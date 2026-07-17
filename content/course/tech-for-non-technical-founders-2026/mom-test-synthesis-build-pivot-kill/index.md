---
title: "2.5 · Mom Test Synthesis: Build, Pivot, or Kill"
aliases: ["/blog/mom-test-synthesis-build-pivot-kill/"]
description: "After your 10 Mom Test interviews: score each transcript, count strong signals, and decide build, pivot, or kill. The 90-minute synthesis that turns raw transcripts into a validated problem statement."
date: 2026-05-13
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: mom-test-synthesis-build-pivot-kill
keywords:
  - mom test synthesis
  - score customer interviews
  - build pivot kill decision
  - validated problem statement
  - founder interview analysis
tags:
  - founders
  - non-technical-founder
  - customer-research
  - validation
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "2.5 · Mom Test Synthesis: Build, Pivot, or Kill"
  og_description: "After your 10 Mom Test interviews: score each transcript, count strong signals, and decide build, pivot, or kill. The 90-minute synthesis."
cover_image_alt: "JetThoughts course cover for Lesson 2.5 - Score Ten, Then Build, Pivot, or Kill, with the decision gate card: 7 or more build, 4 to 6 pivot, under 4 kill"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/mom-test-synthesis-build-pivot-kill/"
related_posts: false
---

> **Module 2 · Lesson 2.5 · [CORE] - run after your 2.4 interviews** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** 10 scored Mom Test transcripts (from [Lesson 2.1](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/)) + completed interviews (from [Lesson 2.3-2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/))
>
> **Output:** a build / pivot / kill decision + a one-page validated problem statement
>
> **Progress:** M2 · 5 of 6 · Results so far: question list + 30-name list + 10 scored interviews - this page turns the scores into a decision

> **TL;DR:** Score 10 transcripts, count strong signals, make one of three calls. 90 minutes. The decision you avoid here costs you a quarter of build time later.

> **You should be here AFTER your Lesson 2.3-2.4 interviews are done.** If you don't have 10 scored transcripts in hand, return to [Lesson 2.1](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) for the technique, then [Lesson 2.3-2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) for recruitment. This page is the synthesis pass - you cannot complete it without real interview data.

After all 10 interviews are done, you have scored transcripts in a folder and a number. Synthesis is the 90-minute step that turns those transcripts into the one-page validated problem statement you'll carry into Module 3. Skip this step and go straight to Lovable, and you have not validated anything - you have a folder and a hypothesis.

## The 3-step synthesis

Synthesis runs on three moves. You don't need a framework. You need 90 minutes alone with the 10 transcripts, a printed template, and the willingness to write down a number that might be a 3.

**Step 1 - Score each interview 1-10.** Open the transcripts in order. For each call, read your handwritten Q4 score and your emotional-flag count from the [Lesson 2.1 script](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/). Combine the two into one number from 1 to 10. A score of 7+ means the interviewee gave you a 7 or higher on Q4 with a comparison (the polite-default 7 with no comparison rounds to 5) and at least 3 emotional-language flags across the five answers. A 4 to 6 means partial signal - a real story but a weak workaround, or a high Q4 score with zero frustration language. Below 4 means polite-yes mode: vague Q1 answers, "nothing yet" on Q3, a hedged Q4 number under 7.

Write the number on the first page of each transcript within 5 minutes of hanging up. The score you write immediately is more honest than the one you'd write after a week of wanting the number to be higher.

**Step 2 - Count the strong signals.** On a single sheet of paper, list the 10 scores in a column. Circle every score that is 7 or higher. That circled count is your strong-signal number.

The pattern matters more than the average. Eight 7+ scores and two 3s is a strong signal - you found a problem two ICPs share. Five 7+ scores and five 5s is muddled - the ICP definition is too broad. Three 9s and seven 4s is the dangerous one: you talked to your three best friends in the industry and they validated the idea while seven strangers told you the truth.

**Step 3 - Write the one page.** Open the [Validated Problem Statement Template](/course/tech-for-non-technical-founders-2026/validated-problem-statement-template/) on a second screen. Fill it in within 30 minutes. Five sections, no exceptions: who has the problem (named persona, named industry, strong-signal count); what it costs them (time, money, and one specific quote from a real transcript - avoid "frustrating" and "time-consuming"); what they've tried (named workarounds and why each failed - these are your real competitors); why now (the trigger event or market shift that makes this solvable in 2026); how big is the pain (average score plus strong-signal count - print both, not just the average). A single side of paper. If you spill onto a second page, the persona is too broad or the pain is too vague.

## The decision: build / pivot / kill

Your strong-signal count from Step 2 routes you to one of three outcomes.

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Caveat, Patrick Hand, Comic Sans MS, cursive', 'primaryColor':'#fff5f5', 'primaryBorderColor':'#cc342d', 'lineColor':'#333', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart TD
    Start(["10 Mom Test transcripts.<br/>90 minutes alone, pen + printed template."])
    Start --> S1[Step 1<br/>Score each interview 1-10]
    S1 --> S2[Step 2<br/>Count strong signals 7+]
    S2 --> S3[Step 3<br/>Write the one page]
    S3 --> S4{Strong signals<br/>in 10 calls?}
    S4 -->|7 or more| Build[BUILD<br/>Test the shape in Lesson 2.6<br/>then write the Lesson 3.1 brief]
    S4 -->|4 to 6| Pivot[PIVOT<br/>Run 5 more interviews<br/>Refine the ICP first]
    S4 -->|Fewer than 4| Kill[KILL<br/>Rewrite the hypothesis in Lesson 1.1<br/>then re-run Lesson 2.3]
    Build --> Sign[Show to 2 advisors.<br/>Get 2 signatures before building.]
    Pivot --> Sign
    Kill --> Sign

    classDef start fill:#e8f4f8,stroke:#0277bd,stroke-width:2.5px,color:#1a1a1a
    classDef step fill:#fff5f5,stroke:#cc342d,stroke-width:2px,color:#1a1a1a
    classDef decision fill:#faf5ff,stroke:#a855f7,stroke-width:2px,color:#1a1a1a
    classDef build fill:#f0f9f0,stroke:#2e7d32,stroke-width:2.5px,color:#1a1a1a
    classDef pivot fill:#fffbe6,stroke:#bf8a00,stroke-width:2.5px,color:#1a1a1a
    classDef kill fill:#ffebee,stroke:#c62828,stroke-width:2.5px,color:#1a1a1a
    classDef sign fill:#f5f5f5,stroke:#555,stroke-width:2px,color:#1a1a1a

    class Start start
    class S1,S2,S3 step
    class S4 decision
    class Build build
    class Pivot pivot
    class Kill kill
    class Sign sign
