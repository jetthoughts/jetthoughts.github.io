# CSS Consolidation Product Backlog

**Product Owner**: Scrum Product Owner AI Agent
**Project**: JetThoughts Website CSS Architecture Consolidation
**Sprint Status**: Iteration 7 (of estimated 15 iterations)
**Last Updated**: 2025-10-13

---

## 📊 Executive Summary

### Current Status
- **Total CSS Files**: 146
- **Completed**: 1 file (0.7%)
- **Critical Infrastructure** (do not modify): 7 files (4.8%)
- **Unprocessed**: 138 files (94.5%)

### Priority Breakdown
- **High Priority**: 37 files (25.3%) - Large layouts with heavy FL-node duplication
- **Medium Priority**: 4 files (2.7%) - Mid-size layouts with moderate duplication
- **Low Priority**: 97 files (66.4%) - Small utilities and component files

### Business Value Metrics
- **Total CSS Size**: ~4.8MB unprocessed
- **Estimated Duplication**: 60-70% across layout files
- **Performance Impact**: Blocking render time reduction potential ~40%
- **Maintenance Burden**: Technical debt reduction across 138 files

---

## 🎯 Product Vision

**Vision Statement**:
Create a maintainable, performant, zero-duplication CSS architecture for the JetThoughts website that enables rapid feature development and ensures consistent user experience across all pages.

**Success Criteria**:
1. ✅ Zero CSS duplication across all files
2. ✅ 100% visual regression coverage (tolerance: 0.0)
3. ✅ All critical tests passing after each consolidation
4. ✅ CSS architecture follows BEM methodology
5. ✅ Page-specific styles preserved in critical CSS files

---

## 📋 Sprint Backlog (Iteration 7-8)

### High-Priority User Stories (Must Have)

#### Epic: Large Layout Consolidation
**Business Value**: Eliminate 60-70% duplication in largest CSS files, reducing page load time by 30-40%

| Priority | Story | Size (KB) | FL Nodes | Acceptance Criteria | Iteration |
|----------|-------|-----------|----------|---------------------|-----------|
| 1 | As a user, I want homepage to load faster, so I can access content quickly | 292.4 | 125 | fl-homepage-layout.css consolidated, visual tests pass, critical tests pass | 7 |
| 2 | As a user, I want page 590 to render correctly, so I can view content without layout issues | 310.2 | 125 | 590-layout.css consolidated, zero visual changes, tests green | 7 |
| 3 | As a developer, I want FL clients bundle consolidated, so I can maintain client pages easily | 159.0 | 58 | fl-clients-alt-bundle.css processed, FL-node patterns extracted | 7 |
| 4 | As a user, I want page 3021 to display correctly, so I can interact with page features | 150.7 | 74 | 3021-layout.css consolidated, behavioral integrity maintained | 7 |
| 5 | As a developer, I want FL services layout cleaned, so I can modify services page CSS safely | 153.2 | 75 | fl-services-layout.css processed, page-specific overrides preserved | 7 |
| 6 | As a user, I want use cases page to load efficiently, so I can browse case studies | 153.3 | 73 | fl-use-cases-layout.css consolidated, screenshot validation passed | 8 |
| 7 | As a developer, I want page 737 layout refactored, so I can eliminate duplicate margin rules | 153.6 | 75 | 737-layout.css processed, tests pass, zero visual regressions | 8 |
| 8 | As a user, I want services page to render quickly, so I can view service offerings | 153.2 | 75 | fl-services-layout.css consolidated, critical CSS preserved | 8 |
| 9 | As a developer, I want grid layout bundle cleaned, so I can understand grid structure | 133.2 | 39 | beaver-grid-layout.css processed, grid patterns documented | 8 |
| 10 | As a user, I want clients page to display properly, so I can review client testimonials | 126.0 | 55 | fl-clients-layout.css consolidated, visual tests green | 8 |

**Sprint Goal (Iteration 7-8)**:
Consolidate top 10 largest layout files (1.5MB+ of CSS), eliminating 60%+ duplication while maintaining zero visual changes.

---

## 📦 Product Backlog (Prioritized)

### Iteration 9-10: Medium-Priority Layouts

