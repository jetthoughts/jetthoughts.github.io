# Incremental FL-Row CSS Deduplication — Executable Playbook

**Status**: Proposed strategy
**Date**: 2026-07-07 (updated from 2026-04-10)
**Scope**: Remove duplicated `.fl-row`, `.fl-row-content`, `.fl-row-content-wrap`,
  `.fl-row-fixed-width`, `.fl-row-full-width` structural rules from **34 layout files**
**Target**: ~1,500-3,000 lines of source CSS eliminated
**Risk tolerance**: ZERO — every change validated by `bin/rake test:critical` +
  `bin/dtest` (tolerance: 0.0)

---

## Executive Summary

The PostCSS pipeline **already deduplicates at build time** via
`postcss-delete-duplicate-css` and `cssnano`'s `discardDuplicates: true`. The
compiled output is clean. The problem is purely in **source code** — 192,000
lines with 70-80% duplication across 34 layout files.

The safest approach is a **comment-out-then-delete** strategy: one rule at a
time, verified by visual regression testing after every change, with instant
rollback via `git checkout`.

---

## Discovery: Actual Scope (Updated 2026-07-07)

Reconnaissance identified **34 files** containing `.fl-row` rules (not 11 as
originally estimated). Files are grouped by risk tier:

### Tier 1 — Low Risk (small, isolated, least page-specific overrides)

| # | File | Lines | Risk |
|---|------|-------|------|
| 1 | `fl-foundation.css` | 479 | 🟢 |
| 2 | `components/foundation.css` | 45 | 🟢 |
| 3 | `utilities/c-spacing.css` | 306 | 🟢 |
| 4 | `utilities/fl-builder-grid.css` | 273 | 🟢 |
| 5 | `3114-layout.css` | 2,272 | 🟢 |
| 6 | `706-layout.css` | 2,202 | 🟢 |
| 7 | `fl-contact-layout.css` | 2,159 | 🟢 |
| 8 | `3059-layout.css` | 924 | 🟢 |

### Tier 2 — Medium Risk (moderate complexity, some overrides)

| # | File | Lines | Risk |
|---|------|-------|------|
| 9 | `fl-component-layout.css` | 5,049 | 🟡 |
| 10 | `fl-about-layout.css` | 4,428 | 🟡 |
| 11 | `fl-careers-layout.css` | 3,693 | 🟡 |
| 12 | `homepage-layout.css` | 2,678 | 🟡 |
| 13 | `fl-services-layout.css` | 6,450 | 🟡 |
| 14 | `fl-use-cases-layout.css` | 6,309 | 🟡 |
| 15 | `fl-service-detail-layout.css` | 6,263 | 🟡 |
| 16 | `fl-clients-layout.css` | 5,428 | 🟡 |
| 17 | `3021-layout.css` | 6,409 | 🟡 |
| 18 | `3027-layout.css` | 5,056 | 🟡 |
| 19 | `beaver-grid-layout.css` | 5,909 | 🟡 |
| 20 | `737-layout.css` | 6,489 | 🟡 |
| 21 | `2949-layout.css` | 5,407 | 🟡 |
| 22 | `3082-layout.css` | 5,399 | 🟡 |
| 23 | `3086-layout2.css` | 5,157 | 🟡 |
| 24 | `701-layout.css` | 4,462 | 🟡 |
| 25 | `404.css` | 4,836 | 🟡 |

### Tier 3 — Higher Risk (critical pages, many overrides)

| # | File | Lines | Risk |
|---|------|-------|------|
| 26 | `fb2624e43f3c4277448abe268cde571e-layout-bundle.css` | 6,523 | 🟠 |
| 27 | `e966db44b09892b8d7d492247c67e86c-layout-bundle.css` | 4,364 | 🟠 |

### Tier 4 — Critical (single-page critical CSS, high cascade sensitivity)

