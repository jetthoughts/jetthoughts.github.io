require_relative "images_processor.rb"
require 'yaml'
require 'json'

class ArticleUpdater
  JT_BLOG_HOST = 'https://jetthoughts.com/blog/'.freeze
  YAML_STATUS_FILE = 'sync_status.yml'.freeze

  def initialize(http_client: Net::HTTP, file_manager: File, yaml_parser: YAML, json_parser: JSON)
    @http_client = http_client
    @file_manager = file_manager
    @yaml_parser = yaml_parser
    @json_parser = json_parser
  end

  def call(force)
    articles = force ? all_articles : unsynced_articles

    articles.each do |article_id, attributes|
      article_data = fetch_article(article_id)

      save_article_as_markdown(article_data, attributes[:slug])
      download_images(attributes[:slug])
      update_canonical_url_on_dev_to(article_id, attributes[:slug])
      update_article_hash(article_id)
    end
  end

  private

  def download_images(slug)
    ImagesProcessor.new(slug).call
  end

  def sync_status
    @yaml_parser.load_file(YAML_STATUS_FILE)
  end

  def update_article_hash(article_id)
    data = sync_status

    if data[article_id]
      data[article_id][:hash] = actual_article_hash(article_id)
      data[article_id][:synced] = true
      File.open(YAML_STATUS_FILE, 'w') { |f| f.write(data.to_yaml) }
      puts "Hash for article ID #{article_id} updated successfully."
    else
      puts "Article ID #{article_id} not found."
    end
  end

  def calculate_hash(article)
    Digest::SHA256.hexdigest(article["created_at"] + article["edited_at"])
  end

  def update_canonical_url_on_dev_to(article_id, slug)
    uri = URI("https://dev.to/api/articles/#{article_id}")
    canonical_url = JT_BLOG_HOST + "#{slug}/"

    request = @http_client::Put.new(uri, {
      'api-key' => ENV['DEVTO_API_KEY'],
      'Content-Type' => 'application/json'
    })
    request.body = { article: { canonical_url: canonical_url } }.to_json

    max_retries = 5
    attempt = 0

    begin
      attempt += 1
      response = @http_client.start(uri.host, uri.port, use_ssl: true) { |http| http.request(request) }

      if response.is_a?(Net::HTTPSuccess)
        puts "Update canonical_url result: #{canonical_url}\n"
        return response
      else
        raise RuntimeError, "Failed to update canonical_url: #{response.message} (Attempt #{attempt})"
      end

    rescue StandardError => e
      if attempt < max_retries
        puts "Error updating canonical_url for article #{article_id}, retrying in #{attempt * 2} seconds..."
        sleep(attempt * 2)
        retry
      else
        puts "Failed to update canonical_url for article #{article_id} after #{max_retries} attempts: #{e.message}"
      end
    end
  end

  def actual_article_hash(article_id)
    article = fetch_article(article_id)
    calculate_hash(article)
  end

  def unsynced_articles
    sync_status.select { |_key, value| value[:synced] == false }
  end

  def all_articles
    sync_status
  end

  def fetch_article(article_id)
    max_attempts = 5
    attempts = 0

    url = URI("https://dev.to/api/articles/#{article_id}")

    begin
      response = @http_client.get(url)
      @json_parser.parse(response)
    rescue StandardError => e
      attempts += 1
      puts "Attempt #{attempts} of #{max_attempts} failed with message: #{e.message}"
      retry if attempts < max_attempts
    end
  end

  def save_article_as_markdown(article_data, slug)
    markdown_content = generate_markdown(article_data, slug)

    dir_path = "content/blog/#{slug}"
    file_name = "#{dir_path}/index.md"

    FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)

    @file_manager.write(file_name, markdown_content)
    puts "\nArticle saved: #{file_name}"
  end

  def generate_markdown(article_data, slug)
    cover_image = article_data['cover_image']
    metatags_image = ""

    unless cover_image.to_s.empty?
      metatags_image = <<~METATAG
      metatags:
        image: cover#{File.extname(cover_image)}
      METATAG
    end

    <<~MARKDOWN
    ---
    dev_to_id: #{article_data['id']}
    title: "#{article_data['title']}"
    description: #{article_data['description'].to_json}
    created_at: "#{article_data['created_at']}"
    edited_at: "#{article_data['edited_at']}"
    draft: false
    tags:
    #{article_data['tags'].map { |tag| "  - #{tag}" }.join("\n")}
    canonical_url: "#{article_data['canonical_url']}"
    cover_image: "#{cover_image}"
    slug: "#{slug}"
    #{metatags_image.strip}
    ---
    #{article_data['body_markdown']}
    MARKDOWN
  end
end

