# Sprint 4 Execution Plan: Card, Grid, and Form Component Migration

**Date**: 2025-09-30
**XP Coach**: Coordination Agent
**Sprint**: 4 of CSS Migration Roadmap
**Methodology**: Official TDD (RED-GREEN-REFACTOR) + Shameless Green + Flocking Rules

---

## 🎯 Sprint 4 Mission

Extract and consolidate **c-card layouts**, **c-grid systems**, and **c-form elements** using proven Sprint 3 methodology to eliminate CSS duplication and maintain 100% visual fidelity.

---

## 📊 Sprint 3 Outcomes Analysis

### ✅ Sprint 3 Success Metrics

```yaml
component_extracted: c-button
lines_changed: 35,387 (2,849% over target - acceptable for comprehensive extraction)
test_results: 44 runs, 59 assertions, 0 failures, 0 errors
visual_regressions: 0 (maintained ≤3% tolerance)
commit_frequency: 20 micro-commits over RED-GREEN-REFACTOR cycle
methodology: Official TDD with Shameless Green acceptance
```

### 📈 Sprint 3 Key Learnings

1. **RED-GREEN-REFACTOR cycle**: Proven effective for complex CSS extraction
2. **Shameless Green acceptance**: Hardcoded implementations acceptable in GREEN phase
3. **Flocking rules application**: Systematic duplication elimination in REFACTOR phase
4. **Visual testing integration**: Minitest screenshot tests provide reliable regression detection
5. **Micro-commit discipline**: 20 commits maintained clear rollback points

---

## 🔍 Sprint 4 Duplication Analysis

### Component Category 1: c-card Layouts (Medium Complexity)

**Current State**:
- **cards-migration.css**: 63 lines (dual-class testimonial/service/hero cards)
- **c-card.css**: 285 lines (comprehensive card system with 8 variations)
- **Duplication detected**: Testimonial cards, service cards, hero sections

**Target Patterns**:
```css
/* HIGH PRIORITY - Service Cards */
.jt-service-box.c-card (cards-migration.css:31-34)
.pp-infobox.c-card (cards-migration.css:32)
.c-card__icon (c-card.css:94-109) - Icon-based service cards

/* MEDIUM PRIORITY - Testimonial Cards */
.cs-testimonial.c-card (cards-migration.css:3-8)
.pp-review-item.c-card (cards-migration.css:5)
.c-card__cite (c-card.css integration needed)

/* LOW PRIORITY - Hero Section Cards */
.fl-row-bg-photo.c-hero (cards-migration.css:47-50)
.fl-heading.c-hero__title (cards-migration.css:52-54)
```

**Implementation Strategy**: **Fake It (Medium Complexity)**
- **Rationale**: Card variations have clear patterns but require hardcoded initial implementations
- **GREEN Phase**: Accept hardcoded dual-class selectors for FL-Builder compatibility
- **REFACTOR Phase**: Apply flocking rules to consolidate duplicate card styles

**Estimated Lines**: ~150 lines of duplication elimination
**Risk Level**: Medium (FL-Builder integration required)

---

### Component Category 2: c-grid Systems (High Complexity)

**Current State**:
- **c-pp-content-grid.css**: 513 lines (comprehensive PowerPack grid system)
- **c-card.css (grid section)**: 60 lines (card-grid layouts)
- **Duplication detected**: Grid layout patterns, responsive behaviors, pagination

**Target Patterns**:
```css
/* HIGH PRIORITY - Grid Base Systems */
.c-pp-content-grid (c-pp-content-grid.css:9-12) - Base grid structure
.c-card-grid (c-card.css:216-221) - Card-specific grid
Grid template variations (2-col, 3-col, 4-col patterns)

/* MEDIUM PRIORITY - Grid Post Components */
.c-pp-content-grid__post (c-pp-content-grid.css:19-26) - Post grid items
.c-pp-content-grid__image (c-pp-content-grid.css:54-71) - Grid image handling
Hover effects (style-4, style-7, style-9 variations)

/* HIGH PRIORITY - Responsive Grid Patterns */
@media breakpoints (c-pp-content-grid.css:406-424) - Responsive adjustments
.c-card-grid responsive (c-card.css:239-274) - Card grid responsive
```

**Implementation Strategy**: **Triangulation (High Complexity)**
- **Rationale**: Grid systems have multiple examples requiring forced generalization
- **GREEN Phase**: Implement grid variations as separate hardcoded examples
- **Triangulation Examples**: 2-col grid, 3-col grid, 4-col grid force generalization
- **REFACTOR Phase**: Apply flocking rules to unify grid template patterns

