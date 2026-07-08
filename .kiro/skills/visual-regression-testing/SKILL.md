# Visual Regression Testing Skill
#
# Reusable visual regression testing protocol for Hugo static sites.

## Overview
Screenshot comparison-based visual testing using capybara-screenshot-diff.
Blocks commits on any visual regression during refactoring.

## Protocol
1. Capture baseline screenshots BEFORE changes
2. Make CSS/HTML changes
3. Capture comparison screenshots AFTER changes
4. Compare with tolerance:
   - 0.0 for refactoring (zero visual changes)
   - ≤0.03 for new features only
5. Block commit on any difference > tolerance

## Test Pattern
```ruby
def test_hero_section_visual_consistency
  visit "/services/fractional-cto/"
  screenshot_path = take_screenshot("fractional_cto_hero")
  assert_visual_match(screenshot_path, "baseline/fractional_cto_hero.png",
                      tolerance: 0.03)
end
```

## Prohibited Patterns (ZERO TOLERANCE)
- CSS class existence testing
- HTML structure counting
- Framework-generated selector usage
- Method existence testing

## Commands
- `bin/test` — visual regression (macOS)
- `bin/dtest` — visual regression (Linux/Docker, CI parity)
- BOTH must pass before commit for HTML/CSS changes

## Full Documentation
.apm/instructions/tdd-enforcement.instructions.md
docs/60.03-tdd-quality-enforcement.md
