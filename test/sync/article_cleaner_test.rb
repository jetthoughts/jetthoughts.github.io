# frozen_string_literal: true

require "unit_helper"
require_relative "../../bin/sync/article_cleaner"

class ArticleCleanerTest < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir
    @cleaner = ArticleCleaner.new(@temp_dir, Logger.new(IO::NULL))
  end

  def teardown
    FileUtils.remove_entry @temp_dir if Dir.exist?(@temp_dir)
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
    create_sync_file([{ slug: "keep-article" }, { slug: "another-article" }])
    create_article_dir("keep-article")
    create_article_dir("remove-article")

    deleted_folders = @cleaner.cleanup_renamed_articles

    assert_equal ["remove-article"], deleted_folders
    assert File.exist?(File.join(@temp_dir, "keep-article"))
    refute File.exist?(File.join(@temp_dir, "remove-article"))
  end

  def test_cleanup_renamed_articles_with_invalid_yaml
    create_sync_file_with_content("invalid: yaml: content: - ")
    create_article_dir("test-article")

    deleted_folders = @cleaner.cleanup_renamed_articles

    assert_equal ["test-article"], deleted_folders
    refute File.exist?(File.join(@temp_dir, "test-article"))
  end

  def test_cleanup_renamed_articles_with_invalid_article_structure
    create_sync_file_with_content("article1:\n  invalid_key: value")
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

  def create_sync_file(articles)
    content = articles.each_with_index.to_h { |article, i| ["article#{i + 1}", article] }
    create_sync_file_with_content(content.to_yaml)
  end

  def create_sync_file_with_content(content)
    File.write(File.join(@temp_dir, ArticleCleaner::SYNC_STATUS_FILE), content)
  end
end
