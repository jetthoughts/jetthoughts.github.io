# frozen_string_literal: true

require "sync_test_case"
require "sync/images_downloader"

class ImagesDownloaderTest < SyncTestCase
  def setup
    super
    @slug = "test-article"
    @content = "# Title\n\n![Alt text](https://example.com/image1.png)\n![Another](https://example.com/image2.jpg)"

    @local_data = find_sync_record(1, create_sync_status(slug: @slug))
    @remote_data = sample_article("cover_image" => "https://example.com/cover.jpg", "body_markdown" => @content)
    @articles.replace([@remote_data])
    create_article_with_metadata(@slug, @remote_data, @content)

    @post = Sync::Post.new(@slug, working_dir: @app.working_dir)
    @article_dir = @post.page_bundle_dir
    @downloader = ImagesDownloader.new(@slug, @remote_data, @local_data, app: @app)

    FileUtils.mkdir_p(@article_dir)
  end

  def test_downloads_cover_image
    create_article_with_metadata(@slug, {"cover_image" => "https://example.com/success.jpg"})

    @downloader.perform

    assert_path_exists File.join(@article_dir, "cover.jpg"), "Cover image should be downloaded"
    metadata = read_markdown_metadata(slug: @slug)
    assert_includes metadata["cover_image"], Sync::Post::REPO_URL, "Cover image URL should be updated to use REPO_URL"
  end

  def test_downloads_inline_images
    create_article_with_metadata(@slug, @remote_data.except("body_markdown"), @remote_data["body_markdown"])

    @downloader.perform

    assert_path_exists File.join(@article_dir, "file_0.png"), "First inline image should be downloaded"
    assert_path_exists File.join(@article_dir, "file_1.jpg"), "Second inline image should be downloaded"

    content = File.read(File.join(@article_dir, "index.md"))
    assert_match(/!\[Alt text\]\(file_0\.png\)/, content, "First image reference should be updated")
    assert_match(/!\[Another\]\(file_1\.jpg\)/, content, "Second image reference should be updated")
  end

  def test_handles_failed_image_downloads
    @remote_data["body_markdown"] = "![Fail](https://example.com/fail.jpg)\n![Success](https://example.com/image.png)"
    create_article_with_metadata(@slug, @remote_data.except("body_markdown"), @remote_data["body_markdown"])

    @downloader.perform

    refute_path_exists File.join(@article_dir, "file_0.jpg"), "Failed image should not create a file"
    assert_path_exists File.join(@article_dir, "file_0.png"), "Successful image should be downloaded"

    content = File.read(File.join(@article_dir, "index.md"))
    assert_match(/!\[Fail\]\(https:\/\/example\.com\/fail\.jpg\)/, content, "Failed image URL should remain unchanged")
    assert_match(/!\[Success\]\(file_0\.png\)/, content, "Successful image reference should be updated")
  end

  def test_handles_missing_cover_image
    create_article_with_metadata(@slug, {"cover_image" => nil})
    @downloader = ImagesDownloader.new(@slug, @remote_data, @local_data, app: @app)

    @downloader.perform

    refute_path_exists File.join(@article_dir, "cover.jpg"), "No cover.jpg should be created when cover_image is nil"
    metadata = read_markdown_metadata(slug: @slug)
    assert_nil metadata["cover_image"], "Cover image URL should remain unchanged"
  end

  def test_handles_failed_cover_image_download
    create_article_with_metadata(@slug, {"cover_image" => "https://example.com/fail.jpg"})
    @downloader = ImagesDownloader.new(@slug, @remote_data, @local_data, app: @app)

    @downloader.perform

    metadata = read_markdown_metadata(slug: @slug)

    refute_path_exists File.join(@article_dir, "cover.jpg"), "No cover.jpg should be created when download fails"
    assert_equal "https://example.com/fail.jpg", metadata["cover_image"], "Cover image URL should remain unchanged"
  end

  def test_preserves_metadata_and_updates_cover_image
    create_article_with_metadata(@slug, {
      "metatags" => {"image" => "cover.jpg"},
      "title" => "Test Article",
      "description" => "Test Article Description",
      "cover_image" => "https://example.com/remote_cover.jpg"
    })

    @downloader.perform

    metadata = read_markdown_metadata(slug: @slug)

    assert_equal "Test Article", metadata["title"], "Title should be preserved"
    assert_equal "Test Article Description", metadata["description"], "Description should be preserved"
    assert_equal "cover.jpg", metadata.dig("metatags", "image"), "Cover image in metatags should be updated"
    assert_includes metadata["cover_image"], Sync::Post::REPO_URL, "Cover image URL should be converted to github CDN"
    assert_includes metadata["cover_image"], "cover.jpg", "Cover image filename should be updated"
    assert_path_exists File.join(@article_dir, "cover.jpg"), "Cover image file should be downloaded"
  end
end
