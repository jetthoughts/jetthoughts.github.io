# frozen_string_literal: true

require "json"
require "sync/logging"
require "sync/sync_status_storage"

class ArticleSyncChecker
  include Logging

  DEFAULT_SOURCE = "dev_to"
  USELESS_WORDS = %w[and the a but to is so].freeze

  attr_reader :storage, :fetcher

  def initialize(app:)
    @storage = app.status_storage
    @fetcher = app.fetcher
  end

  def update_sync_status
    fetch_all = fetcher.fetch_all
    update_sync_statuses_for(fetch_all)
  end

  def update_sync_statuses_for(fetch_all)
    @sync_status = storage.load
    update_statuses_for(fetch_all)
    storage.save(@sync_status)
  end

  private

  def update_statuses_for(articles)
    articles.each do |article|
      id = article["id"]
      changed_at = article["edited_at"] || article["created_at"]

      @sync_status[id] ||= build_new_status(article, changed_at)
      @sync_status[id][:remote_id] = id
      @sync_status[id][:source] = DEFAULT_SOURCE

      if desynchronized?(changed_at, id)
        @sync_status[id][:edited_at] = changed_at
        @sync_status[id][:synced] = false
      end
    end
  end

  def desynchronized?(changed_at, id)
    @sync_status[id][:edited_at] != changed_at
  end

  def build_new_status(article, edited_at)
    {
      edited_at: edited_at,
      slug: generate_slug(article),
      remote_id: article["id"],
      synced: false,
      source: DEFAULT_SOURCE
    }
  end

  def generate_slug(article)
    slug_parts = article["slug"].split("-")
    tags = article["tags"] ? article["tags"].split(", ") : []
    selected_tags = tags.first(10)
    result = [slug_parts, selected_tags]
      .flatten
      .uniq
      .reject { |segment| USELESS_WORDS.include?(segment) }
      .compact
      .first(6)
      .join("-")

    if duplicated?(result)
      result += "-#{SecureRandom.hex(2)}"
    end

    result
  end

  def duplicated?(slug)
    @sync_status.map { _2 && _2[:slug] }.compact.uniq.include?(slug)
  end
end
