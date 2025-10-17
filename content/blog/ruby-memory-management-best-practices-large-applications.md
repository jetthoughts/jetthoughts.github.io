---
title: "Ruby memory management best practices for large applications"
description: "Memory leaks killing your app's performance? Learn how to optimize Ruby memory usage, prevent leaks, and build memory-efficient Rails applications that scale."
date: 2024-09-17
tags: ["Ruby", "Memory management", "Performance optimization", "Ruby on Rails", "Memory leaks"]
categories: ["Development", "Performance"]
author: "JetThoughts Team"
slug: "ruby-memory-management-best-practices-large-applications"
canonical_url: "https://jetthoughts.com/blog/ruby-memory-management-best-practices-large-applications/"
meta_title: "Ruby Memory Management: Best Practices for Large Applications | JetThoughts"
meta_description: "Master Ruby memory management with our comprehensive guide. Learn to prevent memory leaks, optimize garbage collection, and build memory-efficient Rails apps."
---

## The Challenge
Memory leaks killing your app's performance? Watching your Rails server's memory usage creep up until it crashes?

## Our Approach
Let's master Ruby memory management and build apps that stay lean and fast

Have you ever deployed a Rails app that starts using 100MB of memory, only to find it consuming 2GB after a few days? Memory creep is one of the most insidious performance problems in Ruby applications. It starts small, grows slowly, and then suddenly your servers are crashing with out-of-memory errors.

The good news? Ruby memory issues follow predictable patterns, and there are proven techniques to prevent and fix them. Let's dive into how Ruby manages memory and what you can do to keep your applications running efficiently.

## Understanding Ruby's memory model

Before we can optimize memory usage, we need to understand how Ruby handles memory allocation and garbage collection.

### How Ruby allocates memory

Ruby uses several types of memory allocation that behave differently:

### Ruby memory allocation types

```ruby
# Object allocation - creates new Ruby objects
user = User.new                    # Allocates memory for User object
users = User.all.to_a             # Allocates memory for array and each user

# String allocation - strings are objects in Ruby
name = "John Doe"                  # Allocates memory for string
interpolated = "Hello #{name}"     # Allocates new string

# Symbol allocation - symbols are never garbage collected
status = :active                   # Allocated once and kept forever
dynamic_symbol = params[:key].to_sym  # DANGEROUS - can cause memory leaks

# Array and Hash allocation
data = [1, 2, 3, 4, 5]            # Allocates array and references to integers
config = { host: 'localhost', port: 3000 }  # Allocates hash

# Block and Proc allocation
callback = proc { |x| x * 2 }     # Allocates memory for proc object
```

### Ruby's garbage collection basics

Ruby uses a mark-and-sweep garbage collector with generational improvements:

### Understanding GC behavior

```ruby
# Monitor garbage collection
GC.start                          # Force garbage collection
puts GC.stat                      # View GC statistics

# Check current memory usage
def memory_usage
  `ps -o rss= -p #{Process.pid}`.to_i / 1024.0  # Memory in MB
end

puts "Memory usage: #{memory_usage}MB"

# Create temporary objects
1000.times { User.new }

puts "After object creation: #{memory_usage}MB"

GC.start
puts "After GC: #{memory_usage}MB"

# Key GC statistics to monitor:
gc_stats = GC.stat
puts "Total allocations: #{gc_stats[:total_allocated_objects]}"
puts "GC runs: #{gc_stats[:count]}"
puts "Heap pages: #{gc_stats[:heap_allocated_pages]}"
puts "Free slots: #{gc_stats[:heap_free_slots]}"
```

### Memory generations and object lifecycle

Ruby uses generational GC - newer objects are collected more frequently:

### Object generations in Ruby

```ruby
# Short-lived objects (collected frequently)
def process_request
  temp_data = JSON.parse(request.body)  # Dies after method returns
  result = transform_data(temp_data)    # Dies after method returns
  result.to_json                        # Dies after response sent
end

# Long-lived objects (collected less frequently)
class UserCache
  @@cache = {}                          # Lives for application lifetime

  def self.get(id)
    @@cache[id] ||= User.find(id)      # May live for hours/days
  end
