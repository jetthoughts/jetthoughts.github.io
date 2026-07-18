---
type: Service
title: Enhanced SEO Meta Tags
description: Hugo partial that generates per-section page titles, meta descriptions, robots/canonical/OpenGraph/Twitter tags, and its own resized og:image.
resource: themes/beaver/layouts/partials/seo/enhanced-meta-tags.html
tags: [seo, hugo, meta-tags]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

`partials/seo/enhanced-meta-tags.html` builds the page `<title>` and
meta description from hardcoded strings chosen per branch (home,
services section vs single service, blog section vs single post, About/
Contact special cases, generic pages). Emotive words ("Expert",
"Proven", …) are baked into those literal strings — the `$powerWords`
dict and `$titleSuffix` variables it defines are **not actually
referenced** by the title logic. Suffixes therefore vary by branch:
`| JetThoughts` (home, generic pages), `| JT` (blog section index),
`| JetThoughts Blog` (individual posts), or none (About/Contact).

Lengths are **capped, not guaranteed ranges**: the title is truncated
with `…` only if it exceeds 60 chars (`$maxTitleLength`), the
description only if it exceeds 160 chars (`$maxDescLength`) — there is
no minimum-length enforcement.

The partial also emits robots, canonical (with a `/tags/` →
`/blog/tags/` rewrite for the tag taxonomy), keywords, OpenGraph
(`og:type = article` for single blog pages), Twitter cards, and its
**own** `og:image` resized to 1200×630 (CDN `w=1200&h=630` or a local
`.Resize "1200x630 webp q85"`), with a site-default fallback. This is a
separate og:image path from the one in
[cover-image-pipeline](/architecture/cover-image-pipeline.md).

# Citations

[1] `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html`
