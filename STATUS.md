# Status — what's in flight

> Cold-start surface. One screen: goals, WIP, blockers. Links carry the detail —
> this file never duplicates project state, it points at it.
> **Update rule**: any session that changes what's in flight (starts/finishes/parks
> a workstream, ships a PR that changes a workstream's state, hits a blocker)
> updates this file in the same commit/PR.
> **When updating: verify against the artifact (the ledger, the file, the PR), never
> a tracker line — trackers rot, and this file must not inherit their staleness.**

## Goals

- **Company goals / OKR / weekly numbers**: vault `~/Documents/pkm/jt-operations.md` (host-only — vault owns operations; this repo carries growth/marketing execution).
- **Bet of record**: Vibe Code Rescue — **Parked until Sept 2026** per the repo mirror [`docs/business/index.md`](docs/business/index.md) (vault `jt-vcr-runbook.md` is authoritative); campaign artifacts in [`docs/projects/2607-vibe-code-rescue/`](docs/projects/2607-vibe-code-rescue/backlog.md).
- **Content plan of record**: [`20.09 (Aug 2026)`](docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md) — its §1 governing constraint: **outreach outranks new posts**.

## Now / WIP

| Workstream | State | Next step | Entry point |
|---|---|---|---|
| LinkedIn (primary demand lane) | **LIVE** — 3 posts published (2026-08-13/18/19), first metrics read 2026-08-20; ICP-E lane on disk: 1 posted + 4 approved (of 10 planned), validation clock running | Post an approved draft (week1-tue / week1-wed) at Stream 0 cadence (3-4/wk) | [`metrics-ledger`](linkedin-posts/metrics-ledger.md) · [`plan`](docs/workflows/linkedin-icp-validation-plan.md) |
| 2608 site design system (v2 `/next/` rail) | Paused 2026-08-22 mid-flight; 3 pilots built + voted | Apply the [repositioned pilot copy](docs/projects/2608-site-design-system/20-29-strategy/20.09-repositioned-pilot-copy.md) (2608's own 20.09 — not the content plan); then Paul's 5 decisions | [`2608 README`](docs/projects/2608-site-design-system/README.md) |
| Blog / SEO (2510) | Constrained by 20.09 §1 (outreach first). R-queue empty/retired; replacement queue is §13 (restocked 2026-08-21) | Per §1: LinkedIn cadence + sourcing outrank a new post; when drafting, take §13 N-queue | [`20.09 §13`](docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md) |
| 2605 course | v2 live; measuring. Diagnosis: **arrival, not content**; course SEO/AEO **closed** (Paul 2026-08-21) | LinkedIn arrival-test cards **LI-0…LI-D** in [`content-plan`](linkedin-posts/content-plan.md); no new funnel posts on the unproven bridge | [`TASK-TRACKER`](docs/projects/2605-tech-for-non-technical-founders/TASK-TRACKER.md) |
| 2607 campaign tasks | Cold-public-sourcing premise tested and **failed** (3 sweeps, 4 venues, 0 verified-fresh rows; Reddit still un-openable) | Sept-restart Paul decision: retire the cold lane or buy Reddit API access (backlog §c) | [`2607 backlog`](docs/projects/2607-vibe-code-rescue/backlog.md) |
| Test/CI hygiene | **Gates rebuilt 2026-08-22.** Fault-injecting 8 realistic defects caught **3**; now catches **8** ([#576](https://github.com/jetthoughts/jetthoughts.github.io/pull/576), audit in [`20.11`](docs/20-29-testing-qa/20.11-gate-fault-injection-2026-08-22-reference.md)). Link job was excluding 90% of links — 114,050 checked now vs 15,642, and it found 5 real site defects ([#574](https://github.com/jetthoughts/jetthoughts.github.io/pull/574)). `bin/dtest` was comparing **nothing** from a worktree ([#578](https://github.com/jetthoughts/jetthoughts.github.io/pull/578)). CI Linux screenshot job green (run 32565008850) | **Paul decides the dtest arch policy** (below); otherwise nothing queued | [`test-gates`](.okf/build/test-gates.md) |
| Rendering stack → **all-ARM** | **In flight — [#589](https://github.com/jetthoughts/jetthoughts.github.io/pull/589) open.** Paul chose Beta over waiting for Stable (2026-08-21), so CfT pins `153.0.8010.5` (first with `linux-arm64`), container runs native arm64, CI on `ubuntu-24.04-arm`. Non-visual CI green; **Screenshot Tests red is expected** — `linux/` baselines are amd64/Chrome-152 recordings of pre-[#583](https://github.com/jetthoughts/jetthoughts.github.io/pull/583) content | Merge #589 → dispatch `update-baselines` **on master** (recorder and tester must see one tree) → local `bin/dtest` to settle whether the 8 codeblocks keys were ever distro-caused | [`rendering-stack`](.okf/build/rendering-stack.md) |

**Not in flight**: 2604 typography — closed 2026-08-08 (P2 leftovers re-homed). 2509 CSS migration — **project complete 2026-07-19** (tracker in maintenance mode; the dormant remainder is the Phase-E groomed backlog + trigger-conditioned items); the 2608 clean-slate rail is the live CSS strategy ([ADR-0006](docs/adr/0006-clean-slate-dual-run.md)).

## Blocked on Paul

| What | Where the full ask lives |
|---|---|
| Five 2608 decisions (register pick, 3 claims, first page, legacy CTO sweep, Sept measurement gate) | [`2608 README`](docs/projects/2608-site-design-system/README.md) |
| **Joy Adamson override** (1 min; Paul's one override candidate from outreach batch 1, still publicly unanswered) | [`20.09 §1`](docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md) desk table + 2607 backlog card #12 |
| Three 2605 fabricated-fact findings (five-tech-words client claim, $78K/$400 story, SVG chart stats) | [`2605 TASK-TRACKER`](docs/projects/2605-tech-for-non-technical-founders/TASK-TRACKER.md) §Aug-20 sweep |
| 2607 T3 (Gmail warm-source consent) + T10 (split strategy docs, [#449](https://github.com/jetthoughts/jetthoughts.github.io/issues/449)) | [`2607 backlog`](docs/projects/2607-vibe-code-rescue/backlog.md) |

Last updated: 2026-08-22
