---
title: "Kamal 2: Your First Rails Deploy"
description: "What kamal init actually creates in Kamal 2, where secrets live now that .env is gone, how to size the box, and what to do when the first deploy stalls."
date: 2025-01-15
lastmod: 2026-08-20
draft: false
author: "JetThoughts Team"
slug: "kamal-2.0-complete-rails-deployment-guide-deploy-without-heroku-in-2025"
keywords: "kamal 2 deployment, kamal init, kamal secrets, kamal deploy minimum ram, kamal rollback, rails deployment without heroku"
tags: ["kamal", "rails", "deployment", "docker", "devops"]
canonical_url: "https://jetthoughts.com/blog/kamal-2.0-complete-rails-deployment-guide-deploy-without-heroku-in-2025/"
cover_image: cover.png
cover_image_alt: "Dark technical cover reading Kamal 2 Your First Rails Deploy, with a low-poly ruby gem and chips for kamal-proxy replacing Traefik, secrets in .kamal/secrets, and builds running locally by default."
metatags:
  image: cover.png
  og_title: "Kamal 2: Your First Rails Deploy"
  og_description: "What kamal init actually creates in Kamal 2, where secrets live now that .env is gone, how to size the box, and what to do when the first deploy stalls."
  twitter_title: "Kamal 2: Your First Rails Deploy"
  twitter_description: "Traefik is gone, .env is gone, and the build runs on your laptop. The Kamal 2 first deploy, with the parts the old guides get wrong."
---

Most Kamal guides you'll find were written for Kamal 1, and Kamal 2 moved the three things those guides talk about most.

Traefik is gone. `.env` is gone. Paste a `traefik:` block into a Kamal 2 `config/deploy.yml` and nothing warns you - the key sits there doing nothing while your SSL never comes up.

This walks a first deploy onto one server against Kamal 2.12, with the moved parts called out where they bite.

## What `kamal init` actually creates

Add the gem and initialize:

```ruby
# Gemfile
gem "kamal", "~> 2.0"
```

```bash
bundle install
bundle exec kamal init
```

Three things land, and one of them is the one old guides miss:

```
config/deploy.yml     # main configuration
.kamal/secrets        # secret references - safe to commit
.kamal/hooks/         # sample deploy hooks
```

There is no `.env.erb`. If you're hunting for one because a tutorial promised it, that file belonged to Kamal 1 and hasn't shipped since 2.0. `bin/kamal` doesn't appear either unless you pass `--bundle`, which defaults to false.

Rails 8 ships Kamal in new apps already, so `kamal init` may be redundant for you - [we covered that change when it landed](/blog/kamal-integration-in-rails-8-by-default-ruby/).

## Secrets moved to `.kamal/secrets`

This is the change that breaks the most copied-from-a-blog setups. `.kamal/secrets` is built to be committed, because it holds *references*, not values:

```bash
# .kamal/secrets
KAMAL_REGISTRY_PASSWORD=$KAMAL_REGISTRY_PASSWORD
RAILS_MASTER_KEY=$(cat config/master.key)
```

Each line either reads an environment variable or shells out. The file carries no credentials itself, which is why the generated template opens with "DO NOT ENTER RAW CREDENTIALS HERE! This file needs to be safe for git."

Already keeping secrets in a password manager? Kamal will fetch them:

```bash
SECRETS=$(kamal secrets fetch --adapter 1password --account my-account \
  --from MyVault/MyItem KAMAL_REGISTRY_PASSWORD RAILS_MASTER_KEY)
KAMAL_REGISTRY_PASSWORD=$(kamal secrets extract KAMAL_REGISTRY_PASSWORD $SECRETS)
```

Adapters ship for 1Password, LastPass, and Bitwarden.

## The config that gets you deployed

Here's a working single-server `deploy.yml`, shorter than you'd expect:

```yaml
# config/deploy.yml
service: my-app
image: my-user/my-app

servers:
  web:
    - 192.168.0.1

proxy:
  ssl: true
  host: app.example.com
  # kamal-proxy talks to your container on port 80 by default
  # app_port: 3000

registry:
  server: ghcr.io
  username: my-user
  password:
    - KAMAL_REGISTRY_PASSWORD

builder:
  arch: amd64

env:
  clear:
    DB_HOST: 192.168.0.2
  secret:
    - RAILS_MASTER_KEY
```

