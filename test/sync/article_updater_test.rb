# frozen_string_literal: true

require "unit_helper"
require_relative "../../bin/sync/article_updater"

class ArticleUpdaterTest < Minitest::Test
  class TestHttpClient
    def initialize(articles)
      @articles = articles
    end

    def get_articles(username, _)
      raise ArgumentError, "Invalid username" unless username == "jetthoughts"
      OpenStruct.new(body: @articles.to_json)
    end

    def get_article(id)
      result = @articles.find { id == _1["id"] }
      OpenStruct.new(body: result.to_json, success?: !!result)
    end

    def update_article(*, **)
      OpenStruct.new(success?: true, body: { edited_at: Time.now.utc }.to_json)
    end
  end

  def setup
    super
    @temp_dir = Dir.mktmpdir
    @articles = [
      {
        "id" => 1,
        "title" => "Test Article",
        "body_markdown" => "# Test Content",
        "slug" => "test-article-123",
        "tags" => "ruby, rails",
        "edited_at" => "2025-02-17T10:00:00Z",
        "created_at" => "2025-02-17T09:00:00Z",
        "url" => "https://dev.to/test-article",
        "description" => "Test description"
      }
    ]
    @http_client = TestHttpClient.new(@articles)
    @updater = ArticleUpdater.new(@temp_dir, @http_client)
  end

  def teardown
    FileUtils.remove_entry @temp_dir if Dir.exist?(@temp_dir)
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
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    )

    @updater.download_new_articles
    status = YAML.load_file(File.join(@temp_dir, "sync_status.yml"))
    assert status[1][:synced]
  end

  def test_download_new_articles_skips_synced_articles
    create_sync_file(
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

  private

  def create_sync_file(content)
    File.write(File.join(@temp_dir, "sync_status.yml"), content.to_yaml)
  end
end
