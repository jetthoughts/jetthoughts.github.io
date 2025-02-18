require "fileutils"
require "yaml"
require "sync/logging"
require "sync/retryable"
require "sync/images_downloader"
require "sync/article_fetcher"
require "sync/sync_status_storage"

class ArticleUpdater
  include Retryable
  include Logging

  class NetworkError < StandardError; end

  JT_BLOG_HOST = "https://jetthoughts.com/blog/".freeze

  attr_reader :working_dir, :storage, :article_fetcher

  def initialize(working_dir = nil, http_client = nil, storage: nil, app: nil)
    @working_dir = working_dir ? Pathname.new(working_dir) : app&.working_dir
    raise ArgumentError, "working_dir is required" if @working_dir.nil?

    @article_fetcher = http_client ? ArticleFetcher.new(http_client) : app&.fetcher
    @storage = storage || app&.storage || SyncStatusStorage.new(@working_dir)
  end

  def download_new_articles(force = false, dry_run: false)
    articles = force ? all_articles : non_synced_articles

    articles.each do |article_id, local_data|
      remote_data = fetch_remote_article(article_id)
      unless remote_data
        logger.error "Error fetching article ID: #{article_id}"
        next
      end

      save_article_as_markdown(remote_data, local_data[:slug], local_data[:description])
      download_images_and_update_article(local_data[:slug], working_dir, remote_data, local_data)

      articles_sync_status = storage.load
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
    rescue ::Timeout::Error, ::Faraday::ConnectionFailed => e
      logger.error "Network error: #{e.message}"
      raise NetworkError, "Failed to download article #{article_id}: #{e.message}"
    rescue => e
      logger.error "Error processing article #{article_id}: #{e.message}"
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
    storage.load
  end

  def article_fetcher
    @article_fetcher ||= ArticleFetcher.new(http_client)
  end

  def fetch_remote_article(article_id)
    article_fetcher.fetch(article_id)
  end

  def download_images_and_update_article(slug, working_dir, remote_data, local_data)
    logger.info "Downloading images to #{working_dir} / #{slug} ..."
    ImagesDownloader.new(slug, article_fetcher, working_dir, remote_data, local_data).perform
  end

  def mark_as_synced(article_id, edited_at)
    data = storage.load

    if data[article_id]
      data[article_id][:edited_at] = edited_at || data[article_id][:edited_at]
      data[article_id][:synced] = true
      logger.debug "Saving sync status to #{storage.sync_file_path}"
      storage.save(data)
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
