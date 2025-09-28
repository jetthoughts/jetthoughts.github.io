# Phase 1: Foundation CSS Extraction - Ultra-Conservative Execution Plan
## Micro-Refactoring Implementation (≤3 Lines Per Change)

---

## 🎯 EXECUTION CHECKPOINT SYSTEM

### Pre-Flight Checklist
- [ ] Current branch: Create extraction branch
- [ ] Baseline tests passing: `bin/rake test:critical`
- [ ] Visual baseline captured: Screenshots saved
- [ ] Rollback points documented: Git SHA recorded

---

## 📋 STEP-BY-STEP MICRO-REFACTORING SEQUENCE

### EXTRACTION 1: Box-Sizing Reset (20 Micro-Steps)

#### Step 1.1: Create Foundation Directory
```bash
# Micro-change 1: Create directory
mkdir -p themes/beaver/assets/css/foundation
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Create foundation CSS directory"
```

#### Step 1.2: Create Box-Sizing File
```bash
# Micro-change 2: Create file
touch themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Create box-sizing CSS file"
```

#### Step 1.3-1.5: Add Selectors (3 lines)
```bash
# Micro-change 3: Add first selector
echo ".fl-builder-content *," >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add universal selector"

# Micro-change 4: Add before pseudo
echo ".fl-builder-content *:before," >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add before pseudo-selector"

# Micro-change 5: Add after pseudo with opening
echo ".fl-builder-content *:after {" >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add after pseudo-selector with opening brace"
```

#### Step 1.6-1.8: Add Properties (3 lines)
```bash
# Micro-change 6: Add webkit prefix
echo "  -webkit-box-sizing: border-box;" >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add webkit box-sizing"

# Micro-change 7: Add moz prefix
echo "  -moz-box-sizing: border-box;" >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add moz box-sizing"

# Micro-change 8: Add standard property
echo "  box-sizing: border-box;" >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add standard box-sizing"
```

#### Step 1.9: Close Rule
```bash
# Micro-change 9: Close brace
echo "}" >> themes/beaver/assets/css/foundation/_fl-box-sizing.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Close box-sizing rule"
```

#### Step 1.10-1.20: Update Each Layout File (One at a Time)

##### Homepage Layout Update
```bash
# Micro-change 10: Backup original
cp themes/beaver/assets/css/homepage-layout.css themes/beaver/assets/css/homepage-layout.css.backup
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Backup homepage-layout.css"

# Micro-change 11: Add import statement
sed -i '1i@import "foundation/_fl-box-sizing.css";' themes/beaver/assets/css/homepage-layout.css
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Add box-sizing import to homepage-layout"

# Micro-change 12-14: Remove duplicate (3 lines at a time)
sed -i '2d' themes/beaver/assets/css/homepage-layout.css  # Remove line 2
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Remove box-sizing line 1 from homepage-layout"

sed -i '2d' themes/beaver/assets/css/homepage-layout.css  # Remove next line
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Remove box-sizing line 2 from homepage-layout"

sed -i '2d' themes/beaver/assets/css/homepage-layout.css  # Remove next line
# TEST: bin/rake test:critical
# COMMIT: git commit -m "Remove box-sizing line 3 from homepage-layout"
```

##### Continue for Each File...
```bash
# Repeat micro-changes 11-14 for:
# - beaver-grid-layout.css
# - fl-foundation.css
# - fl-component-layout.css
# - fl-contact-layout.css
# - fl-service-detail-layout.css
# - fl-about-layout.css
# - fl-services-layout.css
# - fl-careers-layout.css
# - fl-use-cases-layout.css
# - fl-clients-layout.css
```

---

## 🧪 VALIDATION AFTER EACH EXTRACTION

### Test Protocol Per Micro-Change
```bash
# 1. Syntax validation
hugo --renderToMemory --quiet --logLevel error

# 2. Critical test
bin/rake test:critical

# 3. Visual check (every 5 micro-changes)
bin/hugo-dev &
sleep 5
# Manual visual inspection
kill %1
```

### Rollback Protocol
```bash
# If ANY test fails:
git reset --hard HEAD~1  # Rollback single micro-change
# OR
git reset --hard <checkpoint>  # Rollback to checkpoint
```

---

## 📊 EXTRACTION 2: Clearfix Utilities (15 Micro-Steps)

