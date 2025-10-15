# 🧪 TESTER AGENT: VALIDATION PROTOCOL (WP1.1 - .fl-row Extraction)

**Queen Coordinator Directive**: Validate each Coder commit with comprehensive test coverage + visual regression checks.

---

## ✅ VALIDATION RESPONSIBILITIES

### 1. **Functional Testing** (MANDATORY per commit)
```bash
# Run critical test suite after each Coder commit
bin/rake test:critical

# Expected output:
# 42 runs, 115 assertions, 0 failures, 0 errors, 0 skips
# ✅ ALL MUST PASS before approving commit
```

### 2. **Visual Regression Testing** (MANDATORY per commit)
```bash
# Capture screenshots and compare against baseline
# Tolerance: 0.003 (0.3% acceptable variance for non-refactoring)
# Tolerance: 0.0 (0% variance) for pure refactoring work

# Use Capybara + assert_stable_screenshot from test/test_helper.rb
# Reference: docs/60.06-test-format-requirements-reference.md
```

### 3. **CSS Loading Validation** (Per file completion)
```bash
# Verify fl-foundation.css loads correctly in Hugo templates
# Check: themes/beaver/layouts/_default/baseof.html includes foundation styles
# Validate: No broken styles, no missing patterns
```

---

## 📋 PER-COMMIT VALIDATION WORKFLOW

### Step 1: Monitor for Coder Notifications
```
# Wait for Coder notification:
"✅ WP1.1 [N/22]: Extracted [pattern] from [file], tests pass, commit [hash]"
```

### Step 2: Checkout Commit
```bash
# Ensure you're on latest commit
git pull
git log --oneline -1  # Verify commit hash matches notification
```

### Step 3: Run Functional Tests
```bash
bin/rake test:critical 2>&1 | tee _runtime/css-hive-coordination/test-results/WP1.1-[N]-functional.log

# Validation criteria:
# - 0 failures ✅
# - 0 errors ✅
# - 0 skips ✅
# - All assertions pass ✅
```

### Step 4: Visual Regression Check (Critical Pages)
```bash
# Test critical pages that use .fl-row patterns
# - Home page (/)
# - About page (/about/)
# - Services page (/services/)
# - Use Cases page (/use-cases/)
# - Contact page (/contact/)

# Create Minitest test if not exists:
# test/system/wp1_1_fl_row_extraction_visual_test.rb

# Expected: 0% visual difference for pure CSS refactoring
```

### Step 5: Foundation CSS Load Validation
```bash
# Verify fl-foundation.css loads in browser
# Check network tab: foundation styles present
# Validate: Extracted patterns apply correctly
```

### Step 6: Report Results
```bash
# If ALL validations PASS:
echo "✅ VALIDATED WP1.1 [N/22]: Commit [hash] - functional tests pass, visual regression 0%, foundation CSS loads correctly"

# If ANY validation FAILS:
echo "❌ BLOCKED WP1.1 [N/22]: Commit [hash] - [specific failure details]"
# Notify Coder to investigate and fix
```

---

## 🚨 BLOCKING CONDITIONS (MANDATORY HALT)

### Immediate Block Triggers
1. **Test Failures**: ANY functional test failure → BLOCK commit
2. **Visual Regressions**: >0.3% difference for general work, >0% for refactoring → BLOCK commit
3. **CSS Load Errors**: Foundation styles not loading → BLOCK commit
4. **Broken Layouts**: Page-specific layouts broken → BLOCK commit
5. **Pattern Misplacement**: Extracted pattern doesn't apply correctly → BLOCK commit

### Block Response Protocol
```bash
# Example block notification:
"❌ BLOCKED WP1.1 3/22: Commit 36418264b
- Functional tests: 1 failure in test/system/home_page_test.rb
- Error: Footer layout broken
- Root cause: .fl-row-bg-video extraction broke page-specific override
- Action required: Coder must rollback and preserve pattern in source file"
```

---

## 📊 VALIDATION TRACKING

**Commits Validated**: 2/2 (100% validation rate)
- ✅ WP1.1 1/22: Clearfix utilities (36418264b) - PASSED
- ✅ WP1.1 2/22: .fl-row margin utilities (22377dc6e) - PASSED

**Next Validation**: WP1.1 3/22 (awaiting Coder commit)

**Blocking History**: 0 blocks (100% clean commits so far)

---

## 🔍 VISUAL REGRESSION TEST TEMPLATE

**Location**: `test/system/wp1_1_fl_row_extraction_visual_test.rb`

**Purpose**: Validate .fl-row pattern extractions maintain visual integrity across critical pages.

**Test Structure**:
```ruby
require "application_system_test_case"

class Wp11FlRowExtractionVisualTest < ApplicationSystemTestCase
  # Test .fl-row pattern extractions for visual regressions
  # Reference: docs/60.06-test-format-requirements-reference.md

  test "home page maintains layout after .fl-row extractions" do
    visit "/"
    assert_selector "h1", text: "JetThoughts"

    # Capture screenshot with 0.003 tolerance for WP1.1 extractions
    assert_stable_screenshot(
      "wp1_1_home_after_fl_row_extraction",
      tolerance: 0.003,
      area: { x: 0, y: 0, width: 1920, height: 1080 }
    )
  end

  test "about page maintains layout after .fl-row extractions" do
    visit "/about/"
    assert_selector "h1"

    assert_stable_screenshot(
      "wp1_1_about_after_fl_row_extraction",
      tolerance: 0.003,
      area: { x: 0, y: 0, width: 1920, height: 1080 }
    )
  end

  # Add tests for services, use-cases, contact pages
end
```

**Baseline Capture** (Before WP1.1):
```bash
# Capture baseline screenshots BEFORE Coder starts extractions
# Store in: test/fixtures/screenshots/macos/wp1-1-baseline/
# Reference these baselines for all WP1.1 commit validations
```

---

## 📈 SUCCESS METRICS (WP1.1 Tester Performance)

**Validation Coverage**: 100% (all Coder commits validated)
**Block Rate**: <5% acceptable, 0% ideal
**False Positives**: 0 (no incorrect blocks)
**Response Time**: <5 minutes per commit validation
**Documentation**: All blocks documented with root cause analysis

---

## 🔄 COORDINATION WITH REVIEWER

**Handoff Protocol**:
1. Tester validates functional + visual → ✅ PASS
2. Tester notifies Reviewer: "Commit [hash] validated, ready for code review"
3. Reviewer validates pattern accuracy + commit quality
4. Reviewer approves or requests revisions
5. Loop: Continue to next Coder commit

**Parallel Validation**: Tester and Reviewer can work in parallel on different commits.

---

## 🎯 CURRENT STATUS

**Awaiting**: Coder commit WP1.1 3/22 (.fl-row-bg-video extraction)
**Ready**: Test suite ready, visual regression baseline captured
**Monitoring**: Automated test triggers on commit push (if CI/CD configured)

**Your action**: Monitor for Coder's next commit notification, validate immediately using this protocol.
