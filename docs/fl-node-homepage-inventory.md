# FL-Node Homepage Inventory & Migration Plan

## Overview
This document tracks all FL-node classes found in the homepage critical CSS and provides a migration plan for adding dual BEM classes while maintaining FL classes for backward compatibility.

## FL-Node Classes Found (Homepage Critical CSS)
Based on analysis of `themes/beaver/layouts/partials/header/critical/homepage.html`:

### Layout & Grid Components (Priority 1 - High Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-d09l8jp3qrgf | Row/Container | Main layout container | c-grid__container |
| fl-node-dn129i74qg6m | Row | Hero section row | c-grid__row c-hero |
| fl-node-fwc7x53r0dpl | Column | Left column (50% width) | c-grid__col c-grid__col--half |
| fl-node-bi013pcl2qtv | Column | Right column (50% width) | c-grid__col c-grid__col--half |
| fl-node-pifywec9vd5m | Column | Content box (55% width) | c-grid__col c-grid__col--55 |
| fl-node-5dzyge41jmoa | Column | Full width column | c-grid__col c-grid__col--full |
| fl-node-10d3e2kq8tox | Column | Quarter width (25%) | c-grid__col c-grid__col--quarter |
| fl-node-x6rqpedlc9y5 | Column | Quarter width (25%) | c-grid__col c-grid__col--quarter |
| fl-node-2x7c5i3nmohu | Column | Slightly wider (26%) | c-grid__col c-grid__col--26 |
| fl-node-we18l5hvkso9 | Column | Full width with padding | c-grid__col c-grid__col--full c-content-block |

### Button Components (Priority 1 - High Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-ls7iak3ydobn | Button Module | Primary CTA button | c-button c-button--primary |
| fl-node-2div407rylu5 | Button Module | Secondary/center button | c-button c-button--secondary |

### Typography & Content (Priority 2 - Medium Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-j23qxyn7ofsc | Heading Module | Main hero heading | c-typography__heading c-typography__heading--hero |
| fl-node-8yibs7gtxvjp | Rich Text Module | Content text block | c-content-block__text |
| fl-node-s3wp4tod8vfm | Rich Text Module | Large heading text | c-typography__heading c-typography__heading--large |
| fl-node-mvlu0rkbgc18 | Rich Text Module | Body text content | c-content-block__text |
| fl-node-pqwe8j7o3l6z | Rich Text Module | Centered text content | c-content-block__text c-content-block__text--center |

### Navigation (Priority 2 - Medium Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-header-nav-row | Navigation Row | Main header navigation row | c-navigation__row |
| fl-node-header-nav-logo | Logo Column | Logo container | c-navigation__logo |
| fl-node-header-nav-menu-col | Menu Column | Navigation menu container | c-navigation__menu |
| fl-node-header-nav-contact-us-btn | Button Column | Contact us button | c-navigation__cta |
| fl-node-ncg61wov0ytq | Advanced Menu | Main navigation menu | c-navigation__menu-items |

### Images & Media (Priority 3 - Lower Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-m6xb85qn107l | Photo Module | Hero image (365px) | c-media__image c-media__image--hero |
| fl-node-uqmxksgj6zd4 | Photo Module | Small logo (120px) | c-media__image c-media__image--logo |

### Logos & Client Grid (Priority 3 - Lower Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-cbhworulayqn | Logos Grid | Client logos grid (6 cols) | c-cards__grid c-cards__grid--logos |
| fl-node-el3fhm25cy0g | Logos Module | Logo carousel/slider | c-cards__slider c-cards__slider--logos |

### Interactive Components (Priority 2 - Medium Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-vo75i29j3fmz | Tabs Module | Interactive tabs component | c-tabs |
| fl-node-08kl1yzxeout | Reviews Module | Customer reviews/testimonials | c-cards__reviews |

### Spacers & Layout (Priority 3 - Lower Impact)
| FL-Node ID | Component Type | Purpose | BEM Equivalent |
|------------|----------------|---------|----------------|
| fl-node-7d9wg1x8ua5m | Spacer Module | 100px spacer | c-spacing__spacer c-spacing__spacer--large |
| fl-node-mkyhv3e21dx4 | Spacer Module | 32px spacer | c-spacing__spacer c-spacing__spacer--medium |
| fl-node-ymcvi0qt6zwd | Spacer Module | 60px spacer | c-spacing__spacer c-spacing__spacer--large |
| fl-node-toa2hwegbp4q | Spacer Module | 60px spacer | c-spacing__spacer c-spacing__spacer--large |

