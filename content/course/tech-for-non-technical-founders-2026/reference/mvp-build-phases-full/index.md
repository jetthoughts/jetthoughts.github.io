---
title: "Full Reference: The Self-Serve MVP Build, Phase by Phase"
description: "The complete build guide behind Lesson 4.4 - the Lovable prompts, the first Supabase table and RLS self-test, the Stripe test flow, the 5 green lights in full, the shed envelope, cost tiers, and the pre-Module-5 invite wave."
date: 2026-05-18
draft: false
slug: mvp-build-phases-full
---

> **Reference companion to [Lesson 4.4 · The Self-Serve MVP Stack: Build Phases](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/)** - the step-by-step version of the four build phases, plus the onramp that hands you off to Module 5. Read the micro-lesson first for the minimum effective path; return here when you want the full mechanics for the phase you are on.

---

This guide assumes you already ran Modules 1-3 (hypothesis, smoke test, 10 interviews, one-page brief) and read [Lesson 4.3: Tools & Setup](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/). Lesson 4.3 covers what each tool does, the 3 pre-flight rules, and the AI critic block; the $0 budget path, the full 12 build rules, the Module 2 prototype vs the Module 4 MVP distinction, and communities live in the [stack-and-tools reference](/course/tech-for-non-technical-founders-2026/reference/stack-tools-full/). The phases below reference those concepts without re-explaining them. Skip straight here without validation and the build ships into the silence Modules 1-3 were designed to prevent.

> **Calendar reality for the MVP build.** A full-time founder with daytime availability can hit the Phase 4 5-lights in 4-6 weeks. An evening-only founder (the 2-4 hr/week pattern this course is built for) typically needs 10-12 weeks for the same outputs. Phase 2 (Supabase wiring + RLS - Row-Level Security, the database rule that walls one customer's data off from another's) and Phase 3 (Stripe webhook - an automatic message Stripe sends your app when a payment lands - plus idempotency, the rule that says "if the same webhook fires twice, only act once") are where part-time founders lose the most calendar. Plan the 10-week version, not the 4-week version.

## Phase 1 - write your prompts, set up Lovable, ship the UI

Start by opening the one-page brief. The "what you're building" section becomes your first three Lovable prompts.

Lovable's prompt style is conversational; you describe the screen, the components, the rough behavior. Examples:

```text
Build a dashboard for a fitness coach. Top-level view shows
a list of clients (name, last check-in date, status: green
if checked in this week, red if not). Click a client to open
their detail page with a check-in form (date, weight, notes,
3-photo upload).
```

Lovable generates the screens. You iterate by chatting with it: "make the status badges bigger, move the check-in form to the right side." By the end of the phase you have a clickable UI on a public staging URL. No data persists yet. That is fine. The phase demo is to your spouse: do the screens make sense without any explanation? If the screens need a tour to understand, the design is wrong, not the build. Rewrite the prompts.

## Phase 2 - set up Supabase, connect, real signup works

