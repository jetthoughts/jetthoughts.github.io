# ADR-001: Hugo Site DX and Best Practices Improvements

## Status

Proposed

## Context

After conducting comprehensive research using Hugo's golang_proxy package and analyzing the current JetThoughts Hugo site structure, several significant opportunities for Developer Experience (DX) improvements and performance optimizations have been identified.

### Current Site Architecture Analysis

**Theme Structure**: Custom "beaver" theme with 101 template files across complex partial organization
**Asset Management**: 2.5MB of CSS across 39 files, currently using manual asset processing
**Configuration**: Multi-environment Hugo configuration with production optimizations
**Content Organization**: Well-structured content hierarchy with data-driven testimonials, companies, and services
**Build Performance**: Current production builds take 7-8 seconds with existing asset pipeline

### Research Findings from Hugo Package Analysis

Based on package-search research of `gohugoio/hugo`, key Hugo best practices include:

1. **Page Bundles**: Hugo 0.32+ supports resource co-location with content
2. **Asset Processing Pipeline**: Built-in Hugo Pipes for CSS/JS processing
3. **Template Caching**: `partialCached` for performance optimization
4. **Module System**: Hugo Modules for theme and component management
5. **Resource Processing**: Modern resource processing with fingerprinting and minification

## Decision Drivers

- **Developer Experience**: Improve build speed and development workflow
- **Build Performance**: Reduce 7-8 second build times
- **Maintainability**: Simplify template complexity and asset management
- **Hugo Best Practices Compliance**: Align with modern Hugo patterns
- **Content Management Efficiency**: Streamline content workflows

## Top 5 Improvements

### 1. Adopt Hugo Modules for Theme Management

**Impact**: High  
**Effort**: Medium  

**Current State**: Traditional theme directory with 101 mixed template files and inconsistent partial organization

**Proposed State**:

- Convert custom theme to Hugo Module structure
- Implement proper module versioning and dependency management
- Enable easier theme updates and component reuse

**Benefits**:

- Simplified dependency management
- Better separation of concerns
- Easier updates and versioning
- Improved code reusability across projects
- Standard Hugo community practices

**Implementation**:

1. Initialize `themes/beaver` as Hugo Module with `go mod init`
2. Create `hugo.toml` module configuration
3. Refactor theme structure to follow module conventions
4. Update main site to use module imports
5. Set up version tagging for theme releases

```toml
# In main site hugo.toml
[module]
  [[module.imports]]
    path = "github.com/jetthoughts/beaver-theme"
```

### 2. Implement Hugo Pipes Asset Pipeline

**Impact**: High  
**Effort**: Large  

**Current State**: Manual CSS processing with 2.5MB across 39 files, custom `css-processor.html` partial

**Proposed State**:

- Consolidate CSS into logical bundles using Hugo Pipes
- Implement critical CSS extraction and inlining
- Use Hugo's built-in PostCSS processing
- Enable automatic asset optimization and fingerprinting

**Benefits**:

- Reduced build time (estimated 40-60% improvement)
- Better cache management with automatic fingerprinting
- Critical CSS for improved page load performance
- Tree-shaking and unused CSS removal
- Development/production environment optimization

**Implementation**:

1. Create `assets/css/main.scss` as primary stylesheet
2. Configure PostCSS with `postcss.config.js`
3. Implement critical CSS extraction for above-the-fold content
4. Replace current asset processing with Hugo Pipes
5. Set up environment-specific processing

```go
{{/* Modern Hugo Pipes implementation */}}
{{ $css := resources.Get "css/main.scss" | toCSS | postCSS }}
{{ if hugo.IsProduction }}
  {{ $css = $css | minify | fingerprint }}
{{ end }}
<link rel="stylesheet" href="{{ $css.RelPermalink }}">
```

### 3. Reorganize Template Architecture with Page Bundles

**Impact**: Medium  
**Effort**: Medium  

**Current State**: Complex partial structure with inconsistent organization and resource co-location

**Proposed State**:

- Implement Page Bundles for content with resources
- Reorganize partials into logical component hierarchy
- Create reusable component library
- Standardize template naming and structure

**Benefits**:

- Co-located content and resources
- Improved template discoverability
- Easier content management for authors
- Reduced template complexity
- Better SEO with resource optimization

