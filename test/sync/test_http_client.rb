# frozen_string_literal: true

require "ostruct"
require "json"

class TestHttpClient
  USERNAME = "jetthoughts".freeze

  attr_accessor :articles

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
