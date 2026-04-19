---
dev_to_id: null
title: "Rails 8 Solid Cache Performance: Complete Migration from Redis"
slug: rails-8-solid-cache-performance-redis-migration
date: 2025-10-27
description: "Complete guide to Rails 8 Solid Cache performance optimization and Redis migration. Database-backed caching advantages, benchmarks, cost savings, and step-by-step migration strategy."
summary: "Master Rails 8 Solid Cache migration from Redis. Database-backed caching advantages, performance benchmarks, cost analysis, migration guide, and optimization strategies for production deployments."
author: "JetThoughts Team"
draft: false
tags: ["rails", "solid-cache", "redis", "caching", "performance", "rails-8"]
categories: ["Development", "Rails", "Performance"]
cover_image: "cover.png"
canonical_url: "https://jetthoughts.com/blog/rails-8-solid-cache-performance-redis-migration/"
metatags:
  image: cover.png
  og_title: "Rails 8 Solid Cache: Complete Redis Migration Guide"
  og_description: "Master Solid Cache migration from Redis. Complete guide with benchmarks, cost analysis, migration strategy for production deployments."
  twitter_card: "summary_large_image"
  twitter_title: "Rails 8 Solid Cache Performance: Complete Redis Migration"
  twitter_description: "Master Solid Cache migration from Redis. Benchmarks, cost analysis, production migration guide."
cover_image_alt: "Rails 8 Solid Cache performance and migration from Redis"
---

*Your team pays $200-500/month for a Redis caching service you might not need. Rails 8 lets you replace it with your existing database — saving $17K+/year on a typical mid-size app. This guide shows your dev team how to make the switch safely.*

Rails 8 made Solid Cache the default caching backend. Your database is already running, already monitored, already backed up. Why pay for a separate Redis instance when PostgreSQL can serve those cache reads on its own?

The tradeoff is real though — database-backed caching is slower per read than Redis. Whether that matters depends on your traffic. Here are the actual numbers and a production migration path.

## Executive Summary

Solid Cache stores your cached data in the database you already run. You skip the Redis bill, the Redis monitoring, and the Redis on-call rotation. Redis reads faster -- no question -- but most teams we work with never hit the volume where that gap matters. If your app does fewer than 10,000 cache reads per second, your team will save money and sleep better with Solid Cache. If you're doing more than that, or you need sub-millisecond latency for rate limiting, keep Redis.

## Why Database-Backed Caching Matters

### The Infrastructure Simplification Story

Every Redis instance your team runs is another service to monitor, patch, back up, and page someone about at 2am. A typical mid-size app pays $200-500/month for Redis hosting, plus $50-100/month for monitoring, plus 5-10 hours of DevOps time each month keeping it healthy. With Solid Cache, you add $10-30/month in database storage and almost no extra maintenance -- your DBA is already watching PostgreSQL anyway. You drop the Redis cluster, the Redis backup job, the network config between services, and the security surface that comes with an extra stateful process in production.

### Real-World Impact: Cost Savings Analysis

#### Potential Savings

Dropping Redis removes a hosting bill, a monitoring bill, and several hours of DevOps time each month. The exact savings depend on your provider, traffic, and team size -- run the numbers against your own infrastructure before committing to a migration.

## How Solid Cache Works

### Database-Backed Caching Fundamentals

Solid Cache writes cache entries as rows in a PostgreSQL table, indexed for fast key lookups, with built-in expiration columns so the database handles eviction without a background job:

```ruby
# Core Solid Cache implementation
module SolidCache
  class Entry < ActiveRecord::Base
    # Efficient key-value storage with expiration
    # Uses database indexes for fast lookups
    # Leverages database transactions for consistency
  end
end

# Automatic configuration in Rails 8
# config/environments/production.rb
config.cache_store = :solid_cache_store

# Advanced configuration options
config.cache_store = :solid_cache_store, {
  database: :cache,              # Use separate cache database
  expires_in: 2.weeks,           # Default expiration
  size_estimate: 100.megabytes,  # Size hint for optimization
  max_age: 2.weeks               # Maximum age for cache entries
}
```

