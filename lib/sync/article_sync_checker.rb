# frozen_string_literal: true

require "json"
require "sync/logging"
require "sync/sync_status_storage"

class ArticleSyncChecker
  include Logging

  DEFAULT_SOURCE = "dev_to".freeze
  USELESS_WORDS = %w[and the a but to is so].freeze

  attr_reader :storage, :fetcher

  def initialize(app:)
    @storage = app.storage
    @fetcher = app.fetcher
  end

  def update_sync_status
    fetch_articles = fetcher.fetch_articles
    update_sync_statuses_for(fetch_articles)
  end

  def update_sync_statuses_for(fetch_articles)
    @sync_status = storage.load
    update_statuses_for(fetch_articles)
    storage.save(@sync_status)
  end

  private

  def update_statuses_for(articles)
    articles.each do |article|
      id = article["id"]
      edited_at = article["edited_at"] || article["created_at"]

      @sync_status[id] ||= {
        edited_at: edited_at,
        slug: generate_slug(article),
        synced: false,
        source: DEFAULT_SOURCE
      }

      if @sync_status[id][:edited_at] != edited_at
        @sync_status[id][:edited_at] = edited_at
        @sync_status[id][:synced] = false
      end
    end
  end

  def generate_slug(article)
    slug_parts = article["slug"].split("-")
    tags = article["tags"] ? article["tags"].split(", ") : []
    selected_tags = tags.first(10)
    [slug_parts, selected_tags]
      .flatten
      .uniq
      .reject { |segment| USELESS_WORDS.include?(segment) }
      .compact
      .first(6)
      .join("-")
  end
end
