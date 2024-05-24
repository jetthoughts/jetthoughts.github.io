---
dev_to_id: 1198201
title: "How to avoid callbacks using services."
description: "Often programmers abuse callbacks, not fully understanding that in the end their code will be..."
created_at: "2022-09-20T13:23:18Z"
edited_at: "2024-05-10T19:39:31Z"
sync_date: "2024-05-24T11:41:11Z"
draft: false
tags: ["rails", "refactoring", "callback", "ruby"]
canonical_url: "https://jtway.co/how-to-avoid-callbacks-using-services-ace238dd44ec"
slug: "how-avoid-callbacks-using-services-rails-refactoring"
---

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/lsgjg0p19920ehuu6mz4.png)

Often programmers abuse callbacks, not fully understanding that in the end their code will be confusing and non-obvious. There are several ways to avoid using callbacks. Today I will tell you how to do this using services.

Lets see on a code:

```ruby
class User < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User created!"
    else   
      render :new, error: 'Failed to create user!'
    end
  end
end
class User < ApplicationRecord
  before_create :populate_serial_number
  private
  def populate_serial_number
    self.serial_number ||= SecureRandom.uuid
  end
end
```
What is the problem with this code? We get a non-obvious (magical) action. We do not pass any data about the serial number in the parameters, and we do not explicitly set this value anywhere. This happens automatically with a callback.

Let’s implement the same thing but using a service.

```ruby
class CreateUser
  def self.call(params)
    @user = User.new(params)
    
    populate_serial_number(@user)
    # Other actions for the user
    
    user.save!
  end
  def self.populate_serial_number(user)
    user.serial_number ||= SecureRandom.uuid
  end
end
class User < ApplicationRecord
end
class User < ApplicationController
  def create
    @user = CreateUser.call(user_params)
    if @user
      redirect_to root_path, notice: "User created!"
    else   
      render :new, error: 'Failed to create user!'
    end
  end
  def user_params
    ...
  end
end
```
What advantages does this approach give us?

- Suppose we have users can be created from the Admin panel and through the API. Depending on the method of creation, we may have a different set of actions performed with the user. It is very convenient to make two separate services for creating a user. For example: Admin::CreateUser and Api::CreateUser
- Such services are easy to test.
- They are easy to expand.
- The code becomes much clearer and more predictable.
