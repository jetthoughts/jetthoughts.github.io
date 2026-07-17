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

> **TL;DR:** Rewrite every feature noun as an outcome-shaped job story. "Build a CSV export" (CSV = a plain spreadsheet file people open in Excel) becomes "When I prepare the weekly report, I want to grab the top 5 metrics in 30 seconds." The engineer has nothing left to invent.

*Skip to the action: [What to do tomorrow](#what-to-do-tomorrow) if you have your Lesson 3.1 brief open and want the rewrite steps now, or jump ahead to [Artifacts you carry out of Module 3](#artifacts-you-carry-out-of-module-3). The examples and the theory will still be here.*

You sent your engineer (or your AI agent) a one-line spec: *"build a simple admin panel."* Ten weeks later you have an admin panel with 47 buttons, role-based permissions, an audit log, and a co-pilot AI assistant. Your engineer isn't a show-off - those four words "a simple admin panel" don't tell anyone what "simple" means, who's using the panel, or what the panel needs to do. The engineer (or the training data) filled in those blanks from every big-company SaaS panel they had ever seen.

You finished Section 3 of your brief in the last lesson, so this page can feel like being asked to write it twice. It is not a rewrite for style - it is the 20-minute check that decides whether the builder ships the three buttons you meant or that 47-button spaceship. The Section 3 you fix here is the exact text Module 4 pastes into Lovable.

![A hand-drawn comparison: the simple three-button admin panel you asked for on the left, the absurdly complex 47-button control deck that got built on the right, connected by a red arrow labeled 10-week build, $15K](admin-panel-spaceship.svg)

## Why feature briefs overbuild

Engineers and AI agents fill vague requests from training data - big-company SaaS panels, GitHub-scraped baselines, the busiest version of whatever they last saw. A feature word in isolation ("CSV export," "user roles") has no anchor to your actual job, so the engineer or agent invents the missing context. An outcome-shaped request ("when I prepare the weekly investor report, I want to grab the top 5 metrics in 30 seconds before the 4pm call") leaves no blanks to fill - the moment, the action, the deadline, and the result are already on the page.

## Two briefs, two shapes each

Same job, two ways to write it. Read each pair out loud. Notice how much the engineer or the agent has to invent under the feature shape, and how little they have to invent under the outcome shape.

![Feature-shaped brief on the left leading to a sketched BI suite bristling with modules; outcome-shaped brief on the right leading to a single 'Copy top 5 metrics' button with a five-row data table](feature-vs-outcome.svg)

### Pair 1 - The CSV button

**Feature shape**: *"Build a CSV export button on the dashboard."*

**Outcome shape**: *"When I prepare the weekly investor report, I want to grab the top 5 metrics in 30 seconds, so I can paste them into the deck before the 4pm call."*

What the engineer builds from the feature shape: a reporting module with three dashboards, scheduled email exports, role-based access on who can export, a date-range picker, custom column selectors, and an audit log of every download. Six weeks of work. You used the CSV button once a week for the investor email and ignored the other eight features.

What the engineer builds from the outcome shape: one button at the bottom of the existing dashboard that says *"Copy top 5 metrics to clipboard,"* hard-coded to MRR (monthly recurring revenue - what subscribers pay you each month), net new MRR, active accounts, trial-to-paid conversion, and runway. Ninety minutes of work in a Rails controller, one line per metric. The next investor email goes out before the deck even opens.

### Pair 2 - The CRM module

**Feature shape**: *"Build a CRM module."* (A CRM - customer relationship management tool - is the contact list and deal tracker a sales team works out of.)

**Outcome shape**: *"When a new customer signs up, the founder needs to see which 3 of our existing customers most resemble them, so we can pattern-match the onboarding playbook that worked for those three."*

What the engineer builds from the feature shape: companies, contacts, deals, pipelines, activities, tasks, notes, custom fields, email integration, calendar integration, and a Kanban board nobody opens. Three months. You used the contacts list and the notes field.

What the engineer builds from the outcome shape: a 30-line script that runs nightly, scores existing customers against the new signup on three attributes (industry, employee count, plan tier), and posts a Slack message every morning: *"New customer Acme Co looks most like Beta Inc, Gamma Ltd, and Delta GmbH - here are their onboarding notes."* Two days. The script is throwaway. When Salesforce is finally worth the bill, you import the script's three matches into the proper CRM record.

## The three-part shape that constrains every spec

Both outcome-shaped briefs in the section above use the same three parts. The shape works because each part forecloses a category of overbuild.

**When [trigger context]** - the specific situation that activates the need. Names the moment, the day, the deadline, the surrounding tools. *"When I prepare the weekly investor report"* tells the engineer this happens once a week, that there is a deck involved, that there is a 4pm call. The engineer will not build a real-time streaming dashboard for something that happens on a Tuesday afternoon.

**I want [internal motivation]** - what you are trying to do, expressed as a verb on a concrete object. *"I want to grab the top 5 metrics in 30 seconds"* is a verb (grab) and an object (the 5 metrics) and a budget (30 seconds). The engineer will not build a 12-metric dashboard because you said 5, and will not build an asynchronous export queue because you said 30 seconds.

**So I can [outcome]** - the business or personal result that proves the build worked. *"So I can paste them into the deck before the 4pm call"* gives a finish line the engineer can hold up against any feature suggestion. The engineer can now say: *"Does the build let you paste into the deck before 4pm? Then we are done. Does the audit log help with that? No? Cut it."*

Put the three parts together and the engineer (or the AI agent) has no gaps left to guess at. Drop any one part - the timeframe, the action, or the outcome - and the gap gets filled in from training data instead of your intent. The same shape has a name in product-management literature; see *Further reading* below if you want to chase the lineage.

The same request, written both ways, priced out:

| | <strong style="color:#cc342d">Feature brief</strong> | <strong style="color:#2e7d32">Outcome brief</strong> |
|---|---|---|
| **What you write** | "Build a CRM module" | "Match new signups to 3 similar customers" |
| **What the team builds** | Companies + contacts, deals + pipelines, email + calendar integration, custom fields + Kanban | A nightly scoring script + a Slack message each morning |
| **What it costs** | 3 months. $40K. | 2 days. $600. |
| **What you actually use** | Contacts + notes | The onboarding playbook, ready Monday |

## What to do tomorrow

Three actions, in order.

- **Open your filled-in [one-page brief](/course/tech-for-non-technical-founders-2026/vibe-prd-template/) from Lesson 3.1.** Find Section 3 ("What you're building"). Read the section out loud. If any sentence leans on a noun-shaped feature ("a CSV button," "a CRM," "user roles," "a settings page"), it is feature-shaped. Mark it.
- **Rewrite each marked sentence in the *When / I want / So I can* shape.** The *when* has to name a specific moment with a deadline, the *I want* has to name a verb and a budget, and the *so I can* has to name a result you can measure that week. Keep the whole section to a single focused pass. If you spill, the section is too big - your one-page brief is trying to be three.
- **Share the rewritten section with your engineer or your AI agent and ask exactly one question**: *"What would you build differently from this brief than you would have built from the feature list?"* Their first answer is the scope you were about to lose. Their second answer is the scope you are about to keep.

> **The pass/fail rubric.** Read the peer's answer. The brief PASSES quality-check only if their answer stays inside your scope - the features in your Section 3 and the items NOT in your no-go list. The brief FAILS if their answer:
>
> - names anything you explicitly cut in your no-go list, OR
> - includes 2+ items outside the no-go list (your scope is too vague).
>
> FAIL = revise Section 3 outcome-shape and ask a fresh peer. Do NOT advance to Module 4 with a failed brief; the Lovable build will inherit the fuzziness.

> **Test your brief with an AI reviewer.**
>
> **No peer available? Use Claude or ChatGPT as the peer.** Paste your full Section 3 + Section 5 (no-go list) into Claude, then paste this prompt:
>
> ```text
> Imagine you are a contractor reading this brief to build the product. Based ONLY on Section 3, name 5 things you would build that are NOT in Section 5's no-go list. Be specific - feature names, not categories.
> ```
>
> If Claude names 2+ items outside your no-go list, the brief failed quality-check the same as a peer flagging them. Revise Section 3 and re-run. This is the same failure signal a peer would surface, with no calendar coordination needed.
>
> **No peer and no AI account?** The manual pass works too: read each Section 3 line and ask, "is this a thing the user does, or a thing the software has?" A line that names software parts (a dashboard, user roles, a settings page) is feature-shaped - rewrite it in the *When / I want / So I can* shape until it names a moment and a result instead.
>
> **What AI cannot prove or substitute:**
> - Whether your scope solves the validated problem (only the Module 4 build + real users can)
> - Whether a real contractor would interpret the brief the same way (AI is a proxy, not a substitute)
>
> **The real gate:** a clean peer QA (human or AI) where the answer stays inside your scope AND no-go list.

The cheap fix for this whole pattern is the rewrite tomorrow morning. The expensive fix is the salvage decision you read after the spaceship lands and investors ask why the demo is so heavy. One focused pass with a marker now spares you the build-and-throwaway later.

**Optional: stack-rank features with real users.** After you have rewritten Section 3 as outcome-shaped job stories, you still have a list. If you need to know which outcome to build first, [OpinionX](https://opinionx.co) (free tier available) uses forced-ranking pairwise voting - users pick A or B, not rate everything "very important." Paste your 5-7 outcome statements, send the link to your Lesson 2.3-2.4 interviewees, and the forced-choice format surfaces real priorities that a 1-10 rating scale hides. The output is a ranked list backed by pairwise win rates, not averaged scores. Use this before handing the brief to Lovable or a contractor - it prevents the "build everything because everything scored 8/10" trap.

## Artifacts you carry out of Module 3

After finishing Lesson 3.1-3.2, you have five artifacts. Each one feeds a specific downstream destination - this table is the map:

| Artifact | Where it goes next |
|---|---|
| **One-Page Product Brief / Vibe PRD** (Lesson 3.1 output) | Lesson 4.1 build-path decision (the brief is the input the worksheet routes against) + Lesson 4.3-4.4 Lovable kickoff prompt. The single source of truth Module 4 builds from. |
| **Outcome-shaped feature list** (Lesson 3.2 rewrite of Section 3 in Job Story format) | Lesson 4.1 contractor SOW (Statement of Work - the document that tells a contractor exactly what to build) if you route to hire + Lesson 4.3-4.4 Lovable prompt body. Replaces the noun-shaped feature list that causes overbuild. |
| **No-Go list** (5-8 items you explicitly cut from Lesson 3.1 Section 5) | Lesson 4.3-4.4 self-serve scope guard + Lesson 4.5 ceiling-signal monitoring. The written "we are not building this yet" line that prevents Module 4 scope creep. |
| **Audience-of-one fork** (the audience choice from Lesson 3.1: AI agent / junior dev / senior team) | Lesson 4.1 Q2 build-path routing. The fork decides whether the brief routes to Lovable (AI agent) or a contractor (junior or senior team). |
| **Quality-check verdict** (Lesson 3.2 - peer answers "what would you build differently?" cleanly?) | Checkpoint before Module 4. If the peer cannot answer cleanly, return to Lesson 3.2 and rewrite Section 3 before opening Lovable or sending the SOW. |

> **Module 3 closes here.** Before opening Module 4, you should have: (1) a one-page Product Brief (Vibe PRD) with 5 sections filled in (Lesson 3.1), (2) Section 3 rewritten as outcome-shaped job stories that pass the peer "what would you build differently?" test (this chapter), and (3) a no-go list of 5-8 items you explicitly cut. Both in your `Founder OS` folder. Missing one? Go back - Module 4 reads the brief into Lovable prompts; a half-written brief produces a half-working MVP.

When your brief skips the moment, the action, and the result, the engineer or the AI agent fills them in from training data. Name all three in every line of Section 3, and the builder builds only what you asked for.

## Further reading

- Alan Klement, [*When Coffee and Kale Compete*](https://web.archive.org/web/20230319130354/https://www.whencoffeeandkalecompete.com/) - the book that introduced the *When / I want / So I can* shape under the name "Job Stories" in 2013. The framework is worth chasing once your team is bigger than two; the shape is worth using tomorrow.
- Marty Cagan, [Product vs Feature Teams](https://www.svpg.com/product-vs-feature-teams/) - the canonical essay on why product teams (chartered with outcomes) ship better than feature teams (chartered with feature lists).
- Veracode, [GenAI Code Security Report 2025](https://www.veracode.com/blog/genai-code-security-report/) - 45% of LLM-generated code shipped at least one exploitable security flaw. Vague briefs amplify the rate.
- DHH, [The One Person Framework](https://world.hey.com/dhh/the-one-person-framework-711e6318) - the Rails case for keeping the architecture small enough that one developer can ship outcomes end-to-end.
- Basecamp / Ryan Singer, [Shape Up - Appetite vs Estimate](https://basecamp.com/shapeup/1.2-chapter-03) - the chapter on writing pitches that fix the appetite first, so the build collapses to fit.
- Tom Kerwin, [JTBD Job Stories vs User Stories](https://web.archive.org/web/20240819160036/https://jtbd.info/replacing-the-user-story-with-the-job-story-af7cdee10c27) - the 2013 Klement piece on Medium that popularised the shape, for readers who want the original 1,500 words.
- Y Combinator, [Startup School: How to Write a Product Spec](https://www.ycombinator.com/library/) - YC's distilled take on specs that ship versus specs that sit.

> **Done:** every line of Section 3 is rewritten in the *When / I want / So I can* shape, and one quality-check pass (peer, AI, or the manual question) names nothing outside your Section 3 scope and no-go list.
>
> **You have now:** the complete Module 3 output - a one-page Product Brief with an outcome-shaped Section 3, a no-go list of 5-8 items, and a passed quality check, all in your `Founder OS` folder. This is the page Module 4 builds from.
>
> **Next:** [4.1 · Should You Hire? The 2026 Decision Tree](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/) - it reads the brief you just quality-checked as its input.
> **If blocked:** If Claude names 2+ items outside your no-go list when you run the quality-check prompt, your Section 3 is still too vague. Tighten the "When / I want / So I can" shape until Claude's answer stays inside your scope.

> **Stuck here?** Every feature in Section 3 looks equally important, so the list keeps growing. **Fix:** pick the ONE outcome that would make a real customer pay or stay. Build that. Cut the rest to the no-go list. You can add them back after the first pilot in Module 5.

---

*See it in action: [Module 3 walkthrough: Mia writes the one-page brief](/course/tech-for-non-technical-founders-2026/module-3-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
