---
title: "How to Fire Your Dev Shop (Safely)"
description: "A founder's step-by-step guide to terminating a dev shop relationship, securing your code, and finding a better partner without repeating the same mistake."
date: 2026-04-10T08:00:00+02:00
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

I've watched this play out forty-some times. You hired a team. Wrote them a check - $30K, $60K, sometimes more. Waited three months. The demo loads. The login screen looks fine. But behind it? Nobody knows. Including them, sometimes. And now you're sitting there at 11pm wondering if you should fire your development agency or give them one more sprint.

Here's what I've learned: by the time you're Googling this, you already know the answer.

[Deloitte surveyed 500+ executives](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) about their outsourcing relationships in 2024. Seventy percent had pulled work back in-house over the last five years. Seven out of ten. That's not a few unlucky founders - that's the industry.

So this guide covers the exit - what to secure tonight, what your contract probably doesn't protect, and how to avoid repeating it with the next team.

## How Many of These Sound Familiar?

I'm not going to tell you "if you see one red flag, that's normal." You know what normal friction looks like. This is about the pattern - three or more of these means you're past friction.

They've missed three deadlines, and every time it's "unexpected complexity." Fine - complexity happens. But if they never flagged the risk before the deadline, they're not managing. They're watching. There's a difference.

You can't see the code. Not that you can't read it - you literally don't have a login to wherever it lives. We've taken over projects where the founder didn't know what Git was, and that's totally fine. But your code should live in an account you own. If it doesn't, you don't own a product - you own a promise.

Every small change breaks something else. You ask them to change a button color and the next day the checkout page is down. That's code with no [automated tests](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/). The team is scared to touch anything because they genuinely don't know what will break. A codebase with 70%+ test coverage can handle changes safely. If yours has 5%, your team is guessing every time they deploy.

They refuse to clean up old code. "We can't refactor that - it's too risky." Translation: the code has no tests, so changing anything might break everything. [Technical debt compounds](/blog/fixing-slow-engineering-teams-an-extended/) like interest on a credit card, and eventually you're paying the whole invoice just to service the debt instead of building features.

You have no idea what's actually happening. You ask for a status update and get "it's going well." Going well how? A team that cares sends you a [plain-English standup](/blog/how-make-small-valuable-async-standups-productivity-development/) every day and a one-page summary every Friday. If you're guessing whether progress is real, it isn't.

The invoices keep growing and nobody explains why. Here's a number: [42% of developer time](https://litslink.com/blog/cost-of-outsourcing-software-development) goes to dealing with technical debt and bad code. If your bills are climbing but nothing's launching, you're paying for rework on code that was poorly written the first time.

They can't explain things without jargon. Ask "if your lead developer quit tomorrow, could a new team pick this up in a week?" and watch the face. If the answer involves hedging, one person holds all the knowledge - [that's a hostage situation](/blog/effective-project-onboarding-checklist-management-productivity/).

And the one nobody talks about: you've stopped asking questions. If you've gone quiet because the updates make you feel stupid, or because you're afraid of what you'll hear, the relationship is already dead. You're paying them, and [you have the right to know](/blog/how-know-what-your-team-doing-remote-startup/).

---

**Want to know where you actually stand?** We'll do a free 45-minute code audit. One senior developer. Your codebase. A written one-page report: test coverage, security risks, architecture assessment. No contract. No follow-up calls unless you ask for one. [Get an honest audit](https://jetthoughts.com/contact-us/).

---

## Wait - Is This Fixable?

Before you fire anyone, be honest. I've seen founders torch a relationship that was actually salvageable because they were angry, not wrong.

Try two weeks of real transparency first. Set up a weekly call with a hard agenda - not "how's it going?" but specifics: what shipped, what didn't, what's blocked. If they suddenly start communicating the moment you set clear expectations, maybe the problem was that nobody set expectations. It happens more than you'd think.

Then check your own behavior. Did you change the requirements mid-sprint three times? Any agency would miss deadlines if the target keeps moving. The good ones push back. The bad ones nod and miss quietly.

If you're still unsure, set three concrete numbers for the next 30 days: 80% task completion per sprint, weekly written reports, and repository access within 48 hours. Any [competent remote team](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) does this on autopilot. If they can't hit those for one month, you have your answer - and you have it in writing for the termination letter.

Still here? Alright. Let's talk about the exit.

## What to Secure Before You Send the Email

This is the part most guides skip. Do this tonight - before they know.

Start with repository access. Log into GitHub (or wherever the code lives) and check whether you have admin rights. If not, request access in writing tomorrow morning - casually, not as an ultimatum. "Hey, for our records, can you add me as an admin on the repos?" Get this before you announce anything.

