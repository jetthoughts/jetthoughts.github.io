# Legacy CSS Cleanup Strategy

## Current State Analysis

### Legacy Classes Still in Use
- **957** FL-node class references in templates
- **800** unique node-specific CSS selectors
- **50** Gravity Forms references
- **23** CSS files containing node-specific styles
- **0** new component classes adopted in templates yet

### Component System Ready
✅ All 8 component systems created and tested
✅ Backward compatibility ensured via dual-class support
✅ 173/173 tests passing

## 🎯 Cleanup Strategy - Phased Approach

### Phase 1: Template Migration Preparation (Week 1)
**Goal**: Set up safe migration infrastructure

1. **Create Migration Map**
   - Document FL-node → BEM component mappings
   - Identify high-value migration targets
   - Create conversion guide

2. **Add Dual Classes to Templates**
   - Keep existing FL-node classes
   - Add new BEM classes alongside
   - Test after each template update

3. **Create Rollback Plan**
   - Git branch for each migration phase
   - Backup current CSS files
   - Document rollback procedures

### Phase 2: High-Impact Template Migration (Week 2-3)
**Goal**: Migrate most-used templates first

**Priority Order:**
1. **Homepage** (highest traffic)
   - Buttons: fl-button → c-button
   - Grid: fl-col → c-grid
   - Content: fl-rich-text → c-content-block

2. **Contact Pages** (forms heavy)
   - Forms: gform classes → c-form
   - Already have components.css imported

3. **About Page** (component showcase)
   - Cards: fl-module → c-card
   - Typography: heading classes → c-typography

### Phase 3: Systematic FL-node Cleanup (Week 4-5)
**Goal**: Remove node-specific styles safely

1. **Identify Unused Nodes**
   ```bash
   # Find CSS nodes not in templates
   comm -23 <(grep -oh "fl-node-[a-z0-9]*" css/*.css | sort -u) \
            <(grep -oh "fl-node-[a-z0-9]*" layouts/**/*.html | sort -u)
   ```

2. **Progressive Removal**
   - Remove 10-20 nodes per commit
   - Test after each removal
   - Monitor visual regression

3. **CSS File Consolidation**
   - Merge similar CSS files
   - Remove empty files
   - Update imports

### Phase 4: Legacy CSS Removal (Week 6)
**Goal**: Remove deprecated styles

1. **Remove Dual Classes from Templates**
   - Once confirmed working, remove FL classes
   - Keep only BEM classes
   - Test thoroughly

2. **Delete Legacy CSS**
   - Remove unused FL-node styles
   - Delete deprecated CSS files
   - Optimize imports

3. **Final Optimization**
   - Minify remaining CSS
   - Remove commented code
   - Performance testing

## 🛠️ Implementation Steps

### Step 1: Create Migration Script (Optional)
```bash
#!/bin/bash
# migrate-template.sh
# Adds BEM classes alongside FL classes

sed -i.bak 's/class="fl-button/class="fl-button c-button c-button--primary/g' $1
sed -i.bak 's/class="fl-col/class="fl-col c-grid__item/g' $1
# ... more mappings
```

### Step 2: Template-by-Template Migration
**Conservative Approach** (Recommended):
1. Open template file
2. Add BEM class next to FL class
3. Save and test
4. Commit if tests pass
5. Move to next template

**Example Migration:**
```html
<!-- Before -->
<button class="fl-button">Click Me</button>

<!-- During Migration (Dual Classes) -->
<button class="fl-button c-button c-button--primary">Click Me</button>

<!-- After Cleanup -->
<button class="c-button c-button--primary">Click Me</button>
```

### Step 3: CSS Cleanup Process
1. **Analyze Usage**
   ```bash
   # Check if FL-node is still used
   grep -r "fl-node-abc123" themes/beaver/layouts/
   ```

2. **Remove if Unused**
   ```css
   /* Delete these blocks from CSS */
   .fl-node-abc123 { ... }
   ```

3. **Test & Validate**
   ```bash
   bin/test
   ```

## 📊 Success Metrics

### Target Outcomes
- **CSS Size**: Reduce from 2.2MB to <1MB
- **Files**: Reduce from 42 to <15 files
- **Selectors**: Eliminate 800 node-specific selectors
- **Performance**: Improve page load by 20%+
- **Maintainability**: Single component system

### Tracking Progress
- [ ] Templates migrated: 0/50
- [ ] FL-nodes removed: 0/800
- [ ] CSS files consolidated: 0/23
- [ ] Tests passing: 173/173 ✅

## ⚠️ Risk Mitigation

### Potential Risks
1. **Visual Regression**: Mitigated by dual-class approach
2. **Missing Styles**: Covered by backward compatibility
3. **Performance Impact**: Test after each change
4. **Team Confusion**: Document all changes

### Rollback Strategy
1. Git revert to previous commit
2. Restore CSS backup files
3. Remove new component imports
4. Rerun tests to confirm

## 🚀 Quick Start

### Tomorrow's First Tasks:
1. **Create feature branch**: `git checkout -b feature/legacy-cleanup`
2. **Start with homepage**: Add dual classes to buttons
3. **Test thoroughly**: `bin/test`
4. **Document progress**: Update this file

### Tools Needed:
- Visual regression testing (existing screenshots)
- Git for version control
- bin/test for validation
- Browser DevTools for inspection

## 📝 Notes

### Why This Approach Works:
1. **Safety First**: Dual classes prevent breaking changes
2. **Incremental**: Small changes reduce risk
3. **Tested**: Every change validated
4. **Reversible**: Easy rollback if needed
5. **Visible Progress**: Measurable improvements

### Prerequisites Complete:
✅ Component system built
✅ Tests passing
✅ Documentation ready
✅ Backward compatibility ensured

**Ready to begin legacy cleanup!**