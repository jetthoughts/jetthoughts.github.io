class SaveArticleToMarkdown
  require 'date'
  require 'time'
  require 'net/http'
  require 'json'

  DEV_TO_API_HOST = 'https://dev.to/api/articles/jetthoughts/'.freeze
  JT_BLOG_HOST = 'https://www.jetthoughts.com/blog/'.freeze

  def initialize(article_slug)
    @article_slug = article_slug
  end

  def self.call(article_slug)
    new(article_slug).call
  end

  def call
    data = fetch_article_data
    pp data
    save_to_md_file(data)
    update_canonical_url_on_dev_to(data)
    fill_seo_attributes(data)
  end

  def fetch_article_data
    uri = URI(DEV_TO_API_HOST + @article_slug)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def save_to_md_file(data)
    File.open("../content/#{slug(data)}.md", 'w') { |file| file.write(data['body_markdown']) }
    puts "File #{slug(data)}.md successfully created."
  end

  def slug(data)
    data['slug'].split('-')[0..-2].join('-')
  end

  def update_canonical_url_on_dev_to(data)
    uri = URI("https://dev.to/api/articles/#{data['id']}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Put.new(uri)
    request['api-key'] = 'dAebJE2LywhZD6xBbAfLnfRK'
    request['Content-Type'] = 'application/json'

    pp JT_BLOG_HOST + slug(data)

    # request.body = { article: { canonical_url: JT_BLOG_HOST + slug('data') } }.to_json
    # http.request(request)
  end

  def fill_seo_attributes(data)
    markdown = File.read("../content/#{slug(data)}.md")

    File.open("../content/#{slug(data)}.md", 'w') do |file|
      file.write("+++\n")
      file.write("title = \"#{data['title']}\"\n")
      file.write("description = \"#{data['description']}\"\n")
      file.write("created_at = \"#{data['created_at']}\"\n")
      file.write("edited_at = \"#{data['edited_at']}\"\n")
      file.write("sync_date = \"#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")}\"\n")
      file.write("draft = false\n")
      file.write("tags = #{data['tags']}\n")
      file.write("+++\n")
      file.write(markdown)
    end
  end
end

uri = URI('https://dev.to/api/articles?username=jetthoughts')
response = Net::HTTP.get(uri)
all_articles = JSON.parse(response)

force = ARGV.include?('-f') ? true : false

all_articles.each do |article|
  created_at = Time.parse(article['created_at']) if article['created_at']
  edited_at = Time.parse(article['edited_at']) if article['edited_at']

  if (created_at && (Time.now - created_at) < 1800) || (edited_at && (Time.now - edited_at) < 1800) || force
    SaveArticleToMarkdown.call(article['slug'])
  end
end
