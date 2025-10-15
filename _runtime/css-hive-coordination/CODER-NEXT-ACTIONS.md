# 🚀 CODER AGENT: IMMEDIATE NEXT ACTIONS (WP1.1 - .fl-row Extraction)

**Queen Coordinator Directive**: Resume 590-layout.css extraction using approved micro-commit protocol.

---

## ✅ PROGRESS SO FAR

**Commits Made**: 2/22 for 590-layout.css
- ✅ Commit 1: Clearfix utilities extracted (8 lines removed from 590, 10 added to fl-foundation)
- ✅ Commit 2: .fl-row margin utilities extracted (5 lines removed from 590, 6 added to fl-foundation)

**Tests Status**: ✅ ALL PASSING (42 runs, 115 assertions, 0 failures)

**File Status**:
- `590-layout.css`: 13,063 lines (10+ .fl-row patterns remaining)
- `fl-foundation.css`: 135 lines (extraction target established ✅)

---

## 🎯 IMMEDIATE TASK: Extract Next .fl-row Pattern

**Target Pattern Priority** (from grep analysis):
1. `.fl-row-bg-video` and `.fl-row-bg-embed` patterns (lines 2800-2825)
2. `.fl-row-bg-slideshow` patterns (lines 2851-2865)
3. `.fl-row-bg-overlay` patterns (lines 2874-2886)
4. `.fl-row-default-height`, `.fl-row-custom-height`, `.fl-row-full-height` patterns (lines 2891-2920)
5. Page-specific `.fl-node-*` patterns (lines 2666-2678) - **PRESERVE, DO NOT EXTRACT**

---

## 📋 MICRO-COMMIT PROTOCOL (Your Workflow)

### Step 1: Identify Next Pattern
```bash
# Example: Extract .fl-row-bg-video pattern
# Lines 2800-2810 in 590-layout.css:
# .fl-row-bg-video .fl-bg-video, .fl-row-bg-embed .fl-bg-embed-code {
#   position: relative;
#   overflow: hidden;
# }
```

### Step 2: Extract to fl-foundation.css
```bash
# Add pattern to fl-foundation.css at appropriate location
# Organize by pattern type (background, overlay, height, etc.)
# Add comment for maintainability:
# /* Background video and embed utilities */
```

### Step 3: Remove from 590-layout.css
```bash
# Remove ≤3 lines from source file
# Keep whitespace clean
```

### Step 4: Test IMMEDIATELY
```bash
bin/rake test:critical
```

### Step 5: Commit or Rollback
```bash
# If tests PASS (exit code 0):
git add themes/beaver/assets/css/590-layout.css themes/beaver/assets/css/fl-foundation.css
git commit -m "refactor(css): extract .fl-row-bg-video pattern to foundation (WP1.1 3/22)"

# If tests FAIL (exit code non-zero):
git restore themes/beaver/assets/css/590-layout.css themes/beaver/assets/css/fl-foundation.css
# Investigate failure, adjust extraction, retry
```

### Step 6: Notify Coordination
```bash
# After successful commit:
echo "✅ WP1.1 3/22: Extracted .fl-row-bg-video pattern, tests pass, commit [hash]"
# Tester will validate on next cycle
```

### Step 7: Repeat
```bash
# Continue to next .fl-row pattern in 590-layout.css
# Target: 20-22 total micro-commits for this file
```

---

## ⚠️ CRITICAL CONSTRAINTS

### DO NOT EXTRACT (Preservation Rules)
- ❌ Page-specific `.fl-node-*` patterns (lines 2666-2678) - **THESE MUST STAY**
- ❌ Anything in 3086-layout2.css (block list)
- ❌ Layout-critical overrides (check for specificity)

### DO EXTRACT (Foundation Patterns)
- ✅ Generic `.fl-row` structural patterns
- ✅ Background utilities (`.fl-row-bg-video`, `.fl-row-bg-slideshow`, `.fl-row-bg-overlay`)
- ✅ Height variants (`.fl-row-default-height`, `.fl-row-custom-height`, `.fl-row-full-height`)
- ✅ Positioning and overflow rules
- ✅ Responsive behavior patterns

### Pattern Recognition Checklist
Before extracting ANY pattern, ask:
1. **Is this generic?** → YES = extract, NO = preserve
2. **Does it have `.fl-node-*` selectors?** → YES = preserve, NO = extract
3. **Is it duplicated across multiple layout files?** → YES = extract, NO = investigate
4. **Will extraction break page-specific layouts?** → YES = preserve, NO = extract

---

## 📊 PROGRESS TRACKING

**Current File (590-layout.css)**:
- Commits: 2/22 (9% complete)
- Patterns extracted: 2 (clearfix, margin utilities)
- Patterns remaining: ~20 (bg-video, bg-slideshow, bg-overlay, height variants, etc.)
- Lines remaining: 13,063 (minimal reduction so far, significant work ahead)

**WP1.1 Overall Progress**:
- Files completed: 0/32 (590-layout.css in progress)
- Patterns extracted: 2/2,129 (0.09%)
- Lines eliminated: ~13/600-900 target (2%)
- Micro-commits: 2/128 target (1.6%)

**Next Milestone**: Complete 590-layout.css extraction (18-20 more commits needed)

---

## 🔄 COORDINATION EXPECTATIONS

**After Each Commit**:
- **Tester**: Validates with `bin/rake test:critical` + visual regression check
- **Reviewer**: Reviews pattern accuracy, foundation placement, commit message
- **Queen**: Tracks progress toward WP1.1 completion

**If Tests Fail**:
- **Immediate rollback**: `git restore .`
- **Investigation**: Analyze test failure output
- **Adjustment**: Modify extraction strategy
- **Retry**: Test again before committing

**If Visual Regression Detected** (tolerance: 0.003):
- **Screenshot Guardian blocks**: ABSOLUTE blocking authority
- **Root cause analysis**: Identify CSS specificity issue
- **Preservation strategy**: Move pattern to page-specific file if necessary
- **Re-validation**: Capture new baseline if legitimate layout change

---

## 🎯 SUCCESS CRITERIA (590-layout.css Completion)

- ✅ 20-22 micro-commits total for this file
- ✅ All generic .fl-row patterns extracted to fl-foundation.css
- ✅ Page-specific .fl-node-* patterns preserved in 590-layout.css
- ✅ 100% test pass rate maintained throughout
- ✅ Zero visual regressions (tolerance: 0.003)
- ✅ Clean commit history with descriptive messages
- ✅ fl-foundation.css organized by pattern type with comments

**When Complete**: Notify Queen Coordinator → "590-layout.css WP1.1 extraction complete, ready for next file (580-layout.css)"

---

## 🚀 EXECUTE NOW

**Your immediate action**: Extract `.fl-row-bg-video` pattern from 590-layout.css lines 2800-2810, test, commit as "WP1.1 3/22".

**Reference**: /Users/pftg/dev/jetthoughts.github.io/_runtime/css-hive-coordination/phase1-wp1.1-strategy-resolution.md for full micro-commit protocol.

**Autonomy**: You are authorized to continue extraction autonomously until 590-layout.css complete. Test after EACH extraction. Notify coordination after successful commits. Stop only on critical test failures.