| Story | File | Size (KB) | Priority | Business Value |
|-------|------|-----------|----------|----------------|
| As a user, I want 404 error page to load instantly, so I can navigate back quickly | 404.css | 118.1 | Medium | Error handling UX improvement |
| As a developer, I want careers layout maintainable, so I can update job postings | fl-careers-layout.css | 88.2 | Medium | Recruitment page maintenance |
| As a user, I want homepage alternative styling preserved, so I can see design variations | homepage.css | 50.8 | Medium | A/B testing support |
| As a developer, I want layout2 variant consolidated, so I can choose between layout options | 3086-layout2.css | 127.9 | Medium | Design flexibility |

**Sprint Goal (Iteration 9-10)**:
Process medium-priority layouts (400KB+ CSS), establishing pattern for variant layout handling.

---

### Iteration 11-12: Critical CSS Files

| Story | File | Size (KB) | Priority | Business Value |
|-------|------|-----------|----------|----------------|
| As a user, I want homepage to appear instantly, so I can engage with content immediately | critical/homepage-critical.css | 46.2 | High | Critical rendering path optimization |
| As a user, I want careers page to load without flash of unstyled content | critical/single-careers.css | 48.5 | High | Above-the-fold rendering |
| As a developer, I want about-us critical CSS clean, so I can ensure instant page rendering | critical/about-us-critical.css | 38.9 | High | First paint performance |
| As a user, I want use cases page to display header instantly | critical/single-use-cases.css | 37.4 | High | Perceived performance |
| As a user, I want services detail page to render quickly | critical/single-services.css | 30.7 | High | Service page UX |

**Sprint Goal (Iteration 11-12)**:
Optimize critical CSS files (200KB+) for above-the-fold rendering, targeting <100ms first paint.

---

### Iteration 13-15: Low-Priority Components & Utilities

| Category | File Count | Total Size | Business Value |
|----------|------------|------------|----------------|
| Component Files | 45 files | ~250KB | Code organization, maintainability |
| Utility Files | 35 files | ~80KB | CSS architecture consistency |
| Dynamic/Runtime | 10 files | ~15KB | Runtime behavior correctness |
| Miscellaneous | 7 files | ~20KB | Edge case coverage |

**Sprint Goal (Iteration 13-15)**:
Complete comprehensive consolidation of all remaining CSS files, achieving 100% zero-duplication target.

---

## 🏆 Definition of Done (Global)

**For each CSS file consolidation, the following MUST be true**:

### Functional Requirements
- ✅ All duplicate CSS rules removed or consolidated
- ✅ Page-specific FL-node styles preserved in appropriate critical CSS
- ✅ BEM naming conventions applied where applicable
- ✅ CSS follows project architecture patterns

### Quality Gates
- ✅ `bin/rake test:critical` passes (100% green)
- ✅ Screenshot comparison shows 0% visual difference (tolerance: 0.0)
- ✅ Four-eyes approval obtained (Coder → Reviewer → Screenshot Guardian → Tester)
- ✅ Zero test smells introduced

### Documentation Requirements
- ✅ Consolidation recorded in tracking manifest
- ✅ Git commit describes changes and rationale
- ✅ Status updated in Product Backlog

### Compliance
- ✅ Refactoring definition upheld (EXACT functionality AND appearance preserved)
- ✅ No test baseline modifications
- ✅ TDD micro-refactoring cycle followed (<10 lines per change)

---

## 📈 Release Planning

### Release 1.0 (Iteration 10) - Core Layouts Complete
**Target**: Complete all high-priority layout files
**Deliverables**: 37 files consolidated, 2MB+ CSS optimized
**Business Value**: 40% page load improvement on major pages

### Release 2.0 (Iteration 12) - Critical CSS Optimized
**Target**: All critical CSS files processed
**Deliverables**: Above-the-fold rendering optimized
**Business Value**: <100ms first paint on all pages

### Release 3.0 (Iteration 15) - 100% Zero Duplication
**Target**: All 138 files processed
**Deliverables**: Complete CSS architecture consolidation
**Business Value**: Technical debt eliminated, maintenance effort reduced 60%

---

## 🔄 Processing Schedule

### Parallel Processing Opportunities

**Batch A (Can process simultaneously)**:
- Large layout files with distinct FL-node patterns (no shared components)
- Files: `fl-homepage-layout.css`, `fl-services-layout.css`, `fl-about-layout.css`
- Rationale: Different page contexts, minimal overlap

