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

    # The homepage links out to four social profiles. The old guard meant
    # dropping all four read the same as having them.
    social_links = doc.css("a[href*='facebook'], a[href*='twitter'], a[href*='linkedin'], a[href*='github']")
    refute_empty social_links, "Homepage should link to the company social profiles"

    social_links.each do |link|
      assert link["href"].start_with?("http"),
        "Social media links should use full URLs"
    end
  end

  def test_homepage_performance_critical_elements
    doc = parse_html_file("index.html")

    # Check for performance-critical elements

    # Images should have alt attributes
    images = doc.css("img")
    images.each do |img|
      alt = img["alt"]
      assert !alt.nil?, "Images should have alt attributes"
    end

    # The lazy-loading block that used to follow computed `large_images.any?
    # { ... }` and discarded the result - no assertion either way. Dropped
    # rather than promoted: whether a given hero should be lazy-loaded is a
    # per-image LCP decision, not an invariant. bin/lighthouse is the tool
    # for that question.
  end

  def test_homepage_structured_data_organization
    doc = parse_html_file("index.html")

    # Homepage should have Organization schema
    json_scripts = extract_json_ld_schemas(doc)

    organization_schemas = json_scripts.select do |script|
      data = JSON.parse(script.text)
      data.is_a?(Hash) && data["@type"] == "Organization"
    rescue JSON::ParserError
      false
    end

    refute_empty organization_schemas, "Homepage should publish Organization schema"

    org_data = JSON.parse(organization_schemas.first.text)

    assert_schema_context(org_data)
    assert_schema_fields(org_data, "@type", "name")
    assert_equal "Organization", org_data["@type"]
    assert org_data["name"].length > 0, "Organization should have name"

    refute_nil org_data["url"], "Organization schema should carry a url"
    assert_valid_url(org_data["url"], "Organization URL should be valid")
  end

  # test_homepage_breadcrumb_handling removed 2026-08-07: it guarded on
  # `.breadcrumb/.breadcrumbs` elements, which the homepage does not render
  # (and should not - a homepage is the breadcrumb root). Zero assertions ran.

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

    # A `doc.css(...)` line whose result was discarded used to sit here.
    # Removed: which utility classes a CSS framework emits is not an
    # invariant, and the visual suites cover responsive rendering.
  end

  def test_homepage_loading_performance_optimization
    doc = parse_html_file("index.html")

    # Check for performance optimization elements

    # Preload critical resources
    preload_links = doc.css("head link[rel='preload']")
    refute_empty preload_links, "Homepage should preload its critical CSS"

    preload_links.each do |link|
      refute_nil link["as"], "Preload links should specify resource type with 'as' attribute"
    end

    # The DNS-prefetch block that used to follow had an empty `if` body - it
    # asserted nothing whether or not the optimization was present. Replaced
    # with the invariant that actually holds and matters: the homepage loads
    # zero third-party scripts or stylesheets, which is why it needs no DNS
    # optimization in the first place (fonts and mermaid are self-hosted).
    assert_empty doc.css("script[src^='http']").map { |s| s["src"] },
      "Homepage should not load third-party scripts"
    assert_empty doc.css("link[rel='stylesheet'][href^='http']").map { |l| l["href"] },
      "Homepage should not load third-party stylesheets"
  end

  # test_homepage_security_headers_integration removed 2026-08-07: it guarded
  # every assertion on a <meta http-equiv="Content-Security-Policy"> the site
  # does not emit. CSP belongs in response headers, not a meta tag, so this
  # would not be the place to assert it even once a policy ships.

  # test_homepage_analytics_integration removed 2026-08-07: the test build
  # emits no analytics script at all (page/analytics.html is environment
  # gated), so the guard never opened. Asserting analytics in a test build
  # would pin the wrong environment; leave it to the production build.

  def test_homepage_accessibility_landmarks
    doc = parse_html_file("index.html")

    # Check for proper accessibility landmarks
    # After HTML revert, main element may be within FL-Builder structure
    main_element = doc.css("main").first || doc.css("[role='main']").first || doc.css(".fl-page").first
    refute_nil main_element, "Homepage should have main landmark element or equivalent"

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
    doc.css("a[href*='#main'], a[href*='#content'], .skip-link")
    # Skip links are good practice but not required for testing
  end
end
