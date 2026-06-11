---
title: "Module 1 Walkthrough: Mia Builds TutorMatch"
description: "Follow Mia through Module 1 as she writes a Founding Hypothesis, builds a smoke-test page, installs tracking, runs cold traffic, and price-tests  --  all before writing a line of product code."
date: 2026-06-11
draft: true
slug: module-1-walkthrough-mia
---

> **Module 1 walkthrough · Mia** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> *Illustrative composite based on patterns from real founder builds, not a single client story.*

Mia is a former special-ed teacher who watched parents of kids with dyslexia and ADHD burn evenings Googling "tutor near me," calling dead numbers, and settling for whoever answered the phone. Her idea: a marketplace where parents search by specialty and get matched with a vetted tutor in 48 hours.

---

## [Lesson 1.1: Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/)

**Input:** A rough idea and three years of watching parents struggle.

**Challenge:** Mia's first draft of her hypothesis was: "If we help parents find tutors, they will choose us over Google." Every blank was a category, not a noun. She knew it was useless before she finished writing it.

**Action:** She went to r/Dyslexia and r/ADHD and searched "tutor." She found a parent who wrote: *"I've called 11 tutoring centers this month. Five never called back. Three said they don't specialize in dyslexia. Two had waitlists. One told me their 'learning differences' program was a generic curriculum with a different label."* Mia copied that verbatim into her [problem] blank. The [customer] blank became "parents of kids 8-14 with dyslexia/ADHD." The [competition] became "Googling and calling dead numbers."

**Result:** Her final hypothesis read: *"If we help parents of kids 8-14 with dyslexia/ADHD solve finding a vetted specialist tutor with a search-by-specialty marketplace, they will choose it over Googling and calling dead numbers because it matches them in 48 hours with parent reviews."* She scored it: Customer 5/5, Pragmatic 4/5, Growth 3/5, Money 3/5. Total: 15/20. Weakest blank: Growth  --  she doesn't know if parents search by specialty or by location.

---

## [Lesson 1.2a: Build the Page](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/)

**Input:** A one-sentence Founding Hypothesis with Growth as the weakest blank.

**Challenge:** Mixo's first draft gave her a headline that read "Smart Tutoring Solutions for Modern Families." A parent scrolling Instagram at 10pm would not recognize themselves in that sentence. She regenerated twice.

**Action:** She pasted her hypothesis into ChatGPT: *"Turn this hypothesis into 3 outcome-focused value props, max 6 words each."* The output: "Specialist tutor in 48 hours," "No more dead phone numbers," "Parent-reviewed, not algorithm-matched." She replaced the hero image with a photo of a parent on the phone at 9pm  --  the exact pain her hypothesis named. She stripped Pricing, FAQ, and Testimonials blocks that Mixo added. CTA: "Get matched with a specialist."

**Result:** She sent the URL to her neighbor, who has a son with ADHD. "In three seconds, who is this for and what does it do?" The neighbor said: "Parents of dyslexic kids  --  you find them tutors fast." Three seconds. Clarity test passed.

---

## [Lesson 1.2b: Wire Tracking](/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/)

**Input:** A live landing page at `tutormatch.mixo.io`.

**Challenge:** Mia is B2C. The concept block said B2C → Meta Pixel. She had never created a Meta Business account and was intimidated by "pixel" and "head-tag."

**Action:** She followed the compact install box: signed up at clarity.microsoft.com, copied the snippet, pasted it into Mixo's Custom Code → Header field. Then business.facebook.com → Events Manager → create pixel → copy snippet → paste in the same head-tag field. She picked Meta Pixel because her hypothesis named a B2C customer. She also installed GA4 for the analytics dashboard. Ten minutes total.

**Result:** She opened her page in an incognito window. Within 60 seconds, Clarity showed her own session recording. Her Meta Pixel dashboard showed "Active." GA4 Real-Time showed one active user. Done.

---

## [Lesson 1.2c: Run the Smoke Test](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/)

**Input:** A live page with Meta Pixel + GA4 + Clarity installed.

**Challenge:** Her Growth lens scored 3/5. She doesn't know whether parents search by "dyslexia tutor" (specialty) or "tutor near me" (location). Her Meta ad creative would test both  --  but which to lead with? She also had $400 total to spend and was nervous about burning it with no signal.

**Action:** She picked Meta Ads (B2C consumer, $0.90 CPC target). She ran two ad variants with the same budget split: one targeting "dyslexia tutor" search interest, one targeting "ADHD tutor + [city]" geography. She launched on a Monday and did not touch the page for seven days. No headline rewrites. No bid adjustments.

**Result:**
- Ad 1 (specialty search): 6.5% conversion. **Strong.**
- Ad 2 (location search): 3.5% conversion. **Iterate band.**
- Combined: 4.8% across all 300 visits. Specialty outperformed location by nearly 2x.

Her weakest Growth blank was partially answered: parents search by specialty, not by location. She decided to advance  --  4.8% is below the 6% threshold but the specialty variant alone cleared it. Her decision: advance to Module 2 interviews, but keep the location variant as a test for later.

---

## [Lesson 1.3: Price Hypothesis](/course/tech-for-non-technical-founders-2026/price-hypothesis-on-smoke-test-page/)

**Input:** A live page with 300 cold visits and a 4.8% combined conversion rate (6.5% on the winning variant).

**Challenge:** Mia had no idea what parents pay for tutoring. Her Money lens scored 3/5 because she guessed $25/session based on what her old school charged for after-school programs  --  not what parents actually paid private tutors.

**Action:** She set up a Stripe account on Friday night, uploaded her ID, and was approved by Tuesday. She created a Payment Link at "$99 founding member  --  4 months access at $25/mo equivalent" (one-time, per the lesson's one-time advice). Button copy: "Find your kid's specialist  --  $99 founding member rate." She added a "Full refund within 30 days if we don't ship" line in the footer. Below the button: "Not ready? Join the free waitlist instead."

**Result:** 6% of visitors clicked the Stripe link, 6 completed payments at $99 each  --  a strong price signal for a pre-product page. Her Money lens was wrong  --  parents pay more than $25. She notes this for Module 2 interviews: ask parents what they currently spend on tutoring, not what they'd pay for a marketplace.

---

## What Mia Walked Away With at the End of Module 1

- **Founding Hypothesis:** One sentence, five specific blanks, scored 15/20. Weakest blank: Growth (specialty vs. location).
- **Live landing page:** `tutormatch.mixo.io` with a headline that passed the 3-second clarity test.
- **Tracking:** Meta Pixel + GA4 + Clarity installed, all verified.
- **Conversion data:** 4.8% combined (6.5% on specialty variant). Growth blank partially answered: parents search by specialty.
- **Price signal:** 6 completed Stripe payments at $99. Parents will pay more than $25.
- **Founder OS folder:** All five lesson outputs saved in one Google Drive folder.

**Next: Module 2, where Mia interviews 10 parents using the Mom Test.** Her interview script will test whether parents have ever spent real money on a specialist tutor search  --  the [problem] blank  --  and what they currently pay, to tighten her Money lens.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
