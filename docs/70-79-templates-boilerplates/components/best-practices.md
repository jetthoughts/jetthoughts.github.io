# Component Development Best Practices

*Proven patterns and practices for Hugo component development at JetThoughts*

## Development Philosophy

### KISS Principle
- **Simple Solutions**: Choose the simplest approach that works
- **Clear Code**: Self-documenting template syntax
- **Minimal Dependencies**: Reduce external requirements
- **Direct Implementation**: Avoid over-engineering

### Conservative Approach
- **Zero Breaking Changes**: Maintain existing functionality
- **Backward Compatibility**: Support legacy FL-Builder CSS
- **Incremental Migration**: Small, testable changes
- **Rollback Safety**: Always maintain fallback options

### YAGNI (You Aren't Gonna Need It)
- **Current Requirements**: Build for actual, not theoretical needs
- **Proven Patterns**: Use established template structures
- **Existing Usage**: Document what's actually implemented
- **Real Data**: Test with production content

## Component Architecture Patterns

### 1. Parameter Design

#### Required vs Optional Parameters
```go
{{/* ✅ Good: Clear required/optional distinction */}}
{{- $title := .title -}}          {{/* Required - no default */}}
{{- $icon := .icon | default "default" -}}  {{/* Optional - sensible default */}}
{{- $link := .link | default "#" -}}        {{/* Optional - safe fallback */}}
```

#### Parameter Validation
```go
{{/* ✅ Good: Defensive parameter handling */}}
{{- $node_id := .node_id | default (printf "component-%s" (.icon | default "generic")) -}}

{{/* ❌ Avoid: Assumptions without validation */}}
{{- $node_id := .node_id -}}  {{/* Could be empty */}}
```

#### Default Value Strategy
```go
{{/* ✅ Good: Meaningful defaults */}}
{{- $cta_text := .cta_text | default "Learn More" -}}
{{- $heading := .heading | default "Get Started Today" -}}

{{/* ❌ Avoid: Empty or confusing defaults */}}
{{- $cta_text := .cta_text | default "" -}}      {{/* Empty string unhelpful */}}
{{- $heading := .heading | default "Title" -}}   {{/* Generic, meaningless */}}
```

## Content Block Component Best Practices

### FL-Builder to BEM Migration Patterns

#### 1. Dual-Class Implementation Strategy

**✅ Recommended Pattern:**
```html
<!-- Preserve FL-Builder structure while adding BEM -->
<div class="fl-module fl-module-rich-text fl-node-{{ .node_id }}" data-node="{{ .node_id }}">
  <div class="fl-module-content fl-node-content">
    <div class="fl-rich-text c-content-block {{ .bem_modifiers }}">
      <h2 class="c-content-block__heading">{{ .heading }}</h2>
      <p class="c-content-block__paragraph">{{ .content }}</p>
    </div>
  </div>
</div>
```

**❌ Avoid Breaking FL-Builder Structure:**
```html
<!-- Don't remove FL-Builder wrapper elements -->
<div class="c-content-block {{ .bem_modifiers }}">
  <h2 class="c-content-block__heading">{{ .heading }}</h2>
  <p class="c-content-block__paragraph">{{ .content }}</p>
</div>
```

#### 2. Pattern-Based Modifier Usage

**✅ Use Semantic Pattern Classes:**
```go
{{/* Content block with semantic modifiers */}}
{{ partial "components/content-block.html" (dict
  "heading" "Service Overview"
  "content" "Comprehensive development solutions."
  "pattern" "eyebrow"         // Uses .c-content-block--eyebrow
  "alignment" "center"        // Uses .c-content-block--text-center
  "size" "large-text"         // Uses .c-content-block--large-text
  "preserve_fl_structure" true
) }}
```

**❌ Avoid Inline Styling:**
```html
<!-- Don't use inline styles when BEM modifiers exist -->
<div class="fl-rich-text" style="text-align: center; font-weight: 600;">
  <h2 style="color: #1a8cff;">Service Overview</h2>
</div>
```

#### 3. Common Pattern Recognition

**Eyebrow Text Pattern (20+ instances):**
```html
<!-- ✅ Use pattern class instead of inline styles -->
<div class="fl-rich-text c-content-block c-content-block--eyebrow">
  <h3 class="c-content-block__heading">Service Category</h3>
</div>

<!-- ❌ Avoid repetitive inline styling -->
<div class="fl-rich-text" style="color: #1a8cff; font-weight: 600;">
  <h3>Service Category</h3>
</div>
```

