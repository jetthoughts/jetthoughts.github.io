require "capybara_screenshot_diff/minitest"

Capybara::Screenshot.save_path = "test/fixtures/screenshots"
Capybara::Screenshot.add_os_path = true
Capybara::Screenshot.window_size = nil
Capybara::Screenshot.stability_time_limit = 0.25
Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.delayed = false
Capybara::Screenshot::Diff.tolerance = 0.005
Capybara.default_max_wait_time = 5

Capybara::Screenshot.root = Dir.pwd
