# Component Extraction Architecture - jt_site

**Version**: 1.0
**Date**: 2025-10-06
**Authority**: Architecture Expert - Hive Mind Swarm
**Compliance**: Handbook principles, BEM methodology, TDD quality enforcement

---

## Executive Summary

This document defines the systematic architecture for extracting FL-Builder components into semantic, testable, and maintainable BEM-compliant Hugo partials. The architecture ensures autonomous execution capability while maintaining zero-tolerance quality standards.

### Core Principles

- **Simplicity First**: Leverage existing patterns, avoid over-engineering
- **BEM Strict Compliance**: `c-[component]`, `c-[component]__[element]`, `c-[component]--[modifier]`
- **Testability**: Every component requires both visual regression and behavioral tests
- **Incremental Safety**: Green tests before commits, clear rollback paths
- **Zero Duplication**: NO `_refactored`, `_new`, `_v2` file suffixes

---

## 1. Component Extraction Template Structure

### 1.1 File Naming Conventions

#### ✅ CORRECT Patterns

```yaml
component_files:
  hugo_partials: "themes/beaver/layouts/partials/components/[component-name].html"
  css_files: "themes/beaver/assets/css/components/[component-name].css"
  test_files: "test/system/components/[component_name]_component_test.rb"

naming_rules:
  component_name_format: "kebab-case (lowercase with hyphens)"
  examples:
    - "hero-section.html"
    - "testimonial-card.html"
    - "job-listing-grid.html"
```

#### ❌ FORBIDDEN Patterns

```yaml
forbidden_suffixes:
  - "*_refactored.html"
  - "*_new.html"
  - "*_v2.html"
  - "*_updated.html"
  - "*_copy.html"
  - "*_backup.html"
  - "duplicate_*.html"
  - "temp_*.html"
  - "old_*.html"

enforcement:
  pre_write_validation: "MANDATORY - check file existence before creating"
  duplication_detection: "Analyze similar functionality across files"
  consolidation_requirement: "If similar file exists, update existing instead of creating new"
```

### 1.2 Hugo Partial Template Structure

#### Standard Component Template

```html
{{/*
  Component: [Component Name]
  Purpose: [Brief description of component purpose]

  Required Parameters:
    - [param_name] ([type]): [description]

  Optional Parameters:
    - [param_name] ([type], default: [value]): [description]

  Usage Example:
    {{ partial "components/[component-name].html" (dict
      "[param1]" "[value1]"
      "[param2]" "[value2]"
    ) }}

  BEM Classes:
    - .c-[component]: Base component class
    - .c-[component]__[element]: Component element
    - .c-[component]--[modifier]: Component modifier variant

  FL-Builder Compatibility: [YES/NO]
  Visual Test: test/system/components/[component_name]_component_test.rb
*/}}

{{/* Parameter Extraction with Defaults */}}
{{- $param1 := .param1 -}}  {{/* Required - no default */}}
{{- $param2 := .param2 | default "default_value" -}}  {{/* Optional */}}
{{- $node_id := .node_id | default (printf "c-%s-%s" "[component]" ($param1 | urlize)) -}}

{{/* FL-Builder Wrapper Structure (Preserve for Compatibility) */}}
<div class="fl-module fl-module-[type] fl-node-{{ $node_id }}" data-node="{{ $node_id }}">
  <div class="fl-module-content fl-node-content">

    {{/* BEM Component Structure */}}
    <div class="c-[component] {{ .bem_modifiers }}">

      {{/* Component Elements */}}
      <div class="c-[component]__[element]">
        {{ $param1 }}
      </div>

    </div>

  </div>
</div>
```

### 1.3 Directory Organization Schema

```plaintext
themes/beaver/
├── layouts/
│   └── partials/
│       └── components/           # Hugo component partials
│           ├── hero-section.html
│           ├── testimonial-section.html
│           ├── job-listing-section.html
│           ├── content-block.html
│           └── cta-block.html
│
├── assets/
│   └── css/
│       ├── component-bundle.css   # Main component imports (existing)
│       └── components/            # Individual component CSS
│           ├── hero-section.css
│           ├── testimonial-section.css
│           └── job-listing-section.css
│
test/
├── system/
│   └── components/                # Component system tests
│       ├── hero_section_component_test.rb
│       ├── testimonial_section_component_test.rb
│       └── job_listing_section_component_test.rb
│
docs/
└── components/                    # Component documentation
    ├── hero-section.md
    ├── testimonial-section.md
    └── job-listing-section.md
```

---

## 2. BEM Methodology Compliance

### 2.1 Strict BEM Class Naming

#### Component Prefix System

