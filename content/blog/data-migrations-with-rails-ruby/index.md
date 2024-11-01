---
dev_to_id: 1182433
title: Data migrations with Rails
description: Data migration is a common part of working with databases, and Ruby on Rails developers have many...
created_at: '2022-09-02T17:01:27Z'
edited_at: '2024-10-21T21:06:11Z'
draft: false
tags:
- ruby
- rails
- webdev
- database
canonical_url: https://jetthoughts.com/blog/data-migrations-with-rails-ruby/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/data-migrations-with-rails-ruby/cover.png
slug: data-migrations-with-rails-ruby
metatags:
  image: cover.png
---
Data migration is a common part of working with databases, and Ruby on Rails developers have many tools at their disposal. Still, it can be a challenge to get it right in every situation. Here are some tips for making sure your migrations go smoothly.

The easiest way is just to have data migrations alongside with schema migrations. But as your code base grows this might become a problem.

## Problems
**_Code coupling_**
Data migrations depend on the existing code(models, service objects, etc.) over time code changes potentially breaking the migrations. Let's say you have a `Order` model and want to update a recently added attribute `fulfilled` to `true` for all orders created last year. You can do it with a simple migration:
```ruby
class UpdateFulfilledIn2021 < ActiveRecord::Migration
  def up
    Order.all.where("created_at < '2022-01-01'")
         .update_all(fulfilled: true)
  end
end
```
The above migration might fail:

1. If `Order` model gets renamed or removed completely.
1. If a new validation was added to the model.
1. A new side effect via callback were added to the model. For example if an email gets sent to a customer after the `Order` record is updated with `fulfilled = 't'` , and you definitely don't want to bother customers from last year with emails they don't need.

_**Possibly long execution times**_
Data migrations might take a lot of time to execute, depending on the amount of records you need to update, and the complexity of calculations to perform for each record. Long execution times can potentially break the deployment pipeline, or lead to some down time of the application.

**_Hard to test_**
It's hard to write tests for migrations ensuring that the data is updated in a correct way, since a single error might lead to whole application data corruption requiring some down time to recover DB back to correct state.

## Possible solutions
**_Inline model stubs_**
Just define models class stubs with minimal required definitions. That way original model changes won't affect the migration. For the example from above:
```ruby
class UpdateFulfilledIn2021 < ActiveRecord::Migration  
  class OrderStub < ApplicationRecord
    self.table_name = 'orders'
  end
  
  def up
    OrderStub.all.where("created_at < '2022-01-01'")
             .update_all(fulfilled: true)
  end
end
```

Pros:

- Is not affected by actual model changes;

Cons:

- Model logic and association definitions are duplicated;

**_Pure SQL_**
Alternatively you can use pure SQL to modify your data.
```ruby
def up 
  execute(
    "UPDATE user_orders SET fulfilled = 't' 
     WHERE created_at < '2022-01-01'"
  )
end
```

Pros:

- Does not depend on the code;
- Does not require any additional setup;

Cons:

- Get complex fast for non-trivial data changes;
- Duplicates association logic when need to join associated records;
- No progress indication for long running updates;

_**Rake tasks**_
```ruby
task update_fulfilled_in_2021: :environment do
  OrderStub.all.where("created_at < '2022-01-01'")
           .update_all(fulfilled: true)
end
```

Pros:

- Can be run on demand any time in background without affecting deployment process;
- Testable;

Cons:

- No clear indication that migration has already performed, so it's better be idempotent;

**_Data migration gem_**
There are a couple of gems that helps organize your data migrations in the same way as schema migrations, one of the most known [data-migrate](https://github.com/ilyakatz/data-migrate). You can simply generate a new migration:

```bash
rails g data_migration update_fulfilled_in_2021
```

Generated data migrations are stored in `db/data` and then could be run with:
```bash
rake data:migrate
```

Pros:

- Has versioning the same way as schema migrations;
- Can be easily run during deployment;
- Testable: via either extracting logic into dedicated classes, or setting up a test helper to run the actual migration during tests;

Cons:

- Additional setup;

## Conclusion
Each solution is good in it's own circumstances.

For easy one time updates you can utilize Rails schema migrations or execute pure SQL. 

If you need to perform more complex data updates once in a month or so, then rake tasks might help you with that. 

But as your code base grows and migrations get bigger & more complex it's better to utilize full data migration automation gem with version control and a way to test the updates before they hit the production database.
