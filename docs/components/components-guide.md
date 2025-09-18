# Hugo Components Guide

*Complete usage guide for the JetThoughts Hugo component library*

## Table of Contents
1. [Service Card Component](#service-card-component)
2. [Use Case Card Component](#use-case-card-component)
3. [Hero Section Component](#hero-section-component)
4. [CTA Block Component](#cta-block-component)
5. [Testimonial Component](#testimonial-component)
6. [Usage Patterns](#usage-patterns)
7. [Best Practices](#best-practices)

---

## Service Card Component

### Purpose
Displays service offerings with icons, descriptions, and call-to-action buttons. Extracted from FL-Builder service grids.

### Location
`themes/beaver/layouts/partials/components/service-card.html`

### Parameters
```go
{{/* Required Parameters */}}
icon        string  // SVG icon name from theme/ directory
title       string  // Service title
description string  // Service description text
link        string  // Relative URL to service page
cta_text    string  // Call-to-action button text

{{/* Optional Parameters */}}
node_id     string  // FL-Builder node ID (defaults to generated)
```

### Usage Example
```go
{{/* Basic service card */}}
{{ partial "components/service-card.html" (dict
  "icon" "fractional-cto"
  "title" "Fractional CTO"
  "description" "Get on-demand access to a CTO to help guide your technical vision, accelerate team-building, and improve development team operations."
  "link" "services/fractional-cto/"
  "cta_text" "Learn About Fractional CTO Services"
) }}
```

### Current Usage
- **Homepage**: Service grid (`layouts/partials/homepage/services.html`)
- **Service Pages**: Related services (`layouts/page/service-template.html`)

### Asset Dependencies
- SVG icons via `partial "svgiw"`
- FontAwesome icons for arrows (`far fa-long-arrow-right`)
- FL-Builder CSS classes (`pp-infobox`, `jt-service-box`)

---

## Use Case Card Component

### Purpose
Displays business use cases with cover images, icons, and detailed descriptions. More complex than service cards with dual content (menu + page data).

### Location
`themes/beaver/layouts/partials/components/use-case-card.html`

### Parameters
```go
{{/* Required Parameters */}}
icon         string  // SVG icon name from menu_custom
title        string  // Use case title from menu_custom
description  string  // Use case description from menu_custom
headline     string  // Primary headline from frontmatter
excerpt      string  // Brief description from frontmatter
link         string  // Relative URL to use case page
cover_image  string  // Cover image filename

{{/* Optional Parameters */}}
cta_text     string  // Call-to-action button text (defaults to "Learn More")
node_id      string  // FL-Builder node ID (defaults to generated)
```

### Usage Example
```go
{{/* Complete use case card */}}
{{ partial "components/use-case-card.html" (dict
  "icon" "submenu-fractional"
  "title" "Fractional CTO"
  "description" "Get on-demand access to a CTO to help guide your technical vision."
  "headline" "Launch faster, go to market smarter"
  "excerpt" "Gain market feedback, secure product validation, and accelerate the path to revenue."
  "link" "use-cases/startup-mvp-prototyping-development/"
  "cta_text" "Learn About This Use Case"
  "cover_image" "startup-mvp-prototyping-development.jpg"
) }}
```

### Key Features
- **Dual Content**: Combines menu data with page frontmatter
- **Image Support**: Cover images from `images/use-cases/` directory
- **Flexible Hierarchy**: Headline takes precedence over title
- **Fallback Logic**: Uses description as excerpt fallback

### Current Usage
- **Test Templates**: Component testing (`layouts/_test/single.html`)

---

## Hero Section Component

### Purpose
Creates landing page hero sections with headlines, descriptions, CTAs, and optional cover images. Includes SVG background shapes.

### Location
`themes/beaver/layouts/partials/components/hero-section.html`

### Parameters
```go
{{/* Required Parameters */}}
headline     string  // Main hero headline
excerpt      string  // Hero description text

{{/* Optional Parameters */}}
cta_text     string  // Call-to-action button text
cta_link     string  // Relative URL for CTA button (defaults to "#")
cover_image  string  // Hero image filename
node_id      string  // FL-Builder node ID (defaults to "hero-section")
bg_class     string  // Background class (defaults to "fl-row-bg-photo")
```

### Usage Example
```go
{{/* Full hero section */}}
{{ partial "components/hero-section.html" (dict
  "headline" "Launch faster, go to market smarter"
  "excerpt" "Gain market feedback, secure product validation, and accelerate the path to revenue without slowing down or going broke."
  "cta_text" "Talk to an Expert"
  "cta_link" "free-consultation/"
  "cover_image" "startup-mvp-prototyping-development.jpg"
) }}
```

### Key Features
- **Responsive Design**: FL-Builder responsive classes
- **SVG Shapes**: Built-in SVG background elements
- **Image Optimization**: Uses `fetchpriority="high"` for hero images
- **Semantic HTML**: Proper H1 structure
- **Conditional CTA**: Button only renders if `cta_text` provided

### Current Usage
- **Test Templates**: Hero section testing (`layouts/_test/single.html`)

---

## CTA Block Component

### Purpose
Creates call-to-action sections with headings, descriptions, and styled buttons. Includes flexible border styling.

### Location
`themes/beaver/layouts/partials/components/cta-block.html`

### Parameters
```go
{{/* Required Parameters */}}
heading      string  // CTA section heading
description  string  // CTA description text

{{/* Optional Parameters */}}
cta_text     string  // Call-to-action button text (defaults to "Contact Us")
cta_link     string  // Relative URL for CTA button (defaults to "contact-us/")
node_id      string  // FL-Builder node ID (defaults to "cta-block")
border_class string  // Optional border styling class (defaults to "blue-border")
```

### Usage Example
```go
{{/* Standard CTA block */}}
{{ partial "components/cta-block.html" (dict
  "heading" "Let's get started now"
  "description" "Get in touch with one of our experts to get a technical strategy & planning session for your project at no cost."
  "cta_text" "Contact Us"
  "cta_link" "contact-us/"
  "border_class" "blue-border"
) }}
```

### Key Features
- **Flexible Styling**: Border class customization
- **Responsive Spacers**: Device-specific spacing elements
- **Centered Layout**: Button wrapper centers CTA
- **Semantic Structure**: Proper H2 hierarchy

### Current Usage
- **Test Templates**: CTA section testing (`layouts/_test/single.html`)

---

## Testimonial Component

### Purpose
Complete testimonial section with badges, ratings, and testimonial carousel. Most complex component with external dependencies.

### Location
`themes/beaver/layouts/partials/components/testimonial.html`

### Parameters
```go
{{/* Optional Parameters - All have defaults */}}
section_title string  // Section label (defaults to "TESTIMONIALS")
heading       string  // Main heading (defaults to "What Our Clients Say")
description   string  // Section description
show_badges   bool    // Whether to show company badges (defaults to true)
show_rating   bool    // Whether to show rating section (defaults to true)
rating        string  // Rating score (defaults to "4.8")
rating_text   string  // Rating description (defaults to "Based on client reviews")
node_id       string  // FL-Builder node ID (defaults to "testimonials")
```

### Usage Example
```go
{{/* Complete testimonial section */}}
{{ partial "components/testimonial.html" (dict
  "section_title" "TESTIMONIALS"
  "heading" "Most clients stay over 3 years. Some stayed beyond 6."
  "description" "Don't just take our word for it. See what our clients say about our services."
  "show_badges" true
  "show_rating" true
  "rating" "4.8"
  "rating_text" "Based on 32 client reviews"
) }}
```

### Key Features
- **Badge Integration**: Company badges (GoodFirms, Clutch, Glassdoor, etc.)
- **Star Ratings**: Visual star images with scores
- **Swiper Carousel**: Dynamic testimonial slider
- **Data Integration**: Reads from `.Site.Data.testimonials` or `.Site.Params.testimonials`
- **CSS Loading**: Non-critical CSS with preload optimization
- **Responsive Layout**: Flex container with mobile column layout

### Asset Dependencies
- **Swiper CSS**: `css/swiper.min.css` (preloaded)
- **Badge Images**: Various badge files from `img/badges/`
- **Star Images**: `img/stars.png` for ratings
- **Image Processing**: `img/resize.html` partial for badge optimization

### Current Usage
- **Test Templates**: Testimonial section testing (`layouts/_test/single.html`)

---

## Usage Patterns

### 1. Grid Layouts
```go
{{/* Service grid pattern */}}
<div class="fl-row">
  <div class="fl-col-group">
    {{ range .Site.Data.services.services }}
      {{ partial "components/service-card.html" . }}
    {{ end }}
  </div>
</div>
```

### 2. Page Templates
```go
{{/* Full page layout with multiple components */}}
{{ partial "components/hero-section.html" $hero_params }}

<div class="content-section">
  {{ range $use_cases }}
    {{ partial "components/use-case-card.html" . }}
  {{ end }}
</div>

{{ partial "components/cta-block.html" $cta_params }}
{{ partial "components/testimonial.html" (dict) }}
```

### 3. Data Integration
```go
{{/* Service data integration */}}
{{ $service := index .Site.Data.services.services 0 }}
{{ partial "components/service-card.html" (dict
  "icon" $service.icon
  "title" $service.title
  "description" $service.description
  "link" $service.link
  "cta_text" "Learn More"
) }}
```

---

## Best Practices

### 1. Parameter Validation
- All components provide sensible defaults
- Required parameters are clearly documented
- Use `| default` for optional parameters

### 2. Asset Management
- SVG icons go in `themes/beaver/assets/img/icons/theme/`
- Cover images go in `static/images/` or appropriate subdirectories
- Use Hugo's asset processing for optimization

### 3. FL-Builder Compatibility
- Components preserve existing CSS classes
- Node IDs maintain FL-Builder structure
- No breaking changes to existing layouts

### 4. Performance Optimization
- Use `fetchpriority="high"` for above-fold images
- Preload critical CSS with `rel="preload"`
- Lazy load non-critical assets

### 5. Accessibility
- Maintain proper heading hierarchy (H1 → H2 → H3)
- Include descriptive `alt` text for images
- Use semantic HTML structure
- Preserve keyboard navigation

### 6. SEO Considerations
- Structured data support where applicable
- Semantic HTML markup
- Performance optimization for Core Web Vitals
- Proper image optimization

---

## Component Development Workflow

### 1. Extraction Process
1. Identify FL-Builder module to extract
2. Analyze parameters and dependencies
3. Create parameterized template
4. Maintain CSS compatibility
5. Document thoroughly

### 2. Testing Strategy
1. Create test template in `layouts/_test/`
2. Validate with existing data
3. Test responsive breakpoints
4. Verify FL-Builder compatibility
5. Run Hugo build validation

### 3. Documentation Requirements
1. Complete parameter reference
2. Working usage examples
3. Asset dependency list
4. Current usage locations
5. Migration notes

---

*Documentation follows conservative approach: Document existing patterns, minimal speculation, actual usage examples.*