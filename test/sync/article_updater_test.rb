# frozen_string_literal: true

require_relative "test_helper"
require "faraday"
require_relative "../../bin/sync/article_updater"

class ArticleUpdaterTest < Minitest::Test
  def setup
    @temp_dir = create_temp_dir
    @articles = [sample_article]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)
  end

  def read_markdown_metadata(file_path)
    content = File.read(file_path)
    content_split = content.split("---\n")
    yaml_content = content_split[1]
    YAML.load(yaml_content)
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
    assert_path_exists File.join(@temp_dir, "test-article")
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
    assert_path_exists File.join(@temp_dir, "test-article/index.md")
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

  def test_download_new_articles_with_synced_metadata
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to",
        description: "Test description"
      }
    )

    @articles = [
      sample_article(
        "canonical_url" => "https://example.com/test-article",
        "description" => "Test description"
      )
    ]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)

    @updater.download_new_articles

    status = YAML.load_file(File.join(@temp_dir, ArticleUpdater::DEFAULT_SYNC_STATUS_FILE))
    assert status[1][:synced], "Article should be marked as synced"
    assert_equal "2025-02-17T09:00:00Z", status[1][:edited_at], "Edited at should not be updated"
  end

  def test_download_new_articles_with_non_synced_metadata_in_test_env
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to",
        description: "Old description"
      }
    )

    @articles = [
      sample_article(
        "canonical_url" => "https://example.com/wrong-article",
        "description" => "New description"
      )
    ]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)

    @updater.download_new_articles

    status = YAML.load_file(File.join(@temp_dir, ArticleUpdater::DEFAULT_SYNC_STATUS_FILE))
    assert status[1][:synced], "Article should be marked as synced after metadata update"
    refute_equal "2025-02-17T09:00:00Z", status[1][:edited_at]
  end

  def test_generates_metadata_with_cover_image
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @articles = [
      sample_article(
        "cover_image" => "https://example.com/image.jpg",
        "body_markdown" => "# Test Content"
      )
    ]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)

    @updater.download_new_articles

    metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))
    assert metadata.key?("metatags"), "Metadata should have metatags key"
    assert_equal "cover.jpg", metadata.dig("metatags", "image"), "Cover image filename should be set"
    assert_includes metadata["cover_image"], REPO_URL, "Original cover image URL should be converted to github CDN"
    assert_includes metadata["cover_image"], "cover.jpg", "Original cover image URL should be converted to github CDN"
  end

  def test_generates_metadata_without_cover_image
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @articles = [
      sample_article(
        "cover_image" => nil,
        "body_markdown" => "# Test Content"
      )
    ]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)

    @updater.download_new_articles

    metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))

    refute metadata.key?("metatags")
    assert_nil metadata["cover_image"]
  end

  def test_generates_metadata_with_empty_cover_image
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @articles = [
      sample_article(
        "cover_image" => "",
        "body_markdown" => "# Test Content"
      )
    ]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)

    @updater.download_new_articles

    metadata = read_markdown_metadata(File.join(@temp_dir, "test-article/index.md"))

    refute metadata.key?("metatags")
    assert_equal "", metadata["cover_image"]
  end
end
