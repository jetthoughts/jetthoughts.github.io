require "fileutils"
require "yaml"

module ArticleCleaner
  SYNC_STATUS_FILE = "sync_status.yml".freeze
  ARTICLE_FILE = "index.md".freeze

  def cleanup_renamed_articles
    raise ArgumentError, "Working directory doesn't exist" unless Dir.exist?(working_dir)

    deleted_folders = []
    slugs = load_slugs_from_yaml

    Dir.glob("#{working_dir}/*").each do |folder_path|
      next unless File.directory?(folder_path) && File.exist?("#{folder_path}/#{ARTICLE_FILE}")

      folder_name = File.basename(folder_path)
      unless slugs.include?(folder_name)
        begin
          FileUtils.rm_rf(folder_path)
          deleted_folders << folder_name
          puts "Deleted folder: #{folder_name}"
        rescue => e
          puts "Failed to delete folder #{folder_name}: #{e.message}"
        end
      end
    end
    deleted_folders
  end

  private

  def load_slugs_from_yaml
    yaml_path = File.join(working_dir, SYNC_STATUS_FILE)

    begin
      yaml_data = YAML.load_file(yaml_path)
      raise "Invalid YAML structure" unless yaml_data.is_a?(Hash)

      yaml_data.values.map do |article|
        raise "Invalid article data structure" unless article.is_a?(Hash) && article[:slug]
        article[:slug]
      end
    rescue => e
      logger.error "Failed to load slugs from YAML: #{e.message}"
      []
    end
  end
end
