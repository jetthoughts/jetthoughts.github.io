---
title: "2.6 · Build a Clickable Prototype"
aliases: ["/blog/clickable-prototype-validation-2-hour-lovable/"]
description: "A throwaway Lovable prototype lets 5 interview subjects experience the SHAPE of your solution. The third validation pillar after the landing page."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: clickable-prototype-validation-2-hour-lovable
keywords:
  - lovable prototype validation
  - clickable prototype mom test
  - 2 hour mvp prototype
  - non technical founder validation
  - throwaway prototype customer research
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
  og_title: "2.6 · Build a Clickable Prototype"
  og_description: "A throwaway Lovable prototype lets 5 interview subjects experience the SHAPE of your solution. The third validation pillar after the landing page."
cover_image_alt: "JetThoughts cover for Lesson 2.6 - hand-drawn three-screen clickable prototype with five user-test sessions and pass/fail signal markers"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/clickable-prototype-validation-2-hour-lovable/"
related_posts: false
---

> **Module 2 · Lesson 2.6 · [CORE]** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a BUILD decision plus your validated problem statement from [2.5](/course/tech-for-non-technical-founders-2026/mom-test-synthesis-build-pivot-kill/), and 5 of the 10 Mom Test interviewees (recruited in [2.3](/course/tech-for-non-technical-founders-2026/find-10-people-where-to-look/), messaged in [2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/)) - pick the strongest-signal ones (scored per the Lesson 2.1 rubric)
>
> **Output:** 5 of them watched navigating a throwaway clickable prototype, with pass/fail per session
>
> **Progress:** M2 · 6 of 6 · Results so far: question list + 30-name list + 10 scored interviews + a build/pivot/kill verdict and validated problem statement

> **TL;DR:** Three throwaway screens, five silent-observation sessions. Watch whether users can navigate your solution without coaching - something interviews cannot tell you.

> **How this lesson relates to Lesson 2.3-2.4:** [Lesson 2.3-2.4](/course/tech-for-non-technical-founders-2026/find-10-people-with-problem-outreach-2026/) already booked and ran your 10 past-behavior Mom Test interviews. This lesson takes 5 of those 10 (the ones who scored 7+) and re-engages them for a 30-minute silent-observation session with a throwaway Lovable prototype. You are NOT recruiting fresh people; you are re-asking warm contacts for a different kind of time. Lesson 2.3-2.4 validated THE PROBLEM; Lesson 2.6 validates THE SOLUTION SHAPE.

The [Mom Test](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) tells you whether the problem is real and felt. A clickable prototype tells you something the Mom Test cannot: whether the user knows what to do when you hand them a solution. Those signals do not measure the same thing.

After this lesson you will be able to: **watch 5 real customers try to use your solution before it exists - and score what they do, not what they say.**

One founder we advised ran 8 strong Mom Test interviews, then built a working app over several weeks - and when 5 interviewees logged in, several stalled on screen 2, unable to figure out which button to click next. Validating the problem had not validated whether the shape was navigable. A throwaway prototype in front of 5 subjects surfaces that in an afternoon. ([Full story](/course/tech-for-non-technical-founders-2026/reference/prototype-build-full/).)

> **This is a research tool, not the start of your MVP.**
>
> You build 3 throwaway screens, show them to 5 of your Mom Test interviewees, watch what they do without coaching, then archive everything. The only outputs that carry forward into Module 3 are (a) the pass/fail signal and (b) the exact words your users used when describing what they saw. The prototype CODE is discarded.
>
> Polish this prototype into your MVP later and you'll spend much longer on it, carry every throwaway compromise into production, and invalidate the shape test. The actual MVP is a fresh build in Module 4 ([Lesson 4.3](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/) defines the stack, [Lesson 4.4](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-build-phases/) walks the phases), started from the one-page brief (Lesson 3.1) with real auth, real Stripe, real domain.

## What a prototype catches that interviews miss

A Mom Test interview pulls the interviewee into the past. A prototype session puts them into a possible future and watches what they do. Three things break at the prototype stage that looked clean in interviews:

