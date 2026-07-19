# CSS Loading Order Quick Reference

**Purpose**: Quick lookup for CSS consolidation work to prevent cascade violations
**Date**: 2025-10-14
**Source**: `css-loading-order-analysis.md` (comprehensive analysis)

---

## 🚨 ABSOLUTE BLOCKS (NEVER CONSOLIDATE)

### Vendor Dependencies
```yaml
css/vendors/base-4.min.css:
  - Foundation framework (grid system)
  - Used by: Use Cases, Blog List, Blog Single, Contact Us, 5+ pages
  - Provides: .fl-row, .fl-col, .fl-col-group grid classes
  - Constraint: MUST load BEFORE page-specific layout CSS

css/vendors/swiper.min.css:
  - Swiper carousel library
  - Status: Potential unused legacy (audit required)
```

### Template-Generated CSS
```yaml
css/dynamic-icons.css:
  - Requires Hugo template execution (resources.ExecuteAsTemplate)
  - Cannot extract to static component

css/dynamic-404-590.css:
  - Page-specific FL-builder dynamic styles
  - Must preserve template execution

css/use-cases-dynamic.css:
  - Use cases section with dynamic content
  - Template-generated, NOT static
```

### FL-Builder Layout Files
```yaml
css/*-layout.css:
  - Examples: 590-layout.css (homepage), 701-layout.css (about), etc.
  - Contains page-specific .fl-node-{nodeId} selectors
  - Each page has UNIQUE node IDs
  - Constraint: Cannot consolidate without breaking page layouts
```

### Critical CSS Files
```yaml
css/critical/base.css:
  - Global critical CSS (reset, typography)
  - MUST load FIRST, performance-critical

css/critical/*-critical.css:
  - Page-specific above-fold styles
  - Page-specific, load order critical
```

---

## 📊 5-LAYER CSS CASCADE (MANDATORY ORDER)

```
Layer 1 - BASE (Load FIRST):
  ├── css/critical/base.css
  └── css/critical/{page}-critical.css

Layer 2 - LAYOUT (Load SECOND):
  ├── css/vendors/base-4.min.css (Foundation)
  ├── css/{page-id}-layout.css (FL-builder)
  └── css/bf72bba397177a0376baed325bffdc75-layout-bundle.css

Layer 3 - COMPONENT (Load THIRD):
  ├── css/dynamic-icons.css
  ├── css/586.css
  ├── css/component-bundle.css
  ├── css/companies.css
  ├── css/technologies.css
  └── css/pagination.css

Layer 4 - THEME (Load FOURTH):
  ├── css/style.css
  └── css/skin-65eda28877e04.css

Layer 5 - FOOTER (Load LAST):
  └── css/footer.css
```

---

## ✅ SAFE TO EXTRACT (WITH VALIDATION)

### Standalone Components (LOW RISK)
```yaml
css/footer.css:           # ✅ Already extracted
css/companies.css:        # ✅ Can extract (standalone component)
css/technologies.css:     # ✅ Can extract (standalone component)
css/pagination.css:       # ✅ Can extract (blog component)
css/single-post.css:      # ✅ Can extract (blog component)
```

### Utilities (LOW RISK)
```yaml
Utility classes from style.css:
  - Button utilities
  - Form utilities
  - Typography utilities (NOT Foundation-dependent)
  - Constraint: Extract ONLY utilities, NOT grid classes
```

---

## ⚠️ VALIDATION PROTOCOL

### Before ANY CSS Extraction
```yaml
pre_extraction_checks:
  - "Identify CSS file's cascade layer (Base/Layout/Component/Theme/Footer)"
  - "Check for Foundation grid usage (.fl-row, .fl-col classes)"
  - "Check for FL-builder node classes (.fl-node-* patterns)"
  - "Verify CSS file is NOT in ABSOLUTE BLOCKS list"
  - "Document all files that depend on this CSS loading first"
```

