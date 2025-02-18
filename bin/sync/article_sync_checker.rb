require "json"
require_relative "logging"
require_relative "sync_status_storage"

class ArticleSyncChecker
  include Logging

  USERNAME = "jetthoughts".freeze
  DEFAULT_SYNC_STATUS_FILE = "sync_status.yml".freeze
  USELESS_WORDS = %w[and the a but to is so].freeze
  DEFAULT_SOURCE = "dev_to".freeze

  attr_reader :working_dir, :http_client, :storage

  def initialize(working_dir, http_client, storage: nil)
    @working_dir = Pathname.new(working_dir)
    @http_client = http_client
    @storage = storage || SyncStatusStorage.new(@working_dir)
  end

  def update_sync_status
    storage.ensure_file_exists
    @sync_status = storage.load || {}
    update_status(fetch_articles)
    storage.save(@sync_status)
  end

  private

  def fetch_articles
    response = http_client.get_articles(USERNAME, 0)
    if response.success?
      JSON.parse(response.body)
    else
      logger.error "Failed to fetch articles: #{response.code} - #{response.message}"
      []
    end
  rescue => e
    logger.error "Error fetching articles: #{e.message}"
    []
  end

  def slug(article)
    slug_parts = dev_to_slug_without_salt(article)
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

  def dev_to_slug_without_salt(article)
    article["slug"].split("-")[0..-2]
  end

  def update_status(articles)
    articles.each do |article|
      id = article["id"]
      edited_at = article["edited_at"] || article["created_at"]

      @sync_status[id] ||= {
        edited_at: edited_at,
        slug: slug(article),
        synced: false,
        source: DEFAULT_SOURCE
      }

      if @sync_status[id][:edited_at] != edited_at
        @sync_status[id][:edited_at] = edited_at
        @sync_status[id][:synced] = false
      end
    end
  end
end