| Failure | What happens | Why interviews miss it |
|---|---|---|
| **Workflow backward** | The founder designed the three screens in the order she thought about the problem. The user thinks about it in the opposite order. Screen 1 asks for the wrong piece of information; the user stalls. | An interview asks "how do you do X" - it never asks "what would you click first on a screen." |
| **Vocabulary wrong** | Founder calls it "reconciliation." User's accountant calls it "matching." Button says "Reconcile"; user clicks everything else on the screen first. | Verbal language in an interview doesn't expose what label a user expects on a button. |
| **Scope wrong** | User opens the prototype, sees three screens, asks "where do I upload the CSV?" That feature was in Module 5 of the founder's plan; she considered it obvious context. It isn't. | Interview answers paint the system the founder describes, not the surface the user touches. |

None of these show up in a Mom Test interview - they only appear the moment a real person touches the interface. The [full reference](/course/tech-for-non-technical-founders-2026/reference/prototype-build-full/) has the three-pillar theory (smoke test → Mom Test → prototype) in depth.

## Build 3 screens with Lovable

[Lovable](https://lovable.dev) is an AI app builder that generates a working web app from a prompt. Free trial available, no coding required. Three screens is the constraint - not five, not ten - because each extra screen multiplies the build effort without sharpening the validation signal: **Screen 1** is the entry point (one dominant action), **Screen 2** is the core action (where value is delivered - and where users stall if the vocabulary is wrong), **Screen 3** is the confirmation or result.

> **The two caps that replace "spend a weekend on it".** (1) **Stop at 3 screens.** The fourth screen is the prototype turning into the MVP - exactly the failure mode this lesson prevents. (2) **Aim for a navigable 3-screen prototype within your first ~10 Lovable exchanges.** If after 10 messages the screens still aren't navigable, the hypothesis or the prompt is too vague - sharpen the prompt (or go back to Lesson 1.1) before continuing. Do NOT keep adding messages hoping to brute-force coherence.

Open [Lovable](https://lovable.dev), create a new project, and paste the following. Replace all `[PLACEHOLDERS]` with your specific problem and solution.

```text
Build a 3-screen clickable prototype for a [PRODUCT CATEGORY] tool targeting [CUSTOMER].

This is a throwaway validation prototype. Use hard-coded fake data only. No backend, no auth, no database. All buttons should navigate between screens or show a static success state.

SCREEN 1 - [ENTRY POINT NAME]:
- [PRIMARY ACTION the user takes on this screen]
- Show [FAKE DATA EXAMPLE]
- One prominent CTA button: "[BUTTON LABEL]"

SCREEN 2 - [CORE ACTION NAME]:
- [WHAT THE USER SEES after taking the Screen 1 action]
- Show [FAKE DATA EXAMPLE]
- [KEY VOCABULARY the user must understand]
- One action: "[BUTTON LABEL]"

SCREEN 3 - [RESULT/CONFIRMATION NAME]:
- [WHAT SUCCESS LOOKS LIKE]
- Next step prompt: "[WHAT YOU WANT THE USER TO DO NEXT]"

Design: Clean, minimal. Dark sidebar, white content area. [YOUR COLOR] accent. No login screen. No settings. No navigation beyond these 3 screens. Make it look functional, not finished.
```

Where the blanks come from: `[CUSTOMER]` is your `[CUSTOMER]` blank from Lesson 1.1; `[PRIMARY ACTION ...]` is the top workaround-replacing action from your Lesson 2.5 validated problem statement; `[FAKE DATA EXAMPLE]` is names and numbers pulled from your interview transcripts. Use the vocabulary you heard in interviews, not the words you use with other founders - if 7 of 10 interviewees called it "matching" and you call it "reconciliation," the prototype uses "matching."

![Build the 3-screen prototype in three moves: open Lovable and paste the prompt template with placeholders filled, read the fake data out loud and change the vocabulary to match the words you heard in interviews, then test all three screens yourself as if you've never seen the idea - leaving with a prototype ready to share as a link to 5 interviewees](prototype-build-strip.svg)

> **Deeper reference:** the [full build walkthrough](/course/tech-for-non-technical-founders-2026/reference/prototype-build-full/) has a filled-in worked example (a reconciliation tool for freelance bookkeepers), the Lovable free-tier onramp, and the screen-by-screen build detail.

## Run a silent-observation session with 5 interviewees

Choose 5 of the 10 interviewees whose Mom Test scores were 7 or higher. Book 30-minute video calls. Send the Lovable prototype link 10 minutes before each call - not earlier, so they don't explore it solo before you can observe.

**The re-engagement message** (paste into LinkedIn DM or reply to your original Lesson 2.3-2.4 thread):

> *"Hi [name] - thank you for the 30 minutes last week. I built a quick clickable prototype based on what you told me about [their specific workaround from the Mom Test transcript]. I'd like 30 more minutes to watch you try it without me explaining anything - just silent observation while you click through. I'll send the link 10 minutes before. Would Tuesday afternoon or Wednesday afternoon work?"*

Expect 4-5 of 5 to say yes - the *"I built something based on what you told me"* line signals you listened. During the session, stay silent and record behavior: write down the first buttons they reach for, note any pause over 5 seconds, and never answer their questions or coach them toward the right path. When they finish Screen 3, ask one question: "Describe in one sentence what that tool just did." Write down their exact words.

The [full reference](/course/tech-for-non-technical-founders-2026/reference/prototype-build-full/) has the verbatim opening script, the four closing questions, the async slow-path variant for part-time founders, and the three common fixable failures.

## Pass/fail scoring

Score each session immediately after the call ends. Use three signals.

| Signal | Pass | Fail |
|---|---|---|
| Gets to Screen 3 without coaching | Yes, under 5 minutes | No, or needs explanation |
| Describes the product accurately in 1 sentence | Names the core action correctly | Vague ("it does something with data") or wrong |
| First 3 clicks are correct | Navigates toward the CTA | Clicks UI elements that aren't the intended path |

A session is a **pass** only if all three signals are green. The prototype gate:

- **4 or 5 passes of 5:** Shape is legible. Advance to [Module 3 · One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/), using the "describe in one sentence" words from the closing questions.
- **2 or 3 passes:** Revise one element (vocabulary, Screen 1 layout, or CTA label) and run 2 replacement sessions. One iteration only.
- **0 or 1 pass:** The shape is wrong. Return to Lesson 2.1 before writing any brief - a shape mismatch usually means the interview signal was off.

Catching a shape mismatch here costs one throwaway prototype. Catching it in Module 4, after the real build has started, costs the real build.

> **If this fails:** the user cannot get past Screen 1 and asks what the product does before touching it. **Why:** Screen 1 has no instruction in the user's own words, or it has clutter competing with the primary CTA. **Fix:** add one line of microcopy above the CTA naming the action in the user's vocabulary, and remove everything on Screen 1 that is not the primary button. Test with one fresh session before advancing.

## What to do next

| Step | Action | Output |
|---|---|---|
| **1** | Open Lovable and paste this lesson's 3-screen prompt with every `[PLACEHOLDER]` filled in. Aim for a navigable prototype within ~10 exchanges; stop at 3 screens. | Throwaway 3-screen prototype with link |
| **2** | Book 5 silent-observation sessions with interviewees who scored 7+ on the Mom Test. Send the prototype link 10 minutes before each call. | 5 sessions on the calendar |
| **3** | Tally the pass count from 5 sessions. Copy the exact "describe in one sentence" answers into a doc - those words go into the [One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/) verbatim. | Pass/fail count + verbatim vocabulary |

---

> **Done:** 5 silent-observation sessions are complete, scored with pass/fail per session, and you have verbatim vocabulary from the closing "describe in one sentence" answers.
>
> **You have now:** all Module 2 artifacts - scored interviews (2.1-2.4), the build/pivot/kill decision (2.5), and prototype feedback from 5 real customers (2.6). Drop them all in your `Founder OS` folder; Lesson 3.1 reads the vocabulary into Section 3 of the brief. Module 2 closes here.
>
> **Next:** [3.1 · The One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/) - reads your validated problem statement into Section 1 and your prototype vocabulary into Section 3.
>
> **If blocked:** see "If this fails" above. If 0-1 of 5 sessions passed, the solution shape is wrong - read the "what did you expect to see" answers (that is the user's mental model) and return to Lesson 2.1 before writing the brief.
>
> **Deeper reference:** [Full prototype build, session script, and Module 2 decision matrix](/course/tech-for-non-technical-founders-2026/reference/prototype-build-full/) - the screen-by-screen build, the worked example, the verbatim session script, the combined interview + prototype decision matrix, and the artifacts map.

---

*See it in action: [Module 2 walkthrough: Mia interviews ten parents](/course/tech-for-non-technical-founders-2026/module-2-walkthrough-mia/)*

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
