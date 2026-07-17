---
title: "Full Reference: AI Persona Interview Rehearsal"
description: "The complete persona-rehearsal reference - the four follow-up prompts (diagnose, objection-surface, sharpen), the keep/revise/cut rubric, the Objection Tracker, and the between-rounds reuse playbook. Companion to Lesson 2.2."
date: 2026-05-18
draft: false
slug: persona-rehearsal-full
---

> **Reference companion to [Lesson 2.2 · Sharpen Your Question List with AI Personas](/course/tech-for-non-technical-founders-2026/ai-persona-pre-validation-mom-test-prep/)** - the four follow-up prompts, the keep/revise/cut rubric, the full Objection Tracker, and the between-rounds reuse playbook. Read the micro-lesson first to run the core rehearsal; return here for the full prompt set and the deeper reuse patterns.

---

## Why rehearse with AI at all

| What AI Personas Can Do | What Only Real Interviews Do |
|---|---|
| Show where your questions break before you spend a real slot | Deliver the hesitation, the pause, the "actually, our ops manager..." referral |
| Flag hypothetical questions like "Do you find this frustrating?" that generate polite yes-mode from anyone | Reveal the emergency workaround someone duct-taped together last Thursday |
| Reveal vague or confused persona responses that would collapse under real pressure | Surface unexpected competitors, blockers, or stakeholders you never imagined |
| Prevent the most avoidable failure mode: burning interview slots on broken questions | Tell you when your ICP definition is wrong (real customers can, persona cannot) |

Think of it as a trial attorney prepping cross-examination with a paralegal standing in as the witness. The paralegal can't give testimony, but the rehearsal finds the question that falls apart under any pressure at all.

## Run the rehearsal session

Once the persona is set (Prompt 1 lives in [Lesson 2.2](/course/tech-for-non-technical-founders-2026/ai-persona-pre-validation-mom-test-prep/)), run your draft questions. Here's the sequence.

### Prompt 2 - Opening question test

```text
I'm going to ask you a question about [PROBLEM AREA]. Answer as [PERSONA NAME] would if a stranger asked you this at a conference. Question: "[YOUR DRAFT QUESTION 1]"
```

After each answer, ask this diagnostic.

### Prompt 3 - Question diagnosis

