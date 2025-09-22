# Component System Usage Guide

*Modern BEM-based component system with FL-Builder compatibility*

## Overview

This guide provides comprehensive usage examples for the modern component system created to replace legacy FL-Builder patterns while maintaining full backward compatibility. The system includes three core components with extensive variations and modifiers.

## Component Architecture

### Design Principles

1. **BEM Methodology**: Block-Element-Modifier naming convention with `c-` prefix
2. **FL-Builder Compatibility**: Dual-class strategy ensuring zero visual regression
3. **CSS Custom Properties**: Theme customization and responsive behavior
4. **Progressive Enhancement**: Modern features with graceful fallbacks
5. **Semantic HTML**: Accessibility-first markup patterns

### Component Hierarchy

```
Component System
├── c-button (Button Component)
├── c-nav (Navigation Component)
├── c-content-block (Content Block Component)
├── c-card (Card Component)
└── c-grid (Grid Component)
```

## Button Component (c-button)

### Basic Usage

```html
<!-- Default button -->
<a href="#" class="c-button c-button--default c-button--primary">
  Get Started
</a>

<!-- Small secondary button -->
<button class="c-button c-button--small c-button--secondary">
  Learn More
</button>

<!-- Large outline button -->
<a href="#" class="c-button c-button--large c-button--outline">
  View Portfolio
</a>
```

### Button Variants

#### Size Variants
```html
<!-- Small button -->
<button class="c-button c-button--small c-button--primary">
  Small Button
</button>

<!-- Default size button -->
<button class="c-button c-button--default c-button--primary">
  Default Button
</button>

<!-- Large button -->
<button class="c-button c-button--large c-button--primary">
  Large Button
</button>
```

#### Color Variants
```html
<!-- Primary button (default brand color) -->
<button class="c-button c-button--primary">Primary Action</button>

<!-- Secondary button (neutral gray) -->
<button class="c-button c-button--secondary">Secondary Action</button>

<!-- Outline button (transparent with border) -->
<button class="c-button c-button--outline">Outline Button</button>

<!-- Ghost button (transparent, minimal) -->
<button class="c-button c-button--ghost">Ghost Button</button>
```

#### Layout Variants
```html
<!-- Full width button -->
<button class="c-button c-button--full c-button--primary">
  Full Width Button
</button>

<!-- Centered button wrapper -->
<div class="c-button-wrap--center">
  <button class="c-button c-button--primary">Centered Button</button>
</div>

<!-- Right-aligned button wrapper -->
<div class="c-button-wrap--right">
  <button class="c-button c-button--secondary">Right Button</button>
</div>
```

#### State Examples
```html
<!-- Disabled button -->
<button class="c-button c-button--primary" disabled>
  Disabled Button
</button>

<!-- Manually disabled with class -->
<button class="c-button c-button--primary c-button--disabled">
  Disabled State
</button>
```

### FL-Builder Migration Example

```html
<!-- Before: FL-Builder button -->
<div class="fl-button-wrap fl-button-width-auto fl-button-left">
  <a href="#" class="fl-button" role="button">
    <span class="fl-button-text">Click Here</span>
  </a>
</div>

<!-- After: Modern component (maintains identical styling) -->
<div class="c-button-wrap--left">
  <a href="#" class="c-button c-button--default c-button--primary">
    Click Here
  </a>
</div>
```

## Navigation Component (c-nav)

### Basic Navigation Structure

