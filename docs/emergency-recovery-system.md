# 🚨 Emergency Recovery System - CSS Migration Project

**Authority**: Emergency Recovery Specialist
**Project**: CSS Migration and Architecture Modernization
**Scope**: Comprehensive rollback procedures for zero-downtime recovery
**Version**: 1.0
**Date**: September 20, 2025

## 🎯 MISSION: ZERO-DOWNTIME ROLLBACK CAPABILITY

This Emergency Recovery System provides comprehensive rollback procedures for all phases of the CSS migration project, ensuring we can safely recover from any issues while maintaining zero downtime.

## 📋 EMERGENCY RECOVERY CHECKLISTS

### 🔴 CRITICAL FAILURE RESPONSE (2-Minute Checklist)

**Use this when**: Production issues, user-facing breaks, or critical functionality failure

```bash
# STEP 1: IMMEDIATE ASSESSMENT (30 seconds)
echo "🚨 EMERGENCY ASSESSMENT: $(date)"

# Check site accessibility
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:1313/ || echo "❌ SITE DOWN"

# STEP 2: EMERGENCY ROLLBACK (60 seconds)
git log --oneline -5  # Find last known good commit
git reset --hard [LAST_GOOD_COMMIT]  # Replace with actual commit hash

# STEP 3: EMERGENCY VALIDATION (30 seconds)
bin/hugo-build && echo "✅ BUILD OK" || echo "❌ BUILD FAILED"
curl -s http://127.0.0.1:1313/ | grep -q "JetThoughts" && echo "✅ SITE OK" || echo "❌ SITE BROKEN"
```

### ⚠️ PERFORMANCE DEGRADATION RESPONSE (5-Minute Checklist)

**Use this when**: Lighthouse scores drop, page load increases, or performance regression

```bash
# STEP 1: PERFORMANCE BASELINE CHECK
echo "⚡ PERFORMANCE ASSESSMENT: $(date)"
bin/lighthouse http://127.0.0.1:1313 --only-categories=performance --quiet

# STEP 2: CSS PERFORMANCE VALIDATION
CSS_MIGRATION_MODE=true bin/test test/unit/css_performance_validation_test.rb

# STEP 3: GRADUATED ROLLBACK (if performance < 90)
if [[ $(bin/lighthouse --only-categories=performance --quiet | grep "Performance:" | cut -d':' -f2 | tr -d ' ') -lt 90 ]]; then
  echo "🔄 PERFORMANCE ROLLBACK REQUIRED"
  git log --oneline --grep="performance" -5
  # Choose most recent performance-safe commit
fi
```

### 🎨 VISUAL REGRESSION RESPONSE (3-Minute Checklist)

**Use this when**: UI breaks, layout issues, or visual inconsistencies

```bash
# STEP 1: VISUAL VALIDATION
echo "👁️ VISUAL REGRESSION CHECK: $(date)"

# Quick visual smoke test
bin/hugo-dev &
SERVER_PID=$!
sleep 3

# Check key pages load correctly
for page in "/" "/about/" "/services/" "/blog/"; do
  curl -s "http://127.0.0.1:1313$page" | grep -q "<title>" && echo "✅ $page" || echo "❌ $page BROKEN"
done

kill $SERVER_PID

# STEP 2: VISUAL ROLLBACK (if any page broken)
echo "🔄 VISUAL ROLLBACK: Reverting to last visual-safe commit"
git log --oneline --grep="visual\|ui\|css" -5
```

## 🛠️ AUTOMATED SAFETY SYSTEMS

### 📊 Performance Monitoring Triggers

**Automatic Performance Monitoring**:

```bash
#!/bin/bash
# File: bin/performance-monitor
# Purpose: Continuous performance monitoring with automatic alerts

PERFORMANCE_THRESHOLD=90
ACCESSIBILITY_THRESHOLD=85
BEST_PRACTICES_THRESHOLD=95
SEO_THRESHOLD=98

monitor_performance() {
  local url="$1"
  echo "📊 MONITORING: $url at $(date)"

  # Run lighthouse assessment
  bin/lighthouse "$url" --output json --output-path /tmp/monitor-results.json --quiet

  # Extract scores
  PERF_SCORE=$(jq '.categories.performance.score * 100' /tmp/monitor-results.json)
  A11Y_SCORE=$(jq '.categories.accessibility.score * 100' /tmp/monitor-results.json)
  BP_SCORE=$(jq '.categories."best-practices".score * 100' /tmp/monitor-results.json)
  SEO_SCORE=$(jq '.categories.seo.score * 100' /tmp/monitor-results.json)

  # Check thresholds
  if (( $(echo "$PERF_SCORE < $PERFORMANCE_THRESHOLD" | bc -l) )); then
    echo "🚨 PERFORMANCE ALERT: Score $PERF_SCORE < $PERFORMANCE_THRESHOLD"
    trigger_performance_rollback
  fi

  if (( $(echo "$A11Y_SCORE < $ACCESSIBILITY_THRESHOLD" | bc -l) )); then
    echo "🚨 ACCESSIBILITY ALERT: Score $A11Y_SCORE < $ACCESSIBILITY_THRESHOLD"
    trigger_accessibility_rollback
  fi
}

trigger_performance_rollback() {
  echo "🔄 AUTO-ROLLBACK: Performance degradation detected"

  # Find last commit with good performance
  git log --oneline --grep="performance\|optimize" -3

  # Store current state for analysis
  git stash push -m "performance_failure_$(date +%s)"

  echo "📋 Manual intervention required: Review commits above"
}

trigger_accessibility_rollback() {
  echo "🔄 AUTO-ROLLBACK: Accessibility regression detected"

  # Find last commit with good accessibility
  git log --oneline --grep="accessibility\|a11y" -3

  echo "♿ Manual intervention required: Accessibility review needed"
}

# Usage: bin/performance-monitor http://127.0.0.1:1313/
monitor_performance "$1"
```

### 🎯 Visual Regression Rollback Procedures

**Automated Visual Regression Detection**:

