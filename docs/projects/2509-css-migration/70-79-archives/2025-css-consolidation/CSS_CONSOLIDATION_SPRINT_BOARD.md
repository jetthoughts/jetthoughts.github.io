# CSS Consolidation Sprint Board (Kanban)

**Sprint**: Iteration 7-8
**Sprint Goal**: Consolidate top 10 largest layout files (1.5MB+ CSS)
**Last Updated**: 2025-10-13

---

## 📋 Sprint Backlog (10 files)

### 🔴 To Do (10 files remaining)

| Priority | File | Size | FL Nodes | Owner | Est. Hours |
|----------|------|------|----------|-------|------------|
| 1 | fl-homepage-layout.css | 292.4KB | 125 | - | 2.5h |
| 2 | 590-layout.css | 310.2KB | 125 | - | 2.5h |
| 3 | fl-clients-alt-bundle.css | 159.0KB | 58 | - | 2.0h |
| 4 | 3021-layout.css | 150.7KB | 74 | - | 2.0h |
| 5 | fl-services-layout.css | 153.2KB | 75 | - | 2.0h |
| 6 | fl-use-cases-layout.css | 153.3KB | 73 | - | 2.0h |
| 7 | 737-layout.css | 153.6KB | 75 | - | 2.0h |
| 8 | fb2624e43f3c4277448abe268cde571e-layout-bundle.css | 160.3KB | 58 | - | 2.0h |
| 9 | beaver-grid-layout.css | 133.2KB | 39 | - | 2.0h |
| 10 | fl-clients-layout.css | 126.0KB | 55 | - | 2.0h |

**Total Estimated Effort**: 20.5 hours

---

### 🟡 In Progress (0 files)

*Empty - Ready to start!*

---

### 🟢 Code Review (0 files)

*Awaiting completed files*

---

### ✅ Done (0 files this sprint)

*Sprint just starting*

---

## 📊 Sprint Burndown

```
Remaining Files: 10/10 (100%)
Remaining Size:  1.5MB/1.5MB (100%)

Day 1: ██████████░░░░░░░░░░ (0% complete)
Day 2: ██████████░░░░░░░░░░ (0% complete)
Day 3: ██████████░░░░░░░░░░ (0% complete)
Day 4: ██████████░░░░░░░░░░ (0% complete)
Day 5: ██████████░░░░░░░░░░ (0% complete)

Target: 5 files/iteration
```

---

## 🎯 Daily Standup Template

### What I completed yesterday
- None (sprint starting)

### What I'm working on today
- [ ] Start fl-homepage-layout.css consolidation

### Blockers
- None

---

## 🚨 Sprint Risks & Blockers

### Active Risks
*None currently*

### Blockers
*None currently*

### Escalations Needed
*None currently*

---

## 📈 Sprint Metrics (Real-Time)

### Velocity
- **Completed**: 0 files
- **In Progress**: 0 files
- **Remaining**: 10 files
- **Velocity**: 0 files/day (target: 2-3 files/day)

### Quality
- **Test Pass Rate**: N/A (not started)
- **Visual Validation**: N/A (not started)
- **Rollbacks**: 0

### Business Value
- **CSS Reduced**: 0KB (target: 1.5MB+)
- **Duplication Eliminated**: 0% (target: 60%+)

---

## ✅ Definition of Done (Checklist)

**Before moving to "Done", ALL criteria must be met**:

- [ ] All duplicate CSS rules removed or consolidated
- [ ] Page-specific FL-node styles preserved
- [ ] BEM naming conventions applied
- [ ] `bin/rake test:critical` passes (100% green)
- [ ] Screenshot comparison shows 0% difference (tolerance: 0.0)
- [ ] Four-eyes approval: Coder ✓, Reviewer ✓, Screenshot Guardian ✓, Tester ✓
- [ ] Zero test smells introduced
- [ ] Refactoring definition upheld (EXACT functionality AND appearance)
- [ ] No test baseline modifications
- [ ] Git commit created with descriptive message
- [ ] Status updated in tracking manifest

---

## 🔄 Workflow States

### 🔴 To Do
- File selected from sprint backlog
- Ready to start (no blockers)

### 🟡 In Progress
- Coder actively working on consolidation
- Running `bin/rake test:critical` after each micro-change
- Making changes <10 lines at a time

### 🟢 Code Review
- Consolidation complete, tests green
- Awaiting four-eyes validation
- Screenshot Guardian performing visual validation

### ✅ Done
- All Definition of Done criteria met
- Committed to repository
- Dashboard updated

---

## 🎬 How to Move Cards

### Moving to "In Progress"
1. Assign yourself as owner
2. Capture baseline screenshot (if needed)
3. Run `bin/rake test:critical` to establish baseline
4. Update board: Move card from "To Do" to "In Progress"

### Moving to "Code Review"
1. All tests green (`bin/rake test:critical`)
2. Self-review completed
3. Screenshot comparison prepared
4. Update board: Move card to "Code Review"
5. Tag reviewer, screenshot guardian, tester

### Moving to "Done"
1. All four-eyes approvals obtained
2. All Definition of Done criteria checked
3. Git commit created
4. Update board: Move card to "Done"
5. Update tracking manifest

---

## 📅 Sprint Timeline

**Sprint Duration**: 2 iterations (Iteration 7-8)
**Start Date**: 2025-10-13
**End Date**: 2025-10-27
**Review Date**: 2025-10-27
**Retrospective Date**: 2025-10-27

---

## 🏆 Sprint Success Criteria

**Sprint is successful if ALL are true**:

- ✅ 10 files consolidated (100% of sprint backlog)
- ✅ 1.5MB+ CSS processed
- ✅ 60%+ duplication eliminated
- ✅ Zero visual regressions (tolerance: 0.0)
- ✅ 100% test pass rate maintained
- ✅ All Definition of Done criteria met for each file

---

## 📝 Notes & Learnings

### Consolidation Patterns Discovered
*To be filled as patterns emerge*

### Blockers Encountered
*To be documented as they occur*

### Process Improvements
*To be captured for retrospective*

---

## 🔗 Quick Links

- [Product Backlog](CSS_CONSOLIDATION_PRODUCT_BACKLOG.md)
- [Dashboard](CSS_CONSOLIDATION_DASHBOARD.md)
- [Quick Reference](CSS_CONSOLIDATION_QUICK_REFERENCE.md)
- [Tracking Manifest](CSS_TRACKING_MANIFEST.csv)

---

**Last Updated**: 2025-10-13 | **Next Update**: After each card movement
