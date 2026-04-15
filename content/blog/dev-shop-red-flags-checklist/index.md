---
title: "Red Flags You Hired the Wrong Dev Shop"
description: "The worst dev shops don't miss deadlines — they miss them quietly. Seven warning signs your agency is hiding bad code, and what to do about it."
date: 2026-04-28T08:00:00+02:00
draft: true
author: "JetThoughts"
slug: "dev-shop-red-flags-checklist"
keywords: "bad development agency signs, dev shop warning signs, how to know if your developer is good"
tags: ["startup", "hiring", "dev-agency", "founder", "outsourcing"]
categories: ["Startup"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "7 Red Flags You Hired the Wrong Dev Shop"
  og_description: "Two-thirds of software projects fail or go over budget. Seven warning signs your agency is hiding bad code — and the exact steps to take tonight."
cover_image_alt: "JetThoughts blog cover for Dev Shop Red Flags Checklist with warning sign stats"
canonical_url: "https://jetthoughts.com/blog/dev-shop-red-flags-checklist/"
---

The worst dev shops don't miss deadlines. They miss them quietly.

You hired a team. You wrote them a check. Weeks pass, maybe months. The updates sound fine. "Making progress." "Almost there." Then one day you realize you've spent $40K and you can't demo a single working feature to your investors. If you're searching for confirmation that something's wrong with your dev shop, it is.

The [Standish Group's CHAOS report](https://www.projectsmart.co.uk/white-papers/chaos-report.pdf) tracks software project outcomes every year. In 2024: 19% of projects failed outright. Another 47% were "challenged" — late, over budget, or missing features. That's two-thirds. For startups with outsourced agencies? Worse.

I've compiled seven dev shop warning signs from twenty years of cleaning up after agencies. Recognize three or more and you've got a problem. Five? That's an emergency.

## 1. No Git Access for You

Git is the system developers use to store and track every code change. Think of it like Google Docs version history, but for software. You should have read access to it. Always.

"But I can't read code," you say. Doesn't matter. Your next hire can. Your technical advisor can. Your fractional CTO can. The point is: you own this code. You paid for it. If they won't let you see it, [ask yourself why](/blog/how-know-what-your-team-doing-remote-startup/). What are they protecting? And from whom?

A founder on [r/startups](https://www.reddit.com/r/startups/) put it bluntly: "I asked for repo access and they said 'we'll transfer everything at the end.' There was no end. They ghosted." Code should live in a GitHub organization you own from day one. Not their account. Yours.

## 2. "We'll Show You When It's Done"

This is the big one. A healthy team shows you working software every one to two weeks. Not a slide deck. Not a Figma mockup. Working software — you click buttons, things happen.

If your agency only shows you the finished product, you've already lost the ability to course-correct, to catch misunderstandings early, to say "wait, that's not what I meant" before it's too expensive to fix.

Good teams send [plain-English async standups](/blog/how-make-small-valuable-async-standups-productivity-development/) daily and a one-page summary every Friday. No jargon. What shipped, what's blocked, what's next. If you're guessing whether progress is real, it isn't.

## 3. Estimates That Keep Growing

The project was $30K. Then $45K. Now they're hinting at $60K and the feature list got shorter.

Here's what's actually happening: they either quoted too low to win the deal, or they're drowning in [technical debt](/blog/fixing-slow-engineering-teams-an-extended/) — rework caused by code that was badly written the first time. [LitsLink reports](https://litslink.com/blog/cost-of-outsourcing-software-development) that developers spend 42% of their time on technical debt and maintenance. Nearly half their hours go to fixing old mistakes, not building new features.

Budget creep usually means nobody planned, nobody tested, and nobody wants to tell you the real number.

## 4. No Automated Tests

Automated tests are the single thing that separates codebases that survive from ones that don't.

They're tiny programs that check whether your software works. Every time a developer changes something, these tests run automatically and say "yes, everything still works" or "no, you just broke checkout." Without them, nobody knows what's broken until a real user finds it. Maybe your user. Maybe on launch day.

A healthy codebase has 70%+ test coverage. Ask your agency for the number. If they hedge or change the subject, the answer is close to zero.

We screwed this up early in our own history — took over a project once and assumed the existing tests were solid. They weren't. They were decorative. Passed every time because they didn't actually test anything. Now we [write tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/), every time. It's slower on day one. It's dramatically faster by month two.

### Why This Is Worse in 2026

The rise of ["vibe coding"](/blog/vibe-coding-crisis-ai-code-debt/) — agencies using AI to generate 90%+ of the codebase — has made this red flag catastrophic. AI-generated code looks clean. Good variable names. Consistent formatting. Reads like a textbook.

But it has no tests. No error handling. No edge cases. [Qodo's 2025 report](https://www.qodo.ai/reports/state-of-ai-code-quality/) found AI-generated code produces 1.7x more issues than human-written code. And 45% of AI-generated code has [OWASP security vulnerabilities](https://snyk.io/reports/ai-code-security/).

The vibe coding shops skip tests entirely because the AI output "looks like it works." It does — until real users show up. Then everything breaks at once, and you're paying emergency rates to fix code that should never have shipped.

If your agency can't tell you their test coverage number, they might not have tests. If they don't have tests and they're shipping fast, they're probably vibe coding. Run.

## 5. Can't Explain Technical Decisions in Plain English

"We're refactoring the microservices architecture to improve the API gateway throughput."

What does that mean? If your developer can't explain it in words your mom would understand, one of two things is true: they don't understand it themselves, or they're hiding behind jargon so you stop asking questions.

Every technical decision costs you money or saves it. Ask which. "We're splitting the code into smaller pieces so that when one part breaks, the rest keeps working." That's the same thing, in English. A good team [explains decisions plainly](/blog/code-quality-evaluation-non-technical-founders/) because they want you to make informed choices. A bad team explains nothing because they don't want you involved.

## 6. Single Point of Failure

Ask: "If your lead developer quit tomorrow, what happens?"

If the answer involves panic, you have a bus factor (industry term for "what happens if someone gets hit by a bus") of one. One person holds the passwords, understands the architecture, knows why that weird workaround exists. Everyone else is guessing.

Good teams practice [structured onboarding](/blog/how-does-onboarding-look-like-in-jetthoughts-productivity-startup/) and pair programming so knowledge spreads across at least two or three people. Decisions get documented. Code gets [reviewed by someone who didn't write it](/blog/ai-powered-code-reviews-transforming-development-workflows/). If one person leaves, the project slows down. It doesn't stop.

A founder on Indie Hackers shared: "My agency's senior dev left. The other two couldn't explain half the codebase. I was paying three people's salaries for one person's output." That's the cost of a single point of failure.

## 7. Invoice Surprises

"This month was $12K instead of $8K because we had to handle some infrastructure issues."

What infrastructure issues? When were they flagged? Why didn't anyone mention this before the bill arrived?

Good teams track hours per task and share them weekly. You know exactly where money goes. You see overages coming before they arrive. [Deloitte's 2024 Global Outsourcing Survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) found that 70% of executives had pulled outsourced work back in-house — budget unpredictability was a top driver.

Invoice surprises are a symptom. If the bill shocks you, you were kept in the dark.

---

**Recognizing too many of these?** We do a free 45-minute code audit. One senior developer. Your codebase. A written one-page assessment: test coverage, security risks, architecture quality. No contract. No follow-up calls unless you ask. [Get an honest audit](https://jetthoughts.com/contact-us/).

---

## The Green Flags: What Good Looks Like

Not every agency is bad. The good ones give you repo access from day one, show working software every 1-2 weeks, and write tests before code ([TDD](/blog/why-how-use-tdd-main-tips-testing/)) as a default.

A written update arrives every Friday — what shipped, what's blocked, what's next. Estimates include a range and a risk list: "8-12 weeks, with these three things that could push it to 14." At least two people understand every part of the system. Invoices match expectations because they told you what they'd cost before they cost it.

## The Scorecard

Count your red flags. Be honest.

**0-1 red flags:** Normal friction. Set clearer expectations and revisit in 30 days.

**2 red flags:** Yellow zone. Have a direct conversation. Reference specific examples. Set measurable goals for the next 4 weeks: "I need repo access by Friday. I need a weekly written update starting next Monday. I need a test coverage number by end of month." If they can't hit those — basic asks — you have your answer.

**3-4 red flags:** Orange zone. Start your exit plan. Secure code access, export your data, get a second opinion on the codebase. Don't fire them yet — but be ready. Read our [guide to firing your dev shop safely](/blog/fire-dev-shop-guide/) before you do anything.

**5+ red flags:** Red zone. You're paying for damage, not progress. Begin the transition now. The longer you wait, the more expensive the cleanup.

## What to Do If You See 3+ Red Flags

Don't panic. Don't send an angry email at midnight. Here's the sequence:

**Tonight:** Verify you have access to your code repository, hosting accounts, domain registrar, and all third-party services. If anything is under their email instead of yours, start transferring it.

**This week:** Get a second opinion. Hire a freelance senior developer or fractional CTO for 4 hours. Have them look at the code and tell you — in plain English — what shape it's in. This costs $500-$2,000 and might be the most important money you spend this year.

**Within 30 days:** Make a decision. Either set measurable improvement targets (repo access, weekly reports, test coverage number) with a hard deadline, or begin the exit. Read our [step-by-step exit guide](/blog/fire-dev-shop-guide/) and the [5 warning signs you need technical leadership](/blog/5-warning-signs-your-startup-needs-technical-leadership/) to bring in someone who can navigate the transition.

**Don't fall into the [outsourcing trap](/blog/outsourcing-trap-why-your-product-deserves-better-startup-tutorial/) twice.** Before you hire the next team, ask for a sample weekly report, a real test coverage number, and a contract with milestone-based code ownership. Those three things filter out 80% of bad agencies.

If you're evaluating your current team or vetting the next one:

- [Code quality signals for non-technical founders](/blog/code-quality-evaluation-non-technical-founders/)
- [What real daily standups look like](/blog/how-make-small-valuable-async-standups-productivity-development/)
- [Structured onboarding vs chaos](/blog/how-does-onboarding-look-like-in-jetthoughts-productivity-startup/)

## Further Reading

- [Standish Group CHAOS Report](https://www.projectsmart.co.uk/white-papers/chaos-report.pdf) — 19% failure rate, 47% challenged; two-thirds of projects don't finish as planned
- [Deloitte 2024 Global Outsourcing Survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) — 70% of executives pulled outsourced work back in-house
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) — AI-generated code produces 1.7x more issues than human-written code
- [LitsLink: Cost of Outsourcing Software Development](https://litslink.com/blog/cost-of-outsourcing-software-development) — 42% of developer time goes to technical debt
- [Clutch: Challenges of Outsourcing Software Development](https://clutch.co/resources/challenges-of-outsourcing-software-development) — survey data on communication failures and budget overruns
- [Snyk: AI Code Security Report](https://snyk.io/reports/ai-code-security/) — 45% of AI-generated code contains OWASP vulnerabilities