The `proxy:` block sits where Traefik used to. Kamal 2 runs [kamal-proxy](https://github.com/basecamp/kamal-proxy) instead, and it handles Let's Encrypt itself - `ssl: true` plus a `host:` is the entire TLS setup on one server.

Notice what `env:` looks like now. Plain values go under `clear:`, and anything sensitive goes under `secret:` as a *name* that resolves out of `.kamal/secrets`.

Health checks moved too. They live under `proxy:`, not at the top level:

```yaml
proxy:
  ssl: true
  host: app.example.com
  healthcheck:
    path: /health
    interval: 3
    timeout: 3
```

A top-level `healthcheck:` block with `port:` and `max_attempts:` is Kamal 1 syntax. Kamal won't reject it, which is exactly what makes it annoying to debug.

## Sizing the box

The question I get most is how much RAM the server needs, and the honest answer is that Kamal publishes no minimum because it can't - your app decides that.

What Kamal does decide is *where the build happens*, and that's the part people size wrong. `builder.local` defaults to `true`, so `docker build` runs on your laptop and Kamal pushes the finished image to your registry. Your server pulls it.

Asset precompilation, bundle install, and the whole Node toolchain never touch the production box. Size the server for your app's runtime plus whatever accessories share it, not for a build.

Set `builder.remote` to offload builds elsewhere and the arithmetic changes - but that's a deliberate choice, not the default.

Kamal will install Docker for you, so skip the `curl get-docker.sh` step older guides open with:

```bash
bundle exec kamal server bootstrap
```

## The first deploy

First time out, you want `setup`, not `deploy`:

```bash
bundle exec kamal setup
```

`setup` bootstraps the servers, starts accessories, pushes the env, then deploys. Every deploy after that is `kamal deploy`, and once servers are already bootstrapped, `kamal redeploy` skips the setup work.

```mermaid
flowchart TD
    A["docker build<br/>runs on your laptop"] --> B["image pushed<br/>to your registry"]
    B --> C["server pulls image<br/>over SSH"]
    C --> D["kamal-proxy shifts<br/>traffic to new container"]
```

That local-build step is why a slow home connection hurts a Kamal deploy more than a slow server does.

## When the first deploy stalls

Almost everyone's first failure is a health check that never goes green, and the error names the target rather than the cause. We wrote up [that specific error and how to read it](/blog/solving-kamals-target-failed-become-healthy/) separately, because it has more causes than fit here.

Three commands do most of the diagnosis:

```bash
bundle exec kamal app logs -f      # application output
bundle exec kamal proxy logs       # kamal-proxy, formerly where you'd read Traefik
bundle exec kamal config           # the merged config, secrets included
```

Reach for `kamal config` when the file looks right but the deploy disagrees. It prints what Kamal actually resolved, which is where a mistyped secret name shows up.

There's also `kamal docs proxy` - the gem ships its own configuration reference offline, so you can check a key without leaving the terminal.

## Rolling back

```bash
bundle exec kamal rollback [VERSION]
```

Kamal keeps previous images on the server, so a rollback is a container swap rather than a rebuild. Run `kamal app containers` to see which versions are still around.

Worth knowing before you need it: rollback swaps the code, not your database. A deploy that ran a destructive migration doesn't become safe because you rolled the container back.

## Coming from Kamal 1

Don't hand-edit your way across. Kamal ships the migration:

```bash
bundle exec kamal upgrade
```

It replaces Traefik with kamal-proxy and restarts accessories, prompting before each. Clear one thing out first: Kamal 2 refuses configs carrying `pre-traefik-reboot` or `post-traefik-reboot` hooks, so delete those files or config validation stops you.

## When Kamal is the wrong call

Running one app on one box, with traffic that fits in a small droplet? Kamal earns its keep fast. The calculus shifts as you add servers.

Kamal doesn't load-balance across hosts, and `ssl: true` raises a `ConfigurationError` the moment you list a second web server. Neither is a bug - that's the boundary where you're expected to bring a load balancer. [The multi-server post covers that transition](/blog/kamal-2-multi-server-deployment-complete-guide/), including the roles split and the TLS answer.

Skip Kamal entirely if you want zero infrastructure ownership. Somebody on your team now patches a Linux box, and a PaaS bill is often cheaper than the hours that takes.

For deploys triggered on push rather than from your laptop, [wire it into GitHub Actions](/blog/automate-your-deployments-with-kamal-2-github-actions-devops-development/) - and if you want per-PR environments, [review apps work the same way](/blog/own-heroku-review-apps-with-github-actions-kamal-2-devops-development/).

Further reading:

- [Kamal documentation](https://kamal-deploy.org/) - official guides and the full configuration reference
- [Kamal on GitHub](https://github.com/basecamp/kamal) - source, changelog, and the 2.x release notes
- [kamal-proxy](https://github.com/basecamp/kamal-proxy) - the proxy that replaced Traefik in 2.0
- [Configuration reference](https://kamal-deploy.org/docs/configuration/) - every key, including the ones this post skipped
- [Rails 8 release notes](https://guides.rubyonrails.org/8_0_release_notes.html) - where Kamal became the default deploy path
