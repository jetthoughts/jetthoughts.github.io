---
title: "Wire Tracking Before You Spend a Dollar"
description: "Install Microsoft Clarity and your ad-platform pixel on your landing page before you run a cent of traffic. Free heatmaps, session recordings, and the 3 numbers you will actually read."
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
> **Input:** the live landing page URL you published in [Lesson 1.2a](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/)
>
> **Output:** tracking installed - Microsoft Clarity + your ad-platform pixel - ready for cold traffic in Lesson 1.3

---

Most founders spend their first $300 of ads before they install any tracking. The dashboard ends up showing 312 clicks and 4 signups, and they assume the offer is wrong. The real failure is usually a broken form redirect that a two-minute session replay would have caught on visitor one. The fix is 15 minutes of free tracking installed before you spend a cent.

After this lesson you will be able to: **install Microsoft Clarity and your ad-platform pixel on your landing page, and name the 3 conversion numbers you will read in Lesson 1.3.**

---

A **tracking snippet** is a small block of code (HTML or JavaScript) that you copy from one site and paste into a field on your page builder. You do not write or edit it. Once installed, each snippet records visitor activity to a dashboard you read later.

You will install two snippets, both free:

- **[Microsoft Clarity](https://clarity.microsoft.com/)** (free forever) gives you a **heatmap** (a color overlay showing where visitors clicked and scrolled most) and **session recordings** (silent video replays of one anonymous visitor's mouse and scroll). After 300 visits, watch ten random replays - the pattern showing why visitors leave usually appears within the first three.
- Your **ad-platform pixel** - a snippet from the ad platform you plan to run traffic on. **Meta Pixel** is Facebook and Instagram's; **LinkedIn Insight Tag** is LinkedIn's; **Reddit Pixel** is Reddit's. Same install steps as Clarity. Without it, the platform optimizes for cheap clicks instead of actual signups, and you get traffic that converts nothing.

(**Google Analytics 4** is a free Google dashboard that tracks visits over months or years. Optional for the smoke test; skip it now and install it later if the hypothesis passes.)

Both snippets paste into the same place on your page builder: the **head-tag field**, the hidden block at the top of every webpage where tracking scripts live. Page builders label this field "head," "custom code," or "tracking scripts" - they all point at the same place (in Mixo: Settings → Custom Code → Header field; in Manus AI or Durable: look for "head" or "tracking scripts").

The 3 numbers you will read in Lesson 1.3:

| Event | What it measures |
|---|---|
| Page view | Total visitors who reached the page |
| CTA click | Visitor clicked the email-form button - measures headline + value-prop strength |
| Form submit | Email address actually submitted - measures friction |

Conversion rate = form submits ÷ page views. That is the number your Founding Hypothesis is judged against.

![Three tracking snippets stacked vertically: Microsoft Clarity (heatmap icon), ad-platform pixel (target icon), GA4 (chart icon), with arrows pointing to a landing page wireframe showing where each snippet fires (page view, CTA click, form submit)](tracking-snippets.svg)

---

1. Create a free Microsoft Clarity account at [clarity.microsoft.com](https://clarity.microsoft.com/). Add your site URL, then copy the tracking snippet shown on the next screen.

2. Paste the snippet into your page builder's head-tag (or "custom code") field. Save the page.

3. Sign up for an ad-platform account on the platform your customer uses most (B2B → LinkedIn or Meta; B2C → Meta or Reddit). Copy that platform's pixel snippet, paste it into the same head-tag field. Save.

4. Open your landing page in an **incognito window** (a private browser tab that ignores your login and cache, so the visit looks fresh to Clarity). Wait 60 seconds, then open Clarity's dashboard and click "Recordings." **✅ Success check:** your visit appears as a session recording. If you see yourself, the tracking is live. (If you used the builder's preview URL instead of the published URL, scripts may be blocked - publish first, then check Clarity.)

---

**If Clarity shows "No data yet" after 5 minutes.** **Why:** the snippet is in the wrong field - usually pasted in the page body instead of the head tag, or your builder's preview mode is blocking scripts. **Fix:** double-check the field name; most builders separate "head code" from "body code," and the snippet must go in head. If your builder only has one "custom code" field, that field is usually the right one. Still nothing after the fix? Wait one hour and re-check. Clarity sometimes lags on the first install.

---

Open Clarity, find your own session recording, and watch it. Write down one thing you did not notice while building the page that you noticed watching yourself as a visitor. That gap between what you intended and what a visitor experiences is what tracking exists to surface.

---

> **Done when:** Microsoft Clarity and your ad-platform pixel are installed, and your own visit shows up as a session recording in Clarity within 60 seconds.
>
> **Next click:** [1.3 · Run the Smoke Test and Read the Signal](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/)
>
> **If blocked:** see "If this fails" above.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
