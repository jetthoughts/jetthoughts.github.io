require "fileutils"
require "uri"
require "pathname"
require "sync/retryable"
require "sync/dev_to_article_fetcher"
require "sync/logging"


class ImagesDownloader
  include Retryable
  include Logging

  class NetworkError < StandardError; end

  attr_reader :slug, :remote_data, :local_data, :fetcher

  def initialize(slug, remote_data = nil, local_data = nil, app:)
    @slug = slug
    @fetcher = app.fetcher
    @remote_data = remote_data
    @local_data = local_data
    @post = Sync::Post.create_from_remote_details(remote_data, local_data)
  end

  def perform
    @post.reload
    process_cover_image(@post)
    @post.body_markdown = process_images(@post.body_markdown)
    @post.save
  rescue ::Timeout::Error, ::Faraday::ConnectionFailed => e
    logger.error "Network error while downloading images: #{e.message}"
    raise NetworkError, "Failed to download images: #{e.message}"
  rescue => e
    logger.error "Error processing images: #{e.message}"
    raise
  end

  private

  def process_cover_image(post)
    cover_image = post.cover_image
    return unless cover_image

    cover_image_file_name = post.cover_image_file_name

    if download_image(cover_image, cover_image_file_name)
      post.cover_image = post.cover_image_public_url
    else
      @post.remove_cover_image
    end
  end

  IMG_REGEX = %r{!\[(?<alt>(?:[^\[\]]|\[(?:[^\[\]]|\[[^\[\]]*\])*\])*)\]\((?<url>https?://[^\s\)]+)\)}

  def process_images(content)
    index = 0
    content.gsub(IMG_REGEX) do |match|
      alt_text = $~[:alt]
      image_url = $~[:url]

      next if local?(image_url)

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

  def local?(image_url)
    URI(image_url).host.nil? || URI(image_url).scheme.nil?
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
    @post.add_media_asset(asset_name, media_content)
  end
end
