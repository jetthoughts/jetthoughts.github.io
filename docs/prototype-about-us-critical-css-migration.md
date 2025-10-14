# Critical CSS Migration Prototype: About-Us Template

**Date**: 2025-10-14
**Template**: `themes/beaver/layouts/page/about.html`
**Reference**: `themes/beaver/layouts/home.html` (already migrated)
**Status**: Prototype - DO NOT COMMIT YET

---

## Current Structure Analysis

### Current Template (about.html)
```html
{{ define "header" }}
  {{- $aboutResources := slice
    (resources.Get "css/critical/base.css")
    (resources.Get "css/701-layout.css")
    (resources.Get "css/skin-65eda28877e04.css")
    (resources.Get "css/dynamic-icons.css" | resources.ExecuteAsTemplate "css/dynamic586.css" .)
    (resources.Get "css/586.css")
    (resources.Get "css/bf72bba397177a0376baed325bffdc75-layout-bundle.css")
    (resources.Get "css/footer.css")
  -}}

  {{ partialCached "assets/css-processor.html" (dict "resources" $aboutResources "bundleName" "about-us" "context" .) "about-us" }}
  {{ partial "header/json-ld-company.html" . }}
  {{ partial "seo/organization-enhanced-schema.html" . }}
{{ end }}
```

### Current Critical CSS Partial
**File**: `themes/beaver/layouts/partials/header/critical/about-us.html`
```html
<!-- generated with https://www.corewebvitals.io/tools/critical-css-generator -->
{{ partial "header/critical/base-critical.html" . }}
{{- $criticalCSS := resources.Get "css/critical/about-us-critical.css" | postCSS | fingerprint "md5" -}}
{{- if hugo.IsProduction -}}
  {{- $criticalCSS = $criticalCSS | minify | resources.PostProcess -}}
{{- end -}}
<style>{{ $criticalCSS.Content | safeCSS }}</style>
```

**Critical CSS File**: `themes/beaver/assets/css/critical/about-us-critical.css` (1850 lines)

---

## Proposed Migration

### Updated Template (about.html)
Following the `home.html` pattern where critical CSS is loaded INLINE in `<head>` via footer block:

```html
{{ define "header" }}
{{ end }}

{{ define "footer" }}
  {{- $nonCriticalResources := slice
    (resources.Get "header/critical/base-critical.html")
    (resources.Get "css/critical/about-us-critical.css")
    (resources.Get "css/critical/base.css")
    (resources.Get "css/701-layout.css")
    (resources.Get "css/skin-65eda28877e04.css")
    (resources.Get "css/dynamic-icons.css" | resources.ExecuteAsTemplate "css/dynamic586.css" .)
    (resources.Get "css/586.css")
    (resources.Get "css/bf72bba397177a0376baed325bffdc75-layout-bundle.css")
    (resources.Get "css/footer.css")
  }}

  {{ partialCached "assets/css-processor.html" (dict "resources" $nonCriticalResources "bundleName" "about-us") "about-us" }}

  {{ partial "header/json-ld-company.html" . }}
  {{ partial "seo/organization-enhanced-schema.html" . }}
{{ end }}

{{ define "main" }}
  <!-- EXISTING MAIN CONTENT - NO CHANGES -->
{{ end }}
```

### Key Changes

1. **Remove Header Block Critical CSS Loading**
   - Delete `{{ partial "header/critical/about-us.html" . }}` approach
   - Stop using partial wrapper for critical CSS

2. **Move to Direct CSS Include Pattern**
   - Add `base-critical.html` as FIRST resource (contains inline critical CSS)
   - Add `about-us-critical.css` as SECOND resource (page-specific critical CSS)
   - Maintain ALL existing non-critical CSS files in SAME order

3. **Bundle Name Consistency**
   - Keep `bundleName: "about-us"` for cache keys
   - Maintain existing caching behavior

---

## Files Affected

### Modified Files
1. `themes/beaver/layouts/page/about.html` - Template structure change
2. **NO CHANGES** to `themes/beaver/assets/css/critical/about-us-critical.css`
3. **NO CHANGES** to `themes/beaver/layouts/partials/header/critical/base-critical.html`

### Deprecated/Removed Files
- `themes/beaver/layouts/partials/header/critical/about-us.html` - Can be deleted after migration

---

## Migration Comparison: Home vs About-Us

