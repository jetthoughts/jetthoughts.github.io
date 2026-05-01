# frozen_string_literal: true

require "sync_test_case"

module Sync
  class PostTest < SyncTestCase
    def test_loads_metadata_from_content_file
      create_article_with_metadata("test-article", {"cover_image" => "https://example.com/test.jpg"})

      post = Post.new("test-article", working_dir: @app.working_dir).load

      assert_equal "https://example.com/test.jpg", post.cover_image
    end

    def test_create_from_remote_overwrites_title_and_description_by_default
      create_article_with_metadata("test-article", {
        "title" => "Locally edited title",
        "description" => "Locally edited description",
        "source" => "dev_to"
      })
      remote_article = sample_article("title" => "Remote title", "description" => "Remote description")
      status = {slug: "test-article"}

      post = Post.create_from_remote_details(remote_article, status, app: @app)

      assert_equal "Remote title", post.metadata["title"]
      assert_equal "Remote description", post.metadata["description"]
    end

    def test_create_from_remote_preserves_local_seo_when_override_flag_set
      create_article_with_metadata("test-article", {
        "title" => "Locally edited title",
        "description" => "Locally edited description",
        "source" => "dev_to",
        "seo_override" => true
      })
      remote_article = sample_article("title" => "Remote title", "description" => "Remote description")
      status = {slug: "test-article"}

      post = Post.create_from_remote_details(remote_article, status, app: @app)

      assert_equal "Locally edited title", post.metadata["title"]
      assert_equal "Locally edited description", post.metadata["description"]
      assert_equal true, post.metadata["seo_override"]
    end

    def test_create_from_remote_for_new_post_works_without_local_file
      remote_article = sample_article("title" => "Remote title", "description" => "Remote description")
      status = {slug: "brand-new-article"}

      post = Post.create_from_remote_details(remote_article, status, app: @app)

      assert_equal "Remote title", post.metadata["title"]
      assert_equal "Remote description", post.metadata["description"]
    end

    def test_create_from_remote_falls_back_to_remote_when_local_frontmatter_malformed
      storage = PostStorage.new(@app.working_dir)
      storage.ensure_page_bundle_directory("test-article")
      storage.save_content("test-article", "---\n: : not: valid yaml :\n---\nbody")
      remote_article = sample_article("title" => "Remote title", "description" => "Remote description")
      status = {slug: "test-article"}

      post = Post.create_from_remote_details(remote_article, status, app: @app)

      assert_equal "Remote title", post.metadata["title"]
      assert_equal "Remote description", post.metadata["description"]
    end
  end
end
