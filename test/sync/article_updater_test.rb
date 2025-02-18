# frozen_string_literal: true

require "sync_test_case"
require "sync/article_updater"

module Sync
  class ArticleUpdaterTest < SyncTestCase
    def setup
      super
      @articles << sample_article
      @updater = ArticleUpdater.new(app: @app)
    end

    class ArticleDownloadTest < SyncTestCase
      def setup
        super
        @articles << sample_article
        @updater = ArticleUpdater.new(app: @app)
      end

      def test_creates_article_directory_and_markdown_file
        @app.storage.save(create_sync_status)
        @updater.download_articles

        markdown_file = File.join(@temp_dir, "test-article/index.md")
        assert_path_exists markdown_file, "Markdown file should be created"
        assert_match(/# Test Content/, File.read(markdown_file), "Content should be written to file")
      end

      def test_updates_sync_status_after_download
        @app.storage.save(create_sync_status(synced: false))
        @updater.download_articles

        sync_data = @app.storage.load
        assert sync_data[1][:synced], "Article should be marked as synced"
      end

      def test_skips_synced_articles
        @app.storage.save(create_sync_status(synced: true, slug: "test-article"))
        create_article_dir("test-article", "# Original Content")

        @updater.download_articles

        content = File.read(File.join(@temp_dir, "test-article/index.md"))
        assert_includes content.strip, "# Original Content", "Synced article content should not be modified"
      end

      def test_preserves_existing_metadata
        @app.storage.save(create_sync_status(synced: true))
        create_article_with_metadata("test-article", {
          "title" => "Original Title",
          "description" => "Original Description"
        })

        @updater.download_articles

        metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
        assert_equal "Original Title", metadata["title"]
        assert_equal "Original Description", metadata["description"]
      end
    end

    class MetadataHandlingTest < SyncTestCase
      def setup
        super
        @articles << sample_article
        @updater = ArticleUpdater.new(app: @app)
        @app.storage.save(create_sync_status)
      end

      def test_handles_article_with_cover_image
        @articles.replace([
          sample_article("cover_image" => "https://example.com/image.jpg")
        ])

        @updater.download_articles

        metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
        assert_equal "cover.jpg", metadata.dig("metatags", "image")
        assert_includes metadata["cover_image"], "cover.jpg"
      end

      def test_handles_article_without_cover_image
        @articles.replace([sample_article("cover_image" => nil)])

        @updater.download_articles

        metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
        refute metadata.key?("metatags")
        assert_nil metadata["cover_image"]
      end
    end

    class AppIntegrationTest < SyncTestCase
      def setup
        super
        @articles << sample_article
      end

      def test_respects_dry_run_mode
        app = App.new(args: ["--dry"], working_dir: @temp_dir, http_client: @http_client)
        updater = ArticleUpdater.new(app: app)
        app.storage.save(create_sync_status(synced: false))

        updater.download_articles

        sync_data = app.storage.load
        refute sync_data[1][:synced], "Should not modify files in dry run"
        assert_equal 0, @http_client.update_requests.size, "Should not make API calls"
      end

      def test_respects_force_mode
        app = App.new(args: ["--force"], working_dir: @temp_dir, http_client: @http_client)
        updater = ArticleUpdater.new(app: app)
        app.storage.save(create_sync_status(synced: true, edited_at: "2023-02-17T09:00:00Z"))

        updater.download_articles

        sync_data = app.storage.load
        refute_equal "2023-02-17T09:00:00Z", sync_data[1][:edited_at]
      end

      def test_uses_app_dependencies
        updater = ArticleUpdater.new(app: @app)

        assert_equal @app.storage.object_id, updater.storage.object_id
        assert_equal @app.fetcher.object_id, updater.article_fetcher.object_id
        assert_equal @app.working_dir, updater.working_dir
      end
    end
  end
end
