---
title: "5 Questions Before Hiring a Dev Shop"
description: "Most founders ask 'what's your rate?' first. Here are the 5 questions that predict whether a dev shop will deliver - or disappear with your code."
date: 2026-04-27
draft: false
author: "JetThoughts Team"
slug: "hiring-dev-shop-questions"
keywords: "questions before hiring dev agency, what to look for in a dev shop, hiring software development company"
tags: ["startup", "hiring", "dev-agency", "founder", "outsourcing"]
categories: ["Startup"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "5 Questions Before Hiring a Dev Shop"
  og_description: "Most founders ask 'what's your rate?' first - that's the wrong question. Here are the 5 questions that predict whether a dev shop will deliver or disappear."
cover_image_alt: "Founder reviewing questions before hiring a development agency"
canonical_url: "https://jetthoughts.com/blog/hiring-dev-shop-questions/"
---

Most founders ask "what's your rate?" first. That's the last question you should ask, and the four that come before it predict more than price ever will.

If you're reading this, the last engagement probably didn't go well. Now you're about to hire again, and you want to make a different mistake this time.

## Question 1: "Can I see a sample weekly report?"

This is your transparency test, and it usually fails inside the first two minutes. A dev shop that won't show you a real weekly report is hiding something - whether that's chaos, idle hours, or a project they don't understand. [Research from Clutch](https://clutch.co/agencies/software-developers) shows that 72% of failed development partnerships cite "poor communication" as the primary issue.

A good report tells you what shipped this week, what's blocked, what's next, and a code health score covering test coverage, critical bugs, and deployment frequency. It fits on one page, reads in plain English, and lets a non-technical founder know exactly where the project stands without translating jargon.

A bad report looks like one of these:
- "Progress is being made"
- A list of Jira tickets with no context
- A spreadsheet of hours billed
- Nothing at all

A B2B fintech founder we worked with in early 2025 hired a 14-person offshore shop that put "transparent communication" at the top of their pitch deck. Week three, she asked for a status report and got back a screenshot of a Slack channel showing three engineers debating a database migration she hadn't approved. Week six, the project lead stopped answering email entirely while the shop's invoicing portal kept billing her card on the first of every month. By the time she called us, $48K had cleared and two pre-seed investors were asking for a demo she couldn't show.

If a dev shop can't or won't show you a sample report in the first call, they don't produce them - so walk away before you sign anything. (See our [red flags checklist](/blog/dev-shop-red-flags-checklist/) for more warning signs like this.)

## Question 2: "Who owns the code after each milestone?"

Transparency only matters if you can act on it, which brings us to your lock-in test. Some shops will build your entire app, hand you a folder of files, and leave you unable to do anything with it because they still own the Git repository, the deployment keys, or the API credentials your business runs on.

A good answer sounds like this: "You own it completely after every milestone. It's in our contract, and here's the GitHub ownership transfer clause." They can show you a real contract with a real date and a clear handoff process.

A bad answer sounds like "We'll transfer it to you at the end" or "It's all in our secure repository." Both mean they keep your code until you pay the final invoice, and even then you're dependent on them for access whenever something breaks.

We took over a Rails 7 project in Q3 2025 where the founder had paid $180K over eight months before the shop stopped answering email. She had no admin access to the GitHub org, the AWS console belonged to the previous shop's CTO, and the Stripe keys were registered under their corporate account. The app was live serving 4,200 paying users, and she couldn't ship a hotfix when checkout broke. Recovery took three weeks: two for legal to compel credential transfer, one for our team to audit the codebase and rotate every secret.

Get the code ownership clause in writing before you sign anything binding. If you're already locked in, read our [guide to firing your dev shop](/blog/fire-dev-shop-guide/) for exit strategies that protect your IP.

## Question 3: "What happens if you miss a deadline?"

Code ownership protects you on the back end, but accountability protects you while the project is still moving - and that's where most contracts go quiet. Most dev shops don't want to answer this question because they already know they'll miss deadlines, and they'd rather not put consequences in writing where you can hold them to it.

A good answer is concrete: "We have milestone-based SLAs in the contract. If we miss a deadline by more than X days, you can terminate the engagement." A specific number that's enforceable if it ever comes to that.

A bad answer sounds like "We rarely miss deadlines," or "It depends on scope changes," or "We'll communicate if it looks risky." Each one is a different way of dodging the same commitment.

"Rarely miss deadlines" means they've already sorted your deadlines into ones they'll hit and ones they'll let slip, and you don't get to know which is which until you're three weeks late. "It depends on scope changes" means they'll renegotiate the deadline the week it's due, after they've already missed it and you have no leverage left.

A SaaS founder building a vertical CRM for property managers signed a $135K fixed-bid contract with a US-based shop that promised a 12-week MVP. Week 14, she asked for a status update and the project manager explained they had "misunderstood" the multi-tenant requirements they'd quoted on. Week 16, she realized the booking module couldn't handle a property manager with more than one client portfolio - the core use case her three pilot customers had already signed letters of intent for. Week 18, she fired the shop and hired us to rebuild it on Rails 7 with proper tenant isolation. Her contract had no deadline penalties because the shop's lawyer had stripped them during negotiation and her startup attorney didn't push back.

Put deadline consequences in the contract before you sign. If they refuse, they're betting they can disappoint you and you'll stay anyway because switching feels harder than waiting it out.

## Question 4: "Can I talk to a founder you've rescued?"

Deadlines tell you what they promise; rescued founders tell you what they delivered when someone else couldn't. This is your social proof test, and it has to be a real person on a real call. Skip the polished case study on their website and ask for a founder who hired them after being burned by someone else.

Most dev shops have "success stories" full of greenfield wins and happy logos. Very few have founders who were broken by a previous shop, came back from the brink, and will say so on a fifteen-minute call. That's the founder who'll tell you the truth, because she's already lived through the version of the truth nobody puts on a website.

Listen for:
- A specific timeline, like "We came to them six months in, with 3% test coverage"
- The actual problem they fixed - "They rebuilt the deployment pipeline in two weeks"
- Measurable outcomes such as first user load time dropping from 8 seconds to 1.2 seconds

If they can't name someone or won't let you call them, their book is full of happy greenfield clients who hired them for new work and never had to test what happens when things go wrong.

## Question 5: "What's your rate?"

Now you can ask about money - because the rate only means something once you know what you're buying. Ask this last, after you've vetted transparency, code ownership, accountability, and track record, and the answer will land in the context it deserves.

Cheap shops will underbid to win the contract and then nickel-and-dime you for every scope change once you're locked in. Expensive shops might charge $150/hour and still deliver late, with no penalty for the calendar slipping a month either way.

The shop's rate is meaningless without the other four answers. A $50/hour shop that misses deadlines costs more than a $120/hour shop with a termination clause, every time you do the math. Scope creep and hidden costs are among the top reasons dev shop engagements fall apart - the rate you signed isn't the rate you'll pay six months in.

When a shop asks for your budget first, they're fishing to see how much they can charge before they price the work. Answer with a question of your own: "What's the range for a project like this, based on the scope we discussed?"

A good shop will give you a range: "$45K-$55K, fixed price per milestone." A bad shop will say "it depends" and wait for your number, hoping you'll anchor higher than they would have quoted.

> **Save this as your vetting checklist.** Copy the 5 questions above into your notes app before your next dev shop call. Score each answer 1-3 (1 = vague, 3 = specific + in writing). Any shop scoring below 12/15 is a coin flip - and you've already lost that flip once. Want the printable one-page PDF with scoring rubric? [Grab it free here](https://jetthoughts.com/services/) and bring it to every call.

## The Bonus Question: "Show me your git history"

If they pass the first five, ask one more thing before you sign - because the git history reveals everything the marketing site won't tell you about how they build software.

A git history shows:
- Whether code was reviewed (pull requests with feedback)
- Whether tests exist (commits that touch tests)
- Whether the team communicates (commit messages that explain decisions)
- Whether a human wrote it (human-paced commits) or AI generated it (bulk commits, all at once, vague messages)

A healthtech founder building a HIPAA-adjacent telemedicine intake tool asked this question after eight weeks of "good progress" reports from a Florida-based shop. She pulled the GitHub history with her cofounder over a Saturday coffee and counted 47 commits squashed into one Friday afternoon - each one a 600-line file dump with messages like "update frontend" or "fix stuff." There were zero pull requests, zero review comments, and a test directory holding three files of scaffolding from `rails new` that hadn't been touched since week one.

When she asked the shop's lead developer about it on Monday, he answered with one line: "We deliver fast - that's why you hired us."

What they delivered was a Rails app that pushed untested, unreviewed code straight to production on Heroku. It crashed on launch day when the first 30 patients tried to fill the same intake form simultaneously, because the appointment-slot logic had a race condition no one had caught - no one had even written a test that could have caught it. She called us the next morning, before her cofounder finished his coffee.

A developer writing code produces 5-15 commits per day, each one tied to a specific change with a message that explains the reasoning. Pull requests get review comments from teammates, tests grow alongside the feature they cover, and you can trace any production bug back to the commit that introduced it. [A 2025 code quality analysis](https://www.qodo.ai/reports/state-of-ai-code-quality/) found that AI-generated code produces 1.7x more defects when merged without human review.

If the git history looks like a robot wrote it, it probably did - or the shop skipped the review process to ship faster. Learn more about [AI-generated code risks](/blog/vibe-coding-crisis-ai-code-debt/) and how to spot them.

## When These Questions Don't Apply

Not every engagement deserves the full vetting battery. If you're hiring a solo freelancer for a landing page or a contractor for a short three-week feature, you can skip the "rescue founder" question - and you don't need a termination clause for an $8K project that you could redo over a long weekend if it falls apart.

But if you're committing $50K+ for core functionality the business depends on, every question applies. The stakes are high enough that a bad hire will set you back six months and burn through runway you can't replace.

## The Pattern That Kills Projects

Across 40+ rescue engagements over seventeen years, the pattern is consistent: 91% of failed projects had under 5% test coverage, 73% had no Git ownership clause, and the average founder had spent $80K-$200K before they called. The founders who asked these five questions before signing avoided most of those problems. The questions aren't magic. The shops that can't answer them clearly just self-select out before the contract is drawn up.

The founders who asked "what's your rate?" first and skipped the rest? They hired a shop that looked good on the website and fell apart three months in, usually around the first real deadline. If this sounds like your situation, we have a [comprehensive guide for founders who've been burned](/blog/founders-guide-hiring-dev-shop/) by dev shops.

If a shop can't give you direct answers to all five questions on the first call, you've already learned everything you need to know about how the engagement will go.

---

## Use the checklist on us first

You've read the playbook, so the fair next step is to pressure-test it on the people who wrote it.

Book a free 45-minute call with a senior JetThoughts engineer (not a sales rep, not an account manager) and bring the 5 questions with you. We'll answer every one on the call - sample weekly report, code ownership clause, deadline SLA, rescue-founder reference, rate range - in writing, with no follow-up needed.

If our answers don't match the standard above, you walk away with the checklist sharper than when you arrived. If they do, you've found a partner who'd rather be vetted hard than hired soft.

<a class="cta-link" href="https://jetthoughts.com/services/">Book the 45-minute checklist call</a>
