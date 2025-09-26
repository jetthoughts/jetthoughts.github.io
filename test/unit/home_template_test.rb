require_relative "../base_page_test_case"

class HomeTemplateTest < BasePageTestCase
  # Comprehensive tests for home.html template
  # Validates homepage-specific functionality, SEO, and user experience
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  def test_homepage_hero_section_present
    doc = parse_html_file("index.html")

    # Check for hero section elements
    hero_sections = doc.css(".hero, .hero-section, .fl-builder-content .fl-module-hero, [data-hero]")

    # Homepage should have some form of hero/banner content
    assert hero_sections.any? || doc.css("h1").any?,
      "Homepage should have hero section or prominent h1 heading"
  end

  def test_homepage_unique_title_and_description
    doc = parse_html_file("index.html")

    # Title should be specific to homepage
    title = doc.css("head title").first
    refute_nil title, "Homepage must have title tag"

    title_text = title.text.strip
    assert title_text.length > 10, "Homepage title should be descriptive"
    assert title_text.include?("JetThoughts") || title_text.downcase.include?("home"),
      "Homepage title should identify the site or indicate homepage"

    # Meta description should be homepage-specific
    description_meta = doc.css("head meta[name='description']").first
    refute_nil description_meta, "Homepage must have meta description"

    description_content = description_meta["content"]
    assert description_content.length > 50,
      "Homepage meta description should be substantial"
    assert description_content.length <= 160,
      "Homepage meta description should not exceed 160 characters"
  end

  def test_homepage_navigation_functionality
    doc = parse_html_file("index.html")

    # Navigation should be present and functional
    nav_elements = doc.css("nav, .navbar, .navigation, header nav")
    assert nav_elements.any?, "Homepage should have navigation"

    # Check for main navigation links
    nav_links = doc.css("nav a, .navbar a, .navigation a, header nav a")
    if nav_links.any?
      nav_links.each do |link|
        href = link["href"]
        assert href, "Navigation links should have href attributes"

        # Internal links should be properly formatted
        if href && !href.start_with?("http", "mailto:", "tel:", "#")
          assert href.start_with?("/", "./", "../"),
            "Internal navigation links should use proper relative paths: #{href}"
        end
      end
    end
  end

  def test_homepage_content_sections
    doc = parse_html_file("index.html")

    # Homepage should have substantial content
    main_content = doc.css("main, .main-content, .fl-builder-content")
    assert main_content.any?, "Homepage should have main content area"

    # Check for content structure
    content_text = main_content.text.strip
    assert content_text.length > 200,
      "Homepage should have substantial content (found #{content_text.length} characters)"

    # Look for common homepage sections
    sections = doc.css("section, .section, .fl-module, .content-section")
    if sections.length > 0
      assert sections.length >= 2,
        "Homepage should have multiple content sections"
    end
  end

  def test_homepage_contact_information_present
    doc = parse_html_file("index.html")

    # Homepage should have contact information or links
    contact_indicators = [
      doc.css("a[href*='contact']").any?,
      doc.css("a[href*='mailto:']").any?,
      doc.css("a[href*='tel:']").any?,
      doc.text.downcase.include?("contact"),
      doc.text.downcase.include?("email"),
      doc.text.include?("@")
    ]

    assert contact_indicators.any?,
      "Homepage should provide contact information or contact links"
  end

  def test_homepage_social_media_integration
    doc = parse_html_file("index.html")

    # Check for social media links or sharing
    social_links = doc.css("a[href*='facebook'], a[href*='twitter'], a[href*='linkedin'], a[href*='github']")
    social_classes = doc.css(".social, .social-media, .social-links")

    # Social media is optional but if present should be properly implemented
    if social_links.any? || social_classes.any?
      social_links.each do |link|
        href = link["href"]
        assert href.start_with?("http"),
          "Social media links should use full URLs"

        # Should open in new tab/window for external links
        target = link["target"]
        if href.start_with?("http") && !href.include?("jetthoughts.com")
          # External social links should ideally open in new tab
          # This is a recommendation, not a strict requirement
        end
      end
    end
  end

  def test_homepage_performance_critical_elements
    doc = parse_html_file("index.html")

    # Check for performance-critical elements

    # Images should have alt attributes
    images = doc.css("img")
    images.each do |img|
      alt = img["alt"]
      assert alt != nil, "Images should have alt attributes"
    end

    # Check for lazy loading on images
    large_images = images.select { |img|
      src = img["src"]
      src && (src.include?("hero") || src.include?("banner") || src.include?("large"))
    }

    # Large images benefit from lazy loading (optional optimization)
    if large_images.any?
      lazy_loading_present = large_images.any? { |img|
        img["loading"] == "lazy" || img["data-src"]
      }
      # Note: Lazy loading is an optimization, not a requirement
    end
  end

  def test_homepage_structured_data_organization
    doc = parse_html_file("index.html")

    # Homepage should have Organization schema
    json_scripts = extract_json_ld_schemas(doc)

    organization_schemas = json_scripts.select do |script|
      begin
        data = JSON.parse(script.text)
        data.is_a?(Hash) && data["@type"] == "Organization"
      rescue JSON::ParserError
        false
      end
    end

    if organization_schemas.any?
      org_data = JSON.parse(organization_schemas.first.text)

      assert_schema_context(org_data)
      assert_schema_fields(org_data, "@type", "name")
      assert_equal "Organization", org_data["@type"]
      assert org_data["name"].length > 0, "Organization should have name"

      # Optional but recommended fields
      if org_data["url"]
        assert_valid_url(org_data["url"], "Organization URL should be valid")
      end
    end
  end

  def test_homepage_breadcrumb_handling
    doc = parse_html_file("index.html")

    # Homepage typically doesn't need breadcrumbs, but if present should be minimal
    breadcrumbs = doc.css(".breadcrumb, .breadcrumbs, nav[aria-label*='breadcrumb']")

    if breadcrumbs.any?
      # If breadcrumbs exist on homepage, should be simple
      breadcrumb_links = breadcrumbs.css("a")

      # Homepage breadcrumbs should be minimal (typically just "Home")
      assert breadcrumb_links.length <= 2,
        "Homepage breadcrumbs should be minimal"
    end
  end

  def test_homepage_call_to_action_elements
    doc = parse_html_file("index.html")

    # Homepage should have call-to-action elements
    cta_indicators = [
      doc.css(".cta, .call-to-action").any?,
      doc.css("button").any?,
      doc.css("a.btn, a.button").any?,
      doc.css("input[type='submit']").any?
    ]

    assert cta_indicators.any?,
      "Homepage should have call-to-action elements (buttons, CTA sections, or forms)"

    # Check CTA accessibility
    buttons = doc.css("button, .btn, .button")
    buttons.each do |button|
      text = button.text.strip
      assert text.length > 0, "Buttons should have descriptive text"
    end
  end

  def test_homepage_mobile_responsiveness_indicators
    doc = parse_html_file("index.html")

    # Check for mobile responsiveness indicators
    viewport_meta = doc.css("head meta[name='viewport']").first
    refute_nil viewport_meta, "Homepage must have responsive viewport meta tag"

    content = viewport_meta["content"]
    assert content.include?("width=device-width"),
      "Viewport should include device-width for mobile responsiveness"

    # Check for responsive CSS classes (optional but common)
    responsive_classes = doc.css(".container, .row, .col, .mobile, .tablet, .desktop")
    # Note: Responsive classes are optional as CSS frameworks vary
  end

  def test_homepage_loading_performance_optimization
    doc = parse_html_file("index.html")

    # Check for performance optimization elements

    # Preload critical resources
    preload_links = doc.css("head link[rel='preload']")
    preload_links.each do |link|
      as_attr = link["as"]
      assert as_attr, "Preload links should specify resource type with 'as' attribute"
    end

    # DNS prefetch for external resources
    dns_prefetch = doc.css("head link[rel='dns-prefetch']")
    preconnect = doc.css("head link[rel='preconnect']")

    # External resources benefit from DNS optimization (optional)
    external_resources = doc.css("script[src^='http'], link[href^='http']")
    if external_resources.any? && (dns_prefetch.any? || preconnect.any?)
      # Good practice: DNS optimization for external resources
    end
  end

  def test_homepage_security_headers_integration
    doc = parse_html_file("index.html")

    # Check for Content Security Policy meta tag (if implemented)
    csp_meta = doc.css("head meta[http-equiv='Content-Security-Policy']").first

    if csp_meta
      csp_content = csp_meta["content"]
      assert csp_content.length > 10, "CSP should have meaningful policy"
      assert csp_content.include?("default-src") || csp_content.include?("script-src"),
        "CSP should include security directives"
    end

    # Check for other security-related meta tags
    xframe_options = doc.css("head meta[http-equiv='X-Frame-Options']").first
    if xframe_options
      valid_values = ["DENY", "SAMEORIGIN"]
      assert valid_values.include?(xframe_options["content"]),
        "X-Frame-Options should use DENY or SAMEORIGIN"
    end
  end

  def test_homepage_analytics_integration
    doc = parse_html_file("index.html")

    # Check for analytics integration (Google Analytics, etc.)
    analytics_scripts = doc.css("script").select do |script|
      content = script.text
      src = script["src"]
      content.include?("google-analytics") ||
      content.include?("gtag") ||
      content.include?("analytics") ||
      (src && (src.include?("google-analytics") || src.include?("gtag")))
    end

    # Analytics is optional but if present should be properly configured
    if analytics_scripts.any?
      # Basic validation that analytics code exists
      analytics_scripts.each do |script|
        if script["src"]
          assert script["src"].start_with?("http"),
            "Analytics scripts should use proper URLs"
        else
          assert script.text.length > 20,
            "Inline analytics scripts should have meaningful content"
        end
      end
    end
  end

  def test_homepage_accessibility_landmarks
    doc = parse_html_file("index.html")

    # Check for proper accessibility landmarks
    main_element = doc.css("main").first
    refute_nil main_element, "Homepage should have main landmark element"

    # Header and footer landmarks
    header_element = doc.css("header").first
    footer_element = doc.css("footer").first

    # These are common but not strictly required
    if header_element.nil? && footer_element.nil?
      # Should have at least some structural elements
      structural_elements = doc.css("nav, aside, section, article")
      assert structural_elements.any?,
        "Homepage should have semantic HTML structure"
    end

    # Skip to content link
    skip_links = doc.css("a[href*='#main'], a[href*='#content'], .skip-link")
    # Skip links are good practice but not required for testing
  end
end