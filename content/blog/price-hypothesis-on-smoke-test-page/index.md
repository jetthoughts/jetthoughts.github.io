---
title: "2.2 · Price Your Hypothesis on the Smoke-Test Page"
description: "Why a waitlist signup is a worse signal than a Stripe payment-intent click. The 5-minute Stripe Payment Link setup that turns your smoke-test page into a price hypothesis test."
date: 2026-07-01
draft: false
author: "JetThoughts Team"
slug: price-hypothesis-on-smoke-test-page
keywords:
  - smoke test pricing
  - stripe payment link mvp
  - validate price before build
  - non technical founder pricing
  - landing page payment intent
tags:
  - founders
  - non-technical-founder
  - module-2
  - validation
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "2.2 · Price Your Hypothesis on the Smoke-Test Page"
  og_description: "Why a waitlist signup is a worse signal than a Stripe payment-intent click. The 5-minute Stripe Payment Link setup that turns your smoke-test page into a price hypothesis test."
canonical_url: "https://jetthoughts.com/blog/price-hypothesis-on-smoke-test-page/"
related_posts: false
---

> **Module 2 · Step 2 of 2** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) course.
> Input: a live smoke-test landing page from Module 2.1. Output: a price hypothesis with a measured click-to-payment signal.

---

**The full-course navigation table is at the bottom of this post.** If you landed here directly, start at [Module 2.1](/blog/smoke-test-landing-page-300-dollar-validation/) to build your smoke-test page first - this chapter adds a price signal on top of the demand signal you already measured.

---

A founder we worked with in early 2026 ran her smoke-test page with a waitlist CTA. She spent $380 on Meta ads, drove 490 visits, and collected 48 emails - a 9.8% conversion rate that looked respectable by every benchmark she'd found. She went straight into building her MVP. Nine months later she had a product, a dev invoice for $62K, and exactly zero paying customers. Her first sales call revealed the price she'd assumed was $49/month. Every prospect she called said "I thought it was free." The 48 emails were not lies. They were people who were genuinely curious - at zero cost to them. Nobody had told her the email meant "I'll pay," because nobody had been asked.

The waitlist is social courtesy. The payment-intent click is money leaving a wallet, even if you refund it. Those two signals are not measuring the same thing.

## Why price IS the hypothesis (not a launch tactic)

Most founders treat pricing as a post-launch problem. "We'll figure that out once we have users." That order reverses the cost structure. By the time you have users you have six months of development spend, a team to pay, and real pressure to anchor low because you can't afford to lose anyone. The price you accept in that situation is the price that keeps users, not the price that makes the business work.

Testing price before you build has a different logic. You have no switching costs yet. If strangers on a landing page won't click a $79/month Stripe button, that tells you one of three things: the price is wrong, the value prop is unclear, or the audience is wrong. Each of those is cheaper to fix on a landing page than after six months of building.

Pricing researchers at the Price Intelligently team have been making this point since at least 2018: most SaaS founders anchor their price to what they feel comfortable charging rather than to what the customer perceives as fair value. The smoke-test page is the one moment in the company's life when you can test what a stranger perceives as fair value before the anchor sets.

The price hypothesis has three parts:

1. A specific number (not "premium" or "affordable" - a number)
2. The unit (per month, per user, per project, one-time fee)
3. The framing (early-access price, founding-member rate, standard price)

You need all three on the landing page button and in the confirmation copy, or you're not testing price - you're testing curiosity.

## Set up a Stripe Payment Link in 5 minutes (no account integration, no code)

Stripe Payment Links are a separate product from Stripe's developer API. No webhooks, no integration, no code. You create a link in the Stripe dashboard, and Stripe hosts the checkout page for you. When someone clicks through and enters their card details, you have a payment intent - the strongest demand signal a pre-product page can generate.

Here is the full setup sequence:

