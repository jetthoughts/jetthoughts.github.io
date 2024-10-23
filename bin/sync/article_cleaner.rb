require 'fileutils'

module ArticleCleaner
  SYNC_STATUS_FILE = 'sync_status.yml'.freeze
  ARTICLE_FILE = 'index.md'.freeze

  def cleanup_renamed_articles
    slugs = load_slugs_from_yaml

    Dir.glob("#{working_dir}/*").each do |folder_path|
      next unless file_manager.directory?(folder_path) && File.exist?("#{folder_path}/#{ARTICLE_FILE}")

      folder_name = file_manager.basename(folder_path)
      unless slugs.include?(folder_name)
        FileUtils.rm_rf(folder_path)
        puts "Deleted folder: #{folder_name}"
      end
    end
  end

  private

  def load_slugs_from_yaml
    yaml_data = yaml_parser.load_file(working_dir + SYNC_STATUS_FILE)
    yaml_data.values.map { |article| article[:slug] }
  end
end
