# frozen_string_literal: true

require "sync_test_case"
require "sync/article_sync_checker"
require "sync/app"

class ArticleSyncCheckerTest < SyncTestCase
  def setup
    super
    @another_articles = []
    Sync::Source.register(create_test_source_for(@another_articles, as: "another_test"))
    @articles.replace([sample_article])
    @checker = ArticleSyncChecker.new(app: @app)
  end

  def teardown
    super
    Sync::Source.unregister("another_test")
  end

  def test_update_sync_status_creates_file_if_not_exists
    @checker.update_sync_status
    assert @app.status_storage.sync_file_path.exist?
  end

  def test_update_sync_status_with_new_article
    @articles.replace([sample_article("id" => 2, "slug" => "test-article-123", "tags" => "ruby, rails, testing")])

    @checker.update_sync_status

    number_of_sync_records = sync_records_count
    sync_record = find_sync_record(2)

    assert_equal 1, number_of_sync_records
    assert_equal "test-article-ruby-rails-testing", sync_record[:slug]
    assert_equal "2025-02-17T10:00:00Z", sync_record[:edited_at]
    assert_equal false, sync_record[:synced]
    assert_equal "test", sync_record[:source]
  end

  def test_update_sync_status_with_modified_article
    sync_status = create_sync_status(
      edited_at: "2025-02-17T09:00:00Z",
      slug: "test-article-ruby-rails",
      synced: true
    )
    create_sync_file(@app.working_dir, sync_status)

    @checker.update_sync_status

    assert_equal "2025-02-17T10:00:00Z", find_sync_record(1)[:edited_at]
    assert_equal false, find_sync_record(1)[:synced]
  end

  def test_slug_generation_removes_useless_words
    @articles.replace([sample_article(
      "id" => 2,
      "slug" => "the-best-and-most-useful-tips-123",
      "tags" => "a, ruby, the, testing"
    )])

    @checker = ArticleSyncChecker.new(app: @app)

    @checker.update_sync_status

    assert_equal "best-most-useful-tips-ruby-testing", find_sync_record(2)[:slug]
  end

  def test_slug_generation_prevent_collisions
    @articles.replace([
      sample_article(
        "id" => 2,
        "slug" => "the-best-and-most-useful-tips-123",
        "tags" => "a, ruby, the, testing"
      ),
      sample_article(
        "id" => 3,
        "slug" => "the-best-and-most-useful-tips-124",
        "tags" => "a, ruby, the, testing"
      )
    ])

    @checker = ArticleSyncChecker.new(app: @app)

    @checker.update_sync_status
    assert_equal "best-most-useful-tips-ruby-testing", find_sync_record(2)[:slug]
    assert_match(/best-most-useful-tips-ruby-testing-\w{3}/, find_sync_record(3)[:slug])
  end

  def test_uses_provided_storage
    checker = ArticleSyncChecker.new(app: @app)
    assert_equal @app.status_storage, checker.storage, "Should use the provided storage instance"
  end

  def test_creates_new_storage_when_not_provided
    checker = ArticleSyncChecker.new(app: @app)
    assert_instance_of SyncStatusStorage, checker.storage, "Should create a new storage instance"
  end

  def test_updates_sync_status_with_empty_articles
    @articles.clear
    @checker.update_sync_status

    status = @app.status_storage.load
    assert_equal({}, status)
  end

  def test_preserves_existing_sync_status_for_non_returned_articles
    existing_status = create_sync_status(id: @articles.first["id"], slug: "existed-article")
      .merge(create_sync_status(id: 99, slug: "old-article"))
    create_sync_file(@app.working_dir, existing_status)

    @checker.update_sync_status

    assert_equal "old-article", find_sync_record(99)[:slug], "Should preserve existing article status"
    assert_equal "existed-article", find_sync_record(1)[:slug], "Should add new article status"
  end

  def test_app_storage_is_shared_between_checker_and_app
    @checker.update_sync_status
    app_status = @app.status_storage.load
    checker_status = @checker.storage.load

    assert_equal app_status, checker_status, "App and checker should share the same storage data"
    assert_equal @app.status_storage.object_id, @checker.storage.object_id, "App and checker should use the same storage instance"
  end

  def test_update_sync_status_with_multiple_sources
    @articles.replace([sample_article("id" => 2, "slug" => "test-123", "source" => "test")])
    @another_articles.replace([sample_article("id" => 3, "slug" => "another_test-234")])

    @checker.update_sync_status

    assert_equal 2, sync_records_count
    assert_match(/^test/, find_sync_record(2)[:slug])
    assert_match(/^another_test/, find_sync_record(3, source: "another_test")[:slug])
  end
end
