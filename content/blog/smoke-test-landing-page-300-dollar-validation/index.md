---
title: "2.1 · Smoke-Test the Hypothesis - $300 Landing Page"
description: "Build a Carrd or Framer landing page in one day, drive $300-$500 of cold paid traffic, decide go/iterate/kill in 5-7 days. The pre-interview demand filter."
date: 2026-05-13
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: smoke-test-landing-page-300-dollar-validation
keywords:
  - landing page smoke test
  - validate startup idea before building
  - carrd framer landing page founder
  - cold traffic conversion rate startup
  - pre-MVP validation 2026
tags:
  - founders
  - non-technical-founder
  - smoke-test
  - landing-page
  - course-companion
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "2.1 · Smoke-Test the Hypothesis - $300 Landing Page"
  og_description: "Build a Carrd or Framer landing page in one day, drive $300-$500 of cold paid traffic, decide go/iterate/kill in 5-7 days. The pre-interview demand filter."
cover_image_alt: "JetThoughts course cover for the smoke test chapter showing a landing page with a CTA button and a $300 ad-spend gauge"
canonical_url: "https://jetthoughts.com/blog/smoke-test-landing-page-300-dollar-validation/"
related_posts: false
---

> **Module 2 · Step 1 of 2** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) course.
> Input: a one-sentence Founding Hypothesis (from Module 1). Output: a go / iterate / kill decision backed by ≥300 paid visits to a real landing page, plus the conversion rate.

*Founder anecdotes in this chapter use anonymized names; dollar amounts, timeframes, and technical specifics are exact.*

## What a Smoke Test Actually Proves

### The 14-interview trap (a $38,400 lesson)

Priya, a FinTech founder, came to us for a rescue in March 2026. She had run 14 customer interviews before starting the build; 12 of the 14 said "I would pay for that." She built the MVP over four months with a Lovable + Supabase stack and a developer her cousin introduced.

*Quick glossary: Lovable is an AI app builder at $20/mo; Supabase is a hosted database with a free tier. Neither requires a developer for the smoke-test stage we describe below.*

When the MVP shipped in late February she ran a $420 Meta ad campaign against the same audience the 14 interviewees came from. Conversion rate on the landing page: 0.6%. Three signups, all churned before the second login.

**Total spend including the developer and tooling: $38,400 plus four months.**

The 14 interviews were not lying. They were doing what interviewees do: being agreeable on a 40-minute call with someone who sounded credible. On a 40-minute Zoom call, agreement is the polite default. In a Meta ad feed, nobody owes you anything - and typing an email is the first action that genuinely costs the visitor. The 12 yes votes vanished when the price of saying yes shifted from "smile and nod" to "type my email."

Cold ad traffic filters demand the way customer interviews cannot. The smoke test runs between [Form Your Founding Hypothesis](/blog/form-your-founding-hypothesis-90-minute-sprint/) and [Find 10 People With the Problem](/blog/find-10-people-with-problem-outreach-2026/) to catch the founder who has a good idea on paper but no audience that will actually click to learn more. The click-through rate from cold traffic is the cleanest signal of real demand you can buy for $300.

### What the test proves (and what it doesn't)

What the smoke test does NOT answer: whether the product works (you have not built it), whether people will pay long-term (they are giving up an email, not a credit card unless you upgrade to the fake-Stripe variant in the sidebar), whether they will retain, or whether your price holds. The smoke test answers one question: when a cold stranger sees your hypothesis sentence as a headline, do enough click the CTA (call-to-action button) to suggest a real audience exists.

Three of the last four FinTech / B2B SaaS rescues we ran in 2026 had the same pre-build trajectory as the founder above. The ones that pivoted before building (or shipped with a baseline conversion rate to compare against in [Find 10 People With the Problem](/blog/find-10-people-with-problem-outreach-2026/) interviews) spent under $1,500 to learn what the FinTech founder spent four months and a developer hire to learn.

### The five-step shape + pre-flight checklist

The five-step shape of the test, before we dig into each step:

