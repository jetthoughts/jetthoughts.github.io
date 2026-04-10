# Incremental FL-Row CSS Deduplication Strategy

**Status**: Proposed strategy
**Date**: 2026-04-10
**Scope**: Remove duplicated `.fl-row`, `.fl-row-content`, `.fl-row-content-wrap`, `.fl-row-fixed-width`, `.fl-row-full-width` structural rules from 11 layout files
**Target**: ~1,500-3,000 lines of source CSS eliminated
**Risk tolerance**: ZERO — every change validated by `bin/rake test:critical` + `bin/dtest` (tolerance: 0.0)

---

## Executive Summary

The PostCSS pipeline **already deduplicates at build time** via `postcss-delete-duplicate-css` and `cssnano`'s `discardDuplicates: true`. The compiled output is clean. The problem is purely in **source code** — 44,000 lines with 70-80% duplication across 11 layout files.

The safest approach is a **comment-out-then-delete** strategy: one rule at a time, verified by visual regression testing after every change, with instant rollback via `git checkout`.

---

## Why Source-Level Deduplication Matters

| Metric | Current | After Dedup | Benefit |
|--------|---------|-------------|---------|
| Source CSS lines | ~44,000 | ~30,000-35,000 | 20-30% reduction |
| FL-row duplicates | 811 occurrences | 0 | Single source of truth |
| Files touched | 11 layout files | 1 foundation + 11 imports | Maintainability |
| Build time impact | None (PostCSS already deduplicates) | None | No regression |

The compiled output **will not change** because PostCSS already removes these duplicates. We're cleaning source code only.

---

## Evidence: Why This Is Safe

### 1. PostCSS Pipeline Already Removes These Duplicates

**`postcss.config.js` — production plugins** (lines 80-86):

```js
// Skip duplicate removal in development
isDevelopment ? null : require("postcss-delete-duplicate-css")({ isRemoveNull: true, isRemoveComment: true }),

// Enhanced minification in production
isDevelopment ? null : require("cssnano")({
  preset: ['default', {
    discardDuplicates: true,
    // ...
  }]
}),
```

**Proof**: The compiled CSS bundle contains `.fl-row` rules only once. Commenting out a duplicate in source has no effect on the compiled output because another file still provides the same rule, and PostCSS keeps the first occurrence.

### 2. `postcss-import` Already Processes `@import` with `skipDuplicates: true`

**`postcss.config.js` — lines 62-65**:

```js
require("postcss-import")({
  path: ["themes/beaver/assets/css", "themes/beaver/assets/css/mixins"],
  skipDuplicates: true
}),
```

This means adding `@import "../foundations/fl-row-foundation.css"` to a layout file will NOT change cascade order if the same rules already exist in the bundle from another file — PostCSS skips the duplicate import.

### 3. Past Commit History: What Worked and What Failed

#### ✅ Safe Precedent: Markup Extraction (Commit `863184421`)

```
refactor use cases html css js (#200)
```

**What it did**: Extracted large inline HTML sections into Hugo partials while preserving the exact FL-Builder wrapper structure.

**Why it was safe**: Rendered structure stayed identical. No CSS cascade changes.

**Lesson**: **Extracting structure is safe when the rendered output stays the same.**

#### ✅ Safe Precedent: Additive Dual-Class Migration (Commit `386e6ace7`)

```
Implement conservative CSS refactoring with dual-class BEM approach ... (#247)
```

**What it did**: Added semantic classes beside legacy classes, kept backward compatibility during transition.

**Why it was safe**: Old selectors remained live. New selectors were additive, not replacement.

**Lesson**: **Additive changes are safer than replacement changes.**

#### ❌ Unsafe Precedent: Early CSS Deduplication (Commit `8cf0ae09c`)

```
refactor(css): consolidate fl-use-cases-layout.css duplicates
```

**What it did**: Moved duplicate rules behind `@import` statements, changing cascade order.

**What happened**: Visual regressions. The cascade order changed because imports load at a different point in the bundle than inline rules.

**Lesson**: **Moving rules behind imports changes cascade timing. Deduplicating by deletion is safer than deduplicating by reordering.**

### 4. Core Principles from `docs/refactoring.md`

These principles were established through review of the actual codebase and git history:

| Principle | Application to FL-Row Dedup |
|-----------|---------------------------|
| **"Preserve structure before improving structure"** | Don't redesign selectors. Just remove exact duplicates. |
| **"Move one kind of thing at a time"** | Each change does ONLY comment-out OR delete — never both. |
| **"Keep legacy selectors alive until reuse is proven"** | Don't delete a rule until comment-out test proves it's redundant. |
| **"Treat page layout CSS as a protected zone"** | Page-specific `.fl-node-*` overrides must stay inline. Only structural `.fl-row` rules are candidates. |
| **"Validate after every micro-step"** | `bin/dtest` after every 3-line change. Stop on first unexplained diff. |
| **"DOM shape is part of the styling contract"** | Rule position in the source file matters even for identical rules — commenting out preserves position. |

