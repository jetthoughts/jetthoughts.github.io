---
title: "Rails performance optimization: 15 proven techniques to speed up your app"
description: "Is your Rails app getting slower as it grows? Here are 15 battle-tested techniques to make it lightning fast again."
date: 2024-09-17
tags: ["Ruby on Rails", "Performance optimization", "Rails performance", "Database optimization", "Ruby performance"]
categories: ["Development", "Performance"]
author: "JetThoughts Team"
slug: "rails-performance-optimization-15-proven-techniques"
canonical_url: "https://jetthoughts.com/blog/rails-performance-optimization-15-proven-techniques/"
meta_title: "Rails Performance Optimization: 15 Proven Techniques | JetThoughts"
meta_description: "Speed up your Rails app with 15 proven performance optimization techniques. Database queries, caching, background jobs, and more expert tips."
---


Have you ever watched your Rails app go from lightning-fast to frustratingly slow? We've been there. That smooth, snappy app you launched starts feeling sluggish as you add features, gain users, and accumulate data.

The good news? Most Rails performance problems follow predictable patterns, and there are proven techniques to fix them. We'll walk through 15 optimization strategies that have consistently delivered dramatic speed improvements for our clients.

## The Challenge

Is your Rails app getting slower as it grows? Users complaining about long load times?

## Our Approach

Let's fix that with 15 battle-tested performance optimization techniques that have consistently delivered dramatic speed improvements.

## Identifying performance bottlenecks

Before we start optimizing, let's figure out what's actually slow. Guessing at performance problems is like debugging with `puts` statements – sometimes it works, but it's not very scientific.

### 1. Add performance monitoring

First things first: you need data. Without metrics, you're flying blind.

### Setting up basic performance monitoring

```ruby
# Gemfile
gem 'newrelic_rpm' # or gem 'skylight'

# config/initializers/performance.rb
if Rails.env.production?
  Rails.application.config.middleware.use(
    Rack::Timeout,
    service_timeout: 30
  )
end

# Add to ApplicationController
class ApplicationController < ActionController::Base
  around_action :log_performance_data

  private

  def log_performance_data
    start_time = Time.current
    yield
  ensure
    duration = Time.current - start_time
    Rails.logger.info "Action #{action_name} took #{duration.round(3)}s"
  end

  # Combine performance monitoring with comprehensive testing strategies:
  # /blog/ruby-on-rails-testing-strategy-unit-tests-integration/
end
```

### 2. Use Rails' built-in profiling tools

Rails gives you some excellent tools right out of the box:

### Built-in Rails profiling

```bash
# Check your logs for slow queries
tail -f log/development.log | grep "ms)"

# Use the Rails console for quick profiling
rails c
> Benchmark.measure { User.includes(:posts).limit(100).to_a }

# Profile memory usage - for comprehensive memory profiling techniques:
# /blog/ruby-memory-management-best-practices-large-applications/
> require 'memory_profiler'
> MemoryProfiler.report { expensive_operation }.pretty_print
```

### 3. Identify your slowest endpoints

Focus your optimization efforts where they'll have the biggest impact:

### Finding slow endpoints

```ruby
# config/initializers/slow_request_logger.rb
class SlowRequestLogger
  def initialize(app, threshold: 1000)
    @app = app
    @threshold = threshold
  end

  def call(env)
    start_time = Time.current
    status, headers, response = @app.call(env)

    duration = (Time.current - start_time) * 1000

    if duration > @threshold
      Rails.logger.warn "SLOW REQUEST: #{env['REQUEST_METHOD']} #{env['PATH_INFO']} took #{duration.round(2)}ms"
    end

    [status, headers, response]
  end
end

Rails.application.config.middleware.use SlowRequestLogger
```

## Database optimization techniques

Most Rails performance problems live in the database layer. Let's fix the most common culprits.

### 4. Eliminate N+1 queries