```yaml
prefixes:
  components: "c-"     # Reusable UI components
  layouts: "l-"        # Layout containers (NOT used for components)
  utilities: "u-"      # Utility classes (NOT used for components)
  pages: "[page]__"    # Page-specific sections (NOT used for reusable components)
```

#### BEM Structure Enforcement

```css
/* ✅ CORRECT: BEM Component Structure */

/* Block - Base component */
.c-hero-section {
  /* Base styles for hero section component */
  position: relative;
  display: flex;
}

/* Element - Component parts */
.c-hero-section__column-group { /* Column container */ }
.c-hero-section__column { /* Individual column */ }
.c-hero-section__heading { /* Heading element */ }
.c-hero-section__text { /* Text element */ }
.c-hero-section__button { /* Button element */ }

/* Modifier - Component variants */
.c-hero-section--about { /* About page variant */ }
.c-hero-section--careers { /* Careers page variant */ }
.c-hero-section--with-image { /* With background image */ }
```

#### ❌ FORBIDDEN Patterns
```css
/* Mixed naming conventions */
.c-hero-section { }
.hero-section-title { }         /* Missing c- prefix */
.hero_section__text { }         /* Wrong separator (underscore instead of hyphen) */
.heroSection--large { }         /* camelCase in CSS */

/* Over-nesting */
.c-hero-section__column__text { }  /* Max 2 levels: block__element */

/* Modifier on element without base */
.c-hero-section__heading--large { }  /* Should be on block: .c-hero-section--large-heading */
```

### 2.2 Component CSS Architecture

#### Component CSS Template
```css
/* ==========================================================================
   Component: [Component Name] (c-[component])
   Purpose: [Brief description]

   BEM Structure:
   - .c-[component]                  Base component
   - .c-[component]__[element]       Component elements
   - .c-[component]--[modifier]      Component variants

   FL-Builder Compatibility: [YES/NO]
   ========================================================================== */

/* Base Component
   ========================================================================== */
.c-[component] {
  /* Core component styles */
}

/* Component Elements
   ========================================================================== */
.c-[component]__[element] {
  /* Element-specific styles */
}

/* Component Modifiers
   ========================================================================== */
.c-[component]--[modifier] {
  /* Variant-specific styles */
}

/* FL-Builder Compatibility Layer (if required)
   ========================================================================== */
.fl-node-[original-id] {
  /* Preserve original FL-Builder functionality */
  @extend .c-[component];
}

/* Responsive Adjustments
   ========================================================================== */
@media (max-width: 768px) {
  .c-[component] {
    /* Mobile adjustments */
  }
}
```

---

## 3. Testing Architecture

### 3.1 Visual Regression Testing Pattern

#### Component Visual Test Template
```ruby
# frozen_string_literal: true

require "application_system_test_case"

class [ComponentName]ComponentTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    super
  end

  def test_[component]_desktop_rendering
    visit "/[page-with-component]/"

    # Wait for component to be visible
    assert_css ".c-[component]", wait: 2

    # Verify component structure (BEHAVIORAL - not existence)
    assert_selector ".c-[component]__[element]", count: [expected_count]

    # Verify component content (BEHAVIORAL - user-facing)
    assert_text "[Expected visible text]"

    # Visual regression screenshot
    assert_stable_screenshot "components/[component]", tolerance: 0.03
  end

  def test_[component]_responsive_behavior
    Capybara.current_driver = :mobile_chrome
    visit "/[page-with-component]/"

    assert_css ".c-[component]", wait: 2

    # Verify responsive adaptations (BEHAVIORAL)
    assert_selector ".c-[component]__[element]--mobile", visible: :visible

    # Mobile visual regression
    assert_stable_screenshot "components/[component]_mobile", tolerance: 0.03
  end

  def test_[component]_interactive_states
    visit "/[page-with-component]/"

    # Test hover states (BEHAVIORAL - user interaction)
    element = find(".c-[component]__button")
    element.hover

    assert_css ".c-[component]__button:hover", visible: :visible
    assert_stable_screenshot "components/[component]_hover", tolerance: 0.03
  end
end
```

### 3.2 Behavioral Testing Pattern

