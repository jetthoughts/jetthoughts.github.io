---
title: "Build Path Decision Worksheet"
aliases: ["/blog/build-path-decision-worksheet/"]
description: "5 questions that route a non-technical founder to one of 4 build paths. 30-minute decision, defensible to investors."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: build-path-decision-worksheet
keywords:
  - build path decision worksheet
  - founder build vs hire worksheet
  - validate without code template
  - founder build path 4 quadrant
  - should I hire engineer worksheet
tags:
  - founders
  - non-technical-founder
  - template
  - course-companion
  - decision-framework
categories: ["Templates"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/build-path-decision-worksheet/"
related_posts: false
---

📋 Template companion to the [Module 4 post](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/). Run after your [one-page brief](/course/tech-for-non-technical-founders-2026/vibe-prd-template/) is signed. Print, fill in 30 minutes, write your chosen path at the top of your Notion doc.

# Build Path Decision Worksheet - 5 Questions, 4 Paths

*Print one side of paper. Pen. 30 minutes alone. Walk out with a defensible build decision and the next module to read.*

## Why this exists

A wellness-coaching founder who came to us in early 2026 had spent four months building a Lovable MVP, then panicked and signed a $24K-per-month agency contract because three advisors told her "you need a real team now." Two of the advisors had never seen her validation data. The third had not asked.

She showed us the contract on a Tuesday. By Friday we had walked her through the same 5 questions on this worksheet and the matrix said Path 3 (Fractional CTO at $2,400/mo, 8 hours/week), not Path 4 (the agency at $24K/mo). She paid the agency a kill fee and saved 14 months of runway. The decision was already in the data she had. The advisors had not run the worksheet. Cheaper to spend 30 minutes with this page than to spend a quarter undoing a contract somebody else's instinct signed for you.

## How to use this

Friday afternoon, alone, 30 minutes, before coffee runs out. Bring three documents: your filled-in [Validated Problem Statement](/course/tech-for-non-technical-founders-2026/validated-problem-statement-template/) from Chapter 2.5, your filled-in [one-page brief](/course/tech-for-non-technical-founders-2026/vibe-prd-template/) from Chapter 3.1, and a current bank statement showing months of runway. Pen on paper. Phone in another room.

Answer the five questions in order. Each one is factual, not aspirational. "Number of Mom Test interviews" is a count on your call log, not a vibe. "Months of runway" is cash on hand divided by monthly burn, not a guess. The matrix at the bottom routes you to Path 1, 2, 3, or 4 based on the five answers.

If you spill past 30 minutes, you are negotiating with yourself. Stop, write the verdict the data supports, take it to one peer or advisor for a 20-minute call, and move on.

Total time budget: 30 minutes alone, 20 minutes with one peer, 0 minutes second-guessing. Tomorrow you start the path the worksheet picked.

## The 5 questions - check the box that matches

```
=========== BUILD PATH DECISION WORKSHEET ===========

Founder: _________________  Date: ____________________

one-page brief finalized on: ____________________

Months of runway in the bank: ________________________
```

### Q1: Is the problem validated?

```
------------------------------------------------------
Q1. Is the problem validated?
------------------------------------------------------

Counts as YES only if all 4 below are true:
 [ ] 10 or more Mom Test interviews complete
 [ ] Strong past-behavior signal in at least 7 of 10
 [ ] Smoke test cleared the 6%+ "Promising" band -
     the share of visitors who clicked your fake
     "Buy" button on the test page (from Module 1)
 [ ] Prototype test: 4 of 5 people reached the right
     screen without you coaching them (from Module 2)

LinkedIn likes do not count. "They said they would
buy" does not count. What people DID counts - the
clicks on the smoke test and the prototype run, not
what they said they would do. Pre-orders and paid
pilots come later (Module 5); you do not need them
to answer YES here.

VERDICT: [ ] Yes    [ ] No

If NO -> stop here. Path 1 (Validate without code).
        Run the Airbnb test this week.

If YES -> go to Q2.
```

### Q2: How backend-heavy is the build?

```
------------------------------------------------------
Q2. How backend-heavy is the build?
------------------------------------------------------

Check every TRUE row:
 [ ] Live updates that appear on screen without
     anyone refreshing the page (like watching
     someone type in Google Docs or Slack)
 [ ] Heavy jobs that run in the background and keep
     retrying if they fail (mass emails, big uploads)
 [ ] An AI model runs every time someone uses the
     feature, and each run costs real money (more
     than a cent per use)
 [ ] Many separate companies use the same app and
     none can ever see another company's data
 [ ] The app connects to 5 or more outside services
     (payments, email, maps, calendars, and so on)
 [ ] Regulated data - health records (HIPAA), stored
     credit-card numbers (PCI), or enterprise
     security audits (SOC 2)

VERDICT:
 [ ] 0-1 boxes checked   = LIGHT backend
 [ ] 2-3 boxes checked   = MID backend
 [ ] 4 or more checked   = HEAVY backend

If HEAVY -> Path 4 (Hire a team - see [hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/)).
            Read the SOW guide before kickoff.

If LIGHT or MID -> go to Q3.
```

### Q3: What is your runway?

```
------------------------------------------------------
Q3. What is your runway?
------------------------------------------------------

Months of cash until you must show paying customers:

 [ ] Less than 4 months
 [ ] 4 to 12 months
 [ ] 12 or more months

If LESS THAN 4 -> Path 1 (Validate without code),
                  regardless of how validated you
                  feel. The Airbnb test is the only
                  experiment that fits in the window.

If 4 TO 12 -> Paths 2, 3 are on the table. Go to Q4.

If 12+ -> Paths 2, 3, 4 are on the table. Go to Q4.
```

### Q4: What is your monthly engineering budget?

```
------------------------------------------------------
Q4. What is your monthly engineering budget?
------------------------------------------------------

Money you can commit for at least 6 months:

 [ ] $0 to $400/wk of your own time
 [ ] $1,600 to $4,000/mo (Fractional CTO band)
 [ ] $5,000 to $30,000/mo (small team band)
 [ ] $30,000+ /mo (multi-person team band)

If $0-$400 -> Path 2 (Self-serve / Ch 4.3 then 4.4).
              Paste one-page brief into Lovable.

If $1.6K-$4K -> go to Q5.

If $5K-$30K -> Path 3 (Fractional CTO) until problem
               complexity demands more.

If $30K+ -> Path 4 (Hire a team - see [hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/)).
```

### Q5: Senior engineer in your network for 1 hour of architecture review per month?

```
------------------------------------------------------
Q5. Senior engineer in your network for 1 hour
    of architecture review per month?
------------------------------------------------------

A real human you can text. Returns calls within 48 hrs.
Has shipped a backend at scale in the last 5 years.

 [ ] Yes, named: ___________________________________
 [ ] No

If YES -> Path 2 (Self-serve / Ch 4.3 then 4.4).
          Use them for the monthly architecture call
          + worst-route code review.

If NO -> Path 3 (Fractional CTO bridge - see the
         hire-track supplementary reference).
         Buy the same insurance commercially.

======================================================
THE 4-PATH VERDICT (write your row at the top of
your Notion doc)
======================================================
```

## The 4-path verdict table

| Path | Choose when | First action this week | Cost |
|---|---|---|---|
| **1. Validate without code** | Q1 = No, OR Q3 = less than 4 months | Ship Carrd page + Stripe checkout + Notion FAQ. Send to your 30-name outreach list. | $0 - $300 in tools + optional $100-200 in paid ads |
| **2. Self-serve build** ([Ch 4.3](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) then [4.4](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/)) | Q1 yes, Q2 light, Q4 = $0-$400/wk, Q5 = senior eng in network | Paste one-page brief into Lovable. Hook Supabase + Stripe + Resend. | $200 - $1,200 / month |
| **3. Fractional CTO bridge** ([hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/#the-fractional-cto-bridge)) | Q1 yes, Q2 mid, Q4 = $1.6K-$4K/mo OR Q5 = no senior eng | Hire 5-10 hrs/wk Fractional CTO. Use for architecture, PR review, hiring, cost watch. | $1,600 - $4,000 / month |
| **4. Hire a team** ([hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/)) | Q1 yes, Q2 heavy, Q4 = $5K+/mo | Read draft SOW clause-by-clause. Confirm GitHub/AWS/domain ownership before kickoff. | $30K - $80K / month |

**Failure mode to watch for each path** ->
- Path 1 -> 0 of 35 click. Pivot the pitch or the problem.
- Path 2 -> Hits architectural ceiling at ~5K users. Route to the [hire-track reference](/course/tech-for-non-technical-founders-2026/hire-track-supplementary-reference/) for the next layer.
- Path 3 -> CTO drifts into coder. 90-day review on hour allocation.
- Path 4 -> Spaceship for the wrong moon. Friday demo + Org Chart audit catch it in week 3.

## What good looks like vs what bad looks like

**Q1 - Problem validated**

> Bad: *"I posted on LinkedIn and got 47 likes and 12 comments. People love the idea."*

> Good: *"I ran 12 Mom Test calls (May 2026 sample). 9 of 12 described the exact problem in past-tense with a number attached (hours per week, dollars per month). My smoke-test page converted 8% of visitors on the fake 'Buy' button, above the 6% 'Promising' bar. 4 of 5 prototype testers reached the sign-up screen without me coaching them."*

The good answer is countable: 12 calls, 9 strong signals, an 8% smoke-test click rate, 4 of 5 testers through the prototype. The bad answer is a vibe metric (likes) and a hypothetical (love the idea). Likes are not behavior. The matrix routes the bad answer to Path 1 regardless of how confident the founder feels, because the data is not there.

**Q4 - Monthly engineering budget**

> Bad: *"We have $400K in the bank and we will spend whatever it takes to ship."*

> Good: *"$420K in the bank. Burn is $28K/month (founder salary + tools + ads). 15 months of runway. I can commit $4K/month to engineering for the next 6 months without dipping into the marketing budget I need to test the channel."*

The good answer ties budget to runway and to the marketing test that proves the channel. Bad answer commits the bank without a denominator. The matrix routes the bad answer to Path 4 (hire a team) on the founder's confidence, which is the path that runs them out of money. The good answer routes to Path 3 (Fractional CTO at $4K/mo) which fits inside 15 months of runway with the marketing budget intact.

**Q5 - Senior engineer in your network**

> Bad: *"Yes, my college roommate is a software engineer at Google."*

> Good: *"Yes - Maya Chen, ex-Stripe payments backend, currently fractional. Returns texts within a few hours. She agreed to a 1-hour architecture call on the first Monday of every month at $300/hr. First call booked for Sept 7."*

The good answer names the person, the relevant experience (Stripe payments backend, not Google ads), the cadence (first Monday), the price ($300/hr), and the next call (Sept 7). Bad answer names a person without the cadence or the agreement. "My roommate is an engineer" is not a check-in. The matrix counts only the named, scheduled, paid arrangement.

## What to do after

- **Write your verdict at the top of a fresh Notion doc.** One line: *"Path X (name). Started: [date]. Next: [Ch 4.3 self-serve / hire-track reference / back to Module 2 to re-validate]."* Pin the doc. Re-read the line every Monday for 4 weeks.
- **Share the worksheet result with one peer or advisor in a 20-minute call.** Not three. One. Ask them: *"If the matrix said Path X, what would change your mind?"* Their first answer is the assumption you should pressure-test next. If they cannot name one, the matrix verdict holds.
- **Schedule the first action for tomorrow morning.** Path 1: ship the Carrd page. Path 2: paste one-page brief into Lovable. Path 3: 3 LinkedIn outreach messages to Fractional CTOs in your industry. Path 4: read the SOW clause-by-clause with a printed pen, not in Google Docs. Calendar the action with a hard start time. The worksheet routes the decision; the calendar invite routes the work.

Skip this worksheet and route on advisor instinct and you're the founder who, six weeks later, signs a contract the data did not support and posts a [salvage or rebuild question](/course/tech-for-non-technical-founders-2026/salvage-vs-rebuild-decision-tree/) when the build runs over budget. The matrix is cheaper than the contract it prevents.

If you want the doctrine in long form, the [Module 4 post](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/) walks through the Airbnb test, the Rob Walling shed-vs-skyscraper warning, and the worked example for each of the four paths.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
