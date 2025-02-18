require "minitest/autorun"
require "tmpdir"
require "fileutils"
require_relative "../../../bin/sync/article_sync_checker"

class ArticleSyncCheckerTest < Minitest::Test
  class MockHttpClient
    def initialize(articles)
      @articles = articles
    end

    def get_articles(username, page)
      OpenStruct.new(
        body: @articles.to_json
      )
    end
  end

  def setup
    @temp_dir = Dir.mktmpdir
    @articles = [
      {
        "id" => "123",
        "slug" => "test-article-xyz",
        "tags" => "ruby, testing",
        "edited_at" => "2024-01-01",
        "created_at" => "2023-12-31"
      }
    ]
    @http_client = MockHttpClient.new(@articles)
    @checker = ArticleSyncChecker.new(Pathname.new(@temp_dir), @http_client)
  end

  def teardown
    FileUtils.remove_entry @temp_dir
  end

  def test_updates_sync_status_for_new_article
    @checker.update_sync_status
    
    sync_status = YAML.load_file(@temp_dir + SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE)
    assert_equal "2024-01-01", sync_status["123"][:edited_at]
    assert_equal "test-article", sync_status["123"][:slug]
    refute sync_status["123"][:synced]
    assert_equal "dev_to", sync_status["123"][:source]
  end

  def test_marks_article_for_sync_when_edited
    # First sync
    @checker.update_sync_status
    
    # Update article
    @articles.first["edited_at"] = "2024-02-01"
    @checker.update_sync_status
    
    sync_status = YAML.load_file(@temp_dir + SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE)
    assert_equal "2024-02-01", sync_status["123"][:edited_at]
    refute sync_status["123"][:synced]
  end

  def test_preserves_existing_sync_status
    # First sync
    @checker.update_sync_status
    
    # Manually mark as synced
    sync_status = YAML.load_file(@temp_dir + SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE)
    sync_status["123"][:synced] = true
    File.write(@temp_dir + SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE, sync_status.to_yaml)
    
    # Update without changes
    @checker.update_sync_status
    
    sync_status = YAML.load_file(@temp_dir + SyncStatusStorage::DEFAULT_SYNC_STATUS_FILE)
    assert sync_status["123"][:synced]
  end
end
