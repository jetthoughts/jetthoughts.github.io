require 'httparty'
require 'json'
require 'yaml'
require_relative "./article_sync_checker.rb"
require_relative "./article_updater.rb"
require_relative "./article_cleaner.rb"
require_relative "./dev_to_adapter.rb"

class Sync
  include ArticleSyncChecker
  include ArticleUpdater
  include ArticleCleaner

  def initialize(http_client: DevToAdapter.new, working_dir: "content/blog/")
    @http_client = http_client
    @working_dir = working_dir
  end

  def self.perform(force = false, http_client: DevToAdapter.new, working_dir: "content/blog/")
    new(http_client: http_client, working_dir: working_dir).perform(force)
  end

  def perform(force)
    update_sync_status
    download_new_articles(force)
    cleanup_renamed_articles
  end

  private

  attr_reader :http_client, :working_dir
end

