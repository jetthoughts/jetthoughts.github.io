require_relative "../base_page_test_case"

class SingleTemplateTest < BasePageTestCase
  # Comprehensive tests for single.html template
  # Validates individual post/page functionality, content structure, and SEO
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  # A real single page. The list came first in the old array as
  # "blog/index.html", so `@test_pages.first` resolved to the blog LIST page
  # and this entire file - 376 lines nominally covering single.html - tested
  # the list template instead. `about/index.html` (an alias stub) never got a
  # look in. Same post article_schema_test uses, so one page serves both.
  SINGLE_PAGE = "blog/devtools-for-ai-agents/index.html"

  def setup
    # Was `skip "No single pages found"`. A missing blog post here means the
    # build stopped emitting posts, which is the regression, not a reason to
    # report green on every test in the file.
    assert File.exist?("#{root_path}/#{SINGLE_PAGE}"),
      "Build did not emit #{SINGLE_PAGE} - single-page coverage cannot run"
    @test_page = SINGLE_PAGE
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

    refute_nil canonical_link, "Single page should have a canonical link"

    href = canonical_link["href"]
    # Canonical can be relative or absolute
    if href.start_with?("http")
      assert_valid_url(href, "Canonical URL should be valid")
    else
      assert href.start_with?("/"), "Relative canonical URL should start with /"
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

    refute_nil twitter_card, "Single page should have a twitter:card meta tag"
    assert ["summary", "summary_large_image"].include?(twitter_card["content"]),
      "Twitter card should be 'summary' or 'summary_large_image'"

    # A card without a title or description renders as an empty preview.
    assert twitter_title || twitter_description,
      "twitter:card should be accompanied by a title or description"
  end

  def test_single_page_structured_data_article
    doc = parse_html_file(@test_page)

    # Look for Article schema (for blog posts)
    json_scripts = extract_json_ld_schemas(doc)

    article_schemas = json_scripts.select do |script|
      data = JSON.parse(script.text)
      data.is_a?(Hash) && data["@type"] == "Article"
    rescue JSON::ParserError
      false
    end

    refute_empty article_schemas, "Blog post should publish Article schema"

    article_data = JSON.parse(article_schemas.first.text)

    assert_schema_context(article_data)
    assert_schema_fields(article_data, "@type", "headline")
    assert_equal "Article", article_data["@type"]
    assert article_data["headline"].length > 0, "Article should have headline"

    # datePublished and author drive the article rich result; a post that
    # loses either drops out of it silently.
    refute_nil article_data["datePublished"], "Article schema should carry datePublished"
    assert_valid_date(article_data["datePublished"])

    refute_nil article_data["author"], "Article schema should carry an author"
    assert article_data["author"].is_a?(Hash) || article_data["author"].is_a?(String),
      "Author should be object or string"
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
        assert !alt.nil?, "Content images should have alt attributes"
      end
    end
  end

  def test_single_page_related_content_navigation
    doc = parse_html_file(@test_page)

    # Check for related content or navigation aids
    [
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

    assert social_sharing.any?, "Blog post should offer social sharing"

    share_links = doc.css("a[href*='facebook.com'], a[href*='twitter.com'], a[href*='linkedin.com']")
    refute_empty share_links, "Social sharing should render actual share links"

    share_links.each do |link|
      assert link["href"].start_with?("http"), "Social sharing links should use full URLs"
    end
  end

  def test_single_page_accessibility_features
    doc = parse_html_file(@test_page)

    # Skip-to-content link. The old version of this line called doc.css and
    # discarded the result, asserting nothing.
    refute_empty doc.css("a[href*='#main'], a[href*='#content'], .skip-link"),
      "Single page should offer a skip-to-content link"

    # Proper heading hierarchy
    headings = doc.css("h1, h2, h3, h4, h5, h6")
    refute_empty headings, "Single page should use headings"
    assert_equal "h1", headings.first.name.downcase, "First heading should be h1"

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

    # Link context. An image-only link takes its accessible name from the
    # image's alt text (WCAG 2.1 SC 1.1.1 / 2.4.4), so alt counts alongside
    # title and aria-label. Blog posts wrap YouTube thumbnails this way; the
    # old rule flagged them, but only ever ran against the blog LIST page,
    # which has no such links - so it never surfaced.
    doc.css("a").each do |link|
      next unless link.text.strip.empty?

      accessible_name = link["title"] ||
        link["aria-label"] ||
        link.css("img").map { |img| img["alt"].to_s.strip }.find { |alt| !alt.empty? }

      assert accessible_name,
        "Links without text need a title, aria-label, or an image with alt text " \
        "(href=#{link["href"].inspect})"
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
        img["srcset"]
        img["sizes"]

        # Modern images benefit from responsive attributes
        # This is a recommendation, not a strict requirement
      end

      # Lazy loading for below-the-fold images
      img["loading"]
      # Lazy loading is an optimization, not a requirement
    end

    # External resources should be minimized
    external_scripts = doc.css("script[src^='http']")
    external_stylesheets = doc.css("link[rel='stylesheet'][href^='http']")

    # Count is informational - some external resources may be necessary
    external_scripts.length + external_stylesheets.length

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
        security_keywords.any? { |keyword| rel.include?(keyword) }

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