**Centered Content Pattern (100+ instances):**
```html
<!-- ✅ Use semantic modifier -->
<div class="fl-rich-text c-content-block c-content-block--centered">
  <h2 class="c-content-block__heading">Centered Heading</h2>
  <p class="c-content-block__paragraph">Centered content</p>
</div>

<!-- ❌ Avoid element-level styling -->
<div class="fl-rich-text">
  <h2 style="text-align: center;">Centered Heading</h2>
  <p style="text-align: center;">Centered content</p>
</div>
```

**Large Text Pattern (30+ instances):**
```html
<!-- ✅ Use size modifier -->
<div class="fl-rich-text c-content-block c-content-block--large-text">
  <p class="c-content-block__paragraph">Enhanced readability content</p>
</div>

<!-- ❌ Avoid font-size overrides -->
<div class="fl-rich-text">
  <p style="font-size: 1.125rem; line-height: 1.7;">Enhanced content</p>
</div>
```

### CSS Architecture Best Practices

#### 1. BEM Naming Conventions

**✅ Follow Strict BEM Structure:**
```scss
// Block
.c-content-block { /* base styles */ }

// Elements
.c-content-block__text { /* text wrapper */ }
.c-content-block__heading { /* heading styles */ }
.c-content-block__paragraph { /* paragraph styles */ }

// Modifiers
.c-content-block--large-text { /* size variant */ }
.c-content-block--centered { /* alignment variant */ }
.c-content-block--eyebrow { /* semantic variant */ }
```

**❌ Avoid Mixed Naming Conventions:**
```scss
// Don't mix BEM with other patterns
.c-content-block { }
.content-block-title { }      // Inconsistent naming
.content_block__text { }      // Wrong separator
.contentBlock--large { }      // camelCase in CSS
```

#### 2. FL-Builder Compatibility Layer

**✅ Use @extend for Compatibility:**
```scss
// Maintain FL-Builder functionality while adding BEM
.fl-rich-text {
  @extend .c-content-block__text;
  // Original FL-Builder styles preserved
}

.fl-rich-text h1,
.fl-rich-text h2,
.fl-rich-text h3 {
  @extend .c-content-block__heading;
}
```

**❌ Avoid Overriding FL-Builder Styles:**
```scss
// Don't override existing FL-Builder functionality
.fl-rich-text {
  // Don't reset or override existing styles
  all: unset; // Breaks compatibility
  display: block !important; // Creates specificity issues
}
```

#### 3. Pattern Consolidation Strategy

**✅ Consolidate Common Patterns:**
```scss
// Identify and consolidate repeated patterns
.fl-rich-text.pattern-eyebrow,
.c-content-block--eyebrow {
  color: #1a8cff;
  font-weight: 600;
}

// Universal patterns for efficiency
.fl-rich-text:not(.pattern-preserve-strong) *:not(b, strong) {
  font-weight: inherit;
}
```

**❌ Avoid Individual Selectors:**
```scss
// Don't create individual selectors for common patterns
.fl-node-abc123 h3 { color: #1a8cff; font-weight: 600; }
.fl-node-def456 .title { color: #1a8cff; font-weight: 600; }
.fl-node-ghi789 h2 { color: #1a8cff; font-weight: 600; }
```

### Hugo Template Best Practices

#### 1. Component Partial Structure

**✅ Flexible Parameter Handling:**
```go
{{/* themes/beaver/layouts/partials/components/content-block.html */}}
{{- $block_classes := slice "c-content-block" -}}

{{/* Build modifier classes dynamically */}}
{{- with .size }}{{ $block_classes = $block_classes | append (printf "c-content-block--%s" .) }}{{ end -}}
{{- with .alignment }}{{ $block_classes = $block_classes | append (printf "c-content-block--text-%s" .) }}{{ end -}}
{{- with .weight }}{{ $block_classes = $block_classes | append (printf "c-content-block--weight-%s" .) }}{{ end -}}
{{- with .color }}{{ $block_classes = $block_classes | append (printf "c-content-block--color-%s" .) }}{{ end -}}

{{/* FL-Builder compatibility option */}}
{{- $fl_structure := .preserve_fl_structure | default false -}}

{{- if $fl_structure -}}
  <div class="fl-module fl-module-rich-text fl-node-{{ .node_id | default "generated" }}" data-node="{{ .node_id }}">
    <div class="fl-module-content fl-node-content">
      <div class="fl-rich-text {{ delimit $block_classes " " }}">
        {{ partial "components/content-block-inner.html" . }}
      </div>
    </div>
  </div>
{{- else -}}
  <div class="{{ delimit $block_classes " " }}">
    {{ partial "components/content-block-inner.html" . }}
  </div>
{{- end -}}
```