end

# Immortal objects (never collected)
CONSTANTS = {                          # Lives forever
  api_version: '1.0',
  max_retries: 3
}

# Check object generation
ObjectSpace.each_object(String) do |str|
  puts "String: #{str[0..20]}... Generation: #{GC.generation(str)}"
end
```

> **💡 Tip:** Use `GC.generation(object)` to see which generation an object belongs to. Generation 0 objects are newest and collected most frequently.

## Common memory leak patterns

Let's identify and fix the most common memory leak patterns in Ruby applications.

### Pattern 1: Symbol leaks from dynamic content

Symbols are never garbage collected, making them dangerous when created from user input:

### Symbol leak prevention

```ruby
# BAD: Creates unlimited symbols from user input
class PostsController < ApplicationController
  def index
    sort_by = params[:sort_by].to_sym  # DANGER! Memory leak
    @posts = Post.order(sort_by)
  end
end

# GOOD: Use allowlist approach
class PostsController < ApplicationController
  ALLOWED_SORT_FIELDS = %i[created_at updated_at title author].freeze

  def index
    sort_by = params[:sort_by]&.to_sym

    if ALLOWED_SORT_FIELDS.include?(sort_by)
      @posts = Post.order(sort_by)
    else
      @posts = Post.order(:created_at)  # Safe default
    end
  end
end

# EVEN BETTER: Use string-based sorting
class PostsController < ApplicationController
  ALLOWED_SORT_FIELDS = %w[created_at updated_at title author].freeze

  def index
    sort_by = params[:sort_by]

    if ALLOWED_SORT_FIELDS.include?(sort_by)
      @posts = Post.order(sort_by)      # ActiveRecord handles strings fine
    else
      @posts = Post.order('created_at')
    end
  end
end

# Monitor symbol count
puts "Symbol count: #{Symbol.all_symbols.count}"

# Check for symbol leaks
symbols_before = Symbol.all_symbols.count
# ... run suspicious code ...
symbols_after = Symbol.all_symbols.count
puts "Symbols created: #{symbols_after - symbols_before}"
```

### Pattern 2: Cached object accumulation

Caches that grow unbounded will eventually consume all available memory:

### Safe caching patterns

```ruby
# BAD: Unbounded cache growth
class UserCache
  def self.cache
    @cache ||= {}
  end

  def self.get(id)
    cache[id] ||= User.find(id)  # Cache grows forever
  end
end

# GOOD: LRU cache with size limit
require 'lru_redux'

class UserCache
  MAX_CACHE_SIZE = 1000

  def self.cache
    @cache ||= LruRedux::Cache.new(MAX_CACHE_SIZE)
  end

  def self.get(id)
    cache.getset(id) { User.find(id) }
  end

  def self.clear
    @cache = nil
  end
end

# BETTER: Use Rails cache with TTL
class UserCache
  def self.get(id)
    Rails.cache.fetch("user_#{id}", expires_in: 1.hour) do
      User.find(id)
    end
  end
end

# EVEN BETTER: Memory-aware caching
class MemoryAwareCache
  MAX_MEMORY_MB = 50

  def self.cache
    @cache ||= {}
  end

  def self.get(key, &block)
    # Check memory usage before caching
    if current_memory_mb > MAX_MEMORY_MB
      cache.clear
      GC.start
    end

    cache[key] ||= block.call
  end

  def self.current_memory_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end
```

### Pattern 3: Event listener and callback leaks

Object references in callbacks can prevent garbage collection:

### Callback memory leak prevention

```ruby
# BAD: Callback holds reference to large object
class DataProcessor
  def initialize(large_dataset)
    @large_dataset = large_dataset     # Big object
    setup_callbacks
  end

  private

  def setup_callbacks
    EventBus.subscribe('data_updated') do |event|
      # This callback holds a reference to @large_dataset
      process_update(event)            # Memory leak!
    end
  end

  def process_update(event)
    # Process using @large_dataset
  end
end

