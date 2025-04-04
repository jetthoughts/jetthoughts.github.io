# frozen_string_literal: true

require "sync/post"
require "sync/post_storage"

module TestFactories
  class Article
    def self.build_details(overrides = {})
      {
        "id" => 1,
        "source" => "test",
        "title" => "Test Article",
        "body_markdown" => "# Test Content",
        "slug" => "test-article-123",
        "tags" => "ruby, rails, testing",
        "edited_at" => "2025-02-17T10:00:00Z",
        "created_at" => "2025-02-17T09:00:00Z",
        "url" => "https://dev.to/test-article",
        "description" => "Test description",
        "cover_image" => nil,
        "canonical_url" => nil
      }.merge(overrides)
    end

    def self.create_page_bundle(slug, content = "# Test Content", app:)
      create_with_metadata(slug, {}, content, app:)
    end

    def self.create_with_metadata(slug, metadata = {}, content = "# Test Content", app:)
      metadata = {
        "title" => "Test Article",
        "description" => "Test Description"
      }.merge(metadata)

      post = Sync::Post.new(slug, working_dir: app.working_dir)
      post.metadata = metadata
      post.body_markdown = content

      post.save

      post.page_bundle_dir
    end

    def self.read_metadata(slug:, app:)
      Sync::Post.new(slug, working_dir: app.working_dir).load.metadata
    end
  end

  class SyncStatus
    DEFAULT_ATTRIBUTES = {
      edited_at: "2025-02-17T09:00:00Z", slug: "test-article", synced: false, source: "test", id: 1, description: nil
    }

    def self.create(**attributes)
      sync_record_attrs = DEFAULT_ATTRIBUTES.merge(attributes)
      {"#{sync_record_attrs[:source]}_#{sync_record_attrs[:id]}" => sync_record_attrs}
    end
  end
end
