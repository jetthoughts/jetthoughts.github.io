---
title: "3.1 · AI Persona Pre-Validation - Sharpen the Mom Test Before You Book Real Interviews"
description: "Use Claude personas to rehearse Mom Test questions before booking real interviews. AI catches weak questions in 5 minutes; real customers stay irreplaceable for catching weak hypotheses."
date: 2026-07-01
draft: false
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
  - module-3
  - validation
  - ai-augmented
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "3.1 · AI Persona Pre-Validation - Sharpen the Mom Test Before You Book Real Interviews"
  og_description: "Use Claude personas to rehearse Mom Test questions before booking real interviews. AI catches weak questions in 5 minutes; real customers stay irreplaceable for catching weak hypotheses."
canonical_url: "https://jetthoughts.com/blog/ai-persona-pre-validation-mom-test-prep/"
related_posts: false
---

> **Module 3 · Step 1 of 4** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) course.
> Input: a draft Mom Test question list + 3 ICP characteristics. Output: a sharpened question list, top 3 objections identified, ready to book real interviews.

A real customer interview costs you $25-$100 in incentives, 40 minutes of calendar, and one of the 10 slots you have for this validation round. When the interviewer asks a weak question - "would you use this?" instead of "walk me through the last time this happened" - the whole slot produces polite noise and zero signal. An AI rehearsal costs you nothing. Five minutes in Claude, before you pick up the phone, and you find out which questions collapse the moment a real human deflects them. This is rehearsal, not replacement. Real interviews are irreplaceable for the thing rehearsal cannot simulate: the customer who gives you a noncommittal shrug on question three, the one who mentions a workaround you never imagined, the silence after Q4 that tells you more than 10 affirmative answers. AI personas catch weak questions. Real customers catch weak hypotheses.

## Why this is rehearsal, not replacement

This framing gets challenged, so let's name the challenge directly: if AI personas can simulate customer responses, why run real interviews at all?

Because a Claude persona cannot surprise you. It can't remember the emergency workaround it duct-taped together last Thursday. It can't get visibly uncomfortable when you ask about budget. It can't refer you to a colleague whose entire job is the problem you're describing. Every piece of signal that changes how a founder reads the market - the hesitation, the referral, the "actually, our ops manager is the one who hates this" - comes from real humans in unscripted conversation.

What Claude can do is show you where your questions break before you spend a real slot on a question that produces no information. A question like "Do you find this process frustrating?" generates a polite yes from a persona and a polite yes from a real interviewee, and neither tells you anything. A question like "Tell me what you did the last time this happened - walk me through each step" generates a response from a persona that's directionally plausible, which is enough to reveal that the question is a real one. If even the AI persona gives you a vague or confused response, the question is broken.

This is the same logic a trial attorney uses when prepping cross-examination with a paralegal standing in as the witness. The paralegal is not irreplaceable for giving testimony. The rehearsal is irreplaceable for finding the question that falls apart under any pressure at all.

So: run the rehearsal, sharpen the questions, then book the interviews. The real interviews stay irreplaceable. The rehearsal prevents the most avoidable failure mode in customer discovery - burning a limited set of interview slots on questions that were never going to work.

## Build 3 ICP personas in Claude in 5 minutes

You don't need a sophisticated prompt setup. You need to describe the person you're trying to interview in terms Claude can work with, and then ask Claude to stay in character while you practice questions.

Here's the persona setup prompt:

---

**Prompt 1 - Persona Setup**

```
You are [PERSONA NAME], a [ROLE] at a [COMPANY SIZE] company in [INDUSTRY].

Your situation:
- You deal with [PROBLEM DESCRIPTION] about [FREQUENCY].
- You currently handle it by [CURRENT WORKAROUND].
- You've been doing this for [DURATION].
- Your budget authority for tools in this category is [BUDGET RANGE].
- You're skeptical of new software because [REASON - e.g. "the last three tools we bought sat unused"].

Stay in character for this entire conversation. Do not break character to explain your reasoning. Answer as [PERSONA NAME] would, not as an AI. If a question is vague, give the kind of vague polite answer a busy professional gives when they're not sure what you're asking.
```

---

Build 3 distinct personas before you start - not 3 variations of the same person. If your ICP is "ops managers at B2B SaaS companies," your three personas might be: one at a 10-person seed startup (different budget, different urgency), one at a 60-person Series A (different process maturity), and one at a 200-person growth-stage company (different buying committee). Each persona has different objections, different workarounds, and different reasons to care. A question that works cleanly on one persona will collapse on another - and that collapse tells you something before you spend real calendar slots finding out.

## Run the rehearsal session (5-prompt sequence)

Once the persona is set, run your draft questions. Here's the sequence:

---

**Prompt 2 - Opening question test**

```
I'm going to ask you a question about [PROBLEM AREA]. Answer as [PERSONA NAME] would if a stranger asked you this at a conference. Question: "[YOUR DRAFT QUESTION 1]"
```

After each answer, ask this diagnostic:

**Prompt 3 - Question diagnosis**

```
Now break character for 30 seconds. As an AI assessing that question: Was that a question that would produce useful data in a real customer interview? What would a real busy ops manager do with that question that I wouldn't predict from your answer? What's the version of that question that would make you open a real memory instead of giving a general response?
```

Repeat for each question. The diagnosis prompt is the mechanism. Claude in-character gives you a plausible answer. Claude out-of-character tells you whether that answer means anything.

