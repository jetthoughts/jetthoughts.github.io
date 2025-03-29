require "fileutils"
require "yaml"
require "tqdm"

require "sync/logging"
require "sync/retryable"
require "sync/images_downloader"
require "sync/post"

module Sync
  class ArticleUpdater
    include Retryable
    include Logging

    class NetworkError < StandardError; end

    JT_BLOG_HOST = "https://jetthoughts.com/blog/".freeze
    CONTENT_FILE = "index.md".freeze

    attr_reader :working_dir, :storage, :article_fetcher, :app

    def initialize(app:)
      @app = app
      @working_dir = app.working_dir
      @article_fetcher = app.fetcher
      @storage = app.status_storage
    end

    def download_articles
      articles_to_sync.with_progress(desc: "Download Articles").each do |id, status|
        with_error_handling(id) do
          process_article(id, status)
        end
      end
    end

    private

    def process_article(id, status)
      article = fetch_article(id)
      unless article
        status[:synced] = false
        return
      end

      save_content(article, status)
      update_metadata(article, status)
      save_sync_status
    end

    def save_content(article, status)
      # return if app.dry_run?
      post = Post.create_from_remote_details(article, status)
      post.save

      download_images(article, status)
      status[:synced] = true

      post
    end

    def update_metadata(article, status)
      if metadata_up_to_date?(article, status)
        logger.debug("Metadata is up to date for article ID: #{status[:slug]}")
        return
      end
      unless should_update_metadata?
        logger.debug("Skipping metadata update for article ID: #{status[:slug]} (dry run)")
        return
      end

      logger.debug("Updating dev.to metadata for article ID: #{status[:slug]}...")
      if (updated = update_remote_metadata(article["id"], status))
        status.merge!(edited_at: updated["edited_at"], synced: true)
      end
    end

    def metadata_up_to_date?(article, status)
      unless article_fetcher.need_to_update_remote?(article, status)
        status[:synced] = true
        logger.debug("Article ID: #{status[:slug]} already synced.")
        true
      end
    end

    def should_update_metadata?
      ENV["SYNC_ENV"] != "test" || !app.dry_run?
    end

    def update_remote_metadata(id, status)
      article_fetcher.update_meta_on_dev_to(
        id,
        {
          description: status[:description],
          canonical_url: "#{JT_BLOG_HOST}#{status[:slug]}/"
        }
      )
    end

    def download_images(article, status)
      logger.info("Downloading images to #{working_dir} / #{status[:slug]} ...")
      ImagesDownloader.new(
        status[:slug],
        article,
        status,
        app: app
      ).perform
    end

    def with_error_handling(id)
      yield
    rescue ::Timeout::Error, ::Faraday::ConnectionFailed => e
      raise NetworkError, "Failed to download article #{id}: #{e.message}"
    rescue => e
      logger.error("Error processing article #{id}: #{e.message}")
      raise
    end

    def fetch_article(id)
      article = article_fetcher.fetch(id)
      logger.error("Error fetching article ID: #{id}") unless article
      article
    end

    def articles_to_sync
      app.force? ? all_articles : non_synced_articles
    end

    def non_synced_articles
      all_articles.reject { |_, status| status[:synced] }
    end

    def all_articles
      storage.load
    end

    def save_sync_status
      storage.save(all_articles)
      logger.info("Sync statuses updated!")
    end
  end
end