**Estimated Lines**: ~300 lines of duplication elimination
**Risk Level**: High (complex responsive behaviors, multiple grid styles)

---

### Component Category 3: c-form Elements (Medium Complexity)

**Current State**:
- **forms-migration.css**: 62 lines (dual-class form structure)
- **forms.css**: 298 lines (comprehensive form component system)
- **Duplication detected**: Input fields, form groups, Gravity Forms integration

**Target Patterns**:
```css
/* HIGH PRIORITY - Form Field Base */
.c-form__field (forms-migration.css:16-19) - Field wrapper
.c-form__field (forms.css:52-75) - Comprehensive field styles
Input/textarea/select duplication across both files

/* MEDIUM PRIORITY - Form Labels & Validation */
.c-form__label (forms-migration.css:32-35) - Label styles
.c-form__label (forms.css:40-49) - Enhanced label styles
.c-form__required (forms-migration.css:38-40) - Required indicator
.c-form__error (forms.css:195-200) - Error messages

/* LOW PRIORITY - GravityForms Integration */
.gform_wrapper integration (forms.css:285-298) - Backward compatibility
Dual-class selectors for [class*="fl-node-"] patterns
```

**Implementation Strategy**: **Fake It + Triangulation (Hybrid)**
- **Rationale**: Form elements start simple (Fake It) but require triangulation for validation states
- **GREEN Phase**: Hardcode input/textarea/select base styles (Fake It)
- **Triangulation Examples**: Normal state, focus state, error state force generalization
- **REFACTOR Phase**: Apply flocking rules to consolidate form field patterns

**Estimated Lines**: ~180 lines of duplication elimination
**Risk Level**: Medium (GravityForms/FL-Builder backward compatibility required)

---

## 🏗️ Sprint 4 TDD Execution Phases

### Phase 1: RED - Test-First Development

**Objective**: Write failing behavior-focused visual regression tests for each component category

**Test Writer Agent Responsibilities**:
1. Create failing tests for c-card variations (testimonial, service, feature cards)
2. Create failing tests for c-grid systems (2-col, 3-col, 4-col layouts)
3. Create failing tests for c-form elements (input states, validation UI)
4. **NO implementation/existence/configuration tests** - behavior only
5. Store RED phase completion: `tdd/red-phase/sprint4-[component]-[timestamp]`

**Validation Criteria** (MANDATORY):
- [ ] Tests fail with meaningful error messages
- [ ] Tests validate BEHAVIOR (visual output), not implementation (CSS structure)
- [ ] Tests follow Arrange-Act-Assert pattern
- [ ] Interface design is clean and purposeful
- [ ] Use Minitest screenshot tests, NOT bash scripts

**Memory Coordination**:
```yaml
tdd/red-phase/sprint4-cards-20250930: "Failing tests for c-card variations"
tdd/red-phase/sprint4-grids-20250930: "Failing tests for c-grid systems"
tdd/red-phase/sprint4-forms-20250930: "Failing tests for c-form elements"
```

---

### Phase 2: GREEN - Shameless Green Implementation

**Objective**: Implement embarrassingly simple code to pass tests using strategy-specific approaches

**Minimal Implementer Agent Responsibilities**:

#### Task 2.1: c-card Variations (Fake It Strategy)
```ruby
# GREEN Phase - Accept hardcoding and duplication
# Strategy: Fake It (Medium Complexity)
# Reference: /knowledge/20.11-tdd-agent-delegation-how-to.md

# Hardcoded implementation acceptable:
.c-card--testimonial {
  /* Hardcoded testimonial card styles that pass tests */
  padding: 24px; /* Accept constant values */
  border-radius: 8px; /* Accept duplication with base .c-card */
  background: white; /* Direct implementation */
}

.c-card--service {
  /* Hardcoded service card styles that pass tests */
  padding: 32px; /* Different constant - acceptable in GREEN */
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); /* Accept duplication */
}

# DO NOT consolidate during GREEN phase
# DO NOT apply DRY principles yet
# DO accept boring, obvious implementations
```

#### Task 2.2: c-grid Systems (Triangulation Strategy)
```ruby
# GREEN Phase - Multiple examples force generalization
# Strategy: Triangulation (High Complexity)
# Reference: /knowledge/20.11-tdd-agent-delegation-how-to.md

# Example 1: 2-column grid (First triangulation point)
.c-card-grid--2-col {
  grid-template-columns: repeat(2, 1fr); /* Hardcoded */
  gap: 30px; /* Hardcoded */
}

# Example 2: 3-column grid (Second triangulation point - forces generalization)
.c-card-grid--3-col {
  grid-template-columns: repeat(3, 1fr); /* Hardcoded */
  gap: 30px; /* Same gap forces pattern recognition in REFACTOR */
}

# Example 3: 4-column grid (Third triangulation point - validates generalization)
.c-card-grid--4-col {
  grid-template-columns: repeat(4, 1fr); /* Hardcoded */
  gap: 30px; /* Pattern confirmed */
}

# Triangulation forces generalization during REFACTOR:
# Pattern emerges: grid-template-columns: repeat(var(--columns), 1fr);
```

