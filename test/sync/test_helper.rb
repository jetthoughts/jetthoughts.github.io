# frozen_string_literal: true

require_relative "../unit_helper"
require_relative "test_http_client"

module TestHelper
  def create_temp_dir
    @__created_tmp_dir = Dir.mktmpdir
  end

  def remove_temp_dir
    FileUtils.remove_entry @__created_tmp_dir if defined?(@__created_tmp_dir) && Dir.exist?(@__created_tmp_dir)
  end

  def create_sync_file(dir, content, filename = "sync_status.yml")
    File.write(File.join(dir, filename), content.to_yaml)
  end

  def sample_article(overrides = {})
    {
      "id" => 1,
      "title" => "Test Article",
      "body_markdown" => "# Test Content",
      "slug" => "test-article-123",
      "tags" => "ruby, rails, testing",
      "edited_at" => "2025-02-17T10:00:00Z",
      "created_at" => "2025-02-17T09:00:00Z",
      "url" => "https://dev.to/test-article",
      "description" => "Test description"
    }.merge(overrides)
  end
end

class Minitest::Test
  include TestHelper

  def teardown
    super
    remove_temp_dir
  end
end
