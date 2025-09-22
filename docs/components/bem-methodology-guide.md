# BEM Methodology & Integration Guidelines

*Implementation guidelines for Block-Element-Modifier architecture with FL-Builder compatibility*

## Overview

This document outlines the BEM (Block-Element-Modifier) methodology implementation for the JetThoughts component system, including integration guidelines for FL-Builder compatibility and progressive migration strategies.

## BEM Fundamentals

### Core Concepts

**BEM** is a naming methodology that helps create reusable components and code sharing in front-end development.

- **Block**: A standalone entity that is meaningful on its own
- **Element**: A part of a block that has no standalone meaning
- **Modifier**: A flag on a block or element that changes appearance or behavior

### Naming Convention

```
.block{}
.block__element{}
.block--modifier{}
.block__element--modifier{}
```

### JetThoughts BEM Conventions

We use a prefixed BEM convention with `c-` for components:

```
.c-block{}
.c-block__element{}
.c-block--modifier{}
.c-block__element--modifier{}
```

## Component Prefix System

### Prefix Meanings

- `c-` - **Components**: Reusable UI components
- `l-` - **Layout**: Page layout structures (future)
- `u-` - **Utilities**: Single-purpose utility classes (future)
- `js-` - **JavaScript**: Hooks for JavaScript functionality (future)

### Examples

```css
/* Components */
.c-button{}
.c-nav{}
.c-content-block{}

/* Layout (future) */
.l-header{}
.l-sidebar{}
.l-footer{}

/* Utilities (future) */
.u-text-center{}
.u-margin-top{}
.u-visually-hidden{}
```

## Block Implementation

### Block Definition

A block represents a standalone component that encapsulates related functionality.

#### Good Block Examples

```css
/* ✅ Good: Standalone component */
.c-button {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 25px;
  /* ... */
}

/* ✅ Good: Navigation component */
.c-nav {
  position: relative;
  z-index: 100;
  /* ... */
}

/* ✅ Good: Content block component */
.c-content-block {
  display: block;
  line-height: 1.6;
  /* ... */
}
```

#### Block Characteristics

1. **Reusable**: Can be used anywhere in the project
2. **Independent**: Doesn't depend on other page elements
3. **Meaningful**: Represents a complete UI component
4. **Self-contained**: All styling is contained within the block

### Block Guidelines

```css
/* ✅ Do: Use semantic block names */
.c-button{}
.c-navigation{}
.c-article{}

/* ❌ Don't: Use appearance-based names */
.c-red-button{}
.c-big-text{}
.c-blue-box{}

/* ✅ Do: Use noun-based names */
.c-search-form{}
.c-user-profile{}

/* ❌ Don't: Use verb-based names */
.c-search{}
.c-login{}
```

## Element Implementation

### Element Definition

Elements are parts of a block that have no standalone meaning and are semantically tied to their block.

#### Element Examples

```css
/* Button elements */
.c-button{}
.c-button__text{}
.c-button__icon{}

/* Navigation elements */
.c-nav{}
.c-nav__container{}
.c-nav__content{}
.c-nav__logo{}
.c-nav__menu{}
.c-nav__list{}
.c-nav__item{}
.c-nav__link{}

/* Content block elements */
.c-content-block{}
.c-content-block__text{}
.c-content-block__heading{}
.c-content-block__paragraph{}
```

### Element Guidelines

```css
/* ✅ Do: Use semantic element names */
.c-card__header{}
.c-card__body{}
.c-card__footer{}

/* ❌ Don't: Create elements of elements */
.c-card__header__title{} /* Should be .c-card__title */

/* ✅ Do: Keep elements flat */
.c-nav__item{}
.c-nav__link{}
.c-nav__submenu{}
.c-nav__submenu-item{} /* New element, not nested */

/* ✅ Do: Use descriptive names */
.c-article__date{}
.c-article__author{}
.c-article__content{}
```

### Element Nesting in HTML

While CSS classes should be flat, HTML can be nested:

