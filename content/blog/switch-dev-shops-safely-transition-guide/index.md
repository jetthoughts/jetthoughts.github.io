---
title: "Switch Dev Shops Without Losing Progress"
description: "How to switch development agencies without losing your code: the 30-day overlap, the cold-start deploy drill, and what the next team needs on day one."
date: 2026-07-31
draft: true
author: "JetThoughts Team"
slug: "switch-dev-shops-safely-transition-guide"
keywords: "how to switch development agencies, change dev shop transition, switching software development companies"
tags: ["startup", "founder", "dev-agency", "outsourcing", "hiring"]
categories: ["Startup"]
canonical_url: "https://jetthoughts.com/blog/switch-dev-shops-safely-transition-guide/"
og_title: "Switch Dev Shops Without Losing Progress"
og_description: "How to switch development agencies without losing your code: the 30-day overlap, the cold-start deploy drill, and what the next team needs on day one."
related_posts: false
---

The termination email is the last step, not the first. Founders send it in the wrong order, usually on a Sunday night after one bad week, and then spend two months paying a new team to rediscover things the old team knew.

You can survive losing the relationship. What costs you the quarter is losing the deploy process, the environment variables nobody wrote down, and the reason the payment retry logic has that odd 90-second delay.

The rest of this guide lays out how to switch development agencies in the order that actually protects those things, starting with a question that has nothing to do with the switch.

## Before you replace one shop with another

Run the build-path question again before you sign anything.

Hiring another agency is one option among several, and the fact that this one went badly is not evidence that the category was wrong or right. Plenty of people switch shops when the honest answer was a fractional CTO with two contractors under them, or the same team working a much smaller scope. The [2026 decision tree in our free course](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/) walks that fork in about fifteen minutes.

If the answer still comes back "hire a shop," keep reading. If it comes back "hire a person," the transition mechanics below still apply, because the handover is the same job either way.

## Week 1: take inventory while everyone is still friendly

Do this while the current team still has every reason to help you, before anyone senses you are on the way out. Open a spreadsheet with one row per system: source repository, cloud hosting, database, domain registrar, DNS, email sending, payment processor, error tracking, analytics, and CI (the service that runs automated checks every time code changes). For each one, write down the account owner's email address, whether you can log in yourself today, and who pays the bill. It is common to turn up a service or two you did not know existed, and at least one signed up under a developer's personal address.

Then check the ownership layer, which is separate from access. GitHub's docs on [transferring a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository) explain what actually moves and what does not; AWS documents the [root user](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-root-user.html) that sits above every individual permission your agency may have granted you. Being an admin on someone else's organization is not ownership, and the difference only shows up on the day they stop answering.

Our [exit guide](/blog/fire-dev-shop-guide/) covers the securing sequence and the termination letter in detail. Do that part there; the rest of this post is about the thirty days after.

## Week 2: run the cold-start drill

One test tells you whether a handover is real. Ask your current agency for a written runbook - a step-by-step document for setting up and shipping the project - then have someone who has never touched it follow that document on a clean laptop. Can that person clone the repository, get the app running locally, run the test suite, and deploy a one-word copy change to production using only the document? A contractor at an hourly rate can do this in a day, and the day is the cheapest money in this whole process.

What comes back is usually a list of gaps rather than a green run: an undocumented environment variable, a database migration that only works if you run a seed script first, a deploy that requires a credential living in one developer's password manager. Every gap you find while the old team still answers Slack is a gap your new team does not pay to rediscover at a higher rate.

DORA's research on [documentation quality](https://dora.dev/capabilities/documentation-quality/) found that teams with high-quality internal documentation were more than twice as likely to hit their performance targets. Treat the runbook as the asset you are buying in these thirty days, because it is the only part of the handover your next team can use without asking anyone a question.

## Week 2, in parallel: find out how many people actually know this system

Ask your agency's project manager how many of their developers could take over your codebase tomorrow with no help. Then check the answer against the commit history.

