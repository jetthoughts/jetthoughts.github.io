---
title: "1.3 · Price Your Hypothesis on the Smoke-Test Page"
aliases: ["/blog/price-hypothesis-on-smoke-test-page/"]
description: "A waitlist signup is a worse signal than a Stripe payment-intent click. The 5-minute Payment Link setup that price-tests your smoke-test page."
date: 2026-05-18
draft: false
course_chapter: true
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
  og_title: "1.3 · Price Your Hypothesis on the Smoke-Test Page"
  og_description: "A waitlist signup is a worse signal than a Stripe payment-intent click. The 5-minute Payment Link setup that price-tests your smoke-test page."
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/"
related_posts: false
---

> **Module 1 · Step 3 of 3** · [Tech for Non-Technical Founders 2026](/course/tech-for-non-technical-founders-2026/) course.
> Input: a live smoke-test landing page from Chapter 1.2. Output: a price hypothesis with a measured click-to-payment signal.

If you landed here directly, start at [Chapter 1.2](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-300-dollar-validation/) to build your smoke-test page first - this chapter adds a price signal on top of the demand signal you already measured.

## The 48-email lie (why "I'd pay for that" isn't a price test)

A founder we worked with in early 2026 ran her smoke-test page with a waitlist CTA. She spent $380 on Meta ads, drove 490 visits, and collected 48 emails—a 9.8% conversion rate that looked respectable by every benchmark she'd found.

> She went straight into building her MVP. Nine months later: a product, a $62K dev invoice, zero paying customers. Her first sales call revealed the price she'd assumed was $49/month. Every prospect said "I thought it was free." The 48 emails were people who were genuinely curious—at zero cost to them. Nobody had told her the email meant "I'll pay," because nobody had been asked.

An email signup costs the visitor nothing; a Stripe click costs them the moment of entering a card number, even with a refund clause attached—those two signals are not measuring the same thing.

## Why price IS the hypothesis (not a launch tactic)

Most founders treat pricing as a post-launch problem. "We'll figure that out once we have users." That order reverses the cost structure. By the time you have users you have six months of development spend, a team to pay, and real pressure to anchor low because you can't afford to lose anyone. The price you accept in that situation is the price that keeps users, not the price that makes the business work.

Testing price before you build has a different logic. You have no switching costs yet. If strangers on a landing page won't click a $79/month Stripe button, that tells you one of three things: the price is wrong, the value prop is unclear, or the audience is wrong. Each of those is cheaper to fix on a landing page than after six months of building.

The pattern holds across most early-stage SaaS: founders anchor their price to what they feel comfortable charging rather than to what a stranger will actually click. The smoke-test page is the one moment in the company's life when you can test what a stranger perceives as fair value before the anchor sets.

The price hypothesis has three parts:

| Part | What it is | Example |
|------|-----------|---------|
| **Number** | A specific number, not "premium" or "affordable" | $49, not "affordable" |
| **Unit** | Per month, per user, per project, one-time fee | $49/month, not $49 |
| **Framing** | Early-access price, founding-member rate, standard price | "Founding member - $49/month for life," not just "$49" |

You need all three on the landing page button and in the confirmation copy, or you're not testing price—you're testing curiosity.

## Set up a Stripe Payment Link in 5 minutes (no account integration, no code)

A Stripe Payment Link is a hosted checkout URL you generate from your Stripe dashboard - no code required. Stripe takes ~2.9% + $0.30 per transaction. This is a separate product from Stripe's developer API: no webhooks, no integration. You create a link in the Stripe dashboard, and Stripe hosts the checkout page for you. When someone clicks through and enters their card details, you have a payment intent - the strongest demand signal a pre-product page can generate.

