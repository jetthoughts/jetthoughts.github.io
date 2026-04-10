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

Your agency isn't ghosting you. It's hiding bad code. If you need to fire your development agency, this guide walks you through every step — from recognizing the signs to securing your code to finding a better partner.

If you're reading this, you probably already know something is wrong. Deadlines keep slipping. The demo looks fine but nothing works behind the scenes. You ask for a timeline and get vague answers. You're not crazy — and you're not alone. According to TSH.io, **25% of outsourced software projects fail or significantly underperform**, and 76% of companies report serious issues managing their development providers.

This is your step-by-step guide to firing your dev shop, securing your assets, and finding a partner who won't repeat the pattern.

## 5 Signs It's Time to End the Relationship

Not every problem means you should fire your agency. But if you recognize three or more of these signs, it's time to act.

**1. They've missed 3+ deadlines without a credible explanation.**
One missed deadline is a yellow flag. Three is a pattern. If they blame "unexpected complexity" every time but never flagged it early, they're not managing the project — they're reacting to it.

**2. You don't have access to the code repository.**
If you can't log into GitHub (or GitLab, or wherever the code lives) and see commits happening, you don't actually own your product. You own a promise.

**3. They can't explain the architecture in plain English.**
Ask your lead developer: "If you were hit by a bus tomorrow, could another team pick this up in a week?" If the answer involves hedging, you have a bus factor of one — and that's a business risk.

**4. Test coverage is zero or near-zero.**
This is the single most reliable non-technical signal. Ask: "What percentage of our code is covered by automated tests?" A healthy codebase sits above 70%. If the answer is "we don't track that" or "we test manually," the code is fragile. According to Qodo's 2025 State of AI Code Quality report, AI-generated code produces **1.7x more issues** than human-written code — and shops that rely heavily on AI generation often skip tests entirely.

**5. Budget keeps growing with no clear explanation.**
Stripe's Developer Coefficient report estimates developers spend **42% of their time** dealing with technical debt and bad code. If your invoices keep climbing but features aren't shipping, you're paying for rework on code that was written poorly the first time.

## The Exit Checklist: What to Secure Before You Leave

Firing a dev shop is a business operation, not a breakup text. Treat it like one.

**Code and repositories.** Confirm you have admin access to all repositories. If you don't, request it in writing before giving notice. Attorney Aaron Hall notes that contracts should specify exact delivery timing and format for source code upon termination — if yours doesn't, negotiate this before you announce the split.

**Infrastructure credentials.** Make a list: hosting provider (AWS, Heroku, DigitalOcean), domain registrar, DNS settings, SSL certificates, email service, payment processor API keys, analytics accounts. Transfer ownership of every account to an email address you control.

**Data exports.** Export your production database, user data, uploaded files, and any third-party integrations. Don't assume you can "get it later."

**Documentation.** Request architecture diagrams, API documentation, environment setup instructions, and deployment procedures. If none exist, that tells you something important about the quality of the engagement.

**Legal notice.** Review your contract's termination clause. Most agency contracts require 15-30 days written notice. Send a formal termination letter referencing the specific contract section. Keep emotion out of it.

## What Your Contract Should Have Said

Most founder-agency contracts are missing three critical clauses:

**1. Code ownership after each milestone.** The contract should state that you own all source code, documentation, and intellectual property after each paid milestone — not at the end of the project. If your contract says "upon project completion," you're hostage to a definition of "complete" that your agency controls.

**2. Termination for quality issues.** A good contract includes: "If the provider misses two consecutive milestones or delivers code that fails acceptance criteria, the client may terminate with 7 days notice." Without this, you're stuck negotiating an exit with a partner who has no incentive to let you leave cleanly.

**3. Source code escrow or continuous access.** You should have real-time access to the code repository from day one. Not "access upon request." Not "we'll give you a ZIP file." Continuous, read-only access at minimum.

## How to Evaluate the Code You're Inheriting

You can't read code. But you can read these signals.

Ask a senior developer (a freelancer for a day, a fractional CTO, or your next agency) to run a 4-hour code audit. Here's what they should report:

