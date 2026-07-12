---
title: "FAQ - From Idea to First Paying Customer"
aliases: ["/blog/faq-tech-for-non-technical-founders/"]
description: "Common blockers and questions from founders working through the course. Stuck? Start here before you ask for help."
date: 2026-06-07
draft: false
course_chapter: false
author: "JetThoughts Team"
slug: faq
keywords:
  - tech for non technical founders faq
  - founder course help
  - stuck founder course
  - startup validation questions
tags:
  - founders
  - non-technical-founder
  - course-faq
categories: ["Founders"]
metatags:
  image: cover.png
  og_title: "FAQ - From Idea to First Paying Customer"
  og_description: "Common blockers and questions from founders working through the course. Stuck? Start here."
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/faq/"
related_posts: false
---

> **FAQ** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)

If you're stuck, start here. These are the questions founders ask most often - read the 2-3 that match your situation and get back to the build. If your question isn't here, try the course's [Quickstart path](/course/tech-for-non-technical-founders-2026/quickstart/) or the [How This Course Works](/course/tech-for-non-technical-founders-2026/how-this-course-works/) overview.

![Module map for this FAQ: a General group followed by Module 1 Hypothesis and smoke test, Module 2 Validate the problem, Module 3 Design from evidence, Module 4 Build it yourself, and Module 5 First paying customer - questions below are grouped in this order.](module-strip.svg)

---

## Module 1 - Hypothesis & Smoke Test

**Q: My hypothesis sentence still sounds vague after 3 drafts. What now?**

Write it at the specificity level of "solo chiropractors in Pennsylvania who spend 30 minutes re-entering insurance claim codes from a PDF every Tuesday." Not "healthcare professionals who want to save time." If you can't name the industry, the company size, and the specific 30-minute moment, you're not there yet. Go back to [Ch 1.1](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) and fill each blank with a real person in mind.

**Q: My landing page got zero signups from 300 visitors. Is the idea dead?**

