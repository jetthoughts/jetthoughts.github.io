# frozen_string_literal: true

require "sync_test_case"

module Sync
  class PostTest < SyncTestCase
    def test_loads_metadata_from_content_file
      create_article_with_metadata("test-article", {"cover_image" => "https://example.com/test.jpg"})

      post = Post.new("test-article", working_dir: @app.working_dir).load

      assert_equal "https://example.com/test.jpg", post.cover_image
    end
  end
end