# GOOD: Explicit cleanup and weak references
class DataProcessor
  def initialize(large_dataset)
    @large_dataset = large_dataset
    @subscription_id = setup_callbacks
  end

  def cleanup
    EventBus.unsubscribe(@subscription_id)
    @large_dataset = nil
  end

  private

  def setup_callbacks
    # Store only what you need, not the whole object
    dataset_id = @large_dataset.id

    EventBus.subscribe('data_updated') do |event|
      # Load data fresh instead of holding reference
      dataset = Dataset.find(dataset_id)
      process_update(event, dataset)
    end
  end
end

# BETTER: Use weak references where available
require 'weakref'

class DataProcessor
  def initialize(large_dataset)
    @large_dataset_ref = WeakRef.new(large_dataset)
    setup_callbacks
  end

  private

  def setup_callbacks
    weak_ref = @large_dataset_ref

    EventBus.subscribe('data_updated') do |event|
      begin
        dataset = weak_ref.__getobj__
        process_update(event, dataset)
      rescue WeakRef::RefError
        # Object was garbage collected, which is fine
        Rails.logger.info "Dataset was garbage collected"
      end
    end
  end
end
```

### Pattern 4: String and array concatenation leaks

Inefficient string and array operations can create memory pressure:

### Efficient string and array operations

```ruby
# BAD: Creates many intermediate strings
def build_html(items)
  html = ""
  items.each do |item|
    html += "<div>#{item.name}</div>"  # Creates new string each time
  end
  html
end

# GOOD: Use StringIO or Array#join
def build_html(items)
  items.map { |item| "<div>#{item.name}</div>" }.join
end

# BETTER: Use string interpolation efficiently
def build_html(items)
  items.map { |item|
    "<div>#{item.name}</div>"
  }.join
end

# BEST: Use proper templating
def build_html(items)
  render partial: 'item', collection: items
end

# BAD: Array concatenation in loop
def collect_data(sources)
  result = []
  sources.each do |source|
    result += source.fetch_data  # Creates new array each time
  end
  result
end

# GOOD: Use Array#concat or flatten
def collect_data(sources)
  sources.flat_map(&:fetch_data)
end

# Or use Array#concat for in-place modification
def collect_data(sources)
  result = []
  sources.each do |source|
    result.concat(source.fetch_data)  # Modifies array in place
  end
  result
end
```

## Profiling memory usage

You can't optimize what you don't measure. Let's set up comprehensive memory profiling.

### Using memory_profiler gem

The memory_profiler gem gives detailed insights into object allocation:

### Memory profiling with memory_profiler

```ruby
# Gemfile
gem 'memory_profiler'

# Basic memory profiling
require 'memory_profiler'

report = MemoryProfiler.report do
  # Code you want to profile
  1000.times { User.new(name: "User #{rand(1000)}") }
end

report.pretty_print

# Save report to file for analysis
report.pretty_print(to_file: 'memory_report.txt')

# Profile specific methods
class UserService
  def self.profile_batch_creation(count)
    MemoryProfiler.report do
      create_users_batch(count)
    end
  end

  def self.create_users_batch(count)
    users = []
    count.times do |i|
      users << User.create(
        name: "User #{i}",
        email: "user#{i}@example.com"
      )
    end
    users
  end
end

# Usage
report = UserService.profile_batch_creation(100)
puts "Total allocated: #{report.total_allocated_memsize} bytes"
puts "Total retained: #{report.total_retained_memsize} bytes"

# Analyze allocations by location
report.allocated_memory_by_file.each do |file, size|
  puts "#{file}: #{size} bytes"
end

# Find the biggest memory users
report.allocated_memory_by_class.first(10).each do |klass, size|
  puts "#{klass}: #{size} bytes"
