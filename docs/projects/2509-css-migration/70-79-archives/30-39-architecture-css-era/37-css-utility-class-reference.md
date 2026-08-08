# CSS Utility Class Reference

## Quick Reference Guide

This document provides a comprehensive reference for all utility classes in the new semantic CSS system. Utilities follow a consistent naming pattern for predictability and ease of use.

## Naming Convention

```
.[prefix]-[property]-[value]
.[prefix]-[property]-[modifier]-[value]

Examples:
.u-m-4        → utility margin 4 units
.u-text-lg    → utility text large
.u-md:block   → utility medium-breakpoint block
```

## Spacing Utilities

### Margin

| Class | Property | Value | Pixels |
|-------|----------|-------|--------|
| `.u-m-0` | margin | 0 | 0px |
| `.u-m-1` | margin | 0.25rem | 4px |
| `.u-m-2` | margin | 0.5rem | 8px |
| `.u-m-3` | margin | 1rem | 16px |
| `.u-m-4` | margin | 2rem | 32px |
| `.u-m-5` | margin | 4rem | 64px |
| `.u-m-auto` | margin | auto | auto |

### Directional Margin

```css
/* Top */
.u-mt-[0-5] { margin-top: value; }

/* Right */
.u-mr-[0-5] { margin-right: value; }

/* Bottom */
.u-mb-[0-5] { margin-bottom: value; }

/* Left */
.u-ml-[0-5] { margin-left: value; }

/* Horizontal (left & right) */
.u-mx-[0-5] { margin-left: value; margin-right: value; }

/* Vertical (top & bottom) */
.u-my-[0-5] { margin-top: value; margin-bottom: value; }
```

### Padding

| Class | Property | Value | Pixels |
|-------|----------|-------|--------|
| `.u-p-0` | padding | 0 | 0px |
| `.u-p-1` | padding | 0.25rem | 4px |
| `.u-p-2` | padding | 0.5rem | 8px |
| `.u-p-3` | padding | 1rem | 16px |
| `.u-p-4` | padding | 2rem | 32px |
| `.u-p-5` | padding | 4rem | 64px |

### Directional Padding

```css
/* Same pattern as margin */
.u-pt-[0-5]  /* top */
.u-pr-[0-5]  /* right */
.u-pb-[0-5]  /* bottom */
.u-pl-[0-5]  /* left */
.u-px-[0-5]  /* horizontal */
.u-py-[0-5]  /* vertical */
```

### Space Between (Flexbox/Grid)

```css
.u-space-x-[0-5] > * + * { margin-left: value; }
.u-space-y-[0-5] > * + * { margin-top: value; }
```

## Typography Utilities

### Font Size

| Class | Font Size | Pixels | Line Height |
|-------|-----------|--------|-------------|
| `.u-text-xs` | 0.75rem | 12px | 1rem |
| `.u-text-sm` | 0.875rem | 14px | 1.25rem |
| `.u-text-base` | 1rem | 16px | 1.5rem |
| `.u-text-lg` | 1.125rem | 18px | 1.75rem |
| `.u-text-xl` | 1.25rem | 20px | 1.75rem |
| `.u-text-2xl` | 1.5rem | 24px | 2rem |
| `.u-text-3xl` | 1.875rem | 30px | 2.25rem |
| `.u-text-4xl` | 2.25rem | 36px | 2.5rem |
| `.u-text-5xl` | 3rem | 48px | 1 |
| `.u-text-6xl` | 3.75rem | 60px | 1 |

### Font Weight

| Class | Weight | Value |
|-------|--------|-------|
| `.u-font-thin` | 100 | Thin |
| `.u-font-light` | 300 | Light |
| `.u-font-normal` | 400 | Normal |
| `.u-font-medium` | 500 | Medium |
| `.u-font-semibold` | 600 | Semibold |
| `.u-font-bold` | 700 | Bold |
| `.u-font-extrabold` | 800 | Extrabold |
| `.u-font-black` | 900 | Black |

### Text Alignment

