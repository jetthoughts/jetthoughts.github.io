---
title: "Migrate a Lovable or Replit App to Rails"
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

Before you migrate a Lovable app to Rails, open the network tab on the app you have today. You'll usually find the Supabase URL and a key labeled `anon` sitting in the client bundle. That key is meant to be public. What makes it dangerous is what's behind it: if row-level security was never turned on, that key reads the whole table.

```bash
curl 'https://<project>.supabase.co/rest/v1/profiles?select=*' \
  -H "apikey: <anon-key-from-the-bundle>"
```

A researcher ran a version of that check across Lovable's own showcase in early 2025 and found [303 endpoints on 170 projects returning data to anyone with the public key](https://www.superblocks.com/blog/lovable-vulnerabilities) - emails, addresses, in some cases API keys. It was disclosed in May 2025 as CVE-2025-48757. If you're reading this, you probably already know your app has a problem like it, and you're deciding whether to move to production-grade Rails or keep patching.

## First figure out what to keep

The honest answer to "how much of this transfers" depends on which part you're looking at, and the parts age very differently.

Your database schema and the data in it are the durable part. Tables, columns, foreign keys, the actual rows your users created - that ports cleanly, because it's just Postgres underneath. The generated React front end is often worth keeping: it renders, it's typed, and rebuilding pixel-perfect UI by hand is a poor use of a rescue budget.

Auth and payments almost never survive. Not because the tools can't wire them up, but because "looks wired up" and "actually enforces the rule" are different states that look identical in a demo.

Here's how it usually splits:

| Layer | Usually transfers? | Why |
|---|---|---|
| Database schema | Yes | It's Postgres. `pg_dump` and you're done. |
| Data (rows) | Yes | Same export. Watch the auth foreign keys. |
| Business logic | Sometimes | Read every line, port what's real, rewrite the rest. |
| Front end (React) | Often | It renders. Point it at a new API. |
| Auth | Rarely | Stubbed, hardcoded, or missing session handling. |
| Payments | Rarely | Stripe checkout exists; webhooks don't. |

One decision drives everything else. If the schema is sane and the data is real, you're doing a backend transplant and keeping the UI. If the schema is a mess and the "logic" is a thin wrapper over AI-generated CRUD, you're rebuilding, and the old app is a spec, not a codebase.

We wrote a longer field guide to that call in [the vibe coding crisis: AI code debt](/blog/vibe-coding-crisis-ai-code-debt/). Read the schema before you decide. Everything downstream forks here.

This is also the point where you decide whether to run the migration yourself. If your team reads Postgres comfortably and has shipped auth before, keep going. If not, [our vibe code rescue service](/services/vibe-code-rescue/) opens with a 48-hour audit and quotes a fixed price from it.

## What these tools actually generate

The popular tools cluster into three shapes, and the shape decides how much of this playbook applies.

