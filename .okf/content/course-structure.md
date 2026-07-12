---
type: Content Architecture
title: Course structure (From Idea to First Paying Customer)
description: 5-module linear spine defined in data/course_sequence.yaml, plus a non-linear Going Further set, per-module Mia walkthroughs, and template chapters.
resource: content/course/tech-for-non-technical-founders-2026/
tags: [course, structure, hugo]
timestamp: 2026-07-13T00:00:00Z
---

# The spine

The reading order lives in `data/course_sequence.yaml` - Chapter 0
(how-this-course-works) then Modules 1-5 (hypothesis → smoke test →
interviews → brief/build → first paying customer). The prev/next strip,
branch-aware forks, and the `course-stat` shortcode all derive from that
file. Never hardcode exact chapter counts in prose; use near numbers
("20+ chapters").

# Outside the spine

- **Going Further set** (linked from the 5.7 closing callout): continuation
  chapters (churn triage, pivot-or-persevere), the hire-track reference,
  demoted management chapters (engineering org chart, friday demo rule,
  three questions standup, weekly dev report), and the AI-in-production trio
  (agency AI questions → AI token bill → slopsquatting, badged Step 1-3 of 3).
- **Mia walkthroughs**: one per module (`module-N-walkthrough-mia`).
- **Templates**: worksheet/checklist/script chapters with
  [generated PDFs](/build/pdf-templates.md).
- **Reference deep-dives** under `reference/` (hypothesis-sprint-full,
  smoke-test-channel-guide, stripe-price-test-full).
- **Floating glossary**: five-tech-words-stop-nodding-at, reachable from every
  chapter, not in the linear order.

All chapter facts must agree with the [course canon](/content/course-canon.md).
