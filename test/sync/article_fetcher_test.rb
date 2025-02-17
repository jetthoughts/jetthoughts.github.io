# frozen_string_literal: true

require "unit_helper"
require_relative "../../bin/sync/article_fetcher"

require "ostruct"
require "json"

class ArticleFetcherTest < Minitest::Test
  class TestHttpClient
    def get_article(id)
      if id == "success"
        OpenStruct.new(
          success?: true,
          body: { title: "Test Article", body: "Test content" }.to_json
        )
      else
        OpenStruct.new(
          success?: false,
          code: 404,
          message: "Not Found"
        )
      end
    end
  end

  def setup
    @http_client = TestHttpClient.new
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

  def test_remove_cdn
    assert_equal "https://example.com", @fetcher.remove_cdn("https://example.com")
    assert_equal "https://example.com", @fetcher.remove_cdn("https://cdn-origin.com/path?https://example.com")
    assert_equal "https://example.com", @fetcher.remove_cdn("https://cdn-origin.com/path/https://example.com")
  end
end