Maybe. Under 3% conversion on cold traffic is the kill-or-pivot band in [Lesson 1.4's decision table](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) - and zero is well under it. But first: check your tracking. Did you install Microsoft Clarity? Watch 10 session replays. Common failure modes: the form is broken, the page takes 5+ seconds to load on mobile, or your headline is too vague. Fix those and re-run before you kill the idea. The [smoke test chapter](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/) walks the four copy blocks that decide whether the page converts.

**Q: My Stripe account verification is taking 3+ days. Can I skip the price button?**

Don't skip - sign up for Stripe tonight and let it verify in the background while you build the landing page. Verification takes 1-3 business days. If you wait until launch day to create the account, you block on a wait you could have run in parallel. If it's already been 3+ days, check your email for a Stripe support message asking for business documents.

**Q: Which landing page builder should I use?**

Mixo (~60 seconds from idea to page). If the templates don't fit, Carrd (no-code drag-drop). Don't comparison-shop for a week - you're testing demand, not builders. [Ch 1.2](/course/tech-for-non-technical-founders-2026/smoke-test-build-page/) has the workflow for both.

---

## Module 2 - Validate the Problem

**Q: I can't find anyone to interview. I've searched everywhere.**

Two fixes: (1) Your hypothesis is too vague - "small business owners" is not a searchable ICP (Ideal Customer Profile - the specific kind of person your hypothesis names). Tighten to "12-person law-firm office manager." (2) Search second-degree keywords: "boarding costs" instead of "pet sitter." The [Ch 2.3 chapter](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/) has the AI prompt that generates 8 communities + 5 search strings from your hypothesis.

**Q: Everyone I interview says "sounds great" but nobody gives me real data.**

Your questions are probably hypothetical-shaped. "Would you use a tool like this?" generates polite yeses from anyone. Switch to past-tense: "When was the last time you dealt with [problem]? Walk me through what happened." The [Mom Test chapter](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) has the 5-question template that fixes this.

**Q: Should I skip the AI persona rehearsal (Ch 2.2)?**

If you've run customer interviews before and your questions reliably produce concrete past-tense answers, skip it - go straight to [Ch 2.3](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/). If this is your first time running Mom Test interviews, the 90-minute rehearsal catches broken question shapes before they waste real interview slots.

**Q: Fewer than 7 of my 10 interviewees have actually spent time or money on the problem. What does that mean?**

Pivot or kill, depending on the count. The [Ch 2.5 gate](/course/tech-for-non-technical-founders-2026/mom-test-synthesis-build-pivot-kill/) reads: 7 or more of 10 interviewees with real past spend = build, 4-6 = pivot, under 4 = kill. Before you pivot, check: are you interviewing the right ICP? If you interviewed 10 chiropractors and the problem isn't real for them, but 3 mentioned a related problem they DO care about, build a new hypothesis around that problem and re-validate.

---

## Module 3 - Design from Evidence

**Q: My Product Brief keeps growing beyond one page. How do I cut it?**

If a feature in Section 3 doesn't trace back to a verbatim quote from a Module 2 interview, cut it. If you can't name which interviewee said they needed it, it's your feature, not theirs. The [Ch 3.2 chapter](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/) has the quality-gate that catches scope creep before you open Lovable.

**Q: Claude keeps naming features that aren't on my no-go list. My brief keeps failing.**

Your Section 3 is too vague. Rewrite every feature as a "When / I want / So I can" job story. "CSV export" becomes "When I prepare the weekly investor report, I want to grab the top 5 metrics in 30 seconds, so I can paste them into the deck before the 4pm call." The engineer has nothing left to invent.

---

## Module 4 - Build It Yourself

**Q: I don't know whether to hire or build myself.**

Run the [Ch 4.1 decision tree](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/). The default answer for a first-time solo founder with a validated brief: build it yourself with Lovable + Supabase + Stripe. Hiring triggers when you hit a [Ch 4.5 ceiling signal](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/) - not before.

**Q: The 12 rules checklist is overwhelming. Where do I even start?**

Only 3 rules need to be true before you open Lovable: (1) your one-page brief passed the Ch 3.2 quality-gate, (2) you scoped one workflow for one persona, (3) GitHub sync is on in Lovable Settings. The other 9 rules fire inline during the build. Read the [Ch 4.3 chapter](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) for the full list.

**Q: Lovable generated a sprawling admin panel from my one-page brief.**

Your brief's Section 3 is feature-shaped. Go back to [Ch 3.2](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/) and rewrite every feature as a "When / I want / So I can" outcome before you re-prompt Lovable. Then use the AI critic block in [Ch 4.3](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) to audit your build against your brief.

---

## Module 5 - First Paying Customer

**Q: I'm terrified of asking for money. How do I start?**

The deposit is a test of whether the problem is real - not a test of whether you deserve to be paid. Send the [DPA template](/course/tech-for-non-technical-founders-2026/paid-pilot-charge-before-ship/#dpa-template) to your warmest lead first. A refundable deposit at kickoff is easier to ask for than a full-price sale. The [Ch 5.6 chapter](/course/tech-for-non-technical-founders-2026/paid-pilot-charge-before-ship/) has the exact contract template.

**Q: My personal network only has 5 names. What do I do?**

Five is enough to start. Message all five before you try cold outbound - people who already know you reply and close at many times the rate of cold strangers, which is why [Ch 5.3](/course/tech-for-non-technical-founders-2026/first-ten-customers-network-list/) runs the warm list first. If your network truly has zero applicable names, skip to [Ch 5.7 cold outbound](/course/tech-for-non-technical-founders-2026/outbound-without-sales-team/).

**Q: The customer wants to start free and convert later. Should I accept?**

No. A verbal yes is not a paid pilot. Reframe: the deposit is credited toward year-one ACV (annual contract value - what one customer pays in year one), not added cost. If they still say no, their problem isn't acute enough - they're not in your must-have segment. Move to the next lead.

---

## General

**Q: How long does Module 1 take?**

Two to three weeks at an evenings-and-weekends pace (the pattern this course is built for). A full-time founder can finish Module 1 in about a week. The calendar is mostly wait time - ad-account approval, the 7-day traffic run, Stripe verification - not work time. The [Quickstart](/course/tech-for-non-technical-founders-2026/quickstart/) is the shortest path - core lessons only.

**Q: How long does the full 5-module course take?**

A full-time founder: 6-10 weeks - the per-module estimates overlap, because outreach and interviews run while you wait on ads, Stripe, and the build. An evenings-and-weekends founder (2-4 hrs/week): 10-16 weeks.

**Q: Do I need to do the modules in order?**

Yes. Each module's output is the next module's input. The hypothesis you write in Module 1 feeds the landing page. The interviews you run in Module 2 feed the Product Brief. The brief you write in Module 3 feeds the Lovable build. Skip a module and the input to the next one is missing.

**Q: I already have a half-built MVP. Where do I start?**

If you validated the problem (10+ customer interviews), start at [Module 3 - Design from Evidence](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/). If you never validated, start at [Module 1](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/). The half-built MVP might be solving a problem nobody has - better to find out now than after launch.

---

**Back to the course:** [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) - or jump back into the module you came from. Ready to start? [Chapter 1.1 · Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/).

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