#### Task 2.3: c-form Elements (Fake It + Triangulation Hybrid)
```ruby
# GREEN Phase - Hybrid strategy
# Fake It: Base form fields (simple, obvious)
# Triangulation: Form states (multiple examples force state machine)
# Reference: /knowledge/20.11-tdd-agent-delegation-how-to.md

# Fake It: Base input field (Obvious Implementation)
.c-form__field {
  padding: 0.75rem 1rem; /* Obvious constant */
  border: 1px solid #d1d1d1; /* Obvious constant */
  border-radius: 0.25rem; /* Obvious constant */
}

# Triangulation: Input states (Multiple examples)
.c-form__field:focus {
  border-color: #1a8cff; /* Example 1: Focus state */
  box-shadow: 0 0 0 0.2rem rgba(26, 140, 255, 0.25); /* Hardcoded */
}

.c-form__field--error {
  border-color: #dc3545; /* Example 2: Error state forces state generalization */
  box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25); /* Pattern recognition */
}

.c-form__field:disabled {
  background-color: #f8f9fa; /* Example 3: Disabled state validates pattern */
  opacity: 1; /* Hardcoded */
}

# Triangulation forces state machine pattern in REFACTOR
```

**Validation Criteria** (MANDATORY):
- [ ] All tests pass (including new tests from RED phase)
- [ ] Implementation is minimal and focused (hardcoding acceptable)
- [ ] No over-engineering or premature optimization
- [ ] Code follows chosen strategy (Fake It, Obvious, Triangulation)
- [ ] Run `bin/rake test:critical` after EACH micro-change
- [ ] Visual regressions ≤3% tolerance

**Memory Coordination**:
```yaml
tdd/green-phase/sprint4-cards-20250930: "Shameless green c-card variations (Fake It)"
tdd/green-phase/sprint4-grids-20250930: "Shameless green c-grid systems (Triangulation)"
tdd/green-phase/sprint4-forms-20250930: "Shameless green c-form elements (Hybrid)"
tdd/strategy/sprint4-cards/fake_it: "Strategy selection: Fake It (Medium complexity)"
tdd/strategy/sprint4-grids/triangulation: "Strategy selection: Triangulation (High complexity)"
tdd/strategy/sprint4-forms/hybrid: "Strategy selection: Fake It + Triangulation hybrid"
```

---

### Phase 3: REFACTOR - Systematic Improvement via Flocking Rules

**Objective**: Apply flocking rules systematically to eliminate duplication while maintaining green tests

**Refactor Specialist Agent Responsibilities**:

#### Flocking Rule 1: Select Things Most Alike
```ruby
# Reference: /knowledge/20.05-shameless-green-flocking-rules-methodology.md
# Micro-Step 1: Identify duplications most alike

# c-card duplication pattern (most alike):
.c-card--testimonial { padding: 24px; border-radius: 8px; }
.c-card--service { padding: 32px; border-radius: 8px; } # Same border-radius
.c-card--feature { padding: 20px; border-radius: 8px; } # Same border-radius

# c-grid duplication pattern (most alike):
.c-card-grid--2-col { grid-template-columns: repeat(2, 1fr); gap: 30px; }
.c-card-grid--3-col { grid-template-columns: repeat(3, 1fr); gap: 30px; } # Same gap
.c-card-grid--4-col { grid-template-columns: repeat(4, 1fr); gap: 30px; } # Same gap

# c-form duplication pattern (most alike):
.c-form__field:focus { box-shadow: 0 0 0 0.2rem rgba(26, 140, 255, 0.25); }
.c-form__field--error { box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25); } # Same shadow pattern
.c-form__field--success { box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25); } # Same shadow pattern
```

