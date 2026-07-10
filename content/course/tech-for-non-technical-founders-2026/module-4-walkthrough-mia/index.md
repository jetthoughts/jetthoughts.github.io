---
title: "Module 4 Walkthrough: Mia Ships TutorMatch"
description: "Follow Mia through Module 4 as she routes herself to the self-serve path, locks ownership before building, and walks the four build phases from her one-page brief to a live MVP with real parents on it."
date: 2026-07-10
draft: false
slug: module-4-walkthrough-mia
---

> **Module 4 walkthrough · Mia** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> *Illustrative composite based on patterns from real founder builds, not a single client story. Mia's earlier runs are in the [Module 1](/course/tech-for-non-technical-founders-2026/module-1-walkthrough-mia/), [Module 2](/course/tech-for-non-technical-founders-2026/module-2-walkthrough-mia/), and [Module 3](/course/tech-for-non-technical-founders-2026/module-3-walkthrough-mia/) walkthroughs.*

Mia arrived at Module 4 with a quality-checked one-page brief and a strong opinion she hadn't examined: that a "real" marketplace needed a real engineering team. Module 4 exists to test opinions like that against a worksheet.

---

## [Lesson 4.1: Should You Hire?](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/)

The five questions took her twenty minutes. Q1, validation: ten interviews with eight strong signals, plus six founding members who had already paid $99 - yes, with receipts. Q2, backend weight: her v1 had no real-time anything, no background queues, no regulated data - a curated list, parent accounts, and one request button. Light. Q3 said runway was not forcing her hand. Q4 was the one she had to think about - a senior engineer for one architecture hour a month - until she remembered a former colleague who had offered exactly that over coffee. Q4 = yes, and the worksheet routed her to Path 2 - self-serve.

The opinion didn't survive contact with her own answers. The agency quotes she had been collecting went into a folder named "later."

---

## [Lesson 4.2: Who Owns What](/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/)

The ownership audit was twenty minutes of green checkmarks - solo self-serve founders mostly pass by default, since every account gets created in their own name - with one exception. Her domain still lived inside the smoke-test site builder from Module 1, on a plan she could stop paying for at any moment. She transferred it to a registrar account in her own name the same evening and pointed it nowhere yet. The checklist's line stuck with her: the day you need the domain is the wrong day to discover who owns it.

---

## [Lessons 4.3 and 4.4: The Build](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/)

Setup first: Lovable, Supabase, Stripe, all on her accounts, pre-flight rules read twice. Then she pasted Section 3 of her brief - the outcome-shaped one, with the hand-curated shortlist line - into Lovable, exactly as written in Module 3.

The [four phases](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/) took her nine build evenings spread across ten calendar weeks - the part-time pace Chapter 4.4 tells you to plan for. The UI phase went fastest because the prototype had already settled the layout arguments: search by the kid's need, profiles with reviews, credentials, response time, and the session rate the fifth test parent had gone looking for. Auth was parent accounts with the same magic-link sign-in her brief specified. Stripe was the founding-member checkout she had been running manually since Module 1, now wired into the product. The deploy phase ended with her domain - the one she now owned - pointing at a live TutorMatch.

The scare came from the AI audit prompt in the build rules. She pasted her Supabase table definitions and row-level security policy into Claude and asked whether a logged-in parent could read another parent's rows. The answer was yes - the policy she had accepted from a Lovable default checked that a user was signed in, not which user they were. One corrected policy later, the check came back clean. It was the cheapest security review she will ever run.

She ended the module the way the lesson closes: fifteen hand-onboarded tutors, an invite email to her eleven waitlist parents and eight interviewees, and a weekly demo recording nobody asked her for yet.

---

## [Lesson 4.5: The Ceiling Check](/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/)

She read the five signals once, put a recurring monthly block on her calendar titled "ceiling check," and closed the tab. First run: scheduled for thirty days after launch. That is the whole lesson at this stage.

---

## What Mia Walked Away With at the End of Module 4

- **A live MVP at a domain she owns**, built from her brief - every screen traceable to a parent quote, the session rate on the profile where the prototype said it belonged.
- **Ownership locked before launch**: registrar, GitHub, Supabase, Stripe, all in her name. One domain transfer was the only fix the audit demanded.
- **A build-path decision with a paper trail** - self-serve, chosen by worksheet answers instead of by the fear that "real products need agencies."
- **One security hole caught on paper**: the row-level security fix from the AI audit prompt, before any parent's data was ever at risk.
- **A seeded user base waiting**: fifteen tutors onboarded by hand, nineteen warm invitations out.

**Next: [Module 5, where Mia finds out whether anyone would miss TutorMatch](/course/tech-for-non-technical-founders-2026/must-have-segment-pmf-test/)** - and turns the answer into her next ten customers.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
