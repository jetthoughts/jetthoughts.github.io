# UI/UX Minimal Improvements Plan

**Created**: 2026-04-14  
**Branch**: `chore/ui-ux-wordpress-migration-fixes`  
**Goal**: Simple visual improvements after WordPress migration  
**Design Reference**: Stitch project `11438841921499861157` (Obsidian Ruby theme)

---

## Design System (from Stitch)

**Theme Name**: Obsidian Ruby  
**Colors**:
- Background: `#111125` (obsidian dark)
- Surface: `#1a1a2e` (raised containers)
- Primary accent: `#cc342d` (Ruby red)
- Text: `#e2e0fc` (light purple-white)

**Typography**:
- Headlines: Manrope (geometric, authoritative)
- Body: Inter (highly readable)
- Negative letter-spacing for headlines: `-0.02em`
- Increased line-height for body: `1.7`

**Design Rules**:
- NO borders for sectioning - use background color shifts
- Glassmorphism for floating elements (70% opacity + backdrop-blur)
- Ruby red ONLY for critical actions and brand signals

---

## Priority Fixes (Simple → Complex)

### Fix 1: Typography Consistency (HIGH PRIORITY)
**Issue**: Fonts not consistent with design system  
**Location**: `themes/beaver/assets/css/critical/base.css`  
**Changes**:
- Add Google Fonts import for Manrope and Inter
- Set font-family on body and headings
- Adjust letter-spacing and line-height

**Estimated Impact**: Immediate visual improvement across all pages  
**Risk**: LOW - only affects typography  
**Files Modified**: 1 (base.css)

---

### Fix 2: Color Scheme Application (HIGH PRIORITY)
**Issue**: Colors not matching obsidian ruby theme  
**Location**: `themes/beaver/assets/css/skin-65eda28877e04.css`  
**Changes**:
- Update primary colors to use `#cc342d` (Ruby red)
- Update background to `#111125` (obsidian)
- Update text color to `#e2e0fc`

**Estimated Impact**: Complete visual transformation  
**Risk**: MEDIUM - affects all pages, but CSS cascade preserved  
**Files Modified**: 1 (skin file)

---

### Fix 3: Spacing & Layout Cleanup (MEDIUM PRIORITY)
**Issue**: WordPress remnants causing spacing inconsistencies  
**Location**: `themes/beaver/assets/css/style.css`  
**Changes**:
- Remove `.wp-caption`, `.wp-block-*` spacing overrides
- Standardize paragraph margins to `1.5rem`
- Standardize heading margins to `2rem` top, `1rem` bottom

**Estimated Impact**: Cleaner, more consistent layout  
**Risk**: LOW - only removes WordPress artifacts  
**Files Modified**: 1 (style.css)

---

### Fix 4: Mobile Responsiveness (MEDIUM PRIORITY)
**Issue**: Mobile breakpoints not optimized  
**Location**: `themes/beaver/assets/css/beaver-grid-layout.css`  
**Changes**:
- Verify mobile breakpoints at 768px and 480px
- Ensure typography scales down properly
- Test navigation collapses on mobile

**Estimated Impact**: Better mobile experience  
**Risk**: LOW - only adjusts existing breakpoints  
**Files Modified**: 1 (beaver-grid-layout.css)

---

### Fix 5: WordPress Visual Artifacts (LOW PRIORITY)
**Issue**: Visible WordPress UI remnants  
**Location**: Various CSS files  
**Changes**:
- Hide or remove `.fl-builder` admin artifacts
- Clean up unused Beaver Builder classes
- Remove legacy WordPress pagination styles

**Estimated Impact**: Cleaner, more professional appearance  
**Risk**: LOW - removing unused styles  
**Files Modified**: 2-3 (skin.css, style.css)

---

## Implementation Order

1. **Fix 1**: Typography (base.css) → Test → Commit
2. **Fix 2**: Colors (skin file) → Test → Commit
3. **Fix 3**: Spacing (style.css) → Test → Commit
4. **Fix 4**: Mobile (grid-layout.css) → Test → Commit
5. **Fix 5**: WordPress cleanup → Test → Commit

**Total Commits**: 5 micro-commits  
**Total Time**: < 30 minutes  
**Validation**: Visual regression testing after each commit

---

## Validation Protocol

After EACH fix:
1. Run `bin/hugo-build` to verify build
2. Check Chrome DevTools console for errors (ZERO tolerance)
3. Check Network tab for 404s (ZERO tolerance)
4. Capture desktop + mobile screenshots
5. Compare with baseline (tolerance: 0.0 for refactoring)

---

## Constraints

- **NO new CSS files** - modify existing files only
- **Preserve CSS cascade order** - Critical → Layout → Component → Theme → Footer
- **NO vendor file modifications** - `css/vendors/*.min.css` are off-limits
- **Preserve `.fl-node-*` selectors** - page-specific layouts depend on them
- **Test both desktop and mobile** - responsive design required

---

## Success Criteria

- ✅ Typography consistent across all pages
- ✅ Color scheme matches Obsidian Ruby design
- ✅ No visible WordPress artifacts
- ✅ Mobile layout clean and readable
- ✅ Zero build errors
- ✅ Zero console errors
- ✅ Zero visual regressions (tolerance: 0.0)

---

**Next Step**: Implement Fix 1 (Typography)
