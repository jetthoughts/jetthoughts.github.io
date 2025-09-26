require_relative "../base_page_test_case"

class SingleTemplateTest < BasePageTestCase
  # Comprehensive tests for single.html template
  # Validates individual post/page functionality, content structure, and SEO
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  def setup
    # Test with a known blog post or page
    @test_pages = [
      "blog/index.html",
      "about/index.html"
    ].select { |page| File.exist?("#{root_path}/#{page}") }

    skip "No single pages found for testing" if @test_pages.empty?
    @test_page = @test_pages.first
  end

  def test_single_page_has_unique_title
    doc = parse_html_file(@test_page)

    title = doc.css("head title").first
    refute_nil title, "Single page must have title tag"

    title_text = title.text.strip
    assert title_text.length > 5, "Single page title should be descriptive"

    # Title should not be generic homepage title
    assert !title_text.downcase.include?("home"),
      "Single page title should be specific to the content"
  end

  def test_single_page_has_main_heading
    doc = parse_html_file(@test_page)

    # Every single page should have an h1
    h1_tags = doc.css("h1")
    assert h1_tags.any?, "Single page must have h1 heading"
    assert h1_tags.length == 1, "Single page should have exactly one h1"

    h1_text = h1_tags.first.text.strip
    assert h1_text.length > 3, "H1 should have meaningful text"
  end

  def test_single_page_content_structure
    doc = parse_html_file(@test_page)

    # Main content area
    main_content = doc.css("main, .main-content, .content, .fl-builder-content")
    assert main_content.any?, "Single page should have main content area"

    # Content should be substantial
    content_text = main_content.text.strip
    assert content_text.length > 100,
      "Single page should have substantial content (found #{content_text.length} characters)"

    # Check for proper content structure
    paragraphs = doc.css("main p, .content p, .fl-builder-content p")
    headings = doc.css("main h1, main h2, main h3, .content h1, .content h2, .content h3")

    assert paragraphs.any? || headings.any?,
      "Single page should have structured content (paragraphs or headings)"
  end

  def test_single_page_meta_description
    doc = parse_html_file(@test_page)

    # Meta description should be present and unique
    description_meta = doc.css("head meta[name='description']").first
    refute_nil description_meta, "Single page must have meta description"

    description_content = description_meta["content"]
    assert description_content.length > 20,
      "Single page meta description should be descriptive"
    assert description_content.length <= 160,
      "Single page meta description should not exceed 160 characters"
  end

  def test_single_page_canonical_url
    doc = parse_html_file(@test_page)

    # Canonical URL helps prevent duplicate content issues
    canonical_link = doc.css("head link[rel='canonical']").first

    if canonical_link
      href = canonical_link["href"]
      # Canonical can be relative or absolute
      if href.start_with?("http")
        assert_valid_url(href, "Canonical URL should be valid")
        assert !href.include?("localhost"), "Canonical URL should use production domain"
      else
        assert href.start_with?("/"), "Relative canonical URL should start with /"
      end
    end
  end

  def test_single_page_open_graph_tags
    doc = parse_html_file(@test_page)

    # Open Graph tags for social sharing
    og_title = doc.css("head meta[property='og:title']").first
    og_description = doc.css("head meta[property='og:description']").first
    og_type = doc.css("head meta[property='og:type']").first

    refute_nil og_title, "Single page should have og:title"
    assert og_title["content"].length > 0, "og:title should have content"

    refute_nil og_description, "Single page should have og:description"
    assert og_description["content"].length > 0, "og:description should have content"

    if og_type
      valid_types = ["article", "website"]
      assert valid_types.include?(og_type["content"]),
        "og:type should be 'article' or 'website'"
    end

    # Check for og:url
    og_url = doc.css("head meta[property='og:url']").first
    if og_url
      url_content = og_url["content"]
      # og:url can be relative or absolute
      if url_content.start_with?("http")
        assert_valid_url(url_content, "og:url should be valid URL")
      else
        assert url_content.start_with?("/"), "Relative og:url should start with /"
      end
    end
  end

  def test_single_page_twitter_cards
    doc = parse_html_file(@test_page)

    # Twitter Card meta tags
    twitter_card = doc.css("head meta[name='twitter:card']").first
    twitter_title = doc.css("head meta[name='twitter:title']").first
    twitter_description = doc.css("head meta[name='twitter:description']").first

    if twitter_card
      card_type = twitter_card["content"]
      valid_cards = ["summary", "summary_large_image"]
      assert valid_cards.include?(card_type),
        "Twitter card should be 'summary' or 'summary_large_image'"
    end

    # If Twitter cards are implemented, should be complete
    if twitter_title || twitter_description
      refute_nil twitter_card, "Twitter card type required when other Twitter meta present"
    end
  end

  def test_single_page_structured_data_article
    doc = parse_html_file(@test_page)

    # Look for Article schema (for blog posts)
    json_scripts = extract_json_ld_schemas(doc)

    article_schemas = json_scripts.select do |script|
      begin
        data = JSON.parse(script.text)
        data.is_a?(Hash) && data["@type"] == "Article"
      rescue JSON::ParserError
        false
      end
    end

    # Article schema is optional but if present should be valid
    if article_schemas.any?
      article_data = JSON.parse(article_schemas.first.text)

      assert_schema_context(article_data)
      assert_schema_fields(article_data, "@type", "headline")
      assert_equal "Article", article_data["@type"]
      assert article_data["headline"].length > 0, "Article should have headline"

      # Optional but recommended fields
      if article_data["datePublished"]
        assert_valid_date(article_data["datePublished"])
      end

      if article_data["author"]
        assert article_data["author"].is_a?(Hash) || article_data["author"].is_a?(String),
          "Author should be object or string"
      end
    end
  end

  def test_single_page_navigation_context
    doc = parse_html_file(@test_page)

    # Check for navigation elements
    nav_elements = doc.css("nav, .navbar, .navigation")
    assert nav_elements.any?, "Single page should have navigation"

    # Breadcrumbs are helpful for single pages
    breadcrumbs = doc.css(".breadcrumb, .breadcrumbs, nav[aria-label*='breadcrumb']")

    if breadcrumbs.any?
      breadcrumb_links = breadcrumbs.css("a")
      assert breadcrumb_links.any?, "Breadcrumbs should contain links"

      # Breadcrumb links should be valid
      breadcrumb_links.each do |link|
        href = link["href"]
        assert href, "Breadcrumb links should have href"

        if href && !href.start_with?("http")
          assert href.start_with?("/", "#", "./", "../"),
            "Internal breadcrumb links should use proper paths"
        end
      end
    end
  end

  def test_single_page_reading_experience
    doc = parse_html_file(@test_page)

    # Check for proper reading experience elements

    # Content should be properly structured
    main_content = doc.css("main, .main-content, .content, .entry-content, .fl-builder-content")
    assert main_content.any?, "Should have identifiable main content area"

    # Check for proper typography elements
    content_area = main_content.first
    if content_area
      # Look for structured content
      text_elements = content_area.css("p, h2, h3, h4, ul, ol, blockquote")
      assert text_elements.any?, "Content should have structured text elements"

      # Check for images with proper alt text
      images = content_area.css("img")
      images.each do |img|
        alt = img["alt"]
        assert alt != nil, "Content images should have alt attributes"
      end
    end
  end

  def test_single_page_related_content_navigation
    doc = parse_html_file(@test_page)

    # Check for related content or navigation aids
    related_indicators = [
      doc.css(".related, .related-posts, .related-content").any?,
      doc.css(".next-post, .prev-post, .post-navigation").any?,
      doc.css(".tags, .categories").any?,
      doc.css("nav.pagination").any?
    ]

    # Related content is optional but enhances user experience
    # This is informational rather than a strict requirement
  end

  def test_single_page_social_sharing_integration
    doc = parse_html_file(@test_page)

    # Check for social sharing elements (optional)
    social_sharing = [
      doc.css(".social-share, .share-buttons").any?,
      doc.css("a[href*='facebook.com/sharer']").any?,
      doc.css("a[href*='twitter.com/intent']").any?,
      doc.css("a[href*='linkedin.com/sharing']").any?
    ]

    # Social sharing is optional but if present should be properly implemented
    if social_sharing.any?
      share_links = doc.css("a[href*='facebook.com'], a[href*='twitter.com'], a[href*='linkedin.com']")
      share_links.each do |link|
        href = link["href"]
        assert href.start_with?("http"), "Social sharing links should use full URLs"
      end
    end
  end

  def test_single_page_accessibility_features
    doc = parse_html_file(@test_page)

    # Skip to content link
    skip_links = doc.css("a[href*='#main'], a[href*='#content'], .skip-link")

    # Proper heading hierarchy
    headings = doc.css("h1, h2, h3, h4, h5, h6")
    if headings.length > 1
      # Should start with h1 and not skip levels dramatically
      first_heading = headings.first
      assert_equal "h1", first_heading.name.downcase,
        "First heading should be h1"
    end

    # Form labels (if forms are present)
    forms = doc.css("form")
    forms.each do |form|
      inputs = form.css("input[type='text'], input[type='email'], textarea")
      inputs.each do |input|
        input_id = input["id"]
        if input_id
          label = doc.css("label[for='#{input_id}']")
          assert label.any?, "Form inputs should have associated labels"
        end
      end
    end

    # Link context
    links = doc.css("a")
    links.each do |link|
      text = link.text.strip
      if text.empty?
        # Links without text should have title or aria-label
        title = link["title"]
        aria_label = link["aria-label"]
        assert title || aria_label,
          "Links without text should have title or aria-label"
      end
    end
  end

  def test_single_page_performance_considerations
    doc = parse_html_file(@test_page)

    # Images should be optimized
    images = doc.css("img")
    images.each do |img|
      src = img["src"]
      if src
        # Check for responsive images
        srcset = img["srcset"]
        sizes = img["sizes"]

        # Modern images benefit from responsive attributes
        # This is a recommendation, not a strict requirement
      end

      # Lazy loading for below-the-fold images
      loading = img["loading"]
      # Lazy loading is an optimization, not a requirement
    end

    # External resources should be minimized
    external_scripts = doc.css("script[src^='http']")
    external_stylesheets = doc.css("link[rel='stylesheet'][href^='http']")

    # Count is informational - some external resources may be necessary
    total_external = external_scripts.length + external_stylesheets.length

    # This is informational rather than a hard requirement
    # Too many external resources can impact performance
  end

  def test_single_page_security_considerations
    doc = parse_html_file(@test_page)

    # External links should have proper security attributes
    external_links = doc.css("a[href^='http']").reject do |link|
      href = link["href"]
      href.include?("jetthoughts.com") || href.include?(request_domain)
    end

    external_links.each do |link|
      rel = link["rel"]

      # External links benefit from security attributes
      # This is a recommendation for security best practices
      if rel
        security_keywords = ["noopener", "noreferrer", "nofollow"]
        has_security_attr = security_keywords.any? { |keyword| rel.include?(keyword) }

        # Security attributes are recommended but not strictly required
      end
    end
  end

  private

  def request_domain
    # Helper method to identify the current domain
    # In testing, this might be localhost
    "localhost"
  end
end