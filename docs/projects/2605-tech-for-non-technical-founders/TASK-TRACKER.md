# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-08-08 | **Status**: course v2 COMPLETE and live; wave plan 20.15 CLOSED (W1-W5 merged: PRs #428 #431 #432 #433 #434 #435); GA4 + Clarity measuring; **Aug 1-14 campaign freeze holds** (no template/section-structure changes until the Aug-14 metrics read).
**History**: everything shipped through 2026-08-02 — groomed scopes, retrospectives, closed waves — lives in [`_ARCHIVED_TASK-TRACKER-2026-07.md`](_ARCHIVED_TASK-TRACKER-2026-07.md) (item line-numbers preserved in its banner). This file is ONLY the live queue.
**Editing policies (BLOCKING)**: [`60-69-policies/60.01-course-editing-policies.md`](60-69-policies/60.01-course-editing-policies.md) — read before touching course content.

## ⏱ Next dated event

**Aug-14 metrics read** — first evidence read of the GA4/Clarity campaign window against the week-0 baseline (`50-59-execution/50.01-week0-metrics-baseline.md`). It gates items 13 and the post-freeze window; nothing else waits on it.

## Open queue (in execution order)

1. **Item 16 — Landing full-migration to the shuffle2 reference. RUNS NEXT** (unfrozen by Paul 2026-08-02, no Aug-14 wait). Six-gap punch-list groomed and re-audited @662744c3 — full scope in the archive @L476: (1) RELOCATE "Take this course if" + "Who built this" (+ "Going further", "Already started building?") off the landing to how-this-course-works/FAQ — biggest height cut, mind the `#already-started-building` + `#module-map` inbound anchors; (2) module map → compact summaries + chapter counts; (3) gradient second-line H1 — needs `layouts/course/list.html` (TEMPLATE = post-Aug-14 safe only); (4) mistakes grid 2→3-col; (5) hero card labeled stat cells; (6) NOT-cover dark band (dark-zone-budget rebalance). Skills: /impeccable + stitch-design + ux-principles; side-by-side vs 40.28 reference + Paul taste gate at the PR render. Landing-owned files now; the title-render template change waits for Aug-14.

2. **Item 18 — Remaining 46 under-floor SVGs → O2 flat-vector.** Groomed 2026-08-02, READY TO RUN, campaign-safe, parked after SW-1 per Paul — full scope in the archive @L693. Extends the decided O2 system (ADR 30.09; no new Paul style call needed); template = the 22 already-converted FLAT/PASS SVGs; spec = `.okf/design/house-visual-spec.md` "v3 exhibit spec" (W=720, 5-rung scale, basis rung ≥17px). Gate per batch: `bin/check-svg-floor` + scroll gate both viewports.

3. **Item 13 — W4: V3-B wiring + media P1 (post-Aug-14).** New course-single.css + single.html, walkthrough visual hooks, 1.2/1.3/1.5 mid-body visuals, 5.7 mermaid horizontal, TL;DR accent. Carries the W2 input: responsive-table treatment (`overflow-x:auto` containers) fixing the 390px overflow on the two dense reference pages. Full visual pair at PR prep. Archive @L295.

4. **Item 7 — Wave G Batch 2 (blog): sla-checklist, cheap-developers, admin-panel-spaceship.** Written + critic-fixed on branch `blog-waveg-batch2`; needs covers + publish gate → draft:false → ONE PR closes the wave. NOTE: 20.09's P0 content gate applies — confirm with the content plan before publishing. LinkedIn briefs stay DRAFTS-ONLY for Paul.

## Parked / postponed (not blocking, revisit on trigger)

- **Item 14 — reader-mode readability research** (POSTPONED by Paul 2026-08-02; also tracked as the 2604 reader-mode item — 2605 owns it). Archive @L819.
- **External validation pilot** — post-course-completion only; kit at `40-49-review/40.18-external-validation-pilot-kit.md`. "Pilot" in-session = INTERNAL template review (see editing policies).

## Done (pointer)

W1-W5 + rollout + Wave 0/A-H + M1-M5 media waves + G1-G3 growth waves — all in the archive with retrospectives. Wave plan: [`20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md`](20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md) (CLOSED 2026-08-02).
