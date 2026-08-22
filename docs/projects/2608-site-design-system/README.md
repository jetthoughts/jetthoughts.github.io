# 2608 - Site design system (v2 clean-slate)

**Paused 2026-08-22, mid-flight. Start here.**

## Where the work stands in one paragraph

The legacy CSS was recovered from an obfuscated export and fights every change,
so v2 is being built clean on a noindexed `/next/` rail and cut over page by
page (ADR-0006). Three visual registers were built as full landing pages,
compared under controlled conditions, and voted on. Then the positioning
changed underneath them: the site now sells one offer and bans title claims, so
the pilots' copy has been rewritten but not yet applied. Nothing is blocked on
engineering - it is blocked on five decisions from Paul.

## Read in this order

| Doc | What it holds |
|---|---|
| `20-29-strategy/20.06-clean-slate-v2-plan.md` | **The plan of record + the COLD-SESSION STATE LEDGER.** Every row's status. Read the ledger first. |
| `20-29-strategy/20.09-repositioned-pilot-copy.md` | **The next task.** Repositioned copy, drafted and canon-verified, with a step-by-step apply checklist. |
| `20-29-strategy/20.08-register-demo-board.md` | The three pilots, the panel ballots, the recommendation, the decision protocol. |
| `10-19-research/10.01-design-register-research-2026-08-reference.md` | Why these three registers, the external research, the candidate table. |
| `../../adr/0006-clean-slate-dual-run.md` | The dual-run mechanism, supersession scope, flip checklist, sunset condition. |

## The five decisions waiting on Paul

1. **Pick the register** on the live pilots. Panel first choices: B 2 / C 1 / A 1;
   restricted to the two Claude Design artifact sets it is Editorial 4-1;
   recommendation is Editorial plus grafts (Precision's ledger table for data
   surfaces, Rescue Room's mobile rhythm patterns).
2. **Three claims**, all currently cut from the page: "the repo stays in your
   account", "starts in days", "no equity, no lock-in".
3. **Which page ships first** - homepage, or a standalone offer page. Under
   one-offer positioning these largely collapse into the same page.
4. **The legacy fractional-CTO sweep.** Those pages carry a claim now ruled
   inaccurate, today. `/services/fractional-cto/` has ranking history, so this
   needs a GSC check, not a deletion.
5. **Whether the ~2026-09-17 homepage measurement gate should fall**, given the
   homepage is being repositioned anyway.

## Live artifacts

Pilots (noindexed staging, on production once deployed):
`/next/pilots/{rescue-room,editorial,precision}/fractional-cto/` - renaming to
`/embedded-team/` when 20.09 is applied.

Claude Design projects (Paul's, external): `8eb98dd6-e460-469c-a43c-93fdc3f8592e`
holds the Editorial service page **and the homepage blueprint**;
`3dc819cf-084f-4dd6-b7aa-7275c2424e68` holds the Rescue Room service page.
The homepage blueprint has two open problems: its "Three ways in" section lists
three offers (one a banned title claim), and its audit exhibit is presented as
"from a real one, redacted" without a named source.

## Known red, do not re-record blindly

`linux/mobile/blog/index/_pagination` fails at difference_level
`0.03960763888888889`, **identical across two runs** - which by this repo's own
rule means a stale committed baseline, not flake. It survived the #566
re-record. Diff the `workflow_dispatch` record path against the `pull_request`
test path before touching it; the suspicion is they build the page differently
and blog-index pagination is driven by the post count. Details in `.okf/log.md`.

## What the sprint shipped (PRs #560-#567, 2026-08-21)

Visual gate un-blinded (#560) and 127 baselines re-recorded with the tolerance
shield deleted on a measurement (#566) - the macOS suite is green for the first
time since #540, and CI Linux red went from 22 keys to 1. Three register pilots
(#561-#563) with a cross-pilot specificity fix (#564), the demo board (#565),
and the session's working papers (#567).
