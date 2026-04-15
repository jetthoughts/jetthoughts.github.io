---
dev_to_id: null
title: "Rails 8 Deployment with Docker: Production-Ready Configuration Guide"
slug: rails-8-docker-deployment-production-guide
date: 2025-10-28
description: "Complete Rails 8 Docker deployment guide with production-ready configurations. Multi-stage builds, security hardening, performance optimization, and Kamal alternative strategies."
summary: "Master Rails 8 Docker deployments for production. Multi-stage Dockerfile, docker-compose orchestration, security best practices, performance tuning, and complete deployment workflow for modern Rails applications."
author: "JetThoughts Team"
draft: false
tags: ["rails", "docker", "deployment", "devops", "production", "rails-8"]
categories: ["Development", "Rails", "DevOps"]
cover_image: "cover.png"
canonical_url: "https://jetthoughts.com/blog/rails-8-docker-deployment-production-guide/"
metatags:
  image: cover.png
  og_title: "Rails 8 Docker Deployment: Production-Ready Configuration | JetThoughts"
  og_description: "Complete Rails 8 Docker deployment guide. Multi-stage builds, security hardening, performance optimization, production workflow."
  twitter_card: "summary_large_image"
  twitter_title: "Rails 8 Docker Deployment: Production-Ready Configuration"
  twitter_description: "Master Rails 8 Docker deployments. Multi-stage builds, security, performance, complete production workflow."
---

Stop guessing about Docker configs. This is the exact Dockerfile, docker-compose.yml, and deploy script we run in production for Rails 8 apps.

We've containerized six Rails apps in the past year. Every time, the same questions come up: multi-stage or single-stage? Nginx or [Thruster](/blog/kamal-integration-in-rails-8-by-default-ruby/)? How do you handle migrations during deploys? The configs below answer all of them -- tested against Rails 8 with Solid Queue, Solid Cache, and Propshaft.

One number worth knowing upfront: containerized deploys cut our rollback time from 30 minutes (Capistrano) to under 60 seconds (docker tag swap). That alone justifies the migration.

## Why Docker for Rails 8 Deployments

### The Modern Deployment Challenge

If you've ever spent a Friday night debugging why production has a different libvips version than staging, you already know the problem. Here's what Docker actually fixes:

#### Traditional Deployment Problems:
```yaml
Manual Setup Issues:
  - Ruby version management across servers
  - System dependency conflicts
  - Environment-specific configuration drift
  - Complex rollback procedures
  - Inconsistent development vs production environments

Operational Overhead:
  - Server provisioning time: 2-4 hours
  - Environment setup complexity: High
  - Deployment consistency: Variable
  - Rollback safety: Manual and risky
```

#### Docker Deployment Advantages:
```yaml
Containerized Benefits:
  - Ruby version: Locked in container image
  - Dependencies: Fully isolated and versioned
  - Configuration: Immutable container images
  - Rollbacks: Instant container version switch
  - Environments: Identical development to production

Operational Efficiency:
  - Server provisioning: <5 minutes
  - Environment setup: Automated
  - Deployment consistency: 100%
  - Rollback safety: Built-in and instant
```

### Rails 8 Docker-First Philosophy

Rails 8 made a bet: fewer external dependencies means simpler containers. [Solid Queue replaces Sidekiq](/blog/rails-8-solid-queue-migration-guide/), [Solid Cache replaces Redis](/blog/rails-8-solid-cache-performance-redis-migration/), and Propshaft replaces the Webpacker/Sprockets mess. The Docker setup gets dramatically simpler:

```ruby
# Rails 8 defaults align perfectly with Docker
Rails.application.configure do
  # Solid Queue: Database-backed jobs (no Redis needed)
  config.active_job.queue_adapter = :solid_queue

  # Solid Cache: Database-backed caching (no Memcached needed)
  config.cache_store = :solid_cache_store

  # Propshaft: Simplified asset pipeline
  config.assets.compile = false # Assets pre-compiled in Docker build

  # Fewer external dependencies = simpler Docker setup
end
```

## Production-Ready Dockerfile: Multi-Stage Build

### Complete Multi-Stage Dockerfile for Rails 8

