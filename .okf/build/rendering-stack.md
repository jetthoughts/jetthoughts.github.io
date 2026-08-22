---
type: build-concept
title: A screenshot baseline is a recording of a rendering stack
description: Which environment records the linux/ baselines, why local dtest can differ from CI, the all-arm64 migration, and the five wrong explanations for one drift - two of them formally withdrawn
tags: [testing, screenshots, docker, ci, rendering]
timestamp: 2026-08-22T00:00:00Z
---

# A screenshot baseline is a recording of a rendering stack

Not of a page. Change the stack and every baseline is stale, even though no
code moved. So before calling a visual diff a defect, establish **which stack
produced the baseline and which produced the candidate**.

## The two stacks in this repo

| | local `bin/dtest` | CI (records `linux/`) |
|---|---|---|
| arch | **arm64** | **arm64** (`ubuntu-24.04-arm`) |
| Chrome | 153.0.8010.5, pinned by `.dev/cft-version` | same pin, cached by that file's hash |
| `fonts.conf` + font packages | `.dev/fonts.conf`, noto-core / freefont-ttf / dejavu-core | same, via `bin/setup-test-env` |
| **base OS** | **Debian 13 trixie** (freetype 2.13.3) | **Ubuntu 24.04** |

Architecture, browser and fonts are deliberately pinned to match. The base OS
is not - so freetype/harfbuzz may differ, which would be enough to move dense
monospace text. 8 `mobile/blog/special/codeblocks/*` screenshots differ
~0.055-0.063 with no defect present, and **the base OS is the last unpinned
variable, not a demonstrated cause** - see the open question below.

**macOS is a third stack.** `bin/test` records `macos/`; `bin/dtest` and CI
record `linux/`. Neither OS's set is a subset of the other, and a candidate
rendered on one must never be committed as a baseline for another.

## Five wrong explanations, in the order they were believed

Each sounded mechanical and each was asserted without measuring the thing it
named. Listed because the *shape* recurs, not the specific causes:

1. **"arm64 vs amd64 drift."** The container was x86_64 at the time. `.dev/compose.yml`
   pins `platform: linux/amd64` on the `t` service and that DOES override
   `bin/dc`'s `DOCKER_DEFAULT_PLATFORM=linux/arm64/v8` - which is a real
   booby-trap in the tooling, since it makes the arm64 story look right. One
   `uname -m` in the container ends the debate. (Both the pin and the export
   were deleted in #589 - the trap is gone, the lesson is not.)
2. **"The tolerance change (#560) regressed it."** That test pins its own
   `tolerance: 0.03` inline, so the default never applied to it.
3. **"The PR merge-commit checkout differs from the dispatch checkout."** True
   of the workflow, but the failure reproduced identically on master where
   both see the same tree.
4. **"A date-gated post appeared."** Both candidate posts were dated before
   the baseline was recorded.
5. **"Debian container vs Ubuntu runner."** Believed 2026-08-22 and asserted in
   #589's commit message. The base OS is the last unpinned variable, which makes
   it the standing candidate - but it has never been measured either. Withdrawn;
   see the codeblocks section below for the observation that fooled it.

The measurement that resolved #1-#4 took one command and should have been
first: read the container's OS and library versions. #5 has no such measurement
yet, which is exactly why it is listed here rather than in Rules.

## Rules

- **Identical `difference_level` across two runs = stale baseline, not flake.**
  Flake varies; a stack mismatch does not.
- **Re-record where the tester runs.** An `update-baselines` dispatch on a
  feature branch records the branch tree while PR runs test the merge commit;
  dispatch on **master** so recorder and tester agree. That is what fixed
  `mobile/blog/index/_pagination` (a real 0.0425 content difference).
- **Never re-record `linux/` from a Mac**, whatever the container reports.
- **Pin the test container to CI's arch, never to "the host's".** They coincide
  only while every developer is on the same architecture, so "follow the host"
  is a guarantee that silently expires on the first machine that differs -
  amd64 Chrome compared against arm64 baselines, on a BLOCKING gate. `.dev/
  compose.yml` pins `linux/arm64` on `t` and `sh` for this reason. Bare metal
  cannot pin (an x86 CPU cannot run arm64 Chrome), so `bin/setup-test-env`
  warns instead. Caught by review on #589, not by any gate - no suite fails
  when the only x86 host is one nobody has yet.
- A green visual run that prints no `[snap_diff] N screenshots compared` line
  compared nothing - see [test-gates](/build/test-gates.md).

## arm64 is THE stack (Paul, 2026-08-22) - shipped, not on trial

**Standing decision: arm64 everywhere - container, CI, baselines. It is
reversed only on evidence that something genuinely cannot support it.** Slower
on some hypothetical x86 box does not qualify; neither does an unexplained
pixel diff, which is a measurement job, not grounds to go back. Treat "should
we return to amd64?" as answered unless you can name the thing ARM cannot do.

This matters because the 8 unexplained codeblocks keys below are exactly the
kind of loose end that invites a retreat to the old stack. They predate the
migration and survived it unchanged - so they are not evidence against ARM.

### How it became available (was "waiting for Stable")

Chrome for Testing **does** publish `linux-arm64` - chrome and chromedriver
both - from **153.0.8001.0** onward. An earlier check here concluded "no
linux-arm64 build" because it queried the PINNED version, 152.0.7977.54, which
is one major release too early. Query the manifest, not the pin.

| channel | version | `linux-arm64` |
|---|---|---|
| **Stable** | 152.0.7977.54 | **no** |
| Beta | 153.0.8010.5 | yes |
| Dev / Canary | 154.x | yes |

The policy had been "pin current Stable", which would have blocked ARM until 153
promoted. **Paul overrode it (2026-08-21): take Beta now.** `.dev/cft-version`
pins `153.0.8010.5` - a fixed version string, so nothing floats, and the pin
returns to Stable when 153 promotes. Migration shipped in
[#589](https://github.com/jetthoughts/jetthoughts.github.io/pull/589).

The reasoning that made it worth doing, all of which held:

- the container **ran amd64 under emulation on an ARM Mac** - that is why
  `.dev/compose.yml` carried `mem_limit: 4g` with the note "Chrome 152 needs
  >2g under amd64 emulation (OOM 'tab crashed' at 2g)". Native arm64 removes
  that tax entirely.
- GitHub's `ubuntu-24.04-arm` runners are free for this public repo, so CI can
  match.
- same arch on both sides, and if CI also runs this image, the same distro -
  which closes the Debian-vs-Ubuntu gap below at the same time.

Two things the plan did not anticipate, both of which would have broken CI too:

- `Gemfile.lock` carried `aarch64-linux-musl` (Alpine) but not `aarch64-linux`
  (glibc), so nokogiri had no native candidate on a Debian ARM container. Fix:
  `bundle lock --add-platform aarch64-linux`.
- `bin/dc` exported `DOCKER_DEFAULT_PLATFORM=linux/arm64/v8`, which never took
  effect because the services pinned `linux/amd64` and won. Deleted rather than
  kept-and-now-correct: it is precisely what made wrong explanation #1 above
  look plausible.

### The 8 codeblocks keys: still UNRESOLVED, and beware the false confirmation

After changing both architecture and Chrome major version, 47 of 55 screenshots
still matched baselines recorded on amd64/Chrome-152. The 8 that did not are the
same `mobile/blog/special/codeblocks/*` family, at the same magnitudes - so the
divergence is neither arch nor Chrome version.

**It does NOT follow that the base OS is the cause.** Local ARM (Debian) and CI
ARM (Ubuntu) fail the *same 8 keys*, which reads like confirmation and is not:
both are being compared against baselines recorded on the OLD stack, so every
hypothesis predicts red on both. The observation cannot discriminate. An earlier
commit message in this very migration asserted the distro cause anyway - the
fifth instance of the exact shape catalogued above.

**The discriminating experiment, still to run:** re-record `linux/` via an
`update-baselines` dispatch on master, then run local `bin/dtest`. Green means
the distro never mattered; the same 8 red means it does. Until that runs, the
cause is unknown, not "Debian vs Ubuntu".

## The open decision: one rendering stack, or two?

Running CI inside this same container makes local and CI identical by
construction and lets `bin/dtest` be authoritative for visuals; both sides are
now arm64 native so there is no emulation either way, and the cost is image
build/pull per job -
**measure it before committing.** Feasibility checked 2026-08-22: the repo is
PUBLIC so GHCR is free, the image is 2.54 GB uncompressed, and GitHub Actions
can run a whole job inside it via the job-level `container:` key. Publish on
changes to `.dev/Dockerfile` or `.dev/cft-version` only - the same hash that
already keys the Chrome cache. Note the honest comparison is not "pull vs
nothing": CI already spends the same class of time on
`setup-ruby-and-dependencies`, the Chrome-for-Testing download and the font
packages, all of which the container replaces.

The tempting cheaper alternative - move the CONTAINER to Ubuntu so it matches
the runner - is blocked: the image builds on `ruby:$RUBY_VERSION-slim`, and the
official Ruby images are Debian-only. Matching that way means hand-rolling Ruby
on an Ubuntu base, which is more moving parts than publishing one image.

The alternative is to accept the split: CI owns pixel truth, `bin/dtest` is a
behavioural gate, and the divergent keys are screened. Free today, but an
expected-red list is exactly what rotted into "everything is expected red"
before #566. Pinning font and library versions across two distros is a third
option and not a serious one - they drift independently, forever.
