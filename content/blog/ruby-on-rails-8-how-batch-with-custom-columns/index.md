---
dev_to_id: 2086243
title: 'Ruby on Rails 8: How to Batch with Custom Columns'
description: 'Ruby on Rails 8 introduces a handy feature for developers handling large datasets: batching with...'
created_at: '2024-11-08T08:42:28Z'
edited_at: '2024-11-08T21:14:49Z'
draft: false
tags:
- rails
- ruby
- webdev
- tutorial
canonical_url: https://jetthoughts.com/blog/ruby-on-rails-8-how-batch-with-custom-columns/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/ruby-on-rails-8-how-batch-with-custom-columns/cover.png
slug: ruby-on-rails-8-how-batch-with-custom-columns
metatags:
  image: cover.png
---
Ruby on Rails 8 introduces a handy feature for developers handling large datasets: batching with custom columns. This upgrade lets you batch records by specific attributes, not just the primary key.

This feature can save time and boost performance if you work with multi-tenant systems, data migration, or advanced filtering.

## Quick Guide: Batching with Custom Columns

To start using custom columns for batching, specify them in the `cursor` option. Here’s a quick example:

```ruby
Product.in_batches(cursor: [:shop_id, :id]) do |relation|
  # process each batch of products by shop_id
end
```

This command tells Rails to process `Product` records in batches using both `shop_id` and `id` as the cursor. It’s ideal for scenarios where records are grouped by specific attributes like location, tenant, or priority.

## Common Use Cases

### 1. Multi-Tenant Data Processing

If you’re managing data by tenant (e.g., by `shop_id`), you can process each tenant’s data in its own batch, making operations cleaner and reducing potential conflicts.

   ```ruby
   Order.in_batches(cursor: [:tenant_id, :id]) do |batch|
     # Process orders per tenant
   end
   ```

### 2. Time-Based Archiving

Use batching by date and ID to archive older records while keeping recent ones available. This method reduces database load by archiving in chunks.

   ```ruby
   Event.in_batches(cursor: [:event_date, :id]) do |batch|
     # Archive events by date
   end
   ```

### 3. Custom Sorting for Tasks

Batching by custom criteria like priority and date lets you prioritize tasks while processing. 

   ```ruby
   Task.in_batches(cursor: [:priority, :created_at]) do |batch|
     # Process tasks by priority and date
   end
   ```

### 4. Inventory Management by Location

Batch inventory updates by location and product to manage stock at specific warehouses.

   ```ruby
   Inventory.in_batches(cursor: [:warehouse_id, :product_id]) do |batch|
     # Update inventory by warehouse
   end
   ```

### 5. Customer Segmentation for Campaigns

Group customers by region and signup date for segmented marketing. Batching by these attributes allows more focused engagement.

   ```ruby
   Customer.in_batches(cursor: [:region, :signup_date]) do |batch|
     # Target customers by region
   end
   ```

## Why This Matters

Rails’ new custom batching makes it easier to control data processing, especially for high-scale applications. Now, you can batch records based on how your data is structured, saving time and reducing complexity in your code.