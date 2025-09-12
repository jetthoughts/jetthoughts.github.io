# frozen_string_literal: true

require 'open3'
require 'json'
require 'uri'
require 'cgi'
require 'nokogiri'

class HugoMemoryServer
  attr_reader :base_url, :content_cache

  def initialize(base_url: 'http://localhost:1313', hugo_config: {})
    @base_url = base_url
    @hugo_config = hugo_config
    @content_cache = {}
    @server_process = nil
    @server_started = false
    @hugo_options = build_hugo_options
  end

  def start
    return if @server_started

    puts "Starting Hugo memory server..."
    start_hugo_server
    wait_for_server
    @server_started = true
    puts "Hugo memory server started successfully"
  end

  def stop
    return unless @server_started

    if @server_process
      Process.kill('TERM', @server_process)
      Process.wait(@server_process) rescue nil
      @server_process = nil
    end
    @server_started = false
    puts "Hugo memory server stopped"
  end

  private

  def normalize_path(path)
    # Ensure path starts with /
    path = "/#{path}" unless path.start_with?('/')
    # For root path, just return as is - Hugo will handle it
    return path if path == '/'
    # Add index.html for directory paths
    path += 'index.html' if path.end_with?('/')
    path
  end

  def build_hugo_options
    options = %w[
      server
      -M
      --disableLiveReload
      --disableBrowserError
      --environment test
      --quiet
    ]

    options << "--baseURL #{@base_url}"
    options << "--port #{URI.parse(@base_url).port}"
    options
  end

  def start_hugo_server
    cmd = "hugo #{@hugo_options.join(' ')}"
    puts "Starting Hugo with: #{cmd}" if ENV['DEBUG']

    # Start Hugo server in the background
    if ENV['DEBUG']
      @server_process = spawn(cmd, pgroup: true)
    else
      @server_process = spawn(cmd, pgroup: true, out: File::NULL, err: File::NULL)
    end
  end

  def wait_for_server
    max_attempts = 30
    attempt = 0

    while attempt < max_attempts
      begin
        # Try to connect to Hugo server
        output, error, status = Open3.capture3("curl -s --max-time 1 #{@base_url}/ > /dev/null")
        if status.success?
          sleep(0.1) # Give it a moment to fully initialize
          return
        end
      rescue => e
        puts "Attempt #{attempt + 1}: #{e.message}" if ENV['DEBUG']
      end

      attempt += 1
      sleep(0.1)
    end

    raise "Hugo server failed to start after #{max_attempts} attempts"
  end
end

# Singleton instance for global access
module HugoMemoryServerSingleton
  def self.instance
    @instance ||= HugoMemoryServer.new
  end

  def self.reset!
    @instance&.stop
    @instance = nil
  end
end
