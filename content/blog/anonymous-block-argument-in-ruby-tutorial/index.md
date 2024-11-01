---
dev_to_id: 1739418
title: Anonymous block argument in Ruby
description: In the Ruby programming language, it is possible to use default block parameters instead of...
created_at: '2024-01-23T20:09:24Z'
edited_at: '2024-10-21T21:05:38Z'
draft: false
tags:
- ruby
- tutorial
canonical_url: https://jetthoughts.com/blog/anonymous-block-argument-in-ruby-tutorial/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/anonymous-block-argument-in-ruby-tutorial/cover.png
slug: anonymous-block-argument-in-ruby-tutorial
metatags:
  image: cover.png
---
In the Ruby programming language, it is possible to use default block parameters instead of variables. This feature allows for more concise and expressive code.

## Before Ruby 2.7

We would need to write code like this:

```ruby
irb(main):005> [1, 2, 3].map { |el| el }
=> [1, 2, 3]
```

## From Ruby 2.7

However, in Ruby 2.7, numbered parameters were introduced, which allows us to write code like this:

```ruby
irb(main):010> [10, 100, 1000].each_with_index { p "#{_1}, #{_2}" }
"10, 0"
"100, 1"
"1000, 2"
```

In the above example, `_1` refers to the first element of the array, and `_2` refers to its index.

## From Ruby 3.4

In the newer version of Ruby 3.4, anonymous block arguments were added, and now we can refer to the first element using the word it. For example:

```ruby
irb(main):012> [1, 2, 3].each { it }
=> [1, 2, 3]
```

In this case, it refers to the current element being iterated over.

These features provide more flexibility and readability when working with blocks in Ruby. They allow for more concise code and reduce the need for explicit variable declarations.

---

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).

If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).