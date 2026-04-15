---
title: "Solid Trifecta: When to Keep Redis"
description: "Rails 8 defaults to Solid Cache, Solid Queue, and Solid Cable. Most apps don't need Redis anymore. Some still do. Here's how we decide which workloads stay."
date: 2026-04-13T08:00:00+02:00
draft: false
author: "JetThoughts"
slug: "solid-trifecta-hybrid-redis-rails-8"
keywords: "Rails 8 Solid Trifecta, Solid Cache vs Redis, Solid Queue Sidekiq, Rails 8 production architecture, when to keep Redis Rails"
tags: ["rails", "ruby", "rails-8", "performance", "caching", "solid-queue", "deployment"]
categories: ["Engineering"]
cover_image: cover.png
metatags:
  image: cover.png
cover_image_alt: "JetThoughts blog cover for Solid Trifecta When to Keep Redis — dark design with Ruby-to-purple gradient headline and production architecture stats"
canonical_url: "https://jetthoughts.com/blog/solid-trifecta-hybrid-redis-rails-8/"
---

Redis is the most expensive line item on most Rails infrastructure bills. And since Rails 8, it's optional.

Solid Cache, Solid Queue, and Solid Cable — the "Solid Trifecta" — replace Redis for caching, background jobs, and WebSockets. All three are database-backed and ship as defaults in new Rails 8 apps. 37signals runs Solid Cache in production across Basecamp and HEY, handling what used to require [1.1 terabytes of Redis RAM](https://dev.37signals.com/solid-cache/) with 80 gigabytes of database storage. That's an 80% infrastructure cost reduction.

But *can* drop Redis and *should* drop Redis are different conversations. We've migrated four production apps to the Solid stack in the past six months. Two went fully Redis-free. Two kept Redis for specific workloads. Here's the decision framework we use.

## What the Solid Trifecta Actually Replaces

Each component targets a specific Redis use case:

**Solid Cache** replaces `redis_cache_store`. It stores cache entries in a dedicated database table instead of Redis memory. The tradeoff: reads are [roughly 40% slower](https://dev.37signals.com/solid-cache/) than Redis, but the cache can be 6x larger because disk is cheaper than RAM. For most Rails apps — where cached values are HTML fragments, serialized JSON, or computed reports — single-digit millisecond latency is invisible to users.

**Solid Queue** replaces Sidekiq and Resque for background job processing. It uses `FOR UPDATE SKIP LOCKED` for efficient polling — no Redis pub/sub needed. 37signals [introduced it in production](https://dev.37signals.com/introducing-solid-queue/) at HEY, processing millions of jobs daily. For apps under 100 jobs/second, it performs identically to Sidekiq in wall-clock terms. The difference shows up above that threshold.

**Solid Cable** replaces Redis as the Action Cable adapter. It polls the database for new messages instead of using Redis pub/sub. This works well for live notifications, dashboard updates, and internal tool chat. It does not work well for sub-10ms delivery requirements — multiplayer games, collaborative editing, high-frequency trading dashboards.

## Keep Redis or Drop It: Three Questions Per Component

For each component, there's a short list of deal-breakers. Hit any of them and Redis stays.

### Solid Cache

The main question is throughput. If your app reads cache more than 10,000 times per second, Solid Cache's 1-2ms PostgreSQL overhead adds up — 10-20 extra seconds of cumulative latency across your request pool. Below that? You won't notice.

The second question is sneakier. If you use Redis as a *data structure server* — sorted sets for rate limiting, HyperLogLog for cardinality estimates, Lua scripts for atomic operations — Solid Cache can't replace any of that. It's a key-value store. The cache, yes. The data structures, no.

There's also a write pressure concern that bit us on one migration. Very short-lived cache entries (TTL under 60 seconds) generate constant INSERTs and DELETEs. Redis handles this in memory with zero disk I/O. Your PostgreSQL instance will feel every one of those writes.

For everything else — fragment caching, page caching, API response caching, session storage — Solid Cache works. We've [written a full migration guide](/blog/rails-8-solid-cache-performance-redis-migration/) with benchmarks.

### Solid Queue

Throughput is the obvious question here too. Each enqueue is a database INSERT, each dequeue is a SELECT plus UPDATE. Under 100 jobs/second, you won't notice any difference from [Sidekiq's in-memory operations](/blog/solid-queue-vs-sidekiq-complete-comparison/). Above that, the gap is real and measurable.

Latency is the other concern. Solid Queue polls at a configurable interval — default one second. You can push it lower, but polling will never match Redis pub/sub. If your payment webhooks need to fire within 50ms of enqueue, Sidekiq is still faster.

Then there's the feature question. Solid Queue covers recurring jobs (since 1.0), but Sidekiq Pro's batches, rate limiting, and unique jobs have years of production hardening that Solid Queue hasn't matched yet. If you're paying for Pro and using its features, don't switch just because database-backed sounds purer.

One more thing most people don't think about: spiky traffic. Solid Queue handles steady throughput well. A sudden 50x burst — Black Friday, a concert ticket drop — hits the database hard. Redis absorbs spikes in memory. That's what it was built for.

For apps under 100 jobs/second with tolerance for 1-2 second queue latency? Solid Queue handles it. Our [migration guide](/blog/rails-8-solid-queue-migration-guide/) walks through the move queue by queue.

### Solid Cable

This one is simpler. Solid Cable polls; Redis pushes. If your chat app shows "user is typing" indicators, or you're building collaborative editing, or anything where 200ms of polling latency feels broken — keep Redis. (Or look at [AnyCable](https://anycable.io/) for even better performance.) At 10,000+ concurrent WebSocket connections, each poll is a database query — that's 50,000 SELECTs per second at a 200ms interval. Redis pub/sub handles the same load with a single publish to all subscribers.

For internal dashboards, admin panels, and notification feeds? Solid Cable is fine.

## The Hybrid Architecture That Works

Most production Rails apps we've migrated end up here:

```yaml
# config/environments/production.rb

# Solid Cache for general caching (HTML fragments, API responses)
config.cache_store = :solid_cache_store

# Solid Queue for most background jobs
config.active_job.queue_adapter = :solid_queue

# Redis ONLY for specific workloads:
# - Rate limiting (sorted sets)
# - Sidekiq Pro batches (if you use them)
# - Action Cable (if >1,000 concurrent connections)
```

This cuts the Redis bill by 60-80% while keeping it where it earns its cost. You don't have to choose one or the other. Run Solid Queue for email delivery, report generation, and scheduled tasks. Keep Sidekiq for your payment processing queue where latency matters.

Here's the configuration for running both:

```ruby
# app/jobs/application_job.rb
class ApplicationJob < ActiveJob::Base
  # Default: Solid Queue (database-backed)
end

# app/jobs/payment_webhook_job.rb
class PaymentWebhookJob < ApplicationJob
  self.queue_adapter = :sidekiq  # Override: Redis-backed
  queue_as :critical
end
```

## Migration Order: Start With the Lowest Risk

Don't migrate everything at once. Start with cache — it's the safest.

**Week 1-2: Solid Cache.** If something goes wrong, you get a cache miss — the app is slower, not broken. Run both cache stores in parallel for a week, comparing hit rates and latency. We wrote about [the benchmarks and migration steps](/blog/rails-8-solid-cache-performance-redis-migration/) in detail.

**Week 3-4: Solid Queue (non-critical queues first).** Start with email delivery, analytics events, cleanup jobs. Keep payment processing and time-sensitive webhooks on Sidekiq. Monitor database load — if your connection pool and write throughput can handle it, migrate more queues. Our [Solid Queue vs Sidekiq comparison](/blog/solid-queue-vs-sidekiq-complete-comparison/) covers the architectural differences.

**Week 5+: Evaluate Solid Cable.** Only if you're using Action Cable. Only if your WebSocket load is modest. This is the component with the most noticeable latency difference, so measure before committing.

**Track your database load at every step.** More Solid components = more database queries. If you're running PostgreSQL, watch `pg_stat_activity` for connection counts, `pg_stat_user_tables` for sequential scans on cache/queue tables, and your overall write throughput. A [dedicated database for cache and queue tables](https://guides.rubyonrails.org/active_record_multiple_databases.html) keeps that write pressure off your primary instance.

## When NOT to Migrate

Skip the Solid stack when:

- **You're happy with Redis and it's not a cost problem.** Migration has a cost too. If Redis runs fine, costs $50/month, and your team knows it well — leave it alone. There's no architectural medal for removing a dependency that works.
- **You're pre-launch.** Ship the product first. Optimize infrastructure after you have traffic to measure. The Solid defaults in new Rails 8 apps are fine for launch — revisit when you hit scaling questions.
- **Your database is already under pressure.** Adding cache reads, job polling, and WebSocket queries to an overloaded PostgreSQL instance makes the problem worse. Fix the database first. Consider read replicas or a [dedicated queue database](https://guides.rubyonrails.org/active_record_multiple_databases.html) before migrating.

## The Vibe Coding Problem With "Just Drop Redis"

Here's what we're seeing in 2026 that concerns us.

Teams using AI to scaffold Rails 8 apps see "Solid Queue is the default" and never think about it again. The app works at demo scale. It works at 10 users. Then a real customer base shows up — 500 concurrent users, payment webhooks firing, background imports running — and the database melts because nobody measured the write pressure of running cache, queue, and cable all through the same PostgreSQL instance.

We almost made this mistake on migration #2. Moved cache and queue to Solid on the same weekend, didn't set up a dedicated queue database, and Monday morning the connection pool was exhausted. Rolled back queue, added the separate database, migrated again the following week. No drama — because we'd done cache first and knew the rollback path.

The Solid Trifecta isn't a "just works" black box. It shifts load from Redis to your database. That's a real architectural tradeoff that requires [monitoring and capacity planning](/blog/ruby-on-rails-performance-optimization-patterns-2026/). The same teams that treat [AI-generated code as "it compiles, ship it"](/blog/fire-dev-shop-guide/) treat infrastructure defaults the same way.

The approach is boring on purpose. Boring doesn't page you at 2 AM.

## What We Shipped Last Month

A client came to us running Rails 7.2 with Redis handling cache, Sidekiq, and Action Cable. Monthly Redis bill: $480. Database: PostgreSQL on RDS.

After migration:

- **Solid Cache** replaced Redis for fragment and API response caching. Cache size went from 2GB (limited by Redis memory) to 50GB (limited by disk — effectively unlimited). Average read latency increased from 0.3ms to 1.1ms. Nobody noticed. P95 page load actually improved because cache hit rate went from 68% to 91% with the larger cache.
- **Solid Queue** replaced Sidekiq for email delivery, report generation, and scheduled cleanup. 200 jobs/minute, steady. No issues. [Active Job Continuations](/blog/rails-8-1-active-job-continuations-end-lost-background-jobs/) made the long-running import job deploy-safe for the first time.
- **Sidekiq stayed** for the payment webhook queue (needs sub-second latency) and the real-time inventory sync (2,000 jobs/minute bursts during peak hours).
- **Redis stayed** for Action Cable (1,200 concurrent WebSocket connections for the admin dashboard).

New monthly Redis bill: $120. Same reliability. Less infrastructure to monitor.

That's the hybrid. Not "drop Redis" and not "keep everything." Measure each workload, put it where it belongs, and stop paying for memory you don't need.

---

**Want the same result?** We've done this migration four times in the past six months. We'll review your Redis usage, identify which workloads can move, and build the migration plan. [Book a technical review](https://jetthoughts.com/contact-us/) — 45 minutes, one senior Rails engineer, a written recommendation.

---

If you're planning a Solid stack migration, these are the companion pieces: our [Solid Cache benchmarks and migration steps](/blog/rails-8-solid-cache-performance-redis-migration/) cover the cache move in detail, and the [Solid Queue vs Sidekiq comparison](/blog/solid-queue-vs-sidekiq-complete-comparison/) digs into the architectural differences. For the deployment side, [Kamal in Rails 8](/blog/kamal-integration-in-rails-8-by-default-ruby/) and the [Docker production guide](/blog/rails-8-docker-deployment-production-guide/) round out the stack.

## Further Reading

- [37signals: Solid Cache — a disk-backed Rails cache](https://dev.37signals.com/solid-cache/) — architecture and production results from Basecamp/HEY
- [37signals: Introducing Solid Queue](https://dev.37signals.com/introducing-solid-queue/) — database-backed Active Job backend
- [37signals: Solid Queue 1.0 released](https://dev.37signals.com/solid-queue-v1-0/) — recurring jobs, mission-critical reliability
- [BigBinary: Benchmarking caching in Rails with Redis vs alternatives](https://www.bigbinary.com/blog/caching-in-rails-with-redis-vs-alternatives) — independent performance comparison
- [Simple Thread: I Love You, Redis, But I'm Leaving You for SolidQueue](https://www.simplethread.com/redis-solidqueue/) — real migration story with production numbers
- [Rails Guides: Caching with Rails](https://guides.rubyonrails.org/caching_with_rails.html) — official caching documentation
- [Rails Guides: Multiple Databases](https://guides.rubyonrails.org/active_record_multiple_databases.html) — separate databases for cache and queue tables
