# frozen_string_literal: true

require "test_helper"

# Paved-path consistency guard (Phase E): the new-page checklist
# (docs/workflows/new-page.md) requires every page bundle to be wired into
# the fast gate and the ownership map. This test fails when a page CSS file
# is added without those entries.
class PavedPathGuardTest < Minitest::Test
  REPO_ROOT = File.expand_path("../..", __dir__)

  def page_keys
    Dir.glob(File.join(REPO_ROOT, "themes/beaver/assets/css/pages/*.css"))
      .map { |f| File.basename(f, ".css") }
  end

  def test_every_page_css_has_a_qtest_mapping
    qtest = File.read(File.join(REPO_ROOT, "bin/qtest"))
    missing = page_keys.reject { |k| qtest.include?(%("#{k}")) }
    assert_empty missing,
      "pages/*.css without a bin/qtest PAGE_TESTS entry (see docs/workflows/new-page.md step 6)"
  end

  def test_every_page_css_is_in_the_ownership_map
    map = File.read(File.join(REPO_ROOT, "docs/projects/2509-css-migration/css-bundle-ownership-map.md"))
    missing = page_keys.reject { |k| map.include?(k) }
    assert_empty missing,
      "pages/*.css missing from css-bundle-ownership-map.md (see docs/workflows/new-page.md step 6)"
  end
end
