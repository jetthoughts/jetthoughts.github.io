# CSS Migration Project 2509 - Master Index

**Quick Start for Agents**: This is your ONE-STOP navigation hub for the CSS migration project.

**Last Updated**: 2025-01-27
**Project Status**: ✅ READY FOR EXECUTION - Phase 1 (Critical CSS Inline Consolidation)
**Current Goal**: Eliminate 70-80% CSS duplication (27,094-31,536 lines)

---

## 🚀 IMMEDIATE ACTION - START HERE

### For Executing Agents (Ready to Work)
```bash
# Step 1: Read the current goal
Read: 35-39-project-management/35.04-revised-goal-css-duplication-elimination.md

# Step 2: Check current task status
Read: TASK-TRACKER.md

# Step 3: Understand project context
Read: ANALYST-CONTEXT.md

# Step 4: Review top duplication patterns
Read: 10-19-analysis/10.06-fl-builder-duplication-analysis.md (Top 5)
Read: 10-19-analysis/10.09-css-duplication-patterns-6-15-analysis.md (Patterns #6-#15)
```

### For Research/Analysis Agents
```bash
# Step 1: Project overview and context
Read: ANALYST-CONTEXT.md

# Step 2: Current goal and success criteria
Read: 35-39-project-management/35.04-revised-goal-css-duplication-elimination.md

# Step 3: Comprehensive duplication analysis
Read: 10-19-analysis/10.06-fl-builder-duplication-analysis.md
Read: 10-19-analysis/10.09-css-duplication-patterns-6-15-analysis.md
```

---

## 📋 CORE PROJECT DOCUMENTS (Priority Order)

### 🎯 Goals & Planning (MUST READ FIRST)

1. **CURRENT GOAL** (PRIMARY AUTHORITY)
   - File: `35-39-project-management/35.04-revised-goal-css-duplication-elimination.md`
   - Purpose: Complete goal statement, SMART criteria, 3-phase execution plan, work packages
   - Status: ✅ Active - Ready for Phase 1 execution
   - Key Metrics: 27,094-31,536 lines eliminated (70-80% reduction)

2. **TASK TRACKER** (DAILY REFERENCE)
   - File: `TASK-TRACKER.md`
   - Purpose: Real-time work package status, current phase progress, blockers
   - Update Frequency: After each work package completion
   - Format: Phase → Work Package → Tasks → Status

3. **ANALYST CONTEXT** (NAVIGATION HUB)
   - File: `ANALYST-CONTEXT.md`
   - Purpose: Must-review documents, project status, documentation structure
   - Key Sections: Current Goal, Documentation Structure, Hugo Pipeline Status

4. **GOAL AT A GLANCE** (QUICK REFERENCE)
   - File: `GOAL-AT-A-GLANCE.md`
   - Purpose: 1-page executive summary with key metrics and current status
   - Use: Quick orientation, status checks, executive updates

### 📊 Analysis & Findings (REFERENCE)

5. **Top 5 Duplication Patterns**
   - File: `10-19-analysis/10.06-fl-builder-duplication-analysis.md`
   - Coverage: Patterns #1-#5 (~2,184-3,368 lines)
   - Priorities: All P0 Critical 🔥
   - Key Patterns: FL-Builder Responsive Display, FL-row, FL-col, @imports, Screen Reader

6. **Patterns #6-#15 Analysis**
   - File: `10-19-analysis/10.09-css-duplication-patterns-6-15-analysis.md`
   - Coverage: Patterns #6-#15 (~5,655 lines)
   - Priorities: Mixed P0/P1/P2
   - Key Patterns: Media queries, Typography, Grid/Flexbox, FL-modules, Transitions, Animations

7. **Critical Findings**
   - File: `10-19-analysis/10.01-critical-findings.md`
   - Purpose: Known blockers, critical issues, dependencies
   - Review: Before starting any work package

