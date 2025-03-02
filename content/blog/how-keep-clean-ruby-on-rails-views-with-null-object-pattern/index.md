---
remote_url: https://dev.to/jetthoughts/how-to-keep-clean-ruby-on-rails-views-with-the-null-object-pattern-9be
source: dev_to
remote_id: 1375276
dev_to_id: 1375276
dev_to_url: https://dev.to/jetthoughts/how-to-keep-clean-ruby-on-rails-views-with-the-null-object-pattern-9be
title: How to keep clean Ruby on Rails views with the Null Object pattern
description: One of the most common errors developers encounter is NoMethodError. It occurs when code is...
created_at: '2023-02-22T12:43:10Z'
edited_at: '2024-11-25T15:40:10Z'
draft: false
tags:
- ruby
- rails
- webdev
canonical_url: https://jetthoughts.com/blog/how-keep-clean-ruby-on-rails-views-with-null-object-pattern/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-keep-clean-ruby-on-rails-views-with-null-object-pattern/cover.png
metatags:
  image: cover.png
slug: how-keep-clean-ruby-on-rails-views-with-null-object-pattern
---

![Image description](file_0.png)

One of the most common errors developers encounter is NoMethodError. It occurs when code is executed according to a script not provided by the programmer.

Junior devs often try to solve this problem in a non optimal way. Let’s look at some examples of bad code:
```ruby
@user = User.find_by(email: "deleted@user.com")
@user.first_name
```
If the user is not in the database or is flagged as “deleted”.
Then we will get an error:
```ruby
undefined method `first_name' for nil:NilClass
```
A very common solution to this problem is this:
```ruby
@user.try(:first_name)
```
Or by using a conditional operator:
```ruby
if @user.exists?
 @user.first_name
end
```
This code doesn’t look very smart. The problem is that this check can occur in different places in the project and it is much more convenient to manage this behavior in one place. In addition, this code violates the Tell-Don’t-Ask principle. The **NullObject** pattern just solves these problems.

## Solution
First, let’s write a **NullObject** for a User type object:

```ruby
class DeletedUser
  def full_name
   "Unknown"
  end

  def address
    "Unknown"
  end
  
  def email
   "Unknown"
  end
  # …
end
```
So now we have an object that we can return when a user is not found:
```ruby
@user = User.find_by(email: "deleted@user.com") || DeletedUser.new
@user.first_name #=> "Unknown"
```
Now we are sure that the object will always respond to the methods we expect it to respond to.