```html
<nav class="c-nav">
  <div class="c-nav__container">
    <div class="c-nav__content">
      <!-- Logo -->
      <a href="/" class="c-nav__logo">
        <img src="/logo.svg" alt="Company Logo" width="200" height="auto">
      </a>

      <!-- Mobile menu toggle -->
      <button class="c-nav__toggle" aria-label="Toggle navigation menu">
        <span class="sr-only">Menu</span>
      </button>

      <!-- Navigation menu -->
      <div class="c-nav__menu" id="main-navigation">
        <button class="c-nav__close" aria-label="Close navigation menu">
          <span class="sr-only">Close</span>
        </button>

        <ul class="c-nav__list">
          <li class="c-nav__item c-nav__item--active">
            <a href="/services" class="c-nav__link">Services</a>
          </li>
          <li class="c-nav__item">
            <a href="/about" class="c-nav__link">About</a>
          </li>
          <li class="c-nav__item">
            <a href="/contact" class="c-nav__link">Contact</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>
```

### Navigation with Submenu

```html
<nav class="c-nav">
  <div class="c-nav__container">
    <div class="c-nav__content">
      <a href="/" class="c-nav__logo">
        <img src="/logo.svg" alt="Logo">
      </a>

      <button class="c-nav__toggle"></button>

      <div class="c-nav__menu">
        <button class="c-nav__close"></button>

        <ul class="c-nav__list">
          <li class="c-nav__item c-nav__item--has-submenu">
            <a href="/services" class="c-nav__link">Services</a>

            <!-- Submenu -->
            <div class="c-nav__submenu">
              <div class="c-nav__submenu-item">
                <a href="/services/web-development" class="c-nav__submenu-link">
                  <div class="c-nav__submenu-content">
                    <h3 class="c-nav__submenu-title">Web Development</h3>
                    <p class="c-nav__submenu-text">Custom web applications and websites</p>
                  </div>
                </a>
              </div>

              <div class="c-nav__submenu-item">
                <a href="/services/mobile-apps" class="c-nav__submenu-link">
                  <div class="c-nav__submenu-content">
                    <h3 class="c-nav__submenu-title">Mobile Apps</h3>
                    <p class="c-nav__submenu-text">iOS and Android application development</p>
                  </div>
                </a>
              </div>
            </div>
          </li>

          <li class="c-nav__item">
            <a href="/about" class="c-nav__link">About</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>
```

### Navigation States

```html
<!-- Active navigation item -->
<li class="c-nav__item c-nav__item--active">
  <a href="/current-page" class="c-nav__link">Current Page</a>
</li>

<!-- Navigation item with open submenu -->
<li class="c-nav__item c-nav__item--open">
  <a href="/services" class="c-nav__link">Services</a>
  <div class="c-nav__submenu">
    <!-- Submenu content -->
  </div>
</li>

<!-- Open mobile menu -->
<div class="c-nav__menu c-nav__menu--open">
  <!-- Menu content -->
</div>
```

## Content Block Component (c-content-block)

### Basic Content Blocks

```html
<!-- Simple content block -->
<div class="c-content-block">
  <h2 class="c-content-block__heading">Section Heading</h2>
  <p class="c-content-block__paragraph">
    This is a paragraph of content using the content block component
    with semantic BEM structure and proper spacing.
  </p>
</div>

<!-- Text-only content block -->
<div class="c-content-block c-content-block__text">
  <p>Simple text content without additional structure.</p>
</div>
```

### Typography Variations

```html
<!-- Large text with center alignment -->
<div class="c-content-block c-content-block--large-text c-content-block--text-center">
  <h1 class="c-content-block__heading">Hero Heading</h1>
  <p class="c-content-block__paragraph">
    Large, centered content typically used in hero sections.
  </p>
</div>

<!-- Small text with different weight -->
<div class="c-content-block c-content-block--small-text c-content-block--weight-medium">
  <p class="c-content-block__paragraph">
    Small text with medium font weight for subtitles or captions.
  </p>
</div>

<!-- Bold text with right alignment -->
<div class="c-content-block c-content-block--weight-bold c-content-block--text-right">
  <p class="c-content-block__paragraph">
    Bold text aligned to the right side of the container.
  </p>
</div>
```

### Color Variants