**Prompt 4 - Objection surface**

```
Back in character as [PERSONA NAME]: What would make you want to end this conversation early? What question would feel like a pitch in disguise? What would make you worry I'm about to sell you something?
```

This prompt surfaces the three objections you need to test (not discover) in real interviews. An interviewee who feels sold to shuts down. If your question list has any question that a persona reads as a pitch, it will also read as a pitch to a real human - and real humans stop giving real answers the moment they sense a sales agenda.

**Prompt 5 - Sharpening**

```
Rewrite [QUESTION X] so that it anchors in a specific past event rather than a hypothetical. Keep it under 20 words. Give me three versions.
```

Use this on every question that produced a vague answer in Prompt 2. Concrete past-anchored questions are the whole point of [the Mom Test](/blog/mom-test-ask-about-past-not-future/). If you can't make the question past-anchored in 20 words, the question isn't ready.

---

The session takes 20-30 minutes per persona. Run all three personas against the same question list before you judge any single question. A question that holds up across all three is probably solid. A question that collapses on persona 2 but not persona 3 tells you something about the ICP segment, not just the question.

## What to keep, what to throw out

After the rehearsal, you'll have a mix of responses. Here's how to read them:

**Keep the question if:**
- The persona gave a specific, concrete answer even without being pushed
- Claude's out-of-character diagnosis called it "useful" or "opens real memory"
- All three personas answered differently (different concrete stories, not just different adjectives)

**Revise the question if:**
- The persona answered in generalities ("yeah, we usually...") without any push
- Claude's diagnosis said "this produces the same polite yes a bad question produces"
- The sharpening prompt produced a clearly better version in under 60 seconds

**Cut the question if:**
- The persona read it as a pitch in disguise (Prompt 4 flagged it)
- Even after three sharpening attempts, it's still hypothetical
- Claude's diagnosis couldn't explain what useful data this question would collect

One thing to watch: Claude is trained to be helpful, which means it tends to give reasonable answers even to broken questions. Don't read a coherent persona answer as proof the question works. Read Claude's out-of-character diagnosis instead. That's where the honest assessment lives.

The rehearsal is not a replacement for judgment. You still decide which questions make the cut. Claude tells you which ones are obviously broken before you find out the expensive way.

## What changed in your real interview slate

After the rehearsal, you have two deliverables.

**The sharpened question list.** Take your original questions, apply the revisions from Prompt 5, cut the ones flagged in Prompt 4. You should end the session with 5-7 solid questions where you started with 8-12 loose ones. That's the list you take into [booking real interviews with the full outreach stack](/blog/find-10-people-with-problem-outreach-2026/).

**The top 3 objections to test in real interviews.** Prompt 4 will surface 3-5 things that make your persona want to end the conversation. Pick the 3 that appeared across at least 2 of your 3 personas. These are the objections you're listening for in real interviews - not discovering them for the first time, but noticing whether and how they show up. There's a difference between a real customer who raises objection #2 early (strong signal that the objection is real) and one who never raises it at all (either it's not real for this person, or your questions didn't give them space to surface it).

**Objection Tracker** - fill this in after the rehearsal, before your first real interview:

| Objection | Which personas raised it | What phrasing to listen for | Showed up in real interviews? |
|-----------|-------------------------|----------------------------|-------------------------------|
| 1. | | | |
| 2. | | | |
| 3. | | | |

Print it. Put it next to the [Mom Test interview script](/blog/mom-test-ask-about-past-not-future/) on your second monitor. After each real interview, tick the column. By interview 5, you'll know which objections are real and which were just AI pattern-matching.

## Going further

The rehearsal technique has a second use case beyond question sharpening: hypothesis revision.

After your real interviews, if a hypothesis is partially invalidated - the problem is real but the customer the hypothesis named is wrong - you can run a new persona session with a revised ICP before you go back out with another 10 interview slots. Build 3 new personas reflecting the ICP shift, run the same prompt sequence, and see if the new questions feel sharper. This is not a replacement for more real interviews. It is a way to use the 48 hours between finishing round 1 and opening calendar slots for round 2.

The same logic applies to product-direction pivots. If round 1 surfaces a different problem than you expected, build a persona around the new problem before you rebuild the question list from scratch. AI personas are disposable and fast. Real interview slots are not.

One constraint worth naming: the rehearsal only surfaces signal that's already in your mental model of the customer. Claude constructs the persona from what you tell it. If your ICP description is wrong - the wrong role, the wrong company size, the wrong industry detail - the persona will be wrong in the same direction, and the rehearsal will give you false confidence. This is another reason the real interviews stay irreplaceable. A real customer can tell you your ICP description is wrong. Claude can only simulate the ICP you described.

---

**Module 3 navigation**

| Step | Chapter | Output |
|------|---------|--------|
| **3.1 - You are here** | AI Persona Pre-Validation (this chapter) | Sharpened question list + top 3 objections |
| 3.2 | [Find 10 People With the Problem](/blog/find-10-people-with-problem-outreach-2026/) | 10 ICP interviewees booked |
| 3.3 | [The Mom Test: Ask About the Past](/blog/mom-test-ask-about-past-not-future/) | 10 scored transcripts |
| 3.4 | [Validated Problem Statement](/blog/validated-problem-statement-template/) | One-page statement, 2 signatures |

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) curriculum.*
