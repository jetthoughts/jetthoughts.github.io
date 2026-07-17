---
title: "5.6 · Charge Before You Ship: The Paid Pilot Contract"
aliases: ["/blog/paid-pilot-charge-before-ship/"]
description: "A verbal yes is not a paid pilot. A refundable Stripe deposit signed before kickoff is. The one-page Design Partner Agreement and a Stripe Checkout setup."
date: 2026-05-13
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: paid-pilot-charge-before-ship
keywords:
  - paid pilot contract founder
  - design partner agreement template
  - charge for pilot saas
  - stripe checkout rails django
  - first paying customer deposit
tags:
  - founders
  - non-technical-founder
  - first-paying-customer
  - sales
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "5.6 · Charge Before You Ship: The Paid Pilot Contract"
  og_description: "A verbal yes is not a paid pilot. A refundable Stripe deposit signed before kickoff is. The one-page Design Partner Agreement and a Stripe Checkout setup."
cover_image_alt: "JetThoughts blog cover showing a one-page Design Partner Agreement with the deposit clause highlighted"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/paid-pilot-charge-before-ship/"
related_posts: false
---

> **Module 5 · Lesson 5.6 · [CORE]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** 3-5 warm leads from [Lesson 5.5](/course/tech-for-non-technical-founders-2026/first-ten-customers-send-track/)
>
> **Output:** 1 signed paid pilot before any new code ships
>
> **Progress:** M5 · 6 of 7 · Results so far: demos booked from your warm list (5.3-5.5) - this page turns one into a signed pilot with money attached

> **TL;DR:** A verbal yes is not a paid pilot. A signed DPA (Design Partner Agreement - a one-page co-design pilot contract) with a refundable Stripe deposit is. Charge 10-30% of year-one ACV (annual contract value - what one customer pays in year one) before kickoff - it puts the CFO question on Week 0 instead of Week 8.

---

A free pilot feels collaborative: the customer says yes, you build for six weeks, and every Friday demo gets "this is great." Then Week 8 lands, you send the year-one contract, and the customer says "let me circle back to my CFO" - a CFO who never heard of you and never approved the pilot. A refundable Stripe deposit signed before kickoff is what turns that dead end into a formality.

After this lesson you will be able to: **sign a Design Partner Agreement with a refundable Stripe deposit before writing new code.**

---

Same product, same buyer, one difference - when the money lands:

| Variant | Setup | Result at Week 8 |
|---|---|---|
| **Free pilot** | Six weeks of free build, customer "loves it," a wall of enthusiastic Slack messages, year-one contract sent on day pilot ended | "We're going to revisit at the next budget cycle." There is no next budget cycle. |
| **Paid pilot** | One-page Design Partner Agreement, $1,200 refundable deposit collected before any code ships | Year-one contract closes day one. |

Real money on the table before kickoff forces the internal budget conversation while nothing is riding on it yet. You are not asking for money - you are asking the customer to defend the spend internally. That defense is the test of whether the pilot is real.

![Free pilot vs paid pilot - what skin in the game does](free-vs-paid-pilot.svg)

> **Course terminology: "first paying customer" = signed DPA + cleared deposit.** When the course says "first paying customer," it means the customer has signed the one-page DPA AND the Stripe deposit has cleared - real money in your account. Converting the pilot into a year-one contract is a separate event 6-10 weeks later, after the success criteria are met.

The DPA is a one-page letter of intent that names the customer as a design partner, defines the pilot scope, sets the deposit, and converts to year-one on success. It is mutual-edit, plain English, and v1 needs no lawyer. Six sections plus signatures:

| # | Section | What goes in it |
|---|---------|-----------------|
| 1 | Scope of pilot | 3 outcomes the customer wants. 2 specific use cases. Anything outside is out of scope. |
| 2 | Duration + dates | 6-8 weeks. Start date. End date. Weekly Friday demo at a named time. |
| 3 | **Pilot fee + deposit** (load-bearing) | 10-30% of year-one ACV. Paid via Stripe before kickoff. Credited toward year-one on conversion. |
| 4 | Success criteria | 3 measurable outcomes - hours saved, errors avoided, revenue produced. Friday-demo verified. |
| 5 | Conversion terms | Year-one price. Annual or monthly. Auto-conversion or opt-in. Notice period. |
| 6 | Data, IP, termination | Customer keeps their data. You keep the product IP. 30-day written notice to exit. |
|  | Signature block | DocuSign, HelloSign, or PDF + email confirmation - whichever the customer prefers. |

The clause-by-clause detail - what each section is really doing, and what happens each Friday after the deposit clears - is in the [full reference](/course/tech-for-non-technical-founders-2026/reference/paid-pilot-full/).

### Copy-paste DPA template {#dpa-template}

Verbatim - fill the brackets, send.

Open a Google Doc. Paste the block below. Replace every `[BRACKETED]` value with your numbers. Total document: one page, ~400 words. No lawyer review needed for v1.

