---
dev_to_id: 2157631
dev_to_url: https://dev.to/jetthoughts/a-simpler-way-to-set-content-types-in-rails-n4o
title: A Simpler Way to Set Content Types in Rails
description: Rails now lets you set content types with less code. This new feature makes your work easier.       ...
created_at: '2024-12-15T12:43:01Z'
edited_at:
draft: false
tags:
- rails
- ruby
- news
- tutorial
canonical_url: https://dev.to/jetthoughts/a-simpler-way-to-set-content-types-in-rails-n4o
cover_image:
slug: simpler-way-set-content-types-in-rails-ruby
---
Rails now lets you set content types with less code. This new feature makes your work easier.

## The Change
You can now use a short symbol instead of a long text string. Here's what it looks like:

Old way:
```ruby
response.content_type = "text/html"
```

New way:
```ruby
response.content_type = :html
```

## Benefits
This change helps in three ways. First, your code becomes shorter. Second, it matches how Rails handles other formats. Third, you don't need to remember the full content type text.

## Using the Feature
To try this, update your Rails version. Then start using symbols for your content types.

## Credit
[Petrik de Heus](https://github.com/peternijssen) built this feature. His work helps make Rails better for everyone.