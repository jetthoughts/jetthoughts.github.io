---
title: "3.2 · Quality-check your brief: features to outcomes"
aliases: ["/blog/stop-specifying-features-start-outcomes/"]
description: "Lesson 3.2 of the From Idea to First Paying Customer course. The quality-gate on your Lesson 3.1 brief: rewrite Section 3 feature nouns as outcome-shaped job stories before handing off to Lovable or a contractor."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: stop-specifying-features-start-outcomes
keywords:
  - specify outcomes not features
  - prevent over engineering founder
  - founder feature spec template
  - job stories non technical founder
  - prevent admin panel spaceship
tags:
  - founders
  - non-technical-founder
  - course-companion
  - product
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "3.2 · Quality-check your brief: features to outcomes"
  og_description: "Lesson 3.2 of the From Idea to First Paying Customer course. The quality-gate on your Lesson 3.1 brief: rewrite Section 3 feature nouns as outcome-shaped job stories before handing off to Lovable or a contractor."
cover_image_alt: "JetThoughts cover showing a simple three-button admin panel on the left and a 47-button spaceship control deck on the right, connected by a wavy red arrow labeled '10-week build, $15K'"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/"
related_posts: false
---

> **Module 3 · Lesson 3.2 · [CORE] - the quality gate on your 3.1 brief** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a one-page Product Brief (from [Lesson 3.1](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/))
>
> **Output:** a one-page Product Brief rewritten so engineers and AI agents stop overengineering
>
> **Progress:** M3 · 2 of 2 · Results so far: one-page brief drafted (3.1) - this page stress-tests Section 3 before Module 4 builds from it

---

Send a builder four words - "build a simple admin panel" - and you get back 47 buttons, role permissions, an audit log, and an AI co-pilot nobody asked for. This lesson is the 20-minute rewrite that makes the builder ship the three buttons you actually meant, not the spaceship.

After this lesson you will be able to: **rewrite every feature noun in Section 3 of your brief as an outcome-shaped job story - so the builder has no blanks left to fill with a 47-button spaceship.**

The Section 3 you fix here is the exact text Module 4 pastes into Lovable. It is not a rewrite for style - it is the check that decides whether the builder ships what you meant or a bigger thing you'll spend the quarter deleting.

![A hand-drawn comparison: the simple three-button admin panel you asked for on the left, the absurdly complex 47-button control deck that got built on the right, connected by a red arrow labeled 10-week build, $15K](admin-panel-spaceship.svg)

## Why feature briefs overbuild

Engineers and AI agents fill vague requests from training data - big-company SaaS panels, GitHub-scraped baselines, the busiest version of whatever they last saw. A feature word in isolation ("CSV export," "user roles") has no anchor to your actual job, so the builder invents the missing context. An outcome-shaped request leaves no blanks to fill - the moment, the action, the deadline, and the result are already on the page.

## The three-part shape that constrains every spec

Rewrite every feature noun in three parts. Each part forecloses a category of overbuild.

- **When [TRIGGER_CONTEXT]** - the specific situation that activates the need. Names the moment, the day, the deadline, the surrounding tools. *"When I prepare the weekly investor report"* tells the builder this happens once a week, that there is a deck, that there is a 4pm call. No real-time streaming dashboard for something that happens on a Tuesday afternoon.
- **I want [action + budget]** - a verb on a concrete object, with a limit. *"I want to grab the top 5 metrics in 30 seconds"* is a verb (grab), an object (the 5 metrics), and a budget (30 seconds). No 12-metric dashboard, no async export queue.
- **So I can [OUTCOME]** - the result that proves the build worked. *"So I can paste them into the deck before the 4pm call"* is a finish line the builder holds every feature suggestion up against: does the audit log help you paste before 4pm? No? Cut it.

Put the three parts together and the builder has no gaps left to guess at. Drop any one - the timeframe, the action, or the outcome - and the gap gets filled from training data instead of your intent.

Same job, written both ways:

> **Feature shape:** *"Build a CSV export button on the dashboard."* The builder ships a reporting module with three dashboards, scheduled email exports, role-based access, a date-range picker, and an audit log. Six weeks. You used the button once a week.
>
> **Outcome shape:** *"When I prepare the weekly investor report, I want to grab the top 5 metrics in 30 seconds, so I can paste them into the deck before the 4pm call."* The builder ships one button that copies five hard-coded metrics to the clipboard. Ninety minutes. The next investor email goes out before the deck opens.

A second worked pair (the CRM module), the priced-out comparison table, and the full AI-reviewer test protocol live in the [deeper reference](/course/tech-for-non-technical-founders-2026/reference/outcomes-not-features-full/).

