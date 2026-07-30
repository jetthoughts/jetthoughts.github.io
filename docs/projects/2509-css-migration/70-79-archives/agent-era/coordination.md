# CSS Migration Project 2509 - Coordination

## Current Sprint: Component Extraction (Sprint 6.X)

### Phase Overview
- **Phase 1B (COMPLETED)**: CSS file consolidation via PostCSS @import
  - Consolidated 78 CSS files (30 utilities + 35 components + 13 layouts)
  - Reduced from 105 files to manageable imports
  - Commits: b2bd12394, 7c530341d, ea827f825

- **Phase 2 (COMPLETED)**: BEM class addition to careers.html
  - Added semantic BEM classes (c-hero-section, c-content-block, c-cta-block)
  - 57/57 BEM additions completed
  - FL-node classes retained during addition phase

- **Current Phase: FL-node Extraction** (Sprint 6.X)
  - Systematically removing FL-node dependencies from careers.html
  - Progress: 8/43 FL-nodes extracted (19% complete)
  - Latest: c-feature-card consolidation (items 6-8/43)

### Active Tasks
1. **BLOCKING (RESOLVED)**: Fix careers page visual regression tests
   - Root cause: Stale precompiled assets not including BEM CSS changes
   - Solution: Run tests with PRECOMPILED_ASSETS=false for fresh compilation
   - Status: Individual careers test passes consistently

2. **IN PROGRESS**: FL-node extraction from careers.html
   - Target: Extract remaining 35/43 FL-nodes
   - Approach: TDD RED-GREEN-REFACTOR cycle with micro-commits
   - Validation: `env PRECOMPILED_ASSETS=false bin/rake test:critical` after each change

### Implementation Approach (Confirmed)
**PostCSS @import Strategy** (NOT manual CSS copying):
- Source CSS files remain in `themes/beaver/assets/css/` directory
- Build process uses PostCSS @import-inliner plugin
- Benefits: Source clarity, build-time optimization, no duplication
- Files: fl-careers-layout.css, fl-about-layout.css, etc. loaded via @import

### Test Strategy
- Run tests with: `env PRECOMPILED_ASSETS=false bin/rake test:critical`
- Forces fresh asset compilation including latest BEM CSS
- Avoids stale cache issues from previous runs

### Dependencies
- Hugo build system with PostCSS processing
- snap_diff-capybara for visual regression testing
- Fresh asset compilation required for accurate test results

### Progress Metrics
- **FL-nodes removed**: 8/43 (19%)
- **CSS consolidation**: 105 → 27 files (74% reduction)
- **BEM adoption**: 57/57 classes added (100%)
- **Visual regressions**: 0 (when using fresh assets)