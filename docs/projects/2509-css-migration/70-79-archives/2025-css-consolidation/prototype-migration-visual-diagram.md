# About-Us Template Migration: Visual Architecture Diagram

**Purpose**: Visual representation of template transformation
**Template**: about.html → Direct Critical CSS Include Pattern

---

## Current Architecture (BEFORE)

```
┌─────────────────────────────────────────────────────────────────┐
│                    about.html Template                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  {{ define "header" }}                                          │
│    ┌───────────────────────────────────────────────────┐       │
│    │ Resource Slice: $aboutResources                   │       │
│    │  1. css/critical/base.css                         │       │
│    │  2. css/701-layout.css                            │       │
│    │  3. css/skin-65eda28877e04.css                    │       │
│    │  4. css/dynamic-icons.css                         │       │
│    │  5. css/586.css                                   │       │
│    │  6. css/bf72bba397177a0376baed325bffdc75-layout.  │       │
│    │  7. css/footer.css                                │       │
│    └───────────────────────────────────────────────────┘       │
│                           │                                     │
│                           ▼                                     │
│    ┌───────────────────────────────────────────────────┐       │
│    │ css-processor.html                                │       │
│    │ bundleName: "about-us"                            │       │
│    │ context: .                                        │       │
│    └───────────────────────────────────────────────────┘       │
│                                                                 │
│  {{ end }}                                                      │
│                                                                 │
│  ┌─────────────────────────────────────────────────────┐       │
│  │ CRITICAL CSS LOADED SEPARATELY VIA PARTIAL:         │       │
│  │                                                     │       │
│  │  partials/header/critical/about-us.html            │       │
│  │    ├─ partial "base-critical.html"                 │       │
│  │    └─ inline <style>about-us-critical.css</style>  │       │
│  └─────────────────────────────────────────────────────┘       │
│                                                                 │
│  {{ define "main" }}                                            │
│    <!-- 483 lines of content -->                               │
│  {{ end }}                                                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

LOAD SEQUENCE:
1. Critical CSS loaded via separate partial (inline in <head>)
2. Non-critical CSS loaded via css-processor.html
3. Critical loads FIRST but via different mechanism
```

---

## New Architecture (AFTER)

```
┌─────────────────────────────────────────────────────────────────┐
│                    about.html Template                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  {{ define "header" }}                                          │
│    <!-- EMPTY - follows home.html pattern -->                  │
│  {{ end }}                                                      │
│                                                                 │
│  {{ define "footer" }}                                          │
│    ┌───────────────────────────────────────────────────┐       │
│    │ Resource Slice: $nonCriticalResources             │       │
│    │                                                   │       │
│    │  CRITICAL CSS (inline in <head>):                │       │
│    │  1. header/critical/base-critical.html    ◄──┐   │       │
│    │  2. css/critical/about-us-critical.css    ◄──┤   │       │
│    │                                              │   │       │
│    │  NON-CRITICAL CSS (deferred):                │   │       │
│    │  3. css/critical/base.css                    │   │       │
│    │  4. css/701-layout.css                       │   │       │
│    │  5. css/skin-65eda28877e04.css               │   │       │
│    │  6. css/dynamic-icons.css                    │   │       │
│    │  7. css/586.css                              │   │       │
│    │  8. css/bf72bba397177a0376baed325bffdc75-l.  │   │       │
│    │  9. css/footer.css                           │   │       │
│    └──────────────────────────────────────────────│───┘       │
│                           │                       │            │
│                           ▼                       │            │
│    ┌───────────────────────────────────────────────────┐       │
│    │ css-processor.html                       PRIORITY │       │
│    │ bundleName: "about-us"                   LOADING  │       │
│    │ (no context param - not needed)                   │       │
│    └───────────────────────────────────────────────────┘       │
│                                                                 │
│    JSON-LD and SEO schema partials                             │
│  {{ end }}                                                      │
│                                                                 │
│  {{ define "main" }}                                            │
│    <!-- 483 lines of content - UNCHANGED -->                   │
│  {{ end }}                                                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

LOAD SEQUENCE:
1. Critical CSS loaded FIRST (base-critical.html + about-us-critical.css)
2. Critical loads INLINE in <head> before any other CSS
3. Non-critical CSS deferred (positions 3-9)
4. Single unified loading mechanism via css-processor.html
```

---

## Key Transformation Visualized

### Resource Load Order Comparison

