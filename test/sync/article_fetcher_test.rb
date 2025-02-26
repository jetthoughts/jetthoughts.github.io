# frozen_string_literal: true

require "sync_test_case"
require "sync/dev_to_article_fetcher"

module Sync
  class ArticleFetcherTest < SyncTestCase
    def setup
      super
      @articles.replace [
        sample_article(
          "id" => "success",
          "title" => "Test Article",
          "body" => "Test content"
        )
      ]
      @sync_data = {
        1 => {
          edited_at: "2025-02-17T10:00:00Z",
          slug: "test-article",
          synced: true,
          source: "dev_to",
          description: "Test description"
        },
        2 => {
          edited_at: "2025-02-17T10:00:00Z",
          slug: "another-article",
          synced: true,
          source: "dev_to"
        }
      }
    end

    def test_fetch_successful_article
      article = @fetcher.fetch("success")
      assert_equal "Test Article", article["title"]
      assert_equal "Test content", article["body"]
    end

    def test_fetch_failed_article
      assert_nil @fetcher.fetch("not_found")
    end

    def test_fetch_asset_success
      image_data = @fetcher.fetch_asset("https://example.com/image.jpg")
      assert_equal "fake-image-data", image_data
    end

    def test_has_updated_canonical_url_with_no_url
      article_data = {"id" => 1}
      assert @fetcher.need_to_update_remote?(article_data, {slug: "test-article"})
    end

    def test_has_updated_canonical_url_with_matching_slug
      article_data = {"id" => 1, "canonical_url" => "https://example.com/test-article"}
      refute @fetcher.need_to_update_remote?(article_data, {slug: "test-article"})
    end

    def test_has_updated_canonical_url_with_different_slug
      article_data = {"id" => 1, "canonical_url" => "https://example.com/wrong-article"}
      assert @fetcher.need_to_update_remote?(article_data, {slug: "test-article"})
    end

    def test_has_updated_meta_description_with_no_sync_data
      article_data = {"id" => 3, "description" => "Test description"}
      assert @fetcher.need_to_update_remote?(article_data, nil)
    end

    def test_not_need_to_update_remote_update_without_local_description
      article_data = {"id" => 2, "description" => "Test description", "canonical_url" => "/#{@sync_data[2][:slug]}"}
      refute @fetcher.need_to_update_remote?(article_data, @sync_data[2].except(:description))
    end

    def test_has_updated_meta_description_with_matching_description
      article_data = {
        "id" => 1,
        "description" => @sync_data[1][:description],
        "canonical_url" => "https://example.com/#{@sync_data[1][:slug]}"
      }
      refute @fetcher.need_to_update_remote?(article_data, @sync_data[1])
    end

    def test_has_updated_meta_description_with_different_description
      article_data = {"id" => 1, "description" => "New description"}
      assert @fetcher.need_to_update_remote?(article_data, @sync_data[1])
    end

    def test_has_synced_metadata_when_url_mismatch
      article_data = {
        "id" => 1,
        "description" => "Test description",
        "canonical_url" => "https://example.com/wrong-article"
      }

      assert @fetcher.need_to_update_remote?(article_data, @sync_data[1])
    end

    def test_has_synced_metadata_when_description_mismatch
      article_data = {
        "id" => 1,
        "description" => "New description",
        "canonical_url" => "https://example.com/test-article"
      }
      assert @fetcher.need_to_update_remote?(article_data, @sync_data[1])
    end

    def test_has_synced_metadata_when_no_url
      article_data = {
        "id" => 1,
        "description" => "Test description"
      }
      assert @fetcher.need_to_update_remote?(article_data, @sync_data[1])
    end

    def test_has_synced_metadata_when_no_sync_data
      article_data = {
        "id" => 3,
        "description" => "Test description",
        "canonical_url" => "https://example.com/test-article"
      }
      assert @fetcher.need_to_update_remote?(article_data, @sync_data[3])
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
end
