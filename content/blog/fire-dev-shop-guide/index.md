---
title: "How to Fire Your Dev Shop (Safely)"
description: "A founder's step-by-step guide to terminating a dev shop relationship, securing your code, and finding a better partner without repeating the same mistake."
date: 2026-04-21T08:00:00+02:00
draft: false
author: "JetThoughts"
slug: "fire-dev-shop-guide"
keywords: "fire development agency, devshop ruined my project, outsourced development gone wrong, switch dev shop"
tags: ["startup", "hiring", "dev-agency", "founder", "outsourcing"]
categories: ["Startup"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "How to Fire Your Dev Shop (Safely)"
  og_description: "Step-by-step exit guide for founders burned by a dev shop. Secure your code, transfer assets, and hire the right team next time."
cover_image_alt: "JetThoughts blog cover showing How to Fire Your Dev Shop with developer rescue stats"
canonical_url: "https://jetthoughts.com/blog/fire-dev-shop-guide/"
---

Your agency isn't ghosting you. It's hiding bad code.

I know how this feels. You hired a team, wrote them a check, waited three months — and now the demo sort of works, the backend is a mystery, and you're afraid to ask how much the next milestone will cost. You're not crazy. One in four outsourced projects [fails or significantly underperforms](https://www.deloitte.com/global/en/services/consulting/research/global-outsourcing-survey.html). That number is probably low.

If you need to fire your development agency, this is the guide. Not theory — the actual steps, including the ones nobody tells you about (like what to do tonight, before they know you're leaving).

## The Signs — How Many Do You Recognize?

Not every problem means you should fire your agency. But if three or more of these hit close to home, it's time.

**1. They've missed 3+ deadlines, and the excuse is always "complexity."**
One missed deadline — fine, things happen. Three? That's not bad luck. That's no process. If they never flagged the risk early, they're not managing the project. They're watching it happen.

**2. You don't have access to the code repository.**
If you can't log into GitHub and see commits happening, you don't own your product. You own a promise. We've taken over projects where the founder didn't even know what Git was — and that's okay. But your code should live in a place you control, not behind a login only the agency has.

**3. Every deploy breaks something.**
This one's subtle. You ask for a small change — a button color, a text fix. It ships, and something else breaks. That's the sound of code with no [automated tests](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/). The team is afraid to touch anything because they don't know what will break. A healthy codebase has 70%+ test coverage. If they say "we test manually," what they mean is "every change is a prayer."

**4. They won't refactor. Ever.**
Good teams clean up as they go. Bad teams pile features on top of messy code because refactoring is "too risky" — code without tests can't be safely changed, so [technical debt compounds](/blog/fixing-slow-engineering-teams-an-extended/). If your team treats the codebase like a house of cards, it is one.

**5. No transparency. You have no idea what's happening.**
You ask for a status update and get "it's going well" or "we're almost done." No weekly report. No demo of what shipped. No explanation of what's blocked. A good team sends you a [plain-English standup](/blog/how-make-small-valuable-async-standups-productivity-development/) every day and a summary every Friday. If you're guessing whether progress is real, it probably isn't.

**6. Budget keeps growing. Nobody explains why.**
Nearly half of every developer's paycheck goes to mopping up the mess the last team left — [42% of dev time](https://litslink.com/blog/cost-of-outsourcing-software-development) goes to technical debt. If invoices keep climbing but features aren't shipping, you're paying for rework on code that was written poorly the first time.

**7. They can't explain anything in plain English.**
Ask: "If you left tomorrow, could another team pick this up in a week?" If the answer involves hedging, one person holds all the knowledge. That's not a team — that's a hostage situation. A [structured onboarding process](/blog/effective-project-onboarding-checklist-management-productivity/) means any new developer can get productive in days, not months.

**8. You feel afraid to ask questions.**
This one doesn't show up on any checklist, but it matters. If you've stopped asking for updates because the answers make you feel stupid — or because you're afraid of what you'll hear — the relationship is broken. You're paying them. [You have every right to know what's happening](/blog/how-know-what-your-team-doing-remote-startup/).

---

**Need immediate clarity on what you're inheriting?** We do a free 45-minute code audit: one senior developer reviews your codebase, runs security scans, and gives you a written one-page assessment. No contract. No follow-up calls unless you ask. [Get an honest audit](https://jetthoughts.com/contact-us/).

---

## But First: Is This Actually Fixable?

Before you send that email tonight — is this fixable? Honestly, sometimes it is. And firing prematurely costs you another 2-3 months of onboarding someone new.

**Give them two weeks of structured transparency.** Weekly call, clear agenda: what shipped, what didn't, why. Not "how's it going" — specific deliverables. If they suddenly start communicating when you set expectations, maybe the problem was that nobody set expectations. It happens.

**Be honest with yourself too.** Did you change the requirements three times mid-sprint? Any agency would miss deadlines if the target keeps moving. An honest agency will tell you this. A bad one will nod and miss the date.

**Try 30 days with three concrete numbers.** "80% task completion per sprint. Weekly written reports. Git access within 48 hours." If they can't hit those basics — basics that any [competent distributed team](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) handles by default — you have your answer. And you have it documented for the termination letter.

If none of that moved the needle, keep reading.

## The Exit Checklist: What to Secure Before You Leave

Firing a dev shop is a business operation, not a breakup text.

**Code and repositories.** Confirm you have admin access to all repositories. If you don't, request it in writing before giving notice. Get a lawyer to review your termination clause — you need exact timing and format for code handoff specified in writing. Your next developer won't wait three months for a ZIP file.

**Infrastructure credentials.** Make a list: hosting provider (AWS, Heroku, DigitalOcean), domain registrar, DNS settings, SSL certificates, email service, payment processor API keys, analytics accounts. Transfer ownership of every account to an email address you control.

**Data exports.** Export your production database, user data, uploaded files, and any third-party integrations. Don't assume you can "get it later."

**Documentation.** Request architecture diagrams, API docs, environment setup instructions, and deployment procedures. If none exist — and they probably don't — that tells you everything about the quality of the engagement.

**Legal notice.** Most agency contracts require 15-30 days written notice. Send a formal termination letter referencing the specific contract section. Keep emotion out of it.

## What Your Contract Should Have Said

"But I signed a contract!" you say. Yes. And it probably doesn't protect you. Every contract we've seen from a failed engagement is missing the same three things:

**Code ownership after each milestone.** Your contract probably says you own everything "upon project completion." Sounds fine, right? Except "completion" is whatever the agency says it is. You need ownership after each paid milestone — not at the end. If they've been paid for three months of work, you should own three months of code. Period.

**A termination clause with teeth.** Something like: "If the provider misses two consecutive milestones, the client may terminate with 7 days notice." Without this, firing them turns into a negotiation with someone who has no reason to let you leave cleanly. That's not a partnership. That's a trap.

**Repository access from day one.** Not "upon request." Not a ZIP file emailed next week. Real-time, read-only access to the code repository. If they push back on this — really ask yourself why. What are they protecting?

If you need contract templates that actually protect you, [Clerky](https://www.clerky.com) ($819 lifetime) has startup-focused IP assignment and consulting agreements. It's cheaper than one hour of a lawyer's time and covers the basics.

## How to Evaluate the Code You're Inheriting

You can't read code. But you can read these signals.

Hire a senior dev — a freelancer, fractional CTO, or your replacement agency — to audit the code for four hours. Here's what to ask them:

First, test coverage — below 20% means the code can't be safely changed; below 5% means it was likely [vibe-coded](/blog/ai-powered-code-reviews-transforming-development-workflows/). Second, security vulnerabilities — a basic scan takes 30 minutes. Third, deployment — can they ship a change in under 10 minutes, or is it a multi-hour manual process? Finally, code structure — organized into clear pieces, or one massive file doing everything?

This costs $500-$2,000. Skipping it costs $50,000 when you have to rebuild.

If you can't find a freelancer fast enough, there are tools that can give you a rough picture tonight:

- **[The Code Registry](https://thecoderegistry.com/code-auditing/)** — connect your GitHub repo and get an AI-powered security scan, complexity score, and "Cost to Replicate" valuation in under 15 minutes. Built for non-developers.
- **[Codacy](https://www.codacy.com)** — automated code quality scanning with a free tier. More technical, but the dashboard is readable.
- **[Codekeeper](https://codekeeper.co)** — source code escrow. If you're worried your agency might lock you out, this service makes daily copies of your repo automatically. From $129/month. Set this up *before* you send the termination email.

And if you need a fractional CTO to help you navigate the transition, [Toptal](https://www.toptal.com) can match you within 48 hours, or browse the free directory at [FractionalCTOs.org](https://fractionalctos.org).

One more thing that doesn't cost anything: make sure your code repository lives in a [GitHub Organization that you own](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository), not in your agency's personal account. If you do nothing else from this article, do that. Tonight.

## Why This Is Worse in 2026

Here's a story from last quarter. A founder came to us after six months with a "vibe coding" shop. They'd used AI to generate about 90% of the codebase. The MVP was delivered on time — the founder was thrilled. The app loaded. The demo looked great.

Then real users showed up. First login with a special character in the email? Crash. Two users booking the same slot? Data corrupted. The founder called the shop. "That's an edge case," they said. It wasn't. It was Tuesday.

Test coverage: 2%. Error handling: none. Security scan: 14 critical vulnerabilities. The whole thing had to be rewritten.

This is happening everywhere right now. AI-generated code *looks* clean — good variable names, consistent formatting, reads well. But it has no tests, no error handling, and [security holes that only surface in production](/blog/from-what-start-stop-delivering-bugs-when-there-no-time-for-changes-management-agile/). Qodo's 2025 report found AI-generated code produces [1.7x more issues](https://www.qodo.ai/reports/state-of-ai-code-quality/) than human-written code. And that ratio gets worse when nobody reviews the output.

A team that lasts [writes tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) and [reviews every pull request](/blog/ai-powered-code-reviews-transforming-development-workflows/). A team that burns pastes AI output and ships.

## Finding the Next Partner

Here's what to actually look for. Not "do they have a nice website." That's irrelevant.

**Ask to see a real weekly report.** Not a template — an actual report from a real project (anonymized). A partner worth keeping sends a one-page summary every Friday: what shipped, what hit a wall, what's next. No buzzwords. We wrote about [what good async standups look like](/blog/how-make-small-valuable-async-standups-productivity-development/) — that's the level of visibility you should expect.

**Ask who owns the code after each milestone.** "You do" is the only right answer — backed by a contract clause, not a handshake.

**Ask about their test coverage policy.** If they can't name a number and a process, they don't have one. [TDD — writing tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) — is what separates shops that ship safely from shops that ship and pray. This is especially important now that so many teams use AI to generate code. Without tests, nobody knows if the AI output actually works.

**Ask how they handle deploys.** A good team [deploys daily with CI/CD](/blog/async-remote-xp-practices/) and nothing breaks. A bad team deploys monthly and everyone holds their breath. If deploys are scary, the codebase is fragile.

**Ask to talk to a founder they've rescued.** Not just a happy client — one who came from a situation like yours. If they can't produce one, they haven't done this before.

**Watch how they communicate in the first week.** Did they send an [onboarding checklist](/blog/effective-project-onboarding-checklist-management-productivity/)? Did they set up a shared project board? Did they explain their [delivery flow](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/)? The first week tells you everything about the next six months.

## The Real Win

Firing a dev shop is not a failure. Staying with a bad one is.

You're about to pay twice for the same product — once for the bad code, once to rebuild it. That's the reality. The question is how much the second round costs, and that depends entirely on who you hire next.

The pattern that works: exit cleanly, audit what you have, find a partner who writes tests before code and explains everything in language you understand. You already know what "bad" looks like. Trust that instinct.

---

*In the middle of a dev shop transition? We do a free 45-minute code audit: one senior developer, your codebase, a written one-page assessment. No contract, no follow-up calls. [Get an honest audit](https://jetthoughts.com/contact-us/).*

---

We've been writing about the practices that prevent these disasters for years. Here are the ones that matter most for founders evaluating a new partner:

- [Async-first XP practices](/blog/async-remote-xp-practices/) — how we run pair programming and CI/CD across timezones with zero regressions
- [Delivery flow for remote teams](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) — structured Kanban that keeps everyone aligned without micromanagement
- [Shape Up for founders](/blog/shape-up-founders-guide-not-wasting-your-runway-startup-tutorial/) — 6-week cycles that protect your runway
- [Fixing slow engineering teams](/blog/fixing-slow-engineering-teams-an-extended/) — from monthly releases to daily deploys in 60 days
- [How we evaluate code quality](/blog/code-quality-evaluation-non-technical-founders/) — the 5 signals non-technical founders can actually read
- [What our onboarding looks like](/blog/effective-project-onboarding-checklist-management-productivity/) — day-one checklist, no chaotic handoffs
- [Red flags in big PRs](/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/) — why we split anything over 500 lines

## Further Reading

- [Deloitte: Global Outsourcing Survey](https://www.deloitte.com/global/en/services/consulting/research/global-outsourcing-survey.html) — 25% project failure rate, provider management challenges
- [CISQ: The Cost of Poor Software Quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) — $2.41 trillion annual cost in the US
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) — AI code produces 1.7x more issues than human code
- [Stripe: Developer Coefficient Report](https://litslink.com/blog/cost-of-outsourcing-software-development) — 42% of dev time spent on technical debt
- [Aaron Hall: Source Code Access Rights on Termination](https://aaronhall.com/source-code-access-rights-termination-provisions/) — Legal framework for code ownership
- [Appstronauts: Project Transition Checklist](https://appstronauts.co/blog/a-successful-software-development-project-transition-plan-checklist/) — Practical transition framework