end
```

### Real-time memory monitoring

Set up continuous memory monitoring in your Rails application:

### Real-time memory monitoring

```ruby
# app/services/memory_monitor.rb
class MemoryMonitor
  MEMORY_THRESHOLD_MB = 500
  CHECK_INTERVAL = 30.seconds

  def self.start
    Thread.new do
      loop do
        check_memory_usage
        sleep CHECK_INTERVAL
      end
    end
  end

  def self.check_memory_usage
    current_memory = memory_usage_mb

    Rails.logger.info "Memory usage: #{current_memory}MB"

    if current_memory > MEMORY_THRESHOLD_MB
      Rails.logger.warn "HIGH MEMORY USAGE: #{current_memory}MB"
      log_memory_details
      force_gc_if_needed(current_memory)
    end
  end

  def self.memory_usage_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end

  def self.log_memory_details
    gc_stats = GC.stat

    Rails.logger.info "GC Stats: #{gc_stats}"
    Rails.logger.info "Object count: #{ObjectSpace.count_objects}"

    # Log top object classes
    object_counts = Hash.new(0)
    ObjectSpace.each_object do |obj|
      object_counts[obj.class] += 1
    end

    Rails.logger.info "Top object classes:"
    object_counts.sort_by(&:last).last(10).reverse.each do |klass, count|
      Rails.logger.info "  #{klass}: #{count}"
    end
  end

  def self.force_gc_if_needed(current_memory)
    if current_memory > MEMORY_THRESHOLD_MB * 1.5
      Rails.logger.info "Forcing garbage collection"
      GC.start

      new_memory = memory_usage_mb
      Rails.logger.info "Memory after GC: #{new_memory}MB (freed #{current_memory - new_memory}MB)"
    end
  end
end

# config/initializers/memory_monitor.rb (for production)
if Rails.env.production?
  Rails.application.config.after_initialize do
    MemoryMonitor.start
  end
end

# Middleware for per-request memory tracking
class MemoryTrackingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    memory_before = memory_usage_mb

    status, headers, response = @app.call(env)

    memory_after = memory_usage_mb
    memory_diff = memory_after - memory_before

    if memory_diff > 10 # Log requests that use >10MB
      Rails.logger.warn "High memory request: #{env['REQUEST_METHOD']} #{env['PATH_INFO']} used #{memory_diff}MB"
    end

    [status, headers, response]
  end

  private

  def memory_usage_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end

# Add to application.rb
config.middleware.use MemoryTrackingMiddleware
```

### Memory benchmarking

Compare memory usage of different approaches:

### Memory benchmarking techniques

```ruby
require 'benchmark/memory'

# Compare different approaches
Benchmark.memory do |x|
  x.report("String concatenation") do
    result = ""
    1000.times { |i| result += "item #{i}" }
  end

  x.report("Array join") do
    items = []
    1000.times { |i| items << "item #{i}" }
    items.join
  end

  x.report("String interpolation") do
    (0...1000).map { |i| "item #{i}" }.join
  end

  x.compare!
end

# Benchmark different data loading strategies
Benchmark.memory do |x|
  x.report("Load all at once") do
    User.includes(:posts, :profile).limit(100).to_a
  end

  x.report("Load in batches") do
    User.includes(:posts, :profile).limit(100).find_in_batches(batch_size: 20) do |batch|
      batch.each { |user| user.posts.count }
    end
  end

  x.report("Lazy loading") do
    User.limit(100).find_each do |user|
      user.posts.count
      user.profile&.bio
    end
  end

  x.compare!
end

# Custom memory benchmarking helper
module MemoryBenchmark
  def self.compare(label, &block)
    puts "Benchmarking: #{label}"

    memory_before = memory_usage_mb
    gc_before = GC.stat

    result = block.call

    GC.start  # Force GC to see true memory usage

    memory_after = memory_usage_mb
    gc_after = GC.stat

    puts "  Memory: #{memory_before}MB -> #{memory_after}MB (#{(memory_after - memory_before).round(2)}MB diff)"
    puts "  Objects allocated: #{gc_after[:total_allocated_objects] - gc_before[:total_allocated_objects]}"
    puts "  GC runs: #{gc_after[:count] - gc_before[:count]}"

    result
  end

  def self.memory_usage_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end

# Usage
result1 = MemoryBenchmark.compare("Inefficient approach") do
  # Some memory-intensive code
end

result2 = MemoryBenchmark.compare("Optimized approach") do
  # More efficient code