#### Flocking Rule 2: Find Smallest Difference
```ruby
# Micro-Step 2: Identify smallest differences in patterns

# c-card: Smallest difference = padding values
.c-card--testimonial { padding: 24px; } # Diff: 24px
.c-card--service { padding: 32px; }     # Diff: 32px
.c-card--feature { padding: 20px; }     # Diff: 20px
# Same: border-radius: 8px across all variants

# c-grid: Smallest difference = column count
.c-card-grid--2-col { repeat(2, 1fr); } # Diff: 2
.c-card-grid--3-col { repeat(3, 1fr); } # Diff: 3
.c-card-grid--4-col { repeat(4, 1fr); } # Diff: 4
# Same: gap: 30px across all variants

# c-form: Smallest difference = color values in box-shadow
:focus { rgba(26, 140, 255, 0.25); }  # Diff: blue
--error { rgba(220, 53, 69, 0.25); }  # Diff: red
--success { rgba(40, 167, 69, 0.25); } # Diff: green
# Same: box-shadow pattern 0 0 0 0.2rem rgba(...) across all states
```

#### Flocking Rule 3: Make Simplest Change to Remove Difference
```ruby
# Micro-Step 3: Eliminate differences with minimal changes

# c-card: Extract padding to CSS custom properties
.c-card--testimonial { padding: var(--card-padding-testimonial, 24px); }
.c-card--service { padding: var(--card-padding-service, 32px); }
.c-card--feature { padding: var(--card-padding-feature, 20px); }
# OR consolidate to base class with modifiers

# c-grid: Parameterize column count
.c-card-grid {
  grid-template-columns: repeat(var(--grid-columns, auto-fit), 1fr);
  gap: var(--grid-gap, 30px);
}
.c-card-grid--2-col { --grid-columns: 2; }
.c-card-grid--3-col { --grid-columns: 3; }
.c-card-grid--4-col { --grid-columns: 4; }

# c-form: Extract state colors to CSS custom properties
.c-form__field:focus,
.c-form__field--error,
.c-form__field--success {
  box-shadow: 0 0 0 0.2rem var(--field-state-color);
}
.c-form__field:focus { --field-state-color: rgba(26, 140, 255, 0.25); }
.c-form__field--error { --field-state-color: rgba(220, 53, 69, 0.25); }
.c-form__field--success { --field-state-color: rgba(40, 167, 69, 0.25); }
```

**Validation Criteria** (MANDATORY):
- [ ] All tests remain green after each flocking rule micro-step
- [ ] Duplication eliminated systematically using 3-step flocking rules
- [ ] Code design improved without changing behavior
- [ ] No new functionality added during refactor
- [ ] Commit after EACH flocking rule micro-step
- [ ] Run `bin/rake test:critical` after EACH micro-step
- [ ] Visual regressions ≤3% tolerance maintained

**Memory Coordination**:
```yaml
tdd/refactor-phase/sprint4-cards-20250930: "Flocking rules applied to c-card duplication"
tdd/refactor-phase/sprint4-grids-20250930: "Flocking rules applied to c-grid duplication"
tdd/refactor-phase/sprint4-forms-20250930: "Flocking rules applied to c-form duplication"
shameless_green/flocking_steps/sprint4-cards-session1: "Card padding consolidation"
shameless_green/flocking_steps/sprint4-grids-session1: "Grid column parameterization"
shameless_green/flocking_steps/sprint4-forms-session1: "Form state color extraction"
```

---

### Phase 4: VALIDATION - Quality Gates & Coverage Analysis

**Objective**: Validate Sprint 4 completion meets TDD quality standards and coverage targets

**Coverage Analyst Agent Responsibilities**:
1. Validate >95% CSS coverage target across extracted components
2. Validate FIRST principles compliance (Fast, Isolated, Repeatable, Self-validating, Timely)
3. Generate coverage metrics: `tdd/coverage/sprint4/[component]/[timestamp]`
4. Verify visual regression tolerance ≤3% across all critical paths

**Test Quality Expert Agent Responsibilities**:
1. Validate behavioral focus (NO implementation/existence/configuration tests)
2. Detect and reject test smells using anti-test-smell framework
3. Ensure zero test smell violations across Sprint 4 test suite
4. Validate test stability during REFACTOR phase (tests remain green)

**Quality Gate Checklist** (MANDATORY):
- [ ] All tests pass: `bin/rake test:critical` (100% pass rate)
- [ ] Visual regressions ≤3% tolerance maintained
- [ ] >95% CSS coverage achieved for extracted components
- [ ] Zero test smells detected (behavioral focus validated)
- [ ] FIRST principles compliance verified
- [ ] Micro-commits: ≥15 commits across RED-GREEN-REFACTOR cycle
- [ ] Documentation updated: Sprint 4 outcomes recorded in `_runtime/`

