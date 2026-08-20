---
type: Service
title: JetThoughts Hugo Site
description: Hugo static site generator setup for the JetThoughts marketing site and blog (JTWay).
resource: config/_default/hugo.toml
tags: [hugo, build, config]
timestamp: 2026-08-20T23:20:00Z
verified:
  - { by: claude/opus-5, at: 2026-08-20T23:20:00Z }
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
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

  **A permalink rewrite does NOT change `.Section` or `.Kind`** (2026-08-21,
  caught in review before it shipped). The taxonomy is declared
  `tag = "tags"` and only `[permalinks.term]` rewrites the URL, so a page
  served at `/blog/tags/rails/` still has `.Section == "tags"` and
  `.Kind == "term"`. Any template condition of the form
  `eq .Section "blog"` therefore MISSES every tag page while looking like it
  covers them - the URL says blog, the page object does not. A proposed
  analytics gate was written this way and would have shipped instrumentation
  that silently skipped the pages it named. Gate on `.Kind`
  (`term`/`taxonomy`) or on the section the taxonomy actually belongs to, and
  verify BOTH page kinds in the rendered output rather than reasoning from
  the URL.
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
| `bin/test` / `bin/dtest` | Visual regression on macOS host / Linux Docker respectively — see [visual-scroll-gate](/workflows/visual-scroll-gate.md) and [test-gates](/build/test-gates.md). |

# Citations

[1] `bin/hugo-build`
[2] `config/_default/hugo.toml`
[3] `Rakefile`
