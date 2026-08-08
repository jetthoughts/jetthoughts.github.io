# CSS Semantic Architecture Guide

## Executive Summary

This document defines the comprehensive semantic CSS architecture for the JetThoughts site, establishing naming conventions, component hierarchy, utility classes, and migration strategy from legacy Beaver Builder classes to a modern, maintainable CSS architecture.

## Current State Analysis

### Existing Architecture Issues

1. **Legacy Naming**: Heavy use of Beaver Builder classes (`fl-*`, `pp-*`)
2. **Inconsistent Patterns**: Mixed naming conventions across components
3. **Template-Specific CSS**: Files named by template IDs (701-layout.css)
4. **Inline Styles**: Extensive inline styling reducing maintainability
5. **No Clear Methodology**: Absence of BEM, SMACSS, or other structured approaches

### Current Naming Patterns Identified

```css
/* Legacy Beaver Builder */
.fl-row, .fl-col, .fl-module
.fl-node-[hash]
.fl-builder-content

/* PowerPack Addons */
.pp-tabs, .pp-infobox, .pp-advanced-menu

/* Custom JetThoughts */
.jt-counter-number
.jt-mission-culture
```

## Proposed Semantic Architecture

### Core Principles

1. **Semantic Meaning**: Classes describe purpose, not appearance
2. **Component-Based**: Modular, reusable components
3. **Predictable**: Consistent patterns across the codebase
4. **Scalable**: Easy to extend without conflicts
5. **Maintainable**: Clear hierarchy and relationships

### Naming Methodology: Modified BEM + ITCSS

We adopt a hybrid approach combining BEM (Block Element Modifier) with ITCSS (Inverted Triangle CSS) layers:

```css
/* BEM Structure */
.block {}
.block__element {}
.block--modifier {}

/* ITCSS Layers */
Settings → Tools → Generic → Elements → Objects → Components → Utilities
```

## Semantic Naming Conventions

### 1. Component Naming (Blocks)

```css
/* Layout Components */
.l-header {}        /* Layout: Header */
.l-main {}          /* Layout: Main content */
.l-sidebar {}       /* Layout: Sidebar */
.l-footer {}        /* Layout: Footer */

/* Content Components */
.c-navigation {}    /* Component: Navigation */
.c-card {}          /* Component: Card */
.c-hero {}          /* Component: Hero section */
.c-testimonial {}   /* Component: Testimonial */
.c-service {}       /* Component: Service */

/* UI Components */
.ui-button {}       /* UI: Button */
.ui-form {}         /* UI: Form */
.ui-modal {}        /* UI: Modal */
.ui-tabs {}         /* UI: Tabs */
```

### 2. Element Naming

```css
/* Elements use double underscore */
.c-card__header {}
.c-card__body {}
.c-card__footer {}

.c-navigation__list {}
.c-navigation__item {}
.c-navigation__link {}

.ui-form__group {}
.ui-form__label {}
.ui-form__input {}
```

### 3. Modifier Naming

```css
/* Modifiers use double dash */
.c-card--featured {}
.c-card--compact {}

.ui-button--primary {}
.ui-button--large {}
.ui-button--disabled {}

.c-navigation--horizontal {}
.c-navigation--mobile {}
```

### 4. State Classes

```css
/* State classes use 'is-' or 'has-' prefix */
.is-active {}
.is-loading {}
.is-disabled {}
.is-visible {}

.has-error {}
.has-dropdown {}
.has-children {}
```

## Utility Class System

### Spacing Utilities

```css
/* Margin */
.u-m-0 { margin: 0; }
.u-m-1 { margin: var(--space-1); }  /* 0.25rem */
.u-m-2 { margin: var(--space-2); }  /* 0.5rem */
.u-m-3 { margin: var(--space-3); }  /* 1rem */
.u-m-4 { margin: var(--space-4); }  /* 2rem */
.u-m-5 { margin: var(--space-5); }  /* 4rem */

/* Directional */
.u-mt-* { margin-top: ...; }
.u-mr-* { margin-right: ...; }
.u-mb-* { margin-bottom: ...; }
.u-ml-* { margin-left: ...; }

/* Padding (same pattern) */
.u-p-*, .u-pt-*, .u-pr-*, .u-pb-*, .u-pl-*
```

### Typography Utilities

```css
/* Font Size */
.u-text-xs { font-size: 0.75rem; }
.u-text-sm { font-size: 0.875rem; }
.u-text-base { font-size: 1rem; }
.u-text-lg { font-size: 1.125rem; }
.u-text-xl { font-size: 1.25rem; }
.u-text-2xl { font-size: 1.5rem; }
.u-text-3xl { font-size: 1.875rem; }
.u-text-4xl { font-size: 2.25rem; }

/* Font Weight */
.u-font-light { font-weight: 300; }
.u-font-normal { font-weight: 400; }
.u-font-medium { font-weight: 500; }
.u-font-bold { font-weight: 700; }

/* Text Alignment */
.u-text-left { text-align: left; }
.u-text-center { text-align: center; }
.u-text-right { text-align: right; }
```

