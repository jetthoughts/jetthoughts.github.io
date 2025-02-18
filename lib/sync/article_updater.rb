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

  attr_reader :working_dir, :storage, :article_fetcher, :app

  def initialize(app:)
    @app = app
    @working_dir = app.working_dir
    @article_fetcher = app.fetcher || ArticleFetcher.new(app.http_client)
    @storage = app.storage
  end

  def download_articles
    article_sync_statuses = app.force? ? all_articles : non_synced_articles

    article_sync_statuses.each do |article_id, article_sync_status|
      download_article(article_id, article_sync_status)
    end
  end

  private

  def can_pull?(_dry_run)
    true
  end

  def download_article(article_id, article_sync_status)
    remote_article = fetch_remote_article(article_id)

    unless remote_article
      logger.error "Error fetching article ID: #{article_id}"
      return
    end

    save_content_and_images(article_sync_status, remote_article)

    # Update metadata on dev.to if it is not up to date
    update_remote_metadata(article_sync_status, remote_article)

    save_sync_status_changes
  rescue ::Timeout::Error, ::Faraday::ConnectionFailed => e
    logger.error "Network error: #{e.message}"
    raise NetworkError, "Failed to download article #{article_id}: #{e.message}"
  rescue => e
    logger.error "Error processing article #{article_id}: #{e.message}"
    raise e
  end

  def update_remote_metadata(article_sync_status, remote_data)
    if article_fetcher.has_updated_metadata?(remote_data, article_sync_status, article_sync_status[:slug])
      logger.debug "Article ID: #{article_sync_status[:slug]} already synced."
      article_sync_status[:synced] = true
    else
      article_sync_status[:synced] = false # NOTE: We know that dev.to article does not have required metadata

      if ENV["SYNC_ENV"] == "test" && can_push?(app.dry_run?) # TODO: Remove SYNC_ENV condition
        logger.debug "Overriding dev.to description and canonical_url for article ID: #{article_sync_status[:slug]}..."
        updated_article = article_fetcher.update_meta_on_dev_to(
          remote_data["id"],
          {description: description_for(article_sync_status), canonical_url: canonical_url_for(article_sync_status)}
        )
        # NOTE: We do not need to update the sync if there is no change on the dev.to side
        if updated_article
          article_sync_status[:edited_at] = updated_article["edited_at"]
          article_sync_status[:synced] = true
        end
      end
    end
  end

  def save_content_and_images(article_sync_status, remote_data)
    return unless can_pull?(app.dry_run?)

    save_article_as_markdown(remote_data, article_sync_status[:slug], article_sync_status[:description])
    download_images_and_update_article(article_sync_status[:slug], working_dir, remote_data, article_sync_status)
    article_sync_status[:synced] = true
  end

  def can_push?(dry_run)
    !dry_run
  end

  def description_for(local_data)
    local_data[:description]
  end

  def canonical_url_for(local_data)
    "#{JT_BLOG_HOST}#{local_data[:slug]}/"
  end

  def sync_status
    storage.load
  end

  def fetch_remote_article(article_id)
    article_fetcher.fetch(article_id)
  end

  def download_images_and_update_article(slug, working_dir, remote_data, local_data)
    logger.info "Downloading images to #{working_dir} / #{slug} ..."
    ImagesDownloader.new(slug, article_fetcher, working_dir, remote_data, local_data, app: app).perform
  end

  def save_sync_status_changes
    storage.save(sync_status)
    logger.info "Sync statuses updated!"
  end

  def non_synced_articles
    all_articles.reject { |_key, value| value[:synced] }
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