```html
<!-- ✅ Correct: Flat CSS classes, nested HTML -->
<nav class="c-nav">
  <div class="c-nav__container">
    <div class="c-nav__content">
      <ul class="c-nav__list">
        <li class="c-nav__item">
          <a href="#" class="c-nav__link">Home</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
```

## Modifier Implementation

### Modifier Definition

Modifiers are flags that change the appearance, behavior, or state of blocks or elements.

#### Modifier Types

1. **Boolean modifiers**: Simple flags (present or not)
2. **Key-value modifiers**: Specific values

#### Modifier Examples

```css
/* Boolean modifiers */
.c-button--disabled{}
.c-nav--open{}
.c-content-block--centered{}

/* Key-value modifiers */
.c-button--size-small{}    /* or .c-button--small */
.c-button--size-large{}    /* or .c-button--large */
.c-button--color-primary{} /* or .c-button--primary */
.c-button--color-secondary{} /* or .c-button--secondary */

/* Element modifiers */
.c-nav__item--active{}
.c-nav__link--highlighted{}
.c-content-block__text--large{}
```

### Modifier Guidelines

```css
/* ✅ Do: Use descriptive modifier names */
.c-button--primary{}
.c-button--secondary{}
.c-button--outline{}

/* ✅ Do: Use state-based modifiers */
.c-nav--open{}
.c-nav--closed{}
.c-button--disabled{}
.c-card--highlighted{}

/* ✅ Do: Use size modifiers */
.c-button--small{}
.c-button--large{}
.c-text--big{}

/* ❌ Don't: Use appearance-based modifiers */
.c-button--blue{}
.c-button--20px{}
.c-text--bold{}
```

## JetThoughts Implementation Patterns

### Component Structure Template

```css
/* ========================================
   Component Name (c-component)
   ======================================== */

/* Base component */
.c-component {
  /* Base styles */
}

/* Component elements */
.c-component__element {
  /* Element styles */
}

.c-component__another-element {
  /* Another element styles */
}

/* Component modifiers */
.c-component--modifier {
  /* Modifier styles */
}

/* Element modifiers */
.c-component__element--modifier {
  /* Element modifier styles */
}

/* State classes */
.c-component.is-active,
.c-component--active {
  /* Active state styles */
}

/* FL-Builder compatibility */
.fl-legacy-class {
  /* Extend component functionality */
}
```

### Real Implementation Example

```css
/* ========================================
   Button Component (c-button)
   ======================================== */

/* Base button component */
.c-button {
  border-radius: 25px;
  display: inline-block;
  vertical-align: top;
  text-align: center;
  white-space: nowrap;
  font-family: system-ui, -apple-system, sans-serif;
  font-weight: 700;
  text-decoration: none;
  cursor: pointer;
  border: none;
  transition: all 0.3s ease;
  background-color: var(--jt-primary, #1a8cff);
  color: var(--jt-white, #ffffff);
}

/* Size modifiers */
.c-button--small {
  padding: 9px 18px;
  font-size: 14px;
  line-height: 20px;
  min-width: 80px;
}

.c-button--default {
  padding: 12px 24px;
  font-size: 16px;
  line-height: 24px;
  min-width: 100px;
}

.c-button--large {
  padding: 16px 32px;
  font-size: 18px;
  line-height: 26px;
  min-width: 120px;
}

/* Color variants */
.c-button--primary {
  background-color: var(--jt-primary, #1a8cff);
  color: var(--jt-white, #ffffff);
}

.c-button--secondary {
  background-color: var(--jt-secondary, #6c757d);
  color: var(--jt-white, #ffffff);
}

/* State modifiers */
.c-button:hover {
  text-decoration: none;
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.12);
}

.c-button--disabled,
.c-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}
```

## FL-Builder Integration Strategy

### Dual-Class Approach

The dual-class strategy allows gradual migration while maintaining visual compatibility:

```html
<!-- Phase 1: FL-Builder only -->
<div class="fl-rich-text">
  <h2>Heading</h2>
  <p>Content</p>
</div>

<!-- Phase 2: Dual-class transition -->
<div class="fl-rich-text c-content-block">
  <h2 class="c-content-block__heading">Heading</h2>
  <p class="c-content-block__paragraph">Content</p>
</div>

<!-- Phase 3: BEM only (future) -->
<div class="c-content-block">
  <h2 class="c-content-block__heading">Heading</h2>
  <p class="c-content-block__paragraph">Content</p>
</div>
```

