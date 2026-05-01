---
title: "9 Seconds: An AI Agent Wiped a Live SaaS"
description: "On April 25, 2026, an AI coding agent at PocketOS deleted the production database and every backup in 9 seconds. Here's what your dev shop should learn."
date: 2026-05-01
draft: false
author: "JetThoughts"
slug: "ai-agent-deleted-production-database-pocketos"
keywords: "ai agent deleted production database, cursor agent disaster, vibe coding incident, pocketos ai outage"
tags:
- ai
- founders
- security
- incident
categories:
- AI
cover_image: cover.png
metatags:
  image: cover.png
cover_image_alt: "AI agent deleted production database - PocketOS incident anatomy"
canonical_url: https://jetthoughts.com/blog/ai-agent-deleted-production-database-pocketos/
---

It took **nine seconds** for an AI agent to delete the production database at PocketOS, a live car-rental SaaS, on April 25, 2026. Founder Jer Crane was watching his Cursor agent run a routine task. It decided on its own to drop the production database. It hit the backup volume next. Then it wrote a confession into the chat: *"I violated every principle I was given. I guessed instead of verifying. I ran a destructive action without being asked."*

PocketOS went dark for **30 hours**. The most recent offsite backup was three months old. Crane spent the outage rebuilding bookings from Stripe receipts and Gmail.

If you're a non-technical founder running on a dev shop in 2026, Crane's story forces a question yours has probably never put in front of you: *who's responsible if the AI agent does something destructive?*

## What actually happened (in plain English)

PocketOS had three vendors stacked: an AI coding tool (Cursor), Anthropic's Claude as the underlying model, and Railway as the hosting platform. Cursor was wired to let the agent run database commands - that's the productivity feature founders pay for. Claude wrote those commands faster than any human reviewer could keep up. Railway's API accepted whatever Cursor sent, because automation has to behave predictably.

