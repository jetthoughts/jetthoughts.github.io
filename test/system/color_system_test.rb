# frozen_string_literal: true

require "application_system_test_case"

class ColorSystemTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "color_system"
    super
  end

  def test_color_system_variables_applied
    visit "/"

    # Test that CSS custom properties are defined and working
    assert page.has_css?("body", visible: false), "Body element should exist"

    # Validate text color is applied via CSS custom property
    body_color = page.evaluate_script("getComputedStyle(document.body).color")
    assert_equal "rgb(18, 18, 18)", body_color, "Body should use --jt-text-color variable"

    # Test heading color inheritance
    if page.has_css?("h1, h2, h3", visible: false)
      heading_color = page.evaluate_script("getComputedStyle(document.querySelector('h1, h2, h3')).color")
      assert_equal "rgb(18, 18, 18)", heading_color, "Headings should use --jt-text-color variable"
    end
  end

  def test_primary_color_system_ready
    visit "/"

    # Test that primary color custom property is defined
    primary_color = page.evaluate_script("getComputedStyle(document.documentElement).getPropertyValue('--jt-primary-color').trim()")
    assert_equal "#1a8cff", primary_color, "Primary color custom property should be defined"
  end
end