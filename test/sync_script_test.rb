# frozen_string_literal: true

require "sync_test_case"
require "sync"

class SyncScriptTest < SyncTestCase
  def setup
    super
    @articles << sample_article
    @sync = SyncScript.new(app: @app)
  end

  def test_uses_app_storage_for_sync_checker
    sync_checker = @sync.send(:sync_checker)
    assert_equal @app.status_storage, sync_checker.status_storage, "Should use app's storage for sync checker"
  end

  def test_uses_app_storage_for_article_updater
    article_updater = @sync.send(:article_updater)
    assert_equal @app.status_storage, article_updater.status_storage, "Should use app's storage for article updater"
  end

  def test_uses_app_storage_for_article_cleaner
    article_cleaner = @sync.send(:article_cleaner)
    assert_equal @app.status_storage, article_cleaner.status_storage, "Should use app's storage for article cleaner"
  end

  def test_perform_updates_sync_status_for_new_articles
    article = sample_article
    @http_client.articles = [article]

    @sync.perform

    sync_data = @app.status_storage.load
    assert sync_data.key?(article["id"]), "Should create sync status for article"
    assert_equal article["edited_at"], sync_data[article["id"]][:edited_at], "Should set correct edited_at"
    assert_equal "test-article-ruby-rails-testing", sync_data[article["id"]][:slug], "Should set correct slug"
    assert_equal "dev_to", sync_data[article["id"]][:source], "Should set correct source"
  end

  def test_perform_downloads_articles_in_non_dry_run
    # First ensure we have sync status
    @app.status_storage.save({
      1 => {
        edited_at: "2023-02-01",
        slug: "test-article",
        synced: false,
        source: "dev_to"
      }
    })

    @sync.perform

    assert_path_exists @app.working_dir / "test-article", "Should create article directory"
    assert_path_exists @app.working_dir / "test-article/index.md", "Should create article file"
  end

  def test_perform_skips_article_cleaner_in_dry_run
    create_article_with_metadata("old-article", {}, "# Test Content")

    SyncScript.new(app: create_app(args: ["--dry"])).perform

    assert_path_exists @app.working_dir / "old-article", "Should not delete articles in dry run"
  end
end