**Batch B (Must process sequentially)**:
- Bundle files that reference same components
- Files: All `-bundle.css` files
- Rationale: Shared component dependencies require sequential validation

**Batch C (Can process in parallel after Batch B)**:
- Component files with no cross-dependencies
- Files: All `components/*.css` files
- Rationale: Isolated component scope

### Realistic Sprint Velocity

**Current Velocity**: 1-2 files per iteration (conservative, includes full validation)
**Target Velocity**: 5-8 files per iteration (after establishing patterns)
**Estimated Completion**: Iteration 15 (8 weeks from Iteration 7)

**Acceleration Strategy**:
- Iterations 7-8: Establish consolidation patterns (2 files/iteration)
- Iterations 9-12: Increase to 5 files/iteration with pattern reuse
- Iterations 13-15: Batch process utilities/components (10+ files/iteration)

---

## 🎯 Updated Goal Statement

**Original Goal**: "Process ALL CSS files until zero duplication"

**Refined Goal**:
"Systematically consolidate all 138 unprocessed CSS files across 15 iterations, eliminating 100% of CSS duplication while maintaining zero visual regressions and 100% test coverage, resulting in 60% reduction in CSS size, 40% improvement in page load times, and 60% reduction in maintenance effort."

---

## 🚨 Risk Register

### High-Impact Risks

| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|---------------------|
| Visual regression in footer/core values | Low (addressed) | Critical | Mandatory screenshot validation with 0.0 tolerance |
| Test failures during consolidation | Medium | High | TDD micro-cycles, rollback on any red test |
| Page-specific overrides lost | Medium | High | Four-eyes validation of FL-node preservation |
| Bundle dependency conflicts | Medium | Medium | Sequential processing of interdependent bundles |
| Performance regression | Low | High | Critical CSS integrity checks, load time monitoring |

### Medium-Impact Risks

| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|---------------------|
| Incomplete duplication detection | Medium | Medium | Automated duplication analysis before each file |
| Scope creep (new features during refactor) | Low | Medium | Strict refactoring definition enforcement |
| Team burnout from repetitive work | Medium | Low | Graduated spawning (solo for repetitive work) |
| Stakeholder expectation mismatch | Low | Medium | Weekly progress reports with metrics |

---

## 📊 Metrics & KPIs

### Leading Indicators (Track Weekly)
- Files processed per iteration
- Average duplication reduction per file
- Test pass rate (target: 100%)
- Screenshot validation success rate (target: 100%)

### Lagging Indicators (Track Monthly)
- Total CSS size reduction (target: 60%)
- Page load time improvement (target: 40%)
- Maintenance effort reduction (target: 60%)
- Technical debt score (target: zero)

---

## 🔗 Related Documentation

- **CSS Tracking Manifest**: `/tmp/css_tracking.csv`
- **Visual Testing Workflows**: `/projects/jt_site/docs/visual_testing_delegation_workflows.md`
- **TDD Enforcement**: `/projects/jt_site/docs/60.03-tdd-quality-enforcement.md`
- **Test Format Requirements**: `/projects/jt_site/docs/60.06-test-format-requirements-reference.md`
- **Global TDD Methodology**: `/knowledge/20.01-tdd-methodology-reference.md`

---

## 📝 Stakeholder Communication

### Weekly Sprint Review (Every Iteration)
- Demo consolidated pages with visual comparison
- Review metrics: files processed, duplication eliminated
- Gather feedback on page rendering quality
- Adjust priorities based on business needs

### Monthly Roadmap Review
- Review release progress against plan
- Adjust velocity estimates based on actual performance
- Discuss scope adjustments if needed
- Celebrate team achievements

---

**Next Steps**:
1. ✅ Tracking system established
2. ⏳ Begin Iteration 7: Process `fl-homepage-layout.css` (292.4KB, 125 FL nodes)
3. ⏳ Validate with screenshot guardian (tolerance: 0.0)
4. ⏳ Commit on green tests
5. ⏳ Continue to next file in sprint backlog

**Product Owner Commitment**:
I will prioritize ruthlessly, communicate clearly, and make decisive trade-off decisions to ensure this consolidation delivers maximum business value while maintaining uncompromising quality standards.
