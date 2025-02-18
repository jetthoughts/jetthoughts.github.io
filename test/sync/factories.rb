# frozen_string_literal: true

module TestFactories
  class Article
    def self.create(overrides = {})
      {
        "id" => 1,
        "title" => "Test Article",
        "body_markdown" => "# Test Content",
        "slug" => "test-article",
        "tags" => "ruby, rails, testing",
        "edited_at" => "2025-02-17T10:00:00Z",
        "created_at" => "2025-02-17T09:00:00Z",
        "url" => "https://dev.to/test-article",
        "description" => "Test description",
        "cover_image" => nil,
        "canonical_url" => nil
      }.merge(overrides)
    end

    def self.create_page_bundle(temp_dir, slug, content = "# Test Content")
      create_with_metadata(temp_dir, slug, {}, content)
    end

    def self.create_with_metadata(temp_dir, slug, metadata = {}, content = "# Test Content")
      metadata = {
        "title" => "Test Article",
        "description" => "Test Description"
      }.merge(metadata)

      dir = File.join(temp_dir, slug)
      FileUtils.mkdir_p(dir)

      full_content = "#{metadata.to_yaml}---\n\n#{content}"
      File.write(File.join(dir, "index.md"), full_content)
      dir
    end

    def self.read_metadata(file_path)
      content = File.read(file_path)
      content_split = content.split("---\n")
      return {} if content_split.size < 2

      yaml_content = content_split[1]
      YAML.load(yaml_content)
    end
  end

  class SyncStatus
    def self.create(edited_at: "2025-02-17T09:00:00Z", slug: "test-article", synced: false, source: "dev_to", id: 1)
      {
        id => {
          edited_at: edited_at,
          slug: slug,
          synced: synced,
          source: source
        }
      }
    end

    def self.create_file(dir, content, filename = "sync_status.yml")
      File.write(File.join(dir, filename), content.to_yaml)
    end
  end
end
