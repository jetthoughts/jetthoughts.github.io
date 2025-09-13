# Hugo Pipes Asset Pipeline Design Plan

## Executive Summary

This document outlines the comprehensive design for implementing Hugo Pipes asset pipeline to replace the current ad-hoc CSS/JS processing system. The implementation aims to achieve a 40-60% build time reduction while maintaining all current functionality and improving performance optimization.

## Current Asset Structure Analysis

### Current CSS Organization (87K+ total lines)

- **Large Layout Files**: 590-layout.css (13,128 lines), multiple page-specific layouts
- **Component Files**: component-bundle.css (2,773 lines), navigation.css (439 lines)  
- **Theme Files**: theme-main.css (3,643 lines), base-layout.css (2,892 lines)
- **Page-Specific CSS**: homepage.css (1,969 lines), services-layout.css (1,679 lines)
- **Small Components**: 35 files under 200 lines each

### Current Processing System

- **CSS Processor**: `/themes/beaver/layouts/partials/assets/css-processor.html`
  - Concatenation via `resources.Concat`
  - PostCSS processing with environment-aware optimization
  - Production: minify → fingerprint → postprocess
  - Development: basic fingerprint only

- **JS Processor**: `/themes/beaver/layouts/partials/assets/js-processor.html`
  - Bundle concatenation
  - Environment-aware minification with `js.Build`
  - Fingerprinting and PostProcess for production

### Current PostCSS Configuration

```javascript
// Smart development optimization
const isDevelopment = process.env.HUGO_ENVIRONMENT === "development";

plugins: [
  require("postcss-nested"),
  isDevelopment ? null : require("autoprefixer"),
  isDevelopment ? null : purgecss,
  isDevelopment ? null : require("postcss-delete-duplicate-css"),
  isDevelopment ? null : require("cssnano"),
]
```

## Hugo Pipes Implementation Architecture

### Phase 1: Core Pipeline Setup

#### 1.1 Asset Resource Organization

```
assets/
├── scss/
│   ├── main.scss              # Master import file
│   ├── _variables.scss        # Global variables
│   ├── _mixins.scss          # Reusable mixins
│   ├── components/           # Component styles
│   │   ├── _navigation.scss
│   │   ├── _footer.scss
│   │   ├── _buttons.scss
│   │   └── _forms.scss
│   ├── layouts/              # Page-specific layouts
│   │   ├── _homepage.scss
│   │   ├── _services.scss
│   │   └── _blog.scss
│   ├── base/                 # Foundation styles
│   │   ├── _reset.scss
│   │   ├── _typography.scss
│   │   └── _grid.scss
│   └── utilities/            # Utility classes
│       ├── _spacing.scss
│       └── _responsive.scss
├── js/
│   ├── main.js               # Main application JS
│   ├── components/           # Component JS
│   │   ├── navigation.js
│   │   └── tabs.js
│   └── vendor/               # Third-party libraries
└── images/                   # Source images for processing
```

#### 1.2 Master SCSS Structure

```scss
// main.scss - Single source of truth
@import 'variables';
@import 'mixins';

// Base styles (critical)
@import 'base/reset';
@import 'base/typography';
@import 'base/grid';

// Components (can be split)
@import 'components/navigation';
@import 'components/footer';
@import 'components/buttons';
@import 'components/forms';

// Layout-specific (page bundles)
@import 'layouts/homepage';
@import 'layouts/services';
@import 'layouts/blog';

// Utilities (often critical)
@import 'utilities/spacing';
@import 'utilities/responsive';
```

### Phase 2: Advanced Pipeline Features

#### 2.1 Critical CSS Extraction Strategy

**Implementation Approach**:

1. **Above-the-fold CSS Identification**
   - Header/navigation styles
   - Hero section styles
   - Core typography and layout
   - Essential responsive breakpoints

2. **Critical CSS Partial Creation**

```html
<!-- themes/beaver/layouts/partials/assets/critical-css.html -->
{{- $critical := resources.Get "scss/critical.scss" | toCSS | minify | fingerprint -}}
<style>{{ $critical.Content | safeCSS }}</style>
```

3. **Non-Critical CSS Lazy Loading**

```html
<!-- Load non-critical CSS asynchronously -->
{{- $nonCritical := resources.Get "scss/main.scss" | toCSS | postCSS | minify | fingerprint -}}
<link rel="preload" href="{{ $nonCritical.RelPermalink }}" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="{{ $nonCritical.RelPermalink }}"></noscript>
```

