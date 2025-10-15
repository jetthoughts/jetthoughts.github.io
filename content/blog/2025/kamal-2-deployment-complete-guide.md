---
dev_to_id: 1
title: "Kamal 2.0: Complete Rails Deployment Guide - Deploy Without Heroku in 2025"
description: "Master Kamal 2.0 deployment with this comprehensive Rails tutorial. Learn step-by-step configuration, troubleshooting, and migration from Heroku with real-world examples."
date: 2025-01-15
created_at: "2025-01-15T10:00:00Z"
edited_at: "2025-01-15T10:00:00Z"
draft: false
tags: ["kamal", "rails", "deployment", "docker", "devops"]
canonical_url: "https://jetthoughts.com/blog/kamal-2-deployment-complete-guide/"
cover_image: "/assets/images/blog/kamal-2-deployment-guide.jpg"
series: "Modern Rails Deployment"
---

# Kamal 2.0: Complete Rails Deployment Guide - Deploy Without Heroku in 2025

Tired of expensive Heroku bills and looking for a modern **Rails deployment** solution? **Kamal 2.0** has revolutionized how we deploy Rails applications, offering the simplicity of Heroku with the power and cost-effectiveness of managing your own infrastructure. This **complete Kamal deployment tutorial** will guide you through everything you need to know.

Whether you're migrating from Heroku, Render, or Fly.io, or starting fresh with a **Rails deployment without Heroku**, this guide covers it all with real-world examples, complete configuration files, and troubleshooting solutions.

## What is Kamal 2.0 and Why Should You Care?

Kamal 2.0 is a deployment tool created by the Rails team at 37signals (formerly Basecamp) that orchestrates Docker containers across multiple servers with zero downtime deployments. Think of it as "Heroku on your own servers" but with more control and significantly lower costs.

### Key Benefits of Kamal 2.0:

- **Zero-downtime deployments** with health checks
- **Multi-server orchestration** with a single command
- **Built-in SSL management** with automatic certificate renewal
- **Database migration coordination** across deployments
- **Asset precompilation** and CDN integration
- **Environment management** (staging, production, etc.)
- **Cost reduction** of 70-90% compared to Heroku at scale

### Real-World Impact:

At JetThoughts, we've helped clients reduce deployment costs from $500+/month on Heroku to less than $50/month using Kamal 2.0 with cloud providers like DigitalOcean or Hetzner, while improving deployment speed by 60%. Our [Ruby on Rails development team](/services/app-web-development/) specializes in modernizing deployment infrastructure and has guided numerous companies through successful Kamal 2.0 migrations with comprehensive cost optimization strategies.

## Prerequisites and Environment Setup

Before diving into **Kamal 2.0 tutorial**, ensure you have:

### Required Tools:
```bash
# Check Ruby version (2.7+ required)
ruby --version

# Install Kamal 2.0
gem install kamal

# Verify Docker is available
docker --version

# SSH access to your servers
ssh-keygen -t ed25519 -C "your-email@example.com"
```

### Server Requirements:
- **Minimum**: 1GB RAM, 1 CPU core, 25GB storage
- **Recommended**: 2GB RAM, 2 CPU cores, 50GB storage
- **Operating System**: Ubuntu 20.04+ or Debian 11+
- **Network**: Public IP address with SSH access

### Cloud Provider Setup:

**DigitalOcean (Recommended for beginners):**
```bash
# Create droplet with Docker pre-installed
doctl compute droplet create kamal-app \
  --image docker-20-04 \
  --size s-2vcpu-2gb \
  --region nyc1 \
  --ssh-keys YOUR_SSH_KEY_ID
```

**Hetzner (Best value):**
```bash
# More cost-effective option
# Create server via Hetzner Cloud console
# Install Docker manually:
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Installing and Configuring Kamal 2.0

### Step 1: Add Kamal to Your Rails Application

```ruby
# Gemfile
gem 'kamal', '~> 2.0'
```

```bash
bundle install
bundle exec kamal init
```

This creates essential files:
- `config/deploy.yml` - Main configuration
- `.env.erb` - Environment variables template
- `bin/kamal` - Local executable

### Step 2: Complete deploy.yml Configuration

Here's a production-ready configuration with explanations:

```yaml
# config/deploy.yml
service: my-rails-app
image: my-rails-app

servers:
  web:
    - 192.168.1.10
    - 192.168.1.11
  job:
    hosts:
      - 192.168.1.12
    cmd: bundle exec sidekiq