Lovable, Bolt, and Replit generate a real, ownable codebase. [Lovable ships a React + Vite front end with Supabase behind it](https://docs.lovable.dev/introduction/faq) - Postgres, Supabase Auth, Storage, and Deno edge functions. Bolt defaults to React in a StackBlitz WebContainer and [connects Supabase as the backend](https://support.bolt.new/integrations/supabase). Replit gives you a full Linux container with whatever the agent wrote.

In all three, you can export the code and take the Postgres database with you.

Base44 is the one to check carefully. It's a hosted platform ([Wix acquired it in June 2025](https://www.wix.com/press-room/home/post/wix-further-expands-into-vibe-coding-with-acquisition-of-base44-a-hyper-growth-startup-that-simplif)), and [its data export is per-collection CSV files](https://docs.base44.com/Building-your-app/Managing-your-app-data), not a Postgres dump - the auth and backend services keep running on Base44's infrastructure. Migrating a Base44 app means rebuilding its backend from the UI and the CSVs.

v0 is frontend-first - [it can scaffold Next.js route handlers and database integrations now](https://v0.app/docs/full-stack-apps), but the database and auth are still yours to bring, so there's less to export and less to untangle.

## Get the schema and data out first

Supabase is Postgres, so `pg_dump` does the work.

Grab the direct connection string from the Supabase dashboard under Settings, then Database. Use port 5432, not the pooled 6543 - [pg_dump breaks through the transaction pooler](https://supabase.com/docs/guides/platform/migrating-within-supabase/backup-restore). One catch: the direct hostname `db.<project>.supabase.co` is IPv6-only, so on an IPv4-only network use the session pooler instead - same port 5432, on the pooler hostname.

```bash
pg_dump "postgresql://postgres:[pw]@db.<project>.supabase.co:5432/postgres" \
  --schema=public \
  --no-owner --no-privileges \
  --file=dump.sql
```

The `--schema=public` flag matters. Supabase keeps its own machinery in `auth`, `storage`, and `realtime` schemas, and you don't want that machinery - you're replacing it. Dump `public`, read `dump.sql` in a text editor, and you'll have your real data model in front of you for the first time.

That dump has one hole in it: your users. Supabase stores accounts - emails and bcrypt password hashes - in `auth.users`, which `--schema=public` skips. [Export them separately](https://supabase.com/docs/guides/troubleshooting/migrating-auth-users-between-projects) before you go further, from `psql` on the same connection string:

```sql
\copy (SELECT id, email, encrypted_password, created_at FROM auth.users)
  TO 'auth_users.csv' WITH CSV HEADER
```

Two restore traps follow from that split. Any `public`-schema foreign key that points at `auth.users` will error when you load `dump.sql` into a database with no `auth` schema - drop those constraints from the dump and re-add them against your new `users` table. And keep the exported `id` values: they're the UUIDs every other table references.

Replit apps take the same route with fewer detours. Replit hands the app its own Postgres connection string as `DATABASE_URL`, so `pg_dump` runs against that one and the `--schema=public` filter stops mattering - there's no separate Supabase `auth` schema holding the accounts apart. Whatever table the agent wrote users into comes out with the rest of the dump, so neither restore trap above applies and the CSV export step is one you can skip.

Then translate it to Rails migrations. The tables map almost one-to-one; the friction is at the edges. Supabase uses UUID primary keys by default, so tell Rails the same instead of fighting it:

```ruby
create_table :projects, id: :uuid do |t|
  t.references :owner, type: :uuid, foreign_key: { to_table: :users }
  t.string :name, null: false
  t.timestamps
end
```

Watch two things. The foreign keys that pointed at `auth.users` get re-created here against your new `users` table - that seam is where the old auth hands off to the new one, and the `users` table itself arrives in the next section, with a UUID primary key you have to ask for. And columns Supabase filled with `auth.uid()` defaults need a Rails-side equivalent, usually set in the model or controller.

Load the data with `psql` into your new database, run the app in a console, and confirm the counts match before you touch anything else.

Files are a separate export. Lovable apps lean on Supabase Storage for uploads - avatars, attachments, anything users added through the UI - and none of it is in the SQL dump. Pull each bucket down with the Supabase CLI or a script against the Storage API, move the files into Active Storage or straight to S3, and rewrite the stored URLs as you load the rows. Skip this step and the rescued app boots with every image broken.

## Rebuild the auth they faked

Auth bites hardest, so budget for it honestly. Behind the open endpoints from the intro, nothing was enforcing who-can-see-what - the RLS policies meant to do it were never written.

Rails moves that enforcement to the server, which is where a founder can actually reason about it. Rails 8 ships a built-in authentication generator - no gem required for the common case:

```bash
bin/rails generate authentication
```

That gives you a `User` model with `has_secure_password`, a `Session` model, sign-in and sign-out, and password reset wired to the mailer.

Make two edits before you run its migration. The generated `users` table uses a bigint primary key - change it to `id: :uuid`, or every foreign key you just migrated points at nothing. And the generator ships sign-in and password reset but no sign-up flow: fine for the rows you're importing, but new users can't register until you build that screen.

Now load the `auth_users.csv` you exported earlier. The `encrypted_password` column holds bcrypt hashes, and they move straight into `password_digest` because Rails uses bcrypt too - users keep their passwords and never notice. If any hashes are a format `has_secure_password` can't read, force a password reset on first login rather than trying to translate them.

If you need OAuth, roles, or multi-tenancy beyond what the generator covers, that's the Devise conversation. We compared the [Rails 8 authentication generator against Devise](/blog/rails-8-authentication-generator-devise-migration/) for exactly this decision - start on the generator and reach for Devise when a real requirement shows up.

The test that matters: log in as user A and try to read user B's data by guessing an ID. In the old app that curl worked. After the migration, the controller should refuse it, because a scope like `current_user.projects.find(params[:id])` now decides what's visible.

## Payments: the webhooks nobody wired up

Payments fail the same way auth does - the visible half works and the half that moves money doesn't.

A Stripe Checkout button is a redirect to a page Stripe hosts, so the generated version works: the customer pays and comes back.

What's missing is the webhook handler, the part where Stripe tells your server that a payment cleared or a subscription ended. Without it, someone can pay and get nothing, or cancel and keep access, and your database never learns the difference. It's the least visible bug in the app and the one that quietly costs real money.

Rails handles the webhook as a plain controller action. The two rules that keep it honest: verify the signature so nobody can forge events, and make it idempotent because Stripe retries:

```ruby
class StripeWebhooksController < ApplicationController
  # raise: false because API-mode Rails has no CSRF filter to skip
  skip_before_action :verify_authenticity_token, raise: false

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

Skip idempotency and Stripe's retry will activate the same subscription twice - store the event id and check it before acting. The [quality tax of an AI-built MVP](/blog/quality-tax-ai-mvp-cost/) puts payments at the center for a reason. This is also where a real test suite earns its cost, because you cannot manually click your way through "card declined on renewal after three successful months."

## The front end: keep it or replace it

Here the default advice is often wrong. The generated React works, and your users already know it.

If you're keeping React, run Rails in API mode and point the front end at it. Swap the `@supabase/supabase-js` calls for `fetch` to your Rails endpoints, move auth to the session cookie your new backend issues, and delete the Supabase client. The UI keeps working against a new data source.

One warning: if the SPA lives on a different domain than the Rails API, that session cookie means CORS and SameSite work - rack-cors plus `SameSite=None; Secure`, or serve both from one domain.

If you'd rather consolidate to one framework and one deploy, Hotwire lets you rebuild the interface in server-rendered Rails without a separate frontend build. That's the right call when the team is Ruby-first and the React was mostly forms and tables. It's the wrong call when the front end is genuinely interactive and rewriting it burns weeks to remove a working thing.

Either way you now own a deployable app. [Our Rails 8 Docker production guide](/blog/rails-8-docker-deployment-production-guide/) covers containerizing it, and when one box stops being enough, [the Kamal 2 multi-server guide](/blog/kamal-2-multi-server-deployment-complete-guide/) takes it across hosts.

## When not to migrate to Rails

Rails is the right rebuild target often enough that it's worth naming when it isn't, because forcing it costs more than picking correctly.

Skip it if the app is a static marketing site with a form. That's a landing page and a form handler; Rails is a heavy answer to a light question.

It's also the wrong move when the product is genuinely realtime-first - a live collaborative editor, a multiplayer canvas, a trading view where every millisecond of push latency shows. Rails does realtime, but a design built around it from day one may be better served elsewhere, and honesty here saves a painful second migration.

The third reason to hold off: a team with zero Ruby experience and no runway to learn. A rescue that hands you a stack nobody can maintain just relocates the problem. One [pattern behind failed rebuilds](/blog/47-startups-failed-same-coding-mistake/) is choosing technology the team can't operate.

Rails wins when you have data worth keeping, business logic worth enforcing on a server, and someone who can read Ruby - which describes most SaaS MVPs that outgrew their AI builder, but not all of them.

The migration itself is boring in the good way. Start with the dump; everything else follows from what you find in it.

<!-- Reference cadence: thoughtbot -->
