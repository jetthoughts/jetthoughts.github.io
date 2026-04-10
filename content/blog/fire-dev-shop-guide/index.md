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

I've watched this play out maybe forty times. You hired a team. Wrote them a check — $30K, $60K, sometimes more. Waited three months. The demo loads. The login screen looks fine. But behind it? Nobody knows. Including them, sometimes. And now you're sitting there at 11pm wondering if you should fire your development agency or give them one more sprint.

Here's what I've learned: by the time you're Googling this, you already know the answer.

[Deloitte surveyed 500+ executives](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) about their outsourcing relationships in 2024. Seventy percent had pulled work back in-house over the last five years. Seven out of ten. That's not a few unlucky founders — that's the industry.

This guide covers the exit. The practical stuff nobody talks about. What to secure tonight, what your contract probably doesn't protect, and how to not make the same mistake twice.

## How Many of These Sound Familiar?

I'm not going to tell you "if you see one red flag, that's normal." You know what normal friction looks like. This is about the pattern — three or more of these means you're past friction.

**They've missed three deadlines.** And every time it's "unexpected complexity." Fine — complexity happens. But if they never flagged the risk before the deadline? They're not managing. They're watching. There's a difference.

**You can't see the code.** I don't mean you can't read it. I mean you literally don't have a login to wherever it lives. No GitHub access. No way to see if anyone's actually working. We've taken over projects where the founder didn't know what Git was — totally fine. But your code should live in an account you own. If it doesn't, you don't own a product. You own a promise.

**Every small change breaks something else.** You ask them to change a button color. Next day, the checkout page is down. That's the sound of code with no [automated tests](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/). The team is scared to touch anything because they genuinely don't know what will break. Healthy codebases have 70%+ test coverage. If yours has 5%? Every deploy is a coin flip.

**They refuse to clean up old code.** "We can't refactor that — it's too risky." Translation: the code has no tests, so changing anything might break everything. [Technical debt compounds](/blog/fixing-slow-engineering-teams-an-extended/) like interest on a credit card. Eventually you're paying the whole invoice just to service the debt. No features. Just maintenance.

**You have no idea what's actually happening.** You ask for a status update. "It's going well." Going well how? What shipped this week? What's blocked? What's the plan for next week? A team that cares sends you a [plain-English standup](/blog/how-make-small-valuable-async-standups-productivity-development/) every day and a one-page summary every Friday. If you're guessing whether progress is real — it isn't.

