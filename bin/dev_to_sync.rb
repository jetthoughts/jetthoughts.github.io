#!/usr/bin/env ruby

require_relative "./lib/dev_to_adapter"

class DevToSync
  def initialize(username:, adapter: DevToAdapter.new)
    @username = username
    @adapter = adapter
  end

  def sync
    articles = @adapter.get_articles(@username, 0)
    articles.each do |article_data|
      # Sync article
    end
  end
end
