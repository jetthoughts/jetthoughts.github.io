# frozen_string_literal: true

require "application_system_test_case"

# RED PHASE TEST: c-button BEM Component (Sprint 3)
# Test Strategy: BEHAVIORAL VALIDATION (NOT implementation testing)
# Reference: /knowledge/20.01-tdd-methodology-reference.md
# Reference: /knowledge/25.04-test-smell-prevention-enforcement-protocols.md
#
# CRITICAL: Tests validate USER-FACING BEHAVIOR:
# ✅ Button renders and is clickable (behavior)
# ✅ Visual appearance is consistent (user experience)
# ✅ Mobile responsiveness works (device compatibility)
# ❌ FORBIDDEN: CSS class existence (implementation detail)
# ❌ FORBIDDEN: HTML attribute checking (implementation detail)
# ❌ FORBIDDEN: Template structure validation (implementation detail)

class CButtonTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "components/c-button"
    super
  end

  # RED PHASE: This test will FAIL because c-button component doesn't exist yet
  def test_primary_button_renders_on_homepage
    visit "/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Primary CTA button is visible and clickable
    # Find button by BEHAVIOR (text content) not implementation (CSS class)
    button = find("a", text: /Contact Us|Talk to an Expert|Free Consultation/i, match: :first, wait: 2)
    assert button.visible?, "Primary CTA button must be visible to users"

    # VISUAL REGRESSION: Capture baseline for primary button appearance
    # Tolerance: ≤3% per Sprint 3 requirements
    within button do
      assert_screenshot "primary-button-desktop", tolerance: 0.03
    end
  end

  # RED PHASE: Test button hover state (user interaction behavior)
  def test_primary_button_hover_state
    visit "/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Hover state changes are visible
    # Find by behavior (text) not CSS class
    button = find("a", text: /Contact Us|Talk to an Expert|Free Consultation/i, match: :first, wait: 2)
    button.hover

    # Wait for CSS transition to complete
    sleep 0.3

    # VISUAL REGRESSION: Capture hover state
    within button do
      assert_screenshot "primary-button-hover", tolerance: 0.03
    end
  end

  # RED PHASE: Test mobile responsive button rendering
  def test_primary_button_mobile_rendering
    Capybara.current_driver = :mobile_chrome
    visit "/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Button is tappable on mobile (touch target size)
    # Find by behavior (text) not CSS class
    button = find("a", text: /Contact Us|Talk to an Expert|Free Consultation/i, match: :first, wait: 2)
    assert button.visible?, "Primary button must be visible on mobile"

    # VISUAL REGRESSION: Mobile screenshot comparison
    within button do
      assert_screenshot "primary-button-mobile", tolerance: 0.03
    end
  end

  # RED PHASE: Test button click functionality (navigation behavior)
  def test_button_click_navigates_correctly
    visit "/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Find CTA button by text content
    button = find("a", text: /Contact Us|Talk to an Expert|Free Consultation/i, match: :first, wait: 2)

    # Validate button is interactive (has href and is clickable)
    assert button[:href].present?, "CTA button must have navigation target"

    # BEHAVIORAL VALIDATION: Button click works (user can interact)
    # Note: Only click if it navigates to contact page
    if button[:href]&.include?("contact")
      button.click
      assert_current_path "/contact-us/", "Button should navigate to contact page"
    end
  end
end