The biggest architectural win is transactional consistency. Imagine your team upgrades a user to premium and deletes the cached status in the same request. With Redis, if the transaction rolls back, that cache key is already gone -- now every request for that user hits the database until someone notices. With Solid Cache, the cache delete lives inside the same database transaction, so a rollback undoes both:

```ruby
# Cache invalidation inside the same transaction -- rollback undoes both
ActiveRecord::Base.transaction do
  user.update!(premium: true)
  Rails.cache.delete("user:#{user.id}:status")
  # If this transaction rolls back, the cache entry stays intact
end
```

Your team also stops worrying about eviction policies. Solid Cache expires entries automatically based on the TTL you set, and the database reclaims that space on its own:

```ruby
Rails.cache.write(
  key,
  value,
  expires_in: ttl,
  race_condition_ttl: 10.seconds
)
```

And because cache lives on disk rather than in memory, your team can cache large datasets without watching `used_memory` climb toward the Redis `maxmemory` limit:

```ruby
dataset.each_slice(1000) do |slice|
  Rails.cache.write(
    "dataset:#{slice.first.id}",
    slice.to_json,
    expires_in: 1.hour
  )
end
```

### Performance Characteristics

#### Performance Overview

Solid Cache is comparable to Redis for most workloads -- page caching, fragment caching, and moderate read rates feel the same to end users. Redis is faster for high-frequency access patterns (rate limiting, real-time presence) where sub-millisecond latency matters. Solid Cache has the advantage in storage capacity since it uses disk rather than memory.

Benchmark against your own database and workload before deciding. Latency depends heavily on your PostgreSQL version, connection pooling, and whether the cache database shares hardware with your primary database.

#### When to Use Which

Solid Cache handles page caching, fragment caching, and infrequently changing data (product catalogs, feature flags, configuration) without breaking a sweat. Your team reaches for Redis when the access pattern is high-frequency and latency-sensitive -- rate limiting at 10K+ reads/sec, session storage where every millisecond shows up in the UX, or real-time features like presence tracking that depend on pub/sub and sorted sets. If you're not using those Redis-specific data structures, you probably don't need Redis.

## Migration Guide: Redis to Solid Cache

### Pre-Migration Assessment

Evaluate your current Redis usage before migrating:

