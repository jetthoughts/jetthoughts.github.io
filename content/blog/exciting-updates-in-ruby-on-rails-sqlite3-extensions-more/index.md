---
dev_to_id: 2175960
dev_to_url: https://dev.to/jetthoughts/exciting-updates-in-ruby-on-rails-sqlite3-extensions-and-more-3d75
title: 'Exciting Updates in Ruby on Rails: SQLite3 Extensions and More'
description: Explore the latest updates in Ruby on Rails, including support for SQLite3 extensions, a new tutorial, and enhancements to database management.
created_at: '2024-12-26T13:13:47Z'
edited_at:
draft: false
tags: []
canonical_url: https://dev.to/jetthoughts/exciting-updates-in-ruby-on-rails-sqlite3-extensions-and-more-3d75
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/exciting-updates-in-ruby-on-rails-sqlite3-extensions-more/cover.jpeg
slug: exciting-updates-in-ruby-on-rails-sqlite3-extensions-more
metatags:
  image: cover.jpeg
---
This week in Ruby on Rails, significant updates have been announced, including support for loading SQLite3 extensions and enhancements to the framework's functionality. These changes aim to improve the developer experience and streamline application development.

### Key Takeaways

*   Introduction of a new Getting Started tutorial for building e-commerce apps.
*   1Password joins the Rails Foundation as a Core member.
*   Support for loading SQLite3 extensions via configuration.
*   New shard selector support for database connection switching.
*   Updates to Action Controller guides.
*   Improvements in Redis connection handling.
*   Changes to preload link tags for CSP compliance.
*   New suffix convention for parallel test databases.
*   Reset relations after bulk insert/upsert operations.

### New Getting Started Tutorial

A new pull request has been submitted for community review, introducing a comprehensive Getting Started tutorial. This tutorial is designed to guide developers through building an e-commerce application using all the features of Rails 8, from initial setup to deployment. Feedback from the community is encouraged to refine this flagship resource.

### Rails Foundation Welcomes 1Password

In a move to strengthen the Rails community, the Rails Foundation has welcomed 1Password as a Core member. This expansion of Core membership is expected to enhance long-term growth and sustainability, providing more support for developers and users of the Rails framework.

### Support for Loading SQLite3 Extensions

The latest version of the sqlite3 gem (v2.4.0) introduces a feature that allows loading extensions through a keyword argument in the Database.new method. This enhancement enables developers to configure extensions directly in the config/database.yml file, using either filesystem paths or module names that respond to the to\_path method. This flexibility simplifies the integration of SQLite3 extensions into Rails applications.

### Shard Selector Support

A new configuration option has been added to the active\_record.shard\_selector, allowing applications to specify the abstract connection class for shard selection. By default, this class is ActiveRecord::Base, but developers can now customize it to suit their application's needs. For example, the following configuration allows switching shards using a custom class:

    config.active_record.shard_selector = { class_name: "AnimalsRecord" }
    

### Action Controller Updates

The Action Controller Overview Rails Guide has been updated, and a new guide titled "Action Controller Advanced Topics" has been created. These resources are available for preview on the edge guides, providing developers with enhanced documentation and insights into advanced features of Action Controller.

### Redis Connection Handling

Developers are advised to avoid wrapping Redis in a ConnectionPool when using ActiveSupport::Cache::RedisCacheStore if the :redis option is already a ConnectionPool. This change aims to streamline Redis connection management and prevent potential issues.

### CSP Compliance for Preload Links

To ensure compliance with Content Security Policy (CSP), preload link tags now require the addition of a CSP nonce if the policy is configured with one. This adjustment is crucial for ensuring that browsers can load these resources securely.

### Parallel Test Database Suffixes

A new convention for suffixes in parallel test databases has been introduced, replacing the previous use of -N. This change addresses compatibility issues with relational database management systems (RDBMS) that do not support dashes in database names, enhancing the testing experience.

### Bulk Insert/Upsert Behavior

The behavior of bulk insert and upsert methods has been updated to call reset on a relation, aligning it with the existing behavior of the update\_all method. This change ensures consistency in how relations are managed after bulk operations.

With 29 contributors actively working on the Rails codebase this past week, the community continues to thrive and innovate, making Ruby on Rails a robust framework for developers.