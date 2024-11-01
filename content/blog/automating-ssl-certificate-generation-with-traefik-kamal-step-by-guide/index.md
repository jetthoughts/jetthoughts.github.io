---
dev_to_id: 1966362
title: 'Automating SSL Certificate Generation with Traefik and Kamal: A Step-by-Step Guide'
description: In this guide, we'll explore how to configure Traefik with Kamal to automatically obtain and manage...
created_at: '2024-08-20T09:22:37Z'
edited_at: '2024-11-01T13:22:31Z'
draft: false
tags: []
canonical_url: https://jetthoughts.com/blog/automating-ssl-certificate-generation-with-traefik-kamal-step-by-guide/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/automating-ssl-certificate-generation-with-traefik-kamal-step-by-guide/cover.png
slug: automating-ssl-certificate-generation-with-traefik-kamal-step-by-guide
metatags:
  image: cover.png
---
In this guide, we'll explore how to configure Traefik with Kamal to automatically obtain and manage SSL certificates for your Ruby on Rails application. We'll break down a working configuration and explain each line to help you understand how to set up a secure deployment environment.

## Why Use Traefik with Kamal?

Traefik is a modern reverse proxy and load balancer designed to handle dynamic containerized environments. It simplifies routing, SSL certificate management, and more. When used with Kamal, Traefik can automate SSL certificate acquisition and renewal, making it easier to deploy secure, production-ready Rails applications.

## Configuration Overview
Below is the key part of the configuration file provided, which includes the necessary settings for Traefik to automatically manage SSL certificates:

```yaml
# Name of your application. Used to uniquely configure containers.
service: myapp

# Name of the container image.
image: username/myapp

# Deploy to these servers.
servers:
  web:
    hosts:
      - 192.168.0.1
    labels:
      traefik.http.routers.myapp.entrypoints: websecure
      traefik.http.routers.myapp.rule: Host(`myapp-domain.com`)
      traefik.http.routers.myapp.tls.certresolver: letsencrypt
  workers:
    hosts:
      - 192.168.0.1
    cmd: bundle exec sidekiq

# Credentials for your image host.
registry:
  username: username
  password:
    - KAMAL_REGISTRY_PASSWORD

# Inject ENV variables into containers (secrets come from .env).
env:
  clear:
    HOST: myapp-domain.com
    RAILS_ENV: production
    POSTGRES_USER: myapp
    POSTGRES_DB: myapp_production
    POSTGRES_HOST: 192.168.0.1
  secret:
    - RAILS_MASTER_KEY
    - POSTGRES_PASSWORD
    - REDIS_PASSWORD

# Use a different ssh user than root
ssh:
  user: deploy

# Configure builder setup.
builder:
  args:
    RUBY_VERSION: 3.2.0
  secrets:
    - RAILS_MASTER_KEY

# Use accessory services (secrets come from .env).
accessories:
  db:
    image: postgres:15
    host: 192.168.0.1
    port: 5432
    env:
      clear:
        POSTGRES_USER: myapp
        POSTGRES_DB: myapp_production
        POSTGRES_HOST: 192.168.0.1
      secret:
        - POSTGRES_PASSWORD
    files:
      - db/setup.sql:/docker-entrypoint-initdb.d/setup.sql
    directories:
      - data:/var/lib/postgresql/data
  redis:
    image: redis:7.0
    host: 192.168.0.1
    port: 6379
    cmd: "/bin/sh -c 'redis-server --requirepass $REDIS_PASSWORD'"
    env:
      secret:
        - REDIS_PASSWORD
    directories:
      - data:/data

# Configure custom arguments for Traefik. Be sure to reboot traefik when you modify it.
traefik:
  options:
    publish:
      - "443:443"
    volume:
      - "/letsencrypt/acme.json:/letsencrypt/acme.json" # To save the configuration file.
  args:
    entryPoints.web.address: ":80"
    entryPoints.websecure.address: ":443"
    entryPoints.web.http.redirections.entryPoint.to: websecure # We want to force https
    entryPoints.web.http.redirections.entryPoint.scheme: https
    entryPoints.web.http.redirections.entrypoint.permanent: true
    certificatesResolvers.letsencrypt.acme.email: "username@myapp.com"
    certificatesResolvers.letsencrypt.acme.storage: "/letsencrypt/acme.json" # Must match the path in `volume`
    certificatesResolvers.letsencrypt.acme.httpchallenge: true
    certificatesResolvers.letsencrypt.acme.httpchallenge.entrypoint: web # Must match the role in `servers`

```

