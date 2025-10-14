# Quick Migration Checklist: About-Us Template

**Template**: `themes/beaver/layouts/page/about.html`
**Pattern**: Direct Critical CSS Include (following home.html)
**Status**: PROTOTYPE - DO NOT EXECUTE YET

---

## Pre-Migration Checklist

### 1. Backup Current Template ✅
```bash
cp themes/beaver/layouts/page/about.html themes/beaver/layouts/page/about.html.backup
```

### 2. Capture Baseline Screenshots ✅
```bash
bin/rake test:critical
# MUST capture BEFORE any changes
# Record ALL metrics: Lighthouse, FCP, LCP, CLS
```

### 3. Identify Page-Specific CSS to Preserve 🔍
```
Critical .fl-node-* styles in about-us-critical.css:
- .fl-node-wazohulbme7q (hero section background)
- .fl-node-uiyz63qn8r0f (mission/culture section)
- .fl-node-6tcum8ds5ip4 (mission column 50%)
- .fl-node-cxsbfvdr49eg (culture column 50%)
- .fl-node-os8vrc1dwlji (core values header)
- .fl-node-19njtzagfebh (hero image border-radius)
- .fl-node-ows5td8cbip3 (mission headline #1a8cff)
- .fl-node-6d9equxbio2h (culture headline #1a8cff)
- .fl-node-7rwpn0gkzc45 (mission list margin)
- .fl-node-594ngq8xc7ws (culture list margin)
```

---

## Implementation Checklist

### 4. Apply Template Changes ✏️

**REMOVE** from `{{ define "header" }}` block:
```diff
- {{- $aboutResources := slice
-   (resources.Get "css/critical/base.css")
-   (resources.Get "css/701-layout.css")
-   (resources.Get "css/skin-65eda28877e04.css")
-   (resources.Get "css/dynamic-icons.css" | resources.ExecuteAsTemplate "css/dynamic586.css" .)
-   (resources.Get "css/586.css")
-   (resources.Get "css/bf72bba397177a0376baed325bffdc75-layout-bundle.css")
-   (resources.Get "css/footer.css")
- -}}
-
- {{ partialCached "assets/css-processor.html" (dict "resources" $aboutResources "bundleName" "about-us" "context" .) "about-us" }}
- {{ partial "header/json-ld-company.html" . }}
- {{ partial "seo/organization-enhanced-schema.html" . }}
```

**ADD** new `{{ define "footer" }}` block:
```diff
+ {{ define "footer" }}
+   {{- $nonCriticalResources := slice
+     (resources.Get "header/critical/base-critical.html")
+     (resources.Get "css/critical/about-us-critical.css")
+     (resources.Get "css/critical/base.css")
+     (resources.Get "css/701-layout.css")
+     (resources.Get "css/skin-65eda28877e04.css")
+     (resources.Get "css/dynamic-icons.css" | resources.ExecuteAsTemplate "css/dynamic586.css" .)
+     (resources.Get "css/586.css")
+     (resources.Get "css/bf72bba397177a0376baed325bffdc75-layout-bundle.css")
+     (resources.Get "css/footer.css")
+   }}
+
+   {{ partialCached "assets/css-processor.html" (dict "resources" $nonCriticalResources "bundleName" "about-us") "about-us" }}
+
+   {{ partial "header/json-ld-company.html" . }}
+   {{ partial "seo/organization-enhanced-schema.html" . }}
+ {{ end }}
```

**KEEP** `{{ define "main" }}` block UNCHANGED:
```
{{ define "main" }}
  <!-- ALL 483 LINES - NO CHANGES -->
{{ end }}
```

---

## Validation Checklist

### 5. Build and Test 🧪
```bash
bin/hugo-build
# MUST succeed - no build errors

bin/rake test:critical
# MUST pass ALL tests
```

### 6. Screenshot Comparison 📸
```
Compare screenshots with tolerance: 0.0
Expected: 0% visual difference from baseline

Critical pages to validate:
✓ /about-us/ - Hero section
✓ /about-us/ - Mission & Culture section (two columns)
✓ /about-us/ - Core Values section (three cards)
✓ /about-us/ - Achievements section (counters)
✓ /about-us/ - Testimonials section
✓ /about-us/ - CTA section
```

### 7. Manual Visual Inspection 👁️
```
Desktop (1920x1080):
- [ ] Hero image loads with border-radius
- [ ] Mission headline is blue (#1a8cff)
- [ ] Culture headline is blue (#1a8cff)
- [ ] Two-column layout (50%/50%)
- [ ] Core Values cards display in grid
- [ ] Testimonials carousel works
- [ ] CTA button displays correctly

Mobile (375x667):
- [ ] Single column layout
- [ ] Mission/Culture stack vertically
- [ ] Core Values cards stack
- [ ] Navigation menu functional
- [ ] No horizontal scroll
```

