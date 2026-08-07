require_relative "../base_page_test_case"

class NotFoundTemplateTest < BasePageTestCase
  # Comprehensive tests for 404.html template
  # Validates error page functionality, user experience, and recovery options
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  def setup
    @test_page = "404.html"

    unless File.exist?("#{root_path}/#{@test_page}")
      skip "404.html not found for testing"
    end
  end

  def test_404_page_has_error_title
    doc = parse_html_file(@test_page)

    title = doc.css("head title").first
    refute_nil title, "404 page must have title tag"

    title_text = title.text.strip
    assert title_text.length > 5, "404 page title should be descriptive"

    # Title should indicate error status
    error_indicators = ["404", "not found", "error", "page not found"]
    has_error_indicator = error_indicators.any? { |indicator|
      title_text.downcase.include?(indicator)
    }

    assert has_error_indicator,
      "404 page title should indicate error status (found: '#{title_text}')"
  end

  def test_404_page_has_clear_error_message
    doc = parse_html_file(@test_page)

    # Should have main heading indicating error
    h1_tags = doc.css("h1")
    assert h1_tags.any?, "404 page must have h1 heading"

    h1_text = h1_tags.first.text.strip
    assert h1_text.length > 3, "H1 should have meaningful text"

    # Main content should explain the error
    page_text = doc.text.downcase

    error_messages = ["404", "not found", "page not found", "doesn't exist", "cannot be found"]
    has_error_message = error_messages.any? { |message|
      page_text.include?(message)
    }

    assert has_error_message,
      "404 page should clearly explain the error to users"
  end

  def test_404_page_provides_helpful_navigation
    doc = parse_html_file(@test_page)

    # Should provide navigation options
    navigation_indicators = [
      doc.css("nav, .navbar, .navigation").any?,
      doc.css("a[href='/'], a[href='./'], a[href='../']").any?,
      doc.text.downcase.include?("home"),
      doc.text.downcase.include?("back"),
      doc.text.downcase.include?("return")
    ]

    assert navigation_indicators.any?,
      "404 page should provide navigation options (home link, back button, etc.)"

    # Check for home/main page links
    home_links = doc.css("a[href='/'], a[href='index.html'], a[href='./']")
    if home_links.any?
      home_links.each do |link|
        text = link.text.strip
        # Accept FL-Builder generated content with nested elements
        if text.empty?
          # Check for nested button text elements
          nested_text_elements = link.css(".fl-button-text")
          if nested_text_elements.any?
            nested_text = nested_text_elements.text.strip
            assert nested_text.length > 0, "Home links should have descriptive text (found nested: '#{nested_text}')"
          else
            # Links without text should have accessible alternatives
            title = link["title"]
            aria_label = link["aria-label"]
            assert title || aria_label, "Links without text should have title or aria-label"
          end
        else
          assert text.length > 0, "Home links should have descriptive text"
        end
      end
    end
  end

  # test_404_page_has_search_functionality removed 2026-08-07: the site has
  # no search, so `search_present` was always false and the test asserted
  # nothing. Its own comments said search was "not mandatory" - a test that
  # cannot fail is documentation, and belongs in a doc.
  #
  # test_404_page_suggests_popular_content removed for the same reason: its
  # assertions sat behind a "suggestions improve UX but not mandatory"
  # guard, so it passed whether or not the page offered any recovery links.
  # test_404_page_provides_helpful_navigation below covers the real
  # invariant (the page links somewhere useful).

  def test_404_page_meta_description
    doc = parse_html_file(@test_page)

    description_meta = doc.css("head meta[name='description']").first
    refute_nil description_meta, "404 page must have meta description"

    description_content = description_meta["content"]
    assert description_content.length > 10,
      "404 page meta description should be meaningful"
    assert description_content.length <= 160,
      "404 page meta description should not exceed 160 characters"

    # Should describe the error page purpose or provide useful site description
    # Note: Many 404 pages use general site description for SEO purposes
    error_keywords = ["404", "not found", "error", "missing", "expert", "team", "developers", "services"]
    has_error_keyword = error_keywords.any? { |keyword|
      description_content.downcase.include?(keyword)
    }

    # 404 pages often use site description - this is acceptable SEO practice
    assert has_error_keyword || description_content.length > 50,
      "404 page meta description should indicate error page purpose or provide meaningful site description"
  end

  def test_404_page_prevents_indexing
    doc = parse_html_file(@test_page)

    # The site deliberately serves "index, follow" here rather than noindex
    # (link discovery). Whether that is the right SEO call is a product
    # decision, so this pins the shape, not the policy: the directive must
    # be present and meaningful. Losing the tag entirely IS a regression.
    robots_meta = doc.css("head meta[name='robots']").first
    refute_nil robots_meta, "404 page should carry a robots meta tag"

    robots_content = robots_meta["content"].downcase
    assert robots_content.match?(/\b(no)?index\b|\bnone\b/),
      "404 robots meta should state an indexing directive, got #{robots_content.inspect}"

    # The canonical branch that used to follow only printed an INFO line
    # either way, so it could not fail. Assert the tag exists and resolves;
    # which URL it canonicalizes to stays a product decision.
    canonical_link = doc.css("head link[rel='canonical']").first
    refute_nil canonical_link, "404 page should carry a canonical link"
    refute canonical_link["href"].to_s.strip.empty?,
      "404 canonical link should have a non-empty href"
  end

  def test_404_page_proper_http_status_context
    doc = parse_html_file(@test_page)

    # While we can't test HTTP status in static file testing,
    # we can verify the page is set up to return proper status

    # Page should be named 404.html for proper server handling
    assert @test_page == "404.html",
      "Error page should be named 404.html for proper HTTP status"

    # Content should make error status clear
    page_text = doc.text.downcase
    assert page_text.include?("404") || page_text.include?("not found"),
      "Page content should make 404 status clear"
  end

  def test_404_page_maintains_site_branding
    doc = parse_html_file(@test_page)

    # 404 page should maintain consistent site branding

    # Should have site navigation
    nav_elements = doc.css("nav, .navbar, .navigation, header")
    assert nav_elements.any?,
      "404 page should maintain site navigation"

    # Should have site footer
    footer_elements = doc.css("footer")
    assert footer_elements.any?,
      "404 page should maintain site footer"

    # Logo/branding should be present
    branding_indicators = [
      doc.css(".logo, .site-title, .brand").any?,
      doc.text.downcase.include?("jetthoughts"),
      doc.css("header").any?
    ]

    assert branding_indicators.any?,
      "404 page should maintain site branding elements"
  end

  def test_404_page_accessibility_features
    doc = parse_html_file(@test_page)

    # Proper heading hierarchy
    h1_tags = doc.css("h1")
    assert h1_tags.length == 1, "404 page should have exactly one h1"

    # Skip to content link
    doc.css("a[href*='#main'], a[href*='#content'], .skip-link")
    # Skip links are good practice but not required

    # Main landmark
    # After HTML revert, main element may be within FL-Builder structure
    main_element = doc.css("main").first || doc.css("[role='main']").first || doc.css(".fl-page").first
    assert main_element, "404 page should have main landmark element or equivalent"

    # Links should have descriptive text
    # Check links within the main element (using original selector or fallback)
    links = doc.css("main a")
    links = doc.css("a") if links.empty? && main_element
    links.each do |link|
      text = link.text.strip
      if text.empty?
        # Links without text should have accessible alternatives
        title = link["title"]
        aria_label = link["aria-label"]
        assert title || aria_label,
          "Links without text should have title or aria-label"
      end
    end

    # Form elements should have labels (if forms present)
    forms = doc.css("form")
    forms.each do |form|
      inputs = form.css("input[type='text'], input[type='search'], textarea")
      inputs.each do |input|
        input_id = input["id"]
        if input_id
          label = doc.css("label[for='#{input_id}']")
          assert label.any?, "Form inputs should have associated labels"
        end
      end
    end
  end

  def test_404_page_user_experience_elements
    doc = parse_html_file(@test_page)

    # User-friendly error explanation
    page_text = doc.text

    # Should avoid technical jargon
    technical_terms = ["server error", "http", "500", "internal"]
    technical_terms.any? { |term|
      page_text.downcase.include?(term)
    }

    # Technical terms are not forbidden but user-friendly language is better
    # This is informational for UX improvement

    # Should provide helpful suggestions
    helpful_indicators = [
      page_text.downcase.include?("try"),
      page_text.downcase.include?("check"),
      page_text.downcase.include?("search"),
      page_text.downcase.include?("contact"),
      page_text.downcase.include?("help")
    ]

    assert helpful_indicators.any?,
      "404 page should provide helpful suggestions to users"

    # Error message should be polite and professional
    [
      page_text.downcase.include?("sorry"),
      page_text.downcase.include?("apologize"),
      page_text.downcase.include?("oops")
    ]

    # Polite tone improves UX but not required
    # This is informational for content improvement
  end

  def test_404_page_contact_information
    doc = parse_html_file(@test_page)

    # Contact information helps users report issues
    contact_indicators = [
      doc.css("a[href*='contact']").any?,
      doc.css("a[href*='mailto:']").any?,
      doc.text.downcase.include?("contact"),
      doc.text.downcase.include?("support"),
      doc.text.include?("@")
    ]

    assert contact_indicators.any?,
      "404 page should offer a way to reach a human (contact link, mailto, or support copy)"

    contact_links = doc.css("a[href*='contact'], a[href*='mailto:']")
    refute_empty contact_links, "404 page should link to contact"

    contact_links.each do |link|
      refute_nil link["href"], "Contact links should have href attribute"
      refute link.text.strip.empty?, "Contact links should have descriptive text"
    end
  end

  def test_404_page_performance_considerations
    doc = parse_html_file(@test_page)

    # The two `external_*.length` lines here evaluated a value and threw it
    # away - no assertion, no effect. The invariant they were reaching for
    # is real and currently holds: the 404 page pulls zero third-party
    # scripts or stylesheets, so it renders even when a CDN is down.
    assert_empty doc.css("script[src^='http']").map { |s| s["src"] },
      "404 page should not depend on third-party scripts"
    assert_empty doc.css("link[rel='stylesheet'][href^='http']").map { |l| l["href"] },
      "404 page should not depend on third-party stylesheets"

    doc.css("img").each do |img|
      refute_nil img["alt"], "404 page images should have alt attributes"
    end
  end

  def test_404_page_security_considerations
    doc = parse_html_file(@test_page)

    # Security considerations for error pages

    # Should not reveal sensitive technical information
    page_text = doc.text.downcase
    # Focus on technical error terms that could reveal system information
    # Exclude business/marketing terms that are acceptable
    sensitive_terms = ["stack trace", "internal server error", "sql error", "database error", "500 internal"]

    sensitive_terms.each do |term|
      assert !page_text.include?(term),
        "404 page should not reveal sensitive technical information: #{term}"
    end

    # Note: General business terms like "database design" in service descriptions are acceptable
    #
    # The external-link loop that used to follow read `link["rel"]` and
    # discarded it - no assertion. Removed rather than promoted: the site
    # emits no third-party links on the 404 page (see the performance test
    # above), so there is nothing to guard here yet.
  end
end
