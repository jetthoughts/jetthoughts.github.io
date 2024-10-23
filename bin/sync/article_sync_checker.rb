module ArticleSyncChecker
  API_URL = 'https://dev.to/api/articles?username=jetthoughts'.freeze
  SYNC_STATUS_FILE = 'sync_status.yml'.freeze
  USELESS_WORDS = %w[and the a but to is so].freeze

  def update_sync_status
    ensure_sync_status_file_exists
    @sync_status = load_sync_status
    update_status(fetch_articles)
    save_sync_status
  end

  private

  def ensure_sync_status_file_exists
    unless file_manager.exist?(working_dir + SYNC_STATUS_FILE)
      file_manager.open(working_dir + SYNC_STATUS_FILE, 'w') { |file| file.write({}.to_yaml) }
    end
  end

  def load_sync_status
    yaml_parser.load_file(working_dir + SYNC_STATUS_FILE) || {}
  end

  def save_sync_status
    file_manager.open(working_dir + SYNC_STATUS_FILE, 'w') do |file|
      file.write(@sync_status.to_yaml)
    end
  end

  def fetch_articles
    uri = URI(API_URL + "&per_page=#{rand(999..9999)}") # hack to avoid cached API response
    response = http_client.get(uri)
    JSON.parse(response.body)
  end

  def slug(article)
    slug_parts = article['slug'].split('-')[0..-2]
    tags = article['tags'] ? article['tags'].split(", ") : []
    selected_tags = tags.first(2)
    [slug_parts, selected_tags]
      .flatten
      .uniq
      .reject { |segment| USELESS_WORDS.include?(segment) }
      .compact
      .join('-')
  end

  def update_status(articles)
    articles.each do |article|
      id = article['id']
      edited_at = article["edited_at"] || article["created_at"]

      @sync_status[id] ||= { edited_at: edited_at, slug: slug(article), synced: false }

      if @sync_status[id][:edited_at] != edited_at
        @sync_status[id][:edited_at] = edited_at
        @sync_status[id][:synced] = false
      end
    end
  end
end