end
```

## Garbage collection optimization

Understanding and tuning Ruby's garbage collector can significantly improve performance.

### Tuning GC parameters

Ruby's GC behavior can be tuned via environment variables:

### GC tuning for production

```bash
# Environment variables for GC tuning

# Increase heap size to reduce GC frequency
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_GC_HEAP_FREE_SLOTS=200000

# Control heap growth
export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=100000

# Control when GC runs
export RUBY_GC_MALLOC_LIMIT=16000000
export RUBY_GC_MALLOC_LIMIT_MAX=32000000

# Control old generation GC
export RUBY_GC_OLDMALLOC_LIMIT=16000000
export RUBY_GC_OLDMALLOC_LIMIT_MAX=128000000

# For memory-constrained environments (smaller heap)
export RUBY_GC_HEAP_INIT_SLOTS=100000
export RUBY_GC_HEAP_FREE_SLOTS=10000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.05
```

### Custom GC strategies

Implement application-specific GC strategies:

### Custom GC management

```ruby
# Smart GC triggering based on request patterns
class SmartGarbageCollector
  def self.after_request(controller)
    # Force GC after memory-intensive operations
    if memory_intensive_controller?(controller)
      GC.start
    end

    # Force GC periodically
    if should_run_periodic_gc?
      GC.start
      @last_periodic_gc = Time.current
    end
  end

  def self.memory_intensive_controller?(controller)
    MEMORY_INTENSIVE_CONTROLLERS = %w[
      ReportsController
      ExportsController
      BulkOperationsController
    ].freeze

    MEMORY_INTENSIVE_CONTROLLERS.include?(controller.class.name)
  end

  def self.should_run_periodic_gc?
    @last_periodic_gc ||= Time.current
    Time.current - @last_periodic_gc > 5.minutes
  end

  # Monitor GC effectiveness
  def self.monitor_gc_effectiveness
    before_memory = memory_usage_mb
    before_objects = ObjectSpace.count_objects[:T_OBJECT]

    GC.start

    after_memory = memory_usage_mb
    after_objects = ObjectSpace.count_objects[:T_OBJECT]

    freed_memory = before_memory - after_memory
    freed_objects = before_objects - after_objects

    Rails.logger.info "GC freed #{freed_memory}MB and #{freed_objects} objects"

    # If GC isn't freeing much, we might have a memory leak
    if freed_memory < 5 && freed_objects < 1000
      Rails.logger.warn "GC effectiveness is low - possible memory leak"
    end
  end

  def self.memory_usage_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end

# ApplicationController integration
class ApplicationController < ActionController::Base
  after_action :smart_gc

  private

  def smart_gc
    SmartGarbageCollector.after_request(self)
  end
end

# Background job GC management
class ApplicationJob < ActiveJob::Base
  around_perform do |job, block|
    memory_before = memory_usage_mb

    block.call

    memory_after = memory_usage_mb
    memory_used = memory_after - memory_before

    # Force GC after memory-intensive jobs
    if memory_used > 50
      Rails.logger.info "Job #{job.class.name} used #{memory_used}MB, running GC"
      GC.start
    end
  end

  private

  def memory_usage_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end
```

### GC performance monitoring

Track GC performance over time:

### GC performance tracking

```ruby
# app/services/gc_monitor.rb
class GcMonitor
  def self.start_monitoring
    @gc_stats_before = GC.stat.dup
    @start_time = Time.current
  end

  def self.log_gc_metrics
    return unless @gc_stats_before

    gc_stats_after = GC.stat
    duration = Time.current - @start_time

    metrics = {
      duration_seconds: duration.round(2),
      gc_runs: gc_stats_after[:count] - @gc_stats_before[:count],
      major_gc_runs: gc_stats_after[:major_gc_count] - @gc_stats_before[:major_gc_count],
      minor_gc_runs: gc_stats_after[:minor_gc_count] - @gc_stats_before[:minor_gc_count],
      objects_allocated: gc_stats_after[:total_allocated_objects] - @gc_stats_before[:total_allocated_objects],
      heap_pages: gc_stats_after[:heap_allocated_pages],
      heap_slots_used: gc_stats_after[:heap_live_slots],
      heap_slots_free: gc_stats_after[:heap_free_slots]
    }

    Rails.logger.info "GC Metrics: #{metrics}"

    # Send to monitoring service
    if defined?(StatsD)
      metrics.each do |key, value|
        StatsD.increment("gc.#{key}", value)
      end
    end

    @gc_stats_before = nil
  end

  # Middleware for automatic GC monitoring
  class GcTrackingMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      GcMonitor.start_monitoring

      status, headers, response = @app.call(env)

      GcMonitor.log_gc_metrics

      [status, headers, response]
    end
  end
