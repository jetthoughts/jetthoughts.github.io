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
        @app.status_storage.save(create_sync_status)
        @updater.download_articles

        markdown_file = Sync::Post.new("test-article").page_bundle_dir.join("index.md")
        assert_path_exists markdown_file, "Markdown file should be created"
        assert_match(/# Test Content/, File.read(markdown_file), "Content should be written to file")
      end

      def test_updates_sync_status_after_download
        @app.status_storage.save(create_sync_status(synced: false))
        @updater.download_articles

        sync_data = @app.status_storage.load
        assert sync_data[1][:synced], "Article should be marked as synced"
      end

      def test_skips_synced_articles
        @app.status_storage.save(create_sync_status(synced: true, slug: "test-article"))
        create_article("test-article", "# Original Content")

        @updater.download_articles

        content = File.read(File.join(@app.working_dir, "test-article/index.md"))
        assert_includes content.strip, "# Original Content", "Synced article content should not be modified"
      end

      def test_preserves_existing_metadata
        @app.status_storage.save(create_sync_status(synced: true))
        create_article_with_metadata("test-article", {
          "title" => "Original Title",
          "description" => "Original Description"
        })

        @updater.download_articles

        metadata = Sync::Post.new("test-article").load.metadata

        assert_equal "Original Title", metadata["title"]
        assert_equal "Original Description", metadata["description"]
      end
    end

    class MetadataHandlingTest < SyncTestCase
      def setup
        super
        @articles << sample_article
        @updater = ArticleUpdater.new(app: @app)
        @app.status_storage.save(create_sync_status)
      end

      def test_handles_article_with_cover_image
        @articles.replace([
          sample_article("cover_image" => "https://example.com/image.jpg")
        ])

        @updater.download_articles

        metadata = Sync::Post.new("test-article").load.metadata
        assert_equal "cover.jpg", metadata.dig("metatags", "image")
        assert_includes metadata["cover_image"], "cover.jpg"
      end

      def test_handles_article_without_cover_image
        @articles.replace([sample_article("cover_image" => nil)])

        @updater.download_articles

        metadata = Sync::Post.new("test-article").load.metadata
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
        app = create_app_with("--dry")
        updater = ArticleUpdater.new(app: app)
        app.status_storage.save(create_sync_status(id: 1, synced: false))

        updater.download_articles

        sync_data = app.status_storage.load
        assert sync_data[1][:synced]
      end

      def test_respects_force_mode
        app = create_app_with("--force")
        updater = ArticleUpdater.new(app: app)
        app.status_storage.save(create_sync_status(synced: true, edited_at: "2023-02-17T09:00:00Z"))

        updater.download_articles

        sync_data = app.status_storage.load
        refute_equal "2023-02-17T09:00:00Z", sync_data[1][:edited_at]
      end

      def test_uses_app_dependencies
        updater = ArticleUpdater.new(app: @app)

        assert_equal @app.status_storage.object_id, updater.storage.object_id
        assert_equal @app.working_dir, updater.working_dir
      end

      private

      def create_app_with(arg)
        App.new(args: [arg], fetcher: @fetcher)
      end
    end
  end
end
