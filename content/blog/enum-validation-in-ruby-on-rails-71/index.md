---
dev_to_id: 1765310
title: Enum validation in Ruby on Rails 7.1
description: The latest version of Rails, 7.1, introduces the ability to validate enums, enhancing data integrity...
created_at: '2024-02-19T09:28:13Z'
edited_at: '2024-07-03T12:20:32Z'
draft: false
tags:
- ruby
- rails
- programming
- development
canonical_url: https://jtway.co/enum-validation-in-ruby-on-rails-7-1-285762a64582
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/enum-validation-in-ruby-on-rails-71/cover.png
slug: enum-validation-in-ruby-on-rails-71
metatags:
  image: cover.png
---
The latest version of Rails, 7.1, introduces the ability to validate enums, enhancing data integrity and error handling in Rails models. Enums in Rails allow defining a set of permissible values for an attribute. Prior to Rails 7.1, assigning an invalid enum value would raise an `ArgumentError`, necessitating manual validation checks. The updated feature in Rails 7.1 streamlines this process by enabling built-in enum validation options within ActiveRecord objects.

## Before Rails 7.1

```ruby
class Project < ApplicationRecord
  enum status: [:active, :inactive, :archived] 
end

project = Project.find_by(name: "JT Project")

project.status = :new
=> `assert_valid_value': 'new' is not a valid status (ArgumentError)

```
To avoid ArgumentError exception, programmers used this trick:

```ruby
project = Project.find_by(name: "JT Project")
status_value = :new

if Project.statuses[status_value].present?
  project.status = status_value
else
  # raise more consistent error than ArgumentError
end
```

## After Rails 7.1

```ruby
class Project < ApplicationRecord
  enum status: [:active, :inactive, :draft], validate: true 
end

project = Project.find_by(name: "JT Project")

project.status = :new # Now in this place we do not receive the error ArgumentError
project.valid?
=> false
```
Pay attention on `validate: true` in enum declaration.

We also can send additional rules to validation. For example: 

```ruby
validate: { allow_nil: true }
```

By leveraging the new enum validation feature in Rails 7.1, developers can ensure the integrity of enum attributes, streamline validation processes, and enhance the overall robustness of Rails applications.