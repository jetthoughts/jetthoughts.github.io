# frozen_string_literal: true

require_relative "../unit_helper"
require "ostruct"

module TestHelper
  USERNAME = "jetthoughts".freeze

  class TestHttpClient
    def initialize(articles)
      @articles = articles
    end

    def get_articles(username, _)
      raise ArgumentError, "Invalid username" unless username == USERNAME
      OpenStruct.new(body: @articles.to_json)
    end

    def get_article(id)
      result = @articles.find { id.to_s == _1["id"].to_s }

      if result
        OpenStruct.new(body: result.to_json, success?: true)
      else
        OpenStruct.new(success?: false, code: 404, message: "Not Found")
      end
    rescue => e
      OpenStruct.new(success?: false, code: 500, message: e.message)
    end

    def update_article(*, **)
      OpenStruct.new(success?: true, body: { edited_at: Time.now.utc }.to_json)
    end

    def download(url)
      OpenStruct.new(success?: !url.include?("fail"), body: "fake-image-data")
    end
  end

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
