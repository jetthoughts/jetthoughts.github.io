# frozen_string_literal: true

require "unit_helper"
require_relative "../../bin/sync/article_sync_checker"

class ArticleSyncCheckerTest < Minitest::Test
  class TestHttpClient
    def initialize(articles)
      @articles = articles
    end

    def get_articles(username, _)
      raise ArgumentError, "Invalid username" unless username == ArticleSyncChecker::USERNAME
      OpenStruct.new(body: @articles.to_json)
    end
  end

  def setup
    @temp_dir = Dir.mktmpdir
    @articles = [
      {
        "id" => 1,
        "title" => "Test Article",
        "slug" => "test-article-123",
        "tags" => "ruby, rails, testing",
        "edited_at" => "2025-02-17T10:00:00Z",
        "created_at" => "2025-02-17T09:00:00Z"
      }
    ]
    @http_client = TestHttpClient.new(@articles)
    @checker = ArticleSyncChecker.new(@temp_dir, @http_client, logger: Logger.new(IO::NULL))
  end

  def teardown
    FileUtils.remove_entry @temp_dir if Dir.exist?(@temp_dir)
  end

  def test_update_sync_status_creates_file_if_not_exists
    @checker.update_sync_status
    assert File.exist?(File.join(@temp_dir, ArticleSyncChecker::DEFAULT_SYNC_STATUS_FILE))
  end

  def test_update_sync_status_with_new_article
    @checker.update_sync_status
    status = YAML.load_file(File.join(@temp_dir, ArticleSyncChecker::DEFAULT_SYNC_STATUS_FILE))

    assert_equal 1, status.size
    assert_equal "test-article-ruby-rails", status[1][:slug]
    assert_equal "2025-02-17T10:00:00Z", status[1][:edited_at]
    assert_equal false, status[1][:synced]
    assert_equal ArticleSyncChecker::DEFAULT_SOURCE, status[1][:source]
  end

  def test_update_sync_status_with_existing_unmodified_article
    create_sync_file(
      1 => {
        edited_at: "2025-02-17T10:00:00Z",
        slug: "test-article-ruby-rails",
        synced: true,
        source: ArticleSyncChecker::DEFAULT_SOURCE
      }
    )

    @checker.update_sync_status
    status = YAML.load_file(File.join(@temp_dir, ArticleSyncChecker::DEFAULT_SYNC_STATUS_FILE))

    assert_equal true, status[1][:synced]
  end

  def test_update_sync_status_with_modified_article
    create_sync_file(
      1 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "test-article-ruby-rails",
        synced: true,
        source: ArticleSyncChecker::DEFAULT_SOURCE
      }
    )

    @checker.update_sync_status
    status = YAML.load_file(File.join(@temp_dir, ArticleSyncChecker::DEFAULT_SYNC_STATUS_FILE))

    assert_equal "2025-02-17T10:00:00Z", status[1][:edited_at]
    assert_equal false, status[1][:synced]
  end

  def test_slug_generation_removes_useless_words
    article = {
      "id" => 2,
      "slug" => "the-best-and-most-useful-tips-123",
      "tags" => "a, ruby, the, testing"
    }
    @http_client = TestHttpClient.new([article])
    @checker = ArticleSyncChecker.new(@temp_dir, @http_client, logger: Logger.new(IO::NULL))

    @checker.update_sync_status
    status = YAML.load_file(File.join(@temp_dir, ArticleSyncChecker::DEFAULT_SYNC_STATUS_FILE))

    assert_equal "best-most-useful-tips-ruby-testing", status[2][:slug]
  end

  private

  def create_sync_file(content)
    File.write(File.join(@temp_dir, ArticleSyncChecker::DEFAULT_SYNC_STATUS_FILE), content.to_yaml)
  end
end
