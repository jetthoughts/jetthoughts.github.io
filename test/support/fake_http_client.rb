require "json"
require 'ostruct'
require 'httparty'

class FakeHttpClient
  def get(url, timeout = 60)
    case
    when url == "https://dev.to/api/articles?username=jetthoughts&page=0"
      index_response
    when url == "https://dev.to/api/articles/1879395"
      show_respone("1879395")
    when url == "https://dev.to/api/articles/1877720"
      show_respone("1877720")
    when url.include?("jpeg") || url.include?("png")
      image_response
    else
      raise "Unexpected URL: #{url}"
    end
  end

  def index_response
    index_content = File.read("test/fixtures/responses/index.json")
    JSON.parse(index_content)
  end

  def show_respone(id)
    show_content = File.read("test/fixtures/responses/#{id}.json")
    JSON.parse(show_content)
  end

  def image_response
    OpenStruct.new(
      success?: true,
      body: File.open('test/fixtures/images/sample.jpeg').read
    )
  end
end
