---
dev_to_id: 1872098
title: 'New in Ruby on Rails 7.2: Development Containers Configuration'
description: Development container is a full-featured coding environment. Rails 7.2 introduces configurations for...
created_at: '2024-05-31T13:45:09Z'
edited_at: '2024-11-25T15:36:14Z'
draft: false
tags:
- rails
- ruby
- docker
- changelog
canonical_url: https://jetthoughts.com/blog/new-in-ruby-on-rails-72-development-containers-configuration/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/new-in-ruby-on-rails-72-development-containers-configuration/cover.png
slug: new-in-ruby-on-rails-72-development-containers-configuration
metatags:
  image: cover.png
---

Development container is a full-featured coding environment. **Rails 7.2** introduces configurations for these containers in your application, including a `.devcontainer` folder with `Dockerfile`, `docker-compose.yml`, and `devcontainer.json`.

The default dev container includes:

- A database (SQLite, Postgres, MySQL, or MariaDB)
- Active Storage with local disk usage and preview features
- A Redis container
- A Headless Chrome container for system tests

Generate a new application with a development container using:
```bash
rails new myapp --devcontainer
```
After this, you will see the result of the generator:
```bash
      ...
      create  storage/.keep
      create  tmp/storage
      create  tmp/storage/.keep
      create  .devcontainer
      create  .devcontainer/devcontainer.json
      create  .devcontainer/Dockerfile
      create  .devcontainer/compose.yaml
      ...
```
As you can see, the generator created files that correspond to the container configuration.

For existing applications, use:
```bash
rails devcontainer
```
Result:
```bash
╰─ $ rails devcontainer
Generating Dev Container with the following options:
app_name: rails_blog
database: sqlite3
active_storage: true
redis: true
system_test: true
node: false
      create  .devcontainer
      create  .devcontainer/devcontainer.json
      create  .devcontainer/Dockerfile
      create  .devcontainer/compose.yaml
        gsub  test/application_system_test_case.rb
```

More details in the [Getting Started with Dev Containers guide.](https://edgeguides.rubyonrails.org/getting_started_with_devcontainer.html)

We have previously written about how to set up Docker for Ruby on Rails 7. In this article you can find more detailed information on how to configure docker:
[Setting Up Docker for Ruby on Rails 7](https://jetthoughts.com/blog/setting-up-docker-for-ruby-on-rails-7-beginners/)