#### 2. Content Structure Patterns

**✅ Semantic HTML Structure:**
```go
{{/* components/content-block-inner.html */}}
{{ with .heading }}
  <h2 class="c-content-block__heading{{ with $.heading_modifier }} c-content-block--{{ . }}{{ end }}">
    {{ . }}
  </h2>
{{ end }}

{{ with .content }}
  <div class="c-content-block__text">
    {{ . | markdownify }}
  </div>
{{ end }}

{{ range .paragraphs }}
  <p class="c-content-block__paragraph">{{ . }}</p>
{{ end }}
```

#### 3. Data Integration Patterns

**✅ Flexible Data Sources:**
```go
{{/* Support multiple data sources */}}
{{ $content_data := dict }}

{{/* From page frontmatter */}}
{{ with .Page.Params.content_block }}
  {{ $content_data = merge $content_data . }}
{{ end }}

{{/* From data files */}}
{{ with .Site.Data.content.blocks }}
  {{ $content_data = merge $content_data (index . $.block_id) }}
{{ end }}

{{/* From partial parameters (highest priority) */}}
{{ $content_data = merge $content_data . }}

{{ partial "components/content-block.html" $content_data }}
```

### Performance Optimization Best Practices

#### 1. CSS Efficiency

**✅ Use CSS Custom Properties:**
```scss
.c-content-block {
  --content-line-height: var(--global-line-height, 1.6);
  --content-spacing: var(--global-spacing-md, 1rem);
  --content-color: var(--global-text-color, inherit);

  line-height: var(--content-line-height);
  color: var(--content-color);
}
```

**✅ Minimize Selector Complexity:**
```scss
// Good: Simple, efficient selectors
.c-content-block__paragraph { margin-bottom: 1rem; }
.c-content-block--centered { text-align: center; }

// Avoid: Complex, slow selectors
.c-content-block .content .paragraph:not(.special):last-of-type { }
```

#### 2. Hugo Template Efficiency

**✅ Cache Expensive Operations:**
```go
{{/* Cache complex data transformations */}}
{{ $processed_content := .content | markdownify | safeHTML }}
{{ $.Scratch.Set "content" $processed_content }}

{{/* Reuse cached results */}}
<div class="c-content-block__text">
  {{ $.Scratch.Get "content" }}
</div>
```

**✅ Minimize Template Complexity:**
```go
{{/* Simple, readable conditionals */}}
{{ if .heading }}
  <h2 class="c-content-block__heading">{{ .heading }}</h2>
{{ end }}

{{/* Avoid complex nested logic */}}
{{ if and .heading (or .show_heading (not .hide_heading)) }}
  <!-- Overly complex condition -->
{{ end }}
```

### Testing and Validation Best Practices

#### 1. Visual Regression Prevention

**✅ Systematic Testing Approach:**
```bash
# Before any component changes
hugo server --port 1313 &
SERVER_PID=$!

# Take baseline screenshots
curl -s http://localhost:1313/about/ > /dev/null
# Manual screenshot: about-page-before.png

# After component implementation
# Take comparison screenshots
curl -s http://localhost:1313/about/ > /dev/null
# Manual screenshot: about-page-after.png

# Clean up
kill $SERVER_PID
```

#### 2. Cross-Browser Validation

**✅ Multi-Browser Testing:**
```bash
# Test component across browsers
# Chrome: Default Hugo dev server
# Firefox: Test CSS Grid compatibility
# Safari: Test CSS Custom Properties
# Edge: Test modern CSS features

# Mobile testing
# iOS Safari: Test responsive behavior
# Chrome Mobile: Test touch interactions
```

#### 3. Performance Validation

**✅ Performance Monitoring:**
```bash
# Build performance
time bin/hugo-build

# CSS size analysis
du -sh themes/beaver/assets/css/components/

# Lighthouse audit
bin/lighthouse

# Component-specific metrics
grep -r "c-content-block" public/ | wc -l  # Usage count
```

### Migration Strategy Best Practices

#### 1. Incremental Migration

**✅ Phase-by-Phase Approach:**
```
Phase 1: Create BEM component structure
└── No template changes, CSS only

Phase 2: Add dual-class implementation
└── Templates use both FL-Builder and BEM classes

Phase 3: Pattern consolidation
└── Consolidate common patterns into reusable classes

Phase 4: Performance optimization
└── Remove redundant CSS and optimize selectors
```

