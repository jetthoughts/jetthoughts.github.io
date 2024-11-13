require "json"
require 'ostruct'

class FakeHttpClient
  def get_articles(url, page = 1)
    OpenStruct.new(success?: true, body: index_response)
  end

  def get_article(url)
    id = url.split("/").last

    OpenStruct.new(success?: true, body: show_response(id))
  end

  def download(url)
    image_response
  end

  def index_response
    File.read("test/fixtures/responses/index.json")
  end

  def show_response(id)
    File.read("test/fixtures/responses/#{id}.json")
  end

  def image_response
    OpenStruct.new(
      success?: true,
      body: File.open('test/fixtures/images/sample.jpeg').read
    )
  end

  def update_article(url, headers:, body:)
    OpenStruct.new(
      success?: true,
      body: JSON.generate({ "edited_at" => '2024-10-23T15:44:11Z' })
    )
  end
end
