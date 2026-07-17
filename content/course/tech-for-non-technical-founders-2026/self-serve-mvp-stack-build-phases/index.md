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
> **Companion pair: read [Lesson 4.3 · Tools & Setup](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) first** - it covers why these three tools, what each one does, the 3 pre-flight rules, and the AI critic block; the full 12 build rules and founder communities are in the [stack-and-tools reference](/course/tech-for-non-technical-founders-2026/reference/stack-tools-full/). The phases below reference those concepts without re-explaining them.
>
> **Input:** the self-serve stack set up plus the pre-flight rules from [Lesson 4.3](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) + your one-page brief from Module 3
>
> **Output:** a live MVP at a real URL that real users can click
>
> **Progress:** M4 · 4 of 5 · Results so far: stack set up + pre-flight rules locked (4.3) - this lesson walks the 4 build phases to a live MVP

> **TL;DR:** Four build phases with one demo each. Phase 1 ships clickable UI. Phase 2 wires Supabase auth. Phase 3 connects Stripe checkout. Phase 4 deploys to 5 ICP users. Five green lights to exit. Ship the shed, not the skyscraper.

---

You validated the problem in Modules 1-3 and set up the stack in Lesson 4.3. What you do not have yet is a URL a stranger can pay on. This lesson is the build plan that gets you there - four phases, each ending in one working demo to one human who has not seen the build.

After this lesson you will be able to: **run the four build phases in order, each ending in one demo to one person, until you have a live MVP at a real URL that real users can click.**

![Four build phases, then the five-green-lights gate. Phase 1 Lovable UI - screens click, nothing saved. Phase 2 Supabase and auth - a real signup persists. Phase 3 Stripe checkout - a $1 test charge flips the row to paid. Phase 4 go live - 5 ICP users click the live URL. All five exit lights green advances you to Module 5.](build-phases-strip.svg)

## The ship plan

Four build phases, plus an onramp phase that hands you off to Module 5. Each phase ends with one demo to one human (a friend, an advisor, your spouse - someone who has not seen the build). The build ends with five real ICP users on the staging URL; the onramp brings the rest of your Lesson 2.3-2.4 interview pool onto the product.