#### Behavioral Test Requirements
```ruby
# ✅ CORRECT: Behavioral validation (tests WHAT users see/do)

def test_hero_section_displays_call_to_action
  visit "/careers/"

  # Verify user-facing behavior
  assert_selector ".c-hero-section"
  assert_text "Looking for a Team to Take You to the Next Level?"
  assert_link "Get in Touch", href: /contact-us/

  # Test user interaction
  click_link "Get in Touch"
  assert_current_path "/contact-us/"
  assert_text "Contact Us"
end

def test_testimonial_section_carousel_navigation
  visit "/about/"

  # Verify carousel exists and has content
  assert_selector ".c-testimonial-section"
  assert_css ".swiper-slide", minimum: 2

  # Test carousel navigation (user behavior)
  first_testimonial = find(".swiper-slide-active .pp-review-text").text

  # Navigate to next slide
  find(".swiper-button-next").click
  sleep 0.5  # Animation time

  second_testimonial = find(".swiper-slide-active .pp-review-text").text
  refute_equal first_testimonial, second_testimonial
end

# ❌ FORBIDDEN: Implementation/existence testing

def test_testimonial_css_classes_exist  # WRONG - tests implementation
  visit "/about/"

  assert_css ".c-testimonial-section"
  assert_css ".c-testimonial-section__column-group"
  assert_css ".c-testimonial-section__photo"
  # This tests HOW code is structured, not WHAT users experience
end

def test_hero_section_html_structure  # WRONG - tests code structure
  visit "/careers/"

  assert_selector "div.fl-row.c-hero-section"
  assert_selector "div.fl-row-content-wrap > div.fl-row-content"
  # This tests HTML implementation, not user-facing behavior
end
```

### 3.3 Test Isolation Requirements

#### Component Test Independence
```ruby
# ✅ CORRECT: Isolated component testing

class TestimonialSectionComponentTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    super
  end

  def teardown
    # Cleanup after each test
    Capybara.reset_sessions!
    super
  end

  def test_testimonial_section_renders_independently
    # Test component in isolation on dedicated test page
    visit "/test/components/testimonial/"

    assert_css ".c-testimonial-section", wait: 2
    assert_stable_screenshot "components/testimonial", tolerance: 0.03
  end

  def test_testimonial_section_integrates_with_about_page
    # Test component in production context
    visit "/about/"

    within ".c-testimonial-section" do
      assert_text "Most clients stay over 3 years"
      assert_css ".swiper-slide", minimum: 2
    end
  end
end

# ❌ FORBIDDEN: Coupled testing across components

def test_entire_page_at_once  # WRONG - tests multiple components together
  visit "/about/"

  # Tests hero, testimonials, achievements, CTA all at once
  assert_css ".c-hero-section"
  assert_css ".c-testimonial-section"
  assert_css ".c-achievements-section"
  assert_css ".c-cta-section"

  # Cannot isolate which component is failing
  assert_stable_screenshot "about_page_everything"
end
```

---

## 4. Component Extraction Process

### 4.1 Systematic Extraction Workflow

#### Phase-Based Extraction
```yaml
phase_1_analysis:
  tasks:
    - "Identify FL-Builder module in page template"
    - "Extract HTML structure and data dependencies"
    - "Identify CSS classes and styling requirements"
    - "Document component parameters and usage"

  outputs:
    - "Component specification document"
    - "Parameter interface definition"
    - "BEM class mapping plan"

phase_2_extraction:
  tasks:
    - "Create Hugo partial in themes/beaver/layouts/partials/components/"
    - "Implement parameter extraction with defaults"
    - "Preserve FL-Builder wrapper structure"
    - "Add BEM classes alongside existing classes"

  validation:
    - "Hugo build successful (no template errors)"
    - "No duplicate file created"
    - "Parameter defaults provide safe fallbacks"

phase_3_css_creation:
  tasks:
    - "Create component CSS in themes/beaver/assets/css/components/"
    - "Follow BEM naming strictly"
    - "Add FL-Builder compatibility layer if needed"
    - "Import in component-bundle.css"

  validation:
    - "CSS syntax valid"
    - "BEM structure verified"
    - "No style regressions"

phase_4_testing:
  tasks:
    - "Create visual regression test in test/system/components/"
    - "Write behavioral validation tests"
    - "Create component test page (if needed)"
    - "Run bin/rake test:critical"

  validation:
    - "Visual regression baseline captured"
    - "Behavioral tests pass"
    - "Test isolation verified"
    - "No test smells detected"

phase_5_integration:
  tasks:
    - "Replace inline FL-Builder code with partial"
    - "Pass parameters from page data"
    - "Verify visual output matches baseline"
    - "Update component documentation"

  validation:
    - "Visual regression passes (tolerance: 0.03)"
    - "Page functionality unchanged"
    - "No performance degradation"

phase_6_commit:
  tasks:
    - "Run bin/rake test:critical one final time"
    - "Verify all tests green"
    - "Commit with descriptive message"
    - "Update progress tracking"

  commit_message_template: |
    REFACTOR: Extract [ComponentName] component ([X]/[Total])

    - Created themes/beaver/layouts/partials/components/[component].html
    - Added BEM classes: .c-[component], .c-[component]__[element]
    - Created visual regression test: test/system/components/[component]_test.rb
    - Integrated into [page1].html, [page2].html

    Tests: All green (bin/rake test:critical)
    Visual: Baseline captured, tolerance: 0.03
    Behavior: No functional changes
```