#### 2. Rollback Safety

**✅ Maintain Rollback Capability:**
```scss
/* Feature flag for safe rollback */
.no-content-block-migration {
  .c-content-block {
    all: unset; /* Disable BEM styles if needed */
  }
}

/* Original FL-Builder styles always preserved */
.fl-rich-text {
  /* Original functionality intact */
}
```

#### 3. Documentation During Migration

**✅ Document Decision and Patterns:**
```markdown
# Migration Decision Log

## Pattern: Eyebrow Text
- **Instances Found**: 20+ across 8 templates
- **Common Styles**: font-weight: 600, color: #1a8cff
- **BEM Class**: .c-content-block--eyebrow
- **Migration Status**: ✅ Completed

## Pattern: Centered Content
- **Instances Found**: 100+ across all templates
- **Common Styles**: text-align: center
- **BEM Class**: .c-content-block--centered
- **Migration Status**: ✅ Completed
```

### Maintenance Best Practices

#### 1. Component Updates

**✅ Backward-Compatible Changes:**
```scss
/* Add new modifiers without breaking existing */
.c-content-block--weight-extra-light { font-weight: 200; }
.c-content-block--color-secondary { color: #6c757d; }

/* Avoid changes that break existing usage */
// .c-content-block { display: flex; } // Could break layouts
```

#### 2. Documentation Maintenance

**✅ Keep Documentation Current:**
- Update usage examples when adding modifiers
- Document new patterns as they emerge
- Maintain migration guides for new components
- Keep performance metrics up to date

#### 3. Performance Monitoring

**✅ Ongoing Performance Tracking:**
```bash
# Regular performance audits
bin/lighthouse > reports/performance-$(date +%Y%m%d).json

# CSS size monitoring
du -sh themes/beaver/assets/css/ >> reports/css-size-history.log

# Component usage analysis
grep -r "c-content-block" themes/beaver/layouts/ | wc -l >> reports/component-usage.log

{{/* ❌ Avoid: Generic defaults */}}
{{- $cta_text := .cta_text | default "Click Here" -}}
{{- $heading := .heading | default "Title" -}}
```

### 2. Template Structure

#### Maintainable Template Organization
```go
{{/* ✅ Good: Clear sections with comments */}}
{{/*
  Service Card Component

  Required: icon, title, description, link, cta_text
  Optional: node_id
*/}}

{{/* Parameter processing */}}
{{- $icon := .icon | default "service" -}}
{{- $title := .title | default "Service" -}}

{{/* Template rendering */}}
<div class="service-card">
  <!-- Component content -->
</div>
```

#### CSS Class Preservation
```go
{{/* ✅ Good: Preserve FL-Builder structure exactly */}}
<div class="fl-col fl-node-{{ $node_id }} fl-col-small fl-col-small-custom-width hover-box">
  <div class="fl-col-content fl-node-content">
    <div class="fl-module fl-module-pp-infobox fl-node-{{ $node_id }}-box jt-service-box">
```

#### Hugo Integration Patterns
```go
{{/* ✅ Good: Hugo asset processing */}}
{{ partial "svgiw" (dict "svg" (printf "theme/%s" $icon) "width" "30" "height" "30") }}

{{/* ✅ Good: Hugo URL handling */}}
<a href="{{ relURL $link }}" target="_self">{{ $title }}</a>

{{/* ✅ Good: Hugo resource management */}}
{{- $css := resources.Get "css/components.css" | minify | fingerprint -}}
<link rel="stylesheet" href="{{ $css.Permalink }}">
```

### 3. Data Integration

#### Site Data Integration
```go
{{/* ✅ Good: Flexible data source handling */}}
{{ range .Site.Data.services.services }}
  {{ partial "components/service-card.html" (dict
    "icon" .icon
    "title" .name
    "description" .description
    "link" .url
  ) }}
{{ end }}
```

#### Page Data Integration
```go
{{/* ✅ Good: Frontmatter integration */}}
{{ $hero_params := dict
  "headline" .Page.Title
  "excerpt" .Page.Description
  "cover_image" .Page.Params.cover_image
}}
{{ partial "components/hero-section.html" $hero_params }}
```

