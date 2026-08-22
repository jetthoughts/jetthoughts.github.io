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

  # The SOURCE half of the pair above. The rendered assertion cannot tell a
  # frozen "18+" from a derived one while 2026-2008 == 18, so on its own it is
  # blind until 2027-01-01 - a fault injection replacing `derived: tenure` with
  # `value: "18+"` passed it green (20.11 defect D). This half sees the freeze
  # directly, today.
  #
  # This is NOT a config test. The hardcoded literal IS the defect class: the
  # 2026-08-14 canon audit found the founding year wrong in eight places
  # precisely because each one kept its own copy of the number instead of
  # deriving it. The two assertions are one gate - keep both.
  def test_register_pilot_tenure_stat_is_not_frozen_in_source
    frozen = "#{Time.now.year - 2008}+"

    pilot_frontmatter.each do |path, front|
      stats = front.dig("clients", "stats")
      refute_nil stats, "#{path}: no clients.stats block - this gate would pass by finding nothing"

      assert stats.any? { |stat| stat["derived"] == "tenure" },
        "#{path}: the tenure stat must be `derived: tenure` so layouts/next/landing.html computes it " \
        "from site.Params.foundingYear - a frontmatter number is wrong every January (claims-canon)"
      assert_empty stats.select { |stat| stat["value"].to_s.strip == frozen }.map { |stat| stat["label"] },
        "#{path}: a stat is frozen at #{frozen} in frontmatter. Today that reads the same as the " \
        "derived value, which is exactly why the rendered assertion cannot see it - use `derived: tenure`"
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

  # Frontmatter of every pilot stub, keyed by repo-relative path. Same
  # empty-check reflex as register_pilots: iterating nothing reports green.
  def pilot_frontmatter
    stubs = Dir.glob(File.join(REPO_ROOT, "content/next/pilots/**/*.md"))
    assert stubs.any?, "no pilot stubs under content/next/pilots/ - this gate would pass by finding nothing"

    stubs.to_h do |path|
      front = File.read(path)[/\A---\n(.*?)\n---\n/m, 1]
      refute_nil front, "#{path}: no YAML frontmatter"
      [path.sub("#{REPO_ROOT}/", ""), YAML.safe_load(front)]
    end
  end
end