| Aspect | Home Template (Migrated) | About-Us Template (Proposed) |
|--------|--------------------------|------------------------------|
| **Critical CSS Approach** | Direct include in footer block | Same - direct include in footer block |
| **Base Critical CSS** | `(resources.Get "header/critical/base-critical.html")` | Same |
| **Page Critical CSS** | `(resources.Get "css/critical/homepage-critical.css")` | `(resources.Get "css/critical/about-us-critical.css")` |
| **Non-Critical CSS** | Loaded via css-processor.html | Same pattern |
| **Bundle Name** | "homepage" | "about-us" |

---

## Test Validation Checklist

### Pre-Migration Baseline Capture
```bash
# Step 1: Capture baseline screenshots BEFORE changes
bin/rake test:critical
# Expected: ALL tests pass with tolerance: 0.03

# Step 2: Record baseline metrics
# - Page load time: _____ ms
# - First Contentful Paint: _____ ms
# - Largest Contentful Paint: _____ ms
# - Cumulative Layout Shift: _____
```

### Post-Migration Validation
```bash
# Step 1: Apply changes to about.html template
# (Copy proposed template structure)

# Step 2: Build and test
bin/hugo-build
bin/rake test:critical

# Step 3: Visual regression comparison
# - Screenshot Guardian validation: tolerance: 0.0 (ZERO visual changes)
# - Compare: /about-us/ page screenshots
# - Verify: 0% pixel difference from baseline

# Step 4: Performance validation
# - Lighthouse score: >95 (maintain or improve)
# - FCP: maintain or improve
# - LCP: maintain or improve
# - CLS: maintain or improve

# Step 5: Manual inspection
# - About Us page loads correctly
# - All sections render properly
# - Mission & Culture sections display
# - Core Values section displays
# - Testimonials section displays
# - No console errors
# - No layout shifts
```

### Four-Eyes Approval Required
- [ ] **Coder**: CSS preservation validated, baseline screenshots captured
- [ ] **Reviewer**: Pattern compliance validated, no .fl-node-* removal
- [ ] **Screenshot Guardian**: ABSOLUTE validation - 0% visual difference (BLOCKING)
- [ ] **Tester**: bin/rake test:critical passes, baselines preserved

---

## Risk Assessment

### Low Risk Factors ✅
1. **Pattern Proven**: Home template already migrated successfully using this pattern
2. **No CSS Changes**: Critical CSS files remain untouched
3. **Order Preserved**: CSS load order maintained exactly
4. **Cache Keys Same**: Bundle naming preserved for cache integrity

### Medium Risk Factors ⚠️
1. **Page Complexity**: About-Us has Mission/Culture/Values sections with unique styling
2. **Critical CSS Size**: 1850 lines of critical CSS (larger than homepage)
3. **FlNode Styles**: Contains page-specific .fl-node-* styles that MUST be preserved

### Mitigation Strategy
1. **Zero Tolerance Visual Changes**: tolerance: 0.0 for refactoring
2. **Baseline Capture**: Mandatory pre-migration screenshot baselines
3. **Four-Eyes Validation**: Mandatory cross-agent approval before commit
4. **Rollback Ready**: Keep about-us.html backup for instant rollback

---

## Success Criteria

### Functional Requirements
- [ ] About-Us page renders identically to current version
- [ ] All sections display correctly (hero, mission, culture, values, testimonials)
- [ ] Navigation works correctly
- [ ] CTAs function properly
- [ ] Mobile responsive behavior maintained

### Performance Requirements
- [ ] Lighthouse score ≥95 (maintain or improve)
- [ ] First Contentful Paint ≤2.5s (maintain or improve)
- [ ] Largest Contentful Paint ≤2.5s (maintain or improve)
- [ ] Cumulative Layout Shift ≤0.1 (maintain or improve)

### Visual Requirements
- [ ] Screenshot Guardian approval: 0% visual difference (ABSOLUTE BLOCK)
- [ ] bin/rake test:critical: 0 failures
- [ ] No layout shifts during page load
- [ ] No missing elements
- [ ] No styling regressions

---

## Next Steps (DO NOT EXECUTE YET)

1. **Review Prototype**: Team review of this migration plan
2. **Baseline Capture**: Run full test suite to capture baselines
3. **Implementation**: Apply template changes following this spec
4. **Validation**: Run full validation checklist
5. **Four-Eyes Approval**: Obtain ALL four approvals
6. **Commit**: Only after ALL validation gates pass

---

## References

- **Migrated Template**: `themes/beaver/layouts/home.html`
- **Current Template**: `themes/beaver/layouts/page/about.html`
- **Critical CSS Partial**: `themes/beaver/layouts/partials/header/critical/about-us.html`
- **Critical CSS File**: `themes/beaver/assets/css/critical/about-us-critical.css`
- **Base Critical CSS**: `themes/beaver/layouts/partials/header/critical/base-critical.html`
