---
type: Playbook
title: Test gates and when they block commits
description: bin/qtest --changed is the routine gate; bin/rake test:critical at milestones; bin/test AND bin/dtest once at PR prep (or on explicit confirmation) for themes/, layouts/, or CSS changes.
tags: [testing, visual-regression, gates]
status: stable
generated: { by: claude/opus-5, at: 2026-08-21T16:28:27Z }
verified:
  - { by: claude/opus-5, at: 2026-08-21T09:59:40Z }
  - { by: claude/opus-5, at: 2026-08-21T07:42:17Z }
  - { by: claude/opus-5, at: 2026-08-21T06:44:05Z }
  - { by: claude/opus-5, at: 2026-08-21T06:36:48Z }
  - { by: claude/opus-5, at: 2026-08-21T06:27:54Z }
  - { by: claude/opus-5, at: 2026-08-21T06:15:51Z }
  - { by: claude/opus-5, at: 2026-08-21T06:04:00Z }
  - { by: claude/opus-5, at: 2026-08-21T05:33:58Z }
  - { by: claude/opus-5, at: 2026-08-21T04:01:38Z }
  - { by: claude/opus-5, at: 2026-08-21T03:27:09Z }
  - { by: claude/opus-5, at: 2026-08-20T23:11:35Z }
  - { by: claude/fable-5, at: 2026-08-01T11:30:00Z }
  - { by: claude/sonnet-5, at: 2026-08-20T00:00:00Z }
  - { by: claude/opus-5, at: 2026-08-20T21:43:35Z }
  - { by: claude/opus-5, at: 2026-08-20T21:47:30Z }
timestamp: 2026-08-21T16:28:27Z
---

# The suites

