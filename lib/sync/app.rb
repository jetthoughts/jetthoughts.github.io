# frozen_string_literal: true

require "sync/logging"
require "sync/configuration"
require "sync/article_fetcher"
require "sync/sync_status_storage"

class App
  include Logging

  DEFAULT_WORKING_DIR = "content/blog"

  attr_reader :working_dir, :logger, :http_client, :fetcher, :args

  def self.config
    Thread.current[:sync_app_config] ||= Sync::Configuration.new
  end

  def self.configure
    yield config
  end

  def self.reset_config
    Thread.current[:sync_app_config] = nil
  end

  def initialize(args: [], working_dir: App.config.working_dir, logger: App.config.logger, http_client: nil, fetcher: nil)
    @args = args
    @working_dir = Pathname.new(working_dir).cleanpath
    @logger = logger

    @fetcher = fetcher || ArticleFetcher.new(http_client || DevToClient.new)
    @http_client = @fetcher.http_client
  end

  def status_storage
    @storage ||= SyncStatusStorage.new(@working_dir).tap(&:ensure_file_exists)
  end

  def dry_run?
    @args.include?("--dry")
  end

  def force?
    @args.include?("-f") || @args.include?("--force")
  end
end