```ruby
# Redis usage audit script
class RedisCacheAudit
  def self.comprehensive_analysis
    {
      cache_hit_rate: measure_hit_rate,
      cache_size: measure_cache_size,
      access_patterns: analyze_access_patterns,
      key_expiration: analyze_ttl_patterns,
      read_write_ratio: measure_operations,
      memory_usage: redis_memory_stats,
      migration_readiness: assess_migration_complexity
    }
  end

  private

  def self.measure_hit_rate
    info = Redis.new(url: ENV["REDIS_URL"]).info('stats')
    hits = info['keyspace_hits'].to_f
    misses = info['keyspace_misses'].to_f
    (hits / (hits + misses) * 100).round(2)
  end

  def self.measure_cache_size
    Redis.new(url: ENV["REDIS_URL"]).dbsize
  end

  def self.analyze_access_patterns
    # Sample cache keys to understand patterns using SCAN (non-blocking)
    sample_keys = []
    cursor = "0"
    loop do
      cursor, batch = Redis.new(url: ENV["REDIS_URL"]).scan(cursor, match: "*", count: 100)
      sample_keys.concat(batch)
      break if cursor == "0" || sample_keys.size >= 100
    end

    {
      page_caching: sample_keys.count { |k| k.start_with?('views/') },
      fragment_caching: sample_keys.count { |k| k.start_with?('fragments/') },
      query_caching: sample_keys.count { |k| k.include?('query') },
      custom_caching: sample_keys.count { |k| !k.match(/views|fragments|query/) }
    }
  end

  def self.analyze_ttl_patterns
    # Use SCAN instead of KEYS to avoid blocking production Redis
    keys = []
    cursor = "0"
    loop do
      cursor, batch = Redis.new(url: ENV["REDIS_URL"]).scan(cursor, match: "*", count: 1000)
      keys.concat(batch)
      break if cursor == "0" || keys.size >= 1000
    end

    ttls = keys.map { |k| Redis.new(url: ENV["REDIS_URL"]).ttl(k) }
    {
      average_ttl: ttls.sum / ttls.size,
      max_ttl: ttls.max,
      no_expiry: ttls.count(-1)
    }
  end

  def self.measure_operations
    info = Redis.new(url: ENV["REDIS_URL"]).info('stats')
    {
      total_commands: info['total_commands_processed'],
      reads: info['keyspace_hits'] + info['keyspace_misses'],
      writes: estimate_writes(info),
      ratio: calculate_ratio(info)
    }
  end

  def self.redis_memory_stats
    info = Redis.new(url: ENV["REDIS_URL"]).info('memory')
    {
      used_memory_human: info['used_memory_human'],
      used_memory_peak_human: info['used_memory_peak_human'],
      fragmentation_ratio: info['mem_fragmentation_ratio']
    }
  end

  def self.assess_migration_complexity
    # Determine migration difficulty
    complexity_factors = {
      redis_specific_features: uses_redis_specific_features?,
      high_frequency_access: cache_hit_rate > 80,
      large_cache_size: measure_cache_size > 100_000,
      complex_ttl_patterns: complex_expiration_logic?
    }

    complexity_score = complexity_factors.values.count(true)

    case complexity_score
    when 0..1 then :easy_migration
    when 2 then :moderate_migration
    else :complex_migration_consider_hybrid
    end
  end

  def self.uses_redis_specific_features?
    # Check for sorted sets, pub/sub, etc. using SCAN (non-blocking)
    redis = Redis.new(url: ENV["REDIS_URL"])
    cursor = "0"

    loop do
      cursor, keys = redis.scan(cursor, count: 100)

      keys.each do |key|
        return true if redis.type(key) != 'string'
      end

      break if cursor == "0"
    end

    false
  end
end
```

### Step-by-Step Migration Process

#### Phase 1: Setup Solid Cache Infrastructure

```ruby
# 1. Add solid_cache to Gemfile
# Gemfile
gem 'solid_cache'

# 2. Install and configure
bundle install
rails solid_cache:install:migrations
rails db:migrate

# 3. Configure cache store
# config/environments/production.rb
Rails.application.configure do
  # Basic configuration
  config.cache_store = :solid_cache_store

  # Advanced configuration with separate database
  config.cache_store = :solid_cache_store, {
    database: :cache,                    # Use separate cache database
    connects_to: { writing: :cache },    # Database connection
    expires_in: 2.weeks,                 # Default TTL
    size_estimate: 500.megabytes,        # Size hint for optimization
    namespace: "myapp_cache"             # Namespace for multi-tenancy
  }
end
```

#### Phase 2: Database Optimization for Caching

```ruby
# Create optimized indexes for cache performance
class OptimizeSolidCachePerformance < ActiveRecord::Migration[7.1]
  def change
    # 1. Composite index for key lookups with expiration
    add_index :solid_cache_entries,
              [:key, :expires_at],
              name: 'index_solid_cache_on_key_expires',
              where: 'expires_at IS NULL OR expires_at > NOW()'

    # 2. Index for cleanup queries
    add_index :solid_cache_entries,
              :expires_at,
              where: 'expires_at IS NOT NULL',
              name: 'index_solid_cache_cleanup'

    # 3. Partial index for active entries
    add_index :solid_cache_entries,
              [:key_hash, :byte_size],
              where: 'expires_at IS NULL OR expires_at > NOW()',
              name: 'index_solid_cache_active_entries'
  end
end

# Configure separate cache database (optional but recommended)
# config/database.yml
production:
  primary:
    database: myapp_production
    # ... primary database config

  cache:
    database: myapp_cache_production
    migrations_paths: db/cache_migrate
    # Use faster disk for cache database
    # Consider using SSD or NVMe storage
```

