require "json"

module ArticleSyncChecker
  USERNAME = "jetthoughts".freeze
  SYNC_STATUS_FILE = "sync_status.yml".freeze
  USELESS_WORDS = %w[and the a but to is so].freeze

  def update_sync_status
    ensure_sync_status_file_exists
    @sync_status = sync_status
    update_status(fetch_articles)
    save_sync_status
  end

  private

  def ensure_sync_status_file_exists
    sync_file_path = File.join(working_dir, SYNC_STATUS_FILE)

    unless File.exist?(sync_file_path)
      File.write(sync_file_path, {}.to_yaml)
    end
  end

  def save_sync_status
    File.write(File.join(working_dir, SYNC_STATUS_FILE), @sync_status.to_yaml)
  end

  def fetch_articles
    response = http_client.get_articles(USERNAME, 0)
    JSON.parse(response.body)
  end

  def slug(article)
    slug_parts = article["slug"].split("-")[0..-2]
    tags = article["tags"] ? article["tags"].split(", ") : []
    selected_tags = tags.first(2)
    [slug_parts, selected_tags]
      .flatten
      .uniq
      .reject { |segment| USELESS_WORDS.include?(segment) }
      .compact
      .join("-")
  end

  def update_status(articles)
    articles.each do |article|
      id = article["id"]
      edited_at = article["edited_at"] || article["created_at"]

      @sync_status[id] ||= {edited_at: edited_at, slug: slug(article), synced: false}

      if @sync_status[id][:edited_at] != edited_at
        @sync_status[id][:edited_at] = edited_at
        @sync_status[id][:synced] = false
      end
    end
  end
end
