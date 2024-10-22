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
      FileUtils.mkdir_p "#{@working_dir}/#{article["slug"]}"
      File.open("#{@working_dir}/#{article["slug"]}/index.md", "w+") do |f|
        f.write("markdown content")
      end
    end
  end
end
