---
type: Service
title: Enhanced SEO Meta Tags
description: Hugo partial that generates optimized page titles, meta descriptions, and schema tags per section with emotional-trigger power words.
resource: themes/beaver/layouts/partials/seo/enhanced-meta-tags.html
tags: [seo, hugo, meta-tags]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

`partials/seo/enhanced-meta-tags.html` generates the page `<title>` and
meta description per section (home, services, about, blog, default),
enforcing length limits (title 50-60 chars, description 150-160 chars)
and injecting a per-section "power word" (e.g. "Expert", "Proven",
"Essential", "Advanced") plus a fixed `| JetThoughts` suffix.

This is distinct from the per-post `og:image`/`twitter:image` tags,
which come from [cover-image-pipeline](/architecture/cover-image-pipeline.md)
via `page/cover_image.html`.

# Citations

[1] `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html`
