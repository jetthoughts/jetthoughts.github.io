---
title: "Full Reference: Stripe Price Test Guide"
description: "Complete Stripe Payment Link setup walkthrough, visit-to-Stripe-click threshold bands, button copy patterns with Claude prompt, click-vs-completion tracking, and pricing revisit moments."
date: 2026-05-18
draft: true
type: reference
slug: stripe-price-test-full
---

> **Reference companion to [Lesson 1.3 · Price Your Hypothesis on the Smoke-Test Page](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/)** — this page contains the full Stripe setup walkthrough with gotchas, click-vs-completion tracking table, detailed threshold bands, button copy patterns, and the Claude copy-generation prompt. Read the micro-lesson first; return here for deep pricing methodology.

---

## The Maya Story (Full Version)

A founder came to us after nine months of building. She'd run her smoke-test page with a waitlist CTA, spent $380 on Meta ads, drove 490 visits, and collected 48 emails — a 9.8% conversion rate that looked respectable by every benchmark she'd found.

She moved into building. By month nine she had shipped a working product and spent $62K on developer time — and had zero paying customers. On her first sales call the prospect asked whether the tool was really $49/month: she had assumed her landing page price was obvious, but most of the people who had given her an email had read the page as a free signup. The 48 emails proved curiosity, not commitment.

You don't need a $62K invoice to learn this. An email signup costs the visitor nothing; a Stripe click costs them the moment of entering a card number. Those two signals are not measuring the same thing.

---

## Full Stripe Payment Link Setup

A Stripe Payment Link is a hosted checkout URL generated from your Stripe dashboard — no code, no integration, no webhooks. Stripe takes ~2.9% + $0.30 per transaction.

