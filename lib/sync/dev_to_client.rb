require "faraday"

class DevToClient
  include Logging
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

  ARTICLES_API_URL = "#{BASE_URL}/articles".freeze

  def update_article(article_id, article_details)
    raise ArgumentError, "article_id is required" unless article_id
    raise ArgumentError, "DEVTO_API_KEY is required" unless ENV["DEVTO_API_KEY"]

    headers = {"api-key" => ENV["DEVTO_API_KEY"], "Content-Type" => "application/json"}

    body = {article: article_details.compact}

    begin
      response = @http_client.put("#{ARTICLES_API_URL}/#{article_id}", body.to_json, headers)

      if response.success?
        logger.info "Update successful\n"
        JSON.parse(response.body)
      else
        raise "Failed to update canonical_url: #{response.code} - #{response.message}"
      end
    rescue => e
      logger.error "Error updating article #{article_id}: #{e.message}"
      nil
    end
  end

end