```

**7+ strong signals: build.** You have a problem that 70%+ of a stranger sample confirmed with felt urgency. The validated problem statement travels with you into [2.6 · Build a Clickable Prototype](/course/tech-for-non-technical-founders-2026/clickable-prototype-validation-2-hour-lovable/) to test the shape, and from there into [The One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/).

Before you start writing code, run the 3 pre-orders test: ask your 5 strongest-signal interviewees for a pre-order, a paid letter of intent, or a deposit. Strangers who told you their problem score is a 9 should be willing to put a small commitment behind it. If 3 of the 5 say yes, you have validation with money attached - the strongest signal there is. If 0 of the 5 say yes, the 7+ scores were politer than you thought.

**4-6 strong signals: pivot.** The signal is partial. Most often this is an ICP problem, not a problem problem. Pick the cleanest segment, sharpen the ICP definition, run 5 more interviews against that narrower group. Don't build yet. The 5 sharper interviews cost you a week. A built MVP against a fuzzy ICP costs you a quarter.

**Below 4 strong signals: kill.** Strangers were polite. The market said no in the only way the market knows how to say no before a launch: by not feeling the pain enough to put a number on it. Write down what you learned about the wrong ICP, the wrong framing, or the wrong trigger event. Return to [1.1 · Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/), rewrite the weakest blank using what the dead transcripts taught you, then rebuild your list in [2.3 · Find 10 People: Where to Look](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/).

## What good looks like vs what bad looks like

**Bad problem statement (vague, unfilled):**
> **Bad** - Founders need a better way to validate their startup ideas. Many of them waste time and money.

**Good problem statement (specific, named, signed):**
> **Good** - Pre-seed B2B SaaS founders running their own discovery do customer interviews, but 9 of 10 (per our 10-call sample, Apr-May 2026) use hypothetical-future questions and get polite-yes answers. The average interviewee currently spends 6-12 hours running interviews and learns the problem wasn't real only after their first launch flops - typical sunk cost is 6 weeks of build time plus $15K-$30K of contractor spend. Workarounds tried: YC Library essays (too high-level), $1,500 SurveyMonkey panel (taught one founder I spoke with nothing in the survey style), free templates downloaded but not used. Why now: AI-built MVPs accelerated this failure mode - the prototype lands in 4 days instead of 12 weeks, so the validation gap surfaces faster. Pain average 7.6/10 across 10 calls, 8 strong signals.

The good answer has named industry, dated sample, named workarounds with named failure modes, a quantified cost, a why-now, and a strong-signal count. A peer can argue with it. If your statement has the word "many" or "a lot," cross it out.

The [Validated Problem Statement Template](/course/tech-for-non-technical-founders-2026/validated-problem-statement-template/) is the artifact for this section. Print it, fill it in 30 minutes, get 2 signatures, and the problem validation checkpoint is closed.

Writing the one-page statement is the validation step. Ten transcripts in a folder don't count - until you've scored them, counted the strong signals, and written down what the pattern says, you have raw material and a hypothesis, not a validated problem.

## Further reading

- Rob Fitzpatrick, [The Mom Test (book site)](https://www.momtestbook.com/) - the past-behavior technique behind every transcript you're scoring here.
- Teresa Torres, [Customer Interviews (Product Talk)](https://www.producttalk.org/customer-interviews/) - the deeper-practice version of our scoring sheet: an interview snapshot, one page per interview, capturing a memorable verbatim quote, the quick context facts, and the unmet needs that surfaced.

---

> **Done:** you have a build / pivot / kill decision backed by your strong-signal count, and a one-page validated problem statement.
>
> **You have now:** question list (2.1-2.2) + 30-name list (2.3) + 10 scored interviews (2.4) + the build/pivot/kill decision. The orientation pages state this gate as "7 of 10 interviewees have spent time or money on the problem" - the two are the same bar, because a transcript cannot score 7+ without real past spend surfacing in Q2/Q3.
>
> **Next:** If build - [2.6 · Build a Clickable Prototype](/course/tech-for-non-technical-founders-2026/clickable-prototype-validation-2-hour-lovable/) to test the shape with 5 of your strongest-signal interviewees, then [3.1 · The One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/). If pivot - sharpen the `[customer]` blank of your hypothesis, then return to [2.3 · Find 10 People: Where to Look](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/) to rebuild your list around that narrower group. If kill - the hypothesis is wrong, not the list; return to [1.1 · Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) and rewrite the weakest blank using verbatim quotes from your dead transcripts, then re-run 2.3.
> **If blocked:** If the numbers aren't adding up, re-read [Lesson 2.1's scoring rubric](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) - the Q4 score and flag-count combination is what separates a 7 from a 5.

---

*See it in action: [Module 2 walkthrough: Mia interviews ten parents](/course/tech-for-non-technical-founders-2026/module-2-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