end

# Daily GC report
class GcReportJob < ApplicationJob
  queue_as :low_priority

  def perform
    gc_stats = GC.stat
    memory_mb = `ps -o rss= -p #{Process.pid}`.to_i / 1024.0

    report = {
      timestamp: Time.current,
      memory_usage_mb: memory_mb,
      total_gc_runs: gc_stats[:count],
      major_gc_runs: gc_stats[:major_gc_count],
      heap_pages: gc_stats[:heap_allocated_pages],
      total_allocated_objects: gc_stats[:total_allocated_objects],
      heap_final_slots: gc_stats[:heap_final_slots]
    }

    Rails.logger.info "Daily GC Report: #{report}"

    # Store historical data
    GcReport.create!(report)
  end
end
```

## Memory-efficient coding practices

Write code that's naturally memory-friendly from the start.

### Efficient data processing patterns

### Memory-efficient data processing

```ruby
# BAD: Loads everything into memory
def process_all_users
  User.all.each do |user|  # Loads ALL users into memory
    update_user_stats(user)
  end
end

# GOOD: Process in batches
def process_all_users
  User.find_in_batches(batch_size: 1000) do |batch|
    batch.each do |user|
      update_user_stats(user)
    end
  end
end

# BETTER: Use find_each for automatic batching
def process_all_users
  User.find_each(batch_size: 1000) do |user|
    update_user_stats(user)
  end
end

# BEST: Use pluck for simple operations
def get_user_emails
  User.pluck(:email)  # Only loads email column, not full objects
end

# Efficient aggregation without loading objects
def calculate_user_stats
  {
    total_users: User.count,
    active_users: User.where(active: true).count,
    avg_age: User.average(:age),
    recent_signups: User.where('created_at > ?', 1.week.ago).count
  }
end

# Stream processing for large datasets
def export_users_csv
  CSV.open('users.csv', 'w') do |csv|
    csv << ['Name', 'Email', 'Created At']

    User.find_each do |user|
      csv << [user.name, user.email, user.created_at]
      # Each user object is eligible for GC after this iteration
    end
  end
end

# Lazy enumeration for memory efficiency
def process_large_file(filename)
  File.foreach(filename).lazy
      .map(&:strip)
      .reject(&:empty?)
      .each_slice(100) do |batch|
        process_batch(batch)
      end
end
```

### Smart caching strategies

### Memory-conscious caching

```ruby
# Cache only what you need, when you need it
class UserStatsCache
  CACHE_TTL = 1.hour
  MAX_CACHE_SIZE = 1000

  def self.get_stats(user_id)
    key = "user_stats:#{user_id}"

    Rails.cache.fetch(key, expires_in: CACHE_TTL) do
      calculate_user_stats(user_id)
    end
  end

  # Only cache expensive calculations
  def self.calculate_user_stats(user_id)
    user = User.find(user_id)

    {
      post_count: user.posts.count,
      comment_count: user.comments.count,
      reputation_score: calculate_reputation(user),
      activity_score: calculate_activity(user)
    }
    # User object can be GC'd after this method
  end

  # Conditional caching based on memory pressure
  def self.cache_if_memory_allows(key, &block)
    if current_memory_mb < 400  # Only cache if we have memory available
      Rails.cache.fetch(key, expires_in: 30.minutes, &block)
    else
      block.call  # Skip caching when memory is tight
    end
  end

  def self.current_memory_mb
    `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
  end
end

# Time-based cache eviction
class TimedCache
  def initialize(ttl: 1.hour)
    @cache = {}
    @ttl = ttl
  end

  def get(key, &block)
    entry = @cache[key]

    if entry && (Time.current - entry[:timestamp]) < @ttl
      entry[:value]
    else
      value = block.call
      @cache[key] = { value: value, timestamp: Time.current }

      # Periodic cleanup
      cleanup_expired if rand(100) == 0

      value
    end
  end

  private

  def cleanup_expired
    cutoff = Time.current - @ttl
    @cache.reject! { |_, entry| entry[:timestamp] < cutoff }
  end
end

# Size-limited cache
class SizeLimitedCache
  def initialize(max_size: 1000)
    @cache = {}
    @access_order = []
    @max_size = max_size
  end

  def get(key, &block)
    if @cache.key?(key)
      # Update access order
      @access_order.delete(key)
      @access_order << key
      @cache[key]
    else
      value = block.call
      set(key, value)
      value
    end
  end

  private

  def set(key, value)
    @cache[key] = value
    @access_order << key

    if @cache.size > @max_size
      # Remove least recently used
      oldest_key = @access_order.shift
      @cache.delete(oldest_key)
    end
  end
end
```

