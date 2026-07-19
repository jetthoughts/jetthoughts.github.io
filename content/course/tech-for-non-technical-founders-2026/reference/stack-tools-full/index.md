---
title: "Full Reference: The Self-Serve MVP Stack"
description: "The complete self-serve stack reference - each tool in plain English, the M2-prototype-vs-M4-MVP contrast, the two build-time AI audits, all 12 build rules, the founder communities, and the full further-reading set. Companion to Lesson 4.3."
date: 2026-05-18
draft: false
slug: stack-tools-full
---

> **Reference companion to [Lesson 4.3 · The Self-Serve MVP Stack](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/)** - each tool in plain English, the throwaway-prototype-vs-production-MVP contrast, the two build-time AI audits, all 12 build rules, and the founder communities. Read the micro-lesson first for the tool boundaries and the 3 pre-flight rules; return here when you want the depth on any one tool or rule.

---

## Why these three tools, and why they slot together

[Y Combinator's current stance](https://www.ycombinator.com/library/) is direct: validate without code, then ship the simplest version with AI tools. Lovable + Supabase + Stripe became the dominant self-serve path because all three tools were built AI-first, their documentation is exhaustive, and the integrations between them are templated to the point of being boring.

Boring is what you want for an MVP. The boring path lets one non-technical founder ship the full loop (signup, paid onboarding, the one feature that solves the validated problem) without ever opening a terminal.

How much demand evidence you already have decides the path. With enough of it, you open Lovable and build. Without it, a $0 Concierge MVP - a no-code "Wizard of Oz" where you fake the automation by hand behind the curtain - gets you more evidence before you commit to Lovable code. Wire up Tally (free form) → Zapier or Make.com (free routing) → Airtable or Notion (free storage): the customer fills the Tally form, Zapier drops the row in Airtable, and you process it by hand. To the customer it looks automated, so you validate willingness-to-pay before writing code. The trade-off is that you run it by hand, which makes it a stepping stone, not a replacement. Either way, the Lovable + Supabase + Stripe stack is what ships in [Lesson 4.4](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/).

## M2 prototype vs M4 MVP - different artifacts, different rigor

The [Module 2 clickable prototype](/course/tech-for-non-technical-founders-2026/clickable-prototype-validation-2-hour-lovable/) (Lovable in 2 hours) tested whether 5 interview subjects could navigate the SHAPE of the solution. It had no real auth, no payment integration, no production domain. Discard it.

The Module 4 MVP is built from the [validated Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/) with production rigor: real Lovable build with real Supabase auth + real Stripe + real custom domain + real user data. Different stack composition, different polish bar, different decision criteria.

| | M2 prototype | M4 MVP |
|---|---|---|
| Time | 2 hours | Days to weeks |
| Auth | None | Supabase auth |
| Payment | None | Stripe live |
| Domain | lovable.dev preview | Custom domain |
| Polish | Sketch-grade | Production-grade |
| Audience | 5 interview subjects | Real signups + paying customers |
| Decision | "Should we build this for real?" | "Should we scale this?" |

## What each tool does (in plain English)

It is tempting to ask "which framework" before you ask "which job." Three tools, three jobs. The boundaries between them are the only architecture you need to know on day one.

### Lovable - the UI layer

Lovable is an AI-powered builder for the screens. You describe an app in English: *"a dashboard for fitness coaches to log client check-ins, with a weekly export to CSV"*, and Lovable generates a working web frontend with proper component structure, routing, and form validation. Every save deploys to a public staging URL you can paste into a Slack message.

[Lovable's pricing](https://lovable.dev/pricing) runs from a capped free tier through paid tiers sized by build velocity - check the pricing page for current numbers. Expect to move to a mid or scale tier after the first month once build velocity picks up.

The key thing it does not do well: heavy backend logic, complex auth flows, anything custom on the database side. That is what Supabase is for.

### Supabase - the data layer

Supabase is managed Postgres (a widely used database) + auth (the login and signup system) + file storage + row-level security (rules that keep each user's rows private to them) in one console. Lovable's built-in storage is fine for a prototype; Supabase is what you connect when you have real users whose data has to survive a redeploy.

The free tier comfortably covers early-stage usage - [check Supabase's pricing page](https://supabase.com/pricing) for current limits. Early-stage usage rarely outgrows the first paid tier before you hit the architectural ceiling.

Supabase auto-generates a REST API (a standard way for one program to request data from another) and a JavaScript client on top of any table you create, which is what Lovable calls when it needs to read or write a row. The auth product replaces most of what founders used to pay Auth0 or Clerk for; the row-level security policies replace what a contractor would have hand-coded over two weeks.

### Stripe - the money layer

Stripe processes the payment. The 2026 default integration for a Lovable app is [Stripe Checkout](https://docs.stripe.com/payments/checkout) (a hosted page Lovable can link to with one line) plus a webhook into Supabase that updates the user's subscription status when the charge succeeds.

The fee is the standard [per-transaction card processing rate](https://stripe.com/pricing) for cards in the US (a small percentage plus a flat per-charge amount); international, Klarna, ACH, and other rails have their own bands. There is nothing custom about this in 2026. Every founder hits the same Checkout integration; the documentation has been refined over a decade of the exact same setup.

### GitHub for version control

Free for solo founders on the Free plan. You will not write much code yourself, but Lovable can sync to a GitHub repo (short for repository - the online folder that stores your code) on every save. Two reasons this matters: (a) you have a backup if Lovable goes down or you cancel the subscription, (b) when you eventually hire a contractor or a Fractional CTO, the code is already in a place they can read. Set this up in Lovable's Settings on day one. Skipping this is the most common reason a founder cannot retrieve the source six months later.

## Have AI review the build

The [Lesson 4.3 pre-flight leakage check](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) runs against your brief before you build. These two audits run against the actual build once it exists - during the Phase 1-4 build in [Lesson 4.4](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/).

**Audit your Supabase RLS policies.** First, in the Supabase Dashboard, open Table Editor, click each table, click the Definition tab, and copy the SQL shown. Paste all your table definitions into Claude with this prompt:

```text
Here are my Supabase table definitions. Which tables lack row-level security (RLS) enabled, and for each one, name the cross-tenant data leak that would result if a logged-in user from Tenant A queried that table. If you cannot determine the leak without seeing the application code, respond with "NEED CODE: [which file]" rather than guessing.
```

**Walk the happy path from static input.** Open Lovable in your browser, take 3 screenshots (sign-up screen, the one core-action screen, and the paywall / payment screen) and paste them into Claude one by one along with Section 3 of your brief. Prompt:

```text
Here is the signup-to-paywall happy path from my MVP plus the outcome-shaped feature list it was meant to ship. For each screenshot, name any screen, button, or field that is NOT in the outcome list - these are scope leakage you can cut before launch. If a screen looks aligned to the outcome, say so explicitly.

If you cannot identify any scope leakage in a screenshot, respond with "NO SCOPE LEAK FOUND" - that is a valid finding, not a failure.
```

Claude cannot audit a URL it cannot browse; it CAN audit screenshots you provide.

**What AI cannot prove or substitute:**
- Whether real users can navigate the workflow (only uncoached ICP users can)
- Whether the Stripe webhook idempotency is correct (only test-mode charges can)
- Whether the architecture will hold at scale (only real traffic + [Lesson 4.5](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) ceiling signals can)

**The real gate:** 5 green lights (Phase 4 exit criteria in [Lesson 4.4](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/)) + weekly demo to one non-PRD-reader human.

## 12 rules for a self-built MVP done right

3 rules need to be true BEFORE you open Lovable (rules 1, 2, and 6 - the pre-flight rules taught in Lesson 4.3). The rest fire inline during the Phase 1-4 build. If you internalize ONLY the 3 pre-Lovable rules + the Phase 4 exit criteria, you ship a working MVP. The other rules are inline reminders, not a homework checklist.

1. **Start from a one-page brief that passed the Lesson 3.2 quality-gate.** If Section 3 is feature-shaped, fix it before you open Lovable. Feature-shaped briefs produce sprawling admin panels.
2. **One workflow, one persona, one happy path.** No multi-tenancy, no admin dashboard, no settings page on day one. Build the shed (Rob Walling's analogy), not the house.
3. **Strict layer boundaries**: Lovable renders screens, Supabase stores data, Stripe collects payment. Do not let Lovable hand-roll auth; do not let Supabase render a UI; do not let Stripe become the source of truth for user state.
4. **Weekly demo to one non-PRD-reader human.** Spouse, advisor, dog if necessary. Keep a ship-something-visible cadence every week. The demo IS the data; the screens are not.
5. **Do NOT iterate the Lesson 2.6 throwaway prototype.** Start the build fresh from your one-page brief. The prototype answered "do users know what to click"; the MVP answers "do users pay."
6. **Set up GitHub sync in Lovable Settings on day 1.** Lovable can drop the work; GitHub is your backup. Skipping this is the #1 reason founders cannot retrieve their source.
7. **Enable Row-Level Security on every Supabase table from day 1.** RLS is the rule that says "Coach A can only read Coach A's rows." Skipping it ships the cross-tenant data leak that ends pilots (see [Lesson 4.5](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) Signal 4).
8. **Stripe webhook handler must be idempotent.** Idempotent means "safe to run twice without breaking anything" - Stripe sometimes sends the same payment event more than once, and your handler must not double-charge or double-activate. Check `WHERE event_id = $1 AND processed = true` before re-running the update. (See the production hardening section of the [hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/#production-hardening-checklist-what-your-fractional-cto-will-look-for) for details.)
9. **Budget envelope: vendor free tiers + per-tool monthly fees.** Lovable free, Supabase free, Stripe transaction fees, domain registration. Upgrade Lovable to a paid tier only when build velocity demands it.
10. **Ship before scope creep, then a short stabilization phase.** Build the smallest end-to-end thing, then a stabilization phase before paid-pilot conversations. Sits inside the multi-month journey to first paying customer.
11. **Monthly Lesson 4.5 ceiling-signal check once the live MVP is up.** Even if everything is green, the habit catches the 5 architectural break-points before they become rebuilds.
12. **Do not scale a Lovable stack past ~5K users or two ceiling signals firing for 4+ weeks.** When you hit either limit, graduate to a Fractional CTO bridge (see [hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/#the-fractional-cto-bridge)). The shed is not the house; pouring skyscraper foundations into a shed slab does not build a skyscraper.

Each of the 12 rules is taught in depth somewhere across this reference, the [self-serve stack walkthrough](/course/tech-for-non-technical-founders-2026/self-serve-stack-walkthrough/), [Lesson 4.5 ceiling signals](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/), or the [hire-track supplementary reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/).

## Communities that replace a co-founder

You are about to hit a wall: a Lovable prompt that produces the wrong component, a Supabase RLS policy that locks out your own admin user, a Stripe webhook that fires twice for one charge. Five communities answer most of these in under an hour, free.

| Community | Best for | Cost |
|---|---|---|
| **[Lovable Discord](https://lovable.dev/community)** | Real-time UI troubleshooting; Lovable team answers in channels; monthly hackathons | Free |
| **[Indie Hackers](https://www.indiehackers.com/)** | Honest revenue posts + shipping logs; Friday-demo accountability rhythm | Free + paid tier |
| **[No Code Founders (NCF Slack)](https://www.nocodefounders.com/)** | If Lovable is wrong for your UI shape; worth membership even if you stay on Lovable | Free membership |
| **r/nocode + r/vibecoding (Reddit)** | Lower signal-to-noise than Slack; search before post | Free |
| **[Buildspace + Maven cohorts](https://maven.com/)** | Peer cohort + office hours; best when a deadline is what makes you ship | Paid - check the course page |

None of these is JetThoughts. None of them sells you a service. They are the founder peer pool the YC stance on co-founders [now points at](https://www.ycombinator.com/library/) instead of the 50%-equity hire.

## Further reading

- [Lesson 4.4: Build Phases](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/) - the companion lesson: 4 build phases, exit criteria, shed-vs-skyscraper, and the architectural ceiling
- Y Combinator, [Startup School Library + 2026 Founder Resources](https://www.ycombinator.com/library/) - the YC stance on validating without code and the changing role of the technical co-founder
- Rob Walling, [Vibe Coding interview on Creator Science](https://podcast.creatorscience.com/rob-walling/) - the shed vs skyscraper analogy that frames the architectural ceiling. 35-minute listen.
- Lovable, [Pricing tiers](https://lovable.dev/pricing) and [community Discord](https://lovable.dev/community)
- Supabase, [Pricing tiers](https://supabase.com/pricing) and [Row-Level Security guide](https://supabase.com/docs/guides/database/postgres/row-level-security)
- Stripe, [Checkout quickstart](https://docs.stripe.com/checkout/quickstart) and [Pricing page](https://stripe.com/pricing)
- DHH, [The One-Person Framework](https://world.hey.com/dhh/the-one-person-framework-711e6318)
- Veracode, [GenAI Code Security Report 2025](https://www.veracode.com/blog/genai-code-security-report/)

---

*Built by [JetThoughts](https://jetthoughts.com) as a companion reference to the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
