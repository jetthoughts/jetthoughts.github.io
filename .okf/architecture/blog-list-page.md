---
type: API Endpoint
title: Blog Index / Listing Page
description: Hugo template rendering the JTWay blog index, tag pages, and post thumbnails.
resource: themes/beaver/layouts/blog/list.html
tags: [hugo, blog, layout]
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-20T00:00:00Z
timestamp: 2026-08-20T00:00:00Z
---

# Overview

`themes/beaver/layouts/blog/list.html` renders the blog index
(`/blog/`) and tag taxonomy pages (`/blog/tags/:slug/`). It loads its
own CSS bundle (`blog-list`) via the `blog-list-css-resources.html`
partial and the shared `assets/css-processor.html` partial (see
[css-pipeline](/architecture/css-pipeline.md)).

For tag pages (`.Type == "tags"`), it falls back to the blog section's
own cover image (`$blogIndex.Params.metatags.image`) via
[cover-image-pipeline](/architecture/cover-image-pipeline.md) for the
page-level `og:image`/`twitter:image` meta tags.

Post thumbnails on the list page are rendered by
[img-cropped partial](/architecture/cover-image-pipeline.md), not by
`cover_image.html` directly — thumbnails need responsive `<picture>`
srcsets, cover meta tags need only a single canonical URL.

# Shared partials (2026-08-20)

Tag pages render from a SEPARATE template — `themes/beaver/layouts/list.html`
(kind `term`) — which drifted from the index for months (hashtag tags,
`target="_blank"` cards, no reading time) because both carried their own copy
of the row markup. Three partials are now the single source for both:

| Partial | Renders |
|---|---|
| `partials/blog/post-row.html` | one listing row (cover, title, date · reading time, tags, description) |
| `partials/blog/filters.html` | curated ICP tag pills; `aria-current` on the active one |
| `partials/blog/cta-band.html` | the audit CTA; takes a **location string** as its context, not a page |

`cta-band.html` is also rendered at the end of every non-course blog post by
`single.html` — its `data-cta-location` feeds the `cta_click` GA4 event
(`blog-index` / `tag-index` / `article-end`).

The index adds a feature slot for the newest post on paginator page 1 only
(`range first 1` — `index $posts 0` errors on an empty slice before `with`
can guard it). `list.html` branches on `.Kind`: the taxonomy ROOT (`/tags/`)
carries term objects, not posts, and renders a tag index by count — feeding
those into post rows produced cards reading "0 min read".

# Traps

- **Filter pills are primary navigation, so the term pages must build.**
  `config/development/hugo.toml` disabled the `taxonomy`/`term` kinds for
  build speed; every tag link 404'd locally while working in production.
  When a dev-disabled kind gets promoted to navigation, re-enable it in the
  same commit.
- **Date ordering needs the frontmatter fallback.** 20 published dev.to
  imports carry only `created_at`, so `.ByDate` sorted them as `0001-01-01`
  and they rendered dateless. `[frontmatter] date = ["date","created_at",…]`
  in `config/_default/hugo.toml` fixes ordering AND display everywhere
  (index, tags, RSS, sitemap).
- **A string-valued `tags:` key anywhere under a mounted content dir 500s
  every term page.** A LinkedIn draft carried
  `tags: "#startups #founders …"`; `range` cannot iterate a string. LI
  drafts use `hashtags:` for that reason.
- **Covers are shown on mobile again** — see the `mobileWidth`/`mobileSizes`
  params in [cover-image-pipeline](/architecture/cover-image-pipeline.md).
  They were hidden purely because the partial served 160w.

# Citations

[1] `themes/beaver/layouts/blog/list.html`