### Step 2.1: Create Clearfix File
```bash
# Micro-change 1: Create file
touch themes/beaver/assets/css/foundation/_fl-clearfix.css
# TEST & COMMIT
```

### Step 2.2-2.6: Add First Rule (5 lines)
```bash
# Micro-change 2: First selector
echo ".clearfix:before," >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 3: Second selector
echo ".clearfix:after," >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 4: FL selector
echo ".fl-clearfix:before," >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 5: FL after with opening
echo ".fl-clearfix:after {" >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 6: Content property
echo '  content: " ";' >> themes/beaver/assets/css/foundation/_fl-clearfix.css
```

### Step 2.7-2.10: Complete Rules
```bash
# Micro-change 7: Display property
echo "  display: table;" >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 8: Close first rule
echo "}" >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 9: After selectors
echo ".clearfix:after," >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 10: FL after with opening
echo ".fl-clearfix:after {" >> themes/beaver/assets/css/foundation/_fl-clearfix.css
```

### Step 2.11-2.12: Clear Property
```bash
# Micro-change 11: Clear property
echo "  clear: both;" >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 12: Close rule
echo "}" >> themes/beaver/assets/css/foundation/_fl-clearfix.css
```

---

## 🔍 EXTRACTION 3: Screen Reader Only (12 Micro-Steps)

### Step 3.1: Create SR-Only File
```bash
# Micro-change 1: Create file
touch themes/beaver/assets/css/foundation/_fl-sr-only.css
# TEST & COMMIT
```

### Step 3.2-3.11: Add SR-Only Properties (One at a Time)
```bash
# Micro-change 2: Selector
echo ".sr-only {" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 3: Position
echo "  position: absolute;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 4: Width
echo "  width: 1px;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 5: Height
echo "  height: 1px;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 6: Padding
echo "  padding: 0;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 7: Overflow
echo "  overflow: hidden;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 8: Clip
echo "  clip: rect(0, 0, 0, 0);" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 9: White-space
echo "  white-space: nowrap;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 10: Border
echo "  border: 0;" >> themes/beaver/assets/css/foundation/_fl-sr-only.css

# Micro-change 11: Close
echo "}" >> themes/beaver/assets/css/foundation/_fl-sr-only.css
```

---

## 📦 FINAL STEP: Create Foundation Bundle

### Step 4.1: Create Bundle File
```bash
# Micro-change 1: Create bundle
touch themes/beaver/assets/css/foundation/_fl-foundation-bundle.css

# Micro-change 2: Import box-sizing
echo '@import "_fl-box-sizing.css";' >> themes/beaver/assets/css/foundation/_fl-foundation-bundle.css

# Micro-change 3: Import clearfix
echo '@import "_fl-clearfix.css";' >> themes/beaver/assets/css/foundation/_fl-clearfix.css

# Micro-change 4: Import sr-only
echo '@import "_fl-sr-only.css";' >> themes/beaver/assets/css/foundation/_fl-sr-only.css
```

---

## ✅ PHASE 1 COMPLETION CHECKLIST

### Extraction Verification
- [ ] Box-sizing extracted and imported in all files
- [ ] Clearfix extracted and imported in all files
- [ ] SR-only extracted and imported in all files
- [ ] Foundation bundle created
- [ ] All duplicates removed from original files

### Quality Gates
- [ ] All tests passing: `bin/rake test:critical`
- [ ] Visual regression clean: No UI changes
- [ ] Build successful: `bin/hugo-build`
- [ ] Performance improved: Lighthouse check
- [ ] Git history clean: All micro-commits present

### Metrics Captured
- [ ] CSS file size before: _____ KB
- [ ] CSS file size after: _____ KB
- [ ] Load time before: _____ ms
- [ ] Load time after: _____ ms
- [ ] Duplication eliminated: _____ KB

---

## 🚀 READY FOR PHASE 2

Upon successful completion of Phase 1:
1. Tag the commit: `git tag phase1-complete`
2. Create Phase 2 branch: `git checkout -b extraction-phase2`
3. Document lessons learned
4. Proceed to Grid System Consolidation

---

*Execution Plan Generated: $(date)*
*Micro-refactoring Limit: ≤3 lines per change*
*Total Micro-commits Expected: ~50*
*Rollback Strategy: Active at every step*