| # | File | Lines | Risk |
|---|------|-------|------|
| 28 | `critical/single-careers.css` | 2,297 | 🔴 |
| 29 | `critical/about-us-critical.css` | 1,846 | 🔴 |
| 30 | `critical/single-clients.css` | 1,830 | 🔴 |
| 31 | `critical/single-use-cases.css` | 1,812 | 🔴 |
| 32 | `critical/single-services.css` | 1,773 | 🔴 |
| 33 | `critical/careers-critical.css` | 1,770 | 🔴 |
| 34 | `critical/fl-layout-grid.css` | 549 | 🔴 |

---

## Why Source-Level Deduplication Matters

| Metric | Current | After Dedup | Benefit |
|--------|---------|-------------|---------|
| Source CSS lines | ~192,198 | ~150,000-170,000 | 12-22% reduction |
| FL-row duplicates | ~34 files | 0 (foundation import) | Single source of truth |
| Build time impact | None (PostCSS already deduplicates) | None | No regression |

The compiled output **will not change** because PostCSS already removes these
duplicates. We're cleaning source code only.

---

## Evidence: Why This Is Safe

### 1. PostCSS Pipeline Already Removes These Duplicates

**`postcss.config.js` — production plugins (lines ~80-86):**

```js
isDevelopment ? null : require("postcss-delete-duplicate-css")(
    { isRemoveNull: true, isRemoveComment: true }),
isDevelopment ? null : require("cssnano")({
    preset: ['default', { discardDuplicates: true, /* ... */ }]
}),
```

**Proof**: The compiled CSS bundle contains `.fl-row` rules only once.
Commenting out a duplicate in source has no effect on the compiled output
because another file still provides the same rule, and PostCSS keeps the first
occurrence.

### 2. `postcss-import` Uses `skipDuplicates: true`

**`postcss.config.js` — lines 62-65:**

```js
require("postcss-import")({
  path: ["themes/beaver/assets/css", "themes/beaver/assets/css/mixins"],
  skipDuplicates: true
}),
```

Adding `@import "../foundations/fl-row-foundation.css"` to a layout file will
NOT change cascade order if the same rules already exist in the bundle — PostCSS
skips the duplicate import.

### 3. Past Commit History: What Worked and What Failed

#### ✅ Safe: Markup Extraction (Commit `863184421`)
Extracted HTML into partials preserving FL-Builder wrapper structure.
Rendered output identical. **Lesson: structural preservation = safe.**

#### ✅ Safe: Additive Dual-Class Migration (Commit `386e6ace7`)
Added semantic classes beside legacy classes. Old selectors remained live.
**Lesson: additive changes > replacement changes.**

#### ❌ Unsafe: Early CSS Deduplication (Commit `8cf0ae09c`)
Moved duplicate rules behind `@import`, changing cascade order.
Visual regressions. **Lesson: deletion is safer than reordering.**

---

## The Strategy: Comment-Out-Then-Delete

### Core Principle

```
COMMENT OUT → VALIDATE → DELETE (only on green)
```

Each iteration touches exactly ONE rule block in ONE file. Never batch.

### Why Comment-Out Is Safer Than Delete

- CSS parser ignores it — same effect as deletion for compiled output
- Position in source file preserved — cascade order unchanged
- `git checkout -- <file>` instantly restores — zero investigation cost
- The diff is visible and auditable

---

## Phase 0: Pre-Flight Checklist (Run Once Before Starting)

```bash
# 1. Verify clean working tree
git status --porcelain  # Must be empty

# 2. Create a dedicated branch
git checkout -b refactor/css-fl-row-dedup

# 3. Record baseline: build + test + visual
bin/hugo-build                         # Must pass
bin/rake test:critical                 # Must pass
bin/dtest                              # Must pass with 0% diff

# 4. Record baseline metrics
find themes/beaver/assets/css -name '*.css' -exec cat {} + | wc -l > /tmp/css-baseline-lines.txt
echo "Baseline CSS lines: $(cat /tmp/css-baseline-lines.txt)"

# 5. If anything fails at baseline, STOP. Fix the issue first.
```

---

## Phase 1: Foundation File Creation

### Step 1.1 — Create the canonical foundation file

Create `themes/beaver/assets/css/foundations/fl-row-foundation.css`:

```css
/* FL-Row Structural Foundation
 * ==================================================
 *
 * Canonical source for all .fl-row structural patterns.
 * These rules are duplicated across 34 layout files.
 * PostCSS already deduplicates at build time — this file
 * provides a single import target for source-level cleanup.
 *
 * DO NOT modify these rules without updating ALL layout files
 * and running full visual regression testing (bin/dtest).
 *
 * Created: 2026-07-07
 * Part of: docs/refactoring-2.md — CSS deduplication playbook
 */

.fl-row,
.fl-row-content {
  margin-left: auto;
  margin-right: auto;
  min-width: 0;
}

.fl-row-content-wrap {
  position: relative;
}

.fl-row-fixed-width {
  max-width: 1180px;
  min-width: 1px;
}

.fl-row-full-width {
  width: 100%;
}
```

### Step 1.2 — Validate foundation file has no effect

```bash
# Build must still pass
bin/hugo-build

# Tests must still pass
bin/rake test:critical

# Visual regression must be 0%
bin/dtest

# If ANYTHING fails: the foundation file has a side effect. Stop and investigate.
```

### Step 1.3 — Commit foundation file

```bash
git add themes/beaver/assets/css/foundations/fl-row-foundation.css
git commit -m "refactor(css): add fl-row-foundation.css — canonical source for dedup"
```

---

## Phase 2: Iterative Comment-Out (34 Files × N Rules Per File)

### Micro-Iteration Protocol (Repeat for EVERY rule block)

```
┌──────────────────────────────────────────────────────┐
│ MICRO-ITERATION N: Comment out 1 rule block          │
│                                                      │
│  1. IDENTIFY  the exact rule block (lines X-Y)       │
│  2. COMMENT   out using standard wrapper             │
│  3. BUILD     bin/hugo-build                         │
│  4. TEST      bin/rake test:critical                 │
│  5. VISUAL    bin/dtest                              │
│  6. DECIDE    ✅ all green → go to deletion step     │
│               ❌ any red → git checkout -- <file>    │
│  7. COMMIT    git commit -m "refactor: comment-out   │
│               duplicate .fl-row in <file>"            │
│  8. DELETE    remove commented block, re-validate     │
│  9. COMMIT    git commit -m "refactor: delete        │
│               commented .fl-row in <file>"            │
└──────────────────────────────────────────────────────┘
```

### Standard Comment-Out Wrapper

For each target rule block, wrap it exactly like this:

**Before:**
```css
.fl-row, .fl-row-content {
  margin-left: auto;
  margin-right: auto;
  min-width: 0;
}
```

**After:**
```css
/* DUPLICATE: .fl-row structural rules already in compiled output via
   postcss-delete-duplicate-css + cssnano discardDuplicates.
   Commented out 2026-07-07 during fl-row dedup (docs/refactoring-2.md).
   Pending deletion after visual validation. */
/*
.fl-row, .fl-row-content {
  margin-left: auto;
  margin-right: auto;
  min-width: 0;
}
*/
```

### Validation Gate (Every Single Micro-Iteration)

```bash
# Step 1: Build
bin/hugo-build
BUILD_EXIT=$?
if [ $BUILD_EXIT -ne 0 ]; then
  echo "❌ BUILD FAILED — rolling back"
  git checkout -- themes/beaver/assets/css/<target-file>.css
  exit 1
fi
echo "✅ Build passed"

# Step 2: Test (system-level critical path tests)
bin/rake test:critical
TEST_EXIT=$?
if [ $TEST_EXIT -ne 0 ]; then
  echo "❌ TESTS FAILED — rolling back"
  git checkout -- themes/beaver/assets/css/<target-file>.css
  exit 1
fi
echo "✅ Tests passed"

# Step 3: Visual Regression (Docker-based screenshot diffs)
bin/dtest
DTEST_EXIT=$?
if [ $DTEST_EXIT -ne 0 ]; then
  echo "❌ VISUAL DIFF DETECTED — cascade dependency confirmed"
  echo "   This rule has a position-dependent cascade relationship."
  echo "   Rolling back and SKIPPING this rule."
  git checkout -- themes/beaver/assets/css/<target-file>.css
  exit 1
fi
echo "✅ Visual regression passed (0% diff)"
```

