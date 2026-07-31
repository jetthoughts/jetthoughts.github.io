---
type: Playbook
title: CI gates (GitHub Actions)
description: PR CI runs Hugo build, unit tests, a path-scoped broken-internal-link crawl (lychee), and a report-only visual gate on the pinned rendering stack. Sync fan-out is gated - no-op sync runs deploy nothing.
tags: [ci, github-actions, testing, link-check]
resource: .github/workflows/link-check.yml
timestamp: 2026-07-31T16:30:00Z
---

# What CI enforces on a PR

| Check | Workflow | Runs |
|---|---|---|
| `build_and_deploy / build` | `publish.yml` | Every push/PR; Hugo build (deploy only on master) |
| `Unit Tests` (`rake test:unit`) | `publish.yml` | Every push/PR - `test:critical` does NOT include the unit suite, so this is a separate gate |
| `Broken Internal Links` (`rake test:links`, lychee) | `link-check.yml` | PRs only when link-relevant paths change; always on nightly schedule / push to master / manual |

Plus two piggybacked on the unit_tests job: `bin/lint-css` (stylelint
warning ratchet) and `test/unit/toolchain_pins_test.rb` (toolchain drift
gate). See local pre-PR gates in [test-gates.md](test-gates.md).

# Toolchain single source of truth

`.mise.toml` pins hugo/bun/node/ruby (local install via `mise install`;
`bin/setup` wraps it + doctor). CI copies of the pins live in
`.github/actions/setup-hugo/action.yml` (hugo default, bun-version,
node-version), workflow `ruby-version` inputs, and the `.dev/compose.yml`
image tag; the drift test fails the build when any copy diverges - update
them together. `_hugo.yml` must NOT carry its own pins (it calls the
composite with `build: 'false'`); the drift test enforces that too.
Gotchas: the Ruby pin must be an EXACT patch version - rbenv reads
`.ruby-version` and never matches a fuzzy "4.0"; agent containers block
`api.github.com` through the proxy, so `mise install` cannot fetch
hugo/bun there (node works - nodejs.org is allowed).

# link-check.yml path filter

Native `on.pull_request.paths` (no hand-rolled gate step). The crawl fires on a PR only when a change can move an internal link:
`content/**`, `themes/**/layouts/**`, `config/**`, `data/**`, `lychee.toml`, `Rakefile`, `.github/actions/setup-hugo/**`, `Gemfile`, `Gemfile.lock`.
A CSS/test/docs-only PR does not trigger it. Non-PR events carry no `paths` filter, so nightly/push/manual always run for full master coverage.

Caveat: with native `paths`, a filtered-out PR reports NO check (not a passing one). Fine unless `link_check` becomes a *required* status check - then add a skip-reporting companion job.

# Visual regression is NOT a CI gate today - but the historical blocker is gone

A CI screenshot job (`quick_test` + `bin/qtest`) was built and removed in PR #386. At the time the divergence was unfixable: baselines were captured on the then-Alpine/musl docker image while CI runs Ubuntu (glibc), and text rendered differently enough that measured divergence ran **3-28%** (mobile code blocks 0.28, plain content pages up to 0.21) - far above any tolerance that still catches a real regression.

**That premise no longer holds (DevX Phase 4, 2026-07-30):** the `.dev/Dockerfile` image moved to Debian/glibc with a pinned Chrome for Testing (`.dev/cft-version`) + deterministic fontconfig (`.dev/fonts.conf`) + pinned Noto fonts, and `bin/setup-test-env` installs the identical stack on any bare-metal glibc host - including GitHub's Ubuntu runners.

**Re-introduced (DevX R2 Phase B, 2026-07-31):** `test.yml` now runs the critical screenshot suite on `pull_request` (paths-filtered to visual surfaces), provisioned via `bin/setup-test-env` so runner pixels match `linux/` baselines. Currently REPORT-ONLY (`continue-on-error: true` - failures upload the snap_diff report and comment the PR); flip that flag off after a clean soak week to make it blocking. Record mode (`workflow_dispatch` + update-baselines) records on the same pinned stack. Local gates in [test-gates.md](test-gates.md) (`bin/test` macOS, `bin/dtest` docker-linux) remain the pre-PR discipline.

Two gotchas the first record run hit (both fixed; evidence: [run 30629929407](https://github.com/jetthoughts/jetthoughts.github.io/actions/runs/30629929407) - 104 screenshots compared clean, 4 test failures, commit step never ran). Keep in mind for any new CI test job:
- **Draft fixtures**: screenshot tests visit the draft post `/blog/codeblock-styles-fixture/`; local builds pass `--buildDrafts` but `bin/hugo-build` only does so when `BUILD_DRAFTS` is set - test.yml sets `BUILD_DRAFTS: '1'` on its setup-hugo step. A CI test build without it 404s the fixture and fails the codeblock tests on every run.
- **fail_if_new in CI**: snap_diff hard-errors on missing baselines when `ENV["CI"]` is set. Record mode (`FORCE_SCREENSHOT_UPDATE=true`) disables `fail_on_difference` AND `fail_if_new` (setup_snap_diff.rb) so pages added since the last recording can get their FIRST baseline.

# R3-2 correctness + cost fixes (2026-07-31)

- **hugo_stats.json cache is EXACT-key-only** (own cache entry in
  setup-hugo, no restore-keys). The warm-up skip trusts any non-empty stats
  file; a restore-keys partial hit could restore a STALE stats file from an
  older tree and PurgeCSS would purge live classes (the .sr-only incident
  class re-opened via cache). Exact hit = identical source tree = valid
  stats; any change pays the ~52s warm-up instead. Never add restore-keys
  back to that entry.
- **`_dest` is not cached** - it uploaded ~1-2 GB/job and evicted every
  other cache from the 10 GB repo quota; the build regenerates it anyway.
- **Sync fan-out gate**: publish.yml + link-check.yml `workflow_run` jobs
  run only when `github.event.workflow_run.head_sha != github.sha`
  (for workflow_run events github.sha = current default-branch head; the
  sync pushing a commit is exactly what moves them apart). "Sync articles"
  fires every 10 min 8-21 UTC but usually commits nothing - that was ~84
  no-op deploy+test cascades/day.
- **link-check builds ONCE**: setup-hugo runs with `build: 'false'`;
  `rake test:links` does its own production build. The double build blew
  the job's 10-min timeout on cold caches (seen on PR #422).
- **test.yml checks out the PR MERGE commit** (default checkout) for
  pull_request events; only record dispatches check out the branch ref
  (needed to push the baseline commit). head_ref checkout tested the tip
  without the base merged and breaks fork PRs.
- **Record commits survive red tests**: record runs `rake test:system`
  only (a unit failure used to discard 15+ min of recording), and the
  commit step is `always()`-gated + porcelain-guarded, so recorded PNGs
  land even when one page's test fails.

# libvips gotcha (if a CI job ever needs ruby-vips again)

ruby-vips' `:vips` driver `dlopen`s `libvips.so.42` at runtime, which ships in the **libvips42** runtime package - NOT `libvips-dev` (headers only). Install `libvips42` + run `ldconfig`. snap_diff swallows the real `LoadError` behind generic per-screenshot errors, so verify the load explicitly (`ruby -e 'require "vips"'`).
