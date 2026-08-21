# frozen_string_literal: true

require "base_page_test_case"
require "yaml"

# The /next/ clean-slate rail (ADR-0006) is staging ON the production host.
# Its two safety properties - never indexed, never in the sitemap - exist only
# in RENDERED output, so they are asserted against the built tree. A source
# grep would pass on frontmatter that Hugo silently ignored (it did: `_build`
# was removed in Hugo 0.145 and the build only failed because it errors loudly).
class NextRailTest < BasePageTestCase
  REPO_ROOT = File.expand_path("../..", __dir__)
  PILOT = "next/services/fractional-cto/index.html"

  # Design-register pilots (10.01): one landing page per candidate register,
  # all on the rail. Every REGISTER-PILOT assertion below runs over the glob,
  # not over a named path (PILOT above stays - its three tests target the v2
  # services page, which is not a pilot). A pilot added without its noindex,
  # or with a testimonial smoothed for its own skin, is exactly the failure
  # these gates exist to catch, and a hand-typed list would not see it.
  # Pilot B was added on 2026-08-21 and two of them had to be widened to
  # reach it.

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
  # HONEST LIMIT: in 2026 the derived value equals the frozen frontmatter 18,
  # so this assertion cannot distinguish them until 2027-01-01 - from then on
  # it bites forever. Kept rendered-level per repo doctrine (no template greps).
  def test_tenure_stat_is_derived_not_frozen
    doc = parse_html_file(PILOT)
    tenure = doc.css(".np-stat-value").map(&:text).find { |t| t.include?("+") }
    expected = "#{Time.now.year - 2008}+"
    assert_includes doc.css(".np-stat-value").map(&:text), expected,
      "tenure stat must derive from foundingYear (#{expected}), not the frozen frontmatter 18 - " \
      "the label-keyed branch in layouts/next/single.html silently falls back if the label is renamed"
    refute_nil tenure
  end

  # Every register pilot, not just the one this test knows the name of.
  def test_every_register_pilot_is_noindexed_and_unlisted
    sitemap = File.read(File.join(root_path, "sitemap.xml"))
    register_pilots.each do |relative|
      robots = parse_html_file(relative).css('meta[name="robots"]').first

      assert robots, "#{relative} must carry a robots meta tag"
      assert_includes robots["content"], "noindex",
        "#{relative} is a design pilot on the production host - it must never be indexable"
      refute_includes sitemap, relative.delete_suffix("index.html"),
        "#{relative} must not be submitted to search engines"
    end
  end

  # Same derivation, same HONEST LIMIT as the stub test above: through 2026 the
  # derived value equals the "18" a careless author would type, so this cannot
  # tell them apart until 2027-01-01 - from then on it bites forever.
  def test_register_pilot_tenure_stat_is_derived_not_frozen
    register_pilots.each do |relative|
      values = parse_html_file(relative).css(".rr-stat-value").map(&:text)

      refute_empty values, "#{relative} renders no stat values - this gate would pass by finding nothing"
      assert_includes values, "#{Time.now.year - 2008}+",
        "#{relative}: the tenure stat must derive from foundingYear, not a frozen number - " \
        "the derived: tenure branch in layouts/next/landing.html falls back to .value silently"
    end
  end

  # A testimonial is a person's words, not copy to tighten. The design
  # blueprint had smoothed this one ("They were detailed and precise, helping
  # us find problems...") and it shipped with a hand-waved "verbatim" claim.
  # data/testimonials.yaml is the canon, so the rendered quote has to appear
  # there character for character - an excerpt is fine, a rewrite is not.
  def test_testimonial_quote_is_canon_verbatim
    canon = YAML.load_file(File.join(REPO_ROOT, "data/testimonials.yaml"))["testimonials"]
      .find { |t| t["name"] == "Bruno Wozniak" }
    refute_nil canon, "the canon testimonial must exist in data/testimonials.yaml"

    register_pilots.each do |relative|
      rendered = parse_html_file(relative).css("blockquote").text.strip.delete("“”")

      # Every string contains "", so a blockquote that vanished would sail
      # through the substring assert below - the same false-green shape this
      # file already carries scar tissue for.
      refute_empty rendered, "#{relative} must render a testimonial blockquote"
      assert_includes canon["description"], rendered,
        "#{relative}: the rendered quote is not a verbatim slice of the canon testimonial"
    end
  end

  def test_next_pages_canonicalise_to_their_source_page
    canonicals = parse_html_file(PILOT).css("link[rel='canonical']")

    assert_equal 1, canonicals.size, "a page must emit exactly one canonical"
    assert_match %r{/services/fractional-cto/\z}, canonicals.first["href"]
    refute_match %r{/next/}, canonicals.first["href"] # a fallback to .Permalink must FAIL here
  end

  private

  # Built paths of every register pilot, relative to the destination root.
  # The empty check lives HERE so no caller can iterate zero pages and report
  # green - iterating nothing is the false-green this whole file guards against.
  def register_pilots
    pilots = Dir.glob(File.join(root_path, "next/pilots/**/index.html"))
      .map { |path| path.sub("#{root_path}/", "") }

    assert pilots.any?, "no built pages under next/pilots/ - this gate would pass by finding nothing"
    pilots
  end
end
