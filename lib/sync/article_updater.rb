require "fileutils"
require "yaml"
require "sync/logging"
require "sync/retryable"
require "sync/images_downloader"

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
      @storage = app.storage
    end

    def download_articles
      articles_to_sync.each do |id, status|
        with_error_handling(id) do
          process_article(id, status)
        end
      end
    end

    private

    def process_article(id, status)
      article = fetch_article(id)
      return unless article

      save_content(article, status)
      update_metadata(article, status)
      save_sync_status
    end

    def save_content(article, status)
      write_markdown_file(article, status)
      download_images(article, status)
      status[:synced] = true
    end

    def write_markdown_file(article, status)
      content_path = content_path_for(status[:slug])
      ensure_directory(content_path.dirname)

      File.write(content_path, build_markdown_content(article, status))
      logger.info("\nArticle saved: #{content_path}")
    rescue => e
      logger.error("Error saving article #{status[:slug]}: #{e.message}")
      raise
    end

    def build_markdown_content(article, status)
      metadata = generate_metadata(article, status)
      content = prepare_markdown(article["body_markdown"].to_s)
      "#{metadata.to_yaml(line_width: -1)}---\n#{content}"
    end

    def generate_metadata(article, status)
      {
        "dev_to_id" => article["id"],
        "dev_to_url" => article["url"],
        "title" => article["title"],
        "description" => status[:description] || article["description"],
        "created_at" => article["created_at"],
        "edited_at" => article["edited_at"],
        "draft" => false,
        "tags" => article["tags"],
        "canonical_url" => article["canonical_url"],
        "cover_image" => article["cover_image"],
        "slug" => status[:slug],
        "metatags" => generate_metatags(article)
      }.compact
    end

    def generate_metatags(article)
      return nil if article["cover_image"].to_s.empty?
      {"image" => "cover#{File.extname(article['cover_image'])}"}
    end

    def update_metadata(article, status)
      return if metadata_up_to_date?(article, status)
      return unless should_update_metadata?

      logger.debug("Updating dev.to metadata for article ID: #{status[:slug]}...")
      if (updated = update_remote_metadata(article["id"], status))
        status.merge!(edited_at: updated["edited_at"], synced: true)
      end
    end

    def metadata_up_to_date?(article, status)
      if article_fetcher.has_updated_metadata?(article, status, status[:slug])
        status[:synced] = true
        logger.debug("Article ID: #{status[:slug]} already synced.")
        true
      end
    end

    def should_update_metadata?
      ENV["SYNC_ENV"] == "test" && !app.dry_run?
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
        article_fetcher,
        working_dir,
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

    def content_path_for(slug)
      working_dir.join(slug, CONTENT_FILE)
    end

    def ensure_directory(path)
      FileUtils.mkdir_p(path) unless path.directory?
    end

    def prepare_markdown(markdown)
      markdown.gsub(
        /\{% youtube "https:\/\/youtu\.be\/([a-zA-Z0-9_-]+)(?:\?.*?)?" %\}/,
        '{{< youtube \1 >}}'
      )
    end
  end
end
