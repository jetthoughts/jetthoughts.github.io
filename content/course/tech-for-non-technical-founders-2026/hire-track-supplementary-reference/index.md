---
title: "Hire Track Supplementary Reference"
aliases: ["/blog/hire-track-supplementary-reference/"]
description: "When you've reached the ceiling of self-serve and need to hire: where to find developers, the Fractional CTO bridge, interviews that catch AI theater, and how to read an SOW."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: hire-track-supplementary-reference
keywords:
  - hire developer non technical founder
  - fractional cto
  - hire dev shop sow
  - vet developer ai theater
  - where hire developer 2026
  - ai augmented developer
tags:
  - founders
  - non-technical-founder
  - hire-track-reference
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Hire Track Supplementary Reference"
  og_description: "When you've reached the ceiling of self-serve and need to hire: where to find developers, the Fractional CTO bridge, interviews that catch AI theater, and how to read an SOW."
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/"
related_posts: false
---

> **Reference content.** This page is supplementary - return when retention from Module 5 is solid AND you have hit the self-serve ceiling. Until then, [Module 4: Build It Yourself](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) is the path.

> **This page is a reference, not a linear read.** Four topics, jump to your need:
> - [Where to find developers in 2026](#where-to-find-developers-in-2026)
> - [The Fractional CTO bridge](#the-fractional-cto-bridge)
> - [Interviews that catch AI theater](#interviews-that-catch-ai-theater)
> - [Reading the SOW](#reading-the-sow)

This page consolidates the hire-track material from the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) course into one reference. Read the section you need, skip the rest.

![The hire track as a left-to-right strip of four numbered cards: step 1 find your developers - pick a geography and two platforms; step 2 the Fractional CTO bridge - 5 hours a week of senior eyes at $400-600 a week; step 3 the interview screen - 7 questions where Q7 splits the pool; step 4 read the SOW - the milestone clause is the $78K line.](hire-track-map.svg)

---

## Where to find developers in 2026

The developer hiring market reshaped between 2024 and 2026. Algorithm interviews stopped filtering for the skill that ships product - the model passes them. The question now is whether the candidate can own a system, direct AI tools, and put a thoughtful hand on the output before it merges.

*Rate-and-platform companion: [Where to Hire a Developer in 2026 - the map](/course/tech-for-non-technical-founders-2026/where-to-hire-developer-2026-map/) breaks the same market down by platform and region with rate bands.*

### The 2026 AI-Augmented Developer profile

Pre-seed founders still hire on resume signals that stopped predicting outcomes around 2024. Five criteria are the new screen.

**5 to 10 years of shipped engineering experience.** Not 0-3. The Junior who passes algorithm interviews is the Junior the model now replaces. The 5-10 year engineer knows where the load-bearing decisions live, which is the part the model still cannot do alone.

**Daily user of at least one of Cursor, Claude Code, Aider, or Copilot.** Ask them to walk you through their `.cursorrules` file or their CLAUDE.md. If they cannot, they are not directing the tools, they are watching them.

**Has shipped AI-generated code to production AND reviewed someone else's AI-generated code in pull request.** Both halves matter. Shipping alone produces the 45% security-flaw rate Veracode flagged in their GenAI Code Security Report 2025. Reviewing alone produces a senior who never tests the model's claims.

**Can articulate where the AI is wrong.** A real AI-Augmented Developer will tell you, unprompted, that the model invents npm packages (the slopsquatting attack vector), hallucinates database column names, and confidently rewrites authentication code that ships a CSRF hole. If they tell you the model is "amazing" and stop there, the screen is over.

**Salary band: $85K-$120K Junior with Senior productivity, or $100K-$140K for the AI Integration Engineer specialty.** The old Senior at $235K is a luxury, not a necessity for pre-seed.

### Four geographies

The 2026 hire decision is not "remote vs in office." It is which of four regions the role belongs to.

**Onshore (US / EU) - $130K to $210K+ per year.** 30 to 60 day hire cycle. Pick this when the role demands it: regulated industry (HIPAA, SOC 2 with US-data-residency clauses, fintech with state licensing), security clearance, or a board mandate. Otherwise the cost-to-output ratio is the worst on the map.

**Nearshore (LATAM) - $45 to $100 per hour.** Equivalent to $90K to $200K per year. 2 to 5 day hire cycle. Full timezone overlap with US Pacific through Eastern. English fluency at the level needed for daily standups and Slack. The talent pool is dense in Argentina, Brazil, Mexico, and Colombia. The 2026 default for most US founders who do not have a regulated industry mandate.

**Tier-2 offshore India - $15 to $70 per hour.** Equivalent to $30K to $140K per year. 1 to 5 day hire cycle. The structural shift is away from overheated Bangalore (rates compressed by global hyperscaler offices) toward Tier-2 cities: Jaipur, Kochi, Indore, Coimbatore. Senior engineers with seven to ten years of production ships in these cities accept rates 20% to 30% below Bangalore because the local cost-of-living is lower. The catch: async-first culture. You will not get standups at 9am Pacific. You will get pull requests merged overnight, code reviewed against your CLAUDE.md by morning, and a Slack thread with answers to your async questions before you finish coffee. Pick this for backend-heavy work where async is acceptable.

**Mass-market (Upwork) - $35 to $120 per hour.** Self-vetting required: the marketplace does no quality screen, you become the technical interviewer. Acceptable for point tasks only - a single landing page, a logo, a one-off web scraper. Anything load-bearing (payments, auth, multi-tenant data, a third-party integration with retry logic) belongs on one of the three professional platforms above, not Upwork.

**Which geography for which build** (rate bands and hire cycles are in the four paragraphs above):

| If your build is... | Route to | Why |
|---|---|---|
| In a regulated industry (HIPAA / SOC 2 / fintech), or your budget sits in the onshore band above | Onshore (US / EU) | Compliance, data-residency, or a board mandate justifies the highest cost-to-output ratio on the map |
| Backend-heavy, async is fine, and you want the lowest rate band above | Tier-2 India - Jaipur, Kochi, Indore, Coimbatore (not Bangalore) | Senior engineers accept 20-30% below Bangalore; PRs merge overnight against your CLAUDE.md |
| Backend-heavy, async is fine, at the mid rate band above | Nearshore (LATAM) | Same async workflow, shorter hire cycle, closer timezone overlap |
| Anything needing live timezone overlap for daily standups | Nearshore (LATAM) | Full US Pacific-to-Eastern overlap; English fluency for standups and Slack |
| A single point task - logo, landing page, one-off scraper | Upwork | Self-vetting marketplace; non-load-bearing work only |

### Six platforms ranked

The hiring market for AI-Augmented Developers in 2026 lives across six platforms. Pick two based on your geography decision above. Post the role on both, and do not waste a Friday on a tour of all six.

- **[Toptal Fractional Executives](https://www.toptal.com/fractional/cto)** - Senior + screened, 3-5 day hire cycle, $90-$200/hr. Best for Senior fractional roles where the cost of a wrong hire would dwarf the platform markup.
- **[Bolster](https://www.bolster.com/on-demand-hiring)** - the largest curated fractional executive marketplace. Strong for fractional CTO and VP Engineering.
- **[LatHire](https://www.lathire.com/)** - LATAM nearshore developers, full-time and contract. Pre-screens for English fluency and engineering depth.
- **[AI People Agency](https://aipeople.agency/)** - AI-native engineer screening. Sub-48-hour candidate slates for AI Integration Engineer and AI Quality Engineer roles.
- **[Seedium](https://seedium.io/)** - AI-first software agency. Project work via SOW, not headcount.
- **[Upwork](https://www.upwork.com/)** - mass-market freelance for point tasks only.

**Job description that screens for the right signal:** Five lines: (1) 5-10 years engineering, (2) daily Cursor or Claude Code or Aider user, (3) shipped Rails / Django / Laravel apps to production, (4) reviewed AI-generated code in pull request, (5) can articulate where the model is wrong. Skip "5+ years of React and Node." Skip "Big Tech experience preferred." Both screens filter against the wrong signal in 2026.

---

## The Fractional CTO bridge

You do not need a 50% co-founder. You need 5 hours a week of senior judgment to tell you when the architecture is about to break, the contractor is about to propose a rewrite you do not need, or the PR that just merged shipped a CSRF hole. That job costs $400 to $600 a week, pays in cash, and is terminable on 30 days' notice.

### The 5 jobs the Fractional CTO does

| Job | Time / week | What it catches |
|---|---|---|
| **Architecture review** | 1 hr (Monday) | The contractor proposing microservices - or a separate React frontend + Node API + Python ML service - for an app with 18 paying users. The verdict lands as one paragraph in a Notion doc. |
| **PR review** | 2 hrs | The API key checked into the repo, the n+1 query, the missing CSRF token, the auth bypass on the admin route - the 45% of LLM-generated code Veracode's GenAI Code Security Report 2025 found ships an exploitable security flaw, caught before prod. |
| **Hiring filter** | 1 hr (during a hiring sprint) | A wrong-fit first hire, which costs two months of runway. The FCTO runs the tech screen, reads the candidate's last three commits, and asks the four technical questions you cannot. |
| **Vendor BS detection** | As needed | Kubernetes for 200 users, GraphQL "because REST is old" - the senior "why?" in a room where you are otherwise the only buyer facing three people pitching. |
| **Founder coaching** | 1 hr (Friday) | Translates "Resque is dropping jobs" into "promise the demo for the 12th, not the 5th" - and tells you which feature is one day of work and which is three weeks. |

### Five criteria for hiring a Fractional CTO

Most "Fractional CTO" listings on LinkedIn are either career CTOs in transition (overpriced for pre-seed) or junior engineers padding their title (under-skilled for the role).

**1. 10+ years engineering at Series A-C startups.** Big-tech-only resumes solve different problems. They know how to scale to a billion users. They do not know how to keep a 200-user app alive on a Heroku bill of $89/mo. Series A-C is the sweet spot.

**2. First engineer at 2+ startups.** The "first engineer" experience is the closest analog to what your Fractional CTO will do for you. They have set up the GitHub org from scratch, picked the database, written the deployment script, and argued with a non-technical founder about the roadmap. Two times is enough; one time is luck.

**3. Will commit to a recurring weekly slot.** "Available when needed" is the failure mode. You want a recurring 30-minute architecture review every Monday and a 60-minute founder coaching every Friday. Both blocks on their calendar. If the candidate is not willing to commit to recurring slots in the first call, they are pricing in your churn.

**4. References from non-technical founders specifically.** Ask for two non-technical-founder references. Call both. Ask: "Did the Fractional CTO ever push back on a feature you wanted to ship? What happened?" If the answer is "they always shipped what I asked for," that is a no-hire signal.

**5. $400-$600/wk for 5 hrs is the 2026 market range.** [Bolster's marketplace data](https://www.bolster.com/on-demand-hiring) and Toptal Fractional Executives put the range at $80 to $120 per hour for a competent Fractional CTO. 5 hours per week lands at $400 to $600. Above $1,000 per week you are paying for a name brand or a CTO over-spec for pre-seed. Below $300 you are buying a junior engineer with the title inflated.

### Where to find them

- **LinkedIn**: search "Fractional CTO" + your industry. Send 10 short DMs that name the project and the budget. Reply rate is around 30%.
- **Y Combinator alumni network**: post in the founder Slack. The talent pool here is dense.
- **Platforms**: [Toptal Fractional Executives](https://www.toptal.com/fractional/cto), [Bolster](https://www.bolster.com/on-demand-hiring). Each pre-screens. You pay a markup, you save a week of vetting.
- **Indie Hackers Fractional channel**: free, slower, founder-to-founder. Best for SaaS micro-startups.
- **Your investor network**: one email to your lead angel often produces 2 to 4 warm intros within 48 hours.

> **JetThoughts is not a Fractional CTO provider.** We are an engineering services shop (full-team rescues, rebuilds, technical coaching). The platforms above host specialized fractional executives screened on the criteria in this section. This chapter teaches you how to hire one well; we do not sell the role.

**First-month onboarding (Day 0 through the Week-4 checkpoint):**

| Day | What happens |
|---|---|
| **Day 0** | Sign the MSA. |
| **Day 1** | Share the Validated Problem Statement and one-page brief. Add them to the private GitHub org with `Triage` repo permissions (can review pull requests but cannot merge code) - not `Admin`, not `Write`. |
| **Day 3** | First 30-minute architecture review. They write one paragraph in a shared Notion doc: "what I would change, what I would leave alone." |
| **Day 7** | First PR review. Their comments should be in plain English so you understand the trade-off. |
| **End of Week 4** | Ask them the Friday-coaching question: "Should I hire any contractors yet?" If the answer is hand-wavy, you have hired wrong; replace. |

### The Fractional CTO's first 4 weeks (parallel to your Module 5 first-paying-customer push)

**Read this before you decide whether to hire** - it shows what the FCTO's first 4 weeks look like alongside your Module 5 work, so you can evaluate whether the timing makes sense and what you should expect from the engagement. The FCTO arrives the week one or two Lesson 4.5 ceiling signals flip red (Lesson 4.5 has a 5-signal scoreboard; "red" means a signal has been firing for 4+ weeks). They are NOT building features alongside you - they are reading what already shipped, naming what is about to break, and deciding salvage vs rebuild. The four-week onboarding runs in parallel to your Module 5 outreach so neither stream blocks the other:

| Week | Fractional CTO ships | You ship | Why parallel |
|------|----------------------|----------|--------------|
| **Week 1** | One-page architecture assessment in a shared Notion doc: "the shed is holding" OR "we need a house in 8 weeks." Names the highest-risk ceiling signal and the patch cost. | Send the 50-name personal-network outreach from Lesson 5.3. | The architecture verdict is the input to your runway math; your outreach is the input to your revenue math. Both need to happen before week 5. |
| **Week 2** | Watch Supabase logs for RLS violations, slow queries, error rates as your first 10 invited interviewees create accounts. Patches one critical bug ONLY if data-corruption risk. | Book the first 2-3 demo calls from Lesson 5.3 replies. Run them. | The Fractional CTO reads the signal of your first 10 real users; you read the signal of your first 2-3 demo prospects. |
| **Week 3** | Ships ONE small hardening change to staging: faster dashboard query, fixed RLS policy, or webhook idempotency check. Not a feature - a stabilizer. | Send the first Lesson 5.6 Design Partner Agreement to a hot lead. | One stabilization stream + one revenue stream = the founder gets paid pilots without the contractor getting tempted into feature work. |
| **Week 4** | Friday-coaching call: "based on the first 4 weeks, here is the 90-day plan." Either (a) keep self-serve + Fractional CTO bridge for 3 more months, (b) hire a full engineer this month, or (c) rebuild from scratch on Rails/Django/Laravel in 8-12 weeks. | Close the first paid pilot from Lesson 5.6. Stripe deposit clears. | Both streams converge: the Fractional CTO's 90-day plan and your first revenue are the two inputs to the next hire decision. |

The trap to avoid: the Fractional CTO who arrives in Week 1 and immediately recommends "rewrite the whole thing in Rails." That candidate sees vibe-coded MVPs as broken not salvageable; the recommendation usually means they want the bigger billable engagement. Push back: "what is the ONE ceiling signal we can patch in Supabase this week to give us 90 more days to decide?" A real Fractional CTO has the patch ready by Friday.

### The monthly architecture review habit (the one thing the Fractional CTO does every month)

First Monday of every month, 60 minutes, the Fractional CTO and you read the Lesson 4.5 5-signal scoreboard together. The standing agenda:

1. Re-score the 5 signals against last 30 days of usage data, OpenAI invoice, support tickets, schema changes, and customer security/compliance asks. 20 minutes.
2. Compare to last month's score. Did any signal flip from green to yellow, or yellow to red? Did any flip back? 10 minutes.
3. Pick ONE thing to harden this month. Not three. One. Examples: add caching to the dashboard, write the RLS policy test, set up an audit log. 15 minutes.
4. Decide: bridge for another month, hire a full engineer, or start the rebuild conversation. Document the decision in the same Notion doc. 15 minutes.

The scoreboard becomes the standing artifact. By month 3 you can see whether you are stabilizing (signals flipping back to green), holding (no change), or sliding (signals progressing red). Three consecutive months of one signal at red without patching = it is time to hire. Two consecutive months of all signals at green = the Fractional CTO bridge worked and you can scale back to monthly check-ins only.

### Production hardening checklist: what your Fractional CTO will look for

Five hardening checks a competent Fractional CTO will run in the first 30 days. **Read this BEFORE the hiring conversation so you know the names**, not so you execute the engineering yourself - the steps below need hands-on database + production access most non-technical founders don't have. When the FCTO's week-1 report mentions any of these, you'll know what they mean and the conversation about which one to patch first takes 10 minutes instead of 45.

**1. Row-Level Security (RLS) policy testing.** RLS is the database rule that says "Coach A can read only Coach A's rows." Every RLS policy you (or the FCTO) wrote in Supabase needs a test query proving it works - the FCTO opens the Supabase SQL editor, signs in as Coach A, and tries to read Coach B's data. If the query returns rows, the policy has a hole. This 5-minute check prevents the cross-tenant data leak that ends pilots. The FCTO's first ship is usually patching any failing policy.

**2. Webhook idempotency.** A webhook is an automatic message from one service (Stripe, Resend, etc.) to your app. "Idempotent" means it's safe to fire the same message twice - the second hit doesn't double-charge or double-update. Stripe retries on any non-2xx response (network blip, timeout, deploy mid-call) so the handler must be defensive. The FCTO's check: every webhook handler starts with "have I already processed this event ID?" - if yes, return success immediately without re-running the update.

**3. Database backup restore runbook.** Your Supabase project auto-backs up to S3 nightly. The month you need the backup is not the month to discover the restore doesn't work. The FCTO runs a full restore to a staging Supabase project once a month, signs in as a customer, confirms the data is there, and documents the step-by-step in a shared Google Doc. You inherit the runbook so you can re-run the drill if the FCTO leaves.

**4. Secret rotation recovery flow.** When a contractor leaves on Thursday with your Supabase password in their personal 1Password vault, the FCTO runs the recovery sequence: (a) revoke all API keys in the Supabase / Stripe / OpenAI dashboards immediately, (b) backup the whole database to S3, (c) open a Supabase support ticket for the old password reset, (d) check the audit log for what got read during the unrevoked window. Rotating secrets is easy; recovering the logs of who accessed what is the part most founders miss when they try this themselves.

**5. AI inference rate-limit handling.** If your Lovable form calls OpenAI or Anthropic on submit, you need a request queue. The FCTO's pattern: your Lovable form does NOT call the API directly; it writes a job to a Supabase queue table; a background worker pulls from the queue, hits the API, stores the result. When the API rate-limits you (every API does eventually), the queue backs up gracefully instead of timing out in the user's face. This is one of the FCTO's standard first-week ships.

These five are the gap between "works in test mode for one founder clicking around" and "works in production for 47 paying customers on a Tuesday morning." Knowing the names is the founder's job; running the checks is the FCTO's.

---

## What stack to ask your hired team to use

You are not picking the stack alone - your Fractional CTO or hired engineer makes the technical call. But you need the vocabulary to (a) have an informed conversation, (b) recognize when a contractor proposes the hipster-of-the-month stack that nobody can hire for in 6 months, and (c) push back without escalating to a holy war. The frame below is what we recommend out of 20 years of rescue calls.

### Default: Rails (Ruby on Rails)

Rails is the JetThoughts default and the Indie Hackers / DHH / Pieter Levels community standard. The reasoning is empirical, not religious: Rails ships fast, one engineer can operate the full stack end-to-end, the conventions are tight enough that the next engineer you hire reads the codebase in a day, and the deployment story (Heroku, Fly.io, Render) costs $7-$50/month at pre-seed scale. Basecamp ([DHH's *One-Person Framework* essay](https://world.hey.com/dhh/the-one-person-framework-711e6318)) is the case study: two decades of products on a Rails monolith run by a famously small team, and Shopify serves millions of merchants on one Rails monolith. At your scale (47-5,000 paying users) one Rails engineer can ship + operate the whole thing.

**Why Rails wins for the non-technical founder's hired team:** the hire pool is deep (15+ years of Rails engineers), the framework opinions are tight (less time arguing about conventions, more time shipping), background jobs / email / file uploads / authentication / payment / admin / search are all batteries-included rather than 12 separate npm packages, and the Rails community produced the rescue patterns we see work in production (Pundit for authorization, Devise for auth, Sidekiq for jobs, ActiveAdmin for staff tools).

### Acceptable alternatives, with caveats

| Stack | When it's right | Caveat |
|-------|----------------|--------|
| **Laravel** (PHP) | Your hired team is PHP-comfortable; you need WordPress integration; you're in a market with deeper Laravel hiring than Rails (Europe, Indonesia, Brazil) | Same conventional-monolith strengths as Rails. PHP hosting is cheaper. Hiring outside Rails-strong markets is often easier in Laravel. |
| **Django** (Python) | Your product has serious ML / data / scientific workloads; the team will use Python for the model pipeline anyway and consolidation reduces cognitive load | Slightly less batteries-included than Rails; admin panel + auth + ORM are strong; the migration story is bumpier. Ship Django when ML is the moat, not "we like Python." |
| **Next.js + Postgres** (frontend monolith with API routes) | Your product is content-heavy, SEO-critical, and the build is mostly screens with light backend | Next.js is excellent for static-heavy products. It becomes a footgun when the backend grows: API-route monoliths trap you in serverless cold starts and React-only data-fetch idioms. Cap Next.js at the marketing site + light dashboard. |

### Explicit "do NOT accept" patterns

If your contractor or FCTO proposes any of these in week 1, push back hard. They are real architectural choices, but not for your scale and not for the non-technical founder context:

- **Microservices for 200 users.** Microservices solve a coordination problem teams of 50+ have. At 1 contractor + 1 non-technical founder, microservices add 5x the operational complexity for zero scaling benefit. Counter-proposal: one monolith, period.
- **Separate React frontend + separate Node API + separate Python ML service for a single workflow.** Three deployments, three CI pipelines, three on-call rotations, three places auth has to be enforced. At pre-seed, this is the rebuild-in-9-months pattern we see most often. Counter-proposal: one Rails or Django app that does everything; add the second service only when a real bottleneck appears.
- **GraphQL because "REST is old."** GraphQL solves a frontend-team coordination problem you don't have. It also makes caching, monitoring, and rate-limiting harder. REST is fine for 0 to 50K users. Counter-proposal: REST with sensible JSON; add GraphQL the day a frontend team asks for it.
- **Kubernetes / Docker Swarm for an MVP.** Container orchestration is correct for 20+ services across 3 environments. It is wrong for "1 web process + 1 database + 1 cron job." Counter-proposal: Heroku, Fly.io, Render, or a single Hetzner VPS with a deploy script.
- **Hand-rolled auth ("we'll just build login").** Auth is where rescue calls start. Counter-proposal: Devise (Rails), django-allauth (Django), or Auth.js (Next.js). Buy the proven implementation; never build your own.

### The 3-question script for the contractor stack conversation

When you interview a contractor or FCTO, ask these three questions before signing anything. The right answers map to the recommendations above; the wrong answers are the red flags.

1. **"What stack would you build this in, and why?"** Good answer: "Rails (or Laravel/Django depending on team) - I can ship a working signup + paywall + one workflow end-to-end in 4-6 weeks solo, and the hire pool for the next engineer is deep." Bad answer: a 3-stack architecture diagram, or "whatever you prefer." The first signals over-engineering; the second signals they have no opinion (which means they'll default to what's trendy).
2. **"If we hit 5,000 paying users, what breaks first?"** Good answer: a specific component (database read replicas, background job queue, image processing). Bad answer: "we'll rewrite in [new stack] then." Rewrite-driven engineers are expensive.
3. **"How many other engineers can I hire who would be productive in this stack within 30 days?"** Good answer: a real number for your market (Rails: thousands worldwide; Laravel: similar; Django: similar; Elixir or Clojure: dozens; Rust web framework: a handful). Bad answer: vagueness, or "we don't need to think about that yet."

The Indie Hackers community spent the last decade learning what one-person and two-person engineering teams can sustain. The answer almost always rhymes with Rails / Laravel / Django + Postgres + a single hosted deployment + boring open-source libraries. Trust the empirical evidence; resist the JavaScript fashion cycle.

---

## Interviews that catch AI theater

Every engineer claims AI fluency on a 2026 resume. Most are typing prompts, accepting suggestions, and pushing the diff to PR. Veracode measured what that produces: 45% of LLM-generated code shipped at least one exploitable security flaw. The market split into two populations behind the same resume language. The 80% run AI theater - they accept the model's first suggestion, never disagree, and never check the dependency. The 20% direct the model - they read the diff, reject most of it, and catch the hallucinated package before it merges.

For the verbatim 7-question script + per-question Pass/Fail rubric + scoring sheet, see the [Hiring Interview Script](/course/tech-for-non-technical-founders-2026/hiring-interview-script/) template. Below is the brief on when and why to use it.

### When to run the 7-question screen

Run it after the resume passes, before any technical take-home. The 30-minute screen sits between phone screen (culture/role context) and the deeper paired-coding session you do with finalists. Three of seven questions are about AI tooling, four about engineering judgment - the split mirrors what an AI-Augmented Developer actually does in a week.

### Why these seven questions, not a different seven

The seven questions are organised around what costs the most when a candidate fakes it.

| Question pair | Catches the candidate who... | What faking it costs you |
|---|---|---|
| **Workflow + cost (Q1, Q2)** | Has never set up a `.cursorrules` file (the repo's standing instruction file for AI coding tools) or seen a personal Anthropic invoice | Silently runs your monthly AI bill from $200 to $4,800 in their first sprint |
| **Verification + slopsquatting (Q3, Q4)** | Outsources PR review to the model ([slopsquatting](/course/tech-for-non-technical-founders-2026/slopsquatting-ai-supply-chain-attack/) = installing a fake package the AI invented) | Their name ends up next to the CSRF hole in your incident postmortem |
| **Accountability + refactor (Q5, Q6)** | Has never owned a system through a production incident or a non-trivial rewrite | The "I refactor as I go" answer is the kind of rewrite that kills startups |
| **Disagreement (Q7)** | Accepts the model's first suggestion and cannot show one PR where they disagreed with it | This is the one question that actually splits the population - a candidate who directs the model reads the diff, rejects most of it, and can show you the PR comment where they did it |

### The scoring discipline

Score within five minutes of hanging up - not after the next call. Use the three-axis sheet in the script (Specificity, System judgment, Communication). The one rule worth repeating: do not let a strong Communication score override a failed Q7. Q7 is the load-bearing question; if they cannot show one PR where they disagreed with the model, the answer to every other question was a story.

Send the polite-no email the same evening, not Friday: "Thank you for the time. We are pausing the search to refine our requirements. We will keep your details on file."

---

## Reading the SOW

*"Vendor shall be deemed to have delivered a milestone upon deployment to the Client-accessible staging environment."* That is the single most expensive sentence a founder will sign this year. It moves the trigger for a milestone payment from "the feature works for users" to "the agency pushed code to a URL." In early 2026, one SaaS founder had $78K of milestone invoices clear under that one line before her fractional CTO opened the staging URL and watched it 500 on the second click.

Her general counsel had cleared the SOW the night before signing. He had flagged liability and the IP assignment, fixed both, and called it done. The milestone-acceptance clause sat three pages later and he had skimmed it. Generalist lawyers cover the catastrophic clauses. Agency templates leak money through the operational ones in between.

### Eight clauses that quietly cost you money

For the full 8-clause table - what each clause should say, the red-flag wording, and the exact redline for each - see the [SOW Reading Guide](/course/tech-for-non-technical-founders-2026/sow-reading-guide/). The milestone-acceptance clause below is the one that costs the most; read it before you read the rest.

### The milestone-acceptance redline

Of the eight, milestone acceptance is where founders consistently lose the most money, and it is the clause your general counsel is the most likely to skim.

The fix is one paragraph. A milestone is delivered when (a) the acceptance criteria listed in Exhibit B pass in CI, (b) the Founder or her delegate has clicked the feature end-to-end on the staging URL, and (c) the Founder has signed off in writing within seven business days. The acceptance criteria belong in the SOW, not in a Slack message after the work is done. The five-day silent-acceptance window becomes a seven-day active-acceptance window. The invoice does not clear until the Founder signs.

If the agency pushes back on this language, that is the conversation you want to have before signing, not after $78K has been wired.

### When the SOW is already signed

If you have already signed and a few of the eight clauses are tilted against you, the work is recoverable but harder. Put a dollar number next to each clause before the next renegotiation conversation. Which clauses are biting you now (dollar cost from milestones already paid against staging-only delivery), and which can wait (warranty windows that have not yet triggered). Push back on the milestone-acceptance and termination-trigger clauses first - they have the highest dollar exposure per sprint.

---

## Next steps

If you are reading this because you are ready to hire, the sequence is:

1. Pick your geography and two platforms from the hire section above. Post the role this week.
2. If you have budget for it, hire the Fractional CTO before the first developer starts. The $400-$600 per week for architecture review and PR coverage pays back in the first sprint.
3. Run every candidate through the seven-question interview. Score within five minutes of the call. Do not let good conversation scores override a failed Q7.
4. Before you sign any SOW, read the milestone-acceptance clause word by word. If it says "upon deployment to staging," strike it and replace it with the paragraph above.

The [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) course covers the full sequence from problem validation through your first paying customer.