### 4.2 Component Parameter Design

#### Parameter Categories
```yaml
required_parameters:
  definition: "Parameters without defaults that MUST be provided"
  extraction_pattern: "{{- $param := .param -}}"
  validation: "Component fails gracefully if missing"
  examples:
    - "title: Main component heading"
    - "content: Primary component text"
    - "icon: SVG icon identifier"

optional_parameters:
  definition: "Parameters with sensible defaults"
  extraction_pattern: "{{- $param := .param | default 'default_value' -}}"
  validation: "Component works with default if not provided"
  examples:
    - "cta_text: (default: 'Learn More')"
    - "link: (default: '#')"
    - "heading_level: (default: 'h2')"

page_context_parameters:
  definition: "Parameters from Hugo page context"
  extraction_pattern: "{{- $param := .Page.Params.param -}}"
  validation: "Component adapts to page data"
  examples:
    - "cover_image: .Page.Resources.Get .Page.Params.cover_image"
    - "testimonials: .Page.Params.testimonials"
    - "achievements: .Page.Params.achievements"

fl_builder_compatibility:
  definition: "Parameters for FL-Builder node IDs and legacy classes"
  extraction_pattern: "{{- $node_id := .node_id | default (printf 'c-%s' $unique_id) -}}"
  validation: "Maintains backward compatibility with existing CSS"
  examples:
    - "node_id: Original FL-Builder node identifier"
    - "preserve_fl_structure: (default: true)"
    - "bem_modifiers: Additional BEM modifier classes"
```

---

## 5. Rollback Strategy

### 5.1 Green Test Requirement

#### Commit Gate Enforcement
```yaml
pre_commit_validation:
  command: "bin/rake test:critical"
  requirement: "ALL tests must be green"
  enforcement: "BLOCKING - cannot proceed on test failures"

  test_categories:
    visual_regression:
      - "Component screenshot matches baseline"
      - "Tolerance: 0.03 (3% pixel difference)"
      - "Stability time: 2 seconds default"

    behavioral_validation:
      - "Component renders correctly"
      - "Interactive elements function"
      - "Content displays as expected"

    integration_validation:
      - "Component works in production context"
      - "Page functionality unchanged"
      - "No JavaScript errors"

rollback_triggers:
  critical_failures:
    - "Visual regression exceeds tolerance"
    - "Behavioral test failures"
    - "Hugo build errors"
    - "CSS syntax errors"
    - "JavaScript console errors"

  automatic_rollback:
    action: "git reset --hard HEAD~1"
    when: "Critical test failures detected"
    prevention: "ALWAYS test locally before committing"
```

### 5.2 Rollback Execution Protocol

#### Step-by-Step Rollback
```bash
# 1. Identify failed component extraction
git log --oneline -n 5

# 2. Verify test failures
bin/rake test:critical

# 3. Review specific test failures
bin/rake test TEST=test/system/components/[component]_component_test.rb

# 4. Decision point: Fix or Rollback?

## Option A: Fix Forward (if minor issue)
# - Fix test or implementation
# - Re-run bin/rake test:critical
# - Commit fix

## Option B: Rollback (if complex issue)
git reset --hard HEAD~1  # Remove last commit
git clean -fd            # Remove untracked files

# 5. Verify rollback success
bin/rake test:critical   # Should be all green
hugo build               # Should build successfully

# 6. Document rollback
# - Update component extraction progress
# - Document rollback reason
# - Plan resolution approach
```

### 5.3 Validation Checkpoints

**Quality Gate Checklist:**
```yaml
checkpoint_1_extraction:
  - "[ ] Hugo partial created in correct directory"
  - "[ ] Parameters documented with types and defaults"
  - "[ ] BEM classes follow strict naming convention"
  - "[ ] FL-Builder structure preserved (if required)"
  - "[ ] No duplicate files created"

checkpoint_2_css:
  - "[ ] Component CSS created with BEM structure"
  - "[ ] Imported in component-bundle.css"
  - "[ ] FL-Builder compatibility layer added (if needed)"
  - "[ ] Responsive breakpoints defined"
  - "[ ] CSS syntax validated"

checkpoint_3_testing:
  - "[ ] Visual regression test created"
  - "[ ] Behavioral validation tests written"
  - "[ ] Tests focus on BEHAVIOR, not implementation"
  - "[ ] Test isolation verified"
  - "[ ] bin/rake test:critical passes"

checkpoint_4_integration:
  - "[ ] Component integrated into page template"
  - "[ ] Visual regression passes (tolerance: 0.03)"
  - "[ ] Page functionality unchanged"
  - "[ ] No console errors"
  - "[ ] Hugo build successful"

checkpoint_5_documentation:
  - "[ ] Component usage documented"
  - "[ ] Parameter reference complete"
  - "[ ] Integration examples provided"
  - "[ ] Migration notes added"
  - "[ ] Progress tracking updated"

checkpoint_6_commit:
  - "[ ] All tests green"
  - "[ ] Commit message descriptive"
  - "[ ] Progress counter updated"
  - "[ ] Branch clean (no untracked files)"
```

