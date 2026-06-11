---
title: "1.3 · Price Your Hypothesis on the Smoke-Test Page"
aliases: ["/blog/price-hypothesis-on-smoke-test-page/"]
description: "A waitlist signup is a weaker signal than a Stripe payment-intent click. Add a price button to your smoke-test page and measure whether anyone will pay, not just whether anyone is curious."
date: 2026-05-18
draft: true
course_chapter: false
author: "JetThoughts Team"
slug: price-hypothesis-on-smoke-test-page
keywords:
  - smoke test pricing
  - stripe payment link mvp
  - validate price before build
tags:
  - founders
  - non-technical-founder
  - module-1
  - validation
categories: ["Founders"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/"
related_posts: false
---

> **Module 1 · Lesson 1.3 · [CORE]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a live smoke-test landing page from [Lesson 1.2c](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/)
>
> **Output:** a price hypothesis with a measured click-to-payment signal
>
> **Progress:** M1 · 5 of 5 · Results so far: hypothesis sentence + live landing page + tracking installed + conversion data

---

A founder we worked with ran a waitlist page, collected 48 emails at 9.8% conversion, and spent $62K building the product. Zero paying customers. Her visitors had read the page as a free signup  --  the 48 emails proved curiosity, not commitment. An email signup costs nothing; typing a card number costs the moment of second-guessing. Those two signals are not measuring the same thing.

After this lesson you will be able to: **add a Stripe Payment Link to your smoke-test page and measure whether strangers will click a real price  --  not just whether they'll leave an email.**

---

A **Stripe Payment Link** is a hosted checkout URL you generate from your Stripe dashboard  --  no code, no integration. You paste the link on your landing page. Stripe hosts the checkout. Strangers who click through and enter card details produce a payment intent  --  the strongest demand signal a pre-product page can generate.

Your price hypothesis needs three parts:

| Part | What it is | Example |
|---|---|---|
| **Number** | A specific dollar amount, not "affordable" | $49, not "premium" |
| **Unit** | Per month, per user, or one-time | $49/month, not $49 |
| **Framing** | Early-access or founding-member rate | "Founding member  --  $49/month for life" |

**Default price anchor:** For SaaS, the most common tier is $49-$99/month if the tool replaces manual work. If you can't research yet, pick the midpoint of your category's band. You'll refine after Module 2 interviews.

**Button copy matters more than the price number.** Two patterns consistently work:

- **Outcome framing:** "Stop spending 4 hours on reconciliation  --  $97" (anchors price to the problem it replaces)
- **Risk-reduction framing:** "Reserve your spot  --  $97 refundable for 30 days" (reduces first-touch risk)

Pick one pattern. Do not A/B test  --  150 visits each on a $300 budget can't distinguish 4% from 5%. Ship one button copy.

![Stripe Payment Link flow: dashboard → create link → paste URL on landing page → visitor clicks → card entry → payment intent](stripe-payment-link.svg)

---

1. **Start Stripe verification tonight.** Sign up at [stripe.com](https://stripe.com) (free). Stripe needs your bank account + tax ID before accepting live payments  --  usually 1-3 business days. Start the weekend before launch.
2. Create a Payment Link. Dashboard → Payments → Payment Links → New link. Add a one-time product at your hypothesis price. Use one-time (not subscription)  --  "founding member" converts better on a pre-product page.
3. Set the after-payment redirect to a thank-you page. On Carrd: create a hidden section and use its anchor URL (`yourpage.carrd.co/#thanks`).
4. Add a refund line in your footer: "Full refund within 30 days if we don't ship." Legal, honest, lowers click friction.
5. Paste the Payment Link URL on your CTA button. Below it, smaller text: "Not ready? Join the free waitlist instead."
6. **✅ Success check:** your Stripe dashboard shows live-mode (not test-mode) and the button opens a real checkout page.

---

**If Stripe verification takes more than 3 days.** **Why:** Stripe sometimes requests an ID upload for first-time accounts. **Fix:** build the page without the button. Run the email-only smoke test from 1.2c while Stripe processes. The demand signal doesn't depend on the price button being live today.

**If visitors click the button but nobody completes payment.** Track both: click (page → Stripe) and completion (Stripe → thank-you). 60 clicks with 3 completions = the checkout page is killing intent (price felt different in context). 6 clicks with 3 completions = 50% of clickers bought  --  strong signal. Same outcome, opposite diagnosis. The [full price test guide](/course/tech-for-non-technical-founders-2026/reference/stripe-price-test-full/) has the detailed threshold table.

---

Open your Stripe dashboard. Write down the number of clicks vs. completed payments. Which number is lower than you expected? That gap is your pricing research question for Module 2 interviews.

---

> **Done when:** Stripe Payment Link is live on your smoke-test page and you have a measured click-to-payment rate.
>
> **Next click:** [2.1 · The Mom Test: Ask About the Past, Not the Future](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/)
>
> **If blocked:** see "If this fails" above. Module 1 closes here. Before Module 2, you should have: hypothesis (1.1), landing page (1.2a), tracking (1.2b), conversion data (1.2c), and a price signal (1.3). Missing one? Go back to that lesson.
>
> **Deeper reference:** [Full Stripe setup walkthrough + pricing revisit moments + threshold bands](/course/tech-for-non-technical-founders-2026/reference/stripe-price-test-full/)

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
