# Critical CSS Migration Prototype: About-Us Template

**Status**: ✅ PROTOTYPE COMPLETE - READY FOR REVIEW
**Date**: 2025-10-14
**Next Action**: Team review before implementation

---

## What Was Created

Three comprehensive prototype documents for migrating About-Us template to direct critical CSS include pattern:

### 1. **Migration Plan** (`prototype-about-us-critical-css-migration.md`)
- Complete migration strategy following home.html proven pattern
- Risk assessment (low/medium risk factors)
- Test validation checklist with pre/post migration steps
- Four-eyes approval protocol
- Success criteria (functional, performance, visual)
- Rollback plan and file references

### 2. **Before/After Diff** (`prototype-about-us-before-after-diff.md`)
- Side-by-side template comparison (BEFORE vs AFTER)
- Detailed change summary (removed, added, preserved)
- Resource load order comparison
- Page-specific CSS preservation validation points
- Implementation steps (reference only - NOT to execute yet)
- Complete rollback instructions

### 3. **Quick Checklist** (`prototype-migration-quick-checklist.md`)
- Numbered step-by-step checklist (15 steps)
- Pre-migration, implementation, validation sections
- Four-eyes approval checklist with blocking conditions
- Commit message template
- Rollback checklist
- Success criteria summary

---

## Key Findings from Analysis

### About-Us Template Characteristics

**Complexity**: Medium (simpler than homepage, but has unique sections)

**Current Structure**:
- Uses header block for CSS loading (old pattern)
- Loads critical CSS via partial wrapper (`about-us.html`)
- 483 lines of main content
- Includes: Hero, Mission, Culture, Core Values, Achievements, Testimonials, CTA

**Critical CSS Size**: 1850 lines (larger than homepage)

