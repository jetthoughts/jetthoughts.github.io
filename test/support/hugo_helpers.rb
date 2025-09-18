require "pathname"
require "fileutils"
require "digest"

destination = ENV.fetch("HUGO_DEFAULT_PATH", "_dest/public-test")

unless ENV["PRECOMPILED_ASSETS"]
  salt = ENV.fetch("TEST_SERVER_PORT", rand(5))
  destination = "#{destination}-#{salt}"
end

HUGO_PUBLIC_PATH = destination

class Hugo
  attr_reader :destination

  def self.instance
    @instance ||= new(path: HUGO_PUBLIC_PATH)
  end

  def initialize(path: nil)
    base_path = path || ENV.fetch("HUGO_DEFAULT_PATH", "_dest/public-test")
    @destination = Pathname.new(base_path).expand_path
  end

  HUGO_OPTIONS = %w[
    hugo
    --baseURL /
    --environment test
    --logLevel error
    --quiet
  ].freeze

  def precompile
    return self if ENV["PRECOMPILED_ASSETS"]

    args = HUGO_OPTIONS.dup
    args += %W[--destination #{destination}]

    warn "Hugo: #{args.join(" ")}" if ENV["DEBUG"]

    system(*args, exception: true)

    self
  end

  def app
    that = self
    Rack::Builder.new do
      use RequestLogger if ENV["DEBUG"]

      use HugoDirectoryHandler, that.destination_path

      use Rack::Static,
        urls: ["/"],
        root: that.destination_path,
        header_rules: [
          [:all, {"cache-control" => "public, max-age=31536000"}],
          [:fonts, {"access-control-allow-origin" => "*"}]
        ]

      run Rack::Directory.new(that.destination_path)
    end
  end

  def destination_path
    File.expand_path(@destination, Dir.pwd)
  end
end

class RequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    warn "Received #{request.request_method} request for #{request.path}" if ENV["DEBUG"]
    @app.call(env)
  end
end

class HugoDirectoryHandler
  def initialize(app, public_path)
    @app = app
    @public_path = public_path
  end

  def call(env)
    request = Rack::Request.new(env)
    path = request.path_info

    if path.end_with?("/")
      index_file = File.join(@public_path, path, "index.html")
      if File.exist?(index_file)
        return serve_file(index_file)
      end
    end

    @app.call(env)
  end

  private

  def serve_file(file_path)
    content = File.read(file_path)
    [200, {"Content-Type" => "text/html"}, [content]]
  end
end

Hugo.instance.precompile unless ENV["PRECOMPILED_ASSETS"]
