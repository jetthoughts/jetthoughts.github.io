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

## 5 Signs It's Time to End the Relationship

Not every problem means you should fire your agency. But if you recognize three or more of these signs, it's time to act.

**1. They've missed 3+ deadlines without a credible explanation.**
One missed deadline is a yellow flag. Three is a pattern. If they blame "unexpected complexity" every time but never flagged it early, they're not managing the project — they're reacting to it.

**2. You don't have access to the code repository.**
If you can't log into GitHub (or GitLab, or wherever the code lives) and see work happening, you don't actually own your product. You own a promise.

**3. They can't explain the architecture in plain English.**
Ask your lead developer: "If you left tomorrow, could another team pick this up in a week?" If the answer involves hedging, one person holds all the knowledge — and that's a business risk, not just a technical one.

**4. Test coverage is zero or near-zero.**
This is the fastest way to spot rot if you can't read code. Ask: "What percentage of our code is covered by automated tests?" A healthy codebase sits above 70%. If they say "we test manually," what they mean is "every change we make is a prayer." Qodo's 2025 report found AI-generated code produces [1.7x more issues](https://www.qodo.ai/reports/state-of-ai-code-quality/) than human-written code — and shops that lean on AI generation often skip tests entirely.

**5. Budget keeps growing with no clear explanation.**
Nearly half of every developer's paycheck goes to mopping up the mess the last team left — [42% of dev time](https://litslink.com/blog/cost-of-outsourcing-software-development) is spent on technical debt and bad code, according to Stripe. If your invoices keep climbing but features aren't shipping, you're paying for rework.

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

First, test coverage. Below 20% and the code can't be safely changed. Below 5% and it was likely [vibe-coded](/blog/ai-powered-code-reviews-transforming-development-workflows/) — AI-generated with no human review. Second, security vulnerabilities — a basic scan takes 30 minutes and will tell you if your users' data is exposed. The [cost of poor software quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) in the US runs $2.41 trillion annually, and your app doesn't need to contribute to that number.

Then ask about the deployment process. Can they ship a change in under 10 minutes? If deployment is a manual, multi-hour process, every future update is risky and expensive. Finally, look at code structure. Is it organized, or is it a single massive file that does everything?

This audit costs $500-$2,000 and saves you from inheriting a codebase that costs $50,000 to rebuild.

## Why This Is Worse in 2026

We rescued a codebase last quarter from a shop that had used AI to generate 90% of the code. The founder was told the MVP would be done in 6 weeks. It was — sort of. The app loaded. The demo worked. But test coverage was 2%. There was no error handling. The first time a real user did something unexpected, the app crashed and corrupted their data.

This is the "vibe coding" crisis. Developers use AI to generate entire codebases with minimal oversight. The code *looks* clean on the surface. Under the hood: no tests, no error handling, [security holes that blow up in production](/blog/from-what-start-stop-delivering-bugs-when-there-no-time-for-changes-management-agile/). When you fire one of these shops, you inherit code that's not just bad — it's untestable. There's no safety net.

A team that survives writes [tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/). A team that burns writes AI code and prays.

## Finding the Next Partner

When you're vetting the next shop, these questions will save you months of pain:

**"Can I see a sample weekly report?"** A partner worth keeping sends you a one-page email every Friday: what shipped, what hit a wall, what's next. No buzzwords.

**"Who owns the code after each milestone?"** The answer should be "you do" — with a specific contract clause, not a verbal promise.

If they can't tell you their test coverage policy by name, they don't have one. Ask for a number (above 70%) and a process. [TDD](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) is the gold standard.

**"What happens if you miss a deadline?"** Look for accountability, not excuses. A good answer: "We flag it two days early and offer options." A bad answer: "That rarely happens."

**"Can I talk to a founder you've rescued?"** Not just a happy client — one who came from a bad situation like yours.

## The Real Win

Firing a dev shop is not a failure. Staying with a bad one is.

You're about to pay twice for the same product — once for the bad code, once to rebuild it. That's the reality. The question is how much the second round costs, and that depends entirely on who you hire next.

The pattern that works: exit cleanly, audit what you have, find a partner who [writes tests first](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) and [explains everything in plain English](/blog/how-make-small-valuable-async-standups-productivity-development/). You've already learned what "bad" looks like. Now you know what to look for.

---

*In the middle of a dev shop transition? We do a free 45-minute code audit: one senior developer, your codebase, a written one-page assessment. No contract, no follow-up calls. [Get an honest audit](https://jetthoughts.com/contact-us/).*

---

We've written about the practices that prevent these disasters: how [XP practices like pair programming and CI/CD](/blog/async-remote-xp-practices/) catch problems before they ship, and how [structured delivery flow](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) keeps remote teams aligned without micromanagement.

## Further Reading

- [TSH.io: Why Outsourcing Fails](https://tsh.io/blog/why-outsourcing-fails-problems-of-outsourcing-software-development/) — 25% project failure rate, 76% provider management issues
- [CISQ: The Cost of Poor Software Quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) — $2.41 trillion annual cost in the US
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) — AI code produces 1.7x more issues than human code
- [Stripe: Developer Coefficient Report](https://litslink.com/blog/cost-of-outsourcing-software-development) — 42% of dev time spent on technical debt
- [Aaron Hall: Source Code Access Rights on Termination](https://aaronhall.com/source-code-access-rights-termination-provisions/) — Legal framework for code ownership
- [Appstronauts: Project Transition Checklist](https://appstronauts.co/blog/a-successful-software-development-project-transition-plan-checklist/) — Practical transition framework
