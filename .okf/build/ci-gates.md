---
type: Playbook
title: CI gates (GitHub Actions)
description: PR CI runs Hugo build, unit tests, and a path-scoped broken-internal-link crawl (lychee). Visual regression is not in CI yet - the old cross-OS blocker is gone (pinned glibc stack); re-introduction planned as DevX R2 Phase B.
tags: [ci, github-actions, testing, link-check]
resource: .github/workflows/link-check.yml
timestamp: 2026-07-31T00:00:00Z
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

# libvips gotcha (if a CI job ever needs ruby-vips again)

ruby-vips' `:vips` driver `dlopen`s `libvips.so.42` at runtime, which ships in the **libvips42** runtime package - NOT `libvips-dev` (headers only). Install `libvips42` + run `ldconfig`. snap_diff swallows the real `LoadError` behind generic per-screenshot errors, so verify the load explicitly (`ruby -e 'require "vips"'`).
