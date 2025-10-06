# Hive Mind Goal Plan: CSS Component Extraction & Duplication Removal

**Document Type**: Strategic Goal Plan for Swarm Coordination
**Date**: 2025-10-06
**Status**: READY FOR QUEEN BRIEFING
**Authority**: Goal Planner (GOAP Specialist)
**Target Audience**: Queen Seraphina + All Worker Agents (Researcher, Coder, Analyst, Tester)

---

## 🎯 EXECUTIVE SUMMARY

**Primary Objective**: Complete systematic CSS migration from FL-Builder architecture to maintainable BEM component system through extraction of reusable CSS+HTML components with ZERO duplication.

**Current State**: Phase 1B Complete (71% source file reduction: 105→30 files, 78 files consolidated into 3 masters)

**Critical Path**: Phase 2 requires transitioning from infrastructure consolidation to systematic component extraction with specialized agent coordination.

**Success Definition**:
- 20 high-priority components extracted following handbook-compliant patterns
- 430 HTML FL-node references migrated to BEM classes
- 8,148 CSS FL-node rules migrated to BEM selectors
- ZERO visual regressions maintained (≤3% tolerance)
- 100% test pass rate throughout

---

## 📋 PHASES & MILESTONES

### Phase 2A: Foundation Components (Weeks 1-4) - CRITICAL PATH

**Goal**: Establish layout and typography foundation that blocks all other work

**Components**:
1. **c-grid** (PAIR work, 40-60h) - Grid/Layout System
2. **c-text** (SOLO work, 20-30h) - Typography System
3. **c-button** (SOLO work, 15-20h) - Button System Completion
4. **c-navigation** (PAIR work, 25-35h) - Navigation System Completion

**Success Criteria**:
- All 4 foundation components extracted and tested
- HTML migration complete for all component instances
- Visual regression tests passing (≤3% tolerance)
- Performance baseline maintained or improved

**Blocking Dependency**: c-grid MUST complete before Phase 2B (layout foundation for content components)

---

### Phase 2B: Content Components (Weeks 5-7)

**Goal**: Content presentation and user engagement components

**Components**:
5. **c-hero-sections** (PAIR work, 30-40h) - Above-fold hero sections
6. **c-card** (SOLO work, 15-20h) - Content card system
7. **c-cta-blocks** (SOLO work, 10-15h) - Call-to-action blocks
8. **c-testimonial-section** (PAIR work, 20-25h) - Testimonial components
9. **c-infobox** (SOLO work, 12-18h) - Feature highlight blocks

---

### Phase 2C: Forms & Integration (Weeks 8-10)

**Goal**: User interaction and PowerPack plugin integration

**Components**:
10. **c-form + c-gravity-forms** (TEAM work, 40-50h) - Form system with Gravity Forms
11. **c-pp-advanced-menu** (TEAM work, 30-40h) - PowerPack navigation
12. **c-social-share** (SOLO work, 8-12h) - Social sharing buttons

---

### Phase 2D: PowerPack Cleanup (Weeks 11-12)

**Goal**: PowerPack component consolidation

**Components**:
13. **c-pp-buttons** (PAIR work, 15-20h) - PowerPack button variations
14. **c-pp-content-grid** (PAIR work, 18-24h) - PowerPack grid layouts
15. **c-pp-widgets** (PAIR work, 15-22h) - PowerPack widget system
16. **c-pp-infobox** (SOLO work, 10-15h) - Merge with c-infobox

---

### Phase 2E: Specialized Components (Weeks 13-14)

**Goal**: Edge cases and specialized functionality

**Components**:
17. **c-modal** (PAIR work, 12-18h) - Modal dialog system
18. **alerts.css** (SOLO work, 6-10h) - Alert/notification system
19. **c-feature-card--row2** (SOLO work, 4-8h) - Specific feature variant
20. **Final Validation** (TEAM work, 8-12h) - Comprehensive QA and documentation

---

## 👥 AGENT ROLE SPECIALIZATIONS & HANDBOOK REQUIREMENTS

### 🔬 RESEARCHER Agent - Pattern Analysis & Knowledge Discovery

