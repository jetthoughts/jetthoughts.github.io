# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/article_cleaner"

class ArticleCleanerTest < Minitest::Test
  include TestHelper

  def setup
    @temp_dir = create_temp_dir
    @cleaner = ArticleCleaner.new(@temp_dir)
  end

  def test_cleanup_renamed_articles_with_no_working_dir
    FileUtils.remove_entry @temp_dir
    error = assert_raises(ArgumentError) { @cleaner.cleanup_renamed_articles }
    assert_equal "Working directory doesn't exist", error.message
  end

  def test_cleanup_renamed_articles_with_no_sync_file
    create_article_dir("old-article")
    deleted_folders = @cleaner.cleanup_renamed_articles
    assert_equal ["old-article"], deleted_folders
    refute File.exist?(File.join(@temp_dir, "old-article"))
  end

  def test_cleanup_renamed_articles_with_valid_sync_file
    create_sync_file(
      @temp_dir,
      1 => {
        edited_at: "2025-02-17T10:00:00Z",
        slug: "keep-article",
        synced: true,
        source: "dev_to"
      },
      2 => {
        edited_at: "2025-02-17T10:00:00Z",
        slug: "another-article",
        synced: true,
        source: "dev_to"
      }
    )
    create_article_dir("keep-article")
    create_article_dir("remove-article")

    deleted_folders = @cleaner.cleanup_renamed_articles

    assert_equal ["remove-article"], deleted_folders
    assert File.exist?(File.join(@temp_dir, "keep-article"))
    refute File.exist?(File.join(@temp_dir, "remove-article"))
  end

  def test_cleanup_renamed_articles_with_invalid_yaml
    create_sync_file(@temp_dir, "invalid: yaml: content: - ")
    create_article_dir("test-article")

    deleted_folders = @cleaner.cleanup_renamed_articles

    assert_equal ["test-article"], deleted_folders
    refute File.exist?(File.join(@temp_dir, "test-article"))
  end

  def test_cleanup_renamed_articles_with_invalid_article_structure
    create_sync_file(@temp_dir, "article1:\n  invalid_key: value")
    create_article_dir("test-article")

    deleted_folders = @cleaner.cleanup_renamed_articles

    assert_equal ["test-article"], deleted_folders
    refute File.exist?(File.join(@temp_dir, "test-article"))
  end

  private

  def create_article_dir(name)
    dir_path = File.join(@temp_dir, name)
    FileUtils.mkdir_p(dir_path)
    File.write(File.join(dir_path, ArticleCleaner::ARTICLE_FILE), "# Test Content")
  end
end
