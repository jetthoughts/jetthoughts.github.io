---
type: Content Architecture
title: Course structure (From Idea to First Paying Customer)
description: 5-module linear spine defined in data/course_sequence.yaml, plus a non-linear Going Further set, per-module Mia walkthroughs, and template chapters.
resource: content/course/tech-for-non-technical-founders-2026/
tags: [course, structure, hugo]
generated:
  by: process:okf-migrate
  at: 2026-07-17T00:00:00Z
verified:
  by: claude-opus/4.8
  at: 2026-08-17T00:00:00Z
---

# The spine

The reading order lives in `data/course_sequence.yaml` - the Overview
(how-this-course-works) then Modules 1-5 (hypothesis → smoke test →
interviews → brief/build → first paying customer). The prev/next strip,
branch-aware forks, and the `course-stat` shortcode all derive from that
file. Never hardcode exact chapter counts in prose; use near numbers
("20+ lessons").

# Outside the spine

- **Going Further set** (linked from the 5.7 closing callout): continuation
  chapters (churn triage, pivot-or-persevere), the hire-track reference pair
  (hire-track-supplementary-reference: find/stack/interview;
  fractional-cto-sow-reference: FCTO bridge + SOW - split 2026-08-01 to fit
  the 2,900 reference cap),
  demoted management chapters (engineering org chart, friday demo rule,
  three questions standup, weekly dev report), and the AI-in-production trio
  (agency AI questions → AI token bill → slopsquatting, badged Step 1-3 of 3).
- **Mia walkthroughs**: one per module (`module-N-walkthrough-mia`).
- **Templates**: worksheet/checklist/script chapters with
  [generated PDFs](/build/pdf-templates.md).
- **Reference deep-dives** under `reference/` - every module now has them
  (M1: hypothesis-sprint-full, smoke-test-channel-guide,
  stripe-price-test-full; M2: mom-test-full, persona-rehearsal-full,
  find-10-people-full (shared by 2.3+2.4), prototype-build-full;
  M3: product-brief-full, outcomes-not-features-full; M4: hire-decision-full,
  ownership-full, stack-tools-full, mvp-build-phases-full,
  ceiling-signals-full; M5: must-have-survey-full, channel-selection-full,
  paid-pilot-full, outbound-full). Lessons point at them via a
  `Deeper reference:` footer line; the module landing cards link them as
  "Optional reference". As of 2026-07-17 ALL five modules are migrated to
  the v2 micro-lesson format - no v1 long-form lessons remain.
- **Floating glossary**: five-tech-words-stop-nodding-at, reachable from every
  chapter, not in the linear order.

# Micro-lesson vs reference: the altitude rule

Split the pair by **learner action, not content volume**. The micro-lesson
carries everything the learner must DO plus how to verify it (per phase/step:
action → demo check → if-fails); the reference carries exact mechanics only
(SQL, prompt text, test-card numbers, cost tables). If a micro block contains
SQL or card numbers it crossed the line; if a micro defers a required step
("the real steps are over there") it became a promo shell. Each fact gets ONE
home - duplicated paragraphs (e.g. a handoff protocol in both files) and
circular deferrals ("detail is in the other page", both directions) are
defects. Lesson 4.4 shipped as a shell this way (4x same reference link,
promise restated 6x, phases 2-4 untaught in place) - fixed 2026-08-17 by
giving every phase the do/demo/if-fails block in the micro.

All chapter facts must agree with the [course canon](/content/course-canon.md).
