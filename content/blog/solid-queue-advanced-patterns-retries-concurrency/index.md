---
title: "Solid Queue Advanced: Retries, Concurrency & Monitoring"
description: "Production patterns for Solid Queue: custom retry strategies, concurrency tuning, worker pool sizing, dead letter queues, and monitoring. Working Rails 8 config examples."
date: 2026-07-24
draft: false
tags: ["rails", "solid-queue", "background-jobs", "performance", "production", "monitoring"]
canonical_url: "https://jetthoughts.com/blog/solid-queue-advanced-patterns-retries-concurrency/"
slug: "solid-queue-advanced-patterns-retries-concurrency"
cover_image: "cover.png"
metatags:
  image: cover.png
cover_image_alt: "Dark technical cover for Solid Queue Advanced Patterns. JetThoughts ENGINEERING brand mark, Ruby on Rails 2026 pill, low-poly ruby gem, stat chips for retries/concurrency/alerts, PRODUCTION PATTERNS status indicator."
---

The Solid Queue migration guide shows you how to switch from DelayedJob or Sidekiq. It stops where the real work starts.

Once the jobs are running, the questions change. How do you retry a failed job that depends on an external API that's down for 20 minutes, not 20 seconds? How many workers should you actually run? What do you monitor, and what do you alert on?

These are the patterns we run on production Rails apps since migrating to Solid Queue in Rails 8.

## Retry strategies beyond the defaults

Solid Queue's default retry behavior is linear: a fixed delay, a max attempt count, done. That's fine for transient failures — a database connection blip, a Redis timeout. It breaks when the failure is upstream.

### Exponential backoff with a ceiling

An external API returns 429s. The default retry fires again in 5 seconds. Still rate-limited. Another 5 seconds. Still rate-limited. Your job burns through its retries in under a minute and lands in the dead set. The API recovers 3 minutes later. Your job is already dead.

```ruby
# app/jobs/api_sync_job.rb
class ApiSyncJob < ApplicationJob
  queue_as :api

  retry_on Faraday::TooManyRequestsError,
           wait: ->(executions) { [ (2**executions * 5).seconds, 5.minutes ].min },
           attempts: 8

  retry_on Faraday::TimeoutError,
           wait: :exponentially_longer,
           attempts: 5

  discard_on ApiSyncJob::UnrecoverableError

  def perform(resource_id)
    resource = Resource.find(resource_id)
    ExternalApi.sync(resource)
  end
end
```

The `[2**n * 5, 5.minutes].min` pattern gives you 5s, 10s, 20s, 40s, 80s, 160s, 320s, then caps at 300s. With 8 attempts, the job survives a 30-minute upstream outage and succeeds the moment the API comes back. Eight attempts is higher than you think you need until your first partner API outage.

### The dead letter pattern

Solid Queue has a built-in dead set at every failed job's final attempt, but there's no built-in way to inspect them. A job that dies silently is worse than a job that errors loudly.

```ruby
# config/initializers/solid_queue.rb
Rails.application.config.after_initialize do    # Available in Solid Queue 1.0+. For earlier versions,
    # poll SolidQueue::Job.where.not(failed_at: nil) directly.
    SolidQueue.on_dead_job do |job|
    Rails.logger.error "DEAD JOB: #{job.class_name}##{job.job_id} — #{job.last_error&.truncate(200)}"

    # Alert on unexpected dead jobs
    if job.failed_at > 10.minutes.ago
      ActiveSupport::Notifications.instrument(
        "dead_job.solid_queue",
        job_class: job.class_name,
        job_id: job.job_id,
        error: job.last_error
      )
    end
  end
end
```

We pipe that `dead_job.solid_queue` event into our error tracker. A dead job fires a PagerDuty alert if the class is on the critical list (`PaymentProcessingJob`, `WelcomeEmailJob`). Batched maintenance jobs (`CleanupOldSessionsJob`) log and don't page — someone checks the dashboard Monday morning.

### Job-specific concurrency keys

