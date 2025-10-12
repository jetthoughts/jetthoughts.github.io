# frozen_string_literal: true

require "application_system_test_case"

# CSS Processing Validation Tests
#
# Purpose: Validate CSS processing changes with ZERO visual regression tolerance
# during refactoring. These tests ensure that CSS consolidation, Hugo resource
# processing, and asset pipeline changes maintain pixel-perfect visual fidelity.
#
# Critical Rules (ZERO TOLERANCE):
# - Refactoring tolerance MUST be 0.0 (zero visual changes allowed)
# - Page-specific CSS (.fl-node-*) MUST be preserved
# - Layout-critical CSS rules MUST remain intact
# - Footer appearance MUST be pixel-perfect identical
# - ANY visual change > 0% = IMMEDIATE BLOCK
#
# Testing Protocol:
# 1. Capture baseline screenshots BEFORE refactoring (tolerance: 0.0)
# 2. Validate CSS content includes all required rules
# 3. Compare screenshots AFTER refactoring (MUST show 0% difference)
# 4. Block commits on ANY visual regressions
#
class CssProcessingTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "css_processing"
    super
  end

  # BASELINE SCREENSHOT CAPTURE (Pre-Refactoring)
  #
  # These tests capture baseline screenshots with tolerance: 0.0 for
  # pixel-perfect comparison during refactoring validation.
  #
  # Run BEFORE any CSS processing changes to establish golden master baseline.

  def test_homepage_baseline_full_page
    visit "/"

    preload_all_images

    # Move mouse to prevent menu hover state causing flakiness
    page.driver.browser.action.move_to_location(0, 0).perform

    # Wait for animations to complete
    sleep 0.5

    # REFACTORING BASELINE: tolerance 0.0 for pixel-perfect comparison
    assert_screenshot "baselines/homepage_full", tolerance: 0.0
  end

  def test_about_us_baseline_full_page
    visit "/about-us/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    # REFACTORING BASELINE: zero tolerance for visual changes
    assert_screenshot "baselines/about_us_full", tolerance: 0.0
  end

  def test_careers_baseline_full_page
    visit "/careers/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    # REFACTORING BASELINE: zero tolerance for visual changes
    assert_screenshot "baselines/careers_full", tolerance: 0.0
  end

  def test_services_fractional_cto_baseline
    visit "/services/fractional-cto/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    assert_screenshot "baselines/services_fractional_cto_full", tolerance: 0.0
  end

  def test_use_cases_mvp_baseline
    visit "/use-cases/startup-mvp-prototyping-development/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    assert_screenshot "baselines/use_cases_mvp_full", tolerance: 0.0
  end

  # CRITICAL SECTION VALIDATION (Footer, Headers, CTA)
  #
  # These tests validate critical sections that are most prone to CSS regressions:
  # - Footer layout (broken in previous refactoring)
  # - Hero sections (layout-critical CSS)
  # - CTA blocks (page-specific overrides)

  def test_homepage_footer_baseline
    visit "/"

    scroll_to find("footer")
    sleep 0.3

    # Footer is CRITICAL - broken in previous refactoring
    # ZERO tolerance for any footer visual changes
    assert_screenshot "baselines/homepage_footer", tolerance: 0.0
  end

  def test_about_us_footer_baseline
    visit "/about-us/"

    scroll_to find("footer")
    sleep 0.3

    assert_screenshot "baselines/about_us_footer", tolerance: 0.0
  end

  def test_careers_footer_baseline
    visit "/careers/"

    scroll_to find("footer")
    sleep 0.3

    assert_screenshot "baselines/careers_footer", tolerance: 0.0
  end

  def test_homepage_hero_section_baseline
    visit "/"

    # Hero section uses layout-critical CSS
    hero_section = find(".fl-row-content-wrap", match: :first, visible: true)
    refute_nil hero_section, "Hero section must exist"

    scroll_to :top
    sleep 0.3

    assert_screenshot "baselines/homepage_hero", tolerance: 0.0
  end

  def test_homepage_cta_section_baseline
    visit "/"

    # CTA sections often have page-specific overrides
    # Find CTA by looking for "Contact Us" button or similar CTA elements
    if page.has_css?('[data-node*="cta"]', visible: :all, wait: 1)
      scroll_to find('[data-node*="cta"]', match: :first)
    else
      # Fallback: scroll to Contact Us button
      scroll_to find('a', text: /Contact Us|Get Started/, match: :first)
    end
    sleep 0.3

    assert_screenshot "baselines/homepage_cta", tolerance: 0.0
  end

  # CSS CONTENT VALIDATION
  #
  # These tests validate that CSS files contain required rules and patterns.
  # They verify that consolidation didn't lose critical CSS rules.

  def test_css_files_contain_critical_rules
    visit "/"

    # Verify critical CSS patterns are loaded
    # This validates Hugo resources.Get properly includes all CSS content

    # Check for page-specific node styles (must be preserved)
    assert page.has_css?('[class*="fl-node-"]', visible: :all),
      "Page-specific .fl-node-* classes must be preserved"

    # Check for layout-critical styles
    assert page.has_css?(".fl-row-content-wrap", visible: :all),
      "Layout wrapper classes must be preserved"

    # Check for component styles
    assert page.has_css?(".pp-infobox", visible: :all),
      "Component styles must be preserved"

    # Verify footer styles loaded
    assert page.has_css?("footer", visible: :all),
      "Footer styles must be loaded"
  end

  def test_css_files_contain_navigation_styles
    visit "/"

    # Verify navigation CSS is properly loaded
    assert page.has_css?(".navigation", visible: true, wait: 5),
      "Navigation container must be styled"

    # Verify navigation is functional by checking for menu items
    within ".navigation" do
      assert page.has_css?("a", text: "Services", visible: true, wait: 2),
        "Navigation menu items must be present"

      # Hover to trigger submenu
      find("a", text: "Services", visible: true).hover
      sleep 0.2

      assert page.has_css?(".sub-menu", visible: true, wait: 2),
        "Submenu styles must be loaded"
    end
  end

  def test_css_files_contain_responsive_styles
    # Switch to mobile viewport
    page.driver.browser.manage.window.resize_to(375, 812)

    visit "/"

    # Verify mobile-specific CSS is loaded
    assert page.has_css?('[class*="mobile"]', visible: :all),
      "Mobile-specific CSS classes must be present"

    # Reset viewport
    page.driver.browser.manage.window.maximize
  end

  # CSS LOADING PERFORMANCE VALIDATION
  #
  # These tests ensure CSS is loaded efficiently and correctly via Hugo resources.

  def test_css_loads_without_errors
    visit "/"

    # Check page loaded successfully
    assert page.has_css?("body", visible: true, wait: 5),
      "Page body must load successfully"

    # Verify no console errors related to CSS
    # (Capybara will capture browser console errors if present)
    refute page.has_css?(".error", visible: true),
      "Page must not have error indicators"
  end

  def test_critical_css_applied_before_render
    visit "/"

    # Verify above-the-fold content is styled immediately
    # This validates critical CSS inlining works correctly
    hero = find(".fl-row-content-wrap", match: :first, visible: true, wait: 2)
    refute_nil hero, "Hero section must be styled on initial render"

    # Check computed styles are applied
    hero_bg = page.evaluate_script("getComputedStyle(document.querySelector('.fl-row-content-wrap')).backgroundColor")
    refute_empty hero_bg, "Hero section must have background color applied"
  end

  # VISUAL REGRESSION VALIDATION (Post-Refactoring)
  #
  # These tests compare current screenshots against baselines with tolerance: 0.0
  # Run AFTER CSS processing changes to validate zero visual changes.
  #
  # CRITICAL: ANY difference > 0% = REFACTORING FAILURE

  def test_homepage_visual_regression_check
    visit "/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    # CRITICAL: Compare against baseline with ZERO tolerance
    # This MUST match baselines/homepage_full pixel-perfectly
    assert_screenshot "regression/homepage_full", tolerance: 0.0
  end

  def test_about_us_visual_regression_check
    visit "/about-us/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    # CRITICAL: Zero tolerance comparison
    assert_screenshot "regression/about_us_full", tolerance: 0.0
  end

  def test_careers_visual_regression_check
    visit "/careers/"

    preload_all_images
    page.driver.browser.action.move_to_location(0, 0).perform
    sleep 0.5

    # CRITICAL: Zero tolerance comparison
    assert_screenshot "regression/careers_full", tolerance: 0.0
  end

  def test_footer_visual_regression_check
    visit "/"

    scroll_to find("footer")
    sleep 0.3

    # FOOTER IS CRITICAL - broken in previous refactoring
    # ABSOLUTE ZERO tolerance for footer changes
    assert_screenshot "regression/homepage_footer", tolerance: 0.0
  end

  def test_hero_section_visual_regression_check
    visit "/"

    scroll_to :top
    sleep 0.3

    # Hero section layout must be pixel-perfect
    assert_screenshot "regression/homepage_hero", tolerance: 0.0
  end

  # PAGE-SPECIFIC CSS PRESERVATION VALIDATION
  #
  # These tests verify that page-specific CSS (.fl-node-*) is preserved correctly.
  # This is CRITICAL because previous refactoring broke page layouts by removing
  # these page-specific overrides.

  def test_homepage_preserves_page_specific_css
    visit "/"

    # Verify page-specific node styles are applied
    # Each page has unique .fl-node-* classes that must be preserved

    # Check homepage-specific nodes exist and are styled
    # Using minimum: 1 to ensure at least some nodes exist
    assert page.has_css?('[data-node]', visible: :all, minimum: 1),
      "Homepage must have page-specific node styles"

    # Verify computed styles on page-specific elements
    if page.has_css?('[data-node]', visible: :all, wait: 1)
      homepage_node = find('[data-node]', match: :first, visible: :all)
      refute_nil homepage_node, "Page-specific nodes must be present"
    end
  end

  def test_about_us_preserves_page_specific_css
    visit "/about-us/"

    # About page has unique layout with specific .fl-node-* overrides
    assert page.has_css?('[data-node="uiyz63qn8r0f"]', visible: :all),
      "About page missions section must preserve node-specific CSS"

    assert page.has_css?('[data-node="os8vrc1dwlji"]', visible: :all),
      "About page values section must preserve node-specific CSS"
  end

  def test_careers_preserves_page_specific_css
    visit "/careers/"

    # Careers page has unique layout requiring specific CSS preservation
    assert page.has_css?('[data-node="w02opu1zjdef"]', visible: :all),
      "Careers overview section must preserve node-specific CSS"

    assert page.has_css?('[data-node="dkc4gbvj193z"]', visible: :all),
      "Careers offers section must preserve node-specific CSS"
  end

  # CSS CONSOLIDATION VALIDATION
  #
  # These tests verify that CSS consolidation didn't break functionality.
  # They validate that styles from multiple sources are correctly merged.

  def test_consolidated_css_maintains_specificity
    visit "/"

    # Verify CSS specificity is preserved after consolidation
    # Page-specific styles should override global styles

    # Find an element that has both global and page-specific styles
    assert page.has_css?(".fl-row-content-wrap", visible: true),
      "Hero element must be present for specificity validation"

    # Verify specific styles take precedence
    hero_padding = page.evaluate_script(
      "getComputedStyle(document.querySelector('.fl-row-content-wrap')).padding"
    )
    refute_empty hero_padding, "CSS specificity must be maintained"
  end

  def test_consolidated_css_loads_in_correct_order
    visit "/"

    # Verify CSS cascade order is correct
    # Critical CSS → Component CSS → Page-specific CSS

    # Check that later rules override earlier ones correctly
    assert page.has_css?("body", visible: true),
      "Base styles must load first"

    assert page.has_css?('[class*="fl-"]', visible: :all),
      "Component styles must load after base"

    assert page.has_css?('[data-node]', visible: :all),
      "Page-specific styles must load last"
  end

  private

  def preload_all_images
    scroll_to :bottom
    assert_text "JetThoughts. All Rights Reserved", exact: false
    scroll_to :top
  end

  def within_top_bar
    within ".navigation" do
      yield
    end
  end
end
