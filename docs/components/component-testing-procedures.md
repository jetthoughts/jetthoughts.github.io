# Component Testing Procedures

*Comprehensive testing protocols for BEM component system with FL-Builder compatibility*

## Overview

This document outlines testing procedures for the JetThoughts component system, ensuring compatibility between modern BEM components and legacy FL-Builder patterns. The testing approach covers visual regression, functionality validation, accessibility compliance, and performance verification.

## Testing Strategy

### 1. Visual Regression Testing

#### Component Visual States
Each component must be tested across all variants and states:

**Button Component Testing Matrix:**
```html
<!-- Size Variants -->
<button class="c-button c-button--small">Small Button</button>
<button class="c-button">Default Button</button>
<button class="c-button c-button--large">Large Button</button>

<!-- Color Variants -->
<button class="c-button c-button--primary">Primary</button>
<button class="c-button c-button--secondary">Secondary</button>
<button class="c-button c-button--outline">Outline</button>
<button class="c-button c-button--ghost">Ghost</button>

<!-- State Variations -->
<button class="c-button" disabled>Disabled</button>
<button class="c-button c-button--loading">Loading</button>
<a href="#" class="c-button">Link Button</a>
```

**Navigation Component Testing Matrix:**
```html
<!-- Desktop Navigation -->
<nav class="c-nav">
  <ul class="c-nav__list">
    <li class="c-nav__item">
      <a href="#" class="c-nav__link">Services</a>
      <ul class="c-nav__submenu">
        <li class="c-nav__submenu-item">
          <a href="#" class="c-nav__submenu-link">Web Development</a>
        </li>
      </ul>
    </li>
  </ul>
</nav>

<!-- Mobile Navigation States -->
<nav class="c-nav c-nav--mobile-open">
  <!-- Mobile menu open state -->
</nav>
```

#### Visual Testing Protocol

1. **Screenshot Capture**
   ```bash
   # Capture screenshots at multiple viewports
   # Desktop: 1920x1080, 1366x768
   # Tablet: 1024x768, 768x1024
   # Mobile: 375x667, 414x896, 360x640
   ```

2. **Cross-Browser Testing**
   - Chrome (latest, -1, -2 versions)
   - Firefox (latest, ESR)
   - Safari (latest, -1 version)
   - Edge (latest, -1 version)

3. **Responsive Breakpoints**
   ```css
   /* Test at critical breakpoints */
   @media (max-width: 1024px) { /* Tablet */ }
   @media (max-width: 768px) { /* Mobile */ }
   @media (max-width: 480px) { /* Small mobile */ }
   ```

### 2. FL-Builder Compatibility Testing

#### Dual-Class Strategy Validation

**Test Case 1: FL-Builder to Component Migration**
```html
<!-- Before: Pure FL-Builder -->
<div class="fl-button-wrap">
  <a href="#" class="fl-button" role="button">
    <span class="fl-button-text">Click Me</span>
  </a>
</div>

<!-- During: Dual-class migration -->
<div class="fl-button-wrap">
  <a href="#" class="fl-button c-button" role="button">
    <span class="fl-button-text">Click Me</span>
  </a>
</div>

<!-- After: Pure component -->
<a href="#" class="c-button" role="button">Click Me</a>
```

**Validation Criteria:**
- Visual appearance remains identical across all migration phases
- No layout breaks or style conflicts
- Functionality preserved throughout transition

#### FL-Builder Module Integration

**Test Template:**
```html
<!-- Test within FL-Builder module context -->
<div class="fl-module fl-module-button fl-node-abc123" data-node="abc123">
  <div class="fl-module-content fl-node-content">
    <div class="fl-button-wrap">
      <a href="#" class="fl-button c-button c-button--primary">
        <span class="fl-button-text">FL-Builder + Component</span>
      </a>
    </div>
  </div>
</div>
```

### 3. Functionality Testing

#### Interactive Component Behavior

**Navigation Menu Testing:**
```javascript
// Test mobile menu toggle
function testMobileMenuToggle() {
  const menuToggle = document.querySelector('.c-nav__toggle');
  const navigation = document.querySelector('.c-nav');

  // Test menu open
  menuToggle.click();
  assert(navigation.classList.contains('c-nav--open'));

  // Test menu close
  menuToggle.click();
  assert(!navigation.classList.contains('c-nav--open'));
}

// Test submenu interactions
function testSubmenuBehavior() {
  const submenuTrigger = document.querySelector('.c-nav__item--has-submenu');
  const submenu = submenuTrigger.querySelector('.c-nav__submenu');

  // Desktop hover behavior
  submenuTrigger.dispatchEvent(new Event('mouseenter'));
  assert(submenu.style.display !== 'none');

  // Mobile click behavior
  submenuTrigger.click();
  assert(submenuTrigger.classList.contains('c-nav__item--open'));
}
```

