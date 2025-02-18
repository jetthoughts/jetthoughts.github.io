# frozen_string_literal: true

require "sync_test_case"
require "sync/article_sync_checker"

class ArticleSyncCheckerTest < SyncTestCase
  def setup
    super
    @articles = [sample_article]
    @http_client = TestHttpClient.new(@articles)
    @checker = ArticleSyncChecker.new(@temp_dir, @http_client)
  end

  def test_update_sync_status_creates_file_if_not_exists
    @checker.update_sync_status
    assert @checker.storage.sync_file_path.exist?
  end

  def test_update_sync_status_with_new_article
    @http_client.articles = [sample_article("id" => 2, "slug" => "test-article-123", "tags" => "ruby, rails, testing")]

    @checker.update_sync_status

    status = @checker.storage.load
    assert_equal 1, status.size
    assert_equal "test-article-ruby-rails-testing", status[2][:slug]
    assert_equal "2025-02-17T10:00:00Z", status[2][:edited_at]
    assert_equal false, status[2][:synced]
    assert_equal ArticleSyncChecker::DEFAULT_SOURCE, status[2][:source]
  end

  def test_update_sync_status_with_existing_unmodified_article
    sync_status = create_sync_status(
      edited_at: "2025-02-17T10:00:00Z",
      slug: "test-article-ruby-rails",
      synced: true,
      source: ArticleSyncChecker::DEFAULT_SOURCE
    )
    create_sync_file(@temp_dir, sync_status)

    @checker.update_sync_status
    status = @checker.storage.load

    assert_equal true, status[1][:synced]
  end

  def test_update_sync_status_with_modified_article
    sync_status = create_sync_status(
      edited_at: "2025-02-17T09:00:00Z",
      slug: "test-article-ruby-rails",
      synced: true,
      source: ArticleSyncChecker::DEFAULT_SOURCE
    )
    create_sync_file(@temp_dir, sync_status)

    @checker.update_sync_status
    status = @checker.storage.load

    assert_equal "2025-02-17T10:00:00Z", status[1][:edited_at]
    assert_equal false, status[1][:synced]
  end

  def test_slug_generation_removes_useless_words
    @articles = [sample_article(
                   "id" => 2,
                   "slug" => "the-best-and-most-useful-tips-123",
                   "tags" => "a, ruby, the, testing"
                 )]
    @http_client = TestHttpClient.new(@articles)
    @checker = ArticleSyncChecker.new(@temp_dir, @http_client)

    @checker.update_sync_status
    status = @checker.storage.load

    assert_equal "best-most-useful-tips-ruby-testing", status[2][:slug]
  end

  def test_uses_provided_storage
    storage = SyncStatusStorage.new(@temp_dir)
    checker = ArticleSyncChecker.new(@temp_dir, @http_client, storage: storage)
    assert_equal storage, checker.storage, "Should use the provided storage instance"
  end

  def test_creates_new_storage_when_not_provided
    checker = ArticleSyncChecker.new(@temp_dir, @http_client)
    assert_instance_of SyncStatusStorage, checker.storage, "Should create a new storage instance"
  end

  private

  def create_sync_file(temp_dir, content)
    @checker.storage.save(content)
  end
end
