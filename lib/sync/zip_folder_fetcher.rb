require "zip"
require "yaml"
require "sync/fetcher"
require "sync/logging"

module Sync
  module ZipFolderFetcher
    include Fetcher
    include Logging
    
    def fetch_articles
      articles = []
      
      Zip::File.open(zip_path) do |zip_file|
        folder_entries = zip_file.entries.select { |e| e.ftype == :directory }
        
        folder_entries.each do |folder_entry|
          article_id = folder_entry.name.chomp('/')
          article = fetch_from_zip(zip_file, article_id)
          articles << article if article
        end
      end
      
      articles
    end

    def fetch(id)
      Zip::File.open(zip_path) do |zip_file|
        fetch_from_zip(zip_file, id)
      end
    rescue => e
      logger.error("Error fetching article from zip: #{e.message}")
      nil
    end

    def fetch_image(path)
      return nil unless path && path.start_with?("zip://")
      
      path = path.gsub("zip://", "")
      
      Zip::File.open(zip_path) do |zip_file|
        entry = zip_file.find_entry(path)
        return nil unless entry
        
        entry.get_input_stream.read
      end
    rescue => e
      logger.error("Error fetching image from zip: #{e.message}")
      nil
    end

    def need_to_update_remote?(article_data, article_sync_data)
      # Zip archives don't need remote updates
      false
    end

    def update_meta_on_dev_to(id, data)
      # No-op for zip archives
      nil
    end

    private

    def zip_path
      raise NotImplementedError, "Implementers must define #zip_path"
    end

    def fetch_from_zip(zip_file, id)
      folder_name = "#{id}/"
      content_entry = zip_file.find_entry("#{folder_name}content.md")
      return nil unless content_entry
      
      content = content_entry.get_input_stream.read
      metadata = extract_metadata(content)
      
      cover_image = find_cover_image_in_zip(zip_file, folder_name)
      
      process_article({
        "id" => id,
        "title" => metadata["title"] || id,
        "description" => metadata["description"],
        "body_markdown" => strip_frontmatter(content),
        "cover_image" => cover_image ? "zip://#{cover_image.name}" : nil,
        "slug" => id,
        "canonical_url" => metadata["canonical_url"]
      })
    end

    def find_cover_image_in_zip(zip_file, folder_name)
      %w[thumbnail.jpeg cover.jpg cover.jpeg thumbnail.jpg].each do |name|
        path = "#{folder_name}#{name}"
        entry = zip_file.find_entry(path)
        return entry if entry
      end
      nil
    end

    def extract_metadata(content)
      frontmatter = content.match(/\A---\n(.*?)\n---/m)
      return {} unless frontmatter
      
      begin
        YAML.safe_load(frontmatter[1]) || {}
      rescue
        {}
      end
    end
    
    def strip_frontmatter(content)
      content.sub(/\A---\n.*?\n---\n/m, '')
    end
    
    def process_article(article)
      article["devto_slug"] = article["slug"]
      article["slug"] = article["slug"]
      article
    end
  end
end
