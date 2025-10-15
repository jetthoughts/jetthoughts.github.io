# CSS Pattern Extraction Plan - Next 20 Commits
**Analysis Date**: 2025-10-15
**Progress**: 9/128 commits completed (326 lines removed)
**Target**: Phase 1 completion (119 remaining commits)

## Executive Summary

**HIGH-IMPACT PATTERNS IDENTIFIED**: 5 major pattern categories with 400+ extractable lines

### Pattern Priority Matrix

| Pattern | Occurrences | Lines/Instance | Total Lines | Priority | Risk |
|---------|-------------|----------------|-------------|----------|------|
| 1. Responsive Visibility Blocks | 10 nodes | ~58 lines | ~580 lines | **HIGH** | LOW |
| 2. Equal-Height Flex Containers | 10 nodes | ~15 lines | ~150 lines | **HIGH** | LOW |
| 3. PP-Infobox Node Styles | 10 nodes | ~31 lines | ~310 lines | MEDIUM | MEDIUM |
| 4. Media Query Breakpoints | 90 blocks | Variable | ~270 lines | MEDIUM | HIGH |
| 5. Display Flex Patterns | 66 instances | ~3 lines | ~198 lines | LOW | LOW |

---

## PRIORITY 1: Responsive Visibility Blocks (Commits 10-19)
**Impact**: 580 lines removed, 10 commits
**Risk**: LOW - Simple, repetitive patterns
**Technique**: Mixin extraction with node ID parameter

### Pattern Structure
Each node has identical 58-line responsive visibility block:
```css
/* Lines 5689-5749: Node dxali8vntcr0 example */
.fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-large,
.fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-medium,
.fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-mobile {
  display: none;
}

.fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-desktop {
  display: flex;
}

@media only screen and (max-width: 1200px) {
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-desktop {
    display: none;
  }
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-large {
    display: flex;
  }
}

@media only screen and (max-width: 1115px) {
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-desktop {
    display: none;
  }
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-large {
    display: none;
  }
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-medium {
    display: flex;
  }
}

@media only screen and (max-width: 860px) {
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-desktop {
    display: none;
  }
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-large {
    display: none;
  }
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-medium {
    display: none;
  }
  .fl-col-group-equal-height .fl-node-{NODE_ID}.fl-visible-mobile {
    display: flex;
  }
}
```

### Affected Nodes (Line Numbers)
1. **dxali8vntcr0**: Lines 5689-5749 (58 lines)
2. **075ztwhd3cxn**: Lines 5947-6007 (58 lines)
3. **lajty926uxf5**: Lines 6205-6265 (58 lines)
4. **do5fjakv8b29**: Lines 6483-6543 (58 lines)
5. **3eq5kcmfz0an**: Lines 6741-6801 (58 lines)
6. **v3gpr4klqmob**: Lines 6999-7059 (58 lines)
7. **5oyrwk91ufhg**: Lines 8994-9054 (58 lines)
8. **5b7e9qxr14h8**: Lines 9200-9260 (58 lines)
9. **gyioc8tzs3nr**: Lines 9406-9466 (58 lines)
10. **woz0n3a5ep9x**: Lines 9612-9672 (58 lines)

### Recommended Mixin (PostCSS)
```css
@define-mixin responsive-visibility $nodeId {
  .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-large,
  .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-medium,
  .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-mobile {
    display: none;
  }

  .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-desktop {
    display: flex;
  }

  @media only screen and (max-width: 1200px) {
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-desktop { display: none; }
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-large { display: flex; }
  }

  @media only screen and (max-width: 1115px) {
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-desktop { display: none; }
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-large { display: none; }
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-medium { display: flex; }
  }

  @media only screen and (max-width: 860px) {
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-desktop { display: none; }
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-large { display: none; }
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-medium { display: none; }
    .fl-col-group-equal-height .fl-node-$(nodeId).fl-visible-mobile { display: flex; }
  }
}
```

### Extraction Commands (Commits 10-19)
```bash
# Commit 10: Extract dxali8vntcr0 (Lines 5689-5749)
sed -i '5689,5749d' 590-layout.css
echo '@mixin responsive-visibility dxali8vntcr0;' >> 590-layout.css

# Commit 11: Extract 075ztwhd3cxn (Lines ~5889-5947) [line numbers shift after previous deletion]
# ... repeat for each node
```

---

## PRIORITY 2: Equal-Height Flex Containers (Commits 20-29)
**Impact**: 150 lines removed, 10 commits
**Risk**: LOW - Highly repetitive pattern

### Pattern Structure
Each node has identical 15-line equal-height flexbox declaration:
```css
/* Lines 5672-5687: Node dxali8vntcr0 example */
.fl-col-group-equal-height .fl-node-{NODE_ID},
.fl-col-group-equal-height .fl-node-{NODE_ID} .fl-module-content,
.fl-col-group-equal-height .fl-node-{NODE_ID} .fl-module-content .pp-infobox-wrap,
.fl-col-group-equal-height .fl-node-{NODE_ID} .fl-module-content .pp-infobox-wrap .pp-infobox,
.fl-col-group-equal-height .fl-node-{NODE_ID} .fl-module-content .pp-infobox-wrap > .pp-infobox-link,
.fl-col-group-equal-height .fl-node-{NODE_ID} .fl-module-content .pp-infobox-wrap > .pp-more-link {
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -webkit-flex-direction: column;
  -ms-flex-direction: column;
  flex-direction: column;
  flex-shrink: 1;
  min-width: 1px;
  max-width: 100%;
  -webkit-box-flex: 1 1 auto;
  -moz-box-flex: 1 1 auto;
  -webkit-flex: 1 1 auto;
  -ms-flex: 1 1 auto;
  flex: 1 1 auto;
}
```

