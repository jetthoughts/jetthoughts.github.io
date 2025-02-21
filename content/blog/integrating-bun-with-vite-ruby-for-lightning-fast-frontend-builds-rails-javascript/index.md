---
remote_url: https://dev.to/jetthoughts/integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-1fh2
source: dev_to
remote_id: 1667161
dev_to_id: 1667161
dev_to_url: https://dev.to/jetthoughts/integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-1fh2
title: Integrating Bun with Vite Ruby for Lightning-Fast Frontend Builds
description: With the recent release of Bun and its newfound support for Vite, coupled with Ruby on Rails 7.1...
created_at: '2023-11-15T09:13:40Z'
edited_at: '2024-11-25T15:39:51Z'
draft: false
tags:
- rails
- javascript
- tutorial
- productivity
canonical_url: https://jetthoughts.com/blog/integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-rails-javascript/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-rails-javascript/cover.png
metatags:
  image: cover.png
slug: integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-rails-javascript
---
With the recent release of [Bun](https://bun.sh/) and its newfound support for Vite, coupled with _Ruby on Rails 7.1_ incorporating native support for Bun, developers can now enhance their web development workflow significantly. Here is the effortless process of enabling _Bun_ for [Vite Ruby](https://vite-ruby.netlify.app/), ultimately streamlining your front-end builds.

![Bun plus Vite Ruby](file_0.png)

## Getting Started: Creating a Shim Bin

To kick things off, you need to create a shim bin. Navigate to the `bin/shims` directory and add a file named `vite` with the following content:

```bash
#!/usr/bin/env bash

set -eo pipefail

bunx vite "$@"
```

## Configuring Vite Ruby to Use the Shim Bin

Next up, update your Vite Ruby configuration file (`config/vite.json`). Specify the path to the newly created shim bin using the `viteBinPath` attribute.

Here's an example:

```json
{
  "all": {
    "viteBinPath": "bin/shims/vite"
    // ...
  }
  // ...
}
```

By setting the `viteBinPath` to your shim bin, you're instructing _Vite Ruby_ to leverage _Bun_ during the build process.

## The Results: A Faster Workflow

The impact of this integration is tangible. Migrating to Bun has slashed asset processing time **by 1-2 minutes**, from installing dependencies to compiling assets. This optimization is particularly crucial for teams practicing _Continuous Delivery_, where quicker builds can significantly boost overall productivity.

