# Phase 6: Template Dependency Audit - FL-Builder File Usage

## Executive Summary

**CRITICAL FINDING**: Phase 6 legacy file removal is BLOCKED by active template dependencies. All 12 FL-Builder CSS files (1.7MB total) are still actively referenced in 14 templates across the site.

**RECOMMENDATION**: Pivot to conservative template migration strategy rather than immediate file deletion to prevent site breakage.

## FL-Builder File Usage Mapping

### High-Impact Files (>150KB each)

#### 1. fl-homepage-layout.css (314KB) - CRITICAL
- **Template**: `themes/beaver/layouts/home.html` (line 11)
- **Impact**: Homepage layout - highest traffic page
- **Risk**: EXTREME - homepage breakage would be catastrophic
- **Priority**: PHASE 6A - First migration target

#### 2. fl-clients-alt-bundle.css (162KB)
- **Template**: `themes/beaver/layouts/clients/single.html` (line 7)
- **Impact**: Individual client showcase pages
- **Risk**: HIGH - client-facing content

#### 3. fl-use-cases-layout.css (154KB)
- **Templates**:
  - `themes/beaver/layouts/page/use-cases.html` (line 5)
- **Impact**: Use cases overview page
- **Risk**: HIGH - key conversion page

#### 4. fl-services-layout.css (154KB)
- **Templates**:
  - `themes/beaver/layouts/page/test-service.html` (line 4)
  - `themes/beaver/layouts/page/services.html` (line 5)
- **Impact**: Services pages (multiple)
- **Risk**: HIGH - core business pages

### Medium-Impact Files (100-150KB each)

#### 5. fl-careers-layout.css (128KB)
- **Template**: `themes/beaver/layouts/page/careers.html` (line 5)
- **Impact**: Careers/hiring page
- **Risk**: MEDIUM - recruiting functionality

#### 6. fl-service-detail-layout.css (126KB)
- **Templates**:
  - `themes/beaver/layouts/services/single.html` (line 5)
  - `themes/beaver/layouts/page/service-template.html` (line 20)
- **Impact**: Individual service detail pages
- **Risk**: HIGH - detailed service descriptions

#### 7. fl-clients-layout.css (126KB)
- **Template**: `themes/beaver/layouts/page/clients.html` (line 3)
- **Impact**: Clients overview page
- **Risk**: HIGH - client showcase

#### 8. fl-component-layout.css (118KB)
- **Template**: `themes/beaver/layouts/use-cases/single.html` (line 5)
- **Impact**: Individual use case pages
- **Risk**: MEDIUM - use case details

#### 9. fl-about-layout.css (105KB)
- **Template**: `themes/beaver/layouts/page/about.html` (line 6)
- **Impact**: About page
- **Risk**: MEDIUM - company information

### Lower-Impact Files (<100KB each)

#### 10. fl-contact-layout.css (54KB)
- **Template**: `themes/beaver/layouts/page/contact-us.html` (line 5)
- **Impact**: Contact page
- **Risk**: HIGH - conversion funnel endpoint

#### 11. fl-clients-bundle.css (52KB)
- **Template**: `themes/beaver/layouts/page/clients.html` (line 3)
- **Impact**: Clients page supplementary styles
- **Risk**: MEDIUM - additional client styling

#### 12. fl-component-layout-alt.css (21KB)
- **Template**: `themes/beaver/layouts/page/single.html` (line 5)
- **Impact**: Generic page layout
- **Risk**: MEDIUM - fallback page template

## Template Dependency Analysis

### Templates with Multiple FL-Builder Dependencies

#### 1. clients.html (2 files, 178KB total)
```hugo
{{- $staticClientsCSS := slice
    (resources.Get "css/fl-clients-layout.css")
    (resources.Get "css/fl-clients-bundle.css")
    ...
}}
```

#### 2. test-hero.html (1 file, 314KB)
```hugo
{{- $staticHomepageCSS := slice
    (resources.Get "css/fl-homepage-layout.css")
    ...
}}
```

#### 3. use-cases.html (1 file, 154KB)
```hugo
{{- $staticUseCasesCSS := slice
    (resources.Get "css/fl-use-cases-layout.css")
    ...
}}
```

## Conservative Phase 6 Strategy

### Phase 6A: Critical Path Migration (Homepage Priority)
1. **Target**: fl-homepage-layout.css (314KB) in home.html
2. **Approach**: Create optimized homepage-specific bundle
3. **Safety**: Maintain dual-class compatibility
4. **Validation**: Comprehensive visual regression testing

### Phase 6B: High-Traffic Page Migration
1. **Targets**: Services, Use Cases, Clients pages
2. **Combined Impact**: ~470KB reduction potential
3. **Approach**: Page-specific optimization bundles
4. **Timeline**: One page per micro-iteration

### Phase 6C: Remaining Page Migration
1. **Targets**: About, Contact, Careers, Detail pages
2. **Combined Impact**: ~435KB reduction potential
3. **Approach**: Incremental template replacement
4. **Safety**: Maintain backward compatibility throughout

## Risk Mitigation Strategy

### 1. Template Migration Protocol
- **Step 1**: Analyze existing FL-Builder styles used in template
- **Step 2**: Map to equivalent optimized component styles
- **Step 3**: Create page-specific bundle with necessary components
- **Step 4**: Update template reference with A/B testing capability
- **Step 5**: Validate visual consistency across breakpoints
- **Step 6**: Deploy with rollback plan

### 2. Safety Measures
- **Dual Loading**: Temporarily load both old and new styles during transition
- **Visual Regression**: Screenshot comparison for every page
- **Performance Monitoring**: Lighthouse audits before/after each change
- **Rollback Plan**: Immediate revert capability for any visual issues

### 3. Quality Gates
- **Build Validation**: `bin/hugo-build` must succeed
- **Test Suite**: `bin/test` must pass (23 runs, 33 assertions)
- **Visual Validation**: Manual review of affected pages
- **Performance Validation**: No degradation in Core Web Vitals

## Implementation Timeline

### Week 1: Phase 6A - Homepage Critical Path
- Day 1-2: Analyze fl-homepage-layout.css styles
- Day 3-4: Create optimized homepage bundle
- Day 5: Template migration and testing

### Week 2: Phase 6B - High-Traffic Pages
- Services page template migration
- Use cases page template migration
- Clients page template migration

### Week 3: Phase 6C - Remaining Pages
- Detail pages template migration
- About/Contact/Careers template migration
- Final cleanup and validation

## Expected Outcomes

### Performance Impact
- **Phase 6A**: 314KB reduction (homepage optimization)
- **Phase 6B**: 470KB reduction (high-traffic pages)
- **Phase 6C**: 435KB reduction (remaining pages)
- **Total Phase 6**: ~1.2MB reduction (70% of remaining legacy CSS)

### Risk Assessment
- **Approach**: CONSERVATIVE - maintains compatibility throughout
- **Rollback**: IMMEDIATE - any visual regression triggers revert
- **Testing**: COMPREHENSIVE - visual, functional, performance validation
- **Timeline**: REALISTIC - incremental changes with validation gates

## Conclusion

Phase 6 requires a fundamentally different approach than originally planned. Instead of bulk file deletion, we need systematic template migration to maintain site stability while achieving the performance benefits.

The conservative approach ensures:
1. Zero visual regressions
2. Maintained backward compatibility
3. Incremental performance improvements
4. Comprehensive rollback capability

**Next Action**: Begin Phase 6A with homepage template migration as the highest-impact, lowest-risk starting point.