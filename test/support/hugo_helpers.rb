class Hugo
  attr_reader :destination

  def initialize(path: ENV.fetch("HUGO_DEFAULT_PATH", "public-test"))
    @destination = path
  end
  HUGO_OPTIONS = %w[
    --minify
    --forceSyncStatic
    --environment production
    --cleanDestinationDir
    --gc
    --logLevel warn
  ].freeze

  def precompile(port:)
    options = HUGO_OPTIONS.join(" ")
    system(
      "hugo #{options} --baseURL \"http://localhost:#{port}\" --destination \"#{destination}\"",
      exception: true
    )
    self
  end

  def app
    that = self
    Rack::Builder.new do
      use RequestLogger if ENV["DEBUG"]
      use Rack::Static,
        urls: [""],
        root: that.destination_path,
        index: "index.html",
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
    puts "Received #{request.request_method} request for #{request.path}"
    @app.call(env)
  end
end