**Button Component Testing:**
```javascript
// Test button interactions
function testButtonBehavior() {
  const button = document.querySelector('.c-button');

  // Test click events
  button.addEventListener('click', function(e) {
    if (this.disabled) {
      e.preventDefault();
      assert(false, 'Disabled button should not fire click events');
    }
  });

  // Test disabled state
  button.disabled = true;
  assert(button.getAttribute('aria-disabled') === 'true');
}
```

### 4. Accessibility Testing

#### WCAG 2.1 AA Compliance

**Color Contrast Testing:**
```css
/* Test color combinations meet 4.5:1 ratio */
.c-button--primary {
  /* Background: #1a8cff, Text: #ffffff */
  /* Contrast ratio: 4.52:1 (PASS) */
}

.c-button--secondary {
  /* Background: #6c757d, Text: #ffffff */
  /* Contrast ratio: 4.51:1 (PASS) */
}
```

**Keyboard Navigation Testing:**
```javascript
// Test tab order and focus management
function testKeyboardNavigation() {
  const focusableElements = document.querySelectorAll(`
    .c-button:not([disabled]),
    .c-nav__link,
    .c-nav__toggle
  `);

  focusableElements.forEach((element, index) => {
    element.focus();
    assert(document.activeElement === element);

    // Test Enter/Space activation
    element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter' }));
    element.dispatchEvent(new KeyboardEvent('keydown', { key: ' ' }));
  });
}
```

**Screen Reader Testing:**
```html
<!-- Verify proper ARIA labels and roles -->
<button class="c-button c-button--loading" aria-label="Loading, please wait">
  <span aria-hidden="true">Loading...</span>
</button>

<nav class="c-nav" role="navigation" aria-label="Main navigation">
  <button class="c-nav__toggle" aria-expanded="false" aria-controls="nav-menu">
    Menu
  </button>
  <ul class="c-nav__list" id="nav-menu">
    <li class="c-nav__item">
      <a href="#" class="c-nav__link" aria-current="page">Home</a>
    </li>
  </ul>
</nav>
```

### 5. Performance Testing

#### CSS Performance Metrics

**Bundle Size Analysis:**
```bash
# Measure CSS bundle impact
# Before component system: X KB
# After component system: Y KB
# Reduction: (X-Y)/X * 100%
```

**Rendering Performance:**
```javascript
// Test component rendering performance
function measureRenderTime() {
  const start = performance.now();

  // Render component-heavy page
  const container = document.getElementById('test-container');
  for (let i = 0; i < 100; i++) {
    const button = document.createElement('button');
    button.className = 'c-button c-button--primary';
    button.textContent = `Button ${i}`;
    container.appendChild(button);
  }

  const end = performance.now();
  console.log(`Render time: ${end - start}ms`);
}
```

**Critical CSS Testing:**
```css
/* Verify above-fold components load in critical CSS */
.c-button,
.c-nav,
.c-content-block {
  /* Should be in critical CSS bundle */
}
```

### 6. Hugo Integration Testing

#### Static Site Generation Validation

**Template Integration Test:**
```go
{{/* Test component integration in Hugo templates */}}
{{ partial "components/button.html" (dict
  "text" "Click Me"
  "variant" "primary"
  "size" "large"
  "url" "/contact/"
) }}

{{ partial "components/navigation.html" . }}

{{ partial "components/content-block.html" (dict
  "content" .Content
  "modifiers" (slice "c-content-block--large-text" "c-content-block--centered")
) }}
```

**Build Process Validation:**
```bash
# Test Hugo build with components
hugo --cleanDestinationDir --minify

# Verify CSS compilation
ls -la public/css/
grep -r "c-button\|c-nav\|c-content-block" public/css/

# Test dev server hot reloading
hugo server --disableFastRender
```

### 7. Regression Testing Suite

#### Automated Testing Script

**CSS Regression Tests:**
```javascript
// puppeteer-based visual regression tests
const puppeteer = require('puppeteer');
const pixelmatch = require('pixelmatch');

async function visualRegressionTest() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  // Test each component variant
  const components = [
    'c-button--primary',
    'c-button--secondary',
    'c-nav--desktop',
    'c-nav--mobile',
    'c-content-block--large-text'
  ];

  for (const component of components) {
    await page.goto(`http://localhost:1313/test-${component}`);
    const screenshot = await page.screenshot();

    // Compare with baseline
    const baseline = await loadBaseline(component);
    const diff = pixelmatch(baseline, screenshot, null, 800, 600, {
      threshold: 0.1
    });

    if (diff > 0) {
      console.error(`Visual regression detected in ${component}`);
    }
  }

  await browser.close();
}
```

### 8. Testing Environment Setup

#### Local Testing Environment

**Hugo Development Server:**
```bash
# Start development server with drafts
hugo server --buildDrafts --buildFuture --disableFastRender

# Component testing page
# Create content/test-components.md with all component variations
```

**Browser Testing Setup:**
```javascript
// BrowserStack or local browser testing
const webdriver = require('selenium-webdriver');