---

## 6. Autonomous Execution Patterns

### 6.1 Solo Execution Mode

**When to Use Solo Execution:**
```yaml
solo_execution_criteria:
  - "Simple component extraction with clear pattern"
  - "Component structure already established (follow existing examples)"
  - "No architectural decisions required"
  - "Repetitive mechanical work (multiple similar components)"
  - "Existing tests provide clear validation"

solo_workflow:
  step_1: "Extract component following template"
  step_2: "Create BEM CSS following existing patterns"
  step_3: "Write visual regression + behavioral tests"
  step_4: "Run bin/rake test:critical"
  step_5_green: "Commit and continue to next component"
  step_5_red: "Rollback, analyze, fix, retry"

continuous_execution:
  trigger: "User requests continuous work on component list"
  pattern: "Extract → Test → Commit → Next (repeat)"
  stop_conditions:
    - "Critical test failures"
    - "Architectural uncertainty"
    - "User intervention requested"
```

### 6.2 Pair Execution Mode

**When to Use Pair Execution:**
```yaml
pair_execution_criteria:
  - "Moderate complexity (new component pattern)"
  - "Cross-file integration (affects 2-3 templates)"
  - "Behavioral test design requires validation"
  - "BEM class structure needs review"

pair_roles:
  driver: "Implements component extraction"
  navigator: "Validates BEM compliance, test quality, integration"

rotation: "25 minutes per role"
```

### 6.3 Full XP Team Mode

**When to Use Full Team:**
```yaml
team_execution_criteria:
  - "Complex architectural decisions"
  - "New component pattern establishment"
  - "Multi-page integration (>3 templates)"
  - "Performance-critical components"
  - "System design requiring expert consultation"

team_composition:
  - "XP Coach: Facilitates TDD cycle"
  - "Architecture Expert: Component structure design"
  - "Test Quality Expert: Validates behavioral focus"
  - "Coder (Driver): Implements extraction"
  - "Reviewer (Navigator): Validates quality"
```

---

## 7. Component Quality Validation

### 7.1 Pre-Extraction Validation

**Component Candidate Analysis:**
```yaml
analysis_checklist:
  reusability:
    - "[ ] Component appears in 2+ pages (or will be reused)"
    - "[ ] Component has clear, consistent structure"
    - "[ ] Component serves single, well-defined purpose"

  extractability:
    - "[ ] Component boundaries are clear"
    - "[ ] Component has minimal external dependencies"
    - "[ ] Component parameters are identifiable"

  testability:
    - "[ ] Component has visible user-facing behavior"
    - "[ ] Component has testable interactive states"
    - "[ ] Component can be isolated for testing"

  value:
    - "[ ] Extraction reduces code duplication"
    - "[ ] Extraction improves maintainability"
    - "[ ] Extraction enables consistency across pages"
```

### 7.2 Post-Extraction Validation

**Component Quality Metrics:**
```yaml
code_quality:
  bem_compliance:
    - "All classes follow c-[component] prefix"
    - "No mixed naming conventions"
    - "Max 2 levels: .c-component__element (not .c-component__element__sub)"

  parameter_design:
    - "Required parameters clearly documented"
    - "Optional parameters have sensible defaults"
    - "Parameter types specified"

  fl_builder_compatibility:
    - "FL-Builder structure preserved (if required)"
    - "Legacy CSS classes maintained"
    - "No visual regressions"

test_quality:
  visual_regression:
    - "Screenshot baseline captured"
    - "Tolerance appropriate (default: 0.03)"
    - "Stability time configured (default: 2s)"

  behavioral_validation:
    - "Tests focus on user-facing behavior"
    - "No implementation testing"
    - "No existence testing"
    - "Interactive states tested"

  test_isolation:
    - "Component can be tested independently"
    - "Tests don't depend on other components"
    - "Setup/teardown properly isolated"

documentation_quality:
  component_reference:
    - "Purpose clearly stated"
    - "Required parameters documented"
    - "Optional parameters with defaults"
    - "Usage examples provided"
    - "BEM classes listed"

  integration_guide:
    - "Page integration examples"
    - "Parameter passing patterns"
    - "Migration notes (if replacing FL-Builder)"
```

---

## 8. Component Library Growth Strategy

### 8.1 Priority Component Extraction Order

#### Phase 1: High-Value, Low-Complexity Components

