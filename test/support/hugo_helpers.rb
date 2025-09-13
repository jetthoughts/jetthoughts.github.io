class Hugo
  attr_reader :destination

  def initialize(path: ENV.fetch("HUGO_DEFAULT_PATH", "public-test"))
    @destination = path
  end

  HUGO_OPTIONS = %w[
    --environment test
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
      
      # Custom middleware to handle Hugo-style directory routing
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

class HugoDirectoryHandler
  def initialize(app, destination_path)
    @app = app
    @destination_path = destination_path
  end
  
  def call(env)
    request = Rack::Request.new(env)
    path = request.path
    
    # Try to serve the direct path first
    file_path = File.join(@destination_path, path)
    
    # If it's a directory request, try to serve index.html
    if File.directory?(file_path)
      index_path = File.join(file_path, "index.html")
      if File.exist?(index_path)
        # Rewrite the path to point to index.html
        env["PATH_INFO"] = File.join(path, "index.html")
      end
    elsif !File.exist?(file_path) && !path.end_with?("/")
      # Try directory + index.html pattern
      dir_index_path = File.join(@destination_path, path, "index.html") 
      if File.exist?(dir_index_path)
        env["PATH_INFO"] = File.join(path, "index.html")
      end
    end
    
    @app.call(env)
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
