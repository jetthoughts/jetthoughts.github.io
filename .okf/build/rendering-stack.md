---
type: build-concept
title: A screenshot baseline is a recording of a rendering stack
description: Which environment records the linux/ baselines, why bin/dtest is now authoritative for detecting visual defects, and the five wrong explanations for a drift whose real cause was stale baselines
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
is not - and **measurement on 2026-08-22 says that does not matter today.**
Against baselines recorded by CI on Ubuntu ARM, local `bin/dtest` on Debian ARM
reports `55 screenshots compared, no failures`. Pixel-identical across the
distro boundary.

**Measured, not structural.** Debian and Ubuntu upgrade freetype/harfbuzz
independently, so this agreement can end without anyone changing this repo.
It is a fact about today's two images, not a guarantee - which is why
"re-record where the tester runs" stays a rule below.

**macOS is a third stack.** `bin/test` records `macos/`; `bin/dtest` and CI
record `linux/`. Neither OS's set is a subset of the other, and a candidate
rendered on one must never be committed as a baseline for another.

## Five wrong explanations, and the boring answer (RESOLVED 2026-08-22)

**The cause was stale baselines.** Nothing else. The `linux/` set had been
recorded on amd64/Chrome-152 against older content; every "drift" was that old
recording compared against a current render. Re-recording on master made all 55
match everywhere, local and CI.

Five explanations were believed before that. Each sounded mechanical, each was
asserted without measuring the thing it named, and the true cause was never
proposed as a hypothesis because it was not interesting enough to be suspicious
of. Listed because the *shape* recurs, not the specific causes:

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
5. **"Debian container vs Ubuntu runner."** Believed 2026-08-22, asserted in
   #589's commit message, and **DISPROVEN the same day**: after the re-record,
   Debian ARM and Ubuntu ARM agree on all 55. What made it persuasive was that
   local and CI failed the *same 8 keys* - which reads as corroboration and is
   not, because both were comparing against the same stale baselines, so every
   hypothesis predicted red on both. **Two observers agreeing tells you nothing
   when they share the input you are trying to test.**

Why this family and not others: dense monospace text is where any rendering
difference lands first, so the codeblocks screenshots were the most sensitive
surface in the suite. They were not arbitrary - they were the canary, which is
also why they looked like evidence for whichever theory was current.

The lesson is the ranking. Every one of these five was a story about a
*mechanism*; none was a check on the *instrument*. "Are the baselines current?"
is cheap, boring, and would have ended it in a day.

## Rules

- **Suspect the baselines BEFORE the mechanism.** "Are these current?" is the
  cheapest question available and it is the one that resolved a drift five
  mechanism-theories failed on. Ask it first, every time.
- **Identical `difference_level` across two runs = stale baseline, not flake.**
  Flake varies; a stack mismatch does not.
- **Agreement between two observers proves nothing if they share the input
  under test.** Local and CI failing the same keys looked like corroboration
  and was an artifact: both were reading the same stale baselines.
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

The loose end that would have invited a retreat - the 8 codeblocks keys - is
closed: they were stale baselines, not an ARM problem, and the re-record made
them green. ARM cost nothing in correctness and removed the emulation tax.

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

### The 8 codeblocks keys: CLOSED 2026-08-22

The experiment: re-record `linux/` via an `update-baselines` dispatch on master
(`dc11791ab`, all 55 rewritten), then run local `bin/dtest` against it.

**Result: `55 screenshots compared, no failures`.** The distro never mattered.

Then, because a green gate and a blind gate look identical, the instrument was
checked: forcing `background-color: #ff0000` on `.post-article .highlight pre`
produced `16 failures` - all 8 desktop plus all 8 mobile codeblocks keys, and
nothing else. Reverting returned it to 0. Clean 0 -> injected 16 -> reverted 0
is the evidence that the green means something.

## One stack or two: DECIDED 2026-08-22 - two, and do nothing

The plan was to publish this image to GHCR and run CI inside it, so local and
CI would be identical *by construction*. **Do not build that.** Its entire
justification was closing a Debian-vs-Ubuntu gap that measurement says is not
open: the two images already agree on all 55 screenshots. A 2.54 GB build/pull
per job, retired before it was built.

The other rejected option was accepting a split where CI owned pixel truth and
`bin/dtest` was merely behavioural, with divergent keys screened. Also dead, and
good riddance: an expected-red list is exactly what rotted into "everything is
expected red" before #566.

What holds instead:

- **`bin/dtest` is authoritative for DETECTING visual defects.** It agrees with
  CI, so a local red is a real defect. There is no expected-red list.
- **CI remains authoritative for RECORDING.** Agreement is measured, not
  structural - Debian and Ubuntu move independently - so re-recording stays a
  master dispatch. Detection and recording are different powers; this split is
  deliberate, not leftover caution.
- **Revisit only on evidence**, i.e. a `bin/dtest` red that a master re-record
  then makes green. That is the signature of the distros having drifted apart,
  and it is the only thing that should reopen the GHCR question.
