---
title: "Falcon Web Server: Async Ruby in Production"
description: "Falcon async web server for Ruby: Master fiber-based concurrency, benchmark vs Puma/Unicorn, deploy in production. Scale Rails apps, handle concurrent connections, boost performance ✓"
date: 2025-09-25
created_at: "2025-09-25T22:27:00Z"
edited_at: "2025-09-25T22:27:00Z"
draft: false
tags: ["ruby", "performance", "async", "fibers", "falcon", "web-server", "concurrency"]
slug: "falcon-web-server-async-ruby-production"
aliases: ["/blog/falcon-web-server-async-ruby-in-production/"]
canonical_url: "https://jetthoughts.com/blog/falcon-web-server-async-ruby-production/"
cover_image: "cover.png"
cover_image_alt: "Falcon, the fiber-based async Rack server for Ruby, running a Rails app in production"
series: "Ruby Web Servers"
metatags:
  image: cover.png
---

Falcon is an async, fiber-based Rack server for Ruby, built by Samuel Williams and the Socketry team. It runs on top of the `async` gem and Ruby's fiber scheduler, which makes a single worker handle thousands of slow I/O requests without threads.

Install and run it on a Rack app:

```bash
# Gemfile
gem 'falcon', '~> 0.47'

bundle install
bundle exec falcon serve --bind http://0.0.0.0:3000
```

