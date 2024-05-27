---
dev_to_id: 1140235
title: "What is the difference between joins and includes in Rails ActiveRecord?"
description: "The main difference is that when using includes the eager loading is used. Eager loading allows you..."
created_at: "2022-07-14T11:02:17Z"
edited_at: "2022-09-27T12:48:47Z"
draft: false
tags: ["rails", "ruby", "database", "webdev"]
canonical_url: "https://jtway.co/what-is-the-difference-between-joins-and-includes-in-rails-activerecord-64cdbffe60b6"
slug: "what-difference-between-joins-includes-in-rails-activerecord-ruby"
---
The main difference is that when using includes the eager loading is used. Eager loading allows you to optimize data retrieval by avoiding additional queries to the database.

Let’s see how it works with an example:

**Joins:**
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/yvc5868vlo25ieeqqj3a.png)

We have joined tables, but we don’t get any data from the users table. Therefore, each time the user record is accessed, and there is an additional query to the database.

**Includes:**
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/0a4wxvhwry0k6sucaux0.png)

As you can see, we don’t have any additional queries because we use eager loading and we get the data about the user from memory instead of querying the database.

