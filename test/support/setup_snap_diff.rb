# Screenshot Testing Configuration
#
# Environment Variables:
# - SCREENSHOT_STABILITY_TIME: Override stability wait time (default: 0.1s)
# - FORCE_SCREENSHOT_UPDATE: Set to 'true' to regenerate all baselines
#

require "snap_diff/integrations/minitest"
require "snap_diff/reporters/html"

SnapDiff.config.save_path = "test/fixtures/screenshots"

# The HTML reporter only writes when a run HAS failures, so a green run would
# otherwise leave the previous red run's report on disk - reviewing it shows
# diffs that no longer exist. Drop it up front; every entry point (bin/test,
# bin/qtest, bin/dtest, rake test:*) loads this file.
File.delete("test/fixtures/screenshots/snap_diff_report.html") if File.exist?("test/fixtures/screenshots/snap_diff_report.html")
SnapDiff.config.add_os_path = true
SnapDiff.config.window_size = nil
SnapDiff.config.stability_time_limit = ENV.fetch("SCREENSHOT_STABILITY_TIME", "0.1").to_f
SnapDiff.config.disable_animations = true
SnapDiff.config.root = Dir.pwd

# No driver line: 2.1 removes the knob; :auto resolves to vips.
SnapDiff.config.perceptual_threshold = 2.0
SnapDiff.config.delayed = true

# Missing baselines must FAIL: record = :none (2.0 spelling of fail_if_new =
# true). Anything that breaks git would otherwise pass green silently
# (measured 2026-08-22, git worktree - see .okf/build/test-gates.md).
SnapDiff.config.record = :none

if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  # Bulk re-record; gem refuses :all under CI - test.yml unsets it for this step.
  SnapDiff.config.record = :all
end
