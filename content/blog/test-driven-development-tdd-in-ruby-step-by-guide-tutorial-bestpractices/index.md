---
dev_to_id: 2066540
title: 'Test-Driven Development (TDD) in Ruby: A Step-by-Step Guide'
description: In Test-Driven Development (TDD), you start with tests, not code. First, write a test that defines...
created_at: '2024-10-30T10:03:39Z'
edited_at: '2024-11-25T15:42:01Z'
draft: false
tags:
- tutorial
- bestpractices
- ruby
- learning
canonical_url: https://jetthoughts.com/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/cover.jpeg
slug: test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices
metatags:
  image: cover.jpeg
---
In Test-Driven Development (TDD), you start with tests, not code. First, write a test that defines what the code should do. Then write the code to make the test pass, focusing on small, clear steps. This approach in Ruby helps keep each part of the code clear and on target with what it’s supposed to do, often making it easier to adjust and maintain down the line. TDD can make a difference in breaking down problems into smaller, manageable steps, which tends to reduce bugs and make sure each part does what’s actually needed.

In this article, we’ll explore the TDD lifecycle—red, green, refactor—through a small example of an `Order` class that handles items and calculates the total price.

---

## The TDD Lifecycle
The TDD lifecycle is often broken into three steps:

- **Red:** Write a test that defines a new function or behavior. This test will fail initially.
- **Green:** Implement just enough code to make the test pass.
- **Refactor:** Clean up the code, improving structure without changing functionality.

This cycle ensures that code only has the functionality required by the tests, keeping it lean and easy to refactor.

---

## Step-by-Step Example: Building an Order Class with TDD
Imagine we’re building an e-commerce app. One part of this app is an `Order` class that will:

1. Allow items to be added with prices and quantities.
2. Calculate the total price for all items in the order.
3. Apply a discount if specified.

### Step 1: Define the Initial Test
To start, we’ll write a test specifying that a new order has a total price of zero when no items are added.

```ruby
require 'minitest/autorun'
require_relative 'order'

class OrderTest < Minitest::Test
  def test_initial_total_price_is_zero
    order = Order.new
    assert_equal 0, order.total_price
  end
end
```
This test defines our expectations: a new order should start with a zero total. Since there’s no `Order` class or `total_price` method yet, running this will result in a “red” failure.

### Step 2: Implement Just Enough Code to Pass
Next, we implement the bare minimum to make this test pass.

```ruby
class Order
  def total_price
    0
  end
end
```
Now, running the test again should turn it "green", confirming that our initial requirement is met.

### Step 3: Expanding Requirements - Adding Items
Now let’s add a requirement to add items to the order. Our new test will check that the total price updates based on items added.

```ruby
def test_add_item_increases_total_price
  order = Order.new
  order.add_item(name: "Book", price: 10, quantity: 2)
  assert_equal 20, order.total_price
end
```
Implementing `add_item`
To make this test pass, we need to implement `add_item` in the `Order` class. We’ll use an array to store items, and `total_price` will sum them.

```ruby
class Order
  def initialize
    @items = []
  end

  def add_item(name:, price:, quantity:)
    @items << { name: name, price: price, quantity: quantity }
  end

  def total_price
    @items.reduce(0) { |sum, item| sum + item[:price] * item[:quantity] }
  end
end
```
Now our test_add_item_increases_total_price test should pass.

### Step 4: Adding Validation through Tests
To make this class robust, we’ll add validation to ensure item prices and quantities are positive. Let’s define two tests:

```ruby
def test_add_item_with_negative_price_raises_error
  order = Order.new
  assert_raises(StandardError) { order.add_item(name: "Book", price: -5, quantity: 1) }
end

def test_add_item_with_negative_quantity_raises_error
  order = Order.new
  assert_raises(StandardError) { order.add_item(name: "Book", price: 5, quantity: -1) }
end
```
Implementing Validation in `add_item`
To make these tests pass, we’ll add basic validation in `add_item`.

```ruby
def add_item(name:, price:, quantity:)
  raise "Price must be positive" if price <= 0
  raise "Quantity must be positive" if quantity <= 0
  @items << { name: name, price: price, quantity: quantity }
end
```
With this validation in place, our new tests should pass, and the code becomes safer to use.

### Step 5: Refactoring
As more features and validations are added, the `add_item` and `total_price` methods can grow in complexity. Refactoring keeps our codebase clean and maintainable without affecting functionality. Since we have tests, we’re confident that any changes we make will preserve the behavior.

Let’s refactor `total_price` to separate the logic for calculating an item’s total cost. We can move it into a private helper method, which simplifies the main method.

```ruby
class Order
  def total_price
    @items.reduce(0) { |sum, item| sum + item_cost(item) }
  end

  private

  def item_cost(item)
    item[:price] * item[:quantity]
  end
end
```
Our tests for `total_price` will confirm that this refactoring didn’t break anything. This is a key benefit of TDD: the tests give us freedom to refactor while ensuring functionality remains intact.

## Benefits of TDD
Using TDD in Ruby offers several advantages:

- **Requirement Clarity:** Writing tests first clarifies requirements early on.
- **Confidence in Code:** Tests act as a safety net, catching regressions and errors introduced by refactoring or new features.
- **Incremental Development:** By breaking down requirements into small, testable increments, TDD encourages focused, incremental development.

---
## References:

Kent Beck's **Test-Driven Development: By Example** offers a comprehensive step-by-step guide to mastering Test-Driven Development (TDD). It demonstrates how testing can lead to clean and effective code design. Sandi Metz's **99 Bottles of OOP** complements this approach by providing practical exercises that help developers create flexible and maintainable object-oriented code using a test-driven mindset.

- Beck, Kent. Test Driven Development: By Example. Addison-Wesley Professional, 2002. ISBN: 0321146530.

- Metz, Sandi and Owen, Katrina. 99 Bottles of OOP: A Practical Guide to Writing Cost-Effective, Maintainable, and Pleasing Object-Oriented Code. Self-published, 2018. ISBN-13:978-1-944823-00-9