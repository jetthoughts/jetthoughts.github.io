---
title: "Red Flags You Hired the Wrong Dev Shop"
description: "The worst dev shops don't miss deadlines - they miss them quietly. Eight warning signs your agency is hiding bad code, and what to do about it."
date: 2026-04-23
draft: false
author: "JetThoughts Team"
slug: "dev-shop-red-flags-checklist"
keywords: "bad development agency signs, dev shop warning signs, how to know if your developer is good"
tags: ["startup", "hiring", "dev-agency", "founder", "outsourcing"]
categories: ["Startup"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "8 Red Flags You Hired the Wrong Dev Shop"
  og_description: "Two-thirds of software projects fail or go over budget. Eight warning signs your agency is hiding bad code - and the exact steps to take tonight."
cover_image_alt: "JetThoughts blog cover for Dev Shop Red Flags Checklist with warning sign stats"
canonical_url: "https://jetthoughts.com/blog/dev-shop-red-flags-checklist/"
---

The worst dev shops don't miss deadlines. They miss them quietly.

You hired a team and wrote them a check. Weeks pass, maybe months, and the updates sound fine - "making progress," "almost there." Then one day you realize you've spent $40K and you can't demo a single working feature to your investors. If you're searching for confirmation that something's wrong with your dev shop, it is.

The [Standish Group's CHAOS report](https://www.projectsmart.co.uk/white-papers/chaos-report.pdf) tracks software project outcomes every year. In 2024: 19% of projects failed outright. Another 47% were "challenged" - late, over budget, or missing features. That's two-thirds. For startups with outsourced agencies? Worse.

I've compiled eight dev shop warning signs from twenty years of cleaning up after agencies. Recognize three or more and you've got a problem. Five? That's an emergency.

## 1. No Git Access for You

Git is the system developers use to store and track every code change. Think of it like Google Docs version history, but for software. You should have read access to it. Always.

"But I can't read code," you say. Doesn't matter - your next hire can, and so can a technical advisor or [fractional CTO](/blog/fractional-cto-comprehensive-review-of-first-two-weeks-in-startup-consulting-management/). You own this code because you paid for it. If they won't let you see it, [ask yourself why](/blog/how-know-what-your-team-doing-remote-startup/). What are they protecting? And from whom?

A founder on [r/startups](https://www.reddit.com/r/startups/) put it bluntly: "I asked for repo access and they said 'we'll transfer everything at the end.' There was no end. They ghosted." Code should live in a GitHub organization you own from day one, not theirs.

## 2. "We'll Show You When It's Done"

This is the big one. A healthy team shows you working software every one to two weeks - not a slide deck or a Figma mockup, but something you can click and watch things happen.

If your agency only shows you the finished product, you've already lost the ability to course-correct, to catch misunderstandings early, to say "wait, that's not what I meant" before it's too expensive to fix.

Good teams send [plain-English async standups](/blog/how-make-small-valuable-async-standups-productivity-development/) daily and a one-page summary every Friday covering what shipped, what's blocked, and what's next - all in plain English. If you're guessing whether progress is real, it isn't.

## 3. Estimates That Keep Growing

The project was $30K. Then $45K. Now they're hinting at $60K and the feature list got shorter.

Here's what's actually happening: they either quoted too low to win the deal, or they're drowning in [technical debt](/blog/fixing-slow-engineering-teams-an-extended/) - rework caused by code that was badly written the first time. [LitsLink reports](https://litslink.com/blog/cost-of-outsourcing-software-development) that developers spend 42% of their time on technical debt and maintenance. Nearly half their hours go to fixing old mistakes, not building new features.

Budget creep usually means the team didn't plan or test properly, and now they don't want to tell you the real number.

## 4. No Automated Tests

Automated tests are the single thing that separates codebases that survive from ones that don't.

They're tiny programs that check whether your software works. Every time a developer changes something, these tests run automatically and say "yes, everything still works" or "no, you just broke checkout." Without them, nobody knows what's broken until a real user finds it - maybe your biggest customer, maybe on launch day.

A healthy codebase has 70%+ test coverage. Ask your agency for the number. If they hedge or change the subject, the answer is close to zero.

We screwed this up early in our own history - took over a project once and assumed the existing tests were solid. They weren't - they were decorative, passing every time because they didn't actually test anything. Now we [write tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/), every time. It's slower on day one but dramatically faster by month two.

### Why This Is Worse in 2026

The rise of ["vibe coding"](/blog/vibe-coding-crisis-ai-code-debt/) - agencies using AI to generate 90%+ of the codebase - has made this red flag catastrophic. AI-generated code looks clean - good variable names, consistent formatting, reads like a textbook.

But the developers who generated it never wrote tests, never handled errors, and never checked edge cases. [Qodo's 2025 report](https://www.qodo.ai/reports/state-of-ai-code-quality/) found AI-generated code produces 1.7x more issues than human-written code. And when [Veracode tested over 100 LLMs](https://www.veracode.com/blog/genai-code-security-report/), 45% of the generated code contained exploitable security flaws.

The vibe coding shops skip tests entirely because the AI output "looks like it works." It does - until real users show up. Then everything breaks at once, and you're paying emergency rates to fix code that should never have shipped.

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

## 7. They Blame the Previous Team and Push for a Rewrite

"The last developer wrote terrible code. We need to start over."

Sometimes that's true. But we've watched founders pay for two full rewrites by two different agencies, each one trashing the work that came before. The codebase didn't improve either time because neither team enforced testing or code review - they just rewrote the same problems in a different style.

A good team opens an inherited codebase and says "here's what's working, here's what needs fixing, and here's the cost of each option." They give you a repair estimate alongside a rewrite estimate and explain the trade-offs. A bad team skips the diagnosis entirely because a rewrite is easier to sell - and it resets the clock on accountability. If everything is new code, nobody can blame them for the old bugs. At least not for six months.

When your agency's first move is "throw it all away and let us rebuild," ask them to show you the specific technical problems that make a rescue impossible. If they can't name them, they're selling you a fresh start they haven't earned.

## 8. Invoice Surprises

"This month was $12K instead of $8K because we had to handle some infrastructure issues."

What infrastructure issues? When were they flagged? Why didn't anyone mention this before the bill arrived?

Good teams track hours per task and share them weekly. You know exactly where money goes. You see overages coming before they arrive. [Deloitte's 2024 Global Outsourcing Survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) found that 70% of executives had pulled outsourced work back in-house - budget unpredictability was a top driver.

Invoice surprises are a symptom. If the bill shocks you, you were kept in the dark.

---

If three or more of these sound familiar, we do a free 45-minute code audit. One senior developer looks at your codebase and writes a one-page assessment: test coverage, security risks, architecture quality. No contract. No follow-up calls unless you ask. [Get an honest audit](https://jetthoughts.com/contact-us/).

---

## The Green Flags: What Good Looks Like

Not every agency is bad. The good ones give you repo access from day one and show working software every week or two. They [write tests before code](/blog/why-how-use-tdd-main-tips-testing/) as a default, and they document decisions where you can find them.

A written update arrives every Friday - what shipped, what's blocked, what's next. Estimates include a range and a risk list: "8-12 weeks, with these three things that could push it to 14." At least two people understand every part of the system. Invoices match expectations because they told you what they'd cost before they cost it.

## The Scorecard

Count your red flags. Be honest.

| Red flags | What it means | What to do |
|-----------|--------------|------------|
| 0-1 | Normal friction | Set clearer expectations and revisit in 30 days |
| 2 | Yellow zone | Have a direct conversation with specific examples. Set measurable goals: "repo access by Friday, weekly written update by Monday, test coverage number by end of month." If they can't hit those basic asks, you have your answer |
| 3-4 | Orange zone | Start your exit plan. Secure code access, export your data, get a second opinion. Don't fire them yet - but be ready. Read our [guide to firing your dev shop safely](/blog/fire-dev-shop-guide/) |
| 5+ | Red zone | You're paying for damage, not progress. Begin the transition now. The longer you wait, the more expensive the cleanup |

## What to Do If You See 3+ Red Flags

Don't panic. Don't send an angry email at midnight. Here's the sequence.

The first thing you do - tonight, not tomorrow - is verify you have access to your code repository, hosting accounts, domain registrar, and all third-party services. If anything is under their email instead of yours, start transferring it.

This week, get a second opinion. Hire a freelance senior developer or [fractional CTO](/blog/fractional-cto-comprehensive-review-of-first-two-weeks-in-startup-consulting-management/) for 4 hours. Have them look at the code and tell you - in plain English - what shape it's in. This costs $500-$2,000 and might be the most important money you spend this year.

Within 30 days, make a decision. Either set measurable improvement targets (repo access, weekly reports, test coverage number) with a hard deadline, or begin the exit. Our [step-by-step exit guide](/blog/fire-dev-shop-guide/) covers the mechanics, and if you need someone to manage the transition, the [5 warning signs you need technical leadership](/blog/5-warning-signs-your-startup-needs-technical-leadership/) will help you decide.

Before you hire the next team, don't fall into the [outsourcing trap](/blog/outsourcing-trap-why-your-product-deserves-better-startup-tutorial/) twice. Ask for a sample weekly report, a real test coverage number, and a contract with milestone-based code ownership. Those three things filter out 80% of bad agencies.

If you're evaluating your current team or vetting the next one:

- [Code quality signals for non-technical founders](/blog/code-quality-evaluation-non-technical-founders/)
- [What real daily standups look like](/blog/how-make-small-valuable-async-standups-productivity-development/)
- [Structured onboarding vs chaos](/blog/how-does-onboarding-look-like-in-jetthoughts-productivity-startup/)

## Further Reading

- [Standish Group CHAOS Report](https://www.projectsmart.co.uk/white-papers/chaos-report.pdf) - 19% failure rate, 47% challenged; two-thirds of projects don't finish as planned
- [Deloitte 2024 Global Outsourcing Survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) - 70% of executives pulled outsourced work back in-house
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) - AI-generated code produces 1.7x more issues than human-written code
- [LitsLink: Cost of Outsourcing Software Development](https://litslink.com/blog/cost-of-outsourcing-software-development) - 42% of developer time goes to technical debt
- [Clutch: State of Software Development](https://clutch.co/resources/state-of-software-development) - survey data on outsourcing challenges and budget overruns
- [Veracode GenAI Code Security Report](https://www.veracode.com/blog/genai-code-security-report/) - 45% of AI-generated code contains exploitable vulnerabilities