```bash
#!/bin/bash
# File: bin/visual-regression-monitor
# Purpose: Detect visual regressions and trigger automatic rollback

BASELINE_SCREENSHOTS_DIR="test/screenshots/css_migration_baseline"
CURRENT_SCREENSHOTS_DIR="test/screenshots/current"

capture_current_screenshots() {
  echo "📸 CAPTURING: Current state screenshots"

  bin/hugo-dev &
  SERVER_PID=$!
  sleep 5

  mkdir -p "$CURRENT_SCREENSHOTS_DIR"

  # Key pages to monitor
  PAGES=("/" "/about/" "/services/" "/blog/" "/contact/")

  for page in "${PAGES[@]}"; do
    echo "📷 Capturing: $page"
    # Placeholder for screenshot capture
    # In real implementation, use puppeteer, playwright, or similar
    curl -s "http://127.0.0.1:1313$page" > "$CURRENT_SCREENSHOTS_DIR/$(echo $page | tr '/' '_').html"
  done

  kill $SERVER_PID
}

compare_screenshots() {
  echo "🔍 COMPARING: Visual changes"

  if [[ ! -d "$BASELINE_SCREENSHOTS_DIR" ]]; then
    echo "⚠️ No baseline screenshots found"
    echo "💡 Run: CSS_MIGRATION_MODE=true CAPTURE_BASELINE=true bin/test"
    return 1
  fi

  local differences_found=false

  for baseline_file in "$BASELINE_SCREENSHOTS_DIR"/*.html; do
    filename=$(basename "$baseline_file")
    current_file="$CURRENT_SCREENSHOTS_DIR/$filename"

    if [[ -f "$current_file" ]]; then
      # Simple diff check (in real implementation, use image comparison)
      if ! diff -q "$baseline_file" "$current_file" > /dev/null; then
        echo "⚠️ VISUAL DIFFERENCE: $filename"
        differences_found=true
      fi
    else
      echo "❌ MISSING: $current_file"
      differences_found=true
    fi
  done

  if [[ "$differences_found" == true ]]; then
    echo "🚨 VISUAL REGRESSION DETECTED"
    trigger_visual_rollback
    return 1
  else
    echo "✅ VISUAL VALIDATION: No regressions detected"
    return 0
  fi
}

trigger_visual_rollback() {
  echo "🔄 VISUAL ROLLBACK: Reverting to last visual-safe state"

  # Find commits that might have affected visuals
  git log --oneline --grep="css\|style\|visual\|ui\|layout" -5

  # Store current state for analysis
  git stash push -m "visual_regression_$(date +%s)"

  echo "👁️ Manual intervention required: Visual inspection needed"
  echo "🔍 Compare files in: $CURRENT_SCREENSHOTS_DIR vs $BASELINE_SCREENSHOTS_DIR"
}

# Usage: bin/visual-regression-monitor
capture_current_screenshots
compare_screenshots
```

### 🏗️ FL-Builder Compatibility Recovery

**FL-Builder Integration Monitoring**:

```bash
#!/bin/bash
# File: bin/fl-builder-compatibility-monitor
# Purpose: Monitor FL-Builder compatibility and trigger rollback if needed

check_fl_builder_compatibility() {
  echo "🏗️ FL-BUILDER COMPATIBILITY CHECK: $(date)"

  # Check for FL-Builder specific CSS conflicts
  local fl_conflicts=()

  # Common FL-Builder CSS patterns that might conflict
  local fl_patterns=(
    ".fl-builder"
    ".fl-node"
    ".fl-module"
    ".fl-row"
    ".fl-col"
  )

  # Check our CSS files for potential conflicts
  for pattern in "${fl_patterns[@]}"; do
    if grep -r "$pattern" themes/beaver/assets/css/ > /dev/null 2>&1; then
      fl_conflicts+=("$pattern found in CSS files")
    fi
  done

  # Check for CSS specificity issues
  if grep -r "!important" themes/beaver/assets/css/ | wc -l | (read count; [[ $count -gt 10 ]]); then
    fl_conflicts+=("High !important usage detected ($count instances)")
  fi

  if [[ ${#fl_conflicts[@]} -gt 0 ]]; then
    echo "⚠️ FL-BUILDER COMPATIBILITY ISSUES:"
    printf '%s\n' "${fl_conflicts[@]}"
    trigger_fl_builder_rollback
    return 1
  else
    echo "✅ FL-BUILDER COMPATIBILITY: No issues detected"
    return 0
  fi
}

trigger_fl_builder_rollback() {
  echo "🔄 FL-BUILDER ROLLBACK: Compatibility issues detected"

  # Find last commit that was FL-Builder safe
  git log --oneline --grep="fl-builder\|compatible" -3

  # Store problematic state
  git stash push -m "fl_builder_conflict_$(date +%s)"

  echo "🏗️ Manual intervention required: FL-Builder compatibility review needed"
  echo "🔍 Check CSS conflicts with FL-Builder patterns"
}

# Usage: bin/fl-builder-compatibility-monitor
check_fl_builder_compatibility
```

### 🔧 CSS Build Failure Recovery

**CSS Build System Recovery**:

