---
type: Playbook
title: CI gates (GitHub Actions)
description: PR CI runs Hugo build, unit tests, a path-scoped broken-internal-link crawl (lychee), and a report-only visual gate on the pinned rendering stack. Sync fan-out is gated - no-op sync runs deploy nothing.
tags: [ci, github-actions, testing, link-check]
resource: .github/workflows/link-check.yml
generated:
  by: process:okf-migrate
  at: 2026-07-31T16:30:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-07T00:00:00Z
  - by: claude/sonnet-5
    at: 2026-08-20T00:00:00Z
---

# What CI enforces on a PR

| Check | Workflow | Runs |
|---|---|---|
| `build_and_deploy / build` | `publish.yml` | Every push/PR; Hugo build (deploy only on master) |
| `Unit Tests` (`rake test:unit`) | `publish.yml` | Every push/PR - `test:critical` does NOT include the unit suite, so this is a separate gate |
| `Broken Internal Links` (`rake test:links`, lychee) | `link-check.yml` | PRs only when link-relevant paths change; always on nightly schedule / push to master / manual |

Plus `bin/lint-css` (stylelint warning ratchet) piggybacked on the
unit_tests job. See local pre-PR gates in [test-gates.md](test-gates.md).

# Two more PR gates (added 2026-08-07)

| Check | Workflow | Runs |
|---|---|---|
| `Asset Pipeline` (`rake test:integration`) | `publish.yml` | Every push/PR |
| `rake test:html_proofer` | `link-check.yml` | Same trigger as `test:links`, same job, non-blocking |

Both were dead before this: `test:integration` ran only inside `rake test` on
push-to-master AND `skip`ped itself when the Hugo build failed (a broken build
reported green with every test skipped - now `flunk`s with the build output);
`test:html_proofer` was invoked by no workflow, hook, or script at all.

**Job runtimes are cache-dependent - budget for the cold case** (measured
2026-08-07 across three runs). `Broken Internal Links` ran 3.5 min on a warm
resource cache and **10.7 min** right after master moved and invalidated it; at
its old 10-minute timeout that run would have failed for no reason but cache
state. `Asset Pipeline` runs ~10 min (two full Hugo builds; the
dev-environment one cannot reuse the production-keyed `resources/_gen` cache),
and `actions/checkout` on this repo was observed taking **7 min** on a slow
runner - 17 min of wall clock against what was a 15-minute cap. Timeouts are
now 15 and 25. Do not trim them back toward the observed average: a gate that
flakes on timeout teaches people to ignore red, which costs more than the
runner minutes.

**Slow is not the same as stalled — check which before raising a timeout**
(2026-08-20, three occurrences in one session). `Unit Tests` failed at exactly
10m twice and `build_and_deploy / build` at 15m1s, every one of them inside
`##[group]Fetching the repository` and ending `##[error]The operation was
canceled.` — i.e. they hit the cap, they did not run long and finish. Each
plain `gh run rerun <id> --failed` then completed the SAME job in **2-3
minutes**.

So the failure mode is a checkout **hang**, not the documented slowness, and
the right response is re-run-and-verify rather than another timeout raise —
raising the cap cannot fix a step that never progresses, and would only make
each failure cost longer. Confirm before re-running by pulling the job log
(`gh api repos/<owner>/<repo>/actions/jobs/<job_id>/logs`) and looking for that
group/error pair; if the job actually got past checkout, it is a real failure
and a re-run is the wrong move.

Two things to preserve when touching either:
- **`test:links` and `test:html_proofer` share ONE rake invocation**
  (`rake test:links test:html_proofer`). Both default to the same `OUTPUT_DIR`
  and each triggers `build_for_linkcheck`, which is memoized per rake PROCESS.
  Split them into two `run:` steps and the site builds twice - the exact
  double-build that blew this job's timeout and forced `setup-hugo build: 'false'`.
- **`test:integration` gets its own job**, not a step in `unit_tests`: it drives
  two full Hugo builds of its own (~50s locally) and would push that job over
  its timeout.

Still local-only: **`rake test:guards`** runs in `.githooks/pre-push`; a PR
pushed with `SKIP_CHECKS=1` never sees it.

Full gap analysis with `lib/` coverage numbers and per-layer evidence:
`docs/20-29-testing-qa/20.10-test-coverage-gap-analysis-reference.md`.

