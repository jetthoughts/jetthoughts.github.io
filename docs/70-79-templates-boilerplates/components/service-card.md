# Service Card Component Reference

## Overview
The Service Card component displays service offerings with icons, descriptions, and call-to-action buttons. Extracted from FL-Builder service infobox modules.

## Location
`themes/beaver/layouts/partials/components/service-card.html`

## Purpose
- Display services in grid layouts
- Maintain consistent service presentation
- Provide actionable links to detailed service pages
- Preserve FL-Builder visual compatibility

## Parameters

### Required Parameters
| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `icon` | string | SVG icon name from theme/ directory | `"fractional-cto"` |
| `title` | string | Service title | `"Fractional CTO"` |
| `description` | string | Service description text | `"Get on-demand access to a CTO..."` |
| `link` | string | Relative URL to service page | `"services/fractional-cto/"` |
| `cta_text` | string | Call-to-action button text | `"Learn More"` |

### Optional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `node_id` | string | Generated from icon | FL-Builder node ID for CSS targeting |

## Usage Examples

### Basic Service Card
```go
{{ partial "components/service-card.html" (dict
  "icon" "fractional-cto"
  "title" "Fractional CTO"
  "description" "Get on-demand access to a CTO to help guide your technical vision, accelerate team-building, and improve development team operations."
  "link" "services/fractional-cto/"
  "cta_text" "Learn About Fractional CTO Services"
) }}
```

### With Custom Node ID
```go
{{ partial "components/service-card.html" (dict
  "icon" "app-web"
  "title" "Web App Development"
  "description" "Build scalable web applications with modern frameworks and best practices."
  "link" "services/web-app-development/"
  "cta_text" "Explore Web Development"
  "node_id" "custom-web-service"
) }}
```

### Data Integration
```go
{{/* Using site data */}}
{{ range .Site.Data.services.services }}
  {{ partial "components/service-card.html" . }}
{{ end }}
```

## HTML Structure

### Generated Output
```html
<div class="fl-col fl-node-service-fractionaltto fl-col-small fl-col-small-custom-width hover-box" data-node="service-fractionaltto">
  <div class="fl-col-content fl-node-content">
    <div class="fl-module fl-module-pp-infobox fl-node-service-fractionaltto-box jt-service-box" data-node="service-fractionaltto-box">
      <div class="fl-module-content fl-node-content">
        <div class="pp-infobox-wrap">
          <div class="pp-infobox layout-5">
            <div class="pp-icon-wrapper animated">
              <div class="pp-infobox-image">
                <!-- SVG icon via svgiw partial -->
              </div>
            </div>
            <div class="pp-infobox-title-wrapper">
              <h3 class="pp-infobox-title">
                <a class="pp-title-link" href="/services/fractional-cto/" target="_self">Fractional CTO</a>
              </h3>
            </div>
            <div class="pp-infobox-description">
              <div class="pp-description-wrap">
                <p>Get on-demand access to a CTO...</p>
              </div>
              <div class="pp-infobox-button pp-button-wrap">
                <a title="Fractional CTO" class="pp-more-link pp-button" href="/services/fractional-cto/" role="button" target="_self">
                  Learn About Fractional CTO Services <i class="pp-button-icon pp-button-icon-right far fa-long-arrow-right"></i>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
```

### CSS Classes
- `fl-col`: FL-Builder column wrapper
- `fl-node-{node_id}`: Node-specific targeting
- `hover-box`: Hover effect styling
- `jt-service-box`: Custom service box styling
- `pp-infobox`: PowerPack infobox base class
- `layout-5`: Specific infobox layout variant

## Asset Dependencies

### SVG Icons
- Location: `themes/beaver/assets/img/icons/theme/`
- Format: SVG files with consistent naming
- Processing: Via `svgiw` partial with width/height parameters
- Examples: `fractional-cto.svg`, `app-web.svg`, `consulting.svg`

### FontAwesome Icons
- Arrow icon: `far fa-long-arrow-right`
- Usage: CTA button visual indicator
- Styling: Right-aligned button icon

### FL-Builder CSS
- Base styles: PowerPack infobox styles
- Custom styles: JetThoughts service box customizations
- Responsive: FL-Builder responsive utilities
- Hover effects: Custom hover animations

## Current Usage

### Homepage Service Grid
**File**: `themes/beaver/layouts/partials/homepage/services.html`
```go
{{ range .Site.Data.services.services }}
  {{ if .featured }}
    {{ partial "components/service-card.html" (dict
      "icon" .icon
      "title" .name
      "description" .description
      "link" .url
      "cta_text" "Learn More"
    ) }}
  {{ end }}
{{ end }}
```

### Service Template Pages
**File**: `themes/beaver/layouts/page/service-template.html`
```go
{{ range $related_services }}
  {{ partial "components/service-card.html" . }}
{{ end }}
```

## Design System Integration

### Typography
- **Title**: H3 element with `pp-infobox-title` class
- **Description**: Paragraph text in `pp-description-wrap`
- **CTA**: Button text with FontAwesome arrow

### Spacing
- **Icon**: 30x30px SVG with wrapper padding
- **Content**: Standard FL-Builder module spacing
- **Hover**: Subtle animation effects

### Colors
- **Icons**: Theme blue color scheme
- **Text**: Standard text color hierarchy
- **CTA**: Primary button styling
- **Hover**: Enhanced contrast and shadow

## Best Practices

### Icon Management
```bash
# Add new service icon
cp new-service-icon.svg themes/beaver/assets/img/icons/theme/
```

### Parameter Validation
```go
{{/* Always provide fallbacks */}}
{{- $icon := .icon | default "default-service" -}}
{{- $title := .title | default "Service Title" -}}
{{- $description := .description | default "Service description." -}}
```

### SEO Optimization
- Use descriptive titles in H3 elements
- Include keyword-rich descriptions
- Ensure proper link structure
- Add semantic HTML markup

### Accessibility
- Proper heading hierarchy (H3 for service titles)
- Descriptive alt text for icons via SVG titles
- Keyboard accessible links and buttons
- Focus states for interactive elements

## Testing

### Unit Testing
```bash
# Test component with various parameters
hugo --renderToMemory --templateMetrics
```

### Visual Testing
```bash
# Compare with FL-Builder output
diff fl-builder-output.html component-output.html
```

### Performance Testing
```bash
# Lighthouse audit with components
bin/lighthouse --performance
```

## Migration Notes

### From FL-Builder Module
1. Extract icon, title, description from FL-Builder settings
2. Map node ID to preserve CSS targeting
3. Replace FL-Builder shortcode with component partial
4. Validate visual output matches exactly

### CSS Preservation
- All FL-Builder classes maintained
- Node ID structure preserved
- Custom JT styling classes retained
- Responsive breakpoints unchanged

## Troubleshooting

### Common Issues

**Icon Not Displaying**
```bash
# Check icon file exists
ls themes/beaver/assets/img/icons/theme/fractional-cto.svg

# Verify svgiw partial usage
{{ partial "svgiw" (dict "svg" (printf "theme/%s" $icon) "width" "30" "height" "30") }}
```

**CSS Styling Missing**
```bash
# Verify FL-Builder classes preserved
grep "pp-infobox" themes/beaver/layouts/partials/components/service-card.html

# Check node ID generation
echo $node_id
```

**Link Issues**
```bash
# Verify relURL usage
{{ relURL $link }}

# Check link target
target="_self"
```

---

*Service Card component documentation follows Diátaxis reference format with complete parameter specification and practical examples.*