# Docker registry configuration
registry:
  server: ghcr.io
  username: your-github-username
  password:
    - GITHUB_TOKEN

# Environment variables
env:
  clear:
    RAILS_ENV: production
    RAILS_LOG_TO_STDOUT: true
    RAILS_SERVE_STATIC_FILES: true
  secret:
    - RAILS_MASTER_KEY
    - DATABASE_URL
    - REDIS_URL

# Database configuration
accessories:
  db:
    image: postgres:15
    host: 192.168.1.13
    port: 5432
    env:
      clear:
        POSTGRES_DB: my_rails_app_production
      secret:
        - POSTGRES_PASSWORD
    files:
      - config/postgres/init.sql:/docker-entrypoint-initdb.d/init.sql
    directories:
      - data:/var/lib/postgresql/data

  redis:
    image: redis:7
    host: 192.168.1.14
    port: 6379
    directories:
      - data:/data

# SSL with automatic certificates
traefik:
  options:
    publish:
      - "443:443"
    volume:
      - "/letsencrypt/acme.json:/letsencrypt/acme.json"
  args:
    entrypoints.websecure.address: ":443"
    certificatesresolvers.letsencrypt.acme.tlschallenge: true
    certificatesresolvers.letsencrypt.acme.email: "admin@example.com"
    certificatesresolvers.letsencrypt.acme.storage: "/letsencrypt/acme.json"

# Health checks
healthcheck:
  path: /health
  port: 3000
  max_attempts: 7
  interval: 20s

# Asset handling
volumes:
  - "/app/storage:/app/storage"

# Build configuration
builder:
  arch: amd64

# Deployment hooks
hooks:
  pre-build:
    - bundle exec rake assets:precompile
  pre-deploy:
    - bundle exec rake db:migrate
```

### Step 3: Environment Variables Setup

Create `.env` file (never commit this):

```bash
# .env
GITHUB_TOKEN=your_github_personal_access_token
RAILS_MASTER_KEY=your_rails_master_key
DATABASE_URL=postgresql://user:password@192.168.1.13:5432/my_rails_app_production
REDIS_URL=redis://192.168.1.14:6379/0
POSTGRES_PASSWORD=secure_database_password
```

## Step-by-Step First Deployment

### Phase 1: Preparation

**1. Prepare your Rails application:**

```ruby
# config/environments/production.rb
Rails.application.configure do
  config.force_ssl = true
  config.public_file_server.enabled = true
  config.log_to_stdout = true
  config.log_level = :info

  # Add health check endpoint
  config.after_initialize do
    Rails.application.routes.draw do
      get '/health', to: proc { [200, {}, ['OK']] }
    end
  end
end
```

**2. Create Dockerfile (if not exists):**

```dockerfile
FROM ruby:3.2-slim

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
```

### Phase 2: Server Setup

**3. Setup servers with Kamal:**

```bash
# Install Docker on all servers
kamal server bootstrap

# Setup accessories (database, redis)
kamal accessory boot all
```

**4. Verify server connectivity:**

```bash
# Test SSH connections
kamal server exec --all "docker --version"

# Check accessory status
kamal accessory logs db
kamal accessory logs redis
```

### Phase 3: Initial Deployment

**5. Build and deploy:**

```bash
# First deployment
kamal setup

# Check deployment status
kamal status

# View application logs
kamal app logs
```

**6. Configure DNS:**

Point your domain to your server IP addresses:

```
A    example.com        192.168.1.10
A    example.com        192.168.1.11
```

## Advanced Configuration Scenarios

### Multi-Environment Setup

**staging.yml configuration:**

```yaml
# config/deploy.staging.yml
service: my-rails-app-staging
image: my-rails-app-staging

servers:
  web:
    - 192.168.1.20

env:
  clear:
    RAILS_ENV: staging
  secret:
    - RAILS_MASTER_KEY
    - DATABASE_URL_STAGING

# Staging-specific accessories
accessories:
  db:
    image: postgres:15
    host: 192.168.1.21
    env:
      clear:
        POSTGRES_DB: my_rails_app_staging
