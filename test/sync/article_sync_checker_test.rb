# frozen_string_literal: true

require "unit_helper"
require_relative "../../bin/sync/article_sync_checker"

require "ostruct"
require "json"
require "yaml"

class ArticleSyncCheckerTest < Minitest::Test
  class TestHttpClient
    def get_articles(username, page)
      OpenStruct.new(
        body: [
          {
            "id" => 1,
            "edited_at" => "2025-02-17T13:00:00Z",
            "created_at" => "2025-02-17T12:00:00Z",
            "slug" => "test-article-title",
            "tags" => "ruby, rails"
          }
        ].to_json
      )
    end
  end

  class TestClass
    include ArticleSyncChecker
    attr_reader :http_client, :working_dir, :sync_status

    def initialize(working_dir, http_client = TestHttpClient.new)
      @working_dir = working_dir
      @http_client = http_client
      @sync_status = {}
    end
  end

  def setup
    @temp_dir = Dir.mktmpdir
    @checker = TestClass.new(@temp_dir)
  end

  def teardown
    FileUtils.remove_entry @temp_dir
  end

  def test_updates_status_with_source_field
    @checker.update_sync_status

    status = YAML.load_file(File.join(@temp_dir, ArticleSyncChecker::SYNC_STATUS_FILE))
    assert_equal "dev_to", status["1"][:source]
    assert_equal "test-article-ruby-rails", status["1"][:slug]
    assert_equal "2025-02-17T13:00:00Z", status["1"][:edited_at]
    refute status["1"][:synced]
  end
end
