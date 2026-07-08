---
inclusion: always
---

# CSS Consolidation Rules — JetThoughts Site
#
# MANDATORY for all CSS/HTML template changes.
# Full docs: docs/workflows/css-consolidation.md
# Project: docs/projects/2509-css-migration/css-loading-order-analysis.md

## Architecture
- **Methodology**: BEM (Block__Element--Modifier)
- **Pipeline**: PostCSS (import, mixins, nested, autoprefixer, cssnano, purgecss)
- **Cascade order**: Critical → Layout → Component → Theme → Footer

## Rules
- Never modify vendor files (`css/vendors/*.min.css`) or dynamic templates (`css/dynamic-*.css`)
- Preserve cascade order in all changes
- Extract whole rule sets; keep page-specific `.fl-node-{hash}` in original files
- Run `bin/rake test:critical` after each extraction

## FL-Node Extraction (Beaver Builder → BEM)
- **Phase**: TDD RED-GREEN-REFACTOR cycle
- **Validation**: `env PRECOMPILED_ASSETS=false bin/rake test:critical` after each change
- **Pattern**: Add BEM classes first → verify visual fidelity → remove FL-nodes → retest
- **Commit**: micro-commit on green tests only

## Visual Regression
- Tolerance: 0.0 for refactoring (zero visual changes)
- Tolerance: ≤0.03 for new features only
- Run BOTH `bin/test` and `bin/dtest` before commit
- Visual failures are commit blockers, not warnings

@see docs/workflows/css-consolidation.md