| Step | Action | Where in Stripe |
|------|--------|-----------------|
| 1 | Create free Stripe account | [stripe.com](https://stripe.com) |
| 2 | Open Payment Links | Dashboard → Payments → Payment Links → New link |
| 3 | Add one-time product at hypothesis price | "Add a product" inside the link wizard |
| 4 | Configure after-payment redirect | "After payment" → custom thank-you URL on your landing-page builder |
| 5 | Copy generated `https://buy.stripe.com/xxx` URL | Paste into landing-page CTA button |

Here is the full setup sequence in detail:

**Step 1: Create a free Stripe account at [stripe.com](https://stripe.com).** You need a valid email and a business name. For a pre-product hypothesis, the business name can be your personal name or a project name. Stripe does not verify incorporation at signup. Pick "I'm building a SaaS or software product" when it asks what you're selling.

**Step 2: Go to Dashboard - Payments - Payment Links - New link.** This is in the left navigation under Payments. If you don't see it, Stripe sometimes hides it under "More" depending on your dashboard configuration. Search "Payment Links" in the Stripe dashboard search bar if you can't find it.

**Step 3: Add a one-time product with your hypothesis price.** Click "Add a product" and create a new product. Name it after your hypothesis (e.g., "Founding Member Access - Q3 2026"). Set the price to whatever you're testing. For a SaaS hypothesis, a common first test is a one-time "founding member" price that grants lifetime access or a 12-month block - this converts better than a recurring subscription on a pre-product page because the commitment is bounded. Set the price type to "One time" for this test.

**Step 4: Configure the after-payment page.** Under "After payment," change the default to "Don't show confirmation page" and redirect to a simple thank-you URL on your Carrd or Framer site. Carrd and Framer are no-code landing-page builders - Carrd starts at $19/year, Framer has a free tier. Your thank-you page should say: "You're reserved. We'll email you before we launch." This lets you track confirmed conversions in your landing page builder's analytics.

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

The **≥5% visit-to-Stripe-click** rate is the decision threshold for the price hypothesis. The three bands:

| Band | Visit-to-Stripe-click | What to do |
|------|----------------------|------------|
| Iterate before you kill | Below 4% | Lower price by 50%, add "founding member" framing, change button copy. Below 2% after that = audience or hypothesis is wrong, not the price. In the 2-4% band, also try shortening the Stripe product description. |
| Advance | 5-9% | Price-validated hypothesis. Move to Module 2 customer interviews. Email everyone who clicked but didn't complete - the most valuable interview group. |
| Verify before celebrating | 10%+ | Either exceptional fit or ad targeting hit a hot audience. Run a second cold channel for 72 hours. If both channels stay near the rate, the signal is real. If one is 12% and the other 2%, your targeting is unusually good, not your pricing. |

One practical note about the ≥5% benchmark: it is not a universal law. It's the threshold where the economics of a SaaS business that converts at typical rates (20-30% of trials to paid) become workable. A higher-priced product ($500+ one-time) can build a viable business at 2-3% Stripe click rate if the completion rate is high. A lower-priced product ($9/month) needs the full 5%+ to justify the acquisition cost. Adjust the threshold up if your price is below $49; adjust it down if your price is above $299.

## AI-augmented price-copy variants

Five psychological frames the prompt below generates. Pick the two closest to your actual value prop.

| Frame | Example button text | When it wins |
|-------|--------------------|--------------|
| Access | "Reserve founding member spot - $97" | Pre-product, scarcity is real |
| Outcome | "Stop spending 4 hours on X - $97" | Buyer can name the workaround cost |
| Risk-reduction | "$97, refundable for 30 days" | First-touch audience, low trust |
| Scarcity | "Founding 50 - $97 (closes May 24)" | You can actually enforce the cap |
| Direct | "Get access - $97" | Audience is already warm; no extras needed |

Use this prompt in Claude to generate 3-5 variants to A/B test:

---

```text
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

The button label and supporting copy around the price are the variables that move the Stripe-click rate most, and they're cheap to test. The copy around "how you frame the price" matters as much as the number itself.

Run the five variants through Claude, then pick two that feel most honest to your actual value prop. Don't run all five - you don't have the traffic volume for a five-way split test at $300-$500 budget. Pick two, split traffic 50/50 for the first three days, and cut the lower-converting variant on day four. By day seven you have a winner.

One pattern that consistently outperforms "Buy now - $97" on pre-product pages: anchoring the price to the problem it replaces. "Stop spending 4 hours on reconciliation - $97 to automate it" beats "Get early access for $97" because it makes the $97 feel cheap relative to the alternative. The psychological comparison shifts from "is $97 worth it for something that doesn't exist yet" to "is $97 worth 4 hours of my time per month." For most B2B audiences, $97 is less than one hour of their billable rate - that reframe closes.

## Going further (when to revisit pricing post-launch)

The smoke-test price is a hypothesis price, not your launch price. You're testing whether strangers will click at the stated price, not whether $97 is the right lifetime price for the business. After the smoke test passes, revisit pricing at two moments:

| Moment | What to listen for | How it changes your brief |
|--------|-------------------|--------------------------|
| **After 10 customer interviews** | Comments about budget, alternatives they pay for now, what the problem costs them. | If 5+ mention $250/month for a workaround, your $97 is anchored too low. If 3+ say "under $30 only," audience or value prop needs fixing. Carry interview data into [One-Page Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/). |
| **Before first paid pilot** | What reference customers will sign for given the research weight. | Paid pilots are 30-50% of eventual list price + case study clause. If smoke test was $97, pilot at $49-$67 is reasonable. Smoke-test price = ceiling; pilot price = negotiated floor. |

One thing the smoke-test price does not tell you: whether the price point is sustainable at scale. A founding-member price of $97 that 20 people pay does not prove a $97/month subscription works when you're running support, infrastructure, and development on the recurring revenue. That question gets answered when you move from the smoke test to a real pricing page in Chapter 3.1 ([The One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/)). For now, the smoke test proves one thing: at $97, strangers will click. That's enough to advance.

---

## Module 1 setup checklist

| Item | What it is | Why it matters |
|------|-----------|----------------|
| Stripe account (live mode) | Sign up at stripe.com, enable live mode (not test mode) | Real card attempts measure intent, not button-click luck |
| Payment Link + hypothesis price | Create one-time product in Stripe dashboard with your test price | Tests whether price point creates intent |
| Link pasted into landing page button | Copy `https://buy.stripe.com/xxx` into your CTA button | Closes the intent-to-action loop |
| Refund policy in footer | "Full refund within 30 days if we don't ship" | Lowers psychological friction of clicking paid button |
| Thank-you page redirect | Configure Stripe to redirect to custom thank-you URL after payment | Tracks confirmed conversions in analytics |
| Email + Stripe button on same page | Primary CTA = Stripe button. Secondary = email signup below fold. | Weights the price signal as primary action without losing interested-but-hesitant audience |
| GA4 + Clarity events | Track button clicks and form submissions separately with free tools (GA4 for visits/events; Clarity for session recordings) | Separates visit-to-Stripe-click rate from visit-to-email-signup rate |
| Decision date set | Mark calendar 5-7 days from ad launch where you'll read both signals | Forces disciplined interpretation: no moving the goalposts mid-test |

With that live, you're running a price hypothesis test alongside a demand test. When both come back at threshold—≥10% email, ≥5% Stripe click—you have the strongest validation a pre-product page can generate.

---


*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/course/tech-for-non-technical-founders-2026/) curriculum.*
