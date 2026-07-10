---
title: "6.5 · The Plain-English Weekly Dev Report"
aliases: ["/blog/weekly-dev-report-template-founders/"]
description: "A one-page weekly dev report you demand from your team every Monday. Five sections, copy-paste, with pass/fail examples for each. No jargon."
date: 2026-05-18
course_chapter: true
author: "JetThoughts Team"
slug: weekly-dev-report-template-founders
keywords:
  - weekly dev report template
  - non-technical founder weekly report
  - dev team weekly status email
  - founder Monday review template
  - what to ask for weekly from dev team
tags:
  - founders
  - non-technical-founder
  - course-companion
  - oversight
  - template
categories: ["Founders"]
related_posts: false
course_nav: false
cover_image: cover.png
metatags:
  og_title: "6.5 · The Plain-English Weekly Dev Report"
  og_description: "A one-page weekly dev report you demand from your team every Monday. Five sections, copy-paste, with pass/fail examples for each. No jargon."
cover_image_alt: "JetThoughts blog cover for The Plain-English Weekly Dev Report showing two side-by-side email screenshots - a wall of jargon on the left and a one-page five-section report on the right"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/weekly-dev-report-template-founders/"
---

> **Going Further · Manage a Hired Team** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a team in place + Friday demos running
>
> **Output:** a one-page weekly report template you demand from your team every Monday

**Supplementary content.** This chapter assumes you have a hired team. If you're still on the [self-serve path](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/), bookmark this and return when you graduate to a hired team.

Open your inbox on a Monday morning. Two reports landed over the weekend from two different teams.

The first is 1,840 words long. It opens with "We made significant progress on the v2 architecture refactor and dependency hardening this sprint, prioritising long-term maintainability." There are seven Jira screenshots, a burndown chart, and a paragraph titled "Tech debt remediation." Nowhere in the report can you find a URL you can click. You read it twice. You still cannot say what shipped.

The second is one page. The first line is a staging URL. The second line says "co flow is live; here is a $1 test charge that hit your Stripe dashboard at 14:02 UTC." The third line names two things the team cut to ship that. The fourth line names one person blocking one decision and the answer she needs from you by Wednesday. The fifth line says "next week we are worried about the migration; it locks the orders table and we want a 6am window."

Both teams worked the same five days, and the second report gave you everything you needed to run your Monday while the first burned half an hour of it.

## Why weekly reports usually fail

The weekly report habit gets inherited from whichever PM the agency assigned in week one. The PM was trained to write status reports for an enterprise customer who wanted comfort: lots of words, a velocity chart, a RAG indicator that has been amber for six months. The format survived because nobody on the agency side had to read it. You did.