**Primary Responsibilities**:
- Discover CSS duplication patterns across 13 critical files
- Research BEM architecture patterns from handbook
- Analyze component extraction methodologies
- Study visual testing strategies

**Required Handbook Study** (MANDATORY before starting):

1. **CSS Architecture Foundations**:
   - `/docs/30-39-architecture/35-css-semantic-architecture-guide.md` - BEM methodology, component hierarchy
   - `/docs/30-39-architecture/39-css-migration-patterns-and-guidelines.md` - Migration patterns, dual-class strategy
   - `/docs/component-extraction-architecture.md` - Component extraction templates, naming conventions

2. **Duplication Analysis Methodology**:
   - `/docs/projects/2509-css-migration/10-19-analysis/10.04-duplication-analysis.md` - Current duplication metrics
   - `/docs/projects/2509-css-migration/10-19-analysis/10.05-prioritized-component-extraction-roadmap.md` - Component priority matrix
   - `/knowledge/20.05-shameless-green-flocking-rules-methodology.md` - Flocking rules for refactoring

3. **Component Patterns Research**:
   - Study existing BEM components: c-button.css, c-hero-sections.css, c-navigation.css
   - Identify reusable patterns across templates
   - Document component parameter requirements

**Deliverables**:
- Duplication analysis reports per component
- Component extraction recommendations with complexity ratings (SOLO/PAIR/TEAM)
- Pattern libraries documenting reusable CSS structures
- Risk assessments for complex integrations (Gravity Forms, PowerPack)

**Success Metrics**:
- Accuracy of duplication severity predictions (validate against actual extraction effort)
- Quality of component parameter identification (reduces rework during extraction)
- Completeness of handbook pattern application research

---

### 💻 CODER Agent - Implementation & Extraction

**Primary Responsibilities**:
- Extract FL-Builder components into BEM Hugo partials
- Implement dual-class strategy (FL-Builder + BEM compatibility)
- Create component CSS files following BEM methodology
- Execute TDD RED-GREEN-REFACTOR cycles

**Required Handbook Study** (MANDATORY before starting):

1. **TDD Methodology** (CRITICAL - ZERO TOLERANCE):
   - `/knowledge/20.01-tdd-methodology-reference.md` - Core TDD principles
   - `/knowledge/20.11-tdd-agent-delegation-how-to.md` - TDD agent coordination
   - `/knowledge/20.05-shameless-green-flocking-rules-methodology.md` - Shameless green acceptance, flocking rules
   - `/CLAUDE.md` (lines 60-262) - Official TDD cycle pattern with RED-GREEN-REFACTOR phases

2. **Component Architecture** (MANDATORY):
   - `/docs/component-extraction-architecture.md` - Hugo partial template structure, BEM naming
   - `/docs/components/best-practices.md` - Parameter design, defensive validation
   - `/docs/30-39-architecture/35-css-semantic-architecture-guide.md` - Semantic CSS patterns

3. **Anti-Test-Smell Enforcement** (ZERO TOLERANCE):
   - `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md` - FORBIDDEN test patterns
   - `/docs/60.06-test-format-requirements-reference.md` - Minitest requirements, NO bash scripts
   - `/CLAUDE.md` (lines 264-343) - Behavioral testing mandate, rejection triggers

4. **File Management & Quality** (MANDATORY):
   - `/knowledge/50.01-global-file-management.md` - Anti-duplication protocols, FORBIDDEN file patterns
   - `/knowledge/20.02-four-eyes-principle-global.md` - Validation protocols with pairs

**Implementation Patterns** (COPY-PASTE READY):

**TDD RED Phase** (Test-First):
```ruby
# test/system/components/c_grid_component_test.rb
def test_grid_two_columns_renders_correctly
  visit "/"

  # BEHAVIORAL VALIDATION: Test what users see
  grid = find(".c-grid--two-columns", match: :first)
  assert grid.visible?, "Two-column grid should be visible"

  # VISUAL REGRESSION: Screenshot comparison
  assert_stable_screenshot "components/c-grid/two-columns", tolerance: 0.03
end
```

