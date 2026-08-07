# Bundle Update Log

## 2026-08-01 (W2 T7 escalation) - canon deposit row carries the cancel split

* **Update**: [content/course-canon.md](content/course-canon.md) - deposit row
  "$500+ refundable" was missing the customer-cancel-forfeit / founder-cancel-
  100%-refund split that 5.6's DPA clause 3 and the audit-runbook table already
  carry; the bare "refundable" phrasing caused 3 in-course drift instances
  fixed in W2-T7 (e4850eaf). Row synced; floor and mechanism unchanged.

## 2026-08-01 (O5a) - restore-on-green now OS-scoped

* **Update**: [build/test-gates.md](build/test-gates.md) - green runs restore
  only the OS dir they wrote (macos/ vs linux/), unblocking parallel
  test+dtest in one checkout (devx backlog O5(a); O5(b) worktree-compose
  isolation still open).

## 2026-08-01 (W1 landing merge) - vacuous worktree-dtest caveat

* **Update**: [build/test-gates.md](build/test-gates.md) - new caveat: `bin/dtest`
  run from a git worktree passes vacuously (worktree `.git` pointer file is
  outside the container mount → no baselines → everything records as "new");
  the two tells and the detached-HEAD recipe for an honest Linux leg recorded.
  Learned closing W1 (PR #428 merge gate).

## 2026-08-01 (v0.2 migrate) - bundle-wide v0.1 -> v0.2 field migration

* **Update**: ran the validator `--migrate` across `.okf/` (the skill-sanctioned
  path for a whole v0.1 bundle - do not hand-edit). Mechanically converted every
  legacy `timestamp` to `generated: { by: process:okf-migrate, at: <original> }`
  (29 files) - an honest `process:` actor, NOT `human:`, so no fabricated review
  tier; original dates preserved. Also folded the parseable `# Citations` link in
  `architecture/css-pipeline.md` into `sources`. No external URLs dropped
  (verified); the two dropped plain-text citations were `postcss.config.js`
  (already the `resource`) and a repo doc path.
* **Note**: 12 `# Citations` body lists remain (soft warnings) - their conversion
  to `sources` is semantic, done migrate-as-touched. 31 log date-heading warnings
  are the deliberate house-style suffixes on this append-only history.

## 2026-08-01 (v0.2) - bundle adopts OKF v0.2 provenance/trust/lifecycle

* **Update**: [root index](/index.md) - `okf_version` bumped 0.1 -> 0.2; added a
  conventions note for the new optional frontmatter families (`generated`,
  `verified`, `status`, `stale_after`) and the actor convention
  (`<producer>/<version>` / `human:<id>` / `process:<id>`).
* **Update**: [test-gates](/build/test-gates.md) - migrated to v0.2 trust fields:
  `status: stable`, `generated`/`verified` by `claude/fable-5` (the caveats were
  empirically verified this session - dtest x3 byte-identical, bin/test x2 green).
  Replaces the bare `timestamp`.
* **Note**: the other 34 concepts keep v0.1-style frontmatter (still conformant
  under v0.2); they migrate honestly as maintainers touch them. No back-stamping
  of provenance nobody performed.

## 2026-08-01 (later) - dtest drift verified, CI back to critical, PR #425 review

* **Update**: [test-gates](/build/test-gates.md) - ran `bin/dtest` x3 to hunt
  flakiness. All 3 runs BYTE-IDENTICAL: only 7 mobile-codeblock screenshots red,
  same diff_levels every run = deterministic amd64-emulation antialiasing, NOT
  flaky. mermaid is now GREEN (self-hosted fonts + fonts.ready + CI re-record
  fixed the drift) - the earlier "10 stale linux baselines" narrows to 7, all
  green on CI-native. Trust CI; do NOT re-record locally.
* **Update**: CI reverted PR runs to `test:critical` (was briefly `test:smoke`) -
  the skip_area fix already makes critical ~46s on CI, so full 34-test coverage
  costs little; smoke stays the local/dispatch fast tier. `.github/workflows/test.yml`.
* **Fix**: `bin/test --smoke <file>` now rejects trailing file args (exit 2,
  fail-fast before build) instead of silently ignoring `--smoke` (CodeRabbit
  PR #425). Rakefile `SMOKE_TESTS` unanchored `test_course_landing` kept
  intentional (matches both mobile + desktop course-landing renders).
* **Creation**: [snap-diff-upstream-issues](/docs/20-29-testing-qa/screenshot-testing/20.11-snap-diff-upstream-issues-reference.md)
  - two paste-ready gem bug reports: `Reporters::Default#generate` TypeError when
  `failed_by` is the `"missing_image"` String; skip_area zero-match 5s wait.
* **Update**: [test-speed-research-todo](/docs/20-29-testing-qa/screenshot-testing/20.10-visual-suite-speed-research-reference.md) -
  added the drift-overview procedure for removing a skip_area/tolerance mask
  (read `snap_diff_report.html` heatmap, one mask at a time, which masks to KEEP).
* **Update**: CLAUDE.md - onboard via `/okf:okf`, run `/okf:okf maintain` before
  every commit, default coding posture `/ponytail:ponytail ultra`.

## 2026-08-01 - smoke test tier + test-speed profiling

Profiled the visual suites (`TESTOPTS=--verbose bin/test`). Finding: ONE test,
`test_codeblock_language_styles` (desktop+mobile), is 98.8s+97.2s = ~196s = 44%
of the full 67-test / ~450s run - it loops 8 code-fence sections each doing a
multi-capture `assert_stable_screenshot`. It also errors in the snap_diff Default
reporter (`reporters/default.rb:25`, Symbol into Integer via String#[]) whenever
a delayed codeblock diff needs formatting - external-gem bug, not monkeypatched.

Shipped a smoke tier: `test:smoke` rake task + `bin/test --smoke` flag (reuses
the build + restore-on-green wrapper; `bin/dtest --smoke` passes through to the
container). 17 curated basics+bummers, excludes the `_sections` sweeps and the
codeblock elephant. Measured: host 50.5s green (17/17), Docker 41.6s (Docker
~18% faster, confirming the "Docker is faster" report) with 1 known-stale
failure (linux mermaid baseline diff_level 0.0693, byte-identical across runs -
see project-stale-linux-baselines-pending, NOT a smoke defect). vs bin/test
critical ~300s -> smoke is ~6x faster. Smoke is NOT a milestone/PR gate;
test:critical + bin/dtest at PR prep stay the bar.

Parallel-test execution (host process-sharding + Docker) deferred as a written
spike: docs/docs/20-29-testing-qa/screenshot-testing/20.10-visual-suite-speed-research-reference.md (O1 kill the codeblock
elephant, O2 process sharding, O3 Docker-vs-host, O4 direct-visit). Thread
parallelism is out - Capybara.threadsafe=false + shared current_driver global.
Code: Rakefile (SMOKE_TESTS + test:smoke), bin/test (--smoke flag).

## 2026-08-01 - real elephant found (skip_area waits) + self-hosted fonts/mermaid

The 196s codeblock elephant was NOT stability retries and NOT font swaps -
instrumented probe showed the stable loop exits in 2x0.6s attempts; the ~10s
per screenshot was the gem resolving skip_area CSS selectors via
`all(selector, visible: true)`, where Capybara waits default_max_wait_time
(5s) for EVERY selector with zero visible matches (`%w[picture img]` on the
image-less codeblock fixture = 10.05s x 13 screenshots). Fix at the
assert_screenshot choke point: pin `final_options[:wait] ||=
Capybara.default_max_wait_time`, wrap assert_matches_screenshot in
`Capybara.using_wait_time(0)`; plus a document.fonts.ready wait before
capture (font-swap flakiness), and the 8 stability_time_limit:1 overrides in
blog_special removed. Measured: blog_special 247s->34.9s, bin/test critical
301s->81s (green x2, zero drift), bin/dtest critical ~6-7min->46s.
Lesson: the "stability retries" theory survived two sessions and was wrong -
one attempt-level probe killed it in minutes. Profile before believing.

Same day: self-hosted Caveat + Space Grotesk + mermaid.min.js (was Google
Fonts css2 + jsdelivr). Same woff2 binaries + unicode-ranges, sha384 of
vendored mermaid IDENTICAL to the old SRI pin. Prod loses 2 preconnects +
css2 + font + CDN js round trips on mermaid pages; visual tests are now
hermetic (zero third-party network). Gate: 2 macOS mermaid baselines updated
intentionally (font deterministically ready at mermaid.run() -> SVG measures
~8% more compact; evaluated side by side, quality equivalent). Linux mermaid
baselines need a CI workflow_dispatch update-baselines run after merge -
never re-record locally (emulation drift).

Hugo build (research, no changes): 11.4s memory-render; top template costs
are _partials/img/generic.html (16.5s cumulative, 104 calls),
clients/single (1.56s avg), img/hero-big + img/hero (~14s combined);
css-inline is 100% cached. Follow-up lever if build speed matters:
partialCached on stable img partials.

## 2026-07-31 (R3-2 CI correctness + cost)

* **Update**: [ci-gates](/build/ci-gates.md) - DevX R3-2: hugo_stats.json
  moved to its own EXACT-key-only cache (restore-keys could restore stale
  stats and re-open the PurgeCSS purge-live-classes incident class via
  cache); `_dest` dropped from cache paths (~1-2 GB/job, evicted everything
  else); sync fan-out gated (workflow_run jobs skip when the sync pushed
  nothing - was ~84 no-op deploy+test cascades/day); link-check builds once
  (composite `build: 'false'` - the double build blew its 10-min timeout on
  cold caches, seen live on PR #422); test.yml checks out the PR merge
  commit (head_ref tested the tip unmerged + broke fork PRs) and records
  via `rake test:system` with an always()-gated porcelain-guarded commit
  step (a red unit test used to discard 15+ min of recorded baselines).
  Also: baseline re-record landed (2edb94d9) on the pinned stack - third
  attempt, after #417 (drafts/fail_if_new) and #418 (push race + swallowed
  retry failure).

## 2026-07-31 (R3-1 harness truth)

* **Update**: [test-gates](/build/test-gates.md) - all four test runners now
  build through the shared `bin/build-if-stale` helper (routes via
  bin/hugo-build's PurgeCSS warm-up guard, skips on warm trees); qtest shares
  bin/test's `_dest/public-test` so micro-commit gates stop paying a ~26s
  rebuild each run; `qtest --changed` now counts untracked files (was false
  green exit 0 on a brand-new CSS file); bin/test honors preset
  HUGO_DEFAULT_PATH + PRECOMPILED_ASSETS (was silently breaking bin/dtest by
  pointing the container at the wrong tree). Removed the stale "CI does NOT
  run screenshot diffs" claim (superseded by #413/#417). New gotcha recorded:
  the `.gitignore` `.*` rule kept `.githooks/pre-push` out of the repo
  entirely - the R2 pre-push guard existed only on one machine until the
  `!.githooks` negation landed; check `git check-ignore -v` for any new root
  dot-path. Guard tests added: bare `hugo --environment production` outside
  hugo-build/build-if-stale, multi-file `ruby a_test.rb b_test.rb` (only the
  first file executes), bin/test HUGO_DEFAULT_PATH contract.

## 2026-07-31 (visual gate truth fix)

* **Update**: [ci-gates](/build/ci-gates.md) - first CI baseline-record run
  ([run 30629929407](https://github.com/jetthoughts/jetthoughts.github.io/actions/runs/30629929407))
  failed with 2 root causes, both now fixed: (1) CI test builds lacked `--buildDrafts`, so the draft
  codeblock-styles fixture 404'd and the codeblock tests failed on EVERY visual run (incl. the
  new PR gate - noisy-by-construction); test.yml now sets `BUILD_DRAFTS: '1'` on its setup-hugo
  step. (2) snap_diff `fail_if_new` hard-errors on missing baselines under ENV["CI"], so record
  mode could never create a FIRST baseline for pages added since the last recording
  (vibe_code_rescue); record mode now disables fail_if_new too. Re-record dispatch after merge
  closes the pending linux/ re-baseline.

## 2026-07-31 (R2 Phase C)

* **Update**: [test-gates](/build/test-gates.md) + [ci-gates](/build/ci-gates.md) - DevX R2
  Phase C (inner loop): `bin/test` now builds ONCE via bin/hugo-build (PurgeCSS warm-up guard
  included - hugo_helpers' bare `hugo` call could purge live classes on cold caches) to stable
  `_dest/public-test`, exports PRECOMPILED_ASSETS, and mtime-skips the build when warm -
  measured cold 2m19s -> warm 0.6s for single-file runs (previously EVERY single-file run paid
  a full rebuild into one of 5 random dirs; rand(5) fan-out retired). CI: `hugo_stats.json` now
  in the setup-hugo cache (was gitignored + uncached = ~52s warm-up double-build every run);
  `_hugo.yml` warm-up exits early on cached stats; cache key fixed to hash `config/**` (old key
  hashed nonexistent root hugo.toml, so config-only changes reused stale resources/_gen).
  `test:critical` glob now recursive, matching test:system.

## 2026-07-31 (R2 Phase B2)

* **Update**: [ci-gates](/build/ci-gates.md) scope - DevX R2 Phase B2: agent containers now
  self-bootstrap - checked-in `.claude/settings.json` SessionStart hook runs
  `bin/agent-bootstrap` (bundle+bun install, libvips, pinned CfT stack via setup-test-env,
  doctor; every step warns-and-continues on blocked network; log at /tmp/agent-bootstrap.log).
  Sync code made Ruby>=3.3-compatible (three `it` block-params replaced with named params +
  a missing `require "time"`) - `rake test:unit` now 275/275 green on the container's 3.3.6
  (was 71 errors; agent sessions can finally run the unit gate). NEW pre-push guard
  (`.githooks/pre-push`, installed by bin/setup via core.hooksPath): lint-css ratchet +
  course validators + toolchain-pin/bin-script guard tests in ~5s; bypass SKIP_CHECKS=1.
  Gotcha: `.claude/**/*.json` is gitignored - settings.json needed a `!` negation.

## 2026-07-31 (course waves + GA4 batching)

* **Update**: 2605 course project shipped Waves 0/A-H in one day (PRs #407
  Clarity + local-analytics exclusion, #408 five reference SVGs, #409 twenty
  covers, #410 Sprint D gaps, #411 Phase 2 mechanics). Durable operational
  learning worth keeping: **GA4 batches multiple events into one POST whose
  QUERY STRING carries no `en=` param - the event names live in the REQUEST
  BODY.** Verifying an event by reading the network list alone produces a
  false "did not fire" (hit on the 2.5 checkpoint verification). Read the
  request body. Recorded in runbook 20.12's verified-events table.
* **Learning (process)**: audit a backlog item's premise before dispatching
  work - 4 items this day were invalid or already-resolved (stale cover
  badge, Operating Kit templates, 7 of 15 campaign briefs absorbed, the
  "bistable render" that was a stale committed baseline).

## 2026-07-31 (R2 Phase B)

* **Update**: [ci-gates](/build/ci-gates.md) - the CI visual gate is BACK (report-only soak):
  `test.yml` now provisions the pinned rendering stack via `bin/setup-test-env` (CfT from
  `.dev/cft-version`, cached; fonts + fonts.conf) and exports CHROME_BIN/CHROMEDRIVER_PATH, so
  runner pixels match `linux/` baselines. New `pull_request` trigger (paths-filtered to visual
  surfaces) runs `test:critical` with `continue-on-error: true` - failures comment the snap_diff
  report on the PR without blocking; flip that flag off after the soak week. Record mode is
  workflow_dispatch-only, sets ALLOW_DIRTY_SCREENSHOTS=1 explicitly, and now records on the
  pinned stack (previously it would have silently overwritten canonical baselines with
  unpinned-runner-Chrome renders). Floating snap-diff composite refs pinned to the
  Gemfile.lock SHA. Re-record baselines via workflow_dispatch update-baselines=true - this
  also closes Round 1's pending linux/ re-baseline without a Docker-capable machine.

## 2026-07-31 (R2 Phase A)

* **Update**: [ci-gates](/build/ci-gates.md) + [test-gates](/build/test-gates.md) - DevX R2
  Phase A: bin/test, bin/dev, bin/build, bin/hive shebangs fixed sh→bash (dash exits 2 on
  `set -o pipefail` before line one - the Phase 1 sweep caught only 2 of 6 scripts); NEW guard
  `test/unit/bin_scripts_test.rb` fails CI on any sh-shebang script using pipefail/-E, and it
  caught bin/hive on its first run. `bin/dtest` arg bug fixed (`t "$@"` replaced the container
  command with a bare .rb path; now `t bin/test "$@"`, mirroring dtest-all). `bin/hugo-dev`
  retired - it never exported HUGO_ENVIRONMENT so `rake dev` paid the full production
  PurgeCSS+cssnano chain per rebuild; `rake dev` now runs `bin/dev`. qtest: `privacy-policy`
  critical-CSS key added (was a hard abort), dead pages/careers test branch removed, dirty
  guard now honors ALLOW_DIRTY_SCREENSHOTS and points at the reset task. ci-gates concept
  updated: the Alpine/musl premise for excluding visual CI is obsolete (pinned glibc stack);
  R2 Phase B plans the re-introduction. README/SETUP truth pass #2 (broken doc links,
  fictional coverage section, dead SELENIUM_BROWSER env, setup-test-env now documented).

## 2026-07-31

* **Update**: [test-gates](/build/test-gates.md) - new leading caveat: snap_diff
  baselines are **git HEAD, not the working tree**, so un-committed "accepted"
  baselines change nothing and an identical difference_level across runs means
  a stale committed baseline (not a flaky render). Case study: #405's 28px
  mobile hero gap merged with a "re-record on next run" note instead of updated
  baselines; every later local run failed at 0.2747 until re-record+commit.

## 2026-07-30 (Phase 4)

* **Update**: [test-gates](/build/test-gates.md) scope - DevX Phase 4: canonical visual rendering stack defined - `.dev/Dockerfile` moved ruby:3.4-alpine → ruby:4.0-slim (glibc; Alpine/musl was why linux baselines diverged 3-28% from every real Linux) with pinned Chrome for Testing + chromedriver (`.dev/cft-version` = 141.0.7390.37), deterministic fontconfig (`.dev/fonts.conf`: hintslight, grayscale AA, no embedded bitmaps), fonts-noto-core/freefont/dejavu. `bin/setup-test-env` installs the identical stack bare-metal (CfT cached under ~/.cache/jt-cft/<v>; `eval "$(bin/setup-test-env --print-env)"` exports CHROME_BIN/CHROMEDRIVER_PATH). Bare-metal verified green in an agent container. PENDING on a Docker-capable machine: build image, `FORCE_SCREENSHOT_UPDATE=true bin/dtest` once, commit re-recorded linux/ baselines in the same PR - until then linux/ baselines are still Alpine-rendered.

## 2026-07-30 (Phase 5)

* **Hygiene**: DevX Phase 5 - 9 orphaned agent-era markdown files (~108 KB, closed reference island, all frozen 2026-07-18) moved to `docs/projects/2509-css-migration/70-79-archives/agent-era/`: 3 from repo root (AGENT_COORDINATION_FAILURE_ANALYSIS, coordination, memory-bank) + 6 ALL-CAPS protocol docs from `test/system/`. Executable bits cleared on the two mode-0755 markdown files. Stale `/Users/pftg/...` absolute paths fixed in GEMINI.md/QWEN.md (live pointer files - they stay at root by CLI-tool convention, as do DESIGN.md/PRODUCT.md/AGENTS.md which are resolved at root by the impeccable skill's context.mjs). Rule of thumb: grep for inbound references before moving root docs - the load-bearing set is invisible to grep (tool conventions), so check `.agents/skills/impeccable/scripts/context.mjs` name lists too.

## 2026-07-30 (Phase 3)

* **Update**: [test-gates](/build/test-gates.md) scope - DevX Phase 3: the qtest-only dirty-baseline guard now runs at system-test load (`test/application_system_test_case.rb`) for ALL runners (bin/test, bin/dtest, rake) - refuses to start on dirty `test/fixtures/screenshots`, companion `bin/rake test:screenshots:reset`, bypass `ALLOW_DIRTY_SCREENSHOTS=1`. Browser overrides `CHROME_BIN` + `CHROMEDRIVER_PATH` in `setup_capybara.rb` make the suite runnable in agent containers (proven: color_system test green against Playwright Chromium 141 + matching chromedriver). All 11 `File.read` sites in `lib/` now force `encoding: "bom|utf-8"` - validators no longer crash under non-UTF-8 locales (`LANG=C bin/validate-course` green).

## 2026-07-30 (Phase 2)

* **Update**: [ci-gates](/build/ci-gates.md) - DevX Phase 2: `.mise.toml` is now the toolchain single source of truth (hugo 0.164.0 / bun 1.3.13 / node 22 / ruby 4.0.6), enforced by `test/unit/toolchain_pins_test.rb` drift gate in CI. `_hugo.yml` de-duplicated onto the setup-hugo composite (new `build` input). `bin/setup` rewritten: mise install + brew/apt system libs + bun install + `bundle install` (previously missing!) + doctor with per-item fixes. Brewfile now system-libs-only (mise/vips/lychee). README/CONTRIBUTING corrected (Hugo badge was 17 minor versions stale, 3 fictional test commands, `hugo server -D` → `bin/dev`); `docs/SETUP.md` created (4 links already pointed at it). Gotchas: `.ruby-version` must be an exact patch (rbenv never matches fuzzy "4.0"); repo `.gitignore` ignores all dotfiles - `.mise.toml`/`.ruby-version` needed `!` negations.

## 2026-07-30

* **Update**: [test-gates](/build/test-gates.md) - DevX Phase 1: `bin/docked`/`bin/dc` shebangs fixed to bash (`set -o pipefail` is a bashism; dash rejected it, breaking `bin/dtest` on Linux hosts); new `bin/lint-css` stylelint ratchet (cap 377, wired into CI unit_tests job); dead `SCREENSHOT_DRIVER` env removed from test.yml (driver hardcoded `:vips` in setup_snap_diff.rb). Last 2 `site.Data` call sites migrated to `hugo.Data` (deprecation gone from build output); stale `package-lock.json` deleted (bun.lockb is the only lockfile). Agent-container caveat: Docker Hub blob CDN is 403 through the agent proxy, so dtest is unavailable there - use full-build HTML diff for template-neutrality proof.

## 2026-07-26

* **Milestone**: Vibe Code Rescue landing page built at `/services/vibe-code-rescue/` (branch `landing-vibe-code-rescue`, card #14) via the impeccable pipeline (init → document → build): PRODUCT.md + DESIGN.md + sidecar now exist at repo root as design authority. JetVelocity brand tokens extracted to `foundations/css-variables.css` `:root`.
* **Gotchas** (recorded in `docs/workflows/new-page.md` §Dark-page traps): legacy-theme-skin whitewashes `.fl-page-content` after page slices; site chrome sits outside the page div so page-scoped vars don't reach the header; the `:not()`-chain anchor rule needs `!important` to beat; the mobile drawer is a white panel — drive the menu-open state at 390×844, closed-state screenshots can't see it.

## 2026-07-25

* **Policy**: async-first communication is now repo SOP for all agents — skill at `.agents/skills/async-first-communication/SKILL.md`, exposed via AGENTS.md `<skills>` block + CLAUDE.md Behavioral Constraints + operating-system.md §5. OKF maintenance is now ENFORCED parallel-by-default (dispatch okf-maintainer alongside main work; weekly scheduled back-fill as safety net).
* **Update**: [outbound-sprint](/workflows/outbound-sprint.md) - discovery-call tooling: Fathom free (bot-free capture + MCP; Google Meet flags bot-join recorders since Apr 2026), Gemini-notes fallback, consent line, transcript→3-artifacts pipeline, optional capped pre-call repo pass.
* **Gotcha**: repo `.gitignore` line 28 ignores ALL dotfiles (`.*`) — any new dot-directory artifact (like `.agents/`) needs an explicit `!` negation or it silently never gets committed while docs point at it.
* **Update**: `docs/workflows/new-page.md` §8 — design toolchain for conversion/marketing pages: impeccable (init→document→shape, Persuade mode) as the design engine + hugo/copywriting + frontend-design + impeccable live iteration + ponytail discipline + devtools/webperf gates + critique/audit pre-PR. Ponytail plugin installed and enforced globally (~/.claude/CLAUDE.md); impeccable skill installed. Board card #14 carries the same stack.

## 2026-07-24

* **New concept**: [outbound-sprint](/workflows/outbound-sprint.md) - the 2607 rescue outbound machinery: browser-agent send runner (pre-research -> approval gate -> send -> log), daily reply monitor, pipeline.md ledger, local-only kanban convention, F5Bot/Gmail-forward routing gotchas.
* **Update**: [review-swarm](/workflows/review-swarm.md) - multi-doc kit reviews need a cross-doc drift finder + link-routing check (Joy/Nico mis-route, stale pricing in narrative docs); late finders carry real findings (3 of 6 reported after first synthesis with 3 confirmed defects); idle agents' reports recoverable from subagent transcript jsonl.

## 2026-07-21

* **New concept**: [ci-gates](/build/ci-gates.md) - what GitHub Actions enforces on a PR (build, unit, path-scoped broken-internal-link crawl via lychee in `link-check.yml`). Records that visual regression is intentionally NOT a CI gate: cross-OS pixel diffs (Alpine/musl baselines vs Ubuntu/glibc CI) diverge 3-28%, so `bin/test` + `bin/dtest` are the sole visual coverage (a CI screenshot job was built and removed in PR #386). Includes the libvips42-runtime gotcha for any future ruby-vips CI job.
* **Update**: [test-gates](/build/test-gates.md) - cross-linked to ci-gates; noted visual regression is a local-only gate.

## 2026-07-13
* **Update**: taste anchor established at `.stitch/course-taste-design.md` - Stitch-skill DESIGN.md encoding the course design language + anti-pattern bans; used as the scoring lens for taste-critic passes (see [review-swarm](/workflows/review-swarm.md)).
* **Update**: [render-verification](/workflows/render-verification.md) - render from `_dest/public-dev/` (relative URLs), never the stale repo-root `public/`; stale-tree reviews produce false missing-asset findings.
* **Initialization**: Created the bundle with build/, content/, design/, and workflows/ sections distilled from CLAUDE.md, docs/workflows/, .stitch/design.md, and the 2026-07 course review sprints.

## 2026-07-17 - M2 compression migration
Module 2 (last unmigrated module, 1,652-5,124 body words/lesson) compressed to
exemplar parity (1,265-2,038; migrated 1.4 exemplar = 1,258 on the same basis).
Depth moved to four new reference companions: mom-test-full,
persona-rehearsal-full, find-10-people-full (shared 2.3+2.4),
prototype-build-full. Operative rule learned: the 30.03 numeric bands are
unreachable when mandated keeps (full prompts, teaching tables, reuse bridges)
exceed the band - EXEMPLAR PARITY on an identical measurement basis is the
real gate, not the raw number. M3 (3.1/3.2 at ~2,900w) is the remaining
unmigrated pair.

## 2026-07-17 (later) - Full-course migration complete
M3 (3.1/3.2), M4 (all five), and M5 (5.1/5.2/5.6/5.7) migrated to v2
micro-lesson form in one 5-fixer wave; 11 new reference companions created
(every module now has its deep-dive set). Canon punch-list applied (Cursor
seat range, "Sixty percent" stat, PR #847 collision, fast/easy/free columns,
Chapter 0 -> Overview, faq 12-rules pointer). Cold-eyes M3+ reuse review
fixed 4 restart defects (5.3 warm-list seeding, SOW brief-as-scope, 5.1
persona reconciliation, PRD Section 2). No v1 long-form lessons remain.
Gotcha: claude-flow daemons recreate .git/index.lock continuously - commit
via retry loop (rm lock + immediate git add/commit, up to 10 attempts).
Voice wave (same day): 16-page opener-shape rotation shipped - max 4 pages
per shape, 4 composite-disclaimed vignettes kept, attribution phrases
("we picked up"/"we worked with") now zero course-wide. Teaching numbers
preserved as mechanism descriptions.

## 2026-07-18 - Added course architecture concepts
Added two course architecture concepts to `.okf/architecture/`:
[icp-journey-sipoc](/architecture/icp-journey-sipoc.md) — Mermaid flowchart
of Sam's full journey through all 25 lessons, gate thresholds, branch paths,
and artifact handoffs; and [operational-dependency-map](/architecture/operational-dependency-map.md)
— per-lesson operational prerequisites, template blank sources, wait times,
and Plan B recovery paths. Both distilled from
`docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/`.
Architecture index updated with the two new entries.

## 2026-07-19 (later) - Q3 content plan execution: Phase 1 expanders + snippet hygiene TL;DRs
* **Published**: 3 Phase 1 expander posts from the Q3 content plan:
  - [Falcon in Production: Benchmarks, Memory & Worker Count](/blog/falcon-web-server-production-tuning-benchmarks/) —
    worker sizing formulas, 24-hour memory curves, wrk2 benchmarks, GC tuning,
    rollback case study. 235 lines, 10/10 voice self-test.
  - [Solid Queue Advanced: Retries, Concurrency & Monitoring](/blog/solid-queue-advanced-patterns-retries-concurrency/) —
    exponential backoff, dead letter pattern, I/O profiling, dispatch config,
    queue depth alerts, preserve_finished_jobs gotcha + client story. 324 lines,
    10/10 voice self-test.
  - [Rails 8 Authentication Generator: Complete Guide](/blog/rails-8-authentication-generator-complete-guide/) —
    replaces Devise with built-in auth, sessions table, password reset,
    email verification, rate limiting, production hardening checklist,
    Devise migration case study. 347 lines, 10/10 voice self-test.
* **Cover images**: 3 new covers generated via established pipeline
  (duplicate Falcon HTML → Chrome headless 2× retina → Lanczos downsample):
  Falcon 595KB, Solid Queue 611KB, Rails Auth 600KB — all at 2400×1260.
  Covers live at `.stitch/designs/falcon-production-tuning-cover.html`,
  `.stitch/designs/solid-queue-advanced-cover.html`,
  `.stitch/designs/rails-8-authentication-cover.html`.
* **Snippet hygiene — TL;DR blocks**: TL;DR summary blocks with Quick
  start added to all 5 worst 0-CTR posts (langgraph-workflows, autogen-
  crewai-langgraph, crewai-multi-agent, langchain-memory, laravel-11-
  migration). Each includes 2-3 sentence summary + copy-paste-able quick
  start command sequence for better SERP snippet extraction.
* **Build infrastructure**: PostCSS installed (`npm install --save-dev
  postcss postcss-cli`). `bin/hugo-build` now passes clean (740 pages,
  exit code 0).
* **Bug fixes**: langgraph-workflows frontmatter `---` delimiter had
  concatenated to slug line during TL;DR insertion — split back to
  separate line. All 3 new posts + 3 covers verified in Hugo build.
* **Validation**: All 3 new posts passed blog pipeline validation
  (voice self-test 10/10, zero banned words, zero em dashes, zero
  generalized actors, zero mannerism nouns, zero definitional cadence).
  Solid Queue post received +1 internal link (Rails Auth) and client
  story (April 2026 preserve_finished_jobs disk incident).
* **Content plan** — [content-plan](/content-strategy/content-plan.md) and
  [blog-pipeline](/workflows/blog-pipeline.md) already synced.


* **New**: [content-plan](/content-strategy/content-plan.md) concept — the
  active Q3 2026 3-stream plan built from Apr–Jul GSC performance data (449
  clicks, 478K impressions, 0.09% CTR). Supersedes the ICP-E-focused 20.07
  plan. Rails technical 2/week, founder every other week, snippet hygiene
  sprint. Resource at
  `docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md`.
* **New**: [Falcon Production Tuning](/blog/falcon-web-server-production-tuning-benchmarks/)
  blog post — first Phase 1 expander from the new plan, extending the #1
  performing post (54 clicks, 0.89% CTR) with production worker sizing,
  24-hour memory curves, wrk2 benchmarking methodology, GC tuning, and
  a "when we rolled back to Puma" case study.
* **Update**: [blog-pipeline](/workflows/blog-pipeline.md) — content plan
  reference updated from 20.07 to 20.08; title constraint relaxed from ≤45
  to ≤60 chars (matches Google SERP display limit); added snippet-hygiene
  cross-link to the content-plan concept.
* **Update**: 5 worst 0-CTR blog posts had titles and meta descriptions
  rewritten per the snippet-hygiene sprint (langgraph-workflows, autogen-
  crewai-langgraph, crewai-multi-agent, langchain-memory, laravel-11-
  migration). Projected +435 clicks/3mo. Titles now all ≤60 chars.
* **Update**: [content-strategy index](/content-strategy/index.md) — added
  content-plan entry.

## 2026-07-18 - Merged blog/site bundle into course bundle
Folded a separately-produced Hugo blog/site OKF bundle into this one as two
new sibling sections: `architecture/` (hugo-site, css-pipeline, blog-list-page,
cover-image-pipeline, seo-meta-tags) and `content-strategy/`
(icp-primary-website-target, voice-guide). Added five site/content workflow
concepts to `workflows/` alongside the existing course pair: blog-pipeline,
linkedin-post-pipeline, css-maintainability-plan, visual-scroll-gate, testing.
Root index and workflows index updated with the new entries. No course-side
concepts changed; distilled from CLAUDE.md, bin/hugo-build, Rakefile,
config/_default/hugo.toml, theme layouts, and docs/workflows/ +
docs/90-99-content-strategy/.

## 2026-07-19
- bin/qtest added (scoped visual gate): PRECOMPILED_ASSETS + Minitest -n filter over an ownership-map-derived page set; ~25-60s per micro-commit vs >5 min full stack. Spec Phase C gate stack now items 4 (qtest per commit) + 5 (full suites per milestone/PR). test-gates.md updated.

## 2026-07-19 (2)
- Live incident: visible skip-link site-wide - CI PurgeCSS cold-start race (no hugo_stats.json on first pass). Fixed: safelist sr-only/skip-link (#377) + structural warm-up guard in bin/hugo-build and _hugo.yml (#378). Phase C completed and closed (PRs #371-#376).

## 2026-07-26
- Media pilot shipped: 7 hand-drawn SVGs across 4 course pages (outreach-sequence-template x3, interview-scorecard, pre-launch-checklist, channel-selection channel-fit canvas) + 2 new template pages with JetVelocity covers, wired into _index.md template lists and companion lessons 2.1/4.4. New concept: design/media-design-guidelines.md (external baseline; slides/video sections marked not-applicable - course is text-only per 30.03). Gap audit: 40.20 in project 2605; P0 rows marked shipped. Lesson re-learned: run the visual scroll gate BEFORE committing SVGs - the first cut of all 6 SVGs shipped with text-overflow/misalignment defects that one Chrome pass caught.

## 2026-07-26 (2)
- Correction: the media-design-guidelines concept added earlier today was misplaced in .okf/design/ (a rendering-spec section) and duplicated raw external research that docs/projects/2605-.../10.06-media-design-recommendations.md already distills/adopts. Removed from OKF entirely and relocated as docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.09-media-design-guidelines-external-baseline.md (source material, not an operational concept). Rule: raw external research belongs in docs/projects/<project>/10-19-research/, not .okf/ - OKF concepts are for durable operational knowledge distilled FROM research, not the research itself.

## 2026-07-26 (3)
- Correction to the correction: the doc is enforced guidelines/results, not research - moved again to docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.07-media-design-guidelines.md (the project's specs/requirements section, alongside 30.03-course-format-requirements-for-creators.md) rather than 10-19-research/. Rule refined: 10-19-research/ is for investigation/analysis docs; 30-39-architecture-design/ is for adopted, enforced specs - a doc that prescribes what creators must do belongs in the latter even if its origin was external research.

## 2026-07-26 (4) - Sourcing quality gates + lead/VoC recency split
Batch-1 send-run pre-research (send-runner-prompt Phase 1, via Claude-in-Chrome)
found 3 of 5 curated openers unsendable (6-year-old post; 1-year-old comment
mis-routed as a post; thread saturated by a competing "free" pitch). Root cause:
recency was eyeballed from search excerpts, never verified by reading the thread
timestamp. Fixes shipped: v2 qualification rubric (5 checks, hard capture-time
gates) in rescue-sprint/t4-t5-grooming.md; Paul's policy split codified — leads
must be verified ≤30 days (all venues, no exceptions), VoC quotes have no age
limit and are harvested even from dropped-stale threads. SEND-SHEET now carries
per-message GO/HOLD banners (batch-1 currently 0-for-5; Joy Adamson is the one
Paul-override candidate). Board: #28 done, #29 (re-source v2) is the critical
path. Updated: [outbound-sprint](/workflows/outbound-sprint.md).

## 2026-07-30 - Course strategy review: completion mechanics beat more media
Benchmarked the course against 4 Product Compass course pages (browser walk),
the two Lenny-podcast skill repos, and a 57-source NotebookLM learning-research
corpus, then ran a 3-persona synthesis (pedagogy / Sam-ICP / media-delta audit).
Convergent finding: the completion gap is progress MECHANICS, not media - Wave
C1 added to the TASK-TRACKER (20-min first-win path, tool-stack tables deferred
to JIT, implementation-intention lines, Clarity-gated localStorage progress
tracker, living-document trust line). Public completion certificate REJECTED:
idea-stage Sams are stealthy and won't share "I'm validating an idea"; the
Phase-2 completion artifact is the private Founder OS pack. Delta audit found
40.20's cover-based scan blind to the reference tier (5 chapters 1.8-2.5k words,
zero visuals; 19 pages coverless; true zero-body-visual count 17 not 1) and to
density (5.4k-word single-SVG walls pass) - DoD now carries words-per-visual
<=600 + worked-example fading (templates never ship blank). Updated:
[course-structure](/content/course-structure.md), TASK-TRACKER waves, GOAL-AT-A-GLANCE.

## 2026-07-30 (2) - Waves C1 + M1 shipped; Clarity config gap; sprint retro
PR #390 (1.1 two-sitting split + overview first-win path, 4-eyes reviewed) and
PR #394 (4 hand-drawn SVGs for the visual-less core lessons, designer agent in
worktree + team-lead browser walk) both merged. C1 progress tracker DEFERRED by
2-1 team vote (Sam-ICP + operator over pedagogy) - pilot data decides. P0 gap
found: `microsoftClarity` was never set in config, so the shipped Clarity
snippet collects nothing - blocks pilot recordings; one-line fix documented in
TASK-TRACKER. Retro learnings: (1) subagent SendMessage-to-main is unreliable -
synchronous spawns or nudge-pings needed, budget ~2x expected wall time;
(2) worktree isolation saved the shared checkout when the designer cd'd wrong;
(3) groomed-backlog wording can drift from page reality - agents must verify
spec numbers against page content (two catches this sprint); (4) 4-eyes critic
rounds caught 5 real voice defects my own pass missed - keep as blocking gate.
Updated: TASK-TRACKER wave states, [course-structure](/content/course-structure.md).

## 2026-07-30 (3) - Waves M2 + M3 shipped, M4 closed; media modernization COMPLETE to pilot gate
PR #395 (M2: salvage-vs-rebuild mermaid tree, where-to-hire region map SVG,
hire-track trap-vs-redline table, self-serve mistakes grouped table; 4-eyes
4/4 PASS) and PR #396 (M3: interview-scorecard + pre-launch-checklist PDFs +
channel-fit-canvas landscape one-pager; portrait clip caught in review) both
merged. M4 investigated + closed: portrait worksheet variants = single-source
violation; phone answer is the M3 PDF link; ceiling in
[house-visual-spec](/design/house-visual-spec.md). Board lesson: the
words-per-visual audit metric can't see blockquote scripts/Bad-Good pairs -
3 of 4 flagged word-walls were already healthy; assess per-H2 before
building. All agent-doable media waves (M1-M4) are now DONE; M5 + Phase 2 +
Sprint D are pilot-gated. The wave order M1->C1->M2->M3->M4 completed in one
day (5 PRs: #390/#392/#394/#395/#396).

## 2026-07-30 (4) - Growth waves G1-G3 + M5 shipped; GA4 root cause fixed
Growth runbook 20.12 created (agent-executable marketing plan; standing
decisions: fully ungated, NO mail list, no selling, stealth ICP). Shipped:
G1 docs-truth sweep + production GA4 verification which found the ROOT CAUSE
of muted analytics - privacyCompliant=true defaulted consent to denied with
no banner to ever grant it, AND click events lacked beacon transport. Fixed
in PR #402 (consent granted for analytics_storage, ads stay denied, beacon
added, plus the stealth-compatible copy-link button on 5 module-end
lessons - both visual suites green after rebuilding the stale Docker test
image from #391's gem bumps). PR #404: 10 evergreen blog posts now deep-link
8 course lessons (was 0 of ~580). PR #398: 16 pilot-gated campaign briefs.
PR #406: Wave M5 un-gated by Paul - 3 P2 SVGs (2 pages skipped as already
covered) + module-end checklists M1/M2/M3/M5 + clean interaction audits.
All wave branches cleaned. REMAINING: M5c reference-tier visuals + ~19
covers, G2.2 SERP spot-check, post-deploy GA4 re-verification.

## 2026-07-31 - bin/test port bug root-caused; restore-on-green baselines (PR #424)

Host bin/test failed 49/49 screenshots while bin/dtest stayed green. Root
cause: the R2 fast path built with baseURL=http://localhost:1314 while
Capybara boots Puma on a random port (TEST_SERVER_PORT only set in
Docker) - every stylesheet and clicked link hit a dead port. Fixed to
baseURL "/" (matching CI/qtest/Hugo#precompile). Second fix: green runs
of bin/test/bin/dtest/bin/qtest now auto-restore
test/fixtures/screenshots (red runs keep candidates; re-records exempt
via FORCE_SCREENSHOT_UPDATE), ending the dirty-fixture-guard deadlock
after every passing dtest. Also: dtest reuses warm builds. Re-recorded
12 genuinely-changed macos baselines (record mode had briefly saved
Chrome ERR_CONNECTION_REFUSED pages as baselines - caught by brightness
audit before commit). test-gates.md updated with both caveats.
Evidence: PR #424 (fix + verification transcript: host bin/test 34 runs
0 failures in 5:01 vs 29F+2E in ~11min before; bin/dtest 34 runs 0
failures; forced-red run preserved candidates). Code: bin/build-if-stale
(BASE_URL default), bin/test / bin/dtest / bin/qtest (restore-on-green).

## 2026-07-31 - warm-tree staleness trap + OS-scoped dirty guard

bin/test was red and bin/dtest refused to start. Root cause was NOT a
regression in either script: `_dest/public-test` had been built at 20:17
with the pre-#424 absolute `localhost:1314` baseURL, and #424 landed at
20:45 - but `bin/build-if-stale`'s `stale()` compares only content/theme
SOURCE mtimes against `$DEST/index.html`, so the poisoned tree was judged
warm forever. Every asset 404'd on Capybara's random Puma port; the 21:48
run rewrote 49 macos baselines with black/unstyled renders (404.png = black
canvas + inline-critical nav only; homepage/_footer.png = raw unstyled
HTML). Those 49 dirty files then tripped the dirty-fixture guard, which
globbed the WHOLE screenshots tree - and since the test container has git
(`safe.directory /app`), macOS dirt aborted the Linux leg too.

Fixes (2 one-liners + 1): `bin/build-if-stale` counts `bin/build-if-stale`
and `bin/hugo-build` as sources; the guard in
`test/application_system_test_case.rb` scopes to
`test/fixtures/screenshots/#{Capybara::Screenshot::Os.name}`;
`test/support/setup_snap_diff.rb` deletes a stale snap_diff_report.html at
load (the reporter only writes on failures, so a green run otherwise leaves
the previous red run's report describing diffs that no longer exist - it
bit on the very first green run here).

Verified: rebuilt tree emits root-relative `/css/...` with zero
localhost:1314; warm rerun still short-circuits; `bin/test` 34 runs 0
failures, 53 screenshots compared, tree auto-restored clean; with a
deliberately dirtied macos baseline `bin/test` aborts while `bin/dtest`
runs. Skipped as YAGNI: a `$BASE_URL` stamp file - no caller passes a
different base URL to the same dest (test/qtest -> public-test at "/",
dtest -> public-dtest at "/", dtest-all -> public-dtest-all absolute).

Non-issue confirmed, not changed: this Mac is in Dark Mode and headless
Chrome 151 reports `prefers-color-scheme: dark`, but the only dark-mode CSS
is `themes/beaver/layouts/shortcodes/testimonial.html` and that shortcode
has ZERO usages - the black canvas was purely missing CSS. If baselines
ever come back black on a light-mode-recorded tree, the pin is
`"blink-settings" => "preferredColorScheme=1"` in CHROME_ARGS (verified on
Chrome 151 --headless=new; `--force-prefers-color-scheme=light` is not a
real switch).


## 2026-08-01 - W2-T5: hire-track reference split + since-2011 canon

hire-track-supplementary-reference (5,558w, 2x the 2,900 reference cap)
split at the contract seam: FCTO bridge + Reading the SOW moved whole to
new companion `fractional-cto-sow-reference` (2,893w); find-developers,
stack conversation, interview screen stay (2,890w). All anchored inbound
links re-pointed (13 course pages + 2 blog posts), zero aliases. The only
whole-section 2-page partition that fits the band - FCTO (2,132w) cannot
share a page with the stack section. Two "20 years" tenure claims fixed
to since-2011 canon (kit Built-by, hire-track stack intro); ratchet
signatures added; Cagan "20 years" in hire-decision-full is distinct,
untouched.

## 2026-08-01 - Removed toolchain drift-gate unit tests (config-mirror anti-pattern)
* **Remove**: `test/unit/toolchain_pins_test.rb` deleted in full. It was a config-mirror "drift gate" asserting `.mise.toml` version pins equal the literal pins in the setup-hugo action, `_hugo.yml`, `.dev/compose.yml`, and `.ruby-version`. `test_setup_hugo_action_matches_mise` red-built on a FALSE invariant: `.mise.toml` `node = "latest"` (devs want latest) vs CI `node-version: '22'` (pinned on purpose in #393) - a correct divergence, not drift. Tests config agreement, not behavior; violates FIRST + the CLAUDE.md "no fragile config assertions" rule. Comparing CI-vs-local node explicitly was considered and rejected as overkill (Paul). Refs cleaned: Rakefile `:guards` list, `.mise.toml` / setup-hugo `action.yml` header comments, README, `docs/SETUP.md`, this bundle's [ci-gates](/build/ci-gates.md). Pins still need manual sync when bumping - now by convention, not a gate.

## 2026-08-01 - W3-T1: v3 exhibit spec appended to house-visual-spec

Added a `# v3 exhibit spec` section to `.okf/design/house-visual-spec.md`
(hand-drawn spec untouched, O1 still needs it) covering the six components
ADR 30.09 Phase A demanded: 12-col grid at a canonical 720 viewBox, 8px
spacing scale, connector spec (2px orthogonal + 4px radius O2 / hand-curve
O1), data-viz rules (fill=data / stroke=structure, ruby-for-signal,
threshold-vs-band), aspect-ratio table (mobile-safe default 3:2), and the
5-rung type scale. The >=9px @390px floor is a formula, not prose:
`rendered = font_viewBox * 390/W_viewBox`; basis rung 17px @ W=720 renders
9.21px. O1 bumps the floor x1.15 (basis 20px) for Caveat's small x-height.
Includes the action-title/one-message/basis-line grammar and an O1-vs-O2
scoring rubric so the T2 A/B pair scores both on the same axes.

## 2026-08-07 — content plan of record corrected to 20.08; cannibalization guard added

`docs/workflows/blog-pipeline.md` STEP 1 and `GOAL-AT-A-GLANCE.md` both still
named 20.07 as the plan of record, four months after 20.08 superseded it.
Following either literally picks from the wrong calendar. Both repointed at
20.08; 20.07 is now described as the home of the founder-stream topic briefs
only.

Added the check that would have caught the real trap: a queued row naming a NEW
slug is not proof the topic is uncovered. E3 (Solid Cache vs Redis) and F1
(Propshaft migration) both target keywords an existing long post already ranks
for - F1's target IS the page holding 8,832 impressions at position 12.8.
Writing them as new posts splits the ranking. Both are upgrade-in-place; the
rule now lives in `.okf/content-strategy/content-plan.md` and in STEP 1.

Also corrected `/services/startup-cto-consulting/` (named in 20.08's funnel
section, does not exist) to the paths that do exist under `content/services/`.

E4 Kamal 2 multi-server taken as the next post instead - the six existing Kamal
posts are all single-server and 2024-era, so it splits no ranking.

## 2026-08-07 — E4 Kamal 2 multi-server published; technical posts need a source-verification critic

Published `kamal-2-multi-server-deployment-complete-guide` (Q3 plan E4, PR #437).
Taken ahead of the earlier-queued E3 and F1, both of which target keywords an
existing long post already ranks for and are upgrade-in-place jobs instead.

The durable lesson is about the review loop, not the topic. The standard
3-persona loop (founder / SEO-slop / copy editor) passed a draft that still told
readers to run migrations with bare `kamal app exec` from a `pre-deploy` hook.
That resolves to the `latest` tag, and Kamal only moves `latest` after every host
boots, so the hook would have run the release being replaced. Silent no-op
migrations on every deploy.

For developer-targeted posts, swap the ICP-E founder persona for a practitioner
critic that verifies every claim against a PINNED upstream commit and reports
file:line. That critic caught the migration bug plus a `--target`
self-contradiction and a wrong `drain_timeout` default. The cold-eyes gate then
caught a wrong claim about Sidekiq-Cron's dedup and a wrong date for kamal-proxy
PR #124. Five factual defects total; voice review surfaces none of them.

Two mechanical notes: cite as GitHub permalinks pinned to the released tag, since
bare file:line rots. And per-diagram mermaid `%%init%%` headers copied from older
posts OVERRIDE the house theme in `baseof.html` and silently shrink label text
below the 20px house size - drop the override and fix legibility structurally,
per the standing brand rule.

## 2026-08-07 — service links dropped from deep-technical posts

Paul's call on PR #437: developer-targeted technical posts no longer carry a
service-page link. 20.08's bidirectional-funnel rule required one on every Rails
post, but a fractional-CTO link at the end of a post about container ids and boot
denominators reaches the wrong reader and costs more credibility with engineers
than it returns. Those posts still cross-link sibling technical posts, which is
what actually keeps readers on the site. Founder-stream posts keep the funnel
requirement unchanged. Exemption recorded in 20.08 and applied to
`kamal-2-multi-server-deployment-complete-guide`.

## 2026-08-07 — content plan re-review: pipeline-first revision (20.09)

Four-agent re-review (market, SEO, competitor, goal-alignment) against the 2607
bet. 20.09 supersedes 20.08's allocation, cadence, and click projection; 20.08's
GSC analysis stands.

The finding that reorders everything: 2607's own rabbit-hole says "never ship a
content sprint while the outreach is stalled," and outreach IS stalled - all
batch-1 messages HOLD, zero sendable rows, card #12 blocked on #29. Four Rails
deep-dives shipped Jul 22 - Aug 7 anyway. Content is not the binding constraint;
prospect sourcing is.

Cheapest high-value fix, no new content: the rescue offer page has zero inbound
links from 608 blog posts. Six pre-qualified rescue posts link to it zero times.

Also corrected: real capacity is ~6 posts/month (June 2026 = zero posts), not the
2-3/week the plan assumed; seven queued rows duplicate existing posts and F2
already shipped into a 4-post auth cluster; the 435-click snippet projection
predates AI Overviews.

Market shifts: CVE-2026-66066 (Active Storage RCE, CVSS 9.5, Jul 29) is the rare
durable+urgent+in-authority item - and patching Rails alone is NOT sufficient,
libvips must go to >=8.13 and secrets must be rotated. "Vibe code rescue" is no
longer an uncontested category: justinmckelvey.com (cited in our own strategy as
proof the model works) now sells it at $25K-$50K under the same name.
