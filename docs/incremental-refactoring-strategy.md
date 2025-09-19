# Incremental Refactoring Strategy: FL-Builder to Components

## Strategy Overview

Transform legacy FL-Builder classes to modern component architecture through disciplined, manual micro-refactoring. Each step is small, safe, and immediately improves the codebase.

## Key Principles

1. **No Feature Flags** - Make changes directly with confidence
2. **No Automation** - Thoughtful, manual refactoring for quality
3. **Micro-steps** - Maximum 3 lines changed at a time
4. **Continuous Testing** - Run tests after each change
5. **Zero Technical Debt** - Every change leaves code cleaner

## Refactoring Sequence

### Week 1: Simplify Current Dual-Class Pattern

#### Day 1-2: Clean up redundant classes
```html
<!-- Current (redundant dual-class) -->
<div class="fl-module fl-module-rich-text fl-node-xxx c-content-block">

<!-- Step 1: Remove fl-module (it adds nothing) -->
<div class="fl-module-rich-text fl-node-xxx c-content-block">

<!-- Step 2: Remove fl-module-rich-text (c-content-block handles it) -->
<div class="fl-node-xxx c-content-block">

<!-- Step 3: Move node ID to data attribute -->
<div class="c-content-block" data-node="xxx">
```

**Approach**:
- Change ONE template file at a time
- Run `bin/test` after each file
- Commit after each successful test

#### Day 3-4: Consolidate wrapper divs
```html
<!-- Current (nested wrappers) -->
<div class="c-content-block">
  <div class="fl-module-content fl-node-content">
    <div class="fl-rich-text">
      <p>Content</p>

<!-- Step 1: Merge fl-module-content into component -->
<div class="c-content-block">
  <div class="c-content-block__wrapper">
    <div class="fl-rich-text">
      <p>Content</p>

<!-- Step 2: Merge fl-rich-text into component -->
<div class="c-content-block">
  <div class="c-content-block__content">
    <p>Content</p>

<!-- Step 3: Flatten if only one child -->
<div class="c-content-block">
  <p>Content</p>
```

#### Day 5: Clean up CSS
- Remove unused `.fl-module-rich-text` rules
- Remove unused `.fl-module-content` rules
- Consolidate duplicate styles into components

### Week 2: Refactor Layout Classes

#### Day 1-2: Replace fl-row with semantic HTML
```html
<!-- Current -->
<div class="fl-row fl-row-full-width fl-node-xxx">

<!-- Step 1: Use section element -->
<section class="fl-row fl-row-full-width" data-node="xxx">

<!-- Step 2: Replace with component class -->
<section class="c-section c-section--full-width" data-node="xxx">

<!-- Step 3: Simplify modifiers -->
<section class="c-section--full" data-node="xxx">
```

#### Day 3-4: Replace fl-col with CSS Grid
```html
<!-- Current -->
<div class="fl-col-group">
  <div class="fl-col fl-col-small">

<!-- Step 1: Modern grid -->
<div class="c-grid">
  <div class="c-grid__item">

<!-- Step 2: Use CSS Grid -->
<div style="display: grid; grid-template-columns: 1fr 2fr;">
  <div>

<!-- Step 3: Move to CSS class -->
<div class="c-layout-2col">
  <div>
```

#### Day 5: Remove FL grid CSS
- Delete `beaver-grid-layout.css` references
- Update any dependent styles
- Test responsive behavior

### Week 3: Component Enhancement

#### Day 1-2: Add semantic BEM elements
```scss
// Enhance c-content-block component
.c-content-block {
  // Already exists

  &__title {
    @extend h2;
    margin-bottom: 1rem;
  }

  &__body {
    line-height: 1.6;
  }

  &__cta {
    margin-top: 1.5rem;
  }
}
```

#### Day 3-4: Create layout utilities
```scss
// Spacing utilities (replace FL spacing)
.u-mt-1 { margin-top: 0.5rem; }
.u-mt-2 { margin-top: 1rem; }
.u-mt-3 { margin-top: 1.5rem; }

// Width utilities (replace FL column system)
.u-full-width { width: 100%; }
.u-max-width { max-width: 1200px; margin: 0 auto; }
```

#### Day 5: Typography consolidation
```scss
// Move inline styles to classes
.t-heading-xl { font-size: 2.5rem; }
.t-heading-lg { font-size: 2rem; }
.t-body { font-size: 1rem; line-height: 1.6; }
.t-small { font-size: 0.875rem; }
```

