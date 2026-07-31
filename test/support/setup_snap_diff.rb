# Screenshot Testing Configuration
#
# Environment Variables:
# - SCREENSHOT_STABILITY_TIME: Override stability wait time (default: 0.1s)
# - FORCE_SCREENSHOT_UPDATE: Set to 'true' to regenerate all baselines
#

require "capybara_screenshot_diff/minitest"
require "capybara_screenshot_diff/reporters/html"

Capybara::Screenshot.save_path = "test/fixtures/screenshots"
Capybara::Screenshot.add_os_path = true
Capybara::Screenshot.window_size = nil
Capybara::Screenshot.stability_time_limit = ENV.fetch("SCREENSHOT_STABILITY_TIME", "0.1").to_f
Capybara::Screenshot.disable_animations = true
Capybara::Screenshot.root = Dir.pwd

Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.perceptual_threshold = 2.0
Capybara::Screenshot::Diff.delayed = true

if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  Capybara::Screenshot::Diff.fail_on_difference = false
  # Record mode must be able to create FIRST baselines for new pages: with
  # ENV["CI"] set, snap_diff's fail_if_new defaults to hard-error, which made
  # the CI re-record run fail on pages added since the last recording
  # (2026-07-31: vibe_code_rescue had no linux/ baseline yet).
  Capybara::Screenshot::Diff.fail_if_new = false
end
