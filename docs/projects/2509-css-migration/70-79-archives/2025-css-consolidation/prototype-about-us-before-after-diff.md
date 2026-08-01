# About-Us Template Migration: Before/After Comparison

**Purpose**: Visual side-by-side comparison of template changes
**Template**: `themes/beaver/layouts/page/about.html`
**Pattern Source**: `themes/beaver/layouts/home.html` (already migrated)

---

## BEFORE: Current About-Us Template Structure

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

{{ define "main" }}
  <!-- EXISTING 483 LINES OF MAIN CONTENT -->
  <div id="fl-main-content" class="fl-page-content" itemprop="mainContentOfPage" role="main">
    <!-- About Us page content -->
  </div>
{{ end }}
```

**Current Critical CSS Loading**:
- Uses `{{ partial "header/critical/about-us.html" . }}` wrapper
- Wrapper file: `themes/beaver/layouts/partials/header/critical/about-us.html`
- Wrapper loads `base-critical.html` partial + `about-us-critical.css` inline

---

## AFTER: Proposed About-Us Template Structure

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
  <!-- EXISTING 483 LINES OF MAIN CONTENT - NO CHANGES -->
  <div id="fl-main-content" class="fl-page-content" itemprop="mainContentOfPage" role="main">
    <!-- About Us page content - UNCHANGED -->
  </div>
{{ end }}
```

**New Critical CSS Loading**:
- Direct includes in resource slice
- No wrapper partial needed
- `base-critical.html` loaded FIRST (inline critical CSS)
- `about-us-critical.css` loaded SECOND (page-specific critical CSS)

---

## Change Summary

### REMOVED ❌
1. Critical CSS loading from `header` block
2. Dependency on `themes/beaver/layouts/partials/header/critical/about-us.html` wrapper
3. Context parameter passing (`"context" .`) - not needed with direct includes

### ADDED ✅
1. Empty `header` block (consistent with home.html pattern)
2. `footer` block with comprehensive resource list
3. Direct critical CSS includes (base-critical.html + about-us-critical.css)
4. All existing non-critical CSS resources in SAME ORDER

### PRESERVED 🔒
1. ALL 483 lines of main content (ZERO changes)
2. ALL CSS files in exact same load order
3. Bundle name "about-us" for cache consistency
4. JSON-LD and SEO schema partials
5. All page-specific CSS (.fl-node-* styles, layout rules)

---

## Key Differences vs Current Approach

| Aspect | BEFORE (Current) | AFTER (Proposed) |
|--------|------------------|------------------|
| **Header Block** | Contains CSS resource loading | Empty (follows home.html) |
| **Footer Block** | Not used | Contains ALL CSS loading |
| **Critical CSS** | Via partial wrapper | Direct include in resource slice |
| **Base Critical** | Loaded by wrapper partial | Direct resource: `base-critical.html` |
| **Page Critical** | Loaded by wrapper partial | Direct resource: `about-us-critical.css` |
| **Resource Order** | base.css first | base-critical.html FIRST, then about-us-critical.css |
| **Cache Strategy** | partialCached with context | partialCached without context |
| **Main Content** | Unchanged | Unchanged |

---

## Resource Load Order Comparison

### BEFORE: Current Order
```
1. css/critical/base.css (non-critical)
2. css/701-layout.css
3. css/skin-65eda28877e04.css
4. css/dynamic-icons.css
5. css/586.css
6. css/bf72bba397177a0376baed325bffdc75-layout-bundle.css
7. css/footer.css

CRITICAL CSS LOADED SEPARATELY VIA PARTIAL:
- base-critical.html (inline in <head>)
- about-us-critical.css (inline in <head>)
```

### AFTER: Proposed Order
```
1. header/critical/base-critical.html (CRITICAL - inline in <head>)
2. css/critical/about-us-critical.css (CRITICAL - inline in <head>)
3. css/critical/base.css (non-critical - moved to position 3)
4. css/701-layout.css
5. css/skin-65eda28877e04.css
6. css/dynamic-icons.css
7. css/586.css
8. css/bf72bba397177a0376baed325bffdc75-layout-bundle.css
9. css/footer.css
```

**Impact**: Critical CSS now loads BEFORE non-critical CSS (performance improvement)

---