#### Phase 3: Parallel Operation (Blue-Green Migration)

```ruby
# Run both caches simultaneously to validate
class DualCacheStrategy
  def initialize
    @solid_cache = ActiveSupport::Cache::SolidCacheStore.new
    @redis_cache = ActiveSupport::Cache::RedisCacheStore.new(url: ENV['REDIS_URL'])
  end

  def read(key, options = {})
    # Read from both, compare results
    solid_result = @solid_cache.read(key, options)
    redis_result = @redis_cache.read(key, options)

    # Log discrepancies for investigation
    if solid_result != redis_result
      Rails.logger.warn(
        "Cache mismatch for key #{key}: " \
        "Solid=#{solid_result.inspect}, Redis=#{redis_result.inspect}"
      )
    end

    # Return Solid Cache result (new primary)
    solid_result
  end

  def write(key, value, options = {})
    # Write to both caches during migration
    @solid_cache.write(key, value, options)
    @redis_cache.write(key, value, options)
  end

  def delete(key, options = {})
    @solid_cache.delete(key, options)
    @redis_cache.delete(key, options)
  end

  def fetch(key, options = {}, &block)
    # Fetch from Solid Cache, populate both
    @solid_cache.fetch(key, options) do
      value = block.call
      @redis_cache.write(key, value, options)
      value
    end
  end
end

# Use dual cache strategy
# config/environments/production.rb
Rails.application.configure do
  config.cache_store = :memory_store, {
    # Temporarily use custom dual-cache strategy
    # Remove after validation period
  }
end
```

#### Phase 4: Cache Warming Strategy

```ruby
# Warm up Solid Cache from Redis before cutover
class CacheWarmer
  def self.warm_from_redis
    redis = Redis.new(url: ENV['REDIS_URL'])
    solid_cache = Rails.cache

    # Use SCAN instead of KEYS to avoid blocking Redis
    cursor = "0"
    total_keys = 0
    batch_count = 0

    puts "Starting cache warming with SCAN batching..."

    loop do
      cursor, keys = redis.scan(cursor, count: 1000)
      total_keys += keys.size

      unless keys.empty?
        ActiveRecord::Base.transaction do
          keys.each do |key|
            # Read from Redis
            value = redis.get(key)
            ttl = redis.ttl(key)

            next unless value

            # Write to Solid Cache with same TTL
            solid_cache.write(
              key,
              value,
              expires_in: ttl > 0 ? ttl.seconds : nil
            )
          end
        end

        batch_count += 1
        puts "Processed batch #{batch_count} (#{total_keys} keys total)"
      end

      break if cursor == "0"
    end

    puts "Cache warming complete! Warmed #{total_keys} entries."
  end

  def self.verify_warmup
    # Verify cache consistency using SCAN (non-blocking)
    redis = Redis.new(url: ENV['REDIS_URL'])
    solid_cache = Rails.cache

    # Use SCAN instead of KEYS to avoid blocking production Redis
    sample_keys = []
    cursor = "0"
    loop do
      cursor, batch = redis.scan(cursor, match: "*", count: 100)
      sample_keys.concat(batch)
      break if cursor == "0" || sample_keys.size >= 100
    end

    mismatches = 0

    sample_keys.each do |key|
      redis_value = redis.get(key)
      solid_value = solid_cache.read(key)

      if redis_value != solid_value
        mismatches += 1
        puts "Mismatch for key #{key}"
      end
    end

    puts "Verification complete: #{mismatches} mismatches out of #{sample_keys.size}"
  end
end

# Run cache warming
rails runner "CacheWarmer.warm_from_redis"
rails runner "CacheWarmer.verify_warmup"
```

