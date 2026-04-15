---
title: "Active Job Continuations in Rails 8.1"
description: "Rails 8.1's ActiveJob::Continuable lets long-running jobs resume from their last completed step instead of restarting. Here's how it works, when to use it, and why your Kamal deploys stop losing work."
date: 2026-04-14T08:00:00+07:00
draft: false
author: "JetThoughts"
slug: "rails-8-1-active-job-continuations-background-jobs"
keywords: "Rails 8.1, Active Job Continuations, ActiveJob Continuable, background jobs, Kamal deploy, Solid Queue, Sidekiq, long-running jobs, Ruby on Rails"
tags: ["rails", "ruby", "rails-8-1", "active-job", "background-jobs", "kamal", "solid-queue", "sidekiq"]
categories: ["Engineering"]
cover_image: cover.png
metatags:
  image: cover.png
cover_image_alt: "JetThoughts blog cover for Active Job Continuations in Rails 8.1 — minimalist dark design with Ruby-to-purple gradient headline"
canonical_url: https://jetthoughts.com/blog/rails-8-1-active-job-continuations-background-jobs/
---

Your background jobs lie to you.

You tell yourself they're idempotent. You tell yourself retries are safe. Then a [Kamal](/blog/kamal-integration-in-rails-8-by-default-ruby/) deploy kicks off at 2pm, a 40-minute import job gets 30 seconds to shut down, and the whole thing restarts from row one on the next container. Your users wait. Your database works twice. Your server bill grows.

Rails 8.1 fixes this with a first-class API called `ActiveJob::Continuable`. Include it in a job, define steps, and if the process dies mid-run, the retry picks up where it left off instead of starting over.

Here's what changed, why it matters more than it sounds, and exactly how to wire it into jobs you already have.

## The Problem Rails 8.1 Just Solved

Before Active Job Continuations, a "safe" long-running job looked like this:

1. Track your own progress in a database row.
2. Write custom resumption logic.
3. Hope your resumption logic handles the step where the interrupt happened.
4. Get paged anyway, because you forgot one edge case.

Every mature Rails team has written this code. Every mature Rails team has debugged it at 3am. The Rails core team noticed.

October 2025: Rails 8.1 shipped `ActiveJob::Continuable`. Jobs that include it can define discrete steps. If the job is interrupted mid-run, previously completed steps are skipped on retry. In-progress steps resume from the last recorded cursor.

Custom progress tables and manual resume logic go away. You get checkpoints instead.

## The API in 30 Seconds

```ruby
class ProcessOrderBatchJob < ApplicationJob
  include ActiveJob::Continuable

  def perform(batch_id)
    step :fetch_orders do
      @orders = Order.where(batch_id: batch_id).to_a
    end

    step :process_orders do |step|
      @orders.drop(step.cursor || 0).each_with_index do |order, index|
        order.process!
        step.advance! from: index
      end
    end

    step :notify_finance do
      FinanceMailer.batch_complete(batch_id).deliver_now
    end
  end
end
```

Three steps. If the process dies between "process_orders" and "notify_finance", the retry skips the first two steps entirely and jumps straight to the mailer. If the process dies halfway through "process_orders", the retry resumes at the exact order index where the cursor stopped.

That's the whole API. No surprises.

## Why This Matters More Than It Sounds

Most Rails teams will scroll past this feature. "We already use [Sidekiq](/blog/solid-queue-vs-sidekiq-complete-comparison/) retries. We're fine."

You're not fine. Here's why.

### 1. Kamal's 30-Second Shutdown Is Real

Kamal — the default Rails 8 deployment tool — gives job-running containers 30 seconds to exit gracefully on deploy. Not 30 minutes. Thirty seconds. If your nightly report job is 20 minutes in when the deploy hits, it's dead. The standard Sidekiq retry starts it from the beginning. You've just done the work twice and delayed the deploy while the second run catches up.

Continuations turn that restart into a resume. The deploy still kills the worker. The retry still fires. But the work already done stays done. (For automating those deploys, see our guide on [Kamal 2 with GitHub Actions](/blog/automate-your-deployments-with-kamal-2-github-actions-devops-development/).)

### 2. The Server Cost Is Quiet but Real

Every restarted job does the work twice. If your 18-minute nightly report gets killed at minute 17 by a deploy, the retry runs all 18 minutes again — you paid for 35 minutes of compute to get 18 minutes of output. That cost sits in the bill as "background workers," which most teams never dig into.

The math is blunt: if you deploy daily and you run any job longer than 10 minutes, you're paying for restarts. The cost scales linearly with deploy frequency and job duration. Continuations stop you from paying.

### 3. Your Idempotency Isn't What You Think

Ask your team: "Are all our long-running jobs idempotent?" Watch the confidence drop the longer the list gets. Nightly reconciliations, invoice generation, CSV exports, LLM embeddings — most of these have side effects that *are technically* safe on restart but *practically* double-send emails, double-charge cards, or double-call downstream APIs.

Continuations let you stop pretending. Mark the risky step as a checkpoint. If it finished, it stays finished.

## Adding Continuations to an Existing Job

Here's a job you might already have, before and after.

**Before (Rails 7 / Rails 8.0):**

```ruby
class SyncShopifyOrdersJob < ApplicationJob
  def perform(shop_id)
    shop = Shop.find(shop_id)
    orders = ShopifyAPI::Order.fetch_all(shop)

    orders.each do |order|
      LocalOrder.upsert_from(order)
    end

    shop.update!(last_synced_at: Time.current)
    SyncCompleteMailer.notify(shop).deliver_now
  end
end
```

A deploy halfway through the `orders.each` loop means: API re-fetch, re-upsert every order, resend the email. Total waste: the entire loop plus a duplicate email.