### Avoiding common memory pitfalls

### Memory pitfall prevention

```ruby
# 1. Avoid creating unnecessary objects in loops
# BAD
def format_users(users)
  users.map do |user|
    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}".titleize,  # Creates multiple strings
      email: user.email.downcase                             # Creates new string
    }
  end
end

# GOOD
def format_users(users)
  users.map do |user|
    full_name = user.full_name  # Assume this is efficient

    {
      id: user.id,
      name: full_name,
      email: user.email.downcase
    }
  end
end

# 2. Use constants for repeated values
# BAD
def process_items(items)
  items.select { |item| item.status == 'active' }  # Creates string each time
end

# GOOD
ACTIVE_STATUS = 'active'.freeze

def process_items(items)
  items.select { |item| item.status == ACTIVE_STATUS }
end

# 3. Reuse objects when possible
# BAD
def generate_reports(data)
  data.map do |row|
    formatter = ReportFormatter.new  # Creates new object each time
    formatter.format(row)
  end
end

# GOOD
def generate_reports(data)
  formatter = ReportFormatter.new  # Reuse single object

  data.map do |row|
    formatter.format(row)
  end
end

# 4. Clear large data structures when done
def process_large_dataset
  data = load_large_dataset  # Big memory allocation

  result = transform_data(data)

  data = nil  # Help GC by removing reference
  GC.start   # Force GC to clean up immediately

  result
end

# 5. Use streaming for file operations
# BAD
def process_csv_file(filename)
  content = File.read(filename)  # Loads entire file into memory
  CSV.parse(content) do |row|
    process_row(row)
  end
end

# GOOD
def process_csv_file(filename)
  CSV.foreach(filename) do |row|  # Reads line by line
    process_row(row)
  end
end

# 6. Avoid string mutations in hot paths
# BAD
def build_query(conditions)
  query = "SELECT * FROM users WHERE "
  conditions.each_with_index do |condition, index|
    query << " AND " if index > 0
    query << condition
  end
  query
end

# GOOD
def build_query(conditions)
  "SELECT * FROM users WHERE #{conditions.join(' AND ')}"
end
```

> **⚠️ Warning:** Don't micro-optimize too early! Focus on the biggest memory users first. Profile your application to find the real bottlenecks before applying these techniques.

## Production monitoring and alerting

Set up comprehensive monitoring to catch memory issues before they affect users.

### Memory alerting system

### Production memory monitoring