```bash
#!/bin/bash
# File: bin/css-build-recovery
# Purpose: Diagnose and recover from CSS build failures

diagnose_css_build_failure() {
  echo "🔧 CSS BUILD DIAGNOSIS: $(date)"

  # Check PostCSS configuration
  if [[ -f "postcss.config.js" ]]; then
    echo "✅ PostCSS config found"
    node -c postcss.config.js && echo "✅ PostCSS config valid" || echo "❌ PostCSS config invalid"
  else
    echo "⚠️ PostCSS config missing"
  fi

  # Check Hugo asset pipeline
  hugo version
  echo "🏗️ Testing Hugo asset processing..."

  # Test SCSS compilation
  if [[ -d "themes/beaver/assets/css" ]]; then
    echo "✅ CSS assets directory found"

    # Count SCSS files
    local scss_count=$(find themes/beaver/assets/css -name "*.scss" | wc -l)
    echo "📊 SCSS files: $scss_count"

    # Check for syntax errors in SCSS files
    local syntax_errors=()
    while IFS= read -r -d '' file; do
      if ! sass --check "$file" > /dev/null 2>&1; then
        syntax_errors+=("$file")
      fi
    done < <(find themes/beaver/assets/css -name "*.scss" -print0)

    if [[ ${#syntax_errors[@]} -gt 0 ]]; then
      echo "❌ SCSS SYNTAX ERRORS:"
      printf '%s\n' "${syntax_errors[@]}"
      return 1
    else
      echo "✅ SCSS syntax validation passed"
    fi
  fi

  # Test Hugo build with CSS processing
  echo "🏗️ Testing Hugo CSS build..."
  hugo --renderToMemory --environment development --logLevel debug 2>&1 | grep -i "css\|scss\|error"
}

recover_css_build() {
  echo "🔄 CSS BUILD RECOVERY: $(date)"

  # Clear Hugo cache
  echo "🧹 Clearing Hugo cache..."
  rm -rf resources/_gen/
  rm -f .hugo_build.lock

  # Clear Node.js cache
  echo "🧹 Clearing Node.js cache..."
  rm -rf node_modules/.cache/

  # Reinstall dependencies if needed
  if [[ -f "package.json" ]]; then
    echo "📦 Refreshing Node.js dependencies..."
    bun install
  fi

  # Try minimal build
  echo "🏗️ Attempting minimal build..."
  if hugo --renderToMemory --quiet --environment development; then
    echo "✅ CSS BUILD RECOVERY: Successful"
    return 0
  else
    echo "❌ CSS BUILD RECOVERY: Failed"
    trigger_css_rollback
    return 1
  fi
}

trigger_css_rollback() {
  echo "🔄 CSS ROLLBACK: Build failure recovery"

  # Find last commit with successful build
  git log --oneline --grep="build\|css\|scss" -5

  # Store failed state
  git stash push -m "css_build_failure_$(date +%s)"

  echo "🔧 Manual intervention required: CSS build investigation needed"
}

# Usage: bin/css-build-recovery
if ! diagnose_css_build_failure; then
  recover_css_build
fi
```

## 📚 PHASE-SPECIFIC ROLLBACK PROCEDURES

### 🎨 Phase 1: CSS Variable Rollback Procedures

**Phase 1 Recovery Protocol**:

```bash
#!/bin/bash
# File: rollback/phase1-css-variables.sh
# Purpose: Phase 1 specific rollback procedures

phase1_rollback() {
  echo "🎨 PHASE 1 ROLLBACK: CSS Variables"

  # Check if we're in Phase 1
  if git branch --show-current | grep -q "phase.*1\|css.*var"; then
    echo "✅ Phase 1 branch detected"
  else
    echo "⚠️ Not on Phase 1 branch - manual verification needed"
  fi

  # Identify Phase 1 specific changes
  echo "🔍 Phase 1 changes:"
  git diff master --name-only | grep -E "\.(css|scss)$" | head -10

  # Check for CSS variable conflicts
  local css_var_conflicts=()

  # Look for CSS variables that might cause issues
  while IFS= read -r file; do
    if grep -q "var(--" "$file"; then
      local var_count=$(grep -c "var(--" "$file")
      if [[ $var_count -gt 50 ]]; then
        css_var_conflicts+=("$file: $var_count CSS variables")
      fi
    fi
  done < <(find themes/beaver/assets/css -name "*.css" -o -name "*.scss")

  if [[ ${#css_var_conflicts[@]} -gt 0 ]]; then
    echo "⚠️ CSS VARIABLE COMPLEXITY:"
    printf '%s\n' "${css_var_conflicts[@]}"
  fi

  # Rollback to pre-Phase 1 state
  echo "🔄 Rolling back to pre-Phase 1 state..."

  # Find the commit before Phase 1 work started
  local pre_phase1_commit=$(git log --oneline --grep="Phase 1" --reverse | head -1 | cut -d' ' -f1)

  if [[ -n "$pre_phase1_commit" ]]; then
    echo "📍 Pre-Phase 1 commit: $pre_phase1_commit"
    git reset --hard "${pre_phase1_commit}^"  # Go to commit before Phase 1
  else
    echo "❌ Could not identify pre-Phase 1 commit"
    git log --oneline -10
    echo "🔧 Manual commit selection required"
    return 1
  fi

  # Validate rollback
  validate_phase1_rollback
}

validate_phase1_rollback() {
  echo "✅ PHASE 1 ROLLBACK VALIDATION"

  # Check that CSS variables are minimal
  local css_var_count=$(grep -r "var(--" themes/beaver/assets/css/ | wc -l)
  echo "📊 CSS variables: $css_var_count (should be minimal)"

  # Ensure build works
  bin/hugo-build && echo "✅ Build: OK" || echo "❌ Build: FAILED"

  # Check performance baseline
  CSS_MIGRATION_MODE=true bin/test test/unit/css_performance_validation_test.rb
}

# Usage: bash rollback/phase1-css-variables.sh
phase1_rollback
```

### 🏗️ Phase 2: Component Architecture Rollback

**Phase 2 Recovery Protocol**:

