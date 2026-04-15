---
title: "Ruby on Rails Performance Optimization Patterns for 2026"
description: "Concrete benchmarks and patterns for Rails performance in 2026 — YJIT speedups, Rails 8 query optimization, Redis caching, and N+1 elimination."
date: 2026-04-09T08:00:00+07:00
draft: false
author: "JetThoughts"
tags: ["ruby", "rails", "performance", "optimization", "yjit", "rails-8", "caching"]
categories: ["Engineering"]
cover_image: "cover.png"
metatags:
  image: cover.png
cover_image_alt: "Dark technical cover with Ruby on Rails branding, performance stats, and glowing gem graphic"
---

A client came to us last quarter running Rails 7.2 on Ruby 3.2. Their P95 response time was 3.1 seconds. The dashboard page — the one every user hits after login — took 4.7 seconds on a cold cache. They'd already tried throwing hardware at it: upgraded from 2 to 4 Heroku Performance-L dynos at $500/month each. Response times didn't budge.

We spent three weeks on their codebase. When we finished, P95 was 380ms. Monthly infrastructure cost dropped from $2,800 to $1,600. And we didn't add a single server.

I want to walk through what we actually changed, in order, because the sequence matters more than any individual technique.

## We profiled before we touched anything

This sounds obvious, but the previous team had already "optimized" by adding Redis caching to random endpoints. Some cached data that changed every 30 seconds. Others cached queries that were already fast. Nobody had profiled.

We installed `rack-mini-profiler` on staging and AppSignal in production. Within two hours, we had the answer: 68% of the dashboard's response time came from a single controller action that fired 247 SQL queries. Not a typo. Two hundred and forty-seven.

Here's what the AppSignal trace looked like (simplified):

```
DashboardController#show — 4,712ms
  ├── User.find — 2ms
  ├── Project.where(user_id:) — 8ms
  ├── Project#recent_activity (×34 projects) — 3,890ms
  │     ├── Activity.where(project_id:) — ×34
  │     ├── Activity#user — ×187
  │     └── Activity#commentable — ×26
  └── View rendering — 812ms
```

The N+1 was nested three levels deep. `includes(:activities)` at the top level wouldn't have caught the `activity.user` and `activity.commentable` calls buried inside a partial. This is why Bullet alone isn't enough — it catches the obvious N+1s, but production traces reveal the ones hidden behind polymorphic associations and partials that render other partials.

We've written about [query strategies using SQL views](/blog/how-avoid-n1-query-using-sql-views-materialized-in-rails-application-ruby/) for cases like this, where the object graph gets too deep for simple eager loading.

## Fixing the query layer — from 247 queries to 4

We rewrote the dashboard query as a single scope with nested `includes`:

```ruby
# Before: N+1 nested three levels deep
@projects = current_user.projects.recent
# Template called project.recent_activity, which called
# activity.user and activity.commentable individually

# After: 4 queries total
@projects = current_user.projects
  .includes(activities: [:user, :commentable])
  .where(activities: { created_at: 30.days.ago.. })
  .references(:activities)
  .order("activities.created_at DESC")
  .limit(50)
```

That `.limit(50)` matters. The original code loaded every activity ever created for every project, then paginated in Ruby. The founder's oldest project had 14,000 activity records.

Dashboard response dropped from 4.7 seconds to 1.2 seconds. A 74% improvement from changing one query. But we weren't done — 1.2 seconds is still too slow for a page users hit dozens of times per day.

## YJIT: the free 30% nobody had turned on

The app was running Ruby 3.2 without YJIT. Upgrading to Ruby 3.3.6 and enabling YJIT was the second change we shipped, and it cost us about 45 minutes including the CI pipeline update.

