---
dev_to_id: 1200329
title: "Auto-install system dependencies for Ruby on Rails"
description: "Let's integrate Homebrew into our Ruby on Rails Project local set up.  There is a convention for Ruby..."
created_at: "2022-09-22T15:37:41Z"
edited_at: "2022-09-27T18:10:04Z"
sync_date: "2024-05-24T16:04:33Z"
draft: false
tags: ["ruby", "programming", "devops", "tutorial"]
canonical_url: "https://jtway.co/auto-install-system-dependencies-for-ruby-on-rails-4a19c22b6d49"
slug: "auto-install-system-dependencies-for-ruby-on-rails-programming"
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

---

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
> If you enjoyed this story, we recommend reading our latest tech stories and trending [tech stories](https://jtway.co/trending).
