module Hugo
  def self.precompile(port:)
    system(
      "hugo --minify --forceSyncStatic --environment production --cleanDestinationDir --gc --logLevel warn" \
        " --baseURL \"http://localhost:#{port}\"  --destination \"#{destination}\"",
      exception: true
    )
  end

  def self.destination
    "public-test"
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

Capybara.app = Rack::Builder.new do
  use RequestLogger if ENV["DEBUG"]
  use Rack::Static,
    urls: [""],
    root: Hugo.destination,
    index: "index.html",
    header_rules: [
      # Cache all static files in public caches (e.g. Rack::Cache)
      #  as well as in the browser
      [:all, { "cache-control" => "public, max-age=31536000" }],
      # Provide web fonts with cross-origin access-control-headers
      #  Firefox requires this when serving assets using a Content Delivery Network
      [:fonts, { "access-control-allow-origin" => "*" }]
    ]
  run Rack::Directory.new(File.expand_path("../../#{Hugo.destination}", __FILE__))
end

