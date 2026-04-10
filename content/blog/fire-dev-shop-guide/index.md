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

If you need to fire your development agency, this guide walks you through every step — recognizing the signs, securing your code, and hiring the right team next time.

Deadlines keep slipping. The demo looks fine but nothing works behind the scenes. You ask for a timeline and get vague answers. You're not crazy — one in four outsourced projects [fails or limps along underperforming](https://tsh.io/blog/why-outsourcing-fails-problems-of-outsourcing-software-development/). If you're reading this, you're probably in that group.

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

Before you send the termination email, pause. Some relationships are salvageable — and firing prematurely costs time and money too.

**Set up a 2-week test.** Weekly call with a clear agenda: what shipped, what didn't, why. If transparency improves in two weeks, the relationship might be worth saving.

**Ask yourself: did I keep moving the goalposts?** If you changed requirements mid-sprint three times, any agency would miss deadlines. An honest agency will tell you this. A bad one will absorb the scope silently and miss the date.

**Try a 30-day probation with concrete KPIs.** "80% task completion per sprint, weekly written reports, repository access within 48 hours." If they can't hit those basics, you have your answer — and you have it documented.

If none of that works, keep reading.

## The Exit Checklist: What to Secure Before You Leave

Firing a dev shop is a business operation, not a breakup text.

**Code and repositories.** Confirm you have admin access to all repositories. If you don't, request it in writing before giving notice. Get a lawyer to review your termination clause — you need exact timing and format for code handoff specified in writing. Your next developer won't wait three months for a ZIP file.

**Infrastructure credentials.** Make a list: hosting provider (AWS, Heroku, DigitalOcean), domain registrar, DNS settings, SSL certificates, email service, payment processor API keys, analytics accounts. Transfer ownership of every account to an email address you control.

**Data exports.** Export your production database, user data, uploaded files, and any third-party integrations. Don't assume you can "get it later."

**Documentation.** Request architecture diagrams, API docs, environment setup instructions, and deployment procedures. If none exist — and they probably don't — that tells you everything about the quality of the engagement.

**Legal notice.** Most agency contracts require 15-30 days written notice. Send a formal termination letter referencing the specific contract section. Keep emotion out of it.

## What Your Contract Should Have Said

Every contract I've reviewed that blew up had the same three missing pieces:

**1. Code ownership after each milestone.** You should own all source code, documentation, and IP after each paid milestone — not at the end of the project. If your contract says "upon project completion," you're hostage to a definition of "complete" that your agency controls.

**2. Termination for quality issues.** Something like: "If the provider misses two consecutive milestones or delivers code that fails acceptance criteria, the client may terminate with 7 days notice." Without this, you're stuck negotiating an exit with a partner who has no incentive to let you leave cleanly.

**3. Continuous code access from day one.** Not "access upon request." Not "we'll send you a ZIP file." Real-time, read-only access to the repository at minimum. If they push back on this, ask yourself why.

## How to Evaluate the Code You're Inheriting

You can't read code. But you can read these signals.

Hire a senior dev — a freelancer, fractional CTO, or your replacement agency — to audit the code for four hours. Here's what to ask them:

First, test coverage — below 20% means the code can't be safely changed; below 5% means it was likely [vibe-coded](/blog/ai-powered-code-reviews-transforming-development-workflows/). Second, security vulnerabilities — a basic scan takes 30 minutes. Third, deployment — can they ship a change in under 10 minutes, or is it a multi-hour manual process? Finally, code structure — organized into clear pieces, or one massive file doing everything?

This costs $500-$2,000. Skipping it costs $50,000 when you have to rebuild.

## Why This Is Worse in 2026

We rescued a codebase last quarter from a shop that had used AI to generate 90% of the code. The founder was told the MVP would be done in 6 weeks. It was — sort of. The app loaded. The demo worked. But test coverage was 2%. There was no error handling. The first time a real user did something unexpected, the app crashed and corrupted their data.

This is the "vibe coding" crisis. Developers use AI to generate entire codebases with minimal oversight. The code *looks* clean on the surface. Under the hood: no tests, no error handling, [security holes that blow up in production](/blog/from-what-start-stop-delivering-bugs-when-there-no-time-for-changes-management-agile/). When you fire one of these shops, you inherit code that's not just bad — it's untestable. There's no safety net.

A team that survives writes [tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/). A team that burns writes AI code and prays.

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

- [TSH.io: Why Outsourcing Fails](https://tsh.io/blog/why-outsourcing-fails-problems-of-outsourcing-software-development/) — 25% project failure rate, 76% provider management issues
- [CISQ: The Cost of Poor Software Quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) — $2.41 trillion annual cost in the US
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) — AI code produces 1.7x more issues than human code
- [Stripe: Developer Coefficient Report](https://litslink.com/blog/cost-of-outsourcing-software-development) — 42% of dev time spent on technical debt
- [Aaron Hall: Source Code Access Rights on Termination](https://aaronhall.com/source-code-access-rights-termination-provisions/) — Legal framework for code ownership
- [Appstronauts: Project Transition Checklist](https://appstronauts.co/blog/a-successful-software-development-project-transition-plan-checklist/) — Practical transition framework
