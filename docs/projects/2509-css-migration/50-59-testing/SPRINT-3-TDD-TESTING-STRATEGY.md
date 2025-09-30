# Sprint 3 TDD Testing Strategy - BEM Component Extraction

**Generated**: 2025-09-30 01:50 UTC
**Sprint Goal**: 1,200+ lines changed for BEM component extraction
**Status**: ⏸️ AWAITING BASELINE RESTORATION
**Prerequisites**: ALL tests passing (0 failures, 0 errors)

---

## 🎯 Testing Strategy Overview

### TDD Integration with BEM Component Extraction

**Official Claude-Flow TDD Methodology Application**:
- **RED Phase**: Write failing tests for new BEM components BEFORE extraction
- **GREEN Phase**: Implement shameless green BEM extraction (accept duplication initially)
- **REFACTOR Phase**: Apply flocking rules to consolidate duplicated patterns

**Sprint 3 Specific Testing Focus**:
- Behavioral testing of component rendering (NOT implementation details)
- Visual regression validation (≤3% tolerance)
- Mobile responsiveness verification
- Performance impact assessment
- Cross-browser compatibility

---

## 🔴 RED PHASE: Test-First Component Development

### Component Testing Pattern (MANDATORY)

For each BEM component planned in Sprint 3:
1. **c-button variants**
2. **c-card layouts**
3. **c-grid systems**
4. **c-form elements**

**Test-First Workflow** (repeat for each component):

```bash
#!/bin/bash
# RED Phase: Test-First Component Development

# Step 1: Create failing test for component behavior
create_component_behavior_test() {
    local component_name=$1
    local test_file="test/system/components/${component_name}_test.rb"

    echo "🔴 RED PHASE: Creating failing test for ${component_name}"

    cat > "$test_file" << 'EOF'
# frozen_string_literal: true

require "application_system_test_case"

class CButtonTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "components/c-button"
    super
  end

  def test_primary_button_renders_correctly
    visit "/components-showcase/"

    # BEHAVIOR VALIDATION: Button renders and is clickable
    button = find(".c-button--primary", match: :first)
    assert button.visible?
    assert_equal "button", button.tag_name.downcase

    # VISUAL REGRESSION: Baseline screenshot comparison
    assert_stable_screenshot "c-button/primary", tolerance: 0.03
  end

  def test_secondary_button_renders_correctly
    visit "/components-showcase/"

    # BEHAVIOR VALIDATION: Button renders with correct styling
    button = find(".c-button--secondary", match: :first)
    assert button.visible?

    # VISUAL REGRESSION: Baseline screenshot comparison
    assert_stable_screenshot "c-button/secondary", tolerance: 0.03
  end

  def test_button_hover_state
    visit "/components-showcase/"

    # BEHAVIOR VALIDATION: Hover state changes are visible
    button = find(".c-button--primary", match: :first)
    button.hover

    # VISUAL REGRESSION: Hover state screenshot
    assert_stable_screenshot "c-button/primary-hover", tolerance: 0.03
  end

  def test_button_mobile_rendering
    Capybara.current_driver = :mobile_chrome
    visit "/components-showcase/"

    # BEHAVIOR VALIDATION: Mobile responsive button
    button = find(".c-button--primary", match: :first)
    assert button.visible?

    # VISUAL REGRESSION: Mobile screenshot comparison
    assert_stable_screenshot "c-button/primary-mobile", tolerance: 0.03
  end
end
EOF

    # Step 2: Run test - MUST FAIL (component doesn't exist yet)
    echo "🔴 Running test (should fail - component not extracted yet)..."
    if bin/test "$test_file"; then
        echo "❌ VIOLATION: Test passed before component extraction - test invalid!"
        return 1
    else
        echo "✅ RED PHASE VALID: Test correctly failing - ready for GREEN phase"
        return 0
    fi
}

# Execute RED phase for c-button component
create_component_behavior_test "c-button"
```

### Behavioral Testing Requirements (MANDATORY)

