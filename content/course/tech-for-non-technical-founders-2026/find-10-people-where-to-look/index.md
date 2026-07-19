---
title: "2.3 · Find 10 People: Where to Look"
aliases: ["/blog/find-10-people-where-to-look/"]
description: "Where to find 10 people who actually have your validated problem. AI translates your hypothesis into an ICP map, you read where they post, you build a 30-name list from people you can name."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: find-10-people-where-to-look
keywords:
  - find customers to interview 2026
  - non technical founder outreach
  - icp mapping ai
  - reddit customer research
  - validation outreach strategy
tags:
  - founders
  - non-technical-founder
  - customer-research
  - validation
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "2.3 · Find 10 People: Where to Look"
  og_description: "Where to find 10 people who actually have your validated problem. AI translates your hypothesis into an ICP map, you read where they post, you build a 30-name list."
cover_image_alt: "JetThoughts course cover for Lesson 2.3 - Find 10 People Who Already Care, with a 30-name list card: name and where they posted, the post URL, one quoted line"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/"
related_posts: false
---

> **Module 2 · Lesson 2.3 · [CORE]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a hypothesis you suspect is real (from Lesson 1.1) + a sharpened Mom Test question list (built in Lesson 2.1, polished in Lesson 2.2)
>
> **Output:** a 30-name list of specific people you can name because you read what they wrote, ready for the outreach templates in [Lesson 2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/)
>
> **Progress:** M2 · 3 of 6 · Results so far: question list ready to run

> **TL;DR (Part 1 of 2):** Expand your one-sentence hypothesis from Lesson 1.1 into three sentences (a short step below), paste them into Claude, and get back the ICP profile (ICP = Ideal Customer Profile - the specific kind of person your hypothesis's [CUSTOMER] blank names) + exact communities + search strings. Read where your ICP is already complaining. Build a 30-name list. [Part 2: What to Say](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) covers the message templates, cadence, and follow-up sequence.

The instinctive first move is "I'll just message my LinkedIn network" - sixty polite DMs that produce 3 calls, two of them old colleagues being nice. The technique below replaces it: read where strangers already complain about your exact problem, then write back to those specific complainers. Same hypothesis, same hours, different place to look - and it fills a calendar with 10+ booked interviews instead of 2-3 polite ones.

After this lesson you will be able to: **build a 30-name list of specific people who already complained about your problem in public - people you can name because you read what they wrote.**

The full journey, top to bottom - this page covers the first three steps (map, read, list); [Part 2](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) covers writing to each person and booking the 10 calls:

![The find-10 journey as a left-to-right strip of six cards: your hypothesis from Lesson 1.1, then four numbered steps - step 1 AI ICP map paste into Claude, step 2 read where they complain, step 3 build the 30-name list, step 4 write each one personally - ending in 10 interviews booked on the calendar.](find10-journey.svg)

> **Calendar reality + smoke-test gate before you start.** Full-time founder typically books 10 interviews across 2-4 calendar weeks; evening-only founder (2-4 hr/week) typically needs 6-8 calendar weeks - plan around the longer version. Your Lesson 1.2-1.4 smoke test should have cleared roughly 6%+ email conversion (the "Promising" band) or 5%+ Stripe-click on the Lesson 1.5 price-button variant. 3-6% is the "iterate the message" zone, not a green light. Below 3% means you have a demand-side problem - go back to [Lesson 1.1](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) and rewrite the weakest blank before booking interviews.

One time-box: if you catch yourself on day three still polishing the list instead of moving to outreach, stop - 25 good rows now beat 30 perfect rows next week.

## Before you start: write three sentences

These are not new homework - they are your 1.1 Founding Hypothesis blanks, unpacked for people-hunting. Open your `Founding Hypothesis` doc, copy the sentence in, and expand two of its blanks into full sentences (the third - Business - is the one genuinely new line). Without them, every interview answer sounds encouraging and you can't tell confirm from kill:

| Profile | What to write | Bad vs Good |
|---------|---------------|------------|
| **Customer (one sentence)** | Your `[CUSTOMER]` blank, expanded: *who* is this person in real-world detail - role, company size, the moment in their week when the pain happens. (If you ran the optional Lesson 2.2 persona rehearsal you already sketched role/industry/size - reuse it here.) | Bad: "small-business owners"<br/>Good: "a 12-person law-firm office manager on Friday afternoon trying to invoice ten clients before Quickbooks logs her out" |
| **Business (one sentence)** | The one line your hypothesis doesn't carry: what kind of business are *you* building? B2B SaaS, B2B services, B2C app, marketplace. Free or paid. Self-serve or sales-led. | Bad: "a SaaS tool"<br/>Good: "B2B SaaS, self-serve, $29-49/month annual billing" |
| **Solution (one sentence)** | Your `[APPROACH]` blank, rewritten as the change it makes. You won't pitch this in calls, but you need it written down to know which conversations confirm or kill it. | Bad: "a tool that automates invoicing"<br/>Good: "I think a one-click invoice export to Stripe and Wave saves the office manager 90 minutes every Friday" |

If you can't write all three on a single napkin, do that first.

## Translate the hypothesis into an ICP map

The 2026 shortcut: AI does the part that used to take a week of research. You hand it your three sentences plus two competitor URLs; it returns the ICP profile, the exact places those people post, and the search strings to find named individuals.

Ran the Lesson 1.2 research prompt? Paste 2-3 of those sourced complaints into the prompt as seed pains - they sharpen the search strings better than the hypothesis alone.

Paste this prompt into Claude or ChatGPT:

```text
You are helping me find the first 10 customer interviews for a product I'm validating.

My hypothesis (3 sentences):
- Customer: [paste your customer sentence]
- Business: [paste your business sentence]
- Solution: [paste your solution sentence]

Two competitors or adjacent products serving a similar customer
(start from the `[COMPETITION]` blank in your 1.1 hypothesis - what
your customer uses today):
- [COMPETITOR_1_URL]
- [COMPETITOR_2_URL]

Seed pains from real posts (optional, from your Lesson 1.2 research):
- "[CUSTOMER_QUOTE]"
- "[CUSTOMER_QUOTE]"

Return:
1. A sharper ICP profile (role, industry, company size, the moment in their week when the pain happens, one quote in their language).
2. 8 subreddits, Slack/Discord communities, and forums where this person posts. For each, give the community's topic focus, typical post frequency (e.g., "20 new posts/day" or "2-3 per week"), and 2-3 short keyword phrases that come up most often. Do NOT generate URLs - you cannot browse the web. I will verify the community myself with these inputs.
3. 5 Google + LinkedIn search strings I can paste in today to find named people complaining about this problem (use `site:`, quotes, and `intext:` where helpful).
4. 5 second-degree adjacent search terms I might miss (workarounds they use, related complaints, tool names they'd mention while frustrated).

If you cannot describe a real community for any item, respond with "NOT FOUND - [ITEM]" rather than guessing.
```

> No competitor URLs yet? Ask Claude or ChatGPT to name 3-5 competitors for your one-sentence hypothesis, or Google your problem in plain words plus `tool` or `software` and grab the top 2 results that aren't blog posts.

If a community the AI proposes is dead or off-topic, drop it and ask: `Suggest 3 alternatives more focused on [VERTICAL].`

## Read where they're already complaining

Ran the research prompt back in [Lesson 1.2](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/)? Then you've skimmed these places once already - but that pass collected *phrases* for your landing page. This pass collects the *named people* behind the complaints: every quote you keep now comes with a username and a URL, because these are the people you'll message in 2.4. Start with the threads Perplexity already found for you.

**The simplest way:**

1. Open one of the channels the AI proposed in the ICP map.
2. In the search bar, paste the exact problem phrase in quotes (e.g. `"invoicing takes forever"`).
3. Sort by Top → Past Month. Read the top 30 results.
4. Open a Google Doc. Each time a complaint matches your hypothesis, copy the sentence verbatim - with the username and URL.
5. Repeat for two more channels.

When you're done you should have 30 real sentences and 30 named people. Don't paraphrase - the exact wording is the point, and it becomes your subject lines in Part 2. The per-channel walk (Reddit, LinkedIn, G2, Slack, Twitter, personal network), the Reddit karma rules, and the keyword-variation gallery live in the [full reference](/course/tech-for-non-technical-founders-2026/reference/find-10-people-full/).

## Build a list of 30 specific people

Turn the 30 sentences into 30 names. Open each thread you saved, click each useful username, and copy four things into a spreadsheet: **Name** (theirs, not their company), **role + company** (one cell), **the post you'll reference** (paste the URL), and **one specific line they wrote** (the phrase you'll quote back).

