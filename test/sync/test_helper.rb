# frozen_string_literal: true

require_relative "../unit_helper"
require_relative "test_http_client"
require_relative "factories"
require "pathname"
require "yaml"

module TestHelper
  def setup
    super
    setup_temp_dir
  end

  def teardown
    teardown_temp_dir
    super
  end

  def setup_temp_dir
    @temp_dir = Dir.mktmpdir
  end

  def teardown_temp_dir
    FileUtils.remove_entry_secure(@temp_dir) if @temp_dir && Dir.exist?(@temp_dir)
  end

  # Factory method shortcuts
  def create_sync_file(dir, content, filename = "sync_status.yml")
    TestFactories::SyncStatus.create_file(dir, content, filename)
  end

  def create_article_dir(slug, content = "# Test Content")
    TestFactories::Article.create_page_bundle(@temp_dir, slug, content)
  end

  def create_article_with_metadata(slug, metadata = {}, content = "# Test Content")
    TestFactories::Article.create_with_metadata(@temp_dir, slug, metadata, content)
  end

  def read_markdown_metadata(file_path)
    TestFactories::Article.read_metadata(file_path)
  end

  def create_sync_status(...)
    TestFactories::SyncStatus.create(...)
  end

  def sample_article(...)
    TestFactories::Article.build_details(...)
  end
end

class Minitest::Test
  include TestHelper
end
