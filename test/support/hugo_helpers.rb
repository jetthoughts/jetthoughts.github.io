require 'pathname'

class Hugo
  attr_reader :destination

  def initialize(path: ENV.fetch("HUGO_DEFAULT_PATH", "_dest/public-test"))
    @destination = Pathname.new(path).expand_path
  end

  HUGO_OPTIONS = %w[
    --environment test
    --buildDrafts
    --logLevel warn
    --noBuildLock
    --gc
    --minify
    --enableGitInfo=false
    --quiet
  ].freeze

  def precompiled?
    ENV["PRECOMPILED_ASSETS"]
  end

  def precompile(port:)
    # Skip Hugo execution in Docker environment - use precompiled assets
    return self if precompiled?

    options = HUGO_OPTIONS.join(" ")
    # Only add baseURL if port is specified (for system tests)
    base_url_option = port ? "--baseURL=\"http://localhost:#{port}\"" : ""
    hugo_build_cmd = "hugo #{options} #{base_url_option} --destination=\"#{destination}\"".strip
    warn "Hugo: #{hugo_build_cmd}" if ENV["DEBUG"]

    # Use Hugo's built-in caching for faster test builds
    system(
      hugo_build_cmd,
      exception: true
    )
    self
  end

  def app
    that = self
    Rack::Builder.new do
      use RequestLogger if ENV["DEBUG"]

      # Handle directory requests by serving index.html files
      use HugoDirectoryHandler, that.destination_path

      use Rack::Static,
        urls: ["/"],
        root: that.destination_path,
        header_rules: [
          # Cache all static files in public caches (e.g. Rack::Cache)
          #  as well as in the browser
          [:all, {"cache-control" => "public, max-age=31536000"}],
          # Provide web fonts with cross-origin access-control-headers
          #  Firefox requires this when serving assets using a Content Delivery Network
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

    # If path ends with / and there's an index.html, serve it
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