Solid Queue inherits Active Job's concurrency controls. The most useful pattern we've found: per-resource uniqueness so you don't process the same record twice.

```ruby
# app/jobs/process_order_job.rb
class ProcessOrderJob < ApplicationJob
  queue_as :orders

  # Don't enqueue a second job for the same order while one is running
  uniquely { |order_id:, **_| "order:#{order_id}" } # **_ ignores extra keyword args from Active Job

  retry_on ProcessOrderJob::InventoryNotAvailable, attempts: 3

  def perform(order_id:, event: "created")
    order = Order.find(order_id)
    OrderProcessor.new(order).process!(event: event)
  end
end
```

Without the uniqueness lock, a webhook that fires twice for the same event (Stripe does this) processes the order twice. The `uniquely` block prevents that — second enqueue silently drops while the first is running.

## Concurrency tuning: stop guessing

Solid Queue's `config/solid_queue.yml` lets you set `--max-threads` and `--processes`. The defaults are conservative. Here's how to find the right numbers for your workload.

### Measure your job's I/O ratio

Your concurrency ceiling is determined by how much time your jobs spend waiting. CPU-bound jobs cap at 2-3× CPU cores. I/O-bound jobs can go much higher.

```ruby
# lib/tasks/solid_queue_profile.rake
namespace :solid_queue do
  desc "Profile a job class to determine optimal concurrency"
  task :profile, [:job_class] => :environment do |_, args|
    job_class = args[:job_class].constantize
    times = []

    20.times do |i|
      start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      job_class.perform_now
      elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
      times << elapsed
      puts "Run #{i + 1}: #{elapsed.round(3)}s"
    end

    avg = times.sum / times.size
    p95 = times.sort[(times.size * 0.95).ceil - 1]
    puts "---"
    puts "Average: #{avg.round(3)}s"
    puts "P95: #{p95.round(3)}s"

    # Rule of thumb: threads per worker = (avg I/O wait / avg CPU time) + 1
    # If your jobs average 200ms of database wait and 10ms of Ruby CPU time,
    # that ratio is 20:1 — you can run ~20 threads per worker without contention.
  end
end
```

Run it: `rails solid_queue:profile[ProcessOrderJob]`. If your average job spends 80% of its time in database queries, API calls, or Redis operations, you can run 5-8 threads per worker without contention. If it's mostly Active Record serialization and ERB rendering, cap at 2-3.

### The dispatch config we settled on

```yaml
# config/solid_queue.yml
production:
  dispatchers:
    - polling_interval: 1
      batch_size: 500
      concurrency_maintenance_interval: 600

  workers:
    # High-priority queue: fast jobs, high throughput
    - queues: [ default, mailers ]
      threads: 8
      processes: 2
      polling_interval: 0.5

    # Long-running queue: API calls, file processing
    - queues: [ api, exports ]
      threads: 12
      processes: 3
      polling_interval: 1.0

    # Background maintenance: low urgency, batched
    - queues: [ cleanup, analytics ]
      threads: 4
      processes: 1
      polling_interval: 5.0

    # Critical: payment processing, low concurrency for consistency
    - queues: [ payments ]
      threads: 2
      processes: 1
      polling_interval: 0.5
```

**Why separate payment processing into its own worker with 2 threads?** Not because it's high-volume — because it's high-stakes. If a payment job crashes, we want the smallest possible blast radius. Two threads means at most two payments affected by a worker crash. The `uniquely` lock on `ProcessOrderJob` handles the rest.

**Why `polling_interval: 0.5` on high-priority queues?** Solid Queue uses database polling, not Redis pub/sub. The default 1-second poll means a queued job waits up to 1 second before any worker picks it up. For `default` and `payments` queues, 0.5s halves that latency. The database load increase is negligible — the `SELECT ... FOR UPDATE SKIP LOCKED` query is cheap.

### What happens when you over-subscribe

We ran 16 threads per worker on a CPU-mixed workload. The database connection pool exhausted. Every thread tried to check out a connection, every connection was busy, and jobs started failing with `ActiveRecord::ConnectionTimeoutError` — not in the job body, but in Solid Queue's own dispatch logic.

