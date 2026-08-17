---
title: "4.4 · The Self-Serve MVP Stack: Build Phases"
description: "The build plan: 4 phases from Lovable UI to live Stripe checkout, one demo each, and the 5 green lights that mean the MVP is done. Companion build guide to Lesson 4.3 (Tools & Setup)."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: self-serve-mvp-stack-build-phases
keywords:
  - lovable supabase stripe build phases 2026
  - non technical founder mvp build plan
  - vibe coding ship plan
  - self serve mvp exit criteria
tags:
  - founders
  - non-technical-founder
  - course-companion
  - self-serve
  - vibe-coding
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "4.4 · The Self-Serve MVP Stack: Build Phases"
  og_description: "The build plan: 4 phases from Lovable UI to live Stripe checkout. Phase exit criteria, 5 green lights, and the Module 5 handoff."
cover_image_alt: "JetThoughts cover titled Self-Serve Build Phases, showing four connected phase cards - Phase 1 UI, Phase 2 Data, Phase 3 Pay, Phase 4 Deploy - with chips reading Weeks 4-12, Phases 4, Team Solo."
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/"
related_posts: false
---

> **Module 4 · Lesson 4.4 · [CORE]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Read [Lesson 4.3 · Tools & Setup](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) first** - it sets up the three tools and the pre-flight rules this lesson builds with.
>
> **Input:** the stack from Lesson 4.3 + your one-page brief from Module 3
>
> **Output:** a live MVP at a real URL that real users can click
>
> **Progress:** M4 · 4 of 5

![Four build phases, each proven by one demo, then a green gate of five exit lights. Phase 1 Lovable - screens click, nothing saved. Phase 2 Supabase - a real signup persists. Phase 3 Stripe - a $1 test charge flips the row to paid. Phase 4 go live - 5 ICP users hit the live URL.](build-phases-strip.svg)

Budget the calendar honestly before you start: a full-time founder gets there in 4-6 weeks; at 2-4 hours a week, plan 10-12. Phases 2 and 3 are where part-time founders lose the most calendar.

> → **Mia walked the four phases** in nine build evenings across ten calendar weeks - and the Phase 2 AI audit caught a Lovable-default policy that let one parent read another's rows. [Full walkthrough →](/course/tech-for-non-technical-founders-2026/module-4-walkthrough-mia/)

## The ship plan

Each phase below ends with one demo to one human who has not seen the build.

> **Companion:** the [full build guide](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/) walks every phase step by step - each phase below links its exact section when you need it.

### Phase 1 - Lovable: ship the clickable UI

Pick ONE feature from your one-page brief's "what you're building" section - the smallest workflow that solves the validated problem for one persona. Could you cut it in half and still solve the problem? Then cut it. Write the prompt as **"build a [SCREEN] for [PERSONA] to [OUTCOME]"** ([prompt examples](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/#phase-1---write-your-prompts-set-up-lovable-ship-the-ui)) and let Lovable generate the screens. Iterate by chatting with it: rename a button, move a section. No backend yet; nothing persists, and that is fine.

> **Phase 1 demo:** one person who has not read the brief navigates the core screen without a tour.

**If they needed a tour:** the prompt described a layout instead of a job. Rewrite it around the one job the screen does ("log this week's check-in"), regenerate, and demo again. If two testers stall on the first screen, the workflow shape is wrong - revisit [Lesson 3.2 outcomes](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/) before you touch Stripe.

### Phase 2 - Supabase: real signup, walled data