8. **Hugo Pipeline Strategy**
   - File: `30-39-documentation/30.05-hugo-pipeline-enhancement-strategy.md`
   - Purpose: Hugo integration, PurgeCSS roadmap, critical CSS automation
   - Phase: Phase 3 (Optional enhancements)

---

## 📂 DOCUMENTATION STRUCTURE (Johnny Decimal)

### 10-19: Analysis & Research
```
10-19-analysis/
├── 10.01-critical-findings.md              # Known blockers and issues
├── 10.02-optimization-recommendations.md   # Performance optimization guidance
├── 10.03-performance-baseline.md           # Baseline metrics
├── 10.04-duplication-analysis.md           # Original duplication analysis
├── 10.06-fl-builder-duplication-analysis.md # TOP 5 PATTERNS (MUST READ)
└── 10.09-css-duplication-patterns-6-15-analysis.md # PATTERNS #6-#15 (MUST READ)
```

### 20-29: Components (Reserved)
```
20-29-components/
└── [Component-specific migration data - future use]
```

### 30-39: Documentation & Strategy
```
30-39-documentation/
├── 30.05-hugo-pipeline-enhancement-strategy.md  # Hugo integration strategy
└── 30.06-documentation-update-summary-2025-10-12.md # Update log
```

### 35-39: Project Management
```
35-39-project-management/
└── 35.04-revised-goal-css-duplication-elimination.md # CURRENT GOAL (PRIMARY)
```

### 50-59: Testing & Validation
```
50-59-testing/
├── 50.01-testing-protocol.md                    # Testing standards
└── 50.03-visual-checkpoints/
    └── VISUAL_TESTING_PROTOCOL.md               # Visual regression protocol
```

### 70-79: Archives
```
70-79-archives/
├── HISTORICAL-SPRINT-DATA.md                    # Legacy sprint data
└── legacy-css-migration-data/                   # Historical analysis
```

### _runtime: Temporary Working Files
```
_runtime/
├── DUPLICATION-ELIMINATION-PLAN-2025-10-12.md   # Working plan docs
├── CSS-LOADING-ANALYSIS-2025-10-12.md           # CSS loading analysis
└── XP-TEAM-DEPLOYMENT-2025-10-12.md             # XP team coordination
```

---

## 🎯 WORK PACKAGE QUICK REFERENCE

### Phase 1: Critical CSS Inline Consolidation (20-30 hours)
| WP | Pattern | Files | Lines | Priority | Status |
|----|---------|-------|-------|----------|--------|
| WP1.1 | CSS Variables Foundation | 12 | ~50 | P0 🔥 | 🔲 Not Started |
| WP1.2 | Reset Utilities | 12 | ~129 | P0 🔥 | 🔲 Not Started |
| WP1.3 | PowerPack Infobox | 1 | ~30 | P1 ⚠️ | 🔲 Not Started |
| WP1.4 | Media Query Consolidation | 12 | ~100-120 | P1 ⚠️ | 🔲 Not Started |

**Phase 1 Target**: 300-400 lines eliminated

### Phase 2: FL-Builder Foundation Extraction (40-50 hours)
| WP | Pattern | Files | Lines | Priority | Status |
|----|---------|-------|----------|----------|--------|
| WP2.1 | FL-Row Foundation | 7 | 800-1,200 | P0 🔥 | 🔲 Not Started |
| WP2.2 | FL-Col Grid | 7 | 600-900 | P0 🔥 | 🔲 Not Started |
| WP2.3 | FL-Visible Responsive | 7 | 500-800 | P0 🔥 | 🔲 Not Started |
| WP2.4 | Foundation Integration | All | - | - | 🔲 Not Started |

**Phase 2 Target**: 1,900-2,900 lines eliminated

### Phase 3: Additional Patterns + Hugo (20-45 hours)
| WP | Pattern | Files | Lines | Priority | Status |
|----|---------|-------|-------|----------|--------|
| WP3.1 | Background Patterns | 7 | 400-600 | P2 📋 | 🔲 Not Started |
| WP3.2 | @import Deduplication | 7 | 84-168 | P2 📋 | 🔲 Not Started |
| WP3.3 | Hugo Pipeline (OPTIONAL) | Config | - | - | 🔲 Not Started |
| WP3.4 | PostCSS Final Validation | All | - | - | 🔲 Not Started |

