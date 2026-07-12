---
title: "The Org Chart Your Dev Shop Won't Draw"
aliases: ["/blog/engineering-org-chart-non-technical-founder/"]
description: "The 5-person team your agency pitched is rarely the team writing your code. Six questions to surface who actually ships, who reviews, and who is on-call."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: engineering-org-chart-non-technical-founder
keywords:
  - engineering team structure for founders
  - dev shop team size
  - who reviews pull requests
  - engineering team org chart
  - fractional CTO
tags:
  - founders
  - non-technical-founder
  - tech-literacy
  - dev-shop-management
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "The Org Chart Your Dev Shop Won't Draw"
  og_description: "The 5-person team your agency pitched is rarely the team writing your code. Six questions to surface who actually ships, who reviews, and who is on-call."
cover_image_alt: "JetThoughts blog cover showing a redacted org chart with question marks over four boxes and one named senior reviewer"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/engineering-org-chart-non-technical-founder/"
related_posts: false
course_nav: false
---

> **Going Further · Manage a Hired Team** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a team in place + a signed SOW
>
> **Output:** a weekly oversight rhythm running by month 3
>
**Supplementary content.** This chapter assumes you have a hired team. If you're still on the [self-serve path](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/), bookmark this and return when you graduate to a hired team.
>
> **Read this if**: you've signed an SOW with a dev shop OR you're paying for "a team of N" without seeing the GitHub handles of who reviews your PRs each week.

Marina, a FinTech founder we picked up in Q1 2026, had been billing **$44K a month for "a team of four."** Three months in, her new fractional CTO asked who had written the last twelve pull requests. The answer: one senior reviewer who signed off most weeks, two mid-level shippers, and three rotating juniors paid by a sub-contracted shop she had never heard of. She had been paying senior rates for code one junior wrote and another junior reviewed.

The agency had not lied, exactly. The kickoff deck just did not say which names touched the repo on which weeks, who reviewed whose pull requests, or who picked up the phone at 2am when production was down.

## What an org chart hides