### 8. Performance Validation ⚡
```bash
Lighthouse Audit:
- Performance: ____ (MUST be ≥95)
- FCP: ____ ms (MUST be ≤2500ms)
- LCP: ____ ms (MUST be ≤2500ms)
- CLS: ____ (MUST be ≤0.1)

Compare with baseline:
- Performance: ≥ baseline (maintain or improve)
- FCP: ≤ baseline (maintain or improve)
- LCP: ≤ baseline (maintain or improve)
- CLS: ≤ baseline (maintain or improve)
```

---

## Four-Eyes Approval Checklist

### 9. Coder Approval ✅
- [ ] Baseline screenshots captured BEFORE changes
- [ ] Page-specific CSS (.fl-node-*) preservation validated
- [ ] CSS load order maintained
- [ ] Build succeeds without errors
- [ ] Self-review completed

### 10. Reviewer Approval ✅
- [ ] Template pattern matches home.html (reference migration)
- [ ] No .fl-node-* styles removed from critical CSS
- [ ] Resource order preserved correctly
- [ ] No breaking changes introduced
- [ ] Code review completed

### 11. Screenshot Guardian Approval (BLOCKING) 🛡️
- [ ] Pre-migration baselines captured with tolerance: 0.0
- [ ] Post-migration screenshots compared
- [ ] Visual difference calculation: ____%
- [ ] Result: 0% difference confirmed (ABSOLUTE REQUIREMENT)
- [ ] ALL critical pages validated
- [ ] **BLOCKING DECISION**: APPROVE / REJECT

### 12. Tester Approval ✅
- [ ] bin/rake test:critical passes (0 failures)
- [ ] Test baselines unchanged
- [ ] No new test failures introduced
- [ ] Performance metrics maintained or improved
- [ ] Manual testing completed

---

## Commit Checklist

### 13. Pre-Commit Validation ✅
```
ALL four approvals obtained:
✓ Coder
✓ Reviewer
✓ Screenshot Guardian (0% visual difference - BLOCKING)
✓ Tester

ALL tests passing:
✓ bin/hugo-build succeeds
✓ bin/rake test:critical passes
✓ 0% visual regression
✓ Performance maintained/improved
```

### 14. Commit Message Template ✅
```bash
git add themes/beaver/layouts/page/about.html
git commit -m "refactor(css): migrate about-us to direct critical CSS include

Following home.html pattern:
- Move critical CSS from header to footer block
- Direct include base-critical.html + about-us-critical.css
- Preserve ALL page-specific .fl-node-* styles
- Maintain exact CSS load order

Visual regression: 0% difference (tolerance: 0.0)
Tests: bin/rake test:critical passes
Performance: Lighthouse ≥95 maintained

Four-eyes validation:
✓ Coder: CSS preservation validated
✓ Reviewer: Pattern compliance validated
✓ Screenshot Guardian: 0% visual difference validated (ABSOLUTE)
✓ Tester: Tests pass, baselines preserved

Reference: themes/beaver/layouts/home.html (migrated pattern)"
```

---

## Rollback Checklist (If ANY Validation Fails)

### 15. Immediate Rollback ⏪
```bash
# Restore backup
cp themes/beaver/layouts/page/about.html.backup themes/beaver/layouts/page/about.html

# Rebuild
bin/hugo-build

# Validate rollback
bin/rake test:critical
# Should match original baseline - 0 failures

# Investigate failure
# Review validation output
# Identify root cause
# Document findings
# Plan remediation
```

---

## Success Criteria Summary

**ALL of the following MUST be true to proceed with commit:**

1. ✅ Baseline screenshots captured BEFORE changes
2. ✅ Build succeeds: `bin/hugo-build`
3. ✅ Tests pass: `bin/rake test:critical` (0 failures)
4. ✅ Visual regression: 0% difference (tolerance: 0.0)
5. ✅ Performance: Lighthouse ≥95 maintained
6. ✅ Page-specific CSS preserved (all .fl-node-* styles)
7. ✅ Coder approval obtained
8. ✅ Reviewer approval obtained
9. ✅ Screenshot Guardian approval obtained (BLOCKING - 0% tolerance)
10. ✅ Tester approval obtained

**If ANY criterion fails → IMMEDIATE ROLLBACK → INVESTIGATE → FIX → RE-VALIDATE**

---

## Documents Reference

- **Migration Plan**: `docs/prototype-about-us-critical-css-migration.md`
- **Before/After Diff**: `docs/prototype-about-us-before-after-diff.md`
- **This Checklist**: `docs/prototype-migration-quick-checklist.md`
- **Reference Template**: `themes/beaver/layouts/home.html` (already migrated)
- **Target Template**: `themes/beaver/layouts/page/about.html` (to be migrated)
