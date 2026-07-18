---
title: "2.2 · Sharpen Your Question List with AI Personas"
aliases: ["/blog/ai-persona-pre-validation-mom-test-prep/"]
description: "Lesson 2.2 of the From Idea to First Paying Customer course. A 90-minute companion pass: use Claude personas to sharpen the Mom Test question list you drafted in Lesson 2.1 before booking real interviews."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: ai-persona-pre-validation-mom-test-prep
keywords:
  - ai persona mom test
  - claude personas customer research
  - rehearse interview questions
  - non technical founder ai validation
  - ai augmented customer discovery
tags:
  - founders
  - non-technical-founder
  - module-2
  - validation
  - ai-augmented
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "2.2 · Sharpen Your Question List with AI Personas"
  og_description: "Lesson 2.2 of the From Idea to First Paying Customer course. A 90-minute companion pass: use Claude personas to sharpen the Mom Test question list you drafted in Lesson 2.1 before booking real interviews."
cover_image_alt: "JetThoughts cover for Lesson 2.2 - Claude persona rehearsing Mom Test questions to flag hypothetical-shaped traps before real interviews"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/ai-persona-pre-validation-mom-test-prep/"
related_posts: false
---

> **Module 2 · Lesson 2.2 · [OPTIONAL]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** your draft Mom Test question list (5-8 questions from Lesson 2.1) + your `[CUSTOMER]` blank from the Lesson 1.1 hypothesis (the role, company size, and situation it names - that description is your ICP, your Ideal Customer Profile)
>
> **Output:** a sharpened question list (5-7 solid questions) + top 3 objections, ready to take into Lesson 2.3-2.4 recruitment and real interviews
>
> **Progress:** M2 · 2 of 6 · Results so far: draft question list · Interviewed customers before? Skip straight to [Lesson 2.3: Find 10 People](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/) - 2.1 is the core
>
> **Cost:** $0 (free tier on Claude or ChatGPT)

---

You drafted 5-8 Mom Test questions in Lesson 2.1. Before you spend one of your ~10 scarce interview slots on a question like "Would you use a tool like this?" - which generates a polite "sounds great" from anyone and teaches you nothing - run the list past a Claude persona that matches your ICP. A free rehearsal catches the broken question at your desk instead of on call 5 of 10.

After this lesson you will be able to: **spot and repair pitch-shaped questions before they cost you a real interview slot.**

