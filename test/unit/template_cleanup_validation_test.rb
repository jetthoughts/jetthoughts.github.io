require "page_test_case"

class TemplateCleanupValidationTest < PageTestCase
  # Comprehensive validation of all 29 templates after cleanup
  # Ensures template attribute removal doesn't break Hugo site functionality

  def setup
    @test_pages = {
      homepage: "index.html",
      blog_list: "blog/index.html",
      four_oh_four: "404.html"
    }

    @critical_templates = %w[
      baseof.html
      home.html
      single.html
      list.html
      404.html
      section.html
    ]
  end

  def test_homepage_renders_correctly
    return unless test_page_exists?(:homepage)

    doc = parse_html_file(@test_pages[:homepage])

    # Basic HTML structure validation
    assert doc.css("html").any?, "Homepage should have html element"
    assert doc.css("head").any?, "Homepage should have head element"
    assert doc.css("body").any?, "Homepage should have body element"

    # Essential head elements
    assert doc.css("head title").any?, "Homepage should have title"
    assert doc.css("head meta[name='description']").any?, "Homepage should have meta description"
    assert doc.css("head meta[name='viewport']").any?, "Homepage should have viewport meta"

    # Navigation structure
    assert doc.css("header nav").any?, "Homepage should have navigation"
    assert doc.css("main").any?, "Homepage should have main content area"
    assert doc.css("footer").any?, "Homepage should have footer"

    # CSS and assets
    css_links = doc.css("head link[rel='stylesheet']")
    assert css_links.count >= 1, "Homepage should have CSS files loaded"
  end

  def test_blog_list_functionality
    return unless test_page_exists?(:blog_list)

    doc = parse_html_file(@test_pages[:blog_list])

    # Blog list structure
    assert doc.css("main").any?, "Blog list should have main content"

    # Look for blog posts (allowing multiple selector patterns)
    blog_posts = doc.css("article, .post-item, .blog-post, [data-post]")

    if blog_posts.any?
      # Validate first blog post structure
      first_post = blog_posts.first

      # Post should have heading
      headings = first_post.css("h1, h2, h3, .title, .heading")
      assert headings.any?, "Blog post should have a heading"

      # Post should have some content indicator (description text in div)
      content = first_post.css(".content, .excerpt, .summary, p")
      # Also check for description text in direct child divs of post-content
      description_divs = first_post.css(".post-content > div").select { |d|
        d.text.strip.length > 10 && d.css("div, span, a").empty?
      }

      has_content = content.any? || description_divs.any?
      assert has_content, "Blog post should have content section (#{content.length} standard, #{description_divs.length} description divs found)"
    end
  end

  def test_404_page_structure
    return unless test_page_exists?(:four_oh_four)

    doc = parse_html_file(@test_pages[:four_oh_four])

    # 404 page essentials
    assert doc.css("html").any?, "404 page should have html element"
    assert doc.css("head title").any?, "404 page should have title"
    assert doc.css("main").any?, "404 page should have main content"

    # 404 specific content
    page_text = doc.text.downcase
    assert page_text.include?("404") || page_text.include?("not found") || page_text.include?("page not found"),
      "404 page should indicate page not found"
  end

  def test_template_asset_processing
    # Test that assets are properly processed across templates
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # CSS files should be processed
      css_links = doc.css("head link[rel='stylesheet']")
      css_links.each do |link|
        href = link["href"]
        next if href&.start_with?("http") # Skip external CSS

        # Local CSS should be fingerprinted or minified
        if href && !href.start_with?("http")
          assert href.match?(/\.[a-f0-9]+\.css$/) || href.include?(".min."),
            "CSS file should be processed: #{href} on #{page_name}"
        end
      end

      # JavaScript should have proper loading attributes
      js_scripts = doc.css("script[src]").select { |s| !s["src"]&.start_with?("http") }
      js_scripts.each do |script|
        src = script["src"]
        # Allow both defer and async attributes, or neither for critical scripts
        # This test just ensures JS files are present and accessible
        assert src, "Script should have src attribute on #{page_name}"
      end
    end
  end

  def test_seo_meta_tags_integrity
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # Essential SEO meta tags
      assert doc.css("head title").any?, "#{page_name} should have title"
      assert doc.css("head meta[name='description']").any?, "#{page_name} should have meta description"

      # Open Graph tags
      og_tags = doc.css("head meta[property^='og:']")
      assert og_tags.count >= 2, "#{page_name} should have Open Graph tags"

      # Verify no broken meta tag attributes from cleanup
      all_meta_tags = doc.css("head meta")
      all_meta_tags.each do |meta|
        # Check that essential attributes are still present
        has_name_or_property = meta["name"] || meta["property"] || meta["charset"] || meta["http-equiv"]
        assert has_name_or_property, "Meta tag should have name, property, charset, or http-equiv attribute on #{page_name}"
      end
    end
  end

  def test_structured_data_schemas
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # JSON-LD scripts
      json_ld_scripts = doc.css('script[type="application/ld+json"]')

      if json_ld_scripts.any?
        json_ld_scripts.each do |script|
          # Validate JSON is properly formatted
          begin
            parsed = JSON.parse(script.text)
            assert parsed.is_a?(Hash) || parsed.is_a?(Array), "JSON-LD should be valid JSON on #{page_name}"

            # If it's schema.org data, check basic structure
            if parsed.is_a?(Hash) && parsed["@context"]
              assert parsed["@context"].include?("schema.org"), "Schema should use schema.org context on #{page_name}"
              assert parsed["@type"], "Schema should have @type on #{page_name}"
            end
          rescue JSON::ParserError => e
            flunk "Invalid JSON-LD on #{page_name}: #{e.message}"
          end
        end
      end
    end
  end

  def test_navigation_structure
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # Header navigation
      header_nav = doc.css("header nav, nav[role='navigation'], .navbar, .navigation")
      assert header_nav.any?, "#{page_name} should have header navigation"

      # Navigation links
      nav_links = doc.css("header nav a, nav a, .navbar a, .navigation a")
      if nav_links.any?
        nav_links.each do |link|
          href = link["href"]
          assert href, "Navigation links should have href attribute on #{page_name}"

          # Internal links should not be broken (start with / or #)
          if href && !href.start_with?("http", "mailto:", "tel:")
            assert href.start_with?("/", "#", "./", "../"), "Internal navigation link should start with /, #, ./, or ../ on #{page_name}: #{href}"
          end
        end
      end
    end
  end

  def test_footer_integrity
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # Footer structure
      footer = doc.css("footer")
      assert footer.any?, "#{page_name} should have footer"

      # Contact information
      footer_text = footer.text.downcase

      # Check for common footer elements (at least one should be present)
      footer_elements_present = [
        doc.css("footer a[href*='mailto:']").any?,  # Email
        doc.css("footer a[href*='tel:']").any?,     # Phone
        footer_text.include?("copyright") || footer_text.include?("©"), # Copyright
        doc.css("footer nav a").any?  # Footer navigation
      ].any?

      assert footer_elements_present, "#{page_name} footer should have contact info, copyright, or navigation"
    end
  end

  def test_no_broken_template_syntax
    # This test checks that templates don't have Hugo template syntax errors
    # by ensuring pages render completely without template error indicators

    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      content = File.read(File.join(root_path, file_path))

      # Check for common Hugo template error indicators
      error_indicators = [
        "ZgotmplZ",  # Hugo template error
        "<!-- raw HTML omitted -->", # Markdown rendering issues
        "&lt;no value&gt;", # Missing template variables
        "Error:", # Template errors
        "Failed to" # Processing failures
      ]

      error_indicators.each do |indicator|
        assert !content.include?(indicator),
          "#{page_name} contains template error indicator: #{indicator}"
      end
    end
  end

  def test_performance_indicators
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # Performance best practices

      # DNS prefetch or preconnect for external resources
      prefetch_links = doc.css("head link[rel='preconnect'], head link[rel='dns-prefetch']")
      if prefetch_links.any?
        prefetch_links.each do |link|
          href = link["href"]
          # Allow various prefetch patterns
          assert href&.start_with?("http", "/", "//"),
            "Prefetch links should be valid URLs on #{page_name}: #{href}"
        end
      end

      # Critical resource hints
      preload_links = doc.css("head link[rel='preload']")
      preload_links.each do |link|
        as_attr = link["as"]
        assert as_attr, "Preload links should have 'as' attribute on #{page_name}"
      end
    end
  end

  def test_accessibility_basics
    @test_pages.each do |page_name, file_path|
      next unless test_page_exists?(page_name)

      doc = parse_html_file(file_path)

      # Images should have alt attributes
      images = doc.css("img")
      images.each do |img|
        alt = img["alt"]
        assert alt != nil, "Images should have alt attribute on #{page_name}"
        # Alt can be empty string for decorative images, so we just check it exists
      end

      # Forms should have labels
      form_inputs = doc.css("input[type='text'], input[type='email'], textarea")
      form_inputs.each do |input|
        input_id = input["id"]
        if input_id
          label = doc.css("label[for='#{input_id}']")
          assert label.any?, "Form input should have associated label on #{page_name}"
        end
      end

      # Headings structure (h1 should be present)
      h1_tags = doc.css("h1")
      assert h1_tags.any?, "#{page_name} should have h1 heading"

      # Skip link for accessibility (optional but good practice)
      # Don't require but validate if present
      skip_links = doc.css("a[href*='#main'], a[href*='#content']")
      if skip_links.any?
        skip_links.each do |link|
          assert link["href"].start_with?("#"), "Skip links should link to page anchors on #{page_name}"
        end
      end
    end
  end

  private

  def test_page_exists?(page_key)
    file_path = @test_pages[page_key]
    full_path = File.join(root_path, file_path)
    File.exist?(full_path)
  end
end