**TDD GREEN Phase** (Shameless Green - Accept Hardcoding):
```css
/* themes/beaver/assets/css/components/c-grid.css */

/* Fake It: Hardcoded two-column grid */
.c-grid--two-columns {
  display: grid;
  grid-template-columns: 1fr 1fr; /* Hardcoded - duplication acceptable */
  gap: 24px;
}
```

**TDD REFACTOR Phase** (Flocking Rules):
```css
/* Apply flocking rule 1: Select things most alike */
/* Both two-column and three-column grids have: same gap, same responsive behavior */

/* Apply flocking rule 2: Find smallest difference */
/* Difference: column count only */

/* Apply flocking rule 3: Make simplest change */
.c-grid {
  display: grid;
  gap: 24px; /* Extracted common property */
}

.c-grid--two-columns {
  grid-template-columns: repeat(2, 1fr); /* Only difference remains */
}

.c-grid--three-columns {
  grid-template-columns: repeat(3, 1fr); /* Only difference remains */
}
```

**Micro-Commit Protocol** (MANDATORY - ≤3 lines per commit):
```bash
# After each micro-change (≤3 lines)
bin/rake test:critical  # MUST pass
git add .
git commit -m "Extract c-grid: base class with gap property (≤3 lines)"

# Continue to next micro-change
```

**Deliverables**:
- Hugo component partials in `themes/beaver/layouts/partials/components/`
- BEM component CSS in `themes/beaver/assets/css/components/`
- Micro-commits after each ≤3 line change (5-20 commits/hour target)
- GREEN tests after every commit (100% pass rate)

**Success Metrics**:
- Test pass rate maintained at 100% throughout
- Micro-commit frequency: 5-20 commits/hour
- Zero file duplication violations (*_refactored, *_new, etc.)
- BEM naming compliance: 100% (c-[component], c-[component]__[element], c-[component]--[modifier])

---

### 📊 ANALYST Agent - Metrics & Progress Tracking

**Primary Responsibilities**:
- Track duplication reduction metrics (target: 70-80%)
- Monitor component extraction velocity
- Measure test coverage and quality
- Generate progress dashboards

**Required Handbook Study** (MANDATORY before starting):

1. **Metrics & Validation**:
   - `/docs/projects/2509-css-migration/GOAL-AND-PROGRESS.md` - Current progress baseline, success criteria
   - `/docs/projects/2509-css-migration/10-19-analysis/10.05-prioritized-component-extraction-roadmap.md` - Component priority matrix
   - `/knowledge/30.01-agent-coordination-patterns.md` - Memory coordination patterns for tracking

2. **Quality Gates**:
   - `/knowledge/20.02-four-eyes-principle-global.md` - Validation checkpoint requirements
   - `/CLAUDE.md` (lines 464-521) - Success metrics, quality validation checklist
   - `/docs/projects/2509-css-migration/50-59-testing/SPRINT-5-CSS-CONSOLIDATION-TEST-STRATEGY.md` - Test quality standards

3. **Performance Monitoring**:
   - Core Web Vitals baselines (FCP, LCP, CLS)
   - CSS bundle size tracking (target: 2.4MB → <800KB)
   - Test execution time monitoring (system <5s, unit <100ms)

**Tracking Deliverables**:

**Component Extraction Metrics**:
```yaml
component_extraction_dashboard:
  # Per-component tracking
  c-grid:
    status: "in_progress"
    complexity_rating: "PAIR"
    estimated_hours: 40-60
    actual_hours: 45
    duplication_reduction: "95% (3,000 lines)"
    html_refs_migrated: 274/2000 (13.7%)
    css_rules_migrated: 850/8148 (10.4%)
    test_status: "40/40 passing"
    visual_regression: "0% difference"

  # Program-level tracking
  program_totals:
    components_completed: 4/20
    total_html_refs: 274/430 migrated (63.7%)
    total_css_rules: 850/8148 migrated (10.4%)
    css_bundle_size: "2.1MB → 1.8MB (12.5% reduction so far)"
    test_pass_rate: "100% (0 failures)"
    visual_regression_incidents: 0
```