**Step 1: Create a free Stripe account at [stripe.com](https://stripe.com).** You need a valid email and a business name. For a pre-product hypothesis, the business name can be your personal name or a project name. Stripe does not verify incorporation at signup. Pick "I'm building a SaaS or software product" when it asks what you're selling.

**Step 2: Go to Dashboard - Payments - Payment Links - New link.** This is in the left navigation under Payments. If you don't see it, Stripe sometimes hides it under "More" depending on your dashboard configuration. Search "Payment Links" in the Stripe dashboard search bar if you can't find it.

**Step 3: Add a one-time product with your hypothesis price.** Click "Add a product" and create a new product. Name it after your hypothesis (e.g., "Founding Member Access - Q3 2026"). Set the price to whatever you're testing. For a SaaS hypothesis, a common first test is a one-time "founding member" price that grants lifetime access or a 12-month block - this converts better than a recurring subscription on a pre-product page because the commitment is bounded. Set the price type to "One time" for this test.

**Step 4: Configure the after-payment page.** Under "After payment," change the default to "Don't show confirmation page" and redirect to a simple thank-you URL on your Carrd or Framer site. Your thank-you page should say: "You're reserved. We'll email you before we launch." This lets you track confirmed conversions in your landing page builder's analytics.

**Step 5: Generate the link.** Stripe generates a URL that looks like `https://buy.stripe.com/xxx`. Copy it. Paste it into your Carrd or Framer button. That's the full setup.

One important detail for a pre-product test: put a refund policy in your footer. "Full refund within 30 days if the product doesn't ship." This is both legally correct (you're collecting money for something that doesn't exist yet) and practically important - it lowers the psychological friction of clicking the button. A visitor who sees "refundable" clicks at a higher rate than one who doesn't. The signal is still real because card entry and click still required intent.

**Test mode vs. live mode:** Stripe has a test mode where no real money changes hands. Use live mode for the smoke test. Test mode clicks don't prove anything about intent; they prove the button works. You want real money, even $1, because the experience of entering card details and clicking "Pay" filters out casual curiosity in a way that test mode does not.

**What if nobody completes the payment?** Track both the click (landing page to Stripe) and the completion (Stripe to thank-you page). A founder who gets 60 clicks and 3 completions has different information than one who gets 6 clicks and 3 completions. Sixty clicks to Stripe with 3 completions means the checkout page is killing intent - possibly because the price looked different in context, or because the card-entry step surfaced second thoughts. Six clicks to Stripe with 3 completions means 50% of people who clicked your button bought - which is a strong price signal if the base rate of clicking was low.

## What to measure: clicks vs form-fills vs actual payment-intent

Three signals come off the same landing page. They measure different things.

| Signal | What it actually measures | Threshold to advance |
|--------|--------------------------|---------------------|
| Visit-to-form-fill (email) | Headline resonance - do strangers care enough to give an email? | ≥10% on cold paid traffic |
| Visit-to-Stripe-click | Price hypothesis - does the stated price create intent? | ≥5% on cold paid traffic |
| Stripe-click-to-payment-completion | Checkout friction and price confidence | ≥30% of clickers completing |

The form-fill rate and the Stripe-click rate will diverge. That divergence is the data. A page that gets 12% email signups but 1% Stripe clicks tells you the value prop is compelling but the price is wrong - or the audience has no budget. A page that gets 4% email signups but 4% Stripe clicks tells you the audience that shows up is small but buying - you might have a niche worth serving at a higher price point. A page that gets 8% email signups and 6% Stripe clicks is what price-hypothesis validation looks like in the clear.

Both signals need to be tracked from the same page view count. Don't compare your email list size to your Stripe dashboard in isolation - run both CTAs in parallel on the same page with the same traffic source, and measure both against total visits.

A practical page layout that runs both in parallel: the primary CTA is the Stripe button with the price visible ("Reserve founding access - $97"). Below it, in smaller text: "Not ready to commit? Join the free waitlist instead." The waitlist form sits below the fold. This setup correctly weights the Stripe signal as the primary action without eliminating the email signal. Founders who run only a Stripe button and no email option lose 80% of the interested audience who won't click a payment link on first contact with the brand.

## The ≥5% threshold: kill, iterate, advance

The **≥5% visit-to-Stripe-click** rate is the decision threshold for the price hypothesis. Here's what each band means in practice:

**Below 2% - kill or reprice substantially.** At this rate, even if every clicker completed the payment, you're looking at fewer than 2 paying customers per 100 cold visitors. The economics don't work at any reasonable cost-per-click. Before killing, run one iteration: lower the price by 50% and add "founding member only" framing. If it stays below 2%, the audience or the hypothesis is wrong - not just the price.

**2-4% - iterate the price-copy combination.** This band suggests some demand but friction in the presentation. Run a second test with different button copy. "Get early access for $97" might outperform "Buy now - $97." The Stripe checkout page itself can also suppress clicks - test sending people to a simpler checkout by shortening the product description in Stripe.

**5-9% - advance.** You have a price-validated hypothesis. The audience will click a payment button at your stated price often enough to build a business around. Move to Module 3 (customer interviews) with the Stripe-click segment as your warmest interview list. Email everyone who clicked but didn't complete - that group is the most valuable interview subject because they showed intent and then dropped off.

**10%+ - verify before celebrating.** At 10%+ visit-to-Stripe-click on cold traffic, you either have exceptional product-market fit at the price point, or your ad targeting accidentally reached a hot audience (e.g., people who were already searching for exactly this product). Run a second cold channel for 72 hours. If LinkedIn shows 11% and Reddit shows 9%, you have a real signal. If one channel shows 12% and another shows 2%, the 12% is your targeting working unusually well, not your price hypothesis being validated.

One practical note about the ≥5% benchmark: it is not a universal law. It's the threshold where the economics of a SaaS business that converts at typical rates (20-30% of trials to paid) become workable. A higher-priced product ($500+ one-time) can build a viable business at 2-3% Stripe click rate if the completion rate is high. A lower-priced product ($9/month) needs the full 5%+ to justify the acquisition cost. Adjust the threshold up if your price is below $49; adjust it down if your price is above $299.

## AI-augmented price-copy variants

The button label and supporting copy around the price are the variables that move the Stripe-click rate most, and they're cheap to test. The copy around "how you frame the price" matters as much as the number itself.

Use this prompt in Claude to generate 3-5 variants to A/B test:

---

```
I'm testing a price hypothesis for a pre-product SaaS landing page.

My hypothesis: [paste your one-sentence Founding Hypothesis here]
My test price: [e.g., $97 one-time founding member access]
My target customer: [e.g., freelance bookkeepers who reconcile client accounts manually]
My hero benefit: [e.g., reconcile Stripe and QuickBooks in 90 seconds instead of 4 hours]

Generate 5 button-label variants and their supporting sub-copy (1 sentence under the button).
Each variant should use a different psychological frame:
1. Access framing (founding member, early access, reserved spot)
2. Outcome framing (price anchored to the outcome, not the product)
3. Risk-reduction framing (refundable, no-risk, cancel anytime)
4. Scarcity framing (limited spots, closes [date])
5. Direct framing (plain price, no extras)

Format each as:
BUTTON: [button text]
SUB-COPY: [one sentence under the button]
FRAME: [which psychological frame]
```

---

Run the five variants through Claude, then pick two that feel most honest to your actual value prop. Don't run all five - you don't have the traffic volume for a five-way split test at $300-$500 budget. Pick two, split traffic 50/50 for the first three days, and cut the lower-converting variant on day four. By day seven you have a winner.

One pattern that consistently outperforms "Buy now - $97" on pre-product pages: anchoring the price to the problem it replaces. "Stop spending 4 hours on reconciliation - $97 to automate it" beats "Get early access for $97" because it makes the $97 feel cheap relative to the alternative. The psychological comparison shifts from "is $97 worth it for something that doesn't exist yet" to "is $97 worth 4 hours of my time per month." For most B2B audiences, $97 is less than one hour of their billable rate - that reframe closes.

## Going further (when to revisit pricing post-launch)

The smoke-test price is a hypothesis price, not your launch price. You're testing whether strangers will click at the stated price, not whether $97 is the right lifetime price for the business. After the smoke test passes, revisit pricing at two moments:

**After 10 customer interviews (Module 3):** The Mom Test interviews will surface comments about budget, alternatives they're paying for now, and what the problem costs them. If five of ten interviewees mention they pay $250/month for a workaround, your $97 hypothesis is probably anchored too low. If three of ten say "I'd only pay if it was under $30," you have a different problem - either the audience is wrong or the value prop needs restructuring. Don't change the live price mid-test; carry the interview data into [The One-Page Product Brief](/blog/one-page-product-brief-vibe-prd/) and let it inform your official pricing page.

**Before the first paid pilot (Module 7):** The [Paid Pilot chapter](/blog/paid-pilot-charge-before-ship/) walks through the Design Partner pricing structure, which is deliberately different from your public price. Paid pilots are typically 30-50% of eventual list price in exchange for a reference customer and feedback. If your smoke-test price was $97, a founding pilot at $49-$67 with a case study clause is a reasonable structure. The smoke-test price tells you the ceiling; the pilot price is the negotiated floor that gets a real person to sign.

One thing the smoke-test price does not tell you: whether the price point is sustainable at scale. A founding-member price of $97 that 20 people pay does not prove a $97/month subscription works when you're running support, infrastructure, and development on the recurring revenue. That question gets answered when you move from the smoke test to a real pricing page in Module 4 ([The One-Page Product Brief](/blog/one-page-product-brief-vibe-prd/)). For now, the smoke test proves one thing: at $97, strangers will click. That's enough to advance.

---

## Module 2 setup checklist

Before you close this page, confirm you have:

- [ ] A Stripe account (live mode, not test mode)
- [ ] A Payment Link created with your hypothesis price as a one-time product
- [ ] The Payment Link URL pasted into your landing page button
- [ ] A refund policy in your page footer ("full refund within 30 days if we don't ship")
- [ ] A thank-you page redirect configured in Stripe after payment
- [ ] Both the email signup and Stripe button on the same page, email below the fold
- [ ] GA4 + Clarity events tracking button clicks and form submissions separately
- [ ] A decision date set (5-7 days from ad launch) where you'll read both signals

With that live, you're running a price hypothesis test alongside a demand test. When both come back at threshold - ≥10% email, ≥5% Stripe click - you have the strongest validation a pre-product page can generate.

---

## Full course navigation

| # | Module | Chapter |
|---|--------|---------|
| 0 | Pre-flight | [Self-Assessment: Where Are You Now?](/blog/course-map-self-assessment-non-technical-founder-2026/) |
| 1 | Form Your Hypothesis | [Form Your Founding Hypothesis: the 90-Minute Sprint](/blog/form-your-founding-hypothesis-90-minute-sprint/) |
| 2.1 | Smoke-Test the Hypothesis | [The $300-$500 Landing Page Validation](/blog/smoke-test-landing-page-300-dollar-validation/) |
| **2.2** | **Price the Hypothesis** | **Price Your Hypothesis on the Smoke-Test Page** ← you are here |
| 3 | Validate the Problem | [Find 10 People With the Problem](/blog/find-10-people-with-problem-outreach-2026/) |
| 3.1 | Interview Method | [The Mom Test: Ask About the Past, Not the Future](/blog/mom-test-ask-about-past-not-future/) |
| 4 | Design the Solution | [The One-Page Product Brief (Vibe PRD)](/blog/one-page-product-brief-vibe-prd/) |
| 5 | Choose Your Build Path | [Should You Hire? The 2026 Decision Tree](/blog/should-you-hire-2026-decision-tree/) |
| 6.1 | Ownership Day 1 | [Who Owns Your GitHub, AWS, and Database?](/blog/github-aws-db-ownership-checklist/) |
| 6.2 | Oversight Rhythm | [The Org Chart Your Dev Shop Won't Draw For You](/blog/engineering-org-chart-non-technical-founder/) |
| 6.3 | Progress Proof | [The Friday Demo Rule](/blog/friday-demo-rule-founder-progress/) |
| 6.4 | Standup Signal | [Three Questions That Turn a Standup Into Proof](/blog/three-questions-turn-standup-into-proof/) |
| 6.5 | Weekly Report | [The Plain-English Weekly Dev Report](/blog/weekly-dev-report-template-founders/) |
| 7 | First Paying Customer | [Charge Before You Ship: The Paid Pilot Contract](/blog/paid-pilot-charge-before-ship/) |
| 7.1 | First 10 Customers | [The First Ten Come From People Who Already Know You](/blog/first-ten-customers-personal-network/) |
| 7.2 | Outbound | [Going Outbound Without a Sales Team](/blog/outbound-without-sales-team/) |
| 8 | When Things Break | [Salvage vs Rebuild](/blog/hire-track-supplementary-ref/) |
| 9 | AI-Era Risks | ["We Use AI" - 5 Follow-Up Questions](/blog/agency-uses-ai-follow-up-questions/) |

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) curriculum.*
