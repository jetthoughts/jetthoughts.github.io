require "fileutils"
require "uri"
require "pathname"
require "sync/retryable"
require "sync/article_fetcher"
require "sync/logging"

IMG_REGEX = %r{!\[(?<alt>(?:[^\[\]]|\[(?:[^\[\]]|\[[^\[\]]*\])*\])*)\]\((?<url>https?://[^\s\)]+)\)}
REPO_URL = "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master".freeze

class PostStorage
  attr_reader :working_dir

  def initialize(working_dir)
    @working_dir = Pathname.new(working_dir).cleanpath
  end

  CONTENT_FILE_NAME = "index.md"

  def content_path(slug)
    asset_path(slug, CONTENT_FILE_NAME)
  end

  def page_bundle_dir(slug)
    working_dir / slug
  end

  def remove_asset(slug, asset_name)
    FileUtils.rm_f(page_bundle_dir(slug) / asset_name)
  end

  def read_content(slug)
    File.read(content_path(slug))
  end

  def save_content(slug, content)
    ensure_page_bundle_directory(slug)
    File.write(content_path(slug), content)
  end

  def add_media_asset(slug, asset_name, media_content)
    ensure_page_bundle_directory(slug)
    File.binwrite(asset_path(slug, asset_name), media_content)
  end

  private

  def ensure_page_bundle_directory(slug)
    FileUtils.mkdir_p(page_bundle_dir(slug)) unless page_bundle_dir(slug).directory?
  end

  def asset_path(slug, asset_name)
    page_bundle_dir(slug) / asset_name
  end

end

class ImagesDownloader
  include Retryable
  include Logging

  class NetworkError < StandardError; end

  attr_reader :slug, :working_dir, :remote_data, :local_data, :fetcher

  def initialize(slug, remote_data = nil, local_data = nil, app:)
    @slug = slug
    @working_dir = app.working_dir
    @fetcher = app.fetcher
    @remote_data = remote_data
    @local_data = local_data
    @post_storage = PostStorage.new(@working_dir)
  end

  def perform
    content = read_content

    content = process_cover_image(content)
    content = process_images(content)

    save_content(content)
  rescue ::Timeout::Error, ::Faraday::ConnectionFailed => e
    logger.error "Network error while downloading images: #{e.message}"
    raise NetworkError, "Failed to download images: #{e.message}"
  rescue => e
    logger.error "Error processing images: #{e.message}"
    raise
  end

  private

  def read_content
    @post_storage.read_content(slug)
  end

  def save_content(content)
    @post_storage.save_content(slug, content)
  end

  def content_path
    @_index ||= @post_storage.content_path(slug)
  end

  def work_dir
    @_work_dir ||= @post_storage.working_dir
  end

  def page_bundle_dir
    @_page_bundle_dir ||= @post_storage.page_bundle_dir(slug)
  end

  def process_cover_image(content)
    cover_image = remote_data["cover_image"]
    return content unless cover_image

    ext = ext_from_image_url(cover_image)
    cover_image_file_name = "cover#{ext}"
    cover_path = to_relative_path(cover_image_file_name)

    if download_image(cover_image, cover_image_file_name)
      cover_image_public_url = to_public_url(cover_path)
      remote_data["cover_image"] = cover_image_public_url
      content.sub(cover_image, cover_image_public_url)
    else
      remove_cover_image(cover_image_file_name)
      content
    end
  end

  def remove_cover_image(cover_image_file_name)
    @post_storage.remove_asset(slug, cover_image_file_name)
  end

  def to_public_url(cover_path)
    "#{REPO_URL}/#{cover_path}"
  end

  def to_relative_path(cover_image_name)
    page_bundle_dir / cover_image_name
  end

  def process_images(content)
    index = 0
    content.gsub(IMG_REGEX) do |match|
      alt_text = $~[:alt]
      image_url = $~[:url]

      ext = ext_from_image_url(image_url)
      new_file = "file_#{index}#{ext}"

      if download_image(image_url, new_file)
        index += 1
        "![#{alt_text}](#{new_file})"
      else
        logger.warn "Failed to download image: #{image_url}"
        match
      end
    end
  end

  def ext_from_image_url(image_url)
    fetcher.ext_from_image_url(image_url)
  end

  def download_image(url, as_file_name)
    image = fetcher.fetch_image(url)
    if image
      add_media_asset(as_file_name, image)
      logger.info "#{as_file_name} downloaded from #{url}"
      true
    else
      logger.error "Failed to download image from #{url}"
      false
    end
  end

  def add_media_asset(asset_name, media_content)
    @post_storage.add_media_asset(slug, asset_name, media_content)
  end
end
