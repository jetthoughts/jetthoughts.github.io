---
remote_url: https://dev.to/jetthoughts/understanding-optimistic-and-pessimistic-locking-in-ruby-on-rails-2fo
source: dev_to
remote_id: 2187281
dev_to_id: 2187281
dev_to_url: https://dev.to/jetthoughts/understanding-optimistic-and-pessimistic-locking-in-ruby-on-rails-2fo
title: Understanding Optimistic and Pessimistic Locking in Ruby on Rails
description: When several people touch a database simultaneously, software conflicts can occur when more than one...
created_at: '2025-01-03T10:10:53Z'
edited_at: '2025-01-04T08:17:35Z'
draft: false
tags:
- ruby
- rails
- tutorial
- database
canonical_url: https://jetthoughts.com/blog/understanding-optimistic-pessimistic-locking-in-ruby-on-rails/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/understanding-optimistic-pessimistic-locking-in-ruby-on-rails/cover.png
metatags:
  image: cover.png
slug: understanding-optimistic-pessimistic-locking-in-ruby-on-rails
---
When several people touch a database simultaneously, software conflicts can occur when more than one user tries to update the same record. The most sought-after way to avoid problems from this point of view is to lock the record the first user needs to change. Such conflicts are dealt with in Ruby on Rails using two locking strategies: Optimistic Locking and Pessimistic Locking. This article discusses these strategies, their differences, and how they can be implemented in Ruby on Rails.

Optimistic Locking
---------------
