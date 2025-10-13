# CSS Consolidation Quick Reference

**For Rapid Sprint Planning & Autonomous Execution**

---

## 🚀 Quick Start (Copy-Paste Commands)

### Start Next File
```bash
# 1. Check current status
cat docs/CSS_CONSOLIDATION_DASHBOARD.md

# 2. Pick next file from High Priority list
# (See Sprint Backlog below)

# 3. Run consolidation cycle
bin/rake test:critical  # Before changes (establish baseline)
# ... make changes ...
bin/rake test:critical  # After changes (validate)
git add . && git commit -m "refactor(css): consolidate [filename]"
```

### Update Progress
```bash
# Regenerate tracking manifest
ruby /tmp/css_tracking_analysis.rb

# Update dashboard
# (Manual update to CSS_CONSOLIDATION_DASHBOARD.md)
```

---

## 📋 Sprint Backlog (Top 37 High-Priority Files)

**Copy this list for autonomous execution:**

### Batch 1: Largest Layouts (310KB+)
1. ✅ `590-layout.css` - 310.2KB, 125 FL nodes
2. ✅ `fl-homepage-layout.css` - 292.4KB, 125 FL nodes

### Batch 2: Large Bundles (150KB+)
3. ✅ `fb2624e43f3c4277448abe268cde571e-layout-bundle.css` - 160.3KB, 58 FL nodes
4. ✅ `fl-clients-alt-bundle.css` - 159.0KB, 58 FL nodes
5. ✅ `fl-use-cases-layout.css` - 153.3KB, 73 FL nodes
6. ✅ `fl-services-layout.css` - 153.2KB, 75 FL nodes
7. ✅ `737-layout.css` - 153.6KB, 75 FL nodes
8. ✅ `3021-layout.css` - 150.7KB, 74 FL nodes

### Batch 3: Mid-Large Layouts (125KB+)
9. ✅ `beaver-grid-layout.css` - 133.2KB, 39 FL nodes
10. ✅ `e966db44b09892b8d7d492247c67e86c-layout-bundle.css` - 129.6KB, 39 FL nodes
11. ✅ `fl-service-detail-layout.css` - 126.1KB, 66 FL nodes
12. ✅ `fl-clients-layout.css` - 126.0KB, 55 FL nodes
13. ✅ `3082-layout.css` - 126.0KB, 55 FL nodes
14. ✅ `2949-layout.css` - 124.2KB, 67 FL nodes

### Batch 4: Component & Service Layouts (100KB+)
15. ✅ `3027-layout.css` - 118.0KB, 50 FL nodes
16. ✅ `fl-component-layout.css` - 117.4KB, 48 FL nodes
17. ✅ `701-layout.css` - 104.5KB, 56 FL nodes
18. ✅ `fl-about-layout.css` - 103.8KB, 56 FL nodes

### Batch 5: Medium Layouts (50KB+)
19. ✅ `component-bundle.css` - 60.5KB, 24 FL nodes
20. ✅ `homepage-layout.css` - 55.8KB, 15 FL nodes
21. ✅ `base-4.min.css` - 55.6KB, 0 FL nodes
22. ✅ `3114-layout.css` - 54.9KB, 15 FL nodes
23. ✅ `706-layout.css` - 54.3KB, 15 FL nodes
24. ✅ `fl-contact-layout.css` - 53.0KB, 15 FL nodes
25. ✅ `bf72bba397177a0376baed325bffdc75-layout-bundle.css` - 52.2KB, 24 FL nodes
26. ✅ `fl-clients-bundle.css` - 52.1KB, 24 FL nodes
27. ✅ `e93d9b85e7803f50c80b8a698f8d12f9-layout-bundle.css` - 52.0KB, 24 FL nodes

### Batch 6: Theme & Skin Files
28. ✅ `theme-main.css` - 76.8KB, 0 FL nodes
29. ✅ `skin-65eda28877e04.css` - 72.4KB, 0 FL nodes

### Batch 7: Critical CSS Files
30. ✅ `critical/single-careers.css` - 48.5KB, 16 FL nodes
31. ✅ `critical/homepage-critical.css` - 46.2KB, 19 FL nodes
32. ✅ `critical/about-us-critical.css` - 38.9KB, 18 FL nodes
33. ✅ `critical/single-use-cases.css` - 37.4KB, 10 FL nodes
34. ✅ `critical/single-services.css` - 30.7KB, 9 FL nodes