## Migration Priority Strategy

### Phase 1A: High-Impact Components (Week 1)
1. **Grid System** (fl-node-d09l8jp3qrgf, fl-node-dn129i74qg6m, fl-node-fwc7x53r0dpl, fl-node-bi013pcl2qtv)
   - Add c-grid classes alongside fl-node classes
   - Test responsiveness across breakpoints

2. **Button Components** (fl-node-ls7iak3ydobn, fl-node-2div407rylu5)
   - Add c-button classes alongside fl-button classes
   - Ensure interaction states work correctly

3. **Main Content Block** (fl-node-pifywec9vd5m, fl-node-we18l5hvkso9)
   - Add c-content-block classes
   - Verify content rendering and spacing

### Phase 1B: Navigation & Typography (Week 2)
4. **Navigation Components** (fl-node-header-nav-*, fl-node-ncg61wov0ytq)
   - Add c-navigation classes
   - Test mobile menu functionality

5. **Typography Components** (fl-node-j23qxyn7ofsc, fl-node-8yibs7gtxvjp, fl-node-s3wp4tod8vfm)
   - Add c-typography and c-content-block classes
   - Verify responsive text scaling

### Phase 1C: Media & Interactive (Week 3)
6. **Media Components** (fl-node-m6xb85qn107l, fl-node-uqmxksgj6zd4)
   - Add c-media classes
   - Test image loading and responsiveness

7. **Interactive Components** (fl-node-vo75i29j3fmz, fl-node-08kl1yzxeout)
   - Add c-tabs and c-cards classes
   - Test JavaScript functionality

### Phase 1D: Final Components (Week 4)
8. **Client Logos & Cards** (fl-node-cbhworulayqn, fl-node-el3fhm25cy0g)
   - Add c-cards classes
   - Test grid layouts and sliders

9. **Spacing & Layout** (spacer fl-nodes)
   - Add c-spacing classes
   - Verify layout spacing consistency

## Dual-Class Strategy

### Example Implementation
```html
<!-- Before: FL-only -->
<div class="fl-node-ls7iak3ydobn fl-module fl-module-fl-button">
  <div class="fl-button-wrap">
    <a href="/contact" class="fl-button">Contact Us</a>
  </div>
</div>

<!-- After: Dual classes (FL + BEM) -->
<div class="fl-node-ls7iak3ydobn fl-module fl-module-fl-button c-button">
  <div class="fl-button-wrap c-button__wrapper">
    <a href="/contact" class="fl-button c-button__link c-button__link--primary">Contact Us</a>
  </div>
</div>
```

### Conservative Approach
- Keep ALL existing FL classes
- Add BEM classes alongside existing classes
- Test after each component type migration
- Commit micro-changes (≤3 lines per commit)
- Run `bin/test` after each change

## Testing Protocol
1. **Visual Regression Testing**: Compare before/after screenshots
2. **Cross-Browser Testing**: Chrome, Firefox, Safari, Edge
3. **Responsive Testing**: Mobile, tablet, desktop breakpoints
4. **Functional Testing**: Ensure all interactions work
5. **Performance Testing**: Verify no significant performance impact

## Migration Progress Tracking
- [ ] Grid Components (Priority 1A)
- [ ] Button Components (Priority 1A)
- [ ] Content Blocks (Priority 1A)
- [ ] Navigation (Priority 1B)
- [ ] Typography (Priority 1B)
- [ ] Media Components (Priority 1C)
- [ ] Interactive Components (Priority 1C)
- [ ] Client Logos (Priority 1D)
- [ ] Spacing Components (Priority 1D)

## Component System Alignment
This migration aligns with our 8 component systems:
1. **Buttons** → c-button classes
2. **Colors** → via CSS custom properties
3. **Forms** → c-form classes (not in homepage critical CSS)
4. **Grid** → c-grid classes
5. **Typography** → c-typography classes
6. **Spacing** → c-spacing classes
7. **Navigation** → c-navigation classes
8. **Cards** → c-cards classes

## Risk Mitigation
- Dual-class approach ensures zero breaking changes
- Micro-commits allow for easy rollback
- Comprehensive testing at each stage
- Conservative timeline with buffer for issues
- Team coordination through swarm methodology