**Page-Specific Styles to Preserve**:
- 10+ `.fl-node-*` styles for layout and sections
- Two-column Mission/Culture layout (50%/50%)
- Core Values grid layout
- Blue headline colors (#1a8cff)
- Hero image border-radius
- Layout-critical flex and positioning rules

### Migration Pattern (Following home.html)

**Changes Required**:
1. Empty header block (remove CSS loading)
2. Add footer block with comprehensive resource list
3. Direct critical CSS includes:
   - `base-critical.html` (FIRST - inline base critical)
   - `about-us-critical.css` (SECOND - page-specific critical)
   - All existing non-critical CSS (SAME ORDER)

**No Changes Required**:
- Main content block (ALL 483 lines unchanged)
- Critical CSS files themselves (no modifications)
- Page-specific .fl-node-* styles (must be preserved)
- JSON-LD and SEO schema partials

---

## Risk Assessment

### Low Risk Factors ✅
1. **Proven Pattern**: Home template already migrated successfully
2. **No CSS File Changes**: Critical CSS files untouched
3. **Order Preserved**: CSS load order maintained exactly
4. **Cache Keys Same**: Bundle naming preserved

### Medium Risk Factors ⚠️
1. **Page Complexity**: Mission/Culture/Values unique sections
2. **Large Critical CSS**: 1850 lines (vs ~1000 for homepage)
3. **FlNode Dependencies**: Many page-specific .fl-node-* styles

### Mitigation Strategies 🛡️
1. **Zero Tolerance**: tolerance: 0.0 for visual changes (BLOCKING)
2. **Mandatory Baselines**: Pre-migration screenshot capture required
3. **Four-Eyes Validation**: ALL four approvals required (Coder, Reviewer, Screenshot Guardian, Tester)
4. **Screenshot Guardian**: ABSOLUTE blocking authority on visual changes >0%
5. **Rollback Ready**: Backup template for instant rollback

---

## Validation Gates (ALL MUST PASS)

### Pre-Migration Gates ✅
- [ ] Baseline screenshots captured with tolerance: 0.0
- [ ] Backup template created (about.html.backup)
- [ ] Page-specific CSS identified and documented

### Implementation Gates ✅
- [ ] Template changes applied following EXACT pattern
- [ ] Build succeeds: `bin/hugo-build`
- [ ] No build errors or warnings

### Post-Migration Gates ✅
- [ ] Tests pass: `bin/rake test:critical` (0 failures)
- [ ] Visual regression: 0% difference from baseline
- [ ] Performance maintained: Lighthouse ≥95
- [ ] Manual inspection: All sections render correctly

### Approval Gates (BLOCKING) 🛡️
- [ ] Coder approval: CSS preservation validated
- [ ] Reviewer approval: Pattern compliance validated
- [ ] **Screenshot Guardian approval: 0% visual difference (ABSOLUTE BLOCK)**
- [ ] Tester approval: Tests pass, baselines preserved

**CRITICAL**: Screenshot Guardian has VETO power. ANY visual change >0% = IMMEDIATE STOP, revert, investigate.

---

## Four-Eyes Behavioral Protocol

### Coder Behavioral Constraints
**Pre-Implementation**:
- "Did I capture baseline screenshots? → NO = STOP, CAPTURE FIRST"
- "Did I identify ALL .fl-node-* styles? → NO = STOP, ANALYZE FIRST"
- "Did I validate CSS preservation requirements? → NO = STOP, VALIDATE FIRST"

**During Implementation**:
- "Removing .fl-node-* styles → IMMEDIATE STOP, REVERT"
- "Removing page-specific overrides → IMMEDIATE STOP, REVERT"
- "Changing CSS load order → IMMEDIATE STOP, REVERT"

**Post-Implementation**:
- "Run bin/rake test:critical → MUST PASS"
- "Compare screenshots tolerance: 0.0 → MUST show 0% difference"
- "Self-review complete → PROCEED to Reviewer"

### Screenshot Guardian Mandate (ABSOLUTE)
**Authority**: BLOCKING - can VETO all other approvals
**Tolerance**: 0.0 for refactoring (ZERO visual changes allowed)
**Protocol**:
1. Capture baseline screenshots BEFORE any changes
2. Capture new screenshots AFTER changes
3. Calculate pixel-by-pixel difference per page
4. Report exact percentage difference
5. **DECISION**:
   - 0% difference → APPROVE
   - >0% difference → **ABSOLUTE BLOCK** → revert → investigate

---

## Success Criteria (ALL Required)

### Functional Requirements
- [ ] About-Us page renders identically to baseline
- [ ] Hero section displays correctly
- [ ] Mission & Culture sections display (two columns)
- [ ] Core Values section displays (three cards)
- [ ] Achievements counters animate
- [ ] Testimonials carousel functions
- [ ] CTA section displays correctly
- [ ] Navigation works properly
- [ ] Mobile responsive behavior maintained

### Performance Requirements
- [ ] Lighthouse score ≥95 (maintain or improve)
- [ ] First Contentful Paint ≤2.5s (maintain or improve)
- [ ] Largest Contentful Paint ≤2.5s (maintain or improve)
- [ ] Cumulative Layout Shift ≤0.1 (maintain or improve)

### Visual Requirements (BLOCKING)
- [ ] Screenshot Guardian approval: 0% difference (ABSOLUTE)
- [ ] bin/rake test:critical: 0 failures
- [ ] No layout shifts during load
- [ ] No missing elements
- [ ] No styling regressions

---

## Next Steps (TEAM REVIEW REQUIRED)

### 1. Review Prototype Documents ✅
**Action**: Team review of all three prototype documents
**Participants**: Lead developer, QA lead, DevOps lead
**Decision**: Approve migration plan OR request modifications

### 2. Baseline Capture (If Approved) 📸
```bash
bin/rake test:critical
# Capture baseline screenshots, Lighthouse scores, performance metrics
# Store results for comparison
```

### 3. Implementation (If Approved) ✏️
```bash
# Backup current template
cp themes/beaver/layouts/page/about.html themes/beaver/layouts/page/about.html.backup

# Apply changes from prototype-about-us-before-after-diff.md
# (Manual edit following EXACT pattern)
```

### 4. Validation (Mandatory) 🧪
```bash
# Build and test
bin/hugo-build
bin/rake test:critical

# Compare screenshots (tolerance: 0.0)
# Validate performance (Lighthouse ≥95)
# Manual visual inspection
```

### 5. Four-Eyes Approval (Sequential) ✅
1. Coder self-review and approval
2. Reviewer pattern compliance validation
3. **Screenshot Guardian visual validation (BLOCKING)**
4. Tester functional and regression validation

### 6. Commit (Only if ALL gates pass) ✅
```bash
git add themes/beaver/layouts/page/about.html
git commit -F commit-message.txt
# (Use commit template from quick-checklist.md)
```

---

## Files Created

### Prototype Documentation
1. `docs/prototype-about-us-critical-css-migration.md` - Complete migration plan
2. `docs/prototype-about-us-before-after-diff.md` - Detailed before/after comparison
3. `docs/prototype-migration-quick-checklist.md` - Step-by-step implementation checklist
4. `docs/PROTOTYPE-MIGRATION-SUMMARY.md` - This summary document

### Templates Referenced
- `themes/beaver/layouts/home.html` - Proven migration pattern (reference)
- `themes/beaver/layouts/page/about.html` - Target template (to be migrated)
- `themes/beaver/layouts/partials/header/critical/about-us.html` - Current wrapper (to deprecate)

### CSS Files Referenced (UNCHANGED)
- `themes/beaver/layouts/partials/header/critical/base-critical.html` - Base critical CSS
- `themes/beaver/assets/css/critical/about-us-critical.css` - Page-specific critical CSS (1850 lines)

---

## Decision Required

**Team Decision Needed**: Approve prototype and proceed with migration?

**Options**:
1. ✅ **APPROVE**: Proceed with baseline capture and implementation
2. 🔄 **MODIFY**: Request changes to migration approach
3. ❌ **REJECT**: Do not proceed with this migration (document reasons)

**Decision Date**: _______________
**Decision**: _______________
**Approved By**: _______________

---

## Notes

- **NO CHANGES COMMITTED**: All work is prototype documentation only
- **NO BUILD MODIFICATIONS**: No files modified in codebase
- **REVERSIBLE**: All documentation can be discarded if approach rejected
- **REUSABLE**: Pattern applicable to other templates (services, careers, etc.)

---

## Contact

For questions or clarification on this prototype:
- Review prototype documents in `docs/` directory
- Reference home.html migration as proven pattern
- Consult Screenshot Guardian for visual validation protocol
- Review CLAUDE.md for complete refactoring safeguards
