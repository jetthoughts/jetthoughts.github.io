---
dev_to_id: 1144505
title: "How To Setup Default Values For Attributes In Ruby On Rails"
description: "Have you ever thought that setting default values for attributes in Ruby on Rails could be..."
created_at: "2022-07-19T06:01:04Z"
edited_at: "2022-10-03T13:55:41Z"
sync_date: "2024-05-24T15:34:23Z"
draft: false
tags: ["ruby", "programming", "tutorial", "beginners"]
canonical_url: "https://jtway.co/how-to-setup-default-values-for-attributes-in-ruby-on-rails-dd1d2ba38b82?source=friends_link&sk=4e07feac35fb0ee071003b191873d999"
slug: "how-setup-default-values-for-attributes-in-ruby-on-rails-programming"
---
_Have you ever thought that setting default values for attributes in Ruby on Rails could be a problem?_

Since attributes are uninitialized when a new model is created without any parameters, default values will be set according to the type of attribute.

This is a very good idea if we don't want to fill up the database with unnecessary information.

Ruby on Rails provides a lot of options to add default values, but not all of them are good.

Here is a list of good examples of how you should add default values:

- Option 1: Set the default value directly in the database via migrations.
- Option 2: Use `after_initialize` callback.
- Option 3: Use `before_validate` callback. Set the default value in the model, but only if it is nil.

##Option 1: Set the default value directly in the database via migrations

In Ruby on Rails, you can set default values for attributes in the database by including them as part of your migration.

The syntax is `default: 'value'`.

This is useful if you want to define lots of attributes at once, and it's easy to see what the default value is at a glance when looking at your `db/schema.rb` file.

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, default: "First Last", null: false
    end
  end
end
```

##Option 2: Use `after_initialize` callback

There is `after_initialize` callback to help a developer to set default values,
especially if they are required to do some computation.

This callback is invoked after the model has been initiated and the developer could access default values before updating it.

For example, let's say we want to set a default name for our user in our app:

```ruby
class User < ApplicationRecord
  after_initialize :set_defaults

  def set_defaults
    name = "First Last"
  end
end
```

## Option 3: Use `before_validate` callback. Set the default value in the model, when it is missed

In Ruby on Rails, you can set default values for attributes in the model by using `before_validation`.

This is a great way to ensure that your models always have valid attributes, and it's really simple to do:

```ruby
class User < ApplicationRecord
  before_validation :set_defaults
  
  private

  def set_defaults
    name = "First Last" if name.blank?
  end
end
```

## Option 4: Through Rails Attributes API 

And last most ideal way is to use [Rails Attributes API](https://api.rubyonrails.org/classes/ActiveRecord/Attributes/ClassMethods.html#method-i-attribute). You can adds default value in the model like `attribute :my_string, :string, default: "new default"`

```ruby
# db/schema.rb
create_table :store_listings, force: true do |t|
  t.string :my_string, default: "original default"
end

StoreListing.new.my_string # => "original default"

# app/models/store_listing.rb
class StoreListing < ActiveRecord::Base
  attribute :my_string, :string, default: "new default"
end

StoreListing.new.my_string # => "new default"

class Product < ActiveRecord::Base
  attribute :my_default_proc, :datetime, default: -> { Time.now }
end

Product.new.my_default_proc # => 2015-05-30 11:04:48 -0600
sleep 1
Product.new.my_default_proc # => 2015-05-30 11:04:49 -0600
```

And that's it!

##It is worth mentioning:
- Do not override with default values original changes, which breaks the ActiveRecord contract:
```ruby
def set_defaults
  name = "First Last"
end
```
(This unexpected behavior will provide confusion for developers)

- Do not set defaults after validations. Prefer to add default values only before validation, to make sure that we support consistency
```ruby
before_save :set_defaults

private

def set_defaults
  name = nil if name.blank?
end
```
(This will add invalid data in the DB or raise Runtime Error)

---

Paul Keen is a Chief Technology Officer at JetThoughts. Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
> If you enjoyed this story, we recommend reading our latest tech stories and trending [tech stories](https://jtway.co/trending).