```
BEFORE (Current):                    AFTER (Proposed):
┌──────────────────────┐            ┌──────────────────────────┐
│ CRITICAL CSS         │            │ 1. base-critical.html    │
│ (separate partial)   │            │    (CRITICAL - inline)   │
│                      │            ├──────────────────────────┤
│ - base-critical.html │            │ 2. about-us-critical.css │
│ - about-us-critical  │            │    (CRITICAL - inline)   │
└──────────────────────┘            ├──────────────────────────┤
         │                          │ 3. base.css              │
         │ PARALLEL                 │    (non-critical)        │
         │ LOAD                     ├──────────────────────────┤
         ▼                          │ 4. 701-layout.css        │
┌──────────────────────┐            ├──────────────────────────┤
│ NON-CRITICAL CSS     │            │ 5. skin-*.css            │
│ (css-processor)      │            ├──────────────────────────┤
│                      │            │ 6. dynamic-icons.css     │
│ - base.css           │            ├──────────────────────────┤
│ - 701-layout.css     │            │ 7. 586.css               │
│ - skin-*.css         │            ├──────────────────────────┤
│ - dynamic-icons.css  │            │ 8. layout-bundle.css     │
│ - 586.css            │            ├──────────────────────────┤
│ - layout-bundle.css  │            │ 9. footer.css            │
│ - footer.css         │            └──────────────────────────┘
└──────────────────────┘
                                    SEQUENTIAL PRIORITY LOAD
TWO SEPARATE MECHANISMS             SINGLE UNIFIED MECHANISM
```

---

## Page-Specific CSS Preservation Map

```
about-us-critical.css (1850 lines)
├─ Base FL-Builder Framework
│  ├─ .fl-builder-content
│  ├─ .fl-row, .fl-col, .fl-module
│  └─ .fl-col-group-equal-height
│
├─ Page-Specific .fl-node-* Styles (MUST PRESERVE)
│  ├─ .fl-node-wazohulbme7q          ◄── Hero section background
│  ├─ .fl-node-uiyz63qn8r0f          ◄── Mission/Culture section
│  ├─ .fl-node-6tcum8ds5ip4 (50%)   ◄── Mission column
│  ├─ .fl-node-cxsbfvdr49eg (50%)   ◄── Culture column
│  ├─ .fl-node-os8vrc1dwlji          ◄── Core Values header
│  ├─ .fl-node-19njtzagfebh          ◄── Hero image border-radius
│  ├─ .fl-node-ows5td8cbip3 (#1a8cff) ◄── Mission headline
│  ├─ .fl-node-6d9equxbio2h (#1a8cff) ◄── Culture headline
│  ├─ .fl-node-7rwpn0gkzc45          ◄── Mission list margin
│  └─ .fl-node-594ngq8xc7ws          ◄── Culture list margin
│
├─ Navigation Styles
│  ├─ .fl-node-header-nav-row
│  ├─ .fl-node-header-nav-logo
│  ├─ .fl-node-ncg61wov0ytq          ◄── Menu styles
│  └─ .pp-advanced-menu
│
├─ Layout Components
│  ├─ .fl-button, .fl-photo
│  ├─ .fl-rich-text, .fl-heading
│  └─ .pp-infobox (Core Values cards)
│
└─ Responsive Breakpoints
   ├─ @media (max-width: 1200px)
   ├─ @media (max-width: 1115px)
   └─ @media (max-width: 860px)

⚠️  CRITICAL: ALL these styles MUST remain in about-us-critical.css
    NO REMOVAL, NO CONSOLIDATION during migration
```

---

## Validation Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                  MIGRATION VALIDATION FLOW                  │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ PRE-MIGRATION BASELINE CAPTURE        │
        │ • bin/rake test:critical              │
        │ • Screenshot baselines (tolerance: 0) │
        │ • Performance baselines (Lighthouse)  │
        └───────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ TEMPLATE MODIFICATION                 │
        │ • Backup about.html                   │
        │ • Apply EXACT pattern from prototype  │
        │ • Verify syntax                       │
        └───────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ BUILD VALIDATION                      │
        │ • bin/hugo-build                      │
        │ ✓ Success → Continue                  │
        │ ✗ Failure → ROLLBACK                  │
        └───────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ TEST VALIDATION                       │
        │ • bin/rake test:critical              │
        │ ✓ 0 failures → Continue               │
        │ ✗ ANY failures → ROLLBACK             │
        └───────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ VISUAL REGRESSION VALIDATION          │
        │ • Screenshot comparison               │
        │ • Calculate pixel differences         │
        │ ✓ 0% difference → Continue            │
        │ ✗ >0% difference → ROLLBACK           │
        └───────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ FOUR-EYES APPROVAL SEQUENCE           │
        │                                       │
        │ 1. CODER APPROVAL                     │
        │    ✓ CSS preservation validated       │
        │    ✓ Self-review complete             │
        │              │                        │
        │              ▼                        │
        │ 2. REVIEWER APPROVAL                  │
        │    ✓ Pattern compliance validated     │
        │    ✓ No .fl-node-* removal            │
        │              │                        │
        │              ▼                        │
        │ 3. SCREENSHOT GUARDIAN APPROVAL       │
        │    ⚠️  BLOCKING AUTHORITY             │
        │    ✓ 0% visual difference (ABSOLUTE)  │
        │    ✗ >0% difference → BLOCK & REVERT  │
        │              │                        │
        │              ▼                        │
        │ 4. TESTER APPROVAL                    │
        │    ✓ Tests pass                       │
        │    ✓ Performance maintained           │
        └───────────────────────────────────────┘
                            │
                ┌───────────┴───────────┐
                │                       │
                ▼                       ▼
    ┌─────────────────────┐   ┌─────────────────────┐
    │ ALL APPROVALS ✓     │   │ ANY REJECTION ✗     │
    │ PROCEED TO COMMIT   │   │ IMMEDIATE ROLLBACK  │
    └─────────────────────┘   └─────────────────────┘
                │                       │
                ▼                       ▼
    ┌─────────────────────┐   ┌─────────────────────┐
    │ GIT COMMIT          │   │ RESTORE BACKUP      │
    │ • Detailed message  │   │ • Investigate cause │
    │ • Four-eyes refs    │   │ • Document findings │
    │ • Visual proof      │   │ • Plan remediation  │
    └─────────────────────┘   └─────────────────────┘
