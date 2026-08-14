---
type: Playbook
title: Test gates and when they block commits
description: bin/qtest --changed is the routine gate; bin/rake test:critical at milestones; bin/test AND bin/dtest once at PR prep (or on explicit confirmation) for themes/, layouts/, or CSS changes.
tags: [testing, visual-regression, gates]
status: stable
generated: { by: claude/opus-4-8, at: 2026-08-12T20:20:00Z }
verified: { by: claude/fable-5, at: 2026-08-01T11:30:00Z }
---

# The suites

| Command | What it is | When required |
|---|---|---|
| `bin/test --smoke` / `bin/rake test:smoke` | Smoke tier: 17 curated basics+bummers (homepage/blog-post/404/course renders + funnel forms + nav/hamburger + one mermaid). `bin/dtest --smoke` runs it in Docker (args pass through) | Sub-minute "did I break the basics" check during active work; NOT a milestone/PR gate |
| `bin/qtest --changed` | Scoped visual gate: builds once (~11s), runs ONLY affected pages' desktop+mobile screenshot tests (~2.5s each) + orphan guard + color-system check; site-wide/unmapped files auto-escalate to the full critical suite | Per micro-commit inside a sprint (~25-60s); NOT a substitute for the milestone/PR gates below |
| `bin/rake test:critical` | Critical Minitest suite (34 runs / 53 screenshots), ~81s host / ~46s Docker since the 2026-08-01 skip_area fix | At component/task milestones and before every commit outside sprint micro-commit trains |
| `bin/test` | Visual regression on the host (baselines in `macos/` on a Mac; on Linux, comparable to `linux/` when run through `bin/setup-test-env`'s pinned stack) | ONCE at PR prep (branch head, before `gh pr create`) or on Paul's explicit confirmation - NOT per commit (Paul 2026-07-31: qtest is the routine gate) |
| `bin/dtest` | Same suite in Linux/Docker (baselines in `linux/`) - CI runs Linux | Same trigger as bin/test; a PR must never open without this leg (green-locally / red-in-CI otherwise) |
| `bin/check-post-visuals` | Ratchet: counts blog posts over 800 words with no mermaid/SVG/image. Fails when the count exceeds `FLOOR` (78 as of 2026-08-13) | Before publishing any post. Added 2026-08-13 - `diagram_rendering_test.rb` only proves diagrams RENDER, nothing proved posts HAVE them, and 25 of the 31 long posts published since 2026-04 shipped with none |

`bin/qtest` page keys mirror `themes/beaver/assets/css/pages/*.css` basenames
AND `critical/<name>-critical.css` basenames - the two sets differ (e.g.
`privacy-policy-critical.css` needs its own key even though the page CSS key
is `simple-page`); the changed-file→page map lives in the script itself -
extend it when adding components or critical files. The macOS full suite remains the only dedup-trap catcher
(Linux font resolution masks it) - never finish a component on qtest alone.

# Hard-won caveats

- **The 2% default tolerance hides small text/colour changes** (2026-08-14).
  `DEFAULT_SCREENSHOT_CONFIG = {tolerance: 0.02}`
  (`test/application_system_test_case.rb:87`). Turning a four-word phrase into
  a link on the homepage changed ~0.24% of the frame, so the gate PASSED and
  the baseline was never re-recorded - it still shows the pre-change render.
  Consequence: a green visual suite does NOT mean "no visual change", only "no
  change larger than 2% of the frame". For link/colour/short-text edits,
  verify by reading the built HTML or the render, not by trusting green. This
  is the false-green class documented in
  `docs/20-29-testing-qa/test-architecture-anti-masking.md`.
- **`FORCE_SCREENSHOT_UPDATE=1` re-records EVERYTHING** (2026-08-14). On
  `bin/dtest` it also disables the `git checkout -- .../linux` guard that
  normally discards sub-tolerance Rosetta drift, so a run rewrites all 45
  Linux baselines rather than the few your change moved. Procedure: run it,
  copy out only the baselines your change legitimately moved, `git checkout --
  test/fixtures/screenshots/linux`, then copy your files back. On `bin/qtest`
  the flag appears to be ignored entirely - the suite still compares.
- **A `skip_area` selector that matches NOTHING costs 5s per screenshot**
  (2026-08-01). snap_diff resolves each mask via `all(sel, visible: true)`,
  and Capybara waits `default_max_wait_time` (5s) on a zero-match selector.
  A shared default like `skip_area: %w[picture img]` on an image-less page =
  10s/shot; one test paid ~130s (44% of the suite) this way. Fixed at the
  `assert_screenshot` choke point (`Capybara.using_wait_time(0)` + pinned
  capture wait), so masks are cheap now - but adding a mask for an element
  that may be absent is still a smell. Removing a mask/tolerance is safe once
  fonts settle (`document.fonts.ready` is in the choke point); the
  drift-overview procedure (read `snap_diff_report.html` heatmap, one mask at
  a time, which masks to KEEP) lives in the repo doc
  `docs/20-29-testing-qa/screenshot-testing/20.10-visual-suite-speed-research-reference.md` (outside this bundle).
- **Fonts + mermaid.js are self-hosted** (2026-08-01) - Caveat / Space Grotesk
  woff2 and `mermaid-11.15.0.min.js` served same-origin from
  `themes/beaver/static/`, not Google Fonts / jsdelivr. Visual tests are
  hermetic (zero third-party network); prod mermaid pages lose the CDN round
  trips. The vendored mermaid is sha384-identical to the old SRI pin - re-vendor
  (and re-record mermaid baselines) if bumping the version.
- **Local `bin/dtest` is red ONLY on 7 mobile-codeblock screenshots**
  (2026-08-01, verified across 3 runs byte-identical: bare 7.3 / html 5.46 /
  js 4.34 / python 4.31 / text 4.08 / ruby 3.49 / md 3.57). This is
  DETERMINISTIC amd64-emulation antialiasing (same pinned Docker fonts on both
  sides - it's the QEMU-vs-native CPU math on Apple Silicon), NOT flaky and NOT
  a regression. They are GREEN on CI-native amd64. mermaid used to be in this
  set and is now GREEN after self-hosting the fonts. Trust CI for these 7; never
  re-record them from local emulated Docker (would break green CI). Identical
  diff_levels across runs = deterministic (a flaky render varies).
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
- `bin/dtest` from a git WORKTREE is VACUOUS-GREEN: the worktree's `.git` is
  a pointer file to a directory outside the container mount, so git fails
  inside the container, baselines resolve to nothing, and every screenshot
  records as "new" - 34/34 passes with no `[snap_diff] ... compared` summary
  line and none of the 7 always-red emulation diffs (the two tells). Honest
  Linux leg for a branch held by a worktree: from the MAIN checkout,
  `git checkout --detach <branch>` → `bin/dtest` → restore + checkout back
  (2026-08-01, W1 merge gate).
- `ALLOW_DIRTY_SCREENSHOTS=1` does NOT propagate into the bin/dtest Docker
  container - the dirty-fixtures guard aborts inside the container with only
  "Tasks: TOP => test:critical" in the tail (2026-07-31: cost two aborted-run
  investigations). With dtest the only path is the designed one: COMMIT the
  intended baselines first, then run on a clean tree.
- The dirty-fixtures guard is scoped to the OS dir the run writes
  (`Capybara::Screenshot::Os.name` -> `macos/` on the host, `linux/` in the
  container). Before that, dirty `macos/` candidates aborted the Linux leg -
  the container HAS git (`.dev/Dockerfile` sets `safe.directory /app`), so an
  unscoped glob saw the host's dirt and refused to start. Practical effect:
  a red `bin/test` no longer blocks `bin/dtest`, so you can run the two legs
  independently while reviewing a macOS diff.
- The snapshot tool REWRITES baselines when a run passes. Since 2026-07-31
  a GREEN `bin/test`/`bin/dtest`/`bin/qtest` run auto-restores the
  OS-scoped baseline dir it wrote (`macos/` on the mac host, `linux/` for
  the dtest leg - scoped 2026-08-01 so test and dtest can run in parallel
  in one checkout; skipped under `FORCE_SCREENSHOT_UPDATE`),
  so passing runs no longer leave the tree dirty or arm the dirty-fixture
  guard against the next run. A RED run still keeps candidates + diff
  artifacts for inspection. Never edit CSS while a suite is running - a
  raced run once saved a corrupt baseline missing its hero image.
- Test builds MUST use `baseURL "/"` - enforced as `bin/build-if-stale`'s
  default, which all four runners build through (CI's setup-hugo action
  defaults to "/" independently). An absolute `http://localhost:1314` baseURL bakes
  the port into every stylesheet link and internal href, but Capybara
  boots Puma on a RANDOM port unless TEST_SERVER_PORT pins it - result is
  all-CSS-refused half-styled screenshots (huge diffs on every page) and
  click-navigation tests landing on ERR_CONNECTION_REFUSED
  (2026-07-31: the R2 fast path shipped with the absolute URL; every host
  bin/test run failed 49/49 while dtest stayed green because Docker sets
  TEST_SERVER_PORT=1314). In record mode this silently saves Chrome
  error pages as baselines - brightness-audit re-records before
  committing (identical mean brightness across different pages = black
  or error frames). Evidence + verification transcript: PR #424.
- A warm `_dest/` tree survives a change to the build recipe itself.
  `bin/build-if-stale`'s `stale()` only compares SOURCE mtimes against
  `$DEST/index.html`, so when #424 changed the default baseURL (20:45) every
  tree built before it (20:17) stayed "warm" - `bin/test` kept rendering
  against dead `localhost:1314` asset URLs and rewrote 49 baselines with
  black/unstyled garbage, then the dirty-fixture guard deadlocked both legs.
  Fixed by adding `bin/build-if-stale bin/hugo-build` to the `find` list, so
  a build-recipe change invalidates the tree. Diagnosis tell: `grep
  localhost:1314 _dest/<tree>/404.html` returns hits; escape hatch is
  `FORCE_BUILD=1` or `rm -rf` the tree.
- The snap_diff HTML report at
  `test/fixtures/screenshots/snap_diff_report.html` (gitignored) is written
  automatically on any RED run - the gem auto-registers the reporter on
  require and prints `Report: <path>` as the last stdout line. It shows
  original / candidate / annotated-diff / heatmap per failure. It is deleted
  at suite load, because the reporter only writes when failures exist and a
  stale report otherwise describes diffs that no longer exist.
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
- REPORT-ONLY build gates (each flips to blocking once its backlog hits
  zero via an env flag): `bin/check-svg-floor` (`SVG_FLOOR_BLOCK=1`)
  catches course SVGs whose smallest text renders <9px@390;
  `bin/check-course-paths` (`COURSE_PATH_BLOCK=1`) catches lesson
  `Next:`/branch drift vs `data/course_sequence.yaml`. Both are standalone
  (NOT yet wired into hugo-build/CI), carry a `--self-test`, and print a
  burn-down list + exit 0 until their env flag is set. (A landing-parity
  variant was tried and dropped as redundant - YAGNI: a report-only gate
  nobody wires in earns its keep only when it guards an active backlog.)