This is the big one. N+1 queries can turn a fast page into a crawling nightmare.

### Fixing N+1 queries with includes

```ruby
# BAD: This creates N+1 queries
@posts = Post.limit(10)
@posts.each { |post| puts post.author.name }

# GOOD: This creates 2 queries total
@posts = Post.includes(:author).limit(10)
@posts.each { |post| puts post.author.name }

# EVEN BETTER: Only load what you need
@posts = Post.joins(:author)
             .select('posts.*, authors.name as author_name')
             .limit(10)
```

> **💡 Tip:** Use the `bullet` gem in development to catch N+1 queries automatically. It'll save you hours of debugging!

### 5. Add strategic database indexes

Missing indexes are silent performance killers:

### Adding effective indexes

```ruby
# migration: add_indexes_for_performance.rb
class AddIndexesForPerformance < ActiveRecord::Migration[7.0]
  def change
    # Index foreign keys (Rails doesn't do this automatically)
    add_index :posts, :author_id
    add_index :comments, :post_id

    # Index columns used in WHERE clauses
    add_index :posts, :published_at
    add_index :users, :email # if not already unique

    # Composite indexes for common query patterns
    add_index :posts, [:author_id, :published_at]
    add_index :posts, [:status, :created_at]
  end
end
```

### 6. Optimize your most expensive queries

Find and fix your slowest database queries:

### Query optimization techniques

```sql
-- Use EXPLAIN to understand query execution
EXPLAIN ANALYZE SELECT * FROM posts
WHERE author_id = 123
AND published_at > '2024-01-01'
ORDER BY published_at DESC;

-- Optimize with proper indexes and query structure
-- Instead of this slow query:
SELECT posts.*, authors.name, COUNT(comments.id) as comment_count
FROM posts
JOIN authors ON posts.author_id = authors.id
LEFT JOIN comments ON posts.id = comments.post_id
WHERE posts.published_at > '2024-01-01'
GROUP BY posts.id, authors.name
ORDER BY posts.published_at DESC;

-- Try breaking it into smaller, indexed queries
```

### 7. Use database-level pagination

Skip counting when you don't need exact page numbers:

### Efficient pagination

```ruby
# Instead of offset/limit (slow on large datasets)
Post.published.order(:created_at).limit(20).offset(page * 20)

# Use cursor-based pagination
class Post < ApplicationRecord
  scope :since_id, ->(id) { where('id > ?', id) if id.present? }
  scope :until_id, ->(id) { where('id < ?', id) if id.present? }
end

# In your controller
@posts = Post.published
             .since_id(params[:since_id])
             .order(:id)
             .limit(20)

# Pass the last post ID for the next page
@next_cursor = @posts.last&.id
```

## Caching strategies that actually work

Caching can dramatically speed up your app, but only if you do it right.

### 8. Fragment caching for expensive views

Cache the expensive parts of your templates:

### Smart fragment caching

```erb
<!-- app/views/posts/show.html.erb -->
<% cache @post do %>
  <h1><%= @post.title %></h1>
  <div class="metadata">
    Published by <%= @post.author.name %> on <%= @post.published_at.strftime('%B %d, %Y') %>
  </div>
<% end %>

<!-- Cache expensive calculations separately -->
<% cache [@post, 'stats'], expires_in: 1.hour do %>
  <div class="stats">
    <span><%= @post.comments.count %> comments</span>
    <span><%= @post.views.count %> views</span>
  </div>
<% end %>

<!-- Always cache your navigation if it's database-heavy -->
<% cache 'navigation', expires_in: 30.minutes do %>
  <%= render 'shared/navigation' %>
<% end %>
```

### 9. Smart low-level caching

Cache expensive calculations and external API calls:

### Low-level caching patterns

