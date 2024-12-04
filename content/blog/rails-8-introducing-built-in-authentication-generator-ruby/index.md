---
dev_to_id: 2126561
dev_to_url: https://dev.to/jetthoughts/rails-8-introducing-the-built-in-authentication-generator-1l77
title: 'Rails 8: Introducing the Built-in Authentication Generator'
description: Rails 8 Authentication Guide for Ruby Developers   Ruby on Rails developers face a common...
created_at: '2024-11-29T09:11:43Z'
edited_at: '2024-12-04T03:17:54Z'
draft: false
tags:
- rails
- ruby
- tutorial
- changelog
canonical_url: https://dev.to/jetthoughts/rails-8-introducing-the-built-in-authentication-generator-1l77
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/rails-8-introducing-built-in-authentication-generator-ruby/cover.png
slug: rails-8-introducing-built-in-authentication-generator-ruby
metatags:
  image: cover.png
---
# Rails 8 Authentication Guide for Ruby Developers

Ruby on Rails developers face a common task: building user login systems. Rails 8 brings a built-in solution. This guide helps Rails developers create authentication without extra gems.

## What Ruby Developers Will Build

As a Rails developer, you'll create:
- A secure authentication system
- Public and private pages
- A test suite for user flows
- Database migrations for users

## Set Up Your Rails Environment

Ruby on Rails developers start here:

```bash
rails new auth-example
cd auth-example
```

This creates a fresh Rails application.

## Rails 8 Authentication Generator

Rails developers love simple solutions. Run:

```bash
bin/rails generate authentication
```

The generator creates Rails files:
- ERB view templates
- Rails controllers
- Ruby models
- RSpec test files

## Database Setup for Rails

Rails developers need a working database:

```bash
bin/rails db:create db:migrate
```

Create a test user in Rails console:

```bash
rails c
```

Add user data:

```ruby
User.create(email_address: "you@example.com", password: "test-password-123")
```

## Rails Controllers

Rails developers work with two types of access:
- Public pages for visitors
- Private pages for users

Generate Rails controllers:

```bash
rails g controller home index
rails g controller dashboard show
```

## Ruby on Rails Routes

Rails routing connects URLs to Ruby code. Update `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get "home/index", as: :home
  get "dashboard/show", as: :dashboard
  root "home#index"
end
```

## Public Controller in Rails

Ruby developers handle public access:

```ruby
class HomeController < ApplicationController
  allow_unauthenticated_access(only: :index)
  def index
  end
end
```

## Authenticated Controller

Rails developers protect private pages:

```ruby
class DashboardController < ApplicationController
  before_action :resume_session, only: [:show]
  def show
  end
end
```

## Test Your Rails App

Start your Rails server:

```bash
rails s
```

Test these Rails routes:
1. `/home` - Public access
2. `/dashboard` - Login required

## Rails Security Tips

Ruby developers follow these practices:
- Use secure passwords
- Keep Rails updated
- Monitor logs
- Back up data

## Rails Authentication Code

View the Ruby code: [Rails Authentication Source](https://github.com/rails/rails/blob/main/railties/lib/rails/generators/rails/authentication/templates/app/controllers/concerns/authentication.rb.tt)

## Tasks for Rails Developers

Try these Ruby tasks:
1. Build a signup flow
2. Create a password reset
3. Add session persistence
4. Style your ERB templates

## Next Steps for Rails Developers

You can extend this:
- Add OAuth support
- Create admin roles
- Add API authentication
- Build user profiles

Remember: Now, the Rails developer starts with basic authentication. Build more. Learn more.

Need Ruby on Rails help? Drop questions below.