```

---

## Risk Mitigation Layers

```
┌────────────────────────────────────────────────────────────┐
│                   RISK MITIGATION STACK                    │
└────────────────────────────────────────────────────────────┘

Layer 1: BACKUP PROTECTION
┌────────────────────────────────────────────────────────────┐
│ about.html.backup                                          │
│ • Instant rollback capability                              │
│ • No data loss possible                                    │
└────────────────────────────────────────────────────────────┘
                            ▼
Layer 2: BASELINE VALIDATION
┌────────────────────────────────────────────────────────────┐
│ Pre-migration baselines                                    │
│ • Screenshots (tolerance: 0.0)                             │
│ • Performance metrics (Lighthouse)                         │
│ • Test results (bin/rake test:critical)                    │
└────────────────────────────────────────────────────────────┘
                            ▼
Layer 3: CSS PRESERVATION VALIDATION
┌────────────────────────────────────────────────────────────┐
│ Page-specific .fl-node-* styles                            │
│ • 10+ critical layout styles                               │
│ • Identified and documented                                │
│ • Zero removal tolerance                                   │
└────────────────────────────────────────────────────────────┘
                            ▼
Layer 4: AUTOMATED TESTING
┌────────────────────────────────────────────────────────────┐
│ bin/rake test:critical                                     │
│ • Visual regression tests                                  │
│ • Behavioral validation                                    │
│ • Zero failure tolerance                                   │
└────────────────────────────────────────────────────────────┘
                            ▼
Layer 5: SCREENSHOT GUARDIAN (BLOCKING)
┌────────────────────────────────────────────────────────────┐
│ Pixel-perfect visual validation                            │
│ • ABSOLUTE blocking authority                              │
│ • 0% visual change requirement                             │
│ • Veto power over all other approvals                      │
└────────────────────────────────────────────────────────────┘
                            ▼
Layer 6: FOUR-EYES APPROVAL
┌────────────────────────────────────────────────────────────┐
│ Sequential validation by four roles                        │
│ • Coder, Reviewer, Screenshot Guardian, Tester             │
│ • ALL must approve to proceed                              │
│ • ANY can block and trigger rollback                       │
└────────────────────────────────────────────────────────────┘
                            ▼
                    ✅ SAFE TO COMMIT
```

---

## Performance Impact Visualization

```
CURRENT (Separate Critical CSS Loading):
┌────────────┬────────────┬────────────┬────────────┐
│    HTML    │  CRITICAL  │    HTML    │NON-CRITICAL│
│  Parsing   │    CSS     │ Rendering  │    CSS     │
│            │  (partial) │            │(processor) │
└────────────┴────────────┴────────────┴────────────┘
    200ms        100ms        150ms        200ms
              ▲                         ▲
              │                         │
         Two separate                Loading
         loading paths              delayed

PROPOSED (Unified Critical CSS Loading):
┌────────────┬──────────────────────┬────────────┐
│    HTML    │   CRITICAL CSS       │NON-CRITICAL│
│  Parsing   │ (base + page-spec)   │    CSS     │
│            │   INLINE <head>      │(deferred)  │
└────────────┴──────────────────────┴────────────┘
    200ms          80ms                  200ms
              ▲
              │
         Single loading path
         Critical CSS inline
         Faster initial render
```

---

## Documentation Structure

```
docs/
├─ PROTOTYPE-MIGRATION-SUMMARY.md        ◄── START HERE
│  └─ Executive summary, decision points
│
├─ prototype-about-us-critical-css-migration.md
│  └─ Complete migration plan, risk assessment
│
├─ prototype-about-us-before-after-diff.md
│  └─ Side-by-side template comparison, exact changes
│
├─ prototype-migration-quick-checklist.md
│  └─ Step-by-step implementation checklist
│
└─ prototype-migration-visual-diagram.md  ◄── YOU ARE HERE
   └─ Visual architecture diagrams, flow charts
```

---

## Legend

```
Symbol Guide:
├─   Tree branch connection
└─   Tree branch end
│    Vertical connection
▼    Flow direction (downward)
◄──  Critical path indicator
✓    Validation passed
✗    Validation failed
⚠️    Warning/blocking condition
✅   Success/approval
❌   Rejection/failure
```

---

This visual diagram complements the written documentation by providing:
- Architecture before/after comparison
- Visual load sequence diagrams
- CSS preservation mapping
- Validation flow charts
- Risk mitigation layering
- Performance impact visualization
