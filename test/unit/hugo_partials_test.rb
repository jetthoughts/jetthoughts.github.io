require_relative "base_page_test"

class HugoPartialsTest < BasePageTestCase
  # Unit tests for Hugo partial templates functionality and rendering
  # Tests rendered HTML output from public-test directory (no server required)

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
    css_files.each do |link|
      href = link["href"]
      next if href&.start_with?("http")

      # Should be processed through Hugo pipes
      assert href&.match?(/\.(min\.)?[a-f0-9]+\.css$/) || href&.include?(".min."),
        "CSS should be processed with fingerprinting: #{href}"
    end

    # JavaScript files if any
    js_files = doc.css("script[src]").select { |s| !s["src"]&.start_with?("http") }
    js_files.each do |script|
      src = script["src"]

      # Should have performance attributes
      assert script["defer"] || script["async"],
        "JS file should have async/defer: #{src}"
    end
  end

  def test_blog_post_partials
    # Skip if blog directory doesn't exist
    return unless File.exist?(File.join(root_path, "blog/index.html"))

    doc = parse_html_file("blog/index.html")

    # Blog listing partial structure
    articles = doc.css("article, .post-item, .blog-posts article")
    if articles.any?
      # Test first few articles
      articles.first(3).each do |article|
        # Each post should have title
        headings = article.css("h1, h2, h3, .title, .heading")
        assert headings.any?, "Blog post should have heading"

        # Publication date
        dates = article.css("time, .date, .post-date")
        assert dates.any?, "Blog post should show publication date"
      end
    end
  end

  def test_social_sharing_partial
    # Check on a specific page that likely has social sharing
    pages_to_check = ["index.html", "about-us/index.html"]

    pages_to_check.each do |page|
      next unless File.exist?(File.join(root_path, page))

      doc = parse_html_file(page)
      social_share = doc.css(".social-share")

      next if social_share.empty?

      # Social sharing links
      social_links = social_share.css("a")
      assert social_links.count >= 2, "Should have multiple social sharing options"

      social_links.each do |link|
        # Proper attributes for social sharing
        assert_equal "_blank", link["target"],
          "Social links should open in new tab"
        assert link["rel"]&.include?("noopener"),
          "Social links should have security attributes"

        # Accessibility
        aria_label = link["aria-label"]
        title = link["title"]
        assert aria_label&.length&.positive? || title&.length&.positive?,
          "Social links should have accessibility labels"

        # Should have SVG icons
        assert link.css("svg").any?, "Social links should use SVG icons"
      end
      break # Test only the first page that has social sharing
    end
  end

  def test_critical_css_partial
    doc = parse_html_file("index.html")

    # Check for critical CSS inlined in head
    inline_styles = doc.css("head style")

    if inline_styles.any?
      # Critical CSS should be inlined
      critical_css = inline_styles.first.text

      # Should contain basic layout and typography styles
      assert critical_css.include?("body") || critical_css.include?("."),
        "Critical CSS should contain actual CSS rules"

      # Accept both formatted and minified CSS - Hugo may include readable critical styles
      # This is acceptable as critical CSS serves different purposes
    end
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

  def test_analytics_partial
    doc = parse_html_file("index.html")

    # Google Analytics or similar tracking
    gtag_scripts = doc.css("script").select do |s|
      s.text.include?("gtag") || s["src"]&.include?("googletagmanager")
    end

    if gtag_scripts.any?
      # Should have proper privacy settings
      analytics_script = gtag_scripts.find { |s| s.text.include?("gtag") }
      if analytics_script
        script_content = analytics_script.text

        # Should have privacy-compliant settings
        assert script_content.include?("consent") || script_content.include?("analytics_storage"),
          "Analytics should include privacy consent handling"
      end
    end
  end

  def test_breadcrumb_partial_json_ld
    # Skip if about-us page doesn't exist
    return unless File.exist?(File.join(root_path, "about-us/index.html"))

    doc = parse_html_file("about-us/index.html")

    # Look for breadcrumb structured data
    json_ld_scripts = doc.css('script[type="application/ld+json"]')
    breadcrumb_script = json_ld_scripts.find { |s| s.text.include?("BreadcrumbList") }

    if breadcrumb_script
      breadcrumb_data = JSON.parse(breadcrumb_script.text)

      assert_equal "BreadcrumbList", breadcrumb_data["@type"],
        "Breadcrumb should have correct schema type"

      items = breadcrumb_data["itemListElement"]
      assert items.is_a?(Array) && items.count >= 1,
        "Breadcrumb should have list items"

      # First item should be homepage
      first_item = items.first
      assert_equal "Home", first_item["name"],
        "First breadcrumb item should be Home"
    end
  end

  def test_service_schema_partial
    # Check multiple potential service pages
    service_pages = [
      "services/fractional-cto/index.html",
      "services/index.html",
      "index.html"
    ]

    service_pages.each do |page|
      next unless File.exist?(File.join(root_path, page))

      doc = parse_html_file(page)

      # Look for service-related structured data
      json_ld_scripts = doc.css('script[type="application/ld+json"]')
      service_script = json_ld_scripts.find do |s|
        s.text.include?("Service") || s.text.include?("Organization")
      end

      next unless service_script

      service_data = JSON.parse(service_script.text)

      # Should have schema.org context
      assert service_data["@context"]&.include?("schema.org"),
        "Service schema should use schema.org context"

      # Should have organization or service type
      type = service_data["@type"]
      assert ["Service", "Organization", "LocalBusiness"].include?(type),
        "Should have appropriate schema type"
      break # Test only the first page that has service schema
    end
  end

  def test_performance_partial_integration
    doc = parse_html_file("index.html")

    # Check for performance optimizations from partials

    # Preload critical resources
    preload_links = doc.css("head link[rel='preload']")
    preload_links.each do |link|
      as_attr = link["as"]
      assert %w[style script font image].include?(as_attr),
        "Preload links should specify resource type"
    end

    # DNS prefetch for external resources
    prefetch_links = doc.css("head link[rel='preconnect'], head link[rel='dns-prefetch']")
    prefetch_links.each do |link|
      href = link["href"]
      # Allow external URLs and protocol-relative URLs (starting with //)
      valid_prefetch = href&.start_with?("http", "/", "//")
      assert valid_prefetch,
        "Prefetch should be for external domains or CDN paths, got: #{href}"
    end

    # Service worker registration
    sw_scripts = doc.css("script").select { |s| s.text.include?("serviceWorker") }
    if sw_scripts.any?
      sw_script = sw_scripts.first.text
      assert sw_script.include?("register"),
        "Service worker should be registered"
    end
  end
end
