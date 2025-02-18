require "yaml"
require_relative "logging"
require_relative "article_sync_checker"
require_relative "article_updater"
require_relative "article_cleaner"
require_relative "dev_to_client"
require_relative "app"

class Sync
  include Logging

  attr_reader :http_client, :app

  def initialize(app: App.new, http_client: DevToClient.new)
    @app = app
    @http_client = http_client
  end

  def self.perform(**kwargs)
    new(**kwargs).perform
  end

  def perform
    sync_checker.update_sync_status
    article_updater.download_new_articles(app.force?, dry_run: app.dry_run?)
    article_cleaner.cleanup_renamed_articles unless app.dry_run?
  end

  private

  def sync_checker
    @sync_checker ||= ArticleSyncChecker.new(app.working_dir, http_client)
  end

  def article_updater
    @article_updater ||= ArticleUpdater.new(app.working_dir, http_client)
  end

  def article_cleaner
    @article_cleaner ||= ArticleCleaner.new(app.working_dir)
  end
end
