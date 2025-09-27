# Component Migration Plan - FL to BEM Architecture

## Progress Summary

### ✅ Completed
1. **Critical CSS Removal** - 312KB of duplicated inline CSS removed
   - All critical CSS injections disabled across 16 template files
   - Hugo build successful after removal
   - Site functional with render-blocking CSS (acceptable trade-off)
   - Test failures reduced from 10 to 7

### 🎯 Current State
- FL-Builder CSS: 1.33MB (active framework, not removable yet)
- Visual regression tests: 7 failures (improvement from 10)
- Site performance: Slightly degraded initial render, but better caching

## Component Migration Strategy

### Phase 1: Core Component Structure (Current)
Create reusable BEM components to replace FL-Builder patterns:

#### 1.1 Navigation Component (c-nav)
```css
.c-nav { /* Main navigation wrapper */ }
.c-nav__menu { /* Menu container */ }
.c-nav__item { /* Individual menu items */ }
.c-nav__link { /* Navigation links */ }
.c-nav--mobile { /* Mobile variation */ }
```
- Replace: `.fl-page-nav`, `.fl-nav-menu`
- Files affected: All page templates

#### 1.2 Hero Component (c-hero)
```css
.c-hero { /* Hero section wrapper */ }
.c-hero__content { /* Content container */ }
.c-hero__title { /* Main heading */ }
.c-hero__description { /* Subtitle/description */ }
.c-hero__cta { /* Call-to-action buttons */ }
.c-hero--centered { /* Centered variation */ }
```
- Replace: `.fl-row-bg-photo`, `.fl-heading`
- High impact: Used on homepage, services, about

#### 1.3 Content Block Component (c-content)
```css
.c-content { /* Content section */ }
.c-content__wrapper { /* Inner wrapper */ }
.c-content__title { /* Section title */ }
.c-content__body { /* Main content */ }
.c-content__media { /* Images/videos */ }
.c-content--reversed { /* Media on left */ }
```
- Replace: `.fl-module-rich-text`, `.fl-col-content`
- Most frequently used component

#### 1.4 Card Component (c-card)
```css
.c-card { /* Card container */ }
.c-card__image { /* Card image */ }
.c-card__body { /* Card content */ }
.c-card__title { /* Card heading */ }
.c-card__text { /* Card description */ }
.c-card__link { /* Card CTA */ }
.c-card--horizontal { /* Horizontal layout */ }
```
- Replace: `.fl-module`, service cards, testimonials
- Used in services, use-cases, clients

### Phase 2: Specialized Components

#### 2.1 Testimonial Component (c-testimonial)
```css
.c-testimonial { /* Testimonial wrapper */ }
.c-testimonial__quote { /* Quote text */ }
.c-testimonial__author { /* Author info */ }
.c-testimonial__company { /* Company/role */ }
.c-testimonial__avatar { /* Author image */ }
```

#### 2.2 CTA Component (c-cta)
```css
.c-cta { /* Call-to-action section */ }
.c-cta__heading { /* CTA title */ }
.c-cta__text { /* CTA description */ }
.c-cta__button { /* CTA button */ }
.c-cta--centered { /* Centered variation */ }
```

#### 2.3 Form Component (c-form) - Already Started
```css
.c-form { /* Form wrapper */ }
.c-form__field { /* Form field */ }
.c-form__label { /* Field label */ }
.c-form__input { /* Input field */ }
.c-form__submit { /* Submit button */ }
```

### Phase 3: Layout Components

#### 3.1 Grid System (c-grid)
```css
.c-grid { /* Grid container */ }
.c-grid__item { /* Grid item */ }
.c-grid--2-col { /* 2 column grid */ }
.c-grid--3-col { /* 3 column grid */ }
.c-grid--responsive { /* Responsive grid */ }
```

#### 3.2 Section Component (c-section)
```css
.c-section { /* Page section */ }
.c-section__container { /* Content container */ }
.c-section--full-width { /* Full width section */ }
.c-section--padded { /* With padding */ }
```

## Implementation Approach

### Micro-refactoring Strategy
1. **Dual-class approach** during transition
   - Add BEM classes alongside FL classes
   - Gradually remove FL dependencies
   - Maintain visual consistency

2. **Component-by-component migration**
   - Start with most used components (content blocks)
   - Test after each component migration
   - Maximum 3 components per sprint

3. **Testing protocol**
   - Visual regression test after each component
   - Cross-browser validation
   - Mobile responsiveness check
   - Performance impact measurement

### File Organization
```
themes/beaver/assets/css/components/
├── base/
│   ├── c-grid.css
│   └── c-section.css
├── layout/
│   ├── c-nav.css
│   └── c-footer.css
└── blocks/
    ├── c-hero.css
    ├── c-card.css
    ├── c-content.css
    ├── c-testimonial.css
    ├── c-cta.css
    └── c-form.css (existing)
```

## Success Metrics

### Target Outcomes
- CSS reduction: 1.33MB → <500KB (62% reduction)
- Page load improvement: 20-30% faster
- Maintenance effort: 50% reduction
- Component reusability: 80% of UI from components

### Quality Gates
- ✅ Visual regression tests pass
- ✅ Lighthouse score maintained/improved
- ✅ Cross-browser compatibility verified
- ✅ Mobile responsiveness validated
- ✅ No accessibility regressions

## Next Actions

### Immediate (Sprint 1)
1. Create c-hero component for homepage
2. Create c-content component for main sections
3. Update templates with dual classes
4. Test and validate changes

### Short-term (Sprint 2-3)
1. Migrate navigation to c-nav
2. Create c-card for services/testimonials
3. Implement c-cta components
4. Begin FL class removal

### Medium-term (Sprint 4-6)
1. Complete all component migrations
2. Remove FL-Builder CSS files
3. Optimize component CSS
4. Document component library

## Risk Mitigation

### Rollback Strategy
- Git commits after each micro-change
- Backup FL CSS files before removal
- Feature flags for component switching
- A/B testing capability

### Testing Safeguards
- Automated visual regression tests
- Manual QA on staging
- Performance monitoring
- User acceptance testing

---

*Goal: Remove all CSS duplications and migrate to reusable component architecture*
*Method: XP methodology with micro-refactoring and continuous validation*
*Timeline: 6 sprints (12 weeks) for complete migration*