```ruby
class User < ApplicationRecord
  def expensive_calculation
    Rails.cache.fetch("user_#{id}_calculation", expires_in: 1.hour) do
      # Some complex calculation that takes time
      posts.joins(:comments).group('DATE(posts.created_at)').count
    end
  end

  def profile_completeness
    Rails.cache.fetch("user_#{id}_profile_completeness", expires_in: 1.day) do
      score = 0
      score += 20 if name.present?
      score += 20 if email.present?
      score += 30 if bio.present?
      score += 30 if avatar.attached?
      score
    end
  end
end

# Cache external API calls
class WeatherService
  def self.current_weather(city)
    Rails.cache.fetch("weather_#{city}", expires_in: 10.minutes) do
      # Expensive API call
      HTTParty.get("https://api.weather.com/#{city}")
    end
  end
end
```

### 10. Use Redis for session storage

File-based sessions don't scale. Redis does:

### Redis session configuration

```ruby
# Gemfile
gem 'redis-rails'

# config/initializers/session_store.rb
Rails.application.config.session_store :redis_store,
  servers: [
    {
      host: ENV.fetch('REDIS_HOST', 'localhost'),
      port: ENV.fetch('REDIS_PORT', 6379),
      db: ENV.fetch('REDIS_DB', 0),
      namespace: 'sessions'
    }
  ],
  expire_after: 2.weeks,
  key: "_#{Rails.application.class.module_parent_name.downcase}_session"
```

## Background job optimization

Move slow operations out of the request cycle.

### 11. Async processing for heavy operations

Don't make users wait for slow operations:

### Background job patterns

```ruby
class User < ApplicationRecord
  after_create :send_welcome_email_async
  after_update :sync_to_external_service_async, if: :saved_change_to_email?

  private

  def send_welcome_email_async
    WelcomeEmailJob.perform_later(self)
  end

  def sync_to_external_service_async
    SyncUserJob.perform_later(self)
  end
end

# app/jobs/welcome_email_job.rb
class WelcomeEmailJob < ApplicationJob
  queue_as :emails

  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  def perform(user)
    UserMailer.welcome(user).deliver_now
  end
end

# Process different types of jobs with different priorities
# config/application.rb
config.active_job.queue_adapter = :sidekiq
```

### 12. Optimize background job performance

Make your background jobs faster and more reliable:

### Job optimization techniques

```ruby
class DataExportJob < ApplicationJob
  queue_as :low_priority

  def perform(user_id, export_type)
    # Batch database queries to reduce memory usage
    User.find(user_id).posts.find_in_batches(batch_size: 1000) do |batch|
      process_batch(batch, export_type)
    end
  end

  private

  def process_batch(posts, export_type)
    # Process in smaller chunks to avoid memory bloat
    posts.each do |post|
      # Process individual post
    end

    # Force garbage collection periodically
    GC.start if Random.rand(10) == 0
  end
end
```

## Memory usage optimization

Ruby's garbage collector works hard, but you can help it out. For deep-dive memory optimization techniques, see our [comprehensive Ruby memory management guide](/blog/ruby-memory-management-best-practices-large-applications/).

### 13. Reduce object allocation

Creating fewer objects means less garbage collection pressure:

### Memory-efficient Ruby patterns

```ruby
# BAD: Creates many temporary objects
def format_names(users)
  users.map { |user| "#{user.first_name} #{user.last_name}".titleize }
end

# BETTER: Use fewer string interpolations
def format_names(users)
  users.map { |user| [user.first_name, user.last_name].join(' ').titleize }
end

# EVEN BETTER: Do it in the database
def format_names(users)
  users.pluck("CONCAT(first_name, ' ', last_name)")
end

# Use symbols for hash keys (they're not garbage collected)
# BAD
data = { "name" => user.name, "email" => user.email }

# GOOD
data = { name: user.name, email: user.email }
```

### 14. Stream large responses

Don't load huge datasets into memory:

### Streaming responses

