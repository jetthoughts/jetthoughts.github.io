# frozen_string_literal: true

require "test_helper"

# Orphan CSS guard (Phase 0 / P0.4 of the CSS maintainability plan).
#
# A CSS source file is "live" when a Hugo template references it via
# resources.Get, or a live CSS file @imports it. Anything else under the CSS
# asset trees is dead weight that silently accumulates (six such orphans were
# deleted in PR #363). This test fails whenever a new orphan appears, naming
# it, and whenever a template references a CSS file that doesn't exist.
class CssOrphanGuardTest < Minitest::Test
  REPO_ROOT = File.expand_path("../..", __dir__)
  CSS_ROOTS = ["themes/beaver/assets/css"].freeze
  TEMPLATE_ROOTS = ["themes/beaver/layouts", "layouts"].freeze

  def test_every_css_file_is_reachable_from_a_template
    orphans = css_files_on_disk - reachable_css_files - used_mixin_files
    assert_empty orphans.sort,
      "Orphan CSS files (no template resources.Get reference, no live @import chain, no @mixin usage reaches them) — delete them or wire them in"
  end

  def test_every_template_css_reference_exists_on_disk
    missing = template_referenced_css.reject { |path| File.file?(File.join(REPO_ROOT, "themes/beaver/assets", path)) }
    assert_empty missing.sort,
      "Templates reference CSS files that don't exist under themes/beaver/assets/"
  end

  private

  def css_files_on_disk
    CSS_ROOTS.flat_map { |root|
      Dir.glob(File.join(REPO_ROOT, root, "**", "*.{css,scss}"))
    }.map { |abs| Pathname.new(abs).relative_path_from(File.join(REPO_ROOT, "themes/beaver/assets")).to_s }
  end

  # postcss-mixins (postcss.config.js mixinsDir: css/mixins) makes a file live
  # when any live CSS invokes "@mixin <its-basename>" — deleting one crashes
  # the production build (learned the hard way with responsive-visibility).
  def used_mixin_files
    mixin_files = css_files_on_disk.select { |p| p.start_with?("css/mixins/") }
    return [] if mixin_files.empty?

    live_sources = reachable_css_files.map { |p| File.read(File.join(REPO_ROOT, "themes/beaver/assets", p)) }.join("\n")
    mixin_files.select { |p| live_sources.match?(/@mixin\s+#{Regexp.escape(File.basename(p, ".css"))}\b/) }
  end

  # "css/foo.css" paths pulled from resources.Get calls in all templates.
  def template_referenced_css
    TEMPLATE_ROOTS.flat_map { |root|
      Dir.glob(File.join(REPO_ROOT, root, "**", "*.html")).flat_map { |file|
        File.read(file).scan(/resources\.Get\s+"(css\/[^"]+\.css)"/).flatten
      }
    }.uniq
  end

  # Template-referenced files plus everything transitively reachable via
  # @import "..." lines inside them (imports resolve relative to the file).
  def reachable_css_files
    seen = {}
    queue = template_referenced_css.select { |path| File.file?(File.join(REPO_ROOT, "themes/beaver/assets", path)) }

    until queue.empty?
      path = queue.pop
      next if seen[path]
      seen[path] = true

      abs = File.join(REPO_ROOT, "themes/beaver/assets", path)
      File.read(abs).scan(/@import\s+(?:url\()?["']([^"')]+)["']\)?/).flatten.each do |target|
        next if target.start_with?("http", "//")
        # postcss-import resolves from the css root; plain CSS resolves
        # relative to the importing file — accept whichever exists.
        candidates = [
          Pathname.new(File.join(File.dirname(path), target)).cleanpath.to_s,
          Pathname.new(File.join("css", target)).cleanpath.to_s
        ].map { |c| c.end_with?(".css", ".scss") ? c : "#{c}.css" }
        candidates.each do |resolved|
          queue << resolved if File.file?(File.join(REPO_ROOT, "themes/beaver/assets", resolved))
        end
      end
    end

    seen.keys
  end
end
