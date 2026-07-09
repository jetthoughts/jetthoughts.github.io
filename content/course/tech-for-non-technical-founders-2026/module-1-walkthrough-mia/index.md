---
title: "Module 1 Walkthrough: Mia Builds TutorMatch"
description: "Follow Mia through Module 1 as she writes a Founding Hypothesis, builds a smoke-test page, installs tracking, runs cold traffic, and price-tests - all before writing a line of product code."
date: 2026-06-11
draft: false
slug: module-1-walkthrough-mia
---

> **Module 1 walkthrough · Mia** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> *Illustrative composite based on patterns from real founder builds, not a single client story.*

For twelve years, Mia taught reading to kids who couldn't sound out words the way other kids did. Dyslexia, ADHD, processing differences - she knew the diagnoses by name and the parents by their tired faces at pickup. She also knew what those parents did when they needed help outside school hours: they Googled "tutor near me," called the first six numbers they found, and prayed someone would call back. Most never did. The ones who did rarely specialized in what their kid actually needed.

She'd been turning the same idea over for months. A marketplace where parents could search by specialty - dyslexia, ADHD, executive function - and get matched with a vetted tutor in 48 hours. No more phone tag. No more "learning differences" labels slapped on generic curricula.

Tonight she was going to find out if anyone else cared.

---

## [Lesson 1.1: Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/)

The lesson asked for one sentence with five specific blanks. Mia opened a blank doc and typed: *"If we help parents find tutors, they will choose us over Google."*

She stared at the sentence for a minute. "Parents" - which parents? "Tutors" - any tutor? "Google" - the search engine, the verb, the cultural shorthand? Every blank was a placeholder for a category, broad enough that anyone reading it could nod along without ever taking a position. The lesson was right about that: you can't test a category.

She closed the doc and opened Reddit. r/Dyslexia. She searched "tutor." The third thread she opened was from a mother in Vermont who'd posted three weeks earlier:

> *"I've called 11 tutoring centers this month. Five never called back. Three said they don't specialize in dyslexia. Two had waitlists. One told me their 'learning differences' program was a generic curriculum with a different label."*

Mia copied the post into her notes. The blanks she'd left empty an hour earlier suddenly had specific names. The [customer] wasn't "parents" - it was parents of kids 8-14 with dyslexia or ADHD. The [problem] wasn't "finding tutors" - it was *finding a vetted specialist tutor*. The [competition] wasn't Google the company - it was the exact behavior the Vermont mother had described: Googling and calling dead numbers. By midnight her hypothesis read:

> *"If we help parents of kids 8-14 with dyslexia/ADHD solve finding a vetted specialist tutor with a search-by-specialty marketplace, they will choose it over Googling and calling dead numbers because it matches them in 48 hours with parent reviews."*

She scored it against the four lenses. Customer: 5/5. Pragmatic: 4/5. Growth: 3/5. Money: 3/5. Total: fifteen out of twenty - over the passing bar of fourteen, but with a clear soft spot. She didn't actually know whether parents searched by specialty ("dyslexia tutor") or by location ("tutor near me"). The smoke test would have to tell her.

---

## [Lesson 1.2: Build the Page](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/)

Wednesday morning, she opened Mixo on her phone and pasted her hypothesis into the prompt box. By 7:15 she had a landing page. By 7:17 she hated it.

The headline read *Smart Tutoring Solutions for Modern Families*. She tried to picture the Vermont mother seeing that at 10pm while scrolling Instagram. The Vermont mother wouldn't recognize herself in a single word of it.

Two regenerations later, the headlines were still glossy nonsense. So she gave up on Mixo's copy generator and asked ChatGPT instead, in plain English: "Turn this hypothesis into parent-voice headlines." What ChatGPT came back with sounded like things the Vermont mother might actually say out loud - *Specialist tutor in 48 hours. No more dead phone numbers. Parent-reviewed, not algorithm-matched.* Those she pasted in.

The stock hero image showed three smiling teenagers grouped around a laptop. She swapped it for a photo of a parent on the phone at 9pm, lit by a single desk lamp - the moment her landing page needed to land in, not the moment after. She stripped the Pricing, FAQ, and Testimonials blocks Mixo had added automatically. None of them belonged on a smoke test. The CTA button became *Get matched with a specialist*.

She sent the URL to her neighbor across the hall, whose son had been diagnosed with ADHD that spring. "Three seconds," she said. "Tell me who it's for and what it does."

The neighbor read. "Parents of kids with dyslexia or ADHD. You find them specialist tutors fast."

Three seconds. The page passed.

Now she needed to know who would actually visit it.

---

## [Lesson 1.3: Wire Tracking](/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/)