#### Phase 5: Cutover and Redis Decommission

```bash
# 1. Final cache sync
rails runner "CacheWarmer.warm_from_redis"

# 2. Switch to Solid Cache in production
# config/environments/production.rb
config.cache_store = :solid_cache_store

# 3. Deploy application (see our Kamal guide: /blog/kamal-integration-in-rails-8-by-default-ruby/)
bundle exec kamal deploy

# 4. Monitor cache performance
rails runner "CachePerformanceMonitor.start_monitoring"

# 5. After successful cutover (1-2 weeks), decommission Redis
# Remove Redis configuration
# Cancel Redis hosting
# Update Procfile to remove Redis dependencies
```

### Migration Gotchas and Solutions

#### Common Issues and Resolutions:

1. **Database Connection Pool Exhaustion**
```ruby
# Problem: Cache reads consume database connections
# Solution: Increase connection pool size

# config/database.yml
production:
  primary:
    pool: <%= ENV.fetch("RAILS_MAX_THREADS", 5).to_i + 10 %>

  cache:
    # Dedicated pool for cache operations
    pool: <%= ENV.fetch("CACHE_POOL_SIZE", 20).to_i %>
```

2. **Cache Key Compatibility**
```ruby
# Problem: Redis key formats may differ from Solid Cache
# Solution: Normalize cache keys

class CacheKeyNormalizer
  def self.normalize(key)
    # Ensure consistent key format
    key.to_s.gsub(/[^a-zA-Z0-9_\-:]/, '_')
  end
end

# Wrapper around Rails.cache
module CacheHelper
  def cache_write(key, value, options = {})
    Rails.cache.write(
      CacheKeyNormalizer.normalize(key),
      value,
      options
    )
  end

  def cache_read(key, options = {})
    Rails.cache.read(
      CacheKeyNormalizer.normalize(key),
      options
    )
  end
end
```

3. **Performance Regression Detection** — subscribe to `ActiveSupport::Notifications` for `cache_read.active_support` and `cache_write.active_support` events. Log anything over 50ms. The built-in instrumentation is enough for most apps.

## Performance Optimization Strategies

### Database-Level Optimizations

```ruby
# 1. Table Partitioning for Large Caches
class PartitionSolidCacheTable < ActiveRecord::Migration[7.1]
  def up
    # Partition by month for automatic cleanup
    execute <<-SQL
      CREATE TABLE solid_cache_entries_partitioned (
        LIKE solid_cache_entries INCLUDING ALL
      ) PARTITION BY RANGE (created_at);

      -- Create monthly partitions
      CREATE TABLE solid_cache_entries_2025_01
        PARTITION OF solid_cache_entries_partitioned
        FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

      CREATE TABLE solid_cache_entries_2025_02
        PARTITION OF solid_cache_entries_partitioned
        FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

      -- ... additional partitions
    SQL
  end
end

# 2. Vacuum and Analyze Scheduling
# config/initializers/cache_maintenance.rb
if Rails.env.production?
  # Schedule regular maintenance
  Rails.application.config.after_initialize do
    Thread.new do
      loop do
        sleep 6.hours

        # Vacuum cache tables to reclaim space
        ActiveRecord::Base.connection.execute(
          'VACUUM ANALYZE solid_cache_entries'
        )

        Rails.logger.info 'Solid Cache maintenance completed'
      end
    end
  end
end

# 3. Read Replicas for Cache Reads
class ApplicationRecord < ActiveRecord::Base
  # Use read replicas for cache reads
  connects_to shards: {
    default: { writing: :primary, reading: :primary_replica },
    cache: { writing: :cache, reading: :cache_replica }
  }
end

# Configure cache to use read replica
Rails.application.configure do
  config.cache_store = :solid_cache_store, {
    database: :cache,
    connects_to: {
      writing: :cache,
      reading: :cache_replica  # Read from replica for scalability
    }
  }
end
```

