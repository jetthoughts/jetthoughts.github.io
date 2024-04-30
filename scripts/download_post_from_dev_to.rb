require 'net/http'
require 'json'

url = 'https://dev.to/api/articles/jetthoughts/incremental-lint-fixes-by-github-actions-38o8'
uri = URI(url)
response = Net::HTTP.get(uri)
data = JSON.parse(response)

body_markdown = data['body_markdown']
slug = data['slug']

File.open("#{slug}.md", 'w') { |file| file.write(body_markdown) }
puts "File #{slug}.md successfully created."
