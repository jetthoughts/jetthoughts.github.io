---
title: "2.1 · AI Persona Pre-Validation - Sharpen Mom Test Questions"
aliases: ["/blog/ai-persona-pre-validation-mom-test-prep/"]
description: "Use Claude personas to rehearse Mom Test questions before booking real interviews. AI catches weak questions; real customers catch weak hypotheses."
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
  - module-3
  - validation
  - ai-augmented
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "2.1 · AI Persona Pre-Validation - Sharpen Mom Test Questions"
  og_description: "Use Claude personas to rehearse Mom Test questions before booking real interviews. AI catches weak questions; real customers catch weak hypotheses."
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/ai-persona-pre-validation-mom-test-prep/"
related_posts: false
---

> **Module 2 · Step 1 of 4** · [Tech for Non-Technical Founders 2026](/course/tech-for-non-technical-founders-2026/) course.
> Input: a draft Mom Test question list + 3 ICP characteristics. Output: a sharpened question list, top 3 objections identified, ready to book real interviews.

A founder we worked with in February 2026 ran five Mom Test interviews with a question list she'd written herself. Three said "sounds great!" She called it weak validation and almost pivoted. Before she booked the next five slots, she ran a 20-minute Claude rehearsal with a persona matching her ICP. The out-of-character diagnosis flagged her second question immediately: "Would you use a tool like this?" - hypothetical, pitch-shaped, generates polite yes from anyone. She rewrote her questions to anchor in past events. On the next round, 4 of 5 real interviewees said "no, that's not actually my problem" and then gave her the actual problem. The original hypothesis hadn't been wrong - the questions had been.

A real customer interview costs you $25 to $100 in incentives, 40 minutes of calendar, and one of the 10 slots you have for this validation round. When you ask a weak question - "would you use this?" instead of "walk me through the last time this happened" - the whole slot produces polite noise. An AI rehearsal costs nothing. Five minutes in Claude before you pick up the phone, and you find out which questions collapse the moment a real human deflects them. Real interviews stay irreplaceable for the things rehearsal cannot simulate: the noncommittal shrug on question three, the mention of a workaround you never imagined, the silence after Q4 that tells you more than ten polite yeses. The rehearsal sharpens your questions before you spend a real customer's hour on them.

## Why rehearse with AI at all

| What AI Personas Can Do | What Only Real Interviews Do |
|---|---|
| Show where your questions break before you spend a real slot | Deliver the hesitation, the pause, the "actually, our ops manager..." referral |
| Flag hypothetical questions like "Do you find this frustrating?" that generate polite yes-mode from anyone | Reveal the emergency workaround someone duct-taped together last Thursday |
| Reveal vague or confused persona responses that would collapse under real pressure | Surface unexpected competitors, blockers, or stakeholders you never imagined |
| Prevent the most avoidable failure mode: burning interview slots on broken questions | Tell you when your ICP definition is wrong (real customers can, persona cannot) |

Think of it as a trial attorney prepping cross-examination with a paralegal standing in as the witness. The paralegal can't give testimony, but the rehearsal finds the question that falls apart under any pressure at all.

So: run the rehearsal, sharpen the questions, then book the interviews. The rehearsal prevents the most avoidable failure mode in customer discovery - burning a limited set of interview slots on questions that were never going to work.

## Build 3 ICP personas in Claude in 5 minutes

You don't need a sophisticated prompt setup. You need to describe the person you're trying to interview in terms Claude can work with, and then ask Claude to stay in character while you practice questions.

Here's the persona setup prompt:


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


> **Heads up:** Claude is trained to be helpful, which means it tends to give reasonable answers even to broken questions. Don't read a coherent persona answer as proof the question works. Read Claude's out-of-character diagnosis instead - that's where the honest assessment lives.

Build 3 distinct personas before you start - not 3 variations of the same person. If your ICP is "ops managers at B2B SaaS companies," your three personas might be: one at a 10-person seed startup (different budget, different urgency), one at a 60-person Series A (different process maturity), and one at a 200-person growth-stage company (different buying committee). Each persona has different objections, different workarounds, and different reasons to care. A question that works cleanly on one persona will collapse on another - and that collapse tells you something before you spend real calendar slots finding out.

## Run the rehearsal session

Once the persona is set, run your draft questions. Here's the sequence.

### Prompt 2 - Opening question test

```text
I'm going to ask you a question about [PROBLEM AREA]. Answer as [PERSONA NAME] would if a stranger asked you this at a conference. Question: "[YOUR DRAFT QUESTION 1]"
```

After each answer, ask this diagnostic.

### Prompt 3 - Question diagnosis

```text
Now break character for 30 seconds. As an AI assessing that question: Was that a question that would produce useful data in a real customer interview? What would a real busy ops manager do with that question that I wouldn't predict from your answer? What's the version of that question that would make you open a real memory instead of giving a general response?
```

Repeat for each question. The in-character answer is plausible by default; the out-of-character diagnosis is where you learn whether the question would actually produce useful data on a real call.

### Prompt 4 - Objection surface

```text
Back in character as [PERSONA NAME]: What would make you want to end this conversation early? What question would feel like a pitch in disguise? What would make you worry I'm about to sell you something?
```

This prompt surfaces the three objections you need to test (not discover) in real interviews. An interviewee who feels sold to shuts down. If your question list has any question that a persona reads as a pitch, it will also read as a pitch to a real human - and real humans stop giving real answers the moment they sense a sales agenda.