### Stop Conditions (BLOCK and Revert Immediately)

| Condition | Action |
|-----------|--------|
| Hugo build error | `git checkout -- <file>` — syntax error in comment-out |
| `bin/rake test:critical` fails | `git checkout -- <file>` — investigate test failure |
| `bin/dtest` shows ANY diff (tolerance: 0.0) | `git checkout -- <file>` — cascade dependency, skip this rule permanently |
| `.fl-node-{hash}` selector stops rendering | `git checkout -- <file>` — page-specific override depends on this rule's position |

### After Successful Comment-Out Validation

```bash
# Commit the commented-out version
git add themes/beaver/assets/css/<target-file>.css
git commit -m "refactor(css): comment-out duplicate .fl-row in <file> L<lines>"
```

### Deletion Step (Only After Comment-Out Validated Green)

```bash
# Remove the commented block and its wrapper comment
# Then re-validate with the same 3-step gate
bin/hugo-build && bin/rake test:critical && bin/dtest

# If green:
git add themes/beaver/assets/css/<target-file>.css
git commit -m "refactor(css): delete verified .fl-row duplicate in <file>"
```

---

## Phase 2 Execution: File-by-File Iteration Plan

### File 1: `fl-foundation.css` (479 lines, Tier 1 🟢)

**Target rules to deduplicate** (exact positions vary — verify before starting):

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 1.1 | `.fl-row, .fl-row-content { margin: auto; min-width: 0; }` | ~5-8 | ⬜ Pending |
| 1.2 | `.fl-row-content-wrap { position: relative; }` | ~9-11 | ⬜ Pending |
| 1.3 | `.fl-row-fixed-width { max-width: 1180px; }` | ~12-14 | ⬜ Pending |
| 1.4 | `.fl-row-full-width { width: 100%; }` | ~15-17 | ⬜ Pending |

**Validation scope**: All pages. These are structural foundation rules.

**After all rules deleted from this file, add import at line 1:**
```css
@import "../foundations/fl-row-foundation.css";
```
Then re-validate: `bin/hugo-build && bin/rake test:critical && bin/dtest`

### File 2: `components/foundation.css` (45 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 2.1 | `.fl-row, .fl-row-content { ... }` | ~3-8 | ⬜ Pending |

### File 3: `utilities/c-spacing.css` (306 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 3.1 | `.fl-row` structural rules (if present) | Verify | ⬜ Pending |

### File 4: `utilities/fl-builder-grid.css` (273 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 4.1 | `.fl-row` structural rules (if present) | Verify | ⬜ Pending |

### File 5: `3114-layout.css` (2,272 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 5.1 | `.fl-row, .fl-row-content` block | ~5-10 | ⬜ Pending |
| 5.2 | `.fl-row-content-wrap` block | ~11-13 | ⬜ Pending |
| 5.3 | `.fl-row-fixed-width` block | ~14-16 | ⬜ Pending |
| 5.4 | `.fl-row-full-width` block | ~17-19 | ⬜ Pending |

### File 6: `706-layout.css` (2,202 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 6.1 | `.fl-row, .fl-row-content` | ~5-10 | ⬜ Pending |
| 6.2 | `.fl-row-content-wrap` | ~11-13 | ⬜ Pending |
| 6.3 | `.fl-row-fixed-width` | ~14-16 | ⬜ Pending |
| 6.4 | `.fl-row-full-width` | ~17-19 | ⬜ Pending |

### File 7: `fl-contact-layout.css` (2,159 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 7.1 | `.fl-row, .fl-row-content` | ~5-10 | ⬜ Pending |
| 7.2 | `.fl-row-content-wrap` | ~11-13 | ⬜ Pending |
| 7.3 | `.fl-row-fixed-width` | ~14-16 | ⬜ Pending |
| 7.4 | `.fl-row-full-width` | ~17-19 | ⬜ Pending |