```

**Deploy to staging:**

```bash
kamal deploy -d staging
```

### Custom Domain and SSL Configuration

```yaml
# Advanced SSL setup in deploy.yml
traefik:
  host_port: 80
  options:
    publish:
      - "80:80"
      - "443:443"
    volume:
      - "/letsencrypt:/letsencrypt"
  args:
    entryPoints.web.address: ":80"
    entryPoints.websecure.address: ":443"

    certificatesResolvers.letsencrypt.acme.email: "admin@example.com"
    certificatesResolvers.letsencrypt.acme.storage: "/letsencrypt/acme.json"
    certificatesResolvers.letsencrypt.acme.httpChallenge: true
    certificatesResolvers.letsencrypt.acme.httpChallenge.entryPoint: web

    # HTTP to HTTPS redirect
    entryPoints.web.http.redirections.entryPoint.to: websecure
    entryPoints.web.http.redirections.entryPoint.scheme: https

# Custom labels for your app
labels:
  traefik.http.routers.my-rails-app.rule: "Host(`example.com`,`www.example.com`)"
  traefik.http.routers.my-rails-app.tls.certResolver: "letsencrypt"
```

### Background Jobs with Sidekiq

```yaml
# Background job server configuration
servers:
  job:
    hosts:
      - 192.168.1.30
    cmd: bundle exec sidekiq -C config/sidekiq.yml
    env:
      clear:
        RAILS_ENV: production
        SIDEKIQ_CONCURRENCY: 10
      secret:
        - REDIS_URL
```

### Database Migration Strategy

```yaml
# Safe migration deployment
hooks:
  pre-deploy:
    - bundle exec rake db:migrate:status
    - bundle exec rake db:migrate
  post-deploy:
    - bundle exec rake db:seed:replant
    - bundle exec rake tmp:clear
```

## Migrating from Other Platforms

### From Heroku to Kamal 2.0

**1. Export Heroku configuration:**

```bash
# Get current config vars
heroku config -a your-heroku-app > heroku-config.txt

# Export database (if using Heroku Postgres)
heroku pg:backups:download -a your-heroku-app
```

**2. Adapt configuration:**

```bash
# Convert Heroku environment variables to .env format
# Example transformation:
HEROKU_POSTGRESQL_COPPER_URL → DATABASE_URL
REDISTOGO_URL → REDIS_URL
```

**3. Migration checklist:**

- [ ] Database migration (pg_restore for PostgreSQL)
- [ ] File uploads (AWS S3 configuration)
- [ ] Environment variables mapping
- [ ] Custom domains and SSL
- [ ] Background jobs (Sidekiq configuration)
- [ ] Monitoring and logging setup

**Cost comparison:**

| Service | Heroku | Kamal + DigitalOcean | Savings |
|---------|--------|---------------------|---------|
| 2 web dynos | $50/month | $24/month | 52% |
| Postgres | $50/month | $12/month | 76% |
| Redis | $30/month | $6/month | 80% |
| **Total** | **$130/month** | **$42/month** | **68%** |

### From Render to Kamal 2.0

Render's configuration is closer to Kamal, making migration easier:

```yaml
# Render's render.yaml equivalent in Kamal
# render.yaml:
services:
  - type: web
    name: my-app
    env: ruby
    buildCommand: bundle install && bundle exec rake assets:precompile
    startCommand: bundle exec rails server

# Kamal equivalent is in deploy.yml (shown above)
```

### From Fly.io to Kamal 2.0

```bash
# Export Fly configuration
fly config save

# Fly secrets to Kamal env variables
fly secrets list -a your-app > fly-secrets.txt
```

## Monitoring and Logging

### Application Monitoring

```yaml
# config/deploy.yml - Add monitoring
labels:
  # Prometheus metrics
  prometheus.io/scrape: "true"
  prometheus.io/port: "3000"
  prometheus.io/path: "/metrics"

  # Health checks
  traefik.http.services.my-rails-app.loadbalancer.healthcheck.path: "/health"
  traefik.http.services.my-rails-app.loadbalancer.healthcheck.interval: "30s"
```

### Centralized Logging

```ruby
# config/environments/production.rb
Rails.application.configure do
  # Structured logging
  config.log_formatter = Logger::Formatter.new
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
end
```

### Performance Monitoring

```ruby
# Gemfile - Add monitoring gems
gem 'scout_apm' # or 'newrelic_rpm'
gem 'sidekiq-prometheus-exporter' # if using Sidekiq
```

### Log Management Commands

```bash
# View application logs
kamal app logs -f

# View specific service logs
kamal accessory logs db -f

# View server system logs
kamal server exec --all "journalctl -u docker -f"

# Rotate logs to prevent disk space issues
kamal server exec --all "docker system prune -af"
```

## Troubleshooting Common Issues

### Deployment Failures

**Problem: Build fails with memory issues**

```bash
# Solution: Increase build resources
# config/deploy.yml
builder:
  arch: amd64
  remote: ssh://user@build-server

