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
end
