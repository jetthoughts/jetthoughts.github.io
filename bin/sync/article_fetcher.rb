require_relative "retryable"

class ArticleFetcher
  include Logging
  include Retryable

  def initialize(http_client)
    @http_client = http_client
  end

  def fetch(article_id)
    with_retries(operation: "Fetching article #{article_id}") do
      response = http_client.get_article(article_id)
      if response.success?
        JSON.parse(response.body)
      else
        raise "Failed to fetch article #{article_id}: #{response.code} - #{response.message}"
      end
    end
  end

  def fetch_image(url)
    original_image_url = remove_cdn(url)
    with_retries(operation: "Downloading image from #{original_image_url}") do
      response = http_client.download(original_image_url)
      if response.success?
        return response.body
      else
        raise "Failed to download #{url}: #{response.code} #{response.message}"
      end
    end
  end

  def original_image_url(url)
    remove_cdn(url)
  end

  def ext_from_image_url(image_url)
    File.extname(URI(remove_cdn(image_url)).path)
  end

  def remove_cdn(url)
    encoded_url = "https" + url.split("https").last
    max_attempts = 5
    attempts = 0

    while encoded_url.include?("%") && attempts < max_attempts
      encoded_url = URI.decode_www_form_component(encoded_url)
      attempts += 1
    end

    encoded_url
  end

  private

  attr_reader :http_client
end
