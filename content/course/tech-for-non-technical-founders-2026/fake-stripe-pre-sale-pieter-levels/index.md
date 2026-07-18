---
title: "Fake-Stripe Pre-Sale: The Pieter Levels Pre-Order Smoke Test"
description: "When a $1 refundable Stripe charge is a stronger demand signal than an email signup. The pre-sale variant of the smoke test, with refund + FTC compliance notes."
date: 2026-05-23
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: fake-stripe-pre-sale-pieter-levels
keywords:
  - fake stripe presale
  - pieter levels presale
  - pre-order smoke test
  - dollar intent vs email signup
  - $1 refundable validation
tags:
  - founders
  - non-technical-founder
  - smoke-test
  - course-companion
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Fake-Stripe Pre-Sale: The Pieter Levels Pre-Order Smoke Test"
  og_description: "When a $1 refundable Stripe charge is a stronger demand signal than an email signup. The pre-sale variant of the smoke test, with refund + FTC compliance notes."
cover_image_alt: "JetThoughts companion cover for the fake-Stripe pre-sale: a landing page with a 'Reserve $1 refundable' button flowing into a Stripe $1.00 charge panel with an auto-refund indicator, beside Pieter Levels' 0 / 1-10 / 50+ outcome tiers"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/fake-stripe-pre-sale-pieter-levels/"
related_posts: false
---

The default [smoke test](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) captures email addresses. The Pieter Levels variant captures dollars instead - a real $1 refundable Stripe charge as the CTA, before the product exists.

This page is the companion writeup for that variant. Use it when an email-only signal isn't strong enough to commit to a build.

## Email signup vs $1 refundable charge

A waitlist captures curiosity (a free email costs the visitor nothing). A $1 charge captures a wallet decision. The same 100 visitors who would cheerfully give you an email might generate zero payment clicks - and that zero is the validated demand signal you actually need.

The conversion rate drops 3-5x compared to the email-only version. That is the point. The remaining converters are real demand, not curious clickers.

## When to use this instead of email-only

- You ran the email-only smoke test and the signal was strong (>10% conversion); now you want to upgrade to dollar intent before you build.
- Your hypothesis price is high enough ($50+) that the wallet decision is a meaningful gate.
- You're on your second or third hypothesis and need a sharper signal than email curiosity provides.

If you're running your first ever smoke test, use [the email-only version](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) - it's faster to set up, and the refund + FTC discipline below adds real overhead.

## The setup (15 minutes)

The Stripe Payment Link mechanic is the same as in [Lesson 1.5 (Price Your Hypothesis on the Smoke-Test Page)](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) - read that for the full setup walkthrough. The variant-specific changes:

1. **CTA copy.** Replace "Get on the waitlist" with **"Reserve your spot ($1 today, refundable if we don't ship by [DATE])"**. The "$1 today" + "refundable" combination is the load-bearing phrase.
2. **Thank-you page.** "You're reserved. We'll email you when we ship. Your $1 is fully refundable. If we don't ship by [DATE], you get an automatic refund within 7 days. If you change your mind sooner, reply to this email and we'll refund within 24 hours."
3. **Footer disclosure.** A one-line "About this pre-order: we are testing demand for [PRODUCT]. If we don't ship by [DATE], you get an automatic refund. Your $1 charge appears as JTHOUGHTS-RESERVE on your statement."
4. **Stripe metadata.** Set the product name to your hypothesis title + "(pre-order)". This shows up on the customer's bank statement and on the refund record.

## Refund discipline (non-negotiable)

If the test fails (you don't ship), you refund every $1 charge **automatically** within 30 days. Two reasons:

- **Ethics.** People gave you real money for a product that doesn't exist. The refund is the implicit contract.
- **FTC compliance.** US FTC pre-order rules require you to ship within 30 days of the charge unless you disclose the delay in writing AND get the buyer's consent. The landing-page disclosure ("refundable if we don't ship by [DATE]") is the written delay notice; completing the checkout is the buyer's consent to the disclosed delay. The thank-you page repeats the refund promise. Together they satisfy FTC pre-order requirements for the smoke-test window.

Set a calendar reminder for Day 25 of the test window. If you haven't started the build by then, log into Stripe and refund all charges in one batch (Dashboard > Payments > select all > Refund). Takes 5 minutes.

## Reading the result (Levels' 70-product tiers)

Based on Pieter Levels' [70-product startups portfolio](https://levels.io/startups/) - a decade of running this exact test:

| Pre-sale count from a typical traffic spend | What it means | Next move |
|---|---|---|
| **0 sales** | Hypothesis or price is wrong | Invalidate; rewrite the [hypothesis sentence](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) or the price point |
| **1-10 sales** | Hypothesis directionally right; headline or audience wrong | Iterate headline + ad targeting; re-run for one more week |
| **50+ sales** | Product-market-fit signal in range | Move to [customer interviews](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) and [The One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/) in parallel; start building |

## What this test does NOT prove

The fake-pre-sale signal tells you the headline + price + audience combination converts at the moment of decision. It does NOT tell you:

- Whether the product will retain users once shipped (that's [Lesson 5.1, the Sean Ellis 40% test](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/)).
- Whether the unit economics work at full price (that's a follow-on test post-launch).
- Whether the people who pre-ordered will actually use the product (that's interview-stage research - [Lesson 2.1, The Mom Test](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/)).

The pre-sale is the strongest pre-build demand signal you can buy. It is not validation that you have a business.

## Further reading

- Pieter Levels, [the 70-product startups portfolio](https://levels.io/startups/) - this technique in operation across a decade of indie launches.
- [Lesson 1.4 (the standard smoke test - run-it phase)](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) and [Lesson 1.2 (build the page)](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/) - the email-only version this page upgrades.
- [Lesson 1.5 (Price Your Hypothesis on the Smoke-Test Page)](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) - the full Stripe Payment Link setup walkthrough.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
