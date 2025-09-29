# Component CSS Usage Strategy

## Overview
This document outlines the strategy for including BEM component CSS in Hugo templates to prevent global conflicts and maintain performance.

## Component CSS Isolation Approach

### Principle
Component CSS should be included only where needed, not globally, to:
- Prevent visual regressions from global CSS conflicts
- Reduce CSS bundle sizes for pages that don't need specific components
- Maintain clear dependencies between templates and their required styles

## Implementation Strategy

### 1. Global Components (Always Included)
These components are used across many pages and can be globally imported:
- `content-block` - Basic content structure used throughout site
- `css-utilities` - Utility classes for spacing, typography, etc.

Location: `/themes/beaver/assets/css/components.css`

### 2. Page-Specific Components
These components are included only in the bundles that need them:

#### c-hero Component
- **Used in**: Homepage, About page (potentially)
- **Include via**: Add to page's $nonCriticalResources slice
- **Example**:
  ```go
  (resources.Get "css/components/blocks/c-hero.css")
  ```

#### c-content Component
- **Used in**: Content-heavy pages, blog posts
- **Include via**: Add to specific template bundles
- **Status**: Currently isolated, not globally imported

#### c-nav Component (Planned)
- **Used in**: All pages (via baseof.html)
- **Include via**: Navigation bundle (already exists)
- **Status**: To be created

#### c-card Component (Planned)
- **Used in**: Services, testimonials, team sections
- **Include via**: Specific page bundles
- **Status**: To be created

## Hugo Template Integration Pattern

### Step 1: Identify Component Usage
Check template partials for component classes:
```bash
grep -r "c-[component-name]" themes/beaver/layouts/
```

### Step 2: Add to Resource Bundle
In the template's `{{ define "footer" }}` or similar section:
```go
{{- $nonCriticalResources := slice
  // ... existing resources ...
  (resources.Get "css/components/blocks/c-[component-name].css")
}}
```

### Step 3: Test for Regressions
After adding component CSS:
```bash
bin/rake test:critical
```

## Dual-Class Migration Strategy

During migration, templates use both FL-Builder and BEM classes:
```html
<div class="fl-row fl-row-bg-photo c-hero c-hero--centered">
  <div class="fl-row-content c-hero__content">
    <!-- Content with both class systems -->
  </div>
</div>
```

This allows:
- Gradual migration without breaking existing styles
- Testing new components alongside old framework
- Easy rollback if issues arise

## Testing Protocol

Before deploying component changes:
1. Run visual regression tests: `bin/rake test:critical`
2. Visual regression threshold: 5% maximum
3. Check specific pages that use the component
4. Verify no global CSS leakage

## Success Metrics
- Visual regression: <5% on any page
- CSS bundle size: Reduced by isolating components
- Build time: No significant increase
- Maintainability: Clear component-to-template mapping

## Next Steps
1. Create c-nav component for navigation
2. Create c-card component for content cards
3. Migrate more FL-Builder patterns to BEM components
4. Remove FL-Builder CSS once all components migrated