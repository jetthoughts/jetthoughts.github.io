# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/article_cleaner"

class ArticleCleanerTest < Minitest::Test
  include TestHelper

  def setup
    super
    @cleaner = ArticleCleaner.new(@temp_dir)
  end

  def test_uses_provided_storage
    storage = SyncStatusStorage.new(@temp_dir)
    cleaner = ArticleCleaner.new(@temp_dir, storage: storage)
    assert_equal storage, cleaner.storage, "Should use the provided storage instance"
  end

  def test_creates_new_storage_when_not_provided
    cleaner = ArticleCleaner.new(@temp_dir)
    assert_instance_of SyncStatusStorage, cleaner.storage, "Should create a new storage instance"
  end

  def test_cleanup_renamed_articles_with_nonexistent_directory
    FileUtils.rm_rf(@temp_dir)
    assert_raises(ArgumentError) { @cleaner.cleanup_renamed_articles }
  end

  def test_cleanup_renamed_articles_with_empty_storage
    create_article_dir("old-article")
    deleted = @cleaner.cleanup_renamed_articles
    assert_includes deleted, "old-article", "Should delete article not in storage"
  end

  def test_cleanup_renamed_articles_with_valid_storage
    storage_data = {
      1 => { slug: "keep-article", synced: true },
      2 => { slug: "also-keep", synced: true }
    }
    @cleaner.storage.save(storage_data)

    create_article_dir("keep-article")
    create_article_dir("also-keep")
    create_article_dir("delete-me")

    deleted = @cleaner.cleanup_renamed_articles

    assert_includes deleted, "delete-me", "Should delete article not in storage"
    refute_includes deleted, "keep-article", "Should keep article in storage"
    refute_includes deleted, "also-keep", "Should keep article in storage"
  end

  private

  def create_article_dir(name)
    dir = File.join(@temp_dir, name)
    FileUtils.mkdir_p(dir)
    File.write(File.join(dir, "index.md"), "# Test Content")
  end
end
