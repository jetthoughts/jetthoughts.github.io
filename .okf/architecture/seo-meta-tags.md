---
type: Service
title: Enhanced SEO Meta Tags
description: Hugo partial that generates per-section page titles, meta descriptions, robots/canonical/OpenGraph/Twitter tags, and its own resized og:image.
resource: layouts/partials/seo/enhanced-meta-tags.html
tags: [seo, hugo, meta-tags]
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
verified:
  - { by: claude/opus-5, at: 2026-08-20T22:27:35Z }
timestamp: 2026-08-20T22:27:35Z
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
**own** `og:image` resized to 1200×630 (CDN `w=1200&h=630&output=jpg&q=85`,
or a local `.Resize "1200x630 jpg q90"`), with a site-default fallback. This
is a separate og:image path from the one in
[cover-image-pipeline](/architecture/cover-image-pipeline.md).

**JPEG is deliberate, not incidental**: LinkedIn's crawler will not render
WebP, so an og:image emitted as WebP unfurls blank there even though most
other clients handle it.

# The site-default fallback

When no frontmatter image field resolves, the partial falls back to a
hardcoded `https://jetthoughts.com/assets/images/og-default.jpg`. **This
asset went missing for an unknown period and was only added 2026-08-20** -
553 pages, overwhelmingly blog posts without cover art, unfurled blank on
LinkedIn and Slack the whole time. `og:image` is the one asset class no
crawler, link-checker, or reader ever exercises, so nothing surfaced it.

It is a brand plate (wordmark + category line + canon proof chips), NOT a
campaign pitch: a fallback stands in under arbitrary technical posts, where
sales copy over a Puma-config article reads as an ad. Any figure on it is
bound by [claims-canon](/content/claims-canon.md), and because those figures
live inside a binary, **no text ratchet can see them** - the generator source
is kept in-repo so they stay greppable:

```
# .stitch/og-default.svg  (NOT .stitch/designs/, which is gitignored)
rsvg-convert -w 1200 -h 630 -o /tmp/og.png .stitch/og-default.svg
magick /tmp/og.png -quality 88 static/assets/images/og-default.jpg
```

Verified byte-identical to the committed jpg (`md5
ecd26681b0c591a68d1315d5d578d05c`), so the SVG is the source of record rather
than an approximation of it - a canon change is edited there and re-rendered,
never painted onto the jpg.

Guarded since 2026-08-20 by `test/unit/og_image_resolves_test.rb`, which
resolves every same-origin `og:image`/`twitter:image` in RENDERED output
against the build. Known gap: the two theme partials
(`blog/list.html`, `page/cover_image.html`) guard their tags with
`{{ if . }}` / `{{ with }}`, so a missing resource DROPS the tag rather than
dangling it - a page that loses its social image entirely is invisible to
that gate.

# Citations

[1] `layouts/partials/seo/enhanced-meta-tags.html`
[2] `static/assets/images/og-default.jpg` - the site-default fallback asset
