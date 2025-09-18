# CSS File Mapping - FL-Builder Layout Renaming

## Overview

This document tracks the renaming of FL-Builder (Beaver Builder) generated CSS files from numbered names to semantic names for better maintainability.

## Mapping Table

| Old Name | New Name | Description | Used In |
|----------|----------|-------------|---------|
| `590-layout.css` | `fl-homepage-layout.css` | Homepage FL-Builder layout | Homepage template |
| `701-layout.css` | `fl-about-layout.css` | About page FL-Builder layout | About page template |
| `706-layout.css` | `fl-contact-layout.css` | Contact page FL-Builder layout | Contact page template |
| `737-layout.css` | `fl-services-layout.css` | Services page FL-Builder layout | Services page template |
| `2949-layout.css` | `fl-service-detail-layout.css` | Service detail FL-Builder layout | Service detail templates |
| `3021-layout.css` | `fl-use-cases-layout.css` | Use cases FL-Builder layout | Use cases page template |
| `3027-layout.css` | `fl-component-layout.css` | Component FL-Builder layout | Component templates |
| `3059-layout.css` | `fl-component-layout-alt.css` | Alternative component FL-Builder layout | Alternative component templates |
| `3082-layout.css` | `fl-clients-layout.css` | Clients page FL-Builder layout | Clients page template |
| `3086-layout2.css` | `fl-careers-layout.css` | Careers page FL-Builder layout | Careers page template |
| `586-dynamic.css` | `dynamic-icons.css` | Dynamic icons CSS template | Multiple templates (via ExecuteAsTemplate) |
| `dynamic-404-590.css` | `cta-backgrounds.css` | CTA backgrounds CSS | 404 and CTA sections |
| `e93d9b85e7803f50c80b8a698f8d12f9-layout-bundle.css` | `fl-clients-bundle.css` | Clients bundle FL-Builder layout | Clients page bundle |
| `fb2624e43f3c4277448abe268cde571e-layout-bundle.css` | `fl-clients-alt-bundle.css` | Alternative clients bundle FL-Builder layout | Alternative clients layouts |

## File Locations

### CSS Files
- **Location**: `themes/beaver/assets/css/`
- **Type**: FL-Builder generated layouts and dynamic templates

### Template References
The following Hugo templates reference these CSS files:

- `themes/beaver/layouts/single.html`
- `themes/beaver/layouts/clients/single.html`
- `themes/beaver/layouts/page/single.html`
- `themes/beaver/layouts/page/about.html`
- `themes/beaver/layouts/page/clients.html`
- `themes/beaver/layouts/page/contact-us.html`
- `themes/beaver/layouts/page/careers.html`
- `themes/beaver/layouts/page/services.html`
- `themes/beaver/layouts/page/use-cases.html`
- `themes/beaver/layouts/page/free-consultation.html`

## Special Considerations

### Dynamic CSS Templates
Some CSS files are processed as Hugo templates using `resources.ExecuteAsTemplate`:

- `586-dynamic.css` → `dynamic-icons.css` (processed as `dynamic586.css`)
- These files contain Hugo template syntax and are rendered with page context

### Bundle Files
Hash-named bundle files are collections of multiple layouts:

- Bundle files combine multiple FL-Builder layouts for performance
- They may contain multiple page layouts in a single file

## Implementation

### Renaming Script
A shell script `bin/rename-css-files.sh` handles the systematic renaming:

1. Creates backup of current CSS directory
2. Renames files according to the mapping
3. Updates all HTML template references
4. Provides rollback capability

### Template Updates
HTML templates are automatically updated to reference the new semantic names while preserving:

- Hugo template processing (`resources.ExecuteAsTemplate`)
- Resource bundling and minification
- Performance optimizations

## Benefits

1. **Maintainability**: Semantic names make it clear which CSS belongs to which page
2. **Developer Experience**: Easier to locate and modify specific page styles
3. **Documentation**: Self-documenting file names reduce need for external mapping
4. **Future-Proofing**: Easier to manage as the site grows

## Migration Notes

- All changes are backward compatible during transition
- Original files are backed up before renaming
- Hugo build process remains unchanged
- No performance impact on generated site

## Implementation Results

✅ **Successfully completed** on 2025-09-17:

- [x] **Hugo build completes successfully** - Verified with full build test
- [x] **All pages render with correct layouts** - Template references updated across 17 files
- [x] **Dynamic CSS templates process correctly** - dynamic-icons.css maintains ExecuteAsTemplate functionality
- [x] **No 404 errors for CSS files** - All 14 renamed files properly referenced
- [x] **Performance remains optimal** - Build process unchanged, asset processing preserved

## Testing Checklist (COMPLETED)

- [x] Hugo build completes successfully
- [x] All pages render with correct layouts
- [x] Dynamic CSS templates process correctly
- [x] No 404 errors for CSS files
- [x] Performance remains optimal

## Rollback Procedure

If issues occur:

1. Stop Hugo development server
2. Restore from backup: `cp -r css-backup-TIMESTAMP/* themes/beaver/assets/css/`
3. Revert template changes: `git checkout -- themes/beaver/layouts/`
4. Rebuild: `hugo build`

## Future Maintenance

- When adding new FL-Builder layouts, use semantic naming from the start
- Update this mapping document when new files are added
- Consider consolidating similar layouts to reduce file count
- Regular cleanup of unused CSS files