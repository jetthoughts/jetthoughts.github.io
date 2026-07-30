# CSS Processing Visual Regression Testing Protocol

## Purpose

This document defines the MANDATORY testing protocol for CSS processing changes with ZERO visual regression tolerance. These tests ensure that CSS consolidation, Hugo resource processing, and asset pipeline refactoring maintain pixel-perfect visual fidelity.

## Critical Rules (ZERO TOLERANCE)

### Golden Master Baseline Protection

- **Refactoring Definition**: Code restructuring maintaining EXACT functionality AND appearance
- **Tolerance Enforcement**: `tolerance: 0.0` for ALL refactoring validation tests
- **Page-Specific CSS**: ALL `.fl-node-*` styles MUST be preserved
- **Layout-Critical CSS**: ALL layout rules MUST remain intact
- **Footer Appearance**: MUST be pixel-perfect identical
- **Blocking Authority**: ANY visual change > 0% = IMMEDIATE BLOCK

### Test Masking Prevention

- **FORBIDDEN**: Modifying tests to hide bugs
- **FORBIDDEN**: Increasing tolerance thresholds to bypass failures
- **FORBIDDEN**: Using `visible: :all` to bypass CSS visibility issues
- **FORBIDDEN**: Adding JavaScript execution to work around CSS problems
- **MANDATORY**: Fix underlying code, NEVER modify test assertions

## Testing Workflow

### Phase 1: Pre-Refactoring Baseline Capture

**Objective**: Establish golden master baseline screenshots BEFORE any CSS changes.

**Tests to Run**:

```bash
# Capture full-page baselines with tolerance: 0.0
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/baseline_full_page/"

# Capture critical section baselines
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/baseline/"
```

**Expected Results**:
- ✅ All baseline tests PASS
- ✅ Baseline screenshots saved in `test/fixtures/screenshots/darwin/css_processing/baselines/`
- ✅ Zero test failures
- ✅ Baseline checksums stored for comparison

**CRITICAL**: These baselines become the SACRED GOLDEN MASTER. Do NOT modify them during refactoring.

### Phase 2: CSS Content Validation

**Objective**: Validate CSS files contain all required rules and patterns.

**Tests to Run**:

```bash
# Validate CSS content includes critical rules
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/css_files_contain/"
```

**Expected Results**:
- ✅ All CSS content tests PASS
- ✅ Page-specific `.fl-node-*` classes detected
- ✅ Layout wrapper classes present
- ✅ Component styles loaded
- ✅ Navigation styles functional
- ✅ Responsive styles present

**BLOCKING CONDITIONS**:
- ❌ Missing `.fl-node-*` classes → BLOCK, CSS consolidation incomplete
- ❌ Missing layout classes → BLOCK, layout-critical CSS lost
- ❌ Missing component styles → BLOCK, component CSS not loaded

### Phase 3: Post-Refactoring Visual Regression Validation

**Objective**: Validate ZERO visual changes after CSS processing refactoring.

**Tests to Run**:

```bash
# Run ALL visual regression checks with tolerance: 0.0
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/visual_regression_check/"
```

**Expected Results**:
- ✅ ALL regression tests PASS with 0% difference
- ✅ Homepage matches baseline pixel-perfectly
- ✅ About Us matches baseline pixel-perfectly
- ✅ Careers matches baseline pixel-perfectly
- ✅ Footer matches baseline pixel-perfectly
- ✅ Hero section matches baseline pixel-perfectly

**CRITICAL BLOCKING CONDITIONS**:
- ❌ ANY difference > 0% on full-page screenshots → IMMEDIATE BLOCK
- ❌ ANY footer visual change → IMMEDIATE BLOCK (footer broken in past refactoring)
- ❌ ANY hero section layout change → IMMEDIATE BLOCK
- ❌ ANY CTA block styling change → IMMEDIATE BLOCK

### Phase 4: Page-Specific CSS Preservation Validation

**Objective**: Verify page-specific CSS overrides are preserved correctly.

**Tests to Run**:

```bash
# Validate page-specific CSS preservation
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/preserves_page_specific_css/"
```

**Expected Results**:
- ✅ Homepage page-specific nodes present and styled
- ✅ About Us page-specific nodes present and styled
- ✅ Careers page-specific nodes present and styled
- ✅ All `[data-node]` elements have computed styles

**BLOCKING CONDITIONS**:
- ❌ Missing page-specific node styles → BLOCK, page overrides lost
- ❌ Empty computed styles on nodes → BLOCK, CSS not applied

### Phase 5: CSS Consolidation Validation

**Objective**: Validate CSS consolidation maintains specificity and load order.

**Tests to Run**:

```bash
# Validate CSS consolidation correctness
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/consolidate/"
```

**Expected Results**:
- ✅ CSS specificity preserved (page-specific overrides global)
- ✅ CSS cascade order correct (base → component → page-specific)
- ✅ All style layers load in correct sequence

