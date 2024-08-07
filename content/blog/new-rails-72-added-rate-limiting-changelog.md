---
dev_to_id: 1910839
title: "New Rails 7.2: Added Rate Limiting"
description: "Ruby on Rails 7.2 added rate limiting to Action Controller. It's cool and easy to use.            ..."
created_at: "2024-07-03T21:05:23Z"
edited_at: "2024-07-03T21:07:48Z"
draft: false
tags: ["rails", "changelog"]
canonical_url: "https://dev.to/jetthoughts/new-rails-72-added-rate-limiting-5a8o"
cover_image: "https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fhuuki7kw1dji10iqrd44.png"
slug: "new-rails-72-added-rate-limiting-changelog"
---
Ruby on Rails 7.2 added rate limiting to Action Controller. It's cool and easy to use.

![rate_limit in Rails 7.2](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/j0sfw82qnev4mx1kquvu.png)


What's New?
-----------

Rails now offer built-in rate limiting using Redis and Kredis. This empowers you to control how often a user can act within a given time, putting you in the driver's seat.


Before:
-------

```ruby
# Manually implemented rate limiting
```

After:
------

```ruby
class SessionsController < ApplicationController

  rate_limit to: 10, within: 3.minutes, only: :create

end

class SignupsController < ApplicationController

  rate_limit to: 1000, within: 10.seconds, by: -> { request.domain }, with: -> { redirect_to busy_controller_url, alert: "Too many signups!" }, only: :new

end
```

How It Works
------------

1.  **Setup:** Ensure you have Redis and Kredis 1.7.0+.
2.  **Usage:** Add `rate_limit` in your controllers.

Why This Matters
----------------

This feature is great for preventing abuse and managing traffic, and it's also highly flexible. You can customize limits per action and gracefully handle exceeded limits, making it a perfect fit for your needs.

Conclusion
----------

This update makes managing traffic easier. It's straightforward and effective. If you're using Rails, give it a try!

For more details, check out the [official pull request](https://github.com/rails/rails/pull/50490).