### Compatibility Classes

```css
/* FL-Builder button compatibility */
.fl-button,
.fl-button-wrap .fl-button {
  /* Inherit all c-button base styles */
  border-radius: 25px;
  display: inline-block;
  /* ... rest of c-button styles ... */
}

/* FL-Builder rich text compatibility */
.fl-rich-text {
  display: block;
  line-height: 1.6;
}

.fl-rich-text h1,
.fl-rich-text h2,
.fl-rich-text h3,
.fl-rich-text h4,
.fl-rich-text h5,
.fl-rich-text h6 {
  margin-bottom: 0.75rem;
  font-weight: inherit;
}

.fl-rich-text p {
  margin-bottom: 1rem;
}
```

## File Organization

### Directory Structure

```
themes/beaver/assets/css/
├── components.css              # Main components file
├── components/
│   ├── _button.scss           # Button component (future)
│   ├── _navigation.scss       # Navigation component (future)
│   ├── _content-block.scss    # Content block component (future)
│   ├── _card.scss             # Card component (future)
│   └── _grid.scss             # Grid component (future)
├── utilities/
│   ├── _spacing.scss          # Spacing utilities
│   └── _colors.scss           # Color utilities
└── legacy/
    └── _fl-builder.scss       # FL-Builder compatibility
```

### Component File Template

```scss
/* components/_component-name.scss */

/* ========================================
   Component Name (c-component-name)
   ======================================== */

// Component variables
$component-name-padding: 1rem !default;
$component-name-border-radius: 4px !default;

// Base component
.c-component-name {
  // Base styles
}

// Elements
.c-component-name__element {
  // Element styles
}

// Modifiers
.c-component-name--modifier {
  // Modifier styles
}

// Responsive behavior
@media (max-width: 768px) {
  .c-component-name {
    // Mobile styles
  }
}

// FL-Builder compatibility
.fl-legacy-component {
  @extend .c-component-name;
}
```

## Naming Best Practices

### Do's

```css
/* ✅ Use clear, semantic names */
.c-search-form{}
.c-user-profile{}
.c-product-card{}

/* ✅ Use consistent terminology */
.c-button--primary{}
.c-link--primary{}
.c-card--primary{}

/* ✅ Use logical groupings */
.c-button--small{}
.c-button--medium{}
.c-button--large{}

/* ✅ Use state-based names */
.c-nav--open{}
.c-button--disabled{}
.c-card--highlighted{}
```

### Don'ts

```css
/* ❌ Don't use presentation-based names */
.c-red-button{}
.c-big-text{}
.c-left-sidebar{}

/* ❌ Don't abbreviate unnecessarily */
.c-btn{}
.c-nav-itm{}
.c-usr-prof{}

/* ❌ Don't use technical names */
.c-div{}
.c-span{}
.c-float-left{}

/* ❌ Don't nest elements */
.c-card__header__title{}
.c-nav__menu__item__link{}
```

## Common Patterns

### Component Variations

```css
/* Size variations */
.c-component--small{}
.c-component--medium{}
.c-component--large{}

/* Color variations */
.c-component--primary{}
.c-component--secondary{}
.c-component--tertiary{}

/* State variations */
.c-component--active{}
.c-component--disabled{}
.c-component--loading{}

/* Layout variations */
.c-component--full-width{}
.c-component--centered{}
.c-component--inline{}
```

### Responsive Modifiers

```css
/* Responsive size modifiers */
.c-component--small{}
.c-component--medium{}
.c-component--large{}

@media (max-width: 768px) {
  .c-component--small-mobile{}
  .c-component--hidden-mobile{}
}

@media (min-width: 1024px) {
  .c-component--large-desktop{}
  .c-component--show-desktop{}
}
```

## CSS Custom Properties Integration

### Component-Level Properties