1. **Define what you'll measure** - email signup OR Stripe price-button click ($1 pre-sale, optional)
2. **Build the page** - Carrd or Framer, one working day
3. **Set up tracking** - GA4 (Google Analytics 4, free) + Microsoft Clarity (free) + ad-platform pixel, all installed BEFORE ads run
4. **Buy cold traffic** - $300-$500 on the right channel for your ICP (Ideal Customer Profile - the customer you're targeting), 5-7 day run
5. **Read the numbers** - go / iterate / kill against the conversion-rate decision table

**Before Monday, open these tabs** (15 min setup, all free or under $50 to start):

- [ ] Carrd account (carrd.co, free trial; Pro is $9-49/yr)
- [ ] Email tool account - Mailchimp, ConvertKit, or Buttondown (all have free tiers ≤500 contacts)
- [ ] Meta Ads / LinkedIn Ads / Reddit Ads account on the channel you'll pick - payment method attached
- [ ] Your Founding Hypothesis sentence written down (from Module 1)
- [ ] $300-$500 ad budget approved (this is the test, not the build)
- [ ] A 5-7 day calendar window where you will NOT touch the campaign mid-flight

If you don't have a Founding Hypothesis sentence yet, stop and run the [90-minute sprint](/blog/form-your-founding-hypothesis-90-minute-sprint/) first. Everything below assumes you have one.

## Build the Page in One Day

Ship the ugly version. Beautiful pages take three weeks and the founder has lost the thread of what they are testing by week two - so cap design effort at one day even if you have a designer friend offering help.

### Pick your builder: Carrd or Framer

Two tools work for a non-technical founder in 2026.

**Carrd** (carrd.co, $9-49/yr for the Pro plan) is the cheapest path. One-page sites, drag-and-drop blocks, real responsive behavior on mobile. The Pro plan adds form integration with Mailchimp, ConvertKit, or whatever email tool you already use. Carrd does one thing well: it gets a working page live by lunch.

**Framer** (framer.com, free tier for the smoke test, $5-15/mo for custom domain) is the upgrade path for founders who care about typography or want a slightly more sophisticated look. Framer's templates feel like they were designed in 2025, not 2014. Free tier ships a `[yourpage].framer.website` URL that works fine for cold ad traffic; founders only need the paid tier if they want their own domain.

Pick Carrd if you want it done by 11 AM, Framer if you have an afternoon. Skip Webflow, Hugo themes, and Next.js boilerplates - you are running a Tuesday-to-Saturday test, not a website.

### Required sections (in order, top to bottom)

1. A headline that names the audience and the outcome in one sentence. Pull it directly from your [Founding Hypothesis](/blog/form-your-founding-hypothesis-90-minute-sprint/). Bad: "Smart financial tools for founders." Good: "Reconcile your Stripe and QuickBooks books in 90 seconds instead of 4 hours."
2. A sub-headline that names the mechanism in one sentence. "An AI agent that watches your Stripe webhooks and writes the journal entries to your QuickBooks daily."
3. A hero visual. Not a Figma mockup. A 15-second Loom screen recording of you walking through the imagined flow on a static slide deck, with your voice describing what the user sees. If you cannot record a Loom, use a single annotated screenshot. Hero visuals are the cheapest part of the page to overcomplicate; the founder who hires a designer for the hero is already lost.
4. Three or four value props. Each one is a sentence. Each one is a benefit, not a feature. "Daily reconciliation done by 6 AM" is a value prop. "Webhook integration" is not.
5. One CTA. One. Not three. The default CTA is "Get on the waitlist" with an email field. The upgraded CTA is "Reserve your spot ($1 today, refunded if we do not ship)" with a Stripe button (see the advanced sidebar).
6. A footer disclaimer in 11px gray text: "Coming soon. Email signup reserves your spot at launch." This protects you from FTC (US Federal Trade Commission - they require honesty about products you haven't shipped) concerns about advertising a product that does not exist yet. It also gives interviewees a reason to expect a follow-up.

### Banned sections (the temptations)

- Pricing pages. You do not know your price yet.
- FAQ sections. They water down the CTA conversion.
- Customer testimonials. You have no customers. Fake testimonials are fraud.
- A blog. The page goes live for 7 days. There is no blog.
- "About" pages. The visitor came from an ad. They do not care about your founder story yet.
- A "How it works" section longer than the value props. You do not know how it works yet; the test is whether people care.

### The one-day rule (and why)

Founders who give themselves two weeks to build the page tend to spend most of those two weeks on visual polish. Founders who give themselves eight hours fix headlines instead, and headlines are what move conversion on a cold-traffic page.

## Set Up Tracking Before You Spend a Dollar on Ads

This is the part founders skip and regret. Spending $300-$500 on cold traffic without tracking is buying lottery tickets and throwing them away unopened.

Three tools, all free or near-free, configured before the ads go live.

### Google Analytics 4 (free)

Create a GA4 property - GA4 will generate a 5-line JavaScript snippet for you. Paste it into Carrd's or Framer's "custom code" or "analytics" field (no developer needed, 2 minutes). Verify in GA4's real-time view that page views are firing. GA4 is overkill for this test but it is the standard and you will use it later.

*In Carrd, the "custom code" field is under Settings > Embed > Header. In Framer, it's Site Settings > General > Custom Code > End of head tag.*

### Microsoft Clarity (the underrated half)

Install one tracking snippet the same way you installed GA4 and get heatmaps plus session recordings of every visitor for free, forever. Most founders skip Clarity; the ones who don't get the cleanest insight per dollar of the whole stack. The heatmap tells you where attention died on the page; the session recordings show whether visitors scrolled past your CTA or rage-clicked something you thought was a button. After 300 visits you will have 300 session replays. Watch ten random ones; the patterns are obvious within the first three.

### Ad platform pixel

Meta Pixel, LinkedIn Insight Tag, or the equivalent for whichever channel you picked. A "pixel" is a tracking code. (Despite the name, it is JavaScript, not an image.) The ad platform gives you a 5-line snippet. Paste it into Carrd's "custom code" field the same way you installed GA4. Without the pixel, the platform optimizes for cheap clicks rather than signups. Without the pixel installed before launch, the platform is optimizing for clicks, which buys you the cheapest clickers and rarely the cheapest converters.

### The three events to track

Track these three events:

1. **Page view** - fires automatically on landing.
2. **CTA click** - fires when the visitor clicks the button on the email form.
3. **Form submit** - fires when the email actually goes in. This is the conversion event.

Page view to CTA click is the headline-and-value-prop signal. CTA click to form submit is the friction signal (a real audience clicks and then bounces if the form is annoying). Form submit divided by page view is your conversion rate - the number your Founding Hypothesis is being judged against.

### What breaks silently (Marcus's $480 lesson)

The founder who launches ads before the pixel fires has one number at the end of the week: how much they spent. Every other number is missing. Marcus, a B2B SaaS founder, hired us in early 2026 after spending $480 on Meta and only being able to tell us "I think we got some signups." His Meta dashboard showed 312 clicks; his Mailchimp account showed 4 emails - but Mailchimp's signup form had a broken redirect that Clarity session replay would have caught on the first visitor, had Clarity been installed. We rebuilt the tracking stack on a Tuesday, re-ran the same ad set for $260 on the Wednesday-to-Sunday window, and got real numbers back. Lesson cost: $480 plus six days.

## Buy $300-$500 of Cold Traffic on the Right Channel

The right channel depends on your ICP. The wrong channel burns the budget with no signal. Founders who pick wrong here usually do it for the same reason: they pick the channel they personally use most, not the channel their customer uses.

### Pick the channel (3-question decision tree)

Before picking a channel, run these 3 questions in order:

1. **Does your buyer search Google for this problem TODAY?** Yes → Google Search. No → continue.
2. **Is your buyer identifiable by job title or company size?** Yes → LinkedIn. No → continue.
3. **Does your buyer hang out in a known subreddit (r/SaaS, r/programming, r/webdev, etc.)?** Yes → Reddit. No → Meta (default).

The four matches below are tie-breakers when you know your channel; the questions above are for when you don't.

### Channel-by-ICP matches

Four ICP → channel matches, with cost-per-click ranges and the skip rule:

**B2C consumer → Meta** ($0.50-$2 per click). Split budget 60/40 Reels/feed. Pick this when your product is visual and your audience is broad. Meta does not work when your customer is over 55 or you sell to enterprise.

**B2B / job-title-sold → LinkedIn or Google Search** (LinkedIn $8-$20 per click · Google $2-$8). LinkedIn wins for unaware-problem audiences (your customer does not search for the problem yet); Google wins for already-searching audiences (they Google the symptom). LinkedIn falls flat for consumer or under-25 audiences.

**Developer tools → Reddit Ads or Hacker News job listing** (Reddit $1-$3 per click · HN $475/mo flat). Pick this when your audience lives in r/programming, r/webdev, r/devops, r/SaaS, or HN comments. Reddit fails when your buyer is a non-technical procurement role.

**Niche vertical → Google Search** (long-tail intent keywords, $1-$5 per click). Real estate agents, dentists, contractors. Audience does not hang out on social platforms; they Google when they hit the problem.

Twitter / X has decayed enough as a B2B targeting channel to skip for first-time validation in 2026 - the targeting signal is too noisy after the 2024-2025 platform changes.

### Run length: 5-7 days minimum

Day-1 conversion lies. The first 24 hours of any ad campaign attract the platform's most reactive clickers, not the most representative ones; by day 3 the audience normalizes, and by day 5 you have a stable conversion rate. Founders who read the day-1 number and kill the campaign miss every test that needed three days to find the right viewer.

### Volume: ≥300 paid visits

Below 300 the sample is too small to distinguish 2% from 5%. With 300 visits a 5% conversion is 15 signups, a 2% conversion is 6 signups, and the difference between 15 and 6 is meaningful. With 100 visits a 5% conversion is 5 signups, a 2% is 2, and you cannot tell whether you have a hot audience or a noisy one. Spend the $300-$500. Get to 300 visits. Do not pre-judge.

### The $500 framework (why this is the cheapest budget you'll buy)

The Presta Startup Validation Framework 2026 frames the budget bluntly: *if you can't validate with $500 of traffic, you likely can't validate with $50K.* The corollary is that founders who refuse to spend $300 on this test because "I want to save the money for the build" are saving $300 to spend $30,000 instead. The smoke test budget is the cheapest budget in your founder career.

## Read the Numbers, Decide

You have your 300+ visits, your tracked CTA clicks, your form-submit count. Now you read the conversion rate against the table below. The Foundry CRO 2026 industry benchmark report (which cites Unbounce's Q4 2024 data) compares medians by industry and traffic source:

| Benchmark source | Median conversion rate |
|---|---|
| All industries (aggregate) | 6.6% |
| SaaS / technology | 3.8% |
| B2B professional services | 1-3% |
| Paid search traffic | 3.2% |
| Paid social traffic | 1.5% |

These are aggregate medians across mature products with optimized funnels. Your unoptimized smoke test against cold traffic at week one is comparing against a different baseline.

| Email signup CR from cold paid traffic | Decision | What to do |
|---|---|---|
| <3% | Kill or pivot | Hypothesis is wrong. Rewrite (different audience, mechanism, or outcome). Rewrite your [Founding Hypothesis](/blog/form-your-founding-hypothesis-90-minute-sprint/). |
| 3-5% | Iterate the message | Second test with new headline OR new audience. Same product hypothesis, different framing. |
| 6-10% | Promising | Move to [Find 10 People With the Problem](/blog/find-10-people-with-problem-outreach-2026/). Talk to the people who signed up. |
| 10-20% | Strong signal | Run [customer interviews](/blog/find-10-people-with-problem-outreach-2026/) + [The One-Page Product Brief](/blog/one-page-product-brief-vibe-prd/) in parallel. You have a hot audience. |
| >20% | Suspicious | Either hot market OR broken ad targeting. Verify with a second cold channel. |

### Three rules for reading the table honestly

#### Rule 1: The lowest Magic Lens score predicts which blank to rewrite

The lens that scored lowest in [Form Your Founding Hypothesis](/blog/form-your-founding-hypothesis-90-minute-sprint/) is the part of the message most likely to fail this test.

- **Customer lens scored 2/5 in the Foundation Sprint?** Expect conversion below 5%. The audience question was the weak link.
- **Money lens scored 1/5** (like our procurement-tool founder)? Expect respectable conversion but the price-test in [The One-Page Product Brief](/blog/one-page-product-brief-vibe-prd/) to fail.

The smoke-test number tells you which of the five Mad Libs blanks the audience is rejecting. It does not tell you the product idea is dead. Rewrite the blank that the lens flagged and re-test.

#### Rule 2: Do not optimize the page mid-test

Founders who see a 2% conversion on day 3 and rewrite the headline are no longer running a test - they are running an A/B/C/D test with a sample size of 100 each, which is statistically useless.

You want raw demand against the original hypothesis, not optimized funnel performance. If the original hypothesis flunks at 2%, that is the answer. A 4% conversion against a hybrid sentence you never wrote down proves nothing.

#### Rule 3: A >20% conversion is suspicious, not validation

A 25% conversion rate on cold traffic feels like product-market fit. It usually means one of three things:

- **Hot audience** - rare and great
- **Mis-targeted audience** - your ad targeting selected for an audience that already had the problem solved by a competitor and they are signing up to compare
- **Misleading creative** - your ad set expectations the product does not meet, and they will all churn at signup confirmation

To verify, run a second cold channel for 48 hours:

- LinkedIn 18% + Reddit 22% = you have a hot market
- LinkedIn 22% + Reddit 3% = your LinkedIn targeting is the variable, not the hypothesis

A reasonable two-week schedule for the smoke test:

| Day | What you do |
|---|---|
| Mon | Write the page in one day using your [Founding Hypothesis](/blog/form-your-founding-hypothesis-90-minute-sprint/) |
| Tue | Install GA4, Clarity, and the ad platform pixel; verify all three fire |
| Wed morning | Launch the ad campaign on your chosen channel |
| Wed afternoon - Sun | Do nothing. No headline rewrites, no bid adjustments, no hourly dashboard refreshes |
| Mon of week 2 | Read the numbers. Make the go / iterate / kill decision |

If go, [customer interviews](/blog/find-10-people-with-problem-outreach-2026/) start Tuesday with your signup list as the warmest cold list you have ever had. If iterate, you have one more week and one new test ahead of you. If kill, you have a $300-$500 receipt and seven days saved versus building the product.

### Three numbers to memorize

If you remember nothing else from this chapter, remember these three numbers:

| Number | What it means |
|---|---|
| **300** | Minimum paid visits before reading the conversion rate (anything less is noise) |
| **5%** | Cold-traffic conversion threshold - below means rewrite, above means advance to Module 3 |
| **$300-$500** | Total budget. Less than this is too small; more than this is over-investing in a pre-build test |

### Your Monday morning

1. Open Carrd or Framer
2. Paste your Founding Hypothesis sentence as the H1 headline (one edit pass, no more than 30 minutes)
3. Set a 6-hour timer for the rest of the page (sub-headline, hero visual, 3-4 value props, CTA, footer disclaimer)
4. Tuesday: install GA4 + Clarity + the ad pixel (your channel of choice)
5. Wednesday morning: launch the campaign and walk away until Monday of week two

### When the smoke test isn't the right filter

The smoke test misses founders whose product genuinely needs a longer education arc to make sense (a category-creation product, a complex B2B integration, a regulated-industry tool). What this looks like in the numbers: a 2-3% conversion rate that the founder reads as "kill the hypothesis" when the real signal is "this product needs a sales motion, not a Meta ad." If your hypothesis sentence is hard to fit in a headline, the smoke test is not the right filter - run a paid-pilot conversation instead. See [Charge Before You Ship](/blog/paid-pilot-charge-before-ship/). For everything else, $300-$500 of cold traffic is the cheapest answer you will buy.

## Advanced (optional sidebar)

First-time founders should run the email-only smoke test above. Two upgraded variants are available for founders on their second or third hypothesis who want stronger signal:

### Variant A: Stripe price button ($1 charge as the CTA)

A waitlist signup tells you "this concept sounds interesting." A clicked Stripe payment link tells you "I would pay for this." Different signals. The smoke test gets sharper with the price-button version.

#### Why a price button beats a waitlist

A waitlist captures curiosity (a free email costs the visitor nothing). A $1 charge captures a wallet decision. The same 100 visitors who would cheerfully give you an email might generate zero payment clicks - and that zero is the validated demand signal you actually need.

#### How to set up a Stripe Payment Link in 5 minutes

No Stripe account integration. No code. Just a link.

1. Create a free Stripe account at stripe.com
2. Dashboard - Payments - Payment Links - New
3. Add a product (your hypothesis name) with a price (your hypothesis price)
4. Stripe generates a hosted checkout URL like `https://buy.stripe.com/test_xxx`
5. Paste the URL into your landing page button

The button label matters. "Reserve your spot for $99" outperforms "Buy now" for pre-product hypotheses (signals "early access" framing).

#### What to measure

If you added a Stripe price button (not just an email signup), you have three numbers to track. These thresholds apply ONLY to the price-button variant - the default email-only decision table is in "Read the Numbers, Decide" above.

| Signal | Measures | Price-button threshold |
|---|---|---|
| Visit-to-payment-click rate | "I would actually pay" | ≥5% = price hypothesis validated |
| Form-fill-to-payment-click rate | Quality of intent | ≥30% = the people who care, really care |
| Visit-to-form-fill rate | Headline strength (see email-only table above for full gradient) | n/a |

The ≥5% click-to-payment-intent threshold is the price-button go/iterate/kill signal. Below 3% means rethink price OR rethink hypothesis. Between 3-5% means iterate the headline + button copy. Above 5% means advance to Module 3 (interviews) with a price-validated hypothesis in hand.

For a deeper dive on the price hypothesis (when to revisit pricing post-launch, how to A/B test prices, what to do if traffic is low but click rate is high), see [Price Hypothesis on the Smoke-Test Page](/blog/price-hypothesis-on-smoke-test-page/) (Chapter 2.2 - dedicated chapter).

### Variant B: Pieter Levels fake-Stripe pre-sale

The default smoke test captures email addresses. The Pieter Levels upgrade captures dollars.

Replace the "Get on the waitlist" CTA with a "Reserve your spot ($1 today, refundable if we do not ship by [date])" CTA wired to a real Stripe checkout. After the $1 charge, the user lands on a confirmation page that says "you are reserved, we will email you when we ship." The $1 charge proves the user was willing to type a credit card, not just an email. The conversion rate drops 3-5x compared to the email-only version - that is the point. The remaining converters are real demand, not curious clickers.

Pre-sale tiers from a $300-$500 traffic spend, based on Levels' own 70-product track record at [levels.io](https://levels.io/startups/):

- 0 sales: invalidate the hypothesis or the price.
- 1-10 sales: iterate the headline or the audience.
- 50+ sales from $500 of traffic: product-market-fit signal is in range; move to [customer interviews](/blog/find-10-people-with-problem-outreach-2026/) and [The One-Page Product Brief](/blog/one-page-product-brief-vibe-prd/) in parallel.

Both variants require Stripe + refund discipline + FTC compliance copy. Skip them on your first run.

## Further reading

- Founder FAQs, [How to Run a Smoke Test Landing Page to Prove Demand](https://founderfaqs.com/blogs/how-to-run-a-smoke-test-landing-page-to-prove-demand) - 2026 step-by-step on the smoke-test workflow, including the email-CTA variant and the fake-Stripe variant.
- Presta, [Startup Validation Framework 2026](https://wearepresta.com/startup-validation-framework-2026-the-ultimate-guide-to-testing-ideas/) - the $500 budget rule and the validation-before-build doctrine.
- Foundry CRO, [Landing Page Conversion Rate Benchmarks 2026](https://foundrycro.com/blog/landing-page-conversion-rate-benchmarks-2026/) - the conversion-rate medians by industry and traffic source (citing Unbounce Q4 2024).
- Pieter Levels, [the 70-product startups portfolio](https://levels.io/startups/) - the fake-Stripe pre-sale playbook in operation across a decade of indie launches.
- Kromatic, [Real Startup Book - Landing Page Smoke Test](https://kromatic.com/real-startup-book/4-evaluative-market-experiment/landing-page-smoke-test) - the canonical Lean Startup version of the smoke-test experiment with the original Evaluative Market Experiment framing.
- [Carrd](https://carrd.co/) - the cheapest one-page builder for a smoke-test landing page.
- [Framer](https://framer.com/) - the upgrade for founders who want better typography and templates.
- [Microsoft Clarity](https://clarity.microsoft.com/) - free heatmaps and session recordings, no spending cap, the underrated half of the tracking stack.
- [PostHog](https://posthog.com/) - open-source product analytics alternative to GA4 + Clarity, useful once the smoke test passes and you start build.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) curriculum.*