Create a Supabase project on the free tier. Define your three or four core tables in the SQL editor (or in the Table Editor UI; both work for an MVP). For the fitness coach example: `coaches`, `clients`, `check_ins`. Enable [Row-Level Security](https://supabase.com/docs/guides/database/postgres/row-level-security) from the start. RLS is the difference between a coach seeing their own clients and a coach seeing every coach's clients in a single bug. Skipping it is the most common security mistake we see in vibe-coded MVPs.

> **First-table walkthrough (for the fitness-coach example - adapt to your domain):** in Supabase Dashboard, click **Table Editor** in the left sidebar, then **New table**. Name it `coaches`. Check the "Enable Row Level Security (RLS)" box BEFORE adding columns. Add columns: `id` (uuid, primary key, default `gen_random_uuid()`), `email` (text), `user_id` (uuid, foreign key to `auth.users.id`), `created_at` (timestamp, default `now()`). Click **Save**. Repeat for your second and third tables. The RLS checkbox is the load-bearing click - if you forget it on table creation, you'll have to manually enable it later AND backfill policies on existing rows.

In Lovable, install the Supabase integration. Lovable will add the Supabase JS client and store the keys for you. Wire your signup screen to `supabase.auth.signUp()` and your data screens to `supabase.from('clients').select()`. The phase demo: your spouse signs up via the staging URL, you watch a row appear in the Supabase console in real time.

> **Self-test your RLS policy before going live (two paths).**
>
> Same audit as the Lesson 4.3 pre-flight rule - now run it against your real tables.
>
> *No-code path (the default for a non-technical founder - this is copy-paste verification, not programming: the AI writes the fix, you paste it and read the answer).* In Claude or ChatGPT, paste: *"Audit my Supabase RLS policy. Here is my schema: [paste your table definitions from Supabase Table Editor]. Here is my current RLS policy: [paste from Authentication -> Policies]. Tell me whether a logged-in user with a fake user-id can read rows that belong to other users. If yes, give me the exact policy SQL to fix it."* Paste the AI's suggested policy into Supabase Authentication -> Policies.
>
> *SQL path (only if you are comfortable writing SQL).* In Supabase Dashboard -> SQL Editor, paste the test below, replacing `<table>` with your main user-data table. The pretend user-id `999` has no real rows; if the query returns any, your policy has a hole.
>
> ```sql
> SET ROLE authenticated;
> SET request.jwt.claims = '{"sub": "00000000-0000-0000-0000-000000000999"}';
> SELECT * FROM <table>;
> RESET ROLE;
> ```
>
> Zero rows back = policy works. Any rows back = the policy is missing a `USING (auth.uid() = user_id)` clause or equivalent. Fix before any real user touches the URL.

> **End-of-Phase-2 micro-fail signal.** Before you build Stripe in Phase 3, hand the staging URL to your spouse OR one of your Lesson 2.3-2.4 Mom Test interviewees. Give zero coaching. Watch them try to sign up and reach the core action button (logging a check-in, exporting the CSV, whatever your one-page brief named as the workflow). If 2+ test users stall on screens 1-2, the workflow shape is wrong - pivot back to [Lesson 3.2 outcome rewrite](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/) before adding Stripe. Building a payment wall on top of a workflow nobody can navigate just adds friction to a broken loop.

## Phase 3 - add Stripe, wire checkout, $1 test transactions

Create a Stripe account in test mode. Build one product (your monthly plan) at one price (the price your [Lesson 1.5 smoke test](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) validated). Use [Stripe Checkout](https://docs.stripe.com/checkout/quickstart) for the simplest possible integration: one URL Lovable links to, one webhook (a webhook is an automatic message Stripe sends your app the moment a payment succeeds - you don't write code to call Stripe; Stripe calls you) back to Supabase that flips the `coaches.subscription_status` column to `active` when the charge clears.

Spend the rest of the phase running $1 test transactions through the flow: signup, hit the paywall, pay $1 in test mode, land in the paid view. Use Stripe's [test card numbers](https://docs.stripe.com/testing) to simulate failures (declined card, 3D Secure challenge, dispute). The phase demo is to yourself: you sign up as a fake coach, you pay $1, you land on the paid dashboard, you check Supabase, the row says paid. Webhook works.

## Phase 4 - deploy, send to 5 ICP users, iterate from the data

Switch Stripe out of test mode. Buy a domain (roughly $10/year for a .com on [Porkbun](https://porkbun.com/) or your registrar of choice; never let a tool hold your domain). Point the domain at the Lovable staging URL. Take final screenshots, write a 3-line cold email or LinkedIn DM, and send to 5 ICP prospects from your [Module 2 outreach list](/course/tech-for-non-technical-founders-2026/outreach-sequence-template/).

> "Hey [NAME] - the workflow you described recently (logging client check-ins by hand on a spreadsheet) is now a tool. Quick first-use, $29/month after a trial window. URL: [STAGING_URL]. Honest reactions only."

Watch what happens. If 0 of 5 click, the cold message is wrong, not the product (yet). If 5 click and 0 sign up, the landing screen is wrong, not the product. If 5 sign up and 0 pay, the paywall position or the price is wrong. Each failure shape tells you what to fix next. The demo is the data, not the screens.

> **Phase 4 exit criteria - the five green lights.** The MVP is "done" only when all five gates are green: Stripe in LIVE mode with a real card cleared, a custom domain wired, at least 1 fresh ICP user (not from your Lesson 2.3-2.4 interviews) reaching the paywall, zero red errors in the browser Console on the sign-up + checkout flow, and a final-week demo recording. [Lesson 4.4 · Build Phases](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/#the-five-green-lights) lists each light with its exact check. Advance to Module 5 only when all five are green; if any are red, the MVP is NOT ready for the 10-30 users Module 5 needs - fix the red light first, then re-check.

> **Pre-flight before M5.1: book up to 10 user sessions.** The onramp phase's 4-6 accounts are not enough for M5.1's Sean Ellis 40% test (under 10 respondents = noise, not signal). Before you start Module 5, book a second small invite wave: 5-10 more sessions from your Lesson 2.3-2.4 interviewee list, your community connections, or a fresh micro-batch of cold DMs. Aim for 10-30 active users by the time M5.1's survey ships - 5.1 treats 10 as directional-only and 20+ as a useful read. Without this pre-flight, you will run the 40% test on 5 people, get an ambiguous result, and falsely conclude you have a product problem when you really have a sample-size problem.

## Onramp phase - Module 5 handoff: invite your Module 2 interviewees onto the live MVP

The build phases above are the BUILD container. The onramp phase is the Module-5 handoff - the step that turns a live staging URL into a live users table. The five cold prospects from Phase 4 are the demand-signal check. The 10 interviewees you ran through Lesson 2.3-2.4 are the warm pool that becomes your first real users - the ones who told you the problem was real, in their own words, recently. They are not on your MVP yet. They will not show up unless you invite them by name.

Open your Lesson 2.3-2.4 interview list. For each of the 10 names, write a 3-line personalized note: the workaround they described in their interview, the staging URL of the workflow that now replaces it, and one specific question they answered that the MVP now responds to.

Send it as a [Loom](https://www.loom.com) (Loom is a short-form screen-recording tool - the recipient watches you click through the product in their browser, no install) or a personal LinkedIn DM, not a generic email blast.

Expect 4-6 of the 10 to create accounts; 2-3 of those to actually log in and click around; 1-2 to become candidates for the [Lesson 5.1 Sean Ellis 40% survey](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/) once you have 10-30 users total. "Create an account" is not "pay" - paid conversion happens in Module 5.

This is the step that closes the gap between Module 4 (MVP shipped) and Module 5 (first paying customer). Without it, you ship a working URL into the silence of a Supabase users table with zero rows. The Module 2 interviewees are the closest 10 people in the world to your ICP - they spent 30 minutes telling you their version of the problem. Inviting them by name is the cheapest first-10-users acquisition the course will name.

If you need more than 10 users on the MVP before running Lesson 5.1's survey, the recruitment playbook in [Lesson 2.3-2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) is the same one you use to find them - the message changes from "30 minutes of your time" to "try the live tool for a week, free."

## What "ship the shed" means in practice

[Lesson 4.1 · Should You Hire?](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/) walked through Rob Walling's [shed-vs-skyscraper warning](https://podcast.creatorscience.com/rob-walling/): you build the smallest structure that does the job, and you do not pour skyscraper foundations for it. Lovable + Supabase + Stripe is the shed.

| **Inside the envelope** | **Outside the envelope** |
|---|---|
| One workflow, one persona, one happy path | Multiple parallel workflows or personas |
| Database fits on one Supabase project | Complex data model needing sharding |
| No real-time features | Real-time multiplayer or live updates |
| No compliance scope | Regulated industry (healthcare, finance, PII) |
| AI inference costs pennies per request | AI inference at scale (daily cost >$10) |
| Three core integrations (Lovable/Supabase/Stripe) | Many third-party APIs beyond the three |

Be honest about the trade-off. This stack cannot host every business. It can host yours through the first 10 paying customers, which is the only data point that earns you the right to argue about the next architecture.

## What the stack actually costs

Per published vendor pricing:

| Phase | Cost shape | Line items |
|------|-------|-----------|
| Start | Free tiers | Free tiers across Lovable, Supabase, Stripe, GitHub |
| First ship | Per-tool monthly fees | Lovable + Supabase entry paid tiers + a .com domain (~$10/yr) + Resend entry tier + Stripe per-transaction fees |
| Post-launch | Scale-tier monthly fees | Lovable scale tier + Supabase paid tier + Resend/Sentry/monitoring paid tiers - check vendor pricing pages |

The architectural ceiling tends to land at the post-launch tier - at roughly 5,000 users, route to [Lesson 4.5 · Ceiling Signals](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) or a [Fractional CTO](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/#the-fractional-cto-bridge). A hire-a-team build is material monthly burn before revenue; this stack ships the same first 10 paying customers on a fraction of that.

## When this path ends

Self-serve has a ceiling. [Lesson 4.5 · Ceiling Signals](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) covers the 5 signals that mean it's time to bring in help. When 2+ signals fire across two consecutive monthly checks (the 4-week rule from Lesson 4.5), switch to the [hire-track supplementary reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/). Architecture does not collapse overnight; the warning shows up in the metrics before the customer sees it.

The [Self-Serve Stack Walkthrough](/course/tech-for-non-technical-founders-2026/self-serve-stack-walkthrough/) artifact is the day-by-day version of these phases. Print it before Phase 1. Each day has one small task; each phase has one demo. The artifact removes the "what do I do next" question, which is the reason most small ships actually finish.

## Further reading

- [Lesson 4.3: Tools & Setup](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) - why these three tools, what each one does, the 3 pre-flight rules, and the AI critic block
- [Stack & Tools reference](/course/tech-for-non-technical-founders-2026/reference/stack-tools-full/) - each tool in depth, the M2-vs-M4 contrast, all 12 build rules, and the founder communities
- [Self-Serve Stack Walkthrough](/course/tech-for-non-technical-founders-2026/self-serve-stack-walkthrough/) - day-by-day version of the build plan; print before Phase 1
- Y Combinator, [Startup School Library + 2026 Founder Resources](https://www.ycombinator.com/library/) - the YC stance on validating without code
- Rob Walling, [Vibe Coding interview on Creator Science](https://podcast.creatorscience.com/rob-walling/) - the shed vs skyscraper analogy
- Lovable, [Pricing tiers](https://lovable.dev/pricing) and [community Discord](https://lovable.dev/community)
- Supabase, [Row-Level Security guide](https://supabase.com/docs/guides/database/postgres/row-level-security)
- Stripe, [Checkout quickstart](https://docs.stripe.com/checkout/quickstart) and [Pricing page](https://stripe.com/pricing)
- Drew Falkman, "Vibe Coding Data-Enabled AI Apps" on Maven

---

*Built by [JetThoughts](https://jetthoughts.com) as a companion reference to the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
