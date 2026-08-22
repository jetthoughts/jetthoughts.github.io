# Status — what's in flight

> Cold-start surface. One screen: goals, WIP, blockers. Links carry the detail —
> this file never duplicates project state, it points at it.
> **Update rule**: any session that changes what's in flight (starts/finishes/parks
> a workstream, ships a PR, hits a blocker) updates this file in the same commit/PR.

## Goals

- **Company goals / OKR / weekly numbers**: vault `~/Documents/pkm/jt-operations.md` (host-only — vault owns operations; this repo carries growth/marketing execution).
- **Bet of record**: Vibe Code Rescue — **parked until Sept 2026**; bet state in vault `jt-vcr-runbook.md`, campaign artifacts in [`docs/projects/2607-vibe-code-rescue/`](docs/projects/2607-vibe-code-rescue/backlog.md).
- **Content plan of record**: [`20.09 content plan (Aug 2026)`](docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md).

## Now / WIP

| Workstream | State | Next step | Entry point |
|---|---|---|---|
| 2608 site design system (v2 `/next/` rail) | Paused 2026-08-22 mid-flight; 3 pilots built + voted | Apply 20.09 repositioned copy; then Paul's 5 decisions | [`2608 README`](docs/projects/2608-site-design-system/README.md) |
| Blog / SEO (2510) | Active — descriptions done, R-queue restocked from live GSC (2026-08-21) | Next post from the R-queue | [`tracker`](docs/projects/2510-seo-content-strategy/GOAL-AT-A-GLANCE.md) |
| 2605 course | v2 live; measuring. Diagnosis: **arrival, not content** (GSC/GA/Clarity triple-read 2026-08-20) | Arrival/discovery actions per 50.05; no new funnel posts on the unproven bridge | [`TASK-TRACKER`](docs/projects/2605-tech-for-non-technical-founders/TASK-TRACKER.md) |
| LinkedIn ICP-E campaign | Drafts only (16 drafts, UTM-tagged); no publishing | Draft per plan when asked | [`plan`](docs/workflows/linkedin-icp-validation-plan.md) |
| 2607 campaign tasks | Bet parked; sourcing tooling unblocked 2026-08-20 | P7 date-filtered sweep re-run | [`2607 backlog`](docs/projects/2607-vibe-code-rescue/backlog.md) |
| Test/CI hygiene | One known red (stale linux baseline, see 2608 README §Known red) | Diff record-vs-test build paths before re-recording | [`test-gates`](.okf/build/test-gates.md) |

**Not in flight**: 2604 typography — closed 2026-08-08 (P2 leftovers re-homed). 2509 CSS migration — Phase C complete 2026-07-19, Phase D backlog dormant; the 2608 clean-slate rail is the live CSS strategy ([ADR-0006](docs/adr/0006-clean-slate-dual-run.md)).

## Blocked on Paul

| What | Where the full ask lives |
|---|---|
| Five 2608 decisions (register pick, 3 claims, first page, legacy CTO sweep, Sept measurement gate) | [`2608 README`](docs/projects/2608-site-design-system/README.md) |
| Three 2605 fabricated-fact findings (five-tech-words client claim, $78K/$400 story, SVG chart stats) | [`2605 TASK-TRACKER`](docs/projects/2605-tech-for-non-technical-founders/TASK-TRACKER.md) §Aug-20 sweep |
| LinkedIn metrics-ledger row for the 2026-08-13 post (empty past the 48-72h window) | `linkedin-posts/metrics-ledger.md` |
| 2607 T3 (Gmail warm-source consent) + T10 (split strategy docs, [#449](https://github.com/jetthoughts/jetthoughts.github.io/issues/449)) | [`2607 backlog`](docs/projects/2607-vibe-code-rescue/backlog.md) |

Last updated: 2026-08-22