```css
.c-button {
  /* Component-specific custom properties */
  --button-padding-x: 24px;
  --button-padding-y: 12px;
  --button-border-radius: 25px;
  --button-transition: all 0.3s ease;

  /* Use properties in styles */
  padding: var(--button-padding-y) var(--button-padding-x);
  border-radius: var(--button-border-radius);
  transition: var(--button-transition);
}

/* Modifier override properties */
.c-button--small {
  --button-padding-x: 18px;
  --button-padding-y: 9px;
}

.c-button--large {
  --button-padding-x: 32px;
  --button-padding-y: 16px;
}
```

### Global Properties

```css
:root {
  /* Brand colors */
  --jt-primary: #1a8cff;
  --jt-secondary: #6c757d;
  --jt-white: #ffffff;
  --jt-text-primary: #333333;

  /* Spacing scale */
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;

  /* Typography scale */
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.25rem;
  --font-size-xl: 1.5rem;
}
```

## Testing BEM Implementation

### HTML Validation

```html
<!-- ✅ Valid BEM structure -->
<div class="c-card c-card--highlighted">
  <div class="c-card__header">
    <h3 class="c-card__title">Card Title</h3>
  </div>
  <div class="c-card__body">
    <p class="c-card__text">Card content</p>
  </div>
  <div class="c-card__footer">
    <button class="c-button c-button--primary c-button--small">
      Action
    </button>
  </div>
</div>
```

### CSS Validation

```css
/* ✅ Valid BEM CSS */
.c-card {
  border: 1px solid #ddd;
  border-radius: 8px;
}

.c-card--highlighted {
  border-color: var(--jt-primary);
  box-shadow: 0 4px 8px rgba(26, 140, 255, 0.2);
}

.c-card__header {
  padding: 1rem;
  border-bottom: 1px solid #eee;
}

.c-card__title {
  margin: 0;
  font-size: 1.25rem;
  font-weight: 600;
}
```

## Migration Guidelines

### Step-by-Step Process

1. **Audit existing HTML**: Identify FL-Builder patterns to modernize
2. **Create BEM components**: Build new component system
3. **Implement dual-classes**: Add BEM classes alongside FL-Builder classes
4. **Test compatibility**: Ensure visual parity is maintained
5. **Document changes**: Update component documentation
6. **Plan cleanup**: Schedule FL-Builder class removal (future phase)

### Migration Checklist

- [ ] Component follows BEM naming conventions
- [ ] All elements are properly scoped to their block
- [ ] Modifiers are semantic, not presentational
- [ ] FL-Builder compatibility is maintained
- [ ] Responsive behavior is preserved
- [ ] Accessibility features are included
- [ ] CSS custom properties are used appropriately
- [ ] Documentation is updated

## Troubleshooting

### Common Issues

**Issue**: BEM classes not applying
**Solution**: Check CSS specificity and ensure proper class naming

**Issue**: FL-Builder compatibility broken
**Solution**: Verify compatibility classes are included and properly extended

**Issue**: Modifier classes not working
**Solution**: Ensure modifiers are applied in addition to base block class

### Debug Utilities

```css
/* Temporary debugging classes */
.debug-bem-block {
  outline: 2px solid red !important;
}

.debug-bem-element {
  outline: 2px solid blue !important;
}

.debug-bem-modifier {
  outline: 2px solid green !important;
}
```

## Performance Considerations

### CSS Optimization

```css
/* ✅ Efficient BEM selectors */
.c-button {}
.c-button--primary {}
.c-button__text {}

/* ❌ Avoid deep nesting */
.c-nav .c-nav__list .c-nav__item .c-nav__link {}

/* ✅ Use direct selectors */
.c-nav__link {}
```

### Bundle Size Management

```scss
// Import only needed components
@import 'components/button';
@import 'components/navigation';
// Don't import unused components

// Use tree-shaking for modifiers
.c-button--primary { /* styles */ }
// Only include if primary buttons are used
```

---

*This BEM methodology guide provides comprehensive guidelines for implementing consistent, maintainable, and scalable CSS architecture while preserving FL-Builder compatibility and following modern best practices.*