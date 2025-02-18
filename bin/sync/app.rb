# frozen_string_literal: true

require "logger"
require_relative "logging"
require_relative "sync_status_storage"

class App
  include Logging

  DEFAULT_WORKING_DIR = "content/blog/".freeze

  attr_reader :working_dir, :logger, :storage

  def initialize(args: [], working_dir: DEFAULT_WORKING_DIR, logger: Logger.new($stdout))
    @args = args
    @working_dir = working_dir
    @logger = logger
    @storage = SyncStatusStorage.new(@working_dir)
    @storage.ensure_file_exists
  end

  def dry_run?
    @args.include?("--dry")
  end

  def force?
    @args.include?("-f") || @args.include?("--force")
  end
end
