---
type: Playbook
title: Test gates and when they block commits
description: bin/qtest --changed is the routine gate; bin/rake test:critical at milestones; bin/test AND bin/dtest once at PR prep (or on explicit confirmation) for themes/, layouts/, or CSS changes.
tags: [testing, visual-regression, gates]
timestamp: 2026-07-31T00:00:00Z
---

# The suites

| Command | What it is | When required |
|---|---|---|
| `bin/qtest --changed` | Scoped visual gate: builds once (~11s), runs ONLY affected pages' desktop+mobile screenshot tests (~2.5s each) + orphan guard + color-system check; site-wide/unmapped files auto-escalate to the full critical suite | Per micro-commit inside a sprint (~25-60s); NOT a substitute for the milestone/PR gates below |
| `bin/rake test:critical` | Critical Minitest suite (46 runs / 84 screenshots) | At component/task milestones and before every commit outside sprint micro-commit trains |
| `bin/test` | Visual regression on macOS host (baselines in `test/fixtures/screenshots/macos/`) | ONCE at PR prep (branch head, before `gh pr create`) or on Paul's explicit confirmation - NOT per commit (Paul 2026-07-31: qtest is the routine gate) |
| `bin/dtest` | Same suite in Linux/Docker (baselines in `linux/`) - CI runs Linux | Same trigger as bin/test; a PR must never open without this leg (green-locally / red-in-CI otherwise) |

`bin/qtest` page keys mirror `themes/beaver/assets/css/pages/*.css` basenames;
the changed-file→page map lives in the script itself - extend it when adding
components. The macOS full suite remains the only dedup-trap catcher
(Linux font resolution masks it) - never finish a component on qtest alone.

# Hard-won caveats

- snap_diff compares against **git HEAD, not the working tree** (working tree
  = candidate, HEAD = baseline). Consequences: (a) an un-committed "accepted"
  baseline changes NOTHING - the run still compares against HEAD and fails
  identically; (b) the diagnosis tell for a stale committed baseline is an
  IDENTICAL difference_level across runs (a flaky render would vary);
  (c) a merged PR that shifts layout without re-recording baselines makes
  every later local run red until someone re-records (2026-07-31: #405's
  28px mobile hero gap shipped with a commit-message note instead of updated
  baselines - cost a full false "bistable render" investigation). Re-record =
  run the suite, keep the rewritten PNG, COMMIT it; only then can a rerun go
  green.
- `ALLOW_DIRTY_SCREENSHOTS=1` does NOT propagate into the bin/dtest Docker
  container - the dirty-fixtures guard aborts inside the container with only
  "Tasks: TOP => test:critical" in the tail (2026-07-31: cost two aborted-run
  investigations). With dtest the only path is the designed one: COMMIT the
  intended baselines first, then run on a clean tree.
- The snapshot tool REWRITES baselines when a run passes. Never edit CSS
  while a suite is running - a raced run once saved a corrupt baseline
  missing its hero image. Catch with pixel-compare, restore via `git checkout`.
- Visual failures are commit blockers, not warnings. Either fix the
  regression or update BOTH baseline dirs (macos/ and linux/) in the same
  commit with the intentional change.
- Content-only + standalone-SVG waves need
  [bin/hugo-build](/build/hugo-build.md) + `test:critical` + the
  [visual scroll gate](/workflows/render-verification.md) on edited pages -
  the command matrix above is not the complete gate on its own.
- Changes to `lib/` (validators, helpers) additionally require
  `bundle exec rake test:unit` - CI runs the unit suite and `test:critical`
  does NOT include it (2026-07-17: a validator change shipped green locally,
  red in CI, because its unit fixture was never run).
- Docker runs via Colima; fresh worktrees need `bun install` first.
- `bin/docked`/`bin/dc` need bash, not sh: `set -o pipefail` is a bashism -
  dash (Linux /bin/sh) rejected it and silently broke `bin/dtest` on every
  Linux host until 2026-07-30 (shebangs fixed to bash). Remote/agent
  containers additionally cannot pull Docker Hub base images through the
  agent proxy (blob CDN 403) - there, prove template neutrality with a
  full-build HTML diff instead of dtest.
- Stylelint ratchet: `bin/lint-css` caps the no-duplicate-selectors warning
  backlog (--max-warnings); CI runs it in the unit_tests job. Lower the cap
  in the same commit that fixes duplicates - it only goes down.
- Tests must assert behavior shape (`q=\d+`, has `<picture>`), never tunable
  config values (exact quality/width numbers).
- Visual regression is a LOCAL gate only. CI does NOT run screenshot diffs -
  cross-OS pixel comparison is unusable (Alpine/musl baselines vs Ubuntu/glibc
  CI diverge 3-28%), so `bin/test` + `bin/dtest` are the sole visual coverage.
  What CI enforces (build, unit, link check) lives in [ci-gates.md](ci-gates.md).
