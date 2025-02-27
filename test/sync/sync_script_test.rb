# frozen_string_literal: true

require "sync_test_case"
require "sync/sync_script"

class SyncScriptTest < SyncTestCase
  def setup
    super
    @articles << sample_article
    @sync = SyncScript.new(app: @app)
  end

  def test_perform_updates_sync_status_for_new_articles
    create_sync_file(@app.working_dir, {})

    post = sample_article
    @articles.replace([post])

    @sync.perform

    sync_data = @app.status_storage.load
    assert sync_data.key?(post["id"]), "Should create sync status for article"

    refute_empty sync_data[post["id"]][:edited_at], "Should set correct edited_at"
    assert_equal "test-article-ruby-rails-testing", sync_data[post["id"]][:slug], "Should set correct slug"
    assert_equal "test", sync_data[post["id"]][:source], "Should set correct source"
  end

  def test_perform_downloads_articles_in_non_dry_run
    # First ensure we have sync status
    @app.status_storage.save({
      1 => {
        edited_at: "2023-02-01",
        slug: "test-article",
        synced: false,
        source: "test"
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