1. **Phase 1 - Lovable, the UI.** No backend yet. *Demo:* screens click, no data persists.
2. **Phase 2 - Supabase + auth.** Real signup works. Enable [Row-Level Security](https://supabase.com/docs/guides/database/postgres/row-level-security) (RLS - the database rule that walls one customer's data off from another's) from the first table. *Demo:* your spouse signs up, a row appears in Supabase in real time.
3. **Phase 3 - Stripe + checkout.** Build one product (your monthly plan) at one price - the price your [Lesson 1.5 smoke test](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) validated, not a guess. Run $1 test transactions until the webhook (the automatic message Stripe sends your app when a payment lands) flips your row to paid.
4. **Phase 4 - staging URL + 5 ICP users.** Custom domain, Stripe live. Log 5 click sessions, then iterate from real signal.
5. **Onramp phase - Module 5 handoff.** Invite the 10 Lesson 2.3-2.4 interviewees by name. Hand off to Module 5 with a populated users table, not an empty one.

The [full build guide](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/) walks each phase step-by-step - the Lovable prompts, the first Supabase table, the RLS self-test, the Stripe test cards, and the domain switch.

> **Bridge from Lesson 2.6 vocabulary (the most useful paste in the course).** Before you describe a button label, a column header, or a screen title, open your Lesson 2.6 vocabulary doc (the verbatim words your 5 prototype subjects used in the closing "describe in one sentence" question). If 4 of 5 said "match" and not "reconcile," the button label is **"Match transactions,"** not "Reconcile." If 3 of 5 said "client" and 2 said "patient," **use the most-repeated term**. The vocabulary your prototype subjects passed is the only user-tested language you have; the production MVP is the one place where using it has revenue consequences.

## The five green lights

The MVP is "done" only when ALL five lights are green. Without them, you either polish forever in Lovable or hand Module 5 an MVP real users cannot touch.

1. **Stripe in LIVE mode** and a real card clears the paywall at least once.
2. **Custom domain wired** (not a `.lovable.app` subdomain) - the URL you send must be yours.
3. **At least 1 ICP user who was NOT in your Lesson 2.3-2.4 interviews** reached the paywall on the live URL.
4. **Zero red errors in the browser Console** on the sign-up + checkout flow (press F12, click through like a user, check the Console tab).
5. **A weekly demo recording exists** for the last week of build (a Loom or screen-record proving the cadence held to the end).

Advance to Module 5 only when all five are green. If any are red, fix the red light first before you move on - a red gate hands Module 5 an MVP real users cannot touch.

## Ship the shed, not the skyscraper

Lovable + Supabase + Stripe is the shed: one workflow, one persona, one happy path, three integrations. It cannot host every business - but it can host yours through the first 10 paying customers, which is the only data point that earns you the right to argue about the next architecture. The [full build guide](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/) has the in-the-envelope / out-of-the-envelope table and what the stack costs at each tier.

## Module 5 handoff: invite your interviewees by name

The 5 cold prospects from Phase 4 are the demand-signal check. The 10 people you ran through Lesson 2.3-2.4 are the warm pool that becomes your first real users - the ones who told you the problem was real, in their own words. They are not on your MVP yet, and they will not show up unless you invite them by name.

Open your Lesson 2.3-2.4 interview list. For each of the 10, write a 3-line personal note: the workaround they described, the staging URL of the workflow that now replaces it, and one question they answered that the MVP now responds to. Send it as a [Loom](https://www.loom.com) or a personal LinkedIn DM, not a generic email blast. Expect 4-6 to create accounts and 1-2 to become candidates for the [Lesson 5.1 Sean Ellis 40% survey](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/) once you have 10-30 users total. This is the step that turns a working URL into a users table with rows in it.

## Do this now

Three actions, in order. The first two cost $0.

1. **Sign up for the Lovable + Supabase free tiers** on [lovable.dev](https://lovable.dev) and [supabase.com](https://supabase.com), then connect GitHub sync inside Lovable so your code survives a cancelled subscription.
2. **Pick ONE feature from your one-page brief's "what you're building" section.** Not three. One. The smallest workflow that solves the validated problem for one persona. Write it as: "build a [screen] for [persona] to [outcome]."
3. **Generate the UI in Lovable and demo it.** Iterate by chatting: rename, resize, reposition. Then show one human who has not read the brief and watch them try it without a tour.

> **Success check:** a clickable UI on a public staging URL, and one person navigated the core screen without you explaining it. Nothing needs to persist yet - that is Phase 2.

**If this fails: the person you demoed to needed a tour to understand the screen.**
- **Why:** the design is carrying meaning that should be on the screen, so the prompt described a layout instead of a job.
- **Fix:** rewrite the Lovable prompt around the one job the screen does ("log this week's check-in"), regenerate, and demo again. If two testers stall on the first screen, the workflow shape is wrong - revisit [Lesson 3.2 outcomes](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/) before adding Stripe.

Look at the one feature you picked. Could you cut it in half again and still solve the validated problem? The smaller the first ship, the more likely it actually ships.

> **Done:** a live MVP at a real URL with all five green lights lit - Stripe in live mode, custom domain wired, 1 fresh ICP user tested the paywall, zero red Console errors on signup + checkout, and a weekly demo recording exists.
>
> **You have now:** the self-serve stack set up (4.3) + a live MVP at a real URL. Save the URL, the admin login, and the latest weekly demo recording in a `Live MVP` doc in your `Founder OS` folder, with every account in your own name (per [Lesson 4.2's Day-1 ownership audit](/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/)). Module 5 invites your Module 2 interviewees and your [Lesson 1.4 smoke-test email list](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) to this URL as the warm seed for your first 10-30 users. Paying customers are the next test.
>
> **Next:** [5.1 · Your First Customer Is Not a Marketing Problem](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/) - it runs the Sean Ellis 40% test on the users this MVP collects. Bookmark [4.5 · Ceiling Signals](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) as the optional monthly check to run once the stack starts to strain.
>
> **If blocked:** see "If this fails" above, or open the [full build guide](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/) - it has the per-phase recovery steps and the free help channels from Lesson 4.3.
>
> **Deeper reference:** [The full 4-phase build guide - Lovable prompts, first Supabase table + RLS self-test, Stripe test flow, the 5-lights detail, the shed envelope, cost tiers, and the pre-Module-5 invite wave](/course/tech-for-non-technical-founders-2026/reference/mvp-build-phases-full/)

---

*See it in action: [Module 4 walkthrough: Mia ships TutorMatch](/course/tech-for-non-technical-founders-2026/module-4-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
