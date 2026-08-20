---
title: "What SLAs to Require From Your Dev Shop"
description: "Five SLA requirements for your dev shop contract: response times, fix windows, uptime, a definition of done, and a penalty clause that actually bites."
date: 2026-07-31
draft: false
author: "JetThoughts Team"
slug: "dev-shop-sla-requirements-checklist"
keywords: "software development SLA requirements, dev shop service level agreement, software vendor SLA checklist"
tags: ["startup", "founder", "dev-agency", "sla", "outsourcing"]
categories: ["Startup"]
canonical_url: "https://jetthoughts.com/blog/dev-shop-sla-requirements-checklist/"
og_title: "What SLAs to Require From Your Dev Shop"
og_description: "Five SLA requirements for your dev shop contract: response times, fix windows, uptime, a definition of done, and a penalty clause that actually bites."
cover_image: cover.png
metatags:
  image: cover.png
cover_image_alt: "Dark JetThoughts cover reading Five SLAs / To Require, with chips for response hours, uptime math, and a penalty clause"
related_posts: false
---

Your dev shop has no SLA. That means they have no obligation to fix anything, ever - at least not on any timeline a lawyer could point to.

Harsh? Pull up your agreement and check. An SLA (service level agreement) is the part of a contract that puts numbers on the service: how fast the team answers when something breaks, how fast they fix it, and - once you have users - how often the app stays up. Most first-time founder contracts skip all of that and promise "commercially reasonable efforts" instead.

Here are the five software development SLA requirements worth writing into your next agreement. For each one: the clause in plain English, a fair number to ask for, and the loophole shops use to slide out of it.

## First, measure the service you're getting now

Search your email and Slack for the last five bugs you reported to your team. Note two timestamps for each: when you hit send, and when a human replied with something substantive - what's broken, how bad it is, when a fix lands. "Thanks, we'll look into it" doesn't count as a reply.

That gap, averaged across five reports, is your real response time, and nobody at the agency can argue with your own inbox. If the average is twenty minutes, relax; you may only need to write down what's already happening. If it's three days, you now have a number to open the negotiation with instead of a feeling.

Keep the five examples handy. You'll want them in the room when the sales lead says "we always respond quickly." And if the replies you measured have said "making progress" three weeks running, you may have a bigger problem than paperwork - the [eight red flags checklist](/blog/dev-shop-red-flags-checklist/) covers that diagnosis.

## Requirement 1: first response in hours, split by severity

The clause you want reads something like:

> "Severity 1 incidents receive a first response from an engineer within 2 business hours. Severity 2 within 8 business hours. Severity 3 within 2 business days."

A severity level is just a ranking of how bad the problem is: level 1 means the app is down or customers can't pay you, level 2 means a feature is broken but users can work around it, and level 3 covers typos and cosmetic glitches. Atlassian publishes a plain-English [severity scale](https://www.atlassian.com/incident-management/kpis/severity-levels) you can copy into the contract so both sides rank problems the same way.

Two loopholes hide in this clause. "Business hours" in whose timezone? A shop nine hours ahead of you can be contractually asleep during your entire workday, so name the timezone. And "response" has to mean a person with a plan, or an auto-reply bot will meet the SLA while your app stays down.

One more thing while the agreement is open for markup: fix the cost side in the same pass. The course lesson on [the AI token bill your agency forgot](/course/tech-for-non-technical-founders-2026/ai-token-bill-dev-shop-pass-through-cost/) walks three pass-through clauses - costs the agency pays on your behalf, then adds to your invoice - that deserve redlines right next to the response-time numbers.

## Requirement 2: fix windows, on a separate clock from reply windows

A shop can hit a 2-hour response target for a year and never fix anything, because answering and resolving are different clocks. Atlassian's [guide to service level agreements](https://www.atlassian.com/itsm/service-request-management/slas) treats first response time and resolution time as separate metrics for exactly this reason.

