---
title: "Salvage vs Rebuild: 6-Question Decision Tree"
aliases: ["/course/tech-for-non-technical-founders-2026/salvage-vs-rebuild-decision-tree/"]
description: "A 30-minute structured decision that ends two weeks of analysis paralysis. KEEP / FREEZE / REBUILD with a 30/60/90 day plan."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: salvage-vs-rebuild-decision-tree
keywords:
  - salvage rebuild software project
  - founder rescue decision tree
  - codebase salvage decision
  - rebuild or refactor founder
  - tech debt decision framework
tags:
  - founders
  - non-technical-founder
  - template
  - course-companion
  - rescue
categories: ["Templates"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/salvage-vs-rebuild-decision-tree/"
related_posts: false
---

📋 Template companion to the "When Things Break" path of the [Tech for Non-Technical Founders 2026 course](/course/tech-for-non-technical-founders-2026/). Run alone Friday afternoon. Send the score to one independent reviewer for a paid 30-minute call.

# The Salvage vs Rebuild Decision Tree

A 30-minute decision that ends two weeks of analysis paralysis and gives you a defensible verdict by Friday night.

By Sunday morning you will know whether to KEEP your codebase, FREEZE it for 60 days while you stabilize, or REBUILD the two or three flows that carry your business. You will not have read a line of code. You will have answered six yes/no questions in a Notion doc and sent the score to one independent reviewer for a 30-minute paid second opinion.

## Why this exists

A founder we picked up in late 2025 had spent **$95K and fourteen months** with the previous shop on a marketplace app for home-service contractors. The codebase was about **38,000 lines of Ruby on Rails** with **0% test coverage**, no staging environment, and an auth flow that had been reimplemented three times in three years. None of the three had been deleted. Two were still wired into different login URLs.

She had spent nine weeks asking three different consultants whether to keep, rewrite, or do something in between. Every consultant gave a different answer. Every answer cost $1,500 to $4,000. She ran the six questions below in one Friday afternoon, scored a 2 out of 6, and had a paid 30-minute review confirming a 30/60/90 day REBUILD-the-core-paths plan by the following Wednesday. The paralysis was the expensive part. The decision was 30 minutes.

## How to use it

Run this **alone, on a Friday afternoon**. Do not invite the team. If something fails, you want to know before the conversation, not during it.

Bring five things: the latest code-health note from your new lead engineer or fractional CTO (a thumbs-up or thumbs-down counts), the bug backlog count, the test coverage percentage if anyone tracks it (write `0` if nobody does), the AWS or Heroku bill trend over the last six months, and the original SOW. Open a fresh Notion doc.

For each question, write the answer + the score (0 or 1) + one sentence of evidence. The whole exercise should take 30 minutes. Send the doc to ONE independent reviewer (not the team that wrote the code, not the agency you are about to hire) for a 30-minute paid second opinion before you commit.

## The six questions

Score each question 1 or 0 and write one sentence of evidence next to it. The whole grid takes 30 minutes.

| # | Question | Score 1 if | Score 0 if |
|---|---|---|---|
| Q1 | **Bus factor** - is more than one person able to deploy the production app and restart it without help today? | Two or more humans can deploy independently. | One person, or that person left in the last six months. |
| Q2 | **Test coverage signal** - does the team have any automated tests that run before a deploy? Even 10% with a green CI counts. | `bundle exec rspec` (or the equivalent) runs in CI and the build is green more days than red. | Testing is manual, there is no CI, or the build has been red for more than two weeks. |
| Q3 | **Database health** - can you restore last night's production database to a fresh staging environment in under four hours, with someone you can call tonight? | Backups run nightly, the last seven are visible in your provider's console, and someone has a one-page restore runbook. | "We have backups but I have never tested a restore" - same as no backups. |
| Q4 | **Architecture sanity** - can you list the top three external services your app depends on (e.g. Postgres, Redis, Stripe) and explain in one sentence what breaks if each goes down? | You can write three sentences without help. | The answer is "I don't know, the team handles that." A founder who cannot list the top three cannot triage an outage. |
| Q5 | **Onboarding time** - if you hired a senior engineer Monday morning, would they ship one real pull request to staging by Friday? | There is a written README that gets a developer from `git clone` to a running local app in under two hours. | Onboarding needs "let me get on a call and walk you through it" - that is a knowledge silo, not a codebase. |
| Q6 | **Customer signal** - are real users (not your team, not your investors, not friends doing favors) using the app every week, in volume that materially affects your business? | You can name 10+ paying or actively engaged weekly users by handle or company. | Usage is mostly the team and a few pilot accounts who have not logged in this month. |

## The verdict

Add up the scores.

| Score | Verdict | What you do next |
|---|---|---|
| **5-6** | **KEEP and harden.** | The codebase is salvageable. Spend the rebuild budget you were about to write a check for on test coverage, monitoring, and one senior hire. Do not rewrite. |
| **3-4** | **FREEZE and stabilize.** | No new features for 30 to 60 days. One sprint on access ownership (run the [GitHub / AWS / database checklist](/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/)), one sprint on adding tests around the top three flows, one sprint on monitoring and backups. Re-score in 60 days. If you climb to 5+, you keep. If you stay at 3-4, you rebuild the core paths. |
| **0-2** | **REBUILD core paths.** | Not a full rewrite. Identify the two or three highest-traffic flows (signup, checkout, the one core action your users repeat) and rebuild THOSE on a parallel codebase. Migrate users behind a feature flag. Keep the legacy system running for everything else for 90 days, then sunset it one flow at a time. |

A score of 0 is not a "burn it down" verdict. The legacy code keeps running while you carve out the parts that matter and rebuild them with tests, monitoring, and one engineer who owns them.

## What good looks like vs what bad looks like

### Treating the score as a verdict on you, not the codebase

> Bad: "I scored a 1. I picked the wrong team. This is my fault."
> Good: "I scored a 1. The previous shop shipped without tests, monitoring, or backups. That is triage data."

Most founders we rescue scored a 2 or 3 the first time they ran something like this. The score points at the next sprint, not at the mirror.

### Conflating REBUILD with FULL REWRITE

> Bad: "We scored a 1, so we are throwing everything away and starting fresh in Next.js."
> Good: "We scored a 1. Signup, checkout, and the contractor-match screen carry 80% of our revenue. We rebuild those three flows on a parallel codebase, ship behind a feature flag, and keep the legacy admin panel running for nine more months."

Joel Spolsky called the full-rewrite trap "[the single worst strategic mistake](https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/) any software company can make" in 2000, and the math has not changed. A full rewrite buys you a 12 to 18 month feature freeze in exchange for a new codebase with its own undiscovered bugs. REBUILD in the verdict above means the two or three flows that carry the business, not the whole repo.

### Skipping the independent reviewer because "we cannot afford a consultant"

> Bad: "I will run this myself. A 30-minute review costs $400 and I am already over budget."
> Good: "I scored a 2. I am sending the doc to one fractional CTO for a $400 review on Monday, before I sign anything else."

The founder in the opening story spent $7,500 on three consultants over nine weeks asking the same question three different ways. One 30-minute paid review by someone who is not selling you the rebuild costs less than $500 and resolves it in a week.

## What to do after

- **Send the verdict + the six scores to your independent reviewer** for a 30-minute paid call. Ask one question: "Is there anything in this score I am misreading?"
- **Draft the 30/60/90 day plan in plain English.** KEEP looks like "hire one senior engineer, raise test coverage to 40% by day 90, set up monitoring." FREEZE looks like "no new features for 60 days, three sprints on stabilization, re-score on day 60." REBUILD looks like "two parallel codebases, feature flag, sunset the old one flow at a time."
- **Forward the verdict to your investor or board the same week.** Three lines: the score, the verdict, the plan. Founders who do this keep the trust they have spent 18 months building.

If the verdict is FREEZE or REBUILD and the previous team is still around, the next two reads are the [dev shop red flags checklist](/blog/dev-shop-red-flags-checklist/) and the [step-by-step exit guide](/blog/fire-dev-shop-guide/). If the verdict is KEEP, run the [ownership checklist](/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/) the same Friday to confirm you actually own what you just decided to harden.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/course/tech-for-non-technical-founders-2026/) curriculum.*
