---
dev_to_id: 1852950
title: "Enum validation in Ruby on Rails 7.1"
description: "The latest version of Rails 7.1 introduces the ability to validate enums, enhancing data integrity..."
created_at: "2024-05-14T17:00:00Z"
edited_at: "2024-11-01T16:08:49Z"
draft: false
tags: ["ruby", "rails", "changelog", "development"]
canonical_url: "https://jetthoughts.com/blog/enum-validation-in-ruby-on-rails-71/"
cover_image: ""
slug: "enum-validation-in-ruby-on-rails-71"
---
![](https://cdn-images-1.medium.com/max/2852/1*JxBXDGJmdqyog3dCqDlDOw.png)

The latest version of Rails 7.1 introduces the ability to validate enums, enhancing data integrity and error handling in Rails models. Enums in Rails allow defining a set of permissible values for an attribute. Prior to Rails 7.1, assigning an invalid enum value would raise an ArgumentError, necessitating manual validation checks. The updated feature in Rails 7.1 streamlines this process by enabling built-in enum validation options within ActiveRecord objects.

### Before Rails 7.1

```ruby
    class Project < ApplicationRecord
      enum status: [:active, :inactive, :archived] 
    end
    
    project = Project.find_by(name: "JT Project")
    
    project.status = :new
    => `assert_valid_value': 'new' is not a valid status (ArgumentError)
```
To avoid ArgumentError exception programmers used this trick:
```ruby
    project = Project.find_by(name: "JT Project")
    status_value = :new
    
    if Project.statuses[status_value].present?
      project.status = status_value
    else
      # raise more consistent error than ArgumentError
    end
```
### After Rails 7.1
```ruby
    class Project < ApplicationRecord
      enum status: [:active, :inactive, :draft], validate: true 
    end
    
    project = Project.find_by(name: "JT Project")
    
    project.status = :new # Now in this place we do not receive the error ArgumentError
    project.valid?
    => false
```
Pay attention on validate: true in enum declaration.

We also can send additional rules to validation. For example: validate: { allow_nil: true }

By leveraging the [new enum validation feature in Rails 7.1](https://github.com/rails/rails/pull/49100), developers can ensure the integrity of enum attributes, streamline validation processes, and enhance the overall robustness of Rails applications.

**Paul Keen** is an Open-Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
