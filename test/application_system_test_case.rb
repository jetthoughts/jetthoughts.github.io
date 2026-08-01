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

# Every system-test run REWRITES the committed baseline PNGs in place
# (snap_diff design: working tree = candidate, git HEAD = baseline). Starting
# from dirty fixtures makes results unjudgeable and one `git add -A` away
# from committing corrupted baselines - so refuse to run until they are
# clean. Same guard bin/qtest has carried; this covers bin/test, bin/dtest,
# and every rake test task. Degrades to a no-op where git is unavailable.
#
# Scoped to the OS dir this run actually writes (the same Os.name snap_diff
# uses to build the path under add_os_path). The test container has git, so
# an unscoped glob let dirty macos/ baselines abort the linux/ leg - bin/dtest
# refusing to start on a Mac mid-review was never the intent.
unless ENV["ALLOW_DIRTY_SCREENSHOTS"]
  os_dir = "test/fixtures/screenshots/#{Capybara::Screenshot::Os.name}"
  dirty = `git status --porcelain #{os_dir} 2>/dev/null`.lines
  if dirty.any?
    warn "Screenshot fixtures are dirty (a previous run rewrote baselines):"
    dirty.first(10).each { |l| warn "  #{l.strip}" }
    warn "  ... and #{dirty.size - 10} more" if dirty.size > 10
    warn ""
    warn "Inspect diffs if a change was intentional, then either commit them"
    warn "or restore: bin/rake test:screenshots:reset"
    warn "(bypass once with ALLOW_DIRTY_SCREENSHOTS=1)"
    abort
  end
end

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
    "cta" => {tolerance: 0.02},
    "cta-contact_us" => {tolerance: 0.02},
    "clients" => {tolerance: 0.02},
    "use-cases" => {tolerance: 0.02},
    "technologies" => {tolerance: 0.02},
    "testimonials" => {tolerance: 0.02},
    "why-us" => {tolerance: 0.02}
  }.freeze

  DEFAULT_SCREENSHOT_CONFIG = {tolerance: 0.02}.freeze

  private

  def preload_all_images
    scroll_to :bottom

    assert_text "JetThoughts. All Rights Reserved", exact: false

    scroll_to :top
  end

  # Unified screenshot assertion with Ruby hash-based configuration
  def assert_screenshot(name, **options)
    has_css?("body", wait: options.delete(:wait) || 2)

    # Fonts settled before capture: a webfont swapping in mid-capture reflows
    # text bimodally (the "font-swap race" this suite otherwise masks with
    # skip_areas, 0.03 tolerances, and stability retries). fonts.ready
    # resolves instantly once fonts are cached, so warm sessions pay ~0.
    page.evaluate_async_script("var done = arguments[0]; document.fonts.ready.then(function() { done(true) })")

    section_config = screenshot_config_for(name)
    final_options = section_config.merge(options)

    # skip_area CSS selectors resolve via Capybara `all(sel, visible: true)`
    # INSIDE the gem, which waits default_max_wait_time (5s) for EVERY selector
    # with zero matches - `%w[picture img]` on an image-less page = 10s per
    # screenshot (measured; it was 44% of the whole suite). Selectors that do
    # match resolve instantly either way, so scope the implicit wait to 0 and
    # pin the capture wait explicitly (the stability loop needs a real one -
    # with wait=0 the gem rejects stability_time_limit > wait).
    final_options[:wait] ||= Capybara.default_max_wait_time
    Capybara.using_wait_time(0) do
      assert_matches_screenshot(name, **final_options)
    end
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
