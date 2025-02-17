require "fileutils"
require "yaml"
require_relative "logging"
require_relative "retryable"
require_relative "images_downloader"
require_relative "article_fetcher"

class ArticleUpdater
  include Retryable
  include Logging

  JT_BLOG_HOST = "https://jetthoughts.com/blog/".freeze
  DEV_TO_API_URL = "https://dev.to/api/articles".freeze
  DEFAULT_SYNC_STATUS_FILE = "sync_status.yml".freeze

  attr_reader :working_dir, :http_client, :sync_file_name

  def initialize(working_dir, http_client, sync_file_name: DEFAULT_SYNC_STATUS_FILE)
    raise ArgumentError, "working_dir is required" if working_dir.nil?

    @working_dir = Pathname.new(working_dir)
    @http_client = http_client
    @sync_file_name = sync_file_name
  end

  def download_new_articles(force = false)
    raise ArgumentError, "http_client is required" if http_client.nil?

    articles = force ? all_articles : non_synced_articles

    begin
      articles.each do |article_id, local_data|
        remote_data = fetch_remote_article(article_id)
        unless remote_data
          logger.error "Error fetching article ID: #{article_id}"
          next
        end

        save_article_as_markdown(remote_data, local_data[:slug], local_data[:description])
        download_images(local_data[:slug], http_client, working_dir, remote_data, local_data)

        if has_updated_canonical_url?(remote_data) && has_updated_meta_description?(remote_data)
          logger.debug "Article ID: #{article_id} already synced."
          mark_as_synced(article_id, nil)
          next
        end

        if ENV["SYNC_ENV"] == "test"
          logger.debug "Syncing metadata for article ID: #{article_id}..."
          updated_article = update_meta_on_dev_to(
            article_id,
            local_data[:slug],
            { description: local_data[:description] }
          )
          next unless updated_article

          mark_as_synced(article_id, updated_article["edited_at"])
        end
      end
    rescue => e
      logger.error "Error processing articles: #{e.message}"
      raise
    end
  end

  private

  def sync_status
    YAML.load_file(sync_file_path)
  rescue Errno::ENOENT
    logger.warn "Warning: #{sync_file_name} not found."
    {}
  rescue Psych::SyntaxError => e
    logger.error "YAML parsing error in #{sync_file_name}: #{e.message}"
    {}
  end

  def sync_file_path
    @_sync_file_path ||= working_dir / sync_file_name
  end

  def fetch_remote_article(article_id)
    ArticleFetcher.new(http_client).fetch(article_id)
  end

  def has_updated_canonical_url?(article_data)
    data = sync_status

    return false if article_data["canonical_url"].nil?

    article_data["canonical_url"].split("/").last == data[article_data["id"]][:slug]
  end

  def has_updated_meta_description?(article_data)
    return false unless sync_status[article_data["id"]]
    return true if sync_status[article_data["id"]][:description].nil?

    article_data["description"] == sync_status[article_data["id"]][:description]
  end

  def download_images(slug, http_client, working_dir, remote_data, local_data)
    logger.info "Downloading images to #{working_dir} / #{slug} ..."
    ImagesDownloader.new(slug, http_client, working_dir, remote_data, local_data).perform
  end

  def mark_as_synced(article_id, edited_at)
    data = sync_status

    if data[article_id]
      data[article_id][:edited_at] = edited_at || data[article_id][:edited_at]
      data[article_id][:synced] = true
      logger.debug "Saving sync status to #{sync_file_path}"
      File.write(sync_file_path, data.to_yaml)
      logger.info "Article ID: #{article_id} updated successfully."
    else
      logger.warn "Article ID: #{article_id} not found."
    end
  end

  def update_meta_on_dev_to(article_id, slug, meta = {})
    raise ArgumentError, "Missing dev.to api-key header" unless ENV["DEVTO_API_KEY"]

    canonical_url = JT_BLOG_HOST + "#{slug}/"
    url = "#{DEV_TO_API_URL}/#{article_id}"
    headers = { "api-key" => ENV["DEVTO_API_KEY"], "Content-Type" => "application/json" }

    body = {
      article: {
        canonical_url: canonical_url,
        description: meta[:description]
      }.compact
    }

    begin
      response = http_client.update_article(url, headers: headers, body: body.to_json)

      if response.success?
        logger.info "Update canonical_url result: #{canonical_url}\n"
        JSON.parse(response.body)
      else
        raise "Failed to update canonical_url: #{response.code} - #{response.message}"
      end
    rescue => e
      logger.error "Error updating article #{article_id}: #{e.message}"
      nil
    end
  end

  def non_synced_articles
    sync_status.select { |_key, value| value[:synced] == false }
  end

  def all_articles
    sync_status
  end

  def save_article_as_markdown(article_data, slug, description)
    dir_path = working_dir / slug
    file_name = dir_path / "index.md"

    begin
      FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)

      metadata = generate_metadata(article_data, slug, description)
      markdown = article_data["body_markdown"] = prepare_markdown(article_data["body_markdown"])

      content = assemble_post_file(metadata, markdown)
      File.write(file_name, content)

      logger.info "\nArticle saved: #{file_name}"
    rescue => e
      logger.error "Error saving article #{slug}: #{e.message}"
      raise
    end
  end

  def generate_metadata(article_data, slug, description)
    metadata = {
      "dev_to_id" => article_data["id"],
      "dev_to_url" => article_data["url"],
      "title" => article_data["title"],
      "description" => description || article_data["description"],
      "created_at" => article_data["created_at"],
      "edited_at" => article_data["edited_at"],
      "draft" => false,
      "tags" => article_data["tags"],
      "canonical_url" => article_data["canonical_url"],
      "cover_image" => article_data["cover_image"],
      "slug" => slug
    }

    unless article_data["cover_image"].to_s.empty?
      metadata["metatags"] = {
        "image" => "cover#{File.extname(article_data["cover_image"])}"
      }
    end

    metadata
  end

  def prepare_markdown(markdown)
    prepare_youtube_links(markdown)
  end

  def assemble_post_file(metadata, markdown)
    "#{metadata.to_yaml(line_width: -1)}---\n#{markdown}"
  end

  def prepare_youtube_links(markdown)
    markdown.gsub(/\{% youtube "https:\/\/youtu\.be\/([a-zA-Z0-9_-]+)(?:\?.*?)?" %\}/, '{{< youtube \1 >}}')
  end
end
