---
type: build-concept
title: A screenshot baseline is a recording of a rendering stack
description: Which environment records the linux/ baselines, why local dtest differs from CI, and the four wrong explanations that cost a session
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
| arch | x86_64 | x86_64 |
| Chrome | 152.0.7977.54, pinned by `.dev/cft-version` | same pin, cached by that file's hash |
| `fonts.conf` + font packages | `.dev/fonts.conf`, noto-core / freefont-ttf / dejavu-core | same, via `bin/setup-test-env` |
| **base OS** | **Debian 13 trixie** (freetype 2.13.3) | **ubuntu-latest** |

Architecture, browser and fonts were deliberately pinned to match. The base OS
was not, so freetype/harfbuzz differ - and that is enough to move dense
monospace text. Measured 2026-08-22: 8 `mobile/blog/special/codeblocks/*`
screenshots differ ~0.055-0.063 between the two, with no defect present.

**macOS is a third stack.** `bin/test` records `macos/`; `bin/dtest` and CI
record `linux/`. Neither OS's set is a subset of the other, and a candidate
rendered on one must never be committed as a baseline for another.

## Four wrong explanations, in the order they were believed

Each sounded mechanical and each was asserted without measuring the thing it
named. Listed because the *shape* recurs, not the specific causes:

1. **"arm64 vs amd64 drift."** The container is x86_64. `.dev/compose.yml`
   pins `platform: linux/amd64` on the `t` service and that DOES override
   `bin/dc`'s `DOCKER_DEFAULT_PLATFORM=linux/arm64/v8` - which is a real
   booby-trap in the tooling, since it makes the arm64 story look right. One
   `uname -m` in the container ends the debate.
2. **"The tolerance change (#560) regressed it."** That test pins its own
   `tolerance: 0.03` inline, so the default never applied to it.
3. **"The PR merge-commit checkout differs from the dispatch checkout."** True
   of the workflow, but the failure reproduced identically on master where
   both see the same tree.
4. **"A date-gated post appeared."** Both candidate posts were dated before
   the baseline was recorded.

The measurement that actually resolved it took one command and should have
been first: read the container's OS and library versions.

## Rules

- **Identical `difference_level` across two runs = stale baseline, not flake.**
  Flake varies; a stack mismatch does not.
- **Re-record where the tester runs.** An `update-baselines` dispatch on a
  feature branch records the branch tree while PR runs test the merge commit;
  dispatch on **master** so recorder and tester agree. That is what fixed
  `mobile/blog/index/_pagination` (a real 0.0425 content difference).
- **Never re-record `linux/` from a Mac**, whatever the container reports.
- A green visual run that prints no `[snap_diff] N screenshots compared` line
  compared nothing - see [test-gates](/build/test-gates.md).

## ARM on Linux is a dead end, and that is why compose pins amd64

Verified 2026-08-22 against the Chrome for Testing manifest: version
152.0.7977.54 publishes `linux64, mac-arm64, mac-x64, win32, win64` - **there is
no `linux-arm64` build**. So an arm64 Linux container cannot run the pinned
Chrome natively; it can only emulate the amd64 one, which is both slower and
pixel-divergent. GitHub's `ubuntu-24.04-arm` runners are free for this public
repo, so runner availability is NOT the constraint - the browser is.

That makes `platform: linux/amd64` on the `t` service a forced choice rather
than a preference, and `bin/dc`'s `DOCKER_DEFAULT_PLATFORM=linux/arm64/v8`
straightforwardly wrong for anything that renders. Do not "try ARM" again
without first re-checking that manifest.

## The open decision: one rendering stack, or two?

Running CI inside this same container makes local and CI identical by
construction and lets `bin/dtest` be authoritative for visuals; CI is amd64
native so there is no emulation, and the cost is image build/pull per job -
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