## Do this now

1. Open your filled-in [one-page brief](/course/tech-for-non-technical-founders-2026/vibe-prd-template/) from Lesson 3.1. Find Section 3 ("What you're building"). Read it out loud. Any sentence that leans on a noun-shaped feature ("a CSV button," "a CRM," "user roles," "a settings page") is feature-shaped - mark it.
2. Rewrite each marked sentence in the *When / I want / So I can* shape. The *when* names a specific moment with a deadline; the *I want* names a verb and a budget; the *so I can* names a result you can measure that week.
3. Share the rewritten section with your engineer or your AI agent and ask one question: *"What would you build differently from this brief than from the feature list?"* Their first answer is the scope you were about to lose.

**Success check:** every line of Section 3 names a moment and a result, not a piece of software - and the peer's answer stays inside your Section 3 scope and no-go list.

> **The pass/fail rubric.** The brief PASSES only if the peer's answer stays inside your scope - the features in Section 3 and the items NOT in your no-go list. It FAILS if their answer names anything you cut in the no-go list, OR includes 2+ items outside it (your scope is too vague). No peer handy? Paste Section 3 + Section 5 into [Claude](https://claude.ai) or [ChatGPT](https://chatgpt.com) and ask it to name 5 things it would build that are NOT in your no-go list. Same signal, no calendar coordination.

**If this fails: the reviewer names 2+ things outside your no-go list.**
- **Why:** Section 3 is still vague - it names software parts, not moments and results, so the reviewer fills the gaps from training data.
- **Fix:** tighten the *When / I want / So I can* shape on the loosest line and ask a fresh reviewer. Do NOT advance to Module 4 with a failed brief - the Lovable build inherits the fuzziness.

## Artifacts you carry out of Module 3

After Lessons 3.1-3.2 you have five artifacts. Each feeds a specific downstream destination - this is the map:

| Artifact | Where it goes next |
|---|---|
| **One-Page Product Brief / Vibe PRD** (3.1 output) | Lesson 4.1 build-path decision + Lesson 4.3-4.4 Lovable kickoff prompt. The single source of truth Module 4 builds from. |
| **Outcome-shaped feature list** (3.2 rewrite of Section 3 in job-story form) | Lesson 4.1 contractor SOW (Statement of Work - the document that tells a contractor exactly what to build) if you route to hire + Lesson 4.3-4.4 Lovable prompt body. Replaces the noun-shaped feature list that causes overbuild. |
| **No-Go list** (5-8 items cut from 3.1 Section 5) | Lesson 4.3-4.4 self-serve scope guard + Lesson 4.5 ceiling-signal monitoring. |
| **Audience-of-one fork** (AI agent / junior dev / senior team, from 3.1) | Lesson 4.1 build-path routing - decides whether the brief goes to Lovable or a contractor. |
| **Quality-check verdict** (3.2 - did the peer answer cleanly?) | Checkpoint before Module 4. If the peer cannot answer cleanly, return here and rewrite Section 3 first. |

> **Module 3 closes here.** Before opening Module 4 you should have: a one-page Product Brief with 5 sections filled in (3.1), Section 3 rewritten as outcome-shaped job stories that pass the peer test (this lesson), and a no-go list of 5-8 items - all in your `Founder OS` folder. If this lesson saved you a build-and-throwaway round, someone you know is about to hand a builder four vague words too - send them this free course page. Missing an artifact? Go back - Module 4 reads the brief into Lovable prompts, and a half-written brief produces a half-working MVP.

---

> **Done:** every line of Section 3 is rewritten in the *When / I want / So I can* shape, and one quality-check pass (peer, AI, or the manual question) names nothing outside your Section 3 scope and no-go list.
>
> **You have now:** the complete Module 3 output - a one-page Product Brief with an outcome-shaped Section 3, a no-go list of 5-8 items, and a passed quality check, all in your `Founder OS` folder. This is the page Module 4 builds from.
>
> **Next:** [4.1 · Should You Hire? The 2026 Decision Tree](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/) - it reads the brief you just quality-checked as its input.
>
> **If blocked:** see "If this fails" above.
>
> **Deeper reference:** [The second worked pair, the priced-out comparison, the full AI-reviewer protocol, and stack-ranking outcomes with real users](/course/tech-for-non-technical-founders-2026/reference/outcomes-not-features-full/)

---

*See it in action: [Module 3 walkthrough: Mia writes the one-page brief](/course/tech-for-non-technical-founders-2026/module-3-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