### File 8: `3059-layout.css` (924 lines, Tier 1 🟢)

| Iter | Rule Block | Approx Lines | Status |
|------|-----------|-------------|--------|
| 8.1 | `.fl-row, .fl-row-content` | ~5-10 | ⬜ Pending |
| 8.2 | `.fl-row-content-wrap` | ~11-13 | ⬜ Pending |

---

## Phase 2 Execution: Tier 2 Files (Files 9-25)

For each Tier 2 file, follow the same micro-iteration protocol. The key
difference: **after each file is complete, run the FULL validation gate
including `bin/dtest` to catch any cascade dependencies**.

### Tier 2 Checklist (Files 9-25)

**File 9: `fl-component-layout.css`** (5,049 lines)
- [ ] 9.1 `.fl-row, .fl-row-content` comment-out → validate → delete
- [ ] 9.2 `.fl-row-content-wrap` comment-out → validate → delete
- [ ] 9.3 `.fl-row-fixed-width` comment-out → validate → delete
- [ ] 9.4 `.fl-row-full-width` comment-out → validate → delete
- [ ] Post-file: add `@import "../foundations/fl-row-foundation.css"` + validate

**File 10: `fl-about-layout.css`** (4,428 lines)
- [ ] 10.1-10.4 Same four rules → comment-out → validate → delete
- [ ] Post-file import + validate

**File 11: `fl-careers-layout.css`** (3,693 lines)
- [ ] 11.1-11.4 Same four rules → comment-out → validate → delete
- [ ] Post-file import + validate

**File 12: `homepage-layout.css`** (2,678 lines)
- [ ] 12.1-12.4 Same protocol
- ⚠️ Homepage has the highest business impact. Run `bin/dtest` TWICE.
- [ ] Post-file import + validate (double-check screenshots for homepage)

**File 13: `fl-services-layout.css`** (6,450 lines)
- [ ] 13.1-13.4 Same protocol
- [ ] Post-file import + validate

**File 14: `fl-use-cases-layout.css`** (6,309 lines)
- [ ] 14.1-14.4 Same protocol
- ⚠️ Has existing test coverage — review use-case page screenshots carefully
- [ ] Post-file import + validate

**File 15: `fl-service-detail-layout.css`** (6,263 lines)
- [ ] 15.1-15.4 Same protocol
- [ ] Post-file import + validate

**File 16: `fl-clients-layout.css`** (5,428 lines)
- [ ] 16.1-16.4 Same protocol
- [ ] Post-file import + validate

**File 17: `3021-layout.css`** (6,409 lines)
- [ ] 17.1-17.4 Same protocol
- [ ] Post-file import + validate

**File 18: `3027-layout.css`** (5,056 lines)
- [ ] 18.1-18.4 Same protocol
- [ ] Post-file import + validate

**File 19: `beaver-grid-layout.css`** (5,909 lines)
- [ ] 19.1-19.4 Same protocol
- [ ] Post-file import + validate

**File 20: `737-layout.css`** (6,489 lines)
- [ ] 20.1-20.4 Same protocol
- [ ] Post-file import + validate

**File 21: `2949-layout.css`** (5,407 lines)
- [ ] 21.1-21.4 Same protocol
- [ ] Post-file import + validate

**File 22: `3082-layout.css`** (5,399 lines)
- [ ] 22.1-22.4 Same protocol
- [ ] Post-file import + validate

**File 23: `3086-layout2.css`** (5,157 lines)
- [ ] 23.1-23.4 Same protocol
- [ ] Post-file import + validate

**File 24: `701-layout.css`** (4,462 lines)
- [ ] 24.1-24.4 Same protocol
- [ ] Post-file import + validate

**File 25: `404.css`** (4,836 lines)
- [ ] 25.1-25.4 Same protocol
- ⚠️ 404 page has unique layout — review 404 screenshots carefully
- [ ] Post-file import + validate

---

## Phase 2 Execution: Tier 3 Files (Files 26-27)

These are layout bundles with hashed names — they aggregate CSS from multiple
sources. Extra caution required.