```css
.u-text-left    { text-align: left; }
.u-text-center  { text-align: center; }
.u-text-right   { text-align: right; }
.u-text-justify { text-align: justify; }
```

### Text Transform

```css
.u-uppercase  { text-transform: uppercase; }
.u-lowercase  { text-transform: lowercase; }
.u-capitalize { text-transform: capitalize; }
.u-normal-case { text-transform: none; }
```

### Text Decoration

```css
.u-underline     { text-decoration: underline; }
.u-line-through  { text-decoration: line-through; }
.u-no-underline  { text-decoration: none; }
```

### Line Height

| Class | Line Height |
|-------|-------------|
| `.u-leading-none` | 1 |
| `.u-leading-tight` | 1.25 |
| `.u-leading-snug` | 1.375 |
| `.u-leading-normal` | 1.5 |
| `.u-leading-relaxed` | 1.625 |
| `.u-leading-loose` | 2 |

## Color Utilities

### Text Color

```css
/* Primary Colors */
.u-text-primary   { color: var(--color-primary); }
.u-text-secondary { color: var(--color-secondary); }
.u-text-success   { color: var(--color-success); }
.u-text-danger    { color: var(--color-danger); }
.u-text-warning   { color: var(--color-warning); }
.u-text-info      { color: var(--color-info); }

/* Grays */
.u-text-gray-100  { color: var(--color-gray-100); }
.u-text-gray-200  { color: var(--color-gray-200); }
.u-text-gray-300  { color: var(--color-gray-300); }
.u-text-gray-400  { color: var(--color-gray-400); }
.u-text-gray-500  { color: var(--color-gray-500); }
.u-text-gray-600  { color: var(--color-gray-600); }
.u-text-gray-700  { color: var(--color-gray-700); }
.u-text-gray-800  { color: var(--color-gray-800); }
.u-text-gray-900  { color: var(--color-gray-900); }

/* Semantic */
.u-text-muted     { color: var(--color-text-muted); }
.u-text-body      { color: var(--color-text); }
.u-text-white     { color: white; }
.u-text-black     { color: black; }
```

### Background Color

```css
/* Same pattern with .u-bg-* prefix */
.u-bg-primary   { background-color: var(--color-primary); }
.u-bg-gray-100  { background-color: var(--color-gray-100); }
.u-bg-white     { background-color: white; }
.u-bg-transparent { background-color: transparent; }
```

## Display Utilities

### Display Types

```css
.u-block        { display: block; }
.u-inline-block { display: inline-block; }
.u-inline       { display: inline; }
.u-flex         { display: flex; }
.u-inline-flex  { display: inline-flex; }
.u-grid         { display: grid; }
.u-inline-grid  { display: inline-grid; }
.u-table        { display: table; }
.u-hidden       { display: none; }
```

### Visibility

```css
.u-visible    { visibility: visible; }
.u-invisible  { visibility: hidden; }
```

### Opacity

```css
.u-opacity-0   { opacity: 0; }
.u-opacity-25  { opacity: 0.25; }
.u-opacity-50  { opacity: 0.5; }
.u-opacity-75  { opacity: 0.75; }
.u-opacity-100 { opacity: 1; }
```

## Flexbox Utilities

### Flex Direction

```css
.u-flex-row         { flex-direction: row; }
.u-flex-row-reverse { flex-direction: row-reverse; }
.u-flex-col         { flex-direction: column; }
.u-flex-col-reverse { flex-direction: column-reverse; }
```

### Flex Wrap

```css
.u-flex-wrap         { flex-wrap: wrap; }
.u-flex-wrap-reverse { flex-wrap: wrap-reverse; }
.u-flex-nowrap       { flex-wrap: nowrap; }
```

### Justify Content

```css
.u-justify-start    { justify-content: flex-start; }
.u-justify-end      { justify-content: flex-end; }
.u-justify-center   { justify-content: center; }
.u-justify-between  { justify-content: space-between; }
.u-justify-around   { justify-content: space-around; }
.u-justify-evenly   { justify-content: space-evenly; }
```

### Align Items