```yaml
priority_1_components:
  - name: "Hero Section"
    complexity: "low"
    reusability: "high (6+ pages)"
    value: "high (visual consistency)"

  - name: "Testimonial Section"
    complexity: "low"
    reusability: "high (4+ pages)"
    value: "high (social proof consistency)"

  - name: "Job Listing Grid"
    complexity: "low"
    reusability: "medium (careers page)"
    value: "medium (maintainability)"

extraction_order_criteria:
  - "Reusability (number of pages using component)"
  - "Complexity (lower complexity first)"
  - "Value (duplication reduction, maintainability)"
  - "Dependencies (extract dependencies first)"
```

#### Phase 2: Medium-Complexity Components

```yaml
priority_2_components:
  - name: "Content Block with Patterns"
    complexity: "medium"
    reusability: "very high (100+ instances)"
    value: "very high (massive duplication reduction)"

  - name: "Feature Card Grid"
    complexity: "medium"
    reusability: "high (5+ pages)"
    value: "high (consistency)"

  - name: "CTA Block"
    complexity: "medium"
    reusability: "high (8+ pages)"
    value: "high (conversion consistency)"
```

**Phase 3: Complex, Specialized Components**
```yaml
priority_3_components:
  - name: "Interactive Carousel"
    complexity: "high"
    reusability: "medium (2-3 pages)"
    value: "medium (complex behavior)"

  - name: "Dynamic Form Components"
    complexity: "high"
    reusability: "medium (contact, newsletter)"
    value: "high (user interaction)"
```

### 8.2 Component Consolidation Strategy

**Duplication Detection:**
```yaml
detection_patterns:
  similar_structure:
    - "Components with >80% HTML structure similarity"
    - "Components with identical parameter patterns"
    - "Components differing only in content/styling"

  similar_behavior:
    - "Components with same interactive patterns"
    - "Components with same responsive breakpoints"
    - "Components with same data dependencies"

consolidation_approach:
  analyze: "Identify commonalities and differences"
  generalize: "Create parameterized component supporting all variants"
  migrate: "Replace all instances with generalized component"
  test: "Verify no behavioral changes across all instances"
  cleanup: "Remove duplicate component files"
```

---

## 9. Success Metrics

### 9.1 Quantitative Metrics

```yaml
code_metrics:
  duplication_reduction:
    target: ">50% reduction in duplicated HTML"
    measurement: "Line count before/after extraction"

  file_organization:
    target: "100% components in partials/components/"
    measurement: "Component file location audit"

  test_coverage:
    target: ">95% visual regression coverage"
    measurement: "Components with visual tests / total components"

  bem_compliance:
    target: "100% BEM-compliant class names"
    measurement: "Automated BEM validation scan"

quality_metrics:
  test_quality:
    target: "Zero test smells"
    measurement: "Behavioral test ratio (behavior tests / total tests)"

  rollback_rate:
    target: "<5% extraction rollbacks"
    measurement: "Successful extractions / total attempts"

  build_stability:
    target: "100% Hugo build success rate"
    measurement: "Successful builds / total extraction commits"
```

### 9.2 Qualitative Metrics

```yaml
maintainability:
  - "Developer can understand component purpose within 30 seconds"
  - "Component parameters are self-documenting"
  - "Integration examples are clear and complete"

consistency:
  - "Component behavior is identical across all usage contexts"
  - "Visual output matches design system"
  - "BEM naming follows project conventions"

testability:
  - "Components can be tested in isolation"
  - "Tests validate user-facing behavior"
  - "Visual regression catches design changes"

scalability:
  - "New component variants are easy to add"
  - "Component reuse reduces template complexity"
  - "Documentation supports autonomous execution"
```

---

## 10. Architectural Decision Records

### ADR-001: BEM Class Prefix Strategy

**Decision**: Use `c-` prefix for all component classes

**Context**: Need consistent, recognizable component naming that differentiates from layout (`l-`), utility (`u-`), and page-specific classes.

**Rationale**:
- Existing pattern in codebase (`c-button`, `c-card`, `c-grid`)
- Clear differentiation from FL-Builder classes (`fl-`)
- Industry-standard BEM prefix convention
- Searchable and easily identifiable

**Consequences**:
- All new components must use `c-` prefix
- Existing components already follow this pattern
- CSS linting can enforce compliance
- Easy to identify components in HTML source

### ADR-002: FL-Builder Compatibility Layer

**Decision**: Preserve FL-Builder wrapper structure for backward compatibility

**Context**: Many existing CSS rules target FL-Builder classes; removing them causes visual regressions.

**Rationale**:
- Gradual migration strategy reduces risk
- Existing CSS continues to function
- Visual regression tests validate compatibility
- Future cleanup can be systematic