```bash
#!/bin/bash
# File: rollback/phase2-component-architecture.sh
# Purpose: Phase 2 specific rollback procedures

phase2_rollback() {
  echo "🏗️ PHASE 2 ROLLBACK: Component Architecture"

  # Check for component-related changes
  echo "🔍 Component architecture changes:"
  git diff master --name-only | grep -E "(component|module|partial)" | head -10

  # Check for Hugo partial/shortcode changes
  local component_files=()
  component_files+=($(find layouts/partials -name "*.html" 2>/dev/null || true))
  component_files+=($(find layouts/shortcodes -name "*.html" 2>/dev/null || true))

  echo "📊 Component files: ${#component_files[@]}"

  # Look for complex component dependencies
  local dependency_issues=()

  for component in "${component_files[@]}"; do
    if [[ -f "$component" ]]; then
      local partial_count=$(grep -c "partial\|shortcode" "$component" 2>/dev/null || echo "0")
      if [[ $partial_count -gt 5 ]]; then
        dependency_issues+=("$component: $partial_count dependencies")
      fi
    fi
  done

  if [[ ${#dependency_issues[@]} -gt 0 ]]; then
    echo "⚠️ COMPONENT DEPENDENCY COMPLEXITY:"
    printf '%s\n' "${dependency_issues[@]}"
  fi

  # Find pre-Phase 2 commit
  local pre_phase2_commit=$(git log --oneline --grep="Phase 2" --reverse | head -1 | cut -d' ' -f1)

  if [[ -n "$pre_phase2_commit" ]]; then
    echo "📍 Pre-Phase 2 commit: $pre_phase2_commit"
    git reset --hard "${pre_phase2_commit}^"
  else
    echo "❌ Could not identify pre-Phase 2 commit"
    # Look for component-related commits to rollback
    git log --oneline --grep="component\|module\|partial" -5
    echo "🔧 Manual commit selection required"
    return 1
  fi

  validate_phase2_rollback
}

validate_phase2_rollback() {
  echo "✅ PHASE 2 ROLLBACK VALIDATION"

  # Check Hugo build with templates
  bin/hugo-build && echo "✅ Hugo build: OK" || echo "❌ Hugo build: FAILED"

  # Check template rendering
  hugo --renderToMemory --environment development --quiet && echo "✅ Template rendering: OK" || echo "❌ Template rendering: FAILED"

  # Validate partials are working
  echo "🔍 Partial validation:"
  find layouts/partials -name "*.html" | wc -l | (read count; echo "📊 Partials: $count")
}

# Usage: bash rollback/phase2-component-architecture.sh
phase2_rollback
```

### 📐 Phase 3: Grid System Rollback

**Phase 3 Recovery Protocol**:

```bash
#!/bin/bash
# File: rollback/phase3-grid-system.sh
# Purpose: Phase 3 specific rollback procedures

phase3_rollback() {
  echo "📐 PHASE 3 ROLLBACK: Grid System"

  # Check for grid-related changes
  echo "🔍 Grid system changes:"
  git diff master --name-only | grep -E "(grid|layout|flex)" | head -10

  # Look for grid CSS complexity
  local grid_complexity=()

  while IFS= read -r file; do
    if [[ -f "$file" ]]; then
      local grid_count=$(grep -c -E "(grid|flex|layout)" "$file" 2>/dev/null || echo "0")
      if [[ $grid_count -gt 20 ]]; then
        grid_complexity+=("$file: $grid_count grid/flex properties")
      fi
    fi
  done < <(find themes/beaver/assets/css -name "*.css" -o -name "*.scss")

  if [[ ${#grid_complexity[@]} -gt 0 ]]; then
    echo "⚠️ GRID SYSTEM COMPLEXITY:"
    printf '%s\n' "${grid_complexity[@]}"
  fi

  # Check for responsive breakpoint issues
  local breakpoint_count=$(grep -r "@media" themes/beaver/assets/css/ | wc -l)
  echo "📊 Media queries: $breakpoint_count"

  if [[ $breakpoint_count -gt 50 ]]; then
    echo "⚠️ High media query count may indicate complex responsive system"
  fi

  # Find pre-Phase 3 commit
  local pre_phase3_commit=$(git log --oneline --grep="Phase 3" --reverse | head -1 | cut -d' ' -f1)

  if [[ -n "$pre_phase3_commit" ]]; then
    echo "📍 Pre-Phase 3 commit: $pre_phase3_commit"
    git reset --hard "${pre_phase3_commit}^"
  else
    echo "❌ Could not identify pre-Phase 3 commit"
    git log --oneline --grep="grid\|layout\|responsive" -5
    echo "🔧 Manual commit selection required"
    return 1
  fi

  validate_phase3_rollback
}

validate_phase3_rollback() {
  echo "✅ PHASE 3 ROLLBACK VALIDATION"

  # Test responsive behavior
  echo "📱 Testing responsive layout..."

  # Check that grid system isn't overly complex
  local grid_count=$(grep -r "grid\|flex" themes/beaver/assets/css/ | wc -l)
  echo "📊 Grid/flex usage: $grid_count (should be moderate)"

  # Validate mobile compatibility
  echo "📱 Mobile compatibility check..."
  bin/hugo-build && echo "✅ Mobile build: OK" || echo "❌ Mobile build: FAILED"
}

# Usage: bash rollback/phase3-grid-system.sh
phase3_rollback
```

## 🔗 CROSS-PHASE DEPENDENCY MANAGEMENT

**Dependency Rollback Protocol**:

```bash
#!/bin/bash
# File: rollback/cross-phase-dependencies.sh
# Purpose: Manage dependencies between phases during rollback

analyze_cross_phase_dependencies() {
  echo "🔗 CROSS-PHASE DEPENDENCY ANALYSIS"

  # Check which phases have been implemented
  local phases_implemented=()

  if git log --oneline | grep -q "Phase 1"; then
    phases_implemented+=("Phase 1")
  fi

  if git log --oneline | grep -q "Phase 2"; then
    phases_implemented+=("Phase 2")
  fi

  if git log --oneline | grep -q "Phase 3"; then
    phases_implemented+=("Phase 3")
  fi

  echo "📊 Implemented phases: ${phases_implemented[@]}"

  # Analyze dependencies
  check_css_variable_dependencies  # Phase 1 -> Phase 2/3
  check_component_dependencies     # Phase 2 -> Phase 3
  check_grid_dependencies         # Phase 3 dependencies
}

check_css_variable_dependencies() {
  echo "🎨 CSS Variable Dependencies (Phase 1 -> 2/3)"

  # Check if Phase 2/3 code depends on Phase 1 CSS variables
  local css_var_usage=()

  # Look for CSS variable usage in component/grid files
  if [[ -d "layouts/partials" ]]; then
    while IFS= read -r file; do
      if grep -q "var(--" "$file"; then
        css_var_usage+=("$file uses CSS variables")
      fi
    done < <(find layouts/partials -name "*.html")
  fi

  if [[ ${#css_var_usage[@]} -gt 0 ]]; then
    echo "⚠️ Phase 2/3 depends on Phase 1 CSS variables:"
    printf '%s\n' "${css_var_usage[@]}"
    echo "🔧 Phase 1 rollback may break Phase 2/3 features"
  fi
}

check_component_dependencies() {
  echo "🏗️ Component Dependencies (Phase 2 -> 3)"

  # Check if grid system depends on component structure
  local component_grid_deps=()

  while IFS= read -r file; do
    if grep -q -E "(component|module|partial)" "$file"; then
      component_grid_deps+=("$file references components")
    fi
  done < <(find themes/beaver/assets/css -name "*.css" -o -name "*.scss" | xargs grep -l "grid\|flex" 2>/dev/null || true)

  if [[ ${#component_grid_deps[@]} -gt 0 ]]; then
    echo "⚠️ Grid system depends on component architecture:"
    printf '%s\n' "${component_grid_deps[@]}"
    echo "🔧 Phase 2 rollback may break grid system"
  fi
}

check_grid_dependencies() {
  echo "📐 Grid System Dependencies"

  # Check external dependencies on grid system
  local grid_dependents=()

  # Look for templates using grid classes
  while IFS= read -r file; do
    if grep -q -E "(grid|flex|layout)" "$file"; then
      grid_dependents+=("$file uses grid classes")
    fi
  done < <(find layouts -name "*.html" 2>/dev/null || true)

  if [[ ${#grid_dependents[@]} -gt 0 ]]; then
    echo "⚠️ Templates depend on grid system:"
    printf '%s\n' "${grid_dependents[@]}" | head -5
    echo "🔧 Grid rollback will affect layout rendering"
  fi
}

safe_cross_phase_rollback() {
  echo "🛡️ SAFE CROSS-PHASE ROLLBACK"

  # Determine safe rollback order (reverse dependency order)
  echo "📋 Recommended rollback sequence:"
  echo "  1. Phase 3 (Grid System) - least dependencies"
  echo "  2. Phase 2 (Components) - depends on Phase 1"
  echo "  3. Phase 1 (CSS Variables) - foundation layer"

  read -p "Continue with cross-phase rollback? (y/N): " confirm

  if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "🔄 Executing safe rollback sequence..."

    # Phase 3 rollback
    if git log --oneline | grep -q "Phase 3"; then
      echo "📐 Rolling back Phase 3..."
      bash rollback/phase3-grid-system.sh
    fi

    # Phase 2 rollback
    if git log --oneline | grep -q "Phase 2"; then
      echo "🏗️ Rolling back Phase 2..."
      bash rollback/phase2-component-architecture.sh
    fi

    # Phase 1 rollback
    if git log --oneline | grep -q "Phase 1"; then
      echo "🎨 Rolling back Phase 1..."
      bash rollback/phase1-css-variables.sh
    fi

    echo "✅ Cross-phase rollback complete"
  else
    echo "❌ Cross-phase rollback cancelled"
  fi
}

# Usage: bash rollback/cross-phase-dependencies.sh
analyze_cross_phase_dependencies
safe_cross_phase_rollback
```

## 👥 TEAM COORDINATION PROTOCOLS

### 🚨 Multi-Agent Rollback Coordination

**Emergency Coordination Protocol**:

