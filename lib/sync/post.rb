# frozen_string_literal: true

require "sync/post_storage"

module Sync
  class Post
    include Logging
    REPO_URL = "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master"

    class << self
      DEFAULT_WORKING_DIR = "content/blog"

      def configure(working_dir = DEFAULT_WORKING_DIR)
        @storage = PostStorage.new(working_dir)
      end

      def storage
        @storage ||= configure
      end

      attr_writer :storage
    end

    attr_accessor :slug, :storage, :metadata, :body_markdown

    def initialize(slug, storage: Post.storage)
      @storage = storage
      @slug = slug
    end

    def self.for(article, status, storage: Post.storage)
      metadata = generate_metadata(article, status)
      content = prepare_markdown(article["body_markdown"].to_s)

      Post.new(status[:slug], storage:).tap do |post|
        post.metadata = metadata
        post.body_markdown = content
      end
    end

    def save
      @content = assemble_content
      @storage.save_content(slug, assemble_content)
      logger.info("\nArticle saved: #{slug}")
    rescue => e
      logger.error("Error saving article #{slug}: #{e.message}")
      raise
    end

    def content
      @content ||= @storage.read_content(slug)
    end

    def cover_image
      load unless metadata
      metadata["cover_image"]
    end

    def cover_image=(url)
      if url.nil? || url.empty?
        metadata.delete("cover_image")
        @storage.remove_asset(slug, cover_image_file_name) if cover_image_file_name
        return
      end

      metadata["cover_image"] = url
    end

    def cover_image_file_name
      return unless cover_image
      @_cover_image_file_name ||= begin
        ext = File.extname(URI(cover_image).path)
        "cover#{ext}"
      end
    end

    def remove_cover_image
      storage.remove_asset(slug, cover_image_file_name)
    end

    def cover_image_public_url
      to_public_url(page_bundle_dir / cover_image_file_name)
    end

    def to_public_url(cover_path)
      "#{REPO_URL}/#{cover_path}"
    end

    def self.load(slug)
      Post.new(slug).load
    end

    def load
      content_split = content.split("---\n")
      return self if content_split.size < 2

      self.metadata = YAML.load(content_split[1])
      self.body_markdown = content_split[2]

      self
    end
    alias reload load

    def page_bundle_dir
      @storage.page_bundle_dir(slug)
    end

    private

    def assemble_content
      "#{metadata.to_yaml(line_width: -1)}---\n#{body_markdown}"
    end

    def self.prepare_markdown(markdown)
      markdown.gsub(
        /\{% youtube "https:\/\/youtu\.be\/([a-zA-Z0-9_-]+)(?:\?.*?)?" %\}/,
        '{{< youtube \1 >}}'
      )
    end

    def self.generate_metadata(article, status)
      {
        "dev_to_id" => article["id"],
        "remote_id" => article["id"],
        "source" => "dev_to",
        "dev_to_url" => article["url"],
        "remote_url" => article["url"],
        "title" => article["title"],
        "description" => status[:description] || article["description"],
        "created_at" => article["created_at"],
        "edited_at" => article["edited_at"],
        "draft" => false,
        "tags" => article["tags"],
        "canonical_url" => article["canonical_url"],
        "cover_image" => article["cover_image"],
        "slug" => status[:slug],
        "metatags" => generate_metatags(article)
      }.compact
    end

    def self.generate_metatags(article)
      return nil if article["cover_image"].to_s.empty?
      {"image" => "cover#{File.extname(article["cover_image"])}"}
    end
  end
end