**BLOCKING CONDITIONS**:
- ❌ CSS specificity broken → BLOCK, consolidation lost override priority
- ❌ Incorrect load order → BLOCK, cascade order broken

## Complete Test Suite Execution

**Full Test Run** (all phases):

```bash
# Run ALL CSS processing tests
bin/rake test:critical TEST=test/system/css_processing_test.rb
```

**Expected Results**:
- ✅ 100% test pass rate
- ✅ Zero visual regressions detected
- ✅ All CSS content validations pass
- ✅ All page-specific CSS preserved
- ✅ CSS consolidation validated

**CRITICAL FAILURE PROTOCOL**:

If ANY test fails:

1. **IMMEDIATE HALT**: Stop all refactoring work
2. **INVESTIGATE**: Identify which CSS rule/file caused regression
3. **FIX CODE**: Fix underlying CSS processing, NOT the test
4. **RE-VALIDATE**: Run full test suite again
5. **REPEAT**: Continue until 100% pass rate achieved

## Four-Eyes Validation Protocol

### Step 1: Coder Self-Validation

**Actions**:
- Run pre-refactoring baseline capture
- Implement CSS processing changes
- Run post-refactoring visual regression checks
- Review screenshot diffs for ANY visual changes

**Blocking Conditions**:
- ❌ ANY visual changes detected → STOP, investigate CSS preservation
- ❌ Test failures → STOP, fix code not tests

### Step 2: Reviewer Validation

**Actions**:
- Review CSS processing implementation
- Validate `.fl-node-*` style preservation
- Check page-specific override preservation
- Verify screenshot comparison methodology

**Blocking Conditions**:
- ❌ CSS preservation violations → BLOCK, require coder fix
- ❌ Missing page-specific CSS → BLOCK, incomplete refactoring

### Step 3: Screenshot Guardian Validation (ABSOLUTE AUTHORITY)

**Actions**:
- Run independent visual regression validation
- Execute ALL baseline comparison tests with `tolerance: 0.0`
- Generate detailed diff report
- Verify ZERO visual changes across all pages

**Blocking Conditions**:
- ❌ ANY visual difference > 0% → ABSOLUTE BLOCK
- ❌ Missing baseline screenshots → ABSOLUTE BLOCK
- ❌ Tolerance > 0.0 used → ABSOLUTE BLOCK (test masking attempt)

**CRITICAL**: Screenshot Guardian has VETO power over ALL CSS refactoring commits.

### Step 4: Tester Final Validation

**Actions**:
- Run complete test suite: `bin/rake test:critical`
- Validate ALL tests pass
- Verify test baselines unchanged
- Confirm behavioral integrity

**Blocking Conditions**:
- ❌ ANY test failures → BLOCK, fix code
- ❌ Test baseline changes → BLOCK, preserve baselines
- ❌ Visual regressions → BLOCK, fix CSS

## Test Configuration

### Screenshot Settings

```ruby
# Refactoring validation settings (ZERO TOLERANCE)
REFACTORING_TOLERANCE = 0.0  # Zero visual changes allowed
STABILITY_TIME = 0.5         # Wait for animations/renders
SCREENSHOT_DRIVER = :vips    # High-precision comparison

# Normal development settings (NOT for refactoring)
NORMAL_TOLERANCE = 0.03      # 3% tolerance for new features
```

### Environment Variables

```bash
# Force baseline regeneration (use ONLY for initial baseline capture)
FORCE_SCREENSHOT_UPDATE=true bin/rake test:critical TEST=test/system/css_processing_test.rb TESTOPTS="--name=/baseline/"

# Update baselines after approved changes (FORBIDDEN during refactoring)
CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false bin/rake test:critical

# Normal test execution
bin/rake test:critical TEST=test/system/css_processing_test.rb
```

## Memory Coordination

### Baseline Storage

```yaml
memory_namespace: "hive/testing/baselines"
storage_location: "test/fixtures/screenshots/darwin/css_processing/baselines/"
checksum_tracking: "SHA256 checksums stored for baseline validation"
retention_policy: "Permanent (sacred golden master)"
```

### Test Results Sharing

```yaml
memory_namespace: "hive/testing/results"
test_run_id: "css_processing_validation_{timestamp}"
pass_rate: "100% required for approval"
blocking_authority: "screenshot_guardian has ABSOLUTE veto power"
```

## Validation Gates

### Pre-Commit Gates (MANDATORY)

- ✅ All CSS content tests PASS
- ✅ All visual regression tests PASS with tolerance: 0.0
- ✅ All page-specific CSS preservation tests PASS
- ✅ All CSS consolidation tests PASS
- ✅ Screenshot Guardian approval obtained
- ✅ Four-eyes validation completed

### Approval Authority