```text
Now break character for 30 seconds. As an AI assessing that question: Was that a question that would produce useful data in a real customer interview? What would a real busy [ROLE] do with that question that I wouldn't predict from your answer? What's the version of that question that would make you open a real memory instead of giving a general response?
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

Run all three personas against the same question list before you judge any single question. A question that holds up across all three is probably solid. A question that collapses on persona 2 but not persona 3 tells you something about the ICP segment, not just the question.

## What to keep, what to throw out

After the rehearsal, you'll have a mix of responses. Use these three signals to sort:

| Decision | Condition |
|----------|-----------|
| **Keep it** | Persona gave a specific, concrete answer without being pushed; Claude's out-of-character diagnosis called it "useful"; all three personas answered with different concrete stories, not just different adjectives |
| **Revise it** | Persona answered in generalities; the sharpening prompt (Prompt 5) produced a clearly better version in under 60 seconds |
| **Cut it** | Prompt 4 flagged it as a pitch in disguise; or three sharpening attempts couldn't make it past-anchored |

Judgment is still yours. The diagnostic only tells you which questions are obviously broken before you find out the expensive way. A question with a plausible in-character answer but a "this is hypothetical" out-of-character flag still gets cut - a coherent answer to a hypothetical question tells you nothing about real customer behavior.

## What changed in your real interview slate

After the rehearsal, you have two deliverables.

**The sharpened question list.** Take your original questions, apply the revisions from Prompt 5, cut the ones flagged in Prompt 4. You should end the session with 5-7 solid questions where you started with 5-8 loose ones. That's the list you take into [booking real interviews with the full outreach stack](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/).

**The top 3 objections to test in real interviews.** Prompt 4 will surface 3-5 things that make your persona want to end the conversation. Pick the 3 that appeared across at least 2 of your 3 personas. These are the objections you're listening for in real interviews - not discovering them for the first time, but noticing whether and how they show up. Hearing an objection in rehearsal also does something quieter: when a real person raises it, you've already sat with it, so you take notes instead of getting defensive and pitching to win them back. There's a difference between a real customer who raises objection #2 early (strong signal that the objection is real) and one who never raises it at all (either it's not real for this person, or your questions didn't give them space to surface it).

**Objection Tracker** - fill this in after the rehearsal, before your first real interview:

| Objection (and which personas raised it) | What phrasing to listen for | Heard in real interviews? |
|-----------|----------------------------|-------------------------------|
| They'll say budget is controlled by their manager (personas 1 and 3) | "I'd have to run this by..." | [ ] |
| 1. | | |
| 2. | | |
| 3. | | |

Print it. Put it next to the [Mom Test interview script](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) on your second monitor. After each real interview, tick the column. By interview 5, you'll know which objections are real and which were just AI pattern-matching.

## Going further

Reuse the rehearsal stack when a round of real interviews ends in partial signal.

| Scenario | What to do | Why |
|---|---|---|
| **Real interviews end in partial signal** | Run a new persona session with a revised ICP before booking your next round of interviews | A rehearsal pass between rounds surfaces question gaps before you spend new slots on them |
| **Hypothesis partially invalidated** (problem is real, but wrong customer named) | Build 3 new personas reflecting the ICP shift, run the same prompt sequence | This still doesn't substitute for more real interviews; it just sharpens them |
| **Product-direction pivot emerges** (round 1 surfaces a different problem) | Build a persona around the new problem before rebuilding the question list from scratch | Spinning up a persona costs 5 minutes; spinning up another 10 interview slots costs a week |
| **Considering a customer pivot between validation rounds** | Compare question performance across both the old ICP persona and the new one before committing | Reveals which questions survive the ICP shift and which ones were persona-specific |

One constraint worth naming: the rehearsal only surfaces signal that's already in your mental model of the customer. Claude constructs the persona from what you tell it. If your ICP description is wrong - the wrong role, the wrong company size, the wrong industry detail - the persona will be wrong in the same direction, and the rehearsal will give you false confidence. If you notice you're struggling to write three distinct personas at all, that's a signal worth acting on: go back to [Lesson 1.1](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) and tighten the `[customer]` blank before rehearsing questions against a customer you can't describe.

This is the other reason real interviews stay irreplaceable: a real customer can tell you your ICP description is wrong, while Claude can only simulate the ICP you described.

> **What this AI rehearsal can and cannot do for you.**
>
> **What AI can help with at this stage:**
> - Simulate 3 ICP personas answering your draft Mom Test questions in-character
> - Flag hypothetical questions that generate polite-yes responses from anyone
> - Surface the top 3 objections to listen for in real interviews
> - Sharpen vague questions into past-anchored versions under 20 words
>
> **What AI cannot prove or substitute:**
> - Whether your ICP description is accurate (only a real interviewee can correct you)
> - What a real customer will actually say (Claude simulates the persona YOU describe)
> - Whether the problem is real (only 10 Mom Test interviews can falsify the hypothesis)
>
> **The real gate:** 10 Mom Test interviews with real humans, ≥7/10 strong signal (Lesson 2.1 technique + Lesson 2.3-2.4 recruitment).

> **Advanced: AI ensemble stress-test (after your interviews).** Once your 10 Mom Test interviews are done and you have a refined hypothesis, you can cross-validate the business logic using multiple AI models simultaneously. Paste your validated problem statement into [IdeaProof](https://ideaproof.io) (free tier to start) - it runs your hypothesis through several frontier models and flags contradictions between them. A claim that passes one model but fails another is a blind spot worth investigating before you build. The ensemble approach catches what a single-model rehearsal misses: each model has different training biases, and consensus across several is stronger signal than one model saying "sounds good." This is not a substitute for the Mom Test interviews - it validates the logic AFTER the interviews validated the problem. Think of it as the final sanity check before you commit to building.

## Further reading

- Rob Fitzpatrick, [The Mom Test (book site)](https://www.momtestbook.com/) - the canonical reference for past-anchored interview questions.
- Y Combinator, [How to Talk to Users](https://www.ycombinator.com/library) - YC's short essay on why this conversation has to happen.
- Anthropic, [Claude prompting guide](https://docs.anthropic.com/claude/docs/intro-to-prompting) - persona setup, role-play, and breaking character cleanly.
- Teresa Torres, [Learning to Interview Continuously (Product Talk)](https://www.producttalk.org/learning-to-interview-continuously/) - why mock interviews with feedback are how interviewers get good before the questions reach a real customer.

---

*Built by [JetThoughts](https://jetthoughts.com) as a companion reference to the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