## Validation Points

### Visual Integrity (ZERO TOLERANCE)
- [ ] Hero section: "Learn more about our story" - MUST match pixel-perfect
- [ ] Mission section: Two-column layout with blue headlines - MUST match
- [ ] Core Values: Three card grid layout - MUST match
- [ ] Achievements: Counter animations and stats - MUST match
- [ ] Testimonials: Swiper carousel - MUST match
- [ ] CTA section: Contact button and layout - MUST match

### Page-Specific CSS Preservation
```css
/* CRITICAL: These .fl-node-* styles MUST be preserved */
.fl-node-wazohulbme7q { /* Hero section background */}
.fl-node-uiyz63qn8r0f { /* Mission/Culture section */}
.fl-node-6tcum8ds5ip4 { /* Mission column (50% width) */}
.fl-node-cxsbfvdr49eg { /* Culture column (50% width) */}
.fl-node-os8vrc1dwlji { /* Core Values header */}
.fl-node-19njtzagfebh { /* Hero image border-radius */}
.fl-node-ows5td8cbip3 { /* Mission headline color #1a8cff */}
.fl-node-6d9equxbio2h { /* Culture headline color #1a8cff */}
.fl-node-7rwpn0gkzc45 { /* Mission list margin-top */}
.fl-node-594ngq8xc7ws { /* Culture list margin-top */}

/* Layout-critical rules */
.fl-col-group-equal-height { /* Column flex layout */}
.fl-row-default-height { /* Row height rules */}
.fl-builder-layer { /* Shape layers and decorative elements */}
```

### Performance Validation
```bash
# Before migration baseline
Lighthouse Score: ____ (target: ≥95)
FCP: ____ ms (target: ≤2500ms)
LCP: ____ ms (target: ≤2500ms)
CLS: ____ (target: ≤0.1)

# After migration validation
Lighthouse Score: ____ (MUST maintain or improve)
FCP: ____ ms (MUST maintain or improve)
LCP: ____ ms (MUST maintain or improve)
CLS: ____ (MUST maintain or improve)
```

---

## Implementation Steps (Reference Only - DO NOT EXECUTE)

### Step 1: Backup Current Template
```bash
cp themes/beaver/layouts/page/about.html themes/beaver/layouts/page/about.html.backup
```

### Step 2: Capture Baseline
```bash
bin/rake test:critical
# Save output as baseline reference
```

### Step 3: Apply Changes
Replace `about.html` content with AFTER version from this document

### Step 4: Test
```bash
bin/hugo-build
bin/rake test:critical
# Compare output with baseline - MUST show 0% visual difference
```

### Step 5: Four-Eyes Validation
- Coder approval
- Reviewer approval
- Screenshot Guardian approval (BLOCKING - 0% tolerance)
- Tester approval

### Step 6: Commit (Only if ALL gates pass)
```bash
git add themes/beaver/layouts/page/about.html
git commit -m "refactor(css): migrate about-us to direct critical CSS include

Following home.html pattern:
- Move critical CSS from header to footer block
- Direct include base-critical.html + about-us-critical.css
- Maintain exact CSS load order and all page-specific styles
- Zero visual changes validated (tolerance: 0.0)

Visual regression: 0% difference
Tests: bin/rake test:critical passes
Four-eyes: ✓ Coder ✓ Reviewer ✓ Screenshot Guardian ✓ Tester"
```

---

## Rollback Plan

If ANY validation fails:

```bash
# Immediate rollback
cp themes/beaver/layouts/page/about.html.backup themes/beaver/layouts/page/about.html
bin/hugo-build
bin/rake test:critical
# Verify rollback successful - should match original baseline
```

---

## Files Reference

### Template Files
- Current: `themes/beaver/layouts/page/about.html`
- Reference: `themes/beaver/layouts/home.html` (already migrated)

### Critical CSS Files (UNCHANGED)
- `themes/beaver/layouts/partials/header/critical/base-critical.html`
- `themes/beaver/assets/css/critical/about-us-critical.css`

### Partial to Deprecate
- `themes/beaver/layouts/partials/header/critical/about-us.html` (can delete after migration)

### Test Files
- `test/system/visual_regression_test.rb`
- Test method: `test_about_us_page_stable_screenshot`
