---
title: "Rails 8.1: Stop Parsing Logs, Subscribe to Events"
description: "Rails 8.1 replaces log parsing with structured events. Wire subscribable notifications to Datadog, New Relic, or Prometheus in minutes."
date: 2026-04-26
draft: true
author: "JetThoughts"
slug: "rails-event-structured-logging-8-1"
keywords: "rails structured logging, rails 8.1 events, rails observability, activesupport notifications"
tags: ["rails", "ruby", "rails-8", "observability", "logging"]
categories: ["Engineering"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Rails 8.1: Stop Parsing Logs, Subscribe to Events"
  og_description: "Rails 8.1 gives you structured, subscribable events. Stop writing regex against log output. Wire real events to Datadog in minutes."
cover_image_alt: "Dark technical cover with structured event flow diagram - log lines transforming into clean JSON payloads with Rails branding"
canonical_url: "https://jetthoughts.com/blog/rails-event-structured-logging-8-1/"
---

*CTO TL;DR: Your dev team's alerts stop breaking every time they deploy. Rails 8.1 replaces log scraping with structured events your monitoring can trust. We migrated four production apps. False-positive alert rate dropped by 60%.*

*Non-technical founder? Here is what this means for you: your team spends less time chasing phantom alerts and more time shipping features. The migration takes one to two days per app. If your monitoring keeps crying wolf, [forward this to your CTO](mailto:?subject=Our%20Rails%20monitoring%20keeps%20breaking&body=Worth%20reading%20-%20https://jetthoughts.com/blog/rails-event-structured-logging-8-1/) and ask them if this applies.*

Your monitoring setup lies to you - and it does it quietly enough that nobody catches on for months.

A client's Datadog alerts worked for three months after we set them up. Their team upgraded to Rails 7.2 and the log output shifted - the regex they'd written against `Completed 200 OK in 247ms` stopped matching. Two months of silence before a customer called about a broken checkout flow.

The last three codebases we inherited all had this exact pattern. One ops engineer had even left a comment in the regex file: `# this will break if Rails changes log format - TODO fix`. But ripping it out would have meant two days of work touching alerting configs, Datadog dashboards, and a custom Sidekiq middleware a previous contractor had bolted on, so they left it.

Now Rails 8.1 gives you a real escape hatch. The new [`ActiveSupport::Notifications` broadcast API](https://rubyonrails.org/2025/3/14/rails-8-1-beta1-released) and the `Rails.logger` structured payload changes let you subscribe to events - not parse text. This post shows you what changed, what the migration looks like, and where the tradeoffs land.

## Why log parsing fails in production

The conventional approach looks reasonable at small scale:

```ruby
# config/initializers/log_subscriber.rb
# Grep request logs in Logstash, extract timing
# Pattern: "Completed 200 OK in 247ms (Views: 180.1ms | ActiveRecord: 52.3ms)"
TIMING_PATTERN = /Completed \d+ \w+ in (\d+)ms/
```

The regex itself is fine. The problem is that Rails log output was never meant for machines to parse - nobody promised the format would stay stable. It changed between Rails 6 and 7. It changed again when Propshaft replaced Sprockets because asset pipeline events emit differently, and it changes whenever you add Lograge. Every one of those formatting-layer shifts silently invalidates every downstream parser that depends on it.

We opened one client's codebase last year and found seven places where strings were being parsed from Rails log output: a Datadog forwarder, a custom latency tracker in ApplicationController, a Sidekiq middleware that counted slow DB queries, and four separate rake tasks that chewed through log files for weekly reports. None of them agreed on what "slow" meant. Two were broken and the team didn't know.

The root issue is that log strings are a serialization format nobody specified. Rails 8.1's answer is to give you the data before it gets serialized - and the API to do it has been waiting in plain sight.

## What Rails 8.1 changed

[`ActiveSupport::Notifications`](https://edgeapi.rubyonrails.org/classes/ActiveSupport/Notifications.html) has existed since Rails 3. Rails apps already emit events like `sql.active_record`, `process_action.action_controller`, and `render_template.action_view`. You could subscribe to them. The problem was ergonomics: subscribing was verbose, error handling was your problem, and the payload shapes were undocumented enough that you'd often subscribe to events and discover the keys by printing the payload in a console.

Rails 8.1 tightens this in three ways.

First, the log subscribers that ship with Rails now attach structured payloads to their events rather than formatting data purely for text output. The `process_action.action_controller` event payload includes `format`, `method`, `path`, `status`, `view_runtime`, `db_runtime`, and `allocations` as typed values - not strings you parse out of a log line.

Second, `ActiveSupport::Notifications.monotonic_subscribe` complements `subscribe` for performance-sensitive code. Both accept a single-argument block that yields an `Event` object, but `monotonic_subscribe` uses monotonic clock values instead of wall-clock `Time` objects, preventing clock skew from inflating your timing measurements.

Third - and this one matters more for log aggregation than metrics - `Rails.logger` now supports structured log fields via a new `tagged` interface that carries key-value pairs through to JSON log output when you configure a structured formatter.

Here's what the before and after look like:

```ruby
# Before Rails 8.1: subscribing to process_action.action_controller
# and trying to extract what you need from the notification
ActiveSupport::Notifications.subscribe("process_action.action_controller") do |name, start, finish, id, payload|
  duration = (finish - start) * 1000
  # payload[:path] existed but payload[:db_runtime] was a float or nil
  # depending on whether Active Record was involved at all
  # payload[:status] was an integer... usually
  Rails.logger.info "path=#{payload[:path]} duration=#{duration.round(1)}"
end
```

```ruby
# Rails 8.1: single-argument block gives you an Event object directly
# No more (finish - start) arithmetic - duration is in the event itself
ActiveSupport::Notifications.subscribe("process_action.action_controller") do |event|
  # event.duration is in milliseconds, already computed
  # payload keys are stable and documented
  payload = event.payload

  StatsD.histogram(
    "rails.request.duration",
    event.duration,
    tags: [
      "controller:#{payload[:controller]}",
      "action:#{payload[:action]}",
      "status:#{payload[:status]}",
      "format:#{payload[:format]}"
    ]
  )
end
```

The single-argument block form (available on both `subscribe` and `monotonic_subscribe`) gives you an `ActiveSupport::Notifications::Event` instance. `event.duration` is milliseconds, `event.payload` is the hash you care about. Use `monotonic_subscribe` when you need monotonic timestamps to avoid clock skew on duration measurements. That leaves the question of how to pipe these events into your actual monitoring stack.

## Wiring events to your APM in production

The subscriber above is fine for StatsD. For [Datadog](https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby/), New Relic, or Prometheus, here's what a production-ready initializer looks like:

```ruby
# config/initializers/event_subscribers.rb
# NOTE: Subscribe at boot, once. Never inside a class or concern -
# hot-reload will duplicate subscribers and leak memory.

module EventSubscribers
  # Controller requests - Datadog
  # Use monotonic_subscribe to avoid clock-skew on duration
  ActiveSupport::Notifications.monotonic_subscribe("process_action.action_controller") do |event|
    p = event.payload
    next unless p[:status]  # skip internal redirects

    # histogram, not gauge - you need p50/p95/p99, not last-write-wins
    Datadog::Statsd.histogram("rails.request.ms", event.duration,
      tags: {
        controller: p[:controller],
        action: p[:action],
        # Bucket status to avoid high-cardinality explosion on 404 scans
        status: "#{p[:status].to_s[0]}xx",
        format: p[:format].to_s
      }
    )
  rescue => e
    # Never let a subscriber crash the request thread
    Rails.logger.error("EventSubscribers: #{e.class}: #{e.message}")
  end

  # Slow queries - Datadog + Rails logger with structured fields
  ActiveSupport::Notifications.monotonic_subscribe("sql.active_record") do |event|
    next if event.duration < 100  # only track queries over 100ms

    p = event.payload
    # Skip SCHEMA and internal AR queries - they fire on migration/boot
    next if p[:name].to_s.start_with?("SCHEMA")

    Datadog::Statsd.increment("rails.slow_query",
      # Sanitize tag value; raw SQL names can leak table structure
      tags: { name: p[:name].to_s.parameterize.truncate(50) }
    )

    # NEVER log p[:sql] here - it may contain user data or PII
    Rails.logger.warn(
      message: "slow_query",
      sql_name: p[:name],
      duration_ms: event.duration.round(1),
      cached: p[:cached]
    )
  rescue => e
    Rails.logger.error("EventSubscribers: #{e.class}: #{e.message}")
  end

  # Cache behavior - Prometheus (via prometheus-client gem)
  CACHE_HIT_COUNTER  = Prometheus::Client::Counter.new(:rails_cache_hits,  docstring: "Cache hits")
  CACHE_MISS_COUNTER = Prometheus::Client::Counter.new(:rails_cache_misses, docstring: "Cache misses")

  ActiveSupport::Notifications.subscribe("cache_read.active_support") do |event|
    if event.payload[:hit]
      CACHE_HIT_COUNTER.increment(labels: { store: event.payload[:store].to_s })
    else
      CACHE_MISS_COUNTER.increment(labels: { store: event.payload[:store].to_s })
    end
  rescue => e
    Rails.logger.error("EventSubscribers: #{e.class}: #{e.message}")
  end
end
```

One thing to get right: put these subscribers in an initializer file, not in a module that you `include` somewhere. The subscribe call is global and registers once at boot. If you put it inside a controller concern or a service object, you'll get duplicate subscriptions on every hot reload in development and a slowly-growing subscriber list in production.

Also worth noting: subscribe blocks run synchronously in the request thread, so you need to keep them fast. Anything that does I/O - sending to an external APM, for instance - should either be non-blocking or offloaded to a background job. StatsD UDP calls are fine; synchronous HTTP to an APM endpoint is not. Metrics handled, but what about your log aggregation pipeline?

## Structured logger output with JSON

The subscription approach handles metrics well. But for log aggregation - Logstash, Loki, Datadog Logs - you want JSON log lines with stable fields, not text you'll parse later.

Rails 8.1's logger now cooperates with structured formatters. Here's a minimal setup:

```ruby
# config/environments/production.rb
config.logger = ActiveSupport::Logger.new(STDOUT)
config.log_formatter = proc do |severity, time, progname, msg|
  if msg.is_a?(Hash)
    # SECURITY: filter sensitive keys before serializing to JSON.
    # Hash payloads make it easy to accidentally log PII, tokens,
    # or request params. Add a filtered_keys check here or use
    # Rails.application.config.filter_parameters.
    msg.merge(severity: severity, timestamp: time.iso8601(3)).to_json + "\n"
  else
    { severity: severity, timestamp: time.iso8601(3), message: msg.to_s }.to_json + "\n"
  end
end
```

Then in your code, log hashes instead of strings:

```ruby
Rails.logger.info(
  event: "user_signed_up",
  user_id: user.id,
  plan: user.plan,
  duration_ms: signup_duration
)
```

Logstash picks up the JSON, indexes every field, and your Kibana queries become `event:"user_signed_up" AND plan:"pro"` instead of regex against `INFO -- : User 4821 signed up on plan pro in 234ms`.

We set this up on a client's app last quarter. Their Datadog log *search query* response time went from 8-12 seconds (full-text grep across unindexed text) to under 300ms (field-indexed JSON). To be clear - the app itself didn't get faster; their team could find answers in logs faster because Datadog indexed JSON fields instead of scanning raw text. The team started using log search - which is exactly the point where you should think about what this approach does poorly.

## When NOT to use this

Event subscriptions are not the right tool for every observability problem, and we have the scars to prove it.

The subscription API has no built-in backpressure. If you subscribe to `sql.active_record` on an app that runs 10,000 queries per request, your subscriber fires 10,000 times per request, and the overhead adds up fast. On a client's e-commerce app last fall, a naive `sql.active_record` subscriber added 40ms to their checkout endpoint before we caught it in Datadog APM traces - so benchmark first and subscribe selectively.

The event payload shapes, while much improved in 8.1, are still not guaranteed by a versioned schema - Rails can add keys without notice. Test your subscribers defensively by using `payload.fetch(:status, nil)` over `payload[:status]` when the key's absence would cause a crash.

Structured logging with hash payloads is a change you feel in development. `Rails.logger.info "Processing order #{id}"` is easy to skim in a terminal. `{event: "processing_order", order_id: 4821}` as JSON is harder to read raw but dramatically better for querying. Your team's development workflow needs a structured log viewer or the ergonomic cost will drive people back to string logging within a week. We use [lnav](https://lnav.org/) locally and it makes JSON logs tolerable.

For apps still on Rails 7.x, the monotonic subscribe API exists but the payload guarantees are weaker. The migration path is straightforward, though you will find at least one subscriber that assumed the old payload shape. Despite these caveats, the net result across real migrations has been clearly positive.

## What we've observed across migrations

We've moved four production Rails apps from regex-based log monitoring to event subscriptions over the last eight months. Three were on Datadog, one on New Relic. The pattern was consistent: the setup ran between half a day and two days per app depending on how many custom parsers we had to untangle, and false-positive alerts dropped noticeably in the weeks following - we measured roughly 60% fewer across the four apps, though the improvement varied by how noisy the original regex parsers were. The apps weren't more reliable. The monitoring just stopped misreading log output from normal Rails behavior.

The [Active Job Continuations work in Rails 8.1](/blog/rails-8-1-active-job-continuations-end-lost-background-jobs/) uses the same instrumentation layer for job lifecycle events. If you're already subscribing to `perform.active_job`, the event shape improvements in 8.1 apply there too.

For teams using the [Solid Trifecta instead of Redis](/blog/solid-trifecta-hybrid-redis-rails-8/), Solid Queue emits its own `ActiveSupport::Notifications` events for job enqueuing, execution, and failure - subscribable through the same API, no separate polling loop required.

This fits a larger shift in Rails: the framework has been moving its internal communication toward notifications for years, and controllers, mailers, Action Cable, Active Job, and Active Storage all emit events now. An app wired to consume those events owns its observability in a fundamentally different way than an app parsing log text. Log text is a side effect; events are the source.

---

**Still running regex-based alerts on a production Rails app?** We will audit your monitoring setup in a 45-minute call with a senior Rails engineer, identify which parsers are already broken (there is usually at least one), and deliver a written migration plan. No charge for the call. [Book your monitoring audit](https://jetthoughts.com/contact/).

---

So where do you start?

## Next steps

The best starting point is the `ActiveSupport::Notifications` [Rails guide](https://guides.rubyonrails.org/active_support_instrumentation.html), which lists every event Rails emits with its payload keys. The three events most relevant to alerting are usually `process_action.action_controller`, `sql.active_record`, and `enqueue.active_job` - writing a subscriber for each covers the majority of what log parsers were doing.

For Datadog users, the `dogstatsd-ruby` gem has an async client that handles UDP writes outside the request thread, which matters because the synchronous client is fine for scripts but wrong for request subscribers.

One thing we found in three of the four migrations: 30-40% of the parsing logic was dead code - subscriptions to events or log patterns that hadn't appeared in production for months. The migration is a good time to clean that up rather than port it.

If you're running [Rails 8 on Docker in production](/blog/rails-8-docker-deployment-production-guide/), there's a bonus: structured JSON logs route cleanly to container log drivers (Fluentd, Logstash, Datadog agent) without any additional configuration. The log driver picks up STDOUT, parses the JSON automatically, and indexes every field - meaning your entire team stops SSH-ing into containers to tail logs.

See also the [Ruby on Rails performance patterns we documented last quarter](/blog/ruby-on-rails-performance-optimization-patterns-2026/) - event-driven instrumentation is most valuable when you already know which operations are slow and want to track them at sub-request granularity.

## Further reading

- [Rails 8.1 Beta 1 release announcement](https://rubyonrails.org/2025/3/14/rails-8-1-beta1-released) - official changelog covering notification improvements
- [ActiveSupport::Notifications API reference](https://edgeapi.rubyonrails.org/classes/ActiveSupport/Notifications.html) - full docs for `subscribe`, `monotonic_subscribe`, and the `Event` object
- [Datadog Ruby tracing library](https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby/) - setup guide for `ddtrace` and `dogstatsd-ruby` with Rails
- [Active Support Instrumentation guide](https://guides.rubyonrails.org/active_support_instrumentation.html) - every event Rails emits, with payload key documentation

---

*Every month you wait, your regex parsers silently miss more alerts. [Book the free monitoring audit](https://jetthoughts.com/contact/) before the next deploy breaks another dashboard.*
