require "json"

class FakeHttpClient
  def get(url)
    case url
    when "https://dev.to/api/articles?username=jetthoughts&page=0"
      index_response
    when "https://dev.to/api/articles/1879395"
      show_respone("1879395")
    when "https://dev.to/api/articles/1877720"
      show_respone("1877720")
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
end