**Success Metrics**:
- Real-time dashboard accuracy (updated after each commit)
- Early warning detection for velocity slowdowns
- Accurate effort estimation (within 20% of actuals)
- Quality gate compliance tracking (100% adherence)

---

### 🧪 TESTER Agent - Quality Assurance & Visual Validation

**Primary Responsibilities**:
- Create behavioral tests (NOT existence tests)
- Execute visual regression testing with ≤3% tolerance
- Validate responsive behavior across viewports
- Maintain 100% test pass rate throughout migration

**Required Handbook Study** (MANDATORY before starting):

1. **Test Quality Requirements** (ZERO TOLERANCE):
   - `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md` - FORBIDDEN test smells (existence, implementation, configuration testing)
   - `/docs/60.06-test-format-requirements-reference.md` - Minitest ONLY, NO bash scripts, behavioral focus
   - `/CLAUDE.md` (lines 264-343) - Anti-test-smell behavioral framework
   - `/docs/60.14-test-quality-prevention-framework.md` - Computed style validation patterns

2. **Visual Testing Protocols**:
   - `/docs/20-29-testing-qa/screenshot-testing/20.02-screenshot-testing-workflow-tutorial.md` - Screenshot testing workflow
   - `/docs/60.11-visual-validation-requirements.md` - 3-phase validation (pre/during/post)
   - `/docs/projects/2509-css-migration/50-59-testing/SPRINT-3-TDD-TESTING-STRATEGY.md` - TDD testing strategy
   - `test/support/setup_snap_diff.rb` - Screenshot tolerance configuration

3. **Test Framework Integration**:
   - Study existing tests: `test/system/components/c_button_test.rb`
   - Capybara system test patterns
   - Visual regression helpers: `assert_stable_screenshot`, `assert_quick_screenshot`

**Test Creation Patterns** (COPY-PASTE READY):

**✅ CORRECT: Behavioral Visual Test**:
```ruby
# test/system/components/c_grid_test.rb
require "application_system_test_case"

class CGridTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "components/c-grid"
    super
  end

  # BEHAVIOR: Test what users see (grid layout renders correctly)
  def test_two_column_grid_renders_with_correct_layout
    visit "/"

    # BEHAVIORAL: Grid is visible to users
    grid = find(".c-grid--two-columns", match: :first)
    assert grid.visible?, "Grid should be visible to users"

    # BEHAVIORAL: Computed styles validate layout (implementation-independent)
    column_count = page.evaluate_script(
      "getComputedStyle(arguments[0]).gridTemplateColumns.split(' ').length",
      grid
    )
    assert_equal 2, column_count, "Grid should display 2 columns"

    # VISUAL REGRESSION: Screenshot comparison (≤3% tolerance)
    assert_stable_screenshot "c-grid/two-columns", tolerance: 0.03
  end

  # BEHAVIOR: Mobile responsive behavior
  def test_grid_stacks_on_mobile
    Capybara.current_driver = :mobile_chrome
    visit "/"

    grid = find(".c-grid--two-columns", match: :first)

    # BEHAVIORAL: Grid stacks to 1 column on mobile
    column_count = page.evaluate_script(
      "getComputedStyle(arguments[0]).gridTemplateColumns.split(' ').length",
      grid
    )
    assert_equal 1, column_count, "Grid should stack to 1 column on mobile"

    # VISUAL REGRESSION: Mobile screenshot
    assert_stable_screenshot "c-grid/two-columns-mobile", tolerance: 0.03
  end
end
```

**❌ FORBIDDEN: Existence/Implementation Testing**:
```ruby
# ❌ FORBIDDEN: Testing CSS class existence
def test_grid_class_exists  # BLOCKED
  page_html = page.html
  assert page_html.include?("c-grid--two-columns")  # Tests code, not behavior
end

# ❌ FORBIDDEN: Testing HTML structure
def test_grid_has_correct_html_structure  # BLOCKED
  assert_equal 2, page.all(".c-grid__item").count  # Tests implementation
end

# ❌ FORBIDDEN: Bash script "tests"
# test/test_grid.sh  # ABSOLUTELY FORBIDDEN
```

**Visual Regression Workflow**:

**Step 1: Capture Baseline** (Before component work):
```bash
# Capture reference screenshots with seed 60316
SCREENSHOT_SEED=60316 bin/rake test:critical
```

**Step 2: Continuous Validation** (During component work):
```bash
# After each micro-change
bin/rake test:critical
# Expected: 100% pass rate, ≤3% visual difference
```

**Step 3: Rollback on Failure** (MANDATORY):
```bash
# If ANY test fails OR visual regression >3%
git reset --hard HEAD~1
# Analyze failure, fix code (NEVER modify tests)
```

**Deliverables**:
- Behavioral system tests in `test/system/components/`
- Visual regression baselines in `test/fixtures/screenshots/`
- Test documentation explaining behavioral focus
- Zero test smell violations (tracked and reported)

**Success Metrics**:
- Test behavioral focus: 100% (zero existence/implementation tests)
- Visual regression incidents: 0 (≤3% tolerance maintained)
- Test pass rate: 100% throughout migration
- Test execution speed: System <5s each, Unit <100ms each
- Bash test script creation attempts: 0 (FORBIDDEN, must be rejected)

---

## 🔄 GRADUATED SPAWNING STRATEGY

### Work Classification Decision Matrix

**SOLO Execution** (40% of components - Autonomous batch processing):
- **Suitable Work**: Simple, repetitive patterns with low HTML coordination
- **Components**: c-text, c-button, c-card, c-cta-blocks, c-infobox, c-social-share, alerts.css
- **Agent Count**: 1 (Coder OR Researcher OR Analyst OR Tester)
- **Validation**: `bin/rake test:critical` after each file
- **Commit Strategy**: Micro-commits on green (≤3 lines)
- **Stop Conditions**: Critical test failures ONLY

**Example SOLO Workflow**:
```yaml
component: c-text (Typography System)
agent: Coder (solo)
approach:
  - Extract typography patterns autonomously
  - Test after each heading level (h1, h2, h3, etc.)
  - Commit on green tests (5-20 commits/hour)
  - Continue to completion without approval gates
duration: 20-30 hours
approval_gates: NONE (continuous work)
```

---

**PAIR Execution** (40% of components - Moderate complexity):
- **Suitable Work**: HTML+CSS coordination, interactive components, accessibility-critical
- **Components**: c-grid, c-navigation, c-hero-sections, c-testimonial-section, c-pp-buttons, c-modal
- **Agent Count**: 2 (Driver + Navigator with 25min rotation)
- **Pairing Patterns**:
  - HTML-Driver + CSS-Navigator (coordinated changes)
  - Coder-Driver + Tester-Navigator (TDD validation)
- **Validation**: Visual regression + interaction tests
- **Commit Strategy**: Paired commits after validation
- **Stop Conditions**: Visual regression OR test failures

**Example PAIR Workflow**:
```yaml
component: c-grid (Layout System)
agents:
  - Coder (Driver) - Implements grid CSS + HTML
  - Tester (Navigator) - Validates responsive behavior, accessibility
approach:
  - Driver implements grid structure
  - Navigator validates against test requirements
  - Rotate every 25 minutes
  - Pair approval before commits
duration: 40-60 hours
approval_gates: MINIMAL (pair approval only)
rotation_frequency: Every 25 minutes
```

---

**TEAM Execution** (20% of components - Complex architecture):
- **Suitable Work**: Multi-file integration, plugin dependencies, complex business logic
- **Components**: c-form + c-gravity-forms, c-pp-advanced-menu
- **Agent Count**: 4+ (Full XP team with specialists)
- **Team Composition**:
  - XP Coach (facilitate pair rotation, WIP=1 enforcement)
  - TDD Coordinator (RED-GREEN-REFACTOR orchestration)
  - Test Quality Expert (anti-test-smell detection)
  - Coder Pairs (Driver + Navigator with rotation)
- **Validation**: Comprehensive (unit, integration, visual, accessibility)
- **Commit Strategy**: Sprint-based with retrospectives
- **Stop Conditions**: ANY quality gate failure