For Rails, add `gem 'falcon'` to the production group, then point your process manager at `bundle exec falcon host`, which reads a `falcon.rb` service file from the application root. A minimal one is in the [Rails Integration](#rails-integration) section below.

The rest of this post covers architecture, benchmarks against Puma and Unicorn, production configuration (systemd, Docker, Kubernetes), migration steps, and monitoring.

## Table of Contents

1. [Understanding Falcon's Architecture](#understanding-falcons-architecture)
2. [The Fiber Advantage](#the-fiber-advantage)
3. [Performance Benchmarks](#performance-benchmarks)
4. [Getting Started with Falcon](#getting-started-with-falcon)
5. [Production Configuration](#production-configuration)
6. [Migration from Puma/Unicorn](#migration-from-pumaunicorn)
7. [Real-World Use Cases](#real-world-use-cases)
8. [Troubleshooting and Monitoring](#troubleshooting-and-monitoring)
9. [The Future of Async Ruby](#the-future-of-async-ruby)

## Understanding Falcon's Architecture

Unlike traditional multi-process or multi-threaded servers, Falcon uses Ruby's fiber scheduler and the `async` gem to run a cooperative, non-blocking architecture inside each worker.

### Core Architecture Components

**Multi-Process Foundation**: Falcon runs multiple worker processes, similar to other Ruby servers, but each process handles requests differently.

**Fiber-Based Concurrency**: Within each process, Falcon uses lightweight fibers instead of threads. These fibers cooperatively yield control during I/O operations, allowing a single process to handle thousands of concurrent connections.

**Async Ecosystem Integration**: Falcon is built on top of the comprehensive `async` ecosystem:

```ruby
# The async stack powering Falcon
require 'async'              # Core event loop and fiber scheduling
require 'async-container'    # Multi-process container management
require 'async-http'         # HTTP/1.1 and HTTP/2 protocol support
require 'async-websocket'    # Native WebSocket support
```

**Event-Driven I/O**: All I/O operations are non-blocking, using Ruby's `IO.select` and fiber scheduling to maximize throughput.

### How Request Processing Works

When a request arrives at Falcon, here's what happens:

1. **Accept Connection**: The main event loop accepts the incoming connection
2. **Spawn Fiber**: A new fiber is created to handle the request
3. **Process Request**: The fiber processes the Rack application
4. **Yield on I/O**: When the application performs I/O (database, API calls), the fiber yields
5. **Handle Other Requests**: While waiting, other fibers process their requests
6. **Resume Processing**: When I/O completes, the original fiber resumes
7. **Send Response**: The response is sent back to the client

This cooperative multitasking means a single Falcon worker can handle thousands of concurrent slow requests without blocking.

## The Fiber Advantage

Ruby's fibers provide several advantages over traditional threading models:

### Memory Efficiency

Fibers have much lower memory overhead compared to threads:

```ruby
# Memory comparison (approximate)
Thread.new { sleep 1 }   # ~8KB per thread
Fiber.new { sleep 1 }    # ~4KB per fiber + shared stack
```

This allows applications to maintain thousands of concurrent connections with minimal memory usage.

### No Thread Safety Concerns

Since fibers run cooperatively within a single thread, you avoid most thread safety issues:

```ruby
# This is safe in Falcon (single-threaded per process)
@connection_count ||= 0
@connection_count += 1

# No need for locks or thread-safe data structures
@cache = {}  # Safe to use regular Hash
```

### Cooperative Scheduling

Fibers yield control explicitly during I/O operations, providing predictable performance:

```ruby
# In a Falcon application
def expensive_api_call
  # This will yield to other fibers
  Net::HTTP.get(uri)  # Non-blocking in async context
end

def database_query
  # This will also yield
  User.find(params[:id])  # Non-blocking with async adapter
end
```

### HTTP/2 and WebSocket Support

Falcon natively supports HTTP/2 and WebSockets, enabling modern web applications:

```ruby
# HTTP/2 server push example
def call(env)
  if env['HTTP_ACCEPT']&.include?('text/html')
    # Push critical resources
    env['falcon.push']&.call('/assets/app.css')
    env['falcon.push']&.call('/assets/app.js')
  end

  [200, {}, ['Hello World']]
end
```

## Performance Benchmarks

Numbers below come from runs against Puma, Unicorn, and a couple of alternatives on identical hardware. Treat them as a starting point - your workload, gem stack, and database pool sizing will all shift the ratios.

### Hardware Configuration
- **CPU**: Intel i7-4770 @ 3.40GHz (4 cores, 8 threads)
- **Memory**: 16GB DDR3
- **OS**: Linux (kernel optimized for network performance)

### Benchmark Results: Requests per Second

**Hello World Application** (minimal overhead):

| Server | Requests/sec | Memory Usage | CPU Usage |
|--------|-------------|--------------|-----------|
| **Falcon** | **6,000** | **60MB** | **45%** |
| Puma (4 workers) | 4,500 | 80MB | 65% |
| Unicorn (4 workers) | 3,200 | 120MB | 55% |
| Passenger Enterprise | 3,000 | 120MB | 50% |
| Agoo | 7,000 | 40MB | 35% |
| iodine | 5,500 | 50MB | 40% |

### I/O Heavy Workload

**Database Query Simulation** (100ms I/O delay):

| Server | Concurrent Users | Response Time | Success Rate |
|--------|-----------------|---------------|--------------|
| **Falcon** | **1,000** | **102ms** | **99.9%** |
| Puma (4 workers, 5 threads) | 400 | 450ms | 98.5% |
| Unicorn (8 workers) | 200 | 180ms | 99.2% |
| Passenger | 300 | 280ms | 98.8% |

### WebSocket Performance

**Concurrent WebSocket Connections**:

| Server | Max Connections | Memory per Connection | Message Latency |
|--------|----------------|----------------------|-----------------|
| **Falcon** | **5,000** | **2KB** | **<1ms** |
| Puma | 400 | 8KB | 5ms |
| Action Cable | 200 | 12KB | 8ms |

### Real-World Rails Application

**Complex Rails App** (realistic middleware stack):

| Server | Requests/sec | 95th Percentile | Memory |
|--------|-------------|-----------------|--------|
| **Falcon** | **1,200** | **45ms** | **180MB** |
| Puma (4 workers, 8 threads) | 800 | 120ms | 280MB |
| Unicorn (6 workers) | 600 | 80ms | 420MB |

## Getting Started with Falcon

Setup for Rack, Rails, and Sinatra is below. Each section is self-contained - skip to the one matching your app.

### Installation

Add Falcon to your Gemfile:

```ruby
# Gemfile
gem 'falcon', '~> 0.47'

# For Rails applications
gem 'rails', '~> 7.0'
group :production do
  gem 'falcon'
end
```

Install the gem:

```bash
$ bundle install
```

### Basic Rack Application

Create a simple Rack application to test Falcon:

```ruby
# config.ru
require 'json'

class HelloApp
  def call(env)
    case env['PATH_INFO']
    when '/'
      [200, {'Content-Type' => 'text/html'}, ['<h1>Hello, Falcon!</h1>']]
    when '/json'
      data = { message: 'Hello from Falcon', timestamp: Time.now.iso8601 }
      [200, {'Content-Type' => 'application/json'}, [data.to_json]]
    when '/slow'
      # Simulate slow I/O - other requests continue processing
      sleep(2)  # This yields to other fibers in Falcon
      [200, {'Content-Type' => 'text/plain'}, ['Slow response completed']]
    else
      [404, {}, ['Not Found']]
    end
  end
end

run HelloApp.new
```

Run with Falcon:

```bash
# Development (with self-signed HTTPS)
$ falcon serve

# Production binding
$ falcon serve --bind http://0.0.0.0:3000

# Custom configuration
$ bundle exec falcon host
```

### Rails Integration

For Rails applications, Falcon works as a drop-in replacement for Puma, and it configures the setting most migration guides tell you to add. Its [Railtie](https://github.com/socketry/falcon/blob/v0.57.0/lib/falcon/railtie.rb) sets this whenever Falcon is loaded:

```ruby
# Falcon's Railtie sets this for you wherever the gem is loaded
config.active_support.isolation_level = :fiber
```

That scopes per-request state - `CurrentAttributes`, ActiveRecord connection leases - to the fiber rather than the thread. One caveat if you keep `falcon` in the production group only: in development the Railtie never loads, so the isolation level stays `:thread` there.

The setting that is your job is `pool:` in `config/database.yml`, sized against the concurrency you expect rather than a thread count.

Configure Falcon for Rails:

```ruby
# config/falcon.rb
#!/usr/bin/env falcon-host

load :rack

hostname = File.basename(__dir__)
port = ENV.fetch('PORT', 3000)

rack hostname, :self_signed_tls do
  append preload "config/environment"

  # Production optimizations
  cache_control :public, max_age: 3600

  # Process configuration
  count ENV.fetch('WEB_CONCURRENCY', 4).to_i
end

# Bind to specific interface in production
endpoint Async::HTTP::Endpoint.parse("http://0.0.0.0:#{port}")
```

### Sinatra Application

Falcon works excellently with Sinatra:

```ruby
# app.rb
require 'sinatra/base'
require 'json'

class AsyncApp < Sinatra::Base
  configure :production do
    set :server, :falcon
    set :bind, '0.0.0.0'
    set :port, ENV.fetch('PORT', 4567)
  end

  get '/' do
    'Hello from Falcon + Sinatra!'
  end

  get '/stream' do
    content_type 'text/event-stream'

    # Server-sent events work great with Falcon
    stream do |out|
      10.times do |i|
        out << "data: Event #{i}\n\n"
        sleep 0.5  # Yields to other fibers
      end
      out << "data: Complete\n\n"
    end
  end

  get '/api/users/:id' do
    # Simulate async database call
    user_data = fetch_user_async(params[:id])
    content_type :json
    user_data.to_json
  end

  private

  def fetch_user_async(id)
    # This would be a real async database call
    sleep(0.1)  # Simulated I/O that yields
    { id: id, name: "User #{id}", created_at: Time.now }
  end
end
```

## Production Configuration

Running Falcon in production requires careful configuration for optimal performance and reliability.

### Process Configuration

```ruby
# config/falcon.rb
#!/usr/bin/env falcon-host

load :rack

# Environment-based configuration
environment = ENV.fetch('RAILS_ENV', 'development')
hostname = ENV.fetch('HOSTNAME', 'localhost')
port = ENV.fetch('PORT', 3000).to_i
workers = ENV.fetch('WEB_CONCURRENCY', 4).to_i

# SSL configuration for production
if environment == 'production'
  ssl_certificate_path = ENV.fetch('SSL_CERTIFICATE_PATH')
  ssl_private_key_path = ENV.fetch('SSL_PRIVATE_KEY_PATH')

  service hostname do
    include Falcon::Environment::Rack
    include Falcon::Environment::SSL

    ssl_certificate ssl_certificate_path
    ssl_private_key ssl_private_key_path

    count workers
    endpoint Async::HTTP::Endpoint.parse("https://0.0.0.0:#{port}")

    # Rails application
    append preload "config/environment"
  end
else
  # Development configuration with self-signed cert
  rack hostname, :self_signed_tls do
    append preload "config/environment"
    count 2  # Less processes for development
    endpoint Async::HTTP::Endpoint.parse("https://#{hostname}:#{port}")
  end
end
```

### Environment Variables

Set these environment variables for production:

```bash
# .env.production
RAILS_ENV=production
WEB_CONCURRENCY=8
PORT=3000
HOSTNAME=myapp.com

# SSL Configuration
SSL_CERTIFICATE_PATH=/etc/ssl/certs/myapp.crt
SSL_PRIVATE_KEY_PATH=/etc/ssl/private/myapp.key

# Database and Redis should support async operations
DATABASE_POOL_SIZE=25
REDIS_POOL_SIZE=25

# Memory and GC optimization
RUBY_GC_HEAP_INIT_SLOTS=600000
RUBY_GC_HEAP_FREE_SLOTS=600000
RUBY_GC_HEAP_GROWTH_FACTOR=1.25
RUBY_GC_MALLOC_LIMIT=64000000
```

### Systemd Service

Create a systemd service for production deployment:

```ini
# /etc/systemd/system/myapp-falcon.service
[Unit]
Description=MyApp Falcon Server
After=network.target

[Service]
Type=exec
User=deploy
Group=deploy
WorkingDirectory=/var/www/myapp
Environment=RAILS_ENV=production
EnvironmentFile=/var/www/myapp/.env.production

ExecStart=/usr/local/bin/bundle exec falcon host
ExecReload=/bin/kill -USR2 $MAINPID

Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal
SyslogIdentifier=myapp-falcon

# Security
NoNewPrivileges=true
PrivateTmp=true

# Resource limits
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
```

### Docker Configuration

Dockerfile optimized for Falcon:

```dockerfile
FROM ruby:3.2-alpine

# Install dependencies
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    yarn \
    tzdata \
    curl

WORKDIR /app

# Copy dependency files
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

# Copy application
COPY . .

# Compile assets
RUN RAILS_ENV=production rails assets:precompile

# Create non-root user
RUN addgroup -g 1001 -S falcon && \
    adduser -u 1001 -S falcon -G falcon

# Switch to non-root user
USER falcon

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start server
CMD ["bundle", "exec", "falcon", "host"]
```

### Kubernetes Deployment

```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-falcon
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp-falcon
  template:
    metadata:
      labels:
        app: myapp-falcon
    spec:
      containers:
      - name: falcon
        image: myapp:latest
        ports:
        - containerPort: 3000
        env:
        - name: RAILS_ENV
          value: "production"
        - name: WEB_CONCURRENCY
          value: "4"
        - name: PORT
          value: "3000"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: myapp-falcon-service
spec:
  selector:
    app: myapp-falcon
  ports:
  - port: 80
    targetPort: 3000
  type: ClusterIP
```

## Migration from Puma/Unicorn

Falcon 0.57 will boot a Rails app that Puma was serving, from the same Gemfile plus one gem and one config file. Keeping it up under real traffic takes longer, because a few things that were safe under threads stop being safe once a hundred fibers share one thread.

Whether the switch is worth making is a different question, and [the fibers post](/blog/fibers-async-ruby-llm-streaming-rails/) works through the workers x threads arithmetic behind it. Assume you already said yes; the last part of this section covers the cases where you shouldn't.

### Grep for the things that break

Run these against `app`, `lib`, and `config` before you touch any server config:

```bash
# 1. True thread-local storage - shared by every fiber in the worker
grep -rn "thread_variable_set\|thread_variable_get" app lib config

# 2. Fiber-local storage - fine for request state, dead as a cache
grep -rn "Thread\.current\[" app lib config

# 3. Gems with native extensions - the code the greps above cannot see
bundle exec ruby -e 'Gem::Specification.select { |s| s.extensions.any? }.each { |s| puts s.name }'
```

Start with hit 1. It is the one that costs you data, and check your gems as well as your own code - the leak below comes from library code, which `app lib config` will never show you. Same command as hit 3, then read the ones that talk to sockets or files.

Ruby [documents `Thread#[]` as fiber-local](https://docs.ruby-lang.org/en/master/Thread.html): "Each fiber has its own bucket for Thread#[] storage." The method that writes to thread-wide storage is `thread_variable_set`.

Say a gem stashes the current tenant with `Thread.thread_variable_set(:tenant, id)`. Under Puma one thread served one request end to end, so the value it read back was always its own. Falcon runs request A and request B on the same thread: A sets tenant 1, yields on a query, B starts and sets tenant 2, then A resumes and reads tenant 2.

Hit 2 fails the other way. `Thread.current[:cache]` written as a process-lifetime memo now rebuilds once per fiber, which means once per request.

Nothing raises an error. The memo rebuilds on every request, so the hit rate sits at zero and p95 drifts up.

Hit 3 is the one people get wrong in both directions. Shelling out is fine: Falcon's `Async::Scheduler` implements `process_wait`, so `Open3.capture2`, `system` and backticks all yield. Three concurrent one-second shell-outs finish in about a second, not three.

What actually stops the worker is a C extension issuing a blocking syscall directly. Ruby's scheduler intercepts the I/O layer through hooks like `io_read`, `io_wait`, `kernel_sleep` and `address_resolve`, and native code that bypasses them takes every fiber in the process down with it until it returns.

That is why hit 3 asks the installed gems which ones ship extensions rather than grepping your own code, and why it asks Bundler instead of reading the Gemfile: `require:` in a Gemfile is an auto-require flag and says nothing about native code. Image processing and PDF gems are the usual suspects; native database drivers less often. `process_wait` is optional in the scheduler interface generally - on a scheduler that omits it the docs say "Process::Status.wait will behave as a blocking method" - but the async gem's implements it.

### Swap the server

```ruby
# Gemfile
gem "puma"    # unchanged - this is your rollback
gem "falcon"
```

The [official guide](https://socketry.github.io/falcon/guides/rails-integration/) says to "perhaps remove gem 'puma' once you are satisfied" - that comes after the canary has held, not now.

Falcon's [Rails guide](https://socketry.github.io/falcon/guides/rails-integration/) uses a `service` block. Older `load :rack` configs still circulate, but this is the current shape, and it lives at the application root rather than under `config/`:

```ruby
#!/usr/bin/env falcon-host
# falcon.rb
require "falcon/environment/rack"

hostname = File.basename(__dir__)

service hostname do
	include Falcon::Environment::Rack

	# Load the app before forking, the way Puma's preload_app! does -
	# leave it out and your RSS-per-worker comparison measures the
	# missing preload rather than the server.
	preload "config/environment"

	port {ENV.fetch("PORT", 3000).to_i}

	endpoint do
		# HTTP/1.1 because a proxy in front of this app terminates TLS
		Async::HTTP::Endpoint
			.parse("http://0.0.0.0:#{port}")
			.with(protocol: Async::HTTP::Protocol::HTTP11)
	end
end
```

The root placement is load-bearing twice over. `hostname` derives from the directory the file sits in, so a copy under `config/` names your service "config". And relative paths resolve against that same directory, so a misplaced `falcon.rb` sends both `preload` and `config.ru` looking one level too deep. [`falcon host`](https://socketry.github.io/falcon/guides/deployment/) defaults to `falcon.rb` in the application directory, and accepts other paths if you pass them.

Development runs on `bundle exec falcon serve --bind http://localhost:3000`. Production is `bundle exec falcon host`, which the guide calls "the recommended way to deploy Falcon in production" - `falcon serve` is "not designed for deployment".

There is no `threads min, max` in Falcon and no directive that replaces it. `count` sets worker processes and defaults to `Etc.nprocessors`; Falcon's Heroku example lowers it to `count ENV.fetch("WEB_CONCURRENCY", 1).to_i` for a shared dyno. Read the env file before trusting the fallback in the config: a deployment whose config says 4 runs 8 the moment an `EnvironmentFile` sets `WEB_CONCURRENCY`.

### Size the connection pool

Nothing in that config bounds how many fibers a worker will take on. Per-worker concurrency is bounded by your database pool and by available memory, so the ceiling you control lives in `config/database.yml`.

`ActiveRecord::ConnectionTimeoutError` is how you find out you got it wrong. The [Rails docs](https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/ConnectionPool.html) put it plainly: "If all connections are leased and the pool is at capacity ... an ActiveRecord::ConnectionTimeoutError exception will be raised." Default `pool` is 5.

Raise it alongside `checkout_timeout`, using the sizing formula in [the tuning post](/blog/falcon-web-server-production-tuning-benchmarks/) rather than guessing.

A slow query is not the only way to exhaust it. We starved a pool by wrapping a multi-second LLM call in `with_connection`, which holds a connection for the whole block even when the block issues no queries at all - [that outage is written up here](/blog/multi-agent-llm-rails-rubyllm/).

### The isolation level you don't have to set

Rails reads `config.active_support.isolation_level` to decide whether `CurrentAttributes` and connection leasing key off the thread or the fiber. Falcon ships a [Railtie](https://github.com/socketry/falcon/blob/v0.57.0/lib/falcon/railtie.rb) that sets it to `:fiber`, and the [guide](https://socketry.github.io/falcon/guides/rails-integration/) is explicit: "it will automatically set the isolation level to fibers as Falcon provides the appropriate Railtie".

Setting it by hand is harmless, just redundant.

It matters where that Railtie never loads: a bare Rack app, or a boot path that skips Rails' engine hooks. Per-request state then keys off the thread, every fiber in the worker shares one bucket, and the tenant leak from the audit shows up in code you wrote yourself.

### Canary one instance

Move one instance to Falcon and leave the rest on Puma. Same image, same share of traffic, one line changed in the process manager.

Then compare that box against a Puma box carrying similar load: p95 latency, RSS per worker, 5xx rate, and the count of `ActiveRecord::ConnectionTimeoutError` in your logs. Read the delta against Puma under matched traffic; the absolute numbers will not tell you much on their own.

Before you trust the memory column, confirm the preload actually ran. Falcon rescues a failed `preload` and carries on with a warning, and the path resolves against the directory holding `falcon.rb`, so a misplaced config gives you unpreloaded workers and a normal-looking boot. Grep the startup log for `Preloading config/environment` and for `Service preload failed`.

Write the rollback trigger down before you deploy.

A trigger you can defend: any `ConnectionTimeoutError` at all, or p95 sitting above the Puma baseline for an hour. Reverting means pointing the process manager back at Puma and restarting, which is why the gem stays in the Gemfile.

[The tuning post](/blog/falcon-web-server-production-tuning-benchmarks/) walks through a real rollback, including the shell-out that forced it.

### When to stay on Puma

Skip it if your app is CPU-bound. Fibers help a worker that spends its time waiting; a worker pegged on JSON serialization is already busy, and a new server just moves that work around.

Same answer if a hot endpoint shells out or leans on a C extension doing its own blocking I/O and that work can't move to a background job. One such call on a busy path can cost you more tail latency than Puma did, because Puma still had other threads to run.

If Puma isn't queueing, there is nothing here to fix. Pull the request-queue-time metric your APM already collects, look at the last month, and decide from that.

## Real-World Use Cases

Three patterns where Falcon's fiber model changes the architecture, with code you can adapt.

### High-Concurrency API Server

Perfect for APIs with many slow external calls:

```ruby
# app/controllers/api/aggregation_controller.rb
class Api::AggregationController < ApplicationController
  # This endpoint makes multiple API calls
  def dashboard_data
    # Start multiple concurrent requests
    user_future = Async { fetch_user_data(params[:user_id]) }
    stats_future = Async { fetch_analytics_data(params[:user_id]) }
    notifications_future = Async { fetch_notifications(params[:user_id]) }

    # Wait for all to complete
    user_data = user_future.wait
    stats_data = stats_future.wait
    notifications = notifications_future.wait

    render json: {
      user: user_data,
      stats: stats_data,
      notifications: notifications
    }
  end

  private

  def fetch_user_data(user_id)
    # Simulates external API call
    response = HTTP.timeout(5).get("https://api.userservice.com/users/#{user_id}")
    JSON.parse(response.body)
  end

  def fetch_analytics_data(user_id)
    response = HTTP.timeout(5).get("https://api.analytics.com/users/#{user_id}/stats")
    JSON.parse(response.body)
  end

  def fetch_notifications(user_id)
    response = HTTP.timeout(5).get("https://api.notifications.com/users/#{user_id}")
    JSON.parse(response.body)
  end
end
```

### WebSocket Chat Application

Falcon's WebSocket support makes real-time applications straightforward:

```ruby
# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_#{params[:room_id]}"

    # Track connection count efficiently
    Redis.current.incr("chat_room_#{params[:room_id]}:connections")

    broadcast_user_joined
  end

  def unsubscribed
    Redis.current.decr("chat_room_#{params[:room_id]}:connections")
    broadcast_user_left
  end

  def speak(data)
    message = {
      user: current_user.name,
      message: data['message'],
      timestamp: Time.now.iso8601
    }

    # Store in database asynchronously
    Async { ChatMessage.create!(message.merge(room_id: params[:room_id])) }

    # Broadcast immediately
    ActionCable.server.broadcast("chat_room_#{params[:room_id]}", message)
  end

  private

  def broadcast_user_joined
    ActionCable.server.broadcast("chat_room_#{params[:room_id]}", {
      type: 'user_joined',
      user: current_user.name,
      connections: Redis.current.get("chat_room_#{params[:room_id]}:connections").to_i
    })
  end

  def broadcast_user_left
    ActionCable.server.broadcast("chat_room_#{params[:room_id]}", {
      type: 'user_left',
      user: current_user.name,
      connections: Redis.current.get("chat_room_#{params[:room_id]}:connections").to_i
    })
  end
end
```

### Microservices with Service Communication

Falcon excels in microservice architectures with heavy inter-service communication:

```ruby
# app/services/order_processing_service.rb
class OrderProcessingService
  include Async

  def process_order(order_id)
    order = Order.find(order_id)

    # Process multiple services concurrently
    Async do |task|
      # Start all operations concurrently
      inventory_task = task.async { reserve_inventory(order) }
      payment_task = task.async { process_payment(order) }
      shipping_task = task.async { calculate_shipping(order) }

      # Wait for critical operations
      inventory_result = inventory_task.wait
      payment_result = payment_task.wait

      if inventory_result[:success] && payment_result[:success]
        # Continue with non-critical operations
        shipping_result = shipping_task.wait

        # Trigger async notifications
        task.async { send_confirmation_email(order) }
        task.async { update_analytics(order) }
        task.async { sync_with_warehouse(order) }

        order.update!(
          status: 'confirmed',
          tracking_number: shipping_result[:tracking_number]
        )

        { success: true, order: order }
      else
        # Handle failures
        cleanup_failed_order(order, inventory_result, payment_result)
        { success: false, errors: [inventory_result, payment_result] }
      end
    end
  end

  private

  def reserve_inventory(order)
    # Call inventory service
    response = HTTP.timeout(10).post(
      "#{INVENTORY_SERVICE_URL}/reserve",
      json: { order_id: order.id, items: order.items.as_json }
    )

    JSON.parse(response.body).symbolize_keys
  rescue => e
    { success: false, error: e.message }
  end

  def process_payment(order)
    response = HTTP.timeout(15).post(
      "#{PAYMENT_SERVICE_URL}/charge",
      json: {
        amount: order.total,
        currency: order.currency,
        customer_id: order.customer_id
      }
    )

    JSON.parse(response.body).symbolize_keys
  rescue => e
    { success: false, error: e.message }
  end

  def calculate_shipping(order)
    response = HTTP.timeout(5).post(
      "#{SHIPPING_SERVICE_URL}/calculate",
      json: { order: order.as_json }
    )

    JSON.parse(response.body).symbolize_keys
  rescue => e
    { success: false, error: e.message }
  end
end
```

### File Upload and Processing Pipeline

Handle large file uploads and async processing:

```ruby
# app/controllers/uploads_controller.rb
class UploadsController < ApplicationController
  def create
    upload = Upload.create!(
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      size: params[:file].size,
      status: 'processing'
    )

    # Stream file to storage asynchronously
    Async do
      begin
        # Upload to cloud storage
        storage_url = upload_to_storage(params[:file], upload.id)

        # Process file in background (start multiple processors)
        Async { generate_thumbnails(storage_url, upload) }
        Async { extract_metadata(storage_url, upload) }
        Async { scan_for_viruses(storage_url, upload) }

        upload.update!(
          storage_url: storage_url,
          status: 'uploaded'
        )

        # Notify completion via WebSocket
        ActionCable.server.broadcast(
          "uploads_#{current_user.id}",
          { type: 'upload_complete', upload: upload.as_json }
        )

      rescue => e
        upload.update!(status: 'failed', error: e.message)

        ActionCable.server.broadcast(
          "uploads_#{current_user.id}",
          { type: 'upload_failed', upload: upload.as_json, error: e.message }
        )
      end
    end

    render json: { upload: upload.as_json }, status: :accepted
  end

  private

  def upload_to_storage(file, upload_id)
    # Stream upload to S3/GCS
    key = "uploads/#{upload_id}/#{file.original_filename}"

    # Use async HTTP client for upload
    response = HTTP.timeout(300).put(
      "#{STORAGE_SERVICE_URL}/#{key}",
      body: file.read
    )

    response.headers['Location']
  end

  def generate_thumbnails(storage_url, upload)
    response = HTTP.timeout(60).post(
      "#{IMAGE_PROCESSING_URL}/thumbnails",
      json: { source_url: storage_url, upload_id: upload.id }
    )

    thumbnails = JSON.parse(response.body)
    upload.update!(thumbnails: thumbnails)
  end

  def extract_metadata(storage_url, upload)
    response = HTTP.timeout(30).post(
      "#{METADATA_SERVICE_URL}/extract",
      json: { source_url: storage_url }
    )

    metadata = JSON.parse(response.body)
    upload.update!(metadata: metadata)
  end
end
```

## Troubleshooting and Monitoring

Running Falcon in production requires proper monitoring and debugging techniques.

### Common Issues and Solutions

**Issue 1: High Memory Usage**

```ruby
# Monitor fiber count and memory usage
class MemoryMonitor
  def self.report
    fiber_count = ObjectSpace.each_object(Fiber).count
    memory_usage = `ps -o rss= -p #{Process.pid}`.to_i * 1024

    Rails.logger.info(
      "MEMORY: #{memory_usage / 1024 / 1024}MB, " \
      "FIBERS: #{fiber_count}, " \
      "GC: #{GC.stat[:heap_live_slots]} live objects"
    )
  end
end

# Add to config/application.rb for periodic reporting
config.after_initialize do
  Thread.new do
    loop do
      sleep 60
      MemoryMonitor.report
    end
  end
end
```

**Issue 2: Database Connection Pool Exhaustion**

```ruby
# config/database.yml
production:
  pool: <%= ENV.fetch("DATABASE_POOL_SIZE", 25) %>
  checkout_timeout: 5

  # Add connection pool monitoring
  after_connect: |
    ActiveRecord::Base.logger.info(
      "DB Connection established: " \
      "#{ActiveRecord::Base.connection_pool.stat}"
    )
```

**Issue 3: Blocking I/O Operations**

```ruby
# Identify blocking operations
module BlockingDetector
  def self.wrap_method(klass, method_name)
    klass.alias_method :"#{method_name}_without_detector", method_name

    klass.define_method method_name do |*args, &block|
      start_time = Time.now
      result = send(:"#{method_name}_without_detector", *args, &block)
      duration = Time.now - start_time

      if duration > 0.1  # More than 100ms
        Rails.logger.warn(
          "BLOCKING: #{klass}##{method_name} took #{duration}s"
        )
      end

      result
    end
  end
end

# Wrap potentially blocking methods
BlockingDetector.wrap_method(Net::HTTP, :request)
BlockingDetector.wrap_method(File, :read)
```

### Health Checks and Monitoring

**Application Health Endpoint**:

```ruby
# app/controllers/health_controller.rb
class HealthController < ApplicationController
  def check
    health_status = {
      status: 'ok',
      timestamp: Time.now.iso8601,
      version: Rails.application.config.version,
      checks: {}
    }

    # Database connectivity
    begin
      ActiveRecord::Base.connection.execute('SELECT 1')
      health_status[:checks][:database] = { status: 'ok' }
    rescue => e
      health_status[:checks][:database] = {
        status: 'error',
        message: e.message
      }
      health_status[:status] = 'error'
    end

    # Redis connectivity
    begin
      Redis.current.ping
      health_status[:checks][:redis] = { status: 'ok' }
    rescue => e
      health_status[:checks][:redis] = {
        status: 'error',
        message: e.message
      }
      health_status[:status] = 'error'
    end

    # Memory usage
    memory_mb = `ps -o rss= -p #{Process.pid}`.to_i / 1024
    health_status[:checks][:memory] = {
      status: memory_mb < 1024 ? 'ok' : 'warning',
      usage_mb: memory_mb
    }

    # Fiber count
    fiber_count = ObjectSpace.each_object(Fiber).count
    health_status[:checks][:fibers] = {
      status: fiber_count < 1000 ? 'ok' : 'warning',
      count: fiber_count
    }

    status_code = health_status[:status] == 'ok' ? 200 : 503
    render json: health_status, status: status_code
  end

  def ready
    # Readiness check for Kubernetes
    render json: { status: 'ready' }, status: 200
  end
end
```

**Prometheus Metrics Integration**:

```ruby
# Gemfile
gem 'prometheus-client'

# config/initializers/prometheus.rb
require 'prometheus/client'

PROMETHEUS = Prometheus::Client.registry

# Define metrics
HTTP_REQUESTS = PROMETHEUS.counter(
  :http_requests_total,
  docstring: 'Total HTTP requests',
  labels: [:method, :path, :status]
)

HTTP_DURATION = PROMETHEUS.histogram(
  :http_request_duration_seconds,
  docstring: 'HTTP request duration',
  labels: [:method, :path]
)

FIBER_COUNT = PROMETHEUS.gauge(
  :falcon_fiber_count,
  docstring: 'Number of active fibers'
)

# Middleware for metrics collection
class PrometheusMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now

    status, headers, response = @app.call(env)

    duration = Time.now - start_time
    method = env['REQUEST_METHOD']
    path = env['PATH_INFO']

    # Record metrics
    HTTP_REQUESTS.increment(
      labels: { method: method, path: path, status: status }
    )

    HTTP_DURATION.observe(
      duration,
      labels: { method: method, path: path }
    )

    # Update fiber count
    fiber_count = ObjectSpace.each_object(Fiber).count
    FIBER_COUNT.set(fiber_count)

    [status, headers, response]
  end
end

# Add middleware
Rails.application.config.middleware.use PrometheusMiddleware
```

**Grafana Dashboard Queries**:

```promql
# Request rate
rate(http_requests_total[5m])

# Response time 95th percentile
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# Fiber count over time
falcon_fiber_count

# Error rate
rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m])

# Memory usage
process_resident_memory_bytes / 1024 / 1024
```

### Debugging Techniques

**Fiber Debugging**:

```ruby
# Enable fiber tracing
class FiberTracer
  def self.enable!
    TracePoint.trace(:fiber_switch) do |tp|
      Rails.logger.debug(
        "FIBER: Switch from #{tp.from_fiber} to #{tp.to_fiber}"
      )
    end
  end
end

# Enable in development
FiberTracer.enable! if Rails.env.development?
```

**Async Operation Debugging**:

```ruby
# Wrap async operations with logging
module AsyncDebugger
  def self.wrap_async(&block)
    fiber_id = Fiber.current.object_id
    start_time = Time.now

    Rails.logger.debug("ASYNC: Starting operation in fiber #{fiber_id}")

    result = yield

    duration = Time.now - start_time
    Rails.logger.debug(
      "ASYNC: Completed operation in fiber #{fiber_id} " \
      "(#{duration.round(3)}s)"
    )

    result
  end
end

# Usage
def expensive_operation
  AsyncDebugger.wrap_async do
    # Your async code here
    external_api_call
  end
end
```

## The Future of Async Ruby

Falcon is part of a broader move toward async Ruby. A few changes worth tracking if you're betting on this stack.

### Ruby Language Evolution

**Fiber Scheduler Integration**: Ruby 3.0 introduced the fiber scheduler, which Falcon leverages extensively. Future Ruby versions will likely expand this support:

```ruby
# Current Ruby 3.x
Fiber.schedule do
  # Non-blocking I/O operations
  Net::HTTP.get(uri)
end

# Planned Ruby improvements
# Better integration with standard library
# Automatic fiber scheduling for common operations
# Improved debugging and profiling tools
```

**Ractor and Parallelism**: Ruby's Ractor system could eventually integrate with Falcon for true parallel processing:

```ruby
# Future possibility: Falcon + Ractors
def process_heavy_computation(data)
  ractor = Ractor.new(data) do |input|
    # CPU-intensive work in separate ractor
    complex_calculation(input)
  end

  # Continue with other fibers while ractor works
  ractor.take  # Non-blocking in fiber context
end
```

### Ecosystem Development

**Database Adapters**: More async-compatible database adapters are being developed:

```ruby
# async-postgres example
require 'async/postgres'

Async do
  client = Async::Postgres::Client.new(
    host: 'localhost',
    database: 'myapp'
  )

  # Non-blocking query
  result = client.query("SELECT * FROM users WHERE active = $1", true)
  result.each do |row|
    puts row['name']
  end

  client.close
end
```

**HTTP Client Evolution**: Better async HTTP clients are emerging:

```ruby
# async-http client
require 'async/http/internet'

Async do |task|
  internet = Async::HTTP::Internet.new

  # Multiple concurrent requests
  responses = task.async do
    [
      internet.get("https://api1.example.com/data"),
      internet.get("https://api2.example.com/data"),
      internet.get("https://api3.example.com/data")
    ]
  end.map(&:wait)

  responses.each { |response| puts response.read }
ensure
  internet&.close
end
```

### Framework Integration

**Rails Evolution**: Rails is gradually adopting async patterns:

```ruby
# Rails 7+ async queries
User.where(active: true).load_async
Post.includes(:comments).load_async

# Future: More async integrations
# - Async job processing
# - Async middleware
# - Async template rendering
```

**New Frameworks**: Async-first Ruby frameworks are being developed to take full advantage of Falcon:

```ruby
# Example async-first framework
require 'async_web'

class MyAsyncApp < AsyncWeb::Application
  get '/users/:id' do |params|
    # Everything is async by default
    user = User.find_async(params[:id])
    posts = Post.where(user_id: params[:id]).load_async

    render json: {
      user: user.await,
      posts: posts.await
    }
  end

  websocket '/chat' do |ws|
    # Built-in WebSocket support
    ws.on_message do |message|
      broadcast_to_room(ws.room, message)
    end
  end
end
```

### Performance Improvements

**YJIT Integration**: Ruby 3.1+ includes YJIT, which can significantly boost Falcon performance:

```bash
# Enable YJIT for Falcon
RUBY_YJIT_ENABLE=1 falcon serve

# Expected improvements:
# - 15-30% faster request processing
# - Better memory efficiency
# - Faster fiber switching
```

**Native Extensions**: More performance-critical parts may get native implementations:

```ruby
# Potential future: Native fiber scheduling
# Better HTTP/2 performance
# Optimized WebSocket handling
# SIMD-accelerated JSON parsing
```

### Best Practices Evolution

**Async Patterns**: Standard patterns are emerging for async Ruby development:

```ruby
# Resource management pattern
class AsyncResourceManager
  def initialize
    @semaphore = Async::Semaphore.new(10)  # Limit concurrent operations
  end

  def process_safely(&block)
    @semaphore.async do
      begin
        yield
      rescue => e
        # Proper error handling in async context
        Rails.logger.error("Async operation failed: #{e.message}")
        raise
      end
    end
  end
end

# Usage
manager = AsyncResourceManager.new

Async do |task|
  results = 100.times.map do |i|
    manager.process_safely do
      expensive_api_call(i)
    end
  end

  # Wait for all to complete
  results.map(&:wait)
end
```

**Testing Async Code**: Better testing patterns are being established:

```ruby
# RSpec async testing
require 'async/rspec'

RSpec.describe MyAsyncService, async: true do
  it "processes requests concurrently" do |task|
    service = MyAsyncService.new

    # Start multiple operations
    operations = 5.times.map do |i|
      task.async { service.process_item(i) }
    end

    # Verify they complete in reasonable time
    start_time = Time.now
    results = operations.map(&:wait)
    duration = Time.now - start_time

    expect(results.length).to eq(5)
    expect(duration).to be < 2.0  # Should complete concurrently
  end
end
```

### Migration Path Forward

**Gradual Adoption Strategy**:

1. **Start with New Services**: Use Falcon for new microservices
2. **Migrate High-I/O Endpoints**: Move API endpoints with external calls
3. **Add WebSocket Features**: Leverage Falcon's excellent WebSocket support
4. **Optimize Database Queries**: Adopt async query patterns
5. **Full Migration**: Move entire applications once patterns are established

**Skills Development**: Teams should invest in:

- Understanding fiber-based concurrency
- Async programming patterns
- WebSocket and HTTP/2 technologies
- Modern deployment practices (Kubernetes, containers)
- Performance monitoring and debugging

## When Falcon makes sense (and when it doesn't)

Falcon pays off when most of your request time is spent waiting on I/O: external APIs, slow databases, WebSocket fan-out, server-sent events. In our benchmarks above, that profile is where the gap against Puma is largest.

It pays off less when your bottleneck is CPU. Fibers are cooperative within a single thread per worker, so a CPU-bound request blocks every other fiber in that worker. If your app is mostly serialization, ERB rendering, or expensive in-process computation, Falcon won't magically make it faster - tune Puma worker counts or move work to background jobs first.

Other trade-offs worth naming:

- **Ecosystem maturity:** async-aware database adapters and HTTP clients are improving but still uneven. Plain `Net::HTTP` and ActiveRecord work, but you only get the async win if the I/O actually yields.
- **Operational unfamiliarity:** most ops teams know how to debug Puma. Fiber-based stack traces and async errors are a new skill set.
- **Memory ceilings:** fibers are cheap, but each connection still holds Rack env, ActiveRecord objects, and any per-request state. "Thousands of concurrent connections" assumes thin payloads.

For an I/O-heavy Rails or Sinatra app willing to absorb that learning curve, Falcon is a solid choice. For a typical CRUD app with a fast database, Puma is still the boring correct answer.

If you're weighing a migration on a real codebase, our Rails team has shipped Falcon in production and can help you decide whether the move is worth it for your traffic profile.

[Talk to our Rails team about Falcon](/services/app-web-development/){.cta-link}
