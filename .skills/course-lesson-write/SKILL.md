---
name: course-lesson-write
description: Draft a complete 8-part micro-lesson (index.md) from a topic brief. Use this skill whenever the user asks to write a course lesson, draft a micro-lesson, create a lesson from a topic, or mentions `/course-lesson-write`. Triggers on phrases like "write a lesson", "draft a course chapter", "create a micro-lesson", "write lesson X.Y", or any course content creation task for the Tech for Non-Technical Founders course.
---

# Course Lesson Writer

Draft a complete 8-part micro-lesson from a topic brief. Enforces every spec gate at write time, not after.

## Pre-loaded context (read these before writing)

1. **8-part template structure** — `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.03-course-format-requirements-for-creators.md` §2
2. **Sam profile** — `docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.06-sam-customer-journey-report-2026-06.md` (the corrected newbie Sam: first-time, no tech expertise, no PM background, no burn history, intimidation + first-timer enthusiasm)
3. **Voice guide** — `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` (banned words, anti-AI structural patterns, banned structural patterns, the "who"/"show"/"coffee" tests)
4. **Iter 19 pilot pattern** — agnostic tool framing as worked example (single golden path tool, no tool-pinning in title/slug)

## Inputs expected

- **Chapter topic** — the specific micro-outcome (e.g., "write a founding hypothesis sentence")
- **Input artifact** — what Sam brings from the previous lesson
- **Output artifact** — what Sam walks away with
- **Optional tool to feature as worked example** — agnostic framing, not pinned in title/slug

## Output format

Complete `index.md` with Hugo frontmatter + 8-part body, ready for review + validation. Place in `content/course/tech-for-non-technical-founders-2026/<slug>/index.md`.

### Hugo frontmatter template

```yaml
---
title: "X.Y · Lesson Title"
aliases: ["/blog/slug/"]
description: "One-sentence description using Sam's language, no jargon"
date: YYYY-MM-DD
draft: true
course_chapter: true
author: "JetThoughts Team"
slug: lesson-slug
keywords:
  - keyword1
  - keyword2
tags:
  - founders
  - non-technical-founder
  - course-companion
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "X.Y · Lesson Title"
  og_description: "Same as description"
cover_image_alt: "Alt text describing the cover image content"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/slug/"
related_posts: false
---
```

### 8-part body structure (MANDATORY — every part required except #4 visual)

```
> **Module X · Lesson N of M** · [Course link]

> **Input:** [what Sam brings]

> **Output:** [what Sam walks away with]

> **TL;DR:** [one sentence — the what and why in Sam's language]

[8 PARTS BELOW — DO NOT NUMBER THEM VISIBLY, DO NOT USE TEMPLATE LABELS AS H2s]

## [DESCRIPTIVE H2 — never "Do this now", "If this fails", "Why this matters"]

...

## [DESCRIPTIVE H2 — next part]

...

> **Done when:** [observable success check]

> **Next click:** [link to next lesson]

> **If blocked:** [one common failure + fix]
```

## The 8 parts (structural rules, NOT visible labels)

### Part 1: Hook (1-3 sentences)

Start with a very specific pain sentence plus the immediate win. Maximum 3 sentences. Must contain: (a) the pain in Sam's language, (b) the immediate win from completing this lesson.

Example: "You have an idea. You've told five people about it. They all said 'that sounds great' — which told you nothing. In this lesson you'll turn that idea into a single sentence you can actually test."

### Part 2: One-Sentence Outcome

"After this lesson you will be able to: **[single, observable action]**."

Must be observable and verifiable — not "understand X" but "create X" or "configure X" or "decide X."

### Part 3: Minimal Concept Block (150-300 words)

Only what Sam needs to execute the step. Nothing more.

Constraints:
- Max 3 new terms per lesson; each defined in one sentence at first mention
- Use bullets instead of long paragraphs where possible
- No abstract theory. Extremely concrete language
- If a concept needs more than 300 words, split into two lessons

### Part 4: Visual Micro-Aid (Optional but Recommended)

One compact diagram, tiny flow, or before/after example image. If explaining takes more than 4-5 sentences, consider a small SVG.

Reference SVGs inline: `![alt text describing content](filename.svg)`

### Part 5: Step-by-Step "Do This Now"

Numbered list, 3-7 steps. Each step executable in under 3 minutes, written as an imperative action. Include "success check" after the last step: "You know it worked if you see X / have Y / can do Z."

### Part 6: Error Anticipation

Format:
> **If this fails:** [most common symptom]. **Why:** [root cause in one sentence]. **Fix:** [recovery action in 1-2 steps].

Every lesson must include at least one error anticipation block.

### Part 7: Micro-Reflection (60-90 seconds)

A single reflective question the student answers for themselves. Not a quiz — a moment to process.

### Part 8: Bridge to Next Lesson

