---
title: "Migrate a Lovable App to Rails"
description: "Your Lovable, Bolt, or Replit MVP works in the demo and breaks with real users. How to migrate a vibe coded app to Rails: schema, auth, payments, front end."
date: 2026-08-08
draft: true
author: "JetThoughts"
tags: ["rails", "vibe-coding", "migration", "supabase", "startups", "mvp"]
keywords: ["migrate lovable app to rails", "vibe coded app to production", "lovable to rails migration", "replit to rails", "supabase to rails migration", "rebuild vibe coded mvp"]
categories: ["Development", "Rails", "AI"]
canonical_url: "https://jetthoughts.com/blog/migrate-lovable-replit-app-to-rails/"
slug: "migrate-lovable-replit-app-to-rails"
cover_image: "cover.png"
metatags:
  image: cover.png
cover_image_alt: "Dark technical cover for migrating a Lovable or Replit app to Rails. JetThoughts ENGINEERING brand mark, Ruby on Rails 2026 pill, low-poly ruby gem, stat chips for schema, auth, and payments, MIGRATE status indicator."
---

Open the network tab on a Lovable-built app and you'll usually find the Supabase URL and a key labeled `anon` sitting in the client bundle. That key is meant to be public. What makes it dangerous is what's behind it: if row-level security was never turned on, that key reads the whole table.

```bash
curl 'https://<project>.supabase.co/rest/v1/profiles?select=*' \
  -H "apikey: <anon-key-from-the-bundle>"
```

A researcher ran a version of that check across Lovable's own showcase in May 2025 and found [303 endpoints on 170 projects returning data to anyone with the public key](https://www.superblocks.com/blog/lovable-vulnerabilities) - emails, addresses, in some cases API keys. That's CVE-2025-48757. If you're reading this, you probably already know your app has a problem like it, and you're deciding whether to migrate a vibe coded app to production-grade Rails or keep patching. This post is the migration: schema and data first, then auth, then payments, then the front end.

## First figure out what to keep

The honest answer to "how much of this transfers" depends on which layer you're looking at, and the layers age very differently.

Your database schema and the data in it are the durable part. Tables, columns, foreign keys, the actual rows your users created - that ports cleanly, because it's just Postgres underneath. The generated React front end is worth keeping more often than Rails developers like to admit; it renders, it's typed, and rebuilding pixel-perfect UI by hand is a poor use of a rescue budget.

Auth and payments are the two layers that almost never survive. Not because the tools can't wire them up, but because "looks wired up" and "actually enforces the rule" are different states that look identical in a demo.

Here's the split we see on nearly every rescue:

| Layer | Usually transfers? | Why |
|---|---|---|
| Database schema | Yes | It's Postgres. `pg_dump` and you're done. |
| Data (rows) | Yes | Same export. Watch the auth foreign keys. |
| Business logic | Sometimes | Read it before you trust it. Often thinner than it looks. |
| Front end (React) | Often | It renders. Point it at a new API. |
| Auth | Rarely | Stubbed, hardcoded, or missing session handling. |
| Payments | Rarely | Stripe checkout exists; webhooks don't. |

One decision drives everything else. If the schema is sane and the data is real, you're doing a backend transplant and keeping the UI - a two-to-four week job. If the schema is a mess and the "logic" is a thin wrapper over AI-generated CRUD, you're rebuilding, and the old app is a spec, not a codebase. We wrote a longer field guide to that call in [the vibe coding crisis: AI code debt](/blog/vibe-coding-crisis-ai-code-debt/). Read the schema before you decide. Everything downstream forks here.

This is also the point where you decide whether to run the migration yourself. If your team reads Postgres comfortably and has shipped auth before, keep going - the rest of this post is the playbook. If not, [our vibe code rescue service](/services/vibe-code-rescue/) exists for exactly this handoff.

## What these tools actually generate

You can't plan a migration without knowing what's under the hood, and the popular tools cluster into two shapes.

