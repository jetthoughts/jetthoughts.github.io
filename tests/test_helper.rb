# frozen_string_literal: true

require "minitest/autorun"
require "capybara/minitest"
require "capybara/dsl"
require "capybara/cuprite"
require "rack"
require "puma"

require "capybara_screenshot_diff/minitest"

# Middleware to log requests
class RequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    puts "Received #{request.request_method} request for #{request.path}"
    @app.call(env)
  end
end

Capybara.app = Rack::Builder.new do
  use RequestLogger if ENV["DEBUG"]
  use Rack::Static,
    urls: [""],
    root: "public",
    index: "index.html",
    header_rules: [
      # Cache all static files in public caches (e.g. Rack::Cache)
      #  as well as in the browser
      [:all, {"cache-control" => "public, max-age=31536000"}],
      # Provide web fonts with cross-origin access-control-headers
      #  Firefox requires this when serving assets using a Content Delivery Network
      [:fonts, {"access-control-allow-origin" => "*"}]
    ]
  run Rack::Directory.new(File.expand_path("../../public", __FILE__))
end

Capybara.javascript_driver = :cuprite
Capybara.current_driver = Capybara.javascript_driver
Capybara.disable_animation = true

Capybara::Screenshot.save_path = "tests/fixtures/screenshots"
Capybara::Screenshot.window_size = nil
Capybara::Screenshot.stability_time_limit = 0.25
Capybara::Screenshot::Diff.driver = :vips
Capybara.default_max_wait_time = 1

system("hugo --minify --baseURL \"http://localhost:#{Capybara.current_session.server.port}\" --environment production", exception: true)

module Rails
  def self.root
    File.expand_path("../../", __FILE__)
  end

  def self.application
    Capybara.app
  end
end

class ApplicationSystemTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
  include CapybaraScreenshotDiff::DSL

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