```html
<!-- Primary brand color -->
<div class="c-content-block c-content-block--color-primary">
  <h3 class="c-content-block__heading">Brand Color Heading</h3>
  <p class="c-content-block__paragraph">Content in primary brand color.</p>
</div>

<!-- Muted color for secondary content -->
<div class="c-content-block c-content-block--color-muted">
  <p class="c-content-block__paragraph">
    Secondary information in muted color.
  </p>
</div>

<!-- Light color for dark backgrounds -->
<div style="background-color: #333; padding: 2rem;">
  <div class="c-content-block c-content-block--color-light">
    <h3 class="c-content-block__heading">Light Text</h3>
    <p class="c-content-block__paragraph">
      Light colored text for use on dark backgrounds.
    </p>
  </div>
</div>
```

### Common Pattern Examples

```html
<!-- Eyebrow text pattern (20+ instances site-wide) -->
<div class="c-content-block c-content-block--eyebrow">
  Services Overview
</div>

<!-- Followed by main content -->
<div class="c-content-block c-content-block--text-center">
  <h2 class="c-content-block__heading">Our Core Services</h2>
  <p class="c-content-block__paragraph">
    Comprehensive development solutions for modern businesses.
  </p>
</div>

<!-- Centered content pattern (100+ instances) -->
<div class="c-content-block c-content-block--centered">
  <h2 class="c-content-block__heading">Centered Section</h2>
  <p class="c-content-block__paragraph">
    Most common alignment pattern across the entire site.
  </p>
</div>
```

### Spacing Variations

```html
<!-- Tight spacing for compact layouts -->
<div class="c-content-block c-content-block--spacing-tight">
  <h3 class="c-content-block__heading">Compact Heading</h3>
  <p class="c-content-block__paragraph">
    Reduced spacing between elements for tighter layouts.
  </p>
</div>

<!-- Loose spacing for spacious layouts -->
<div class="c-content-block c-content-block--spacing-loose">
  <h2 class="c-content-block__heading">Spacious Heading</h2>
  <p class="c-content-block__paragraph">
    Increased spacing between elements for more breathing room.
  </p>
</div>
```

### FL-Builder Migration Examples

```html
<!-- Phase 1: FL-Builder only -->
<div class="fl-rich-text">
  <h2>Service Heading</h2>
  <p><strong>Bold text</strong> with regular content following.</p>
</div>

<!-- Phase 2: Dual-class transition -->
<div class="fl-rich-text c-content-block c-content-block--weight-normal">
  <h2 class="c-content-block__heading">Service Heading</h2>
  <p class="c-content-block__paragraph">
    <strong>Bold text</strong> with regular content following.
  </p>
</div>

<!-- Phase 3: Pure BEM (future state) -->
<div class="c-content-block c-content-block--weight-normal">
  <h2 class="c-content-block__heading">Service Heading</h2>
  <p class="c-content-block__paragraph">
    <strong>Bold text</strong> with regular content following.
  </p>
</div>
```

## Grid Component (c-grid)

### Basic Grid Layouts

```html
<!-- 2-column grid -->
<div class="c-grid c-grid--2-col">
  <div class="c-card">Card 1</div>
  <div class="c-card">Card 2</div>
</div>

<!-- 3-column grid -->
<div class="c-grid c-grid--3-col">
  <div class="c-card">Card 1</div>
  <div class="c-card">Card 2</div>
  <div class="c-card">Card 3</div>
</div>

<!-- 4-column grid -->
<div class="c-grid c-grid--4-col">
  <div class="c-card">Card 1</div>
  <div class="c-card">Card 2</div>
  <div class="c-card">Card 3</div>
  <div class="c-card">Card 4</div>
</div>
```

## Card Component (c-card)

### Basic Card Structure

