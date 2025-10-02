# frozen_string_literal: true

require "application_system_test_case"

# RED PHASE TEST: Careers Page FL-node Cleanup (Sprint 6.X)
# Test Strategy: BEHAVIORAL VALIDATION (NOT implementation testing)
# Reference: /knowledge/20.01-tdd-methodology-reference.md
# Reference: /knowledge/25.04-test-smell-prevention-enforcement-protocols.md
#
# CRITICAL: Tests validate USER-FACING BEHAVIOR:
# ✅ Page sections render correctly (behavior)
# ✅ Visual appearance is consistent (user experience)
# ✅ Benefits cards display properly (user information)
# ❌ FORBIDDEN: FL-node class existence (implementation detail)
# ❌ FORBIDDEN: HTML attribute checking (implementation detail)
# ❌ FORBIDDEN: Template structure validation (implementation detail)

class CareersPageTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "pages/careers"
    super
  end

  # RED PHASE: Baseline test - validates current page renders correctly
  def test_careers_page_renders_all_sections
    visit "/careers/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Hero section is visible
    assert_selector ".c-hero-section", wait: 2
    assert_selector ".c-hero-section__heading", text: "Looking for a Team"

    # BEHAVIORAL VALIDATION: Benefits section renders
    assert_selector ".c-content-block__heading", text: "Why Work with Us?"

    # BEHAVIORAL VALIDATION: CTA button works
    assert_selector ".c-cta-block__button", minimum: 1

    # VISUAL REGRESSION: Full page baseline
    assert_screenshot "careers-page-full", tolerance: 0.03
  end

  # RED PHASE: Benefits section rendering (lines 97-107 - first FL-node cleanup target)
  def test_benefits_section_renders_correctly
    visit "/careers/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Benefits content section exists
    assert_selector ".c-content-section", wait: 2
    assert_selector ".c-hero-section__category", text: "BENEFITS"
    assert_selector ".c-content-block__heading", text: "Why Work with Us?"
    assert_selector ".c-content-block__text", text: "we love what we do"

    # VISUAL REGRESSION: Benefits section screenshot
    within first(".c-content-section") do
      assert_screenshot "benefits-section", tolerance: 0.03
    end
  end

  # RED PHASE: Spacer modules render correctly (lines 100, 188 - FL-node cleanup targets)
  def test_spacer_modules_create_proper_spacing
    visit "/careers/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Spacing between sections exists
    # We validate the EFFECT (spacing) not the IMPLEMENTATION (fl-node-h0tyqmkv4lcs)
    content_groups = all(".c-content-block__group")
    assert content_groups.count >= 2, "Multiple content groups should exist with spacing"

    # VISUAL REGRESSION: Spacing is visually consistent
    assert_screenshot "benefits-spacing", tolerance: 0.03
  end

  # RED PHASE: Feature cards (infoboxes) render correctly (lines 108-184)
  def test_feature_cards_render_correctly
    visit "/careers/"

    preload_all_images

    # BEHAVIORAL VALIDATION: All 6 benefit cards are visible
    feature_cards = [
      "People-Oriented",
      "Long-Term Focused",
      "Tight-Knit Team",
      "Flexible Environment",
      "Growth Beyond JetThoughts",
      "World-Class Training"
    ]

    feature_cards.each do |card_title|
      assert_selector ".pp-infobox-title", text: card_title, wait: 2
    end

    # VISUAL REGRESSION: Feature cards section
    within first(".fl-col-group-custom-width") do
      assert_screenshot "feature-cards-section", tolerance: 0.03
    end
  end

  # RED PHASE: Newsletter section renders (lines 419-478)
  def test_newsletter_section_renders
    visit "/careers/"

    preload_all_images

    # BEHAVIORAL VALIDATION: Newsletter form exists and is functional
    assert_selector ".jt-newsletter", wait: 2
    assert_selector "input[type='email']", wait: 2
    assert_selector "input[type='submit']", wait: 2

    # VISUAL REGRESSION: Newsletter section
    within ".jt-newsletter" do
      assert_screenshot "newsletter-section", tolerance: 0.03
    end
  end
end
