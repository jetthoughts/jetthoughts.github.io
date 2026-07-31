# frozen_string_literal: true

require "ostruct"
require "json"
require "time" # Time#iso8601 - not transitively loaded on Ruby < 4.0

class TestHttpClient
  USERNAME = "jetthoughts"

  attr_accessor :articles, :update_requests

  def initialize(articles)
    @articles = articles
    @update_requests = []
  end

  def get_articles(username, _)
    raise ArgumentError, "Invalid username" unless username == USERNAME
    OpenStruct.new(body: @articles.to_json, success?: true)
  end

  def get_article(id)
    result = @articles.find { |article| id.to_s == (article["remote_id"] || article["id"]).to_s }

    if result
      OpenStruct.new(body: result.to_json, success?: true)
    else
      OpenStruct.new(success?: false, code: 404, message: "Not Found")
    end
  rescue => e
    OpenStruct.new(success?: false, code: 500, message: e.message)
  end

  def update_article(article_id, data)
    @update_requests << {article_id: article_id, data: data}
    {"edited_at" => Time.now.iso8601, "success" => true}
  end

  def download(url)
    OpenStruct.new(success?: !url.include?("fail"), body: "fake-image-data")
  end
end
