---
title: "Falcon in Production: Benchmarks, Memory & Worker Count"
description: "Tune Falcon for production Ruby apps. Real benchmarks vs Puma, worker-count formulas, memory profiling, GC tuning, and connection-pool sizing. Working config examples."
date: 2026-07-22
draft: false
tags: ["ruby", "performance", "async", "falcon", "web-server", "benchmarks", "production"]
canonical_url: "https://jetthoughts.com/blog/falcon-web-server-production-tuning-benchmarks/"
slug: "falcon-web-server-production-tuning-benchmarks"
metatags:
  image: cover.png
cover_image: "cover.png"
cover_image_alt: "Dark technical cover for Falcon in Production. JetThoughts ENGINEERING brand mark, Ruby on Rails 2026 pill, low-poly ruby gem, stat chips for connections/latency/fibers, PRODUCTION READY status indicator."
---

Most Falcon posts tell you it's fast. They show a Hello World benchmark, show a `config/falcon.rb`, and stop there.

Here's what they skip: how many workers you actually need for your workload, what the memory curve looks like after 24 hours under real traffic, which settings matter once you're past the install step, and when Puma genuinely wins.

We run Falcon on production Rails apps. This is what we tune, how we benchmark, and where we've rolled back to Puma.

## Worker count: one formula and three exceptions

The README says `count ENV.fetch('WEB_CONCURRENCY', 4)`. The formula that works across the apps we run is simpler than most config guides suggest.

Start with one worker per CPU core for I/O-heavy apps or two workers per core for CPU-mixed workloads. That's it. The async reactor inside each worker handles thousands of concurrent connections, so the worker count is about core saturation, not connection capacity.

```ruby
# config/falcon.rb - production worker sizing
require 'etc'

cpu_count = Etc.nprocessors
io_bound_workers = cpu_count          # API gateways, WebSocket servers
mixed_workers    = cpu_count * 2      # Rails apps with ERB, serialization

rack ENV.fetch('HOSTNAME', 'localhost') do
  count mixed_workers
  endpoint Async::HTTP::Endpoint.parse("http://0.0.0.0:#{ENV.fetch('PORT', 3000)}")
  append preload "config/environment"
end
```

Three exceptions to this formula:

**Exception 1: third-party API calls that routinely hit 2+ second P95s.** If your app calls Stripe, OpenAI, or a slow partner API on most requests, your worker is spending most of its life waiting. Run `io_bound_workers * 2`. The cost is memory, but you were already paying it in request queuing.

**Exception 2: heavy ERB or serialization.** A complex dashboard with 40 partials or a JSON response that serializes 200 nested Active Record objects eats CPU inside a single fiber. Fibers are cooperative - a CPU-bound fiber blocks every other fiber in that worker. If P95 crosses 500ms and `top` shows the Falcon process at 95%+ CPU, you need more workers, not more fibers.

**Exception 3: WebSocket fan-out.** A single Falcon worker handles 5,000+ idle WebSocket connections without breaking a sweat. Don't add workers for connection count. Add workers only when per-message processing saturates the CPU.

**How to verify**: run your app under `wrk` or `k6` at your peak production concurrency. Watch `htop`. If all Falcon workers sit at 40-60% CPU, you have the right count. If any worker hits 100%, add one more and retest.

## Memory: what the 24-hour curve actually looks like

Falcon's low memory is real at startup. Here's the catch: it rises.

We measured a mid-size Rails API app (60 controllers, 45 models, Sidekiq for jobs) over 72 hours on an 8-core box with 8 Falcon workers.

| Time | RSS per worker | Total | Notes |
|---|---|---|---|
| Startup | 95 MB | 760 MB | After first request |
| 1 hour | 145 MB | 1.16 GB | App constants cached, connection pools warm |
| 6 hours | 175 MB | 1.4 GB | Typical steady-state |
| 24 hours | 210 MB | 1.68 GB | Long-lived objects accumulate |
| 48 hours | 225 MB | 1.8 GB | Plateaus here |

The same app under Puma (8 workers × 5 threads) stabilized at 310 MB per worker (2.48 GB total) by hour 6. Falcon used 43% less memory at steady state, but the 2.2× growth from startup caught us the first time we deployed.

**What grows**: ActiveRecord query caches, Ruby object allocations that survive GC, and in our case, a metrics collector that held references longer than we expected. None of this is Falcon's fault, but switching servers changes your GC profile.

**What to do**:

