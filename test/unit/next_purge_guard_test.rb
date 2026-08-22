# frozen_string_literal: true

require "base_page_test_case"

# PurgeCSS keeps a rule only if the class reached hugo_stats.json, and Hugo's
# writeStats does not record class attrs on every element - `<th>` is one it
# misses (.okf/build/hugo-stats-th-classes.md). The result is a rule that
# exists in source, markup that still carries the class, and NOTHING in the
# bundle the browser downloads.
#
# No visual gate can see this even in principle: it builds with
# ENVIRONMENT=production, so it purges exactly as production does and matches
# its own baseline (20.11 defect G - the screenshot test reported
# "1 screenshot compared, no failures" over a rule that had been deleted).
# Caught by human review in #563; this is the automated half.
#
# Deliberately keyed on the MECHANISM, not on `<th>`: any element type Hugo
# stops recording, or starts, is covered without an edit here.
class NextPurgeGuardTest < BasePageTestCase
  REPO_ROOT = File.expand_path("../..", __dir__)
  SOURCE_CSS = "themes/beaver/assets/css/pages/next-%s.css"

  # A class selector: a dot that is not part of a decimal, a filename, or the
  # tail of another identifier.
  CLASS_SELECTOR = /(?<![\w.-])\.(-?[A-Za-z_][\w-]*)/

  def test_no_register_pilot_rule_is_silently_purged
    pilot_pages.each do |relative|
      doc = parse_html_file(relative)
      register, built_css = loaded_bundle(relative, doc)
      source_css = File.read(File.join(REPO_ROOT, format(SOURCE_CSS, register)))

      styled = source_css.scan(CLASS_SELECTOR).flatten.uniq
      shipped = built_css.scan(CLASS_SELECTOR).flatten.uniq
      rendered = doc.css("[class]").flat_map { |el| el["class"].split }.uniq

      refute_empty styled & rendered,
        "#{relative}: no class is both styled and rendered - this gate would pass by finding nothing"

      assert_empty (styled & rendered) - shipped,
        "#{relative}: styled in next-#{register}.css and present in the markup, but ABSENT from the " \
        "bundle the page loads - PurgeCSS dropped the rule because the class never reached " \
        "hugo_stats.json. Move the class onto an element Hugo records, or select by position instead."
    end
  end

  private

  def pilot_pages
    pages = Dir.glob(File.join(root_path, "next/pilots/**/index.html"))
      .map { |path| path.sub("#{root_path}/", "") }

    assert pages.any?, "no built pages under next/pilots/ - this gate would pass by finding nothing"
    pages
  end

  # The bundle the PAGE links, never a glob of css/ - stale fingerprinted
  # bundles from earlier builds live in the same directory, and reading one of
  # those measures a build nobody is shipping (.okf/build/test-gates.md).
  def loaded_bundle(relative, doc)
    href = doc.css('link[rel="stylesheet"]').map { |link| link["href"] }
      .find { |h| h.to_s.match?(%r{/css/next-.+\.css\z}) }
    refute_nil href, "#{relative} links no next-* stylesheet"

    path = File.join(root_path, href.sub(%r{\A/}, ""))
    assert File.exist?(path), "#{relative} links a bundle that was not built: #{path}"

    [href[%r{/css/next-(.+?)\.min\.}, 1], File.read(path)]
  end
end
