# frozen_string_literal: true

require "minitest/autorun"
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

  # Enhanced screenshot assertion with optimized defaults and OS-specific handling
  #
  # @param name [String] Screenshot name/identifier
  # @param options [Hash] Override options for specific test cases
  # @option options [Float] :wait Wait time before taking screenshot (default: 3s)
  # @option options [Float] :stability_time_limit Time to wait for page stability (default: 1.0s)
  # @option options [Float] :tolerance Allowed difference percentage (default: 0.015 - 1.5%)
  # @option options [Array] :skip_area CSS selectors for areas to ignore
  # @option options [Boolean] :os_specific Use OS-specific tolerance adjustments
  #
  def assert_stable_screenshot(name, **options)
    # Default options optimized for stability
    defaults = {
      wait: 3,
      stability_time_limit: 1.0,
      tolerance: 0.015, # Slightly higher than global default for individual tests
      os_specific: true
    }
    
    # Apply OS-specific adjustments if enabled
    if options.fetch(:os_specific, true)
      case RbConfig::CONFIG['host_os']
      when /darwin/i # macOS
        defaults[:tolerance] *= 0.8  # macOS typically more consistent
        defaults[:stability_time_limit] *= 0.9
      when /linux/i
        defaults[:tolerance] *= 1.2  # Linux may have slight font rendering differences
        defaults[:stability_time_limit] *= 1.1
      when /mswin|mingw|cygwin/i # Windows
        defaults[:tolerance] *= 1.3  # Windows may have more rendering variations
        defaults[:stability_time_limit] *= 1.2
      end
    end
    
    # Merge user options with defaults
    screenshot_options = defaults.merge(options)
    screenshot_options.delete(:os_specific) # Remove internal option
    
    assert_matches_screenshot(name, **screenshot_options)
  end

  # Quick screenshot for static content that doesn't need stability waiting
  #
  # @param name [String] Screenshot name/identifier
  # @param options [Hash] Override options
  #
  def assert_quick_screenshot(name, **options)
    defaults = {
      wait: nil,
      stability_time_limit: nil,
      tolerance: 0.01
    }
    
    assert_matches_screenshot(name, **defaults.merge(options))
  end

  # Screenshot for problematic/flaky areas with higher tolerance and longer stability
  #
  # @param name [String] Screenshot name/identifier
  # @param options [Hash] Override options
  #
  def assert_stable_problematic_screenshot(name, **options)
    defaults = {
      wait: 5,
      stability_time_limit: 2.0,
      tolerance: 0.025, # 2.5% tolerance for problematic areas
      median_filter_window_size: 5 # Apply median filtering to reduce noise
    }
    
    assert_matches_screenshot(name, **defaults.merge(options))
  end
end
