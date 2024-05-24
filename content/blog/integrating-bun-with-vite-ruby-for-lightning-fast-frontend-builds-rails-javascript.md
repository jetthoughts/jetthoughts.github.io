---
dev_to_id: 1667161
title: "Integrating Bun with Vite Ruby for Lightning-Fast Frontend Builds"
description: "With the recent release of Bun and its newfound support for Vite, coupled with Ruby on Rails 7.1..."
created_at: "2023-11-15T09:13:40Z"
edited_at: "2023-11-15T12:29:08Z"
sync_date: "2024-05-24T15:39:22Z"
draft: false
tags: ["rails", "javascript", "tutorial", "productivity"]
canonical_url: "https://pftg.medium.com/bbd220fefdc0?source=friends_link&sk=57ef60a3a71ed0b74cfd04ac5ca59c0e"
slug: "integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-rails-javascript"
---
With the recent release of [Bun](https://bun.sh/) and its newfound support for Vite, coupled with _Ruby on Rails 7.1_ incorporating native support for Bun, developers can now enhance their web development workflow significantly. Here is the effortless process of enabling _Bun_ for [Vite Ruby](https://vite-ruby.netlify.app/), ultimately streamlining your front-end builds.

![Bun plus Vite Ruby](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hhd73ikhzma10k727lzf.png)

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

---

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [Showcase](https://showca.se) and [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).

If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).