# Or build locally then push
kamal build deliver
```

**Problem: Health check failures**

```bash
# Debug health check
kamal app exec --interactive bash
curl localhost:3000/health

# Check application logs
kamal app logs --grep "ERROR"
```

**Problem: Database connection issues**

```bash
# Verify database accessibility
kamal accessory exec db psql -h localhost -U postgres

# Check network connectivity
kamal server exec --all "nc -zv db-server 5432"
```

### SSL Certificate Issues

**Problem: SSL certificate not generating**

```bash
# Debug Traefik logs
kamal traefik logs

# Check certificate storage
kamal server exec --all "ls -la /letsencrypt/"

# Manual certificate generation
kamal traefik exec "certbot certonly --standalone -d example.com"
```

**Problem: Mixed content warnings**

```ruby
# config/environments/production.rb
Rails.application.configure do
  config.force_ssl = true
  config.ssl_options = { hsts: { subdomains: true, preload: true } }
end
```

### Performance Issues

**Problem: Slow deployment times**

```yaml
# Optimize Docker layers
# Use multi-stage builds
# Cache dependencies separately

# config/deploy.yml
builder:
  cache:
    type: registry
    options:
      mode: max
```

**Problem: High memory usage**

```bash
# Monitor container resources
kamal app exec --interactive top

# Limit container memory
# config/deploy.yml
servers:
  web:
    hosts:
      - server-ip
    options:
      memory: 1g
```

### Network and Connectivity

**Problem: Can't reach application**

```bash
# Check firewall settings
kamal server exec --all "ufw status"

# Verify port binding
kamal server exec --all "netstat -tulpn | grep :80"

# Test internal connectivity
kamal app exec curl http://localhost:3000/health
```

## Security Best Practices

### Server Hardening

```bash
# Initial server security setup
kamal server exec --all "apt-get update && apt-get upgrade -y"
kamal server exec --all "ufw allow ssh && ufw allow 80 && ufw allow 443 && ufw enable"

# Disable root login
kamal server exec --all "sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config"
```

### Application Security

```ruby
# config/environments/production.rb
Rails.application.configure do
  # Security headers
  config.force_ssl = true
  config.ssl_options = {
    hsts: {
      subdomains: true,
      preload: true,
      expires: 1.year
    }
  }

  # Content Security Policy
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.script_src  :self, :https
    policy.style_src   :self, :https, :unsafe_inline
  end
end
```

### Environment Security

```yaml
# config/deploy.yml - Secure secrets management
env:
  secret:
    - RAILS_MASTER_KEY
    - DATABASE_URL
    - SECRET_KEY_BASE
    - REDIS_URL

# Never commit .env files
# Use secure secret management
accessories:
  vault:
    image: vault:1.13
    env:
      secret:
        - VAULT_DEV_ROOT_TOKEN_ID
```

## Performance Optimization

### Application-Level Optimizations

```ruby
# config/environments/production.rb
Rails.application.configure do
  # Enable caching
  config.cache_store = :redis_cache_store, {
    url: ENV['REDIS_URL'],
    pool_size: 5,
    pool_timeout: 5
  }

  # Asset optimization
  config.assets.compile = false
  config.assets.digest = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31536000'
  }
end
```

### Database Optimization

```yaml
# config/deploy.yml - Database performance
accessories:
  db:
    image: postgres:15
    env:
      clear:
        POSTGRES_SHARED_PRELOAD_LIBRARIES: "pg_stat_statements"
        POSTGRES_MAX_CONNECTIONS: 100
        POSTGRES_SHARED_BUFFERS: "256MB"
        POSTGRES_EFFECTIVE_CACHE_SIZE: "1GB"
        POSTGRES_WORK_MEM: "4MB"