# Toolchain single source of truth

`.mise.toml` pins hugo/bun/node/ruby (local install via `mise install`;
`bin/setup` wraps it + doctor). CI copies of the pins live in
`.github/actions/setup-hugo/action.yml` (hugo default, bun-version,
node-version), workflow `ruby-version` inputs, and the `.dev/compose.yml`
image tag. **Nothing enforces this** since the drift gate
(`test/unit/toolchain_pins_test.rb`) was deleted on 2026-08-01 as a
config-mirror anti-pattern - the copies are synced by convention now, so
update them in the same commit by hand. `_hugo.yml` must NOT carry its own
pins (it calls the composite with `build: 'false'`), also by convention.
Gotchas: the Ruby pin must be an EXACT patch version - rbenv reads
`.ruby-version` and never matches a fuzzy "4.0"; agent containers block
`api.github.com` through the proxy, so `mise install` cannot fetch
hugo/bun there (node works - nodejs.org is allowed). `bin/dc build` fails on
ARM Macs (`bin/dc` pins DOCKER_DEFAULT_PLATFORM=arm64 vs the amd64 test
services) - rebuild the test image with
`docker build -t jetthoughts.com-test:1.0.0 --platform linux/amd64 -f .dev/Dockerfile .`
after any Gemfile.lock/bun.lockb change (the image bakes gems into an
anonymous /opt/bundle volume).

# link-check.yml path filter

Native `on.pull_request.paths` (no hand-rolled gate step). The crawl fires on a PR only when a change can move an internal link:
`content/**`, `themes/**/layouts/**`, `config/**`, `data/**`, `lychee.toml`, `Rakefile`, `.github/actions/setup-hugo/**`, `Gemfile`, `Gemfile.lock`.
A CSS/test/docs-only PR does not trigger it. Non-PR events carry no `paths` filter, so nightly/push/manual always run for full master coverage.

Caveat: with native `paths`, a filtered-out PR reports NO check (not a passing one). Fine unless `link_check` becomes a *required* status check - then add a skip-reporting companion job.

# Visual regression is NOT a CI gate today - but the historical blocker is gone

A CI screenshot job (`quick_test` + `bin/qtest`) was built and removed in PR #386. At the time the divergence was unfixable: baselines were captured on the then-Alpine/musl docker image while CI runs Ubuntu (glibc), and text rendered differently enough that measured divergence ran **3-28%** (mobile code blocks 0.28, plain content pages up to 0.21) - far above any tolerance that still catches a real regression.

**That premise no longer holds (DevX Phase 4, 2026-07-30):** the `.dev/Dockerfile` image moved to Debian/glibc with a pinned Chrome for Testing (`.dev/cft-version`) + deterministic fontconfig (`.dev/fonts.conf`) + pinned Noto fonts, and `bin/setup-test-env` installs the identical stack on any bare-metal glibc host - including GitHub's Ubuntu runners.

**Dispatch record mode on YOUR BRANCH, never on master (2026-08-20).** The
record job **commits the baselines it produces** - as `github-actions[bot]`,
message `chore: update screenshot baselines [ci skip]`. Whatever ref you
dispatch is the ref it writes to, because the checkout step uses
`${{ github.event_name == 'workflow_dispatch' && github.ref || '' }}`.

So this:

```bash
gh workflow run test.yml --ref master -f screenshots=true -f update-baselines=true   # WRONG
```

pushes ~40 changed baseline PNGs straight to master with no PR and no review -
which happened on 2026-08-20 and violates the repo's branch+PR rule. Screenshot
baselines are not an exception to that rule: they are the artifact class that
can carry banned copy invisibly, since a text ratchet cannot read a PNG.

Do this instead:

```bash
gh workflow run test.yml --ref <your-branch> -f screenshots=true -f update-baselines=true
```

The bot commits to your branch, the baselines ride the PR that needed them, and
a reviewer sees the pixels change alongside the change that moved them.