| Agent | Authority | Blocking Power |
|-------|-----------|----------------|
| Coder | Self-validation | Can BLOCK own commit |
| Reviewer | Code review | Can BLOCK commit |
| Screenshot Guardian | Visual validation | **ABSOLUTE BLOCKING AUTHORITY** |
| Tester | Final validation | Can BLOCK commit |

**Critical Rule**: ALL four approvals required. ANY agent BLOCKS → work STOPS.

## Incident Learning Integration

### Sprint 2 Crisis Prevention

This testing protocol incorporates lessons from Sprint 2 CSS refactoring crisis:

**Historical Failures**:
- Footer layout broken by removing page-specific CSS
- Core values section styling lost
- Visual regressions went undetected during refactoring
- Test baselines modified to hide failures (test masking)

**Prevention Mechanisms**:
- ✅ `tolerance: 0.0` enforcement (zero visual changes)
- ✅ Mandatory baseline capture BEFORE refactoring
- ✅ Page-specific CSS preservation validation
- ✅ Footer-specific regression tests
- ✅ Screenshot Guardian blocking authority
- ✅ Test masking prevention (cannot modify baselines)

## Test Execution Examples

### Baseline Capture (Pre-Refactoring)

```bash
# Step 1: Capture all baselines
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/baseline/"

# Step 2: Verify baselines created
ls -la test/fixtures/screenshots/darwin/css_processing/baselines/

# Step 3: Store baseline checksums
shasum -a 256 test/fixtures/screenshots/darwin/css_processing/baselines/*.png > baselines.sha256
```

### Visual Regression Validation (Post-Refactoring)

```bash
# Step 1: Run all regression checks
bin/rake test:critical TEST=test/system/css_processing_test.rb \
  TESTOPTS="--name=/visual_regression_check/"

# Step 2: Review any failures
# If ANY test fails → STOP, investigate, fix code

# Step 3: Verify 100% pass rate before continuing
```

### Complete Validation Workflow

```bash
# Full validation sequence
bin/rake test:critical TEST=test/system/css_processing_test.rb

# Expected output: 100% pass rate, 0 failures
# If ANY failures → BLOCK commit, fix code, re-validate
```

## Success Criteria

### Commit Approval Checklist

- [ ] All baseline screenshots captured with `tolerance: 0.0`
- [ ] All CSS content validation tests PASS
- [ ] All visual regression tests PASS (0% difference)
- [ ] All page-specific CSS preservation tests PASS
- [ ] All CSS consolidation tests PASS
- [ ] Coder approval: CSS preservation validated ✓
- [ ] Reviewer approval: Pattern compliance validated ✓
- [ ] Screenshot Guardian approval: Zero visual changes validated ✓
- [ ] Tester approval: Tests pass and baselines preserved ✓

**ONLY commit when ALL checkboxes are checked.**

## Emergency Protocols

### If Visual Regressions Detected

1. **HALT**: Immediately stop refactoring work
2. **CAPTURE**: Take screenshots of current state for comparison
3. **ANALYZE**: Compare against baselines to identify CSS rule causing regression
4. **INVESTIGATE**: Review CSS consolidation to find lost rules
5. **FIX**: Restore missing CSS rules or page-specific overrides
6. **RE-TEST**: Run full test suite validation
7. **VALIDATE**: Obtain Screenshot Guardian approval
8. **DOCUMENT**: Record what CSS was missing and why

### If Tests Are Modified

1. **REJECT**: Immediately reject any test baseline modifications
2. **ESCALATE**: Report test masking attempt to team
3. **INVESTIGATE**: Identify why test modification was attempted
4. **ROOT CAUSE**: Determine underlying bug being masked
5. **FIX CODE**: Fix the actual CSS bug, not the test
6. **RE-VALIDATE**: Run original test to confirm fix
7. **DOCUMENT**: Record incident for institutional learning

## Reporting

### Test Results Report Template

```yaml
test_run_id: "css_processing_validation_{timestamp}"
test_suite: "CSS Processing Visual Regression Tests"
total_tests: 24
passed: 24
failed: 0
pass_rate: "100%"

critical_validations:
  - baseline_capture: "✅ PASS"
  - css_content_validation: "✅ PASS"
  - visual_regression_check: "✅ PASS (0% difference)"
  - page_specific_css_preservation: "✅ PASS"
  - css_consolidation_validation: "✅ PASS"

blocking_conditions_triggered: []

approvals:
  - coder: "✅ APPROVED"
  - reviewer: "✅ APPROVED"
  - screenshot_guardian: "✅ APPROVED"
  - tester: "✅ APPROVED"

commit_status: "✅ APPROVED FOR COMMIT"
```

---

**Remember**: This protocol has ZERO TOLERANCE for visual regressions. ANY visual change during refactoring is a FAILURE. Fix the code, NEVER modify the tests.
