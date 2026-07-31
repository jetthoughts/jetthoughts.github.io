# Bundle Update Log

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
