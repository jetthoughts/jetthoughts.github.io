# frozen_string_literal: true

require "application_system_test_case"

# Phase 2 Sprint 7: Test Usecase Page - BEM Migration Validation
class TestUsecasePageTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    screenshot_section "test-pages/usecase"
    super
  end

  def test_usecase_page_renders_correctly
    visit "/test-usecase-page/", buildDrafts: true
    preload_all_images

    assert_selector ".c-hero-section", minimum: 1, wait: 2
    assert_screenshot "test-usecase-full-page", tolerance: 0.03
  end

  def test_usecase_components_visible
    visit "/test-usecase-page/", buildDrafts: true
    preload_all_images

    assert_selector ".c-content-section", minimum: 1, wait: 2
    assert_selector ".c-content-block", minimum: 1, wait: 2
  end
end