```html
<!-- Simple card -->
<div class="c-card">
  <div class="c-card__header">
    <h3>Card Title</h3>
  </div>
  <div class="c-card__body">
    <p>Card content goes here with proper spacing and typography.</p>
  </div>
  <div class="c-card__footer">
    <a href="#" class="c-button c-button--primary">Learn More</a>
  </div>
</div>

<!-- Feature card variant -->
<div class="c-card c-card--feature">
  <div class="c-card__body">
    <h3>Feature Title</h3>
    <p>Centered feature card with prominent call-to-action.</p>
    <a href="#" class="c-button c-button--outline">Get Started</a>
  </div>
</div>
```

## Component Combinations

### Hero Section Example

```html
<section class="hero-section">
  <div class="c-content-block c-content-block--text-center c-content-block--spacing-loose">
    <!-- Eyebrow text -->
    <div class="c-content-block c-content-block--eyebrow">
      Welcome to JetThoughts
    </div>

    <!-- Main heading -->
    <h1 class="c-content-block__heading c-content-block--extra-large-text c-content-block--weight-bold">
      Building Amazing Digital Experiences
    </h1>

    <!-- Description -->
    <p class="c-content-block__paragraph c-content-block--large-text c-content-block--color-muted">
      We create custom web applications and mobile solutions that drive business growth.
    </p>

    <!-- Call-to-action buttons -->
    <div class="c-button-wrap--center">
      <a href="/contact" class="c-button c-button--large c-button--primary">
        Start Your Project
      </a>
      <a href="/portfolio" class="c-button c-button--large c-button--outline">
        View Our Work
      </a>
    </div>
  </div>
</section>
```

### Services Grid Example

```html
<section class="services-section">
  <!-- Section heading -->
  <div class="c-content-block c-content-block--text-center">
    <div class="c-content-block c-content-block--eyebrow">
      What We Offer
    </div>
    <h2 class="c-content-block__heading">Our Services</h2>
    <p class="c-content-block__paragraph c-content-block--color-muted">
      Comprehensive development solutions for modern businesses.
    </p>
  </div>

  <!-- Services grid -->
  <div class="c-grid c-grid--3-col">
    <div class="c-card c-card--feature">
      <div class="c-card__body">
        <h3>Web Development</h3>
        <p>Custom web applications built with modern technologies.</p>
        <a href="/services/web" class="c-button c-button--outline">
          Learn More
        </a>
      </div>
    </div>

    <div class="c-card c-card--feature">
      <div class="c-card__body">
        <h3>Mobile Apps</h3>
        <p>Native and cross-platform mobile application development.</p>
        <a href="/services/mobile" class="c-button c-button--outline">
          Learn More
        </a>
      </div>
    </div>

    <div class="c-card c-card--feature">
      <div class="c-card__body">
        <h3>Consulting</h3>
        <p>Strategic technology consulting and architecture planning.</p>
        <a href="/services/consulting" class="c-button c-button--outline">
          Learn More
        </a>
      </div>
    </div>
  </div>
</section>
```

## Hugo Template Integration

### Partial Template Usage

```go
{{/* Button component partial */}}
{{/* layouts/partials/components/button.html */}}
{{- $classes := slice "c-button" -}}
{{- $classes = $classes | append (printf "c-button--%s" (.size | default "default")) -}}
{{- $classes = $classes | append (printf "c-button--%s" (.color | default "primary")) -}}
{{- if .full }}{{ $classes = $classes | append "c-button--full" }}{{ end -}}

<a href="{{ .url }}" class="{{ delimit $classes " " }}"{{ with .target }} target="{{ . }}"{{ end }}>
  {{ .text }}
</a>
```

### Content Block Template

