# CSS Migration Task Tracker

**Purpose**: Real-time work package status tracking for CSS duplication elimination goal
**Update Frequency**: After each work package completion or status change
**Last Updated**: 2025-01-27
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

#### WP1.1: CSS Variables Foundation 🔲 NOT STARTED
```yaml
status: 🔲 Not Started
priority: P0 🔥 Critical
duration: 4-6 hours
files_affected: 12 inline critical CSS files
impact: 2.8KB savings, ~50 lines eliminated
micro_commits_target: 15-20 commits

tasks:
  - [ ] Create _css-variables.scss with design tokens
  - [ ] Extract --font-system-ui variable (18 font-family declarations)
  - [ ] Extract --color-primary, --color-secondary, --color-text
  - [ ] Extract --border-radius-default, --spacing-unit
  - [ ] Update 12 inline critical CSS files to reference variables
  - [ ] Validation: bin/rake test:critical (all pass)
  - [ ] Validation: FCP metrics unchanged

blockers: NONE
dependencies: NONE (can start immediately)
assigned_to: TBD
started_date: -
completed_date: -
actual_duration: -
actual_commits: -
notes: Foundation for all CSS variable usage
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
