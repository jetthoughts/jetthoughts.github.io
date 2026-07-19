# CSS Migration Task Tracker

**Purpose**: Status tracking for the CSS maintainability goal — FL-Builder export CSS retired page-by-page (strangler rewrites)
**Update Frequency**: After each sprint or status change
**Last Updated**: 2026-07-18
**Current Phase**: 🔄 Phase C (post-burn-down cleanup) — sprints C1–C3 planned; FL burn-down itself ✅ 16/16 (PR #365)

---

## 🎯 GOAL OVERVIEW

**Objective**: Every style hand-editable, understood, single-source — FL export CSS 16 files → 0
**Approach**: Phase 0 scaffolding, then one-page-per-sprint full rewrites (semantic HTML + token-based page CSS), easiest first
**Execution Mode**: One feature branch + one bundled PR per sprint; read-only audit agents allowed, mutations sequential
**Success Criteria**: FL burn-down to zero; no hash-named/obfuscated files; no duplication in the hand-maintained layer; both snapdiff suites green with every non-target page 0.0-diff

**Quick Links**:
- 📋 [Approved spec (authority)](2026-07-12-css-maintainability-redesign.md)
- 🗺️ [Bundle ownership map + FL burn-down](css-bundle-ownership-map.md)
- 📊 [Project Index](PROJECT-INDEX.md)
- 📚 [Superseded Oct-2025 plan (archived)](70-79-archives/superseded-2026-07-12/README.md)

---

## 📊 OVERALL PROGRESS

```
OLD PLAN (falsified, closed):
Phase 1: Critical CSS Inline     [✅❌✅❌] 4/4 WPs resolved (2 done, 2 closed with evidence)
Phase 2: FL-Builder Foundations  [❌❌❌❌] 4/4 WPs resolved (all closed with evidence; cleanup shipped instead)
Phase 3: Additional Patterns     SUPERSEDED 2026-07-12 — never started; premise died with Phases 1+2

CURRENT PLAN (2026-07-12 spec, revised 2026-07-18):
Phase 0: Safety scaffolding      [✅✅✅✅] 4/4 items (P0.1 blog special-content tests ✅, P0.2 practiced before every sprint ✅, P0.3 ownership map ✅, P0.4 orphan guard unit test ✅)
Rewrites: FL burn-down           ✅ 16/16 files RETIRED (R1–R9, PR #365, 2026-07-16..17) — zero snapdiff baseline changes across the entire run
Phase C: Post-burn-down cleanup  [🔲🔲🔲] 0/3 planned sprints (C1 shared components, C2 de-obfuscate shared layer, C3 page re-key pilots) + C4 backlog

Historical: ~73,150 lines eliminated sprints 1-7 (orphan deletion + consolidation)
```

**Status Legend**:
- 🔲 Not Started
- 🔄 In Progress
- ✅ Completed
- ⚠️ Blocked
- 🔥 Critical
- 📋 Medium Priority

---

## 📅 PHASE 1: Critical CSS Inline Consolidation

**Phase Status**: 🔲 Not Started
**Duration**: 20-30 hours (2-3 weeks part-time)
**Target Impact**: 300-400 lines eliminated (30% reduction from inline CSS)
**Risk Level**: LOW - Utilities creation, no complex refactoring

### Work Package Status

#### WP1.1: CSS Variables Foundation ✅ COMPLETED
```yaml
status: ✅ Completed 2026-07-12 (sprint 6 / PR #360)
priority: P0 🔥 Critical
duration: 4-6 hours
files_affected: 12 inline critical CSS files
impact: 2.8KB savings, ~50 lines eliminated
micro_commits_target: 15-20 commits

tasks:
  - [x] Create foundations/css-variables.css with design tokens (pre-existing, 2025-10-12)
  - [x] Extract --font-system-ui variable — ALL exact-match literal stacks
        (25 stacks across 8 critical files) replaced with var(--font-system-ui);
        @import wired into the 3 no-base bundles (careers, single-careers,
        single-use-cases) that never defined the variable
  - [x] Extract --color-dark (#121212) — defined in foundations/css-variables.css
        (sprint 4, 2026-07-12); 404 of 648 literals tokenized across 32 files;
        47 literals kept by design (KEEP LITERAL comments in-file), ~19 in the
        inline components tree (deferred). The ~157 in orphan files and the
        variables/colors.css duplicate def were removed with those files
        (sprint 5, 2026-07-12).
  - [x] Extract --color-primary (#1a8cff) — token had consumers for years but
        was NEVER DEFINED (28 fallback-less declarations shipped invalid);
        six live broken rule groups codified to shipped rendering first,
        then defined + ~280 literals tokenized across 50 files (sprint 6)
  - [x] --color-secondary — OBSOLETE: only consumers lived in orphaned
        buttons-migration.css (deleted sprint 6); no definition needed
  - [x] --color-text — delivered as --color-muted (#969798, 168 literals);
        body text color is --color-dark
  - [x] Extract --radius-default (4px; 137 exact swaps incl. vendor prefixes;
        reboot-generic button triplets KEEP LITERAL) and --spacing-sm/md
        (values = the fallbacks live consumers already resolved to;
        --spacing-unit as a single token is fiction — no dominant unit exists)
  - [x] Dedup the identical 35-line Bootstrap :root block copied across
        8 critical files — DELETED outright (sprint 2, 2026-07-11): zero
        var() consumers repo-wide, so no relocation needed; 280 lines
        removed; vendor base-4.min.css copy untouched
  - [x] Validation: bin/rake test:critical (46/46 pass, 84 screenshots 0 diffs)
  - [x] Validation: bin/dtest Linux gate (46/46 pass, per commit)
  - [x] Validation: FCP unchanged — first-fold page HTML (inline critical CSS
        included) byte-identical pre/post sprint-6 token work (homepage,
        services, blog, careers, free-consultation). External bundles +4.8KB
        raw (+0.18%, var() names longer than hex; gzip absorbs it)

blockers: NONE
dependencies: NONE (can start immediately)
assigned_to: Claude (sprint 1, 2026-07-11)
started_date: 2026-07-11
completed_date: -
actual_duration: ~2.5 hours (sprint 1)
actual_commits: 10 (c2a161f6..498edbba), 9 files, +44/-420 lines
notes: |
  Foundation for all CSS variable usage.
  Sprint-1 findings:
  - careers bundle had 4 var(--font-system-ui) usages with NO definition
    (unresolved var since a prior partial extraction) — fixed by @import.
  - use-cases-critical.css is ORPHANED (no template loads it; repo-wide
    grep finds zero loaders). Follow-up: wire into use-cases bundle or delete.
  - Variant stacks (short system-ui + Bootstrap-reboot -apple-system-first)
    intentionally NOT converted — different values, would be value changes.
```

#### WP1.2: Reset Utilities Extraction ❌ OBSOLETE
```yaml
status: ❌ Closed as obsolete 2026-07-12 (sprint 6) — premise falsified:
  (1) only 18 of ~140 padding:0/margin:0 occurrences in critical/ are
  standalone rules; the other 122 are declarations inside larger blocks
  that utility classes cannot replace without splitting rules AND editing
  FL-Builder-generated markup;
  (2) the utility files this WP asks for ALREADY EXISTED
  (utilities/margins.css, padding.css, display.css, flexbox.css …) —
  extracted in an earlier effort, imported only by the dead
  _consolidated-utilities.css aggregator, classes present in zero
  templates; the whole closure was deleted as orphans in sprint 6;
  (3) the byte savings the WP projected are already realized in output by
  cssnano rule-merging + postcss-delete-duplicate-css per bundle.
priority: P0 🔥 Critical
duration: 6-8 hours
files_affected: 12 inline critical CSS files
impact: 3-4KB savings, ~129 lines eliminated
micro_commits_target: 25-30 commits

tasks:
  - [ ] Create _reset-utilities.scss with utility classes
  - [ ] Create .u-padding-0, .u-padding-top-0 utilities
  - [ ] Create .u-margin-0, .u-margin-bottom-0 utilities
  - [ ] Replace 59 padding:0 declarations with utility classes
  - [ ] Replace 70 margin:0 declarations with utility classes
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: Visual regression ≤3%

blockers: NONE
dependencies: WP1.1 (CSS variables should be complete first)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: High-impact utility extraction
```

#### WP1.3: PowerPack Infobox Pattern ✅ COMPLETED
```yaml
status: ✅ Completed 2026-07-12 (sprint 6, 23ed3049) — 6 per-fl-node
  duplicate blocks in services-critical.css consolidated via selector
  grouping (-224 source lines). Note the projected 1.5KB output saving
  was ALREADY realized by cssnano merging the duplicates — compiled
  output byte-identical; this is source hygiene. Gate: per-node rule
  expansion identical; services/index.html is the only page inlining
  these nodes.
priority: P1 ⚠️ High
duration: 4-6 hours
files_affected: services.html (6 duplicates)
impact: 1.5KB savings, ~30 lines eliminated
micro_commits_target: 8-10 commits

tasks:
  - [ ] Create .c-pp-infobox-standard utility in component CSS
  - [ ] Extract pattern: padding: 40px 20px; border: 1px solid #e0e0e0;
  - [ ] Replace 6 inline duplicates in services.html with utility reference
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: services.html visual test (0% difference)

blockers: NONE
dependencies: WP1.2 (reset utilities provide baseline)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Page-specific optimization for services page
```

#### WP1.4: Media Query Consolidation ❌ REJECTED (measured)
```yaml
status: ❌ Closed as net-negative 2026-07-12 (sprint 6) — implemented via
  postcss-sort-media-queries (production-only, after purge/dedup), measured,
  reverted. Raw bytes: −6% (homepage 332 @media blocks → 28). BUT transfer
  size is what ships: gzip GREW +2-3% per bundle (merging scatters the
  repetitive per-node blocks gzip compresses best); brotli −0.3-1% ≈ noise.
  Zero real win against real cascade-reorder risk (cssnano removed its own
  media-merging for exactly this) plus a plugin crash on PurgeCSS's empty
  @media rules that needed a workaround. Source-level regrouping would
  change output the same way — same verdict. Do not revisit without new
  evidence.
priority: P1 ⚠️ High
duration: 6-8 hours
files_affected: 12 inline critical CSS files (168 @media occurrences)
impact: ~8KB savings, 100-120 lines eliminated
micro_commits_target: 30-40 commits

tasks:
  - [ ] Create _responsive-utilities.scss with standard breakpoints
  - [ ] Group mobile-specific rules into single @media block per file
  - [ ] Extract common responsive patterns to utilities
  - [ ] Consolidate @media (max-width:860px) repetitions
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: Responsive test suite (all breakpoints)

blockers: NONE
dependencies: WP1.1, WP1.2 (variables and utilities provide foundation)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Highest line count reduction in Phase 1
```

### Phase 1 Summary — ✅ CLOSED 2026-07-12
```yaml
work_packages_total: 4
work_packages_completed: 2   # WP1.1, WP1.3
work_packages_closed_obsolete: 2   # WP1.2 (premise falsified), WP1.4 (measured net-negative)
total_lines_eliminated_actual: ~70,600 across sprints 1-6 (mostly orphan deletion;
  the WPs' own line targets were largely already realized in OUTPUT by the
  postcss pipeline — the 2025-10 analysis measured source, not compiled bundles)
notes: |
  Phase-1 lesson: the original WP estimates predate cssnano/delete-duplicate
  awareness. Before starting any Phase-2 WP, verify its projected savings
  against COMPILED bundle output (and gzip), not source line counts.
```

---

## 📅 PHASE 2: FL-Builder Foundation Extraction

**Phase Status**: ❌ CLOSED 2026-07-12 (sprint 7) — extraction rejected on measurement; orphan cleanup + bundle merge shipped instead
**Original Target**: 1,900-2,900 lines eliminated via shared FL foundations
**Why closed** (two independent read-only audits against the compiled production baseline):
- The spec's "7 FL-Builder layout files" is stale: **17 live layout files**, all external `<link>` bundles via `css-processor.html`, none inline.
- The proposed foundation files **already existed as never-wired orphans** (utilities/fl-builder-*, components/layout-*, foundations/_fl-responsive-display.scss — a .scss file in a Sass-less PostCSS pipeline). Deleted in sprint 7.
- **Shipped-byte math is net-NEGATIVE**: each page loads exactly one PurgeCSS-purged bundle carrying only its own FL subset. A shared foundation must carry the union of all 979 unique FL rules (120KB raw / 11.3KB gz): first-visit +7.1KB gz (homepage) to +9.8KB gz (blog list) per page. Multi-page warm-cache session saves only ~1.5KB gz total across 4 pages.
- The `.fl-visible` "90-95% duplication" claim measured at **41.9%** across bundles (453 instances, 263 distinct — high per-bundle counts are distinct breakpoint variants, not copies).
- ~7,991 of 75,382 layout-file lines are per-page `fl-node-XXXX` rules that extraction cannot consolidate by definition; the byte-identical generic blocks are only a few hundred lines and already deduped per-bundle at build time by postcss-delete-duplicate-css.

Same lesson as WP1.4: verify projected savings against COMPILED + GZIPPED output, not source line counts.

### Work Package Status

#### WP2.1: FL-Row Foundation Extraction ❌ CLOSED — net-negative on shipped bytes (see Phase header)
```yaml
status: ❌ Closed 2026-07-12 without implementation (sprint 7 measurement)
priority: P0 🔥 Critical
duration: 12-16 hours
files_affected: 7 FL-Builder layout files
pattern: FL-row, FL-row-content layout foundation
impact: 800-1,200 lines eliminated
micro_commits_target: 35-45 commits

tasks:
  - [ ] Create themes/beaver/assets/css/foundations/_fl-row-foundation.scss
  - [ ] Extract common FL-row patterns (layout, spacing, backgrounds)
  - [ ] Import foundation in each of 7 layout files
  - [ ] Remove duplicated FL-row definitions from layout files
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: Full page visual regression (all 7 pages)

blockers: NONE
dependencies: Phase 1 complete (WP1.1-WP1.4)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Largest single pattern extraction in project
```

#### WP2.2: FL-Col Grid Foundation ❌ CLOSED — net-negative on shipped bytes (see Phase header)
```yaml
status: ❌ Closed 2026-07-12 without implementation (sprint 7 measurement)
priority: P0 🔥 Critical
duration: 10-14 hours
files_affected: 7 FL-Builder layout files
pattern: FL-col grid system
impact: 600-900 lines eliminated
micro_commits_target: 30-40 commits

tasks:
  - [ ] Create themes/beaver/assets/css/foundations/_fl-col-foundation.scss
  - [ ] Extract FL-col grid system (columns, gutters, responsiveness)
  - [ ] Import foundation in each of 7 layout files
  - [ ] Remove duplicated FL-col definitions from layout files
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: Grid layout visual tests (all 7 pages)

blockers: NONE
dependencies: WP2.1 (FL-row foundation provides baseline)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Grid system must maintain responsive behavior
```

#### WP2.3: FL-Visible Responsive Foundation ❌ CLOSED — duplication claim falsified (41.9%, not 90-95%)
```yaml
status: ❌ Closed 2026-07-12 without implementation (sprint 7 measurement)
priority: P0 🔥 Critical
duration: 10-14 hours
files_affected: 7 FL-Builder layout files
pattern: FL-visible responsive display utilities
impact: 500-800 lines eliminated (90-95% duplicate)
micro_commits_target: 25-35 commits

tasks:
  - [ ] Create themes/beaver/assets/css/foundations/_fl-responsive-display.scss
  - [ ] Extract responsive visibility utilities (.fl-visible-large, -medium, -mobile)
  - [ ] Import foundation in each of 7 layout files
  - [ ] Remove duplicated responsive display rules from layout files
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: Responsive breakpoint tests (all 7 pages)

blockers: NONE
dependencies: WP2.2 (grid foundation provides responsive context)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Highest duplication percentage (90-95%)
```

#### WP2.4: Foundation Integration & Validation ❌ CLOSED — moot (no foundations to integrate; WP2.1-2.3 closed)
```yaml
status: ❌ Closed 2026-07-12 (sprint 7)
priority: P0 🔥 Critical
duration: 8-10 hours
files_affected: All 7 FL-Builder layout files + 3 foundation files
impact: Consolidation complete, 1,900-2,900 total lines eliminated
micro_commits_target: 10-15 commits

tasks:
  - [ ] Ensure proper @import order in all layout files
  - [ ] Validate no duplicate imports across files
  - [ ] Run full regression test suite (bin/rake test:critical)
  - [ ] Run visual regression for all 7 pages
  - [ ] Document foundation usage patterns
  - [ ] Generate Phase 2 completion report

blockers: NONE
dependencies: WP2.1, WP2.2, WP2.3 (all foundations extracted)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Phase 2 gate - must pass all validations
```

### Phase 2 Summary
```yaml
work_packages_total: 4
work_packages_completed: 0 (all 4 closed with evidence, no extraction implemented)
phase_status: CLOSED 2026-07-12 (sprint 7)
foundation_files_created: 0 — and the 6 pre-existing never-wired foundation orphans were DELETED
shipped_instead:
  - deleted 6 orphan artifacts + 61 stale comment refs (-597 lines, compiled output byte-identical)
  - merged e93d9b85…-layout-bundle.css into its superset bf72bba… (-1,956 lines, compiled output byte-identical; clients page purges the 2 extra rules)
lesson: same as WP1.4 — savings claims must be verified against compiled+gzipped bundles; PurgeCSS-per-bundle already gives each page its minimal FL subset, so shared foundations regress first-visit transfer size
```

---

## 📅 PHASE 3 (OLD PLAN): Additional Pattern Consolidation + Hugo Enhancements — ❌ SUPERSEDED 2026-07-12

**Phase Status**: ❌ Superseded before start — closed 2026-07-12 (never begun)
**Reason**: Its premise (source-level pattern consolidation into shared foundation
files, measured in raw line counts) is the same methodology falsified by Phase 1
(WP1.2/WP1.4) and the whole of Phase 2: PurgeCSS runs per bundle, so each page
already ships only its own FL subset — foundation extraction grows shipped bytes.
WP3.1/WP3.2 also proposed `.scss` files in a Sass-less pipeline. WP3.3's Hugo
enhancements (hugo_stats.json, PurgeCSS, safelists) already exist in production.
The WP3.1-3.4 definitions are preserved in git history (commit 2388c437 and
earlier) and the archived plan docs under `70-79-archives/superseded-2026-07-12/`.

**Replaced by**: the strangler rewrite plan in
[2026-07-12-css-maintainability-redesign.md](2026-07-12-css-maintainability-redesign.md).

---

## 📅 PHASE 0 (CURRENT PLAN): Safety scaffolding

**Phase Status**: ✅ COMPLETE (4/4 items)
**Source**: Spec §"Phase 0 — safety scaffolding". No legacy CSS edits in this phase.
**Gate mechanism**: existing snapdiff suites only — `bin/test` (macOS) + `bin/dtest`
(Linux), `FORCE_SCREENSHOT_UPDATE=true` to regenerate baselines. No new custom
baseline/compare scripts; missing coverage is fixed by ADDING TESTS.

```yaml
items:
  - [x] P0.1 Special-content blog post coverage: mermaid rendered-diagram capture
        (dfecb741) + per-language code-block screenshots via draft fixture post
        (5a7a67f5, test_codeblock_language_styles).
  - [x] P0.2 Rewrite-target coverage check: practiced before every R1–R9 sprint.
  - [x] P0.3 Page→bundle ownership map: css-bundle-ownership-map.md (2026-07-12) —
        19 bundles × owning template × FL files × gzip; FL burn-down table 16→0.
  - [x] P0.4 Orphan guard: test/unit/css_orphan_guard_test.rb.
```

---

## 📅 REWRITE SPRINTS (CURRENT PLAN): FL burn-down 16 → 0

One page type per sprint: semantic HTML template + one token-based file under
`css/pages/`, FL file(s) deleted in the same PR, design improvements per
JetVelocity (`.stitch/design.md`) with Paul's screenshot approval. Full protocol
in the spec; live status in `css-bundle-ownership-map.md`.

```yaml
completed:  # all shipped in PR #365 (branch css-migration/strangler-run), 2026-07-16..17
  - R1:  3059-layout retired — privacy-policy + course-list semantic rewrites (46060e0c lineage)
  - R2:  706-layout retired — contact-us semantic rewrite
  - R3a: blog-single off FL files; .sr-only moved site-wide
  - R3b: course-single off FL files (+ chapter coverage)
  - R3c: fb2624…-bundle retired — single-client semantic node aliases
  - R3d: 3114-layout + e966db44…-bundle retired — single-career delta port
  - R4a: blog-list semantic rewrite (dropped homepage-layout/services-layout from its slice)
  - R4b: free-consultation semantic rewrite; homepage-layout, services-layout,
         utilities/fl-builder-grid, critical/free-consultation-critical DELETED
  - R5:  701-layout retired — about-us delta port (9 dead nodes pruned)
  - R6:  3086-layout2 retired — careers verbatim move (compiled bundle byte-identical)
  - R7:  3021 + 3027 retired — use-cases pair delta ports (58+14 dead nodes)
  - R8a: 3082 retired — clients delta port (35 dead nodes)
  - R8b: 2949 retired — single-service delta port (26 dead nodes, 8-page union prune)
  - R8c: 737 retired + bf72bba…-bundle DELETED (last consumer) — services delta port (41 dead nodes)
  - R9:  590-layout retired — homepage delta port (47 dead nodes). BURN-DOWN COMPLETE.
notes: |
  Evidence bar held for every commit: converged production build ×2, only the
  target bundle fingerprint changed, headless old-vs-new RMSE 0 (desktop +
  mobile, full page), bin/rake test:critical AND bin/dtest green, ZERO
  screenshot baseline changes. Satellite fl-builder-common-base.css KEPT
  (imported by pages/use-cases.css; not byte-redundant). critical/ FL trio
  stays as shared framework for kept fl-node markup.
follow_ups:
  - ABSORBED into Phase C (2026-07-18): shared-component extraction = sprint C1;
    semantic re-keying = sprints C2/C3 + C4 backlog. See PHASE C below.
```

---

## 📅 PHASE C (CURRENT PLAN): Post-burn-down cleanup — sprints C1–C3

**Phase Status**: 🔲 Not started (planned 2026-07-18)
**Source**: Spec §"Phase C — post-burn-down cleanup" (revision 2026-07-18) —
read it FIRST; it defines the gate stack, the preflight rule, the
dedup-trap warning, and the non-goals (no DOM restructuring, no rule-content
changes, no transfer-size targets).
**Execution mode (XP)**: one feature branch + ONE bundled PR per sprint;
micro-commits — one component/consumer/node per commit, every commit passes
the gate stack (converged build ×2 → bundle rule-diff → headless RMSE 0 →
`bin/qtest --changed` scoped visual gate, ZERO baseline changes). Full
`bin/rake test:critical` + `bin/test` + `bin/dtest` at each component
milestone (last consumer swap of a C1.x / completed C2-C3 task) and on the
branch head before the PR — see spec gate stack items 4-5 (rev 2026-07-19).
Read-only audit agents may run in parallel; ALL mutations sequential.
A commit is a move OR a rename OR a documented deletion — never mixed.

### Sprint C1 — extract shared components (kills the 55–70% page-file duplication)

**Branch**: `css-migration/c1-shared-components`
**Deliverable**: rules for the shared partials live ONCE under
`themes/beaver/assets/css/components/`, `@import`-ed in place by their
consumer `pages/*.css` files. Per-bundle compiled output rule-identical;
per-bundle gzip unchanged (±noise) — record before/after in the PR.

```yaml
tasks:
  - [ ] C1.0a Preflight — orphan-guard compatibility: confirm
        test/unit/css_orphan_guard_test.rb counts files reachable via @import
        from a slice member (components/*.css will have no direct template
        reference). If it doesn't, teach it to follow @import in the same
        commit that lands the first component file.
  - [ ] C1.0b Preflight — identity proof per component: for each component
        below, extract every consumer's candidate block (all rules whose
        selectors contain the component's fl-node ids) and diff normalized
        (whitespace/blank-line collapse). Identical → proceed. Divergent →
        narrow the component to the identical subset and LOG the variance
        here; do NOT reconcile differences inside this sprint.
  - [🔄] C1.1 components/testimonials.css — source partial
        themes/beaver/layouts/partials/page/testimonials.html; scope:
        node ids (08kl1yzxeout 1a4igunq3xvj 1i28o7dq3pcv 38ejkdz2v4cq
        byg0v6ftixrd c17gwsk2h8zy d4wp9kxy1uav q4x2z8f9l1k3 ud8jroeig5h2
        zaerhibqp296) PLUS pp-review*/pp-reviews-wrapper anchored rules
        (partial-exclusive; widened 2026-07-19 to fix an order flip vs the
        wrapper's svg-sizing rule). Component = 133-rule intersection,
        canonical order about-us.css, font stacks → var(--font-system-ui).
        [x] Commit 1 (782507ec): component file + about-us swap. Gated.
        [ ] Commits 2-6: clients, services, single-use-cases,
            single-service, use-cases — one consumer per commit; regenerate
            remainder via the split tool, add
            `(resources.Get "css/components/testimonials.css")` to the
            template slice directly before its pages/*.css entry, gate each
            (fingerprint-only-target + decl-set + winner map + DOM probe
            vs control + bin/qtest <page>).
        [ ] Commit 7a (documented deletion): homepage dead
            `.fl-node-08kl1yzxeout .pp-swiper-button svg {24px}` rule
            (line ~1277) — shadowed by the 48px copy at ~10317; MUST be
            deleted BEFORE the swap or the keep-fires-last order flips
            homepage's buttons 48→24px.
        [ ] Commit 7b: homepage swap (block present TWICE; both copies
            removed by the split tool, second copy is 5 rules short —
            verified subset).
        METHOD CORRECTIONS (2026-07-19, learned in commit 1):
        - @import in pages/*.css DOES NOT WORK: postcss-import skips
          post-prelude imports (only critical/base.css + adjacent members
          are prelude). Wire components as CONCAT SLICE MEMBERS in the
          template instead. Latent pre-existing instance of this bug:
          7 skipped @imports at concat lines ~4102-4123 of some bundle
          (postcss warnings) — audit which bundle in C4.
        - VARIANCE LOG (kept per-page, NOT unified): 38ejkdz2v4cq
          wrapper margin/padding variants (homepage margin-top 130 vs 0;
          clients/services/singles padding-top 130 vs about-us/homepage
          none; @1115/@860 padding-top 50 vs 0); ud8jroeig5h2 @1115
          margins 50px (5 pages) vs 0 (services, single-service) — its
          @860 twin EXCLUDED from the component (equal-specificity
          cross-media tie; extraction reorder flipped the mobile winner,
          +60px heading shift, caught by qtest); use-cases carries NO
          38ejkdz2v4cq cluster at all. Unification of the spacing
          variants = design decision for Paul (would visually change
          pages) — out of C1 scope per non-goals.
        - Probe/RMSE builds MUST use `--baseURL /` — production default
          baseURL makes headless Chrome fetch bundles from the LIVE site
          (silent 404/stale-CSS false signals, hit twice).
        - Component file header comment must CLOSE (`*/`) — an unclosed
          comment swallows the whole file silently in every environment.
  - [x] C1.2 components/cta-banner.css — DONE 2026-07-19 (3 commits, via
        bin/css-split). Real consumer count: 6, not 8 (clients + contact-us
        carry NO cta node rules). 10-rule intersection; zero
        selector+property ties (order-safe). VARIANCE: rujwd9mzxche
        rich-text pair kept in 5 pages (services has none); about-us keeps
        its fdsvgxpowi03 spacing cluster. Gates: only-target fingerprints,
        decl-sets identical per bundle.
  - [x] C1.3 components/header-cta.css — DONE 2026-07-19 (1 commit).
        Trio byte-identical across use-cases/clients/services; node id
        keeps the FL "contat" typo (rename = C2). critical/ copies left
        for C4 dedup per plan.
  - [x] C1.4 Evidence: per-bundle gzip after all three extractions
        (vs pre-C1 baseline): about-us 14971→14927, clients 18651→18629,
        services 19943→19942, homepage 26644→26645, single-service
        19066→19099, single-use-cases 18845→18863, use-cases 16965→16978 —
        all ±35B noise as designed. fl-node refs in pages/*.css:
        ~3,700 → 2,834. Components carry "affects pages:" headers;
        ownership map updated (components/ slice members).
  - [x] C1.5 PR #371 (branch css-migration/c1-shared-components) — also
        carries the fast-gate infra (bin/qtest, bin/css-split,
        bin/dtest-all, churn-based test:critical), the dead-import +
        never-shipped-orphan cleanups, the flaky careers_page test
        deletion, and the free_consultation gform mask + re-baseline.

blockers: NONE — C1.1 SHIPPED (9 commits + tooling, 2026-07-19); C1.2/C1.3
  next via bin/css-split. Known PRE-EXISTING test:all failures (master-level,
  branch exonerated by only-target-bundle fingerprints): linux
  desktop/free_consultation baseline drift (fails on master too) + the 5
  test/system/pages/careers_page_test.rb tests (old test:critical glob never
  ran them; stale linux baselines). Both need a master-side baseline refresh.
estimated_commits: ~18-22 (2 preflight, 7+~5+3 swaps, docs)
```

### Sprint C2 — de-obfuscate the shared layer (criterion 2 start)

**Branch**: `css-migration/c2-deobfuscate-shared`
**Depends on**: C1 merged (re-key each shared block once, not 7×).
**Deliverable**: shared partials use semantic classes; zero hash-named CSS
files; deferred cascade hardening landed.

```yaml
tasks:
  - [ ] C2.1 Re-key testimonials — one node per commit (≈10 commits): rename
        `fl-node-<id>` → semantic class (naming from section intent:
        testimonials-section, testimonials-heading, testimonials-quote,
        testimonials-author, …) in partials/page/testimonials.html AND
        components/testimonials.css in the SAME commit. Keep the generic
        `fl-row/fl-col/fl-module` framework classes (they die in C4 with the
        critical/fl-* trio). Gate: bundle diff is exactly the class
        substitution; rendered HTML diff likewise; ZERO baseline changes.
  - [ ] C2.2 Re-key cta partial — same protocol, ≈7 commits
        (cta-banner, cta-banner-heading, cta-banner-button, …) in
        partials/page/cta.html + components/cta-banner.css.
  - [ ] C2.3 Rename skin-65eda28877e04.css → legacy-theme-skin.css (last
        hash-named file; criterion 2). Enumerate ALL refs first:
        `grep -rln 'skin-65eda28877e04' themes/ config/ | sort` (12+ template
        slices at last count). git mv + sed all refs in ONE commit; file
        content untouched. Gate: every bundle's rule content identical
        (fingerprints change — concat input renamed — that is the ONLY
        expected diff). Name pre-approved? NO — flag in PR for Paul; rename
        is one-commit revertable if he prefers another name.
  - [ ] C2.4 Rename dynamic-404-590.css → dynamic-404.css (node-id 590 is
        retired). Refs: themes/beaver/layouts/404.html +
        partials/assets/homepage-css-resources.html. One commit, same gate
        as C2.3.
  - [ ] C2.5 Cascade hardening (deferred from burn-down): delete
        `background-color:#F5F6F8` from `.single-content pre` (586.css:823)
        — the losing duplicate whose only effect is masking the dark
        code-block background behind cascade order. Gate: blog-single bundle
        rule-diff shows EXACTLY this deletion; 586.css is in most slices so
        expect broad fingerprint churn with rule-identical content elsewhere;
        test_codeblock_language_styles (codeblock-styles-fixture post) must
        stay green — it screenshot-locks the regression this prevents.
  - [ ] C2.6 Safe-edit headers (criterion 4 closure for the legacy layer):
        one-line "affects pages: see css-bundle-ownership-map.md; loaded by
        <N> bundles" header comment on 586.css, style.css, theme-main.css,
        component-bundle.css, legacy-theme-skin.css. Comment-only commits;
        production bundles strip comments — output byte-identical.
  - [ ] C2.7 PR + ownership map + tracker UPDATE LOG.

blockers: C1 not merged
estimated_commits: ~22 (10+7 re-keys, 2 renames, 1 deletion, headers, docs)
```

### Sprint C3 — page re-keying pilots (easiest pages first)

**Branch**: `css-migration/c3-rekey-pilot`
**Depends on**: C2 merged (shared partial nodes already semantic — page grep
hits are page-own nodes only).
**Deliverable**: 3–4 templates fully off `fl-node-*` ids; the R3c alias
protocol timed and documented so C4 sprints can be sized.

```yaml
tasks:
  - [ ] C3.1 clients/single.html — 1 remaining distinct node (pages/
        single-client.css is already fully aliased from R3c). Verify the
        node has zero rules in any live CSS
        (`grep -rn '<id>' themes/beaver/assets/css/`); if dead, rename or
        drop the class attr; one commit.
  - [ ] C3.2 page/use-cases.html — 11 distinct page-own nodes /
        pages/use-cases.css ~147 fl-node refs pre-C1. Protocol per
        node-cluster (a section's nodes rename together, one commit each):
        (a) name from rendered section intent (use-cases-hero,
        use-cases-grid, use-cases-cta-strip, …; grep the template around the
        node for the visible heading), (b) rename in template + CSS same
        commit, (c) full gate. ≈5-8 commits.
  - [ ] C3.3 careers/single.html — 18 distinct nodes /
        pages/single-career.css 67 refs. Same protocol, ≈6-9 commits.
  - [ ] C3.4 (stretch, only if velocity allows) page/clients.html —
        13 distinct nodes. Same protocol.
  - [ ] C3.5 Retro + sizing: record minutes-per-node actual; write the C4
        re-key order with estimates into this tracker (spec backlog order:
        404 16 → use-cases/single 32 → page/services 33 → services/single 40
        → about 41 → careers 58 → home 85); PR + map + UPDATE LOG.

blockers: C2 not merged
estimated_commits: ~15-20
non_goals: NO wrapper-div collapse, NO visual changes, NO rule edits —
  renames only (spec §Phase C non-goals)
```

---

## 🚨 BLOCKERS & RISKS

### Current Blockers
```yaml
phase_c_blockers: NONE — C1 ready to start; C2 gated on C1 merge; C3 gated on C2 merge

critical_path_risks:
  - postcss-delete-duplicate-css dedup trap (production-only, later-duplicate
    deleted): rule moves/renames can flip cascade winners; Linux suite alone
    CANNOT catch it (font masking) — macOS suite + RMSE pre-gate mandatory
    per commit. See memory project-css-var-extraction-dedup-trap.
  - build flicker false signals (term-casing races, header partialCached
    -active race): build twice as control before blaming an edit. See memory
    project-hugo-stats-purgecss-flicker.
```

### Risk Mitigation Status
```yaml
test_suite_operational: ✅ YES - bin/rake test:critical passing
visual_regression_ready: ✅ YES - Screenshot comparison available
rollback_capability: ✅ YES - Micro-commit strategy (≤3 lines)
performance_baseline: ✅ YES - FCP, CLS metrics documented
```

---

## 📈 CUMULATIVE METRICS

### FL burn-down (the headline metric)
```
Live FL layout files: 0 / 16 — ✅ COMPLETE 2026-07-17 (R1–R9, PR #365)
Earlier: e93d9b85…-layout-bundle.css merged into bf72bba… + 6 never-loaded
         orphans deleted (PR #363)
Authoritative table: css-bundle-ownership-map.md
```

### Phase C headline metrics (criteria 2+3; measured 2026-07-18)
```
fl-node rules in pages/*.css:   ~3,700  (target: 0 — sprints C2/C3/C4)
fl-* refs in templates:            604  (target: 0)
Hash-named CSS files:                1  (skin-65eda28877e04.css; target: 0 — C2.3)
Dup lines between sibling pages: 55-70% (target: ~0 — C1)
Re-measure commands:
  for f in themes/beaver/assets/css/pages/*.css; do grep -c 'fl-node-' "$f"; done
  grep -r 'fl-node-' themes/beaver/layouts --include='*.html' | wc -l
```

### Historical (old plan, closed)
```
Lines eliminated sprints 1-7: ~73,150 (orphan cleanup + consolidation + dedup)
Old line-count targets (27,394-31,936) retired — methodology falsified;
see 70-79-archives/superseded-2026-07-12/README.md
```

### Quality Metrics (Maintained Throughout)
```yaml
test_pass_rate:
  target: 100%
  current: 100% (baseline)
  status: ✅ Maintained

visual_regressions:
  target: 0 (≤3% tolerance for features, 0% for refactoring)
  current: 0 (baseline)
  status: ✅ Maintained

lighthouse_score:
  target: 95+
  current: 95+ (baseline)
  status: ✅ Maintained

fcp_metrics:
  target: ≤1.5s
  current: ≤1.5s (baseline)
  status: ✅ Maintained
```

---

## 🔄 UPDATE LOG

### 2026-07-18 (plan revision — Phase C defined, sprints C1–C3 planned)
- **Action**: Post-burn-down audit measured the tree against the spec's five
  success criteria: criteria 2 (no obfuscated artifacts) and 3 (no duplication
  in the hand layer) are NOT met — the delta ports moved ~3,700 fl-node rules
  into pages/*.css, 604 fl-* refs remain in 14 templates, 55–70% of lines are
  byte-identical between sibling page files (shared-partial copies), and
  skin-65eda28877e04.css is still hash-named.
- **Shipped**: spec revision (§"Phase C — post-burn-down cleanup": phase
  structure C1→C4, gate stack, preflight rule, non-goals) + this tracker's
  PHASE C section with agent-executable micro-commit task lists for sprints
  C1 (shared-component extraction), C2 (shared-layer de-obfuscation),
  C3 (page re-key pilots). Phase 0 yaml, blockers, metrics, and quick-actions
  sections de-staled.
- **Dropped from follow-ups (falsified)**: "root list.html is dead code" —
  sprint-4 log already corrected this (383 /blog/tags/* pages render through
  it; the bundleName collision was fixed via shared partial). Stray @charset
  follow-up — already fixed in sprint 3 (grep confirms zero mid-file
  @charset today). contact-us/free-consultation re-keying — already done
  during R2/R4b (fl-node hits in those files are comments only).
- **Next**: Sprint C1 on branch css-migration/c1-shared-components.

### 2026-07-17 (strangler run complete — FL burn-down 16/16, PR #365)
- **Shipped**: R4a..R9 in one continuous run (R1..R3d landed 2026-07-16 on the
  same branch): every FL-Builder export file retired; 16 hand-maintained
  `css/pages/*.css` files own all page styling; bf72bba shared bundle,
  homepage-layout, services-layout, fl-builder-grid, free-consultation-critical
  deleted. gz deltas per bundle in css-bundle-ownership-map.md (typical −20-33%).
- **Method that held**: Option-A delta ports via a media-aware dead-node pruner
  (prune only rules keyed on fl-node ids absent from the rendered page; keep
  generics verbatim) + compiled fragment-diff liveness check + headless
  old-vs-new RMSE pre-gate (caught every parity miss BEFORE the suites:
  all-sides wrap padding on blog-list mobile, 4 gform generics + footer
  centering + a contact-us-only button margin on free-consultation, the
  bf72bba header CTA trio on use-cases/clients/services).
- **Upstream event absorbed mid-run**: rebase onto master's course v2 merge
  (#361) — revalidated at HEAD both OSes; one bimodal text-wrap flake in the
  new lesson-meta blockquote masked via skip_area in both chapter tests;
  ZERO baseline changes.
- **Standing evidence**: every commit gated on converged build ×2 +
  only-target-bundle fingerprint change + both snapdiff suites green with zero
  baseline changes. The "unchanged baselines ARE the proof" bar held 16/16.

### 2026-07-12 (sprint 8 — plan re-wised, project docs realigned)
- **Action**: Goal reframed from line-count elimination to maintainability
  (hand-editable, single-source, FL export retired) — approved spec
  `2026-07-12-css-maintainability-redesign.md` (brainstormed section-by-section,
  merged in PR #363). This tracker rewritten to the new plan: Phase 3
  superseded before start; new Phase 0 (safety scaffolding) + rewrite sprints
  R1…Rlast (FL burn-down 16→0, easiest first).
- **Shipped**: `css-bundle-ownership-map.md` (Phase 0 item P0.3) — 19 bundles ×
  template × FL files × gzip from a converged production build; 36 superseded
  Oct-2025 docs moved to `70-79-archives/superseded-2026-07-12/` (audited
  file-by-file by a read-only agent); PROJECT-INDEX rewritten;
  `css-loading-order-analysis.md` banner + CLAUDE.md pointer updated.
- **Evidence basis**: PR #363 review (independent agent, SAFE-TO-MERGE) +
  the sprint-7 compiled+gzip falsification of the extraction plan.
- **Next**: Phase 0 items P0.1 (special-content blog post tests), P0.4 (orphan
  guard), then R1 (3059-layout → privacy-policy + course-list pages).

### 2026-07-12 (sprint 7 — Phase 2 re-scoped and closed)

Swarm protocol: two parallel read-only auditors (source inventory + compiled-output
measurement against a converged production baseline); all mutations sequential in the
main loop under the byte-diff gate + both visual suites per commit.

**Evidence (falsified the Oct-2025 Phase 2 spec on every load-bearing claim):**
- 17 live layout files (not 7), all external bundles, mapped file→template→page.
- Proposed foundation destinations already existed as 6 never-wired orphans, one of them
  `.scss` in a Sass-less pipeline. The Oct plan was half-built, abandoned, and never loaded.
- Cross-source duplication per page < 1KB raw (FL portion ≈ 0); careers (worst page)
  perfect-dedup saves 310 bytes gz. The 201KB "redundancy" spans 19 page-type bundles a
  visitor never co-loads.
- Shared-foundation simulation: first-visit +7.1 to +9.8KB gz per page (PurgeCSS already
  ships per-page minimal subsets; union foundation = 120KB raw / 11.3KB gz unpurged).
- `.fl-visible` duplication 41.9% measured vs 90-95% claimed.

**Shipped:**
- 5892fe44 — deleted 6 orphan FL-foundation artifacts + 61 stale comment refs
  (-597 lines). Gate: all compiled bundles byte-identical; HTML diffs = known noise only
  (sw.js?v= stamp, taxonomy term-casing race). macOS 46/46 + 84 screenshots clean;
  Linux dtest 46/46.
- (this commit) — merged `e93d9b85…-layout-bundle.css` (1,956 lines) into its superset
  `bf72bba…` (13-line diff: img.mfp-img padding + fl-photo @860px block) by repointing
  `page/clients.html`. Compiled output 100% byte-identical (PurgeCSS drops the 2 extra
  rules for clients; clients page has zero mfp-img/fl-photo elements). Both suites green.

**Not done / follow-ups:** Phase 3 specs carry the same Oct-2025 line-count methodology —
re-scope against compiled+gzip before starting. `fl-builder-common-base.css` and
`utilities/fl-builder-grid.css` are single-importer live files (fold-in candidates for a
later sprint). Near-dupe cohort analysis (12 numbered files vs 4 hash bundles) done, no
further whole-file merges found.

### 2026-07-12 (sprint 6 continuation — WP1 / Phase 1 closed)
- **Landed** (same branch/PR #360, 7 more commits): Phase 1 fully resolved.
  1. 23ed3049 — WP1.3 done: 6 duplicated infobox blocks in
     services-critical.css consolidated by selector grouping (-224 lines;
     output byte-identical — cssnano had already merged them).
  2. 06207988 — 16 MORE orphans deleted (audit finding): components
     buttons-migration/c-navigation/c-gravity-forms/navigation-migration
     + dead _consolidated-utilities.css aggregator closure (12 utility
     files incl. the very margins/padding utilities WP1.2 asked for).
  3. d4370857 — components tree #121212 → var(--color-dark) (15 swaps);
     foundation @imported at top of components.css; --spacing-sm/md
     defined at live fallback values. TRAP DOCUMENTED: prepending the
     foundation via the baseof resource slice put :root before
     components.css's @imports → CSS invalidated them → the whole
     components inline bundle silently vanished (caught by swap gate).
  4. d3b049e3 — --color-primary (#1a8cff) DEFINED for the first time
     (28 fallback-less consumers had shipped invalid for years; 6 live
     groups codified to shipped rendering first: inherit/transparent/
     currentColor) + ~280 literals tokenized across 50 files.
  5. 20b4896b — --color-muted (#969798, ~168 swaps) + --radius-default
     (4px, 137 swaps) defined + rolled out; reboot-generic button radius
     triplets KEEP LITERAL (dedup-twin re-appearance in all 13 bundles).
  6. WP1.2 closed obsolete, WP1.4 closed net-negative (see WP sections
     for evidence; WP1.4: raw −6% but gzip +2-3% — transfer size LOST).
- **Gate additions (reusable)**: swap-gate.sh (symmetric rule-level diff,
  generic :root-def strip, inline-bundle extraction) + mq-fingerprint.pl
  (viewport fingerprint: last-wins winner per selector/property from
  active @media contexts at each breakpoint width — proves computed
  equivalence for merge-product churn, twin re-splits, shorthand↔longhand).
- **FCP evidence**: first-fold page HTML byte-identical pre/post token
  work; external bundles +4.8KB raw (+0.18%), gzip-neutral.
- **Quality**: per commit — swap gate + fingerprint where bytes moved +
  test:critical 46/46 + dtest 46/46. Zero visual regressions.

### 2026-07-12 (sprint 6 — swarm-verified cleanup)
- **Landed** (branch css-migration/wp1.1-sprint-6, stacked on sprint-5,
  4 commits): executed via swarm — two read-only verification agents
  (deletion-manifest builder + header-race analyst), all mutations
  sequential in the main loop under the standard gate.
  1. e39ac043 — nav -active menu state removed (analyst option c). The
     partialCached race means active-state NEVER worked (frozen from
     first-rendered page; steady state = nothing highlighted) and was a
     screenshot-flake source. Zero visual change: all 780 pages carrying
     the inline nav bundle diff by exactly the two removed dead .-active
     rules (verified per page). Alternative option b (make it work: key
     header-content cache by computed active-menu id, 9 entries, ~1-2h,
     baseline churn on section pages) documented for Paul.
  2. b2cce936 — draft-only _test apparatus deleted: content/_test/,
     layouts/_test/single.html + its 3 orphan partials
     (components/hero-section, use-case-card, testimonial).
     **CORRECTION to sprint-5 follow-up**: component-bundle.css is LIVE
     (blog-list-css-resources.html:19 + free-consultation:7) — it and its
     @imported component CSS (c-hero-sections, c-cta-blocks, c-pp-*) stay.
  3. 616a94de — 6 more zero-loader CSS files deleted (swarm sweep):
     accessibility-focus, bem-404-conversion, bem-home-page-minimal,
     cta-backgrounds, fl-foundation, mobile-fixes. No resources.Match
     globs exist in the theme, so loader counts are exhaustive.
     bem-home-page-minimal carried the dead --cta-button-bg token —
     that sprint-4 repoint follow-up dissolves.
  4. 6166f561 — 3 zero-caller data partials deleted:
     partials/data/{authors,testimonials,company}-cached.html.
- **Gate**: per commit — converged production build diffed against the
  prior commit's converged build (bundles + inline styles byte-identical,
  zero non-noise HTML diffs) + test:critical 46/46 + dtest 46/46.
  Zero rollbacks.
- **Remaining follow-ups**: inline components tree tokenization (~19
  literals); --jt-text-color/--jt-text-primary repoint (Paul);
  fl-common-modules.css reboot purge (own sprint); WP1.2; optional
  option-b nav active-state revival (Paul).

### 2026-07-12 (sprint 5 — orphan cleanup)
- **Landed** (branch css-migration/wp1.1-sprint-5, one bundled PR, 6 commits,
  28 files, +24/-67,517):
  1. 08b0c6e3 — dead aggregators deleted: critical.css,
     _consolidated-layouts.css, _consolidated-components.css (zero loaders;
     the last was NOT on the sprint-4 list but is the same class — flagged),
     plus forms.css (its only importer was _consolidated-components.css).
  2. 6a92e204 — all 13 orphan CSS files deleted (66,459 lines): the 9
     fl-*-layout files, fl-clients{,-alt}-bundle, beaver-grid-layout,
     utilities.css. Only remaining refs were provenance comments. The ~157
     untokenized #121212 literals from the sprint-4 count leave with them.
  3. 23eda403 — dead variables/colors.css deleted; stale comments pointing
     at it fixed (foundations/css-variables.css, c-navigation.css).
  4. c458213b — dead templates deleted: page/service-template.html (no
     content uses the layout; only loader of fl-service-detail-layout.css),
     partials/homepage/services.html + clients.html (zero callers / only
     called by each other), partials/components/cta-block.html (only caller
     was the draft-only _test layout; test section removed there too).
  5. 31e0e9a6 — dead .c-content-block__paragraph rule pair deleted from
     content-block.css (the sprint-4 flicker source) + commented-out
     components/forms import removed.
  6. 21ca3789 — [[build.cachebusters]] hugo_stats.json → css added to
     hugo.toml (Hugo defaults replicated alongside, since custom entries
     replace them). Verified: cold-cache build now byte-matches warm build;
     before the fix this sprint's own baseline reproduced the flicker (cold
     differed from warm by 7 inline navigation-bundle rules).
- **Gate method**: per commit — converged production build to scratch
  (build twice, take the second) diffed against a converged pre-sprint
  baseline: all 19 css bundle hashes + inline style blocks byte-identical,
  whole-tree HTML diff empty modulo documented noise (sw.js?v= stamp,
  taxonomy term-casing races). test:critical 46/46 + dtest 46/46 per
  commit. Zero rollbacks.
- **NEW FINDING — header partialCached race (pre-existing, NOT fixed)**:
  partials/page/header.html caches header-content.html via partialCached
  with NO variant key, so the whole header (incl. navigation -active
  state) is computed once from whichever page renders first and reused on
  ALL pages. One build during this sprint marked "Blog" -active on all
  1300 pages; the steady state is NO item ever -active. Menu active-state
  is effectively dead/nondeterministic site-wide. Fix (own change, visual
  impact): key the cache by section/menu-state or drop active-state from
  the cached fragment.
- **New follow-ups**:
  - hero-section.html, testimonial.html, use-case-card.html + the _test
    layout/content are only reachable via the draft-only test page —
    delete-or-keep decision (they'd take the remaining
    .c-content-block__text/.u-text-center dead classes with them).
  - header partialCached -active race (above).
- **Carried follow-ups**: inline components tree tokenization (~19
  literals) if components.css gets the foundation; --jt-text-color /
  --cta-button-bg repoint decision (deliberate value change — Paul);
  fl-common-modules.css Bootstrap reboot purge (own sprint); WP1.2.

### 2026-07-12 (sprint 4)
- **Landed** (branch css-migration/wp1.1-sprint-4, one bundled PR, 6 commits):
  1. fbd38c63 — blog-list bundleName collision fixed via shared partial
     assets/blog-list-css-resources.html. CORRECTION to the sprint-3 log:
     taxonomy pages DO generate — 383 /blog/tags/* pages render through root
     list.html; both templates raced for the "blog-list" concat name and
     blog/list.html's slice always won (verified in scratch builds AND live
     site), so sprint 3's css-variables wiring for "taxonomy list" was
     silently ineffective. Fix is deterministic-by-construction; compiled
     output byte-identical (all 19 bundle hashes unchanged).
  2. a621f8f6 — LIVE BUG: single-service bundle shipped 17 unresolved
     var(--font-system-ui) (sprint-1 no-base sweep missed services/single.html);
     foundation wired in, +1 :root rule, everything else byte-identical.
  3. 9c264fa3 — --color-dark:#121212 defined in foundations/css-variables.css
     (canonical home; the variables/colors.css copy is bundled NOWHERE — dead
     file, delete candidate). Made already-shipped var(--color-dark) consumers
     (free-consultation gform/accordion rules) resolve; reviewer traced every
     consumer selector against rendered HTML — no visible change.
  4. e25d9f00 — blog-list bundle wired with the foundation (its
     services-layout/homepage-layout consumers were invalid at computed-value
     time; consumer markup renders on none of the bundle's pages).
  5. 48bb2c71 — #121212→var(--color-dark): 384 swaps across 29 files (19 live
     layout/bundle files whole-file + 10 critical/* minus reboot generics).
  6. 662b59cb — batch 3: skin/theme-main/navigation scoped lines (20 swaps);
     the site-wide inline navigation bundle now carries the def, so
     --color-dark resolves on every page.
- **Totals**: 404/648 literals tokenized. Kept by design (all carry KEEP
  LITERAL comments in-file): 25 reboot-generic body/h1 color rules in
  critical/*, 10 fl-button dedup-twin border-colors (8 critical + skin
  L2401/2411), 6 invisible-border border-colors (skin woo L1077/1105,
  theme-main L1227/1288/3167/3233), 2 shadow-token defs (theme-main --jt-*),
  2 bare-textarea selector parts, skin/theme-main/navigation body+h1 generics.
  ~157 literals sit in 13 ORPHAN files (delete, don't tokenize — follow-up),
  ~19 in the inline components tree (deferred), forms.css 7 (dead import).
- **Gate method (option-a, evolved)**: per commit — production build to
  scratch + SYMMETRIC rule-level diff (normalize var↔literal both sides,
  strip the def, require empty diff + equal rule counts per bundle; inline
  bundles extracted from compiled HTML and diffed the same way). Caught three
  masking classes the visual suites alone would miss:
  (a) dedup-twin rule RE-appearance when only one of two byte-identical
      same-selector rules in a bundle is tokenized (590↔homepage-critical,
      e966db44↔single-careers) → tokenize bundles atomically;
  (b) minifier border shorthand/longhand merge-product churn when
      border-color goes var() on style:none invisible borders → keep literal;
  (c) cssnano merge-hoist on reboot-generic body/h1 rules (sprint-3 class).
- **Pre-existing build nondeterminism documented (visually inert)**: inline
  components bundle flickers dead rules (.c-content-block__paragraph pair)
  between builds — the class exists only in dead templates so hugo_stats.json
  omits it while stale postcss cache sometimes preserves it; no
  [[build.cachebusters]] for hugo_stats.json configured. Benign per-build HTML
  noise: sw.js?v= stamp, taxonomy term-title casing races (CrewAI vs Crewai —
  live tag-page titles are nondeterministic), sitemap order. Sprint-start
  3-failure macOS flake (mobile 404/blog text shift) was a cold-worktree
  first-run flake; re-run green.
- **Quality**: per commit — rule-level gate + bin/rake test:critical 46/46 +
  bin/dtest 46/46 + standing reviewer approval with independent re-derivation.
  Zero rollbacks.
- **New follow-ups**:
  - Cleanup PR: delete 13 orphan CSS files (fl-use-cases-layout,
    beaver-grid-layout, fl-clients-alt-bundle, fl-services-layout,
    fl-homepage-layout, fl-contact-layout, fl-clients-bundle,
    fl-careers-layout, fl-about-layout, fl-clients-layout,
    fl-component-layout, utilities.css, fl-service-detail-layout) + dead
    aggregators (critical.css, _consolidated-layouts.css) + dead
    page/service-template.html + dead variables/colors.css + dead partials
    (homepage/services.html, homepage/clients.html, components/cta-block.html)
    + dead .c-content-block__paragraph rules + commented-out forms import.
  - Add [[build.cachebusters]] (hugo_stats.json → css).
  - Inline components tree tokenization if components.css gets the foundation.
  - Decide: repoint theme-main --jt-text-color/--jt-text-primary and
    bem-home-page-minimal --cta-button-bg at var(--color-dark) (deliberate).
  - fl-common-modules.css Bootstrap reboot purge ASSESSED & DEFERRED: block
    ~L425-540 + second body reboot ~L560; @imported by 28 files; rules are
    live-in-cascade (overridden, not dead) — needs per-page computed-style
    proof (h1 size, body color) per bundle; own sprint.
  - WP1.2 (reset utilities) not started.

### 2026-07-11 (sprint 3)
- **Landed**: orphaned use-cases-critical.css deleted (265 lines); 8 invalid
  mid-file @charset removed; css-variables foundation wired into the 4
  bundles that lacked it (blog-single, taxonomy list, not_found, course-single)
- **ROLLED BACK**: skin-65eda28877e04.css font-stack extraction (6 stacks).
  Root cause: postcss-delete-duplicate-css (production builds only) deletes
  the later of two byte-identical declarations; converting skin's body
  font-family to var() made it duplicate an earlier critical-CSS declaration,
  unmasking a short-variant body rule as cascade winner → 17 macOS screenshot
  diffs (Linux green — font resolution masks it). See memory
  project-css-var-extraction-dedup-trap.
- **RESOLVED (Paul chose option a — per-case production-bundle masking
  analysis)**: skin extraction landed for the 3 button-group stacks only
  (d0da5e7b); body/h1/h1-h6 stay literal with KEEP LITERAL comments —
  v2 attempt confirmed the minifier hoists merged h1 rules up-cascade
  (reviewer hand-traced h1 70px→40px inversion; 17 macOS diffs).
  --color-ruby rollout complete: token defined (91d5da27), foundation
  inlined site-wide via baseof navigation bundle (987935a1), all 14
  literal declarations replaced across style.css/navigation.css/
  single-post.css (6ba9b23b, ef907fc8, 1ae080e0) — each commit gated by
  production-bundle rule-level diff + rule-count check + both platform
  suites; zero rollbacks needed under the option-a protocol.
- **New follow-ups**: root list.html is dead code (no taxonomy pages
  generated; its "blog-list" bundleName collides with blog/list.html's) —
  rename or remove; --color-ruby token name approved by Paul for #cc342d.

### 2026-07-11 (sprint 2)
- **Action**: Dead Bootstrap :root block deleted from all 8 critical files
- **Metrics**: 8 commits (763996f2..17838e2d), 280 lines removed, 0 added
- **Quality**: 100% test pass both platforms per commit, 0 visual regressions;
  reviewer independently re-verified zero consumers of all 28 vars
- **New follow-ups**: stray mid-file @charset in single-services.css,
  single-use-cases.css, fl-common-modules.css (pre-existing concat leftovers)
- **Next**: WP1.1 remaining variables (--color-primary already exists in
  variables/colors.css naming — reconcile), orphaned use-cases-critical.css

### 2026-07-11
- **Action**: WP1.1 sprint 1 executed — --font-system-ui extraction complete
- **Status**: WP1.1 🔄 In Progress; Phase 1 progress 0→~0.5/4 WPs
- **Metrics**: 10 commits, 9 files, +44/-420 lines (376 net eliminated)
- **Quality**: 100% test pass maintained (macOS + Linux gates per commit), 0 visual regressions
- **Findings**: careers bundle unresolved-var defect fixed; use-cases-critical.css orphaned (follow-up); 35-line :root Bootstrap block duplicated across 8 critical files (queued for sprint 2)
- **Next**: WP1.1 remaining variables (--color-primary, --color-text, spacing/radius) + :root dedup

### 2025-01-27
- **Action**: Initial task tracker created
- **Status**: All phases set to "Not Started"
- **Baseline**: 0 lines eliminated, 0 commits, 0 foundation files
- **Next**: Ready for Phase 1 WP1.1 execution (CSS Variables Foundation)

---

## 📋 QUICK ACTIONS

### Start the next sprint
```bash
# Current: Sprint C1 (shared-component extraction) — see PHASE C section
git checkout -b css-migration/c1-shared-components
# Follow the spec §"Phase C": 2026-07-12-css-maintainability-redesign.md
# Gate stack EVERY commit: converged build ×2 → bundle rule-diff →
#   headless RMSE 0 → bin/rake test:critical → bin/test AND bin/dtest
# ZERO baseline changes (refactor tolerance 0.0); one bundled PR per sprint
```

### Update this tracker after a sprint
```bash
# Flip Phase 0 item / rewrite sprint status; update FL burn-down count
# Update css-bundle-ownership-map.md statuses in the same commit
# Add an UPDATE LOG entry; bump "Last Updated" at top
```

### Check goal completion
```bash
# Success criteria live in: 2026-07-12-css-maintainability-redesign.md
# FL layout files: 0 remaining (css-bundle-ownership-map.md burn-down)
# No hash-named CSS files; no fl-node-* markup in templates
# Both snapdiff suites green; per-page payload checked compiled+gzip
```

---

**Navigation**:
- 🏠 [Project Index](PROJECT-INDEX.md)
- 🎯 [Approved spec (authority)](2026-07-12-css-maintainability-redesign.md)
- 🗺️ [Bundle ownership map + burn-down](css-bundle-ownership-map.md)

**Last Updated**: 2026-07-17
**Next Update**: After Phase 0 item completion or status change
