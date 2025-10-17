---
title: "Rails 7 upgrade guide: Step-by-step migration from Rails 6"
description: "Stuck on Rails 6 while Rails 7 offers amazing performance improvements? Here's your complete guide to upgrading safely with zero downtime."
date: 2024-09-17
tags: ["Ruby on Rails", "Rails 7", "Rails upgrade", "Rails migration", "Performance optimization"]
categories: ["Development", "Ruby on Rails"]
author: "JetThoughts Team"
slug: "rails-7-upgrade-guide-step-by-step-migration"
canonical_url: "https://jetthoughts.com/blog/rails-7-upgrade-guide-step-by-step-migration/"
meta_title: "Rails 7 Upgrade Guide: Complete Migration from Rails 6 | JetThoughts"
meta_description: "Complete Rails 7 upgrade guide with step-by-step instructions, code examples, and best practices. Migrate from Rails 6 safely with our expert tips."
---

## The Challenge
Stuck on Rails 6 while Rails 7 offers amazing performance improvements and new features?

## Our Approach
Let's walk through a complete upgrade process together, step by step

Have you ever wondered if upgrading Rails is worth the potential headaches? We've been there too. Rails 7 brings some incredible improvements – faster asset compilation with esbuild, better security defaults, and performance boosts that can make your app noticeably snappier.

But here's the thing: upgrading Rails doesn't have to be scary. With the right approach, you can move from Rails 6 to Rails 7 smoothly, and we'll show you exactly how.

## Why upgrade to Rails 7 now

Rails 7 isn't just another version bump. It's a significant leap forward that brings real benefits to your app and your development workflow.

**Performance improvements you'll notice immediately:**
- Asset compilation is up to 3x faster with the new JavaScript bundling
- Hotwire Turbo makes page transitions feel instant
- Better database query optimization out of the box

**Developer experience wins:**
- No more Webpack configuration headaches
- Simplified asset pipeline with esbuild
- Better error messages and debugging tools

**Security enhancements:**
- Improved CSRF protection
- Better content security policy defaults
- Enhanced encryption for sensitive data

The best part? Most Rails 6 apps can upgrade with minimal code changes. Let's dive into how you can make it happen.

---

## Pre-upgrade preparation checklist

Before we touch any code, let's make sure you're set up for success. This preparation phase will save you hours of debugging later.

> **💡 Tip:** Always upgrade on a feature branch first. Never upgrade directly on main – you'll thank yourself later!

**1. Audit your current setup**

First, let's see what you're working with:

**Check your current Rails version**
```bash
# In your terminal
rails --version
# Should show something like "Rails 6.1.7"

# Check your Ruby version too
ruby --version
# Rails 7 requires Ruby 2.7.0 or newer
```

**2. Update your test suite**

Make sure all your tests are passing before you start. If they're not, fix them now – you'll need them to catch any upgrade issues.

**Run your full test suite**
```bash
# For RSpec users
bundle exec rspec

# For Minitest users
rails test

# Don't forget system tests
rails test:system
```

**3. Review your gem dependencies**

Some gems might not be Rails 7 compatible yet. Let's check:

**Check gem compatibility**
```bash
# Use bundler-audit to check for known issues
gem install bundler-audit
bundler-audit check --update

# Check for outdated gems
bundle outdated
```

**4. Back up your database**

This should go without saying, but let's say it anyway: back up your database before making any changes.

**Database backup commands**
```bash
# For PostgreSQL
pg_dump your_database_name > backup_before_rails7.sql

# For MySQL
mysqldump -u username -p your_database_name > backup_before_rails7.sql

# Don't forget to test your backup!
```

---

## Step-by-step migration process

Now for the main event. We'll upgrade Rails gradually to catch any issues early.

### Step 1: Update your Gemfile

Start by updating Rails in your Gemfile:

**Gemfile changes**
```ruby
# Before
gem 'rails', '~> 6.1.7'

# After
gem 'rails', '~> 7.0.0'

# You might also want to update these related gems
gem 'bootsnap', '>= 1.4.4', require: false
gem 'sprockets-rails' # Add this if you're using Sprockets
gem 'importmap-rails' # New Rails 7 default for JavaScript
```

### Step 2: Bundle install and handle conflicts

Time to install the new Rails version:

**Installing Rails 7**
```bash
bundle update rails

# If you get dependency conflicts, try this instead:
bundle update --conservative rails

# This updates Rails while keeping other gems at compatible versions
```

You might see some dependency conflicts. Don't panic! Most can be resolved by updating related gems:

**Common gem updates needed**
```ruby
# Add these to your Gemfile if you don't have them
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false

# These are now separate gems in Ruby 3.1+
```

### Step 3: Run the Rails upgrade script

Rails provides a handy script to update configuration files:

**Rails upgrade command**
```bash
rails app:update

# This will show you diffs for each config file
# You can choose to keep your version, use the new version, or merge
```

**Key files to pay attention to:**
- `config/application.rb` - New configuration options
- `config/environments/development.rb` - Better defaults for debugging
- `config/environments/production.rb` - Performance improvements

### Step 4: Handle JavaScript and asset changes

Rails 7 introduces a new approach to JavaScript. If you're using Webpacker, you'll need to decide your path forward.

> **⚠️ Warning:** If you run into trouble during the upgrade, you can always revert your changes and try a different approach. This is why we're working on a feature branch!

**Option 1: Stick with Sprockets (recommended for most apps)**

**Updating for Sprockets**
```javascript
// app/assets/javascripts/application.js becomes:
//= require rails-ujs
//= require turbo
//= require_tree .

// Remove any webpack-specific imports
```

**Option 2: Migrate to importmap (Rails 7 default)**

**Setting up importmap**
```bash
# Add importmap to your Gemfile
bundle add importmap-rails

# Generate importmap configuration
rails importmap:install

# This creates config/importmap.rb
```

### Step 5: Update your routes

Rails 7 has some new routing features, but your existing routes should work fine. However, you might want to take advantage of new features:

**New Rails 7 routing features**
```ruby
# config/routes.rb

# New: infer format from request headers
resources :posts, defaults: { format: :json }

# New: better constraint syntax
get '/admin/*path', to: 'admin#show', constraints: ->(req) { req.subdomain == 'admin' }
```

---

## Handling breaking changes

Most Rails 6 apps will upgrade smoothly, but there are a few breaking changes to watch for.

### ActiveRecord changes

**Deprecation: `update_attributes`**

**Updating deprecated methods**
```ruby
# Before (deprecated)
user.update_attributes(name: 'John')

# After (Rails 7 compatible)
user.update(name: 'John')
```

**Changes to `composed_of`**

If you're using `composed_of` (rare, but possible), you'll need to replace it with custom methods.

### ActiveSupport changes

**Updated `ActiveSupport::Duration` behavior**

**Duration parsing changes**
```ruby
# This behavior changed slightly in Rails 7
duration = 1.day + 2.hours

# Make sure your tests account for more precise calculations
```

### ActionView changes

**HTML sanitization is stricter**

Rails 7 has improved XSS protection, which might affect how you handle user-generated content:

**Updated sanitization**
```ruby
# This might now strip more tags than before
sanitize(user_content)

# Be explicit about allowed tags if needed
sanitize(user_content, tags: %w[p br strong em])
```

---

## Testing your upgraded app

Testing is crucial. Here's how to make sure everything still works:

### Run your test suite

Start with the obvious:

**Full test run**
```bash
# Run everything
rails test:all

# Or if you use RSpec
bundle exec rspec

# Pay special attention to integration tests
rails test:system
```

### Manual testing checklist

Don't rely only on automated tests. Click through your app manually:

- [ ] User authentication works
- [ ] Forms submit correctly
- [ ] File uploads function
- [ ] JavaScript features work
- [ ] Background jobs process
- [ ] Email sending works

### Performance testing

Rails 7 should be faster, but let's verify:

**Basic performance check**
```bash
# Start your server
rails server

# In another terminal, test some endpoints
curl -w "@curl-format.txt" -o /dev/null -s "http://localhost:3000/"

# Create curl-format.txt with:
#     time_namelookup:  %{time_namelookup}\n
#     time_connect:     %{time_connect}\n
#     time_appconnect:  %{time_appconnect}\n
#     time_pretransfer: %{time_pretransfer}\n
#     time_redirect:    %{time_redirect}\n
#     time_starttransfer: %{time_starttransfer}\n
#     ----------\n
#     time_total:       %{time_total}\n
```

---

## Post-upgrade optimization tips

Once you're running Rails 7, you can take advantage of new features to make your app even better.

### Enable Hotwire Turbo

Hotwire Turbo comes with Rails 7 and can make your app feel much faster:

**Adding Turbo to your layouts**
```erb
<!-- app/views/layouts/application.html.erb -->
<%= javascript_importmap_tags %>

<!-- Turbo will automatically intercept link clicks and form submissions -->
<!-- No additional configuration needed for basic functionality -->
```

### Optimize your asset pipeline

Rails 7's new asset pipeline is much faster. Make sure you're getting the benefits:

**Asset optimization**
```ruby
# config/environments/production.rb

# Enable asset compression
config.assets.compress = true

# Use the new digest strategy
config.assets.digest = true

# Precompile additional assets if needed
config.assets.precompile += %w( admin.js admin.css )
```

### Take advantage of new security features

Rails 7 has better security defaults. Make sure they're enabled:

**Security configuration**
```ruby
# config/application.rb

# Enable new CSRF protection
config.force_ssl = true # in production

# Use the new content security policy helpers
# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.script_src :self, :https
  policy.style_src :self, :https, :unsafe_inline
end
```

---

## What to do if something breaks

Even with careful preparation, you might run into issues. Here's how to troubleshoot:

### Common error messages and fixes

**"uninitialized constant" errors**

Usually means a gem isn't compatible. Check for updated versions or alternatives.

**Asset compilation failures**

Often related to JavaScript changes. Review your asset pipeline configuration.

**Test failures**

Rails 7 has stricter validations. Review failing tests to see if they're catching real issues or need updates.

### Getting help

If you're stuck:

1. Check the [Rails 7 upgrade guide](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html)
2. Search GitHub issues for your gems
3. Ask on Stack Overflow with the `ruby-on-rails` and `rails-7` tags

Remember: if you're having trouble, you can always revert to your previous Rails version while you troubleshoot. That's why we're working on a feature branch!

---

## Ready to upgrade with confidence?

Upgrading to Rails 7 might seem daunting, but with the right approach, it's totally manageable. The performance improvements and new features are worth the effort.

The key is taking it step by step, testing thoroughly, and not rushing the process. Most apps upgrade smoothly, and the ones that don't usually have specific edge cases that are solvable.


**What's next?**

- Start with a feature branch and follow our checklist
- Run your tests frequently during the upgrade process
- Take advantage of Rails 7's new features once you're upgraded

**Need help with your Rails upgrade?**

At JetThoughts, we've helped dozens of companies upgrade their Rails applications safely and efficiently. If you'd rather have experts handle the upgrade while you focus on your business, [let's talk about your Rails upgrade project](https://jetthoughts.com/contact-us/).

We offer comprehensive Rails upgrade services including:
- Pre-upgrade assessment and planning
- Zero-downtime upgrade execution
- Post-upgrade optimization and training
- Ongoing Rails maintenance and support

Ready to get started? [Contact us today](https://jetthoughts.com/contact-us/) for a free Rails upgrade consultation.