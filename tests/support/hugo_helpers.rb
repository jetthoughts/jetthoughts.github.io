module Hugo
  def self.precompile(port:)
    system("hugo --minify --baseURL \"http://localhost:#{port}\" --environment production", exception: true)
  end
end
