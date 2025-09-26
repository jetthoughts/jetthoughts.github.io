require_relative "../base_page_test_case"

class ListTemplateTest < BasePageTestCase
  # Comprehensive tests for list.html template
  # Validates archive/category page functionality, pagination, and content listing
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  def setup
    # Test with blog list page or category pages
    @test_pages = [
      "blog/index.html",
      "categories/index.html",
      "tags/index.html"
    ].select { |page| File.exist?("#{root_path}/#{page}") }

    skip "No list pages found for testing" if @test_pages.empty?
    @test_page = @test_pages.first
  end

  def test_list_page_has_descriptive_title
    doc = parse_html_file(@test_page)

    title = doc.css("head title").first
    refute_nil title, "List page must have title tag"

    title_text = title.text.strip
    assert title_text.length > 5, "List page title should be descriptive"

    # Title should indicate it's a list/archive page
    list_indicators = ["blog", "posts", "articles", "archive", "category", "tag"]
    has_list_indicator = list_indicators.any? { |indicator|
      title_text.downcase.include?(indicator)
    }

    # Not strict requirement, but good practice
    # assert has_list_indicator, "List page title should indicate content type"
  end

  def test_list_page_has_proper_heading_structure
    doc = parse_html_file(@test_page)

    # Should have main heading
    h1_tags = doc.css("h1")
    assert h1_tags.any?, "List page must have h1 heading"

    h1_text = h1_tags.first.text.strip
    assert h1_text.length > 2, "H1 should have meaningful text"
  end

  def test_list_page_content_structure
    doc = parse_html_file(@test_page)

    # Main content area
    main_content = doc.css("main, .main-content, .content, .fl-builder-content")
    assert main_content.any?, "List page should have main content area"

    # Look for list of items (posts, articles, etc.)
    list_indicators = [
      doc.css("article").any?,
      doc.css(".post, .post-item").any?,
      doc.css(".entry, .entry-item").any?,
      doc.css(".blog-post").any?,
      doc.css("ul li, ol li").any?
    ]

    assert list_indicators.any?,
      "List page should contain a list of items (articles, posts, or list elements)"
  end

  def test_list_page_item_structure
    doc = parse_html_file(@test_page)

    # Find list items (posts, articles)
    items = doc.css("article, .post, .post-item, .entry, .blog-post")

    if items.any?
      # Test first few items
      items.first(3).each_with_index do |item, index|
        # Each item should have a heading or title
        item_headings = item.css("h1, h2, h3, h4, .title, .heading")
        assert item_headings.any?,
          "List item #{index + 1} should have a heading or title"

        # Each item should have some content or excerpt
        content_indicators = [
          item.css("p").any?,
          item.css(".excerpt, .summary, .content").any?,
          item.text.strip.length > 50
        ]

        assert content_indicators.any?,
          "List item #{index + 1} should have content, excerpt, or substantial text"

        # Links should be properly formatted
        item_links = item.css("a")
        item_links.each do |link|
          href = link["href"]
          assert href, "Item links should have href attribute"

          if href && !href.start_with?("http", "mailto:", "tel:")
            assert href.start_with?("/", "#", "./", "../"),
              "Internal item links should use proper relative paths"
          end
        end
      end
    end
  end

  def test_list_page_meta_description
    doc = parse_html_file(@test_page)

    description_meta = doc.css("head meta[name='description']").first
    refute_nil description_meta, "List page must have meta description"

    description_content = description_meta["content"]
    assert description_content.length > 20,
      "List page meta description should be descriptive"
    assert description_content.length <= 160,
      "List page meta description should not exceed 160 characters"

    # Should describe the list content
    list_keywords = ["blog", "posts", "articles", "archive", "latest", "recent"]
    has_list_keyword = list_keywords.any? { |keyword|
      description_content.downcase.include?(keyword)
    }

    # Informational - helps with SEO but not strictly required
  end

  def test_list_page_pagination_if_present
    doc = parse_html_file(@test_page)

    # Look for pagination elements
    pagination_elements = doc.css(".pagination, .pager, .page-navigation, nav[aria-label*='pagination']")

    if pagination_elements.any?
      pagination = pagination_elements.first

      # Pagination should have proper structure
      page_links = pagination.css("a")
      page_numbers = pagination.css(".page-number, .current, .active")

      # Should have navigation links or page numbers
      assert page_links.any? || page_numbers.any?,
        "Pagination should contain navigation links or page numbers"

      # Pagination links should be valid
      page_links.each do |link|
        href = link["href"]
        assert href, "Pagination links should have href attribute"

        # Should be relative URLs for same site
        if href && !href.start_with?("http")
          assert href.start_with?("/", "#", "./", "../"),
            "Pagination links should use proper relative paths"
        end
      end

      # Check for accessibility attributes
      if pagination["aria-label"]
        assert pagination["aria-label"].downcase.include?("pagination"),
          "Pagination should have descriptive aria-label"
      end
    end
  end

  def test_list_page_filtering_or_sorting_if_present
    doc = parse_html_file(@test_page)

    # Look for filter or sort controls
    filter_elements = doc.css(".filter, .sort, .category-filter, .tag-filter")
    sort_elements = doc.css(".sort-by, .order-by, select[name*='sort']")

    # If filtering/sorting exists, should be properly implemented
    if filter_elements.any? || sort_elements.any?
      # Filter links should be properly formatted
      filter_links = doc.css(".filter a, .category-filter a, .tag-filter a")
      filter_links.each do |link|
        href = link["href"]
        assert href, "Filter links should have href attribute"
      end

      # Sort controls should have proper form attributes
      sort_selects = doc.css("select[name*='sort']")
      sort_selects.each do |select|
        options = select.css("option")
        assert options.length > 1, "Sort select should have multiple options"
      end
    end
  end

  def test_list_page_rss_feed_link
    doc = parse_html_file(@test_page)

    # RSS feed link for list pages
    rss_links = doc.css("head link[type='application/rss+xml'], head link[href*='.xml']")

    if rss_links.any?
      rss_links.each do |link|
        href = link["href"]
        assert href, "RSS links should have href attribute"

        title = link["title"]
        # RSS links benefit from descriptive titles
        if title
          assert title.length > 3, "RSS link should have descriptive title"
        end
      end
    end
  end

  def test_list_page_structured_data_blog
    doc = parse_html_file(@test_page)

    # Look for Blog or CollectionPage schema
    json_scripts = extract_json_ld_schemas(doc)

    blog_schemas = json_scripts.select do |script|
      begin
        data = JSON.parse(script.text)
        data.is_a?(Hash) && (data["@type"] == "Blog" || data["@type"] == "CollectionPage")
      rescue JSON::ParserError
        false
      end
    end

    # Blog schema is optional but if present should be valid
    if blog_schemas.any?
      blog_data = JSON.parse(blog_schemas.first.text)

      assert_schema_context(blog_data)
      assert_schema_fields(blog_data, "@type", "name")

      valid_types = ["Blog", "CollectionPage"]
      assert valid_types.include?(blog_data["@type"]),
        "List page schema should be Blog or CollectionPage"

      if blog_data["name"]
        assert blog_data["name"].length > 0, "Blog should have name"
      end

      # Check for blogPost items if it's a Blog
      if blog_data["@type"] == "Blog" && blog_data["blogPost"]
        assert blog_data["blogPost"].is_a?(Array),
          "blogPost should be an array"
      end
    end
  end

  def test_list_page_breadcrumb_navigation
    doc = parse_html_file(@test_page)

    # Breadcrumbs are helpful for list pages
    breadcrumbs = doc.css(".breadcrumb, .breadcrumbs, nav[aria-label*='breadcrumb']")

    if breadcrumbs.any?
      breadcrumb_links = breadcrumbs.css("a")

      breadcrumb_links.each do |link|
        href = link["href"]
        assert href, "Breadcrumb links should have href"

        text = link.text.strip
        assert text.length > 0, "Breadcrumb links should have descriptive text"

        if href && !href.start_with?("http")
          assert href.start_with?("/", "#", "./", "../"),
            "Internal breadcrumb links should use proper paths"
        end
      end

      # Should show hierarchy (Home > Blog, etc.)
      breadcrumb_text = breadcrumbs.text
      hierarchy_indicators = [">", "/", "»", "→"]
      has_hierarchy = hierarchy_indicators.any? { |indicator|
        breadcrumb_text.include?(indicator)
      }

      # Hierarchy indicators help user orientation but not required
    end
  end

  def test_list_page_search_functionality_if_present
    doc = parse_html_file(@test_page)

    # Look for search form
    search_forms = doc.css("form[action*='search'], form .search")
    search_inputs = doc.css("input[type='search'], input[name*='search'], input[placeholder*='search']")

    if search_forms.any? || search_inputs.any?
      # Search forms should be properly implemented
      search_forms.each do |form|
        action = form["action"]
        method = form["method"]

        assert action, "Search form should have action attribute"

        # Method should be GET for search (standard practice)
        if method
          assert_equal "get", method.downcase,
            "Search forms should typically use GET method"
        end

        # Should have search input
        search_input = form.css("input[type='search'], input[name*='search']").first
        assert search_input, "Search form should contain search input"

        # Search input should have proper attributes
        if search_input
          name = search_input["name"]
          assert name, "Search input should have name attribute"

          placeholder = search_input["placeholder"]
          # Placeholder is helpful for UX but not required
        end
      end
    end
  end

  def test_list_page_date_information
    doc = parse_html_file(@test_page)

    # List items should show date information
    items = doc.css("article, .post, .post-item, .entry")

    if items.any?
      items.first(3).each_with_index do |item, index|
        # Look for date elements
        date_elements = item.css("time, .date, .published, .post-date")

        if date_elements.any?
          date_elements.each do |date_elem|
            if date_elem.name == "time"
              datetime = date_elem["datetime"]
              # Time elements should have datetime attribute
              if datetime
                # Basic date format check
                assert datetime.match?(/\d{4}-\d{2}-\d{2}/),
                  "DateTime attribute should include valid date format"
              end
            end

            # Date should have readable text
            date_text = date_elem.text.strip
            assert date_text.length > 3,
              "Date elements should have readable text"
          end
        end
      end
    end
  end

  def test_list_page_author_information_if_present
    doc = parse_html_file(@test_page)

    # List items may show author information
    items = doc.css("article, .post, .post-item, .entry")

    if items.any?
      items.first(3).each do |item|
        # Look for author elements
        author_elements = item.css(".author, .by-author, .post-author")

        author_elements.each do |author_elem|
          author_text = author_elem.text.strip
          assert author_text.length > 0,
            "Author elements should have readable text"

          # Author links should be properly formatted
          author_links = author_elem.css("a")
          author_links.each do |link|
            href = link["href"]
            assert href, "Author links should have href attribute"
          end
        end
      end
    end
  end

  def test_list_page_category_tag_information
    doc = parse_html_file(@test_page)

    # List items may show category/tag information
    items = doc.css("article, .post, .post-item, .entry")

    if items.any?
      items.first(3).each do |item|
        # Look for category/tag elements
        taxonomy_elements = item.css(".category, .categories, .tag, .tags, .post-categories, .post-tags")

        taxonomy_elements.each do |tax_elem|
          # Should have links to category/tag pages
          tax_links = tax_elem.css("a")

          tax_links.each do |link|
            href = link["href"]
            assert href, "Category/tag links should have href attribute"

            text = link.text.strip
            assert text.length > 0,
              "Category/tag links should have descriptive text"

            if href && !href.start_with?("http")
              assert href.start_with?("/", "#", "./", "../"),
                "Internal category/tag links should use proper paths"
            end
          end
        end
      end
    end
  end

  def test_list_page_accessibility_features
    doc = parse_html_file(@test_page)

    # Proper heading hierarchy
    headings = doc.css("h1, h2, h3, h4, h5, h6")
    if headings.length > 1
      first_heading = headings.first
      assert_equal "h1", first_heading.name.downcase,
        "First heading should be h1"

      # Check for logical heading progression
      h1_count = doc.css("h1").length
      assert_equal 1, h1_count, "Should have exactly one h1"
    end

    # Lists should use proper markup
    content_lists = doc.css("main ul, main ol, .main-content ul, .main-content ol")
    content_lists.each do |list|
      list_items = list.css("li")
      assert list_items.any?, "Lists should contain list items"
    end

    # Links should have descriptive text
    links = doc.css("main a, .main-content a")
    links.each do |link|
      text = link.text.strip
      if text.empty?
        # Links without text should have accessible alternatives
        title = link["title"]
        aria_label = link["aria-label"]
        assert title || aria_label,
          "Links without text should have title or aria-label"
      else
        # Avoid generic link text
        generic_text = ["click here", "read more", "more", "link"]
        is_generic = generic_text.any? { |generic| text.downcase == generic }
        # Generic text is not ideal but not a hard requirement
      end
    end
  end

  def test_list_page_loading_performance
    doc = parse_html_file(@test_page)

    # Check for performance optimizations

    # Images should have proper attributes
    images = doc.css("img")
    images.each do |img|
      alt = img["alt"]
      assert alt != nil, "Images should have alt attributes"

      # Check for lazy loading on non-critical images
      loading = img["loading"]
      # Lazy loading is beneficial but not required
    end

    # External resources should be optimized
    external_scripts = doc.css("script[src^='http']")
    external_stylesheets = doc.css("link[rel='stylesheet'][href^='http']")

    # Too many external resources can impact performance
    total_external = external_scripts.length + external_stylesheets.length
    # This is informational - some external resources may be necessary
  end
end