#### Data Mapping Patterns
```go
{{/* ✅ Good: Clear data transformation */}}
{{ $service_data := index .Site.Data.services.services 0 }}
{{ partial "components/service-card.html" (dict
  "icon" $service_data.icon
  "title" $service_data.name           // Map 'name' to 'title'
  "description" $service_data.content  // Map 'content' to 'description'
  "link" $service_data.url             // Map 'url' to 'link'
  "cta_text" "Learn More"
) }}
```

## Asset Management Best Practices

### 1. SVG Icon Management

#### File Organization
```
themes/beaver/assets/img/icons/theme/
├── fractional-cto.svg
├── app-web.svg
├── consulting.svg
└── default-service.svg
```

#### Icon Usage Pattern
```go
{{/* ✅ Good: Consistent icon processing */}}
{{ partial "svgiw" (dict
  "svg" (printf "theme/%s" $icon)
  "width" "30"
  "height" "30"
) }}
```

#### Icon Fallbacks
```go
{{/* ✅ Good: Icon fallback strategy */}}
{{- $icon := .icon | default "default-service" -}}
{{- $icon_exists := fileExists (printf "assets/img/icons/theme/%s.svg" $icon) -}}
{{- if not $icon_exists -}}
  {{- $icon = "default-service" -}}
{{- end -}}
```

### 2. Image Optimization

#### Performance-First Loading
```go
{{/* ✅ Good: Prioritize above-fold images */}}
<img fetchpriority="high" decoding="async"
     src="{{ relURL $image_path }}"
     alt="{{ $headline }}" />
```

#### Responsive Image Handling
```go
{{/* ✅ Good: Use Hugo image processing */}}
{{ partial "img/resize.html" (dict
  "image" $image
  "title" $title
  "width" 50
  "class" "logo-image"
) }}
```

### 3. CSS Management

#### Non-Critical CSS Loading
```go
{{/* ✅ Good: Preload non-critical CSS */}}
{{- $nonCriticalCSS := resources.Get "css/swiper.min.css" | fingerprint "md5" -}}
<link fetchpriority="low" rel="preload" href="{{ $nonCriticalCSS.RelPermalink }}" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="{{ $nonCriticalCSS.RelPermalink }}"></noscript>
```

## Performance Optimization

### 1. Build Performance

#### Component Caching
```go
{{/* ✅ Good: Cache stable components */}}
{{ partialCached "components/testimonial.html" . "testimonials" }}

{{/* ❌ Avoid: Caching dynamic components */}}
{{ partialCached "components/service-card.html" . $service.id }}  // Different per service
```

#### Conditional Rendering
```go
{{/* ✅ Good: Conditional expensive operations */}}
{{- if $show_badges -}}
  <!-- Badge rendering only when needed -->
{{- end -}}

{{- if $cover_image -}}
  <!-- Image processing only when image provided -->
{{- end -}}
```

### 2. Runtime Performance

#### Lazy Loading Strategy
```go
{{/* ✅ Good: Lazy load below-fold content */}}
<img loading="lazy" decoding="async"
     src="{{ $image.RelPermalink }}"
     alt="{{ $title }}" />
```

#### Asset Bundling
```go
{{/* ✅ Good: Bundle related assets */}}
{{ $bundle := slice
  (resources.Get "css/components.css")
  (resources.Get "css/layout.css")
| resources.Concat "css/combined.css"
| minify
| fingerprint }}
```

## Accessibility Standards

### 1. Semantic HTML

#### Heading Hierarchy
```go
{{/* ✅ Good: Proper heading structure */}}
<h1>{{ .Page.Title }}</h1>           <!-- Page title -->
<h2>{{ $section.heading }}</h2>     <!-- Section heading -->
<h3>{{ $service.title }}</h3>       <!-- Service title -->
```

#### Link Accessibility
```go
{{/* ✅ Good: Descriptive link text and titles */}}
<a title="{{ $title }}"
   class="pp-more-link pp-button"
   href="{{ relURL $link }}"
   role="button"
   target="_self">
  {{ $cta_text }} <i class="pp-button-icon"></i>
</a>
```

### 2. Image Accessibility

#### Alt Text Strategy
```go
{{/* ✅ Good: Meaningful alt text */}}
<img src="{{ $image_path }}"
     alt="{{ $headline }}" />

{{/* ✅ Good: Decorative images */}}
<img src="{{ $badge_path }}"
     alt="{{ $company_name }} certification badge" />
```

## SEO Best Practices

### 1. Structured Data

#### Schema Integration
```go
{{/* ✅ Good: Component-level structured data */}}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Service",
  "name": "{{ $title }}",
  "description": "{{ $description }}",
  "url": "{{ absURL $link }}"
}
</script>
```

