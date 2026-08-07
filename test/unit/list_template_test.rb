require_relative "../base_page_test_case"

class ListTemplateTest < BasePageTestCase
  # Comprehensive tests for list.html template
  # Validates archive/category page functionality, pagination, and content listing
  # Implements TDD coverage per /knowledge/20.01-tdd-methodology-reference.md

  # One selector, used by every test that walks the listed posts. Before
  # this, test_list_page_date_information used a list missing `.blog-post` -
  # the ONLY class the page actually renders - so it matched zero items on
  # every run, and its `if items.any?` guard made that look like a pass.
  ITEM_SELECTOR = "article, .post, .post-item, .entry, .blog-post"

  def setup
    # Test with blog list page or category pages
    @test_pages = [
      "blog/index.html",
      "categories/index.html",
      "tags/index.html"
    ].select { |page| File.exist?("#{root_path}/#{page}") }

    # Was `skip "No list pages found"`. The blog index is a core page; if the
    # build stops emitting every list page, that is the regression, not a
    # reason to report green on 13 tests.
    refute_empty @test_pages, "Build emitted no list pages at all (blog/, categories/, tags/)"
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
    list_indicators.any? { |indicator|
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
    items = doc.css(ITEM_SELECTOR)

    # A blog index that lists nothing is the headline failure for this page,
    # and the old `if items.any?` guard made it the quietest.
    refute_empty items, "List page should render post items"

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
      item.css("a").each do |link|
        href = link["href"]
        assert href, "Item links should have href attribute"

        if href && !href.start_with?("http", "mailto:", "tel:")
          assert href.start_with?("/", "#", "./", "../"),
            "Internal item links should use proper relative paths"
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
    list_keywords.any? { |keyword|
      description_content.downcase.include?(keyword)
    }

    # Informational - helps with SEO but not strictly required
  end

  # The blog index IS paginated (204 paginator pages), so the old
  # "_if_present" guard was hiding a real invariant behind an optional one.
  def test_list_page_pagination
    doc = parse_html_file(@test_page)

    pagination_elements = doc.css(".pagination, .pager, .page-navigation, nav[aria-label*='pagination']")
    refute_empty pagination_elements, "Blog list page should render pagination"

    pagination = pagination_elements.first
    page_links = pagination.css("a")

    assert page_links.any? || pagination.css(".page-number, .current, .active").any?,
      "Pagination should contain navigation links or page numbers"

    page_links.each do |link|
      href = link["href"]
      assert href, "Pagination links should have href attribute"

      if href && !href.start_with?("http")
        assert href.start_with?("/", "#", "./", "../"),
          "Pagination links should use proper relative paths"
      end
    end
  end

  # Removed 2026-08-07. Each guarded every assertion behind a feature this
  # site does not render, so none of them could fail:
  #
  #   test_list_page_filtering_or_sorting_if_present - no .filter / .sort /
  #     select[name*=sort] anywhere in the build.
  #   test_list_page_rss_feed_link - the list page <head> carries no
  #     application/rss+xml link and no *.xml link at all. (Whether it SHOULD
  #     is a separate SEO question; a test that passes either way answers it
  #     for nobody.)
  #   test_list_page_search_functionality_if_present - the site has no search.
  #   test_list_page_breadcrumb_navigation - no .breadcrumb/.breadcrumbs
  #     elements. The JSON-LD BreadcrumbList the page DOES emit is covered by
  #     test/unit/meta_tags/breadcrumb_schema_test.rb.
  #   test_list_page_author_information_if_present - no .author elements.
  #   test_list_page_category_tag_information - no .category/.tag elements.
  #
  # Bring any of them back with a presence assertion on the day the feature
  # ships, not before.

  # The list page emits Organization + Article + BreadcrumbList, NOT Blog or
  # CollectionPage - so the old version of this test selected an empty set
  # and skipped every assertion. Assert what the page actually publishes:
  # each JSON-LD block must be parseable and typed. Malformed JSON-LD fails
  # silently in production (Google drops the result, the page renders fine).
  def test_list_page_structured_data_is_valid
    doc = parse_html_file(@test_page)
    scripts = extract_json_ld_schemas(doc)

    refute_empty scripts, "List page should publish JSON-LD structured data"

    scripts.each do |script|
      data = assert_valid_json(script.text, "List page JSON-LD")
      refute_nil data["@type"], "Each JSON-LD block should declare an @type"
      assert_schema_context(data)
    end
  end

  # Every listed post carries a date today. Three nested guards used to make
  # "no dates rendered at all" indistinguishable from "all dates valid".
  def test_list_page_date_information
    doc = parse_html_file(@test_page)

    items = doc.css(ITEM_SELECTOR)
    refute_empty items, "List page should render post items"

    items.first(3).each_with_index do |item, index|
      date_elements = item.css("time, .date, .published, .post-date")
      refute_empty date_elements, "List item #{index + 1} should show a date"

      date_elements.each do |date_elem|
        if date_elem.name == "time"
          datetime = date_elem["datetime"]
          refute_nil datetime, "<time> elements should carry a datetime attribute"
          assert datetime.match?(/\d{4}-\d{2}-\d{2}/),
            "DateTime attribute should include valid date format"
        end

        assert date_elem.text.strip.length > 3,
          "Date elements should have readable text"
      end
    end
  end

  def test_list_page_accessibility_features
    doc = parse_html_file(@test_page)

    # Proper heading hierarchy
    headings = doc.css("h1, h2, h3, h4, h5, h6")
    refute_empty headings, "List page should use headings"

    assert_equal "h1", headings.first.name.downcase, "First heading should be h1"
    assert_equal 1, doc.css("h1").length, "Should have exactly one h1"

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
      end
    end
  end

  def test_list_page_loading_performance
    doc = parse_html_file(@test_page)

    doc.css("img").each do |img|
      refute_nil img["alt"], "Images should have alt attributes"
    end

    # The two `external_*` lines that used to end this test computed a sum
    # and discarded it. The invariant behind them is real and holds: the
    # list page pulls no third-party scripts or stylesheets, so it renders
    # even when a CDN is down.
    assert_empty doc.css("script[src^='http']").map { |s| s["src"] },
      "List page should not depend on third-party scripts"
    assert_empty doc.css("link[rel='stylesheet'][href^='http']").map { |l| l["href"] },
      "List page should not depend on third-party stylesheets"
  end
end
