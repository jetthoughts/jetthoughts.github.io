# frozen_string_literal: true

require "base_page_test_case"

# The /next/ clean-slate rail (ADR-0006) is staging ON the production host.
# Its two safety properties - never indexed, never in the sitemap - exist only
# in RENDERED output, so they are asserted against the built tree. A source
# grep would pass on frontmatter that Hugo silently ignored (it did: `_build`
# was removed in Hugo 0.145 and the build only failed because it errors loudly).
class NextRailTest < BasePageTestCase
  PILOT = "next/services/fractional-cto/index.html"

  def test_next_pages_are_marked_noindex
    robots = parse_html_file(PILOT).css('meta[name="robots"]').first

    assert robots, "/next/ pages must carry a robots meta tag"
    assert_includes robots["content"], "noindex",
      "/next/ is production staging - it must never be indexable"
  end

  def test_next_pages_are_absent_from_the_sitemap
    sitemap = File.join(root_path, "sitemap.xml")
    assert File.exist?(sitemap), "sitemap.xml must be built: #{sitemap}"

    refute_match %r{/next/}, File.read(sitemap),
      "/next/ staging pages must not be submitted to search engines"
  end

  # The stub mirrors a real page; the copy lives there, so that URL is the
  # canonical one - and exactly one canonical may ship.
  def test_next_pages_canonicalise_to_their_source_page
    canonicals = parse_html_file(PILOT).css("link[rel='canonical']")

    assert_equal 1, canonicals.size, "a page must emit exactly one canonical"
    assert_match %r{/services/fractional-cto/\z}, canonicals.first["href"]
    refute_match %r{/next/}, canonicals.first["href"] # a fallback to .Permalink must FAIL here
  end
end
