# frozen_string_literal: true

# Which tolerance a screenshot assertion gets, by name.
#
# Lives apart from ApplicationSystemTestCase so it can be unit-tested without
# booting Hugo, Capybara or the dirty-fixtures guard that file runs on load.
module ScreenshotSectionConfig
  # TEMPORARY SHIELD, not configuration. Every value here equalled the old 0.02
  # default, so this table did nothing; now that the default is 0.0001 it is
  # load-bearing - it holds ~22 section screenshots at the OLD tolerance while
  # their drift is still unmeasured. Delete it once they are measured and
  # re-recorded; that is the whole point of keeping it.
  SECTION_CONFIGS = {
    "cta" => {tolerance: 0.02},
    "cta-contact_us" => {tolerance: 0.02},
    "clients" => {tolerance: 0.02},
    "use-cases" => {tolerance: 0.02},
    "technologies" => {tolerance: 0.02},
    "testimonials" => {tolerance: 0.02},
    "why-us" => {tolerance: 0.02}
  }.freeze

  # 0.02 let ~41,472 pixels of a 1920x1080 frame change before failing, so real
  # diffs passed green - services/_testimonials-header sat at 0.005923 for a
  # whole recolour and reported no change. Repeat runs report IDENTICAL
  # difference_levels, i.e. run-to-run noise is 0.0, so the floor only has to
  # clear zero: 0.0001 is ~207 px. Calls that need real slack (font-swap,
  # animation) still pin their own tolerance.
  DEFAULT_SCREENSHOT_CONFIG = {tolerance: 0.0001}.freeze

  def screenshot_config_for(name)
    SECTION_CONFIGS.fetch(extract_section_key(name), DEFAULT_SCREENSHOT_CONFIG)
  end

  # The key is the tail after "/_", so "services/_technologies" matches the
  # "technologies" key but "services/_testimonials-header" does NOT match
  # "testimonials" - it is one string, not a prefix.
  def extract_section_key(name)
    name.to_s.split("/_").last
  end
end