**After (Rails 8.1 with `Continuable`):**

```ruby
class SyncShopifyOrdersJob < ApplicationJob
  include ActiveJob::Continuable

  def perform(shop_id)
    @shop = Shop.find(shop_id)

    step :fetch_orders do
      @orders = ShopifyAPI::Order.fetch_all(@shop)
    end

    step :upsert_orders do |step|
      @orders.drop(step.cursor || 0).each_with_index do |order, index|
        LocalOrder.upsert_from(order)
        step.advance! from: index
      end
    end

    step :mark_synced do
      @shop.update!(last_synced_at: Time.current)
    end

    step :notify do
      SyncCompleteMailer.notify(@shop).deliver_now
    end
  end
end
```

Same logic. Same outputs. One `include` and four `step` blocks. On interruption, the retry resumes at whichever step was running and — inside `upsert_orders` — at whichever order index had just been processed.

**The gotcha**: the `@orders` ivar isn't persisted across interruptions. If the job dies and resumes in a new process, `@orders` is `nil`. That's why `fetch_orders` exists as its own step — but when the *second* step resumes, it re-runs `fetch_orders` first because ivars don't survive. For most jobs this is fine. For expensive fetches, store the IDs you need in a short-lived cache or a dedicated table and pull them back at the top of each resumable step.

## The Kamal 30-Second Trap — Fixed Properly

Here's the specific production pattern that makes this feature pay for itself.

```ruby
class NightlyReportJob < ApplicationJob
  include ActiveJob::Continuable

  def perform(report_date)
    step :aggregate_sales do
      Aggregator.build_sales_snapshot(report_date)
    end

    step :aggregate_refunds do
      Aggregator.build_refund_snapshot(report_date)
    end

    step :render_pdf do
      Report.render(report_date)
    end

    step :email_stakeholders do
      ReportMailer.nightly(report_date).deliver_now
    end
  end
end
```

Four expensive steps. Total runtime: ~18 minutes. Kamal deploy window: 30 seconds.

Before continuations, a deploy during `render_pdf` meant the retry re-runs both aggregation steps — another 12 minutes of wasted Postgres time. After continuations, the retry skips straight to `render_pdf`. The deploy cost drops from 18 minutes of duplicated work to zero.

## When NOT to Use Continuations

Like every powerful feature, this one has wrong uses.

- **Short jobs don't need it.** If your job finishes in under 30 seconds, the Kamal shutdown window is already generous. Adding `step` blocks just adds noise.
- **Strictly ordered side-effect chains are dangerous.** If step 2 sends an email and step 3 charges a card, a retry that "skips" step 2 is wrong if the email didn't actually reach the user. Steps guarantee *completion*, not *delivery*. Use idempotent side effects inside each step.
- **Your adapter has to support it.** [Solid Queue](/blog/rails-8-solid-queue-migration-guide/) and recent Sidekiq releases support continuations. Older adapters or custom queues may not — they'll still run the job, but the resume-from-cursor behavior depends on the adapter calling `queue_adapter.stopping?` at checkpoints. Verify before you rely on it.
- **Cursors aren't magic.** If your step iterates over a mutating collection (a query that returns different rows each run), the cursor won't save you. Freeze the collection in its own fetch step and iterate over a stable list.

## Migration Path for Existing Apps

If you're on Rails 8.0 today, the migration is two steps.

**Step 1: Upgrade to Rails 8.1.3 or later.** The current stable release (as of March 24, 2026) is Rails 8.1.3 and Rails 8.0.5 for maintenance. Continuations require Rails 8.1.

**Step 2: Add `include ActiveJob::Continuable` to jobs that run longer than ~1 minute.** Sort by impact: the longest-running jobs first. Add steps around the natural phase boundaries of the job. Run in staging with a simulated SIGTERM to confirm the resume path works.

Don't refactor every job on day one. Do the nightly batch, the nightly reconciliation, the bulk import, the LLM embedding pipeline. Those four cover 80% of the pain for most teams.

## The Real Win

Continuations aren't really a performance feature. They're a clarity feature.

The real value isn't the compute savings. It's that adding `step` blocks makes you be explicit about where your job can be interrupted, what each phase actually does, and what "done" means at each checkpoint. That clarity pays for itself even if you never get interrupted.

Rails 8.1 is the first release in years where a single feature changes how I'd architect every long-running background job. Continuations is that feature.

Upgrade. Wrap your longest job. Deploy in the middle of it. Watch it resume.

**Related reading on this blog:** our [Rails performance optimization patterns for 2026](/blog/ruby-on-rails-performance-optimization-patterns-for-2026/) covers YJIT, query allocation, and Redis caching — the companion performance moves you want to make while you're upgrading to Rails 8.1. And if you're still on DelayedJob, our [Solid Queue migration guide](/blog/rails-8-solid-queue-migration-guide/) walks through the move.

---

**Further reading:**

- [Rails 8.1 Release Announcement — rubyonrails.org](https://rubyonrails.org/2025/10/22/rails-8-1)
- [ActiveJob::Continuation API Reference — api.rubyonrails.org](https://api.rubyonrails.org/classes/ActiveJob/Continuation.html)
- [Rails 8.1 Release Notes — guides.rubyonrails.org](https://guides.rubyonrails.org/8_1_release_notes.html)
- [Active Job Continuations: The end of lost jobs — MarsBased](https://marsbased.com/blog/2025/10/15/active-job-continuations-the-end-of-lost-jobs)
- [Rails 8.1 Job Continuations Could Save You Dollars in Server Costs — DEV](https://dev.to/raisa_kanagaraj/rails-81s-job-continuations-could-save-you-dollars-in-server-costs-122c)
