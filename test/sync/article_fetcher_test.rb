# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/article_fetcher"

class ArticleFetcherTest < Minitest::Test
  def setup
    @articles = [
      sample_article(
        "id" => "success",
        "title" => "Test Article",
        "body" => "Test content"
      )
    ]
    @http_client = TestHttpClient.new(@articles)
    @fetcher = ArticleFetcher.new(@http_client)
  end

  def test_fetch_successful_article
    article = @fetcher.fetch("success")
    assert_equal "Test Article", article["title"]
    assert_equal "Test content", article["body"]
  end

  def test_fetch_failed_article
    assert_nil @fetcher.fetch("not_found")
  end

  def test_fetch_image_success
    image_data = @fetcher.fetch_image("https://example.com/image.jpg")
    assert_equal "fake-image-data", image_data
  end

  def test_remove_cdn
    assert_equal "https://example.com", @fetcher.remove_cdn("https://example.com")
    assert_equal "https://example.com", @fetcher.remove_cdn("https://cdn-origin.com/path?https://example.com")
    assert_equal "https://example.com", @fetcher.remove_cdn("https://cdn-origin.com/path/https://example.com")
  end

  def test_ext_from_image_url
    assert_equal ".jpg", @fetcher.ext_from_image_url("https://example.com/image.jpg")
    assert_equal ".png", @fetcher.ext_from_image_url("https://cdn-origin.com/path?https://example.com/image.png")
  end
end
