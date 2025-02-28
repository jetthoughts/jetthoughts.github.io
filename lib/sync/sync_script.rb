require "yaml"
require "sync/logging"
require "sync/article_sync_checker"
require "sync/article_updater"
require "sync/article_cleaner"
require "sync/dev_to_client"
require "sync/app"
require "sync/source"

class SyncScript
  include Logging

  attr_reader :app

  def initialize(app:)
    @app = app
  end

  def self.perform(**kwargs)
    new(**kwargs).perform
  end

  def perform
    sync_checker.update_sync_status
    article_updater.download_articles
    article_cleaner.cleanup_renamed_articles
  end

  private

  def sync_checker
    @sync_checker ||= ArticleSyncChecker.new(app: app)
  end

  def article_updater
    @article_updater ||= Sync::ArticleUpdater.new(app: app)
  end

  def article_cleaner
    @article_cleaner ||= ArticleCleaner.new(app: app)
  end
end