**Phase 3 Target**: 484-768 lines + Hugo enhancements

---

## 📊 PROJECT METRICS DASHBOARD

### Current State (Baseline)
```yaml
css_files:
  total_lines: 44,420
  duplication: 70-80% (31,094-35,536 lines)
  foundation_files: 0

inline_critical_css:
  total_lines: 1,357
  duplication: 35-40% (450-550 lines)
  page_templates: 12

top_15_patterns_identified:
  total_duplication: 7,839-9,023 lines (17.6-20.3% of total)
  potential_reduction: 6,663-8,572 lines (85-95% consolidation)
  foundation_files_needed: 7
```

### Target State (Goal Complete)
```yaml
css_files:
  total_lines: 11,884-17,326
  reduction: 27,094-31,536 lines (70-80%)
  foundation_files: 5-7

inline_critical_css:
  total_lines: 950-1,050
  reduction: 300-400 lines (30-40%)

quality_maintained:
  test_pass_rate: 100%
  visual_regressions: 0
  lighthouse_score: 95+
```

---

## 🔍 AGENT SEARCH STRATEGIES

### Finding Duplication Patterns
```bash
# Semantic search for specific patterns
claude-context search "FL-row foundation pattern CSS" \
  --path "/Users/pftg/dev/jetthoughts.github.io/themes/beaver/assets/css"

# Search project documentation
claude-context search "media query breakpoints duplication" \
  --path "/Users/pftg/dev/jetthoughts.github.io/docs/projects/2509-css-migration"
```

### Finding Work Package Details
```bash
# Direct file reads for work package specs
Read: 35-39-project-management/35.04-revised-goal-css-duplication-elimination.md
# Search for: "WP1.1", "WP2.1", etc.

# Pattern-specific implementation guidance
Read: 10-19-analysis/10.06-fl-builder-duplication-analysis.md
Read: 10-19-analysis/10.09-css-duplication-patterns-6-15-analysis.md
```

### Finding Test Protocols
```bash
# Testing standards
Read: 50-59-testing/50.01-testing-protocol.md

# Visual regression protocols
Read: 50-59-testing/50.03-visual-checkpoints/VISUAL_TESTING_PROTOCOL.md
```

---

## 🚨 CRITICAL CONSTRAINTS

### Zero-Tolerance Policies
- ✅ **100% test pass rate** - ALL tests must pass after every change
- ✅ **Zero visual regressions** - ≤3% screenshot tolerance (0% for refactoring)
- ✅ **Micro-commits** - ≤3 lines per commit, commit on green tests
- ✅ **Solo autonomous execution** - NO swarm spawning for mechanical work
- ✅ **Test-after-each-change** - Run `bin/rake test:critical` after every file change

### Out of Scope (Deferred)
- ❌ FL-node HTML migration (572 HTML refs + 8,449 CSS rules)
- ❌ BEM class system replacement
- ❌ Complete CSS architecture redesign
- ❌ Visual design changes

### Hugo Pipeline Status
- ✅ **Already Optimal**: resources.Concat, PostCSS, fingerprinting, minification
- 🎯 **Our Goal**: SOURCE CSS duplication elimination (NOT pipeline changes)
- 📋 **Phase 3 Optional**: PurgeCSS, automated critical CSS (can be separate initiative)

---

## 🛠️ VALIDATION COMMANDS

### After Each Change
```bash
# Run critical test suite (MANDATORY)
bin/rake test:critical

# If GREEN → commit and continue
# If RED → rollback immediately, investigate, fix
```

### After Each Work Package
```bash
# Full validation protocol
bin/rake test:critical                    # All tests
bin/rake test:visual                      # Visual regression
lighthouse http://localhost:1313          # Performance metrics
```