```text
DESIGN PARTNER AGREEMENT

Between: [Your Company Name] ("Company") and [Customer Company Name] ("Design Partner")
Date: [YYYY-MM-DD]

1. SCOPE OF PILOT
The Company will deliver the following outcomes during the pilot period:
  1. [Outcome 1 - measurable, e.g. "Reduce weekly report prep from 3 hours to 30 minutes"]
  2. [Outcome 2]
  3. [Outcome 3]
Specific use cases covered: [Use case 1], [Use case 2].
Anything outside this list is out of scope until year-one conversion.

2. DURATION + DATES
Start date: [YYYY-MM-DD]
End date: [YYYY-MM-DD] (6-8 weeks)
Weekly Friday demo at [time] [timezone]. 15 minutes. Loom or live screenshare.

3. PILOT FEE + DEPOSIT
One-time deposit: $[500-6,000] (10-30% of year-one ACV).
Paid via Stripe before pilot kickoff. Credited dollar-for-dollar toward year-one invoice on conversion.
If Design Partner cancels before week 4: deposit forfeited.
If Company cancels for any reason: 100% refund within 14 days.

4. SUCCESS CRITERIA
The pilot is successful if 2 of 3 criteria are met by [end date]:
  1. [Measurable criterion 1 - e.g. "Report prep time reduced to <=30 min/week, verified in Friday demo"]
  2. [Measurable criterion 2]
  3. [Measurable criterion 3]
If 2+ criteria met: year-one contract auto-converts unless Design Partner opts out in writing within 7 days.
If <2 criteria met: both parties walk. Company retains deposit as paid consideration for pilot work.

5. CONVERSION TERMS
Year-one price: $[amount] / [month or year]
Billing: [monthly / annual]
Conversion: auto-convert at pilot end unless Design Partner opts out in writing.
Post year-one: 30-day written notice to cancel.

6. DATA, IP, TERMINATION
Design Partner keeps their data. Company keeps the product IP.
Either party may exit at 30 days written notice during pilot.
Design Partner's data remains exportable for 90 days after termination.

SIGNED:

_________________________  Date: __________
[Your Name], [Your Company]

_________________________  Date: __________
[Champion Name], [Customer Company]
```

Two annotated worked examples (a $1,500 B2B SaaS pilot and a $5,000 B2B services pilot) plus DocuSign-importable + PDF formats are in [The First-Paying-Customer Operating Kit](/course/tech-for-non-technical-founders-2026/first-paying-customer-operating-kit/) - a free reference for the same template with sector-specific fills.

**The deposit number:** take the monthly price you tested in [Lesson 1.5](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) and multiply by 12 for year-one ACV. A $97/month hypothesis → $1,164 ACV. Your deposit is 10-30% of that, with a **$500 floor** - below $500 it stops working as a commitment device. When 10% of ACV is under $300, charge the first month's revenue upfront instead. The full band table by sector, the $10K procurement ceiling, and the Stripe Checkout flow are in the [full reference](/course/tech-for-non-technical-founders-2026/reference/paid-pilot-full/).

---

> **Do this now:**
>
> 1. Copy the [DPA template above](#dpa-template) into a Google Doc. Fill the 6 bracketed sections.
> 2. Take your [Lesson 1.5](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/) price × 12 for ACV. Set the deposit at 10-30%, never below $500.
> 3. In [Stripe](https://dashboard.stripe.com/login): Products → create "[Product] - Design Partner Pilot" → add a one-time price for the deposit → hit "Payment link". Stripe generates a hosted checkout URL. No webhook, no code.
> 4. Send the DPA + Stripe link to 1-2 warm leads from Lesson 5.5 who booked demos recently.
> 5. **Success check:** one lead replies "send the one-pager" or signs, and your first deposit clears in your Stripe account. That is the first paying customer.

---

**If this fails: the customer says "can we start free and convert later?"**
- **Why:** the deposit scares them, but they're still interested - this is hedging, not a no.
- **Fix:** reframe the deposit as *year-one ACV prepaid*, not added cost. The $500 sits in this month's accounting and gains a CFO check now; free pilots lose that approval in Week 8.

**If this fails: the customer says "we do not do paid pilots."**
- **Why:** they're not in your must-have segment - wrong buyer profile.
- **Fix:** thank them and move to the next warm lead. They're not disqualified, just not your customer yet.

---

Send the DPA to your warmest lead first. Asking someone you know for a refundable deposit is the stall point - but the deposit is a test of whether the problem is real, not of whether you deserve to be paid. The second one is easier.

---

> **Done:** one DPA is signed and the Stripe deposit has cleared in your account.
>
> **You have now:** a signed Design Partner Agreement + a cleared deposit (5.6), sitting alongside your validated problem statement, Product Brief, and live MVP in the `Founder OS` folder. That completes the folder - the artifact investors fund. Converting this pilot into a year-one contract is the next test, 6-8 weeks out.
>
> **Next:** that is the core course complete - from a one-sentence hypothesis to a stranger's money in your account. Keep going with the optional [5.7 · Going Outbound Without a Sales Team](/course/tech-for-non-technical-founders-2026/outbound-without-sales-team/) when your warm list runs dry, or the [Going further chapters](/course/tech-for-non-technical-founders-2026/#going-further-after-first-paying-customer) once your pilot converts. The [First-Paying-Customer Operating Kit](/course/tech-for-non-technical-founders-2026/first-paying-customer-operating-kit/) keeps the build honest through the pilot.
>
> **If blocked:** see "If this fails" above. If you do not have warm demos yet, your work is still in [Lesson 5.3](/course/tech-for-non-technical-founders-2026/first-ten-customers-network-list/) - the DPA is the wrong sprint for an empty pipeline.
>
> **Deeper reference:** [The six DPA clauses in detail, the full pricing bands, the Stripe flow, and the conversation script with objection handling](/course/tech-for-non-technical-founders-2026/reference/paid-pilot-full/)

---

*See it in action: [Module 5 walkthrough: Mia gets paid](/course/tech-for-non-technical-founders-2026/module-5-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
