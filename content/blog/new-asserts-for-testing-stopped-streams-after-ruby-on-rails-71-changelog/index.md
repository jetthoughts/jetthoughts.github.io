---
dev_to_id: 1851499
title: "New asserts for testing stopped streams after Ruby on Rails 7.1."
description: "Previously, developers encountered a significant challenge verifying if streams ceased operation..."
created_at: "2024-05-13T15:10:06Z"
edited_at: "2024-11-01T16:09:30Z"
draft: false
tags: ["changelog", "testing", "rails"]
canonical_url: "https://jetthoughts.com/blog/new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-changelog/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fzad8psdcqef2hwwzzm9x.png"
slug: "new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-changelog"
metatags:
  image: cover.png
---
Previously, developers encountered a significant challenge verifying if streams ceased operation correctly. This issue often led to the creation of intricate workarounds or the omission of proper testing.

## The Old Way

Here's an e­xample:

```ruby
assert_not ActionCable.server.pubsub.redis_connection_for_subscriptions.subscribed_to?("messages")
```

This code­ works but isn't straightforward to update.

## The New Solution

The following Ruby on Rails introduces `assert_has_no_stream` and `assert_has_no_stream_for`. These new methods simplify the testing of stopped streams.

```ruby
assert_has_no_stream "messages"
assert_has_no_stream_for User.find(42)
```

With these new assertion methods, you can straightforwardly express your test goals. This simplicity and clarity strengthen your tests and make them easier to maintain, giving you confidence in the reliability of your code.
