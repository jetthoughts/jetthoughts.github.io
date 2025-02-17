require "yaml"
require "logger"
require_relative "article_sync_checker"
require_relative "article_updater"
require_relative "article_cleaner"
require_relative "dev_to_adapter"

class Sync
  include ArticleUpdater

  DEFAULT_WORKING_DIR = "content/blog/".freeze
  SYNC_STATUS_FILE = "sync_status.yml".freeze

  attr_reader :http_client, :working_dir, :logger

  def initialize(http_client: DevToAdapter.new, working_dir: DEFAULT_WORKING_DIR, logger: Logger.new($stdout))
    @http_client = http_client
    @working_dir = Pathname.new(working_dir)
    @logger = logger
  end

  def self.perform(force = false, **kwargs)
    new(**kwargs).perform(force)
  end

  def sync_status
    YAML.load_file(@working_dir / SYNC_STATUS_FILE)
  rescue Errno::ENOENT
    logger.warn "Warning: #{SYNC_STATUS_FILE} not found."
    {}
  rescue Psych::SyntaxError => e
    logger.error "YAML parsing error in #{SYNC_STATUS_FILE}: #{e.message}"
    {}
  end

  def perform(force)
    sync_checker.update_sync_status
    download_new_articles(force)
    article_cleaner.cleanup_renamed_articles
  end

  private

  def article_cleaner
    @article_cleaner ||= ArticleCleaner.new(working_dir.to_s, logger)
  end

  def sync_checker
    @sync_checker ||= ArticleSyncChecker.new(working_dir.to_s, http_client, logger:)
  end
end
