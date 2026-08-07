require "base_page_test_case"

class HugoPartialsTest < BasePageTestCase
  # Unit tests for Hugo partial templates functionality and rendering
  # Tests rendered HTML output from public-test directory (no server required)

  # Partials that only render on a post (share, article schema) need a real
  # post, not the blog list page.
  BLOG_POST = "blog/devtools-for-ai-agents/index.html"

  def test_header_partial_rendering
    doc = parse_html_file("index.html")

    # Logo partial rendering
    assert doc.css("header a.logo").any?, "Header should contain logo link"
    assert doc.css("header svg").any?, "Header should contain SVG logo"

    # Navigation partial
    assert doc.css("header nav.navigation").any?, "Header should contain navigation"
  end

  def test_page_header_partial_with_css
    doc = parse_html_file("index.html")

    # Check that header partial loads appropriate CSS
    css_links = doc.css("head link[rel='stylesheet']")
    assert css_links.count >= 1, "Should have CSS files loaded through header partial"

    # CSS should be processed and optimized
    css_links.each do |link|
      href = link["href"]
      next if href&.start_with?("http") # Skip external CSS

      # Local CSS should be minified and have integrity hash
      assert href&.include?(".min.") || href&.match?(/\.[a-f0-9]+\.css$/),
        "CSS file should be minified or fingerprinted: #{href}"

      if link["integrity"]
        assert_match(/^(sha\d+|md5)-/, link["integrity"],
          "CSS file should have valid integrity attribute: #{href}")
      end
    end
  end

  def test_footer_partial_structure
    doc = parse_html_file("index.html")

    # Company information section
    assert doc.css("footer .info").any?, "Footer should contain info section"

    # Contact information
    assert doc.css("footer a[href*='mailto:']").any?, "Footer should contain email link"
    assert doc.css("footer a[href*='tel:']").any?, "Footer should contain phone link"

    # Navigation sections
    assert doc.css("footer nav[aria-label*='Services']").any?, "Footer should contain services navigation"
    assert doc.css("footer nav[aria-label*='Company']").any?, "Footer should contain company navigation"

    # Social media partial
    assert doc.css("footer nav[aria-label*='Social']").any?, "Footer should contain social navigation"

    # Copyright and legal
    assert doc.css("footer .footer-bottom").any?, "Footer should contain bottom section"
    copyright_text = doc.css("footer").text
    assert_match(/© \d{4}/, copyright_text, "Footer should contain copyright year")
  end

  def test_seo_partials_integration
    doc = parse_html_file("index.html")

    # Meta tags partial
    assert doc.css("head meta[name='description']").any?, "Should have meta description"
    assert doc.css("head meta[name='robots']").any?, "Should have robots meta tag"
    assert doc.css("head meta[name='viewport']").any?, "Should have viewport meta tag"

    # Open Graph partial
    og_tags = doc.css("head meta[property^='og:']")
    assert og_tags.count >= 4, "Should have multiple Open Graph tags"

    # Twitter Card partial
    twitter_tags = doc.css("head meta[name^='twitter:']")
    assert twitter_tags.count >= 2, "Should have Twitter Card tags"

    # JSON-LD schema partials
    json_ld_scripts = doc.css('head script[type="application/ld+json"]')
    assert json_ld_scripts.count >= 1, "Should have structured data from schema partials"
  end

  def test_asset_processing_partials
    doc = parse_html_file("index.html")

    # CSS processor partial results
    css_files = doc.css("head link[rel='stylesheet']")
    refute_empty css_files, "Homepage should link processed stylesheets"

    css_files.each do |link|
      href = link["href"]
      next if href&.start_with?("http")

      # Should be processed through Hugo pipes
      assert href&.match?(/\.(min\.)?[a-f0-9]+\.css$/) || href&.include?(".min."),
        "CSS should be processed with fingerprinting: #{href}"
    end

    # JavaScript files if any
    js_files = doc.css("script[src]").select { |s| !s["src"]&.start_with?("http") }
    refute_empty js_files, "Homepage should load processed local scripts"

    js_files.each do |script|
      src = script["src"]

      # Should have performance attributes
      assert script["defer"] || script["async"],
        "JS file should have async/defer: #{src}"
    end
  end

  # Selected with "article, .post-item, .blog-posts article" - a list that
  # omits `.blog-post`, the only class the blog index renders. It matched
  # zero articles on every run and `if articles.any?` made that a pass. Same
  # defect as list_template_test's date check.
  def test_blog_post_partials
    doc = parse_html_file("blog/index.html")

    articles = doc.css("article, .post-item, .blog-post, .blog-posts article")
    refute_empty articles, "Blog index should render post entries"

    articles.first(3).each do |article|
      assert article.css("h1, h2, h3, .title, .heading").any?,
        "Blog post should have heading"
      assert article.css("time, .date, .post-date").any?,
        "Blog post should show publication date"
    end
  end

  # Checked index.html and about-us/index.html, neither of which renders
  # blog/share.html - so `next if social_share.empty?` skipped both and the
  # test asserted nothing on any run. The partial lives on blog posts.
  def test_social_sharing_partial
    doc = parse_html_file(BLOG_POST)

    social_share = doc.css(".social-share")
    refute_empty social_share, "Blog post should render the social share partial"

    social_links = social_share.css("a")
    assert social_links.count >= 2, "Should have multiple social sharing options"

    social_links.each do |link|
      assert_equal "_blank", link["target"],
        "Social links should open in new tab"
      assert link["rel"]&.include?("noopener"),
        "Social links should have security attributes"

      aria_label = link["aria-label"]
      title = link["title"]
      assert aria_label&.length&.positive? || title&.length&.positive?,
        "Social links should have accessibility labels"

      assert link.css("svg").any?, "Social links should use SVG icons"
    end
  end

  def test_critical_css_partial
    doc = parse_html_file("index.html")

    # Check for critical CSS inlined in head. Losing the inline block is a
    # first-paint regression, which is exactly what the old guard hid.
    inline_styles = doc.css("head style")
    refute_empty inline_styles, "Homepage should inline its critical CSS"

    critical_css = inline_styles.first.text

    # Should contain basic layout and typography styles
    assert critical_css.include?("body") || critical_css.include?("."),
      "Critical CSS should contain actual CSS rules"

    # Accept both formatted and minified CSS - Hugo may include readable
    # critical styles; that serves a different purpose and is fine.
  end

  def test_favicon_partial
    doc = parse_html_file("index.html")

    # Standard favicon
    assert doc.css("head link[rel*='icon']").any?, "Should have favicon link"

    # Apple touch icon
    assert doc.css("head link[rel='apple-touch-icon']").any?, "Should have Apple touch icon"

    # Web manifest
    assert doc.css("head link[rel='manifest']").any?, "Should have web manifest"

    # Theme color
    assert doc.css("head meta[name='theme-color']").any?, "Should have theme color meta tag"
  end

  # test_analytics_partial removed 2026-08-07: page/analytics.html is
  # environment-gated, so the test build emits no gtag script and both
  # guards were permanently false. Its intent - "if analytics ships, it must
  # carry consent handling" - is worth keeping, but it has to run against a
  # production build to mean anything. Nothing here asserted that.

  # The `return unless File.exist?` and `if breadcrumb_script` guards both
  # made a missing breadcrumb indistinguishable from a valid one.
  def test_breadcrumb_partial_json_ld
    doc = parse_html_file("about-us/index.html")

    json_ld_scripts = doc.css('script[type="application/ld+json"]')
    breadcrumb_script = json_ld_scripts.find { |s| s.text.include?("BreadcrumbList") }
    refute_nil breadcrumb_script, "about-us should publish BreadcrumbList structured data"

    breadcrumb_data = JSON.parse(breadcrumb_script.text)

    assert_equal "BreadcrumbList", breadcrumb_data["@type"],
      "Breadcrumb should have correct schema type"

    items = breadcrumb_data["itemListElement"]
    assert items.is_a?(Array) && items.count >= 1,
      "Breadcrumb should have list items"

    assert_equal "Home", items.first["name"],
      "First breadcrumb item should be Home"
  end

  # Walked three candidate pages and `next`ed past any that lacked the
  # schema, so all three coming up empty read the same as one succeeding.
  # A service page must publish it; assert against the canonical one.
  def test_service_schema_partial
    doc = parse_html_file("services/fractional-cto/index.html")

    json_ld_scripts = doc.css('script[type="application/ld+json"]')
    service_script = json_ld_scripts.find do |s|
      s.text.include?("Service") || s.text.include?("Organization")
    end
    refute_nil service_script, "Service page should publish Service/Organization schema"

    service_data = JSON.parse(service_script.text)

    assert service_data["@context"]&.include?("schema.org"),
      "Service schema should use schema.org context"

    assert ["Service", "Organization", "LocalBusiness"].include?(service_data["@type"]),
      "Should have appropriate schema type"
  end

  def test_performance_partial_integration
    doc = parse_html_file("index.html")

    # Check for performance optimizations from partials

    # Preload critical resources
    preload_links = doc.css("head link[rel='preload']")
    refute_empty preload_links, "Homepage should preload critical resources"

    preload_links.each do |link|
      assert %w[style script font image].include?(link["as"]),
        "Preload links should specify resource type"
    end

    # The site emits no preconnect/dns-prefetch at all - fonts and mermaid
    # are self-hosted - so the loop that used to sit here iterated an empty
    # set. Assert the reason it is empty instead.
    assert_empty doc.css("script[src^='http']").map { |s| s["src"] },
      "Homepage should not load third-party scripts"

    # Service worker registration
    sw_scripts = doc.css("script").select { |s| s.text.include?("serviceWorker") }
    refute_empty sw_scripts, "Homepage should register a service worker"
    assert sw_scripts.first.text.include?("register"),
      "Service worker should be registered"
  end
end
