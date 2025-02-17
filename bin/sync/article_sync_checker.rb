require "json"
require "yaml"
require_relative "logging"

class ArticleSyncChecker
  include Logging

  USERNAME = "jetthoughts".freeze
  DEFAULT_SYNC_STATUS_FILE = "sync_status.yml".freeze
  USELESS_WORDS = %w[and the a but to is so].freeze
  DEFAULT_SOURCE = "dev_to".freeze

  attr_reader :working_dir, :http_client, :sync_file_name

  def initialize(working_dir, http_client, sync_file_name: DEFAULT_SYNC_STATUS_FILE)
    @working_dir = Pathname.new(working_dir)
    @http_client = http_client
    @sync_file_name = sync_file_name
  end

  def update_sync_status
    ensure_sync_status_file_exists
    @sync_status = sync_status
    update_status(fetch_articles)
    save_sync_status
  end

  private

  def sync_status
    YAML.load_file(sync_file_path)
  rescue Errno::ENOENT
    logger.warn "Warning: #{sync_file_name} not found."
    {}
  rescue Psych::SyntaxError => e
    logger.error "YAML parsing error in #{sync_file_name}: #{e.message}"
    {}
  end

  def ensure_sync_status_file_exists
    unless File.exist?(sync_file_path)
      File.write(sync_file_path, {}.to_yaml)
    end
  end

  def sync_file_path
    @_sync_file_path ||= working_dir / sync_file_name
  end

  def save_sync_status
    logger.debug "Saving sync status to #{sync_file_path}"
    File.write(sync_file_path, @sync_status.to_yaml)
  end

  def fetch_articles
    response = http_client.get_articles(USERNAME, 0)
    JSON.parse(response.body)
  end

  def slug(article)
    slug_parts = article["slug"].split("-")[0..-2]
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
