require "yaml"
require_relative "article_sync_checker"
require_relative "article_updater"
require_relative "article_cleaner"
require_relative "dev_to_adapter"

class Sync
  include ArticleSyncChecker
  include ArticleUpdater
  include ArticleCleaner

  DEFAULT_WORKING_DIR = "content/blog/".freeze
  YAML_STATUS_FILE = "sync_status.yml".freeze

  def initialize(http_client: DevToAdapter.new, working_dir: DEFAULT_WORKING_DIR)
    @http_client = http_client
    @working_dir = Pathname.new(working_dir)
  end

  def self.perform(force = false, **kwargs)
    new(**kwargs).perform(force)
  end

  def sync_status
    YAML.load_file(File.join(@working_dir, SYNC_STATUS_FILE))
  rescue Errno::ENOENT
    puts "Warning: #{YAML_STATUS_FILE} not found."
    {}
  rescue Psych::SyntaxError => e
    puts "YAML parsing error in #{YAML_STATUS_FILE}: #{e.message}"
    {}
  end

  def perform(force)
    update_sync_status
    download_new_articles(force)
    cleanup_renamed_articles
  end

  private

  attr_reader :http_client, :working_dir
end
