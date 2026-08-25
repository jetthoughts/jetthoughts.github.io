require "snap_diff/integrations/minitest"
require "snap_diff/reporters/html"

SnapDiff.config.save_path = "test/fixtures/screenshots"

# Green runs leave the prior red report; drop it up front.
File.delete("test/fixtures/screenshots/snap_diff_report.html") if File.exist?("test/fixtures/screenshots/snap_diff_report.html")
SnapDiff.config.add_os_path = true
SnapDiff.config.window_size = nil
SnapDiff.config.stability_time_limit = ENV.fetch("SCREENSHOT_STABILITY_TIME", "0.1").to_f
SnapDiff.config.disable_animations = true
SnapDiff.config.root = Dir.pwd

# Driver knob removed in 2.1; :auto = vips.
SnapDiff.config.perceptual_threshold = 2.0
SnapDiff.config.delayed = true

# Missing baselines fail; a broken git once passed silently (.okf/build/test-gates.md).
SnapDiff.config.record = :none

if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  # Bulk re-record; gem refuses :all under CI (test.yml unsets it).
  SnapDiff.config.record = :all
end
