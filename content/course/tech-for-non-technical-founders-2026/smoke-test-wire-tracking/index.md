---
title: "Wire Tracking Before You Spend a Dollar"
description: "Install Microsoft Clarity and ad-platform pixels on your landing page before you run a cent of traffic. Free heatmaps, session recordings, and the 3 numbers you'll actually read."
date: 2026-06-08
draft: true
course_chapter: false
author: "JetThoughts Team"
slug: smoke-test-wire-tracking
keywords:
  - microsoft clarity landing page
  - smoke test tracking setup
  - conversion rate tracking
  - meta pixel ga4 landing page
tags:
  - founders
  - non-technical-founder
  - smoke-test
categories: ["Founders"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/"
related_posts: false
---

> **Module 1 · Lesson 1.2b** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a live landing page URL (from Lesson 1.2a)
>
> **Output:** tracking installed, Clarity + ad pixel + GA4, ready for cold traffic in Lesson 1.3

---

You spend $300 on ads, the dashboard shows 312 clicks, and your email tool shows 4 signups. You assume the offer is wrong, but the real failure is a broken form redirect a two-minute session replay would have caught on visitor one. In this lesson you'll install the three free tracking snippets that turn $300 of ads into answers instead of a lesson.

After this lesson you will be able to: **install Microsoft Clarity, your ad-platform pixel, and GA4 on your landing page, and name the 3 conversion numbers you'll read in Lesson 1.3.**

---

Ad spend without tracking produces one number: how much you spent. Ad spend with tracking produces three numbers that tell you whether your hypothesis holds. The tracking stack costs zero dollars and takes 15 minutes to install.

**The three snippets (install all three before ads run):**

**Microsoft Clarity** ([clarity.microsoft.com](https://clarity.microsoft.com/), free forever), the most useful tool on this list. Paste one snippet into your builder's "custom code" or "head tag" field and you get heatmaps plus session recordings of every visitor. After 300 visits, watch ten random replays. The pattern usually shows up within the first three.

*In Carrd: Settings > Embed > Header. In Framer: Site Settings > General > Custom Code. AI builders (Mixo, Manus AI, Durable): look for "tracking" or "scripts" field.*

**Ad-platform pixel** (Meta Pixel, LinkedIn Insight Tag, or Reddit Pixel), identical shape to Clarity's snippet, same paste pattern. Without it, the platform optimizes for cheap clicks instead of actual signups. You get traffic that looks good in the dashboard and converts nothing.

**Google Analytics 4** (optional, install now if you'll want longer-term analytics; not required for the smoke test).

**The 3 numbers you'll read in Lesson 1.3:**

| Event | What it measures |
|---|---|
| Page view | Total visitors who reached the page |
| CTA click | Visitor clicked the email-form button, which measures headline + value-prop strength |
| Form submit | Email address actually submitted, which measures friction |

**Conversion rate = form submits ÷ page views.** That's the number your Founding Hypothesis is judged against.

![Three tracking snippets stacked vertically: Microsoft Clarity (heatmap icon), ad-platform pixel (target icon), GA4 (chart icon), with arrows pointing to a landing page wireframe showing where each snippet fires (page view, CTA click, form submit)](tracking-snippets.svg)

---

## Do this now

1. Create a free Microsoft Clarity account. Copy the tracking snippet.
2. Paste the snippet into your builder's custom-code field. In Carrd: Settings > Embed > Header. In Framer: Site Settings > General > Custom Code. In AI builders: look for "tracking" or "scripts."
3. Repeat for your ad-platform pixel (pick one: Meta, LinkedIn, or Reddit) and GA4. All three snippets go in the same field.
4. Open your landing page, then open Clarity's dashboard and click "Recordings." **Success check:** You see your own visit appear as a session recording within 60 seconds. If you see yourself, the tracking is live.

**If this fails:** Clarity dashboard shows "No data yet" after 5 minutes. **Why:** the snippet is in the wrong field: it's in the page body instead of the head tag, or your builder's preview mode blocks scripts. **Fix:** double-check the field name. Most builders have separate fields for "head code" vs "body code", the snippet must go in head. If your builder only has one "custom code" field, it's usually the right one. Still failing? Open the page in incognito mode (preview mode sometimes blocks tracking scripts).

---

Open Clarity, find your own session recording, and watch it. Write down one thing you didn't notice while building the page that you noticed watching yourself as a visitor. That's the gap between what you intended and what a stranger experiences, the whole point of tracking.

---

Next: you'll buy cold traffic against the page you just wired, ~300 visits on the right channel, and read the conversion numbers to make a go/iterate/kill decision. The tracking you installed today is what turns that ad spend from a cost into a signal.

> **Done when:** All three tracking snippets are installed, and your own visit appears as a session recording in Clarity within 60 seconds.
> **Next click:** [1.3 · Run the Smoke Test and Read the Signal](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/)
> **If blocked:** If Clarity still shows no data after trying incognito mode, skip the verification and move on. The snippets are likely installed correctly (Clarity sometimes takes 1-2 hours on first setup). You can verify in Lesson 1.3 when real traffic hits the page.

> **Case Study: Tomas**
>
> Tomas shipped his Stripe-to-QuickBooks reconciliation page (from Lesson 1.2a) and installed Clarity plus the LinkedIn Insight Tag. His input: a Mixo page with a headline promising "90 seconds instead of 4 hours" and a 15-second Loom showing a manual reconciliation workflow.
>
> He asked five accounting-firm contacts to visit the page while he watched the Clarity recordings. The first three sessions showed the same pattern: each visitor read the headline, nodded, scrolled past the CTA button, and left. The CTA was gray text on a white background - invisible against the page. Tomas hadn't noticed because he built the page knowing where the button was; his visitors didn't.
>
> He changed the CTA to red with white text and asked two more contacts to visit. Both clicked the button and typed their email. The tracking turned a silent failure (3 visitors left, no signups, no explanation) into an actionable fix (change button color, retest, confirm).
>
> Result: tracking caught the invisible-CTA problem on visitor three instead of visitor 300. Without Clarity, Tomas would have spent $300 on LinkedIn ads, seen 4 signups from 312 clicks, and concluded his hypothesis was wrong. The hypothesis was fine. The button was invisible.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
