# Screenshot Testing Configuration
#
# Environment Variables:
# - SCREENSHOT_STABILITY_TIME: Override stability wait time (default: 0.1s)
# - FORCE_SCREENSHOT_UPDATE: Set to 'true' to regenerate all baselines
#

require "capybara_screenshot_diff/minitest"
require "capybara_screenshot_diff/reporters/html"

Capybara::Screenshot.save_path = "test/fixtures/screenshots"

# The HTML reporter only writes when a run HAS failures, so a green run would
# otherwise leave the previous red run's report on disk - reviewing it shows
# diffs that no longer exist. Drop it up front; every entry point (bin/test,
# bin/qtest, bin/dtest, rake test:*) loads this file.
File.delete("test/fixtures/screenshots/snap_diff_report.html") if File.exist?("test/fixtures/screenshots/snap_diff_report.html")
Capybara::Screenshot.add_os_path = true
Capybara::Screenshot.window_size = nil
Capybara::Screenshot.stability_time_limit = ENV.fetch("SCREENSHOT_STABILITY_TIME", "0.1").to_f
Capybara::Screenshot.disable_animations = true
Capybara::Screenshot.root = Dir.pwd

Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.perceptual_threshold = 2.0
Capybara::Screenshot::Diff.delayed = true

# A screenshot whose baseline cannot be RETRIEVED must fail, not pass. The gem
# resolves baselines with `git show HEAD:<path>`, so anything that breaks git
# silently turns the whole visual gate into a no-op: captures are written,
# nothing is compared, every run is green.
#
# Measured 2026-08-22: run from a git WORKTREE, `.git` is a file pointing at an
# absolute host path under the main repo, which the container does not mount -
# so git inside it reports "not a git repository", every baseline lookup
# returns nothing, and a contact page with a `background: red !important` body
# (difference_level 0.68) passed with 0 failures. Defaulting fail_if_new to
# false outside CI is what made that invisible.
#
# Consequence: a genuinely NEW page fails its first run until recorded. That is
# the same run-to-fail -> inspect -> commit flow .okf/build/test-gates.md
# already documents for re-records; record mode below still bypasses it.
Capybara::Screenshot::Diff.fail_if_new = true

if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  Capybara::Screenshot::Diff.fail_on_difference = false
  # Record mode must be able to create FIRST baselines for new pages: with
  # ENV["CI"] set, snap_diff's fail_if_new defaults to hard-error, which made
  # the CI re-record run fail on pages added since the last recording
  # (2026-07-31: vibe_code_rescue had no linux/ baseline yet).
  Capybara::Screenshot::Diff.fail_if_new = false
end