### Prompt 5 - Sharpening

```text
Rewrite [QUESTION X] so that it anchors in a specific past event rather than a hypothetical. Keep it under 20 words. Give me three versions.
```

Use this on every question that produced a vague answer in Prompt 2. Concrete past-anchored questions are the whole point of [the Mom Test](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/). If you can't make the question past-anchored in 20 words, the question isn't ready.

---

The session takes 20-30 minutes per persona. Run all three personas against the same question list before you judge any single question. A question that holds up across all three is probably solid. A question that collapses on persona 2 but not persona 3 tells you something about the ICP segment, not just the question.

## What to keep, what to throw out

After the rehearsal, you'll have a mix of responses. Use these three signals to sort:

| Decision | Condition |
|----------|-----------|
| **Keep it** | Persona gave a specific, concrete answer without being pushed; Claude's out-of-character diagnosis called it "useful"; all three personas answered with different concrete stories, not just different adjectives |
| **Revise it** | Persona answered in generalities; the sharpening prompt (Prompt 5) produced a clearly better version in under 60 seconds |
| **Cut it** | Prompt 4 flagged it as a pitch in disguise; or three sharpening attempts couldn't make it past-anchored |

Judgment is still yours. The diagnostic only tells you which questions are obviously broken before you find out the expensive way. A question with a plausible in-character answer but a "this is hypothetical" out-of-character flag still gets cut - the helpful answer is the trap.

## What changed in your real interview slate

After the rehearsal, you have two deliverables.

**The sharpened question list.** Take your original questions, apply the revisions from Prompt 5, cut the ones flagged in Prompt 4. You should end the session with 5-7 solid questions where you started with 8-12 loose ones. That's the list you take into [booking real interviews with the full outreach stack](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/).

**The top 3 objections to test in real interviews.** Prompt 4 will surface 3-5 things that make your persona want to end the conversation. Pick the 3 that appeared across at least 2 of your 3 personas. These are the objections you're listening for in real interviews - not discovering them for the first time, but noticing whether and how they show up. There's a difference between a real customer who raises objection #2 early (strong signal that the objection is real) and one who never raises it at all (either it's not real for this person, or your questions didn't give them space to surface it).

**Objection Tracker** - fill this in after the rehearsal, before your first real interview:

| Objection | Which personas raised it | What phrasing to listen for | Showed up in real interviews? |
|-----------|-------------------------|----------------------------|-------------------------------|
| They'll say budget is controlled by their manager | Personas 1 and 3 | "I'd have to run this by..." | [ ] |
| 1. | | | |
| 2. | | | |
| 3. | | | |

Print it. Put it next to the [Mom Test interview script](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) on your second monitor. After each real interview, tick the column. By interview 5, you'll know which objections are real and which were just AI pattern-matching.

## What to do tomorrow

| Day | Action | Outcome |
|---|---|---|
| **Day 1** | Open Claude/ChatGPT and paste the 4 rehearsal prompts in order. Run through one persona session in 30-45 minutes. | 5-7 sharpened questions, top 3 objections identified |
| **Day 2** | Run the same prompts against personas 2 and 3. Note every question that got vague or off-topic answers - those are the weak ones. | Question list with all weak questions flagged for rewrite |
| **Day 3** | Rewrite the weak questions using Prompt 5 (past-anchored, under 20 words). Book the first real interview. | Ready to start real customer interviews with a sharp question list |

The two deliverables after tomorrow: a sharpened question list (5-7 solid questions) and an Objection Tracker (top 3 objections to listen for in real interviews).

## Going further

Reuse the rehearsal stack when a round of real interviews ends in partial signal.

| Scenario | What to do | Why |
|---|---|---|
| **Real interviews end in partial signal** | Run a new persona session with a revised ICP before booking another 10 slots | Filling the 48 hours between round 1 and round 2 surfaces question gaps |
| **Hypothesis partially invalidated** (problem is real, but wrong customer named) | Build 3 new personas reflecting the ICP shift, run the same prompt sequence | This still doesn't substitute for more real interviews; it just sharpens them |
| **Product-direction pivot emerges** (round 1 surfaces a different problem) | Build a persona around the new problem before rebuilding the question list from scratch | Spinning up a persona costs 5 minutes; spinning up another 10 interview slots costs a week |
| **Considering a customer pivot between validation rounds** | Compare question performance across both the old ICP persona and the new one before committing | Reveals which questions survive the ICP shift and which ones were persona-specific |

One constraint worth naming: the rehearsal only surfaces signal that's already in your mental model of the customer. Claude constructs the persona from what you tell it. If your ICP description is wrong - the wrong role, the wrong company size, the wrong industry detail - the persona will be wrong in the same direction, and the rehearsal will give you false confidence. This is the other reason real interviews stay irreplaceable: a real customer can tell you your ICP description is wrong, while Claude can only simulate the ICP you described.

## Further reading

- Rob Fitzpatrick, [The Mom Test (book site)](https://www.momtestbook.com/) - the canonical reference for past-anchored interview questions.
- Y Combinator, [How to Talk to Users](https://www.ycombinator.com/library/6g-how-to-talk-to-users) - YC's short essay on why this conversation has to happen.
- Anthropic, [Claude prompting guide](https://docs.anthropic.com/claude/docs/intro-to-prompting) - persona setup, role-play, and breaking character cleanly.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/course/tech-for-non-technical-founders-2026/) curriculum.*
