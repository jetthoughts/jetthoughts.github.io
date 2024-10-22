---
dev_to_id: 1939835
title: "Kamal Integration in Rails 8 by Default"
description: "In Rails 8, Kamal will be included by default. This change aims to simplify deployment and..."
created_at: "2024-07-29T09:50:35Z"
edited_at: "2024-10-22T17:18:49Z"
draft: false
tags: ["ruby", "rails", "kamal", "docker"]
canonical_url: "https://jetthoughts.com/blog/kamal-integration-in-rails-8-by-default-ruby/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fq8hqn47ak2tmxlr13awl.png"
slug: "kamal-integration-in-rails-8-by-default-ruby"
metatags:
  image: cover.png
---

In **Rails 8**, Kamal will be included by default. This change aims to simplify deployment and infrastructure management processes for developers. 

## What is Kamal?
Kamal is a deployment tool that works with Docker and Kubernetes. It automates and simplifies the deployment of applications, providing support for containerization and orchestration.

## Key Changes
**Adding Kamal to the Gemfile:**
The Gemfile of new Rails applications will now include the kamal gem by default:
```ruby
gem 'kamal', '~> 1.0'
```

**Automatic Generation of Kamal Configuration File:**
When creating a new Rails application, a Kamal configuration file will now be generated automatically, allowing for basic deployment parameters to be set up immediately.
```yaml
# Name of your application. Used to uniquely configure containers.
service: app_name

# Name of the container image.
image: your-user/app_name

# Deploy to these servers.
servers:
  web:
    - 192.168.0.1
  # job:
  #   hosts:
  #     - 192.168.0.1
  #   cmd: bin/solid_queue work

# Credentials for your image host.
registry:
  # Specify the registry server, if you're not using Docker Hub
  # server: registry.digitalocean.com / ghcr.io / ...
  username: your-user

  # Always use an access token rather than real password when possible.
  password:
    - KAMAL_REGISTRY_PASSWORD

# Inject ENV variables into containers (secrets come from .env).
# Remember to run `kamal env push` after making changes!
env:
  secret:
    - RAILS_MASTER_KEY
  # clear:
  #   DB_HOST: 192.168.0.2

# Use a persistent storage volume for sqlite database files and local Active Storage files.
# Recommended to change this to a mounted volume path that is backed up off server.
volumes:
  - "app_name_storage:/rails/storage"

# Bridge fingerprinted assets, like JS and CSS, between versions to avoid
# hitting 404 on in-flight requests. Combines all files from new and old
# version inside the asset_path.
asset_path: /rails/public/assets

# Use a different ssh user than root
# ssh:
#   user: app

# Configure builder setup (defaults to multi-arch images).
# builder:
#   # Build same-arch image locally (use for x86->x86)
#   multiarch: false
#
#   # Build diff-arch image via remote server
#   remote:
#     arch: amd64
#     host: ssh://app@192.168.0.1
#
#   args:
#     RUBY_VERSION: <%= ENV["RBENV_VERSION"] || ENV["rvm_ruby_string"] || "#{RUBY_ENGINE}-#{RUBY_ENGINE_VERSION}" %>
#   secrets:
#     - GITHUB_TOKEN
#     - RAILS_MASTER_KEY

# Use accessory services (secrets come from .env).
# accessories:
#   db:
#     image: mysql:8.0
#     host: 192.168.0.2
#     port: 3306
#     env:
#       clear:
#         MYSQL_ROOT_HOST: '%'
#       secret:
#         - MYSQL_ROOT_PASSWORD
#     files:
#       - config/mysql/production.cnf:/etc/mysql/my.cnf
#       - db/production.sql:/docker-entrypoint-initdb.d/setup.sql
#     directories:
#       - data:/var/lib/mysql
#   redis:
#     image: redis:7.0
#     host: 192.168.0.2
#     port: 6379
#     directories:
#       - data:/data
```

**Updates to Rails Generators:** 
Rails generators now support Kamal, enabling the use of standard Rails commands to create and configure applications with Kamal in mind.

## Benefits of Kamal Integration

**Simplified Deployment:** 
Kamal automates the deployment process, making it easy to set up and deploy applications.

**Support for Docker and Kubernetes:** 
Kamal integrates with Docker and Kubernetes, allowing the use of containerization and orchestration systems.

**Unified Technology Stack:**
With Kamal built into Rails, developers get a unified stack for development and deployment, simplifying project management.

More information here: 
- https://github.com/rails/rails/pull/51798
- https://kamal-deploy.org/