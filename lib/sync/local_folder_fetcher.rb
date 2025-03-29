require "yaml"
require "sync/fetcher"
require "sync/logging"

module Sync
  module LocalFolderFetcher
    include Fetcher
    include Logging
    
    def fetch_articles
      articles = []
      Dir.glob(File.join(folder_path, "*")).select { |f| File.directory?(f) }.each do |dir|
        article_id = File.basename(dir)
        article = fetch(article_id)
        articles << article if article
      end
      articles
    end

    def fetch(id)
      path = File.join(folder_path, id.to_s)
      return nil unless Dir.exist?(path)

      content_file = File.join(path, "content.md")
      return nil unless File.exist?(content_file)

      content = File.read(content_file)
      metadata = extract_metadata(content)
      
      process_article({
        "id" => id,
        "title" => metadata["title"] || id,
        "description" => metadata["description"],
        "body_markdown" => strip_frontmatter(content),
        "cover_image" => find_cover_image(path),
        "slug" => id,
        "canonical_url" => metadata["canonical_url"]
      })
    end

    def fetch_image(path)
      return nil unless File.exist?(path)
      File.binread(path)
    end

    def need_to_update_remote?(article_data, article_sync_data)
      # Local folders don't need remote updates
      false
    end

    def update_meta_on_dev_to(id, data)
      # No-op for local folders
      nil
    end

    private

    def folder_path
      raise NotImplementedError, "Implementers must define #folder_path"
    end

    def find_cover_image(dir)
      %w[thumbnail.jpeg cover.jpg cover.jpeg thumbnail.jpg].each do |name|
        path = File.join(dir, name)
        return path if File.exist?(path)
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
