# CSS Pattern Extraction - Quick Reference Guide

## Copy-Paste Commands for Next 20 Commits

### Priority 1: Responsive Visibility (Commits 10-19)

**Pattern**: 10 nodes × 58 lines = 580 lines removed

#### Step 1: Create Mixin File
```bash
# Create mixins directory
mkdir -p themes/beaver/assets/css/mixins

# Create responsive-visibility mixin
cat > themes/beaver/assets/css/mixins/responsive-visibility.css << 'EOF'
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
EOF
```

#### Step 2: Import Mixin in 590-layout.css
```css
/* Add at top of file after existing imports */
@import "mixins/responsive-visibility.css";
```

#### Commits 10-19: Node-by-Node Extraction

**COMMIT 10**: Node dxali8vntcr0
```bash
# Delete lines 5689-5749 (61 lines including alignment rules)
# Replace with mixin call
@mixin responsive-visibility dxali8vntcr0;
```
**Lines removed**: 61 | **Lines added**: 1 | **Net**: -60 lines

**COMMIT 11**: Node 075ztwhd3cxn
```bash
# After commit 10, line numbers shift down by ~60
# New location: ~5887 (was 5947)
# Delete ~61 lines, replace with:
@mixin responsive-visibility 075ztwhd3cxn;
```
**Lines removed**: 61 | **Lines added**: 1 | **Net**: -60 lines

**COMMIT 12**: Node lajty926uxf5
```bash
# New location: ~5825 (was 6205 - 120)
@mixin responsive-visibility lajty926uxf5;
```

**COMMIT 13**: Node do5fjakv8b29
**COMMIT 14**: Node 3eq5kcmfz0an
**COMMIT 15**: Node v3gpr4klqmob
**COMMIT 16**: Node 5oyrwk91ufhg
**COMMIT 17**: Node 5b7e9qxr14h8
**COMMIT 18**: Node gyioc8tzs3nr
**COMMIT 19**: Node woz0n3a5ep9x

**Cumulative**: ~600 lines removed, ~10 lines added = **-590 net lines**

---

### Priority 2: Equal-Height Flex (Commits 20-29)

**Pattern**: 10 nodes × 15 lines = 150 lines removed

#### Step 1: Create Equal-Height Mixin
```bash
cat > themes/beaver/assets/css/mixins/equal-height-flex.css << 'EOF'
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
  }
}
EOF
```

#### Step 2: Import Mixin
```css
@import "mixins/equal-height-flex.css";
```

#### Commits 20-29: Extract Equal-Height Patterns

**Original Line Numbers** (before any deletions):
1. dxali8vntcr0: 5672
2. 075ztwhd3cxn: 5930
3. lajty926uxf5: 6188
4. do5fjakv8b29: 6466
5. 3eq5kcmfz0an: 6724
6. v3gpr4klqmob: 6982
7. 5oyrwk91ufhg: 8977
8. 5b7e9qxr14h8: 9183
9. gyioc8tzs3nr: 9389
10. woz0n3a5ep9x: 9595

**COMMIT 20-29**: Replace each 15-line block with:
```css
@mixin equal-height-flex {NODE_ID};
```

**Cumulative**: ~150 lines removed, ~10 lines added = **-140 net lines**

---

## Line Number Tracking Strategy

### Challenge
After each deletion, all subsequent line numbers shift up.

### Solution
1. **Work from bottom to top** - Extract highest line numbers first
2. **OR: Use search-and-replace** instead of line numbers
3. **OR: Automated script** (see below)

### Automated Extraction Script (RECOMMENDED)
```bash
#!/bin/bash
# extract-patterns.sh

NODES=(
  "dxali8vntcr0"
  "075ztwhd3cxn"
  "lajty926uxf5"
  "do5fjakv8b29"
  "3eq5kcmfz0an"
  "v3gpr4klqmob"
  "5oyrwk91ufhg"
  "5b7e9qxr14h8"
  "gyioc8tzs3nr"
  "woz0n3a5ep9x"
)

for node in "${NODES[@]}"; do
  # Find and delete responsive visibility block
  perl -i -0777 -pe "s/\.fl-col-group-equal-height \.fl-node-$node\.fl-visible-large.*?(?=\n\.fl-node-)/\@mixin responsive-visibility $node;\n\n/gs" \
    themes/beaver/assets/css/590-layout.css

  git add -A
  git commit -m "refactor(css): extract responsive-visibility for node $node

- Remove 58 lines of duplicated responsive visibility rules
- Replace with @mixin responsive-visibility call
- Net reduction: 57 lines

Part of systematic CSS pattern extraction initiative.
Tracking: Phase 1, Commits 10-19"
done
```