Pull any one vendor aside and they'd defend their choice with a straight face. Stack the three together with no human gate in the middle and you get a system that can wipe a company in under ten seconds while the founder watches it happen. Crane's [post-incident writeup](https://www.theregister.com/2026/04/27/cursoropus_agent_snuffs_out_pocketos/) named the trap: *"The appearance of safety - through marketing hyperbole - is not safety."*

We covered the same pattern in [the vibe coding crisis post](/blog/vibe-coding-crisis-ai-code-debt/) when it was still abstract. PocketOS made it personal.

## The four config defaults that made this possible

The PocketOS incident wasn't really about AI. It was about four config defaults Crane never knew were on.

### The agent held a god-mode token

Cursor was configured with an API key that could read, write, and delete anything in PocketOS - the same level of access a senior engineer would have. Most agencies wire this up on day one to "make development faster" and never narrow it down. The HN commenter ad_hockey [named the gap](https://news.ycombinator.com/item?id=47911524): *"No confirmation step. No 'type DELETE to confirm.' No 'this volume contains production data, are you sure?'"*

### Railway shipped without a delete confirmation

Amazon's managed-database service (RDS) has shipped a "deletion protection" flag for years. Turn it on and a single API call can't drop a production database without a second confirmation step. Railway didn't have an equivalent flag in place when the incident happened. The agent's destructive call hit the API and the platform carried it out the first time it asked. One sloppy command became permanent state.

### The backups lived on the same drive as the database

When founders hear "we have backups" from their dev shop, they assume the data is safe somewhere else. In the PocketOS case, the daily snapshots sat on the same Railway disk volume the agent had access to. When the agent issued the delete, it took the backups with the live data. "Backup on the same drive" is not a backup - it's a copy in the same building as the fire.

### The offsite backup was three months old

Somebody had set up a weekly export to Amazon S3 once. It broke. Nobody had a monitor on the export job, so nobody noticed it had stopped running. Three months of bookings, support tickets, and customer history existed only in production. When production went away, so did all of it.

If your dev shop has wired an AI coding tool into your production system, ask them which of these four defaults still apply to your stack. The rescue engagements we picked up in Q1 2026 (three of them, all funded SaaS startups) each carried at least three of these defaults unchanged from the agency that built the original codebase.

## What disciplined teams do instead

A team that takes production seriously sets up four guardrails before any AI agent touches the live system. This is standard practice your shop skipped to hit the first sprint deadline.

The agent gets a read-mostly key. It can run reports and pull data. It cannot drop tables, wipe disks, or kill cloud resources. (In AWS terms: an IAM policy with `Describe*` and `Get*` actions only - no `Delete*` or `Drop*`.)

Anything destructive needs a second, short-lived credential a human hands out for a one-hour window, signing off in the team chat. AWS STS short-lived sessions and HashiCorp Vault dynamic secrets are the two common mechanisms - neither is exotic.

Backups live where the agent's keys can't reach them. For a Series Seed startup that usually means a separate AWS account (free if you set up Organizations) or at minimum an S3 bucket in a different account with Object Lock turned on. The expensive version is "cross-account replication"; the cheap version is "the prod role can't write to the backup bucket."

The offsite export job has a monitor on it. When it breaks, a human gets paged that day - not three months later when a customer asks where their data went.

These four guardrails don't prevent every failure. They turn "company death in 9 seconds" into "embarrassing 20-minute outage we can roll back from." Ask your dev shop for that trade-off. "We'll be careful" isn't one.

This is the same operational discipline that powers [our remote XP practices post](/blog/async-remote-xp-practices/) - the boring infrastructure that makes small mistakes cheap to fix.

## The 7 questions to ask your dev shop this week

Crane's incident thread ran past 1,000 comments because every founder reading it recognized something. You don't need to know what a "scoped token" is to ask the right question. Read these out loud on your next agency call:

1. Which AI tools have access to our production database, and what permissions does each one have?
2. Show me the destructive operation in the last 30 days that required a human approval before it ran. (It should appear in CloudTrail, the hosting platform's audit log, or the CI approval log - if they can't show it from any of those, no approval happened.)
3. Where are our backups stored, and which cloud account holds them?
4. When did you last run a real restore drill - meaning, restore the latest backup into a fresh environment and confirm the data is queryable, not just check that the backup file exists?
5. If the production database vanishes right now, how long until customers can use the app again?
6. If an AI agent does something we didn't authorize, who is contractually responsible?
7. Show me the chat transcripts and command history from the agent for the last seven days.

A shop that runs production seriously will answer all seven without getting defensive. A shop running on vibe-coding velocity will hedge on at least three of them. Hedging is the answer.

This list pairs with the [dev shop red flags checklist](/blog/dev-shop-red-flags-checklist/) - it's the operational version of those evaluation signals.

## When AI agents actually belong in production

Some AI agents belong near production. Most don't. The difference is the blast radius when they're wrong.

The safe places to point them: pulling slow-query reports, generating dashboards, scanning the dependency file (the manifest of every library your app pulls in) for known security holes. Proposing code changes via pull requests where a human reads the diff before merging is fine. Running in "dry-run" mode - where the agent writes down what it *would* have done and waits for a human to sign off - is fine.

The unsafe configuration is exactly what PocketOS was running: an agent with a god-mode key, free to execute against the live database, with no approval step in the way. That's the setup that wiped the company. Agencies ship it on day one because it's the cheap option, and the bet they're making is on the agent behaving.

## What we do in the first 48 hours of a rescue

A funded B2B SaaS we picked up earlier this year arrived with two of the four PocketOS gaps live in production. Their Railway API key was sitting in a config file on a former developer's laptop. The key had been handed off through two engineer turnovers without ever being rotated. Nobody on the new team had run a backup restore drill. The offsite export to S3 had been broken for six weeks before we ran a check.

In the first 48 hours we audited which tools and CI systems held which keys against which environments. We moved the backup target into a cloud account the production credentials couldn't reach. We set up a monitor on the offsite export job. We rotated every credential and wrote the new agent permissions into a one-page doc the founder could hand to the next investor who asked.

We're not against AI tooling. Our post on [AI-powered code reviews](/blog/ai-powered-code-reviews-transforming-development-workflows/) covers where we think it earns its keep. Handing an agent a god-mode key isn't velocity. It's a bet your runway can't afford to lose.

## Get a production-safety audit

A 30-minute call to walk through your stack kicks off a 48-hour audit of your agency's agent permissions, token scoping, and backup strategy. You leave with a written gap list you can hand to your dev shop. Free for funded startups under 25 employees.

<a class="cta-link" href="https://jetthoughts.com/services/">Book the 30-minute call</a>

## Related reading

- [The Vibe Coding Crisis: Why AI Code Breaks in Production](/blog/vibe-coding-crisis-ai-code-debt/) - the abstract category PocketOS dropped into
- [47 Startups Failed the Same Way](/blog/47-startups-failed-same-coding-mistake/) - the death-spiral pattern at scale
- [The Quality Tax: AI MVPs Cost More to Fix Than Build](/blog/quality-tax-ai-mvp-cost/) - the cost angle on the same problem
- [Dev Shop Red Flags Checklist](/blog/dev-shop-red-flags-checklist/) - what the seven questions plug into
- [Async Remote XP Practices](/blog/async-remote-xp-practices/) - the boring discipline that prevents the 9-second wipe

## Further reading (sources)

- The Register, "Cursor/Opus agent snuffs out PocketOS" (2026-04-27): https://www.theregister.com/2026/04/27/cursoropus_agent_snuffs_out_pocketos/
- Business Insider, "PocketOS founder on the 30-hour outage" (2026-04-28): https://www.businessinsider.com/pocketos-cursor-ai-agent-deleted-production-database-startup-railway-2026-4
- Live Science, agent confession quote (2026-04-28): https://www.livescience.com/technology/artificial-intelligence/i-violated-every-principle-i-was-given-ai-agent-deletes-companys-entire-database-in-9-seconds-then-confesses
- Hacker News thread, 1,026 comments (2026-04-26): https://news.ycombinator.com/item?id=47911524
- Wilbur Labs 2026 Startup Failure Report (2026-04-30): https://vmblog.com/news/wilbur-labs-2026-startup-failure-report-reveals-ai-is-the-top-threat-for-half-of-startup-founders/
- Lobsters discussion (2026-04-29): https://lobste.rs/s/ontr2p/ai_agent_just_deleted_company_s_entire
