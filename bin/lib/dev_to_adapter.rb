class DevToAdapter
  BASE_URL = 'https://dev.to/api'

  def initialize(http_client: HTTParty)
    @http_client = http_client
  end

  def get_articles(username, page)
    @http_client.get("#{BASE_URL}/articles?username=#{username}&page=#{page}")
  end

  def get_article(id)
    @http_client.get("#{BASE_URL}/articles/#{id}")
  end
end

