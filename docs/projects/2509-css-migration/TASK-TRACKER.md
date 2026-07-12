# CSS Migration Task Tracker

**Purpose**: Real-time work package status tracking for CSS duplication elimination goal
**Update Frequency**: After each work package completion or status change
**Last Updated**: 2026-07-12
**Current Phase**: Phase 1 - Critical CSS Inline Consolidation

---

## 🎯 GOAL OVERVIEW

**Objective**: Eliminate 70-80% CSS duplication (27,094-31,536 lines)
**Approach**: 3-phase execution with micro-commit discipline
**Execution Mode**: Solo autonomous (NO swarm spawning for mechanical work)
**Success Criteria**: 100% test pass rate, zero visual regressions maintained

**Quick Links**:
- 📋 [Full Goal Document](35-39-project-management/35.04-revised-goal-css-duplication-elimination.md)
- 📊 [Project Index](PROJECT-INDEX.md)
- 🔍 [Top 5 Patterns](10-19-analysis/10.06-fl-builder-duplication-analysis.md)
- 🔍 [Patterns #6-#15](10-19-analysis/10.09-css-duplication-patterns-6-15-analysis.md)

---

## 📊 OVERALL PROGRESS

```
Phase 1: Critical CSS Inline     [🔲🔲🔲🔲] 0/4 WPs    (0% complete)
Phase 2: FL-Builder Foundations  [🔲🔲🔲🔲] 0/4 WPs    (0% complete)
Phase 3: Additional Patterns     [🔲🔲🔲🔲] 0/4 WPs    (0% complete)

Total Progress: 0/12 work packages (0% complete)
Lines Eliminated: 0 / 27,394-31,936 target (0% complete)
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

#### WP1.1: CSS Variables Foundation 🔄 IN PROGRESS
```yaml
status: 🔄 In Progress (font-system-ui extraction COMPLETE 2026-07-11)
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
  - [ ] Extract --color-primary, --color-secondary, --color-text
  - [ ] Extract --border-radius-default, --spacing-unit
  - [x] Dedup the identical 35-line Bootstrap :root block copied across
        8 critical files — DELETED outright (sprint 2, 2026-07-11): zero
        var() consumers repo-wide, so no relocation needed; 280 lines
        removed; vendor base-4.min.css copy untouched
  - [x] Validation: bin/rake test:critical (46/46 pass, 84 screenshots 0 diffs)
  - [x] Validation: bin/dtest Linux gate (46/46 pass, per commit)
  - [ ] Validation: FCP metrics unchanged

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

#### WP1.2: Reset Utilities Extraction 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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

#### WP1.3: PowerPack Infobox Pattern 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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

#### WP1.4: Media Query Consolidation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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

### Phase 1 Summary
```yaml
work_packages_total: 4
work_packages_completed: 0
work_packages_blocked: 0
total_duration_target: 20-30 hours
total_duration_actual: 0 hours
total_lines_eliminated_target: 300-400 lines
total_lines_eliminated_actual: 0 lines
total_commits_target: 78-100 commits
total_commits_actual: 0 commits
```

---

## 📅 PHASE 2: FL-Builder Foundation Extraction

**Phase Status**: 🔲 Not Started
**Duration**: 40-50 hours (4-5 weeks part-time)
**Target Impact**: 1,900-2,900 lines eliminated
**Risk Level**: MEDIUM - Systematic extraction from 7 files

### Work Package Status

#### WP2.1: FL-Row Foundation Extraction 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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

#### WP2.2: FL-Col Grid Foundation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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

#### WP2.3: FL-Visible Responsive Foundation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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

#### WP2.4: Foundation Integration & Validation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
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
work_packages_completed: 0
work_packages_blocked: 0
total_duration_target: 40-50 hours
total_duration_actual: 0 hours
total_lines_eliminated_target: 1,900-2,900 lines
total_lines_eliminated_actual: 0 lines
total_commits_target: 100-135 commits
total_commits_actual: 0 commits
foundation_files_created: 0 / 3 (_fl-row, _fl-col, _fl-responsive-display)
```

---

## 📅 PHASE 3: Additional Pattern Consolidation + Hugo Enhancements

**Phase Status**: 🔲 Not Started
**Duration**: 20-30 hours (base) OR 30-45 hours (with Hugo enhancements)
**Target Impact**: 484-768 lines + optional Hugo pipeline improvements
**Risk Level**: LOW - Cleanup and optimization

### Work Package Status

#### WP3.1: Background Patterns Consolidation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
priority: P2 📋 Medium
duration: 10-14 hours
files_affected: 7 FL-Builder layout files
pattern: FL-row background patterns (colors, images, gradients)
impact: 400-600 lines eliminated
micro_commits_target: 30-40 commits

tasks:
  - [ ] Create _fl-background-utilities.scss
  - [ ] Extract common background patterns (colors, images)
  - [ ] Consolidate gradient definitions
  - [ ] Import utilities in layout files
  - [ ] Remove duplicated background CSS
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: Background visual tests (all 7 pages)

blockers: NONE
dependencies: Phase 2 complete (WP2.1-WP2.4)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Lower priority, can be deferred if needed
```

#### WP3.2: @import Statement Deduplication 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
priority: P2 📋 Medium
duration: 6-8 hours
files_affected: 7 FL-Builder layout files
pattern: Duplicate @import statements
impact: 84-168 lines eliminated
micro_commits_target: 15-20 commits

tasks:
  - [ ] Create master _fl-imports.scss
  - [ ] Consolidate all foundation imports into master file
  - [ ] Replace individual @import statements with master import
  - [ ] Validation: Build validation (CSS compilation)
  - [ ] Validation: No broken imports

blockers: NONE
dependencies: WP3.1 (all foundations extracted and stable)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Cleanup work, enhances maintainability
```

#### WP3.3: Hugo Pipeline Enhancements (OPTIONAL) 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
priority: OPTIONAL (can be separate initiative)
duration: 10-15 hours
files_affected: config.toml, postcss.config.js, layouts
impact: 20-40% additional CSS reduction + automated workflows
micro_commits_target: 15-20 commits

tasks:
  - [ ] Enable hugo_stats.json generation (config.toml)
  - [ ] Add postcss-purgecss plugin to postcss.config.js
  - [ ] Configure safelist for FL-Builder/PowerPack classes
  - [ ] Add postcss-critical for automated critical CSS
  - [ ] Update layouts to use automated critical CSS
  - [ ] Validation: Lighthouse audits (FCP, CLS improvements)
  - [ ] Validation: Bundle size comparison (before/after)

blockers: NONE
dependencies: WP3.2 (SOURCE CSS consolidation complete)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: See 30.05-hugo-pipeline-enhancement-strategy.md for details
reference: Can be executed as separate initiative if Phase 3 base completes
```

#### WP3.4: PostCSS Final Validation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
priority: P0 🔥 Critical (Phase gate)
duration: 4-8 hours
files_affected: All compiled CSS files
impact: Runtime validation, final duplication metrics
micro_commits_target: 5-10 commits

tasks:
  - [ ] Run PostCSS postcss-delete-duplicate-css plugin
  - [ ] Validate remaining duplication < 5%
  - [ ] Document any intentional duplication (with justification)
  - [ ] Generate final duplication metrics report
  - [ ] Validation: Build output analysis
  - [ ] Generate Phase 3 completion report

blockers: NONE
dependencies: WP3.1, WP3.2 complete (or WP3.3 if Hugo enhancements executed)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: MANDATORY - Phase 3 gate and goal completion validation
```

### Phase 3 Summary
```yaml
work_packages_total: 4 (3 base + 1 optional Hugo)
work_packages_completed: 0
work_packages_blocked: 0
total_duration_target: 20-30 hours (base) OR 30-45 hours (with Hugo)
total_duration_actual: 0 hours
total_lines_eliminated_target: 484-768 lines (base) + 20-40% (Hugo)
total_lines_eliminated_actual: 0 lines
total_commits_target: 50-70 commits (base) OR 70-100 commits (with Hugo)
total_commits_actual: 0 commits
foundation_files_created: 0 / 2 (_fl-backgrounds, _fl-imports)
```

---

## 🚨 BLOCKERS & RISKS

### Current Blockers
```yaml
phase_1_blockers: NONE - Ready to start immediately
phase_2_blockers: NONE - Waiting for Phase 1 completion
phase_3_blockers: NONE - Waiting for Phase 2 completion

critical_path_risks: NONE - All dependencies clear
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

### Lines Eliminated (Running Total)
```
Phase 1 Target:  300-400 lines    | Actual: 0 lines    | Progress: 0%
Phase 2 Target:  1,900-2,900 lines| Actual: 0 lines    | Progress: 0%
Phase 3 Target:  484-768 lines    | Actual: 0 lines    | Progress: 0%
─────────────────────────────────────────────────────────────────────
TOTAL Target:    27,394-31,936    | Actual: 0 lines    | Progress: 0%
```

### Micro-Commits (Running Total)
```
Phase 1 Target:  78-100 commits   | Actual: 0 commits  | Progress: 0%
Phase 2 Target:  100-135 commits  | Actual: 0 commits  | Progress: 0%
Phase 3 Target:  50-70 commits    | Actual: 0 commits  | Progress: 0%
─────────────────────────────────────────────────────────────────────
TOTAL Target:    300-390 commits  | Actual: 0 commits  | Progress: 0%
```

### Foundation Files Created
```
Target: 5-7 foundation files
Actual: 0 foundation files created

Planned:
  - _css-variables.scss (WP1.1)
  - _reset-utilities.scss (WP1.2)
  - _responsive-utilities.scss (WP1.4)
  - _fl-row-foundation.scss (WP2.1)
  - _fl-col-foundation.scss (WP2.2)
  - _fl-responsive-display.scss (WP2.3)
  - _fl-background-utilities.scss (WP3.1)
  - _fl-imports.scss (WP3.2)
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

### Start Next Work Package
```bash
# Current: WP1.1 CSS Variables Foundation (ready to start)
git checkout -b feat/css-duplication-elimination
# Create themes/beaver/assets/css/foundations/_css-variables.scss
# Update 12 inline critical CSS files
# Test after each file: bin/rake test:critical
# Commit on green (≤3 lines per commit)
```

### Update This Tracker After WP Completion
```bash
# Update work package status from 🔲 to ✅
# Update actual duration, commits, lines eliminated
# Update cumulative metrics
# Add notes/lessons learned
# Update "Last Updated" date at top
# Commit tracker changes
```

### Check Goal Completion
```bash
# Read goal document for success criteria
Read: 35-39-project-management/35.04-revised-goal-css-duplication-elimination.md

# Validate all phases complete
All 12 work packages: ✅ Completed

# Validate metrics targets met
Lines eliminated: 27,394-31,936 ✅
Foundation files: 5-7 ✅
Test pass rate: 100% ✅
Visual regressions: 0 ✅
```

---

**Navigation**:
- 🏠 [Project Index](PROJECT-INDEX.md)
- 🎯 [Current Goal](35-39-project-management/35.04-revised-goal-css-duplication-elimination.md)
- 📊 [Goal At A Glance](GOAL-AT-A-GLANCE.md)
- 🔍 [Analyst Context](ANALYST-CONTEXT.md)

**Last Updated**: 2025-01-27
**Next Update**: After WP1.1 completion or status change