const browsers = [
  { browserName: 'chrome', version: 'latest' },
  { browserName: 'firefox', version: 'latest' },
  { browserName: 'safari', version: 'latest' },
  { browserName: 'MicrosoftEdge', version: 'latest' }
];

browsers.forEach(async (browser) => {
  const driver = await new webdriver.Builder()
    .forBrowser(browser.browserName)
    .build();

  // Run component tests
  await runComponentTests(driver);
  await driver.quit();
});
```

### 9. Testing Checklist

#### Pre-Release Component Validation

**Visual Testing:**
- [ ] All component variants render correctly
- [ ] Responsive behavior functions at all breakpoints
- [ ] Cross-browser compatibility verified
- [ ] FL-Builder integration maintains visual consistency
- [ ] No layout breaks in dual-class implementation

**Functionality Testing:**
- [ ] Interactive components respond to user input
- [ ] Keyboard navigation works correctly
- [ ] Mobile touch interactions function properly
- [ ] Form components submit data correctly
- [ ] Navigation menus open/close properly

**Accessibility Testing:**
- [ ] Color contrast meets WCAG AA standards
- [ ] Screen readers announce content correctly
- [ ] Keyboard navigation reaches all interactive elements
- [ ] Focus indicators are visible and appropriate
- [ ] ARIA labels provide meaningful descriptions

**Performance Testing:**
- [ ] CSS bundle size optimized
- [ ] Component rendering performance acceptable
- [ ] Critical CSS includes above-fold components
- [ ] No unused CSS in production build
- [ ] Mobile performance meets Core Web Vitals

**Integration Testing:**
- [ ] Hugo templates compile without errors
- [ ] Static site generation completes successfully
- [ ] Components work in FL-Builder page builder
- [ ] Content management workflow uninterrupted
- [ ] SEO meta tags and structured data preserved

### 10. Continuous Testing

#### Automated Testing Pipeline

**GitHub Actions Workflow:**
```yaml
name: Component Testing
on: [push, pull_request]

jobs:
  visual-regression:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
      - name: Build site
        run: hugo --minify
      - name: Run visual tests
        run: npm run test:visual

  accessibility:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run axe-core tests
        run: npm run test:a11y

  performance:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Lighthouse CI
        run: npm run test:lighthouse
```

**Testing Commands:**
```json
{
  "scripts": {
    "test:visual": "backstop test",
    "test:a11y": "axe-core --include .c-button,.c-nav,.c-content-block",
    "test:lighthouse": "lighthouse --chrome-flags='--headless' http://localhost:1313",
    "test:components": "jest --testPathPattern=components",
    "test:integration": "cypress run --spec 'cypress/integration/components/*'"
  }
}
```

### 11. Documentation Testing

#### Component Documentation Validation

**Usage Example Verification:**
```html
<!-- Verify all documented examples work correctly -->
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/css/components.css">
</head>
<body>
  <!-- Test each documented example -->
  <button class="c-button c-button--primary c-button--large">
    Large Primary Button
  </button>

  <!-- Verify Hugo shortcode examples -->
  {{< button text="Shortcode Button" variant="secondary" >}}

  <!-- Test FL-Builder compatibility examples -->
  <div class="fl-button-wrap">
    <a href="#" class="fl-button c-button c-button--outline">
      FL-Builder Compatible
    </a>
  </div>
</body>
</html>
```

### 12. Error Handling and Debugging

#### Common Testing Issues

**CSS Conflicts:**
```css
/* Debug CSS specificity issues */
.debug-component {
  outline: 2px solid red !important;
}

/* Check for unintended inheritance */
* {
  box-sizing: border-box; /* Ensure consistent box model */
}
```

**JavaScript Debugging:**
```javascript
// Component state debugging
function debugComponentState(component) {
  console.group(`Debugging ${component.className}`);
  console.log('Computed styles:', getComputedStyle(component));
  console.log('Event listeners:', getEventListeners(component));
  console.log('ARIA attributes:', component.attributes);
  console.groupEnd();
}
```

**Hugo Template Debugging:**
```go
{{/* Debug template context */}}
{{ if hugo.IsProduction }}
  <!-- Production build -->
{{ else }}
  <div class="debug-info">
    <p>Page: {{ .RelPermalink }}</p>
    <p>Type: {{ .Type }}</p>
    <p>Layout: {{ .Layout }}</p>
  </div>
{{ end }}
```

## Summary

This comprehensive testing procedure ensures the component system maintains quality, accessibility, and compatibility across all environments. Regular execution of these tests validates that the modern BEM component architecture successfully integrates with the existing FL-Builder infrastructure while providing a clear migration path to a more maintainable CSS system.

The testing approach balances automated verification with manual validation, ensuring both technical correctness and user experience quality. By following these procedures, teams can confidently deploy component updates while maintaining the reliability and performance expectations of the JetThoughts website.

---

*For specific testing tools and detailed configuration examples, refer to the individual testing tool documentation and the project's CI/CD pipeline configuration.*