### 2. Performance SEO

#### Core Web Vitals
```go
{{/* ✅ Good: LCP optimization */}}
<img fetchpriority="high"
     width="800"
     height="400"
     src="{{ $hero_image }}"
     alt="{{ $headline }}" />

{{/* ✅ Good: CLS prevention */}}
<img width="50"
     height="50"
     src="{{ $icon }}"
     alt="{{ $service }}" />
```

## Testing Strategies

### 1. Component Testing

#### Template Validation
```bash
# Test component rendering
hugo --renderToMemory --templateMetrics

# Validate HTML output
hugo --renderToMemory | tidy -q -e
```

#### Visual Regression Testing
```bash
# Compare component output
diff expected-output.html actual-output.html

# Lighthouse testing
bin/lighthouse --performance --accessibility
```

### 2. Integration Testing

#### Data Integration Testing
```go
{{/* Test with edge case data */}}
{{ partial "components/service-card.html" (dict
  "icon" ""              // Empty icon
  "title" ""              // Empty title
  "description" ""        // Empty description
  "link" ""               // Empty link
) }}
```

#### Cross-page Testing
```bash
# Test across multiple page types
hugo server
curl http://localhost:1313/ | grep "service-card"
curl http://localhost:1313/services/ | grep "service-card"
```

## Error Handling

### 1. Graceful Degradation

#### Missing Assets
```go
{{/* ✅ Good: Handle missing icons gracefully */}}
{{- $icon_path := printf "theme/%s" $icon -}}
{{- if not (resources.Get (printf "img/icons/%s.svg" $icon_path)) -}}
  {{- $icon_path = "theme/default-service" -}}
{{- end -}}
```

#### Data Validation
```go
{{/* ✅ Good: Validate required data */}}
{{- if and .Site.Data.testimonials .Site.Data.testimonials.testimonials -}}
  {{ range .Site.Data.testimonials.testimonials }}
    <!-- Render testimonials -->
  {{ end }}
{{- else -}}
  <!-- Fallback content or skip section -->
{{- end -}}
```

## Documentation Standards

### 1. Component Documentation

#### Template Header Documentation
```go
{{/*
  Service Card Component

  Usage:
  {{ partial "components/service-card.html" (dict
    "icon" "fractional-cto"
    "title" "Fractional CTO"
    "description" "Service description"
    "link" "services/fractional-cto/"
    "cta_text" "Learn More"
    "node_id" "optional-id"
  ) }}

  Parameters:
  - icon: SVG icon name (required)
  - title: Service title (required)
  - description: Service description text (required)
  - link: Relative URL to service page (required)
  - cta_text: Call-to-action button text (required)
  - node_id: Optional FL-Builder node ID (defaults to generated)
*/}}
```

### 2. Usage Documentation

#### Example-Driven Documentation
- **Working Examples**: Use actual production data
- **Edge Cases**: Document handling of empty/missing data
- **Integration Patterns**: Show real template usage
- **Migration Notes**: FL-Builder to component transitions

## Maintenance Guidelines

### 1. Regular Maintenance

#### Quarterly Component Review
- [ ] Validate all components render correctly
- [ ] Check for unused parameters
- [ ] Update documentation with new usage patterns
- [ ] Review performance metrics

#### Annual Architecture Review
- [ ] Evaluate component reuse patterns
- [ ] Consider consolidation opportunities
- [ ] Update best practices based on learnings
- [ ] Plan deprecation of unused components

### 2. Version Control

#### Component Versioning
```go
{{/* Version comments for major changes */}}
{{/*
  Service Card Component v2.0

  Changes from v1.0:
  - Added node_id parameter
  - Improved accessibility
  - Enhanced error handling
*/}}
```

## Success Metrics

### Development Experience
- **Template Clarity**: Self-documenting component usage
- **Reusability**: Components used across multiple pages
- **Maintainability**: Single source of truth for layouts
- **Documentation**: Comprehensive usage guides

### Performance
- **Build Speed**: Hugo build performance
- **CSS Efficiency**: Reduced stylesheet complexity
- **Asset Optimization**: Optimized image and icon loading
- **Core Web Vitals**: LCP, CLS, FID improvements

### Quality
- **Visual Consistency**: Identical FL-Builder compatibility
- **Accessibility**: WCAG 2.1 compliance
- **SEO**: Semantic markup and structured data
- **Cross-browser**: Consistent rendering

---

*Component best practices follow conservative development principles with proven patterns and comprehensive testing.*