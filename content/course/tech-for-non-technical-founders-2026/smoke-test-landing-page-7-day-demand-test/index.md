---
title: "1.2c · Smoke Test: Run It and Read the Signal"
aliases: ["/blog/smoke-test-landing-page-300-dollar-validation/"]
description: "Put your landing page in front of 300 cold strangers, read the conversion rate against the go/iterate/kill table, and get the cheapest demand signal before you build."
date: 2026-05-13
draft: true
course_chapter: false
author: "JetThoughts Team"
slug: smoke-test-landing-page-7-day-demand-test
keywords:
  - landing page smoke test
  - validate startup idea before building
  - cold traffic conversion rate startup
tags:
  - founders
  - non-technical-founder
  - smoke-test
  - module-1
categories: ["Founders"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/"
related_posts: false
---

> **Module 1 · Lesson 1.2c · [CORE]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a live landing page with Clarity + GA4 installed (from [Lesson 1.2b](/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/))
>
> **Output:** a go / iterate / kill decision on your hypothesis, backed by real demand signal
>
> **Progress:** M1 · 4 of 5 · Results so far: hypothesis sentence + live landing page + Clarity + GA4 installed

---

You have a live page and tracking installed. Now you need strangers to see it  --  not friends, not your LinkedIn network, not people who want to be polite to you. Three hundred cold visitors tell you more about your hypothesis than 14 polite interviews. Cold strangers don't lie to spare your feelings.

After this lesson you will be able to: **run a cold-traffic smoke test on your landing page, read the conversion rate against the go/iterate/kill threshold, and decide whether to advance, rewrite, or kill your hypothesis.**

---

**Pick your ad channel** based on who your hypothesis names in the [customer] blank:

- **B2C consumer** → [Meta Ads](https://business.facebook.com/) ($0.50-$2 CPC). Best when the product is visual and the audience is broad.
- **B2B / job-title-sold** → [Google Search](https://ads.google.com/) ($3-$8 CPC) if your customer Googles the problem; [LinkedIn](https://www.linkedin.com/campaignmanager/) ($5.50-$22 CPC) if they don't.
- **Developer tools** → [Reddit Ads](https://ads.reddit.com/) ($1-$3 CPC) in r/programming, r/webdev, r/SaaS.
- **Niche vertical** → Google Search long-tail ($1-$5 CPC)  --  real estate, dentists, contractors Googling pain.

**Budget:** depends on your channel's CPC (cost-per-click  --  what one ad click costs). Not ready to spend? Start with the $0 organic path on the [full channel guide](/course/tech-for-non-technical-founders-2026/reference/smoke-test-channel-guide/)  --  slower but real. If you have budget: 300 visits on Meta costs $300-$600; on LinkedIn, $1,800-$6,600.

**Start ad-account setup the weekend BEFORE launch.** First-time ad accounts can take 24-72 hours to approve. Meta is the slowest; Reddit clears same-day.

![A landing page with ad traffic arrows pointing to it, a tracking dashboard showing conversion numbers, and a decision arrow leading to go/iterate/kill](smoke-test-signal.svg)

> **Pixel first:** Install your channel's pixel before launching (Meta Pixel, LinkedIn Insight Tag, or Reddit Pixel -- same copy-paste as Clarity/GA4 in [1.2b](/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/)). Google Ads users: GA4 is already your pixel, skip this step.

---

1. Install your channel's pixel if you haven't already. Open your ad platform's Events Manager (or equivalent), copy the pixel snippet, paste in your page builder's head-tag field -- same process as Clarity and GA4 in Lesson 1.2b. Open your page in an incognito window; verify the pixel fires in your platform's dashboard. Google Ads users: skip this (GA4 is your pixel).
2. Verify your ad account is approved and payment method attached. If not, set it up tonight.
3. Create and launch your campaign. Open the [campaign creation recipe](/course/tech-for-non-technical-founders-2026/reference/smoke-test-channel-guide/#campaign-creation-recipes) for your channel (Meta, Google, LinkedIn, or Reddit). Each recipe walks you through 7 settings: objective, budget, audience, placement, creative, tracking, and launch. Set a daily budget that gets you to 300 visits within 5-7 days.
4. **Do not touch the page.** No headline rewrites, no bid adjustments, no hourly dashboard refreshes. You want raw demand against the original hypothesis  --  not an optimized funnel.
5. After 300 visits, read your conversion rate (form submits ÷ page views) against this table:

| Conversion rate from cold traffic | Decision | What to do |
|---|---|---|
| <3% | Kill or pivot | Hypothesis is wrong. Rewrite the weakest blank and re-test. |
| 3-5% | Iterate the message | Rewrite headline or try a different audience. Same hypothesis, different framing. |
| 6-10% | Promising | Move to [Module 2 interviews](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/). Talk to the people who signed up. |
| 10-20% | Strong signal | Run interviews + [Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/) in parallel. |
| >20% | Suspicious | Either hot market OR broken targeting. Verify with a second channel. |

**✅ Success check:** you have a conversion rate from ≥300 cold visits AND a go/iterate/kill decision written down.

---

**If conversion is below 3%.** **Why:** your [customer] or [differentiation] blank is too vague  --  strangers don't recognize themselves in the headline. **Fix:** go back to [Lesson 1.1](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) and tighten the blank that scored lowest on your 4-lens test.

**If conversion is above 20%.** **Why:** either you have a hot market (rare) or your ad targeting is too narrow (common). **Fix:** run a second channel briefly. LinkedIn 22% + Reddit 3% = your LinkedIn targeting is the variable, not the hypothesis. Both channels near the rate = the signal is real.

---

Open your tracking dashboard. Write down the number that surprised you most  --  the gap between what you expected and what the data says. That gap is the hypothesis blank worth testing first in Module 2.

---

> **Done when:** ≥300 cold visitors have seen your page and you have a conversion rate read against the go/iterate/kill table. Decision written down.
>
> **Next click:** [1.3 · Price Your Hypothesis on the Smoke-Test Page](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/)
>
> **If blocked:** see "If this fails" above. If the ad budget is out of reach, use the $0 organic path on the [full channel guide](/course/tech-for-non-technical-founders-2026/reference/smoke-test-channel-guide/)  --  slower but real.
>
> **Deeper reference:** [Full channel budgets + campaign creation recipes + pixel install + ad account setup timing + B2B budget alternatives](/course/tech-for-non-technical-founders-2026/reference/smoke-test-channel-guide/)

---

> **See it in action:** [Module 1 walkthrough: Mia builds TutorMatch](/course/tech-for-non-technical-founders-2026/module-1-walkthrough-mia/)

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
