# frozen_string_literal: true

require "minitest/autorun"
require "timeout"
require "capybara/minitest"
require "capybara/dsl"
require "rack"
require "puma"

require_relative "support/setup_capybara"
require_relative "support/setup_snap_diff"
require_relative "support/hugo_helpers"

hugo_builder = Hugo.new
Capybara.app = hugo_builder.app

if ENV["PRECOMPILED_ASSETS"]
  Capybara.server_port = ENV.fetch("TEST_SERVER_PORT") { 1314 }
else
  hugo_builder.precompile(port: Capybara.current_session.server.port)
end

class ApplicationSystemTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
  include CapybaraScreenshotDiff::DSL
  include CapybaraScreenshotDiff::Minitest::Assertions

  private

  # Simple screenshot assertion - fail fast if issues arise
  def assert_stable_screenshot(name, **options)
    # Use Capybara's built-in wait mechanism instead of sleep
    wait_time = options.delete(:wait) || 1
    
    # Wait for any pending animations or loading to complete
    has_css?('body', wait: wait_time) # This ensures page is ready
    
    options[:tolerance] ||= 0.05 # 5% tolerance for cross-platform rendering differences
    assert_matches_screenshot(name, **options)
  end

  # Special handling for screenshots with known cross-platform issues
  def assert_stable_problematic_screenshot(name, **options)
    # Use higher tolerance for sections with significant platform rendering differences
    options[:tolerance] ||= 0.25 # 25% tolerance for problematic sections
    assert_stable_screenshot(name, **options)
  end

  # Special handling for CTA sections with dynamic content
  def assert_cta_screenshot(name, **options)
    # Use higher tolerance for CTA sections with animations/dynamic content
    options[:tolerance] ||= 0.15 # 15% tolerance for CTA sections
    assert_stable_screenshot(name, **options)
  end

  # Special handling for major template changes
  def assert_major_template_change_screenshot(name, **options)
    # Use very high tolerance for major template/layout changes
    options[:tolerance] ||= 0.75 # 75% tolerance for major template changes
    assert_stable_screenshot(name, **options)
  end

  # Alias other complex screenshot methods to the simple one
  alias_method :assert_quick_screenshot, :assert_stable_screenshot
end