#### 2.2 Asset Bundle Strategy

**Page-Specific Bundles**:

```go
{{/* Homepage Bundle */}}
{{- $homepageCSS := slice
  (resources.Get "scss/base.scss")
  (resources.Get "scss/components/navigation.scss")
  (resources.Get "scss/layouts/homepage.scss")
  | resources.Concat "css/homepage.css"
  | toCSS
  | postCSS
  | minify
  | fingerprint -}}

{{/* Services Bundle */}}
{{- $servicesCSS := slice
  (resources.Get "scss/base.scss")
  (resources.Get "scss/components/navigation.scss")
  (resources.Get "scss/layouts/services.scss")
  | resources.Concat "css/services.css"
  | toCSS
  | postCSS
  | minify
  | fingerprint -}}
```

#### 2.3 JavaScript Bundling with Hugo Pipes

**Modern JS Processing**:

```go
{{/* Main JavaScript Bundle */}}
{{- $js := resources.Get "js/main.js" 
  | js.Build (dict "target" "es2018" "minify" hugo.IsProduction) 
  | fingerprint -}}

{{/* Component-specific JS */}}
{{- $tabsJS := resources.Get "js/components/tabs.js"
  | js.Build (dict "target" "es2018" "minify" hugo.IsProduction)
  | fingerprint -}}
```

### Phase 3: Performance Optimization

#### 3.1 Asset Preprocessing Pipeline

**SCSS Processing Chain**:

```
SCSS Source → Hugo toCSS → PostCSS → PurgeCSS → Minify → Fingerprint → PostProcess
```

**Environment-Specific Optimization**:

```go
{{/* Development: Fast compilation */}}
{{- if eq hugo.Environment "development" -}}
  {{- $css := resources.Get "scss/main.scss" | toCSS | fingerprint -}}

{{/* Production: Full optimization */}}  
{{- else -}}
  {{- $css := resources.Get "scss/main.scss" 
    | toCSS (dict "targetPath" "css/main.css" "enableSourceMap" false)
    | postCSS
    | minify
    | fingerprint "sha256"
    | resources.PostProcess -}}
{{- end -}}
```

#### 3.2 Image Processing Pipeline

**Responsive Image Generation**:

```go
{{/* Generate multiple image sizes */}}
{{- $image := resources.Get "images/hero.jpg" -}}
{{- $small := $image.Resize "400x webp q80" -}}
{{- $medium := $image.Resize "800x webp q80" -}}
{{- $large := $image.Resize "1200x webp q80" -}}

<picture>
  <source media="(max-width: 400px)" srcset="{{ $small.RelPermalink }}">
  <source media="(max-width: 800px)" srcset="{{ $medium.RelPermalink }}">
  <img src="{{ $large.RelPermalink }}" alt="Hero image" loading="lazy">
</picture>
```

### Phase 4: Advanced Features

#### 4.1 Dynamic Asset Loading

**Conditional CSS Loading**:

```go
{{/* Load page-specific CSS only when needed */}}
{{- if eq .Type "services" -}}
  {{- $servicesCSS := resources.Get "scss/layouts/services.scss" | toCSS | postCSS | minify | fingerprint -}}
  <link rel="stylesheet" href="{{ $servicesCSS.RelPermalink }}">
{{- end -}}
```

#### 4.2 Asset Versioning & Cache Optimization

**Fingerprinting Strategy**:

```go
{{/* Different hashing for different environments */}}
{{- if hugo.IsProduction -}}
  {{- $css := $css | fingerprint "sha256" -}}
{{- else -}}
  {{- $css := $css | fingerprint "md5" -}}
{{- end -}}
```

## Implementation Phases

### Phase 1: Foundation (Week 1)

1. **Asset Restructuring**
   - Move existing CSS to SCSS structure
   - Create master import files
   - Implement basic Hugo Pipes processing

2. **Critical CSS Implementation**
   - Identify above-the-fold styles
   - Create critical.scss partial
   - Implement inline critical CSS

### Phase 2: Optimization (Week 2)

1. **Bundle Strategy**
   - Page-specific CSS bundles
   - JavaScript module bundling
   - Asset size optimization

2. **PostCSS Integration**
   - Environment-aware processing
   - PurgeCSS integration
   - Autoprefixer setup

### Phase 3: Advanced Features (Week 3)

1. **Image Processing**
   - Responsive image pipeline
   - WebP conversion
   - Lazy loading implementation

2. **Performance Monitoring**
   - Build time measurement
   - Bundle size analysis
   - Core Web Vitals integration