### Affected Nodes (Line Numbers)
1. **dxali8vntcr0**: Line 5672 (15 lines)
2. **075ztwhd3cxn**: Line 5930 (15 lines)
3. **lajty926uxf5**: Line 6188 (15 lines)
4. **do5fjakv8b29**: Line 6466 (15 lines)
5. **3eq5kcmfz0an**: Line 6724 (15 lines)
6. **v3gpr4klqmob**: Line 6982 (15 lines)
7. **5oyrwk91ufhg**: Line 8977 (15 lines)
8. **5b7e9qxr14h8**: Line 9183 (15 lines)
9. **gyioc8tzs3nr**: Line 9389 (15 lines)
10. **woz0n3a5ep9x**: Line 9595 (15 lines)

### Recommended Mixin
```css
@define-mixin equal-height-flex $nodeId {
  .fl-col-group-equal-height .fl-node-$(nodeId),
  .fl-col-group-equal-height .fl-node-$(nodeId) .fl-module-content,
  .fl-col-group-equal-height .fl-node-$(nodeId) .fl-module-content .pp-infobox-wrap,
  .fl-col-group-equal-height .fl-node-$(nodeId) .fl-module-content .pp-infobox-wrap .pp-infobox,
  .fl-col-group-equal-height .fl-node-$(nodeId) .fl-module-content .pp-infobox-wrap > .pp-infobox-link,
  .fl-col-group-equal-height .fl-node-$(nodeId) .fl-module-content .pp-infobox-wrap > .pp-more-link {
    display: flex;
    flex-direction: column;
    flex-shrink: 1;
    min-width: 1px;
    max-width: 100%;
    flex: 1 1 auto;
    /* Vendor prefixes handled by autoprefixer */
  }
}
```

---

## PRIORITY 3: PP-Infobox Node-Specific Styles (Commits 30-39)
**Impact**: 310 lines removed, 10 commits
**Risk**: MEDIUM - Requires careful property inspection

### Pattern Overview
Each node has ~31 lines of repetitive infobox styling:
- Title/description colors and spacing
- Hover states
- Image/icon styling
- Border radius
- Link styling

### Sample Pattern (Node dxali8vntcr0, Lines 5751-5844)
```css
.fl-node-{NODE_ID} .pp-infobox .pp-infobox-title-prefix {
  display: none;
}

.fl-node-{NODE_ID} .pp-infobox-title-wrapper .pp-infobox-title {
  color: #ffffff;
  margin-top: 30px;
  margin-bottom: 0px;
}

.fl-node-{NODE_ID} .pp-infobox-title-wrapper .pp-infobox-title a {
  color: #ffffff;
}

.fl-node-{NODE_ID} .pp-infobox-description {
  color: #ffffff;
  margin-top: 15px;
  margin-bottom: 0px;
}

/* ... hover states, image styling, etc. */
```

### Recommended Approach
**CAUTION**: Colors and spacing vary slightly between nodes. Requires:
1. **Property normalization audit** before extraction
2. **CSS custom properties** for variable values
3. **Progressive extraction** - start with most common properties

### Commits 30-34: Common Properties (5 commits, ~15 lines each)
Extract only properties that are 100% identical across all 10 nodes:
- `.pp-infobox-title-prefix { display: none; }`
- Image max-width/height rules
- Base flexbox alignment properties

### Commits 35-39: Variable Properties (5 commits, ~16 lines each)
Extract properties with variable values using CSS custom properties:
```css
@define-mixin infobox-colors $nodeId, $textColor, $hoverColor {
  .fl-node-$(nodeId) .pp-infobox-title-wrapper .pp-infobox-title {
    color: var(--node-text-color, $(textColor));
  }
  .fl-node-$(nodeId) .pp-infobox .pp-infobox-title:hover {
    color: var(--node-hover-color, $(hoverColor));
  }
}
```

---

## Summary Statistics

### Lines Saved by Priority
- **Priority 1** (Commits 10-19): 580 lines
- **Priority 2** (Commits 20-29): 150 lines
- **Priority 3** (Commits 30-39): 310 lines
- **Total (Next 30 commits)**: 1,040 lines removed

### Timeline Estimate
- **Commits 10-19**: 3-4 days (responsive visibility)
- **Commits 20-29**: 2-3 days (equal-height flex)
- **Commits 30-39**: 4-5 days (infobox styles, requires normalization)
- **Total Phase 1**: ~10-12 days to complete 119 remaining commits

### Risk Assessment
- ✅ **Low Risk**: Priorities 1 & 2 (730 lines, 20 commits)
- ⚠️ **Medium Risk**: Priority 3 (310 lines, 10 commits) - requires property audit

---

## Next Actions

### Immediate (Next Session)
1. **Validate mixin syntax** with PostCSS setup
2. **Test extraction** on first node (dxali8vntcr0) for each priority
3. **Document line number shifts** after each deletion

### Short-term (This Week)
1. Complete Priority 1 (Commits 10-19)
2. Start Priority 2 (Commits 20-29)

### Medium-term (Next 2 Weeks)
1. Complete Priority 2 (Commits 20-29)
2. Audit infobox properties for Priority 3
3. Begin Priority 3 extraction (Commits 30-39)

---

## Pattern Research Completion

**Analysis Coverage**: 100% of file (12,737 lines)
**Patterns Identified**: 5 major categories
**Extraction Roadmap**: 30 commits (1,040 lines)
**Confidence Level**: HIGH for Priorities 1-2, MEDIUM for Priority 3

**Researcher**: CSS Pattern Researcher
**Handoff**: Ready for implementation by CSS Coder
**Documentation**: Stored in `/projects/jt_site/_runtime/css-analysis/next-patterns.md`
