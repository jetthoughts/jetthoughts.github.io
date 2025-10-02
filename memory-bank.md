# Memory Bank - CSS Migration Project 2509

## Project Context
**Goal**: Migrate from Beaver Builder FL-node system to maintainable BEM component architecture
**Timeline**: Sprint 6.X - Component extraction from careers.html
**Scope**: 43 FL-nodes to extract, 8 completed (19%)

## Key Decisions

### Decision 1: PostCSS @import Strategy (Phase 1B)
**Date**: Sprint 5 (commits b2bd12394, 7c530341d, ea827f825)
**Rationale**:
- Keep source CSS files separate for clarity and maintainability
- Use PostCSS @import-inliner plugin for build-time consolidation
- Avoid manual CSS duplication and merge conflicts
**Outcome**: Successfully consolidated 78 CSS files (74% reduction: 105 → 27 files)

### Decision 2: BEM Addition Before Removal (Phase 2)
**Date**: Sprint 6.1-6.2 (57 commits)
**Rationale**:
- Add BEM classes first while retaining FL-node classes
- Verify visual fidelity with both systems running in parallel
- Remove FL-nodes only after BEM is proven stable
**Outcome**: 57/57 BEM additions completed, zero regressions

### Decision 3: Test with Fresh Asset Compilation
**Date**: Oct 2, 2025 (Session 1759308485653)
**Problem**: Visual regression tests failing with 81-90% difference
**Root Cause**: Stale precompiled assets not including latest BEM CSS changes
**Solution**: Always run tests with `PRECOMPILED_ASSETS=false`
**Validation**: Careers test passes consistently when assets are fresh

### Decision 4: Solo Execution for Repetitive FL-node Extraction
**Date**: Oct 2, 2025 (Product Owner directive)
**Rationale**:
- FL-node extraction is repetitive pattern-based work (35 remaining items)
- No need for full XP team spawning for simple consolidation
- Faster execution with solo work + intensive testing
**Approach**: Solo execution, test after each change, commit on green, continue

## Code Patterns

### Pattern 1: TDD Cycle for Component Extraction
```
RED: Identify FL-node CSS dependencies
GREEN: Add BEM classes to HTML, consolidate CSS
REFACTOR: Remove duplicate FL-node CSS, cleanup
TEST: env PRECOMPILED_ASSETS=false bin/rake test:critical
COMMIT: Micro-commit on green tests
```

### Pattern 2: BEM Component Structure
```html
<!-- Before (FL-node) -->
<div class="fl-col fl-node-yx43bujcaiqn hover-box">

<!-- After (BEM + FL retention during transition) -->
<div class="fl-col fl-col-small hover-box c-feature-card">

<!-- Final (Pure BEM) -->
<div class="c-feature-card c-feature-card--variant">
```

### Pattern 3: CSS Consolidation
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

## Session History

### Session 1759308485653 (Oct 2, 2025)
**Coordinator**: Hive Mind Queen (Scrum Master)
**Phases Completed**:
1. ✅ Phase 1: Resolved careers test failures (stale asset cache issue)
2. ✅ Phase 2: Updated coordination documentation with accurate @import approach
3. ⏳ Phase 3: Ready to resume FL-node extraction (9-43/43)

**Key Outcomes**:
- Diagnosed test failure root cause: precompiled asset caching
- Documented PostCSS @import implementation strategy
- Confirmed autonomous solo execution for remaining 35 FL-nodes
- Established test protocol: PRECOMPILED_ASSETS=false for reliability

**Lessons Learned**:
- Hugo's asset compilation caches aggressively - force fresh builds for CSS changes
- Visual regression tests are sensitive to compilation state, not just code changes
- Solo autonomous execution appropriate for repetitive pattern-based refactoring work