```ruby
# config/initializers/memory_monitoring.rb (production only)
if Rails.env.production?
  class ProductionMemoryMonitor
    ALERT_THRESHOLD_MB = 800
    CRITICAL_THRESHOLD_MB = 1200
    CHECK_INTERVAL = 30.seconds

    def self.start
      Thread.new do
        loop do
          check_memory_and_alert
          sleep CHECK_INTERVAL
        end
      rescue => e
        Rails.logger.error "Memory monitor error: #{e.message}"
        sleep 60  # Wait before restarting
        retry
      end
    end

    def self.check_memory_and_alert
      current_memory = memory_usage_mb

      if current_memory > CRITICAL_THRESHOLD_MB
        send_critical_alert(current_memory)
        emergency_memory_cleanup
      elsif current_memory > ALERT_THRESHOLD_MB
        send_warning_alert(current_memory)
      end
    end

    def self.send_critical_alert(memory_mb)
      Rails.logger.error "CRITICAL MEMORY USAGE: #{memory_mb}MB"

      # Send to monitoring service
      if defined?(StatsD)
        StatsD.increment('memory.critical_alert')
        StatsD.gauge('memory.usage_mb', memory_mb)
      end

      # Send to Slack/email
      AlertService.send_critical_alert(
        title: "Critical Memory Usage",
        message: "Server memory usage: #{memory_mb}MB (threshold: #{CRITICAL_THRESHOLD_MB}MB)",
        details: gather_memory_details
      )
    end

    def self.emergency_memory_cleanup
      Rails.logger.info "Running emergency memory cleanup"

      # Clear caches
      Rails.cache.clear

      # Force garbage collection
      3.times { GC.start }

      # Clear any application-specific caches
      UserCache.clear if defined?(UserCache)

      memory_after = memory_usage_mb
      Rails.logger.info "Memory after cleanup: #{memory_after}MB"
    end

    def self.gather_memory_details
      gc_stats = GC.stat

      {
        memory_mb: memory_usage_mb,
        gc_count: gc_stats[:count],
        heap_pages: gc_stats[:heap_allocated_pages],
        heap_slots: gc_stats[:heap_live_slots],
        top_objects: top_object_classes(10)
      }
    end

    def self.top_object_classes(limit = 10)
      object_counts = Hash.new(0)
      ObjectSpace.each_object { |obj| object_counts[obj.class] += 1 }
      object_counts.sort_by(&:last).last(limit).reverse.to_h
    end

    def self.memory_usage_mb
      `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
    end
  end

  # Start monitoring after Rails initialization
  Rails.application.config.after_initialize do
    ProductionMemoryMonitor.start
  end
end

# Sidekiq memory monitoring
if defined?(Sidekiq)
  Sidekiq.configure_server do |config|
    config.server_middleware do |chain|
      chain.add MemoryTrackingMiddleware
    end
  end

  class SidekiqMemoryMiddleware
    def call(worker, job, queue)
      memory_before = memory_usage_mb

      yield

      memory_after = memory_usage_mb
      memory_used = memory_after - memory_before

      if memory_used > 100  # Log jobs using >100MB
        Rails.logger.warn "High memory job: #{worker.class.name} used #{memory_used}MB"
      end
    end

    private

    def memory_usage_mb
      `ps -o rss= -p #{Process.pid}`.to_i / 1024.0
    end
  end
end
```

## Ready to master Ruby memory management?

Memory management in Ruby doesn't have to be mysterious. By understanding how Ruby allocates and collects memory, identifying common leak patterns, and implementing smart monitoring, you can build applications that stay lean and fast even as they scale.

The key is to start with good practices from the beginning: avoid creating unnecessary objects, use efficient data processing patterns, and monitor your memory usage in production. When issues do arise, you'll have the tools and knowledge to diagnose and fix them quickly.

**Start optimizing your Ruby memory usage:**

1. Add basic memory monitoring to identify current usage patterns
2. Profile your most memory-intensive operations with memory_profiler
3. Implement efficient data processing patterns in your hottest code paths
4. Set up production alerting to catch issues early

**Need help optimizing your Ruby application's memory usage?**

At JetThoughts, we've helped teams solve complex memory issues in Ruby applications of all sizes. From small memory leaks to major architectural optimizations, we know how to make Ruby apps run efficiently at scale.

Our memory optimization services include:
- Comprehensive memory profiling and leak detection
- Custom GC tuning and optimization strategies
- Code review focused on memory efficiency
- Production monitoring and alerting setup
- Team training on Ruby memory best practices

Ready to build memory-efficient Ruby applications? [Contact us for a memory optimization consultation](https://jetthoughts.com/contact-us/) and let's discuss how we can help your application run leaner and faster.

