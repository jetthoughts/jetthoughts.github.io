require "base_page_test_case"

class MetaTagsTest < BasePageTestCase
  # Unit tests for meta tags functionality and SEO validation
  # Tests rendered HTML output from public-test directory (no server required)

  def test_canonical_url_for_site
    doc = parse_html_file("index.html")

    canonical_links = doc.css("link[rel='canonical']")
    assert canonical_links.any?, "Homepage should have canonical link"

    canonical_href = canonical_links.first["href"]
    assert canonical_href, "Canonical link should have href attribute"
  end

  def test_homepage_has_og_locale_meta_tag
    doc = parse_html_file("index.html")

    # Look for og:locale meta tag
    og_locale_tags = doc.css('meta[property="og:locale"]')
    assert og_locale_tags.any?, "Homepage should have og:locale meta tag"

    # Verify it has the correct value
    og_locale = og_locale_tags.first
    assert_equal "en_US", og_locale["content"], "og:locale should be en_US"
  end

  def test_homepage_has_required_opengraph_meta_tags
    doc = parse_html_file("index.html")

    # Test for required OpenGraph tags
    assert doc.css('meta[property="og:title"]').any?, "Should have og:title"
    assert doc.css('meta[property="og:description"]').any?, "Should have og:description"
    assert doc.css('meta[property="og:url"]').any?, "Should have og:url"
    assert doc.css('meta[property="og:type"]').any?, "Should have og:type"
    assert doc.css('meta[property="og:site_name"]').any?, "Should have og:site_name"

    # Verify content values
    og_title = doc.css('meta[property="og:title"]').first
    refute og_title["content"].strip.empty?, "og:title should not be empty"

    og_type = doc.css('meta[property="og:type"]').first
    assert_equal "website", og_type["content"], "og:type should be website"

    og_site_name = doc.css('meta[property="og:site_name"]').first
    assert_equal "JetThoughts", og_site_name["content"], "og:site_name should be JetThoughts"
  end

  def test_homepage_has_twitter_card_meta_tags
    doc = parse_html_file("index.html")

    # Test for Twitter Card tags
    assert doc.css('meta[name="twitter:card"]').any?, "Should have twitter:card"
    assert doc.css('meta[name="twitter:title"]').any?, "Should have twitter:title"
    assert doc.css('meta[name="twitter:description"]').any?, "Should have twitter:description"
    assert doc.css('meta[name="twitter:site"]').any?, "Should have twitter:site"

    # Verify content values
    twitter_card = doc.css('meta[name="twitter:card"]').first
    assert_equal "summary_large_image", twitter_card["content"], "Twitter card should be summary_large_image"

    twitter_site = doc.css('meta[name="twitter:site"]').first
    assert_equal "@jetthoughts", twitter_site["content"], "Twitter site should be @jetthoughts"
  end

  def test_blog_post_has_article_specific_og_tags
    doc = parse_html_file("blog/tips-for-writing-readable-system-tests-in-rails-capybara-ruby/index.html")

    # Test article-specific tags
    assert doc.css('meta[property="og:type"]').any?, "Blog post should have og:type"
    assert doc.css('meta[property="article:published_time"]').any?, "Blog post should have published_time"
    assert doc.css('meta[property="article:modified_time"]').any?, "Blog post should have modified_time"

    # Handle multiple og:type tags by checking if any has "article" value
    og_type_tags = doc.css('meta[property="og:type"]')
    article_types = og_type_tags.select { |tag| tag["content"] == "article" }
    assert article_types.any?, "Expected at least one og:type meta tag with 'article' content"

    # Verify article timestamps exist
    published_time_tags = doc.css('meta[property="article:published_time"]')
    assert published_time_tags.length >= 1, "Should have at least one article:published_time meta tag"

    published_time_content = published_time_tags.first["content"]
    assert published_time_content.match?(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/),
      "Published time should be in ISO format: #{published_time_content}"
  end

  def test_services_page_has_proper_meta_tags
    doc = parse_html_file("services/fractional-cto/index.html")

    # Test service page tags
    assert doc.css('meta[property="og:type"]').any?, "Service page should have og:type"
    assert doc.css('meta[property="og:title"]').any?, "Service page should have og:title"
    assert doc.css('meta[property="og:description"]').any?, "Service page should have og:description"

    # Verify og:type is "website" for service pages
    og_type = doc.css('meta[property="og:type"]').first
    assert_equal "website", og_type["content"], "Service page og:type should be website"
  end

  def test_meta_description_exists_and_not_truncated
    doc = parse_html_file("index.html")

    # Test meta description
    description_tags = doc.css('meta[name="description"]')
    assert description_tags.any?, "Should have meta description"

    # Verify description length is appropriate
    description = description_tags.first
    description_content = description["content"]
    assert description_content.length <= 160,
      "Meta description too long: #{description_content.length} characters"
    assert description_content.length > 50,
      "Meta description too short: #{description_content.length} characters"
  end

  def test_meta_robots_tag_exists
    doc = parse_html_file("index.html")

    # Test robots meta tag
    robots_tags = doc.css('meta[name="robots"]')
    assert robots_tags.any?, "Should have robots meta tag"

    # Verify robots tag has proper content
    robots = robots_tags.first
    robots_content = robots["content"]
    valid_robots_values = [
      "index, follow",
      "index, follow, max-snippet:-1, max-video-preview:-1, max-image-preview:large"
    ]
    assert valid_robots_values.include?(robots_content),
      "Robots tag should have valid content: #{robots_content}"
  end

  def test_og_image_meta_tag_exists
    doc = parse_html_file("index.html")

    # Test for og:image tags
    assert doc.css('meta[property="og:image"]').any?, "Should have og:image"
    assert doc.css('meta[property="og:image:width"]').any?, "Should have og:image:width"
    assert doc.css('meta[property="og:image:height"]').any?, "Should have og:image:height"

    # Verify image dimensions
    og_image_width = doc.css('meta[property="og:image:width"]').first
    assert_equal "1200", og_image_width["content"], "og:image width should be 1200"

    og_image_height = doc.css('meta[property="og:image:height"]').first
    assert_equal "630", og_image_height["content"], "og:image height should be 630"
  end

  def test_viewport_meta_tag_exists
    doc = parse_html_file("index.html")

    # Test viewport meta tag for mobile responsiveness
    viewport_tags = doc.css('meta[name="viewport"]')
    assert viewport_tags.any?, "Should have viewport meta tag"

    viewport = viewport_tags.first
    viewport_content = viewport["content"]
    assert viewport_content.include?("width=device-width"),
      "Viewport should include width=device-width"
    assert viewport_content.include?("initial-scale=1"),
      "Viewport should include initial-scale=1"
  end

  def test_theme_color_meta_tag_exists
    doc = parse_html_file("index.html")

    # Test theme-color meta tag
    theme_color_tags = doc.css('meta[name="theme-color"]')
    assert theme_color_tags.any?, "Should have theme-color meta tag"

    theme_color = theme_color_tags.first
    theme_color_content = theme_color["content"]
    assert theme_color_content.match?(/^#[0-9a-f]{6}$/i),
      "Theme color should be valid hex color: #{theme_color_content}"
  end
end