### Display Utilities

```css
/* Display */
.u-block { display: block; }
.u-inline-block { display: inline-block; }
.u-inline { display: inline; }
.u-flex { display: flex; }
.u-grid { display: grid; }
.u-hidden { display: none; }

/* Flexbox */
.u-flex-row { flex-direction: row; }
.u-flex-col { flex-direction: column; }
.u-justify-start { justify-content: flex-start; }
.u-justify-center { justify-content: center; }
.u-justify-end { justify-content: flex-end; }
.u-justify-between { justify-content: space-between; }
.u-items-start { align-items: flex-start; }
.u-items-center { align-items: center; }
.u-items-end { align-items: flex-end; }
```

### Responsive Utilities

```css
/* Breakpoint Prefixes */
.u-sm:* { /* Small devices */ }
.u-md:* { /* Medium devices */ }
.u-lg:* { /* Large devices */ }
.u-xl:* { /* Extra large devices */ }

/* Examples */
.u-hidden .u-md:block { /* Hidden on mobile, visible on medium+ */ }
.u-w-full .u-lg:w-1/2 { /* Full width mobile, half on large+ */ }
```

## Component Architecture

### Component File Structure

```
assets/css/
├── settings/
│   ├── _variables.css      /* CSS custom properties */
│   ├── _colors.css         /* Color system */
│   └── _typography.css     /* Type scale */
├── tools/
│   ├── _mixins.css         /* PostCSS mixins */
│   └── _functions.css      /* CSS functions */
├── generic/
│   ├── _reset.css          /* CSS reset */
│   └── _box-sizing.css     /* Box model */
├── elements/
│   ├── _headings.css       /* h1-h6 styles */
│   ├── _links.css          /* Anchor styles */
│   └── _forms.css          /* Form elements */
├── objects/
│   ├── _container.css      /* Container object */
│   ├── _grid.css           /* Grid system */
│   └── _media.css          /* Media object */
├── components/
│   ├── _navigation.css     /* Navigation component */
│   ├── _card.css           /* Card component */
│   ├── _hero.css           /* Hero component */
│   └── _testimonial.css    /* Testimonial component */
└── utilities/
    ├── _spacing.css        /* Spacing utilities */
    ├── _typography.css     /* Text utilities */
    └── _display.css        /* Display utilities */
```

### Component Template

```css
/* components/_card.css */

/* Block */
.c-card {
  --card-padding: var(--space-4);
  --card-border-radius: 0.5rem;
  --card-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);

  display: block;
  padding: var(--card-padding);
  background: var(--color-white);
  border-radius: var(--card-border-radius);
  box-shadow: var(--card-shadow);
}

/* Elements */
.c-card__header {
  margin-bottom: var(--space-3);
  padding-bottom: var(--space-3);
  border-bottom: 1px solid var(--color-gray-200);
}

.c-card__title {
  margin: 0;
  font-size: var(--text-xl);
  font-weight: var(--font-bold);
}

.c-card__body {
  margin-bottom: var(--space-3);
}

.c-card__footer {
  margin-top: auto;
  padding-top: var(--space-3);
  border-top: 1px solid var(--color-gray-200);
}

/* Modifiers */
.c-card--featured {
  --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.15);
  border: 2px solid var(--color-primary);
}

.c-card--compact {
  --card-padding: var(--space-2);
}

/* States */
.c-card.is-loading {
  opacity: 0.6;
  pointer-events: none;
}

/* Responsive */
@media (min-width: 768px) {
  .c-card {
    --card-padding: var(--space-5);
  }
}
```

## Migration Strategy

### Phase 1: Preparation (Week 1)

1. **Audit Current CSS**: Document all unique patterns
2. **Create Mapping**: Legacy class → Semantic class
3. **Set Up Variables**: Define CSS custom properties
4. **Build Core Utilities**: Create utility class system

### Phase 2: Component Migration (Weeks 2-3)

```css
/* Migration Mapping Example */
.fl-row → .l-row
.fl-col → .l-col
.fl-module → .c-module
.pp-tabs → .ui-tabs
.pp-infobox → .c-infobox
.jt-counter-number → .c-counter__value
```

### Phase 3: Template Updates (Weeks 3-4)

1. **Create Semantic Partials**: New template partials with semantic classes
2. **Parallel Classes**: Temporarily support both old and new
3. **Progressive Enhancement**: Add semantic classes alongside legacy
4. **Testing**: Ensure visual consistency

### Phase 4: Cleanup (Week 5)

