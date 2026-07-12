---
type: Playbook
title: Test gates and when they block commits
description: bin/rake test:critical always; bin/test AND bin/dtest are both mandatory for any themes/, layouts/, or CSS change.
tags: [testing, visual-regression, gates]
timestamp: 2026-07-13T00:00:00Z
---

# The three suites

| Command | What it is | When required |
|---|---|---|
| `bin/rake test:critical` | Critical Minitest suite (46 runs / 84 screenshots) | After every change, before every commit |
| `bin/test` | Visual regression on macOS host (baselines in `test/fixtures/screenshots/macos/`) | Any edit to `themes/`, `layouts/`, `*.css`, or post body HTML |
| `bin/dtest` | Same suite in Linux/Docker (baselines in `linux/`) - CI runs Linux | Same trigger as bin/test; skipping it ships green-locally / red-in-CI |

# Hard-won caveats

- The snapshot tool REWRITES baselines when a run passes. Never edit CSS
  while a suite is running - a raced run once saved a corrupt baseline
  missing its hero image. Catch with pixel-compare, restore via `git checkout`.
- Visual failures are commit blockers, not warnings. Either fix the
  regression or update BOTH baseline dirs (macos/ and linux/) in the same
  commit with the intentional change.
- Content-only + standalone-SVG waves need only
  [bin/hugo-build](/build/hugo-build.md) + `test:critical`.
- Docker runs via Colima; fresh worktrees need `bun install` first.
- Tests must assert behavior shape (`q=\d+`, has `<picture>`), never tunable
  config values (exact quality/width numbers).