### File 26: `fb2624e43f3c4277448abe268cde571e-layout-bundle.css` (6,523 lines)

- [ ] 26.1-26.4 Same protocol
- ⚠️ Triple-validate: `bin/dtest` × 3 to check for intermittent cascade issues
- [ ] Post-file import + validate

### File 27: `e966db44b09892b8d7d492247c67e86c-layout-bundle.css` (4,364 lines)

- [ ] 27.1-27.4 Same protocol
- ⚠️ Triple-validate as above
- [ ] Post-file import + validate

---

## Phase 2 Execution: Tier 4 Files (Files 28-34 — CRITICAL PAGES)

These are `critical/` CSS files loaded inline for first-paint optimization.
They have the highest cascade sensitivity. **Triple-validate every iteration.**

### File 28: `critical/single-careers.css` (2,297 lines)

- [ ] 28.1-28.4 Same protocol, triple-validate each iteration
- [ ] Verify careers page screenshots specifically

### File 29: `critical/about-us-critical.css` (1,846 lines)
- [ ] 29.1-29.4 Same protocol, triple-validate

### File 30: `critical/single-clients.css` (1,830 lines)
- [ ] 30.1-30.4 Same protocol, triple-validate

### File 31: `critical/single-use-cases.css` (1,812 lines)
- [ ] 31.1-31.4 Same protocol, triple-validate

### File 32: `critical/single-services.css` (1,773 lines)
- [ ] 32.1-32.4 Same protocol, triple-validate

### File 33: `critical/careers-critical.css` (1,770 lines)
- [ ] 33.1-33.4 Same protocol, triple-validate

### File 34: `critical/fl-layout-grid.css` (549 lines)
- [ ] 34.1-34.4 Same protocol, triple-validate

---

## Phase 3: Final Import + Dedup Verification

After all 34 files have been processed:

```bash
# 1. Full build
bin/hugo-build

# 2. Full test suite
bin/rake test:all

# 3. Full visual regression × 3
bin/dtest && bin/dtest && bin/dtest

# 4. Verify source line reduction
find themes/beaver/assets/css -name '*.css' -exec cat {} + | wc -l
# Compare to baseline: cat /tmp/css-baseline-lines.txt

# 5. Verify compiled output is identical
# (PostCSS pipeline ensures this, but confirm)
diff <(git stash && bin/hugo-build --renderToMemory 2>&1 | sha256sum) \
     <(git stash pop && bin/hugo-build --renderToMemory 2>&1 | sha256sum)
# Must be identical
```

---

## Session Tracking Log

Maintain a running log for each working session. Create
`docs/refactoring-2-session-log.md`:

```markdown
# FL-Row CSS Dedup — Session Log

## Session 1: 2026-07-07
- Branch: refactor/css-fl-row-dedup
- Baseline: 192,198 CSS lines

### File 1: fl-foundation.css
- [x] 1.1 `.fl-row, .fl-row-content` — commented out — ✅ green — deleted
- [x] 1.2 `.fl-row-content-wrap` — commented out — ✅ green — deleted
- [ ] 1.3 `.fl-row-fixed-width` — commented out — ⏳ running dtest...
- [ ] 1.4 `.fl-row-full-width`

### File 2: components/foundation.css
- [ ] 2.1 ...

## Session 2: 2026-07-08
...
```

---

## Cascade Order Preservation Rules

### Rule 1: Never Reorder Source Files
The PostCSS bundle order is determined by the Hugo template's CSS array.
**Never change the order of CSS files in any template's `{{ define "header" }}`
block during this refactor.**

### Rule 2: Never Delete a Rule Before Proving It Redundant
Comment-out first. Test. If visual regression occurs, the rule has a cascade
dependency. **Skip it permanently** — mark it in the session log with `⛔ SKIP`.

### Rule 3: Page-Specific Overrides Stay Inline
```css
/* SAFE to keep inline — this is a page-specific override */
.fl-node-abc123 .fl-row-content {
  padding: 40px;
}
```
These rules depend on cascade order and must remain in their original position.

