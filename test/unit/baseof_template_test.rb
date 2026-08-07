require_relative "../base_page_test_case"

class BaseofTemplateTest < BasePageTestCase
  # Comprehensive tests for baseof.html template
  # Validates security, accessibility, and architectural improvements
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  # Mermaid loads only on pages that render a diagram, never on index.html.
  MERMAID_PAGE = "blog/hidden-cost-poor-development-vendor-management-fix/index.html"

  # Mermaid is self-hosted from themes/beaver/static/js/vendor (2026-08-01),
  # which retires the jsdelivr CDN + SRI pin this test used to assert. It
  # ran on index.html, which never loads mermaid at all, so the whole body
  # sat inside a guard that was permanently false - and every assertion in
  # it described the CDN implementation that no longer exists. Same security
  # intent, current implementation: the script must be same-origin, so no
  # third party can swap it.
  def test_mermaid_script_is_self_hosted
    doc = parse_html_file(MERMAID_PAGE)

    mermaid_scripts = doc.css("script[src*='mermaid']")
    refute_empty mermaid_scripts, "Mermaid page should load the mermaid bundle"

    src = mermaid_scripts.first["src"]
    assert src.start_with?("/"), "Mermaid must be served same-origin, got #{src.inspect}"
    refute_match %r{^https?://}, src, "Mermaid must not be loaded from a third-party CDN"
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

  # test_logo_styles_in_external_css removed 2026-08-07: it guarded every
  # assertion behind `doc.css(".logo-image-main").any?`, and that class no
  # longer exists anywhere in themes/ or layouts/. Zero assertions ran, and
  # the test reported green.

  def test_accessibility_skip_link
    doc = parse_html_file("index.html")

    skip_link = doc.at_css("a.skip-link")
    assert skip_link, "Page should have a skip navigation link"

    assert_equal "#main-content", skip_link["href"],
      "Skip link should point to main content"
    assert skip_link.text.strip.length > 0,
      "Skip link should have descriptive text"
  end

  def test_screen_reader_utilities_present
    doc = parse_html_file("index.html")

    # Check for screen reader only elements. The presence assertion is the
    # point: PurgeCSS dropped .sr-only from the production nav bundle once
    # (2026-07-19), and an `each` over an empty set would have said nothing.
    sr_only_elements = doc.css(".sr-only")
    refute_empty sr_only_elements, "Page should render screen-reader-only elements"

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
    refute_nil robots_meta, "Page should have a robots meta tag"

    robots_content = robots_meta["content"]
    assert robots_content.include?("index") || robots_content.include?("noindex"),
      "Robots meta should specify indexing directive"
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
    refute_nil twitter_card, "Page should have a twitter:card meta tag"
    assert ["summary", "summary_large_image"].include?(twitter_card["content"]),
      "Twitter card should use appropriate card type"

    twitter_site = doc.css("head meta[name='twitter:site']").first
    refute_nil twitter_site, "Page should have a twitter:site meta tag"
    assert twitter_site["content"].start_with?("@"),
      "Twitter site should include @ handle"
  end

  def test_service_worker_registration
    doc = parse_html_file("index.html")

    # Check for service worker registration script
    sw_scripts = doc.css("script").select do |script|
      script.text.include?("serviceWorker")
    end

    refute_empty sw_scripts, "Page should register a service worker"

    script_content = sw_scripts.first.text
    assert script_content.include?("navigator.serviceWorker"),
      "Service worker should check for navigator support"
    assert script_content.include?("register"),
      "Service worker should call register method"
    assert script_content.include?("sw.js"),
      "Service worker should register sw.js file"
  end

  # Ran against index.html, which never loads mermaid - the guard was
  # permanently false and no assertion ever executed. Points at a page that
  # actually renders a diagram now.
  def test_mermaid_initialization_script
    doc = parse_html_file(MERMAID_PAGE)

    mermaid_scripts = doc.css("script").select do |script|
      script.text.include?("mermaid")
    end
    refute_empty mermaid_scripts, "Mermaid page should carry mermaid scripts"

    init_script = mermaid_scripts.find { |script| script.text.include?("initialize") }
    refute_nil init_script, "Mermaid should have initialization script"

    assert init_script.text.include?("startOnLoad"),
      "Mermaid should initialize with startOnLoad option"
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

  def test_page_has_css
    doc = parse_html_file("index.html")

    has_css = doc.css("head link[rel='stylesheet']").any? || doc.css("head style").any?
    assert has_css, "Page should include CSS styles"
  end

  def test_template_block_structure
    doc = parse_html_file("index.html")

    # Validate that template blocks are properly implemented
    # This tests the Hugo template structure indirectly through rendered output

    # Should have header content (from header block or partial)
    doc.css("header").first || doc.css(".header").first
    # Header is optional but if present, should have proper structure

    # Should have footer content (from footer block or partial)
    doc.css("footer").first || doc.css(".footer").first
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
    refute_nil xua_compatible, "Page should have an X-UA-Compatible meta tag"
    assert_equal "IE=edge", xua_compatible["content"],
      "X-UA-Compatible should use IE=edge"

    # The referrer-policy branch that used to live here was dead: the site
    # emits no <meta name="referrer">, so it asserted nothing. Add it back
    # with a presence assertion if a referrer policy is ever shipped.
  end
end
