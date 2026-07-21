---
type: Playbook
title: CI gates (GitHub Actions)
description: PR CI runs Hugo build, unit tests, and a path-scoped broken-internal-link crawl (lychee). Visual regression is deliberately NOT in CI - cross-OS pixel diffs are unusable; it stays on the local bin/test + bin/dtest gates.
tags: [ci, github-actions, testing, link-check]
resource: .github/workflows/link-check.yml
timestamp: 2026-07-21T00:00:00Z
---

# What CI enforces on a PR

| Check | Workflow | Runs |
|---|---|---|
| `build_and_deploy / build` | `publish.yml` | Every push/PR; Hugo build (deploy only on master) |
| `Unit Tests` (`rake test:unit`) | `publish.yml` | Every push/PR - `test:critical` does NOT include the unit suite, so this is a separate gate |
| `Broken Internal Links` (`rake test:links`, lychee) | `link-check.yml` | PRs only when link-relevant paths change; always on nightly schedule / push to master / manual |

Three lean gates. See local pre-PR gates in [test-gates.md](test-gates.md).

# link-check.yml path filter

Native `on.pull_request.paths` (no hand-rolled gate step). The crawl fires on a PR only when a change can move an internal link:
`content/**`, `themes/**/layouts/**`, `config/**`, `data/**`, `lychee.toml`, `Rakefile`, `.github/actions/setup-hugo/**`, `Gemfile`, `Gemfile.lock`.
A CSS/test/docs-only PR does not trigger it. Non-PR events carry no `paths` filter, so nightly/push/manual always run for full master coverage.

Caveat: with native `paths`, a filtered-out PR reports NO check (not a passing one). Fine unless `link_check` becomes a *required* status check - then add a skip-reporting companion job.

# Visual regression is intentionally NOT a CI gate

A CI screenshot job (`quick_test` + `bin/qtest`) was built and removed in PR #386. Cross-OS pixel diffing is unusable: baselines are captured on the docker gate (Alpine/musl, aarch64) but CI runs Ubuntu (glibc, x86_64), and text renders differently enough that measured divergence ran **3-28%** (mobile code blocks 0.28, plain content pages up to 0.21) - far above any tolerance that still catches a real regression. Loosening tolerance to absorb it makes the gate blind; a same-container approach or a third Ubuntu baseline set costs more than it returns given two mandatory same-OS gates already cover it.

Visual regression therefore stays on the local gates in [test-gates.md](test-gates.md): `bin/test` (macOS) + `bin/dtest` (docker-linux). CI catches build breakage, unit failures, and broken internal links only.

# libvips gotcha (if a CI job ever needs ruby-vips again)

ruby-vips' `:vips` driver `dlopen`s `libvips.so.42` at runtime, which ships in the **libvips42** runtime package - NOT `libvips-dev` (headers only). Install `libvips42` + run `ldconfig`. snap_diff swallows the real `LoadError` behind generic per-screenshot errors, so verify the load explicitly (`ruby -e 'require "vips"'`).