```go
{{/* Content block component partial */}}
{{/* layouts/partials/components/content-block.html */}}
{{- $classes := slice "c-content-block" -}}
{{- with .size }}{{ $classes = $classes | append (printf "c-content-block--%s-text" .) }}{{ end -}}
{{- with .weight }}{{ $classes = $classes | append (printf "c-content-block--weight-%s" .) }}{{ end -}}
{{- with .alignment }}{{ $classes = $classes | append (printf "c-content-block--text-%s" .) }}{{ end -}}
{{- with .color }}{{ $classes = $classes | append (printf "c-content-block--color-%s" .) }}{{ end -}}
{{- if .eyebrow }}{{ $classes = $classes | append "c-content-block--eyebrow" }}{{ end -}}
{{- if .centered }}{{ $classes = $classes | append "c-content-block--centered" }}{{ end -}}

<div class="{{ delimit $classes " " }}">
  {{ with .heading }}<h2 class="c-content-block__heading">{{ . }}</h2>{{ end }}
  {{ with .content }}<div class="c-content-block__text">{{ . | markdownify }}</div>{{ end }}
</div>
```

### Frontmatter Integration

```yaml
# In content file frontmatter
hero:
  eyebrow: "Welcome to Our Company"
  heading: "We Build Amazing Things"
  content: "Custom development solutions for modern businesses."
  alignment: "center"
  size: "large"
  weight: "semibold"

services:
  - title: "Web Development"
    description: "Custom web applications"
    button:
      text: "Learn More"
      url: "/services/web"
      color: "outline"
```

## Accessibility Considerations

### ARIA Labels and Screen Reader Support

```html
<!-- Navigation with proper ARIA labels -->
<nav class="c-nav" role="navigation" aria-label="Main navigation">
  <button class="c-nav__toggle"
          aria-label="Toggle navigation menu"
          aria-expanded="false"
          aria-controls="main-navigation">
    <span class="sr-only">Menu</span>
  </button>

  <div class="c-nav__menu" id="main-navigation">
    <ul class="c-nav__list" role="menubar">
      <li class="c-nav__item" role="none">
        <a href="/services" class="c-nav__link" role="menuitem">Services</a>
      </li>
    </ul>
  </div>
</nav>

<!-- Buttons with proper labeling -->
<button class="c-button c-button--primary"
        aria-describedby="button-help">
  Submit Form
</button>
<div id="button-help" class="sr-only">
  Submits the contact form and sends your message
</div>
```

### Keyboard Navigation Support

```html
<!-- Focusable navigation items -->
<a href="/services" class="c-nav__link" tabindex="0">Services</a>

<!-- Skip links for screen readers -->
<a href="#main-content" class="sr-only sr-only-focusable c-button">
  Skip to main content
</a>
```

## Performance Considerations

### CSS Loading Strategy

```html
<!-- Critical CSS inline -->
<style>
  /* Critical above-the-fold component styles */
  .c-button { /* ... */ }
  .c-nav { /* ... */ }
</style>

<!-- Non-critical CSS loaded asynchronously -->
<link rel="preload" href="/css/components.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
```

### Component Tree Shaking

```scss
// Import only needed components
@import 'components/button';
@import 'components/navigation';
// Skip @import 'components/card'; if not used
```

## Browser Support

### Progressive Enhancement

```css
/* Base styles work everywhere */
.c-button {
  display: inline-block;
  padding: 12px 24px;
  background: #1a8cff;
  color: white;
}

/* Enhanced styles for modern browsers */
@supports (transform: translateY(-1px)) {
  .c-button:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.12);
  }
}

/* CSS Grid fallback */
.c-grid {
  display: flex;
  flex-wrap: wrap;
}

@supports (display: grid) {
  .c-grid {
    display: grid;
    gap: 24px;
  }
}
```

## Testing Guidelines

### Visual Regression Testing

```bash
# Build and test
bin/hugo-build
bin/test

# Manual visual verification
hugo server --port 1313
# Compare components before/after changes
```

### Component Testing Checklist

- [ ] All variants render correctly
- [ ] FL-Builder compatibility maintained
- [ ] Responsive behavior works across breakpoints
- [ ] Accessibility features function properly
- [ ] Performance impact is minimal
- [ ] Browser support requirements met

---

*This usage guide provides comprehensive examples for implementing the modern component system while maintaining full FL-Builder compatibility and following best practices for accessibility, performance, and maintainability.*