[Ruby's official benchmark suite](https://speed.ruby-lang.org/) shows YJIT 4.1.0dev at 94.7% faster than the interpreter on synthetic x86-64 benchmarks. That number is misleading for Rails apps — our production numbers landed at a 28-32% improvement in mean response time across all endpoints. Still significant for effectively zero code changes.

The configuration is one line:

```ruby
# config/application.rb
RubyVM::YJIT.enable
```

A caveat worth stating upfront: YJIT increases memory usage by 15-20% because it holds compiled code in memory. For this client, that meant going from 512MB to ~600MB per dyno. On their Performance-L instances with 14GB RAM, that was irrelevant. On a 512MB Basic dyno, it might force an upgrade. Know your memory ceiling before enabling it.

ZJIT exists as an experimental alternative, but we've measured latency variance of up to ±27% under load compared to YJIT's ±3%. For production Rails apps, YJIT is the only serious option right now.

After the Ruby upgrade, the dashboard was at 820ms. Progress, but we had more room.

## Caching the right thing (and only the right thing)

The previous team's caching strategy was scattershot. They'd wrapped random `ActiveRecord` calls in `Rails.cache.fetch` blocks with 1-hour TTLs, which meant stale data for an app where users expect real-time updates.

We took a different approach. Instead of caching at the model layer, we cached the expensive fragment — the rendered activity feed HTML — with a cache key that auto-invalidates:

```ruby
# app/views/dashboards/_activity_feed.html.erb
<% cache [current_user, @projects.cache_key_with_version] do %>
  <% @projects.each do |project| %>
    <%= render project.activities.limit(10), cached: true %>
  <% end %>
<% end %>
```

Russian doll caching. The outer fragment busts when any project changes. Individual activity partials are cached independently. Second page load: 140ms.

We've been moving clients toward [Solid Cache](/blog/rails-8-solid-cache-performance-redis-migration/) for apps that don't need Redis's pub/sub features. For this client, Redis was already in the stack for Sidekiq, so we kept it. But if you're starting fresh on Rails 8, the [Solid Trifecta](/blog/solid-trifecta-hybrid-redis-rails-8/) — Solid Cache, Solid Queue, Solid Cable — eliminates Redis as a dependency entirely, which simplifies deployment and cuts your infrastructure bill.

## Background jobs were blocking the web tier

The client ran Sidekiq on the same dynos as their web processes. Every time a batch email job kicked off, response times spiked because Sidekiq was competing for CPU and memory.

We split them. Dedicated worker dynos for Sidekiq. A separate Redis instance for the queue (don't share your cache Redis with your job queue — we've seen clients lose cache entries during queue storms).

The bigger change: we moved from Sidekiq to [Solid Queue](/blog/solid-queue-vs-sidekiq-complete-comparison/). The client's job patterns were simple — email delivery, webhook processing, report generation — and didn't need Sidekiq Pro's batching or rate limiting features. Solid Queue runs on the database. One fewer infrastructure dependency to manage and monitor.

For jobs that can't afford to be lost, Rails 8.1's [Active Job Continuations](/blog/rails-8-1-active-job-continuations-end-lost-background-jobs/) are worth understanding. They solve the problem where a long-running job crashes halfway through and restarts from zero.

## When NOT to do any of this

I need to be honest about when this work isn't worth doing.

If your app serves 50 requests per minute and your P95 is under 500ms, you don't have a performance problem. You have a feature problem. Ship the next feature. Come back to performance when users complain or when your monitoring shows a regression trend.

Caching is a liability when your data model is still changing weekly. We've watched teams spend days building cache invalidation logic for a feature that got redesigned the following sprint. If the interface isn't stable, don't cache it.

YJIT's memory overhead can be a real cost on small instances. We had a different client on 512MB Heroku Standard-2X dynos where enabling YJIT pushed them into swap, and performance got worse. The fix was upgrading the dyno tier, which added $25/month — still worth it, but not free.

And profiling has diminishing returns. Once your P95 is under 200ms and your slowest queries are under 50ms, you're in a zone where further optimization costs more engineering time than the additional infrastructure you'd avoid. At that point, [deploy on solid infrastructure](/blog/rails-8-docker-deployment-production-guide/) and move on.

## What we shipped, in order

Here's the full timeline for this client:

1. Installed profiling tools (day 1, 2 hours)
2. Fixed the nested N+1 — P95 dropped from 3.1s to 1.4s (day 2)
3. Upgraded Ruby and enabled YJIT — P95 to 980ms (day 3)
4. Added fragment caching on dashboard — P95 to 380ms (day 5)
5. Separated worker dynos, migrated to Solid Queue (days 8-12)
6. Removed unused indexes, added 3 partial indexes (day 14)

Total engineering time: roughly 60 hours across two developers. Monthly hosting cost dropped $1,200. Average response time went from "users complaining" to "nobody mentions it" — which, for a performance project, is the goal.

The order matters. Profiling first, because without data you're guessing. Query fixes next, because they have the highest ratio of impact to effort. YJIT after that, because it's nearly free. Caching last, because it adds complexity and you want to cache the smallest surface area possible.

If you're staring at a slow Rails app and not sure where to start, that sequence — profile, fix queries, enable YJIT, cache selectively — is a reasonable default. We've run this playbook on about a dozen apps over the past year, and the specifics vary but the order almost never does.

---

**Sources:**
- [Ruby Official Benchmarks — YJIT Performance](https://speed.ruby-lang.org/)
- [Scaling Rails Applications — Netguru](https://www.netguru.com/blog/scaling-ruby-on-rails-apps)
- [State of Ruby 2026 — Dev Newsletter](https://devnewsletter.com/p/state-of-ruby-2026/)
- [Ruby 4.0 Set Performance — Medium](https://medium.com/write-a-catalyst/set-is-finally-core-in-ruby-4-0-the-performance-gains-and-migration-tips-nobody-is-talking-about-ba701181ded2)
- [Best Gems for Rails Performance 2025 — DevOps Blog](https://blog.devops.dev/best-gems-for-rails-performance-optimization-2025-edition-7466ed5eb4eb)
- [Rails 8 Performance Improvements — Rails Blog](https://rubyonrails.org/blog)
