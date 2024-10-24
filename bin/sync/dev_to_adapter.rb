class DevToAdapter
  BASE_URL = 'https://dev.to/api'

  def initialize(http_client: HTTParty)
    @http_client = http_client
  end

  def get_articles(username, page)
    @http_client.get("#{BASE_URL}/articles?username=#{username}&page=#{page}&per_page=1000&cache_buster=#{Time.now.to_i}")
  end

  def get_article(id)
    @http_client.get(id)
  end

  def download(url)
    @http_client.get(url, timeout: 60)
  end

  def update_article(url, headers: , body:)
    @http_client.put(url, headers: headers, body: body)
  end
end