### Rule 4: Foundation Import Goes at Line 1 of Each File
```css
@import "../foundations/fl-row-foundation.css";
/* Everything else below — page-specific rules */
```

---

## Recovery Procedures

### If `bin/dtest` fails with a visual diff:

```bash
# 1. Revert immediately
git checkout -- themes/beaver/assets/css/<file>.css

# 2. Mark this rule as SKIPPED in the session log
echo "⛔ SKIP: <file> rule <name> — cascade dependency detected" \
  >> docs/refactoring-2-session-log.md

# 3. Move to the next rule — do NOT try to "fix" the cascade
```

### If `bin/hugo-build` fails:

```bash
# Most likely: syntax error in comment-out wrapper
git checkout -- themes/beaver/assets/css/<file>.css
# Verify the comment wrapper matched exactly:
# /* starts the comment, */ ends it, and the CSS block is inside /* ... */
```

### If `bin/rake test:critical` fails:

```bash
# The test failure is likely unrelated to the CSS change.
# Investigate the test failure first:
bin/rake test:critical 2>&1 | tail -50

# If it's a flaky test, re-run. If persistent, investigate before continuing.
```

### Emergency full rollback:

```bash
# Reset all CSS files to branch state
git checkout HEAD -- themes/beaver/assets/css/

# Or reset to main:
git checkout main -- themes/beaver/assets/css/
```

---

## Decision Matrix

| Change type | Risk | Do now? | Notes |
|-------------|------|---------|-------|
| Comment out one duplicate rule block | Low | ✅ Yes | Instantly reversible |
| Delete after comment-out test passes | Low | ✅ Yes | Only after visual proof |
| Add `@import` after all rules proven redundant | Low | ✅ Yes | PostCSS `skipDuplicates` protects |
| Create `foundations/fl-row-foundation.css` | Low | ✅ Yes | One-time setup |
| Remove page-specific `.fl-node-*` overrides | High | ❌ No | DOM shape is styling contract |
| Reorder CSS bundles in template | High | ❌ No | Breaks cascade contract |
| Move rules behind imports without comment-out proof | High | ❌ No | Same failure as commit `8cf0ae09c` |
| Combine comment-out + delete in one change | Medium | ❌ No | Violates "one thing at a time" |
| Skip a rule that shows cascade dependency | N/A | ✅ Yes | Document as `⛔ SKIP` in log |

---

## Progress Tracking Dashboard

| Tier | Files Total | Completed | In Progress | Skipped | Remaining |
|------|------------|-----------|-------------|---------|-----------|
| Tier 1 🟢 | 8 | 0 | 0 | 0 | 8 |
| Tier 2 🟡 | 17 | 0 | 0 | 0 | 17 |
| Tier 3 🟠 | 2 | 0 | 0 | 0 | 2 |
| Tier 4 🔴 | 7 | 0 | 0 | 0 | 7 |
| **Total** | **34** | **0** | **0** | **0** | **34** |

---

## Recommended First Move

> Comment out the first `.fl-row, .fl-row-content` block in
> `fl-foundation.css` (File 1, Iteration 1.1), then validate with
> `bin/hugo-build && bin/rake test:critical && bin/dtest`.

Why this is the right first move:
- Lowest-risk file (479 lines, Tier 1)
- Proves the entire comment-out-then-delete pipeline
- If it passes: ~34 files × 4 rules = ~136 iterations remain
- If it fails: we learn immediately with zero blast radius

**Estimated effort:**
- ~10 minutes per iteration (identify → comment → validate → commit → delete → validate → commit)
- ~136 iterations total
- ~23 hours of focused work (can be done across multiple sessions)

---

## References

- `docs/refactoring.md` — Incremental refactoring principles
- `docs/projects/2509-css-migration/css-loading-order-analysis.md`
- `docs/comprehensive-technical-debt-report.md`
- PostCSS config: `postcss.config.js`
- Safe precedent: Commit `863184421` — Markup extraction
- Safe precedent: Commit `386e6ace7` — Additive dual-class migration
- Unsafe precedent: Commit `8cf0ae09c` — Early CSS deduplication
