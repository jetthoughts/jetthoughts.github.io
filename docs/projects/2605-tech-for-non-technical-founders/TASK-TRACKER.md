# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-08-08 | **Status**: course v2 COMPLETE and live; wave plan 20.15 CLOSED (W1-W5 merged: PRs #428 #431 #432 #433 #434 #435); GA4 + Clarity measuring; **Aug 1-14 campaign freeze holds** (no template/section-structure changes until the Aug-14 metrics read).
**History**: everything shipped through 2026-08-02 — groomed scopes, retrospectives, closed waves — lives in [`_ARCHIVED_TASK-TRACKER-2026-07.md`](_ARCHIVED_TASK-TRACKER-2026-07.md) (item line-numbers preserved in its banner). This file is ONLY the live queue.
**Editing policies (BLOCKING)**: [`60-69-policies/60.01-course-editing-policies.md`](60-69-policies/60.01-course-editing-policies.md) — read before touching course content.

## ⏱ Next dated event

**Aug-14 metrics read** — first evidence read of the GA4/Clarity campaign window against the week-0 baseline (`50-59-execution/50.01-week0-metrics-baseline.md`). It gates items 13 and the post-freeze window; nothing else waits on it.

## Open queue (in execution order)

1. **Item 16 — Landing full-migration to the shuffle2 reference. ✅ PR #444 OPEN** (branch `landing-item16`). **Blocked on merge by: (a) Paul's taste gate on the render (esp. T4 stat-cell copy), (b) CI `workflow_dispatch update-baselines` for the Linux `desktop/course/landing` baseline** (T2/T4 changed the hero-fold; macOS committed, Linux stale — the only real Linux red; the other 7 dtest reds are known local-Docker codeblock env-flakes, green on CI). Host `bin/test` green; both reviewer agents failed on Fable quota so all blocking checks were run directly with evidence (constraint scoping, anchors, canon, fact-loss, div balance, parity-gate regression sim — all pass). Design panel (3 lenses: conversion/taste/UX) decided: Fork A = Option 2 + embedded CTA (dark NOT-cover, drop the endcap island, keep the bottom CTA inside the dark base); Fork B = relocate all 4 off-reference sections; section reorder = adopt reference order. Shipped: **T1** relocate 4 sections → how-this-course-works (5 inbound anchors repointed, router one-liner kept in hero); **reorder** Hero → mistakes → module map → NOT-cover; **T2** gradient second-line H1 (`list.html` replaceRE, one semantic h1); **T3** mistakes 2→3-col; **T4** hero stat cells (Methodology/No-Code MVP · Validation Pace/2-3 Weeks — copy Paul-gated); **T5** dark NOT-cover single full-bleed band + merged endcap (0px seam to footer) + 4 dead eyebrow selectors removed; **T6** chapter links body-color + muted numbers + tighter cards. 20%-slot: `bin/check-landing-parity` (report-only, 3≤4 budget). Result render: `40-49-review/40.32-item16-result-full.jpeg`. **Remaining before merge:** core-reviewer verdict, full visual pair (`bin/test` host + honest `bin/dtest` from main), **Linux hero baseline re-record via CI `workflow_dispatch update-baselines`** (T2/T4 changed the hero-fold; macOS baseline committed, Linux stale), ONE PR + Paul taste gate on the render (T4 copy). Constraints held: all CSS in `course-list.css`, template only `list.html`, no shared CSS/partials.

2. **Item 18 — Remaining 46 under-floor SVGs → O2 flat-vector.** Groomed 2026-08-02, READY TO RUN, campaign-safe, parked after SW-1 per Paul — full scope in the archive @L693. Extends the decided O2 system (ADR 30.09; no new Paul style call needed); template = the 22 already-converted FLAT/PASS SVGs; spec = `.okf/design/house-visual-spec.md` "v3 exhibit spec" (W=720, 5-rung scale, basis rung ≥17px). Gate per batch: `bin/check-svg-floor` + scroll gate both viewports.

3. **Item 13 — W4: V3-B wiring + media P1 (post-Aug-14).** New course-single.css + single.html, walkthrough visual hooks, 1.2/1.3/1.5 mid-body visuals, 5.7 mermaid horizontal, TL;DR accent. Carries the W2 input: responsive-table treatment (`overflow-x:auto` containers) fixing the 390px overflow on the two dense reference pages. Full visual pair at PR prep. Archive @L295.

4. **Item 7 — Wave G Batch 2 (blog): sla-checklist, cheap-developers, admin-panel-spaceship.** Written + critic-fixed on branch `blog-waveg-batch2`; needs covers + publish gate → draft:false → ONE PR closes the wave. NOTE: 20.09's P0 content gate applies — confirm with the content plan before publishing. LinkedIn briefs stay DRAFTS-ONLY for Paul.

## Parked / postponed (not blocking, revisit on trigger)

- **Item 14 — reader-mode readability research** (POSTPONED by Paul 2026-08-02; also tracked as the 2604 reader-mode item — 2605 owns it). Archive @L819.
- **External validation pilot** — post-course-completion only; kit at `40-49-review/40.18-external-validation-pilot-kit.md`. "Pilot" in-session = INTERNAL template review (see editing policies).

## Done (pointer)

W1-W5 + rollout + Wave 0/A-H + M1-M5 media waves + G1-G3 growth waves — all in the archive with retrospectives. Wave plan: [`20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md`](20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md) (CLOSED 2026-08-02).
