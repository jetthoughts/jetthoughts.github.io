require "uri"
require "json"

require "sync/retryable"
require "sync/logging"

require "sync/sources/dev_to"

module Sync
  class DevToArticleFetcher
    include Logging
    include Retryable
    USERNAME = "jetthoughts".freeze

    attr_reader :client

    def initialize(client = nil)
      @client = client || DevToClient.new
      @source = Sync::Sources::DevTo.new(client: @client)
    end

    def fetch_all
      @source.fetch_all
    end

    def fetch(article_id)
      @source.fetch(article_id)
    end

    def fetch_asset(url)
      @source.fetch_asset(url)
    end

    # Do we need to update the remote article details?
    def need_to_update_remote?(article_data, article_sync_data)
      @source.need_to_update_remote?(article_data, article_sync_data)
    end

    def ext_from_image_url(image_url)
      @source.ext_from_image_url(image_url)
    end

    def remove_cdn(url)
      @source.remove_cdn(url)
    end

    def update(...)
      @source.update(...)
    end
  end
end
