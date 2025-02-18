require "fileutils"
require "yaml"
require_relative "logging"
require_relative "retryable"
require_relative "images_downloader"
require_relative "article_fetcher"

class ArticleUpdater
  include Retryable
  include Logging

  class NetworkError < StandardError; end

  JT_BLOG_HOST = "https://jetthoughts.com/blog/".freeze
  DEFAULT_SYNC_STATUS_FILE = "sync_status.yml".freeze

  attr_reader :working_dir, :http_client, :sync_file_name

  def initialize(working_dir, http_client, sync_file_name: DEFAULT_SYNC_STATUS_FILE)
    raise ArgumentError, "working_dir is required" if working_dir.nil?

    @working_dir = Pathname.new(working_dir)
    @http_client = http_client
    @sync_file_name = sync_file_name
  end

  def download_new_articles(force = false, dry_run: false)
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
        download_images_and_update_article(local_data[:slug], http_client, working_dir, remote_data, local_data)

        articles_sync_status = sync_status
        if article_fetcher.has_synced_metadata?(remote_data, articles_sync_status, local_data[:slug])
          logger.debug "Article ID: #{article_id} already synced."
          mark_as_synced(article_id, nil)
          next
        end

        if ENV["SYNC_ENV"] == "test" && !dry_run
          logger.debug "Overriding dev.to description and canonical_url for article ID: #{article_id}..."
          updated_article = article_fetcher.update_meta_on_dev_to(article_id, {description: description_for(local_data), canonical_url: canonical_url_for(local_data)})
          # NOTE: We do not need to update the sync if there is no change on the dev.to side
          next unless updated_article

          # NOTE: Update the sync status file with the new edited_at timestamp
          mark_as_synced(article_id, updated_article["edited_at"])
        end
      end
    rescue ::Timeout::Error, ::Faraday::ConnectionFailed => e
      logger.error "Network error: #{e.message}"
      raise NetworkError, "Failed to download articles: #{e.message}"
    rescue => e
      logger.error "Error processing articles: #{e.message}"
      raise
    end
  end

  private

  def description_for(local_data)
    local_data[:description]
  end

  def canonical_url_for(local_data)
    "#{JT_BLOG_HOST}#{local_data[:slug]}/"
  end

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
    @_sync_file_path ||= path_to(sync_file_name)
  end

  def article_fetcher
    @_article_fetcher ||= ArticleFetcher.new(http_client)
  end

  def fetch_remote_article(article_id)
    article_fetcher.fetch(article_id)
  end

  def download_images_and_update_article(slug, http_client, working_dir, remote_data, local_data)
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

  def non_synced_articles
    sync_status.select { |_key, value| value[:synced] == false }
  end

  def all_articles
    sync_status
  end

  def save_article_as_markdown(article_data, slug, description)
    content_path = content_path_for(slug)

    begin
      metadata = generate_metadata(article_data, slug, description)
      markdown = article_data["body_markdown"] = prepare_markdown(article_data["body_markdown"])

      content = assemble_post_file(metadata, markdown)
      File.write(content_path, content)

      logger.info "\nArticle saved: #{content_path}"
    rescue => e
      logger.error "Error saving article #{slug}: #{e.message}"
      raise
    end
  end

  def content_path_for(slug)
    page_bundle_path_for(slug) / "index.md"
  end

  def page_bundle_path_for(slug)
    result = path_to(slug)

    FileUtils.mkdir_p(result) unless Dir.exist?(result)

    result
  end

  def path_to(slug)
    working_dir / slug
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
