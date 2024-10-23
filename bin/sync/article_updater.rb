require 'fileutils'
require_relative 'images_downloader'

module ArticleUpdater
  JT_BLOG_HOST = 'https://jetthoughts.com/blog/'.freeze
  YAML_STATUS_FILE = 'sync_status.yml'.freeze
  DEV_TO_API_URL = 'https://dev.to/api/articles'.freeze

  def download_new_articles(force = false)
    articles = force ? all_articles : unsynced_articles

    articles.each do |article_id, attributes|
      article_data = fetch_article(article_id)

      save_article_as_markdown(article_data, attributes[:slug])
      download_images(attributes[:slug], http_client)
      update_canonical_url_on_dev_to(article_id, attributes[:slug])
      update_article_edited_at(article_id)
    end
  end

  private

  def download_images(slug, http_client)
    ImagesDownloader.new(slug, http_client, working_dir).call
  end

  def sync_status
    yaml_parser.load_file(working_dir + YAML_STATUS_FILE)
  end

  def update_article_edited_at(article_id)
    data = sync_status

    if data[article_id]
      data[article_id][:edited_at] = actual_article_edited_at(article_id)
      data[article_id][:synced] = true
      File.open(working_dir + YAML_STATUS_FILE, 'w') { |f| f.write(data.to_yaml) }
      puts "Article ID: #{article_id} updated successfully."
    else
      puts "Article ID: #{article_id} not found."
    end
  end

  def update_canonical_url_on_dev_to(article_id, slug)
    canonical_url = JT_BLOG_HOST + "#{slug}/"
    url = "#{DEV_TO_API_URL}/#{article_id}"
    headers = {
      'api-key' => ENV['DEVTO_API_KEY'],
      'Content-Type' => 'application/json'
    }

    body = { article: { canonical_url: canonical_url } }.to_json
    max_retries = 5
    attempt = 0

    begin
      attempt += 1
      response = http_client.put(url, headers: headers, body: body)

      if response.success?
        puts "Update canonical_url result: #{canonical_url}\n"
        return response
      else
        raise "Failed to update canonical_url: #{response.code} - #{response.message} (Attempt #{attempt})"
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

  def actual_article_edited_at(article_id)
    article = fetch_article(article_id)
    article['edited_at']
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

    url = "#{DEV_TO_API_URL}/#{article_id}"

    begin
      response = http_client.get(url)

      if response.success?
        JSON.parse(response.body)
      else
        raise "Failed to fetch article #{article_id}: #{response.code} - #{response.message}"
      end

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

    File.write(file_name, markdown_content)
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