- **Test coverage percentage.** Below 20% means the code can't be safely changed. Below 5% means it was likely [vibe-coded](/blog/ai-powered-code-reviews-transforming-development-workfl/) — AI-generated with no human review.
- **Number of critical security vulnerabilities.** Run a basic OWASP scan. The 2024 CISQ report found that poor software quality costs the US economy **$2.41 trillion annually**.
- **Deployment pipeline.** Does one exist? Can it deploy to production in under 10 minutes? If deployment is a manual, multi-hour process, every future change is risky and expensive.
- **Code architecture.** Is there a clear separation of concerns? Or is it a single 5,000-line file that does everything?

This audit costs $500-$2,000 and saves you from inheriting a codebase that costs $50,000 to rewrite.

## Why This Is Worse in 2026

The "vibe coding" trend — where developers use AI to generate entire codebases with minimal human oversight — has created a new class of dev shop disaster. These shops promise fast delivery at low cost. The code looks clean on the surface. But it has no tests, no error handling, and [security vulnerabilities that only show up in production](/blog/from-what-start-stop-delivering-bugs-when-there-no-time/).

When you fire one of these shops, you inherit code that's not just bad — it's untestable. There's no safety net. Every change risks breaking something else. A disciplined team writes tests first and reviews every pull request. An undisciplined team pastes AI output and ships it.

## Finding the Next Partner Without Repeating the Mistake

Before you sign with another agency, ask these five questions:

1. **"Can I see a sample weekly report?"** A good partner produces plain-English reports: what was done, what's blocked, what's next. No jargon.
2. **"Who owns the code after each milestone?"** The answer should be "you do" with a specific contract clause.
3. **"What's your test coverage policy?"** The answer should be a number (>70%) and a process ([TDD](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutor/)).
4. **"What happens if you miss a deadline?"** Look for accountability, not excuses.
5. **"Can I talk to a founder you've rescued?"** Not just a happy client — one who came from a bad situation.

## When NOT to Fire Your Dev Shop

Sometimes the relationship is salvageable. Before you terminate:

- **Try a structured retrospective.** Set up a weekly call with clear agenda: what shipped, what didn't, why. Give it 2-3 weeks. If transparency improves, the relationship may be fixable.
- **Check if the problem is scope, not skill.** If you keep changing requirements mid-sprint, any agency will miss deadlines. An honest agency will tell you this. A bad one will just absorb the scope and miss the date.
- **Consider a probation period.** "We'll continue for 30 days with these specific KPIs: 80% task completion per sprint, weekly written reports, git access within 48 hours." If they can't hit those basics, you have your answer.

## The Real Win

Firing a dev shop is not a failure. Staying with a bad one is. The cost of poor software quality is real: that $2.41 trillion CISQ number isn't theoretical. It's the sum of every startup that paid twice — once for bad code, once to rebuild it.

The pattern that works: exit cleanly, audit what you have, find a partner who writes tests first and [explains everything in plain English](/blog/how-make-small-valuable-async-standups-productivity-dev/). You've already learned what "bad" looks like. Now you know what to look for.

---

*If you're in the middle of a dev shop transition, we offer a free 30-minute code audit call. No pitch — just an honest assessment of what you're working with. [Schedule a call](https://www.jetthoughts.com/contact).*

---

We've written about the patterns that prevent these disasters: how we use [XP practices like pair programming and CI/CD](/blog/async-remote-xp-practices/) to catch problems before they ship, and how [structured delivery flow for remote teams](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) keeps everyone aligned without micromanagement.

## Further Reading

- [TSH.io: Why Outsourcing Fails — Problems of Outsourcing Software Development](https://tsh.io/blog/why-outsourcing-fails-problems-of-outsourcing-software-development/) — 25% project failure rate, 76% provider management issues
- [CISQ / Cloud Data Insights: The Cost of Poor Software Quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) — $2.41 trillion annual cost in the US
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) — AI code produces 1.7x more issues than human code
- [Stripe: Developer Coefficient Report](https://litslink.com/blog/cost-of-outsourcing-software-development) — 42% of dev time spent on technical debt
- [Aaron Hall, Attorney: Source Code Access Rights in Termination Provisions](https://aaronhall.com/source-code-access-rights-termination-provisions/) — Legal framework for code ownership on termination
- [Appstronauts: Software Development Project Transition Checklist](https://appstronauts.co/blog/a-successful-software-development-project-transition-plan-checklist/) — Practical transition framework