The pattern: rehearsal tells you whether the question is broken; real interviews tell you whether the hypothesis is right. There's a second reason to rehearse - interviewing is a skill you build by doing it and getting feedback, not by reading about it. Teresa Torres' teams practice with mock interviews and a feedback loop before the questions ever reach a real customer; the clumsy run is where the learning happens ([Product Talk](https://www.producttalk.org/learning-to-interview-continuously/)). A Claude persona gives you that same loop without spending a real interviewee on a question you could have caught first.

![The rehearsal flow at a glance: bring in your draft question list plus the Lesson 1.1 customer blank, run Prompts 1-2 to build 3 ICP personas and test each question in-character, Prompt 3 for Claude's out-of-character diagnosis, Prompts 4-5 to surface 3 objections and sharpen weak questions past-anchored, and leave with 5-7 sharpened questions plus an Objection Tracker for real interviews](rehearsal-loop.svg)

## Build 3 ICP personas in Claude

You don't need a sophisticated setup. Describe the person you're trying to interview in terms Claude can work with, then ask Claude to stay in character while you practice questions. Here's the persona setup prompt - the placeholder mapping table below tells you where each `[BRACKETED]` value comes from in your existing artifacts.

### Prompt 1 - Persona Setup

```text
You are [PERSONA NAME], a [ROLE] at a [COMPANY SIZE] company in [INDUSTRY].

Your situation:
- You deal with [PROBLEM DESCRIPTION] about [FREQUENCY].
- You currently handle it by [CURRENT WORKAROUND].
- You've been doing this for [DURATION].
- Your budget authority for tools in this category is [BUDGET RANGE].
- You're skeptical of new software because [REASON - e.g. "the last three tools we bought sat unused"].

Stay in character for this entire conversation. Do not break character to explain your reasoning. Answer as [PERSONA NAME] would, not as an AI. If a question is vague, give the kind of vague polite answer a busy professional gives when they're not sure what you're asking.
```

**Placeholder mapping - where each value comes from:**

| Placeholder | Where it lives in your artifacts |
|---|---|
| `[ROLE]` | Founding Hypothesis `[CUSTOMER]` blank (Lesson 1.1) - e.g. "solo chiropractor managing insurance claims" |
| `[INDUSTRY]` + `[COMPANY SIZE]` | Your Lesson 1.1 `[CUSTOMER]` blank - the company size and situation it names |
| `[PROBLEM DESCRIPTION]` | Founding Hypothesis `[PROBLEM]` blank (Lesson 1.1) |
| `[PROBLEM AREA]` | The `[PROBLEM]` blank summarized in 2-3 words (e.g. "claim resubmission backlog") |
| `[CURRENT WORKAROUND]` | Founding Hypothesis `[COMPETITION]` blank (what they do today) |
| `[YOUR DRAFT QUESTION 1]`, `2`, `3`, ... | Pick one question at a time from your Lesson 2.1 `Mom Test draft - [DATE]` doc (5-8 question list) |
| `[QUESTION X]` (in Prompt 5) | Whichever question you want to sharpen from your draft list |
| `[PERSONA NAME]`, `[FREQUENCY]`, `[DURATION]`, `[BUDGET RANGE]`, `[REASON]` | Your judgment, anchored to deep-research findings if you ran the deep-research prompt on the [full sprint reference](/course/tech-for-non-technical-founders-2026/reference/hypothesis-sprint-full/) linked from Lesson 1.1 - see fallback below |

> **Fallback for the 3 fields not in your hypothesis (`[FREQUENCY]`, `[DURATION]`, `[REASON]`):** make your best informed guess. The rehearsal is calibrated; the persona doesn't have to be perfect. After your first real Lesson 2.3-2.4 interview, you will know whether your guess was too mild ("monthly" when reality is "daily") or too aggressive. Revise BETWEEN interview 1 and interview 2. If any placeholder above is empty, the Lesson 1.1 hypothesis is not specific enough - tighten it before rehearsing.

Build 3 distinct personas before you start - not 3 variations of the same person. If your ICP is "ops managers at B2B SaaS companies," your three might be: one at a 10-person seed startup, one at a 60-person Series A, one at a 200-person growth-stage company. Each has different objections, workarounds, and reasons to care. A question that works cleanly on one and collapses on another tells you something before you spend real calendar slots finding out.

## Run the rehearsal

Once the persona is set, run your draft questions through four follow-up prompts (the full text of each is in the [persona-rehearsal reference](/course/tech-for-non-technical-founders-2026/reference/persona-rehearsal-full/)):

1. **Prompt 2 - Ask** each draft question in-character. The persona answers as a busy professional would.
2. **Prompt 3 - Diagnose:** tell Claude to break character and assess whether that question would produce useful data on a real call. Read the diagnosis, not the polite in-character answer - Claude is trained to be helpful, so a coherent answer is not proof the question works.
3. **Prompt 4 - Surface objections:** ask what would make the persona want to end the call or feel pitched. This gives you 3 objections to listen for in real interviews.
4. **Prompt 5 - Sharpen:** rewrite every vague question as a past-anchored version under 20 words. Run all three personas against the same list before you judge any single question.

**Success check:** you end with 5-7 solid questions (down from 5-8 loose ones) and a top-3 objection list - the two deliverables you carry into [booking real interviews](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/).

---

**If this fails: all 3 personas produce nearly-identical answers.**
- **Why:** your persona descriptions are too generic - three variations of the same person, not three different people.
- **Fix:** rewrite them with sharper role, company-size, and urgency differences. If you can't write three distinct personas at all, go back to [Lesson 1.1](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) and tighten the `[CUSTOMER]` blank first.

---

Look at the one question every persona answered cleanly. Would a real stranger with no stake answer it the same easy way? If yes, it's probably still hypothetical - sharpen it before you book a single call.

---

> **Done:** you have a sharpened question list (5-7 solid questions) and an Objection Tracker with the top 3 objections to listen for.
>
> **You have now:** a question list rehearsed against pushback (2.2) on top of your 2.1 draft. The rehearsal proved the questions are ready - it did NOT validate the hypothesis; only the 10 real interviews do that.
>
> **Next:** [2.3 · Find 10 People: Where to Look](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/) - build the 30-name list, then [2.4 · What to Say](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) sends the messages using the sharpened list you just built.
>
> **If blocked:** see "If this fails" above.
>
> **Deeper reference:** [The four full rehearsal prompts, the keep/revise/cut rubric, and the Objection Tracker](/course/tech-for-non-technical-founders-2026/reference/persona-rehearsal-full/)

---

*See it in action: [Module 2 walkthrough: Mia interviews ten parents](/course/tech-for-non-technical-founders-2026/module-2-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
