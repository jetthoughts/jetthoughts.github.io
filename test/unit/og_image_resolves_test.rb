# frozen_string_literal: true

require "base_page_test_case"

# Social-preview images are the one asset nothing on the site links to, so a
# missing file is invisible until someone shares the page and gets a blank
# card. On 2026-08-20 the site-wide fallback
# (/assets/images/og-default.jpg) had never been uploaded - 553 pages, mostly
# blog posts, previewed blank on LinkedIn and Slack.
#
# The pre-existing meta-tag tests could not catch it: they assert the tag
# EXISTS and that width/height are 1200x630. Neither reads the file the tag
# points at. This one sweeps RENDERED output and resolves every same-origin
# social image against the build.
#
# Honest about its own reach: the build emits 684 distinct social-image
# values, of which exactly 2 are same-origin (this fallback and
# /blog/og-blog.jpg). The rest are off-origin CDN urls - see same_origin_url.
class OgImageResolvesTest < BasePageTestCase
  # Attribute order and attribute name both vary by emitter:
  # enhanced-meta-tags.html writes property=/name= first, the two theme
  # partials write content= first. Match the whole tag, then pull content out
  # of it - a fixed attribute sequence dropped the content-first tag on 480
  # pages, losing one whole distinct image (/blog/og-blog.jpg). Those pages
  # still matched via their property-first tag, so nothing looked wrong.
  SOCIAL_META = /<meta[^>]*(?:property|name)="(?:og:image|twitter:image)"[^>]*>/
  CONTENT_ATTR = /content="([^"]*)"/
  SITE_ORIGIN = "https://jetthoughts.com"

  def test_every_social_image_resolves_to_a_file_in_the_build
    refs = collect_social_image_refs
    refute_empty refs, "Build should emit social images - sweep found none"

    missing = refs.reject { |url, _| File.exist?(build_path_for(url)) }

    assert_empty missing.map { |url, page| "#{url} (referenced by #{page})" },
      "Social images referenced by rendered pages must exist in the build"
  end

  private

  # => { url => first page that referenced it }
  def collect_social_image_refs
    Dir.glob("#{root_path}/**/*.html").each_with_object({}) do |page, refs|
      File.read(page).scan(SOCIAL_META).each do |tag|
        url = same_origin_url(tag[CONTENT_ATTR, 1].to_s.gsub("&amp;", "&"))
        refs[url] ||= page.delete_prefix("#{root_path}/") if url
      end
    end
  end

  # Same-origin URL, or nil for anything this build does not produce.
  #
  # Off-origin images are deliberately NOT followed. Most og:image values are
  # CDN-proxied (wsrv.nl?url=raw.githubusercontent.com/...), and behind that
  # proxy sits a Hugo page resource that enhanced-meta-tags.html only emits
  # inside `if $resource` - so the build itself already guarantees the source
  # exists. What is left is a publish-time question (is it pushed to master
  # yet), which needs the network, not the filesystem.
  def same_origin_url(raw)
    raw = raw.delete_prefix(SITE_ORIGIN)
    raw.start_with?("/") ? raw.split("?").first : nil
  end

  def build_path_for(url)
    File.join(root_path, url)
  end
end