**Example TEAM Workflow**:
```yaml
component: c-form + c-gravity-forms (Form System Integration)
agents:
  - XP Coach: Pair rotation facilitation
  - TDD Coordinator: Phase transition coordination
  - Test Quality Expert: Behavioral focus validation
  - Coder-Driver: Form CSS + HTML implementation
  - Coder-Navigator: Gravity Forms integration validation
  - Tester-Driver: Form interaction tests
  - Tester-Navigator: Accessibility validation
approach:
  - Full TDD RED-GREEN-REFACTOR cycle
  - Gravity Forms plugin integration coordination
  - Form validation state testing
  - 25min pair rotations with phase handoff
duration: 40-50 hours
approval_gates: STANDARD (XP team + Product Owner)
retrospective: After sprint completion
```

---

## 📚 HANDBOOK KNOWLEDGE MAP

### Critical Reading Paths by Agent Type

**ALL Agents** (Foundation - READ FIRST):
1. `/CLAUDE.md` - Project CLAUDE.md (TDD methodology, zero-tolerance policies)
2. `/knowledge/KNOWLEDGE_INDEX.md` - Global handbook navigation
3. `/docs/projects/2509-css-migration/GOAL-AND-PROGRESS.md` - Current progress baseline

**Researcher-Specific**:
4. `/docs/30-39-architecture/35-css-semantic-architecture-guide.md`
5. `/docs/component-extraction-architecture.md`
6. `/knowledge/20.05-shameless-green-flocking-rules-methodology.md`

**Coder-Specific**:
7. `/knowledge/20.01-tdd-methodology-reference.md`
8. `/knowledge/20.11-tdd-agent-delegation-how-to.md`
9. `/knowledge/50.01-global-file-management.md`

**Analyst-Specific**:
10. `/docs/projects/2509-css-migration/10-19-analysis/10.05-prioritized-component-extraction-roadmap.md`
11. `/knowledge/30.01-agent-coordination-patterns.md`

**Tester-Specific**:
12. `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md`
13. `/docs/60.06-test-format-requirements-reference.md`
14. `/docs/20-29-testing-qa/screenshot-testing/20.02-screenshot-testing-workflow-tutorial.md`

---

## ✅ SUCCESS CRITERIA & QUALITY GATES

### Component Extraction Success Criteria (Per Component)

**Before Component Work**:
- [ ] Visual baseline screenshots captured (seed 60316)
- [ ] Performance baseline recorded (FCP, LCP, CLS)
- [ ] Current test suite passing (`bin/rake test:critical`)
- [ ] Git working tree clean (ready for micro-commits)
- [ ] Handbook sections studied by assigned agents

**During Component Work**:
- [ ] Micro-commits after each change (≤3 lines)
- [ ] Tests run after every commit (`bin/rake test:critical`)
- [ ] Visual regression check after HTML changes (≤3% tolerance)
- [ ] Rollback on ANY test failure (`git reset --hard HEAD~1`)
- [ ] TDD cycle followed: RED → GREEN → REFACTOR

**After Component Completion**:
- [ ] All HTML FL-node references replaced with BEM classes
- [ ] All CSS FL-node rules migrated to BEM selectors
- [ ] Visual regression tests passing (0% difference or ≤3% acceptable)
- [ ] Performance metrics maintained or improved
- [ ] Accessibility validation passing (WCAG 2.1 AA)
- [ ] Component documentation updated
- [ ] Retrospective notes captured for team learning

---

### Program-Level Success Metrics

**Quantitative Targets**:
- ✅ 20/20 high-priority components extracted
- ✅ 430/430 HTML FL-node references migrated (100%)
- ✅ 8,148/8,148 CSS FL-node rules migrated (100%)
- ✅ CSS bundle size: 2.4MB → <800KB (67% reduction)
- ✅ Source files: 105 → 30 (71% reduction maintained)
- ✅ Test pass rate: 100% maintained throughout
- ✅ Visual regression incidents: 0 (≤3% tolerance)

**Qualitative Targets**:
- ✅ BEM methodology 100% compliance
- ✅ Zero test smells (no existence/implementation/configuration tests)
- ✅ Zero file duplication violations
- ✅ 100% handbook compliance (TDD, Four-Eyes, Zero-Defect)
- ✅ Comprehensive component documentation
- ✅ Team learning outcomes captured in retrospectives

