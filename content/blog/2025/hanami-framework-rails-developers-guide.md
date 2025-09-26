---
title: "Hanami Framework for Rails Developers: Complete Guide"
description: "A comprehensive comparison of Hanami vs Rails for Ruby developers, covering architecture, migration strategies, and practical examples to help you choose the right framework."
slug: "hanami-framework-rails-developers-guide"
date: 2025-01-26
author: thoughtbot
categories: ["Ruby", "Framework Comparison", "Architecture"]
tags: ["hanami", "rails", "ruby", "framework", "architecture", "dry-rb", "migration"]
canonical_url: "https://thoughtbot.com/blog/hanami-framework-rails-developers-guide"
meta_description: "Compare Hanami vs Rails frameworks for Ruby development. Learn architecture differences, migration strategies, and when to choose Hanami over Rails with practical examples."
keywords: ["hanami framework", "hanami vs rails", "hanami ruby", "rails alternative", "ruby framework comparison", "hanami migration", "dry-rb ecosystem"]
---

The Ruby web development landscape has long been dominated by Rails, but Hanami has emerged as a compelling alternative that challenges conventional Ruby web application architecture. If you're a Rails developer curious about Hanami, this comprehensive guide will walk you through the key differences, architectural philosophies, and practical considerations for choosing between these frameworks.

## Introduction: Why Hanami Matters

Hanami (formerly known as Lotus) represents a different approach to Ruby web development. While Rails prioritizes convention over configuration and rapid prototyping, Hanami emphasizes clean architecture, explicit dependencies, and long-term maintainability. This isn't about one framework being "better" than the other—it's about understanding when each approach serves your project's needs.

### Key Philosophical Differences

**Rails Philosophy:**
- Convention over configuration
- Rapid development and prototyping
- Monolithic structure with shared concerns
- ActiveRecord pattern for data persistence
- "Omakase" approach—Rails makes decisions for you

**Hanami Philosophy:**
- Clean architecture and separation of concerns
- Explicit over implicit
- Modular design with clear boundaries
- Entity-repository pattern for data persistence
- Developer choice and flexibility

## Architecture Comparison: Foundation Differences

The most significant difference between Rails and Hanami lies in their architectural foundations. Let's examine how each framework approaches application structure.

### Rails Architecture: The Familiar MVC

Rails follows the traditional Model-View-Controller (MVC) pattern with some extensions:

```ruby
# Rails structure
app/
├── controllers/
├── models/
├── views/
├── helpers/
├── services/ (custom)
├── concerns/
└── jobs/
```

In Rails, models are typically ActiveRecord objects that handle both business logic and persistence:

```ruby
# Rails - User model
class User < ApplicationRecord
  has_many :orders
  validates :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def recent_orders
    orders.where(created_at: 1.month.ago..)
  end
end
```

### Hanami Architecture: Clean Separation

Hanami embraces Clean Architecture principles, separating concerns into distinct layers:

```ruby
# Hanami structure
app/
├── entities/          # Domain objects
├── repositories/      # Data access
├── interactors/       # Use cases
├── serializers/       # Data presentation
├── actions/          # HTTP handlers
├── views/            # View logic
└── templates/        # HTML templates

# Plus application slices for modularity
slices/
├── admin/
├── api/
└── web/
```

The same user concept in Hanami is split across multiple objects:

```ruby
# Hanami - User entity (domain logic only)
class User < Hanami::Entity
  attributes :id, :first_name, :last_name, :email, :created_at

  def full_name
    "#{first_name} #{last_name}"
  end
end

# Hanami - User repository (data access)
class UserRepository < Hanami::Repository
  associations do
    has_many :orders
  end

  def recent_orders_for(user)
    orders.where(user_id: user.id)
           .where { created_at >= 1.month.ago }
  end
end

# Hanami - Use case/interactor
class Users::Show
  include Deps[repo: "repositories.user"]

  def call(id:)
    user = repo.by_id(id)
    return failure(:not_found) unless user

    success(user: user)
  end
end
```

## Persistence Layer: ActiveRecord vs Entity-Repository

One of the most noticeable differences for Rails developers is how Hanami handles data persistence.

### ActiveRecord Pattern in Rails

Rails uses the ActiveRecord pattern where model objects represent database records:

```ruby
# Rails - Direct database interaction
user = User.find(1)
user.update(email: "new@example.com")
user.orders.create(total: 100.00)

# Query methods mixed with domain logic
User.where(active: true).includes(:orders)
```

**Pros:**
- Quick and intuitive for simple CRUD operations
- Less boilerplate code
- Familiar to most Ruby developers

**Cons:**
- Tight coupling between domain and persistence
- Difficult to test in isolation
- Complex queries can become unwieldy
- Domain objects depend on database structure

### Entity-Repository Pattern in Hanami

Hanami separates domain objects (entities) from data access (repositories):

```ruby
# Hanami - Clean separation
# Entity represents domain object
user = User.new(id: 1, email: "user@example.com")

# Repository handles persistence
user_repo = UserRepository.new
updated_user = user_repo.update(user.id, email: "new@example.com")

# Repositories contain query logic
active_users = user_repo.where(active: true).map_to(User)
```

