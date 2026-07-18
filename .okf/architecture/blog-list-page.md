---
type: API Endpoint
title: Blog Index / Listing Page
description: Hugo template rendering the JTWay blog index, tag pages, and post thumbnails.
resource: themes/beaver/layouts/blog/list.html
tags: [hugo, blog, layout]
timestamp: 2026-07-12T00:00:00Z
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

# Citations

[1] `themes/beaver/layouts/blog/list.html`
