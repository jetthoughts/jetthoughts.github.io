---
type: Playbook
title: Blog Cover Image Pipeline
description: How a blog post's cover image is generated (JetVelocity design system), stored, and rendered as thumbnail vs og:image.
tags: [images, seo, design, cdn]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

Cover images are generated at a 2400×1260 source PNG (2x retina) using
the **JetVelocity "Obsidian Engine"** design system defined in
`.stitch/design.md`, and follow a mandatory 6-slot layout (brand/category,
year pill, 3-line gradient headline, visual ember, tag chips, status
chip). Hugo derives the 1200×630 `og:image`, responsive
640/960/1920 WebP/JPG variants, and a 360×189 thumbnail from that
source at build/CDN time.

Two distinct rendering paths consume the same source image:

- **`page/cover_image.html`** — emits only the `og:image` /
  `twitter:image` meta tags. If `site.Params.cdn.enabled`, it uses the
  CDN-resized resource's own `Permalink`/`Width`/`Height` directly;
  otherwise it falls back to a local Hugo `.Fit "512x512 jpeg"`.
- **`partials/blog/img-cropped.html`** — renders the actual
  `<picture>` thumbnail markup used on cards/list pages. It resolves
  the source image from `metatags.image` (primary convention), falling
  back to `cover_image`, `cover`, then `featured_image` in that order.
  When the CDN is enabled it requests WebP + JPG at both a fixed mobile
  width (`160px`, i.e. 80px × 2 retina) and a caller-supplied retina
  desktop width via `partial "cdn/url"` calls (see
  `docs/workflows/cdn-image-proxy.md`), with `loading="lazy" decoding="async"`.
  Without a source image it falls back to an aspect-preserving resize
  with `object-fit: contain` letterboxing.

Any new cover image or thumbnail change is subject to the
[visual-scroll-gate](/workflows/visual-scroll-gate.md) — visual
defects (clipped text, wrong aspect, stale badges) are invisible to
text-only validation.

# Citations

[1] `themes/beaver/layouts/partials/page/cover_image.html`
[2] `themes/beaver/layouts/partials/blog/img-cropped.html`
[3] `.stitch/design.md`
[4] `docs/workflows/cover-images.md`
