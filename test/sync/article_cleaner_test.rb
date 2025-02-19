# frozen_string_literal: true

require "sync_test_case"
require "sync/article_cleaner"

class ArticleCleanerTest < SyncTestCase
  def setup
    super
    @cleaner = ArticleCleaner.new(app: @app)
  end

  def test_uses_provided_storage
    cleaner = ArticleCleaner.new(app: @app)
    assert_equal @app.storage, cleaner.storage, "Should use the provided storage instance"
  end

  def test_cleanup_renamed_articles_with_nonexistent_directory
    FileUtils.rm_rf(@app.working_dir)

    assert_raises(ArgumentError) { @cleaner.cleanup_renamed_articles }
  end

  def test_cleanup_renamed_articles_with_empty_storage
    create_article_with_metadata("old-article")
    deleted = @cleaner.cleanup_renamed_articles
    assert_includes deleted, "old-article", "Should delete article not in storage"
  end

  def test_cleanup_renamed_articles_with_valid_storage
    storage_data = {
      1 => { slug: "keep-article", synced: true },
      2 => { slug: "also-keep", synced: true }
    }
    @cleaner.storage.save(storage_data)

    create_article_with_metadata("keep-article")
    create_article_with_metadata("also-keep")
    create_article_with_metadata("delete-me")

    deleted = @cleaner.cleanup_renamed_articles

    assert_includes deleted, "delete-me", "Should delete article not in storage"
    refute_includes deleted, "keep-article", "Should keep article in storage"
    refute_includes deleted, "also-keep", "Should keep article in storage"
  end
end