```dockerfile
# syntax=docker/dockerfile:1

#############################################
# Stage 1: Base Image with Ruby and System Dependencies
#############################################
FROM ruby:3.2.2-slim AS base

# Set production environment
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test \
    NODE_ENV=production

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js and enable Corepack (for Yarn management)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    corepack enable && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /rails

#############################################
# Stage 2: Dependencies Installation
#############################################
FROM base AS dependencies

# Copy dependency files
COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

# Install Ruby dependencies
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3 && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Install JavaScript dependencies
RUN yarn install --frozen-lockfile --production && \
    yarn cache clean

#############################################
# Stage 3: Application Build (Assets Compilation)
#############################################
FROM base AS build

# Copy installed dependencies from dependencies stage
COPY --from=dependencies /usr/local/bundle /usr/local/bundle
COPY --from=dependencies /rails/node_modules /rails/node_modules

# Copy application code
COPY . .

# Precompile assets and bootsnap cache
RUN SECRET_KEY_BASE_DUMMY=1 \
    bundle exec rails assets:precompile && \
    bundle exec bootsnap precompile --gemfile app/ lib/

# Clean up unnecessary files to reduce image size
RUN rm -rf node_modules tmp/cache app/assets vendor/assets lib/assets spec

#############################################
# Stage 4: Final Production Image
#############################################
FROM ruby:3.2.2-slim AS production

# Set production environment
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Install runtime dependencies only (no build tools)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libpq5 \
    libvips && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user for security
RUN groupadd -g 1000 rails && \
    useradd -u 1000 -g rails -s /bin/bash -m rails

# Create app directory with proper permissions
WORKDIR /rails
RUN chown rails:rails /rails

# Copy built application from build stage
COPY --from=build --chown=rails:rails /usr/local/bundle /usr/local/bundle
COPY --from=build --chown=rails:rails /rails /rails

# Switch to non-root user
USER rails:rails

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:3000/up || exit 1

# Default command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
```

### Dockerfile Optimization Techniques

#### Image Size Optimization:

```dockerfile
# Before optimization: ~1.2GB final image
FROM ruby:3.2.2
RUN apt-get update && apt-get install -y build-essential nodejs
COPY . /rails
RUN bundle install
CMD ["rails", "server"]

# After optimization: ~350MB final image
# Multi-stage build (shown above) achieves:
# - Separate build dependencies from runtime
# - Clean up unnecessary files
# - Use slim base images
# - Remove build artifacts
```

#### Layer Caching Optimization:

```dockerfile
# Inefficient: Changes to app code invalidate all layers
COPY . /rails
RUN bundle install
RUN rails assets:precompile

# Efficient: Separate dependency installation from app code
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . /rails
RUN rails assets:precompile
# Now dependency installation is cached unless Gemfile changes
```

#### Build Performance Comparison:

| Technique | Initial Build | Rebuild (code change) | Image Size |
|-----------|---------------|----------------------|------------|
| **Single-stage naive** | 8 minutes | 8 minutes | 1.2GB |
| **Multi-stage basic** | 7 minutes | 6 minutes | 850MB |
| **Multi-stage optimized** | 6 minutes | 2 minutes | 350MB |

## Docker Compose: Complete Development Stack

### Production-Like Development Environment

```yaml
# docker-compose.yml
version: '3.8'

services:
  #############################################
  # PostgreSQL Database
  #############################################
  postgres:
    image: postgres:15-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: ${POSTGRES_USER:-rails}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-password}
      POSTGRES_DB: ${POSTGRES_DB:-myapp_development}
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U rails"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - backend

  #############################################
  # Redis (Optional - for Action Cable, Sidekiq)
  #############################################
  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 5
    networks:
      - backend

  #############################################
  # Rails Application
  #############################################
  web:
    build:
      context: .
      dockerfile: Dockerfile
      target: base # Use base image for development hot-reload
    command: bundle exec rails server -b 0.0.0.0
    volumes:
      # Mount code for development hot-reload
      - .:/rails
      - bundle_cache:/usr/local/bundle
      - node_modules:/rails/node_modules
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgres://rails:password@postgres:5432/myapp_development
      REDIS_URL: redis://redis:6379/0
      RAILS_ENV: development
      RAILS_LOG_TO_STDOUT: "true"
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - backend
      - frontend
    stdin_open: true
    tty: true

  #############################################
  # Solid Queue Worker (Rails 8 Background Jobs)
  #############################################
  worker:
    build:
      context: .
      dockerfile: Dockerfile
      target: base # Use base image for development consistency
    command: bundle exec rails solid_queue:start
    volumes:
      - .:/rails
      - bundle_cache:/usr/local/bundle
    environment:
      DATABASE_URL: postgres://rails:password@postgres:5432/myapp_development
      RAILS_ENV: development
    depends_on:
      postgres:
        condition: service_healthy
    networks:
      - backend

  #############################################
  # Nginx Reverse Proxy (Production Simulation)
  #############################################
  nginx:
    image: nginx:alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./public:/rails/public:ro
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - web
    networks:
      - frontend

volumes:
  postgres_data:
  redis_data:
  bundle_cache:
  node_modules:

networks:
  backend:
    driver: bridge
  frontend:
    driver: bridge
```