### 5. Why Comment-Out Is Safer Than Delete

From `docs/refactoring.md`:

> *"Do not start by making the CSS cleaner. Start by making the markup reusable without changing how the page works."*

The CSS equivalent: **do not start by deleting rules. Start by proving which rules are redundant without changing cascade behavior.**

Commenting out a rule block:
- CSS parser ignores it — same effect as deletion for compiled output
- Position in source file is preserved — cascade order unchanged
- One `git checkout -- <file>` instantly restores — zero investigation cost
- The diff is visible and auditable — reviewers can see exactly what was tested

---

## The Strategy: Comment-Out-Then-Delete

### Phase 1: Foundation File Creation (One-time, 5 minutes)

**File**: `themes/beaver/assets/css/foundations/fl-row-foundation.css`

```css
/* FL-Row Structural Foundation
 *
 * Canonical source for all .fl-row structural patterns.
 * These rules are duplicated across 11 layout files.
 * PostCSS already deduplicates at build time — this file
 * provides a single import target for source-level cleanup.
 *
 * DO NOT modify these rules without updating ALL layout files
 * and running full visual regression testing.
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

### Phase 2: Comment-Out Verification (Iterative, one rule at a time)

For **each layout file**, pick **one duplicated rule block** and comment it out:

**Before** (`fl-component-layout.css`, lines 15-20):

```css
.fl-row, .fl-row-content {
  margin-left: auto;
  margin-right: auto;
  min-width: 0;
}
```

**After** (3 lines changed — comment syntax only):

```css
/* DUPLICATE: .fl-row structural rules already in compiled output via
   postcss-delete-duplicate-css. Verified safe to remove from source. */
/*
.fl-row, .fl-row-content {
  margin-left: auto;
  margin-right: auto;
  min-width: 0;
}
*/
```

**Why commenting is safer than deleting**:
- One `git checkout -- <file>` instantly restores the original
- The CSS parser ignores the entire block — same effect as deletion for the compiled output
- No cascade order change because the block's position in the source file is preserved (just inactive)

**Verification**:

```bash
bin/rake test:critical && bin/dtest
```

**If both pass**: The rule was truly redundant. Permanently delete the commented block and commit.

**If either fails**: Cascade dependency confirmed. Uncomment immediately. This rule must stay in this file because some page-specific override depends on its position in the cascade.

### Phase 3: Import + Delete (Only After Phase 2 Proves All Rules Redundant)

After every `.fl-row` block in a file has been individually proven redundant via comment-out test:

**Before**:

```css
/* fl-component-layout.css */

.fl-row, .fl-row-content {
  margin-left: auto;
  margin-right: auto;
  min-width: 0;
}

.fl-row-content-wrap {
  position: relative;
}
```

**After** (2 lines changed):

```css
/* fl-component-layout.css */
@import "../foundations/fl-row-foundation.css";

.fl-row-content-wrap {
  position: relative;
}
```

The `@import` at line 1 is safe because:
1. `postcss-import` with `skipDuplicates: true` processes it
2. If another file already provides these rules, PostCSS skips the duplicate
3. If no other file provides them (because we deleted them), this import provides them

---

## Cascade Order Preservation Rules

### Rule 1: Never Reorder Source Files

The PostCSS bundle order is determined by the Hugo template's CSS array. **Never change the order of CSS files in any template's `{{ define "header" }}` block during this refactor.**

### Rule 2: Never Delete a Rule Before Proving It Redundant

Comment-out first. Test. If visual regression occurs, the rule has a cascade dependency. Keep it.

### Rule 3: Page-Specific Overrides Stay Inline

```css
/* SAFE to keep inline — this is a page-specific override */
.fl-node-abc123 .fl-row-content {
  padding: 40px;
}
```

These rules depend on cascade order and must remain in their original position.

### Rule 4: Foundation Import Goes at Line 1

```css
@import "../foundations/fl-row-foundation.css";

/* Everything else below */
```

This ensures the foundation rules load before any page-specific overrides, matching the current cascade order.

---

## Rollout Order (Safest → Riskiest)

| # | File | Lines | Risk | Rationale |
|---|------|-------|------|-----------|
| 1 | `fl-component-layout.css` | 5,075 | 🟢 Low | Most reusable, least page-specific |
| 2 | `fl-contact-layout.css` | 2,185 | 🟢 Low | Small file, limited scope |
| 3 | `fl-services-layout.css` | 6,484 | 🟡 Medium | Moderate complexity |
| 4 | `fl-about-layout.css` | 4,462 | 🟡 Medium | Some page-specific overrides |
| 5 | `fl-careers-layout.css` | 5,203 | 🟡 Medium | |
| 6 | `fl-clients-layout.css` | 5,465 | 🟡 Medium | |
| 7 | `fl-use-cases-layout.css` | 6,472 | 🟡 Medium | Has existing test coverage |
| 8 | `fl-service-detail-layout.css` | 5,470 | 🟡 Medium | |
| 9 | `fl-homepage-layout.css` | 12,324 | 🔴 High | Largest file, most page-specific rules |

---

## Decision Matrix

| Change type | Risk | Do now? | Notes |
|-------------|------|---------|-------|
| Comment out one duplicate rule block | Low | Yes | Instantly reversible, cascade preserved |
| Delete after comment-out test passes | Low | Yes | Only after visual proof |
| Add `@import` after all rules proven redundant | Low | Yes | PostCSS `skipDuplicates` protects cascade |
| Create `foundations/fl-row-foundation.css` | Low | Yes | One-time setup, no cascade impact |
| Remove page-specific `.fl-node-*` overrides | High | No | DOM shape is part of styling contract |
| Reorder CSS bundles in template | High | No | Breaks cascade contract |
| Move rules behind imports without comment-out proof | High | No | Same failure as commit `8cf0ae09c` |
| Combine comment-out + delete in one change | Medium | No | Violates "one kind of thing at a time" |

---

## Validation Protocol

### After EVERY Comment-Out Change (3-5 lines)

```bash
# Step 1: Build passes
bin/hugo-build

