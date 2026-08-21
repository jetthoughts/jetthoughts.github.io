---
type: Playbook
title: Test gates and when they block commits
description: bin/qtest --changed is the routine gate; bin/rake test:critical at milestones; bin/test AND bin/dtest once at PR prep (or on explicit confirmation) for themes/, layouts/, or CSS changes.
tags: [testing, visual-regression, gates]
status: stable
generated: { by: claude/opus-4-8, at: 2026-08-12T20:20:00Z }
verified:
  - { by: claude/opus-5, at: 2026-08-21T04:01:38Z }
  - { by: claude/opus-5, at: 2026-08-21T03:27:09Z }
  - { by: claude/opus-5, at: 2026-08-20T23:11:35Z }
  - { by: claude/fable-5, at: 2026-08-01T11:30:00Z }
  - { by: claude/sonnet-5, at: 2026-08-20T00:00:00Z }
  - { by: claude/opus-5, at: 2026-08-20T21:43:35Z }
  - { by: claude/opus-5, at: 2026-08-20T21:47:30Z }
timestamp: 2026-08-21T04:01:38Z
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

# Tolerance policy

**0.0 for refactors** (a refactor must move zero pixels), **<=0.03 for
genuinely new features**. This is the policy for what you ACCEPT, distinct from
the mechanical defaults: `DEFAULT_SCREENSHOT_CONFIG` is 0.02
(`test/application_system_test_case.rb:87`) and individual calls may pin their
own (e.g. 0.03 at `test/system/blog_special_content_test.rb:136`).

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
- **Flat-file posts are invisible to the visuals ratchet** (2026-08-20).
  `bin/check-post-visuals` globs `content/blog/*/index.md`, so a post living as
  a flat file (`content/blog/2025/<slug>.md`) is outside the ratchet population
  AND outside page-bundle tooling - no pre-rendered mermaid, no local cover.
  Converting one to a bundle preserves its URL as long as the `slug`
  frontmatter is set, and adds it to the ratchet. The script self-reports slack
  (`post-visuals: floor is loose, lower FLOOR to N`) - obey it: `FLOOR` dropped
  78 -> 72 on 2026-08-20 on the script's own prompt.
- **`FORCE_SCREENSHOT_UPDATE=1` re-records EVERYTHING** (2026-08-14). On
  `bin/dtest` it also disables the `git checkout -- .../linux` guard that
  normally discards sub-tolerance Rosetta drift, so a run rewrites all 45
  Linux baselines rather than the few your change moved. On `bin/qtest`
  the flag appears to be ignored entirely - the suite still compares.

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
  `test/system/blog_special_content_test.rb:136` - NOT the 0.02
  `DEFAULT_SCREENSHOT_CONFIG` in `test/application_system_test_case.rb:87`,
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
  run the suite, keep the rewritten PNG, COMMIT it; only then can a rerun go
  green.
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

A third instance, 2026-08-21: two identical `verified` entries looked like a
duplication artifact, and `git log -S <timestamp>` returned exactly ONE
commit - read as proof one commit emitted both. `-S` counts when a string
first appears, not how many events a line represents. The parent commit held
two DISTINCT entries that a timestamp-repair commit had normalised, so the
"duplicate" was a real verification and deleting it destroyed provenance.
Positive control that would have caught it in one command: read the file at
the parent commit.

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
