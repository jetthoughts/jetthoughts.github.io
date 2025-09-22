# CSS Rollback Procedure
## Emergency Recovery for CSS Component Simplification

**Sprint**: CSS Component Simplification Delivery
**Feature Branch**: `feature/css-component-simplification`
**Created**: September 18, 2025

## 🚨 Emergency Rollback Scenarios

### When to Execute Rollback
- **Performance degradation**: Lighthouse scores drop below 90
- **Visual regressions**: Any UI/UX breaking changes
- **Build failures**: Hugo build process breaks
- **Test failures**: System tests fail
- **User-reported issues**: Critical functionality broken

## 📋 Pre-Rollback Checklist

### 1. Assess Impact
```bash
# Check current performance
bin/lighthouse http://127.0.0.1:1313

# Verify build status
bin/hugo-build

# Run system tests
bin/test
```

### 2. Document Issue
- Record specific failure symptoms
- Capture lighthouse scores if performance-related
- Save error logs and screenshots
- Note which commit introduced the issue

## 🔄 Rollback Procedures

### Quick Rollback (Same Session)
```bash
# If working on feature branch with uncommitted changes
git status
git checkout -- .  # Discard uncommitted changes
git reset --hard HEAD~1  # Remove last commit

# Verify rollback
bin/hugo-build
bin/test
```

### Safe Rollback (To Specific Commit)
```bash
# Find last known good commit
git log --oneline --graph -10

# Reset to specific commit (replace COMMIT_HASH)
git reset --hard COMMIT_HASH

# Verify system functionality
bin/hugo-build && bin/test
```

### Complete Branch Rollback
```bash
# Switch to master branch
git checkout master

# Delete feature branch locally
git branch -D feature/css-component-simplification

# If pushed to remote, delete remote branch
git push origin --delete feature/css-component-simplification

# Recreate clean feature branch
git checkout -b feature/css-component-simplification
```

## 🛡️ Recovery Validation

### 1. Build Validation
```bash
# Ensure Hugo builds successfully
bin/hugo-build
echo "Build status: $?"

# Check for any build warnings
bin/hugo-build 2>&1 | grep -i warning
```

### 2. Performance Validation
```bash
# Verify baseline performance maintained
bin/lighthouse http://127.0.0.1:1313

# Compare against baseline metrics
diff _reports/lighthouse-reports/20250918_084625/results.csv \
     _reports/lighthouse-reports/LATEST/results.csv
```

### 3. Visual Validation
```bash
# Run visual regression tests
bin/test test/system/

# Manual verification checklist:
# [ ] Homepage renders correctly
# [ ] Navigation functions properly
# [ ] Blog pages display content
# [ ] Service pages maintain layout
# [ ] Mobile responsiveness intact
```

## 📊 Baseline Recovery Targets

### Performance Targets (Must Meet After Rollback)
- **Performance Score**: ≥97/100
- **Accessibility**: ≥86/100
- **Best Practices**: ≥96/100
- **SEO**: 100/100
- **FCP**: ≤0.8s
- **LCP**: ≤1.1s
- **CLS**: ≤0.051

### File System Targets
- **CSS Files**: 57 files (baseline)
- **CSS Size**: 7.2MB (baseline)
- **Build Time**: ≤6000ms

## 🔍 Root Cause Analysis

### After Successful Rollback
1. **Identify the problematic commit**:
   ```bash
   git log --oneline feature/css-component-simplification
   git show PROBLEMATIC_COMMIT
   ```

2. **Analyze the failure**:
   - Was it a CSS syntax issue?
   - Performance regression from too many changes?
   - Missing dependency or asset?
   - Build process change?

3. **Plan prevention**:
   - Should the change be split into smaller commits?
   - Need additional validation steps?
   - Missing test coverage?

## 📞 Escalation Contacts

### Technical Issues
- **Build System**: Check `bin/` tool documentation
- **Performance**: Review lighthouse reports in `_reports/`
- **CSS Structure**: Analyze `themes/beaver/assets/css/`

### Decision Making
- **Continue vs. Abort**: Based on timeline and complexity
- **Alternative Approach**: Consider smaller scope delivery
- **Resource Allocation**: Additional expertise needed?

## 📝 Rollback Documentation Template

```markdown
## Rollback Incident Report
**Date**: [DATE]
**Time**: [TIME]
**Issue**: [BRIEF_DESCRIPTION]
**Trigger**: [WHAT_CAUSED_ROLLBACK]
**Commit**: [PROBLEMATIC_COMMIT_HASH]
**Recovery**: [ROLLBACK_METHOD_USED]
**Status**: [RESOLVED/INVESTIGATING]
**Next Steps**: [IMMEDIATE_ACTIONS]
```

## ✅ Post-Rollback Actions

### 1. Verify Main Branch Unaffected
```bash
git checkout master
bin/hugo-build && bin/test
bin/lighthouse http://127.0.0.1:1313
```

### 2. Update Team
- Notify stakeholders of rollback
- Share rollback report
- Communicate revised timeline if needed

### 3. Plan Recovery
- Determine if sprint continues with modified scope
- Schedule additional validation steps
- Consider pair programming for complex changes

---

## 🎯 Prevention Strategy

### Conservative Principles
- **≤3 lines per commit**: Easier rollback granularity
- **Test after each commit**: `bin/test && bin/hugo-build`
- **Performance monitoring**: Check lighthouse regularly
- **Visual validation**: Manual checks for UI changes
- **Documentation updates**: Keep this procedure current

### Emergency Preparedness
- **Always work on feature branch**: Never directly on master
- **Frequent commits**: Easy to pinpoint issues
- **Baseline documentation**: Know target metrics
- **Tool familiarity**: Practice using bin/ tools

---

*Last Updated: 2025-09-18 | Version: 1.0 | Branch: feature/css-component-simplification*