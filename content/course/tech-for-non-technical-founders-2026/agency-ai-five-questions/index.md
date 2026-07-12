---
title: 'The "We Use AI" 5-Question Script'
aliases: ["/blog/agency-ai-five-questions/"]
description: "Five questions that catch AI theatre in 30 minutes. Hand them to your next agency call before you sign anything. Score 0-5; below 3 means walk."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: agency-ai-five-questions
keywords:
  - agency uses ai questions
  - hire ai augmented developer
  - founder catch ai theatre
  - non technical founder ai interview
  - ai agency interrogation script
tags:
  - founders
  - non-technical-founder
  - template
  - course-companion
  - ai-era
categories: ["Templates"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/agency-ai-five-questions/"
related_posts: false
---

📋 Template companion to the "Manage AI-Era Risks" path of the [From Idea to First Paying Customer course](/course/tech-for-non-technical-founders-2026/). Send 24 hours before the discovery call. Score in real time during the call.

# The "We Use AI" 5-Question Script

Five questions that catch AI theatre in 30 minutes - hand them to your next agency call before you sign anything.

By the end of one Tuesday discovery call you will know whether the agency claiming "we use AI to ship 3x faster" can describe what their developers do with Cursor on a Wednesday morning, or whether the AI talk is a slide. Five questions, sent in writing 24 hours before the call, scored 0 or 1 in real time. Two failed questions is a walkaway.

A founder we picked up in Q1 2026 had been three weeks deep with an "AI-native" agency that promised a four-week MVP for $34K. She asked for a walkthrough of one PR the team had merged that week. The lead developer screenshared a staging branch; her independent advisor paused the screen-share and pointed at line 14 of `config/database.yml`: an OpenAI API key, a Stripe live key, and a database password committed in plaintext, on a public-by-default GitHub repo.

Then he opened the agency's OpenAI billing dashboard the developer had also screenshared by accident: **$4,800 in API charges in the last 30 days**, no project tags, no per-developer attribution, and the agency owner could not explain which client the spend belonged to. She walked. The five questions below would have caught both in the first 20 minutes.

Most agencies in 2026 are not malicious about AI. They adopted Cursor in a hurry, never wrote down a workflow, and never priced the token bill. The damage is the same either way.

## How to use it

Send the five questions in writing 24 hours before the call with one sentence: "We will work through these together on Tuesday; please come prepared." Do not soften it.

Score in real time - 0 or 1 per question, in a Notion doc next to each answer. A score of 3+ is a pass with conditions. A score of 2 or below means do not sign, no matter how impressive the rest of the pitch. Forward your scoring doc to your independent advisor or fractional CTO the same evening for a 15-minute sanity-check call.

If the agency declines to answer in advance, that is a 0 on every question. Exercise over.

## The five questions

### Q1 - The workflow question

> "Walk me through how a developer on your team takes a Jira ticket and ends up with merged code, when they use AI in the loop. Name the tools, the prompt patterns, and the human review gates. Use a real ticket your team closed last week."

**Pass:** Tools named by version - Cursor with Claude 4.5 Sonnet, or Claude Code, or Aider, or Copilot Enterprise. A written sequence: ticket - draft prompt - generate - run the failing test the developer wrote first - review the diff against the spec - PR with `Assisted-by:` tag - second human reviews - merge. The PR was reviewed by a different senior than the one who wrote the prompt. They offer to email the internal one-pager.

**Fail:** "We let the senior dev decide." "It depends on the project." "AI is used where it makes sense." No named tool, no named gate, no real PR.

**Score:** 1 if they name tools + a written workflow + a real PR. 0 otherwise.

### Q2 - The cost question

> "What does the average developer on your team spend on AI tokens per month, and who pays it? Will it pass through to my invoice, and what should I budget per month for the project we just scoped?"

**Pass:** A per-developer dollar range ($80 to $300 per month for Cursor seats plus Anthropic and OpenAI API usage), a pass-through model written into the SOW, and a sample invoice line-item they will email after the call. They have a budget alert on the API account.

**Fail:** "It is included in the rate." "We don't track it that closely." "We absorb the AI costs." Sign without this number and you get a surprise five-figure OpenAI charge in month two - the $4,800 line in the opening story was that number two weeks before the founder caught it.

**Score:** 1 if they give a per-developer dollar range and a written pass-through policy. 0 otherwise.

### Q3 - The verification question

> "When AI generates a 200-line PR, what does your senior reviewer actually check? Walk me through one PR you reviewed last week and tell me what you looked for."

**Pass:** The reviewer pulls up an actual PR on screenshare. Does the diff match the ticket spec, line by line? Any hardcoded secrets, API keys, or database passwords (the agency in the opening story would have caught the `database.yml` problem here)? Are the tests genuine, written by the developer first as failing specs (the team's TDD discipline shows here), or AI-generated to pass after the fact? Did the AI introduce new gems or pip packages, and do they exist on Rubygems / PyPI and pass the team's allowlist?

**Fail:** "We trust the model." "Cursor catches most issues." "We have automated checks in CI." A team that trusts the model will ship the SQL injection vector in [Veracode's 45% of AI-generated code](/blog/ai-code-ownership-accountability/) into your production database.

**Score:** 1 if they show a real PR with named checks. 0 otherwise.

### Q4 - The slopsquatting question

*slopsquatting: when AI suggests a package name that doesn't exist, an attacker registers it, and your build pulls the malicious version. See the [dedicated chapter](/course/tech-for-non-technical-founders-2026/slopsquatting-ai-supply-chain-attack/).*

> "In April 2025 a security researcher published findings that AI assistants suggested over 200 package names across Rubygems, PyPI, and npm that did not exist; attackers register those names and wait for developers to install the typo. How does your team prevent installing a hallucinated gem or pip package?"

**Pass:** A pre-vetted allowlist with a written process for adding new packages. A scanner like Socket or Snyk on every PR that blocks the build on new dependencies until a human approves. They use the term "slopsquatting" without prompting and cite the [Infosecurity Magazine writeup](https://www.infosecurity-magazine.com/news/ai-hallucinations-slopsquatting/) or the [SecurityWeek piece on AI coding agents and supply-chain risk](https://www.securityweek.com/ai-coding-agents-could-fuel-next-supply-chain-crisis/).

**Fail:** "Our developers know what they are doing." "We use trusted packages." A confused look. An agency that has not heard of slopsquatting in May 2026 has not read their field's security press for a year.

**Score:** 1 if they name a specific defense (allowlist, scanner, gated CI). 0 otherwise.

### Q5 - The accountability question

> "When AI-generated code causes a production incident, who is on the hook? Walk me through the last AI-generated-code incident your team had - what happened, when, and what you changed afterwards."

**Pass:** A specific incident with a date in the last 6 months, a one-paragraph root cause, the named senior who reviewed the offending PR, and the workflow change made the week after. The kernel maintainers' [`Assisted-by:` rule](/blog/ai-code-ownership-accountability/) puts the human reviewer on the hook by name; an agency on that posture knows whose name is next to the bug.

**Fail:** "We have never had an AI-related incident." (Either lying or never shipped to production - the [PocketOS database deletion](/blog/ai-agent-deleted-production-database-pocketos/) was a 9-second incident on a live SaaS the founder did not see coming.) Or: "AI code is the developer's responsibility." (No team-level accountability means no team-level review.)

**Score:** 1 if they describe a specific incident with a date, root cause, and workflow change. 0 otherwise.

## What good looks like vs what bad looks like

The passing-agency pattern: the salesperson defers to the senior engineer on technical questions. The senior pulls up real artifacts on screenshare - a PR, an invoice line, a post-mortem. Specific tool names, dollar amounts, dates, people. The internal AI policy lands in your inbox the same day.

The AI-theatre pattern: the salesperson takes every question. Answers come back as "we use AI to deliver faster value" or "our developers are AI-native." When you ask for a real PR or invoice line, the answer is "I will follow up." That follow-up does not arrive.

One concrete contrast on Q3:

> Bad: "Our senior reviews every PR. We have a high standard."
> Good: "Open PR #1247 - Marcus reviewed it Tuesday morning. He flagged that Cursor had added `gem 'active_record_extras_helper'` to the Gemfile - a gem that does not exist on Rubygems. He blocked the merge and asked the developer to use the real `active_record_extra` gem. The hallucinated name would have been a slopsquat install if an attacker had registered it."

## What to do after the call

- **Forward your scored doc to your independent advisor the same evening** for a 15-minute paid review. Under $400 and the cheapest decision insurance you will buy this year.
- **Score below 3:** send a polite "we are pausing the search to refine our requirements" note. Do not negotiate. The agency will argue the framing instead of fixing four gaps.
- **Score 3-4:** ask for a 45-minute follow-up technical session with the senior reviewer (not the salesperson), working through one of your real product flows. If the senior cannot attend two sessions in two weeks, that tells you who actually staffs the project once you sign.
- **Score 5:** do reference checks on AI-augmented projects specifically. Ask their last three clients about AI-related incidents, the OpenAI line on monthly invoices, and whether they have ever received an `Assisted-by:` commit log on request.

Every agency uses AI in 2026. The five questions test whether they can describe what they are doing with it, what it costs, who reviews it, and whose name is on the line when it breaks. If they cannot, they are selling you the [quality tax](/blog/quality-tax-ai-mvp-cost/) - the four-month invoice that arrives after the demo, when AI-generated code meets a production load nobody tested against.

## What to do tomorrow

1. Schedule your next agency discovery call - block 30 minutes.
2. Print the 5-question script (or pull up this page on your phone) and bring it to the call.
3. After the call, score each answer 0 or 1 in real time (per the scoring rule above) - a total of 2 or below out of 5 means do not sign the SOW.

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