The symptom was cryptic: jobs appeared to succeed (no error in the job itself) but the dispatch logged `Error performing job: could not obtain a connection from the pool`. Solid Queue needs its own connection pool headroom. The formula:

```ruby
# config/database.yml
production:
  # Solid Queue's internal pool + your job's pool
  # Each worker process needs: (threads + 2) connections
  # 2 extra: 1 for the dispatcher, 1 for maintenance
  pool: <%= (ENV.fetch('SOLID_QUEUE_MAX_THREADS', 5).to_i + 2) *
            ENV.fetch('SOLID_QUEUE_PROCESSES', 2).to_i +
            ENV.fetch('RAILS_MAX_THREADS', 5).to_i %>
```

If you run 3 worker processes with 8 threads each, that's (8+2) × 3 = 30 connections for Solid Queue, plus your web server's pool. If your database allows 60 total connections, the web server gets 30. If you run Sidekiq on the same box, subtract its pool too.

## Monitoring: beyond the built-in dashboard

Solid Queue ships with a dashboard at `/solid_queue` in development. It shows queue depths, job counts, and recent failures. It's useful. It's also not enough for production.

### Metrics we actually alert on

Three numbers matter. Everything else is noise.

```ruby
# config/initializers/solid_queue_metrics.rb
Rails.application.config.after_initialize do
  return unless Rails.env.production?

  # 1. Queue depth: if any queue is growing faster than it's draining,
  #    you're falling behind. Alert at 500+ backlog.
  ActiveSupport::Notifications.subscribe("enqueue.active_job") do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    queue_name = event.payload[:job]&.queue_name || "default"

    depth = SolidQueue::Job.where(queue_name: queue_name)
                           .where(finished_at: nil)
                           .count

    if depth > 500
      Rails.logger.warn "QUEUE DEPTH: #{queue_name} has #{depth} pending jobs"
    end
  end

  # 2. Job latency: how long between enqueue and start.
  #    >60s means your workers are saturated.
  SolidQueue::Job.where(started_at: nil)
                .where("created_at < ?", 1.minute.ago)
                .in_batches do |batch|
    batch.each do |job|
      latency = Time.current - job.created_at
      Rails.logger.warn "JOB LATENCY: #{job.class_name} waiting #{latency.round}s" if latency > 60
    end
  end
end
```

Queue depth is the canary. If the `api` queue hits 500 pending and isn't draining, your upstream is down or your workers are saturated. Either way, adding more workers is the wrong first move — check the upstream first, then check your thread count.

### The dashboard you actually need

Solid Queue's data lives in the `solid_queue_jobs` table. A 5-minute rake task gives you more signal than the built-in dashboard:

```ruby
# lib/tasks/solid_queue_stats.rake
namespace :solid_queue do
  desc "Print queue health summary"
  task stats: :environment do
    puts "=" * 60
    puts "Solid Queue Health — #{Time.current.strftime('%Y-%m-%d %H:%M UTC')}"
    puts "=" * 60

    # Per-queue breakdown
    SolidQueue::Job.group(:queue_name)
                   .where(finished_at: nil)
                   .count
                   .sort_by { |_, count| -count }
                   .each do |queue, count|
      status = count > 100 ? "⚠️" : "✅"
      puts "#{status} #{queue}: #{count} pending"
    end

    # Failure rate (last hour)
    total = SolidQueue::Job.where("created_at > ?", 1.hour.ago).count
    failed = SolidQueue::Job.where("created_at > ?", 1.hour.ago)
                            .where.not(finished_at: nil)
                            .where("finished_at IS NULL OR last_error IS NOT NULL")
                            .count

    if total > 0
      failure_rate = (failed.to_f / total * 100).round(2)
      status = failure_rate > 5 ? "🚨" : failure_rate > 1 ? "⚠️" : "✅"
      puts "#{status} Failure rate (1h): #{failure_rate}% (#{failed}/#{total})"
    end

    # Oldest pending job
    oldest = SolidQueue::Job.where(finished_at: nil)
                            .order(:created_at)
                            .first
    if oldest
      age = (Time.current - oldest.created_at).round
      status = age > 300 ? "🚨" : "✅"
      puts "#{status} Oldest pending: #{oldest.class_name} (#{age}s)"
    end

    # Dead jobs today (failed_at is populated when retries exhausted)
    dead_today = SolidQueue::Job.where.not(failed_at: nil)
                                .where("failed_at > ?", Date.today.beginning_of_day)
                                .count
    puts "#{dead_today > 0 ? '⚠️' : '✅'} Dead jobs today: #{dead_today}"
  end
end
```