## Performance Targets

### Build Time Optimization

- **Current Build Time**: ~45-60 seconds
- **Target Build Time**: 18-27 seconds (40-60% reduction)
- **Development Builds**: <10 seconds

### Asset Size Optimization

- **CSS Size Reduction**: 30-50% via tree-shaking and bundling
- **JavaScript Bundling**: 20-40% reduction via code splitting
- **Image Optimization**: 40-70% size reduction via modern formats

### Core Web Vitals Improvements

- **LCP Improvement**: Critical CSS → sub-1.5s LCP target
- **CLS Optimization**: Proper font loading → <0.1 CLS
- **FID Enhancement**: Optimized JS loading → <100ms FID

## Migration Strategy

### Backward Compatibility Plan

1. **Dual Processing Mode**
   - Keep existing CSS processors during migration
   - Gradually migrate page by page
   - A/B test performance improvements

2. **Fallback Mechanisms**
   - Maintain existing asset structure
   - Progressive enhancement approach
   - Rollback capability at each phase

### Testing Strategy

1. **Visual Regression Testing**
   - Screenshot comparison tests
   - Cross-browser compatibility
   - Mobile/desktop consistency

2. **Performance Testing**
   - Lighthouse CI integration
   - Build time benchmarks
   - Bundle size monitoring

## File Structure After Implementation

```
themes/beaver/
├── assets/
│   ├── scss/
│   │   ├── main.scss
│   │   ├── critical.scss
│   │   ├── _variables.scss
│   │   ├── _mixins.scss
│   │   ├── base/
│   │   ├── components/
│   │   ├── layouts/
│   │   └── utilities/
│   ├── js/
│   │   ├── main.js
│   │   ├── components/
│   │   └── vendor/
│   └── images/
├── layouts/
│   └── partials/
│       └── assets/
│           ├── css-pipeline.html      # New Hugo Pipes processor
│           ├── js-pipeline.html       # Enhanced JS processor  
│           ├── critical-css.html      # Critical CSS handler
│           ├── image-processor.html   # Image optimization
│           └── asset-preloader.html   # Resource preloading
└── static/
    └── (legacy assets during migration)
```

## Development Workflow

### Build Scripts Enhancement

```bash
#!/bin/bash
# Enhanced hugo-build-pipes

hugo --environment production \
  --minify \
  --enableGitInfo \
  --cleanDestinationDir \
  --destination public \
  --templateMetrics \
  --printI18nWarnings
```

### Development Mode Optimizations

```bash
# Fast development builds
hugo server \
  --environment development \
  --disableFastRender=false \
  --buildDrafts \
  --buildFuture \
  --navigateToChanged \
  --templateMetrics
```

## Success Metrics

### Quantitative Metrics

- Build time reduction: 40-60%
- CSS bundle size reduction: 30-50%  
- First Contentful Paint improvement: 25-40%
- Largest Contentful Paint improvement: 30-50%
- Cumulative Layout Shift reduction: 50-70%

### Qualitative Metrics

- Developer experience improvement
- Maintainability enhancement
- Code organization clarity
- Future scalability

## Risk Assessment & Mitigation

### High-Risk Items

1. **CSS Cascade Changes**: Risk of styling breakage
   - *Mitigation*: Comprehensive visual regression testing
   - *Rollback*: Keep existing CSS as fallback

2. **Build Pipeline Complexity**: Risk of build failures
   - *Mitigation*: Gradual migration with fallbacks
   - *Rollback*: Revert to existing processors

### Medium-Risk Items

1. **Performance Regression**: Risk of worse performance
   - *Mitigation*: Continuous performance monitoring
   - *Rollback*: Performance-based rollback triggers

2. **Third-party Dependencies**: Risk of PostCSS plugin issues
   - *Mitigation*: Lock dependency versions
   - *Rollback*: Vendor CSS fallback

## Next Steps

1. **Design Review & Approval**
   - Stakeholder review of this design
   - Technical architecture validation
   - Timeline and resource approval

2. **Phase 1 Implementation**
   - Create SCSS structure
   - Implement basic Hugo Pipes
   - Set up critical CSS pipeline

3. **Testing & Validation**
   - Performance baseline establishment
   - Visual regression test setup
   - Build pipeline validation

This design provides a comprehensive roadmap for implementing Hugo Pipes while maintaining backward compatibility and achieving significant performance improvements. The phased approach ensures minimal risk while maximizing the benefits of modern asset processing.
