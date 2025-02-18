require "yaml"
require_relative "logging"
require_relative "article_sync_checker"
require_relative "article_updater"
require_relative "article_cleaner"
require_relative "dev_to_client"

class Sync
  include Logging

  DEFAULT_WORKING_DIR = "content/blog/".freeze
  SYNC_STATUS_FILE = "sync_status.yml".freeze

  attr_reader :http_client, :working_dir

  def initialize(http_client: DevToClient.new, working_dir: DEFAULT_WORKING_DIR)
    @http_client = http_client
    @working_dir = Pathname.new(working_dir).cleanpath
  end

  def self.perform(force = false, **kwargs)
    new(**kwargs).perform(force)
  end

  def perform(force)
    sync_checker.update_sync_status
    article_updater.download_new_articles(force)
    article_cleaner.cleanup_renamed_articles
  end

  private

  def sync_checker
    @sync_checker ||= ArticleSyncChecker.new(working_dir, http_client)
  end

  def article_updater
    @article_updater ||= ArticleUpdater.new(working_dir, http_client)
  end

  def article_cleaner
    @article_cleaner ||= ArticleCleaner.new(working_dir)
  end
end
