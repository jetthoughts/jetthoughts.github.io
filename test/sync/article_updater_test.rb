# frozen_string_literal: true

require "sync_test_case"
require "sync/article_updater"

class ArticleUpdaterTest < SyncTestCase
  def setup
    super
    @articles << sample_article
    @updater = ArticleUpdater.new(app: @app)
  end

  def test_download_new_articles_creates_directory
    @app.storage.save(create_sync_status)

    @updater.download_new_articles

    assert_path_exists File.join(@temp_dir, "test-article"), "Article directory should be created"
  end

  def test_download_new_articles_creates_markdown_file
    @app.storage.save(create_sync_status)

    @updater.download_new_articles

    markdown_file = File.join(@temp_dir, "test-article/index.md")
    assert_path_exists markdown_file, "Markdown file should be created"
    assert_match(/# Test Content/, File.read(markdown_file), "Content should be written to file")
  end

  def test_download_new_articles_updates_sync_status
    @app.storage.save(create_sync_status(synced: false))

    @updater.download_new_articles

    sync_data = @app.storage.load
    assert sync_data[1][:synced], "Article should be marked as synced"
  end

  def test_download_new_articles_skips_synced_articles
    @app.storage.save(create_sync_status(synced: true, slug: "test-article"))
    create_article_dir("test-article", "# Original Content")

    @updater.download_new_articles

    content = File.read(File.join(@temp_dir, "test-article/index.md"))
    assert_includes content.strip, "# Original Content", "Synced article content should not be modified"
  end

  def test_download_new_articles_with_synced_metadata
    @app.storage.save(create_sync_status(synced: true))
    create_article_with_metadata("test-article", {
      "title" => "Original Title",
      "description" => "Original Description"
    })

    @updater.download_new_articles

    metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
    assert_equal "Original Title", metadata["title"], "Title should not be modified"
    assert_equal "Original Description", metadata["description"], "Description should not be modified"
  end

  def test_generates_metadata_with_cover_image
    @app.storage.save(create_sync_status)
    @articles.replace([
      sample_article("cover_image" => "https://example.com/image.jpg", "body_markdown" => "# Test Content")
    ])

    @updater.download_new_articles

    metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
    assert metadata.key?("metatags"), "Metadata should have metatags key"
    assert_equal "cover.jpg", metadata.dig("metatags", "image"), "Cover image filename should be set"
    assert_includes metadata["cover_image"], REPO_URL, "Cover image URL should use github CDN"
    assert_includes metadata["cover_image"], "cover.jpg", "Cover image URL should include filename"
  end

  def test_generates_metadata_without_cover_image
    @app.storage.save(create_sync_status)
    @articles.replace([sample_article("cover_image" => nil)])

    @updater.download_new_articles

    metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
    refute metadata.key?("metatags"), "Metadata should not have metatags key"
    assert_nil metadata["cover_image"], "Cover image should be nil"
  end

  def test_download_new_articles_in_dry_run_mode
    @app.storage.save(create_sync_status(synced: false))

    @updater.download_new_articles(force: false, dry_run: true)

    sync_data = @app.storage.load
    refute sync_data[1][:synced], "Article should not be marked as synced in dry run mode"
    assert_equal 0, @http_client.update_requests.size, "No update requests should be made in dry run mode"
  end

  def test_uses_app_storage
    assert_equal @app.storage.object_id, @updater.storage.object_id, "Should use storage from app"
  end

  def test_uses_app_fetcher
    assert_equal @app.fetcher.object_id, @updater.article_fetcher.object_id, "Should use fetcher from app"
  end

  def test_uses_app_working_dir
    assert_equal @app.working_dir, @updater.working_dir, "Should use working_dir from app"
  end

  def test_uses_app_dry_run_setting
    @app = App.new(args: ["--dry"], working_dir: @temp_dir, http_client: @http_client)
    @updater = ArticleUpdater.new(app: @app)

    @app.storage.save(create_sync_status(synced: false))
    @updater.download_new_articles

    sync_data = @app.storage.load
    refute sync_data[1][:synced], "Should respect app's dry run setting"
  end

  def test_uses_app_force_setting
    @app = App.new(args: ["--force"], working_dir: @temp_dir, http_client: @http_client)
    @updater = ArticleUpdater.new(app: @app)
    @app.storage.save(create_sync_status(synced: true, edited_at: "2023-02-17T09:00:00Z"))

    @updater.download_new_articles

    sync_data = @app.storage.load
    refute_equal "2023-02-17T09:00:00Z", sync_data[1][:edited_at], "Should respect app's force setting"
  end
end
