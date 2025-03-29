require "sync/logging"
require "sync/retryable"

module Sync
  class Fetcher
    include Logging
    include Retryable

    def fetch_articles
      raise NotImplementedError, "Subclasses must implement #fetch_articles"
    end

    def fetch(id)
      raise NotImplementedError, "Subclasses must implement #fetch"
    end

    def fetch_image(url)
      raise NotImplementedError, "Subclasses must implement #fetch_image"
    end

    def need_to_update_remote?(article_data, article_sync_data)
      raise NotImplementedError, "Subclasses must implement #need_to_update_remote?"
    end

    def update_meta_on_dev_to(id, data)
      raise NotImplementedError, "Subclasses must implement #update_meta_on_dev_to"
    end
  end
end
