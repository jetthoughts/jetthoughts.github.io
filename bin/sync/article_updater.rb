require "fileutils"
require_relative "retryable"
require_relative "images_downloader"

module ArticleUpdater
  JT_BLOG_HOST = "https://jetthoughts.com/blog/".freeze
  DEV_TO_API_URL = "https://dev.to/api/articles".freeze
  YAML_STATUS_FILE = "sync_status.yml".freeze

  include Retryable

  def download_new_articles(force = false)
    raise ArgumentError, "http_client is required" if http_client.nil?
    raise ArgumentError, "working_dir is required" if working_dir.nil?

    articles = force ? all_articles : unsynced_articles

    begin
      articles.each do |article_id, attributes|
        article_data = fetch_article(article_id)
        next unless article_data

        save_article_as_markdown(article_data, attributes[:slug], attributes[:description])
        download_images(attributes[:slug], http_client, working_dir)

        if has_updated_canonical_url?(article_data) && has_updated_meta_description?(article_data)
          mark_as_synced(article_id, nil)
          next
        end

        updated_article = update_meta_on_dev_to(article_id, attributes[:slug], { description: attributes[:description] })
        next unless updated_article

        mark_as_synced(article_id, updated_article["edited_at"])
      end
    rescue => e
      puts "Error processing articles: #{e.message}"
      raise
    end
  end

  private

  def has_updated_canonical_url?(article_data)
    data = sync_status

    return false if article_data["canonical_url"].nil?

    article_data["canonical_url"].split("/").last == data[article_data["id"]][:slug]
  end

  def has_updated_meta_description?(article_data)
    return true if sync_status[article_data["id"]][:description].nil?

    article_data["description"] == sync_status[article_data["id"]][:description]
  end

  def download_images(slug, http_client, working_dir)
    ImagesDownloader.new(slug, http_client, working_dir).call
  end

  def mark_as_synced(article_id, edited_at)
    data = sync_status

    if data[article_id]
      data[article_id][:edited_at] = edited_at || data[article_id][:edited_at]
      data[article_id][:synced] = true
      File.write(File.join(working_dir, YAML_STATUS_FILE), data.to_yaml)
      puts "Article ID: #{article_id} updated successfully."
    else
      puts "Article ID: #{article_id} not found."
    end
  end

  def update_meta_on_dev_to(article_id, slug, meta = {})
    raise ArgumentError, "Missing dev.to api-key header" unless ENV["DEVTO_API_KEY"]

    canonical_url = JT_BLOG_HOST + "#{slug}/"
    url = "#{DEV_TO_API_URL}/#{article_id}"
    headers = {"api-key" => ENV["DEVTO_API_KEY"], "Content-Type" => "application/json"}

    body = {
      article: {
        canonical_url: canonical_url,
        description: meta[:description]
      }.compact
    }

    with_retries(operation: "Updating canonical_url for article #{article_id}") do
      response = http_client.update_article(url, headers: headers, body: body.to_json)

      if response.success?
        puts "Update canonical_url result: #{canonical_url}\n"
        JSON.parse(response.body)
      else
        raise "Failed to update canonical_url: #{response.code} - #{response.message}"
      end
    end
  end

  def unsynced_articles
    sync_status.select { |_key, value| value[:synced] == false }
  end

  def all_articles
    sync_status
  end

  def fetch_article(article_id)
    url = "#{DEV_TO_API_URL}/#{article_id}"

    with_retries(operation: "Fetching article #{article_id}") do
      response = http_client.get_article(url)
      if response.success?
        JSON.parse(response.body)
      else
        raise "Failed to fetch article #{article_id}: #{response.code} - #{response.message}"
      end
    end
  end

  def save_article_as_markdown(article_data, slug, description)
    markdown_content = generate_markdown(article_data, slug, description)

    dir_path = "#{working_dir}#{slug}"
    file_name = "#{dir_path}/index.md"

    begin
      FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)
      File.write(file_name, markdown_content)
      puts "\nArticle saved: #{file_name}"
    rescue => e
      puts "Error saving article #{slug}: #{e.message}"
      raise
    end
  end

  def meta_description()

  end

  def generate_markdown(article_data, slug, description)
    cover_image = article_data["cover_image"]
    metatags_image = {}

    unless cover_image.to_s.empty?
      metatags_image = {
        "metatags" => {
          "image" => "cover#{File.extname(cover_image)}"
        }
      }
    end

    article_hash = {
      "dev_to_id" => article_data["id"],
      "title" => article_data["title"],
      "description" => description || article_data["description"],
      "created_at" => article_data["created_at"],
      "edited_at" => article_data["edited_at"],
      "draft" => false,
      "tags" => article_data["tags"],
      "canonical_url" => article_data["canonical_url"],
      "cover_image" => cover_image,
      "slug" => slug
    }.merge(metatags_image)

    "#{article_hash.to_yaml(line_width: -1)}---\n#{article_data["body_markdown"]}"
  end
end
