# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-08-08 | **Status**: course v2 COMPLETE and live; wave plan 20.15 CLOSED (W1-W5 merged: PRs #428 #431 #432 #433 #434 #435); GA4 + Clarity measuring; **Aug 1-14 campaign freeze holds** (no template/section-structure changes until the Aug-14 metrics read).
**History**: everything shipped through 2026-08-02 — groomed scopes, retrospectives, closed waves — lives in [`_ARCHIVED_TASK-TRACKER-2026-07.md`](_ARCHIVED_TASK-TRACKER-2026-07.md) (item line-numbers preserved in its banner). This file is ONLY the live queue.
**Editing policies (BLOCKING)**: [`60-69-policies/60.01-course-editing-policies.md`](60-69-policies/60.01-course-editing-policies.md) — read before touching course content.

## ⏱ Next dated event

**Aug-14 metrics read** — first evidence read of the GA4/Clarity campaign window against the week-0 baseline (`50-59-execution/50.01-week0-metrics-baseline.md`). It gates items 13 and the post-freeze window; nothing else waits on it.

## Open queue (in execution order)

1. **Item 16 — Landing full-migration to the shuffle2 reference. ✅ DONE, MERGED (PR #444, squash `902686f3`, 2026-08-12).** Paul approved the render + flagged `bin/check-landing-parity` as redundant → removed (YAGNI). Design panel (conversion/taste/UX) decided Fork A = Option 2 + embedded CTA (dark NOT-cover, endcap merged into the dark base, no light sliver), Fork B = relocate all 4 off-reference sections, section reorder to reference order. Shipped T1-T6 (relocate 4 sections + 5 anchor repoints, reorder, gradient H1, 3-col mistakes, hero stat cells, dark band + merged endcap + 4 dead-selector cleanup, de-farmed chapter links). Linux baselines re-recorded via CI `update-baselines` (40-file env-drift re-sync incl. the intended `desktop/course/landing`) and rode the merge. Result render: `40-49-review/40.32-item16-result-full.jpeg`. Both reviewer agents failed on Fable quota → all blocking checks self-run with grep evidence. **Landing is live.**

2. **Item 18 — Course SVG corpus → O2 flat-vector. ✅ DONE, PR #445 OPEN** (branch `course-svg-floor-item18`). Floor burn-down **46 → 0** across 4 sub-waves (SW-1 5 walkthroughs, SW-2 11 reference+hire-track, SW-3 16 workflow/template, SW-4 13 hiring/sales/ownership); `bin/check-svg-floor` reports all 80 SVGs clear the 9px@390 floor. **Gate flipped to BLOCKING**: `bin/hugo-build` runs `check-svg-floor` with `SVG_FLOOR_BLOCK=1` and fails on any regression. Executors ran on Opus (Fable exhausted — [[feedback-agent-fallbacks-fable-and-hugo-expert]]); two main-checkout write-leaks caught + reverted. Gates: hugo-build green (8 validators + blocking floor), rendered review on 5 SVGs across diagram types, pixel suite N/A (masks `<img>`). Rebased clean onto master (item16). **Awaiting: Paul review + merge of #445.**

3. **Item 13 — W4: V3-B wiring + media P1 (post-Aug-14).** New course-single.css + single.html, walkthrough visual hooks, 1.2/1.3/1.5 mid-body visuals, 5.7 mermaid horizontal, TL;DR accent. Carries the W2 input: responsive-table treatment (`overflow-x:auto` containers) fixing the 390px overflow on the two dense reference pages. Full visual pair at PR prep. Archive @L295.

4. **Item 7 — Wave G Batch 2 (blog): sla-checklist, cheap-developers, admin-panel-spaceship.** Written + critic-fixed on branch `blog-waveg-batch2`; needs covers + publish gate → draft:false → ONE PR closes the wave. NOTE: 20.09's P0 content gate applies — confirm with the content plan before publishing. LinkedIn briefs stay DRAFTS-ONLY for Paul.

## Parked / postponed (not blocking, revisit on trigger)

- **Item 14 — reader-mode readability research** (POSTPONED by Paul 2026-08-02; also tracked as the 2604 reader-mode item — 2605 owns it). Archive @L819.
- **External validation pilot** — post-course-completion only; kit at `40-49-review/40.18-external-validation-pilot-kit.md`. "Pilot" in-session = INTERNAL template review (see editing policies).

## Done (pointer)

W1-W5 + rollout + Wave 0/A-H + M1-M5 media waves + G1-G3 growth waves — all in the archive with retrospectives. Wave plan: [`20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md`](20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md) (CLOSED 2026-08-02).