**Re-introduced (DevX R2 Phase B, 2026-07-31):** `test.yml` now runs the critical screenshot suite on `pull_request` (paths-filtered to visual surfaces), provisioned via `bin/setup-test-env` so runner pixels match `linux/` baselines. Currently REPORT-ONLY (`continue-on-error: true` - failures upload the snap_diff report and comment the PR); flip that flag off after a clean soak week to make it blocking. Record mode (`workflow_dispatch` + update-baselines) records on the same pinned stack. Local gates in [test-gates.md](test-gates.md) (`bin/test` macOS, `bin/dtest` docker-linux) remain the pre-PR discipline.

Two gotchas the first record run hit (both fixed; evidence: [run 30629929407](https://github.com/jetthoughts/jetthoughts.github.io/actions/runs/30629929407) - 104 screenshots compared clean, 4 test failures, commit step never ran). Keep in mind for any new CI test job:
- **Draft fixtures**: screenshot tests visit the draft post `/blog/codeblock-styles-fixture/`; local builds pass `--buildDrafts` but `bin/hugo-build` only does so when `BUILD_DRAFTS` is set - test.yml sets `BUILD_DRAFTS: '1'` on its setup-hugo step. A CI test build without it 404s the fixture and fails the codeblock tests on every run.
- **fail_if_new in CI**: snap_diff hard-errors on missing baselines when `ENV["CI"]` is set. Record mode (`FORCE_SCREENSHOT_UPDATE=true`) disables `fail_on_difference` AND `fail_if_new` (setup_snap_diff.rb) so pages added since the last recording can get their FIRST baseline.

Two more, hit re-recording Linux baselines from CI on 2026-08-20 (see [test-gates.md](test-gates.md) for why CI, not local `bin/dtest`, is the only honest place to record them):
- **"no checks reported" has TWO causes - check `mergeable_state` FIRST**: (a) the bot's baseline commit carries `[ci skip]`, so a record dispatch leaves the PR with no new run; (b) far more silent, an UNMERGEABLE PR produces ZERO checks at all - `pull_request` runs are built against a merge ref GitHub cannot compute, so it creates nothing rather than erroring. On 2026-08-20 (b) was the real blocker and (a) was wrongly blamed for 25 minutes; `gh api repos/OWNER/REPO/pulls/N --jq .mergeable_state` returned `dirty`. A baseline record takes ~20 min while master keeps moving, and the record commit plus any `.okf/log.md` edit conflicts easily - merge master and the checks appear. Never read missing checks as "still running" or "passing."
- **Record mode has no accept/reject gate**: `FORCE_SCREENSHOT_UPDATE=true` overwrites every baseline blind, with no diff review before the commit. Screen the result by per-file byte-size delta and visually inspect only the outliers - sub-pixel noise lands under ~1.2%, real content changes stand out (2026-08-20: mermaid_post +21%/+24%, nav/use_cases -10%).

**Stale Linux baselines drift silently on master** while the PR screenshot gate stays `continue-on-error` (report-only, see below) - two live examples found 2026-08-20: PR #470 updated only the `macos/` mermaid baselines and left `linux/` stale; and `linux/desktop/nav/use_cases.png` was still encoding copy banned by `.okf/content/claims-canon.md` ("Rated 4.8/5 by 32 clients", "2011") that was corrected on the live site on 2026-08-14 - the LIVE SITE was correct, only the frozen PNG carried the stale wording, which is why the banned-string ratchet (a text grep) never caught it. A frozen baseline PNG is not covered by any text validator.

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

# Diagnosing a slow or timing-out job

Read the **per-STEP** timings via `list_workflow_jobs`, not just the job
duration. The 7-minute `actions/checkout` above was invisible at job level and
would have been misread as a slow test suite (2026-08-07).

# Agent containers self-bootstrap

A checked-in `.claude/settings.json` SessionStart hook runs `bin/agent-bootstrap`
(bundle + bun install, libvips, the pinned CfT stack via `bin/setup-test-env`,
doctor), every step warning-and-continuing on blocked network; log at
`/tmp/agent-bootstrap.log`. A pre-push guard (`.githooks/pre-push`, installed by
`bin/setup` via `core.hooksPath`) runs the lint-css ratchet, course validators,
and toolchain-pin guards in ~5s; bypass with `SKIP_CHECKS=1`. Gotcha:
`.claude/**/*.json` is gitignored - `settings.json` needed a `!` negation, and
the same `.*` rule once kept `.githooks/pre-push` out of the repo entirely.

