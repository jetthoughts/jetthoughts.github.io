# frozen_string_literal: true

require "minitest/autorun"
require "support/screenshot_section_config"

# The shield mapping was inert while its values equalled the default. Lowering
# the default made it decide which screenshots keep the OLD tolerance, so the
# "/_" tail rule is now behaviour worth pinning - a near-miss like
# "_testimonials-header" silently inheriting the "testimonials" shield would
# re-blind the gate on that section.
class ScreenshotSectionConfigTest < Minitest::Test
  include ScreenshotSectionConfig

  def test_section_name_matching_a_key_is_shielded
    assert_equal 0.02, screenshot_config_for("services/_technologies")[:tolerance]
  end

  def test_longer_section_name_does_not_match_a_shorter_key
    refute_equal 0.02, screenshot_config_for("services/_testimonials-header")[:tolerance]
    assert_equal DEFAULT_SCREENSHOT_CONFIG, screenshot_config_for("services/_testimonials-header")
  end

  def test_name_without_a_section_gets_the_default
    assert_equal DEFAULT_SCREENSHOT_CONFIG, screenshot_config_for("homepage")
    assert_equal DEFAULT_SCREENSHOT_CONFIG, screenshot_config_for("blog/post")
  end

  def test_key_is_the_tail_after_the_last_section_separator
    assert_equal "footer", extract_section_key("services/_footer")
    assert_equal "homepage", extract_section_key("homepage")
  end

  def test_every_shielded_section_is_looser_than_the_default
    ScreenshotSectionConfig::SECTION_CONFIGS.each do |key, config|
      assert_operator config[:tolerance], :>, DEFAULT_SCREENSHOT_CONFIG[:tolerance],
        "#{key} shields nothing - drop it from SECTION_CONFIGS"
    end
  end
end
