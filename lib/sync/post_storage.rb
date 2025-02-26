# frozen_string_literal: true

require "pathname"

module Sync
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
      return nil unless page_bundle_dir(slug).directory? && content_path(slug).file?
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

    def ensure_page_bundle_directory(slug)
      FileUtils.mkdir_p(page_bundle_dir(slug)) unless page_bundle_dir(slug).directory?
    end

    def asset_path(slug, asset_name)
      page_bundle_dir(slug) / asset_name
    end
  end
end