### Nginx Configuration for Rails

```nginx
# nginx.conf
upstream rails_app {
    server web:3000;
}

server {
    listen 80;
    server_name localhost;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Serve static assets directly
    location ~ ^/(assets|packs|images|javascripts|stylesheets|favicon.ico|robots.txt) {
        root /rails/public;
        expires max;
        add_header Cache-Control public;
        access_log off;
    }

    # Proxy to Rails application
    location / {
        proxy_pass http://rails_app;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;

        # WebSocket support (for Action Cable)
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # Health check endpoint
    location /up {
        proxy_pass http://rails_app/up;
        access_log off;
    }
}
```

## Production Deployment Strategies

### Strategy 1: Docker Compose Production (Simple Deployments)

```yaml
# docker-compose.production.yml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    volumes:
      - postgres_prod_data:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    networks:
      - backend
    restart: unless-stopped

  web:
    image: myregistry.com/myapp:${VERSION}
    command: bundle exec rails server -b 0.0.0.0
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}
      RAILS_ENV: production
      SECRET_KEY_BASE: ${SECRET_KEY_BASE}
      RAILS_MASTER_KEY: ${RAILS_MASTER_KEY}
    depends_on:
      - postgres
    networks:
      - backend
      - frontend
    restart: unless-stopped
    deploy:
      # Note: deploy section is only used by Docker Swarm, ignored by docker-compose
      # For docker-compose scaling, use: docker-compose up --scale web=2
      replicas: 2 # Run 2 instances for high availability
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M

  worker:
    image: myregistry.com/myapp:${VERSION}
    command: bundle exec rails solid_queue:start
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}
      RAILS_ENV: production
      SECRET_KEY_BASE: ${SECRET_KEY_BASE}
    depends_on:
      - postgres
    networks:
      - backend
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    volumes:
      - ./nginx.production.conf:/etc/nginx/nginx.conf:ro
      - static_assets:/rails/public:ro
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - web
    networks:
      - frontend
    restart: unless-stopped

volumes:
  postgres_prod_data:
  static_assets:

networks:
  backend:
  frontend:
```

#### Deployment Script:

```bash
#!/bin/bash
# deploy.sh

set -e

# Configuration
IMAGE_NAME="myregistry.com/myapp"
VERSION=${1:-latest}

echo "🚀 Deploying version: $VERSION"

# 0. Record current version for rollback
VERSION_PREVIOUS=$(docker inspect --format='{{.Config.Image}}' $(docker-compose -f docker-compose.production.yml ps -q web) 2>/dev/null | awk -F: '{print $2}')
export VERSION_PREVIOUS

# 1. Pull latest images
echo "📦 Pulling latest images..."
docker-compose -f docker-compose.production.yml pull

# 2. Run database migrations
echo "🗄️  Running database migrations..."
docker-compose -f docker-compose.production.yml run --rm web bundle exec rails db:migrate

# 3. Restart services with zero-downtime
echo "🔄 Restarting services..."
docker-compose -f docker-compose.production.yml up -d --no-deps --build web worker

# 4. Health check
echo "💚 Performing health check..."
sleep 10
curl -f http://localhost/up || {
    echo "❌ Health check failed! Rolling back..."
    # Rollback by deploying the previous known-good version
    # Requires VERSION_PREVIOUS to be set before deploy
    docker-compose -f docker-compose.production.yml down
    VERSION=${VERSION_PREVIOUS} docker-compose -f docker-compose.production.yml up -d
    exit 1
}

echo "✅ Deployment successful!"
```

### Strategy 2: Kamal Alternative (Simplified Docker Deployment)

Rails 8 ships with [Kamal by default](/blog/kamal-integration-in-rails-8-by-default-ruby/), and for most teams we'd recommend starting there (see our [Kamal 2 + GitHub Actions guide](/blog/automate-your-deployments-with-kamal-2-github-actions-devops-development/) and [deploying Rails with Kamal](/blog/deploying-ruby-on-rails-applications-with-kamal-devops-docker/)). But some teams prefer traditional Docker workflows -- here's that path:

```yaml
# Alternative to Kamal: Simple Docker deployment script
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build Docker image
        run: |
          docker build \
            -t myregistry.com/myapp:${{ github.sha }} \
            -t myregistry.com/myapp:latest \
            --target production \
            .

      - name: Push to registry
        run: |
          echo "${{ secrets.REGISTRY_PASSWORD }}" | docker login -u "${{ secrets.REGISTRY_USERNAME }}" --password-stdin myregistry.com
          docker push myregistry.com/myapp:${{ github.sha }}
          docker push myregistry.com/myapp:latest

      - name: Deploy to server
        uses: appleboy/ssh-action@v1.0.0
        with:
          host: ${{ secrets.DEPLOY_HOST }}
          username: ${{ secrets.DEPLOY_USER }}
          key: ${{ secrets.DEPLOY_SSH_KEY }}
          script: |
            cd /opt/myapp
            docker-compose pull
            docker-compose up -d
            docker-compose exec -T web bundle exec rails db:migrate
            docker system prune -af
```

## Security Hardening

### Container Security Best Practices

```dockerfile
# 1. Non-root user (already in multi-stage Dockerfile)
RUN groupadd -g 1000 rails && \
    useradd -u 1000 -g rails -s /bin/bash -m rails
USER rails:rails

# 2. Read-only root filesystem (where possible)
# docker-compose.yml
services:
  web:
    read_only: true
    tmpfs:
      - /tmp
      - /rails/tmp

# 3. Security scanning in CI/CD
# .github/workflows/security.yml
- name: Scan Docker image
  uses: aquasecurity/trivy-action@0.33.1
  with:
    image-ref: 'myregistry.com/myapp:latest'
    format: 'sarif'
    severity: 'CRITICAL,HIGH'
```

### Secrets Management

```yaml
# Using Docker secrets (Docker Swarm)
version: '3.8'
services:
  web:
    image: myapp:latest
    secrets:
      - database_url
      - secret_key_base
    environment:
      DATABASE_URL_FILE: /run/secrets/database_url
      SECRET_KEY_BASE_FILE: /run/secrets/secret_key_base

secrets:
  database_url:
    external: true
  secret_key_base:
    external: true
```

```ruby
# Load secrets from files (Rails initializer)
# config/initializers/secrets_from_files.rb
if Rails.env.production?
  ENV.each do |key, value|
    if key.end_with?('_FILE') && File.exist?(value)
      actual_key = key.gsub(/_FILE$/, '')
      ENV[actual_key] = File.read(value).strip
    end
  end
end
```

## Performance Optimization

### Application-Level Optimizations

```ruby
# config/puma.rb (Production Puma Configuration)
max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
min_threads_count = ENV.fetch("RAILS_MIN_THREADS", max_threads_count).to_i
threads min_threads_count, max_threads_count

# Workers for multi-core systems
worker_count = ENV.fetch("WEB_CONCURRENCY", 2).to_i
workers worker_count if worker_count > 1

# Preload application for better memory efficiency
preload_app!

# Allow puma to be restarted by `rails restart` command
plugin :tmp_restart

# Improve worker boot time
before_fork do
  # Close database connections before forking
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  # Reconnect to database after fork
  ActiveRecord::Base.establish_connection
end
```

### Database Connection Pooling

```yaml
# config/database.yml
production:
  <<: *default
  database: <%= ENV['POSTGRES_DB'] %>
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASSWORD'] %>
  host: <%= ENV.fetch('DATABASE_HOST', 'postgres') %>
  pool: <%= ENV.fetch('RAILS_MAX_THREADS', 5).to_i * ENV.fetch('WEB_CONCURRENCY', 2).to_i + 5 %>
  # Formula: (threads * workers) + 5 for background jobs
```

### Caching Strategy with Docker

```ruby
# config/environments/production.rb
Rails.application.configure do
  # Use Solid Cache (database-backed, Docker-friendly)
  config.cache_store = :solid_cache_store, {
    database: ENV.fetch('CACHE_DATABASE', 'cache'),
    expires_in: 2.weeks,
    namespace: 'myapp_cache'
  }

  # Enable HTTP caching with ETag/Last-Modified
  config.action_controller.perform_caching = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31536000, immutable'
  }
end
```

## Monitoring and Observability

### Comprehensive Docker Monitoring

```yaml
# docker-compose.monitoring.yml
version: '3.8'

services:
  #############################################
  # Prometheus (Metrics Collection)
  #############################################
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
    ports:
      - "9090:9090"
    networks:
      - monitoring

  #############################################
  # Grafana (Metrics Visualization)
  #############################################
  grafana:
    image: grafana/grafana:latest
    volumes:
      - grafana_data:/var/lib/grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    ports:
      - "3001:3000"
    depends_on:
      - prometheus
    networks:
      - monitoring

  #############################################
  # cAdvisor (Container Metrics)
  #############################################
  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
    ports:
      - "8080:8080"
    networks:
      - monitoring

volumes:
  prometheus_data:
  grafana_data:

networks:
  monitoring:
```