The vibe-coding wave made the org chart even fuzzier. Agencies that pitch "AI-augmented teams" route work through three layers: a senior who runs the demo, a mid-level who prompts Cursor or Claude Code, and a junior who reviews whatever falls out. The labor cost dropped; the bill rate did not. [TechTIQ Solutions' 2026 staff augmentation report](https://techtiqsolutions.com/it-staff-augmentation-cost-breakdown-and-pricing-models/) flags that hidden costs add 15-30% on top of base rates, with 10-18% already going to vendor margin. The shops we rescue in 2026 are charging the same and paying less, with the gap going to subcontracted juniors and AI tooling the founder never approved as a line item.

**What the kickoff deck said vs who actually shipped your PRs:**

| Slot on the slide | Kickoff deck (what you bought) | Reality on the PRs (what you got) |
|-------------------|-------------------------------|-----------------------------------|
| 1 | Senior Dev / Tech Lead - "available for architecture calls" | Senior Dev - 1-2 days/week, 3 other clients, signs off most weeks |
| 2 | Mid-level Engineer - "daily shipper" | Mid Engineer - full-time, writes 60% of code |
| 3 | Mid-level Engineer - "daily shipper" | Mid Engineer - part-time, writes 30% of code, on another client most weeks |
| 4 | Junior Engineer - "in mentorship" | Subcontracted Junior #1 - from a partner shop you never met |
| 5 | PM (1/4 allocation) - "runs your standups" | Subcontracted Juniors #2, #3 - rotating, AI-augmented, no Slack handle in your repo |
| **Bill rate** | **$44K / month** | Same. Senior rate paid, junior work delivered |

Same five seats. Different five humans. Ask the six questions below to learn which side of this chart you're on.

## The five-person team your shop pitched

The kickoff deck almost always shows a tidy stack. From the top:

- **One senior dev or "tech lead."** Usually the salesperson on calls. Strong on architecture conversations, weak on weekly availability. Their actual job is to win the next contract.
- **One or two mid-level engineers.** The daily shippers. They write most of the code that ends up in your repo and run the standup when the lead is busy on another pitch.
- **One or two juniors.** Often AI-augmented now. In a healthy shop they are paired with the mid-levels and grow into them. In an unhealthy shop they ship straight to your main branch with one rubber-stamp review.
- **A quarter of a project manager.** Shared across three or four projects. Their Slack is yours on Mondays and Wednesdays, gone the rest of the week.
- **A tenth of a CTO.** The founder of the agency, "available for escalation," which means available if you escalate loudly enough.

That is a 4.35-person team on the spreadsheet, billed as five. The Rails version works when the senior actually reviews - she catches the `before_action` that bypasses auth, the missing Sidekiq retry, the migration that locks the orders table. It collapses when the senior is on three other projects and the juniors are reviewing each other. [Our MVP team-structure note](/blog/our-mvp-team-structure-startup-management/) describes the alternative: two full-stack developers and one frontend, with a product owner in your meetings, not three others'.

## The questions that surface the real org chart

These six questions belong in your next status call. Ask them in this order. Watch which ones the team answers fast and which ones get a "let me get back to you."

### 1. "Who specifically reviewed the last five pull requests on my repo? Name them."

A healthy answer names two or three humans whose handles you can find in GitHub. A failing answer is a role ("the senior team"). One reviewer for all five means single point of failure; five different reviewers means no consistent owner. [Will Larson at Carta](https://review.firstround.com/unexpected-anti-patterns-for-engineering-leaders-lessons-from-stripe-uber-carta/) treats the pull request funnel as the load-bearing signal for engineering health. Founders should too.

### 2. "How many other clients does that reviewer have this week?"

A senior carrying three other projects gives your PRs about fifteen minutes each. That is enough to skim a diff and click approve. It is not enough to catch the auth regression or the N+1 query in the dashboard endpoint. JT's [60-day playbook for slow teams](/blog/fixing-slow-engineering-teams-an-extended/) starts by figuring out where the senior's attention actually is.

![PR reviewer attention math: senior's week split across 4 clients at 25% each leaves 10 hours on your repo, divided by ~40 PRs per week, equals 15 minutes per PR; what 15 minutes catches versus what it misses including auth regressions, N+1 queries, hardcoded Stripe secrets, dropped test coverage, and locking migrations](reviewer-attention.svg)

### 3. "Is anyone on my project subcontracted - paid by you but employed elsewhere?"

Ask flat. Watch the pause. [DataToBiz describes the practice plainly](https://www.datatobiz.com/blog/subcontracting-in-it-staff-augmentation/): the agency you signed with can route work through a partner shop you never met. Subcontracting is not automatically bad - the question is whether you knew. If your contract does not say "no subcontracting without written approval," it can happen and probably is.

### 4. "Who is on-call if production breaks at midnight, and what is the handoff?"

A shop with a real on-call rotation can tell you the schedule, the escalation path, and the SLA in under a minute. Without one, you get "best effort" coverage - which means your senior sees the Sentry email when she opens her laptop on Monday. [Team Coherence on code ownership and accountability](https://www.teamcoherence.com/code-ownership-and-accountability/) makes the point: ownership without a named person is not ownership. JT's [remote team accountability writeup](/blog/remote-team-accountability-non-technical-founders/) covers the same ground in plain English.

### 5. "If your senior reviewer quits Friday, who replaces them on my project Monday?"

A real answer names a person, their familiarity with your repo, and their existing client load. "We have bench depth" means the agency will scramble and you will pay for the scramble in slower velocity and missed reviews. This is the question covered in [our 15-minute engineering team health check](/blog/how-to-assess-engineering-team-health-15-minutes-non-technical-founder/).

### 6. "Walk me through one PR from last week. Who wrote it, who reviewed it, what they checked."

This catches what the first five missed. A team that ships well can replay a PR in a minute: "Marcos opened a 40-line change in the `OrdersController`, Priya pushed back on the missing test for the refund branch, Marcos added the test, she approved, CI went green, we merged at 3pm Wednesday." A team that does not ship well will describe a process instead of a transaction. JT's note on [small PRs as the unit of team productivity](/blog/how-small-pr-improves-team-productivity-development/) explains why the transaction is the trust signal; if your team cannot point at one, the unit does not exist.

Run the six on your next status call, in order. Every answer in the right column is a flag:

| Question, in order | Healthy answer | Red-flag answer = 1 flag |
|---|---|---|
| 1. Who reviewed the last 5 PRs? | Named humans | "the senior team" - single point of failure or no clear owner |
| 2. How many other clients this week? | 1-2 | 3+ - 15 min per PR means skim and approve |
| 3. Anyone subcontracted? | No, all in-house | Pause / "sometimes" - hidden labor layer at junior rate, senior bill |
| 4. On-call for midnight outages? | Named rotation + SLA | "Best effort" - Sentry hits Monday morning, not Tuesday at 3am |
| 5. Senior quits Friday - who replaces by Monday? | Named person, familiar with your repo | "We have bench depth" - you will pay for the scramble |
| 6. Walk me through one PR from last week | Replays it in 60 seconds | Describes a process, not a transaction - the unit of trust is missing |

**Zero to two flags**: the real org chart is visible - continue with the team. **Three or more flags fire**: time to audit your team - cross-check PRs, the AWS bill, and the names on commits.

## What to do tomorrow

Email your agency tonight. One line: "Please send me the current org chart with names, roles, and FTE allocation for everyone touching my code this month. Include any subcontracted resources." Forward the response to your fractional CTO or developer-friend - if you do not have one, [our note on fractional CTO ROI](/blog/fractional-cto-vs-full-time-cto-complete-comparison-2025/) explains the shape. Cross-check against [our dev-shop red flags checklist](/blog/dev-shop-red-flags-checklist/) and the [non-technical founder checklist](/blog/checklist-for-non-tech-founder-agile/). If the reply has fewer named humans than the kickoff deck promised, the deck was the pitch and the reply is the truth.

## When the org chart shows you've got a problem

If the answers came back vague, contradictory, or missing, that is the signal. The fix is putting numbers next to the names before the next agency conversation: how many PRs each reviewer touched last month, how many days the senior was actually on your project, which juniors shipped which features. Cross-reference the [eight red flags checklist](/blog/dev-shop-red-flags-checklist/) and the [15-minute team-health assessment](/blog/how-to-assess-engineering-team-health-15-minutes-non-technical-founder/) to know what good looks like.

## Further reading

- DHH, [The One Person Framework](https://world.hey.com/dhh/the-one-person-framework-711e6318) - the Rails case for shipping with a small team.
- DHH, [The Majestic Monolith](https://signalvnoise.com/svn3/the-majestic-monolith/) - why Basecamp ran on one codebase since 2003.
- AWS Executive Insights, [Amazon's Two-Pizza Teams](https://aws.amazon.com/executive-insights/content/amazon-two-pizza-team/) - Bezos' rule on team size and what it actually optimised for.
- Jason Yip, [My critique of "the Spotify Model"](https://jchyip.medium.com/my-critique-of-the-spotify-model-part-1-197d335ef7af) - an ex-Spotify coach explaining what the model is and is not.
- Agile Pain Relief, [The Spotify Model of Scaling - Spotify doesn't use it, neither should you](https://agilepainrelief.com/blog/the-spotify-model-of-scaling-spotify-doesnt-use-it-neither-should-you/) - the broader agile-community position on cargo-culted squad structures.
- Will Larson (interviewed by First Round Review), [Engineering leadership anti-patterns from Stripe, Uber, Carta](https://review.firstround.com/unexpected-anti-patterns-for-engineering-leaders-lessons-from-stripe-uber-carta/) - on review processes and the PR funnel as the productivity signal.
- TechTIQ Solutions, [IT Staff Augmentation Cost Breakdown 2026](https://techtiqsolutions.com/it-staff-augmentation-cost-breakdown-and-pricing-models/) - hidden costs of staff-augmented teams.
- DataToBiz, [The Strategic Advantage of Subcontracting in IT Staff Augmentation](https://www.datatobiz.com/blog/subcontracting-in-it-staff-augmentation/) - plain description of the subcontracting layers founders rarely see.

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
