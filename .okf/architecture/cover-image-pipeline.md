---
type: Playbook
title: Blog Cover Image Pipeline
description: How a blog post's cover image is generated (JetVelocity design system), stored, and rendered as thumbnail vs og:image; also why a workflow doc's "duplicate this reference" pointer must name a tracked file, not a gitignored one.
tags: [images, seo, design, cdn]
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-28T14:34:59Z
---

# Overview

Cover images are generated at a 2400×1260 source PNG (2x retina) using
the **JetVelocity "Obsidian Engine"** design system defined in
`.stitch/design.md`, and follow a mandatory 6-slot layout (brand/category,
year pill, 3-line gradient headline, visual ember, tag chips, status
chip). The 1200×630 og:image / 640·960·1920 responsive variants /
360×189 thumbnail listed in `.stitch/design.md` are the design spec's
**target** output sizes; the actual derivation each template performs is
described below — the source PNG is what the pipeline is authored
against.

Two distinct rendering paths consume the same source image:

- **`page/cover_image.html`** — emits only the `og:image` /
  `twitter:image` meta tags. If `site.Params.cdn.enabled`, it uses the
  CDN-resized resource's own `Permalink`/`Width`/`Height` directly;
  otherwise it falls back to a local Hugo `.Fit "512x512 jpeg"`. (The
  fixed 1200×630 og:image is emitted separately by
  [seo-meta-tags](/architecture/seo-meta-tags.md), not here.)
- **`partials/blog/img-cropped.html`** — renders the actual
  `<picture>` thumbnail markup used on cards/list pages. It resolves
  the source image from `metatags.image` (primary convention), falling
  back to `cover_image`, `cover`, then `featured_image` in that order.
  When the CDN is enabled it requests WebP + JPG at a mobile width and a
  caller-supplied retina desktop width via `partial "cdn/url"` calls (see
  `docs/workflows/cdn-image-proxy.md`). Without a source image it falls
  back to an aspect-preserving resize with `object-fit: contain`
  letterboxing.

  **Optional params (2026-08-20, whole-blog rebuild).** The mobile width
  was hardcoded to 160w (80px × 2) — which is why list covers were simply
  *hidden* below 860px: a full-width cover from a 160w source is blurry.
  Three optional params now cover the responsive case:

  | Param | Default | Purpose |
  |---|---|---|
  | `mobileWidth` | `80` | LARGEST css px the slot reaches ≤860px; drives the srcset candidate at 2× |
  | `mobileSizes` | `<mobileWidth>px` | the `sizes` mobile slot — may be a `vw` expression |
  | `loading` | `lazy` | `eager` for a cover that is the first visual |

  **`mobileWidth` alone is not enough, and getting this wrong is a silent
  quality regression.** A stacked full-width cover is ~320px on a phone and
  ~784px on an 860px tablet; one fixed px value under-serves one end badly
  (a fixed 430px slot shipped 860w where 1568w was needed — caught in
  review, not by any test). Pass `mobileSizes` as a `vw` expression matching
  the real box: list rows use `calc(100vw - 76px)` (20px page + 18px index
  padding, both sides), the feature `calc(100vw - 116px)` (plus its 20px
  card padding). Omitting all three reproduces the historical 80px/160w
  thumbnail byte-for-byte, so untouched callers are unaffected.

Any new cover image or thumbnail change is subject to the
[visual-scroll-gate](/workflows/visual-scroll-gate.md) — visual
defects (clipped text, wrong aspect, stale badges) are invisible to
text-only validation.

# A workflow doc must name a TRACKED file (fixed 2026-08-28)

`docs/workflows/cover-images.md` named two reference HTMLs under
`.stitch/designs/` for "duplicate this, don't author from scratch" — but that
directory is gitignored (`.gitignore:148`), so neither file exists in a fresh
clone. Nine cover HTMLs are tracked (force-added past the ignore); the doc now
points at two of those instead, with a one-line note on why.

Generalizes past this doc: a "duplicate this reference" instruction rots
silently the moment its target directory is gitignored — nothing fails until
someone works from a clean checkout, so the rot is invisible to whoever wrote
or last edited the instruction. When adding a "copy this file" pointer to any
workflow doc, confirm the target is tracked (`git ls-files <path>`), not just
present locally.

# Citations

[1] `themes/beaver/layouts/partials/page/cover_image.html`
[2] `themes/beaver/layouts/partials/blog/img-cropped.html`
[3] `.stitch/design.md`
[4] `docs/workflows/cover-images.md`
