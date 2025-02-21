---
remote_url: https://dev.to/jetthoughts/rails-8-brings-viewobjects-why-theyre-awesome-and-how-to-use-them-323c
source: dev_to
remote_id: 2130465
dev_to_id: 2130465
dev_to_url: https://dev.to/jetthoughts/rails-8-brings-viewobjects-why-theyre-awesome-and-how-to-use-them-323c
title: 'Rails 8 Brings ViewObjects: Why They’re Awesome and How to Use Them'
description: 'Rails 8 brings an exciting addition to its arsenal: ViewComponents, powered by the...'
created_at: '2024-12-02T06:54:57Z'
edited_at: '2024-12-12T12:47:03Z'
draft: false
tags:
- rails
- ruby
- changelog
- tutorial
canonical_url: https://jetthoughts.com/blog/rails-8-brings-viewobjects-why-theyre-awesome-how-use-them-ruby/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/rails-8-brings-viewobjects-why-theyre-awesome-how-use-them-ruby/cover.png
metatags:
  image: cover.png
slug: rails-8-brings-viewobjects-why-theyre-awesome-how-use-them-ruby
---
Rails 8 brings an exciting addition to its arsenal: ViewComponents, powered by the ViewComponent::Base class. This feature is a game-changer for managing UI logic, offering developers a clean, reusable, and testable approach to building components.

## What Are ViewComponents?
ViewComponents encapsulate a piece of your UI into a Ruby class, allowing you to define rendering logic in one place. Instead of scattering presentation logic across views, helpers, and partials, ViewComponents consolidate it into an object that’s easy to maintain and test.

### Key benefits include:

- **Reusability**: Create components once and use them in multiple places.
- **Testability**: Easily test components in isolation.
- **Performance**: Templates are compiled, which makes them faster than traditional partials.
- **Encapsulation**: All logic and rendering for a component live in a single, cohesive unit.

## Example: Product Card with ViewComponent
Let’s build a product card component for an e-commerce site to demonstrate how ViewComponents work. This card will display the product's name, price, and availability status.

### Step 1: Create the Component Class
Manually create a new Ruby class for the component:

```ruby
# app/components/product_card_component.rb
class ProductCardComponent < ViewComponent::Base
  attr_reader :product

  def initialize(product:)
    @product = product
  end

  def price
    product.discounted? ? product.discounted_price : product.price
  end

  def stock_status
    product.in_stock? ? "In Stock" : "Out of Stock"
  end

  def css_classes
    "product-card #{'out-of-stock' unless product.in_stock?}"
  end
end
```
This class encapsulates all logic for the product card, including calculating the price, determining stock status, and generating CSS classes dynamically.

### Step 2: Create the Component Template
Add the corresponding view template:

```erb
<!-- app/components/product_card_component.html.erb -->
<div class="<%= css_classes %>">
  <h3><%= product.name %></h3>
  <p>Price: <%= number_to_currency(price) %></p>
  <p>Status: <%= stock_status %></p>
</div>
```
This template uses methods from the component class to render HTML dynamically based on the product’s attributes.

### Step 3: Use the Component in a View
Render the component in any Rails view using the render helper:

```erb
<!-- app/views/products/index.html.erb -->
<div class="products-grid">
  <% @products.each do |product| %>
    <%= render ProductCardComponent.new(product: product) %>
  <% end %>
</div>
```
This approach replaces repetitive HTML and logic with a single line, making the view cleaner and easier to maintain.

### Step 4: Test the Component
Write tests for the component to ensure it behaves correctly:

```ruby
# test/components/product_card_component_test.rb
require "test_helper"

class ProductCardComponentTest < ViewComponent::TestCase
  def test_renders_in_stock_product
    product = OpenStruct.new(name: "Ruby Book", price: 20.0, discounted_price: nil, in_stock: true, discounted?: false)
    render_inline(ProductCardComponent.new(product: product))

    assert_text "Ruby Book"
    assert_text "Price: $20.00"
    assert_text "In Stock"
    assert_no_css ".out-of-stock"
  end

  def test_renders_out_of_stock_product
    product = OpenStruct.new(name: "Rails Book", price: 25.0, discounted_price: 20.0, in_stock: false, discounted?: true)
    render_inline(ProductCardComponent.new(product: product))

    assert_text "Rails Book"
    assert_text "Price: $20.00"
    assert_text "Out of Stock"
    assert_css ".out-of-stock"
  end
end
```
This ensures your component behaves correctly for various product states.

## Why ViewComponents Are Awesome
- **Clean and Reusable Code**: Consolidating logic into reusable components reduces duplication and keeps views clean.
- **Improved Testability**: Isolated tests for each component make your UI code more reliable.
- **Better Performance**: Compiled templates improve rendering speed compared to partials.
-  **Scalability**: As your application grows, managing UI becomes easier with well-organized components.

##Conclusion
ViewComponents in Rails 8 provide a modern way to manage UI logic, making it reusable, testable, and performant. By leveraging ViewComponent::Base, developers can build clean, maintainable components that fit seamlessly into Rails’ ecosystem. Embrace this new feature to take your Rails applications to the next level!