#### Prometheus Configuration:

```yaml
# prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'rails-app'
    static_configs:
      - targets: ['web:3000']
    metrics_path: '/metrics'

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
```

#### Rails Metrics Endpoint

For Prometheus metrics from your Rails app, use the [`prometheus-client`](https://github.com/prometheus/client_ruby) gem. It provides proper metric types (counters, histograms, gauges), thread-safe collectors, and a Rack middleware that exposes a `/metrics` endpoint in the correct exposition format. Hand-rolling a metrics controller without this gem will produce incorrectly formatted output that Prometheus cannot scrape reliably.

## Troubleshooting Common Issues

### Issue 1: Out of Memory (OOM) Errors

```yaml
# Diagnosis
docker stats # Check memory usage

# Solution: Adjust memory limits
services:
  web:
    deploy:
      resources:
        limits:
          memory: 2G # Increase from 1G
        reservations:
          memory: 1G
```

### Issue 2: Slow Build Times

```dockerfile
# Problem: Rebuilding dependencies on every code change
COPY . /rails
RUN bundle install

# Solution: Leverage layer caching
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . /rails # Code changes don't invalidate bundle install
```

### Issue 3: Database Connection Failures

```yaml
# Solution: Add health checks and depends_on conditions
services:
  web:
    depends_on:
      postgres:
        condition: service_healthy
    restart: on-failure

  postgres:
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U rails"]
      interval: 10s
      timeout: 5s
      retries: 5
```

## Real-World Case Studies

### Case Study: SaaS Platform Migration to Docker

**Company:** B2B SaaS platform with 50,000 active users
**Before:** Traditional server deployments with Capistrano
**After:** Docker-based deployment with container orchestration

#### Migration Results (on a recent client project):
- **Deployment time:** Significantly reduced (from slow Capistrano deploys to fast image pulls)
- **Environment consistency:** Eliminated "works on my machine" issues entirely
- **Infrastructure costs:** Reduced through better resource utilization
- **Rollback time:** Decreased from manual rollbacks to sub-minute container swaps
- **Developer onboarding:** New developers productive much faster with containerized dev environments

We wrote about a common gotcha during this migration in [Solving Kamal's "target failed to become healthy"](/blog/solving-kamals-target-failed-become-healthy/) -- health check timing is the number one deployment blocker we see.

## When NOT to Use Docker for Rails Deploys

Docker isn't always the right call. Skip it if:

- **You're a solo founder on Heroku or Render.** Platform-as-a-Service handles containerization for you. Adding your own Docker layer adds complexity without benefit. Ship features instead.
- **Your team has zero Docker experience and a launch deadline.** Learning Docker and deploying a new app simultaneously is how you miss deadlines. Use [Kamal](/blog/deploying-ruby-on-rails-applications-with-kamal-devops-docker/) -- it handles the Docker parts you'd get wrong the first time.
- **Your app is a simple CRUD with no background jobs.** A basic `rails deploy` with Kamal or a Heroku push is faster to set up and maintain than the full docker-compose stack shown here.
- **You're running on managed Kubernetes already.** Your platform team likely has container standards. Don't fight them with a custom Docker setup -- adapt to their patterns.

The honest test: if you can't explain what multi-stage builds save you, you probably don't need them yet. Start with Kamal, graduate to custom Docker when you hit scaling limits.

## What to Do Next

Start with the multi-stage Dockerfile above -- copy it, adjust the Ruby version, and build. If the image is under 400MB, you're on track. If it's over 800MB, you're missing the cleanup stage.

For CI/CD, wire up [GitHub Actions with Kamal 2](/blog/automate-your-deployments-with-kamal-2-github-actions-devops-development/) before writing custom deploy scripts. For local development with Docker, our [Docker setup guide for Rails](/blog/setting-up-docker-for-ruby-on-rails-7-beginners/) covers the basics.

If you're already running containers and hitting health check failures or OOM errors, check the troubleshooting section above -- those two issues account for 80% of the Docker deploy tickets we see.

---

*Configurations tested with Rails 8, Docker 24+, and Docker Compose v2. Test in staging before production -- always.*

## Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Rails 8 Deployment Guide](https://guides.rubyonrails.org/8_0_release_notes.html#deployment)
- [Docker Multi-Stage Builds](https://docs.docker.com/build/building/multi-stage/)
- [Container Security Best Practices](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