**✅ CORRECT Behavioral Patterns**:
```ruby
# ✅ Test button BEHAVIOR (user-facing outcomes)
def test_button_click_triggers_action
  visit "/homepage/"

  # Behavioral validation: Click works and produces result
  find(".c-button--primary").click
  assert_current_path "/contact-us/"  # Behavior: navigation works
  assert_text "Contact Us"            # Behavior: page loads
end

# ✅ Test visual regression (appearance matters to users)
def test_button_visual_consistency
  visit "/homepage/"

  # Behavioral validation: Visual appearance is consistent
  assert_stable_screenshot "components/c-button-group", tolerance: 0.03
end

# ✅ Test mobile responsiveness (user experience across devices)
def test_button_mobile_touch_targets
  Capybara.current_driver = :mobile_chrome
  visit "/homepage/"

  # Behavioral validation: Button is tappable on mobile
  button = find(".c-button--primary")
  assert button.visible?
  assert button[:class].include?("c-button--primary")

  # Visual validation: Mobile rendering
  assert_stable_screenshot "components/c-button-mobile", tolerance: 0.03
end
```

**❌ FORBIDDEN Implementation Testing Patterns**:
```ruby
# ❌ VIOLATION: Testing CSS class existence (implementation detail)
def test_button_has_correct_classes
  visit "/homepage/"
  button = find("button")

  # FORBIDDEN: Testing implementation structure
  assert button[:class].include?("c-button")
  assert button[:class].include?("c-button--primary")
end

# ❌ VIOLATION: Testing HTML attribute details (implementation)
def test_button_data_attributes
  visit "/homepage/"
  button = find("button")

  # FORBIDDEN: Testing internal attributes
  assert_equal "button-1", button["data-id"]
  assert_equal "primary", button["data-variant"]
end

# ❌ VIOLATION: Testing framework mechanics (not user behavior)
def test_button_hugo_template_structure
  template_content = File.read("layouts/partials/button.html")

  # FORBIDDEN: Testing template implementation
  assert_includes template_content, "{{ .Params.buttonText }}"
  assert_includes template_content, "c-button--{{ .Params.variant }}"
end
```

### RED Phase Validation Checklist

