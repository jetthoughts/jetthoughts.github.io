---
dev_to_id: 2187281
dev_to_url: https://dev.to/jetthoughts/understanding-optimistic-and-pessimistic-locking-in-ruby-on-rails-2fo
title: Understanding Optimistic and Pessimistic Locking in Ruby on Rails
description: When several people touch a database simultaneously, software conflicts can occur when more than one...
created_at: '2025-01-03T10:10:53Z'
edited_at:
draft: false
tags:
- ruby
- rails
- tutorial
- database
canonical_url: https://dev.to/jetthoughts/understanding-optimistic-and-pessimistic-locking-in-ruby-on-rails-2fo
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/understanding-optimistic-pessimistic-locking-in-ruby-on-rails/cover.png
slug: understanding-optimistic-pessimistic-locking-in-ruby-on-rails
metatags:
  image: cover.png
---
When several people touch a database simultaneously, software conflicts can occur when more than one user tries to update the same record. The most sought-after way to avoid problems from this point of view is to lock the record the first user needs to change. Such conflicts are dealt with in Ruby on Rails using two locking strategies: Optimistic Locking and Pessimistic Locking. This article discusses these strategies, their differences, and how they can be implemented in Ruby on Rails.

Optimistic Locking
------------------

Optimistic locking assumes that conflicts are rare. It allows multiple users to read the same record without restrictions but ensures that updates are safe by verifying the record's version before saving.

### How it Works

1.  A `version` column is added to the table.
2.  Each time a record is updated, the `version` is incremented.
3.  When a user tries to save changes, Rails checks if the `version` in the database matches the `version` in the user's object.
4.  If the versions do not match, Rails raises an error (e.g., `ActiveRecord::StaleObjectError`), indicating the record has been updated by someone else.

#### Example in Rails

```ruby
# Migration to add version column
class AddLockVersionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lock_version, :integer, default: 0, null: false
  end
end
```
#### Model setup
```ruby
class User < ApplicationRecord
end
```

#### Usage in code
```ruby
user1 = User.find(1)
user2 = User.find(1)
    
user1.update(name: "Alice")
user2.update(name: "Bob") # Raises ActiveRecord::StaleObjectError
```

Pessimistic Locking
-------------------

Pessimistic locking prevents conflicts by locking a record for a single user during an operation. Other users cannot modify or even read the record (depending on the lock type) until the lock is released.

### How it Works

1.  A database-level lock is applied when a record is accessed.
2.  Other transactions must wait for the lock to be released.
3.  This prevents conflicts but can lead to performance issues if locks are held for too long.

#### Example in Rails
```ruby
# Usage with find and lock
user = User.lock.find(1) # Applies a "FOR UPDATE" lock in SQL
user.update(name: "Charlie") # Other transactions must wait
```

#### Usage in a transaction
```ruby
User.transaction do
  user = User.lock.find(1)
  user.update(name: "Dana")
end
```

Differences Between Optimistic and Pessimistic Locking
------------------------------------------------------

| Feature              | Optimistic Locking                            | Pessimistic Locking                          |
|----------------------|-----------------------------------------------|---------------------------------------------|
| **Assumption**       | Conflicts are rare.                          | Conflicts are likely.                       |
| **Implementation**   | Uses a `version` column to detect conflicts. | Uses database locks to prevent conflicts.   |
| **Performance**      | No waiting for locks, better for high-read apps. | Can cause delays and deadlocks if overused. |
| **Conflict Resolution** | Raises an error when a conflict is detected. | Prevents conflicts by locking the record.   |
| **Use Case**         | Best for apps with frequent reads and rare updates. | Best for critical operations needing strict control. |

Choosing the Right Strategy
---------------------------

**Use Optimistic Locking** when:

*   The application has high read-to-write ratios.
*   Conflicts are rare but need to be detected.
*   Users need to resolve conflicts manually.

**Use Pessimistic Locking** when:

*   Conflicts are common or critical.
*   Data integrity is more important than performance.
*   Transactions are short and well-managed.

Summary
-------

Optimistic locking is simple and lightweight, while pessimistic locking offers strict control at the cost of possible performance problems. Which one to use depends on the particular needs of an application and the pattern of usage.