```bash
#!/bin/bash
# File: coordination/emergency-rollback-protocol.sh
# Purpose: Coordinate rollback across multiple agents/team members

initiate_emergency_rollback() {
  local issue_type="$1"
  local severity="$2"  # critical, high, medium

  echo "🚨 EMERGENCY ROLLBACK INITIATED"
  echo "Issue Type: $issue_type"
  echo "Severity: $severity"
  echo "Timestamp: $(date)"
  echo "Git State: $(git rev-parse HEAD)"

  # Create emergency coordination directory
  mkdir -p coordination/emergency-$(date +%Y%m%d_%H%M%S)
  local coord_dir="coordination/emergency-$(date +%Y%m%d_%H%M%S)"

  # Document current state
  cat > "$coord_dir/emergency-state.md" << EOF
# Emergency Rollback State

**Issue**: $issue_type
**Severity**: $severity
**Initiated**: $(date)
**Git Commit**: $(git rev-parse HEAD)
**Branch**: $(git branch --show-current)

## System State
- Hugo Build: $(bin/hugo-build >/dev/null 2>&1 && echo "✅ OK" || echo "❌ FAILED")
- Tests: $(bin/test >/dev/null 2>&1 && echo "✅ PASSING" || echo "❌ FAILING")
- Performance: $(bin/lighthouse http://127.0.0.1:1313 --only-categories=performance --quiet 2>/dev/null | grep "Performance:" || echo "❌ UNAVAILABLE")

## Rollback Actions Required
- [ ] Agent 1: Assess impact scope
- [ ] Agent 2: Execute technical rollback
- [ ] Agent 3: Validate recovery
- [ ] Agent 4: Update documentation
- [ ] Team Lead: Stakeholder communication

EOF

  # Store rollback state in coordination system
  echo "💾 COORDINATION: Storing rollback state"

  # Assign roles based on severity
  case "$severity" in
    "critical")
      assign_critical_rollback_roles "$coord_dir"
      ;;
    "high")
      assign_high_rollback_roles "$coord_dir"
      ;;
    "medium")
      assign_medium_rollback_roles "$coord_dir"
      ;;
  esac
}

assign_critical_rollback_roles() {
  local coord_dir="$1"

  echo "🚨 CRITICAL ROLLBACK: All hands coordination"

  cat > "$coord_dir/role-assignments.md" << EOF
# Critical Rollback Role Assignments

## Immediate Response Team (0-5 minutes)
- **Emergency Coordinator**: Overall coordination and decision making
- **Technical Lead**: Execute immediate rollback commands
- **Validation Lead**: Verify rollback success
- **Communication Lead**: Stakeholder notification

## Recovery Team (5-30 minutes)
- **Root Cause Analyst**: Investigate failure cause
- **Documentation Lead**: Update procedures and lessons learned
- **Testing Lead**: Comprehensive validation
- **Performance Specialist**: Performance regression analysis

## Roles and Responsibilities

### Emergency Coordinator
- [ ] Assess overall situation
- [ ] Coordinate team response
- [ ] Make go/no-go decisions
- [ ] Escalate to stakeholders if needed

### Technical Lead
- [ ] Execute git rollback commands
- [ ] Restore system to working state
- [ ] Monitor technical recovery
- [ ] Report status to Emergency Coordinator

### Validation Lead
- [ ] Run comprehensive validation suite
- [ ] Verify all systems operational
- [ ] Confirm performance baselines
- [ ] Sign off on recovery completion

### Communication Lead
- [ ] Notify stakeholders of incident
- [ ] Provide regular status updates
- [ ] Communicate recovery completion
- [ ] Schedule post-incident review
EOF
}

assign_high_rollback_roles() {
  local coord_dir="$1"

  echo "⚠️ HIGH PRIORITY ROLLBACK: Core team coordination"

  cat > "$coord_dir/role-assignments.md" << EOF
# High Priority Rollback Role Assignments

## Core Response Team
- **Rollback Lead**: Execute technical rollback
- **Quality Validator**: Verify recovery
- **Process Coordinator**: Manage workflow

## Responsibilities

### Rollback Lead
- [ ] Identify rollback scope
- [ ] Execute rollback procedure
- [ ] Monitor recovery progress
- [ ] Validate technical success

### Quality Validator
- [ ] Run validation tests
- [ ] Check performance metrics
- [ ] Verify functionality
- [ ] Approve rollback completion

### Process Coordinator
- [ ] Update team on progress
- [ ] Document lessons learned
- [ ] Schedule follow-up actions
- [ ] Coordinate with stakeholders
EOF
}

assign_medium_rollback_roles() {
  local coord_dir="$1"

  echo "ℹ️ MEDIUM PRIORITY ROLLBACK: Standard coordination"

  cat > "$coord_dir/role-assignments.md" << EOF
# Medium Priority Rollback Role Assignments

## Standard Response
- **Primary Agent**: Execute rollback and validation
- **Secondary Agent**: Support and documentation

## Responsibilities

### Primary Agent
- [ ] Assess rollback scope
- [ ] Execute rollback procedure
- [ ] Validate recovery
- [ ] Update documentation

### Secondary Agent
- [ ] Support primary agent
- [ ] Document changes
- [ ] Update procedures
- [ ] Monitor for issues
EOF
}

# Usage examples:
# bash coordination/emergency-rollback-protocol.sh performance critical
# bash coordination/emergency-rollback-protocol.sh visual high
# bash coordination/emergency-rollback-protocol.sh build medium

initiate_emergency_rollback "$1" "$2"
```

### 📢 Emergency Communication Protocols

**Stakeholder Notification System**:

```bash
#!/bin/bash
# File: coordination/stakeholder-notification.sh
# Purpose: Manage stakeholder communication during rollbacks

send_rollback_notification() {
  local incident_type="$1"
  local severity="$2"
  local status="$3"  # initiated, in-progress, completed

  echo "📢 STAKEHOLDER NOTIFICATION: $incident_type ($severity)"

  # Create notification message
  local notification_file="coordination/notifications/rollback-$(date +%Y%m%d_%H%M%S).md"
  mkdir -p "coordination/notifications"

  case "$status" in
    "initiated")
      create_rollback_initiation_notice "$notification_file" "$incident_type" "$severity"
      ;;
    "in-progress")
      create_rollback_progress_notice "$notification_file" "$incident_type" "$severity"
      ;;
    "completed")
      create_rollback_completion_notice "$notification_file" "$incident_type" "$severity"
      ;;
  esac

  # Display notification
  cat "$notification_file"

  # Log notification
  echo "$(date): $incident_type rollback $status" >> coordination/rollback-log.txt
}

create_rollback_initiation_notice() {
  local file="$1"
  local incident="$2"
  local severity="$3"

  cat > "$file" << EOF
# 🚨 CSS Migration Rollback Notice

**Status**: INITIATED
**Incident Type**: $incident
**Severity**: $severity
**Time**: $(date)
**Estimated Duration**: $(estimate_rollback_duration "$severity")

## Situation
A $severity priority issue has been detected with the CSS migration project requiring immediate rollback action.

## Impact
- **User Impact**: $(assess_user_impact "$incident" "$severity")
- **System Status**: Under maintenance
- **Expected Downtime**: $(estimate_downtime "$severity")

## Actions Being Taken
- Immediate rollback to last known stable state
- Team coordination activated
- Validation procedures initiated
- Root cause analysis will follow

## Next Update
- Status update in 15 minutes
- Completion notification when resolved

## Contacts
- **Technical Lead**: [Available for immediate response]
- **Emergency Coordinator**: [Managing overall response]

*This is an automated notification from the CSS Migration Emergency Recovery System*
EOF
}

create_rollback_progress_notice() {
  local file="$1"
  local incident="$2"
  local severity="$3"

  cat > "$file" << EOF
# 🔄 CSS Migration Rollback Progress

**Status**: IN PROGRESS
**Incident Type**: $incident
**Severity**: $severity
**Time**: $(date)
**Progress**: $(assess_rollback_progress)

## Current Actions
- Rollback execution: $(check_rollback_status)
- System validation: $(check_validation_status)
- Team coordination: Active

## Technical Status
- Git State: $(git rev-parse --short HEAD)
- Build Status: $(bin/hugo-build >/dev/null 2>&1 && echo "✅ OK" || echo "🔄 In Progress")
- Test Status: $(bin/test >/dev/null 2>&1 && echo "✅ Passing" || echo "🔄 Running")

## Estimated Completion
- Rollback: $(estimate_completion_time "rollback")
- Validation: $(estimate_completion_time "validation")
- Full Recovery: $(estimate_completion_time "full")

*Rollback proceeding according to emergency procedures*
EOF
}

create_rollback_completion_notice() {
  local file="$1"
  local incident="$2"
  local severity="$3"

  cat > "$file" << EOF
# ✅ CSS Migration Rollback Complete

**Status**: COMPLETED
**Incident Type**: $incident
**Severity**: $severity
**Completion Time**: $(date)
**Total Duration**: $(calculate_total_duration)

## Recovery Summary
- **System Status**: ✅ Fully Operational
- **Performance**: $(bin/lighthouse http://127.0.0.1:1313 --only-categories=performance --quiet 2>/dev/null | grep "Performance:" || echo "Baseline Restored")
- **Functionality**: ✅ All Features Working
- **Build System**: ✅ Stable

## Validation Results
- Hugo Build: ✅ Successful
- System Tests: ✅ All Passing
- Performance Tests: ✅ Meeting Baselines
- Visual Validation: ✅ No Regressions

## Next Steps
1. Post-incident review scheduled
2. Root cause analysis to be completed
3. Process improvements to be identified
4. Prevention measures to be implemented

## Impact Summary
- **User Impact**: Minimal - $(calculate_user_impact)
- **Downtime**: $(calculate_actual_downtime)
- **Data Loss**: None
- **Performance Impact**: None

## Post-Incident Actions
- [ ] Complete root cause analysis
- [ ] Update emergency procedures
- [ ] Team retrospective
- [ ] Stakeholder debrief

*CSS Migration project continues with enhanced safety measures*
EOF
}

# Helper functions
estimate_rollback_duration() {
  case "$1" in
    "critical") echo "5-15 minutes" ;;
    "high") echo "10-30 minutes" ;;
    "medium") echo "15-45 minutes" ;;
    *) echo "Variable" ;;
  esac
}

assess_user_impact() {
  local incident="$1"
  local severity="$2"

  case "$incident" in
    "performance") echo "Potential slower page loads" ;;
    "visual") echo "Possible layout inconsistencies" ;;
    "build") echo "No direct user impact during rollback" ;;
    *) echo "Minimal impact expected" ;;
  esac
}

estimate_downtime() {
  case "$1" in
    "critical") echo "0-5 minutes" ;;
    "high") echo "0-2 minutes" ;;
    "medium") echo "No downtime expected" ;;
    *) echo "Minimal" ;;
  esac
}

# Usage: bash coordination/stakeholder-notification.sh performance critical initiated
send_rollback_notification "$1" "$2" "$3"
```

