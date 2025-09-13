# frozen_string_literal: true

require "application_system_test_case"

class MetaTagsTest < ApplicationSystemTestCase
  def setup
    Capybara.current_driver = :desktop_chrome
    super
  end

  def test_canonical_url_for_test_localhost
    visit "/"

    canonical_node = find("link[rel=canonical]", visible: false)
    assert_includes canonical_node[:href], "http://localhost:"
  end

  def test_homepage_has_og_locale_meta_tag
    visit "/"

    # This should FAIL initially - we're looking for og:locale meta tag
    assert_selector('meta[property="og:locale"]', visible: false)

    # Verify it has the correct value
    og_locale = find('meta[property="og:locale"]', visible: false)
    assert_equal "en_US", og_locale["content"]
  end

  def test_homepage_has_required_opengraph_meta_tags
    visit "/"

    # These should FAIL initially - testing for required OpenGraph tags
    assert_selector('meta[property="og:title"]', visible: false)
    assert_selector('meta[property="og:description"]', visible: false)
    assert_selector('meta[property="og:url"]', visible: false)
    assert_selector('meta[property="og:type"]', visible: false)
    assert_selector('meta[property="og:site_name"]', visible: false)

    # Verify content values - adjust expectations based on actual content
    og_title = find('meta[property="og:title"]', visible: false)
    refute_empty og_title["content"], "og:title should not be empty"

    og_type = find('meta[property="og:type"]', visible: false)
    assert_equal "website", og_type["content"]

    og_site_name = find('meta[property="og:site_name"]', visible: false)
    assert_equal "JetThoughts", og_site_name["content"]
  end

  def test_homepage_has_twitter_card_meta_tags
    visit "/"

    # These should FAIL initially - testing for Twitter Card tags
    assert_selector('meta[name="twitter:card"]', visible: false)
    assert_selector('meta[name="twitter:title"]', visible: false)
    assert_selector('meta[name="twitter:description"]', visible: false)
    assert_selector('meta[name="twitter:site"]', visible: false)

    # Verify content values
    twitter_card = find('meta[name="twitter:card"]', visible: false)
    assert_equal "summary_large_image", twitter_card["content"]

    twitter_site = find('meta[name="twitter:site"]', visible: false)
    assert_equal "@jetthoughts", twitter_site["content"]
  end

  def test_homepage_has_canonical_url
    visit "/"

    # This should FAIL initially - testing for canonical URL
    assert_selector('link[rel="canonical"]', visible: false)

    # Verify canonical URL points to homepage
    canonical = find('link[rel="canonical"]', visible: false)
    assert_match %r{https?://.*/$}, canonical["href"]
  end

  def test_blog_post_has_article_specific_og_tags
    visit "/blog/tips-for-writing-readable-system-tests-in-rails-capybara-ruby/"

    # These should FAIL initially - testing article-specific tags
    assert_selector('meta[property="og:type"]', visible: false)
    assert_selector('meta[property="article:published_time"]', visible: false)
    assert_selector('meta[property="article:modified_time"]', visible: false)

    # Handle multiple og:type tags by checking if any has "article" value
    og_type_tags = all('meta[property="og:type"]', visible: false)
    assert og_type_tags.any? { |tag| tag["content"] == "article" },
      "Expected at least one og:type meta tag with 'article' content"

    # Verify article timestamps exist (handle multiple tags)
    published_time_tags = all('meta[property="article:published_time"]', visible: false)
    assert published_time_tags.length >= 1, "Should have at least one article:published_time meta tag"
    assert_match(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/, published_time_tags.first["content"])
  end

  def test_services_page_has_proper_meta_tags
    visit "/services/fractional-cto/"

    # These should FAIL initially - testing service page tags
    assert_selector('meta[property="og:type"]', visible: false)
    assert_selector('meta[property="og:title"]', visible: false)
    assert_selector('meta[property="og:description"]', visible: false)

    # Verify og:type is "website" for service pages
    og_type = find('meta[property="og:type"]', visible: false)
    assert_equal "website", og_type["content"]
  end

  def test_meta_description_exists_and_not_truncated
    visit "/"

    # This should FAIL initially - testing meta description
    assert_selector('meta[name="description"]', visible: false)

    # Verify description is not too long (under 160 characters)
    description = find('meta[name="description"]', visible: false)
    assert description["content"].length <= 160, "Meta description too long: #{description["content"].length} characters"
    assert description["content"].length > 50, "Meta description too short: #{description["content"].length} characters"
  end

  def test_meta_robots_tag_exists
    visit "/"

    # This should FAIL initially - testing robots meta tag
    assert_selector('meta[name="robots"]', visible: false)

    # Verify robots tag has proper content
    robots = find('meta[name="robots"]', visible: false)
    assert_includes ["index, follow", "index, follow, max-snippet:-1, max-video-preview:-1, max-image-preview:large"], robots["content"]
  end

  def test_og_image_meta_tag_exists
    visit "/"

    # This should FAIL initially - testing for og:image
    assert_selector('meta[property="og:image"]', visible: false)
    assert_selector('meta[property="og:image:width"]', visible: false)
    assert_selector('meta[property="og:image:height"]', visible: false)

    # Verify image dimensions
    og_image_width = find('meta[property="og:image:width"]', visible: false)
    assert_equal "1200", og_image_width["content"]

    og_image_height = find('meta[property="og:image:height"]', visible: false)
    assert_equal "630", og_image_height["content"]
  end
end