**Consequences**:
- Slightly larger HTML output (wrapper divs)
- Two class systems coexist temporarily
- Eventually FL-Builder classes can be deprecated
- Migration path is clear and safe

### ADR-003: Behavioral Testing Mandate

**Decision**: All component tests must validate user-facing behavior, not implementation

**Context**: Test smells (existence testing, implementation testing) were causing false positives.

**Rationale**:
- Behavioral tests remain stable during refactoring
- Tests validate actual user value
- Implementation can change without breaking tests
- Aligns with TDD RED-GREEN-REFACTOR methodology

**Consequences**:
- Test creation requires behavioral analysis
- Tests focus on "what users see/do"
- Refactoring doesn't break working tests
- Higher test quality and maintainability

### ADR-004: Component-Specific CSS Files

**Decision**: Create separate CSS files for each component in `themes/beaver/assets/css/components/`

**Context**: Need modular, maintainable CSS organization supporting selective loading.

**Rationale**:
- Component CSS co-located with component logic
- Easier to understand component styling
- Supports future CSS code-splitting
- Aligns with component-based architecture

**Consequences**:
- More CSS files to manage
- Import via `component-bundle.css` required
- Clear ownership of component styles
- Easier to identify and remove unused CSS

---

## 11. Component Extraction Checklist (Copy-Paste Ready)

**Pre-Extraction Phase:**
```markdown
- [ ] Component identified in page template (FL-Builder module or repeated HTML)
- [ ] Component boundaries are clear (where it starts/ends)
- [ ] Component parameters identified (what varies between instances)
- [ ] Component reusability verified (used in 2+ places or will be)
- [ ] Similar component checked (no duplicate extraction)
- [ ] BEM class names planned (.c-[component], .c-[component]__[element])
```

**Extraction Phase:**
```markdown
- [ ] Hugo partial created: themes/beaver/layouts/partials/components/[component].html
- [ ] Component documentation header complete (purpose, parameters, examples)
- [ ] Required parameters extracted without defaults
- [ ] Optional parameters have sensible defaults
- [ ] FL-Builder wrapper structure preserved (if needed)
- [ ] BEM classes added alongside existing classes
- [ ] Hugo build successful: hugo build --minify
```

**CSS Phase:**
```markdown
- [ ] Component CSS created: themes/beaver/assets/css/components/[component].css
- [ ] BEM structure follows strict naming (.c-[component], .c-[component]__[element], .c-[component]--[modifier])
- [ ] FL-Builder compatibility layer added (if needed)
- [ ] Responsive breakpoints defined
- [ ] Imported in component-bundle.css
- [ ] CSS syntax validated (no build errors)
```

**Testing Phase:**
```markdown
- [ ] Visual regression test created: test/system/components/[component]_component_test.rb
- [ ] Test validates BEHAVIOR (user-facing outcomes, not code structure)
- [ ] Test includes desktop rendering validation
- [ ] Test includes responsive/mobile validation (if applicable)
- [ ] Test includes interactive states (hover, active, focus) if applicable
- [ ] Screenshot baseline captured: assert_stable_screenshot "components/[component]"
- [ ] Behavioral assertions present (assert_text, assert_link, assert_selector with content)
- [ ] NO existence testing (checking class names exist)
- [ ] NO implementation testing (checking HTML structure)
- [ ] Test isolation verified (component can be tested independently)
- [ ] bin/rake test:critical passes (ALL tests green)
```

**Integration Phase:**
```markdown
- [ ] Component partial integrated into page template
- [ ] Parameters passed from page data
- [ ] Visual output matches baseline (tolerance: 0.03)
- [ ] Page functionality unchanged
- [ ] No console errors
- [ ] Hugo build successful
- [ ] Visual regression passes
```

**Documentation Phase:**
```markdown
- [ ] Component usage documented: docs/components/[component].md
- [ ] Required parameters documented with types
- [ ] Optional parameters documented with defaults
- [ ] Integration examples provided
- [ ] Migration notes added (if replacing FL-Builder)
- [ ] BEM classes listed and explained
```

**Commit Phase:**
```markdown
- [ ] bin/rake test:critical final run (ALL GREEN)
- [ ] All tests passing
- [ ] No untracked files (except intentional new files)
- [ ] Commit message follows template:
      REFACTOR: Extract [ComponentName] component ([X]/[Total])

      - Created themes/beaver/layouts/partials/components/[component].html
      - Added BEM classes: .c-[component], .c-[component]__[element]
      - Created visual regression test
      - Integrated into [page].html

      Tests: All green
      Visual: Baseline captured
      Behavior: No changes
- [ ] Component extraction progress updated
```

**Post-Commit Validation:**
```markdown
- [ ] Git status clean
- [ ] Hugo build still successful
- [ ] bin/rake test:critical still green
- [ ] Component library documentation updated
- [ ] Progress tracking incremented
```

