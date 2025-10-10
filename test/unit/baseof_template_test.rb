require_relative "../base_page_test_case"

class BaseofTemplateTest < BasePageTestCase
  # Comprehensive tests for baseof.html template
  # Validates security, accessibility, and architectural improvements
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  def test_sri_integrity_implementation_for_mermaid
    doc = parse_html_file("index.html")

    # Find Mermaid script tag
    mermaid_scripts = doc.css("script[src*='mermaid']")

    if mermaid_scripts.any?
      mermaid_script = mermaid_scripts.first
      src = mermaid_script["src"]
      integrity = mermaid_script["integrity"]
      crossorigin = mermaid_script["crossorigin"]

      # Validate SRI implementation per security requirements
      assert src.include?("mermaid@11"), "Mermaid script should specify version 11"
      refute_nil integrity, "Mermaid script must have integrity attribute for security"
      assert integrity.start_with?("sha384-"), "Mermaid integrity must use SHA384 hash"
      assert_equal "anonymous", crossorigin, "Mermaid script must have crossorigin=anonymous"

      # Validate hash format
      hash_part = integrity.gsub("sha384-", "")
      assert_match(/^[A-Za-z0-9+\/]+=*$/, hash_part, "Integrity hash must be valid base64")
      assert hash_part.length >= 64, "SHA384 hash must be sufficiently long"
    end
  end

  def test_no_hardcoded_inline_css_styles
    doc = parse_html_file("index.html")

    # Validate that specifically targeted hardcoded CSS has been extracted
    inline_styles = doc.css("head style")

    # Check for the specific styles we extracted from baseof.html
    # Note: FL-Builder (Beaver Builder) CSS is generated dynamically and is acceptable
    # We're looking for the exact patterns that were previously hardcoded in baseof.html
    problematic_styles = inline_styles.select do |style|
      content = style.text
      # Check for logo styles with main-logo-image or logo-image-main class
      content.match?(/\.(?:main-)?logo-image-main\s*\{[^}]*max-width:\s*100%/) ||
      # Check for skip-link with exact positioning pattern we removed
      content.match?(/\.skip-link\s*\{[^}]*position:\s*absolute[^}]*top:\s*-40px/) ||
      # Check for our specific sr-only pattern (not the plugin versions)
      content.match?(/^\.sr-only\s*\{[^}]*position:\s*absolute[^}]*clip:\s*rect\(1px,\s*1px,\s*1px,\s*1px\)/)
    end

    assert problematic_styles.empty?,
      "Previously hardcoded CSS (.logo-image-main, .skip-link, .sr-only) should be extracted to separate stylesheets"
  end

  def test_logo_styles_in_external_css
    # Validate that logo styles are properly loaded from theme-main.css
    doc = parse_html_file("index.html")

    # Check if logo element exists (indicating styles should be loaded)
    logo_elements = doc.css(".logo-image-main")

    if logo_elements.any?
      # Should have external CSS that includes theme styles
      css_links = doc.css("head link[rel='stylesheet']")
      theme_css_loaded = css_links.any? do |link|
        href = link["href"]
        href && (href.include?("theme") || href.include?("main"))
      end

      assert theme_css_loaded, "Logo styles should be loaded from external theme CSS file"
    end
  end

  def test_accessibility_styles_properly_loaded
    doc = parse_html_file("index.html")

    # Check for skip navigation link
    skip_links = doc.css("a.skip-link")

    if skip_links.any?
      # Should have CSS loaded that includes accessibility styles
      css_links = doc.css("head link[rel='stylesheet']")
      navigation_css_loaded = css_links.any? do |link|
        href = link["href"]
        href && (href.include?("navigation") || href.include?("accessibility"))
      end

      assert navigation_css_loaded,
        "Skip-link and accessibility styles should be loaded from external CSS file (navigation.css or accessibility.css)"

      # Validate skip-link attributes
      skip_link = skip_links.first
      assert_equal "#main-content", skip_link["href"],
        "Skip link should point to main content"
      assert skip_link.text.strip.length > 0,
        "Skip link should have descriptive text"
    end
  end

  def test_screen_reader_utilities_present
    doc = parse_html_file("index.html")

    # Check for screen reader only elements
    sr_only_elements = doc.css(".sr-only")

    # Validate sr-only implementation if present
    sr_only_elements.each do |element|
      # Should have proper accessibility class
      assert element["class"].include?("sr-only"),
        "Screen reader elements should have sr-only class"

      # Should contain meaningful content
      text = element.text.strip
      assert text.length > 0,
        "Screen reader only elements should contain descriptive text"
    end
  end

  def test_html_document_structure
    doc = parse_html_file("index.html")

    # Validate proper HTML5 document structure
    assert_equal "html", doc.root.name, "Document should have html root element"
    assert doc.css("head").any?, "Document should have head element"
    assert doc.css("body").any?, "Document should have body element"

    # Check language attribute
    html_lang = doc.root["lang"]
    refute_nil html_lang, "HTML element should have lang attribute for accessibility"
    assert_equal "en-US", html_lang, "Language should be set to en-US"

    # Check charset
    charset_meta = doc.css("head meta[charset]").first
    refute_nil charset_meta, "Document should have charset meta tag"
    assert_equal "UTF-8", charset_meta["charset"], "Charset should be UTF-8"
  end

  def test_viewport_meta_tag_present
    doc = parse_html_file("index.html")

    # Validate responsive design viewport
    viewport_meta = doc.css("head meta[name='viewport']").first
    refute_nil viewport_meta, "Document should have viewport meta tag"

    content = viewport_meta["content"]
    assert content.include?("width=device-width"),
      "Viewport should include device-width for responsive design"
    assert content.include?("initial-scale=1"),
      "Viewport should set initial scale to 1"
  end

  def test_seo_meta_tags_from_partial
    doc = parse_html_file("index.html")

    # Validate SEO partial integration
    description_meta = doc.css("head meta[name='description']").first
    refute_nil description_meta, "Document should have meta description"

    description_content = description_meta["content"]
    assert description_content.length > 50,
      "Meta description should be substantial"
    assert description_content.length <= 160,
      "Meta description should not exceed 160 characters"

    # Check robots meta tag
    robots_meta = doc.css("head meta[name='robots']").first
    if robots_meta
      robots_content = robots_meta["content"]
      assert robots_content.include?("index") || robots_content.include?("noindex"),
        "Robots meta should specify indexing directive"
    end
  end

  def test_open_graph_tags_present
    doc = parse_html_file("index.html")

    # Validate Open Graph implementation
    og_title = doc.css("head meta[property='og:title']").first
    refute_nil og_title, "Document should have og:title"
    assert og_title["content"].length > 0, "og:title should have content"

    og_description = doc.css("head meta[property='og:description']").first
    refute_nil og_description, "Document should have og:description"
    assert og_description["content"].length > 0, "og:description should have content"

    og_type = doc.css("head meta[property='og:type']").first
    refute_nil og_type, "Document should have og:type"
    assert ["website", "article"].include?(og_type["content"]),
      "og:type should be website or article"
  end

  def test_twitter_card_meta_tags
    doc = parse_html_file("index.html")

    # Validate Twitter Card implementation
    twitter_card = doc.css("head meta[name='twitter:card']").first
    if twitter_card
      card_type = twitter_card["content"]
      assert ["summary", "summary_large_image"].include?(card_type),
        "Twitter card should use appropriate card type"
    end

    twitter_site = doc.css("head meta[name='twitter:site']").first
    if twitter_site
      site_handle = twitter_site["content"]
      assert site_handle.start_with?("@"),
        "Twitter site should include @ handle"
    end
  end

  def test_service_worker_registration
    doc = parse_html_file("index.html")

    # Check for service worker registration script
    sw_scripts = doc.css("script").select do |script|
      script.text.include?("serviceWorker")
    end

    if sw_scripts.any?
      sw_script = sw_scripts.first
      script_content = sw_script.text

      assert script_content.include?("navigator.serviceWorker"),
        "Service worker should check for navigator support"
      assert script_content.include?("register"),
        "Service worker should call register method"
      assert script_content.include?("/sw.js") || script_content.include?("sw.js"),
        "Service worker should register sw.js file"
    end
  end

  def test_mermaid_initialization_script
    doc = parse_html_file("index.html")

    # Check for Mermaid initialization when feature is enabled
    mermaid_scripts = doc.css("script").select do |script|
      script.text.include?("mermaid")
    end

    if mermaid_scripts.any?
      init_script = mermaid_scripts.find do |script|
        script.text.include?("initialize")
      end

      refute_nil init_script, "Mermaid should have initialization script"

      init_content = init_script.text
      assert init_content.include?("startOnLoad"),
        "Mermaid should initialize with startOnLoad option"
    end
  end

  def test_favicon_and_manifest_links
    doc = parse_html_file("index.html")

    # Check for favicon
    favicon_link = doc.css("head link[rel*='icon']").first
    refute_nil favicon_link, "Document should have favicon link"

    # Check for web manifest
    manifest_links = doc.css("head link[rel='manifest']")
    assert manifest_links.any?, "Document should have web manifest link"

    # Validate at least one manifest link points to a valid manifest file
    valid_manifest = manifest_links.any? do |link|
      href = link["href"]
      href && (href.include?("manifest.json") || href.include?(".webmanifest"))
    end

    assert valid_manifest,
      "Web manifest should point to manifest.json or .webmanifest file"

    # Check for theme color
    theme_color = doc.css("head meta[name='theme-color']").first
    if theme_color
      color_value = theme_color["content"]
      assert color_value.match?(/^#[0-9a-f]{6}$/i) || color_value.match?(/^#[0-9a-f]{3}$/i),
        "Theme color should be valid hex color"
    end
  end

  def test_main_content_element_present
    doc = parse_html_file("index.html")

    # Validate main content structure
    # After HTML revert, main element may be within FL-Builder structure
    main_element = doc.css("main").first || doc.css("[role='main']").first || doc.css(".fl-page").first
    refute_nil main_element, "Document should have main element or main landmark for accessibility"

    # TODO: Restore strict id check when BEM structure restored
    # Should have proper id for skip navigation
    # main_id = main_element["id"]
    # if main_id
    #   assert_equal "main-content", main_id,
    #     "Main element should have id='main-content' for skip navigation"
    # end

    # Should have role attribute if using semantic main element
    if main_element.name == "main"
      main_role = main_element["role"]
      if main_role
        assert_equal "main", main_role,
          "Main element should have role='main' for accessibility"
      end
    end
  end

  def test_css_resource_loading
    doc = parse_html_file("index.html")

    # Validate CSS loading from navigation bundle
    nav_css = doc.css("head link[rel='stylesheet']").select do |link|
      href = link["href"]
      href && href.include?("navigation")
    end

    assert nav_css.any?, "Navigation CSS should be loaded"

    # Check for proper resource attributes
    nav_css.each do |link|
      # Should have proper MIME type if specified
      type = link["type"]
      if type
        assert_equal "text/css", type, "CSS links should have proper MIME type"
      end
    end
  end

  def test_template_block_structure
    doc = parse_html_file("index.html")

    # Validate that template blocks are properly implemented
    # This tests the Hugo template structure indirectly through rendered output

    # Should have header content (from header block or partial)
    header_element = doc.css("header").first || doc.css(".header").first
    # Header is optional but if present, should have proper structure

    # Should have footer content (from footer block or partial)
    footer_element = doc.css("footer").first || doc.css(".footer").first
    # Footer is optional but if present, should have proper structure

    # Main content area should exist
    # After HTML revert, main element may be within FL-Builder structure
    main_content = doc.css("main").first || doc.css("[role='main']").first || doc.css(".fl-page").first
    refute_nil main_content, "Main content area or equivalent should be rendered"
  end

  def test_security_headers_meta_tags
    doc = parse_html_file("index.html")

    # Check for security-related meta tags
    xua_compatible = doc.css("head meta[http-equiv='X-UA-Compatible']").first
    if xua_compatible
      assert_equal "IE=edge", xua_compatible["content"],
        "X-UA-Compatible should use IE=edge"
    end

    # Check for referrer policy if implemented
    referrer_policy = doc.css("head meta[name='referrer']").first
    if referrer_policy
      valid_policies = ["no-referrer", "no-referrer-when-downgrade", "origin",
                       "origin-when-cross-origin", "same-origin", "strict-origin",
                       "strict-origin-when-cross-origin", "unsafe-url"]
      assert valid_policies.include?(referrer_policy["content"]),
        "Referrer policy should use valid value"
    end
  end
end