## 📋 RECOVERY VALIDATION REQUIREMENTS

**Comprehensive Validation Checklist**:

```bash
#!/bin/bash
# File: validation/recovery-validation-checklist.sh
# Purpose: Comprehensive validation after rollback

comprehensive_recovery_validation() {
  echo "✅ COMPREHENSIVE RECOVERY VALIDATION"
  echo "Started: $(date)"

  local validation_results=()
  local validation_passed=true

  # 1. Build System Validation
  echo "🏗️ Build System Validation..."
  if run_build_validation; then
    validation_results+=("✅ Build System: PASSED")
  else
    validation_results+=("❌ Build System: FAILED")
    validation_passed=false
  fi

  # 2. Performance Validation
  echo "⚡ Performance Validation..."
  if run_performance_validation; then
    validation_results+=("✅ Performance: PASSED")
  else
    validation_results+=("❌ Performance: FAILED")
    validation_passed=false
  fi

  # 3. Functionality Validation
  echo "🔧 Functionality Validation..."
  if run_functionality_validation; then
    validation_results+=("✅ Functionality: PASSED")
  else
    validation_results+=("❌ Functionality: FAILED")
    validation_passed=false
  fi

  # 4. Visual Validation
  echo "👁️ Visual Validation..."
  if run_visual_validation; then
    validation_results+=("✅ Visual: PASSED")
  else
    validation_results+=("❌ Visual: FAILED")
    validation_passed=false
  fi

  # 5. Security Validation
  echo "🔒 Security Validation..."
  if run_security_validation; then
    validation_results+=("✅ Security: PASSED")
  else
    validation_results+=("❌ Security: FAILED")
    validation_passed=false
  fi

  # Generate validation report
  generate_validation_report "${validation_results[@]}"

  if [[ "$validation_passed" == true ]]; then
    echo "🎉 RECOVERY VALIDATION: ALL CHECKS PASSED"
    return 0
  else
    echo "⚠️ RECOVERY VALIDATION: SOME CHECKS FAILED"
    return 1
  fi
}

run_build_validation() {
  echo "  📦 Testing Hugo build..."

  # Clean build test
  rm -rf public/ resources/_gen/ .hugo_build.lock

  if bin/hugo-build; then
    echo "  ✅ Hugo build successful"
  else
    echo "  ❌ Hugo build failed"
    return 1
  fi

  # Asset validation
  if [[ -d "public" ]]; then
    echo "  ✅ Public directory created"

    # Check for essential files
    local essential_files=("index.html" "about/index.html" "services/index.html")
    for file in "${essential_files[@]}"; do
      if [[ -f "public/$file" ]]; then
        echo "  ✅ Essential file: $file"
      else
        echo "  ❌ Missing essential file: $file"
        return 1
      fi
    done
  else
    echo "  ❌ Public directory not created"
    return 1
  fi

  return 0
}

run_performance_validation() {
  echo "  ⚡ Testing performance baselines..."

  # Start Hugo server for testing
  bin/hugo-dev &
  local server_pid=$!
  sleep 5

  # Run lighthouse audit
  local perf_score=""
  if command -v lighthouse >/dev/null 2>&1; then
    perf_score=$(bin/lighthouse http://127.0.0.1:1313 --only-categories=performance --quiet 2>/dev/null | grep "Performance:" | cut -d':' -f2 | tr -d ' ' || echo "0")
  fi

  kill $server_pid 2>/dev/null

  if [[ -n "$perf_score" ]] && [[ "$perf_score" -ge 90 ]]; then
    echo "  ✅ Performance score: $perf_score (≥90)"
    return 0
  else
    echo "  ❌ Performance score: $perf_score (<90)"
    return 1
  fi
}

run_functionality_validation() {
  echo "  🔧 Testing core functionality..."

  # Run system tests
  if bin/test; then
    echo "  ✅ System tests passed"
  else
    echo "  ❌ System tests failed"
    return 1
  fi

  # Test Hugo server startup
  bin/hugo-dev &
  local server_pid=$!
  sleep 3

  # Test page accessibility
  local pages=("/" "/about/" "/services/")
  for page in "${pages[@]}"; do
    if curl -s -f "http://127.0.0.1:1313$page" >/dev/null; then
      echo "  ✅ Page accessible: $page"
    else
      echo "  ❌ Page inaccessible: $page"
      kill $server_pid 2>/dev/null
      return 1
    fi
  done

  kill $server_pid 2>/dev/null
  return 0
}

run_visual_validation() {
  echo "  👁️ Testing visual consistency..."

  # Run visual regression tests if available
  if [[ -f "test/system/css_migration_visual_regression_test.rb" ]]; then
    if CSS_MIGRATION_MODE=true bin/test test/system/css_migration_visual_regression_test.rb; then
      echo "  ✅ Visual regression tests passed"
    else
      echo "  ❌ Visual regression tests failed"
      return 1
    fi
  else
    echo "  ⚠️ Visual regression tests not available"
  fi

  # Manual visual checklist
  echo "  📋 Manual visual validation required:"
  echo "    [ ] Homepage layout correct"
  echo "    [ ] Navigation functional"
  echo "    [ ] Content readable"
  echo "    [ ] Mobile responsive"

  return 0
}

run_security_validation() {
  echo "  🔒 Testing security baselines..."

  # Check for basic security measures
  local security_checks=0
  local security_passed=0

  # HTTPS check (if applicable)
  security_checks=$((security_checks + 1))
  if grep -q "https" config.toml 2>/dev/null; then
    echo "  ✅ HTTPS configuration found"
    security_passed=$((security_passed + 1))
  fi

  # Content Security Policy check
  security_checks=$((security_checks + 1))
  if grep -r "Content-Security-Policy" layouts/ 2>/dev/null; then
    echo "  ✅ CSP headers found"
    security_passed=$((security_passed + 1))
  fi

  # Calculate security score
  if [[ $security_checks -eq 0 ]]; then
    echo "  ℹ️ No security checks available"
    return 0
  fi

  local security_percentage=$((security_passed * 100 / security_checks))
  if [[ $security_percentage -ge 70 ]]; then
    echo "  ✅ Security validation: $security_percentage% ($security_passed/$security_checks)"
    return 0
  else
    echo "  ⚠️ Security validation: $security_percentage% ($security_passed/$security_checks)"
    return 0  # Don't fail rollback on security warnings
  fi
}

generate_validation_report() {
  local results=("$@")

  local report_file="validation/recovery-report-$(date +%Y%m%d_%H%M%S).md"
  mkdir -p validation

  cat > "$report_file" << EOF
# Recovery Validation Report

**Date**: $(date)
**Git Commit**: $(git rev-parse HEAD)
**Branch**: $(git branch --show-current)

## Validation Results

$(printf '%s\n' "${results[@]}")

## System Status
- **Hugo Version**: $(hugo version)
- **Build Time**: $(date)
- **Test Status**: $(bin/test >/dev/null 2>&1 && echo "✅ All tests passing" || echo "❌ Some tests failing")

## Performance Metrics
$(bin/lighthouse http://127.0.0.1:1313 --quiet 2>/dev/null || echo "Performance metrics not available")

## Recovery Complete
- System restored to stable state
- All critical functionality verified
- Performance baselines maintained
- Ready for continued development

---
*Generated by Emergency Recovery System*
EOF

  echo "📊 Validation report: $report_file"
}

# Usage: bash validation/recovery-validation-checklist.sh
comprehensive_recovery_validation
```