1. **Remove Legacy Classes**: Strip old Beaver Builder classes
2. **Delete Unused CSS**: Remove deprecated styles
3. **Optimize**: Combine and minify CSS files
4. **Documentation**: Update style guide

## Deprecation Strategy

### Temporary Compatibility Layer

```css
/* _compatibility.css - Temporary during migration */

/* Map old classes to new */
.fl-row { @extend .l-row; }
.fl-col { @extend .l-col; }
.pp-tabs { @extend .ui-tabs; }

/* Add deprecation warnings in development */
.fl-row::before {
  content: "Deprecated: Use .l-row instead" !development;
}
```

### Deprecation Timeline

1. **Month 1**: Add semantic classes alongside legacy
2. **Month 2**: Update all templates to use semantic classes
3. **Month 3**: Add deprecation warnings
4. **Month 4**: Remove legacy CSS files

## Implementation Checklist

### Immediate Actions

- [ ] Create CSS custom properties file
- [ ] Build utility class system
- [ ] Define component naming conventions
- [ ] Set up PostCSS configuration
- [ ] Create migration mapping document

### Short-term (2 weeks)

- [ ] Migrate navigation component
- [ ] Migrate card components
- [ ] Migrate form components
- [ ] Update header/footer templates
- [ ] Create component documentation

### Medium-term (1 month)

- [ ] Complete all component migrations
- [ ] Update all page templates
- [ ] Remove inline styles
- [ ] Implement responsive utilities
- [ ] Performance optimization

### Long-term (3 months)

- [ ] Complete legacy class removal
- [ ] Full documentation
- [ ] Team training
- [ ] Style guide creation
- [ ] Automated testing

## CSS Variables System

```css
/* settings/_variables.css */

:root {
  /* Colors */
  --color-primary: #0066cc;
  --color-secondary: #6c757d;
  --color-success: #28a745;
  --color-danger: #dc3545;
  --color-warning: #ffc107;
  --color-info: #17a2b8;

  /* Grays */
  --color-gray-100: #f8f9fa;
  --color-gray-200: #e9ecef;
  --color-gray-300: #dee2e6;
  --color-gray-400: #ced4da;
  --color-gray-500: #adb5bd;
  --color-gray-600: #6c757d;
  --color-gray-700: #495057;
  --color-gray-800: #343a40;
  --color-gray-900: #212529;

  /* Spacing Scale */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 1rem;
  --space-4: 2rem;
  --space-5: 4rem;
  --space-6: 8rem;

  /* Typography */
  --font-sans: system-ui, -apple-system, sans-serif;
  --font-serif: Georgia, serif;
  --font-mono: 'SF Mono', Monaco, monospace;

  /* Font Weights */
  --font-light: 300;
  --font-normal: 400;
  --font-medium: 500;
  --font-bold: 700;
  --font-black: 900;

  /* Line Heights */
  --leading-none: 1;
  --leading-tight: 1.25;
  --leading-normal: 1.5;
  --leading-relaxed: 1.75;
  --leading-loose: 2;

  /* Breakpoints */
  --screen-sm: 640px;
  --screen-md: 768px;
  --screen-lg: 1024px;
  --screen-xl: 1280px;
  --screen-2xl: 1536px;

  /* Z-index Scale */
  --z-dropdown: 1000;
  --z-sticky: 1020;
  --z-fixed: 1030;
  --z-backdrop: 1040;
  --z-modal: 1050;
  --z-popover: 1060;
  --z-tooltip: 1070;
}
```

## Validation & Testing

### CSS Validation Rules

1. **No Empty Values**: All properties must have valid values
2. **Semantic Names**: Classes must describe purpose
3. **BEM Compliance**: Follow BEM naming strictly
4. **No Deep Nesting**: Maximum 3 levels of nesting
5. **Mobile-First**: Media queries use min-width

### Testing Checklist

- [ ] Visual regression testing
- [ ] Cross-browser compatibility
- [ ] Responsive breakpoints
- [ ] Accessibility compliance
- [ ] Performance metrics
- [ ] CSS validation (W3C)

## Benefits & Outcomes

### Developer Experience

- **Predictable**: Consistent naming patterns
- **Discoverable**: Clear component hierarchy
- **Maintainable**: Modular architecture
- **Scalable**: Easy to extend

### Performance

- **Reduced CSS**: Utility classes reduce duplication
- **Better Caching**: Stable class names
- **Smaller Bundles**: Component-based splitting
- **Faster Rendering**: Optimized selectors

### Business Value

- **Faster Development**: Reusable components
- **Easier Onboarding**: Clear conventions
- **Reduced Bugs**: Predictable cascade
- **Future-Proof**: Modern architecture

## Conclusion

This semantic CSS architecture provides a solid foundation for maintainable, scalable frontend development. The migration from legacy Beaver Builder classes to semantic naming will improve code quality, developer experience, and site performance.