### Application-Level Optimizations

```ruby
# 1. Multi-Read Optimization
class OptimizedCaching
  # Batch cache reads to reduce database queries
  def fetch_multiple(keys)
    Rails.cache.read_multi(*keys) do |key|
      # Only expensive operations for missing keys
      yield key
    end
  end

  # Example usage
  def load_user_data(user_ids)
    cache_keys = user_ids.map { |id| "user:#{id}:profile" }

    fetch_multiple(cache_keys) do |key|
      user_id = key.split(':')[1]
      User.find(user_id).profile_data
    end
  end
end

# 2. Cache Layering (Hybrid Approach)
class LayeredCache
  def initialize
    @memory_cache = ActiveSupport::Cache::MemoryStore.new(size: 64.megabytes)
    @solid_cache = Rails.cache
  end

  def fetch(key, options = {})
    # Check memory cache first (fastest)
    @memory_cache.fetch(key, expires_in: 5.minutes) do
      # Fall back to database cache (slower but persistent)
      @solid_cache.fetch(key, options) do
        yield
      end
    end
  end
end

# Use for high-frequency reads
class ProductCatalog
  def self.cached_products
    layered_cache = LayeredCache.new
    layered_cache.fetch('products:catalog', expires_in: 1.hour) do
      Product.active.includes(:images).to_a
    end
  end
end

# 3. Intelligent Cache Warming
class CacheWarmer
  # Warm cache during off-peak hours
  def self.warm_critical_paths
    # Identify most-accessed cache keys
    critical_keys = [
      'homepage:en',
      'products:featured',
      'navigation:menu'
    ]

    critical_keys.each do |key|
      Rails.cache.fetch(key, force: true) do
        # Re-generate cached content
        send("generate_#{key.split(':').first}")
      end
    end
  end

  # Schedule via cron or Solid Queue recurring job:
  # every 1.day, at: "3:00 am" do
  #   runner "CacheWarmer.warm_critical_paths"
  # end
end
```

## Cost Analysis: Solid Cache vs Redis

### Total Cost of Ownership Comparison

#### Scenario: Mid-Size SaaS Application
- 50,000 active users
- 1M cache reads/day
- 100K cache writes/day
- Cache size: 2GB average

#### Redis Total Costs (Annual):
```yaml
Infrastructure:
  Redis Hosting (AWS ElastiCache): $350/month × 12 = $4,200
  Redis Backups (RDB + AOF): $75/month × 12 = $900
  Monitoring (DataDog/New Relic): $50/month × 12 = $600

Operational:
  DevOps maintenance: 8 hours/month × $100/hour × 12 = $9,600
  Incident response: 4 hours/quarter × $150/hour × 4 = $2,400
  Capacity planning: 2 hours/quarter × $100/hour × 4 = $800

Total Annual Cost: $18,500
```

#### Solid Cache Total Costs (Annual):
```yaml
Infrastructure:
  Additional DB storage (2GB): $10/month × 12 = $120
  Database backup (incremental): $5/month × 12 = $60

Operational:
  DevOps maintenance: 0.5 hours/month × $100/hour × 12 = $600
  Incident response: Minimal (included in DB management)
  Capacity planning: Minimal (scales with database)

Total Annual Cost: $780

Annual Savings: $17,720 (95.8% reduction)
```

**Note:** These cost estimates are for the specified mid-size SaaS scenario (50K users, 1M cache reads/day). Actual costs depend on hosting provider, data transfer, storage rates, and labor rates in your region. Benchmark with your specific infrastructure and regional pricing.

### ROI Calculation for Migration