### During CSS Extraction
```yaml
extraction_rules:
  - "Preserve exact load order position in bundle"
  - "NO modifications to Foundation framework files"
  - "NO modifications to FL-builder layout files"
  - "NO modifications to template-generated CSS"
  - "Test after EVERY change: bin/rake test:critical"
```

### After CSS Extraction
```yaml
post_extraction_validation:
  - "bin/rake test:critical (MUST pass 100%)"
  - "Visual regression test: tolerance 0.003"
  - "Verify Foundation grid still works (.fl-row, .fl-col)"
  - "Verify FL-builder layouts unchanged (.fl-node-* classes)"
  - "Lighthouse audit: FCP ≤1.5s maintained"
  - "Screenshot comparison: ZERO visual changes for refactoring"
```

---

## 🔍 QUICK DECISION TREE

```
Q: Does this CSS file contain .fl-node-* selectors?
├── YES → ABSOLUTE BLOCK (DO NOT EXTRACT)
└── NO → Continue...

Q: Is this file in css/vendors/ directory?
├── YES → ABSOLUTE BLOCK (DO NOT EXTRACT)
└── NO → Continue...

Q: Does this file use resources.ExecuteAsTemplate?
├── YES → ABSOLUTE BLOCK (DO NOT EXTRACT)
└── NO → Continue...

Q: Is this css/critical/*.css?
├── YES → ABSOLUTE BLOCK (DO NOT EXTRACT)
└── NO → Continue...

Q: Does this file contain Foundation grid classes?
├── YES → HIGH RISK (Extract with extreme caution)
└── NO → SAFE TO EXTRACT (with validation)
```

---

## 📝 CASCADE DEPENDENCY EXAMPLES

### Example 1: Foundation Grid Dependency
```css
/* css/vendors/base-4.min.css (MUST load first) */
.fl-row { display: flex; max-width: 1200px; margin: 0 auto; }

/* css/3021-layout.css (MUST load AFTER Foundation) */
.fl-node-5f8a7b3c4d2e1 > .fl-row { background: #fff; }
/* ⚠️ If Foundation not loaded first, .fl-row doesn't exist = layout breaks */
```

### Example 2: Component Layer Dependency
```css
/* css/companies.css (Component Layer) */
.companies-grid { display: grid; }

/* css/style.css (Theme Layer - MUST load AFTER components) */
.companies-grid { gap: 2rem; }
/* ⚠️ If style.css loads before companies.css, override happens first = wrong cascade */
```

---

## 🎯 RECOMMENDED EXTRACTION ORDER

**Phase 1: Safe Extractions** (Lowest Risk)
1. ✅ footer.css (already done)
2. ✅ companies.css
3. ✅ technologies.css
4. ✅ pagination.css

**Phase 2: Moderate Risk**
1. ⚠️ Utility classes from style.css (NO grid classes)
2. ⚠️ single-post.css
3. ⚠️ homepage.css (check Foundation dependencies)

**Phase 3: High Risk** (Requires Expert Review)
1. 🚨 style.css consolidation (complex dependencies)
2. 🚨 skin-65eda28877e04.css (global theme overrides)

**NEVER Extract**
1. ❌ css/vendors/base-4.min.css (Foundation framework)
2. ❌ css/*-layout.css (FL-builder page layouts)
3. ❌ css/dynamic-*.css (template-generated)
4. ❌ css/critical/*.css (performance-critical)

---

## 📚 REFERENCE DOCUMENTS

- **Comprehensive Analysis**: `css-loading-order-analysis.md`
- **Goal Document**: `35-39-project-management/35.04-revised-goal-css-duplication-elimination.md`
- **At-A-Glance**: `GOAL-AT-A-GLANCE.md`
- **Project Index**: `PROJECT-INDEX.md`

---

**Last Updated**: 2025-10-14
**Document Owner**: CSS Migration Project
**Status**: Active Reference Document