**Before proceeding to GREEN phase**:
- [ ] Test file created for component
- [ ] Test uses behavioral validation (NOT implementation testing)
- [ ] Test includes visual regression screenshot comparison
- [ ] Test includes mobile responsiveness validation
- [ ] Test FAILS when run (component doesn't exist yet)
- [ ] Test failure message is meaningful and actionable
- [ ] Test follows Arrange-Act-Assert pattern

---

## 🟢 GREEN PHASE: Shameless Green BEM Extraction

### Minimal Implementation Strategy

**Shameless Green Philosophy** (Kent Beck methodology):
- Accept hardcoded implementations initially
- Accept duplication between components
- Focus ONLY on making tests pass
- NO premature optimization or consolidation

**Implementation Workflow**:

```bash
#!/bin/bash
# GREEN Phase: Shameless Green BEM Extraction

# Step 1: Extract component with MINIMAL changes (≤3 lines)
extract_bem_component_shameless_green() {
    local component_name=$1
    local target_file="themes/beaver/assets/css/components/${component_name}.css"

    echo "🟢 GREEN PHASE: Shameless green extraction for ${component_name}"

    # Step 1a: Create component file with HARDCODED initial implementation
    cat > "$target_file" << 'EOF'
/* c-button.css - Shameless Green Implementation (ACCEPT DUPLICATION) */

/* Primary button variant - HARDCODED for green phase */
.c-button--primary {
  background-color: #2563eb;
  color: white;
  padding: 12px 24px;
  border-radius: 6px;
  font-weight: 600;
  text-align: center;
  display: inline-block;
  cursor: pointer;
  transition: background-color 0.2s;
}

.c-button--primary:hover {
  background-color: #1d4ed8;
}

/* Secondary button variant - DUPLICATED from primary (acceptable in GREEN) */
.c-button--secondary {
  background-color: #f3f4f6;
  color: #1f2937;
  padding: 12px 24px;
  border-radius: 6px;
  font-weight: 600;
  text-align: center;
  display: inline-block;
  cursor: pointer;
  transition: background-color 0.2s;
}

.c-button--secondary:hover {
  background-color: #e5e7eb;
}
EOF

    # Step 1b: Import component into main CSS bundle
    echo '@import "components/c-button.css";' >> themes/beaver/assets/css/components.css

    # Step 2: Run tests - MUST PASS NOW
    echo "🟢 Running tests (should pass now with component extracted)..."
    if bin/test "test/system/components/c-button_test.rb"; then
        echo "✅ GREEN PHASE SUCCESS: Tests passing with shameless green implementation"

        # Step 3: Micro-commit immediately
        git add .
        git commit -m "Extract c-button component (shameless green - ≤3 lines)"

        return 0
    else
        echo "❌ GREEN PHASE FAILURE: Tests still failing - rollback required"
        git reset --hard HEAD
        return 1
    fi
}

# Execute GREEN phase for c-button component
extract_bem_component_shameless_green "c-button"
```

### GREEN Phase Implementation Strategies

**Strategy Selection Matrix**:

| Component Complexity | Implementation Strategy | Rationale |
|----------------------|------------------------|-----------|
| **Low** (c-button) | Obvious Implementation | Straightforward button styling - implement directly |
| **Medium** (c-card) | Fake It | Complex layout - start with hardcoded example |
| **High** (c-grid) | Triangulation | Multiple responsive behaviors - need multiple test examples |

**Fake It Strategy Example** (for c-card component):
```css
/* c-card.css - Fake It Strategy (GREEN Phase) */

/* Start with HARDCODED card for specific use case */
.c-card {
  /* FAKE IT: Hardcoded values that pass first test */
  width: 350px;
  background: white;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.c-card__title {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 12px;
}

.c-card__content {
  font-size: 16px;
  line-height: 1.5;
  color: #6b7280;
}
```

**Triangulation Strategy Example** (for c-grid component):
```ruby
# c-grid_test.rb - Triangulation with multiple examples

def test_grid_two_columns
  visit "/layouts/"

  # First example: 2-column grid
  assert_selector ".c-grid--columns-2 .c-grid__item", count: 2
  assert_stable_screenshot "c-grid/two-columns", tolerance: 0.03
end

def test_grid_three_columns
  visit "/layouts/"

  # Second example: 3-column grid (forces generalization)
  assert_selector ".c-grid--columns-3 .c-grid__item", count: 3
  assert_stable_screenshot "c-grid/three-columns", tolerance: 0.03
end

def test_grid_mobile_single_column
  Capybara.current_driver = :mobile_chrome
  visit "/layouts/"

  # Third example: Mobile responsive (forces responsive implementation)
  assert_selector ".c-grid .c-grid__item", count: 3
  assert_stable_screenshot "c-grid/mobile-stacked", tolerance: 0.03
end
```

### GREEN Phase Validation Checklist

**Before proceeding to REFACTOR phase**:
- [ ] Component file created with shameless green implementation
- [ ] Component imported into main CSS bundle
- [ ] ALL component tests passing (100% pass rate)
- [ ] Visual regression screenshots within ≤3% tolerance
- [ ] Mobile responsiveness tests passing
- [ ] Micro-commit completed immediately after tests pass
- [ ] NO premature refactoring or optimization performed

---

## 🔵 REFACTOR PHASE: Flocking Rules Consolidation

### Systematic Refactoring with Flocking Rules

**Flocking Rules Methodology** (Sandi Metz):
1. **Select things most alike** - Find similar patterns across components
2. **Find smallest difference** - Identify minimal differences between patterns
3. **Make simplest change to remove difference** - Eliminate differences systematically

**Refactoring Workflow**:

```bash
#!/bin/bash
# REFACTOR Phase: Flocking Rules Application

# Step 1: Apply flocking rule 1 - Select things most alike
apply_flocking_rule_1() {
    echo "🔵 REFACTOR: Flocking Rule 1 - Select things most alike"

    # Example: Identify similar button variants
    echo "Analyzing c-button.css for similar patterns..."

    # Both primary and secondary buttons have:
    # - Same padding: 12px 24px
    # - Same border-radius: 6px
    # - Same font-weight: 600
    # - Same transition: background-color 0.2s

    echo "✅ Identified common patterns: padding, border-radius, font-weight, transition"
}

# Step 2: Apply flocking rule 2 - Find smallest difference
apply_flocking_rule_2() {
    echo "🔵 REFACTOR: Flocking Rule 2 - Find smallest difference"

    # Differences between primary and secondary:
    # - background-color (primary: #2563eb, secondary: #f3f4f6)
    # - color (primary: white, secondary: #1f2937)
    # - hover background-color

    echo "✅ Identified smallest differences: color variants only"
}

# Step 3: Apply flocking rule 3 - Make simplest change
apply_flocking_rule_3() {
    echo "🔵 REFACTOR: Flocking Rule 3 - Make simplest change"

    # Create base button class with common properties
    cat > themes/beaver/assets/css/components/c-button.css << 'EOF'
/* c-button.css - Refactored with Flocking Rules */

/* Base button (common properties extracted) */
.c-button {
  padding: 12px 24px;
  border-radius: 6px;
  font-weight: 600;
  text-align: center;
  display: inline-block;
  cursor: pointer;
  transition: background-color 0.2s;
}

/* Primary variant (only color differences) */
.c-button--primary {
  background-color: #2563eb;
  color: white;
}

.c-button--primary:hover {
  background-color: #1d4ed8;
}

/* Secondary variant (only color differences) */
.c-button--secondary {
  background-color: #f3f4f6;
  color: #1f2937;
}

.c-button--secondary:hover {
  background-color: #e5e7eb;
}
EOF

    # Step 3a: Run tests after refactoring micro-step
    if bin/test "test/system/components/c-button_test.rb"; then
        echo "✅ REFACTOR SUCCESS: Tests remain green after flocking rule application"

        # Step 3b: Micro-commit after each flocking rule
        git add .
        git commit -m "Refactor c-button: Apply flocking rule 3 (extract base class - ≤3 lines)"

        return 0
    else
        echo "❌ REFACTOR FAILURE: Tests broke during refactoring - rollback"
        git reset --hard HEAD
        return 1
    fi
}

# Execute all flocking rules sequentially
apply_flocking_rule_1
apply_flocking_rule_2
apply_flocking_rule_3
```

### Micro-Refactoring Protocol (≤3 Lines per Change)

**MANDATORY Micro-Step Pattern**:
```bash
# Micro-refactoring cycle (repeat for each small change)
micro_refactor_step() {
    local description="$1"

    echo "🔄 Micro-refactoring: ${description}"

    # 1. Make ≤3 line change
    echo "📝 Applying ≤3 line change..."
    # (Agent makes change to CSS file)

    # 2. Run ALL tests immediately
    if ! npm test; then
        echo "❌ Tests failed after micro-refactoring - ROLLBACK"
        git reset --hard HEAD
        return 1
    fi

    # 3. Validate visual regression
    if ! validate_visual_regression_threshold; then
        echo "❌ Visual regression >3% - ROLLBACK"
        git reset --hard HEAD
        return 1
    fi

    # 4. Micro-commit immediately
    git add .
    git commit -m "Refactor: ${description} (≤3 lines)"

    echo "✅ Micro-refactoring successful"
}

# Example micro-refactoring sequence
micro_refactor_step "Extract base c-button class (common padding)"
micro_refactor_step "Extract base c-button class (common border-radius)"
micro_refactor_step "Extract base c-button class (common font-weight)"
micro_refactor_step "Extract base c-button class (common transition)"
```

### REFACTOR Phase Validation Checklist

**After each flocking rule application**:
- [ ] All tests remain GREEN (100% pass rate)
- [ ] Visual regression ≤3% (no unintended visual changes)
- [ ] Duplication reduced systematically
- [ ] Code design improved (DRY principle applied)
- [ ] NO new functionality added during refactoring
- [ ] Micro-commit completed after each flocking rule
- [ ] Rollback performed if ANY test fails

---

## 📊 Sprint 3 Component Testing Matrix

### Component-Specific Testing Requirements

#### 1. c-button Variants

**Testing Focus**:
- [ ] Primary button rendering (desktop + mobile)
- [ ] Secondary button rendering (desktop + mobile)
- [ ] Tertiary button rendering (desktop + mobile)
- [ ] Button hover states (all variants)
- [ ] Button focus states (keyboard navigation)
- [ ] Button disabled states (all variants)
- [ ] Button click functionality (navigation/form submission)
- [ ] Mobile touch target size (≥44px)

**Visual Regression Baselines**:
- `components/c-button/primary-desktop.png`
- `components/c-button/primary-mobile.png`
- `components/c-button/secondary-desktop.png`
- `components/c-button/secondary-mobile.png`
- `components/c-button/hover-states.png`
- `components/c-button/focus-states.png`

**TDD Cycle**:
1. RED: Write failing test for button variant
2. GREEN: Extract button CSS with shameless duplication
3. REFACTOR: Apply flocking rules to consolidate variants

#### 2. c-card Layouts

**Testing Focus**:
- [ ] Card basic layout rendering (desktop + mobile)
- [ ] Card with image rendering
- [ ] Card with title + content + CTA
- [ ] Card hover effects (shadow, transform)
- [ ] Card grid layouts (2-column, 3-column)
- [ ] Card mobile stacking behavior
- [ ] Card responsive image sizing
- [ ] Card content overflow handling

**Visual Regression Baselines**:
- `components/c-card/basic-desktop.png`
- `components/c-card/basic-mobile.png`
- `components/c-card/with-image.png`
- `components/c-card/grid-layout.png`
- `components/c-card/hover-state.png`

**TDD Cycle**:
1. RED: Write failing test for card layout
2. GREEN: Fake It with hardcoded card dimensions
3. REFACTOR: Apply flocking rules to extract responsive patterns

#### 3. c-grid Systems

**Testing Focus**:
- [ ] 2-column grid (desktop)
- [ ] 3-column grid (desktop)
- [ ] 4-column grid (desktop)
- [ ] Mobile responsive stacking (all grids → 1 column)
- [ ] Tablet responsive behavior (2 columns)
- [ ] Grid gap/spacing consistency
- [ ] Grid item alignment (start, center, end)
- [ ] Grid auto-fit behavior with varying item counts

**Visual Regression Baselines**:
- `components/c-grid/two-columns-desktop.png`
- `components/c-grid/three-columns-desktop.png`
- `components/c-grid/four-columns-desktop.png`
- `components/c-grid/mobile-stacked.png`
- `components/c-grid/tablet-responsive.png`

**TDD Cycle**:
1. RED: Write failing tests with multiple grid examples (triangulation)
2. GREEN: Implement grid with CSS Grid (obvious implementation)
3. REFACTOR: Apply flocking rules to consolidate responsive breakpoints

#### 4. c-form Elements

**Testing Focus**:
- [ ] Text input rendering (desktop + mobile)
- [ ] Textarea rendering (desktop + mobile)
- [ ] Select dropdown rendering (desktop + mobile)
- [ ] Checkbox rendering (desktop + mobile)
- [ ] Radio button rendering (desktop + mobile)
- [ ] Form validation states (error, success, disabled)
- [ ] Form label positioning and accessibility
- [ ] Mobile form input zoom behavior (prevent zoom on focus)

**Visual Regression Baselines**:
- `components/c-form/text-input-desktop.png`
- `components/c-form/text-input-mobile.png`
- `components/c-form/textarea.png`
- `components/c-form/select-dropdown.png`
- `components/c-form/checkbox-radio.png`
- `components/c-form/validation-states.png`

**TDD Cycle**:
1. RED: Write failing test for form element
2. GREEN: Fake It with hardcoded form element styling
3. REFACTOR: Apply flocking rules to extract common form patterns

---

## 🚨 Quality Gate Enforcement

### Continuous Testing Protocol

**After EVERY Micro-Refactoring Step** (≤3 lines):

```bash
#!/bin/bash
# Continuous testing validation protocol

validate_micro_refactoring_step() {
    local change_description="$1"

    echo "🔍 Validating micro-refactoring: ${change_description}"

    # Quality Gate 1: All tests pass
    echo "🧪 Quality Gate 1: Running all tests..."
    if ! npm test; then
        echo "❌ QUALITY GATE FAILURE: Tests failing"
        echo "🔄 ROLLBACK INITIATED"
        git reset --hard HEAD
        return 1
    fi
    echo "✅ Quality Gate 1 PASSED: All tests passing"

    # Quality Gate 2: Visual regression ≤3%
    echo "📸 Quality Gate 2: Checking visual regression..."
    if ! validate_visual_regression_within_tolerance; then
        echo "❌ QUALITY GATE FAILURE: Visual regression >3%"
        echo "🔄 ROLLBACK INITIATED"
        git reset --hard HEAD
        return 1
    fi
    echo "✅ Quality Gate 2 PASSED: Visual regression ≤3%"

    # Quality Gate 3: Hugo build success
    echo "🏗️ Quality Gate 3: Validating Hugo build..."
    if ! bun run build >/dev/null 2>&1; then
        echo "❌ QUALITY GATE FAILURE: Hugo build failed"
        echo "🔄 ROLLBACK INITIATED"
        git reset --hard HEAD
        return 1
    fi
    echo "✅ Quality Gate 3 PASSED: Hugo build successful"

    # Quality Gate 4: Performance maintained
    echo "⚡ Quality Gate 4: Performance regression check..."
    if ! validate_performance_within_threshold; then
        echo "❌ QUALITY GATE FAILURE: Performance degraded >5%"
        echo "🔄 ROLLBACK INITIATED"
        git reset --hard HEAD
        return 1
    fi
    echo "✅ Quality Gate 4 PASSED: Performance maintained"

    # All quality gates passed - micro-commit
    git add .
    git commit -m "${change_description} (≤3 lines)"

    echo "✅ ALL QUALITY GATES PASSED - Micro-commit successful"
}

# Helper function: Validate visual regression threshold
validate_visual_regression_within_tolerance() {
    # Run visual regression tests with 3% tolerance
    local visual_test_output=$(npm test 2>&1 | grep -i "screenshot.*match\|difference")

    # Check if any visual differences exceed 3% tolerance
    if echo "$visual_test_output" | grep -qE "difference.*level.*0\.0[4-9]|difference.*level.*0\.[1-9]"; then
        return 1  # Visual regression >3%
    fi

    return 0  # Visual regression ≤3%
}

# Helper function: Validate performance threshold
validate_performance_within_threshold() {
    # Run Lighthouse performance check
    local current_score=$(bun run lighthouse 2>&1 | grep -oP 'Performance: \K\d+' || echo "0")
    local baseline_score=98

    # Calculate percentage change
    local score_diff=$((baseline_score - current_score))
    local percentage_drop=$((score_diff * 100 / baseline_score))

    # Fail if performance dropped >5%
    if [[ $percentage_drop -gt 5 ]]; then
        return 1
    fi

    return 0
}
```

### Rollback Decision Matrix

**IMMEDIATE ROLLBACK TRIGGERS** (zero tolerance):

| Condition | Threshold | Action | Rationale |
|-----------|-----------|--------|-----------|
| **Test Failures** | ANY failure | `git reset --hard HEAD` | Tests are sacred baseline |
| **Visual Regression** | >3% difference | `git reset --hard HEAD` | User-facing visual changes unacceptable |
| **Hugo Build Error** | ANY error | `git reset --hard HEAD` | Site must build successfully |
| **Performance Degradation** | >5% Lighthouse drop | `git reset --hard HEAD` | Performance is user experience |
| **Mobile Functionality** | ANY broken feature | `git reset --hard HEAD` | Mobile users are primary audience |

---

## 📋 Sprint 3 Testing Checklist

### Pre-Sprint Testing Readiness

**Before starting Sprint 3** (MANDATORY):
- [ ] Baseline restored: ALL 40 tests passing (0 failures, 0 errors)
- [ ] Visual regression baselines confirmed (≤3% tolerance)
- [ ] Mobile navigation functional (`.js-mobile-menu-opener` present)
- [ ] Hugo builds successfully (no errors/warnings)
- [ ] Lighthouse performance ≥98/100
- [ ] Component showcase page created (for testing components)
- [ ] RED phase tests written for all Sprint 3 components
- [ ] Rollback procedures validated and documented

### During Sprint Testing Protocol

**After EVERY micro-refactoring step**:
- [ ] Run `npm test` - expect: 40+ runs, 58+ assertions, 0 failures
- [ ] Validate visual regression ≤3% tolerance
- [ ] Confirm mobile responsiveness maintained
- [ ] Verify Hugo build succeeds
- [ ] Git micro-commit completed

**After EVERY component extraction**:
- [ ] All component-specific tests passing
- [ ] Visual regression baselines captured
- [ ] Mobile testing completed
- [ ] Performance impact assessed (≤5% degradation)
- [ ] Four-eyes validation completed
- [ ] Documentation updated

### Post-Sprint Testing Validation

**Sprint 3 completion criteria**:
- [ ] 1,200+ lines changed (BEM component extraction)
- [ ] ALL tests passing (100% pass rate)
- [ ] Zero visual regressions introduced
- [ ] Performance maintained (Lighthouse ≥98/100)
- [ ] Mobile parity confirmed across all components
- [ ] Cross-browser testing completed (Chrome, Firefox, Safari)
- [ ] Accessibility testing completed (WCAG 2.1 AA)
- [ ] Four-eyes validation completed for all components
- [ ] Sprint retrospective completed
- [ ] Documentation fully updated

---

## 🤝 Agent Coordination & Memory Storage

### Testing Phase Memory Coordination

**TDD Phase Tracking** (store in memory after each phase):

```yaml
memory_coordination:
  # RED Phase completion
  red_phase_completion:
    key: "tdd/red-phase/sprint-3/component-{name}"
    value:
      component: "c-button"
      tests_created: ["test_primary_button", "test_secondary_button", "test_hover_state"]
      tests_failing: true
      timestamp: "2025-09-30T02:00:00Z"
      agent: "test-writer"

  # GREEN Phase completion
  green_phase_completion:
    key: "tdd/green-phase/sprint-3/component-{name}"
    value:
      component: "c-button"
      implementation_strategy: "obvious"  # fake_it | obvious | triangulation
      tests_passing: true
      duplication_accepted: true
      timestamp: "2025-09-30T02:15:00Z"
      agent: "minimal-implementer"

  # REFACTOR Phase completion
  refactor_phase_completion:
    key: "tdd/refactor-phase/sprint-3/component-{name}"
    value:
      component: "c-button"
      flocking_rules_applied: 3
      duplication_eliminated: ["padding", "border-radius", "font-weight"]
      tests_remaining_green: true
      micro_commits: 3
      timestamp: "2025-09-30T02:30:00Z"
      agent: "refactor-specialist"

  # Quality Gate validation
  quality_gate_status:
    key: "tdd/quality-gates/sprint-3/component-{name}"
    value:
      component: "c-button"
      test_pass_rate: "100%"
      visual_regression: "0.02"  # 2% - within ≤3% tolerance
      performance_impact: "-1%"  # improved
      mobile_functionality: "passing"
      validation_timestamp: "2025-09-30T02:35:00Z"
```

### Four-Eyes Validation Integration

**Paired Testing Protocol**:
```bash
#!/bin/bash
# Four-eyes paired testing validation

four_eyes_component_testing() {
    local component_name=$1
    local test_writer="test-writer-agent"
    local reviewer="qa-expert-agent"

    echo "👥 Four-Eyes Component Testing: ${component_name}"

    # Step 1: Primary agent (test-writer) creates RED phase tests
    echo "🔴 Primary Agent (${test_writer}): Creating RED phase tests..."
    if ! create_component_behavior_test "$component_name"; then
        echo "❌ BLOCKING: RED phase test creation failed"
        return 1
    fi

    # Step 2: Secondary agent (reviewer) validates test quality
    echo "👁️ Secondary Agent (${reviewer}): Validating test quality..."
    if ! validate_behavioral_testing_compliance "$component_name"; then
        echo "❌ BLOCKING: Tests violate behavioral testing requirements"
        return 1
    fi

    # Step 3: Both agents confirm GREEN phase implementation
    echo "🟢 Both Agents: Validating GREEN phase implementation..."
    if ! validate_green_phase_tests_passing "$component_name"; then
        echo "❌ BLOCKING: GREEN phase tests not passing"
        return 1
    fi

    # Step 4: Both agents confirm REFACTOR phase maintains green
    echo "🔵 Both Agents: Validating REFACTOR phase integrity..."
    if ! validate_refactor_phase_tests_green "$component_name"; then
        echo "❌ BLOCKING: REFACTOR phase broke tests"
        return 1
    fi

    # Store four-eyes validation in memory
    npx claude-flow@alpha hooks memory-store \
        --key "four-eyes/tdd/sprint-3/${component_name}" \
        --value "test_writer:${test_writer},reviewer:${reviewer},status:validated,timestamp:$(date -Iseconds)"

    echo "✅ Four-Eyes Validation Complete: ${component_name}"
}
```

---

## 🎯 Success Metrics

### Sprint 3 Testing KPIs

**Quantitative Metrics**:
- **Test Pass Rate**: 100% (zero failures tolerated)
- **Visual Regression**: ≤3% tolerance (zero unintended changes)
- **Mobile Functionality**: 100% (all features work on mobile)
- **Performance**: Lighthouse ≥98/100 (maintain baseline)
- **Component Coverage**: 100% (all Sprint 3 components tested)

**Qualitative Metrics**:
- **Behavioral Testing Compliance**: 100% (zero implementation testing)
- **TDD Cycle Integrity**: RED → GREEN → REFACTOR followed for all components
- **Shameless Green Acceptance**: Duplication accepted in GREEN phase
- **Flocking Rules Application**: Systematic consolidation in REFACTOR phase
- **Micro-Commit Discipline**: ≤3 lines per commit

---

## 📚 References

### Project Documentation
- **Testing Protocol**: `/docs/projects/2509-css-migration/50-59-testing/50.01-testing-protocol.md`
- **Visual Testing Protocol**: `/docs/projects/2509-css-migration/50-59-testing/50.03-visual-checkpoints/VISUAL_TESTING_PROTOCOL.md`
- **Critical Baseline Report**: `/docs/projects/2509-css-migration/50-59-testing/CRITICAL-TESTING-BASELINE-REPORT.md`

### Handbook Standards
- **TDD Methodology**: `/knowledge/20.01-tdd-methodology-reference.md`
- **TDD Agent Delegation**: `/knowledge/20.11-tdd-agent-delegation-how-to.md`
- **Shameless Green Methodology**: `/knowledge/20.05-shameless-green-flocking-rules-methodology.md`
- **Test Smell Prevention**: `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md`
- **TDD Quality Enforcement**: `/docs/60.03-tdd-quality-enforcement.md`

---

**CRITICAL REMINDER**: This TDD testing strategy CANNOT be executed until baseline is restored to passing state. ALL 40 tests must pass with 0 failures, 0 errors before Sprint 3 begins. Rollback to master branch is MANDATORY prerequisite.