### CSS Analysis
```bash
# Check duplication levels
grep -r "FL-row" themes/beaver/assets/css/fl-*.css | wc -l

# Validate PostCSS compilation
hugo --gc --minify
```

---

## 📚 CROSS-REFERENCES

### Global Knowledge Base
- **TDD Methodology**: `/knowledge/20.01-tdd-methodology-reference.md`
- **Shameless Green**: `/knowledge/20.05-shameless-green-flocking-rules-methodology.md`
- **File Management**: `/knowledge/50.01-global-file-management.md`
- **Four-Eyes Principle**: `/knowledge/20.02-four-eyes-principle-global.md`

### Related Projects
- **elital_search**: `/projects/elital_search/docs/` (AI search patterns)
- **snap_diff-capybara**: `/projects/snap_diff-capybara/docs/` (Visual testing tools)

### External References
- **Hugo Pipes**: https://gohugo.io/hugo-pipes/introduction/
- **PostCSS**: https://gohugo.io/hugo-pipes/postcss/
- **PurgeCSS**: https://purgecss.com/plugins/postcss.html

---

## 🔄 UPDATE PROTOCOL

### When to Update This Index

**After each phase completion**:
1. Update work package status in TASK-TRACKER.md
2. Update metrics in GOAL-AT-A-GLANCE.md
3. Update phase status in this index
4. Update "Last Updated" date at top

**After discovering new patterns**:
1. Add pattern to analysis documents
2. Update duplication metrics
3. Update work package estimates

**After critical findings**:
1. Update 10-19-analysis/10.01-critical-findings.md
2. Update blockers section in TASK-TRACKER.md
3. Update risk assessment in goal document

---

## 📞 AGENT COORDINATION

### For Solo Execution (Recommended)
```yaml
approach: "Autonomous continuous execution"
validation: "bin/rake test:critical after each change"
commit_strategy: "Micro-commits on green tests (≤3 lines)"
approval_gates: "NONE (continuous work to goal completion)"
stop_conditions: "Critical test failures ONLY"
```

### For Complex Work (Multi-Agent)
```yaml
trigger: "Complex TDD cycles, >3 component changes, new architecture"
pattern: "XP team with TDD specialists"
coordination: "Via MCP memory tools, NOT custom scripts"
four_eyes: "Required for architectural changes"
```

### Memory Coordination Namespaces
```yaml
phase_tracking: "css-migration/phase-{N}-complete"
work_packages: "css-migration/wp-{N}.{M}-status"
pattern_extraction: "css-migration/patterns/{pattern-id}"
validation_results: "css-migration/validation/{timestamp}"
```

---

## ✅ QUICK START CHECKLIST

### For New Agents Joining Project
- [ ] Read this PROJECT-INDEX.md (you are here)
- [ ] Read ANALYST-CONTEXT.md (project overview)
- [ ] Read 35.04-revised-goal-css-duplication-elimination.md (current goal)
- [ ] Read TASK-TRACKER.md (current status)
- [ ] Read Top 15 pattern analysis (10.06 + 10.09)
- [ ] Verify test suite works: `bin/rake test:critical`
- [ ] Understand Hugo pipeline status (already optimal)
- [ ] Review out-of-scope items (FL-node HTML deferred)

### For Executing Phase 1
- [ ] All checklist items above ✓
- [ ] Create feature branch: `feat/css-duplication-elimination`
- [ ] Start with WP1.1 (CSS Variables Foundation)
- [ ] Follow micro-commit discipline (≤3 lines per commit)
- [ ] Test after each file change
- [ ] Update TASK-TRACKER.md after each WP completion

---

**Navigation Tip**: Use `claude-context search "[topic]"` to find specific information across project documentation.

**Status Legend**:
- 🔲 Not Started
- 🔄 In Progress
- ✅ Completed
- ⚠️ Blocked
- 🔥 Critical Priority
- 📋 Medium Priority

**Last Updated**: 2025-01-27
**Project Owner**: CSS Migration Project Team
**Contact**: See ANALYST-CONTEXT.md for coordination details