### Week 4: Final Cleanup

#### Day 1: Remove FL-Builder CSS imports
- Remove from Hugo asset pipeline
- Update any PostCSS configs
- Verify build still works

#### Day 2: Clean up data attributes
```html
<!-- Remove unnecessary FL data -->
<div data-node="xxx" data-animation="none" data-delay="0">
<!-- Becomes -->
<div>
```

#### Day 3: Optimize HTML structure
```html
<!-- Flatten unnecessary nesting -->
<div><div><div>Content</div></div></div>
<!-- Becomes -->
<div>Content</div>
```

#### Day 4: Performance optimization
- Combine similar CSS rules
- Remove unused variables
- Minify component CSS

#### Day 5: Documentation and testing
- Update component documentation
- Visual regression testing
- Performance benchmarking

## Incremental Refactoring Rules

### 1. The Three-Line Rule
Never change more than 3 lines in a single commit:
```bash
git add -p  # Stage partial changes
git commit -m "refactor: remove fl-module class from contact template line 40"
```

### 2. The Test-After-Each Rule
```bash
# After EVERY change
bin/test
bin/hugo-build
# Only proceed if both pass
```

### 3. The Simplification Rule
Each change must reduce complexity:
- Fewer classes
- Fewer divs
- Clearer naming
- Less CSS

### 4. The No-Debt Rule
Never add a TODO or FIXME. Fix it now or don't touch it.

### 5. The Atomic Commit Rule
One logical change per commit:
```bash
# Good commits
"Remove fl-module class from services template"
"Replace fl-rich-text with c-content-block__text"
"Delete unused FL-Builder CSS rule"

# Bad commits
"Update templates and CSS"
"Various improvements"
"Work in progress"
```

## Risk Mitigation Through Incrementalism

### Safe Refactoring Checklist
- [ ] Change affects only ONE component/template
- [ ] Tests pass after change
- [ ] Build succeeds after change
- [ ] Visual appearance unchanged (screenshot comparison)
- [ ] No new complexity introduced
- [ ] Code is simpler than before

### Rollback Strategy
Since each change is atomic:
```bash
# Any problem? Just revert last commit
git revert HEAD
# Or reset if not pushed
git reset --hard HEAD~1
```

### Validation Points
After each day's work:
1. Full test suite: `bin/test`
2. Production build: `bin/hugo-build`
3. Lighthouse audit: `bin/lighthouse`
4. Visual check: Manual review of key pages

## Success Metrics

### Code Quality Metrics
- **CSS Size**: Reduce by 30-40%
- **HTML Nesting**: Max 3 levels (from current 5-6)
- **Class Count**: Reduce by 50%
- **Component Reuse**: Increase by 100%

### Performance Metrics
- **Lighthouse Score**: Maintain 90+
- **First Paint**: Improve by 10%
- **Build Time**: Reduce by 20%

### Developer Experience Metrics
- **Template Clarity**: One purpose per template
- **CSS Maintainability**: Clear component boundaries
- **Documentation**: 100% component coverage

## Daily Workflow

```bash
# Morning
1. Pick one refactoring from the sequence
2. Make the change (≤3 lines)
3. Run tests
4. Commit with descriptive message

# Repeat 10-15 times

# End of day
1. Run full test suite
2. Run production build
3. Review git log for clarity
4. Push to feature branch
```

## Why This Approach Works

1. **No Big Bang**: System never breaks
2. **Continuous Delivery**: Can deploy at any point
3. **Learning by Doing**: Understanding improves with each change
4. **Low Stress**: Small changes = small risks
5. **High Quality**: Manual attention to each change

## Anti-Patterns to Avoid

❌ **Don't**: Try to refactor entire template at once
✅ **Do**: Change one class at a time

❌ **Don't**: Add temporary hacks
✅ **Do**: Make each change production-ready

❌ **Don't**: Skip tests to "save time"
✅ **Do**: Test after every single change

❌ **Don't**: Make changes without understanding
✅ **Do**: Research first, change second

❌ **Don't**: Create "refactoring branches" that live for weeks
✅ **Do**: Merge to main daily

## Conclusion

This incremental approach transforms the codebase through hundreds of tiny improvements rather than risky large changes. Each micro-refactoring:
- Takes 5-10 minutes
- Is easily reviewed
- Can be reverted instantly
- Improves the code immediately
- Requires no feature flags or complex tooling

By the end of Week 4, the entire FL-Builder system will be replaced with clean, modern components—without any downtime, bugs, or technical debt.