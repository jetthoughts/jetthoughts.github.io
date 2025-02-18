require "httparty"
require "faraday"

class DevToClient
  BASE_URL = "https://dev.to/api"

  def initialize(http_client: Faraday)
    @http_client = http_client
  end

  def get_articles(username, page)
    @http_client.get(URI("#{BASE_URL}/articles?username=#{username}&page=#{page}&per_page=#{rand(8999..9999)}"))
  end

  def get_article(id)
    @http_client.get("#{BASE_URL}/articles/#{id}")
  end

  def download(url)
    @http_client.get(url, timeout: 60)
  end

  def update_article(url, headers:, body:)
    @http_client.put(url, body, headers)
  end
end