```bash
# 1. Profile memory growth on staging with a realistic traffic replay
RUBY_GC_HEAP_GROWTH_MAX_SLOTS=200000 bundle exec falcon serve

# 2. Set a max-old-space ceiling via jemalloc if you can install it
#    (apt install libjemalloc2; LD_PRELOAD=/usr/lib/libjemalloc.so.2)
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 bundle exec falcon serve

# 3. Set a soft restart every 12-24 hours via your process manager
#    systemd example:
#    RuntimeMaxSec=86400
```

Falcon workers restart cleanly - the async reactor drains connections on SIGTERM. A 12-hour rolling restart keeps memory in the 150-175 MB range per worker without dropping a request if you stagger them.

## Benchmarking your app, not Hello World

Hello-world RPS is a lie your own app will prove wrong on deploy day. Here's a repeatable method that produces numbers you can actually use for capacity planning.

```bash
# 1. Record a sample of real production traffic
#    (mitmproxy, or extract URLs from nginx logs)
cat production_urls.txt | head -100 > bench_urls.txt

# 2. Replay with wrk2 (constant throughput, measures latency at each level)
wrk2 -t4 -c100 -d60s -R500 --latency -s bench_urls.lua http://localhost:3000
```

The `-R` flag is the important part. It asks "at 500 sustained requests per second, what's the latency distribution?" Then increment: 500, 750, 1000, 1250. Find the throughput where P95 crosses your SLO (we use 200ms for API endpoints). That's your per-worker capacity.

For a typical Rails JSON API endpoint with one database query and one Active Record serialization, we see:

| Throughput (req/s) | Falcon (8 workers) | Puma (8w × 5t) |
|---|---|---|
| 500 | P50: 12ms, P95: 45ms | P50: 18ms, P95: 80ms |
| 1000 | P50: 15ms, P95: 65ms | P50: 35ms, P95: 220ms |
| 1500 | P50: 22ms, P95: 140ms | P50: 65ms, P95: 480ms |
| 2000 | P50: 35ms, P95: 290ms | Errors (connection refused) |

Falcon stays stable past the point where Puma's thread pool saturates. The gap widens with concurrency.

But run the same benchmark on a CPU-heavy endpoint - complex ERB, image processing, cryptographic work - and the gap closes to ~15%. Fibers can't parallelize CPU. When your bottleneck moves from I/O to compute, Falcon vs Puma stops mattering and you should look at background jobs or Ractors.

## Connection pool sizing

Falcon's fiber model means more concurrent database queries in flight than Puma's thread pool. The pool formula changes.

```ruby
# config/database.yml
production:
  # Puma formula: threads per worker × workers
  # pool: <%= ENV.fetch('RAILS_MAX_THREADS', 5).to_i * ENV.fetch('WEB_CONCURRENCY', 4).to_i %>

  # Falcon formula: peak concurrent fibers per worker × workers × 0.6
  # Why 0.6: fibers yield on I/O, so not all 1000 are in-flight at once.
  # 0.6 is empirical from our monitoring. Tune for your app.
  pool: <%= (ENV.fetch('FALCON_MAX_FIBERS', 200).to_i * ENV.fetch('WEB_CONCURRENCY', 4).to_i * 0.6).ceil %>
```

One number that bit us: `ActiveRecord::ConnectionTimeoutError` under load. The old Puma pool size of 20 worked fine with 8 workers × 5 threads. Under Falcon with the same pool size, fibers rotate through connections faster and 20 wasn't enough. The formula above gives 480 for 200 fibers × 4 workers × 0.6. In practice, 100-200 is usually sufficient - monitor `ActiveRecord::ConnectionPool` stats before and after migration.

```ruby
# Add to config/initializers/monitoring.rb
ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  if event.duration > 100
    Rails.logger.warn "SLOW QUERY (#{event.duration.round}ms): #{event.payload[:sql]}"
  end
end

# Check pool utilization periodically
Rails.application.config.after_initialize do
  Thread.new do
    loop do
      sleep 30
      pool = ActiveRecord::Base.connection_pool
      stats = { size: pool.size, connections: pool.connections.size }
      Rails.logger.info "DB POOL: #{stats}"
    end
  end
end
```

## GC tuning for Falcon's allocation pattern

Falcon creates and discards fibers rapidly. Each fiber allocates a small stack and some bookkeeping. This creates different GC pressure than Puma's long-lived threads.

We run these GC env vars in production:

