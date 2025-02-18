require "fileutils"
require "uri"
require "pathname"
require "sync/retryable"
require "sync/article_fetcher"
require "sync/logging"

IMG_REGEX = %r{!\[(?<alt>(?:[^\[\]]|\[(?:[^\[\]]|\[[^\[\]]*\])*\])*)\]\((?<url>https?://[^\s\)]+)\)}
REPO_URL = "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master".freeze

class ImagesDownloader
  include Retryable
  include Logging

  class NetworkError < StandardError; end

  attr_reader :slug, :working_dir, :remote_data, :local_data, :fetcher

  def initialize(slug, fetcher, working_dir, remote_data, local_data, app: nil)
    @slug = slug
    @working_dir = app&.working_dir || working_dir && Pathname.new(working_dir).cleanpath
    @fetcher = app&.fetcher || fetcher
    @remote_data = remote_data
    @local_data = local_data
  end

  def perform
    content = File.read(index_path)

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

  def save_content(content)
    File.write(index_path, content)
  end

  def index_path
    @_index ||= page_bundle_dir / "index.md"
  end

  def work_dir
    @_work_dir ||= Pathname.new(working_dir).cleanpath
  end

  def page_bundle_dir
    @_page_bundle_dir ||= work_dir / slug
  end

  def process_cover_image(content)
    cover_image = remote_data["cover_image"]
    return content unless cover_image

    ext = ext_from_image_url(cover_image)
    cover_path = to_relative_path("cover#{ext}")

    if download_image(cover_image, cover_path)
      absolute_url = to_absolute_url(cover_path)
      remote_data["cover_image"] = absolute_url
      content.sub(cover_image, absolute_url)
    else
      FileUtils.rm_f(cover_path)
      content
    end
  end

  def to_absolute_url(cover_path)
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
      new_path = to_relative_path(new_file)

      if download_image(image_url, new_path)
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

  def download_image(url, dest)
    image = fetcher.fetch_image(url)
    if image
      File.binwrite(dest, image)
      logger.info "#{dest} downloaded from #{url}"
      true
    else
      logger.error "Failed to download image from #{url}"
      false
    end
  end
end
