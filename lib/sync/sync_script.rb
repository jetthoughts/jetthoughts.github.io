require "yaml"
require "sync/logging"
require "sync/article_sync_checker"
require "sync/article_updater"
require "sync/article_cleaner"
require "sync/dev_to_client"
require "sync/app"

class SyncScript
  include Logging

  attr_reader :app

  def initialize(app: App.new)
    @app = app
  end

  def self.perform(**kwargs)
    new(**kwargs).perform
  end

  def perform
    fetch_articles = app.fetcher.fetch_articles
    sync_checker.update_sync_statuses_for(fetch_articles)
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
