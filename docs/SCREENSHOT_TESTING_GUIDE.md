# Screenshot Testing Guide

This guide explains how to use the screenshot testing functionality that has been implemented for visual regression testing.

## Overview

The screenshot testing system uses Capybara Screenshot Diff to capture and compare visual states of web pages, ensuring that UI changes don't introduce unintended visual regressions.

## Available Screenshot Assertion Methods

### `assert_stable_screenshot(name, **options)`
**Use for**: Standard UI components and content
- **Wait time**: 3 seconds for asset loading
- **Default tolerance**: 1.5%
- **Features**: Animation disabling, asset loading verification

```ruby
def test_simple_page
  visit "/about-us/"
  assert_stable_screenshot "about_us"
end
```

### `assert_quick_screenshot(name, **options)`
**Use for**: Static content that doesn't need loading time
- **Wait time**: None
- **Default tolerance**: 1%
- **Features**: No preparation, fastest option

```ruby
def test_static_page
  visit "/404.html"
  assert_quick_screenshot "404"
end
```

### `assert_stable_problematic_screenshot(name, **options)`
**Use for**: Complex content with animations or dynamic elements
- **Wait time**: 5 seconds for asset loading
- **Default tolerance**: 2.5%
- **Features**: Extended stability buffer, higher tolerance

```ruby
def test_dynamic_content
  visit "/"
  assert_stable_problematic_screenshot "homepage"
end
```

### `assert_cta_screenshot(name, **options)`
**Use for**: Call-to-action sections with dynamic content
- **Wait time**: 4 seconds for asset loading
- **Default tolerance**: 2%
- **Features**: Optimized for CTA elements

```ruby
def test_cta_section
  visit "/"
  scroll_to find("#cta-contact_us")
  assert_cta_screenshot "homepage/_cta-contact_us"
end
```

## Screenshot Organization

The screenshot system automatically organizes screenshots into sections using the `screenshot_section` method:

```ruby
class DesktopSiteTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"  # All screenshots will be prefixed with "desktop/"
    super
  end
end
```

This creates screenshots in paths like: `test/fixtures/screenshots/macos/desktop/homepage.png`

## Creating Screenshot Baselines

To create new screenshot baselines (first time or after intentional UI changes):

```bash
# Create baselines for all tests
FORCE_SCREENSHOT_UPDATE=true PRECOMPILED_ASSETS=true bin/test

# Create baseline for specific test
FORCE_SCREENSHOT_UPDATE=true PRECOMPILED_ASSETS=true bin/test test/system/desktop_site_test.rb -n test_homepage

# Create baselines for specific test file
FORCE_SCREENSHOT_UPDATE=true PRECOMPILED_ASSETS=true bin/test test/system/desktop_site_test.rb
```

## Running Screenshot Tests

```bash
# Run all screenshot tests (comparison mode)
PRECOMPILED_ASSETS=true bin/test

# Run specific test file
PRECOMPILED_ASSETS=true bin/test test/system/desktop_site_test.rb

# Run specific test
PRECOMPILED_ASSETS=true bin/test test/system/desktop_site_test.rb -n test_homepage
```

## Directory Structure

```
test/fixtures/screenshots/
├── macos/                  # OS-specific screenshots
│   ├── desktop/           # Desktop screenshots
│   │   ├── homepage.png   # Baseline screenshot
│   │   ├── 404.png
│   │   └── clients/
│   └── mobile/            # Mobile screenshots
└── linux/                # Linux screenshots (CI)
```

## Test Features

### Asset Loading Verification
All screenshot methods automatically wait for:
- Images to load completely
- Stylesheets to be available
- Page ready state completion

### Animation Disabling
Screenshots automatically disable CSS animations and transitions for consistent captures:
- `animation-duration: 0s !important`
- `transition-duration: 0s !important`

### Scroll and Wait
Helper method for scrolling to elements:
```ruby
scroll_to find("#section-id")        # Scroll to element
scroll_to :bottom                     # Scroll to bottom
```

## Error Handling and Diff Generation

When screenshots don't match, the system generates:
- `.diff.png` - Visual diff highlighting changes
- `.heatmap.diff.png` - Heatmap showing difference intensity
- Console output with difference percentage and affected area

## Configuration Options

### Environment Variables
- `FORCE_SCREENSHOT_UPDATE=true` - Create/update baselines
- `SCREENSHOT_TOLERANCE=0.02` - Override tolerance (2%)
- `SCREENSHOT_STABILITY_TIME=3.0` - Override stability wait time

### Test Options
```ruby
assert_stable_screenshot "name", 
  tolerance: 0.02,           # Custom tolerance
  skip_area: [".dynamic"],   # Skip dynamic areas
  wait: 5                    # Custom wait time
```

## Best Practices

1. **Use appropriate assertion methods** based on content type
2. **Scroll to sections** before taking screenshots to ensure visibility
3. **Use descriptive names** like "homepage/_section" for organization
4. **Update baselines intentionally** using `FORCE_SCREENSHOT_UPDATE=true`
5. **Review diff images** when tests fail to understand changes
6. **Test on both desktop and mobile** for comprehensive coverage

## Troubleshooting

### Tests fail with "Element not found"
- Check if the page structure has changed
- Verify elements exist with proper IDs/classes
- Use browser dev tools to inspect the actual DOM

### Screenshots show differences but look the same
- Check if there are subtle font rendering differences
- Consider increasing tolerance for the specific test
- Review the generated diff images for actual changes

### Tests are flaky (sometimes pass, sometimes fail)
- Use `assert_stable_problematic_screenshot` instead of `assert_stable_screenshot`
- Increase wait time with the `:wait` option
- Add `skip_area` for dynamic content that changes frequently

## Example Complete Test

```ruby
class DesktopSiteTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "desktop"
    super
  end

  def test_homepage_sections
    visit "/"
    scroll_to :bottom # Preload all images
    
    sections = %w[services technologies clients testimonials cta-contact_us]
    
    sections.each do |section_id|
      scroll_to find("##{section_id}")
      
      case section_id
      when "testimonials"
        assert_stable_problematic_screenshot "homepage/_#{section_id}"
      when "cta-contact_us"
        assert_cta_screenshot "homepage/_#{section_id}"
      else
        assert_stable_screenshot "homepage/_#{section_id}"
      end
    end
  end
end
```

This creates a comprehensive visual regression testing suite that catches unintended UI changes while being flexible enough to handle dynamic content appropriately.