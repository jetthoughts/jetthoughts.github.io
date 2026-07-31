---
title: "Cheap Developers Are Expensive Without Review"
description: "Cheap developers turn into expensive mistakes when nobody senior reads their code. A 20-minute pull request check plus ways to add review without a CTO salary."
date: 2026-07-31T08:00:00+00:00
edited: 2026-07-31T08:00:00+00:00
draft: true
author: "JetThoughts Team"
slug: "cheap-developers-expensive-without-cto-review"
keywords: "cheap developer expensive mistakes, student freelancer developer risk, fractional cto code review"
tags: ["startup", "founder", "hiring", "code-quality"]
categories: ["Business"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Cheap Developers Are Expensive Without Review"
  og_description: "Cheap developers turn into expensive mistakes when nobody senior reads their code. A 20-minute pull request check plus ways to add review without a CTO salary."
cover_image_alt: "Pull request list with zero reviewers highlighted, next to a fractional CTO review loop diagram"
canonical_url: "https://jetthoughts.com/blog/cheap-developers-expensive-without-cto-review/"
---

The cheap developer isn't the mistake. The mistake is that nobody senior ever reads what they merge - and you find that out in month four, when something breaks and the person who built it can't explain why.

Maybe you hired a computer science student, or a freelancer a friend vouched for. The demos look fine, the invoices are small, and some quiet evening you catch yourself wondering whether the code behind the demo is as good as the price.

There is a 20-minute check you can run on the project today, without reading a single line of code - open the pull request list and see who approved the last ten changes.

## The rate you compared isn't the cost you're paying

A $30-an-hour freelancer next to a $150-an-hour senior looks like a five-times saving. The rate comparison works if the two are producing the same thing at different speeds, and for a lot of the work - screens, forms and the features you can see - they roughly are. Students and junior freelancers genuinely can build those, which is why the cheap option keeps looking vindicated for months.

The expensive mistakes hide in decisions that look identical in a demo: how the database is organized, or what the login system does with a malicious request. No demo ever shows those, so the first person qualified to judge them is often the rescue engineer you hire after they fail.

That gap between "can build features" and "can make the judgment calls" is exactly the student-freelancer developer risk. If you haven't signed anyone yet, run our course's [Should You Hire? decision tree](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/) first - it exists so you don't find out the hard way which kind of help your product actually needed. And if the budget itself is the open question, the [contractor vs full-time budget guide](/blog/hiring-developers-contractors-budget-guide-founders/) walks the numbers.

## Twenty minutes in your own project: who approved the last ten pull requests?

Your product's code lives in a repository - the shared folder, usually on [GitHub](https://docs.github.com/en/pull-requests), that stores every version of every file. When a developer finishes a change, healthy teams package it as a pull request: a bundle of proposed changes that waits for a second developer to read and approve before it's merged, merged meaning it becomes part of the product. That reading step is code review.

You can check whether review is happening without understanding any code. Open your repository on GitHub, click "Pull requests," then the "Closed" tab, and look at the ten most recent merged ones. For each, GitHub shows who wrote it and who approved it, right there in the list.

Two people per pull request is the healthy shape. You want to see approvals from someone other than the author, plus a few comments per change - and if you spot the occasional "changes requested," even better, because that means a reader pushed back and the code improved before it shipped. The unreviewed shape is just as recognizable: the author approved and merged their own work with zero comments anywhere, or there are no pull requests at all because changes go straight in.

This isn't an exotic standard. [Google's published engineering guide](https://google.github.io/eng-practices/review/) expects every change to be read by someone other than its author before it lands, and a [Microsoft Research study of code review](https://www.microsoft.com/en-us/research/publication/expectations-outcomes-and-challenges-of-modern-code-review/) found teams use it to spread knowledge of the codebase (all the code that makes up your product) as much as to catch defects.

GitHub will even [enforce review with a setting](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches) - a checkbox that blocks merging until someone approves.

One caveat, because this check has a blind spot: approval theater. Two juniors rubber-stamping each other's work looks identical on this page to real review, so once you've confirmed reviews exist, ask who the reviewer is and what they've pushed back on lately. An approver who has never once requested a change is probably just clicking the button.

## What a senior reviewer catches before you pay for it

Somewhere in an unreviewed project there is often a file with the production database password - the key to the live system your real users' data sits in - pasted in as plain text, where every past contractor and every copied laptop can read it. A senior reviewer flags this in the first minute. Mishandled secrets like this sit on the [OWASP Top Ten](https://owasp.org/www-project-top-ten/), the standard list of the most common ways web applications get broken into, and a solo junior often simply doesn't know to avoid them.

Or take a migration - a change to the database's structure, like adding a column to a spreadsheet. Written naively, one can lock the whole table while it runs, which your users experience as the app freezing mid-morning. The junior who wrote it tested on their laptop with 40 rows and saw nothing wrong.

Your developer isn't careless so much as alone: nobody asks "what happens when this meets real users?" before the change ships.

You can screen for the review gap before signing anyone. Ask a candidate, "who reviews your code before it ships?" - a confident "I review my own work" is the risk in one sentence. The [hiring interview script](/course/tech-for-non-technical-founders-2026/hiring-interview-script/) in our course packs this screen into 7 questions over 30 minutes, and for agencies rather than individuals, the [questions to ask a dev shop](/blog/hiring-dev-shop-questions/) covers the same ground.

## Buying senior judgment without the senior salary

A fractional CTO (chief technology officer) gives you a few hours a week of an experienced engineer's judgment - reviewing pull requests and vetoing risky designs - without the full-time salary. Search for "fractional CTO code review" and you'll find exactly this arrangement: keep the affordable developer for the building, add a senior reader for the judgment calls. A review retainer with an agency gets you the same result under a different contract.

The setup has real costs. Every change now waits for a reviewer, so shipping typically slows by a day or two per change, and your cheap developer's rate is no longer the whole bill. Review also can't rescue foundational structure decisions that were wrong from the start - a reviewer who arrives in month six inherits choices they'd have vetoed in week one, so this works best when the reader is in place before the building starts.

"But my developer will feel policed," you say. Good developers feel the opposite - review is how juniors get senior, and the ones who bristle at a second reader are telling you something. If the resistance goes as far as stalling on repository access, check it against the [dev shop red flags checklist](/blog/dev-shop-red-flags-checklist/), because that pattern rarely travels alone.

If the fractional route is where you're headed, the course's [Hire Track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/) maps how a fractional CTO fits alongside the hire itself - which decisions they own and which stay with you.

## When cheap plus review is still the wrong setup

Review fixes code quality and nothing else. A developer who ships slowly, or builds features nobody asked for, will do both of those things with beautifully reviewed code. Payment infrastructure and medical data are a different case again - those need someone who has actually built in that domain, and a weekly reader can't inject experience that was never there.

It's also the wrong tool when trust has already collapsed. A developer or shop that refuses review outright, or won't hand over repository access, has moved past "add oversight" into a different playbook - that one's covered in the [guide to firing a dev shop safely](/blog/fire-dev-shop-guide/).

## Where JetThoughts fits

Our developers average 8+ years of experience, and we've been building Rails apps (Rails is the web technology we specialize in) since 2011 - long enough that every change we ship goes through the same review described above, because we've read too many inherited projects where it didn't happen. If you want the check done for you: a senior JetThoughts engineer reads your repository and sends a plain-English, one-page assessment of what your recent merges actually contain. [Start with the services page](https://jetthoughts.com/services/) - no pitch deck, just the read.

For more on watching a team you can't technically evaluate, see [how to know what your team is doing](/blog/how-know-what-your-team-doing-remote-startup/), and if your product is being built with AI coding tools, [the quality tax on AI-built apps](/blog/quality-tax-ai-mvp-cost/) covers the review gap from that angle.

## Further reading

- [Google Engineering Practices: How to do a code review](https://google.github.io/eng-practices/review/)
- [Microsoft Research: Expectations, Outcomes, and Challenges of Modern Code Review](https://www.microsoft.com/en-us/research/publication/expectations-outcomes-and-challenges-of-modern-code-review/)
- [GitHub Docs: About protected branches and required reviews](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [SmartBear: State of Code Review](https://smartbear.com/state-of-software-quality/code-review/)
- [OWASP Top Ten](https://owasp.org/www-project-top-ten/)