```

### Container Optimization

```dockerfile
# Multi-stage Dockerfile for smaller images
FROM ruby:3.2-slim as base
RUN apt-get update && apt-get install -y \
  build-essential libpq-dev nodejs npm \
  && rm -rf /var/lib/apt/lists/*

FROM base as builder
WORKDIR /app
COPY Gemfile* ./
RUN bundle install --without development test

FROM base as runner
WORKDIR /app
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . .
RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server"]
```

## Cost Analysis and Optimization

### Detailed Cost Breakdown

**Traditional Heroku Setup:**
```
Web dynos (2x Standard-2X): $50/month
Heroku Postgres (Standard): $50/month
Heroku Redis (Premium): $30/month
SSL certificates: Included
Monitoring: $25/month
Total: $155/month
```

**Kamal 2.0 + DigitalOcean:**
```
2x Droplets (2GB RAM): $24/month
Managed PostgreSQL: $15/month
Managed Redis: $15/month
Load Balancer: $12/month
Monitoring (optional): $5/month
Total: $71/month (54% savings)
```

**Kamal 2.0 + Hetzner (Maximum savings):**
```
2x Cloud Servers (2GB): $16/month
PostgreSQL server: $8/month
Redis server: $8/month
Load Balancer: $6/month
Total: $38/month (75% savings)
```

### Cost Optimization Strategies

1. **Resource Right-Sizing**
   - Start small and scale based on actual usage
   - Use monitoring to identify over-provisioned resources

2. **Multi-Tenancy**
   - Run multiple applications on the same servers
   - Use Docker resource limits for isolation

3. **Automated Scaling**
   ```yaml
   # config/deploy.yml - Basic auto-scaling
   servers:
     web:
       hosts:
         - 192.168.1.10
         - 192.168.1.11
       options:
         cpus: "0.5"
         memory: "512m"
   ```

## Advanced Deployment Strategies

### Blue-Green Deployments

```yaml
# config/deploy.yml - Blue-green setup
servers:
  web:
    - hosts:
        - 192.168.1.10  # Blue environment
      options:
        labels:
          deployment: blue
    - hosts:
        - 192.168.1.11  # Green environment
      options:
        labels:
          deployment: green

# Deployment strategy
strategy: blue_green
```

### Rolling Deployments

```yaml
# config/deploy.yml - Rolling deployment
deployment:
  strategy: rolling
  max_surge: 1
  max_unavailable: 0

healthcheck:
  path: /health
  max_attempts: 10
  interval: 10s
```

### Canary Deployments

```yaml
# Deploy to subset of servers first
servers:
  web:
    - hosts:
        - 192.168.1.10
      options:
        labels:
          canary: "true"
  web_main:
    - hosts:
        - 192.168.1.11
        - 192.168.1.12
```

## Conclusion and Next Steps

**Kamal 2.0** represents a significant leap forward in **Rails deployment** technology, offering the perfect balance between simplicity and control. This **complete Kamal deployment guide** has covered:

✅ **Complete setup and configuration**
✅ **Production-ready examples**
✅ **Migration strategies from Heroku, Render, and Fly.io**
✅ **Advanced security and performance optimization**
✅ **Comprehensive troubleshooting guide**
✅ **Cost analysis and optimization strategies**

### Your Next Steps:

1. **Start Small**: Deploy a simple Rails app to get familiar with Kamal 2.0
2. **Experiment**: Try different cloud providers to find your optimal cost/performance balance
3. **Monitor**: Implement comprehensive monitoring from day one
4. **Scale**: Add more servers as your application grows
5. **Optimize**: Continuously improve based on monitoring data

Need expert help implementing Kamal 2.0 for your production Rails application? Our [DevOps and deployment specialists](/services/app-web-development/) have successfully migrated dozens of Rails applications from Heroku to Kamal, delivering significant cost savings and improved performance.

### Key Takeaways:

- **Cost Savings**: 50-75% reduction compared to Heroku
- **Performance**: Better control over server resources and optimization
- **Flexibility**: Deploy to any cloud provider or bare metal servers
- **Simplicity**: Single command deployments with zero downtime
- **Community**: Growing ecosystem with excellent documentation

The future of **Rails deployment** is here with Kamal 2.0. By following this guide, you're equipped with everything needed to deploy, manage, and scale Rails applications efficiently and cost-effectively.

### Resources for Continued Learning:

- [Official Kamal 2.0 Documentation](https://kamal-deploy.org)
- [37signals Kamal Handbook](https://github.com/basecamp/kamal)
- [Docker Best Practices for Rails](https://docs.docker.com/develop/dev-best-practices/)
- [Rails Production Optimization Guide](https://guides.rubyonrails.org/configuring.html#configuring-for-production)

---

*Ready to revolutionize your Rails deployment strategy? Start with Kamal 2.0 today and join thousands of developers who have already made the switch from expensive platforms to cost-effective, powerful deployment solutions.*

**Need help with your Kamal 2.0 deployment?** [Contact JetThoughts](https://jetthoughts.com/contact) - we specialize in Rails deployment optimization and have helped dozens of companies successfully migrate to Kamal 2.0 with significant cost savings and improved performance.