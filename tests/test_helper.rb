# frozen_string_literal: true

require "minitest/autorun"
require "capybara/minitest"
require "capybara/dsl"
require "rack"
require "puma"

require_relative 'support/setup_capybara'
require_relative 'support/setup_snap_diff'
require_relative 'support/hugo_helpers'

Hugo.precompile(port: Capybara.current_session.server.port)

class ApplicationSystemTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
  include CapybaraScreenshotDiff::DSL
  include SnapDiffHelpers
end
