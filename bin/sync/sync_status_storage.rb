require "yaml"
require "pathname"
require_relative "logging"

class SyncStatusStorage
  include Logging

  DEFAULT_SYNC_STATUS_FILE = "sync_status.yml".freeze

  attr_reader :sync_file_path

  def initialize(working_dir, file_name: DEFAULT_SYNC_STATUS_FILE)
    @sync_file_path = Pathname.new(working_dir).join(file_name)
  end

  def ensure_file_exists
    return if sync_file_path.exist?

    sync_file_path.write({}.to_yaml)
  end

  def load(force: false)
    @_cache = nil if force

    @_cache ||= begin
      YAML.load_file(sync_file_path)
    rescue Errno::ENOENT
      logger.warn "Warning: #{sync_file_path} not found."
      {}
    rescue Psych::SyntaxError => e
      logger.error "YAML parsing error in #{sync_file_path}: #{e.message}"
      {}
    end
  end

  def save(sync_status)
    logger.debug "Saving sync status to #{sync_file_path}"
    @_cache = sync_status
    sync_file_path.write(sync_status.to_yaml)
  end
end