Next, make a list of everything they control: hosting (AWS, Heroku, DigitalOcean), domain registrar, DNS settings, SSL certificates, email provider, payment processor API keys, analytics accounts. You probably don't even know all the services they signed up for on your behalf. [Nudge Security](https://www.nudgesecurity.com/) can find every SaaS account connected to your email - free trial, takes five minutes. For each account: do you have the login? Is it under your email or theirs? Transfer anything under their email to yours tonight.

Then export your data - production database, user records, uploaded files, third-party integrations. Don't assume you can get this later. I've seen agencies go silent after a termination notice. If your app runs on Heroku, AWS, or DigitalOcean, [SimpleBackups](https://simplebackups.com/) can automate database exports through a point-and-click UI (free tier available, paid from $29/month). Get it while the relationship is still cordial.

Documentation is the trickiest part because they probably don't have any. Here's the workaround: if your code is on GitHub, paste the repo URL into [DeepWiki](https://deepwiki.com/) and it generates a navigable wiki from your codebase in minutes. It won't replace real documentation, but it gives your next team a starting point. [Swimm](https://swimm.io/) does something similar and keeps docs in sync as code changes (free tier for small teams).

Finally, send a formal termination letter. Most contracts require 15-30 days written notice. Reference the specific clause, keep it factual, skip the emotion. "Per Section 12.3 of our agreement dated X, this letter serves as 30-day notice of termination, effective Y."

## "But I Signed a Contract!"

Yeah. And it probably doesn't protect you.

Every contract we've seen from a failed engagement is missing the same three things. Yours probably is too.

**Code ownership after each milestone.** Your contract says you own everything "upon project completion," which sounds reasonable until you realize "completion" is whatever they say it is. You need ownership after each paid milestone - three months of payments means three months of code.

**A termination clause that actually works.** Something like "if the provider misses two consecutive milestones, the client may terminate with 7 days notice." Without that, firing them becomes a negotiation with someone who has zero incentive to let you leave.

**Real-time code access from day one.** Not "access upon request," not a ZIP file next month - read-only access to the repo, always on. If they push back on this, really sit with that for a second. What are they protecting?

Need templates? [Clerky](https://www.clerky.com) has startup-focused IP assignment and consulting agreements for $819 lifetime. Cheaper than one hour of a lawyer's time. Won't cover everything, but it covers the basics that most agency contracts miss entirely.

## Evaluating What They Left Behind

You can't read code, and that's fine - here's what to do.

Hire a senior dev for four hours. Freelancer, fractional CTO, your next agency - anyone competent. Have them check four things.

Test coverage first. Below 20% and the code can't be safely modified - below 5% and it was probably [vibe-coded](/blog/ai-powered-code-reviews-transforming-development-workflows/) with no human review.

Security next - a basic vulnerability scan takes 30 minutes and will tell you if your users' data is exposed right now.

Ask the deployment question too: can they push a change in under 10 minutes? A multi-hour manual process means every future update is expensive and risky, because someone has to babysit every release.

Then look at structure. Is the code organized into logical pieces, or is everything crammed into one giant file?

This costs $500-$2,000. Skipping it costs $50,000 when you have to rebuild from scratch.

Can't find someone today? Start here:

- **[The Code Registry](https://thecoderegistry.com/code-auditing/)** - connect your GitHub repo, get an AI security scan and complexity score in 15 minutes. Built for non-developers.
- **[Codacy](https://www.codacy.com)** - automated code quality scanning. Free tier available. Dashboard is readable.
- **[Codekeeper](https://codekeeper.co)** - code escrow. Makes daily copies of your repo automatically. From $129/month. Set this up *before* you send the termination email.

Need someone to handle the transition - audit the code, talk to both teams, tell you in plain English what you're actually working with? [That's what we do](https://jetthoughts.com/contact-us/). We've handled this exact handoff dozens of times and can start within 48 hours.

And one thing that costs nothing: make sure your repository lives in a [GitHub Organization you own](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository), not your agency's personal account. If you do nothing else from this article, do that. Do it now.

## The 2026 Problem: Vibe Coding

This part didn't exist two years ago.

Last quarter a founder came to us after six months with what they later learned was a "vibe coding" shop. The agency had used AI to generate about 90% of the codebase, and the MVP shipped on time. The founder was ecstatic - the app loaded, the demo looked polished.

Then real users showed up.

First login with a special character in the email? Crash. Two users booking the same time slot? Data corrupted. The founder called the agency. "That's an edge case," they said.

It wasn't an edge case. It was Tuesday.

We opened the codebase and found 2% test coverage, zero error handling, and 14 critical security vulnerabilities. We had to rewrite the entire thing.

We're seeing this in about half the rescue projects that come through our door now. AI-generated code *looks* professional - good variable names, consistent formatting, reads well. But under the hood you find no tests, no error handling, and [security holes that only show up when real people use the product](/blog/from-what-start-stop-delivering-bugs-when-there-no-time-for-changes-management-agile/). [Qodo's 2025 report](https://www.qodo.ai/reports/state-of-ai-code-quality/) found AI code produces 1.7x more issues than human-written code. And that's when someone reviews it. When nobody does? It's a time bomb.

We've watched this enough times to see the split. The shops that last [write tests before code](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) and have a second person [review every change](/blog/ai-powered-code-reviews-transforming-development-workflows/) before it goes live. The shops that burn out paste AI output and ship without anyone checking whether it actually works.

## What to Actually Look For in the Next One

Ignore the website and the Clutch profile. Here's what actually separates the shops that last from the ones that burn you.

Before you sign anything, request a real weekly report from an actual project, anonymized. A team worth hiring sends a one-page Friday email covering what shipped, what hit a wall, and what's next. We wrote about [what that looks like](/blog/how-make-small-valuable-async-standups-productivity-development/) - that's the bar.

Find out who owns the code. "You do" is the only acceptable answer, backed by a contract clause that transfers ownership at each paid milestone.

Now the question that matters most. If they can't give you a coverage number and a methodology, they don't have one. [TDD](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) - writing tests before code - is the difference between shops that ship safely and shops that ship and pray. Especially now that so much code is AI-generated.

Then dig into how deploys work. Good teams [deploy daily](/blog/async-remote-xp-practices/) without drama. Bad teams deploy monthly and everyone holds their breath. If deploys are scary, the code is fragile.

Request a reference from a founder they've rescued - not their happiest client, but someone who came from a situation like yours. If they can't produce one, they haven't done this before.

The first week tells you everything about the next six months. Did they send an [onboarding checklist](/blog/effective-project-onboarding-checklist-management-productivity/)? Set up a project board? Explain their [delivery flow](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/)?

## You're Going to Pay Twice

Firing a dev shop feels like failure, but staying with a bad one costs more.

You're going to pay twice for the same product. Once for the bad code, once to fix it. That's the tax. The size of the second bill depends on who you hire next and what they find when they open the hood.

Get the code, get it audited, and hire someone who writes tests first and explains things in language you understand. You lived through the bad version - that experience is worth something when you're picking the next team.

---

*In the middle of a transition right now? We'll audit your codebase for free. 45 minutes. One senior developer. A written one-page assessment. No contract, no follow-up calls. [Get an honest audit](https://jetthoughts.com/contact-us/).*

---

We've been writing about the practices that prevent these disasters. The ones that matter most if you're evaluating your next partner:

- [Async-first XP practices](/blog/async-remote-xp-practices/) - pair programming and CI/CD across timezones, zero regressions
- [Delivery flow for remote teams](/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) - Kanban that keeps everyone aligned without micromanagement
- [Shape Up for founders](/blog/shape-up-founders-guide-not-wasting-your-runway-startup-tutorial/) - 6-week cycles that protect your runway
- [Fixing slow engineering teams](/blog/fixing-slow-engineering-teams-an-extended/) - monthly releases to daily deploys in 60 days
- [Code quality signals for non-technical founders](/blog/code-quality-evaluation-non-technical-founders/) - the 5 things you can actually read
- [Our onboarding checklist](/blog/effective-project-onboarding-checklist-management-productivity/) - day one, no chaos
- [Red flags in big PRs](/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/) - why we split anything over 500 lines

## Further Reading

- [Deloitte 2024 Global Outsourcing Survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) - 70% of executives insourced previously outsourced work
- [CISQ: The Cost of Poor Software Quality](https://www.clouddatainsights.com/the-cost-of-poor-software-quality-is-higher-than-ever/) - $2.41 trillion annual cost in the US
- [Qodo: State of AI Code Quality in 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/) - AI code produces 1.7x more issues than human code
- [Stripe: Developer Coefficient Report](https://litslink.com/blog/cost-of-outsourcing-software-development) - 42% of dev time spent on technical debt
- [Aaron Hall: Source Code Access on Termination](https://aaronhall.com/source-code-access-rights-termination-provisions/) - legal framework for code ownership
- [Appstronauts: Project Transition Checklist](https://appstronauts.co/blog/a-successful-software-development-project-transition-plan-checklist/) - practical transition framework