Mia had never pasted code into anything. The word "snippet" sounded like something that would break if she held it wrong. But the lesson promised Clarity and GA4 would tell her exactly who was visiting the page she'd just built - before she spent a single dollar on traffic. Both free. Both five-minute installs, if you knew which field to use.

She didn't.

The Clarity snippet went in. Refresh, incognito check. Dashboard: *No data yet*. Five minutes. Still nothing. She went back to the lesson and re-read the part she'd skimmed: the snippet has to go in the head-tag field, not the body field. Mixo had both. She'd picked the wrong one.

She moved the snippet up one slot. Refreshed Clarity. There it was - a fresh session recording, twelve seconds long, of herself.

GA4 was the same dance, faster the second time. Real-time report showed one active user. Both tools verified.

Meta Pixel could wait. She'd install that in 1.4, after she picked her ad channel.

Twenty-five minutes total. Twenty of those on the wrong-field detour.

---

## [Lesson 1.4: Run the Smoke Test](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/)

She had $400 to spend, a Growth lens that scored only 3/5, and a quiet knot in her stomach about it. The lens was weak because she didn't know which way parents searched: by specialty (*dyslexia tutor*) or by location (*ADHD tutor near me*). The smoke test could answer one of those questions properly - not both.

She installed the Meta Pixel she'd deferred from 1.3. Same dance as Clarity and GA4, two minutes this time - the wrong-field detour had taught her where to click.

Then the ads. Her first instinct was to split the budget - $200 on "dyslexia tutor" search interest, $200 on "ADHD tutor near me" in her city, and let the two angles fight it out. The channel guide's sample-size warning killed that plan: $200 buys roughly 150 visits, and below 300 visits a conversion rate can't tell 2% from 5%. Two half-tests would have bought her two unreadable numbers. She put the full $400 behind one angle - the specialty search, because that was the bet her hypothesis actually named: parents searching by their kid's need, not by zip code. The location question went into her notebook, not her ad account. She hit Launch on a Monday morning.

Then she made a rule for herself: don't touch the page for seven days. No headline tweaks. No bid adjustments. No anxious dashboard refreshes. The point of a smoke test was a clean signal, and a clean signal needed clean traffic.

On Day 8 she opened the results: 300 cold visitors, 6.5% conversion. **Promising band** - past the 6% proceed bar, one readable number, no asterisk.

Half of her weakest blank had just answered itself. Parents searching by specialty recognized the page and signed up. Whether the location angle would have worked too was a question she hadn't paid to answer - so she wrote it into her Module 2 prep instead: ask every parent how they actually searched the last time they needed a tutor. She advanced to the price test.

---

## [Lesson 1.5: Price Hypothesis](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/)

Mia had no idea what parents actually paid for tutoring. Her Money lens scored 3/5 because her gut number ($25 a session) came from what her old school had charged for after-school programs - which she now suspected was nowhere near what parents paid private tutors out of their own pockets.

She set up a Stripe account on Friday night and uploaded her ID. By Tuesday morning she was approved. Wednesday she built her Payment Link: a one-time *$99 founding member rate, four months of access at $25/mo equivalent*. The button on her landing page changed to *Find your kid's specialist - $99 founding member rate*. Underneath in smaller type: *Full refund within 30 days if we don't ship.* And below that, an escape hatch for the curious-but-not-ready: *Not ready? Join the waitlist instead.*

She let the same ads keep running and went back to her day job.

Over the next week, 6% of visitors clicked the Stripe link. Six of them completed the $99 payment. Six paying customers before her product existed - a price signal stronger than she'd dared hope for a pre-product page. Her Money lens had been low. Parents would pay well above $25.

She added a note to her Module 2 prep: when she interviewed parents, she'd ask what they currently spent on tutoring. Real numbers from real receipts, not projections.

---

## What Mia Walked Away With at the End of Module 1

- **A Founding Hypothesis** scoring 15/20, with one soft blank (Growth) flagged and tested.
- **A live landing page** at `tutormatch.mixo.io` that passed the 3-second clarity test on a neighbor who actually fit the ICP.
- **Tracking installed and verified** - Clarity for behavior, GA4 for traffic source, Meta Pixel for ad attribution.
- **Conversion data on 300 cold visitors:** 6.5% from specialty-search targeting - the Promising band. The specialty half of the Growth question answered; the location angle queued for Module 2 interviews.
- **Six paying customers at $99 each.** $594 in revenue, before the product existed.
- **A Google Drive folder** holding all five Module 1 outputs. Her Founder OS, started.

**Next: Module 2, where Mia interviews ten parents using the Mom Test.** Her interview script will ask whether parents have ever spent real money on a specialist tutor search (the [problem] blank in her hypothesis), and what they currently pay - so she can replace her Money lens guess with actual numbers from actual receipts.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
