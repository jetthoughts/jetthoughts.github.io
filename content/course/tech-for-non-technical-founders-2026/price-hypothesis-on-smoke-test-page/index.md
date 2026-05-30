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

> **Module 1 · Step 3 of 3** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a live smoke-test landing page from Chapter 1.2
>
> **Output:** a price hypothesis with a measured click-to-payment signal

> **Heads-up: Stripe verification takes 1-3 business days.** If you've never had a Stripe account, start the signup TONIGHT - not the morning you plan to add the price button. You can build the page without Stripe (use a placeholder button), but you cannot accept live payments until Stripe approves your bank account + tax ID (SSN for US sole proprietors). Approval is usually same-day but can take 24-72 hours if Stripe requests an ID upload. Plan for the 3-day worst case so launch day isn't blocked.

If you landed here directly, start at [Chapter 1.2](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) to build your smoke-test page first - this chapter adds a price signal on top of the demand signal you already measured.

**Three variants exist; here's which one you're doing.** Ch 1.2 sets up the **email-only** version (free, demand signal, simplest first run). This chapter adds the **Stripe price-button** version on top of the same page (still a $1 minimum charge, but you collect a card not just an email). If you want the strongest pre-product signal possible - a $1 refundable pre-order in the Pieter Levels style - that's a separate companion: [Fake-Stripe Pre-Sale: The Pieter Levels Pre-Order Smoke Test](/course/tech-for-non-technical-founders-2026/fake-stripe-pre-sale-pieter-levels/) (read it after this chapter; it carries the FTC + refund discipline). First-time founders: do the email-only test (Ch 1.2) first, then add the Stripe button (this chapter) once that page is live.

## The 48-email lie (why "I'd pay for that" isn't a price test)

Maya, a founder we worked with, ran her smoke-test page with a waitlist CTA. She spent $380 on Meta ads, drove 490 visits, and collected 48 emails - a 9.8% conversion rate that looked respectable by every benchmark she'd found.

> She moved into building. By month nine she had shipped a working product and spent $62K on developer time - and had zero paying customers. On her first sales call the prospect asked whether the tool was really $49/month: she had assumed her landing page price was obvious, but most of the people who had given her an email had read the page as a free signup. The 48 emails proved curiosity, not commitment - the page had only asked them to leave an email.

You don't need a $62K invoice to learn this. Spend any amount on a pretty waitlist page and you'll still have free email signups that don't tell you whether anyone will pay.

An email signup costs the visitor nothing; a Stripe click costs them the moment of entering a card number, even with a refund clause attached - those two signals are not measuring the same thing.

## What your price hypothesis needs (3 parts)

> **Starting point if you haven't done the price research yet.** For a SaaS hypothesis the most common tier sits in **$49-$99/month** for tools that replace manual work, and the broader "SaaS sweet spot" runs **$49-$299/month**. Pick the midpoint of your category's most common tier as your hypothesis. You'll refine after Ch 2 interviews and again after Ch 5.4 paid-pilot calls. The AI deep-research prompt below sharpens this; if you can't run it today, the midpoint-of-band rule is a defensible default.

Testing price before you build has one advantage: there are no switching costs yet. Strangers either click the price or they don't. The test only works if you put a *real* price in front of them - not a category. Three parts:

| Part | What it is | Example |
|------|-----------|---------|
| **Number** | A specific number, not "premium" or "affordable" | $49, not "affordable" |
| **Unit** | Per month, per user, per project, one-time fee | $49/month, not $49 |
| **Framing** | Early-access price, founding-member rate, standard price | "Founding member - $49/month for life," not just "$49" |

All three on the button and in the confirmation copy. Anything less measures curiosity, not price intent.

> **Optional: AI deep-research for the price anchor.** Before you set the price, run this against Perplexity Pro ($20/mo), ChatGPT Deep Research (Pro tier), or Gemini Deep Research ($20/mo Advanced tier): *"What do [your ICP] currently pay for [your category]? Pull from G2 review price snippets, Reddit pricing threads, Capterra category averages, and competitor pricing pages."* The output gives you a real price distribution (e.g., "$19-$79/month is the band, with one outlier at $299"). Pick your hypothesis price ABOVE the cheapest 30%; the smoke test's job is to validate willingness-to-pay, not to be cheaper than the cheapest. **What this is NOT**: a prediction that your price will convert. That's what the Stripe-click rate in the next section measures.

