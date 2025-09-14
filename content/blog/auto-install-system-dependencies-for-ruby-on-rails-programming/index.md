---
remote_url: https://dev.to/jetthoughts/auto-install-system-dependencies-for-ruby-on-rails-48kf
source: dev_to
remote_id: 1200329
dev_to_id: 1200329
dev_to_url: https://dev.to/jetthoughts/auto-install-system-dependencies-for-ruby-on-rails-48kf
title: Auto-install system dependencies for Ruby on Rails
description: Let's integrate Homebrew into our Ruby on Rails Project local set up.  There is a convention for Ruby...
created_at: '2022-09-22T15:37:41Z'
edited_at: '2024-11-25T15:40:36Z'
draft: false
tags:
- ruby
- programming
- devops
- tutorial
canonical_url: https://jetthoughts.com/blog/auto-install-system-dependencies-for-ruby-on-rails-programming/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/auto-install-system-dependencies-for-ruby-on-rails-programming/cover.jpg
metatags:
  image: cover.jpg
slug: auto-install-system-dependencies-for-ruby-on-rails-programming
---
Let's integrate Homebrew into our Ruby on Rails Project local set up.

There is a convention for Ruby on Rails projects to use `bin/setup` to set up and install/update required dependencies. But by default, it does not include system dependencies.

We are going to use [the Homebrew Bundle tool](https://github.com/Homebrew/homebrew-bundle) for this.

First, we need to have a `Brewfile` with:

```ruby
# Redis - For ActionCable support (and Sidekiq, caching, etc.)
brew "redis"
    
# PostgreSQL - brew install postgresql
brew "postgresql"
    
# Overmind (requires tmux)
brew "tmux"
brew "overmind"
    
# Imagemagick or libvips - for processing images (avatars, file uploads, etc.)
brew "vips"
    
# Yarn - for installing Javascript dependencies
brew "yarn"
```

Then, in `bin/setup,` we are going to add:

```ruby
puts "== Installing system dependencies =="
if system('[[ (-x "$(command -v brew)") ]]') # Is Homebrew available?
  system("brew bundle check --no-lock --no-upgrade") || system!("brew bundle --no-upgrade --no-lock") # install if there are missed dependencies
end
```

I prefer to add it in the beginning before installing other dependencies.

These will help new onboarding set up development with one command only. Reduces the number of instructions from `README`.
