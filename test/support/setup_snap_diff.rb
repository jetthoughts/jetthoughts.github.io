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

# 2.0: no `driver` line - the knob is removed in 2.1 and warns in 2.0 (value
# blind, even `:vips`). With the `vips` gem installed, `:auto` resolves to the
# vips backend, which is the only backend 2.1 keeps.
SnapDiff.config.perceptual_threshold = 2.0
SnapDiff.config.delayed = true

# A screenshot whose baseline cannot be RETRIEVED must fail, not pass. The gem
# resolves baselines with `git show HEAD:<path>`, so anything that breaks git
# silently turns the whole visual gate into a no-op: captures are written,
# nothing is compared, every run is green.
#
# Measured 2026-08-22: run from a git WORKTREE, `.git` is a file pointing at an
# absolute host path under the main repo, which the container does not mount -
# so git inside it reports "not a git repository", every baseline lookup
# returns nothing, and a contact page with a `background: red !important` body
# (difference_level 0.68) passed with 0 failures. The 2.0 default (`:once`,
# record a missing baseline and compare the rest) is what made that invisible;
# `record = :none` restores the 1.x `fail_if_new = true` strictness: a missing
# baseline ALWAYS fails, at any time, CI or not.
#
# Consequence: a genuinely NEW page fails its first run until recorded. That is
# the same run-to-fail -> inspect -> commit flow .okf/build/test-gates.md
# already documents for re-records; record mode below still bypasses it.
SnapDiff.config.record = :none

if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  # record = :all re-records every screenshot and compares nothing - the 2.0
  # bulk-accept verb that replaces `fail_on_difference = false` + `fail_if_new
  # = false`. It must create FIRST baselines for new pages too (2026-07-31:
  # vibe_code_rescue had no linux/ baseline yet), which :all does. The gem
  # REFUSES `:all` under ENV["CI"] by design; the CI record dispatch unsets CI
  # on its step (test.yml) because there the human is the dispatch itself.
  SnapDiff.config.record = :all
end