## Set up a Stripe Payment Link (no account integration, no code)

A Stripe Payment Link is a hosted checkout URL you generate from your Stripe dashboard - no code required. Stripe takes ~2.9% + $0.30 per transaction. This is a separate product from Stripe's developer API: no webhooks, no integration. You create a link in the Stripe dashboard, and Stripe hosts the checkout page for you. When someone clicks through and enters their card details, you have a payment intent - the strongest demand signal a pre-product page can generate.

| Step | Action | Where in Stripe |
|------|--------|-----------------|
| 1 | Create free Stripe account | [stripe.com](https://stripe.com) |
| 2 | Open Payment Links | Dashboard → Payments → Payment Links → New link |
| 3 | Add one-time product at hypothesis price | "Add a product" inside the link wizard |
| 4 | Configure after-payment redirect | "After payment" → custom thank-you URL on your landing-page builder |
| 5 | Copy generated `https://buy.stripe.com/xxx` URL | Paste into landing-page CTA button |

**A few gotchas the table doesn't say:**

- **Stripe signup.** You need an email and a business name; the business name can be your own name or a project name (Stripe doesn't verify incorporation at signup). Pick "I'm building a SaaS or software product" when it asks. Stripe will ask for your bank account + tax ID (SSN for US sole proprietors) before you can accept *live* payments - usually approved within a day, sometimes 24-72 hours if Stripe requests an ID upload. **Sign up at least 3 days before launch.**
- **Can't find Payment Links?** Dashboard sidebar → Payments → Payment Links. If hidden, search "Payment Links" in the Stripe search bar (it sometimes tucks under "More").
- **One-time vs subscription.** Use one-time for the smoke test - a "founding member" lifetime or 12-month block. It converts better than a recurring sub on a pre-product page because the commitment is bounded.
- **Thank-you URL on Carrd.** Carrd has no separate "thank-you page" route. Make a hidden second section on the same Carrd page (Settings → Sections → add → set as Hidden) and use its anchor URL (e.g. `yourpage.carrd.co/#thanks`) as the Stripe redirect. Framer and Webflow have real second pages; Carrd cheats with anchors.
- **Refund policy in the footer.** "Full refund within 30 days if we don't ship." Standard FTC-friendly disclosure for pre-orders, also lowers click friction. The signal is still real because card entry took intent.
- **Live mode, not test mode.** Test-mode clicks prove the button works; live mode proves anyone wants to buy.

**What if people click but nobody completes the payment?** Track both the click (page → Stripe) and the completion (Stripe → thank-you). 60 clicks with 3 completions means the checkout page is killing intent (price looked different in context, or the card-entry step surfaced second thoughts). 6 clicks with 3 completions means 50% of clickers actually bought - a strong price signal if the base rate of clicking was low. Same outcome, opposite diagnosis.

## What to measure: clicks vs form-fills vs actual payment-intent

Three signals come off the same landing page. They measure different things. The thresholds below apply to **cold paid traffic** - strangers who arrived from an ad and have never heard of you (the opposite of "warm" traffic, where the visitor already knows your brand). Warm traffic converts at multiples of these rates; don't read your friends-and-family signups against this table.

| Signal | What it actually measures | Threshold to advance |
|--------|--------------------------|---------------------|
| Visit-to-form-fill (email) | Headline resonance - do strangers care enough to give an email? | ≥10% on cold paid traffic |
| Visit-to-Stripe-click | Price hypothesis - does the stated price create intent? | ≥5% on cold paid traffic |
| Stripe-click-to-payment-completion | Checkout friction and price confidence | ≥30% of clickers completing |

The form-fill rate and the Stripe-click rate will diverge. That divergence is the data.

A page that gets 12% email signups but 1% Stripe clicks tells you the value prop is compelling but the price is wrong - or the audience has no budget. A page that gets 4% email signups but 4% Stripe clicks tells you the audience that shows up is small but buying - you might have a niche worth serving at a higher price point. A page that gets 8% email signups and 6% Stripe clicks is what price-hypothesis validation looks like in the clear.

Both signals need to be tracked from the same page view count. Don't compare your email list size to your Stripe dashboard in isolation - run both CTAs in parallel on the same page with the same traffic source, and measure both against total visits.

A practical page layout that runs both in parallel: the primary CTA is the Stripe button with the price visible ("Reserve founding access - $97"). Below it, in smaller text: "Not ready to commit? Join the free waitlist instead." The waitlist form sits below the fold. This weights the Stripe signal as the primary action without eliminating the email signal - keep both, because a strong demand signal with a weak price signal is still useful data, and a Stripe-only page filters out a chunk of interested-but-hesitant visitors before they ever convert.

## The ≥5% threshold: kill, iterate, advance

The **≥5% visit-to-Stripe-click** rate is the decision threshold for the price hypothesis. The three bands:

| Band | Visit-to-Stripe-click | What to do |
|------|----------------------|------------|
| Iterate before you kill | Below 4% | Lower price by 50%, add "founding member" framing, change button copy. Below 2% after that = audience or hypothesis is wrong, not the price. In the 2-4% band, also try shortening the Stripe product description. |
| Advance | 5-9% | Price-validated hypothesis. Move to Module 2 customer interviews. Email everyone who clicked but didn't complete - the most valuable interview group. |
| Verify before celebrating | 10%+ | Either exceptional fit or ad targeting hit a hot audience. Run a second cold channel briefly to verify. If both channels stay near the rate, the signal is real. If one is 12% and the other 2%, your targeting is unusually good, not your pricing. |

The thresholds above assume a $49-$299 price band - the SaaS sweet spot where ad economics and unit economics line up. Below $49, you need more than 5% to cover acquisition cost; above $299 (or any $500+ one-time), 2-3% can be enough if the completion rate is high. Pick the band you're testing and read the table accordingly.

## Two button-copy patterns worth testing

The button label moves the Stripe-click rate more than the price number itself. Two patterns consistently beat plain "Get access - $97" on pre-product pages:

| Pattern | Example button text | When it wins |
|---|---|---|
| **Outcome framing** (anchor the price to the problem it replaces) | "Stop spending 4 hours on reconciliation - $97" / "Skip the $300 trainer - $49 for the 6-week course" / "Replace your $2k/yr bookkeeping subscription - $499" | Buyer can name what the alternative costs them. |
| **Risk-reduction framing** (lead with refundable / refund window) | "Reserve your spot - $97 refundable for 30 days" | First-touch audience, no brand trust yet. |

The outcome reframe shifts the buyer's comparison from "is $97 worth a thing that doesn't exist" to "is $97 worth saving 4 hours / replacing my $2k subscription / skipping a $300 alternative." Whether that math feels cheap to your reader depends entirely on who they are - a freelancer comparing to billable hours reads $97 differently than a parent comparing to a kids-soccer-league fee.

For the smoke test, **pick one pattern. Don't A/B test.** Two-variant testing on a $300 ad budget produces 150 visits each, not enough to distinguish 4% from 5%. Pick the pattern that fits your audience best, ship one button copy, and read the single result against the threshold table above. A/B testing is a post-launch tool, not a smoke-test tool.

If you want copy variants to choose between before launch, run this prompt in Claude:

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

Pick the one that feels most honest to your value prop. Ship it.

## Going further (when to revisit pricing post-launch)

The smoke-test price is a hypothesis price, not your launch price. You're testing whether strangers will click at the stated price, not whether $97 is the right lifetime price for the business. After the smoke test passes, revisit pricing at two moments:

| Moment | What to listen for | How it changes your brief |
|--------|-------------------|--------------------------|
| **After 10 customer interviews** | Comments about budget, alternatives they pay for now, what the problem costs them. | If 5+ mention $250/month for a workaround, your $97 is anchored too low. If 3+ say "under $30 only," audience or value prop needs fixing. Carry interview data into [One-Page Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/). |
| **Before first paid pilot** | What reference customers will sign for given the research weight. | Paid pilots usually settle at 30-50% of eventual list price plus a case-study clause. If the smoke test was $97, a $49-$67 pilot is reasonable - the smoke-test number is the ceiling you tested at, not the floor a real customer will commit to. |

One thing the smoke-test price does NOT tell you: whether the price point is sustainable at scale. A $97 founding-member rate that 20 people pay doesn't prove a $97/month subscription works once you're paying for support, infrastructure, and development out of recurring revenue. That's a post-launch question, not a pre-build one. For now, the smoke test proves one thing: at $97, strangers will click. That's enough to advance to interviews.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