| Command | What it is | When required |
|---|---|---|
| `bin/test --smoke` / `bin/rake test:smoke` | Smoke tier: 17 curated basics+bummers (homepage/blog-post/404/course renders + funnel forms + nav/hamburger + one mermaid). `bin/dtest --smoke` runs it in Docker (args pass through) | Sub-minute "did I break the basics" check during active work; NOT a milestone/PR gate |
| `bin/qtest --changed` | Scoped visual gate: builds once (~11s), runs ONLY affected pages' desktop+mobile screenshot tests (~2.5s each) + orphan guard + color-system check; site-wide/unmapped files auto-escalate to the full critical suite | Per micro-commit inside a sprint (~25-60s); NOT a substitute for the milestone/PR gates below |
| `bin/rake test:critical` | Critical Minitest suite (34 runs / 53 screenshots), ~81s host / ~46s Docker since the 2026-08-01 skip_area fix | At component/task milestones and before every commit outside sprint micro-commit trains |
| `bin/test` | Visual regression on the host (baselines in `macos/` on a Mac; on Linux, comparable to `linux/` when run through `bin/setup-test-env`'s pinned stack) | ONCE at PR prep (branch head, before `gh pr create`) or on Paul's explicit confirmation - NOT per commit (Paul 2026-07-31: qtest is the routine gate) |
| `bin/dtest` | Same suite in Linux/Docker (baselines in `linux/`) - CI runs Linux | Same trigger as bin/test; a PR must never open without this leg (green-locally / red-in-CI otherwise) |
| `bin/check-post-visuals` | Ratchet: counts blog posts over 800 words with no mermaid/SVG/image. Fails when the count exceeds `FLOOR` (**72** as of 2026-08-20, down from 78) | Before publishing any post. Added 2026-08-13 - `diagram_rendering_test.rb` only proves diagrams RENDER, nothing proved posts HAVE them, and 25 of the 31 long posts published since 2026-04 shipped with none |

`bin/qtest` page keys mirror `themes/beaver/assets/css/pages/*.css` basenames
AND `critical/<name>-critical.css` basenames - the two sets differ (e.g.
`privacy-policy-critical.css` needs its own key even though the page CSS key
is `simple-page`); the changed-file→page map lives in the script itself -
extend it when adding components or critical files. The macOS full suite remains the only dedup-trap catcher
(Linux font resolution masks it) - never finish a component on qtest alone.

# Run the suite at the MERGE BASE before trusting a green screenshot run

A green screenshot run proves nothing until you know the suite is green with NO
change in the tree. Measured in a worktree on 2026-08-21:

| Suite | Failures on untouched master |
|---|---|
| `bin/rake test:critical` | **13 of 55** |
| `bin/rake test:system` | **18 of 126** |

A phase-1a.4 CSS change reported "55 screenshots compared, no failures" in that
same worktree - green ONLY because the run had rewritten the baselines with this
machine's output. That is not verification against the repo's baselines, it is
replacement of them, and committing the result bakes local render drift into the
repo, mixed in with the intended change and indistinguishable from it.

The tell that something else was moving: a blog screenshot diff showed the
article body VERTICALLY SHIFTED. A `background-color` change cannot move layout,
and it nearly got accepted anyway because it arrived batched with diffs that
genuinely were the intended recolour.

So establish the baseline-of-the-baseline first - `git checkout "$(git merge-base
origin/master HEAD)" -- themes/ test/fixtures/screenshots/`, build, run.

**The merge base, NOT current `origin/master`** (corrected 2026-08-21 by review of
PR #543). Master moves after a branch is cut, so comparing against its current
tip smuggles unrelated upstream failures into your delta and attributes them to
your change. Rebase immediately before measuring and run both sides in the same
environment. Same correction this bundle already made for `git diff` when
checking `verified` rows. If master is not green here,
this machine cannot produce trustworthy baselines: record them where the
canonical ones came from (`gh workflow run test.yml --ref <branch> -f
screenshots=true -f update-baselines=true`), which is the rule
[ci-gates](/build/ci-gates.md) already states for Linux, for the same reason.

Correctness of the CHANGE is still establishable without the suite - browser
measurement and pixel-sampling the live render - and should be, since that
evidence is independent of baseline drift.

# Tolerance policy

**0.0 for refactors** (a refactor must move zero pixels), **<=0.03 for
genuinely new features**. This is the policy for what you ACCEPT, distinct from
the mechanical default that decides whether the suite even reports a diff.

That default is **0.0001** (`DEFAULT_SCREENSHOT_CONFIG`,
`test/application_system_test_case.rb`), lowered from 0.02 on 2026-08-21.
Both halves still hold: the accept-policy is unchanged, and individual calls
may still pin their own tolerance (~30 do, mostly 0.03 - e.g.
`test/system/blog_special_content_test.rb:136`), which the default never
overrides. What changed is the floor for calls that pin NOTHING.

**`SECTION_CONFIGS` is GONE (deleted 2026-08-21), and its exit condition was
met by measurement, not by judgement.** It existed for one day as a temporary
shield holding ~22 section screenshots at the old 0.02 while their drift was
unmeasured. Measured on the full macOS system suite, both sides in the same
environment: **shield in place 48 failing screenshots, shield emptied 50** -
a cost of exactly **+2**, `desktop/services/_use-cases` (0.017498) and
`desktop/services/_technologies` (0.013838). Both were then classified and
re-recorded, so the table was deleted along with `screenshot_config_for`,
`extract_section_key`, `test/support/screenshot_section_config.rb` and its
unit test. `DEFAULT_SCREENSHOT_CONFIG` survives as a plain constant on
`ApplicationSystemTestCase`; there is no per-section tolerance table any more,
and a call that needs slack pins its own tolerance.

The deleted table's keys matched the tail after `/_`, which mattered because
it was easy to misread: `services/_technologies` hit the `technologies` key
(0.02) while `services/_testimonials-header` did NOT hit `testimonials` and
got the default - one string, not a prefix. That subtlety is only recorded
here now; nothing in the tree implements it.

Why 0.0001: on a 1920x1080 capture, 0.02 means ~41,472 pixels must differ
before the assertion fails. A one-cell copy edit measures 0.0004 (844 px), so
the gate was blind to it by 50x - and passed, which is worse than failing
(see the fossilization bullet below). Measured run-to-run noise on a static
page is ~1e-6, not 0 (three runs of `services/_technologies`: 0.013838252,
0.013838252, 0.013837770 - about 2 px of 2,073,600), so the floor has to clear
that; 0.0001 (~207 px) sits 100x above it, fails that copy edit, and goes green
again when it is reverted. **That 1e-6 is the macOS-local figure and does NOT
generalise - see the per-platform noise section below before you lower any
tolerance.** The noise claim is
checkable without re-running the copy edit: two independent runs of the same
test reported difference_levels identical to 16 decimal places (0.6893909143518518
for `services/_footer` every time), and 2 of the 7 screenshots stayed GREEN at
0.0001 even with the shield removed - a floor that low is not tripping on
render jitter.

**What the change actually catches**, measured three ways on
`DesktopSiteTest#test_services` at clean HEAD (macOS, 7 screenshots compared
each run). The middle column is what shipped:

| screenshot | difference_level | 0.02 | shipped | +deleting the shield |
|---|---|---|---|---|
| `services/_footer` | 0.689391 | FAIL | FAIL | FAIL |
| `services/_cta-contact_us` | 0.457970 | FAIL | FAIL | FAIL |
| `services/_testimonials-header` | 0.005923 | pass | **FAIL** | **FAIL** |
| `services/_use-cases` | 0.017498 | pass | pass (shield) | **FAIL** |
| `services/_technologies` | 0.013838 | pass | pass (shield) | **FAIL** |
| totals | | 2 | **3** | 5 |

**Measure the default change and the shield deletion SEPARATELY** - conflating
them is a mistake that was actually made here. A first pass deleted
`SECTION_CONFIGS` in the same commit, measured 5 failures, and reported the
default change as costing +3 screenshots. It costs **+1**; the other +2 are the
shield deletion, and they are exactly the two whose names happen to hit a
SECTION_CONFIGS key. The two changes look like one line and one dead constant,
but they move different screenshots.

All are real stale-baseline detections, not machine drift, and none is caused
by the tolerance change.

**Correction (2026-08-21, from the re-record that measured them):** an earlier
version of this section attributed all five to the #540 dark-surface recolour.
Only the two big ones are. `_footer` and `_cta-contact_us` are #540
(`rgb(0,0,0)` -> `rgb(20,17,15)` is 97-99% of their changed pixels). The three
small ones - `_testimonials-header`, `_use-cases`, `_technologies` - contain
**0.13% or less** of that transition. They are a **1-pixel vertical offset**
from #528's eyebrow consolidation, which touched `services-critical.css` and
`content-block.css` and re-recorded only the two sections that exceeded 0.02;
everything below the eyebrow on /services/ shifted 1px, passed under the old
default, and fossilized. Measured, not inferred: realigning baseline to
candidate by one pixel drops the residual to **exactly 0.0000 in several
bands** and collapses the non-blend suspect count by orders of magnitude
(`blog/index/_pagination`: 32,652 px at dy=0 -> 106 at dy=-1). It does NOT
reach zero page-wide - a sub-pixel shift re-rasterizes glyphs rather than
translating them, so `services/_use-cases` still differs in 22,895 px after
the best realignment. Content is identical on inspection; position moved. The
lesson is the one this file already teaches - a plausible cause that matches
the loudest diffs will happily absorb the quiet ones that have a different
cause entirely.

# Below the fold is invisible to the gate at ANY tolerance

Tolerance is the smaller of the two blind spots. Captures are **viewport-only,
taken at scroll top**: 1920x1080 desktop, 360x800 mobile
(`test/support/setup_capybara.rb:85-86`). Everything below that first fold is
simply not in the image, so no tolerance can catch a change there - measured, a
table-cell edit produced difference_level **exactly 0** on mobile even at
tolerance 0. Corroborating tell in any failure payload: the reported `region`
never exceeds the viewport height (e.g. `[0.0,42.0,1920.0,1080.0]` for
`services/_footer`).

There is a second tolerance-independent axis: `Capybara::Screenshot::Diff.perceptual_threshold = 2.0`
(`test/support/setup_snap_diff.rb:25`) means the vips driver only counts a
pixel as differing once it is more than CIE dE00 2.0 from the baseline pixel.
A recolour that stays under that contributes ZERO differing pixels, so it
passes at ANY tolerance including 0 - most relevant to palette and
dark-surface work, where a shift can be deliberate, visible and still
sub-threshold.

This is why the suite leans on per-section screenshots - each one scrolls its
section INTO the viewport first (`verify_section_for` →
`scroll_to find(css)`), which is the existing workaround, not an accident.
A page asserted only as one top-of-page shot is verified for its first fold and
nothing else. Closing the gap properly means either more section shots or
full-page capture; both are out of scope for the tolerance change and belong to
the follow-up that re-records baselines.

# Rake tasks and suite layout

Minitest under `test/`, driven by `Rakefile` (`Rake::TestTask`).
`test/test_helper.rb` sets `SYNC_ENV=test`, a fake `DEVTO_API_KEY`, and puts
`lib/` on `$LOAD_PATH`. Default rake task is `test:all`.

| Rake task | Pattern | Use |
|---|---|---|
| `rake test` / `rake test:all` | `test/**/*_test.rb` | Full suite |
| `rake test:unit` | `test/unit/**/*_test.rb` | Unit tests - required for any `lib/` change; `test:critical` does NOT include it |
| `rake test:critical` | `test/system/*_test.rb` | The milestone gate above |
| `rake test:integration` | `test/integration/**/*_test.rb` | Integration tests |
| `rake build` | - | Runs `bin/hugo-build` |
| `rake dev` | - | Runs `bin/dev` (dev-mode PostCSS; `bin/hugo-dev` retired - it ran the production PurgeCSS chain) |
| `rake lighthouse[limit]` | - | Runs `bin/lighthouse` across crawled pages |

# Hard-won caveats

- **The 2% default tolerance hid small text/colour changes** (2026-08-14,
  FIXED 2026-08-21 by lowering the default to 0.0001 - see Tolerance policy).
  Turning a four-word phrase into a link on the homepage changed ~0.24% of the
  frame, so the gate PASSED and the baseline was never re-recorded - it still
  showed the pre-change render. The residual rule outlives the fix, because
  ~30 calls still pin 0.03 of their own: a green visual suite does NOT mean
  "no visual change", only "no change larger than THAT call's tolerance". For
  link/colour/short-text edits on a page whose call pins a tolerance, verify by
  reading the built HTML or the render, not by trusting green. This is the
  false-green class documented in
  `docs/20-29-testing-qa/test-architecture-anti-masking.md`.
- **Flat-file posts are invisible to the visuals ratchet** (2026-08-20).
  `bin/check-post-visuals` globs `content/blog/*/index.md`, so a post living as
  a flat file (`content/blog/2025/<slug>.md`) is outside the ratchet population
  AND outside page-bundle tooling - no pre-rendered mermaid, no local cover.
  Converting one to a bundle preserves its URL as long as the `slug`
  frontmatter is set, and adds it to the ratchet. The script self-reports slack
  (`post-visuals: floor is loose, lower FLOOR to N`) - obey it: `FLOOR` dropped
  78 -> 72 on 2026-08-20 on the script's own prompt.
- **Screen a CI re-record with the gate's own instrument** (2026-08-21).
  `FORCE_SCREENSHOT_UPDATE` rewrites every baseline, so a CI record commit is
  much larger than the real change set - the 2026-08-21 Linux record touched
  83 files. Do not screen it by eye or by file size. Compute the libvips
  **dE00 fraction above `perceptual_threshold = 2.0`** (what
  `difference_level` actually measures) for each file and compare against the
  0.0001 default: files above it would FAIL the gate, so the rewrite is real
  and dropping them leaves CI red; files at exactly 0 are encoder churn and
  should be reverted. That split was 77 keep / 6 drop, and it needs no
  judgement call.

  **Neither OS baseline set is a subset of the other**, so never infer one
  from the other. Earlier PRs re-recorded only the OS they ran on: #528
  committed `macos/mobile/services.png` and left `linux/mobile/services.png`
  stale (still carrying the shift), while `linux/.../inline_style_post` was
  already current from a post-#520 CI record when macOS was 25% stale. The
  Linux record here was legitimately BROADER than the macOS one (77 vs 50).

- **`FORCE_SCREENSHOT_UPDATE=1` re-records EVERYTHING** (2026-08-14). On
  `bin/dtest` it also disables the `git checkout -- .../linux` guard that
  normally discards sub-tolerance Rosetta drift, so a run rewrites all 45
  Linux baselines rather than the few your change moved. On `bin/qtest`
  the flag appears to be ignored entirely - the suite still compares.

  **The two readers disagree on what counts as set** (identified 2026-08-21,
  NOT fixed - known wart): `bin/qtest:209` skips its restore on ANY truthy
  value, while `test/support/setup_snap_diff.rb:28` enters record mode only
  on the literal string `"true"`. So `FORCE_SCREENSHOT_UPDATE=1` on qtest
  gets the worst of both - the suite still compares and fails, and the
  restore that would have cleaned up is skipped. Spell it `=true`, or better,
  use `bin/record-baselines`.

  **Use `bin/record-baselines <glob>...` instead of doing this by hand**
  (shipped 2026-08-20, PR #489; the manual dance had been done 3x). It runs
  the record, then restores every baseline NOT matching your globs -
  including `rm`ing ones the run CREATED - and reconciles the tree even when
  the test run exits red. `--dry-run` previews the keep/restore split;
  `--linux` refuses to record locally and prints the CI dispatch instead
  (`gh workflow run test.yml --ref <branch> -f update-baselines=true`),
  because local ARM Docker records plant false drift. Globs use bash `case`
  matching, so `*` crosses `/`: `macos/*/blog/**` keeps every blog baseline
  on both viewports. First at-scale run: 69 tests, kept 29 / restored 44.
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
- **Rule VIOLATED, then re-confirmed 2026-08-20.** Commit 5a2a36d8 (CfT
  141->152) re-recorded 91 of 135 Linux baselines from local `bin/dtest` -
  exactly what the bullet above forbids - and CI went red on the same 7
  fixtures at the same magnitudes, precisely as that bullet predicts.
  Re-recording through CI instead
  (`gh workflow run test.yml --ref <branch> -f screenshots=true -f update-baselines=true`)
  reproduced master's pre-existing Chrome-141 baselines byte-for-byte for 7
  of 8 codeblock fixtures - so Chrome 152 renders identically to 141 here and
  the re-record was never needed at all. Full suite green after the CI
  record: 356 runs, 6329 assertions, 0 failures (run 32347402944). Note the
  governing tolerance for these is **0.03**, set per-call at
  `test/system/blog_special_content_test.rb:136` - NOT the
  `DEFAULT_SCREENSHOT_CONFIG` in `test/application_system_test_case.rb`,
  which only applies when a call omits an explicit tolerance.

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
  run the suite so the FAILING run leaves its candidate on disk, keep that
  rewritten PNG, COMMIT it; only then can a rerun go green. Deleting the PNG
  first does nothing - the base is read from git HEAD, not from the file - and
  a run that PASSES restores the HEAD image over the fresh capture, so there
  is nothing to keep. Only a red run produces a committable baseline.
- **A local visual red cannot condemn a branch until you have run the same
  thing on master** (2026-08-21). Verifying PR #511 (template/CSS class),
  `bin/qtest --changed` went red pointing at `services/fractional-cto`
  baselines - a page the PR never touched. The plausible story was that its
  `postcss.config.js` edit had shifted CSS site-wide; it had not, because that
  edit only ADDS purgecss safelist entries and safelisting more can only
  preserve more CSS, never remove any. The decisive check was the same system
  test on clean `origin/master` on the macOS host: **34 runs, 6 failures, 8 of
  77 screenshots mismatched** - the suite is red on master here, so a local red
  said nothing about the branch. The run also rewrites two of those baselines
  mid-run and then fails its own dirty-check, so repeated
  `git checkout -- test/fixtures/screenshots/` never converges. Reproduce on
  master first; if master is red the same way, fall back to CI's native-Linux
  `Screenshot Tests` (which passed #511 in 16m15s while local was red).
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
  artifacts for inspection.

  **This is why a sub-tolerance change FOSSILIZES the baseline.** The two
  behaviours compose: the capture overwrites the PNG, then the pass restores
  the git-HEAD image back over it. So a green run never refreshes anything,
  and any real change small enough to pass leaves the baseline showing the
  OLD render - permanently, until something large enough to fail arrives and
  the accumulated drift gets accepted in one lump nobody can attribute. The
  lower the tolerance, the less can accumulate; it does not remove the
  mechanic, which is inherent to the gem's design. Never edit CSS while a suite is running - a
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

- **No local build path passes `--cleanDestinationDir`, so DELETED sources
  keep serving from the dest tree forever** (2026-08-20). `bin/hugo-build:47`
  builds with `hugo build --noBuildLock --environment <env> --destination
  <dir>` and `Hugo#precompile` (`test/support/hugo_helpers.rb:24-38`) with a
  bare `hugo --destination <dir>`; only the CI Pages build
  (`.github/workflows/_hugo.yml:82`) cleans. Hugo does not remove outputs
  whose source is gone, so an orphaned page or asset persists in every local
  `_dest/` tree until someone `rm -rf`s it. Note this is NOT the staleness
  probe failing - `bin/build-if-stale` handles deletions correctly (it
  probes DIRECTORIES, whose mtime a delete bumps). The tree is genuinely
  rebuilt and STILL serves the deleted file, which is why the usual
  "did it rebuild?" reflex diagnoses it wrong.

  Consequence for any rendered-output test: **deleting a source file to
  prove a test goes RED proves nothing.** On 2026-08-20 a new og:image test
  stayed green through three delete-and-rerun attempts against a stale
  `_dest/public-test-local`. Clear the dest dir before trusting a RED, the
  same way a screenshot baseline must be COMMITTED before trusting a
  re-record (both are "the assertion is right, the input is stale").

- **The NULL CHANGE: a diff that passes every gate and alters nothing at
  runtime** (2026-08-21, four instances in one phase). Every gate here is
  designed to catch a change that does the WRONG thing. None catches a change
  that does NOTHING, because nothing is indistinguishable from no-regression.
  The four, all caught only by asking "what does this alter at runtime?" AFTER
  the edit looked finished:

  | Change | Why it was null |
  |---|---|
  | An eyebrow rule in `critical/careers-critical.css` | `pages/careers.css` redeclares the same selector at equal specificity and loads LATER |
  | A screenshot assertion for `/friday-report/` | the test name was not in `CRITICAL_TESTS`, so `bin/test` never ran it - suite reported the same 34 runs / 53 screenshots |
  | Tokenising `components/c-button.css` | `c-button--*` appears zero times in markup; absent from the whole production tree |
  | A DevTools recipe added to a concept | its last statement was the cleanup call, so pasting it returned `undefined` and discarded the result it promised |

  Each produced a clean diff, a green suite and a plausible commit message.
  **Before counting a change done, name the observable it moves** - a computed
  style, a rendered pixel, a test that newly runs, a byte in the built output -
  and check that one thing. "The suite is still green" is consistent with
  having changed nothing at all.

- **Test the instrument, not just the result: run it against a case where the
  answer is KNOWN to differ** (2026-08-21). A null change does nothing and is
  at least silent about it. A wrong instrument RUNS, returns a plausible
  number, and gets believed.

  The real instance: `okf_validate .okf --strict | grep -c 'warn'` also matches
  the summary line `✓ conformant (89 warning(s))`, so it returns 90 - every
  warning total published on 2026-08-21 was one high, including the totals
  inside an argument about not trusting written numbers.

  **The check cuts both ways, and that is the point.** The same day, this file
  nearly recorded a second instance: `grep -rc 'c-button--primary'
  _dest/public-dev/css/*.css` returning 0, dismissed as vacuous on the theory
  that the bundles ship inline via `partials/assets/css-inline.html` and never
  land under `css/`. Running the positive control refuted that in one command -
  `blog-eyebrow`, a class known to be adopted, returns **13 files** through the
  exact same glob. The command can differ, so it is a valid instrument, and its
  0 was a TRUE reading: `c-button` lives in 2 source files that reach 0 bundles.
  The accusation was as unevidenced as the measurement it accused.

  So the control is not "run it somewhere else" - re-running the c-button grep
  against a production tree proves nothing, because `css-inline.html` inlines
  the bundle in every environment and only adds `minify` under
  `hugo.IsProduction`. The control is **a positive case through the identical
  command**: a class, string, or file you already know is present. If the known
  positive also returns nothing, the command is looking in the wrong place. If
  it returns a count, the zero you got is real.

    Worked once immediately, on this very entry: `grep -c` for the new wording
    returned 0, and so did the positive control - both phrases wrap across lines
    and `grep` is line-oriented. The control refused the answer instead of
    confirming a false one. Flatten first (`tr '\n' ' ' < file | tr -s ' '`),
    then grep; same reason `marketing_copy_test` misses banned phrases split
    across two template lines.

    Caveat on that flattened form, found 2026-08-21 while using it: the result is
    ONE line, so `grep -c` - which counts matching LINES - can only ever return 0
    or 1. A control expecting "2 occurrences" silently reads 1 and looks like a
    failed edit. Use `grep -o PATTERN file | wc -l` for counts, and keep `grep -c`
    for present/absent only.

    The two fixes COMPOSE and must be applied together: `grep -o` on the raw file
    still misses a wrapped phrase, and `grep -c` on the flattened file still caps
    at 1. Counting occurrences of possibly-wrapped text needs
    `tr '\n' ' ' < file | tr -s ' ' | grep -o PATTERN | wc -l` - piped, so it
    leaves no throwaway file behind and cannot clobber one that already exists.
    Each fix was applied alone first, and each alone still read 1.

A third instance, 2026-08-21: two identical `verified` entries looked like a
duplication artifact, and `git log -S <timestamp>` returned exactly ONE
commit - read as proof one commit emitted both. `-S` selects every commit that
CHANGES a string`s occurrence count - additions, removals, deduplications,
reintroductions - so ONE hit means one net count change, not one event. Do not
freeze such a count into prose either: the number this file first recorded was
stale within the same PR, because the commits fixing the entry changed the
occurrence count the entry was citing. The parent commit held
two DISTINCT entries that a timestamp-repair commit had normalised, so the
"duplicate" was a real verification and deleting it destroyed provenance.
Positive control that would have caught it in one command: read the file at
the parent commit.

A fourth, 2026-08-21, and the cheapest to avoid: stamping a concept with
`gsub(old_time, new_time)` rewrote the previous `verified` EVENT as well as
`generated.at` and `timestamp`, silently deleting a real verification. A global
replace does not know which occurrences are the same fact. Append the new event,
edit `generated.at`/`timestamp` in place, and READ the whole `verified` block in
the diff before committing - no `-` line should touch an event you did not mean
to remove.

That instruction replaces a grep this file carried through four corrections
(unscoped, then wrong base, then blind to the block form `- by:` / `at:` that
`ci-gates.md` actually uses). Per the delete-dont-patch rule above, the check is
gone rather than patched a fifth time: reading the block has none of those holes.

- **An empty query result is not evidence of absence** (2026-08-21). Hunting a
  black band on `/services/`, `document.querySelectorAll('path.fl-shape')`
  returned `[]`. That read as "no shape layer on this page" and an entire
  theory of an undetectable painter got built on it. The real answer: services
  uses `<rect>`, the homepage uses `<path>`, and the layer was in a rule
  already edited once. Match on the CLASS or the container, never the element
  name - and when a query comes back empty, suspect the query before
  concluding the thing does not exist.

- **A `skip_area` mask can blind a gate completely, at any tolerance**
  (2026-08-21). All four blog-index screenshots mask BOTH `.blog-post` and
  `.post-feature` (`test/system/desktop_site_test.rb:34,42`,
  `test/system/mobile_site_test.rb:25,33`) - and `.post-feature` IS the
  feature slot the blog index was rebuilt around.

  **Scope it precisely** (narrowed 2026-08-21 after review - the first draft
  said "the entire content area" and "2.1 and 2.2 shipped through that hole",
  both overstated). The masks hide the LISTING ROWS and the FEATURE SLOT only;
  the lead, filters, CTA band and pagination on that page remain covered. And
  the POST template has 24 dedicated baselines of its own, so Phase 2.2 was
  never unguarded. What went unseen is Phase 2.1's rows and feature slot.

  This is strictly worse than the 2% tolerance trap above: tolerance is a
  STATISTICAL blindness that a big enough change defeats, a mask is a
  STRUCTURAL one that no change defeats. Masks are usually added for a good
  reason (post content churns as posts are added, so unmasked baselines would
  never settle) - but a mask over a COMPONENT rather than over dynamic TEXT
  silently removes it from coverage forever. When adding one, mask the
  smallest volatile region, and grep the mask list before trusting a green
  run on a component you just changed.

- **Local gates are the merge authority while CI is unreliable** (Paul,
  2026-08-21: "use local tests for now, CI is under attack is not reliable").
  CI checks become informational; gate on `bin/rake test:unit` +
  `bin/hugo-build` + `bin/qtest --changed`, plus the macOS `bin/test` leg for
  visual work, and quote those results in the PR. **macOS only** - never cite
  `dtest` from a worktree (vacuous-green, above).

  The consequence must be stated, not hidden: work that moves Linux baselines
  ships on macOS evidence, so **master's Linux screenshot job goes red and
  stays red** until one batched CI dispatch re-records. That is accepted,
  written-down debt - PR #518 carries it - and it is cleared by CI, never by
  recording locally. Say so in the PR rather than letting a reader assume
  both legs were run.

- **Quote the compared COUNT, not just "0 failures"** (2026-08-21). A suite
  that compared nothing and a suite that compared everything both print
  `0 failures`. The distinguishing line is
  `[snap_diff] N screenshots compared, no failures.` - cite the N. #518 cites
  `53 screenshots compared`, which is what makes its green legible as
  evidence rather than as an absence of errors.

- **A rendered-output sweep can look thorough and check almost nothing**
  (2026-08-20). Count the DISTINCT values a sweep actually resolves before
  trusting its breadth - a glob over 1757 files is not coverage. The first
  `og_image_resolves_test.rb` matched `property="..." content="..."` as a
  FIXED attribute sequence. Two facts collapsed 1297 tag matches to ONE url
  checked: most values are off-origin CDN urls that fell through the
  same-origin filter, and the theme partials
  (`themes/beaver/layouts/blog/list.html:23`,
  `themes/beaver/layouts/partials/page/cover_image.html:3,:11`) write
  `content=` BEFORE `property=`, so the content-first tag on 480 pages was
  dropped. Those pages still matched via their property-first tag, which is
  why nothing looked wrong - what was lost was one whole distinct image.
  Match whole tags and extract the attribute separately.

  The trap underneath: **a reproduction test can be honestly RED for the
  right reason and still cover nothing else.** RED->GREEN passed cleanly
  because the single path the sweep reached WAS the defect under repair.
  Coverage and correctness are independent; proving the second says
  nothing about the first.
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
  Same rule bites SUBdirectories of a tracked dot-dir: `.stitch/*.md` is
  tracked but `.stitch/designs/` is ignored, so a source file placed there
  is invisible (2026-08-20, the og:image plate source). **`git add <path>`
  ERRORS on an ignored path; `git add -A` just silently omits it** - which
  is the case for staging by explicit path when a commit's value depends on
  a specific file actually landing.
- REPORT-ONLY build gates (each flips to blocking once its backlog hits
  zero via an env flag): `bin/check-svg-floor` (`SVG_FLOOR_BLOCK=1`)
  catches course SVGs whose smallest text renders <9px@390;
  `bin/check-course-paths` (`COURSE_PATH_BLOCK=1`) catches lesson
  `Next:`/branch drift vs `data/course_sequence.yaml`. Both are standalone
  (NOT yet wired into hugo-build/CI), carry a `--self-test`, and print a
  burn-down list + exit 0 until their env flag is set. (A landing-parity
  variant was tried and dropped as redundant - YAGNI: a report-only gate
  nobody wires in earns its keep only when it guards an active backlog.)
- Running a suite with multiple files - `ruby a_test.rb b_test.rb` - silently
  executes only the FIRST file. A guard test covers this (2026-07-31, R3-1);
  use rake tasks or `-n` filters, never a multi-file ruby invocation.

# What `okf_validate` actually guards

**First: which validator you run decides whether ANY of this is checked.**
`CLAUDE.md` routes agents through `/okf:validate`, which runs the installed
`okf@scaccogatto` plugin - a **v0.1** checker with no `check_trust` at all. Under
the documented workflow every `generated`/`verified` defect passes silently. To
actually check the trust family, invoke the v0.2 checker by path:

```bash
uv run ~/.agents/skills/validate/scripts/okf_validate.py .okf --strict
```

**Neither exit code is a usable trust gate on this bundle, so READ THE OUTPUT.**
Without `--strict` the exit code is error-only, and trust defects are warnings.
With `--strict` it exits 1 on ANY warning - and this bundle always carries some
(the log-heading deviation below guarantees it), so strict is permanently red
here and says nothing specific. Grep the output for `§5.2` to see the trust
findings.

The TRUST-FIELD paragraphs below describe THAT validator only - run the plugin
route and none of them apply. The error-only conformance behaviour further down
applies to BOTH checkers: each warns on malformed log headings and computes its
checkmark from errors alone.

**It checks trust-field SHAPE, and a missing `at` slips through.** The v0.2
`check_trust` requires `generated` to be a mapping, requires `generated.by`,
validates actor shapes, and shape-checks instants - and `--strict` turns every
one of those warnings into a failure. Two holes worth knowing:

- `check_instant` returns early on `None`, so `verified: [{ by: claude/opus-5 }]`
  with no `at` passes.
- The `RFC3339` pattern makes the time, the seconds AND the timezone optional, so
  `2026-08-21T05:30` and a bare `2026-08-21` both pass.

So a green run is real evidence about shape - do not dismiss it - but it cannot
tell you an event HAS a time, and it can never tell you a recorded time is TRUE.
Six review rounds on PR #538 turned on exactly that and no tool caught any of it.

**`✓ conformant` is an ERROR-ONLY verdict, not a §11 verdict.** v0.2 §11 has
three conditions: parseable frontmatter on every non-reserved `.md`, a non-empty
`type` in every block, and reserved files (`index.md`, `log.md`) following §8 and
§9. The third surfaces as WARNINGS - `check_log` warns and never errors - and
conformance is computed from errors alone.

This bundle is a live example: its `log.md` uses themed date headings
(`## 2026-08-21 - <theme>`) where §9 wants a bare `## YYYY-MM-DD`, so the
validator warns on each and still prints the checkmark. **Green and not
§11-conformant at the same time, both true.** Every `okf_validate ... exit=0`
quoted in this repo means "no errors".

That heading style is a DELIBERATE deviation already recorded in
[log.md](/log.md) (2026-08-21): the bundle lands several thematic entries per
day, and bare dates would produce a stack of identical headings. The conformant
repair is one dated heading per day with the themes as ENTRIES beneath it - bold
labels or list items, since §9 wants a flat list of date-grouped entries. Nested
`###` headings would look warning-free (the validator only inspects `##`) while
still violating §9. Either way it is a restructure of the whole file, not a
find-and-replace. Do not sweep it casually.

**Two OKF specs live on this machine and their section numbers disagree.** The
`/okf:okf` skill ships and points at
`.claude/plugins/cache/.../skills/okf/reference/SPEC.md`, which is **v0.1**,
calls itself "the source of truth", never defines `generated` or `verified`, and
numbers §5.2 as "Relative links". The v0.2 spec at
`~/.agents/skills/okf/reference/SPEC.md` makes provenance, trust, lifecycle and
attestation first-class and numbers §5.2 as "Trust: `generated` and `verified`".
**This bundle is `okf_version: "0.2"`, so the v0.2 copy governs.** Only the v0.2
validator checks the trust family and the §13.1 `sources` convention.

That mismatch cost two confident wrong rejections of a correct review finding on
#538 - §5.2 looked up in the v0.1 copy, twice - and a §9/§11 slip, since v0.1 §9
was conformance while v0.2 §9 is log structure. When a spec section is cited,
resolve WHICH copy before disputing it.

## Verifying production builds locally

A plain production build hard-codes absolute asset URLs at the live domain, so
a browser pointed at the local tree **silently loads the LIVE site's
stylesheet** - every computed-style check then measures the wrong CSS and
passes or fails meaninglessly. Build with `BASE_URL` set to the local origin
and confirm the page loads its own fingerprinted `.min.<hash>.css` before
trusting any computed value (caught 2026-08-21 during the pilot column-fix
verification; the earlier "inconclusive" production check had exactly this
cause).

# The noise floor is per-PAGE, not per-repo (measured 2026-08-22)

The ~1e-6 above was measured on macOS, locally, on a static page. CI amd64 is
different, and the difference decides whether a tolerance may be lowered.

**Method**: two `update-baselines` dispatches of the SAME commit, ~12 hours
apart, compared file by file. Anything that moves between two recordings of
identical content is render noise by definition.

**Result**: **135 of 147 Linux baselines were byte-identical.** CI is
deterministic for ~92% of pages. The remaining 12 split cleanly:

| Pages | difference_level | What they are |
|---|---|---|
| 11 | 0.0003 - 0.002 | mermaid diagrams, syntax-highlighted code, course + about + clients pages - font and SVG rasterisation |
| 1 | 0.0425 (max_delta 238) | `mobile/blog/index/_pagination` - a real content difference, not noise |

**The consequence that matters: every one of those 11 noisy pages already pins
`tolerance: 0.03` at its call site.** Those pins are LOAD-BEARING on CI, not
legacy padding left over from the blind era. Lowering them toward the 0.0001
default - which an earlier plan proposed as a tidy-up - would redden CI
permanently on pages that have no defect.

**Rule.** Before lowering any pinned tolerance, measure that page's noise on
the platform that will judge it, by recording it twice on the same commit. The
floor for a page is its measured noise, not the repo default. A tolerance that
looks like slack may be the only thing absorbing a rasteriser.