### Batch 8: Specialized Layouts
35. ✅ `services-layout.css` - 30.7KB, 0 FL nodes
36. ✅ `586.css` - 29.1KB, 0 FL nodes
37. ✅ `utilities/c-spacing.css` - 12.2KB, 0 FL nodes

---

## ✅ Consolidation Checklist (Per File)

**Before Starting**:
- [ ] File not in critical infrastructure list
- [ ] Previous file committed and tests green
- [ ] Screenshot baseline captured (if needed)

**During Consolidation**:
- [ ] Run `bin/rake test:critical` before changes
- [ ] Make micro-changes (<10 lines)
- [ ] Run `bin/rake test:critical` after each micro-change
- [ ] Preserve all page-specific FL-node styles
- [ ] No test baseline modifications

**After Consolidation**:
- [ ] All tests green (`bin/rake test:critical`)
- [ ] Screenshot comparison shows 0% difference (tolerance: 0.0)
- [ ] Git commit with descriptive message
- [ ] Update tracking manifest

**Rollback Trigger**:
- ANY test failures → IMMEDIATE rollback
- ANY visual changes → IMMEDIATE rollback
- Unable to fix within 30 min → IMMEDIATE rollback, escalate

---

## 🎯 Processing Strategies

### Solo Autonomous Execution (RECOMMENDED)
**When**: Simple repetitive pattern-based consolidation
**Approach**: Process files 1-37 sequentially, test after each, commit on green
**Stop conditions**: Critical test failures ONLY

### Pair Execution
**When**: Complex FL-node patterns requiring validation
**Approach**: Driver implements, Navigator validates patterns
**Rotation**: Every 25 minutes

### Team Execution
**When**: Bundle files with complex dependencies
**Approach**: Full XP team with TDD specialists
**Coordination**: Test-Writer → Minimal-Implementer → Refactor-Specialist

---

## 📊 Progress Tracking Template

**After each file, update dashboard**:

```markdown
### Iteration X Progress

| File | Size | Status | Visual Tests | Critical Tests | Notes |
|------|------|--------|--------------|----------------|-------|
| [filename] | XKB | ✅ Completed | ✅ Pass (0.0%) | ✅ Pass | [notes] |
```

---

## 🚨 Critical Reminders

1. **ALWAYS** run `bin/rake test:critical` after each change
2. **NEVER** modify test baselines during refactoring
3. **ALWAYS** preserve page-specific FL-node styles in critical CSS
4. **IMMEDIATELY** rollback on any test failures
5. **MANDATORY** screenshot validation for visual changes (tolerance: 0.0)
6. **REQUIRED** four-eyes approval: Coder → Reviewer → Screenshot Guardian → Tester

---

## 📈 Velocity Targets

| Phase | Target | Strategy |
|-------|--------|----------|
| Iteration 7-8 (Learning) | 2 files/iteration | Establish patterns, full validation |
| Iteration 9-12 (Scaling) | 5 files/iteration | Reuse patterns, parallel processing |
| Iteration 13-15 (Batch) | 10+ files/iteration | Batch utilities/components |

**Current Velocity**: 0 files/iteration (sprint starting)
**Target by Iteration 15**: 138/138 files completed (100%)

---

## 🔗 Related Files

- **Product Backlog**: `/Users/pftg/dev/jetthoughts.github.io/docs/CSS_CONSOLIDATION_PRODUCT_BACKLOG.md`
- **Dashboard**: `/Users/pftg/dev/jetthoughts.github.io/docs/CSS_CONSOLIDATION_DASHBOARD.md`
- **Tracking Manifest**: `/Users/pftg/dev/jetthoughts.github.io/docs/CSS_TRACKING_MANIFEST.csv`
- **Analysis Script**: `/tmp/css_tracking_analysis.rb`

---

**Usage**: Reference this guide for rapid sprint execution and autonomous file processing. Update progress after each file completion.

**Product Owner Commitment**: I will update this quick reference after each sprint to reflect new patterns and velocity improvements.