Your Lesson 1.2 complaints each came with a thread URL - those posters are named leads with a known pain; enter them as the first rows (name, post URL, quoted line).

**This is the most important step in the chapter.** A list of 30 individuals you can name - because you read what they wrote - replies far more often than a list of strangers a tool exported for you - the quoted line is the difference. Aim for 30 hand-picked people in one focused sitting, then filter the list on [six dimensions](/course/tech-for-non-technical-founders-2026/reference/find-10-people-full/#filter-the-list-six-dimensions) (buyer-or-user, company size, one industry, one timezone) so the calls are bookable.

> **Save the Apollo filter and whatever contacts your monthly export credits cover (a small monthly allowance on the free tier) to a tab named "Module 5 cold seed" in your outreach spreadsheet.** You will reuse this exact filter in [Lesson 5.7 cold outbound](/course/tech-for-non-technical-founders-2026/outbound-without-sales-team/).

> **Done:** 30-name list is built in your spreadsheet with name, role+company, post URL, and one quoted line per row.
>
> **You have now:** a question list (2.1-2.2) + a 30-name list of real people (2.3). Outreach is next.
>
> **Next:** [2.4 · Find 10 People: What to Say](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) - the message templates, cadence, and follow-up sequence for the list you just built.
>
> **If blocked:** If the AI returned "NOT FOUND" for every community, your hypothesis is too vague. Go back to Lesson 1.1 and rewrite the customer sentence with a specific role, company size, and the moment in their week when the pain happens. If your name list stops at 3 people, search a related keyword ("boarding costs" instead of "pet sitter") - 30 minutes of keyword variation turns 3 names into 12.
>
> **Deeper reference:** [Full channel walk + search-string galleries + list filters + Apollo backfill + monitoring tools + offline-vertical panels](/course/tech-for-non-technical-founders-2026/reference/find-10-people-full/)

---

*See it in action: [Module 2 walkthrough: Mia interviews ten parents](/course/tech-for-non-technical-founders-2026/module-2-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
</content>
