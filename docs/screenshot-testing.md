# Screenshot Testing Guide

This project uses `capybara-screenshot-diff` for visual regression testing to ensure the website renders consistently across different environments.

## Overview

Screenshot tests capture images of web pages during system tests and compare them against baseline images to detect visual changes. This helps catch unintended UI regressions.

## Current Setup

- **Gem**: `capybara-screenshot-diff` v1.10.3+
- **Driver**: VIPS (for better performance)
- **Tolerance**: 0.5% (0.005)
- **Screenshots Location**: `test/fixtures/screenshots/`
- **OS-specific**: Screenshots are organized by OS (linux/macos)

## Common Issues

### Cross-Platform Differences

Screenshots taken on different operating systems (macOS vs Linux) will differ due to:
- Font rendering differences
- Browser rendering engine variations
- System UI differences

Our Docker-based CI runs on Linux, while developers typically use macOS, leading to screenshot mismatches.

## Updating Screenshot Baselines

When visual changes are intentional (design updates, content changes, etc.), you need to update the baseline screenshots.

### Method 1: Docker-based Update (Recommended)

Use the Docker environment to generate screenshots that match the CI environment:

```bash
# Update all screenshots
CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false bin/dtest

# Update specific test file
CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false bin/dtest test/system/desktop_site_test.rb
```

## Workflow for Updating Screenshots

1. **Make your UI changes**
2. **Run tests to see failures**: `bin/test test/system/`
3. **Review the differences**: Check if the changes are intentional
4. **Update baselines**: `CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false bin/dtest`
5. **Review changes**: `git diff test/fixtures/screenshots/`
6. **Commit updates**: `git add test/fixtures/screenshots/ && git commit -m "Update screenshot baselines"`

## Troubleshooting

### "No baseline screenshot found"

This happens when:
- New screenshot tests are added
- Screenshot names are changed
- OS-specific directories don't exist

**Solution**: Run the update script to generate initial baselines.

### "Screenshot differences detected"

This happens when:
- UI changes have been made
- Font rendering differs between environments
- Browser versions differ

**Solution**: Review if changes are intentional, then update baselines if appropriate.

### "Tests fail even after update"

This can happen when:
- Screenshots are unstable (timing issues)
- Dynamic content changes between runs
- Network-dependent content loads inconsistently

**Solutions**:
- Increase `stability_time_limit` in test configuration
- Add `wait:` parameter to specific screenshot calls
- Use `skip_area` to exclude dynamic regions

## Configuration

### Test Configuration (test/support/setup_snap_diff.rb)

```ruby
Capybara::Screenshot::Diff.tolerance = 0.005  # 0.5% tolerance
Capybara::Screenshot::Diff.driver = :vips     # Fast comparison
Capybara::Screenshot.add_os_path = true       # Separate by OS
Capybara::Screenshot.stability_time_limit = 0.25  # Wait for stability
```

### Environment Variables

- `CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false`: Don't fail tests on differences

## Best Practices

1. **Update screenshots in Docker**: Use `bin/dtest-update-screenshots` for CI consistency
2. **Review changes carefully**: Always check `git diff` before committing
3. **Test both mobile and desktop**: Both test suites should be updated together
4. **Use descriptive commit messages**: Include what UI changes were made
5. **Handle dynamic content**: Use `skip_area` or mock time-dependent content

## Files Overview

- `bin/dtest`: Run tests in Docker
- `test/support/setup_snap_diff.rb`: Screenshot testing configuration
- `test/system/*_test.rb`: Screenshot test files

## Need Help?

If you encounter issues:
1. Check if your changes are intentional
2. Try the Docker-based update script
3. Review this documentation
4. Check the `capybara-screenshot-diff` (aka `snap_diff-capybara`) gem documentation
