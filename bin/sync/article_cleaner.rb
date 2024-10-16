require 'yaml'
require 'fileutils'

class ArticleCleaner
  BLOG_DIR = 'content/blog'.freeze
  YAML_FILE = 'sync_status.yml'.freeze
  ARTICLE_FILE = 'index.md'.freeze

  def initialize
    @slugs = load_slugs_from_yaml
  end

  def call
    clean_up_unused_folders
  end

  private

  def load_slugs_from_yaml
    yaml_data = YAML.load_file(YAML_FILE)
    yaml_data.values.map { |article| article[:slug] }
  end

  def clean_up_unused_folders
    Dir.glob("#{BLOG_DIR}/*").each do |folder_path|
      next unless File.directory?(folder_path) && File.exist?("#{folder_path}/#{ARTICLE_FILE}")

      folder_name = File.basename(folder_path)
      unless @slugs.include?(folder_name)
        FileUtils.rm_rf(folder_path)
        puts "Deleted folder: #{folder_name}"
      end
    end
  end
end