Wire this to a cron job every 5 minutes and log the output. If the summary ever prints 🚨, someone should look.

### The Sidekiq migration gotcha

Solid Queue stores jobs in PostgreSQL. If you're coming from Sidekiq, your Redis memory was your job buffer. Under Solid Queue, that buffer is now rows in `solid_queue_jobs`. A queue with 500,000 pending jobs is a 500,000-row table. PostgreSQL handles it fine — until it doesn't.

The vacuum: `solid_queue_jobs` accumulates finished jobs unless you configure retention. By default, Solid Queue keeps finished jobs for `preserve_finished_jobs: true` (indefinitely). In development, fine. In production, that table grows unbounded.

```ruby
# config/initializers/solid_queue.rb
Rails.application.config.solid_queue.preserve_finished_jobs = false
Rails.application.config.solid_queue.clear_finished_jobs_after = 7.days
```

Set `clear_finished_jobs_after` to something your debugging workflow tolerates. Seven days is enough to investigate a weekend failure on Monday. At 100,000 jobs/day, that's 700,000 rows — a few hundred MB. Fine.

If you need to debug a job that ran 3 weeks ago, pull the logs, not the database row.

We learned this the hard way. A client migrated from Sidekiq to Solid Queue in April 2026 — 80K jobs/day, standard RDS instance. The `preserve_finished_jobs` default ate 8GB of disk in the first week before their monitoring caught it. After setting `clear_finished_jobs_after: 7.days`, the table stabilized at 700K rows and 500MB. The fix was two config lines. The diagnosis took a morning of digging through a bloated jobs table.

## When Solid Queue isn't enough

Solid Queue replaces Sidekiq for 80% of Rails apps. The 20% where it doesn't:

**You process more than 500,000 jobs/hour.** PostgreSQL's `SELECT ... FOR UPDATE SKIP LOCKED` works at scale, but at some point Redis's pub/sub delivers lower latency and higher throughput. The exact crossover depends on your database hardware, but we've seen performance degradation start around 500K jobs/hour on standard RDS instances.

**You need scheduled jobs with sub-second precision.** Solid Queue polls the database. The minimum polling interval is 0.1 seconds. If you need a job to run exactly 50ms after another job completes, use Sidekiq with Redis.

**You run PostgreSQL on a single small instance.** Solid Queue adds constant read/write load to your primary database. If your RDS is already at 80% CPU serving web traffic, adding a job queue on top will push it over. Either size up or run Sidekiq on Redis.

For the rest of us — the apps processing 10K-200K jobs/hour, running on reasonable hardware — Solid Queue eliminates a Redis dependency, simplifies the stack, and gives you job visibility in the same database you already query. The trade-off is real but the simplification wins for most workloads.

*For the migration guide and benchmarks, see [Rails 8 Solid Queue: Migration Guide for Production Apps](/blog/rails-8-solid-queue-migration-guide/). For deployment patterns that pair well with Solid Queue, see [Falcon in Production: Benchmarks, Memory & Worker Count](/blog/falcon-web-server-production-tuning-benchmarks/). For replacing Devise in the same stack, see [Rails 8 Authentication Generator: Complete Guide](/blog/rails-8-authentication-generator-complete-guide/). If you're running Solid Queue at scale, [our Rails team can help](/services/app-web-development/).*