```ruby
# Migration cost calculator
class MigrationROI
  def self.calculate(app_profile)
    {
      migration_costs: estimate_migration_costs(app_profile),
      annual_savings: calculate_annual_savings(app_profile),
      payback_period: calculate_payback_period(app_profile),
      five_year_roi: calculate_five_year_roi(app_profile)
    }
  end

  private

  def self.estimate_migration_costs(profile)
    {
      development_time: profile[:complexity] * 40, # hours
      testing_time: 20, # hours
      deployment_time: 8, # hours
      total_cost: (profile[:complexity] * 40 + 28) * profile[:hourly_rate]
    }
  end

  def self.calculate_annual_savings(profile)
    redis_annual = profile[:redis_monthly_cost] * 12
    solid_cache_annual = profile[:db_additional_cost] * 12
    redis_annual - solid_cache_annual
  end

  def self.calculate_payback_period(profile)
    migration_cost = estimate_migration_costs(profile)[:total_cost]
    monthly_savings = calculate_annual_savings(profile) / 12.0
    (migration_cost / monthly_savings).ceil
  end

  def self.calculate_five_year_roi(profile)
    migration_cost = estimate_migration_costs(profile)[:total_cost]
    total_savings = calculate_annual_savings(profile) * 5
    ((total_savings - migration_cost) / migration_cost * 100).round(2)
  end
end

# Example calculation
app_profile = {
  complexity: 3, # 1=simple, 5=complex
  hourly_rate: 100,
  redis_monthly_cost: 350,
  db_additional_cost: 20
}

roi = MigrationROI.calculate(app_profile)
# => {
#   migration_costs: { total_cost: 14800 },
#   annual_savings: 3960,
#   payback_period: 4, # months
#   five_year_roi: 33.78 # percent
# }
```

## Monitoring Solid Cache

Track cache performance with ActiveSupport::Notifications — it's already built in:

```ruby
ActiveSupport::Notifications.subscribe('cache_read.active_support') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  StatsD.timing("cache.read", event.duration)
  StatsD.increment(event.payload[:hit] ? "cache.hit" : "cache.miss")
end
```

Three numbers to watch weekly: hit rate (target 85%+), P95 read latency (should stay under 5ms for PostgreSQL), and `solid_cache_entries` table size. If any drift, investigate before adding more cached views.

## When to Keep Redis (Hybrid Approach)

### Strategic Hybrid Architecture

Some applications benefit from using both Solid Cache and Redis:

```ruby
# Intelligent cache routing
class HybridCacheStrategy
  def initialize
    @solid_cache = Rails.cache # Solid Cache
    @redis_cache = Redis.new(url: ENV['REDIS_URL'])
  end

  def fetch(key, options = {})
    # Route based on access patterns
    if high_frequency_key?(key)
      # Use Redis for high-frequency access
      @redis_cache.get(key) || begin
        value = yield
        @redis_cache.setex(key, options[:expires_in] || 3600, value)
        value
      end
    else
      # Use Solid Cache for standard access
      @solid_cache.fetch(key, options) { yield }
    end
  end

  private

  def high_frequency_key?(key)
    # Keys accessed >100 times/minute use Redis
    key.match?(/rate_limit|session|realtime/)
  end
end

# Use cases for Redis retention
class RedisOptimalUseCases
  # 1. Rate limiting (high-frequency reads/writes)
  def rate_limit_check(user_id, endpoint)
    key = "rate_limit:#{user_id}:#{endpoint}"
    count = @redis.incr(key)
    @redis.expire(key, 60) if count == 1
    count <= 100 # Allow 100 requests/minute
  end

  # 2. Session storage (sub-millisecond access)
  def session_storage
    # Use Redis for session store
    config.session_store :redis_store, {
      servers: [ENV['REDIS_URL']],
      expire_after: 90.minutes
    }
  end

  # 3. Real-time features (pub/sub)
  def realtime_notifications
    @redis.publish('notifications', {
      user_id: user.id,
      message: 'New notification'
    }.to_json)
  end
end
```

## Real-World Case Studies

### Case Study 1: Content Management Platform