Create your three or four core tables in Supabase ([first-table walkthrough](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/#phase-2---set-up-supabase-connect-real-signup-works)), and check **Enable Row-Level Security** on each table BEFORE adding columns. Then install the Supabase integration inside Lovable and wire the signup screen to it.

> **Why that checkbox:** [RLS](https://supabase.com/docs/guides/database/postgres/row-level-security) walls one customer's data off from another's - skipping it is the most common security hole in vibe-coded MVPs.

> **Phase 2 demo:** your spouse signs up on the staging URL and you watch the row appear in Supabase in real time.

**Before Phase 3, two checks.** First, run the RLS self-test (in the same guide section) - it is copy-paste verification with an AI assistant, not programming. Second, hand the URL to one tester with zero coaching; if they cannot reach the core action, go back to [Lesson 3.2](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/) - a paywall on top of a workflow nobody can navigate just adds friction to a broken loop.

### Phase 3 - Stripe: one product, one price, $1 test

Build one product at one price - the price your [Lesson 1.5 smoke test](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) validated, not a guess. Use [Stripe Checkout](https://docs.stripe.com/checkout/quickstart) in test mode, and wire the webhook (the automatic message Stripe sends your app when a payment lands) to flip your user's row to paid. Run $1 test transactions ([the full test flow](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/#phase-3---add-stripe-wire-checkout-1-test-transactions)) until the flip is boring.

> **Phase 3 demo:** you sign up as a fake user, pay $1 in test mode, land on the paid view, and the row in Supabase says paid.

**If the row never flips:** the webhook is the failure point, not the checkout. Use Stripe's [test card numbers](https://docs.stripe.com/testing) to walk the failure cases (declined card, 3D Secure) until the happy path and the failures both behave.

### Phase 4 - go live: domain, live mode, 5 real users

Buy a domain (roughly $10/year for a .com - never let a tool hold your domain), point it at the app, and switch Stripe to live mode. Then send a 3-line personal note ([word-for-word template](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/#phase-4---deploy-send-to-5-icp-users-iterate-from-the-data)) to 5 ICP prospects from your [Module 2 outreach list](/course/tech-for-non-technical-founders-2026/outreach-sequence-template/): the workaround they described, the URL that now replaces it, "honest reactions only."

> **Phase 4 demo:** five click sessions from real ICP users, logged.

**Read the failure shape before touching the product.** 0 of 5 click - the message is wrong, not the product. 5 click, 0 sign up - the landing screen is wrong. 5 sign up, 0 pay - the paywall position or the price is wrong.

> **Bridge from [Lesson 2.6](/course/tech-for-non-technical-founders-2026/clickable-prototype-validation-2-hour-lovable/) vocabulary.** Before you describe a button label, a column header, or a screen title, open your Lesson 2.6 vocabulary doc (the verbatim words your 5 prototype subjects used in the closing "describe in one sentence" question). If 4 of 5 said "match" and not "reconcile," the button label is **"Match transactions,"** not "Reconcile." The vocabulary your prototype subjects passed is the only user-tested language you have; the production MVP is the one place where using it has revenue consequences.

## The five green lights

The MVP is "done" only when ALL five lights are green. Without them, you either polish forever in Lovable or hand Module 5 an MVP real users cannot touch.

1. **Stripe in LIVE mode** and a real card clears the paywall at least once.
2. **Custom domain wired** (not a `.lovable.app` subdomain) - the URL you send must be yours.
3. **At least 1 ICP user who was NOT in your [Lesson 2.3-2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) interviews** reached the paywall on the live URL.
4. **Zero red errors in the browser Console** on the sign-up + checkout flow (press F12, click through like a user, check the Console tab).
5. **A weekly demo recording exists** for the last week of build (a Loom or screen-record proving the cadence held to the end).

Advance to Module 5 only when all five are green. If any are red, fix the red light first.

## Ship the shed, not the skyscraper

Lovable + Supabase + Stripe is the shed: one workflow, one persona, one happy path, three integrations. It cannot host every business - but it can host yours through the first 10 paying customers, which is the only data point that earns you the right to argue about the next architecture.

## Module 5 handoff: invite your interviewees by name

The 5 cold prospects from Phase 4 are the demand-signal check. The 10 people you ran through [Lesson 2.3-2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) are the warm pool that becomes your first real users - the ones who told you the problem was real, in their own words. They are not on your MVP yet, and they will not show up unless you invite them by name.

Open your Lesson 2.3-2.4 interview list. For each of the 10, write a 3-line personal note: the workaround they described, the staging URL of the workflow that now replaces it, and one question they answered that the MVP now responds to. Send it as a [Loom](https://www.loom.com) or a personal LinkedIn DM, not a generic email blast. Expect 4-6 to create accounts and 1-2 to become candidates for the [Lesson 5.1 Sean Ellis 40% survey](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/) once you have 10-30 users total. Skip this step and you ship a working URL into an empty users table.

## Do this now

Start Phase 1 tonight. The first two actions cost $0.

1. **Confirm the Lesson 4.3 set-up held:** Lovable + Supabase free-tier accounts exist and GitHub sync is on (pre-flight rule 3). If you skipped it, do it now on [lovable.dev](https://lovable.dev) and [supabase.com](https://supabase.com).
2. **Write your Phase 1 prompt** - one feature, "build a [SCREEN] for [PERSONA] to [OUTCOME]."
3. **Generate the UI and run the Phase 1 demo** with one human who has not read the brief.

> **Done:** a live MVP at a real URL with all five green lights lit (the list above). The day before you share the URL with anyone new, run the printable [Pre-Launch Checklist](/course/tech-for-non-technical-founders-2026/pre-launch-checklist/) - it breaks the lights into 15 two-minute checks.
>
> **You have now:** the self-serve stack set up (4.3) + a live MVP at a real URL. Save the URL, the admin login, and the latest weekly demo recording in a `Live MVP` doc in your `Founder OS` folder, with every account in your own name (per [Lesson 4.2's Day-1 ownership audit](/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/)). Module 5 invites your Module 2 interviewees and your [Lesson 1.4 smoke-test email list](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) to this URL as the warm seed for your first 10-30 users. Paying customers are the next test.
>
> **Next:** [5.1 · Your First Customer Is Not a Marketing Problem](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/) - it runs the Sean Ellis 40% test on the users this MVP collects. Bookmark [4.5 · Ceiling Signals](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) as the optional monthly check to run once the stack starts to strain.
>
> **If blocked:** each phase above carries its own failure branch - start there.
>
> **Deeper reference:** [The full 4-phase build guide](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/) - the exact mechanics for every phase, the shed envelope table, and cost tiers.

---

*See it in action: [Module 4 walkthrough: Mia ships TutorMatch](/course/tech-for-non-technical-founders-2026/module-4-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