```css
.u-items-start    { align-items: flex-start; }
.u-items-end      { align-items: flex-end; }
.u-items-center   { align-items: center; }
.u-items-baseline { align-items: baseline; }
.u-items-stretch  { align-items: stretch; }
```

### Align Self

```css
.u-self-auto     { align-self: auto; }
.u-self-start    { align-self: flex-start; }
.u-self-end      { align-self: flex-end; }
.u-self-center   { align-self: center; }
.u-self-stretch  { align-self: stretch; }
```

### Flex Grow/Shrink

```css
.u-flex-1     { flex: 1 1 0%; }
.u-flex-auto  { flex: 1 1 auto; }
.u-flex-initial { flex: 0 1 auto; }
.u-flex-none  { flex: none; }

.u-grow-0     { flex-grow: 0; }
.u-grow       { flex-grow: 1; }

.u-shrink-0   { flex-shrink: 0; }
.u-shrink     { flex-shrink: 1; }
```

## Grid Utilities

### Grid Template Columns

```css
.u-grid-cols-1  { grid-template-columns: repeat(1, minmax(0, 1fr)); }
.u-grid-cols-2  { grid-template-columns: repeat(2, minmax(0, 1fr)); }
.u-grid-cols-3  { grid-template-columns: repeat(3, minmax(0, 1fr)); }
.u-grid-cols-4  { grid-template-columns: repeat(4, minmax(0, 1fr)); }
.u-grid-cols-5  { grid-template-columns: repeat(5, minmax(0, 1fr)); }
.u-grid-cols-6  { grid-template-columns: repeat(6, minmax(0, 1fr)); }
.u-grid-cols-12 { grid-template-columns: repeat(12, minmax(0, 1fr)); }
```

### Gap

```css
.u-gap-0  { gap: 0; }
.u-gap-1  { gap: 0.25rem; }
.u-gap-2  { gap: 0.5rem; }
.u-gap-3  { gap: 1rem; }
.u-gap-4  { gap: 2rem; }
.u-gap-5  { gap: 4rem; }

/* Directional */
.u-gap-x-[0-5] { column-gap: value; }
.u-gap-y-[0-5] { row-gap: value; }
```

## Layout Utilities

### Width

```css
/* Fixed */
.u-w-0     { width: 0; }
.u-w-auto  { width: auto; }
.u-w-full  { width: 100%; }
.u-w-screen { width: 100vw; }
.u-w-min   { width: min-content; }
.u-w-max   { width: max-content; }

/* Fractions */
.u-w-1/2   { width: 50%; }
.u-w-1/3   { width: 33.333333%; }
.u-w-2/3   { width: 66.666667%; }
.u-w-1/4   { width: 25%; }
.u-w-3/4   { width: 75%; }
.u-w-1/5   { width: 20%; }
.u-w-2/5   { width: 40%; }
.u-w-3/5   { width: 60%; }
.u-w-4/5   { width: 80%; }
```

### Height

```css
/* Same pattern with .u-h-* prefix */
.u-h-0      { height: 0; }
.u-h-auto   { height: auto; }
.u-h-full   { height: 100%; }
.u-h-screen { height: 100vh; }
```

### Max Width

```css
.u-max-w-xs   { max-width: 20rem; }    /* 320px */
.u-max-w-sm   { max-width: 24rem; }    /* 384px */
.u-max-w-md   { max-width: 28rem; }    /* 448px */
.u-max-w-lg   { max-width: 32rem; }    /* 512px */
.u-max-w-xl   { max-width: 36rem; }    /* 576px */
.u-max-w-2xl  { max-width: 42rem; }    /* 672px */
.u-max-w-3xl  { max-width: 48rem; }    /* 768px */
.u-max-w-4xl  { max-width: 56rem; }    /* 896px */
.u-max-w-5xl  { max-width: 64rem; }    /* 1024px */
.u-max-w-6xl  { max-width: 72rem; }    /* 1152px */
.u-max-w-7xl  { max-width: 80rem; }    /* 1280px */
.u-max-w-full { max-width: 100%; }
.u-max-w-none { max-width: none; }
```

## Position Utilities

### Position Type

