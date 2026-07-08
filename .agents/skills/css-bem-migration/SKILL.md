# CSS BEM Migration Skill
#
# Reusable methodology for migrating from FL-Builder (Beaver Builder)
# auto-generated classes to BEM component architecture.

## Overview
TDD-driven FL-node extraction: add BEM classes → verify visual fidelity →
remove FL-nodes → retest. Micro-commits on every green test.

## Pattern
1. RED: Identify FL-node CSS dependencies
2. GREEN: Add BEM classes to HTML, consolidate CSS
3. REFACTOR: Remove duplicate FL-node CSS, cleanup
4. TEST: `env PRECOMPILED_ASSETS=false bin/rake test:critical`
5. COMMIT: Micro-commit on green tests

## BEM Component Structure
```html
<!-- Before (FL-node) -->
<div class="fl-col fl-node-yx43bujcaiqn hover-box">

<!-- Transition (BEM + FL retention) -->
<div class="fl-col fl-col-small hover-box c-feature-card">

<!-- Final (Pure BEM) -->
<div class="c-feature-card c-feature-card--variant">
```

## CSS Consolidation Pattern
```css
/* Before: 3 separate FL-node selectors */
.fl-node-yx43bujcaiqn { width: 32%; margin-right: 30px; }
.fl-node-ktz4ipj39vd6 { width: 36%; margin: 0 30px; }
.fl-node-m39uvorzy5g8 { width: 32%; margin-left: 30px; }

/* After: DRY BEM pattern */
.c-feature-card { width: 32%; margin-right: 30px; }
.c-feature-card--second { width: 36%; margin: 0 30px; }
.c-feature-card--third { margin-right: 0; }
```

## Constraints
- Never modify vendor files or dynamic templates
- Preserve cascade order: Critical → Layout → Component → Theme → Footer
- Run BOTH bin/test (macOS) AND bin/dtest (Linux Docker) before commit

## Full Documentation
docs/workflows/css-consolidation.md
docs/projects/2509-css-migration/css-loading-order-analysis.md
