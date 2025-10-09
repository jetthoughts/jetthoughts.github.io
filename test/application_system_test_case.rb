# frozen_string_literal: true

require "minitest/autorun"
require "timeout"
require "capybara/minitest"
require "capybara/dsl"
require "rack"
require "puma"

require "support/setup_capybara"
require "support/setup_snap_diff"
require "support/hugo_helpers"

if ENV["TEST_SERVER_PORT"]
  test_port = ENV.fetch("TEST_SERVER_PORT", "1314").to_i
  Capybara.server_port = test_port
end

hugo_builder = Hugo.instance
Capybara.app = hugo_builder.app

unless ENV["PRECOMPILED_ASSETS"]
  hugo_builder.precompile
end

module NavigationHelpers
  def within_top_bar(&block)
    within(".navigation", &block)
  end

  def visit_via_menu(menu_text, submenu_text = nil)
    within_top_bar do
      if submenu_text
        find("a", text: menu_text, visible: true, wait: 5).hover
        click_on submenu_text
      else
        click_on menu_text
      end
    end
  end
end

class ApplicationSystemTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
  include CapybaraScreenshotDiff::DSL
  include CapybaraScreenshotDiff::Minitest::Assertions
  include NavigationHelpers

  # Ruby hash-based configuration for screenshot sections
  SECTION_CONFIGS = {
    "cta" => {tolerance: 0.03},
    "cta-contact_us" => {tolerance: 0.03},
    "clients" => {tolerance: 0.03},
    "use-cases" => {tolerance: 0.03},
    "technologies" => {tolerance: 0.02},
    "testimonials" => {tolerance: 0.02},
    "why-us" => {tolerance: 0.02}
  }.freeze

  DEFAULT_SCREENSHOT_CONFIG = {tolerance: 0.03}.freeze

  private

  def preload_all_images
    scroll_to :bottom

    assert_text "JetThoughts. All Rights Reserved", exact: false

    scroll_to :top
  end

  # Unified screenshot assertion with Ruby hash-based configuration
  def assert_screenshot(name, **options)
    has_css?("body", wait: options.delete(:wait) || 2)

    section_config = screenshot_config_for(name)
    final_options = section_config.merge(options)

    assert_matches_screenshot(name, **final_options)
  end

  def screenshot_config_for(name)
    section_key = extract_section_key(name)
    SECTION_CONFIGS.fetch(section_key, DEFAULT_SCREENSHOT_CONFIG)
  end

  def extract_section_key(name)
    name.to_s.split("/_").last || name.to_s.split("/").last
  end

  # Backward compatibility aliases - will be deprecated once all tests updated
  alias_method :assert_stable_screenshot, :assert_screenshot
  alias_method :assert_cta_screenshot, :assert_screenshot
  alias_method :assert_quick_screenshot, :assert_screenshot
end
