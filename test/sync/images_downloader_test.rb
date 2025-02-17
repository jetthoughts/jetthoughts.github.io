# frozen_string_literal: true

require_relative "test_helper"
require_relative "../../bin/sync/images_downloader"

class ImagesDownloaderTest < Minitest::Test
  def setup
    @temp_dir = create_temp_dir
    @slug = "test-article"
    @article_dir = File.join(@temp_dir, @slug)
    @remote_data = sample_article(
      "cover_image" => "https://example.com/cover.jpg",
      "body_markdown" => "# Title\n\n![Alt text](https://example.com/image1.png)\n![Another](https://example.com/image2.jpg)"
    )
    @local_data = { slug: @slug }
    @http_client = TestHttpClient.new([@remote_data])
    @downloader = ImagesDownloader.new(@slug, @http_client, @temp_dir, @remote_data, @local_data)

    FileUtils.mkdir_p(@article_dir)
    File.write(File.join(@article_dir, "index.md"), @remote_data["body_markdown"])
  end

  def test_downloads_cover_image
    @downloader.perform

    assert_path_exists File.join(@article_dir, "cover.jpg")
    assert_path_exists File.join(@article_dir, "index.md")
    assert_includes @remote_data["cover_image"], REPO_URL
  end

  def test_downloads_inline_images
    @downloader.perform

    assert File.exist?(File.join(@article_dir, "file_0.png"))
    assert File.exist?(File.join(@article_dir, "file_1.jpg"))
    content = File.read(File.join(@article_dir, "index.md"))
    assert_match(/!\[Alt text\]\(file_0\.png\)/, content)
    assert_match(/!\[Another\]\(file_1\.jpg\)/, content)
  end

  def test_handles_failed_image_downloads
    @remote_data["body_markdown"] = "![Fail](https://example.com/fail.jpg)\n![Success](https://example.com/image.png)"
    File.write(File.join(@article_dir, "index.md"), @remote_data["body_markdown"])

    @downloader.perform

    refute File.exist?(File.join(@article_dir, "file_0.jpg"))
    assert File.exist?(File.join(@article_dir, "file_0.png"))
    content = File.read(File.join(@article_dir, "index.md"))
    assert_match(/!\[Fail\]\(https:\/\/example\.com\/fail\.jpg\)/, content)
    assert_match(/!\[Success\]\(file_0\.png\)/, content)
  end

  def test_handles_missing_cover_image
    @remote_data["cover_image"] = nil
    @downloader = ImagesDownloader.new(@slug, @http_client, @temp_dir, @remote_data, @local_data)

    @downloader.perform

    refute File.exist?(File.join(@article_dir, "cover.jpg"))
  end

  def test_handles_failed_cover_image_download
    @remote_data["cover_image"] = "https://example.com/fail.jpg"
    @downloader = ImagesDownloader.new(@slug, @http_client, @temp_dir, @remote_data, @local_data)

    @downloader.perform

    refute File.exist?(File.join(@article_dir, "cover.jpg"))
    assert_equal "https://example.com/fail.jpg", @remote_data["cover_image"]
  end
end
