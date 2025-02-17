require "fileutils"
require "uri"
require_relative "retryable"
require "pathname"

IMG_REGEX = %r{!\[(?<alt>(?:[^\[\]]|\[(?:[^\[\]]|\[[^\[\]]*\])*\])*)\]\((?<url>https?://[^\s\)]+)\)}
REPO_URL = "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master".freeze

class ImagesDownloader
  include Retryable

  def initialize(slug, http_client, working_dir, remote_data, local_data)
    @slug = slug
    @working_dir = working_dir
    @http_client = http_client
    @remote_data = remote_data
    @local_data = local_data
  end

  def perform
    FileUtils.mkdir_p(page_bundle_dir) unless page_bundle_dir.exist?

    # TODO: Replace with `@remote_data["body_markdown"]`
    content = File.read(index_path)

    content = process_cover_image(content, index_path)
    content = process_images(content)

    File.write(index_path, content)
    @remote_data["body_markdown"] = content
  end

  private

  def index_path
    @_index ||= page_bundle_dir / "index.md"
  end

  def work_dir
    @_work_dir ||= Pathname.new(@working_dir).cleanpath
  end

  def page_bundle_dir
    @_page_bundle_dir ||= work_dir / @slug
  end

  def fetcher
    @_fetcher ||= ArticleFetcher.new(@http_client)
  end

  def process_cover_image(content, file_path)
    cover_image = @remote_data["cover_image"]

    if cover_image
      ext = ext_from_image_url(cover_image)
      cover_path = to_relative_path("cover#{ext}")

      if download_image(cover_image, cover_path)
        updated_content = content.sub(cover_image, to_absolute_url(cover_path))
        File.write(file_path, updated_content)

        @remote_data["cover_image"] = to_absolute_url(cover_path)
        return updated_content
      else
        FileUtils.rm_f(cover_path)
      end
    end

    content
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

      # TODO: Move detect ext after downloaded file, and replace the original name only after that
      ext = ext_from_image_url(image_url)
      new_file = "file_#{index}#{ext}"

      new_path = to_relative_path(new_file)

      if download_image(image_url, new_path)
        index += 1
        "![#{alt_text}](#{new_file})"
      else
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
      puts "#{dest} downloaded from #{url}"
      return true
    end

    false
  end
end
