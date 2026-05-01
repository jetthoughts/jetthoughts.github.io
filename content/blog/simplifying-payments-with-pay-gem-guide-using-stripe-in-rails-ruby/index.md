---
remote_url: https://dev.to/jetthoughts/simplifying-payments-with-pay-gem-a-guide-to-using-stripe-in-rails-12ga
source: dev_to
seo_override: true
remote_id: 2133274
dev_to_id: 2133274
dev_to_url: https://dev.to/jetthoughts/simplifying-payments-with-pay-gem-a-guide-to-using-stripe-in-rails-12ga
title: 'Simplifying Payments with Pay gem: A Guide to Using Stripe in Rails'
description: Payment integration can be challenging when building web applications. The Pay gem makes handling...
created_at: '2024-12-03T09:36:14Z'
date: 2024-12-03
edited_at: '2024-12-12T14:07:22Z'
draft: false
tags:
- ruby
- rails
- tutorial
- stripe
canonical_url: https://jetthoughts.com/blog/simplifying-payments-with-pay-gem-guide-using-stripe-in-rails-ruby/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/simplifying-payments-with-pay-gem-guide-using-stripe-in-rails-ruby/cover.jpeg
metatags:
  image: cover.jpeg
slug: simplifying-payments-with-pay-gem-guide-using-stripe-in-rails-ruby
---
Payment integration adds a lot of moving parts to a Rails app. The [Pay gem](https://github.com/pay-rails/pay) (current version `11.6.x`, Rails 6.0+) wraps Stripe, Paddle, Braintree, and Lemon Squeezy behind one Rails-friendly interface so you don't write the customer, subscription, and webhook plumbing yourself.

**Quick start (TL;DR):**

```ruby
# Gemfile
gem "pay", "~> 11.6"
```

```bash
bundle install
bin/rails generate pay:install
bin/rails db:migrate
```

```ruby
# app/models/user.rb
class User < ApplicationRecord
  pay_customer
end
```

That's the minimum viable setup. The rest of this post walks through configuring Stripe, wiring webhooks, and creating a subscription.

## What is Pay?

The Pay gem is a library for handling payments and subscriptions in Rails. It abstracts many common tasks, such as:

- Creating and managing customer records on Stripe.
- Handling subscriptions, invoices, and payment methods.
- Managing webhooks for real-time payment updates.

Instead of writing custom code to interact with the Stripe API, Pay provides a Rails-friendly interface that saves time and reduces complexity.

## How Does Pay Work?

Pay integrates with your Rails models to handle payments and subscriptions. For example, you can add a pay_customer relationship to your User model, allowing each user to manage their payments. Pay also listens for webhooks from Stripe, so your app stays updated when payments are made or subscriptions change.

## Setting Up Pay for Stripe

Here’s how to get started:

#### 1. Install the Gem

Add Pay to your Gemfile and install it:

```ruby
gem "pay", "~> 11.6"
```

Run the `bundle install` command to install it:

```bash
bundle install
```

Pay 11.x targets Rails 6.0+ and uses Stripe API version `2022-11-15`. If you're on an older Pay release, read the [UPGRADE guide](https://github.com/pay-rails/pay/blob/main/UPGRADE.md) before bumping - the migrations changed shape between major versions.

#### 2. Configure Pay

Run the generator to set up Pay’s migrations and configuration:

```bash
rails generate pay:install  
rails db:migrate  
```

Edit the generated `config/initializers/pay.rb` file to enable Stripe:

```ruby
Pay.setup do |config|
  config.adapters = [:stripe] # Add Stripe as the payment adapter
  config.default_product_name = "My Awesome App"
  config.default_plan_name = "default-plan"
end
```

Set your Stripe keys in your environment variables or `credentials.yml.enc`:

```yaml
stripe:
  public_key: pk_live_12345
  secret_key: sk_live_12345
  webhook_secret: whsec_12345
```

#### 3. Connect Pay to Your Models

In your User model, add the `Pay::Billable` module with using `pay_customer` method:

```ruby
class User < ApplicationRecord
  pay_customer
end
```

This allows users to have payment methods, subscriptions, and invoices.

### 4. Set Up Stripe Webhooks

To handle real-time updates from Stripe, set up a webhook endpoint. Run this command:

```bash
rails generate pay:webhooks
```

This creates a `Pay::Webhooks::StripeController` that processes Stripe events. Register the webhook URL in the Stripe dashboard, typically at:

```ruby
https://your-app.com/pay/webhooks/stripe
```

## Example: Creating a Subscription

Here’s a simple example of how to create a subscription:

#### 1. Add a Button for Payment

In your view, include a form to collect a payment method:

```erb
<%= form_with url: stripe_payment_method_path, method: :post do %>
  <div id="card-element"></div>
  <button type="submit">Submit Payment</button>
<% end %>
```

Stripe provides JavaScript tools to handle card input fields securely.

#### 2. Attach a Payment Method to the User

In the controller:

```ruby
class StripeController < ApplicationController
  def create_payment_method
    current_user.payment_processor = :stripe
    current_user.payment_processor.save_payment_method(params[:payment_method_id])
    redirect_to subscriptions_path, notice: "Payment method saved!"
  end
end
```

#### 3. Create a Subscription

Now, you can create a subscription for the user:

```ruby
class SubscriptionsController < ApplicationController
  def create
    current_user.payment_processor.subscribe(plan: "default-plan")
    redirect_to dashboard_path, notice: "Subscription created!"
  end
end
```

## How Pay Keeps Things Simple

Instead of directly interacting with the Stripe API, Pay handles the heavy lifting. It:

- Saves payment methods and creates customers on Stripe automatically.
- Manages recurring billing through its subscription methods.
- Ensures webhooks update your app without custom code.

## Conclusion

The Pay gem simplifies integrating Stripe with Rails. By abstracting common payment tasks, it lets you focus on your app's features instead of payment processing details.

If you're starting with payments in Rails, Pay is the path of least resistance - one gem covers Stripe, Paddle, Braintree, and Lemon Squeezy without locking you in.

If you're stuck wiring Stripe into an existing Rails app and your billing logic is starting to leak into half a dozen models, JetThoughts can help you ship a clean Pay-based subscription system in a few weeks.

<a class="cta-link" href="https://jetthoughts.com/services/app-web-development/">Get help integrating Stripe in your Rails app</a>