---

## 🚨 ZERO-TOLERANCE ENFORCEMENT

### Mandatory Rejection Triggers (Agent Behavioral Constraints)

**Test Creation Decision Protocol** (MANDATORY):
```yaml
before_creating_any_test:
  question: "Does this test validate BEHAVIOR or IMPLEMENTATION?"

  if_behavior:
    action: "✅ Create Minitest test in test/system/"
    example: "Button renders correctly, button is clickable, grid layout displays 2 columns"

  if_implementation:
    action: "❌ STOP - REJECT test creation"
    example: "CSS class exists in file, HTML has specific structure, config value present"
```

**File Creation Decision Protocol** (MANDATORY):
```yaml
before_creating_any_file:
  check_existing: "Does similar file already exist?"

  if_exists:
    action: "❌ BLOCK new file creation - UPDATE existing file instead"
    forbidden_patterns: "*_refactored, *_new, *_v2, *_updated, *_copy, *_backup"

  if_not_exists:
    action: "✅ Proceed with file creation"
    validate_naming: "Use kebab-case, BEM c- prefix for components"
```

**Rollback Decision Protocol** (MANDATORY):
```yaml
after_every_commit:
  run_tests: "bin/rake test:critical"

  if_tests_fail:
    action: "git reset --hard HEAD~1"
    reason: "Fix code, NEVER modify tests"

  if_visual_regression_exceeds_3_percent:
    action: "git reset --hard HEAD~1"
    reason: "Review CSS changes, maintain visual consistency"

  if_tests_pass:
    action: "Continue to next micro-change"
```

---

## 📊 PROGRESS TRACKING & MEMORY COORDINATION

### Memory Namespaces (Claude-Flow MCP Integration)

**Component Extraction State**:
```yaml
memory_coordination:
  # Component progress tracking
  component_state:
    namespace: "css-migration/components/{component_name}/state"
    keys:
      - "status" (not_started | in_progress | testing | complete)
      - "complexity_rating" (SOLO | PAIR | TEAM)
      - "assigned_agents" (list of agent IDs)
      - "html_refs_migrated" (count)
      - "css_rules_migrated" (count)

  # TDD phase tracking
  tdd_phases:
    namespace: "css-migration/tdd/{component_name}/{phase}"
    keys:
      - "red-phase/{timestamp}" (failing test created)
      - "green-phase/{timestamp}" (shameless green implementation)
      - "refactor-phase/{timestamp}" (flocking rules applied)

  # Quality gates
  quality_validation:
    namespace: "css-migration/quality/{component_name}/{timestamp}"
    keys:
      - "tests_passing" (true | false)
      - "visual_regression_percent" (0.00-100.00)
      - "handbook_compliance" (violations list)
      - "rollback_count" (number)
```

---

## 🎓 LEARNING OUTCOMES & CONTINUOUS IMPROVEMENT

### After Each Component Extraction (Retrospective Required)

**Capture Learning**:
- What worked well? (velocity, test quality, collaboration)
- What didn't work? (blockers, inefficiencies, confusion)
- What handbook sections were most valuable?
- What handbook sections need clarification?
- What patterns can be reused for next component?

**Update Handbook**:
- Add new patterns discovered during extraction
- Clarify ambiguous guidance that caused confusion
- Document prevention mechanisms for issues encountered
- Share successful micro-commit patterns

**Share with Swarm**:
- Memory coordination: Store lessons in `css-migration/lessons/{component_name}`
- Broadcast effective patterns to other agents
- Update component extraction architecture document

---

## 🚀 IMMEDIATE NEXT ACTIONS (Queen Briefing Checklist)

**For Queen Seraphina** (Swarm Coordination):
- [ ] Review complete goal plan with all phases and milestones
- [ ] Approve Phase 2A Foundation Components as starting point
- [ ] Assign agents to Phase 2A components:
  - c-grid: PAIR team (Coder + Tester)
  - c-text: SOLO agent (Coder OR Researcher)
  - c-button: SOLO agent (Coder)
  - c-navigation: PAIR team (Coder + Tester)
