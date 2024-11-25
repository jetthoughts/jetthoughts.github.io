---
dev_to_id: 1910839
title: 'New Rails 7.2: Added Rate Limiting'
description: Ruby on Rails 7.2 added rate limiting to Action Controller. It's cool and easy to use.            ...
created_at: '2024-07-03T21:05:23Z'
edited_at: '2024-11-25T15:33:20Z'
draft: false
tags:
- rails
- changelog
canonical_url: https://jetthoughts.com/blog/new-rails-72-added-rate-limiting-changelog/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/new-rails-72-added-rate-limiting-changelog/cover.png
slug: new-rails-72-added-rate-limiting-changelog
metatags:
  image: cover.png
---
Ruby on Rails 7.2 added rate limiting to Action Controller. It's cool and easy to use.

![rate_limit in Rails 7.2](file_0.png)


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