1-2 sentences: "Next, we'll use what you just built to achieve [very specific next benefit]." Must name the specific dependency: what from this lesson the next lesson needs.

## Hard Gates (NON-NEGOTIABLE — zero tolerance)

### Anti-patterns to NEVER produce

1. **Template-label H2s leaking** — NEVER use `## Do this now`, `## If this fails`, `## Why this matters`, `## What to do tomorrow` or any template-label as an H2. Every H2 must be descriptive and content-specific.

2. **Inline-header bold-cap bullet pattern** — NEVER write `**Speed:** fast. **Quality:** good.` Use prose. Mix sentence lengths.

3. **Slogany "X works. Y doesn't." flips** — NEVER write "It's not about X. It's about Y." or "The hypothesis hadn't been wrong — the questions had been." State the cause and effect in normal order; let the reader supply the contrast.

4. **Definitional cadence** — NEVER open with "X is Y" definition. Open with tension, conflict, or a concrete scenario.

5. **Tool-pinning in title/slug** — NEVER put tool names (Lovable, Mixo, Carrd, Stripe) in the title or slug. Use agnostic framing: "smoke-test-build-page" not "build-with-mixo."

6. **Missing glosses** — Every technical term must be glossed at first mention: "CTO (Chief Technology Officer — the senior-most technical leader)" or "RLS (Row-Level Security — the rule that says Coach A can only read Coach A's rows)." Never assume Sam knows: MVP, PMF, ICP, CTA, DPA, ARR, MRR, SOC2, HIPAA, API, RLS, JWT, OAuth, SDK, CI/CD, CMS, DNS, SSL, hero section, incognito mode, staging, production, deployment, ORM, framework, runtime, webhook.

### Voice rules (from 90.11)

1. **Banned words** — unlock, harness, leverage, seamless, robust, supercharge, revolutionize, cutting-edge, world-class, best-in-class, state-of-the-art, innovative, synergy, holistic, game-changer, deep dive, empower, transform, embark, delve, navigate (metaphorical)
2. **Banned openings** — "In today's...", "When it comes to...", "It's worth noting..."
3. **Banned structural patterns** — Rule of three, triple rhetorical questions, signposting, negative parallelism, slogany closings, therapist voice, copula avoidance, anaphora pairs, sustained staccato, "The..." opener density >20%, "We..." opener density
4. **Punctuation** — Use regular dashes (`-`) not em dashes (`—`). NEVER use em dashes anywhere.
5. **Word count** — 500-900 words for agnostic-tool lessons (tool featured as worked example). 400-600 words for pure-concept lessons (no specific tool featured, no action section).

### Sam-first rules (from 40.06 and 40.07)

1. **Every term glossed at first mention** — if Sam doesn't know it, define it inline
2. **No "developer" or "PM" assumptions** — never assume Sam knows product management or engineering terminology
3. **First 30% orients** — thresholds and metrics arrive only when Sam acts on them
4. **Single golden path** — one primary tool recommendation with a named fallback, not a comparison table of 6 options
5. **Confidence-to-act** — Sam must know what to do next with no remaining ambiguity after reading

### Case study placement

Case studies live at the END OF EACH MODULE as a single coherent walkthrough page (`module-N-walkthrough-<founder>`), NOT inside individual lessons. Do NOT include case study narratives inside lesson bodies. The lesson body stays tightly focused on its single algorithm.

However, each lesson footer should include a case study CTA line at the END of the lesson (after the bridge) ONLY IF the module's walkthrough page already exists:

```
> **See it in action:** [Module N walkthrough · Founder](/course/tech-for-non-technical-founders-2026/module-N-walkthrough-founder/)
```

Do NOT add this line before the walkthrough page is published.

### Footer block (after bridge line)

```markdown
> **Done when:** [observable success check]
> **Founder OS · Artifact #N of 6:** [artifact name]. [where to save it].
> **Next click:** [X.Y · Next Lesson Title](/course/tech-for-non-technical-founders-2026/next-slug/)
> **If blocked:** [one common failure + fix]

> **See it in action:** [optional, only if walkthrough page exists]

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
```

## Workflow

1. Read `30.03-course-format-requirements-for-creators.md` §2 (the 8-part template)
2. Read `90.11-voice-guide.md` (banned words, structural patterns)
3. Read `40.06-sam-customer-journey-report-2026-06.md` (Sam's perspective)
4. Read at least 2-3 existing micro-lessons for style reference. Canonical v2 examples: `form-your-founding-hypothesis-90-minute-sprint/`, `stop-specifying-features-start-outcomes/`, `vibe-coding-ceiling-signals/`, `smoke-test-build-landing-page/`, `smoke-test-wire-tracking/` (from `content/course/tech-for-non-technical-founders-2026/<slug>/index.md`)
5. Draft the lesson frontmatter + 8-part body
6. Self-check against all hard gates above
7. Output the complete `index.md`
