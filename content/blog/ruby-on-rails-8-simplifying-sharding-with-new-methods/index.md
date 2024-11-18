---
dev_to_id: 2086267
dev_to_url: https://dev.to/jetthoughts/ruby-on-rails-8-simplifying-sharding-with-new-methods-48m9
title: 'Ruby on Rails 8: Simplifying Sharding with New Methods'
description: Ruby on Rails 8 brings helpful updates for working with sharded databases. The new methods...
created_at: '2024-11-08T08:57:16Z'
edited_at: '2024-11-25T15:42:04Z'
draft: false
tags:
- ruby
- rails
- webdev
- tutorial
canonical_url: https://jetthoughts.com/blog/ruby-on-rails-8-simplifying-sharding-with-new-methods/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/ruby-on-rails-8-simplifying-sharding-with-new-methods/cover.png
slug: ruby-on-rails-8-simplifying-sharding-with-new-methods
metatags:
  image: cover.png
---
Ruby on Rails 8 brings helpful updates for working with sharded databases. The new methods `.shard_keys`, `.sharded?`, and `.connected_to_all_shards` make it easier to manage multiple shards. If you handle sharded data, these tools can streamline your workflow.

## How to Use the New Sharding Methods

### Set Up Your Sharded Base Class

Begin by defining an abstract class that connects to your shards:

```ruby
class ShardedBase < ActiveRecord::Base
  self.abstract_class = true

  connects_to shards: {
    shard_one: { writing: :shard_one },
    shard_two: { writing: :shard_two }
  }
end
```

Here, `ShardedBase` connects to two shards: `:shard_one` and `:shard_two`.

### Create a Sharded Model

Inherit from `ShardedBase` to create models that use these shards:

```ruby
class ShardedModel < ShardedBase
end
```

### Use the New Methods

- **Get Shard Keys**

  Retrieve the list of shard keys:

  ```ruby
  ShardedModel.shard_keys
  # => [:shard_one, :shard_two]
  ```

- **Check if a Model is Sharded**

  Determine if your model uses sharding:

  ```ruby
  ShardedModel.sharded?
  # => true
  ```

- **Connect to All Shards**

  Run code across all shards:

  ```ruby
  ShardedBase.connected_to_all_shards do
    ShardedModel.current_shard
    # Perform actions on all shards
  end
  ```

## Practical Use Cases

### 1. Running Migrations on All Shards

   Apply migrations or updates across every shard without manual switching:

   ```ruby
   ShardedBase.connected_to_all_shards do
     ActiveRecord::Migrator.migrate("db/migrate/")
   end
   ```

### 2. Data Aggregation Across Shards

   Collect and combine data from all shards:

   ```ruby
   total_users = 0

   ShardedBase.connected_to_all_shards do
     total_users += ShardedModel.count
   end

   puts "Total users across all shards: #{total_users}"
   ```

### 3. Conditional Logic Based on Sharding

   Adjust your code if the model is sharded or not:

   ```ruby
   if ShardedModel.sharded?
     # Logic for sharded environment
   else
     # Logic for single database
   end
   ```

### 4. Listing All Shards for Monitoring

   Generate a list of shards for health checks or monitoring:

   ```ruby
   ShardedModel.shard_keys.each do |shard|
     puts "Checking status of #{shard}"
     # Add monitoring logic here
   end
   ```

### 5. Parallel Processing on Shards

   Improve performance by processing shards in parallel:

   ```ruby
   threads = []

   ShardedModel.shard_keys.each do |shard|
     threads << Thread.new do
       ShardedBase.connected_to(shard: shard) do
         # Perform time-consuming task
       end
     end
   end

   threads.each(&:join)
   ```

## Why This Matters

Managing multiple database shards can be challenging. These new Rails methods reduce complexity:

- **`.shard_keys`** gives you quick access to all shard identifiers.
- **`.sharded?`** lets you write code that adapts if sharding is in use.
- **`.connected_to_all_shards`** allows batch operations across all shards effortlessly.

By using these tools, you save time and write cleaner code. Your applications become more scalable and maintainable.

Give these new methods a try to enhance how you work with sharded databases in Rails!