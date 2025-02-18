require "fileutils"
require "yaml"
require "sync/logging"
require "sync/sync_status_storage"

class ArticleCleaner
  include Logging

  ARTICLE_FILE = "index.md".freeze

  attr_reader :working_dir, :storage, :app

  def initialize(app:)
    @working_dir = app.working_dir
    @storage = app.storage || SyncStatusStorage.new(@working_dir)
    @app = app
  end

  def cleanup_renamed_articles
    raise ArgumentError, "Working directory doesn't exist" unless working_dir.exist?

    deleted_folders = []
    slugs = load_slugs_from_storage

    Dir.glob("#{working_dir}/*").each do |folder_path|
      next unless File.directory?(folder_path) && File.exist?("#{folder_path}/#{ARTICLE_FILE}")

      folder_name = File.basename(folder_path)
      unless slugs.include?(folder_name)
        begin
          unless app.dry_run?
            FileUtils.rm_rf(folder_path)
            deleted_folders << folder_name
          end
          logger.info "Deleted folder: #{folder_name}"
        rescue => e
          logger.error "Failed to delete folder #{folder_name}: #{e.message}"
          raise
        end
      end
    end

    deleted_folders
  end

  private

  def load_slugs_from_storage
    storage_data = storage.load
    raise "Invalid storage data structure" unless storage_data.is_a?(Hash)

    storage_data.values.map do |article|
      raise "Invalid article data structure" unless article.is_a?(Hash) && article[:slug]
      article[:slug]
    end
  rescue => e
    logger.error "Failed to load slugs from storage: #{e.message}"
    raise
  end
end
