# frozen_string_literal: true

require "logger"
require_relative "logging"

class App
  include Logging

  DEFAULT_WORKING_DIR = "content/blog/".freeze
  DEFAULT_SYNC_STATUS_FILE = "sync_status.yml".freeze

  attr_reader :working_dir, :sync_status_file, :logger

  def initialize(args: [], working_dir: DEFAULT_WORKING_DIR, sync_status_file: DEFAULT_SYNC_STATUS_FILE, logger: Logger.new($stdout))
    @args = args
    @working_dir = working_dir
    @sync_status_file = sync_status_file
    @logger = logger
  end

  def dry_run?
    @args.include?("--dry")
  end

  def force?
    @args.include?("-f") || @args.include?("--force")
  end
end
