#!/usr/bin/env ruby

require_relative "./lib/dev_to_adapter"
require 'fileutils'

class DevToSync
  def initialize(username:, adapter: DevToAdapter.new, working_dir: 'content/blog/')
    @username = username
    @adapter = adapter
    @working_dir = working_dir
  end

  def sync
    articles = @adapter.get_articles(@username, 0)
    articles.each do |article|
      a = @adapter.get_article(article["id"])

      FileUtils.mkdir_p "#{@working_dir}/#{a["slug"]}"
      File.open("#{@working_dir}/#{a["slug"]}/index.md", "w+") do |f|
        f << meta_information(a)
      end
    end
  end

  def meta_information(article_data)
    cover_image = article_data['cover_image']
    metatags_image = ""

    unless cover_image.to_s.empty?
      metatags_image = <<~METATAG
      metatags:
        image: cover#{File.extname(cover_image)}
      METATAG
    end

    <<~MARKDOWN
    ---
    dev_to_id: #{article_data['id']}
    title: "#{article_data['title']}"
    description: #{article_data['description'].to_json}
    created_at: "#{article_data['created_at']}"
    edited_at: "#{article_data['edited_at']}"
    draft: false
    tags:
    #{article_data['tags'].map { |tag| "  - #{tag}" }.join("\n")}
    canonical_url: "#{article_data['canonical_url']}"
    cover_image: "#{cover_image}"
    slug: "#{article_data["slug"]}"
    #{metatags_image.strip}
    ---
    #{article_data['body_markdown']}
    MARKDOWN
  end
end
