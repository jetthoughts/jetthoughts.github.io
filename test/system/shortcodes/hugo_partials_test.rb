# frozen_string_literal: true

require "application_system_test_case"

class HugoPartialsTest < ApplicationSystemTestCase
  # Test Hugo partial templates functionality and rendering

  def test_header_partial_rendering
    visit "/"

    within "header" do
      # Logo partial rendering
      assert_selector "a.logo"
      assert_selector "svg"

      # Navigation partial
      assert_selector "nav.navigation"
    end
  end

  def test_page_header_partial_with_css
    visit "/"

    # Check that header partial loads appropriate CSS
    within("head", visible: false) do
      # Should have CSS files loaded
      css_links = all("link[rel='stylesheet']", visible: false)
      assert css_links.count >= 1,
        "Should have CSS files loaded through header partial"

      # CSS should be processed and optimized
      css_links.each do |link|
        href = link[:href]
        next if href.start_with?("http") # Skip external CSS

        # Local CSS should be minified and have integrity hash
        assert href.include?(".min."),
          "CSS file should be minified: #{href}"
        assert link[:integrity].present?,
          "CSS file should have integrity attribute: #{href}"
      end
    end
  end

  def test_footer_partial_structure
    visit "/"

    within "footer" do
      # Company information section
      assert_selector ".info"

      # Contact information
      assert_selector "a[href*='mailto:']"
      assert_selector "a[href*='tel:']"

      # Navigation sections
      assert_selector "nav[aria-label*='Services']"
      assert_selector "nav[aria-label*='Company']"

      # Social media partial
      assert_selector "nav[aria-label*='Social']"

      # Copyright and legal
      assert_selector ".footer-bottom"
      assert_text(/© \d{4}/)
    end
  end

  def test_seo_partials_integration
    visit "/"

    within("head", visible: false) do
      # Meta tags partial
      assert_selector "meta[name='description']", visible: false
      assert_selector "meta[name='robots']", visible: false
      assert_selector "meta[name='viewport']", visible: false

      # Open Graph partial
      og_tags = all("meta[property^='og:']", visible: false)
      assert og_tags.count >= 4,
        "Should have multiple Open Graph tags"

      # Twitter Card partial
      twitter_tags = all("meta[name^='twitter:']", visible: false)
      assert twitter_tags.count >= 2,
        "Should have Twitter Card tags"

      # JSON-LD schema partials
      json_ld_scripts = all('script[type="application/ld+json"]', visible: false)
      assert json_ld_scripts.count >= 1,
        "Should have structured data from schema partials"
    end
  end

  def test_asset_processing_partials
    visit "/"

    # CSS processor partial results
    css_files = all("link[rel='stylesheet']")
    css_files.each do |link|
      href = link[:href]
      next if href.start_with?("http")

      # Should be processed through Hugo pipes
      assert href.match?(/\.(min\.)?[a-f0-9]+\.css$/),
        "CSS should be processed with fingerprinting: #{href}"
    end

    # JavaScript files if any
    js_files = all("script[src]").select { |s| !s[:src].start_with?("http") }
    js_files.each do |script|
      src = script[:src]

      # Should have performance attributes
      assert script[:defer] || script[:async],
        "JS file should have async/defer: #{src}"
    end
  end

  def test_blog_post_partials
    # Visit a blog page to test blog-specific partials
    visit "/blog"

    # Blog listing partial structure
    if has_selector?(".blog-posts, .post-list, article")
      # Post excerpts/summaries
      articles = all("article, .post-item")
      articles.first(3).each do |article|
        # Test first few articles
        within article do
          # Each post should have title
          assert_selector "h1, h2, h3, .title, .heading", minimum: 1,
            message: "Blog post should have heading"

          # Publication date
          assert_selector "time, .date, .post-date",
            message: "Blog post should show publication date"
        end
      end
    end
  end

  def test_social_sharing_partial
    visit "/test-testimonial" # Use test page

    if has_selector?(".social-share")
      within ".social-share" do
        # Social sharing links
        social_links = all("a")
        assert social_links.count >= 2,
          "Should have multiple social sharing options"

        social_links.each do |link|
          # Proper attributes for social sharing
          assert link[:target] == "_blank",
            "Social links should open in new tab"
          assert link[:rel]&.include?("noopener"),
            "Social links should have security attributes"

          # Accessibility
          assert link[:"aria-label"].present? || link[:title].present?,
            "Social links should have accessibility labels"

          # Should have SVG icons
          assert_selector "svg",
            message: "Social links should use SVG icons"
        end
      end
    end
  end

  def test_critical_css_partial
    visit "/"

    # Check for critical CSS inlined in head
    inline_styles = all("style")

    if inline_styles.any?
      # Critical CSS should be inlined
      critical_css = inline_styles.first.text

      # Should contain basic layout and typography styles
      assert critical_css.include?("body") || critical_css.include?("."),
        "Critical CSS should contain actual CSS rules"

      # Should be minified (no unnecessary whitespace)
      refute critical_css.include?("\n  "),
        "Critical CSS should be minified"
    end
  end

  def test_favicon_partial
    visit "/"

    within("head", visible: false) do
      # Standard favicon
      assert_selector "link[rel*='icon']", visible: false, minimum: 1

      # Apple touch icon
      assert_selector "link[rel='apple-touch-icon']", visible: false

      # Web manifest
      assert_selector "link[rel='manifest']", visible: false

      # Theme color
      assert_selector "meta[name='theme-color']", visible: false
    end
  end

  def test_analytics_partial
    visit "/"

    # Google Analytics or similar tracking
    gtag_scripts = all("script").select { |s| s.text.include?("gtag") || s[:src]&.include?("googletagmanager") }

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
    visit "/about-us"

    # Look for breadcrumb structured data
    json_ld_scripts = all('script[type="application/ld+json"]')
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
      assert first_item["name"] == "Home",
        "First breadcrumb item should be Home"
    end
  end

  def test_service_schema_partial
    visit "/services/fractional-cto" rescue visit("/")

    # Look for service-related structured data
    json_ld_scripts = all('script[type="application/ld+json"]')
    service_script = json_ld_scripts.find { |s|
      s.text.include?("Service") || s.text.include?("Organization")
    }

    if service_script
      service_data = JSON.parse(service_script.text)

      # Should have schema.org context
      assert service_data["@context"]&.include?("schema.org"),
        "Service schema should use schema.org context"

      # Should have organization or service type
      type = service_data["@type"]
      assert ["Service", "Organization", "LocalBusiness"].include?(type),
        "Should have appropriate schema type"
    end
  end

  def test_performance_partial_integration
    visit "/"

    # Check for performance optimizations from partials

    # Preload critical resources
    preload_links = all("link[rel='preload']")
    preload_links.each do |link|
      as_attr = link[:as]
      assert %w[style script font image].include?(as_attr),
        "Preload links should specify resource type"
    end

    # DNS prefetch for external resources
    prefetch_links = all("link[rel='preconnect'], link[rel='dns-prefetch']")
    prefetch_links.each do |link|
      href = link[:href]
      assert href.start_with?("http"),
        "Prefetch should be for external domains"
    end

    # Service worker registration
    sw_scripts = all("script").select { |s| s.text.include?("serviceWorker") }
    if sw_scripts.any?
      sw_script = sw_scripts.first.text
      assert sw_script.include?("register"),
        "Service worker should be registered"
    end
  end
end