## Step-by-Step Explanation
Let's break down the configuration to understand how each line contributes to automating SSL certificate management with Traefik.

### Application and Image Configuration
```yaml
service: myapp
image: username/myapp
```
**Purpose:** These lines define the application name (myapp) and the container image (username/myapp) that Kamal will deploy.

### Server Configuration with Traefik Labels
```yaml
servers:
  web:
    hosts:
      - 192.168.0.1
    labels:
      traefik.http.routers.myapp.entrypoints: websecure
      traefik.http.routers.myapp.rule: Host(`myapp-domain.com`)
      traefik.http.routers.myapp.tls.certresolver: letsencrypt
```

**Purpose:**
- **hosts**: Specifies the VPS IP address (192.168.0.1) where the application will be deployed.
- **labels**: The labels configure how Traefik should route traffic and handle SSL certificates for the myapp service:
  - **traefik.http.routers.myapp.entrypoints**: websecure: Directs traffic for this service to the websecure entry point, which handles HTTPS on port 443.
  - **traefik.http.routers.myapp.rule**: Host('myapp-domain.com'): Routes traffic to this service only if the request's Host header matches myapp-domain.com, ensuring that only requests to this domain are handled by this service.
  - **traefik.http.routers.myapp.tls.certresolver**: letsencrypt: Specifies that Traefik should use the letsencrypt resolver to automatically obtain and manage SSL certificates for the myapp-domain.com domain.

## Traefik Configuration

```yaml
traefik:
  options:
    publish:
      - "443:443"
    volume:
      - "/letsencrypt/acme.json:/letsencrypt/acme.json"
  args:
    entryPoints.web.address: ":80"
    entryPoints.websecure.address: ":443"
    entryPoints.web.http.redirections.entryPoint.to: websecure
    entryPoints.web.http.redirections.entryPoint.scheme: https
    entryPoints.web.http.redirections.entrypoint.permanent: true
    certificatesResolvers.letsencrypt.acme.email: "username@myapp.com"
    certificatesResolvers.letsencrypt.acme.storage: "/letsencrypt/acme.json"
    certificatesResolvers.letsencrypt.acme.httpchallenge: true
    certificatesResolvers.letsencrypt.acme.httpchallenge.entrypoint: web
```
**Purpose:**
- **publish**: "443:443": Exposes port 443, enabling Traefik to handle HTTPS traffic.
- **volume**: "/letsencrypt/acme.json:/letsencrypt/acme.json": Mounts a volume to store SSL certificate data in acme.json, ensuring certificates persist across restarts.
- **entryPoints.web.address**: ":80": Defines the entry point for HTTP traffic on port 80, which is necessary for the initial Let's Encrypt certificate validation.
- **entryPoints.websecure.address**: ":443": Defines the entry point for HTTPS traffic on port 443, which will be used once the SSL certificate is obtained.
- **entryPoints.web.http.redirections.entryPoint.to**: websecure: Redirects all HTTP traffic to HTTPS, ensuring secure connections.
certificatesResolvers.letsencrypt.acme.email: Specifies the email address for Let's Encrypt account notifications and certificate management.
- **certificatesResolvers.letsencrypt.acme.storage**: Defines the path where SSL certificates will be stored, matching the volume configuration.
- **certificatesResolvers.letsencrypt.acme.httpchallenge**: Enables the HTTP challenge method for Let's Encrypt, necessary for obtaining SSL certificates.
- **certificatesResolvers.letsencrypt.acme.httpchallenge.entrypoint**: web: Associates the HTTP challenge with the HTTP entry point, allowing Let's Encrypt to validate domain ownership.

## Final Steps: Deploy and Validate
Deploy Your Application: Run the deployment using Kamal, with the Traefik configuration in place. 
```bash
kamal deploy
```

Monitor Logs: Check the Traefik logs to ensure SSL certificates are being generated and renewed properly.
```bash
kamal traefik logs
```

Access the Application: Visit your application using the domain `myapp-domain.com` to verify that it’s accessible over HTTPS and that the connection is secure.

## Conclusion
With this setup, you've successfully configured Traefik to automatically manage SSL certificates for your Rails application deployed with Kamal. This integration not only simplifies the deployment process but also ensures that your application is securely accessible over HTTPS. By following this guide, you can achieve a streamlined and secure deployment pipeline for your web applications.