```css
.u-static   { position: static; }
.u-fixed    { position: fixed; }
.u-absolute { position: absolute; }
.u-relative { position: relative; }
.u-sticky   { position: sticky; }
```

### Position Values

```css
/* Directional positioning */
.u-top-0     { top: 0; }
.u-right-0   { right: 0; }
.u-bottom-0  { bottom: 0; }
.u-left-0    { left: 0; }

.u-top-auto    { top: auto; }
.u-right-auto  { right: auto; }
.u-bottom-auto { bottom: auto; }
.u-left-auto   { left: auto; }

/* Full positioning */
.u-inset-0  { top: 0; right: 0; bottom: 0; left: 0; }
.u-inset-x-0 { left: 0; right: 0; }
.u-inset-y-0 { top: 0; bottom: 0; }
```

### Z-Index

```css
.u-z-0    { z-index: 0; }
.u-z-10   { z-index: 10; }
.u-z-20   { z-index: 20; }
.u-z-30   { z-index: 30; }
.u-z-40   { z-index: 40; }
.u-z-50   { z-index: 50; }
.u-z-auto { z-index: auto; }
```

## Border Utilities

### Border Width

```css
.u-border    { border-width: 1px; }
.u-border-0  { border-width: 0; }
.u-border-2  { border-width: 2px; }
.u-border-4  { border-width: 4px; }
.u-border-8  { border-width: 8px; }

/* Directional */
.u-border-t  { border-top-width: 1px; }
.u-border-r  { border-right-width: 1px; }
.u-border-b  { border-bottom-width: 1px; }
.u-border-l  { border-left-width: 1px; }
```

### Border Style

```css
.u-border-solid  { border-style: solid; }
.u-border-dashed { border-style: dashed; }
.u-border-dotted { border-style: dotted; }
.u-border-none   { border-style: none; }
```

### Border Radius

```css
.u-rounded-none { border-radius: 0; }
.u-rounded-sm   { border-radius: 0.125rem; }
.u-rounded      { border-radius: 0.25rem; }
.u-rounded-md   { border-radius: 0.375rem; }
.u-rounded-lg   { border-radius: 0.5rem; }
.u-rounded-xl   { border-radius: 0.75rem; }
.u-rounded-2xl  { border-radius: 1rem; }
.u-rounded-3xl  { border-radius: 1.5rem; }
.u-rounded-full { border-radius: 9999px; }
```

## Responsive Utilities

### Breakpoint Prefixes

All utilities can be prefixed with breakpoint modifiers:

```css
/* Breakpoints */
sm: @media (min-width: 640px)
md: @media (min-width: 768px)
lg: @media (min-width: 1024px)
xl: @media (min-width: 1280px)
2xl: @media (min-width: 1536px)
```

### Usage Examples

```html
<!-- Hidden on mobile, block on medium+ -->
<div class="u-hidden u-md:block">...</div>

<!-- Full width on mobile, half on large+ -->
<div class="u-w-full u-lg:w-1/2">...</div>

<!-- Different padding at different breakpoints -->
<div class="u-p-2 u-md:p-3 u-lg:p-4">...</div>

<!-- Responsive flexbox -->
<div class="u-flex-col u-md:flex-row">...</div>

<!-- Responsive grid -->
<div class="u-grid-cols-1 u-md:grid-cols-2 u-lg:grid-cols-3">...</div>
```

## State Utilities

### Hover States

```css
/* Add :hover to any utility */
.u-hover:bg-primary:hover { background-color: var(--color-primary); }
.u-hover:text-white:hover { color: white; }
.u-hover:scale-105:hover  { transform: scale(1.05); }
```

### Focus States

```css
/* Add :focus to any utility */
.u-focus:outline-none:focus { outline: none; }
.u-focus:ring:focus { box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5); }
```

### Active States

```css
/* Add :active to any utility */
.u-active:bg-primary:active { background-color: var(--color-primary); }
```

## Accessibility Utilities

### Screen Reader

```css
.u-sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}

.u-not-sr-only {
  position: static;
  width: auto;
  height: auto;
  padding: 0;
  margin: 0;
  overflow: visible;
  clip: auto;
  white-space: normal;
}
```

