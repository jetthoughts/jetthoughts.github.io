require "json"

class FakeHttpClient
  def get(url)
    case url
    when /articles\?username=jetthoughts&page=0/
      index_response
    when /articles\/2040573/
      show_respone
    else
      raise "Unexpected URL: #{url}"
    end
  end

  def index_response
    index_content = File.read("test/fixtures/responses/index.json")
    JSON.parse(index_content)
  end

  def show_respone
    show_content = File.read("test/fixtures/responses/show.json")
    JSON.parse(show_content)
  end
end
