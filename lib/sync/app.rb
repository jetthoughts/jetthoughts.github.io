# frozen_string_literal: true

require "sync/logging"
require "sync/configuration"
require "sync/dev_to_article_fetcher"
require "sync/sync_status_storage"

class App
  include Logging

  DEFAULT_WORKING_DIR = "content/blog"

  attr_reader :working_dir, :logger, :fetcher, :args

  def self.config
    @config ||= Sync::Configuration.new
  end

  def self.configure
    yield config
  end

  def initialize(args: [], working_dir: App.config.working_dir, register: nil)
    @args = args
    @working_dir = Pathname.new(working_dir).cleanpath
    @register = register
  end

  def status_storage
    @storage ||= SyncStatusStorage.new(@working_dir).tap(&:ensure_file_exists)
  end

  def register
    @register ||= Sync::Source::Lookup.new
  end

  def dry_run?
    @args.include?("--dry")
  end

  def force?
    @args.include?("-f") || @args.include?("--force")
  end

  def run
    SyncScript.perform(app: self)
  end
end