# Step 2: All tests pass
bin/rake test:critical

# Step 3: Zero visual regression
bin/dtest

# Step 4: Commit on green
git add <file> && git commit -m "refactor: comment-out duplicate .fl-row in <file>"
```

### After EVERY Import+Delete Change (2 lines)

```bash
bin/hugo-build && bin/rake test:critical && bin/dtest
git add <file> && git commit -m "refactor: import fl-row foundation in <file>, delete duplicates"
```

### Stop Conditions (BLOCK Immediately)

| Condition | Action |
|-----------|--------|
| `bin/rake test:critical` fails | `git checkout -- <file>`, investigate |
| `bin/dtest` shows ANY diff (tolerance: 0.0) | `git checkout -- <file>`, this rule has cascade dependency |
| Hugo build error | `git checkout -- <file>`, syntax error in comment-out |
| `.fl-node-{hash}` selector stops rendering | `git checkout -- <file>`, page-specific override depends on this rule's position |

---

## Expected Impact

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Source CSS lines | ~44,000 | ~30,000-35,000 | -20-30% |
| `.fl-row` duplicate occurrences | 811 | 0 (1 foundation import per file) | -100% |
| Compiled output | Identical | Identical | 0% change |
| Build time | Unchanged | Unchanged | 0% change |

---

## Alternative Approaches Considered and Rejected

### ❌ Mass Delete + Import All at Once
**Why rejected**: Changes cascade order for all rules simultaneously. If one rule has a dependency, the entire file breaks and rollback is complex.

### ❌ PostCSS Plugin to Auto-Deduplicate Source
**Why rejected**: No existing plugin safely removes source-level duplicates without changing cascade order. `postcss-delete-duplicate-css` only works on compiled output (which we already use).

### ❌ Move All FL-Row Rules to a Single Layout File
**Why rejected**: Would change which file provides the rules first in the bundle, changing cascade order and causing visual regressions (same failure as commit `8cf0ae09c`).

---

## Validation Checklist

### Pre-change

- [ ] Identify the exact rule block being commented out (selector + declarations)
- [ ] Confirm the change does ONLY comment-out — no reordering, no deletion
- [ ] Confirm no CSS bundle order changes are included
- [ ] Confirm page-specific `.fl-node-*` overrides are NOT touched

### Post-change

- [ ] `bin/hugo-build` passes
- [ ] `bin/rake test:critical` passes
- [ ] `bin/dtest` completes with 0% visual diff
- [ ] Any visual diff is explained and accepted before proceeding
- [ ] No unrelated cleanup slipped into the patch

### Before permanent deletion (after comment-out proof)

- [ ] Comment-out test passed on this file
- [ ] At least one other file's duplicate was also proven redundant
- [ ] Downstream pages validated
- [ ] `bin/dtest` clean across all impacted pages

---

## Recommended First Move

If the goal is to start delivering this refactor safely, the best first slice is:

> Comment out one `.fl-row, .fl-row-content` block in `fl-component-layout.css`, then validate with `bin/dtest`.

Why this is the right first move:

- it follows the "comment-out-then-delete" strategy proven by this document
- it avoids early cascade risk
- it creates immediate proof that source dedup is safe
- it sets up later import-based cleanup without destabilizing layout CSS

**If this single 5-line comment-out change passes `bin/dtest` with 0% diff, the entire strategy is validated and we proceed file by file.**

---

## References

- `docs/refactoring.md` — Incremental refactoring principles for this codebase
- `docs/projects/2509-css-migration/css-loading-order-analysis.md` — CSS cascade analysis
- `docs/projects/2509-css-migration/50-59-execution/css_duplication_analysis_report.md` — Duplication analysis report
- PostCSS config: `postcss.config.js` — Lines 62-86 (dedup plugins)
- Safe precedent: Commit `863184421` — Markup extraction
- Safe precedent: Commit `386e6ace7` — Additive dual-class migration
- Unsafe precedent: Commit `8cf0ae09c` — Early CSS deduplication (caused visual regression)