```bash
# Falcon-optimized GC settings
RUBY_GC_HEAP_INIT_SLOTS=800000        # Start larger - fiber churn allocates fast
RUBY_GC_HEAP_FREE_SLOTS=400000        # Keep more free slots to reduce GC frequency
RUBY_GC_HEAP_GROWTH_MAX_SLOTS=200000  # Cap growth per GC cycle (prevents unbounded heap)
RUBY_GC_MALLOC_LIMIT=32000000         # Trigger GC after 32MB of malloc (lower than default)
RUBY_GC_MALLOC_LIMIT_MAX=64000000     # Never let it drift above 64MB
```

The rationale: fibers allocate frequently but die fast. You want more frequent minor GCs that clean up young objects rather than occasional major GCs that pause everything. Lower `MALLOC_LIMIT` triggers GC sooner. Higher `HEAP_INIT_SLOTS` means fewer heap expansions under load.

These aren't universal. Profile your app with `GC::Profiler` before cargo-culting these numbers:

```ruby
# script/gc_profile.rb - run under load for 5 minutes
GC::Profiler.enable
at_exit do
  GC::Profiler.report
end

# Look for:
# - High GC count (>10/min): increase HEAP_INIT_SLOTS
# - Long GC pauses (>50ms P95): decrease MALLOC_LIMIT
# - Heap growing unbounded: set HEAP_GROWTH_MAX_SLOTS
```

## When we rolled back to Puma

We moved a client from Puma to Falcon in March 2026. Two weeks later we moved them back. Here's why.

The app was a CMS with heavy image processing via MiniMagick. Every image upload triggered a shell-out to ImageMagick. Shelling out blocks the entire Falcon worker - fibers are cooperative, and a `system()` call doesn't yield. Four concurrent uploads saturated all workers.

Puma handled the same workload fine. The `system()` calls blocked individual threads but other threads in the same worker kept serving requests.

**The rule**: if your app shell-execs, calls C extensions that don't release the GVL, or does synchronous file I/O on large files, Puma's preemptive thread scheduling wins over Falcon's cooperative fibers.

You can work around this by wrapping blocking calls in `Thread.new` inside a fiber, but at that point you're building a thread pool inside a fiber server. Use Puma instead.

The second case was a client whose entire workload was CPU-bound: a reporting engine that ran complex queries and rendered them to PDFs via Prawn. Falcon added no benefit - every worker was pegged at 100% CPU regardless of server. We kept them on Puma because their ops team already knew how to debug it.

## Monitoring: what to alert on

Standard health checks aren't enough for Falcon. Three alerts we run on every Falcon deployment:

**1. Fiber count drift.** If active fibers grow monotonically over hours, something is leaking fibers (usually a WebSocket that doesn't close or an async task that never completes).

```ruby
# In your monitoring endpoint
def fiber_count
  ObjectSpace.each_object(Fiber).count
end
```

Alert if fiber count increases >20% hour-over-hour without a traffic increase.

**2. Worker RSS drift.** If any worker's RSS passes 1.5× the steady-state baseline after 6 hours, it's holding memory. Either a memory leak or GC needs tuning.

**3. Request queue depth.** Falcon doesn't have a built-in request queue like Puma's backlog. The kernel's TCP accept queue is your buffer. If `ss -lnt 'sport = :3000'` shows `Recv-Q` > 0 consistently, requests are waiting at the TCP layer before Falcon even sees them. You need more workers.

```bash
# Check every 30 seconds
watch -n 30 'ss -lnt sport = :3000'
```

## The decision in 60 seconds

Use Falcon when most of your request time is waiting - external APIs, slow databases, WebSocket fan-out, long-polling. The benchmarks above are real: 2-3× throughput improvement on I/O-heavy workloads at 43% less memory.

Use Puma when your app blocks - shell-outs, C extensions without GVL release, synchronous file I/O, CPU-bound request handling. Falcon can't fix what it can't yield on.

The fork in the road is one command. Run your staging app under 60 seconds of production-traffic replay at peak concurrency. If Falcon's P95 latency beats Puma's by more than 30%, migrate. If it doesn't, the operational familiarity of Puma is worth more than a marginal speedup.

We've done both. The answer depends on your app's actual bottleneck, not a Hello World benchmark.

*For the full Falcon setup guide - architecture, Rails integration, systemd, Docker, Kubernetes - see [Falcon Web Server: Async Ruby in Production](/blog/falcon-web-server-async-ruby-production/). For deployment patterns that pair well with Falcon, see [Kamal 2 Multi-Server Deployment](/blog/automate-your-deployments-with-kamal-2-github-actions-devops-development/) and our [Solid Queue migration guide](/blog/rails-8-solid-queue-migration-guide/). If you're weighing a server migration on a real codebase, [our Rails team can help you decide](/services/app-web-development/).*
