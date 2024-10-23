require 'fileutils'
require 'uri'

IMG_REGEX = %r{!\[(?<alt>(?:[^\[\]]|\[(?:[^\[\]]|\[[^\[\]]*\])*\])*)\]\((?<url>https?:\/\/[^\s\)]+)\)}
REPO_URL = 'https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master'.freeze

class ImagesDownloader
  def initialize(slug, http_client, working_dir)
    @slug = slug
    @working_dir = working_dir
    @http_client = http_client
  end

  def call
    process_blog("#{@working_dir}/#{@slug}/index.md")
  end

  private

  def process_blog(file_path)
    file_name = File.basename(File.dirname(file_path))
    content = File.read(file_path)

    content = process_cover_image(file_name, content, file_path)
    content = process_images(file_name, content)

    File.write(file_path, content)
  end

  def process_cover_image(file_name, content, file_path)
    cover_image_match = content.match(/cover_image: "(?<url>http[^\s\)]*)"/)

    if cover_image_match
      cover_image_url = remove_cdn(cover_image_match[:url])
      ext = File.extname(URI(cover_image_url).path)
      cover_path = "#{@working_dir}/#{file_name}/cover#{ext}"

      FileUtils.mkdir_p(File.dirname(cover_path))
      if download_image(cover_image_url, cover_path)
        updated_content = content.sub(cover_image_match[:url], "#{REPO_URL}/#{cover_path}")
        File.write(file_path, updated_content)
        return updated_content
      else
        FileUtils.rm_f(cover_path)
      end
    end

    content
  end

  def process_images(file_name, content)
    index = 0
    content.gsub(IMG_REGEX) do |match|
      alt_text = $~[:alt]
      img_url = remove_cdn($~[:url])
      ext = File.extname(URI(img_url).path)
      new_file = "file_#{index}#{ext}"
      new_path = "#{@working_dir}/#{file_name}/#{new_file}"

      FileUtils.mkdir_p(File.dirname(new_path))
      if download_image(img_url, new_path)
        index += 1
        "![#{alt_text}](#{new_file})"
      else
        match
      end
    end
  end

  def remove_cdn(url)
    encoded_url = 'https' + url.split('https').last
    max_attempts = 5
    attempts = 0

    while encoded_url.include?('%') && attempts < max_attempts
      encoded_url = URI.decode_www_form_component(encoded_url)
      attempts += 1
    end

    encoded_url
  end

  def download_image(url, dest)
    max_attempts = 5
    attempts = 0

    begin
      response = http_client.get(url, timeout: 60)

      if response.success?
        File.open(dest, 'wb') { |file| file.write(response.body) }
        return true
      else
        puts "Failed to download #{url}: #{response.code} #{response.message}"
          return false
      end

    rescue StandardError => e
      attempts += 1
      puts "Attempt #{attempts} of #{max_attempts} failed with message: #{e.message}"
        retry if attempts < max_attempts
    end

    false
  end
end
