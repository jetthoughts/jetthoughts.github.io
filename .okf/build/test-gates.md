---
type: Playbook
title: Test gates and when they block commits
description: bin/qtest --changed per micro-commit; bin/rake test:critical + bin/test AND bin/dtest at milestones and before every PR for themes/, layouts/, or CSS changes.
tags: [testing, visual-regression, gates]
timestamp: 2026-07-21T00:00:00Z
---

# The suites

| Command | What it is | When required |
|---|---|---|
| `bin/qtest --changed` | Scoped visual gate: builds once (~11s), runs ONLY affected pages' desktop+mobile screenshot tests (~2.5s each) + orphan guard + color-system check; site-wide/unmapped files auto-escalate to the full critical suite | Per micro-commit inside a sprint (~25-60s); NOT a substitute for the milestone/PR gates below |
| `bin/rake test:critical` | Critical Minitest suite (46 runs / 84 screenshots) | At component/task milestones and before every commit outside sprint micro-commit trains |
| `bin/test` | Visual regression on macOS host (baselines in `test/fixtures/screenshots/macos/`) | Any edit to `themes/`, `layouts/`, `*.css`, or post body HTML - at minimum per component milestone + branch head before PR |
| `bin/dtest` | Same suite in Linux/Docker (baselines in `linux/`) - CI runs Linux | Same trigger as bin/test; skipping it ships green-locally / red-in-CI |

`bin/qtest` page keys mirror `themes/beaver/assets/css/pages/*.css` basenames;
the changed-file→page map lives in the script itself - extend it when adding
components. The macOS full suite remains the only dedup-trap catcher
(Linux font resolution masks it) - never finish a component on qtest alone.

# Hard-won caveats

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
- Tests must assert behavior shape (`q=\d+`, has `<picture>`), never tunable
  config values (exact quality/width numbers).
- Visual regression is a LOCAL gate only. CI does NOT run screenshot diffs -
  cross-OS pixel comparison is unusable (Alpine/musl baselines vs Ubuntu/glibc
  CI diverge 3-28%), so `bin/test` + `bin/dtest` are the sole visual coverage.
  What CI enforces (build, unit, link check) lives in [ci-gates.md](ci-gates.md).