Lovable, Bolt, and Replit generate a real, ownable codebase. [Lovable ships a React + Vite front end with Supabase behind it](https://docs.lovable.dev/introduction/faq) - Postgres, Supabase Auth, Storage, and Deno edge functions. Bolt generates React or Next.js in a StackBlitz WebContainer and [connects Supabase as the backend](https://support.bolt.new/integrations/supabase). Replit gives you a full Linux container with whatever the agent wrote. In all three, you can export the code and take the Postgres database with you.

Base44 is the one to check carefully. After [Wix acquired it in June 2025](https://www.wix.com/press-room/home/post/wix-further-expands-into-vibe-coding-with-acquisition-of-base44-a-hyper-growth-startup-that-simplif), its export gives you the front end, but the database, auth, and backend services stay on Base44's infrastructure. You're not migrating a Base44 app so much as rebuilding its backend from the UI. v0 is frontend-only by design - it generates the React, you brought your own backend.

The practical read: if Supabase is your backend, your data is in standard Postgres and this migration is very doable. If your backend is a managed black box, the schema still exports but you're rebuilding more.

## Get the schema and data out first

Start here because it's the safe part, and getting it done early means you're never blocked on it later. Supabase is Postgres, so `pg_dump` does the work.

Grab the direct connection string from the Supabase dashboard under Settings, then Database. Use port 5432, not the pooled 6543 - [pg_dump needs the direct connection](https://supabase.com/docs/guides/platform/migrating-to-supabase/postgres):

```bash
pg_dump "postgresql://postgres:[pw]@db.<project>.supabase.co:5432/postgres" \
  --schema=public \
  --no-owner --no-privileges \
  --file=dump.sql
```

The `--schema=public` flag matters. Supabase keeps its own machinery in `auth`, `storage`, and `realtime` schemas, and you don't want those - you're replacing them. Dump `public`, read `dump.sql` in a text editor, and you'll have your real data model in front of you for the first time.

Then translate it to Rails migrations. The tables map almost one-to-one; the friction is at the edges. Supabase uses UUID primary keys by default, so tell Rails the same instead of fighting it:

```ruby
create_table :projects, id: :uuid do |t|
  t.references :owner, type: :uuid, foreign_key: { to_table: :users }
  t.string :name, null: false
  t.timestamps
end
```

Watch two things. Any column that referenced Supabase's `auth.users` needs to point at your new `users` table instead - that foreign key is the seam between the old auth and the new one. And columns Supabase filled with `auth.uid()` defaults need a Rails-side equivalent, usually set in the model or controller. Load the data with `psql` into your new database, run the app in a console, and confirm the counts match before you touch anything else.

## Rebuild the auth they faked

This is the layer that bites hardest, so budget for it honestly. The RLS holes from the intro aren't the auth being broken - they're the auth being absent. When every table is readable by the public key, there was never a server enforcing who-can-see-what. That job was supposed to live in RLS policies the tool never wrote.

Rails moves that enforcement to the server, which is where a founder can actually reason about it. Rails 8 ships a built-in authentication generator - no gem required for the common case:

```bash
bin/rails generate authentication
```

That gives you a `User` model with `has_secure_password`, a `Session` model, sign-in and sign-out, and password reset wired to the mailer. Point your migrated user rows at it. If your Supabase export stored bcrypt hashes, they move straight into `password_digest` because Rails uses bcrypt too - users keep their passwords and never notice. If the hashes are a format `has_secure_password` can't read, force a password reset on first login rather than trying to translate them.

If you need OAuth, roles, or multi-tenancy beyond what the generator covers, that's the Devise conversation. We compared the [Rails 8 authentication generator against Devise](/blog/rails-8-authentication-generator-devise-migration/) for exactly this decision - most rescued MVPs start on the generator and add Devise only when a real requirement shows up.

The test that matters: log in as user A and try to read user B's data by guessing an ID. In the old app that curl worked. After the migration, the controller should refuse it, because now a scope like `current_user.projects.find(params[:id])` decides what's visible, not a policy nobody wrote.

## Payments: the webhooks nobody wired up

Payments fail the same way auth does - the visible half works and the half that moves money doesn't.

Vibe-coded apps reliably produce a working Stripe Checkout button. The customer gets redirected, pays, comes back. What's missing is the webhook handler, the part where Stripe tells your server "that payment cleared, that subscription renewed, that card got declined." Without it, someone can pay and get nothing, or cancel and keep access, and your database never learns the difference. It's the least visible bug in the app and the one that quietly costs real money.

Rails handles the webhook as a plain controller action. The two rules that keep it honest: verify the signature so nobody can forge events, and make it idempotent because Stripe retries:

```ruby
class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    event = Stripe::Webhook.construct_event(
      request.body.read,
      request.env["HTTP_STRIPE_SIGNATURE"],
      Rails.application.credentials.stripe[:webhook_secret]
    )

    case event.type
    when "checkout.session.completed"
      Subscriptions::Activate.call(event.data.object)
    when "customer.subscription.deleted"
      Subscriptions::Revoke.call(event.data.object)
    end

    head :ok
  rescue Stripe::SignatureVerificationError
    head :bad_request
  end
end
```

Idempotency is the part people skip and regret. Stripe sends the same event more than once, so store the event id and check it before acting - activating a subscription twice is annoying, charging twice is a support fire. This is also where a real test suite earns its cost, because you cannot manually click your way through "card declined on renewal after three successful months." Founders underestimate this layer constantly; the [quality tax of an AI-built MVP](/blog/quality-tax-ai-mvp-cost/) has payments at the center of it.

## The front end: keep it or replace it

Now the layer where the default advice is often wrong. The generated React works. It renders, it's typed, and your users already know it.

If you're keeping React, run Rails in API mode and point the front end at it. Swap the `@supabase/supabase-js` calls for `fetch` to your Rails endpoints, move auth to the session cookie your new backend issues, and delete the Supabase client. The UI doesn't change; its data source does.

If you'd rather consolidate to one framework and one deploy, Hotwire lets you rebuild the interface in server-rendered Rails without a separate frontend build. That's the right call when the team is Ruby-first and the React was mostly forms and tables - which, on a rescued MVP, it usually was. It's the wrong call when the front end is genuinely interactive and rewriting it burns weeks to remove a working thing.

Either way you now own a deployable app. [Our Rails 8 Docker production guide](/blog/rails-8-docker-deployment-production-guide/) covers containerizing it, and when one box stops being enough, [the Kamal 2 multi-server guide](/blog/kamal-2-multi-server-deployment-complete-guide/) takes it across hosts.

## When not to migrate to Rails

Rails is the right rebuild target often enough that it's worth naming when it isn't, because forcing it costs more than picking correctly.

Don't do this migration if the app is a static marketing site with a form. That's a landing page and a form handler; Rails is a heavy answer to a light question. Don't do it if the product is genuinely realtime-first - a live collaborative editor, a multiplayer canvas, a trading view where every millisecond of push latency shows. Rails does realtime, but a design built around it from day one may be better served elsewhere, and honesty here saves a painful second migration.

And don't do it if your team has zero Ruby experience and no runway to learn. A rescue that hands you a stack nobody can maintain has moved the problem, not solved it. The [pattern behind most failed rebuilds](/blog/47-startups-failed-same-coding-mistake/) is choosing the technology the team can't operate. Rails wins when you have data worth keeping, business logic worth enforcing on a server, and someone who can read Ruby - which describes most SaaS MVPs that outgrew their AI builder, but not all of them.

The migration itself is boring in the good way. Export the schema, rebuild the two layers that were always going to break, decide about the front end, ship. The hard part was admitting the demo and the product were never the same thing.

<!-- Reference cadence: thoughtbot -->