**The invoices keep growing and nobody explains why.** Here's a number that'll make you sick: [42% of developer time](https://litslink.com/blog/cost-of-outsourcing-software-development) goes to dealing with technical debt and bad code. Nearly half. If your bills are climbing but nothing's launching, you're paying for rework on code that was poorly written the first time.

**They can't explain things without jargon.** Ask: "If your lead developer quit tomorrow, could a new team pick this up in a week?" Watch the face. If the answer involves hedging, one person holds all the knowledge. That's not a team. [That's a hostage situation](/blog/effective-project-onboarding-checklist-management-productivity/).

**You've stopped asking questions.** This is the one nobody talks about. If you've gone quiet because the updates make you feel stupid — or because you're afraid of what you'll hear — the relationship is already dead. You're paying them. [You have the right to know](/blog/how-know-what-your-team-doing-remote-startup/).

---

**Want to know where you actually stand?** We'll do a free 45-minute code audit. One senior developer. Your codebase. A written one-page report: test coverage, security risks, architecture assessment. No contract. No follow-up calls unless you ask for one. [Get an honest audit](https://jetthoughts.com/contact-us/).

---

## Wait — Is This Fixable?

Before you fire anyone, be honest. I've seen founders torch a relationship that was actually salvageable because they were angry, not wrong.

**Try two weeks of real transparency.** Set up a weekly call with a hard agenda. Not "how's it going?" — specific: what shipped, what didn't, what's blocked. If they suddenly start communicating the moment you set clear expectations, maybe the problem was that nobody set expectations. It happens more than you'd think.

**Check your own behavior.** Did you change the requirements mid-sprint? Three times? Any agency would miss deadlines if the target keeps moving. The good ones push back. The bad ones nod and miss quietly.

**Set three concrete numbers for the next 30 days.** 80% task completion per sprint. Weekly written reports. Repository access within 48 hours. These are basics — any [competent remote team](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) does this on autopilot. If they can't hit those for one month, you have your answer. And you have it in writing for the termination letter.

Still here? Alright. Let's talk about the exit.

## What to Secure Before You Send the Email

This is the part most guides skip. Do this tonight — before they know.

**Repository access.** Log into GitHub (or wherever the code lives). Can you see the repositories? Do you have admin rights? If not, request access in writing tomorrow morning — casually, not as an ultimatum. "Hey, for our records, can you add me as an admin on the repos?" Get this before you announce anything.

**Make a list of everything they control.** Hosting (AWS, Heroku, DigitalOcean). Domain registrar. DNS settings. SSL certificates. Email provider. Payment processor API keys. Analytics accounts. You probably don't even know all the services they signed up for on your behalf. [Nudge Security](https://www.nudgesecurity.com/) can find every SaaS account connected to your email — free trial, takes five minutes, no technical setup. For each account: do you have the login? Is it under your email or theirs? Transfer anything under their email to yours. Tonight.

**Export your data.** Production database. User records. Uploaded files. Third-party integrations. Don't assume you can get this later — I've seen agencies go silent after a termination notice. If your app runs on Heroku, AWS, or DigitalOcean, [SimpleBackups](https://simplebackups.com/) can automate database exports via a point-and-click UI (free tier available, paid from $29/month). Get it while the relationship is still cordial.

**Ask for documentation.** Architecture diagrams. API docs. Deployment procedures. Setup instructions. They probably don't have any. Here's the workaround: if your code is on GitHub, paste the repo URL into [DeepWiki](https://deepwiki.com/) — it generates a navigable wiki from your codebase in minutes. It won't replace real documentation, but it gives your next team a starting point instead of nothing. [Swimm](https://swimm.io/) does something similar and keeps docs in sync as code changes (free tier for small teams).

**Send a formal termination letter.** Most contracts require 15-30 days written notice. Reference the specific clause. Keep it factual. No blame, no emotion. "Per Section 12.3 of our agreement dated X, this letter serves as 30-day notice of termination, effective Y."

## "But I Signed a Contract!"

Yeah. And it probably doesn't protect you.

Every contract we've seen from a failed engagement is missing the same three things. Yours probably is too.

**Code ownership after each milestone.** Your contract says you own everything "upon project completion." Sounds reasonable. Except "completion" is whatever they say it is. Maybe it's six months from now. Maybe never. You need ownership after each paid milestone. Three months of payments = three months of code. Period.

**A termination clause that actually works.** "If the provider misses two consecutive milestones, the client may terminate with 7 days notice." Without something like that, firing them becomes a negotiation with someone who has zero incentive to let you leave. That's not a partnership. That's a trap.

**Real-time code access from day one.** Not "access upon request." Not a ZIP file next month. Read-only access to the repo, always on. If they push back on this — really sit with that. What are they protecting? And from whom?

Need templates? [Clerky](https://www.clerky.com) has startup-focused IP assignment and consulting agreements for $819 lifetime. Cheaper than one hour of a lawyer's time. Won't cover everything, but it covers the basics that most agency contracts miss entirely.

## Evaluating What They Left Behind

You can't read code. That's fine. Here's what to do.

Hire a senior dev for four hours. Freelancer, fractional CTO, your next agency — anyone competent. Ask them to check four things:

**Test coverage.** Below 20% and the code can't be safely modified. Below 5% and it was probably [vibe-coded](/blog/ai-powered-code-reviews-transforming-development-workflows/) — AI-generated with no human review. **Security.** A basic vulnerability scan takes 30 minutes. You need to know if your users' data is exposed. **Deployment.** Can they push a change in under 10 minutes? If it's a multi-hour manual process, every future update is expensive and risky. **Structure.** Is the code organized, or is everything crammed into one giant file?

This costs $500-$2,000. Skipping it costs $50,000 when you have to rebuild from scratch.

Can't find someone today? Start here:

- **[The Code Registry](https://thecoderegistry.com/code-auditing/)** — connect your GitHub repo, get an AI security scan and complexity score in 15 minutes. Built for non-developers.
- **[Codacy](https://www.codacy.com)** — automated code quality scanning. Free tier available. Dashboard is readable.
- **[Codekeeper](https://codekeeper.co)** — code escrow. Makes daily copies of your repo automatically. From $129/month. Set this up *before* you send the termination email.

Need someone to navigate the transition — audit the code, talk to both teams, tell you in plain English what you're actually working with? [That's what we do](https://jetthoughts.com/contact-us/). We've handled this exact handoff dozens of times and can start within 48 hours.

And one thing that costs nothing: make sure your repository lives in a [GitHub Organization you own](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository), not your agency's personal account. If you do nothing else from this article, do that. Do it now.

## The 2026 Problem: Vibe Coding

This is the part that's new. And it's ugly.

Last quarter a founder came to us after six months with what they later learned was a "vibe coding" shop. The agency had used AI to generate about 90% of the codebase. The MVP shipped on time. The founder was ecstatic. The app loaded. The demo looked polished.

Then real users showed up.

First login with a special character in the email? Crash. Two users booking the same time slot? Data corrupted. The founder called the agency. "That's an edge case," they said.

It wasn't an edge case. It was Tuesday.

Test coverage: 2%. Error handling: none. Security scan: 14 critical vulnerabilities. We had to rewrite the entire thing.

This pattern is everywhere now. AI-generated code *looks* professional — good variable names, consistent formatting, reads well. Under the hood: no tests, no error handling, [security holes that only show up when real people use the product](/blog/from-what-start-stop-delivering-bugs-when-there-no-time-for-changes-management-agile/). [Qodo's 2025 report](https://www.qodo.ai/reports/state-of-ai-code-quality/) found AI code produces 1.7x more issues than human-written code. And that's when someone reviews it. When nobody does? It's a time bomb.

A team that lasts [writes tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) and [reviews every pull request](/blog/ai-powered-code-reviews-transforming-development-workflows/). A team that burns pastes AI output and ships.

## What to Actually Look For in the Next One

Not "do they have a nice website." Irrelevant. Not "do they have a Clutch profile." Meaningless.

**Ask to see a real weekly report.** From an actual project, anonymized. A team worth hiring sends a one-page Friday email: what shipped, what hit a wall, what's next week. No jargon. We wrote about [what that looks like](/blog/how-make-small-valuable-async-standups-productivity-development/) — that's the bar.

**Ask who owns the code.** "You do" is the only acceptable answer. Backed by a contract clause.

**Ask about their testing policy.** If they can't give you a number and a methodology, they don't have one. [TDD](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) — writing tests before code — is the difference between shops that ship safely and shops that ship and pray. Especially now, when so much code is AI-generated. Without tests, nobody — not even the developers — knows if the code works.

**Ask how deploys work.** Good teams [deploy daily](/blog/async-remote-xp-practices/). Nothing breaks. Bad teams deploy monthly and everyone holds their breath. If deploys are scary, the code is fragile.

**Ask to talk to a founder they've rescued.** Not their happiest client. Someone who came from a situation like yours. If they can't produce one, they haven't done this before.

**Watch the first week.** Did they send an [onboarding checklist](/blog/effective-project-onboarding-checklist-management-productivity/)? Set up a project board? Explain their [delivery flow](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/)? The first week tells you everything about the next six months.

## The Uncomfortable Truth

Firing a dev shop feels like failure. It isn't. Staying with a bad one is.

Here's what nobody tells you: you're going to pay twice for the same product. Once for the bad code, once to fix it. That's the tax. The question is just how big the second bill is. And that depends entirely on who you hire next and what they find when they open the hood.

Exit cleanly. Audit what you have. Find a partner who writes tests before code and explains everything in language you actually understand. You already know what bad looks like — you just lived through it. Trust that.

---

*In the middle of a transition right now? We'll audit your codebase for free. 45 minutes. One senior developer. A written one-page assessment. No contract, no follow-up calls. [Get an honest audit](https://jetthoughts.com/contact-us/).*

---

We've been writing about the practices that prevent these disasters. The ones that matter most if you're evaluating your next partner:

- [Async-first XP practices](/blog/async-remote-xp-practices/) — pair programming and CI/CD across timezones, zero regressions
- [Delivery flow for remote teams](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) — Kanban that keeps everyone aligned without micromanagement
- [Shape Up for founders](/blog/shape-up-founders-guide-not-wasting-your-runway-startup-tutorial/) — 6-week cycles that protect your runway
- [Fixing slow engineering teams](/blog/fixing-slow-engineering-teams-an-extended/) — monthly releases to daily deploys in 60 days
- [Code quality signals for non-technical founders](/blog/code-quality-evaluation-non-technical-founders/) — the 5 things you can actually read
- [Our onboarding checklist](/blog/effective-project-onboarding-checklist-management-productivity/) — day one, no chaos
- [Red flags in big PRs](/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/) — why we split anything over 500 lines

## Further Reading

- [Deloitte 2024 Global Outsourcing Survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) — 70% of executives insourced previously outsourced work
- [CISQ: The Cost of Poor Software Quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) — $2.41 trillion annual cost in the US
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) — AI code produces 1.7x more issues than human code
- [Stripe: Developer Coefficient Report](https://litslink.com/blog/cost-of-outsourcing-software-development) — 42% of dev time spent on technical debt
- [Aaron Hall: Source Code Access on Termination](https://aaronhall.com/source-code-access-rights-termination-provisions/) — legal framework for code ownership
- [Appstronauts: Project Transition Checklist](https://appstronauts.co/blog/a-successful-software-development-project-transition-plan-checklist/) — practical transition framework