So ask for both. A fair shape: for a Severity 1, a workaround (anything that gets users moving again, even if it's ugly) within 24 hours, and a permanent fix within 5 business days.

Here's the honest limit: be suspicious of any shop that guarantees a hard fix time for every possible bug. Nobody who has actually debugged software can promise that, because some bugs take a day to find and an hour to fix. The trustworthy version is a firm workaround deadline plus a fix target, with an agreed escalation - who gets on a call, and when - if the target slips.

## Requirement 3: uptime that someone is actually watching

99.9% uptime sounds indistinguishable from 99% until you do the arithmetic. Uptime is the percentage of time your app is reachable and working for users, and over a 30-day month, 99.9% allows about 43 minutes of downtime while 99% allows more than seven hours.

The number is worthless without a measurement both sides trust, so the clause needs a source: which monitoring tool watches the app (software that pings your product every minute and records when it stops answering), and your right to see it. Stripe runs a public [status page](https://status.stripe.com/) - a live webpage showing whether each part of the service is up - and a modest version of the same for your product costs the agency an afternoon to set up.

If you haven't launched yet, skip this requirement for now. An uptime promise on an app with no users is decoration, and negotiating it wastes goodwill you'll want for the other four.

## Requirement 4: a definition of "done" you can check yourself

"Login feature: complete" on an invoice can mean the code works in production, or it can mean the code sits on one developer's laptop. Both read the same on paper, and you're paying either way.

Write the definition into the agreement: a feature is done when it's deployed to production (pushed live to the version of the app your customers use), covered by automated tests (small programs that re-check the feature after every future change), and demonstrated to you in the running app. Every item on that list is one a non-technical founder can verify without anyone translating.

An SLA is one clause in a bigger document, and the acceptance language usually lives in the SOW - the statement of work, the document listing what gets built and for how much. The course's [SOW Reading Guide](/course/tech-for-non-technical-founders-2026/sow-reading-guide/) annotates a full sample SOW, including the eight clauses agencies hope you skim; this "done" definition is the same discipline applied before you ever sign.

## Requirement 5: a consequence with a number on it

Google's site reliability engineers draw this line in [their SRE book](https://sre.google/sre-book/service-level-objectives/): if missing a target carries no explicit consequence, you're looking at an internal goal rather than an agreement anyone can enforce. Everything above stays decorative until missing the numbers costs the shop something.

The standard mechanism is a service credit - a percentage of that month's invoice you don't pay when a target is missed. [AWS's compute SLA](https://aws.amazon.com/compute/sla/) works this way for every customer down to the smallest account: uptime falls below the promised figure, and a slice of the bill comes back as credit. Your agency can't claim the concept is exotic when their own hosting provider extends it to them.

Add an exit trigger for repeated misses: something like "three Severity 1 breaches in a quarter" lets you terminate without an early-exit penalty. Hopefully it never fires, and if it does, the [guide to leaving a dev shop safely](/blog/fire-dev-shop-guide/) covers what to secure and in what order.

## "But my shop says SLAs are for enterprise clients"

You'll hear this, and usually kindly: "we're partners, we don't need that formality." Notice that the same shop signs an SLA with its own hosting provider and payment processor without calling either of them unfriendly.

A team confident in its own service tends to accept measurement, because the numbers flatter them. If you're still in the choosing phase, the [five questions to ask before hiring a dev shop](/blog/hiring-dev-shop-questions/) test for this in the sales call - a shop that volunteers a deadline commitment before you ask is telling you something worth knowing.

## What an SLA costs you

Expect the price to move. Hard response numbers mean the shop is now selling you an on-call commitment that didn't exist before, and honest shops will charge for it rather than sign and hope.

A resolution clock also creates a new incentive you should watch: a team racing a deadline is tempted to close the report with a shallow patch that makes the symptom disappear. An SLA measures speed, and nothing in it measures whether the code underneath stays healthy - that takes [someone technical reviewing the work weekly](/blog/code-quality-evaluation-non-technical-founders/), which is a separate job no clause replaces. And a few good small shops will simply decline hard fix guarantees, which is useful too: you learned how they handle commitments before signing instead of during an outage.

If you can't tell whether slow replies are a service problem or a code problem, we do a free 45-minute code audit: one senior developer, your codebase, a written one-page assessment. We've worked in Rails since 2008 and 95% of our clients stay with us - numbers we're comfortable putting in a contract, which is rather the point of this post. [Get the audit](https://jetthoughts.com/contact-us/).

Start with the inbox measurement tonight. It needs no lawyer, and by Friday you'll know which of the five clauses to fight for first.