### Focus Management

```css
.u-focus-visible:focus {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
}

.u-focus-within:focus-within {
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
}
```

## Animation Utilities

### Transitions

```css
.u-transition       { transition-property: all; transition-duration: 150ms; }
.u-transition-none  { transition-property: none; }
.u-transition-colors { transition-property: background-color, border-color, color, fill, stroke; }
.u-transition-opacity { transition-property: opacity; }
.u-transition-shadow { transition-property: box-shadow; }
.u-transition-transform { transition-property: transform; }

/* Duration */
.u-duration-75   { transition-duration: 75ms; }
.u-duration-100  { transition-duration: 100ms; }
.u-duration-150  { transition-duration: 150ms; }
.u-duration-200  { transition-duration: 200ms; }
.u-duration-300  { transition-duration: 300ms; }
.u-duration-500  { transition-duration: 500ms; }
```

### Transform

```css
/* Scale */
.u-scale-0   { transform: scale(0); }
.u-scale-50  { transform: scale(0.5); }
.u-scale-75  { transform: scale(0.75); }
.u-scale-90  { transform: scale(0.9); }
.u-scale-95  { transform: scale(0.95); }
.u-scale-100 { transform: scale(1); }
.u-scale-105 { transform: scale(1.05); }
.u-scale-110 { transform: scale(1.1); }
.u-scale-125 { transform: scale(1.25); }
.u-scale-150 { transform: scale(1.5); }

/* Rotate */
.u-rotate-0   { transform: rotate(0deg); }
.u-rotate-45  { transform: rotate(45deg); }
.u-rotate-90  { transform: rotate(90deg); }
.u-rotate-180 { transform: rotate(180deg); }

/* Translate */
.u-translate-x-0 { transform: translateX(0); }
.u-translate-y-0 { transform: translateY(0); }
.u-translate-x-full { transform: translateX(100%); }
.u-translate-y-full { transform: translateY(100%); }
```

## Utility Combinations

### Common Patterns

```html
<!-- Card -->
<div class="u-bg-white u-rounded-lg u-shadow u-p-4">...</div>

<!-- Button -->
<button class="u-bg-primary u-text-white u-px-4 u-py-2 u-rounded u-hover:bg-primary-dark">
  Click Me
</button>

<!-- Container -->
<div class="u-max-w-7xl u-mx-auto u-px-4 u-sm:px-6 u-lg:px-8">...</div>

<!-- Flexbox Center -->
<div class="u-flex u-items-center u-justify-center">...</div>

<!-- Responsive Grid -->
<div class="u-grid u-grid-cols-1 u-md:grid-cols-2 u-lg:grid-cols-3 u-gap-4">...</div>

<!-- Overlay -->
<div class="u-fixed u-inset-0 u-bg-black u-opacity-50 u-z-40">...</div>

<!-- Badge -->
<span class="u-inline-flex u-items-center u-px-2 u-py-1 u-rounded-full u-text-xs u-font-medium u-bg-primary u-text-white">
  New
</span>
```

## Best Practices

### Do's
- ✅ Use utilities for small, one-off styles
- ✅ Combine utilities for common patterns
- ✅ Use responsive prefixes for adaptive design
- ✅ Extract repeated utility combinations into components
- ✅ Use semantic color variables

### Don'ts
- ❌ Don't use utilities for complex components
- ❌ Don't override utilities with inline styles
- ❌ Don't create utilities for one-time use
- ❌ Don't use arbitrary values
- ❌ Don't nest utilities unnecessarily

## Performance Tips

1. **PurgeCSS Integration**: Remove unused utilities in production
2. **Critical CSS**: Include only above-fold utilities
3. **Component Extraction**: Convert repeated patterns to components
4. **Utility Grouping**: Group related utilities in HTML
5. **CSS Variables**: Use variables for consistency

## Conclusion

This utility class system provides a comprehensive toolkit for rapid UI development while maintaining consistency and performance. Use utilities wisely in combination with semantic components for the best results.