```ruby
class ReportsController < ApplicationController
  def export_users
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = 'attachment; filename="users.csv"'
        headers['Content-Type'] = 'text/csv'

        # Stream the response instead of building it all in memory
        self.response_body = Enumerator.new do |yielder|
          yielder << CSV.generate_line(['Name', 'Email', 'Created'])

          User.find_in_batches(batch_size: 1000) do |batch|
            batch.each do |user|
              yielder << CSV.generate_line([user.name, user.email, user.created_at])
            end
          end
        end
      end
    end
  end
end
```

### 15. Monitor and optimize memory usage

Keep an eye on your app's memory consumption:

### Memory monitoring

For production-grade [memory profiling techniques](/blog/ruby-memory-management-best-practices-large-applications/#profiling-memory-usage), integrate these patterns with comprehensive monitoring tools.

```ruby
# Add to your ApplicationController
class ApplicationController < ActionController::Base
  if Rails.env.development?
    around_action :log_memory_usage
  end

  private

  def log_memory_usage
    start_memory = memory_usage
    yield
    end_memory = memory_usage

    Rails.logger.info "Memory: #{start_memory}MB -> #{end_memory}MB (#{(end_memory - start_memory).round(2)}MB diff)"
  end

  def memory_usage
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end

# For production monitoring
# Gemfile
gem 'get_process_mem'

# In your monitoring
class MemoryReporter
  def self.report
    mem = GetProcessMem.new
    Rails.logger.info "Memory usage: #{mem.mb.round(2)}MB"

    # Alert if memory usage is too high
    if mem.mb > 512 # Adjust threshold as needed
      Rails.logger.warn "HIGH MEMORY USAGE: #{mem.mb.round(2)}MB"
    end
  end
end
```

> **⚠️ Warning:** Remember: premature optimization is the root of all evil. Always measure first, then optimize. Don't guess at what's slow – profile and find out for sure.

## Measuring your success

After implementing these optimizations, you'll want to measure the impact:

**Key metrics to track:**
- Average response time per endpoint
- Database query count and duration
- Memory usage patterns
- Background job processing times
- User-perceived performance (Core Web Vitals)

**Tools that help:**
- New Relic or Skylight for application monitoring
- Redis Monitor for cache hit rates
- Your database's slow query log
- Browser dev tools for frontend performance

## Ready to make your Rails app lightning fast?

Performance optimization is both an art and a science. The techniques we've covered here have consistently delivered significant improvements across hundreds of Rails applications.

The key is to approach optimization systematically: measure first, identify bottlenecks, apply targeted fixes, and measure again. Don't try to implement everything at once – pick the 3-4 techniques that address your biggest pain points first.

For systematic performance improvements with [test-driven development](/blog/ruby-on-rails-testing-strategy-unit-tests-integration/), ensure all optimizations are validated through comprehensive testing.

**Start with these high-impact optimizations:**

1. Fix N+1 queries (biggest bang for your buck)
2. Add database indexes for your most common queries
3. Implement fragment caching on expensive views
4. Move heavy operations to background jobs

**Need expert help optimizing your Rails app?**

At JetThoughts, we've optimized Rails applications serving millions of users. We know where to look for performance bottlenecks and how to fix them without breaking your existing functionality.

Our performance optimization services include:
- Comprehensive performance audit and profiling
- Database query optimization and indexing strategy
- Caching implementation and Redis setup
- Background job architecture and optimization
- Ongoing performance monitoring and maintenance

Ready to make your Rails app blazing fast? [Contact us for a performance audit](https://jetthoughts.com/contact-us/) and let's discuss how we can speed up your application.

## Next Steps

Ready to implement these performance optimizations in your Rails app?

1. Start with measuring your current performance baseline
2. Focus on the highest-impact optimizations first (N+1 queries, indexes)
3. Implement caching strategically where it matters most
4. Move heavy operations to background jobs
5. Monitor and measure your improvements continuously

## Related Resources

Need expert help with Rails performance? Contact JetThoughts for a comprehensive performance audit.