**Implementation**:

1. Convert high-resource pages to Page Bundles
2. Reorganize `/themes/beaver/layouts/partials/` structure:

   ```
   partials/
   ├── components/         # Reusable UI components
   ├── layout/            # Layout-specific partials  
   ├── seo/               # SEO and meta partials
   └── data/              # Data processing partials
   ```

3. Create component library documentation
4. Implement consistent partial naming convention

### 4. Implement Template Caching Strategy

**Impact**: Medium  
**Effort**: Small  

**Current State**: Limited use of `partialCached`, potential for improved caching

**Proposed State**:

- Comprehensive template caching for static content
- Smart cache keys for dynamic content
- Performance monitoring and optimization

**Benefits**:

- Faster development server rebuilds
- Reduced memory usage during builds
- Improved developer workflow
- Better hot-reload performance

**Implementation**:

1. Audit current partial usage and identify caching opportunities
2. Implement `partialCached` for static partials:

   ```go
   {{ partialCached "components/header.html" . "header" }}
   {{ partialCached "seo/organization-schema.html" . "org-schema" }}
   ```

3. Create cache invalidation strategy for dynamic content
4. Monitor cache hit rates and effectiveness

### 5. Optimize Build Configuration and Development Workflow  

**Impact**: High  
**Effort**: Small  

**Current State**: Basic multi-environment configuration without development optimizations

**Proposed State**:

- Optimized development environment configuration
- Enhanced build performance settings
- Improved developer workflow with watch mode optimization

**Benefits**:

- Faster development builds (estimated 50% improvement)
- Better development experience with hot-reload
- Environment-specific optimizations
- Reduced resource usage during development

**Implementation**:

1. Enhance `config/development/hugo.toml`:

   ```toml
   [build]
     writeStats = false      # Skip build stats in dev
     useResourceCacheWhen = "always"
   
   [caches]
     [caches.assets]
       maxAge = "24h"        # Cache assets longer in dev
   ```

2. Implement development-specific asset processing
3. Configure watch mode optimizations
4. Add build performance monitoring

## Consequences

### Positive

- **Build Performance**: Estimated 40-60% build time reduction
- **Developer Productivity**: Improved development workflow and faster iterations
- **Maintainability**: Cleaner, more organized codebase following Hugo conventions
- **Scalability**: Better foundation for future feature additions
- **Performance**: Improved site loading performance through optimized asset delivery
- **Standards Compliance**: Alignment with Hugo community best practices

### Negative

- **Migration Effort**: Significant initial time investment for implementation
- **Learning Curve**: Team needs to learn Hugo Modules and modern Hugo practices
- **Potential Disruption**: Changes may temporarily impact current workflows
- **Testing Requirements**: Comprehensive testing needed during migration
- **Documentation Update**: Need to update development and deployment documentation

## Implementation Priority

### Phase 1: Quick Wins (Weeks 1-2)

1. **Template Caching Strategy** - Low effort, immediate performance gains
2. **Build Configuration Optimization** - Development workflow improvements

### Phase 2: Strategic Improvements (Weeks 3-6)

1. **Hugo Pipes Asset Pipeline** - Major performance improvement
2. **Template Architecture Reorganization** - Improved maintainability

### Phase 3: Long-term Excellence (Weeks 7-10)

1. **Hugo Modules Adoption** - Modern architecture foundation

## Validation and Metrics

### Success Criteria

- Build time reduction of 40-60%
- Development server restart time under 2 seconds
- Asset bundle size reduction of 30-50%
- Template complexity reduction (fewer deeply nested partials)
- Improved Lighthouse performance scores

### Monitoring

- Build performance benchmarking before/after each phase
- Developer workflow feedback collection
- Asset optimization metrics tracking
- Template rendering performance monitoring

## References

- [Hugo Modules Documentation](https://gohugo.io/hugo-modules/)
- [Hugo Pipes Asset Processing](https://gohugo.io/hugo-pipes/)
- [Hugo Template Caching](https://gohugo.io/functions/partialcached/)
- [Hugo Page Bundles](https://gohugo.io/content-management/page-bundles/)
- Package search findings from `gohugoio/hugo` golang_proxy registry
