---
remote_url: https://dev.to/jetthoughts/new-in-rails-72-active-model-got-typeforattribute-1ig1
source: dev_to
remote_id: 1910828
dev_to_id: 1910828
dev_to_url: https://dev.to/jetthoughts/new-in-rails-72-active-model-got-typeforattribute-1ig1
title: 'type_for_attribute in Rails 7.2 Active Model: API Reference'
description: Rails 7.2 added type_for_attribute to Active Model. See the method signature, return type, and a working example for both Active Record and Active Model.
created_at: '2024-07-03T20:42:57Z'
date: 2024-07-03
edited_at: '2024-11-25T15:33:24Z'
draft: false
tags:
- rails
- changelog
canonical_url: https://jetthoughts.com/blog/new-in-rails-72-active-model-got-typeforattribute-changelog/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/new-in-rails-72-active-model-got-typeforattribute-changelog/cover.png
metatags:
  image: cover.png
slug: new-in-rails-72-active-model-got-typeforattribute-changelog
---

## Method signature

```ruby
ClassName.type_for_attribute(attribute_name) # => ActiveModel::Type::Value subclass
```

Rails 7.2 moved `type_for_attribute` from Active Record to Active Model. Any class that includes `ActiveModel::Attributes` now exposes the same type lookup that Active Record models have always had. The method returns the type object Rails uses internally to cast values, so you can ask "what is the declared type of `:age`?" without instantiating the model.

The change shipped in [Rails PR #51653](https://github.com/rails/rails/pull/51653) and is documented in the [Rails 7.2 release notes](https://guides.rubyonrails.org/7_2_release_notes.html).

![Image description](file_0.png)

## Active Model example

```ruby
class MyModel
  include ActiveModel::Attributes

  attribute :my_attribute, :integer
end

MyModel.type_for_attribute(:my_attribute)
# => #<ActiveModel::Type::Integer ...>

MyModel.type_for_attribute(:my_attribute).cast("42")
# => 42
```

The return value is an `ActiveModel::Type::Value` subclass - `Integer`, `String`, `Boolean`, `DateTime`, and so on - with `cast`, `serialize`, and `deserialize` methods.

## Active Record still works the same way

```ruby
class User < ApplicationRecord
end

User.type_for_attribute(:email)
# => #<ActiveModel::Type::String ...>
```

Active Record inherits the method through the same code path now, so the API is identical across both layers.

## Use case: validating form input by declared type

```ruby
class SignupForm
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :age, :integer

  def initialize(params)
    params.each do |key, value|
      type = self.class.type_for_attribute(key.to_sym)
      raise ArgumentError, "Unknown attribute: #{key}" if type.nil?

      public_send("#{key}=", type.cast(value))
    end
  end
end

form = SignupForm.new(email: "test@example.com", age: "42")
form.age # => 42 (cast from "42")
```

Before Rails 7.2 you had to maintain a parallel hash of attribute types or duplicate the Active Record helper. The method does one job: hand back the type object so you can cast or inspect it.

## Why it matters

If you build form objects, command objects, or any plain Ruby class that uses `ActiveModel::Attributes`, you get the same introspection Active Record models have. No more `attributes.fetch(:age).type` workarounds. No custom registries.

## Building Rails apps that ship?

We rescue Rails projects that other shops left in a broken state - upgrades, performance work, test coverage. If your team is stuck on an older Rails version or your app is bleeding money on N+1 queries, talk to us.

<a class="cta-link" href="https://jetthoughts.com/services/">Book a 30-minute Rails review</a>
