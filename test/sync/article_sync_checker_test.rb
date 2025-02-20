# frozen_string_literal: true

require "sync_test_case"
require "sync/article_sync_checker"
require "sync/app"

class ArticleSyncCheckerTest < SyncTestCase
  def setup
    super
    @articles << sample_article
    @app = App.new(working_dir: @temp_dir, http_client: @http_client)
    @checker = ArticleSyncChecker.new(app: @app)
  end

  def test_update_sync_status_creates_file_if_not_exists
    @checker.update_sync_status
    assert @app.status_storage.sync_file_path.exist?
  end

  def test_update_sync_status_with_new_article
    @articles.replace [sample_article("id" => 2, "slug" => "test-article-123", "tags" => "ruby, rails, testing")]

    @checker.update_sync_status

    status = @app.status_storage.load
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
    status = @app.status_storage.load

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
    status = @app.status_storage.load

    assert_equal "2025-02-17T10:00:00Z", status[1][:edited_at]
    assert_equal false, status[1][:synced]
  end

  def test_slug_generation_removes_useless_words
    @articles.replace([sample_article(
      "id" => 2,
      "slug" => "the-best-and-most-useful-tips-123",
      "tags" => "a, ruby, the, testing"
    )])

    @checker = ArticleSyncChecker.new(app: @app)

    @checker.update_sync_status
    status = @app.status_storage.load

    assert_equal "best-most-useful-tips-ruby-testing", status[2][:slug]
  end

  def test_uses_provided_storage
    checker = ArticleSyncChecker.new(app: @app)
    assert_equal @app.status_storage, checker.storage, "Should use the provided storage instance"
  end

  def test_creates_new_storage_when_not_provided
    checker = ArticleSyncChecker.new(app: @app)
    assert_instance_of SyncStatusStorage, checker.storage, "Should create a new storage instance"
  end

  def test_uses_app_fetcher_when_provided
    app = App.new(working_dir: @temp_dir, http_client: @http_client)
    checker = ArticleSyncChecker.new(app: app)
    assert_equal app.fetcher, checker.fetcher
  end

  def test_creates_new_fetcher_when_app_not_provided
    checker = ArticleSyncChecker.new(app: @app)
    assert_instance_of ArticleFetcher, checker.fetcher
  end

  def test_updates_sync_status_with_empty_articles
    @articles.clear
    @checker.update_sync_status

    status = @app.status_storage.load
    assert_equal({}, status)
  end

  def test_preserves_existing_sync_status_for_non_returned_articles
    existing_status = {
      @articles.first["id"] => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "existed-article",
        synced: true,
        source: ArticleSyncChecker::DEFAULT_SOURCE
      },
      99 => {
        edited_at: "2025-02-17T09:00:00Z",
        slug: "old-article",
        synced: true,
        source: ArticleSyncChecker::DEFAULT_SOURCE
      }
    }
    create_sync_file(@temp_dir, existing_status)

    @checker.update_sync_status

    status = @app.status_storage.load
    assert_equal "old-article", status[99][:slug], "Should preserve existing article status"
    assert_equal "existed-article", status[1][:slug], "Should add new article status"
  end

  def test_app_storage_is_shared_between_checker_and_app
    @checker.update_sync_status
    app_status = @app.status_storage.load
    checker_status = @checker.storage.load

    assert_equal app_status, checker_status, "App and checker should share the same storage data"
    assert_equal @app.status_storage.object_id, @checker.storage.object_id, "App and checker should use the same storage instance"
  end
end