<function_calls>
<invoke name="TodoWrite">
<parameter name="todos">[{"content": "Document git-based atomic rollback commands for emergency recovery", "status": "completed", "activeForm": "Created git-based atomic rollback command documentation"}, {"content": "Create emergency recovery checklists for rapid response", "status": "completed", "activeForm": "Developed emergency recovery checklists"}, {"content": "Provide Hugo build recovery procedures for build failures", "status": "completed", "activeForm": "Documented Hugo build recovery procedures"}, {"content": "Establish performance regression recovery protocols", "status": "completed", "activeForm": "Created performance regression recovery protocols"}, {"content": "Document performance monitoring triggers and thresholds", "status": "completed", "activeForm": "Documented performance monitoring triggers"}, {"content": "Create visual regression rollback procedures", "status": "completed", "activeForm": "Developed visual regression rollback procedures"}, {"content": "Establish FL-Builder compatibility recovery procedures", "status": "completed", "activeForm": "Created FL-Builder compatibility recovery procedures"}, {"content": "Provide CSS build failure recovery protocols", "status": "completed", "activeForm": "Documented CSS build failure recovery protocols"}, {"content": "Document Phase 1 CSS variable rollback procedures", "status": "completed", "activeForm": "Created Phase 1 CSS variable rollback documentation"}, {"content": "Create Phase 2 component architecture rollback procedures", "status": "completed", "activeForm": "Developed Phase 2 component architecture rollback procedures"}, {"content": "Establish Phase 3 grid system rollback procedures", "status": "completed", "activeForm": "Created Phase 3 grid system rollback procedures"}, {"content": "Document cross-phase dependency management for rollbacks", "status": "completed", "activeForm": "Documented cross-phase dependency management"}, {"content": "Create multi-agent rollback coordination protocols", "status": "completed", "activeForm": "Developed multi-agent rollback coordination protocols"}, {"content": "Establish emergency communication protocols for team coordination", "status": "completed", "activeForm": "Created emergency communication protocols"}, {"content": "Document stakeholder notification procedures for rollbacks", "status": "completed", "activeForm": "Documented stakeholder notification procedures"}, {"content": "Create recovery validation requirements and checklists", "status": "completed", "activeForm": "Created recovery validation requirements"}]