A medium-sized content platform was running a 5GB Redis cache that cost $450/month. Their team migrated the bulk of their caching to Solid Cache and kept Redis only for real-time features -- about 10% of the original usage. After the switch, their infrastructure bill dropped to $125/month (a 72% reduction). They maintained an 85% cache hit rate, and average response times went up by 12ms -- a tradeoff they accepted because their users never noticed the difference and their ops team stopped getting paged about Redis memory pressure.

We've covered [Rails performance optimization strategies](/blog/best-practices-for-optimizing-ruby-on-rails-performance/) in depth if you're looking at the broader picture beyond caching.

### Case Study 2: E-commerce Application (Memcached, not Redis)

This one wasn't a Redis migration -- it was Memcached -- but the pattern applies to any external cache service. An online retail platform had been fighting cache invalidation race conditions in their Memcached cluster for months. A customer would place an order, the inventory cache wouldn't invalidate in time, and another customer would buy the same item. Their team switched to Solid Cache specifically for the transactional consistency: cache writes and deletes now live inside the same database transaction as the business logic, so race conditions disappeared entirely. They saved $320/month on Memcached hosting, simplified their deploys (no more Memcached cluster to coordinate), and their developers spent less time debugging stale cache issues because they could trace cache state in the same database queries they already knew.

## When NOT to Use Solid Cache

Solid Cache isn't the right call for every app. Be specific about when to keep Redis:

- **You're doing 10K+ cache reads/sec.** Solid Cache adds 3-8ms per read vs Redis's 0.5-2ms. At high volume, that latency compounds into real response time degradation.
- **You need sub-millisecond latency for rate limiting or session storage.** These are hot-path operations where every millisecond matters. Redis is purpose-built for this.
- **You rely on Redis data structures -- sorted sets, pub/sub, HyperLogLog.** Solid Cache is key-value only. If you're using Redis as more than a cache, you can't drop it entirely.
- **Your database is already at capacity.** Adding cache reads to a maxed-out PostgreSQL instance will make everything slower, not just cache hits.
- **You're running a real-time app with presence tracking or live notifications.** Redis pub/sub has no Solid Cache equivalent.

The hybrid approach (Solid Cache for general caching, Redis for hot-path operations) is often the right middle ground. Don't treat this as all-or-nothing.

## What to do next

If you're not running 10K+ reads/sec, Solid Cache is the obvious choice. Start with the audit script to understand your current Redis usage patterns, then run the dual-cache strategy in production for a week before cutting over.

Solid Cache pairs well with the rest of the Rails 8 infrastructure stack. If you're also migrating background jobs, our [Solid Queue migration guide](/blog/rails-8-solid-queue-migration-guide/) covers that process. For the asset pipeline side, see [Propshaft vs Sprockets migration](/blog/propshaft-vs-sprockets-rails-8-asset-pipeline-migration/). For teams modernizing their full deployment pipeline, see our guides on [Kamal deployment](/blog/deploying-ruby-on-rails-applications-with-kamal-devops-docker/) and [Rails 8 Docker production setup](/blog/rails-8-docker-deployment-production-guide/).

And if you're optimizing beyond caching, our post on [Rails performance patterns with Hotwire](/blog/hotwire-turbo-8-performance-patterns-real-time-rails/) covers the frontend side of the equation.

---

*Performance benchmarks and cost estimates based on Rails 8 beta and PostgreSQL 14+. Actual results vary by application workload, database configuration, hosting provider, regional pricing, and infrastructure. Cost estimates reflect specific scenarios described in each section. Always benchmark with production-like data and obtain real pricing quotes before making caching decisions.*

## Resources and Further Reading

- [Solid Cache Official Repository](https://github.com/rails/solid_cache)
- [Rails 8 Release Notes - Caching](https://guides.rubyonrails.org/8_0_release_notes.html#solid-cache)
- [Database-Backed Caching Patterns](https://martinfowler.com/articles/patterns-of-distributed-systems/cache.html)
- [PostgreSQL Performance Tuning for Caching](https://wiki.postgresql.org/wiki/Performance_Optimization)
