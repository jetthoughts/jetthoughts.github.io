---
remote_url: https://dev.to/jetthoughts/rails-71-how-ruby-on-rails-developers-can-use-the-with-query-method-for-ctes-2p9a
source: dev_to
remote_id: 2427475
dev_to_id: 2427475
dev_to_url: https://dev.to/jetthoughts/rails-71-how-ruby-on-rails-developers-can-use-the-with-query-method-for-ctes-2p9a
title: 'Rails 7.1: How Ruby on Rails Developers Can Use the .with Query Method for CTEs'
description: For Ruby on Rails developers looking to level up their database query skills, Rails 7.1 introduced a...
created_at: '2025-04-23T16:02:26Z'
draft: false
tags:
- rails
- tutorial
- database
- programming
canonical_url: https://dev.to/jetthoughts/rails-71-how-ruby-on-rails-developers-can-use-the-with-query-method-for-ctes-2p9a
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/rails-71-how-ruby-on-developers/cover.png
metatags:
  image: cover.png
slug: rails-71-how-ruby-on-developers
---
For Ruby on Rails developers looking to level up their database query skills, Rails 7.1 introduced a powerful new feature that deserves your attention: the [.with](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-with) query method. This elegant addition allows developers to construct [Common Table Expressions (CTEs)](https://www.atlassian.com/data/sql/using-common-table-expressions) directly in Active Record, making complex queries more readable and maintainable.

## What are Common Table Expressions?

Before diving into implementation, let's quickly understand what CTEs are. Common Table Expressions act as temporary result sets that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. For Rails developers working with complex data relationships, CTEs offer several advantages:

- Improved query readability
- Better organization of complex queries
- The ability to reference the same subquery multiple times
- Enhanced query performance in many cases

## How Ruby on Rails Developers Can Use the New `.with` Method

Rails 7.1 introduces the `.with` query method that enables developers to construct CTEs directly using Active Record. Let's explore various examples of how you can implement it in your applications.

### Basic Example

```ruby
# Add a CTE named 'posts_with_tags' that selects posts with tags
Post.with(posts_with_tags: Post.where(tags_count: 1..))
# => ActiveRecord::Relation
# WITH posts_with_tags AS (
#   SELECT * FROM posts WHERE (tags_count > 0)
# )
# SELECT * FROM posts
```

### Using CTEs in FROM and JOIN Clauses

Once you define a CTE, you can reference it in your queries using custom `FROM` values or `JOIN` clauses:

```ruby
# Using a CTE in a FROM clause
Post.with(posts_with_tags: Post.where(tags_count: 1..))
    .from("posts_with_tags AS posts")
# => ActiveRecord::Relation
# WITH posts_with_tags AS (
#  SELECT * FROM posts WHERE (tags_count > 0)
# )
# SELECT * FROM posts_with_tags AS posts

# Using a CTE in a JOIN clause
Post.with(posts_with_tags: Post.where(tags_count: 1..))
    .joins("JOIN posts_with_tags ON posts_with_tags.id = posts.id")
# => ActiveRecord::Relation
# WITH posts_with_tags AS (
#   SELECT * FROM posts WHERE (tags_count > 0)
# )
# SELECT * FROM posts JOIN posts_with_tags ON posts_with_tags.id = posts.id
```

### Using UNION ALL with CTEs

You can pass an array of sub-queries to be joined with a `UNION ALL`:

```ruby
Post.with(
  posts_with_tags_or_comments: [
    Post.where(tags_count: 1..), 
    Post.where(comments_count: 1..)
  ]
)
# => ActiveRecord::Relation
# WITH posts_with_tags_or_comments AS (
#  (SELECT * FROM posts WHERE (tags_count > 0))
#  UNION ALL
#  (SELECT * FROM posts WHERE (comments_count > 0))
# )
# SELECT * FROM posts
```

### Practical Example: Finding Users with Articles

Let's examine a practical example that Ruby on Rails developers might use in their projects:

```ruby
# First, create a CTE for users who have articles
users_with_articles = User.joins(:articles).select(:id).distinct

# Then, use the CTE in our main query
result = User.with(users_with_articles: users_with_articles)
             .joins("JOIN users_with_articles ON users.id = users_with_articles.id")
             .select(:id, :name)
```

The SQL generated from this query would look like:

```sql
WITH users_with_articles AS (
  SELECT DISTINCT users.id
  FROM users
  INNER JOIN articles ON articles.user_id = users.id
)
SELECT users.id, users.name
FROM users
JOIN users_with_articles ON users.id = users_with_articles.id
```

### Multiple CTEs

For more complex scenarios, Rails developers can define multiple CTEs in two ways:

```ruby
# Method 1: Pass multiple key-value pairs
Post.with(
  posts_with_comments: Post.where(comments_count: 1..),
  posts_with_tags: Post.where(tags_count: 1..)
)

# Method 2: Chain multiple .with calls
Post.with(posts_with_comments: Post.where(comments_count: 1..))
    .with(posts_with_tags: Post.where(tags_count: 1..))
```

### Using Multiple CTEs in a Complex Query

Here's how you could combine multiple CTEs in a real-world scenario:

```ruby
recent_articles = Article.where(created_at: 1.month.ago..).select(:id, :user_id)
active_users = User.where(active: true).select(:id)

result = User.with(
           recent_articles: recent_articles,
           active_users: active_users
         )
         .joins("JOIN recent_articles ON users.id = recent_articles.user_id")
         .joins("JOIN active_users ON users.id = active_users.id")
         .distinct
```

### Using Raw SQL in CTEs

When necessary, you can use raw SQL for complex computations, but be careful about SQL injection:

```ruby
# Only use when you've verified it's safe
Post.with(popular_posts: Arel.sql("... complex sql to calculate posts popularity ..."))
```

### Example: Calculating Comment Likes and Sorting

A common real-world scenario for Ruby on Rails developers is calculating aggregations and sorting by them. Here's how you could use CTEs to find the most liked comments:

```ruby
# Create a CTE that calculates the total likes for each comment
comment_likes = Comment.select(:id, 'COUNT(likes.id) AS likes_count')
                      .left_joins(:likes)
                      .group(:id)

# Use the CTE in the main query to sort comments by popularity
popular_comments = Comment.with(comment_likes: comment_likes)
                         .joins("JOIN comment_likes ON comments.id = comment_likes.id")
                         .select('comments.*, comment_likes.likes_count')
                         .order('comment_likes.likes_count DESC')
                         .limit(10)

# The generated SQL would look like:
# WITH comment_likes AS (
#   SELECT comments.id, COUNT(likes.id) AS likes_count
#   FROM comments
#   LEFT JOIN likes ON likes.comment_id = comments.id
#   GROUP BY comments.id
# )
# SELECT comments.*, comment_likes.likes_count
# FROM comments
# JOIN comment_likes ON comments.id = comment_likes.id
# ORDER BY comment_likes.likes_count DESC
# LIMIT 10
```

This pattern is particularly useful when you need to:
1. Calculate aggregate values that would normally require subqueries
2. Reference the same aggregation multiple times in your query
3. Keep your queries clean and maintainable
4. Optimize performance for complex sorting operations

### Example: Building a Hierarchical Category Tree

CTEs are perfect for working with hierarchical data. Here's how Ruby on Rails developers can display a complete category tree with depth information:

```ruby
# Base query: select top-level categories
base_categories = Category.where(parent_id: nil)
                         .select(:id, :name, :parent_id, 'ARRAY[id] AS path', '0 AS depth')

# Recursive part: join child categories
child_categories = Category.select('categories.id, categories.name, categories.parent_id, 
                                    (categories_tree.path || categories.id) AS path, 
                                    categories_tree.depth + 1 AS depth')
                          .joins('JOIN categories_tree ON categories.parent_id = categories_tree.id')

# Combine into a recursive CTE
categories_tree = base_categories.recursive_union(child_categories)

# Use the recursive CTE
result = Category.with.recursive(categories_tree: categories_tree)
                .from('categories_tree')
                .order('path')

# This will return all categories with their depth and path information
```

### Example: Finding Active Users with Recent Posts and Comment Counts

CTEs allow you to cleanly combine multiple related datasets:

```ruby
# CTE for users who posted in the last 30 days
recent_posters = User.where(posts: { created_at: 30.days.ago.. })
                    .joins(:posts)
                    .select(:id)
                    .distinct

# CTE for comment counts per user
comment_stats = User.select(:id, 'COUNT(comments.id) AS comment_count')
                   .joins(:comments)
                   .group(:id)

# Main query combining both CTEs
result = User.with(
           recent_posters: recent_posters,
           comment_stats: comment_stats
         )
         .joins('INNER JOIN recent_posters ON users.id = recent_posters.id')
         .joins('LEFT JOIN comment_stats ON users.id = comment_stats.id')
         .select('users.*, COALESCE(comment_stats.comment_count, 0) AS comment_count')
         .order('comment_count DESC')
```

### Example: Paginated Search Results with Ranking

CTEs can make complex search logic more manageable:

```ruby
# CTE for search results with ranking
ranked_results = Article.select('articles.*, 
                               (CASE 
                                 WHEN title ILIKE ? THEN 10 
                                 WHEN body ILIKE ? THEN 5 
                                 ELSE 1 
                               END) AS rank', 
                              "%#{query}%", "%#{query}%")
                       .where("title ILIKE ? OR body ILIKE ? OR tags ILIKE ?", 
                              "%#{query}%", "%#{query}%", "%#{query}%")

# Use the CTE for pagination and sorting
page_size = 20
offset = (page_number - 1) * page_size

results = Article.with(ranked_results: ranked_results)
                .from('ranked_results')
                .select('*')
                .order('rank DESC, created_at DESC')
                .limit(page_size)
                .offset(offset)
```

### Example: Calculating Running Totals for Financial Reports

CTEs are excellent for running calculations like financial reporting:

```ruby
# CTE for monthly transaction data
monthly_transactions = Transaction.select(
                         "DATE_TRUNC('month', transaction_date) AS month",
                         'SUM(amount) AS monthly_total'
                       )
                      .group("DATE_TRUNC('month', transaction_date)")
                      .order("DATE_TRUNC('month', transaction_date)")

# CTE for running totals
running_totals = Transaction.with(monthly_data: monthly_transactions)
                           .from('monthly_data')
                           .select('month, 
                                   monthly_total, 
                                   SUM(monthly_total) OVER (ORDER BY month) AS running_total')

# Use the CTE for final report
result = Transaction.with(
           monthly_data: monthly_transactions,
           running_totals: running_totals
         )
         .from('running_totals')
         .order('month')
```

### Example: Finding Gaps in Sequential Data

CTEs can help identify gaps in sequences, like missing order numbers:

```ruby
# CTE for order numbers with lead values
order_sequence = Order.select(:id, :order_number, 
                             'LEAD(order_number, 1) OVER (ORDER BY order_number) AS next_number')
                     .order(:order_number)

# Use the CTE to find gaps
gaps = Order.with(order_sequence: order_sequence)
           .from('order_sequence')
           .where('next_number - order_number > 1')
           .select('order_number, next_number, next_number - order_number - 1 AS gap_size')
```

### Example: Advanced Filter with Multiple Conditions

For complex filtering that might otherwise require multiple subqueries:

```ruby
# CTE for premium users who have completed their profile
eligible_users = User.where(subscription_status: 'premium')
                    .where.not(profile_completed_at: nil)
                    .select(:id)

# CTE for users with minimum purchase amounts
qualified_purchases = User.select(:id)
                         .joins(:orders)
                         .group(:id)
                         .having('SUM(orders.amount) >= ?', 500)

# Combine CTEs to find users eligible for a special promotion
promotion_users = User.with(
                    eligible_users: eligible_users,
                    qualified_purchases: qualified_purchases
                  )
                  .joins('INNER JOIN eligible_users ON users.id = eligible_users.id')
                  .joins('INNER JOIN qualified_purchases ON users.id = qualified_purchases.id')
                  .select('users.*')
```

> **Note:** CTE's are only supported in MySQL for versions 8.0 and above. You will not be able to use CTE's with MySQL 5.7.

## Leveraging Recursive CTEs in Rails 7.1

One of the most powerful features of CTEs is recursion, which is fully supported by the `.with` method. This is particularly useful for Ruby on Rails developers working with hierarchical data structures like organization charts, comment threads, or category trees.

Here's how you can implement a recursive CTE:

```ruby
# Base case
base_query = Comment.where(parent_id: nil)
                   .select(:id, :parent_id, :content, '0 as depth')

# Recursive part
recursive_query = Comment.select('comments.id, comments.parent_id, comments.content, depth + 1')
                        .joins('JOIN comments_hierarchy ON comments.parent_id = comments_hierarchy.id')

# Combine using RECURSIVE
comments_hierarchy = base_query.recursive_union(recursive_query)

# Use the recursive CTE
result = Comment.with.recursive(comments_hierarchy: comments_hierarchy)
                .from('comments_hierarchy')
                .order('depth, id')
```

## Benefits for Ruby on Rails Developers

Implementing CTEs with the new `.with` method provides several advantages for developers:

1. **Code Organization**: Keep complex queries clean and modular
2. **DRY Principle**: Reuse the same subquery multiple times without duplication
3. **Performance**: Many databases optimize CTEs better than nested subqueries
4. **Readability**: Make your query intentions clearer to other developers

## Implementation Details

For Ruby on Rails developers wanting to use this feature, it's important to note:

- The `.with` method is available in Rails 7.1 and later
- It works with all major database backends that support CTEs (PostgreSQL, MySQL 8.0+, SQLite 3.8.3+, etc.)
- You can use both recursive and non-recursive CTEs
- CTEs can be referenced in JOIN clauses, WHERE conditions, and more

## Conclusion

The addition of the `.with` query method is a significant enhancement to Active Record in Rails 7.1, giving Ruby on Rails developers a more elegant way to construct Common Table Expressions. By incorporating CTEs into your Rails applications, you can write more maintainable and efficient database queries.

Whether you're managing complex data relationships, working with hierarchical structures, or simply want to improve your query organization, the `.with` method provides a powerful tool in your Ruby on Rails development toolkit.

Happy coding!