---
dev_to_id: 1089599
title: "How to get & build full URLs in Rails"
description: "There are some cases when you want to get a current request absolute URL. Thankfully, Rails got you..."
created_at: "2022-05-19T08:10:35Z"
edited_at: "2024-10-21T20:07:41Z"
draft: false
tags: ["ruby", "rails", "webdev"]
canonical_url: "https://jetthoughts.com/blog/how-get-build-full-urls-in-rails-ruby/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fp6h92y04u9tw8zreu37m.jpg"
slug: "how-get-build-full-urls-in-rails-ruby"
metatags:
  image: cover.jpg
---
There are some cases when you want to get a current request absolute URL. Thankfully, Rails got you covered on this one and provides a simple way for that: 
```ruby
request.original_url
```
This'll return an absolute full URL including schema, host, port, path, and query string, but without anchor though.

So, for a request to `https://example.com/resource?q=first`:

```ruby
request.original_url # => https://example.com/resource?q=first
request.fullpath # => /resource?q=first
request.path # => /resource
```

## Building full URL
When you need to build a full URL in controller views you can simply use the URL helpers provided by Rails:
```ruby
post_url(@post)
```

But it's not that easy outside the request(controller/view) scope. For example, if you need to build a full URL inside a background job, Rails can't simply get the host for that from a request, since there's no request.

#### To make it work we need two things:

First, include URL helpers.
```ruby
class MyJob < ApplicationJob
  include Rails.application.routes.url_helpers
  
  def perform(user)
    user_url(user)
    ...
  end
end
```
And then, set url options in app configuration:
```ruby
# config/environments/production.rb
Rails.application.routes.default_url_options[:host] =  "example.com"
# And for email views
Rails.application.config.action_mailer[:host] = "example.com"
```

If you need to generate URLs for assets (for example images/icons in emails) you'll need to set `asset_host` as well:
```ruby
# Need only if host is other than the one 
# that handles requests
config.action_controller.asset_host = 'example.com'

# Required since mailer has no request context 
# to get host address from
config.action_mailer.asset_host = 'example.com'
```