---
remote_url: https://dev.to/jetthoughts/new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-542b
source: dev_to
remote_id: 1851499
dev_to_id: 1851499
dev_to_url: https://dev.to/jetthoughts/new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-542b
title: New asserts for testing stopped streams after Ruby on Rails 7.1.
description: Previously, developers encountered a significant challenge verifying if streams ceased operation...
created_at: '2024-05-13T15:10:06Z'
edited_at: '2024-11-25T15:39:17Z'
draft: false
tags:
- changelog
- testing
- rails
canonical_url: https://jetthoughts.com/blog/new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-changelog/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-changelog/cover.png
metatags:
  image: cover.png
slug: new-asserts-for-testing-stopped-streams-after-ruby-on-rails-71-changelog
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