---

## Verification Commands

### After Each Commit
```bash
# Verify file still compiles
npm run build:css

# Check line count reduction
wc -l themes/beaver/assets/css/590-layout.css

# Verify visual regression tests pass
npm run test:visual
```

### After Batch (Every 5 Commits)
```bash
# Full visual regression test
npm run test:visual:full

# Check CSS output size
ls -lh public/css/590-layout.css

# Verify no syntax errors
npx stylelint themes/beaver/assets/css/590-layout.css
```

---

## Progress Tracking

### Commits 10-19 (Priority 1)
- [ ] Commit 10: dxali8vntcr0 (Lines 5689-5749)
- [ ] Commit 11: 075ztwhd3cxn (Lines ~5887)
- [ ] Commit 12: lajty926uxf5 (Lines ~5825)
- [ ] Commit 13: do5fjakv8b29 (Lines ~5763)
- [ ] Commit 14: 3eq5kcmfz0an (Lines ~5701)
- [ ] Commit 15: v3gpr4klqmob (Lines ~5639)
- [ ] Commit 16: 5oyrwk91ufhg (Lines ~5577)
- [ ] Commit 17: 5b7e9qxr14h8 (Lines ~5515)
- [ ] Commit 18: gyioc8tzs3nr (Lines ~5453)
- [ ] Commit 19: woz0n3a5ep9x (Lines ~5391)

**Expected Result**: ~600 lines removed

### Commits 20-29 (Priority 2)
- [ ] Commit 20: woz0n3a5ep9x equal-height (work bottom-to-top)
- [ ] Commit 21: gyioc8tzs3nr equal-height
- [ ] Commit 22: 5b7e9qxr14h8 equal-height
- [ ] Commit 23: 5oyrwk91ufhg equal-height
- [ ] Commit 24: v3gpr4klqmob equal-height
- [ ] Commit 25: 3eq5kcmfz0an equal-height
- [ ] Commit 26: do5fjakv8b29 equal-height
- [ ] Commit 27: lajty926uxf5 equal-height
- [ ] Commit 28: 075ztwhd3cxn equal-height
- [ ] Commit 29: dxali8vntcr0 equal-height

**Expected Result**: ~150 lines removed

---

## Git Commit Message Template

```
refactor(css): extract {PATTERN_NAME} for node {NODE_ID}

- Remove {N} lines of duplicated {pattern description}
- Replace with @mixin {mixin-name} call
- Net reduction: {N-1} lines

Part of systematic CSS pattern extraction initiative.
Tracking: Phase 1, Commit {N}/128
```

---

## Quick Stats

| Metric | Priority 1 | Priority 2 | Combined |
|--------|-----------|-----------|----------|
| Commits | 10 | 10 | 20 |
| Lines Removed | ~600 | ~150 | ~750 |
| Lines Added | ~10 | ~10 | ~20 |
| Net Reduction | ~590 | ~140 | ~730 |
| Estimated Time | 3-4 days | 2-3 days | 5-7 days |

**Current Progress**: 9/128 commits (7%)
**After Commit 29**: 29/128 commits (23%)
**Remaining for Phase 1**: 99 commits (77%)

---

## Handoff Checklist

- [x] Pattern analysis complete
- [x] Line numbers documented
- [x] Mixin syntax defined
- [x] Extraction commands provided
- [x] Verification steps documented
- [x] Progress tracking template created
- [ ] Mixin files created (implementation step)
- [ ] First extraction tested (implementation step)
- [ ] Visual regression baseline updated (implementation step)

**Next Step**: CSS Coder implements Commit 10 with full verification