**Pros:**
- Clear separation of concerns
- Domain objects independent of database
- Easier to test and modify
- Better support for complex business logic

**Cons:**
- More verbose for simple operations
- Steeper learning curve
- More objects to manage

## Dependency Injection and the dry-rb Ecosystem

Hanami 2.0+ heavily leverages the dry-rb ecosystem, particularly for dependency injection—a concept that Rails developers might find unfamiliar.

### Rails Approach: Global Dependencies

Rails typically uses global constants and class-level dependencies:

```ruby
# Rails - Global dependencies
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])  # Direct class reference
    @orders = OrderService.new.recent_for(@user)
  end
end
```

### Hanami Approach: Explicit Dependencies

Hanami uses dependency injection to make dependencies explicit:

```ruby
# Hanami - Explicit dependencies
module Web
  module Actions
    module Users
      class Show < Web::Action
        include Deps[
          repo: "repositories.user",
          order_service: "services.order"
        ]

        def handle(request, response)
          user = repo.by_id(request.params[:id])
          orders = order_service.recent_for(user)

          response[:user] = user
          response[:orders] = orders
        end
      end
    end
  end
end
```

This approach offers several advantages:

```ruby
# Easy testing with injected dependencies
RSpec.describe Web::Actions::Users::Show do
  subject { action }

  let(:action) { described_class.new(repo: repo, order_service: order_service) }
  let(:repo) { instance_double("UserRepository") }
  let(:order_service) { instance_double("OrderService") }

  it "handles user lookup" do
    allow(repo).to receive(:by_id).with(1).and_return(user)
    # Test without database dependencies
  end
end
```

## Application Structure: Monoliths vs Slices

### Rails: The Modular Monolith

Rails applications typically grow as single monoliths, though they can be modularized:

```ruby
# Rails - Traditional structure
app/
├── controllers/
│   ├── users_controller.rb
│   ├── admin/
│   │   └── users_controller.rb
│   └── api/
│       └── v1/
│           └── users_controller.rb
├── models/
│   └── user.rb
└── views/
    ├── users/
    ├── admin/
    └── api/
```

### Hanami: Slices for Modular Architecture

Hanami 2.0 introduces "slices"—modular boundaries within your application:

```ruby
# Hanami - Slice-based structure
slices/
├── web/              # Public website
│   ├── actions/
│   ├── views/
│   └── templates/
├── admin/            # Admin interface
│   ├── actions/
│   ├── views/
│   └── templates/
└── api/              # API endpoints
    ├── actions/
    ├── serializers/
    └── validators/

# Each slice has its own container and dependencies
# slices/web/slice.rb
module Web
  class Slice < Hanami::Slice
    import keys: ["repositories.user"], from: :main
  end
end
```

This structure provides:
- Clear module boundaries
- Isolated dependencies per slice
- Better organization for large applications
- Easier extraction to separate services

## Migration Considerations: When and How

### When to Consider Hanami

**Choose Hanami when:**

1. **Long-term maintenance is priority**: Clean architecture pays off in complex, long-lived applications
2. **Complex business logic**: Entity-repository pattern better supports rich domain models
3. **Team prefers explicit dependencies**: When magical behavior creates confusion
4. **Modular growth planned**: Slices support gradual service extraction
5. **Performance is critical**: Hanami has lower memory footprint and faster request handling

**Stick with Rails when:**

1. **Rapid prototyping needed**: Rails' conventions accelerate early development
2. **Team expertise in Rails**: Existing knowledge and ecosystem familiarity
3. **Gem ecosystem dependency**: Rails has broader third-party library support
4. **Simple CRUD applications**: ActiveRecord excels at straightforward data operations
5. **Time-to-market pressure**: Rails' code generation and conventions provide speed

### Migration Strategy: Gradual Transition

If migrating from Rails to Hanami, consider a gradual approach:

```ruby
# Phase 1: Extract business logic from models
class User < ApplicationRecord
  # Move business logic to service objects
  def full_name
    UserFormatter.new(self).full_name
  end
end

# Phase 2: Introduce repositories pattern
class UserRepository
  def self.by_email(email)
    User.find_by(email: email)
  end

  def self.active_users
    User.where(active: true)
  end
end

# Phase 3: Create entities
class UserEntity
  attr_reader :id, :first_name, :last_name, :email

  def initialize(attributes)
    # Initialize from ActiveRecord or hash
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
```

## Practical Code Examples: Side-by-Side Comparison

Let's look at implementing a common feature—user registration—in both frameworks:

### Rails Implementation

```ruby
# Rails - routes.rb
Rails.application.routes.draw do
  resources :users, only: [:new, :create]
end

# Rails - users_controller.rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome(@user).deliver_later
      redirect_to root_path, notice: "Welcome!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end

# Rails - user.rb
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
end
```

### Hanami Implementation

