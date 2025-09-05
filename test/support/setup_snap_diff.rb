# Screenshot Testing Configuration
#
# Environment Variables for controlling screenshot behavior:
# - SCREENSHOT_TOLERANCE: Override global tolerance (default: 0.01 = 1%)
# - SCREENSHOT_STABILITY_TIME: Override stability wait time (default: 1.0s)
# - FORCE_SCREENSHOT_UPDATE: Set to 'true' to regenerate all baseline screenshots
# - CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE: Set to 'false' to update baselines
#
# Usage Examples:
# SCREENSHOT_TOLERANCE=0.02 bundle exec rake test           # 2% tolerance
# SCREENSHOT_STABILITY_TIME=2.0 bundle exec rake test       # 2s stability time
# FORCE_SCREENSHOT_UPDATE=true bundle exec rake test        # Regenerate baselines
#

require "capybara_screenshot_diff/minitest"

Capybara::Screenshot.save_path = "test/fixtures/screenshots"
Capybara::Screenshot.add_os_path = true
Capybara::Screenshot.window_size = nil

# Screenshot stability and tolerance settings
# 
# stability_time_limit: Time to wait for the page to be stable before taking screenshot
# Increased from 0.25s to 1.0s to reduce flakiness from animations/loading states
Capybara::Screenshot.stability_time_limit = ENV.fetch("SCREENSHOT_STABILITY_TIME", "1.0").to_f

# tolerance: Allowed difference percentage between baseline and current screenshot
# Increased from 0.005 (0.5%) to 0.01 (1%) to handle minor rendering differences
# across different environments and versions
Capybara::Screenshot::Diff.tolerance = ENV.fetch("SCREENSHOT_TOLERANCE", "0.01").to_f

Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.delayed = false
Capybara.default_max_wait_time = 5

# Environment variable controls for screenshot behavior
# 
# CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false: Useful for updating screenshot baselines
if ENV["CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE"] == "false"
  Capybara::Screenshot::Diff.fail_on_difference = false
end

# FORCE_SCREENSHOT_UPDATE=true: Regenerate all baseline screenshots
if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  Capybara::Screenshot::Diff.fail_on_difference = false
end

Capybara::Screenshot.root = Dir.pwd
