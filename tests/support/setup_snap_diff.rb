require "capybara_screenshot_diff/minitest"

Capybara::Screenshot.save_path = "tests/fixtures/screenshots"
Capybara::Screenshot.window_size = nil
Capybara::Screenshot.stability_time_limit = 0.25
Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.delayed = false
Capybara.default_max_wait_time = 5

module Rails
  def self.root
    File.expand_path("../../", __FILE__)
  end

  def self.application
    Capybara.app
  end
end

module SnapDiffHelpers
  def screenshot(*, **)
    super
  rescue CapybaraScreenshotDiff::ExpectationNotMet => e
    raise ::Minitest::Assertion, e.message
  end

  alias_method :assert_matches_screenshot, :screenshot

  def setup
    super
    if ::Capybara::Screenshot.window_size
      ::Capybara::Screenshot::BrowserHelpers.resize_to(::Capybara::Screenshot.window_size)
    end
  end

  def teardown
    super
    Capybara.reset_sessions!

    errors = verify_screenshots!(@test_screenshots)
    failures << ::Minitest::Assertion.new(errors.join("\n\n")) if errors && !errors.empty?
  end
end