| Step | Action | Where in Stripe |
|---|---|---|
| 1 | Create free Stripe account | [stripe.com](https://stripe.com) |
| 2 | Open Payment Links | Dashboard → Payments → Payment Links → New link |
| 3 | Add one-time product at hypothesis price | "Add a product" inside the link wizard |
| 4 | Configure after-payment redirect | "After payment" → custom thank-you URL on your builder |
| 5 | Copy generated `https://buy.stripe.com/xxx` URL | Paste into landing-page CTA button |

**Gotchas the table doesn't say:**

- **Stripe signup.** You need an email and a business name; the business name can be your own name or a project name (Stripe doesn't verify incorporation at signup). Pick "I'm building a SaaS or software product" when it asks. Stripe will ask for your bank account + tax ID (SSN for US sole proprietors) before you can accept *live* payments — usually approved within a day, sometimes 24-72 hours if Stripe requests an ID upload. **Sign up at least 3 days before launch.**

- **Can't find Payment Links?** Dashboard sidebar → Payments → Payment Links. If hidden, search "Payment Links" in the Stripe search bar (it sometimes tucks under "More").

- **One-time vs subscription.** Use one-time for the smoke test — a "founding member" lifetime or 12-month block. It converts better than a recurring sub on a pre-product page because the commitment is bounded.

- **Thank-you URL on Carrd.** Carrd has no separate "thank-you page" route. Make a hidden second section on the same Carrd page (Settings → Sections → add → set as Hidden) and use its anchor URL (e.g. `yourpage.carrd.co/#thanks`) as the Stripe redirect. Framer and Webflow have real second pages; Carrd cheats with anchors.

- **Refund policy in the footer.** "Full refund within 30 days if we don't ship." Standard FTC-friendly disclosure for pre-orders, also lowers click friction. The signal is still real because card entry took intent.

- **Live mode, not test mode.** Test-mode clicks prove the button works; live mode proves anyone wants to buy.

---

## Visit-to-Stripe-Click Threshold Bands

| Band | Visit-to-Stripe-click | What to do |
|---|---|---|
| Iterate before you kill | Below 4% | Lower price by 50%, add "founding member" framing, change button copy. Below 2% after that = audience or hypothesis is wrong, not the price. In the 2-4% band, also try shortening the Stripe product description. |
| Advance | 5-9% | Price-validated hypothesis. Move to Module 2 customer interviews. Email everyone who clicked but didn't complete — the most valuable interview group. |
| Verify before celebrating | 10%+ | Either exceptional fit or ad targeting hit a hot audience. Run a second cold channel briefly to verify. If both channels stay near the rate, the signal is real. If one is 12% and the other 2%, your targeting is unusually good, not your pricing. |

Thresholds assume a $49-$299 price band. Below $49, you need more than 5% to cover acquisition cost; above $299 (or any $500+ one-time), 2-3% can be enough if the completion rate is high.

---

## Click-vs-Completion Tracking

Both signals matter. Track click (page → Stripe) AND completion (Stripe → thank-you):

| Scenario | Diagnosis |
|---|---|
| 60 clicks, 3 completions | Checkout page is killing intent — price felt different in context, or card-entry surfaced second thoughts |
| 6 clicks, 3 completions | 50% of clickers bought — strong price signal, even if the base click rate was low |
| 8% email signups, 6% Stripe clicks | What price-hypothesis validation looks like in the clear |

Same page, both CTAs: primary CTA is the Stripe button with price visible. Below it, smaller text: "Not ready? Join the free waitlist instead." This weights the Stripe signal as primary without eliminating the email signal.

Both signals must be tracked from the same page view count. Don't compare your email list size to your Stripe dashboard in isolation.

---

## Button Copy Patterns (Full)

Two patterns consistently beat plain "Get access - $97" on pre-product pages:

| Pattern | Example | When it wins |
|---|---|---|
| Outcome framing (anchor price to the problem it replaces) | "Stop spending 4 hours on reconciliation — $97" | Buyer can name what the alternative costs them |
| Risk-reduction framing (lead with refundable/refund window) | "Reserve your spot — $97 refundable for 30 days" | First-touch audience, no brand trust yet |

**Do not A/B test on the smoke test.** Two-variant testing on a $300 ad budget produces 150 visits each, not enough to distinguish 4% from 5%. Pick the pattern that fits your audience best, ship one button copy, read the single result. A/B testing is a post-launch tool.

### Claude Copy-Generation Prompt

If you want copy variants to choose between before launch:

```text
I'm testing a price hypothesis for a pre-product landing page.

My hypothesis: [paste your one-sentence Founding Hypothesis here]
My test price: [e.g., $97 one-time founding member access]
My target customer: [e.g., freelance bookkeepers who reconcile client accounts manually]
My hero benefit: [e.g., reconcile Stripe and QuickBooks in 90 seconds instead of 4 hours]

Generate 2 button-label variants and a 1-sentence sub-copy for each:
1. Outcome framing (price anchored to the outcome / alternative cost the buyer already pays)
2. Risk-reduction framing (refundable, 30-day window)

Format each as:
BUTTON: [button text]
SUB-COPY: [one sentence under the button]
```

---

## AI Deep-Research for Price Anchor

Paste into Perplexity Pro ($20/mo), ChatGPT Deep Research (Pro tier), or Gemini Deep Research ($20/mo Advanced tier):

```text
What do [YOUR ICP] currently pay for [YOUR CATEGORY]? Pull from G2 review price snippets, Reddit pricing threads, Capterra category averages, and competitor pricing pages. If you cannot find a real source for any item, respond with "NOT FOUND - [item]" rather than estimating or paraphrasing.
```

**Free-tier fallback:** Paste the same prompt into Claude free or ChatGPT free. Output is less exhaustive but the NOT-FOUND escape valve tells you which items it could not verify.

The output gives a real price distribution (e.g., "$19-$79/month is the band, with one outlier at $299"). Pick your hypothesis price ABOVE the cheapest 30%; the smoke test's job is to validate willingness-to-pay, not to be cheaper than the cheapest.

---

## Pricing Revisit Moments

The smoke-test price is a hypothesis price, not your launch price. Revisit pricing at two moments:

| Moment | What to listen for | How it changes your brief |
|---|---|---|
| After 10 customer interviews | Comments about budget, alternatives they pay for now, what the problem costs them | If 5+ mention $250/month for a workaround, your $97 is anchored too low. If 3+ say "under $30 only," audience or value prop needs fixing |
| Before first paid pilot | What reference customers will sign for given the research weight | Paid pilots usually settle at 30-50% of eventual list price plus a case-study clause. Smoke-test number is the ceiling you tested at, not the floor |

---

## Case Study: Tomas & Mia

**Tomas:** Adds a Stripe price button at "$1,200 founding member — 6 months access at $200/mo equivalent" (one-time). 5% of visitors click (15 of 300). Of those, 3 complete the payment. Weak price signal — won't sustain $200/mo equivalent without the product in hand.

**Mia:** Adds a Stripe price button at "$99 founding member — 4 months access at $25/mo equivalent" (one-time). 6% of visitors click (18 of 300). Of those, 6 complete. Stronger signal than Tomas — parents are used to paying for tutoring.

---

*Built by [JetThoughts](https://jetthoughts.com) as a companion reference to the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