---

## 12. Troubleshooting Guide

### Common Issues and Solutions

**Issue 1: Visual Regression Exceeds Tolerance**
```yaml
symptom: "Screenshot diff > 0.03 tolerance"

diagnosis:
  - "Check for dynamic content (dates, counters)"
  - "Check for font rendering differences"
  - "Check for image loading issues"

solutions:
  increase_tolerance:
    when: "Dynamic content unavoidable"
    action: "assert_stable_screenshot 'component', tolerance: 0.05"

  skip_dynamic_areas:
    when: "Specific areas change dynamically"
    action: "assert_stable_screenshot 'component', skip_area: ['.dynamic-counter']"

  stabilize_content:
    when: "Content can be stabilized"
    action: "Use fixed test data, wait for animations to complete"
```

**Issue 2: Behavioral Test Failures**
```yaml
symptom: "assert_text or assert_selector fails"

diagnosis:
  - "Component not rendering (HTML structure issue)"
  - "Content not loading (data dependency missing)"
  - "Timing issue (content loads slowly)"

solutions:
  add_wait:
    when: "Content loads asynchronously"
    action: "assert_css '.c-component', wait: 3"

  verify_data:
    when: "Content depends on page data"
    action: "Check .Page.Params or data files exist"

  check_selector:
    when: "Selector doesn't match"
    action: "Inspect actual HTML, adjust selector"
```

**Issue 3: Hugo Build Errors**
```yaml
symptom: "Template execution errors"

diagnosis:
  - "Parameter extraction syntax error"
  - "Missing required parameter"
  - "Hugo function misuse"

solutions:
  syntax_check:
    action: "Review parameter extraction: {{- $param := .param -}}"

  default_check:
    action: "Add defaults for optional params: | default 'value'"

  hugo_function:
    action: "Verify Hugo function syntax (partial, resources.Get, etc.)"
```

**Issue 4: BEM Class Naming Violations**
```yaml
symptom: "Mixed naming conventions"

diagnosis:
  - "Forgot c- prefix"
  - "Used wrong separator (underscore vs hyphen)"
  - "Over-nested elements"

solutions:
  prefix_fix:
    action: "Add c- to all component classes"

  separator_fix:
    action: "Use hyphens for blocks/modifiers, double-underscore for elements"

  nesting_fix:
    action: "Flatten to max 2 levels: .c-component__element"
```

---

## 13. Next Steps & Continuous Improvement

### Immediate Actions

1. **Validate Architecture with First Component**
   - Extract Hero Section component following this architecture
   - Validate all phases (extraction, CSS, testing, integration)
   - Refine architecture based on learnings

2. **Establish Component Library Foundation**
   - Create component template file for copy-paste
   - Create test template file for copy-paste
   - Document first 3 components as examples

3. **Enable Autonomous Execution**
   - Validate solo execution on simple components
   - Document decision points for escalation
   - Create progress tracking system

### Continuous Improvement

```yaml
weekly_review:
  - "Review component extraction velocity"
  - "Identify common issues/blockers"
  - "Update architecture based on learnings"
  - "Refine templates and checklists"

monthly_audit:
  - "Measure success metrics"
  - "Review test quality"
  - "Assess BEM compliance"
  - "Identify optimization opportunities"

quarterly_retrospective:
  - "Evaluate component library completeness"
  - "Assess maintainability improvements"
  - "Plan next phase of architecture evolution"
  - "Update handbook documentation"
```

---

## Appendix A: Quick Reference

**Essential Commands:**
```bash
# Test component extraction
bin/rake test:critical

# Build Hugo site
hugo build --minify

# Run specific component test
bin/rake test TEST=test/system/components/[component]_component_test.rb

# Visual regression baseline
# (Automatic on first test run)

# Rollback last commit
git reset --hard HEAD~1
git clean -fd
```

**Essential Patterns:**
```html
<!-- Component extraction template -->
{{ partial "components/[component].html" (dict
  "required_param" "value"
  "optional_param" "value"
) }}

<!-- BEM class structure -->
<div class="c-[component] c-[component]--[modifier]">
  <div class="c-[component]__[element]">
    Content
  </div>
</div>
```

**Essential Tests:**
```ruby
# Visual regression
assert_stable_screenshot "components/[component]", tolerance: 0.03

# Behavioral validation
assert_text "Expected user-facing text"
assert_link "Click Me", href: /path/

# Interactive states
element.hover
assert_css ".c-component:hover"
```

---

**Document Status**: Final Architecture v1.0
**Review Date**: 2025-10-06
**Next Review**: After first 5 component extractions
**Authority**: Architecture Expert - Hive Mind Swarm