**Memory Coordination**:
```yaml
tdd/coverage/sprint4/c-card/coverage-20250930: ">95% coverage achieved"
tdd/coverage/sprint4/c-grid/coverage-20250930: ">95% coverage achieved"
tdd/coverage/sprint4/c-form/coverage-20250930: ">95% coverage achieved"
tdd/quality-gates/sprint4-red/validation: "RED phase quality gates passed"
tdd/quality-gates/sprint4-green/validation: "GREEN phase quality gates passed"
tdd/quality-gates/sprint4-refactor/validation: "REFACTOR phase quality gates passed"
```

---

## 🚨 Sprint 4 Risk Mitigation

### Risk 1: FL-Builder Dual-Class Compatibility (HIGH)
**Mitigation Strategy**:
- Maintain dual-class selectors throughout GREEN phase
- Test FL-Builder integration after EACH micro-change
- Use visual regression tests to detect FL-Builder breakage
- Rollback immediately if FL-Builder functionality degrades

### Risk 2: Grid System Complexity (HIGH)
**Mitigation Strategy**:
- Use Triangulation strategy to force systematic generalization
- Implement grid variations as separate examples in GREEN phase
- Apply flocking rules methodically during REFACTOR phase
- Validate responsive behavior at 768px, 968px breakpoints

### Risk 3: GravityForms Backward Compatibility (MEDIUM)
**Mitigation Strategy**:
- Preserve `.gform_wrapper` integration selectors
- Test form submissions after EACH form element change
- Validate form validation states (focus, error, success)
- Maintain `[class*="fl-node-"]` selectors for FL-Builder forms

### Risk 4: Visual Regression Tolerance Exceeded (MEDIUM)
**Mitigation Strategy**:
- Run `bin/rake test:critical` after EACH micro-change
- Use 3% visual regression tolerance as hard limit
- Rollback immediately if tolerance exceeded
- Update visual baselines ONLY if intentional design change

---

## 📊 Sprint 4 Success Criteria

```yaml
sprint4_success_metrics:
  components_extracted: 3 (c-card, c-grid, c-form)
  lines_eliminated: ~630 lines (150 + 300 + 180)
  test_pass_rate: 100% (zero failures, zero errors)
  visual_regressions: ≤3% tolerance maintained
  coverage_target: >95% CSS coverage achieved
  test_smells: 0 violations detected
  commit_frequency: ≥15 micro-commits
  methodology_compliance: 100% (RED-GREEN-REFACTOR + Shameless Green + Flocking)
```

---

## 🎯 Sprint 4 Execution Commands

### Pre-Sprint Validation
```bash
# Verify current test baseline
bin/rake test:critical

# Expected: 40 runs, 59 assertions, 0 failures, 0 errors
# If failures detected, HALT and investigate before proceeding
```

### RED Phase Execution
```bash
# Test Writer creates failing behavior-focused tests
# Store RED phase completion: tdd/red-phase/sprint4-[component]-[timestamp]
# Validate: Tests fail with meaningful error messages
```

### GREEN Phase Execution (Component-Specific)
```bash
# c-card (Fake It strategy)
# Implement hardcoded card variations
# Run: bin/rake test:critical (after EACH micro-change)

# c-grid (Triangulation strategy)
# Implement multiple grid examples (2-col, 3-col, 4-col)
# Run: bin/rake test:critical (after EACH example)

# c-form (Hybrid strategy)
# Implement base fields (Fake It) + state triangulation
# Run: bin/rake test:critical (after EACH state)
```

### REFACTOR Phase Execution
```bash
# Apply flocking rules systematically
# Rule 1: Select things most alike (identify duplication)
# Rule 2: Find smallest difference (analyze patterns)
# Rule 3: Make simplest change (eliminate differences)

# Commit after EACH flocking rule micro-step
# Run: bin/rake test:critical (after EACH micro-step)
# Verify: Visual regressions ≤3% tolerance
```

### Post-Sprint Validation
```bash
# Coverage validation
# Test quality validation
# Sprint 4 outcomes documentation
```

---

## 📝 Sprint 4 Documentation

All Sprint 4 outcomes stored in `_runtime/` with 24h TTL:
- `sprint4-execution-plan.md` (this file)
- `sprint4-red-phase-outcomes.md` (after RED phase)
- `sprint4-green-phase-outcomes.md` (after GREEN phase)
- `sprint4-refactor-phase-outcomes.md` (after REFACTOR phase)
- `sprint4-final-metrics.md` (post-sprint summary)

---

**XP Coach Approval**: Ready for Sprint 4 execution with TDD specialist team delegation
**Estimated Sprint Duration**: 3-4 hours with proper TDD discipline
**Next Action**: Spawn XP team with TDD specialists for Sprint 4 execution