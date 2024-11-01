---
dev_to_id: 1140235
title: "What is the difference between joins and includes in Rails ActiveRecord?"
description: "The main difference is that when using includes the eager loading is used. Eager loading allows you..."
created_at: "2022-07-14T11:02:17Z"
edited_at: "2024-11-01T14:19:02Z"
draft: false
tags: ["rails", "ruby", "database", "webdev"]
canonical_url: "https://jetthoughts.com/blog/what-difference-between-joins-includes-in-rails-activerecord-ruby/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fyvc5868vlo25ieeqqj3a.png"
slug: "what-difference-between-joins-includes-in-rails-activerecord-ruby"
metatags:
  image: cover.png
---
The main difference is that when using includes the eager loading is used. Eager loading allows you to optimize data retrieval by avoiding additional queries to the database.

Let’s see how it works with an example:

**Joins:**
![Image description](file_0.png)

We have joined tables, but we don’t get any data from the users table. Therefore, each time the user record is accessed, and there is an additional query to the database.

**Includes:**
![Image description](file_1.png)

As you can see, we don’t have any additional queries because we use eager loading and we get the data about the user from memory instead of querying the database.