Researchers at UFMG measured this across 133 popular open-source projects using what they call the [truck factor](https://arxiv.org/abs/1604.06766) - the number of developers who would have to walk away before a project stalls. In 46% of the systems they studied the answer was one person, and in another 28% it was two. Their [measurement tool](https://github.com/aserg-ufmg/Truck-Factor) is open source if you want the number for your own repository.

Agency projects skew worse than open source, because staffing follows margin. When the truck factor is one, your transition is really a conversation with one developer, and the smart move is to buy a few hours of that specific person's time for a recorded walkthrough rather than negotiating with their account manager.

## Week 3: extract the things that are not in the code

Your next team can read the code whenever they want, but the reasoning behind it walks out the door on the last day of the contract.

Book two recorded sessions with the outgoing lead developer and hand them the agenda in advance: architecture walkthrough, the three decisions they would do differently, known bugs and workarounds nobody filed, and every scheduled job or integration that runs without a human touching it. Record the calls. Transcripts of those two hours have saved more rescue budget than any document a departing agency writes voluntarily.

Ask one more question at the end of each call. "What would break first if traffic tripled next month?" You are not going to act on it this quarter, and their answer tells your next team where to look before it becomes an incident.

## Week 4: what the new team needs on day one

Everything that makes the new team's first week productive gets prepared before they start. Have ready: repository access under your own organization, credentials in a shared vault, the runbook plus the gaps found in the cold-start drill, the two recordings, a written list of what is broken today, and the one business outcome you want in the first six weeks. That last item matters more than the rest combined, because a new team with no stated outcome will spend three weeks refactoring and show you nothing you can demo.

Ask a candidate shop to describe their own first week before you sign. We wrote ours up in [how onboarding works at JetThoughts](/blog/how-does-onboarding-look-like-in-jetthoughts-productivity-startup/), and the [hire-track reference in the course](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/) collects the interview screen, the SOW reading guide, and the fractional-CTO option in one place.

## Choosing the next partner without repeating yourself

Write down what actually failed last time, in one sentence, before you take a single sales call.

"They missed deadlines" is not that sentence. "Nobody could tell me what shipped each week, and I found out about slips from my own customers" is, and it turns into a specific question you ask every shop you interview. The [eight red flags](/blog/dev-shop-red-flags-checklist/) are the behavioral version of this list, and most of them are visible in the first two conversations if you know what you are listening for.

Location changes the price and the overlap hours, not the failure modes. The course [map of where to hire in 2026](/course/tech-for-non-technical-founders-2026/where-to-hire-developer-2026-map/) lays out the onshore, nearshore, and offshore trade-offs with real rate ranges, so you can pick on time zones and budget rather than on a sales deck.

## When switching is the wrong move

Requirements that changed three times this quarter will hit a new team the same way, on a new invoice, which means the shop was never the whole problem. You may also not have tested this team properly yet: a shop that has never been given a weekly written report to deliver against has never been given a clear target. Where the current developers are competent but slow, an [interim technical lead](/blog/when-your-startup-needs-emergency-cto-leadership/) working alongside them usually costs less than a full transition and buys the same visibility.

Switching also carries a real bill. Deloitte's [global outsourcing survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html) found 70% of the executives it surveyed had brought at least some previously outsourced work back in-house over five years - selective moves, not wholesale reversals. Budget six to eight weeks of reduced output, overlap pay for two teams, and a new set of unknowns you will discover in month two.

## The one number to hold yourself to

One line in the SOW protects you more than the rest of the document put together: the date your new team ships something a customer can actually use. A discovery document does not count, and neither does a refactoring milestone. You want a small change your users can see, inside the first three weeks. If a shop calls that unrealistic before it has read a line of your code, cross it off the list and take the next call.

## Further reading

- [DORA: documentation quality as a capability](https://dora.dev/capabilities/documentation-quality/)
- [A novel approach for estimating truck factors (Avelino et al.)](https://arxiv.org/abs/1604.06766)
- [Truck Factor measurement tool (UFMG ASERG)](https://github.com/aserg-ufmg/Truck-Factor)
- [GitHub: transferring a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository)
- [AWS: managing the root user on an account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-root-user.html)
- [Deloitte global outsourcing survey](https://www.deloitte.com/ca/en/services/consulting/perspectives/global-outsourcing-survey-2024.html)