```ruby
# Hanami - routes.rb
module Web
  class Routes < Hanami::Routes
    get "/users/new", to: "users.new"
    post "/users", to: "users.create"
  end
end

# Hanami - user entity
class User < Hanami::Entity
  attributes :id, :first_name, :last_name, :email, :created_at

  def full_name
    "#{first_name} #{last_name}"
  end
end

# Hanami - user repository
class UserRepository < Hanami::Repository
  def create_with_attributes(attrs)
    create(attrs)
  end
end

# Hanami - validation
class UserContract < Dry::Validation::Contract
  params do
    required(:first_name).filled(:string)
    required(:last_name).filled(:string)
    required(:email).filled(:string)
  end

  rule(:email) do
    unless value.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      key.failure("must be a valid email")
    end
  end
end

# Hanami - action
module Web
  module Actions
    module Users
      class Create < Web::Action
        include Deps[
          repo: "repositories.user",
          mailer: "mailers.user"
        ]

        def handle(request, response)
          result = validate(request.params[:user])

          if result.success?
            user = repo.create_with_attributes(result.values)
            mailer.deliver(:welcome, user_id: user.id)

            response.redirect_to "/", flash: { notice: "Welcome!" }
          else
            response[:errors] = result.errors
            response.render view, status: 422
          end
        end

        private

        def validate(params)
          UserContract.new.call(params.to_h)
        end
      end
    end
  end
end
```

## Performance and Memory Considerations

Hanami typically outperforms Rails in several metrics:

### Memory Usage

```ruby
# Typical memory usage (approximate)
Rails application: 50-80MB base memory
Hanami application: 15-30MB base memory

# Request processing
Rails: 2-5MB per request
Hanami: 0.5-2MB per request
```

### Response Times

```ruby
# Benchmark results (simple JSON API)
Rails: 8-15ms average response
Hanami: 3-8ms average response

# Boot time
Rails: 5-15 seconds
Hanami: 1-3 seconds
```

These improvements come from:
- Lighter dependency graph
- More efficient request routing
- Lazy loading of components
- Smaller object allocation

## Ecosystem and Community

### Rails Ecosystem Advantages

- **Mature gem ecosystem**: 150,000+ gems available
- **Large community**: Extensive documentation, tutorials, Stack Overflow answers
- **Job market**: More opportunities and developers familiar with Rails
- **Third-party integrations**: SaaS tools often provide Rails-specific gems
- **Development tools**: Better IDE support, debugging tools, profilers

### Hanami Ecosystem

- **Growing community**: Smaller but passionate and helpful
- **dry-rb integration**: Access to excellent functional programming libraries
- **ROM integration**: Flexible data mapping capabilities
- **Modern Ruby practices**: Encourages current Ruby best practices
- **Clean architecture support**: Better tooling for enterprise-grade applications

## Decision Framework: Choosing Between Frameworks

Use this decision matrix to evaluate which framework fits your project:

| Factor | Rails | Hanami | Weight |
|--------|--------|---------|--------|
| **Team Experience** | High (familiar) | Low (learning curve) | High |
| **Development Speed** | Fast (conventions) | Slower (explicit) | Medium |
| **Long-term Maintenance** | Moderate | High (clean arch) | High |
| **Performance Requirements** | Adequate | Superior | Medium |
| **Business Logic Complexity** | Simple-Medium | Medium-High | High |
| **Third-party Dependencies** | Extensive | Limited | Medium |
| **Testing Requirements** | Good | Excellent | Medium |
| **Modular Growth** | Challenging | Natural | Low-Medium |

### Scoring Guide

Rate each factor (1-5) based on your project needs, multiply by weight, and sum:
- **Rails total > Hanami total**: Choose Rails
- **Hanami total > Rails total**: Consider Hanami
- **Close scores**: Evaluate team preferences and long-term vision

## Conclusion: The Right Tool for the Job

Both Rails and Hanami have their place in the Ruby ecosystem. Rails remains the pragmatic choice for rapid development, prototypes, and teams prioritizing speed-to-market. Its mature ecosystem and familiar patterns make it the safe choice for most projects.

Hanami shines when clean architecture, long-term maintainability, and performance matter more than development speed. It's particularly well-suited for complex business domains, applications planning to scale across teams, or projects where the business logic is more important than the web interface.

The choice isn't about which framework is "better"—it's about which aligns with your project's priorities, team expertise, and long-term vision. As the Ruby community continues to evolve, having options like Hanami pushes both frameworks to improve and gives developers tools for different problems.

Consider starting your next side project with Hanami to experience its architectural approach firsthand. You might discover that its explicit, modular design resonates with how you prefer to structure applications—or you might gain a deeper appreciation for Rails' conventions and rapid development capabilities.

Whether you're evaluating Hanami for a new project or considering migrating from Rails, having experienced Ruby developers guide your architectural decisions is crucial. Our [expert Ruby on Rails development team](/services/app-web-development/) has extensive experience with both Rails and alternative Ruby frameworks, helping companies make informed technology choices and implement clean, maintainable architectures that scale with their business needs.

Either way, understanding both frameworks makes you a more well-rounded Ruby developer and better equipped to choose the right tool for each unique challenge.

---

*Want to dive deeper into Hanami? Check out the [official Hanami guides](https://guides.hanamirb.org/) and the [dry-rb documentation](https://dry-rb.org/) to explore the ecosystem that powers modern Ruby architecture.*