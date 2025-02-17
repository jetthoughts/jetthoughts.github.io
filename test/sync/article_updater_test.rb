# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/article_updater"

class ArticleUpdaterTest < Minitest::Test
  def setup
    @temp_dir = create_temp_dir
    @articles = [sample_article]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)
  end

  def test_download_new_articles_without_http_client
    updater = ArticleUpdater.new(@temp_dir, nil)
    assert_raises(ArgumentError, "http_client is required") { updater.download_new_articles }
  end

  def test_download_new_articles_without_working_dir
    assert_raises(ArgumentError, "working_dir is required") { ArticleUpdater.new(nil, @http_client) }
  end

  def test_download_new_articles_creates_directory
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @updater.download_new_articles
    assert Dir.exist?(File.join(@temp_dir, "test-article")), "post directory has not been created"
  end

  def test_download_new_articles_creates_markdown_file
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @updater.download_new_articles
    assert File.exist?(File.join(@temp_dir, "test-article/index.md"))
  end

  def test_download_new_articles_updates_sync_status
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @updater.download_new_articles

    status = YAML.load_file(File.join(@temp_dir, ArticleUpdater::DEFAULT_SYNC_STATUS_FILE))
    assert status[1][:synced]
  end

  def test_download_new_articles_skips_synced_articles
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T10:00:00Z",
        slug: "test-article",
        synced: true,
        source: "dev_to"
      }
    )

    @updater.download_new_articles
    refute Dir.exist?(File.join(@temp_dir, "test-article"))
  end
end
