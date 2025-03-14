---
remote_url: https://dev.to/jetthoughts/new-in-rails-72-active-model-got-typeforattribute-1ig1
source: dev_to
remote_id: 1910828
dev_to_id: 1910828
dev_to_url: https://dev.to/jetthoughts/new-in-rails-72-active-model-got-typeforattribute-1ig1
title: 'New in Rails 7.2: Active Model Got type_for_attribute'
description: What's New?   Ruby on Rails 7.2 brings a handy change. The type_for_attribute method is now...
created_at: '2024-07-03T20:42:57Z'
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
## What's New?

Ruby on Rails 7.2 brings a handy change. The `type_for_attribute` method is now in Active Model.

![Image description](file_0.png)

## What is type_for_attribute?

It's a method that simplifies type checking, relieving you from the burden of manual checks for both Active Record and Active Model.

## How it Works

Here is a simple example:

```ruby

class MyModel

  include ActiveModel::Attributes

  attribute :my_attribute, :integer

end

MyModel.type_for_attribute(:my_attribute) # => #<ActiveModel::Type::Integer ...>
```

## Real-Life Example

Think of a signup form. You need to check the types of inputs. Here is how you can use it:

```ruby
class SignupForm

  include ActiveModel::Attributes

  attribute :email, :string

  attribute :age, :integer

  def initialize(params)

    @params = params

    @params.each do |key, value|

      if self.class.type_for_attribute(key.to_sym)

        send("#{key}=", value)

      else

        raise "Unknown attribute type"

      end

    end

  end

end

form = SignupForm.new(email: "test@example.com", age: "twenty")

# raises "Unknown attribute type" if age is not an integer
```

## Before the Change

Before this update, you had to write custom code. You had to check types manually.

## After the Change

Now, `type_for_attribute` makes it easy and saves you valuable time. Just include `ActiveModel::Attributes`. It makes your code cleaner and your development process more efficient.

## Why It Matters

This change empowers you to catch errors, ensures data integrity, and is a small but powerful tool that puts you in control of your code.

## In Summary

Ruby on Rails 7.2 simplifies type checking. Use `type_for_attribute` with the Active Model. It's quick and efficient. This change is a great addition. Give it a try in your next project!