- [ ] Brief all agents on handbook study requirements
- [ ] Activate memory coordination for progress tracking
- [ ] Schedule Phase 2A kickoff (Week 1)

**For Worker Agents** (Pre-Work Preparation):
- [ ] **Researcher**: Study CSS architecture handbooks (sections 1-6 above)
- [ ] **Coder**: Study TDD methodology handbooks (sections 1-4 above)
- [ ] **Analyst**: Study metrics & validation handbooks (sections 1-3 above)
- [ ] **Tester**: Study test quality handbooks (sections 1-3 above)
- [ ] **ALL**: Review current progress baseline (`GOAL-AND-PROGRESS.md`)
- [ ] **ALL**: Understand graduated spawning strategy (SOLO vs PAIR vs TEAM)

**For Development Team** (Readiness Validation):
- [ ] Confirm Phase 2A timeline acceptable (4 weeks for foundation components)
- [ ] Approve graduated spawning strategy (SOLO/PAIR/TEAM classification)
- [ ] Validate success criteria and quality gates
- [ ] Authorize memory coordination setup
- [ ] Approve handbook-aligned workflows

---

## 📝 APPENDIX: QUICK REFERENCE CARDS

### Coder Quick Reference

**TDD Cycle**:
1. RED: Write failing behavioral test
2. GREEN: Shameless green (accept hardcoding)
3. REFACTOR: Flocking rules (≤3 lines per step)
4. COMMIT: Micro-commit after each phase

**Micro-Commit Pattern**:
```bash
# After ≤3 line change
bin/rake test:critical  # MUST pass
git add .
git commit -m "Extract c-[component]: [description] (≤3 lines)"
```

**Rollback Pattern**:
```bash
# If tests fail OR visual regression >3%
git reset --hard HEAD~1
git clean -fd
```

---

### Tester Quick Reference

**Test Decision Protocol**:
- ✅ BEHAVIOR: "Does this test what users see/do?"
- ❌ IMPLEMENTATION: "Does this test code structure/existence?"

**Visual Testing Commands**:
```bash
# Capture baseline
SCREENSHOT_SEED=60316 bin/rake test:critical

# Run tests
bin/rake test:critical

# Check visual diff (if failure)
open test/fixtures/screenshots/macos/desktop/[component].diff.png
```

**Tolerance Levels**:
- Standard: 0.03 (3%)
- Problematic areas: 0.05 (5%)
- Static content: 0.01 (1%)

---

### Analyst Quick Reference

**Metrics Dashboard**:
```yaml
track_per_component:
  - Status (not_started | in_progress | testing | complete)
  - Estimated hours vs Actual hours
  - Duplication reduction %
  - HTML refs migrated count
  - CSS rules migrated count
  - Test pass rate %
  - Visual regression incidents count

track_program_level:
  - Total components completed / 20
  - Total HTML refs migrated / 430
  - Total CSS rules migrated / 8148
  - CSS bundle size reduction
  - Overall test pass rate
  - Overall visual regression incident count
```

---

### Researcher Quick Reference

**Pattern Analysis Workflow**:
1. Identify CSS duplication across files
2. Rate duplication severity (HIGH >70%, MEDIUM 40-70%, LOW <40%)
3. Assess component complexity (SOLO/PAIR/TEAM)
4. Document component parameters
5. Create extraction recommendations

**Flocking Rules**:
1. Select things most alike (group similar patterns)
2. Find smallest difference (identify minimal variations)
3. Make simplest change (remove differences systematically)

---

**Document Status**: ✅ COMPLETE - Ready for Queen Seraphina Briefing
**Next Action**: Queen approves plan → Agents study handbooks → Phase 2A kickoff
**Memory Coordination**: Store in `css-migration/goal-plan/hive-mind-v1`
**Review Frequency**: After each component extraction (update lessons learned)

---

*Goal Planner - GOAP Specialist*
*Generated: 2025-10-06*
*For: Queen Seraphina + Hive Mind Worker Agents (Researcher, Coder, Analyst, Tester)*
