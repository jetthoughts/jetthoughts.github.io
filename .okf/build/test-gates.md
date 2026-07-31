---
type: Playbook
title: Test gates and when they block commits
description: bin/qtest --changed is the routine gate; bin/rake test:critical at milestones; bin/test AND bin/dtest once at PR prep (or on explicit confirmation) for themes/, layouts/, or CSS changes.
tags: [testing, visual-regression, gates]
timestamp: 2026-07-31T15:00:00Z
---

# The suites

| Command | What it is | When required |
|---|---|---|
| `bin/qtest --changed` | Scoped visual gate: builds once (~11s), runs ONLY affected pages' desktop+mobile screenshot tests (~2.5s each) + orphan guard + color-system check; site-wide/unmapped files auto-escalate to the full critical suite | Per micro-commit inside a sprint (~25-60s); NOT a substitute for the milestone/PR gates below |
| `bin/rake test:critical` | Critical Minitest suite (46 runs / 84 screenshots) | At component/task milestones and before every commit outside sprint micro-commit trains |
| `bin/test` | Visual regression on the host (baselines in `macos/` on a Mac; on Linux, comparable to `linux/` when run through `bin/setup-test-env`'s pinned stack) | ONCE at PR prep (branch head, before `gh pr create`) or on Paul's explicit confirmation - NOT per commit (Paul 2026-07-31: qtest is the routine gate) |
| `bin/dtest` | Same suite in Linux/Docker (baselines in `linux/`) - CI runs Linux | Same trigger as bin/test; a PR must never open without this leg (green-locally / red-in-CI otherwise) |

`bin/qtest` page keys mirror `themes/beaver/assets/css/pages/*.css` basenames
AND `critical/<name>-critical.css` basenames - the two sets differ (e.g.
`privacy-policy-critical.css` needs its own key even though the page CSS key
is `simple-page`); the changed-file→page map lives in the script itself -
extend it when adding components or critical files. The macOS full suite remains the only dedup-trap catcher
(Linux font resolution masks it) - never finish a component on qtest alone.

# Hard-won caveats

- **Content-only diffs skip the visual suites entirely** (Paul 2026-07-31).
  A change touching ONLY markdown prose/frontmatter - no `themes/`, no
  `layouts/`, no `*.css`, no inline HTML/SVG in a body - is gated by
  `bin/hugo-build` (validators + ratchet) plus the rendered scroll gate on
  the edited pages. qtest already self-reports "no visual-affecting changes"
  for these. Decide from the actual diff, not the task name: one inline SVG
  or one template touch re-arms the full gate.
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
- CI DOES run screenshot diffs since 2026-07-31 (PRs #413/#417): test.yml
  installs the pinned rendering stack (bin/setup-test-env: CfT per
  .dev/cft-version + fonts.conf) so the runner renders the same pixels as
  the `linux/` baselines - the old Alpine/musl-vs-glibc 3-28% divergence
  argument no longer applies (image is Debian/glibc since #403). The PR
  gate is REPORT-ONLY during the soak week; details in
  [ci-gates.md](ci-gates.md).
- All four runners (test/qtest/dtest/dtest-all) build through
  `bin/build-if-stale <dest>` - it routes via bin/hugo-build (PurgeCSS
  cold-start warm-up guard; a bare `hugo` call can purge live classes on a
  fresh clone) and skips on a warm tree. qtest and bin/test share
  `_dest/public-test`, so a qtest right after a bin/test run costs 0s of
  build. `FORCE_BUILD=1` (or bin/test `--build`) forces. The staleness
  probe watches content/ themes/ layouts/ config/ data/ assets/ static/
  postcss.config.js package.json bun.lockb.
- `bin/qtest --changed` counts UNTRACKED files (git ls-files --others):
  before 2026-07-31 a brand-new pages/foo.css produced "no visual-affecting
  changes" and a false green exit 0.
- The `.gitignore` `.*` rule silently keeps NEW dot-directories out of the
  repo unless negated (`!.githooks`, `!.mise.toml`, `!.claude/settings.json`
  all needed this). The R2 pre-push hook shipped bin/setup wiring for
  `core.hooksPath .githooks` while the hook file itself never made it into
  the repo - fresh clones had a hooksPath pointing at nothing. Adding any
  root dotfile/dot-dir? Check `git check-ignore -v <path>` before assuming
  it's tracked.