The vibe-coding wave made the prose worse, not better. The same PM now pastes the standup transcripts into a long-context model and asks for "an executive summary suitable for the founder." What you get back is a wall of soft language - "exploring," "optimising," "iterating on" - assembled out of whatever the team said in standup, with no signal about whether anything reached a place you can click. [Atlassian's writeup of weekly status reporting](https://www.atlassian.com/work-management/project-management/status-reports) makes the point flat: a status report that does not link to working software is theatre, regardless of how cleanly it is formatted.

The fix is not a new tool. The fix is a one-page format with five non-negotiable sections, each producing a fact you can verify in under a minute. The five sections below are it.

![Side-by-side comparison: jargon-wall report vs. five-section one-page report. Left panel is a 1,840-word document with corporate-speak phrases like 'leveraging best practices' redacted. Right panel is a clean one-page report with five labelled rows: Shipped, In review, Blocked, Cut, Concern. Both report on the same five working days.](report-comparison.svg)

## The five-section template (copy this into your Monday email)

Send this to your tech lead Sunday night or first-thing Monday. Frame it as the format you need - not a request for "more detail."

> Starting next Monday, please send your weekly report in this format. One page, five sections, in this order. Send by 9am UK time on Monday so I can read it before our 11am call.
>
> **1. What shipped this week.** One line per shipped feature. Each line must include the staging or production URL I can click, the test login if it is gated, and one sentence on what the user can now do. Example: `staging.acme.app/co/v2 - login: founder@test.com / demo1234 - users can now apply a discount code at checkout.` If nothing shipped, write "Nothing shipped this week" and skip to section 2. Do not pad.
>
> **2. What is in review but not shipped.** One line per open pull request. Include the PR number, the author, the named reviewer, the date the review was requested, and what is holding it up. Example: `PR #847 - Marcos opened Tue, Priya reviewing, two changes requested Wed evening - waiting on author.` If nobody reviewed it, name that.
>
> **3. What is blocked, and on whom.** One line per blocked item. Name the person, the answer they need, and the deadline they need it by. If I am the blocker, list me first. Example: `Stripe live keys - waiting on you - need them by Wed end-of-day or the launch slips to next week.`
>
> **4. What we cut to ship that.** One line per item we descoped, postponed, or simplified. Include the reason. Example: `Cut the admin override screen - users do not need it for v1; will handle plan changes via Postgres console for the first month.` If nothing was cut, write "Nothing was cut" and we will talk about that on the call.
>
> **5. One concern for next week.** One sentence. Not a status update; the actual thing keeping you awake. Example: `Next week we deploy the migration that locks the orders table - we want a 6am window so no live customer hits a 30-second timeout.`
>
> Hard rules: one page, no Jira screenshots, no burndown charts, no executive summary paragraph at the top. The five sections are the report. Plain text in the email body, not a PDF attachment.

Do not soften the wording when you send it. "Would be nice to have" gets you the old format with two new bullets. "This is the format I need each week" gets you the format.

### The weekly oversight loop

The weekly oversight loop in one glance:

1. **Mon 9am** - Report lands in your inbox. Read in 90 sec, click one staging URL, note one blocker on you.
2. **Mon 11am** - Call with the team. Discuss the cuts, unblock yourself fast.
3. **Tue-Thu** - Team ships. You stay out.
4. **Fri 4pm** - 15-min demo. Click what shipped (see the [Friday Demo Template](/course/tech-for-non-technical-founders-2026/friday-demo-template/)).
5. **Weekend** - Team writes next week's report.
6. **Mon 9am (next week)** - Loop closes; the next report lands.

The cadence is closed-loop on purpose. Monday's report tells you what happened last week and what to unblock this week. Friday's demo (covered in [the Friday Demo Template](/course/tech-for-non-technical-founders-2026/friday-demo-template/)) shows you the working software. Without Monday's report you walk into the demo blind. Without the demo, Monday's report is a prose exercise. The two pieces fit together.

![The five sections of the weekly report visualised as five labelled boxes stacked top-to-bottom on a single page. Box 1 (green): Shipped - staging URL + test login. Box 2 (yellow): In review - PR number + reviewer name. Box 3 (red): Blocked - named person + deadline. Box 4 (blue): Cut - what got descoped + why. Box 5 (purple): Concern - one sentence on next week's risk. Each box is sized to fit one or two lines of text, total fits on one A4 page.](five-sections.svg)

## What good looks like vs. what bad looks like

Two reports on the same week of work. Same team. Same backlog. Different formats.

### Bad report (1,840 words, no clickable URL)

> *Subject: Weekly Status Report - Sprint 12*
>
> Team made significant progress this sprint on architectural improvements and tech debt reduction. We continued to iterate on the v2 checkout flow, exploring options for the discount-code feature and aligning on best practices for the underlying data model. Velocity remained steady at 34 points (vs. 32 last sprint). The team participated in three architecture workshops to ensure long-term maintainability. RAG status: Amber. We are tracking three risks around third-party dependencies and will provide a deeper writeup in next week's report. PR throughput remained healthy.
>
> *(eight more paragraphs in the same register; three Jira screenshots; one burndown chart; no URL anywhere in the email; one mention of "the team" with no names)*

You finish reading at 9:18am. You cannot tell what shipped, who reviewed what, or what you need to decide before Wednesday. The report orients nobody.

### Good report (one page, five sections)

> *Subject: Weekly report - week of 5 Oct*
>
> **1. Shipped:**
> - `staging.acme.app/co/v2` - discount-code field is live; test code `LAUNCH10` gives 10% off; webhook to Stripe fires correctly. Login: `founder@test.com / demo1234`.
> - `staging.acme.app/account/email` - email change flow now sends confirmation and reverts on link expiry.
>
> **2. In review:**
> - PR #847 (admin search) - Marcos, Priya reviewing since Tue; two changes requested Wed evening; waiting on author.
> - PR #851 (rate limiting on signup) - Marcos, no reviewer yet because Priya is on PTO Thu-Fri; will assign Mon.
>
> **3. Blocked:**
> - Stripe live keys - waiting on you - need them by Wed end-of-day or the launch slips a week.
> - Decision on whether the discount-code field accepts free-text or dropdown only - waiting on you - need it by Tue afternoon.
>
> **4. Cut:**
> - Admin override for plan changes - users do not need it for v1; we will handle plan edits in the Postgres console for the first month.
> - Date-range picker on the dashboard - v1 spec only needs last-30-days; saved roughly two days.
>
> **5. Concern for next week:**
> - We deploy the orders-table migration on Wed; it locks the table for ~30 seconds. We want a 6am UK window so no live customer hits a timeout.

Same five days of work. You finish reading at 9:02am. You know what shipped, what is in review, what you owe the team by Wednesday, what was traded off, and what to flag on Wednesday's call. You can spend the rest of Monday on the work that needs you - not on parsing a status doc.

The bad report leans on soft verbs, passive voice, and unnamed actors because it has no clickable URL to anchor anything specific. If yours would not survive being read out loud at a board meeting, the team is sending you the wrong format.

## What to do tomorrow

**1. Forward this post to your tech lead with one line in the body.** "Starting next Monday I need the weekly report in this format. Five sections, one page, plain text in the email." Do not edit the template. Do not add a sixth section. The five sections are the report.

**2. Block 9:00 to 9:15 on Monday morning to read it.** If the report does not arrive by 9am, send one line: "Where is the weekly report?" Hold the slot. The first two Mondays will feel awkward; by week three the team will have it ready Friday afternoon and you will read it over coffee.

**3. Save the first four reports in a folder.** After four weeks, scroll through them. Three things should be true: every Shipped section names a URL you actually clicked; the Blocked section lists you by name at least once; the Concern section flagged something that came true at least once. If none of those three things happen, the format is being filled in but not used. Read [the three standup questions](/course/tech-for-non-technical-founders-2026/three-questions-turn-standup-into-proof/) and [the eight red flags checklist](/blog/dev-shop-red-flags-checklist/) - the problem is upstream of the report.

## Further reading

- Atlassian, [How to Write an Effective Project Status Report](https://www.atlassian.com/work-management/project-management/status-reports) - the canonical reference on what status reports are for and where they fail.
- DHH, [The One Person Framework](https://world.hey.com/dhh/the-one-person-framework-711e6318) - the Rails case for one full-stack developer shipping a feature end-to-end, which is why the five-section report fits on one page.
- Marty Cagan, [Product Status Reports](https://www.svpg.com/product-status-reports/) - on why traditional status reports tell you nothing about whether the product is moving and what to ask for instead.
- Will Larson via First Round Review, [Engineering leadership anti-patterns from Stripe, Uber, Carta](https://review.firstround.com/unexpected-anti-patterns-for-engineering-leaders-lessons-from-stripe-uber-carta/) - on the pull request funnel as the load-bearing signal in any status format.
- Wes Kao, [How to Write a Great Status Update](https://newsletter.weskao.com/p/great-status-update) - a practitioner reference on the discipline of writing one short, useful update a week.
- Eric Ries via Lean Startup Co., [What Is an MVP?](https://leanstartup.co/resources/articles/what-is-an-mvp/) - the validated-learning framing that makes "what did we cut?" a real product question, not a comfort question.

Built by JetThoughts as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum. Authorship credit only - no service pitch.
