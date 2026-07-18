---
type: Service
title: JetThoughts Hugo Site
description: Hugo static site generator setup for the JetThoughts marketing site and blog (JTWay).
resource: config/_default/hugo.toml
tags: [hugo, build, config]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

The site is built with [Hugo](https://gohugo.io) using the `beaver` theme
(`themes/beaver/`). Config lives under `config/_default/`, with
`hugo.toml` as the entry point. Content lives in `content/`, with blog
posts under `content/blog/<slug>/index.md`.

Key config choices (`config/_default/hugo.toml`):

- `baseURL = "https://jetthoughts.com/"`, `theme = "beaver"`.
- Permalinks: pages at `/:slug/`, blog posts at `/blog/:slug/`, tag
  taxonomy at `/blog/tags/:slug/`.
- `[build] writeStats = true` — Hugo writes `hugo_stats.json`, which
  PostCSS/PurgeCSS reads to know which CSS classes are actually used
  on the page (see [css-pipeline](/architecture/css-pipeline.md)).
- Goldmark markdown renderer runs with `unsafe = true` (raw HTML in
  markdown is passed through).
- Highlighting uses the `dracula` Chroma style; **fenced ERB code
  blocks must use the `` ```html `` alias, not `` ```erb ``** — Chroma
  has no `erb` lexer alias, so `erb` fences silently lose the syntax
  highlight wrapper and render invisible light-on-light text.

# Build & Test

| Command | Purpose |
|---|---|
| `bin/hugo-build` | Production/dev build. Sets `HUGO_ENVIRONMENT` so `postcss.config.js` can skip PurgeCSS/cssnano in dev mode. Runs `bin/validate-course` first if present. |
| `bin/rake test:critical` | Runs `test/system/*_test.rb` — the fast required gate after any change. |
| `bin/test` / `bin/dtest` | Visual regression on macOS host / Linux Docker respectively — see [visual-scroll-gate](/workflows/visual-scroll-gate.md) and [testing](/workflows/testing.md). |

# Citations

[1] `bin/hugo-build`
[2] `config/_default/hugo.toml`
[3] `Rakefile`
