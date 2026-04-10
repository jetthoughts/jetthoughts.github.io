# JetVelocity Design System — Blog Cover Images

## Overview
- **Project**: JetThoughts Blog Covers
- **Stitch Project ID**: `3224353017067976684`
- **Canvas**: **2400×1260** source PNG (2× retina). Hugo derives 1200×630 og:image, 640/960/1920 responsive WebP/JPG, and 360×189 thumbnail.
- **Style**: `The Obsidian Engine` — dark technical blueprint. Authoritative, precise, sophisticated.

## Creative North Star
High-end engineering blog covers that survive both as full hero images AND as blog-list thumbnails. Every slot earns its space. No slot repeats copy the reader already has from the SERP snippet or the post's H1.

---

## Canonical 6-Slot Layout (MANDATORY)

Every cover MUST follow this layout. Reference implementations:
- `.stitch/designs/rails-8-1-active-job-continuations-cover.html`
- `.stitch/designs/rails-argon2-has-secure-password-cover.html`

```
┌──────────────────────────────────────────────────────────┐
│  [1] Brand | CATEGORY                     [2] Year pill  │
│                                                          │
│  [3] Headline line 1 (white)                             │
│      Headline line 2 (RUBY→PURPLE GRADIENT)   [4] Visual │
│      Headline line 3 (white)                      ember  │
│                                                          │
│  [5] chip · chip · chip           [6] ● STATUS CHIP      │
└──────────────────────────────────────────────────────────┘
```

| Slot | Content | Anti-redundancy rule |
|------|---------|----------------------|
| **1. Brand + category** | `JetThoughts | ENGINEERING` (or `TUTORIAL`, `CASE STUDY`) | Category tells a Google arrival *what kind* of content this is — something the SERP snippet doesn't convey. |
| **2. Year pill** | `Ruby on Rails 2026` (ecosystem + year, filled ruby pill) | **Year, NOT version.** Version (e.g. "Rails 8.1") is already in the H1. Year answers "is this still current?" which is the #1 concern for dev readers. |
| **3. Headline (3 lines)** | Line 1: short white phrase. Line 2: hero word with ruby→purple gradient. Line 3: short white value-prop or context word. | The headline IS the typographic art — acceptable redundancy with the post title because it's presented as visual, not copy. |
| **4. Visual ember (right)** | Low-poly SVG ruby gem (consistent across ALL Ruby/Rails posts) — ecosystem marker, not topic marker. | Never swap the gem per-post. It's the brand throughline. |
| **5. Stat chips (3)** | Each chip has `LABEL value`. The three values MUST be facts **not in the post title**. | If a chip could be inferred from reading the H1, it has zero information value. Replace it. |
| **6. Status indicator** | `● STATUS TEXT` with colored dot, bottom-right | Adds texture and engineering vibe. Text should be post-specific (e.g. `DEPLOY SAFE`, `PRODUCTION READY`, `ZERO LOGOUTS`). |

### Anti-Redundancy Audit (do before shipping)

Before rendering any cover, answer these. Every **yes** means the element is dead weight:

- Does the pill repeat the version shown in the H1?
- Do any stat chips repeat the subject of the H1?
- Does a footer meta strip repeat the post tags rendered below the cover?
- Does the subtitle paraphrase the H1 without adding a benefit?

If the post is migrated from an older design with a subtitle, drop the subtitle unless it adds a *new benefit phrase* (e.g. "zero lost work") that the title lacks.

---

## Color Tokens

| Token | Hex | Usage |
|-------|-----|-------|
| Background base | `#0d1117` → `#10141a` → `#1a0a2e` | 135deg linear gradient |
| Ruby red | `#cc342d` | Pill fill, gradient start, chip left-border #1, gem core |
| Ruby light | `#ff8a7a` → `#ffb4ab` | Gem highlights, pill text |
| Neon purple | `#a855f7` | Gradient end, chip left-border #2, radial glow |
| Cyan info | `#7dd0fe` → `#bfe5ff` | Chip left-border #3 |
| On surface | `#dfe2eb` | Body text (NEVER pure white `#ffffff` except headline) |
| Chip background | `rgba(28, 32, 38, 0.75)` | Semi-transparent surface |
| Status green | `#22c55e` | "OK" status dot |
| Radial glow ruby | `rgba(204, 52, 45, 0.10-0.14)` | Ambient atmosphere |
| Radial glow purple | `rgba(168, 85, 247, 0.08-0.12)` | Ambient atmosphere |
| Grid dots | `rgba(204, 52, 45, 0.05)` | 48px code-pattern backdrop |

## Typography

| Element | Font | Weight | Size (2400 canvas) | Letter-spacing |
|---------|------|--------|--------------------|----------------|
| Headline line 1 & 2 | Space Grotesk | 800 | 180px | -0.030em |
| Headline line 3 | Space Grotesk | 800 | 150px | -0.030em |
| Brand name | Space Grotesk | 700 | 56px | -0.020em |
| Category slug | Inter | 600 | 26px uppercase | 0.22em |
| Pill | Space Grotesk | 700 | 34px | -0.005em |
| Chip label | Inter | 600 | 22px uppercase | 0.14em |
| Chip value | Space Grotesk | 700 | 30px | -0.005em |
| Status text | JetBrains Mono | 600 | 22px uppercase | 0.20em |

### Headline width budget
At 180px, "Continuations" measures ≈1228px in Space Grotesk 800. The hero column is 8 of 12 grid units (≈1400px after padding). Words longer than ~13 characters may need to drop to 160-170px. Always measure via canvas `measureText` before committing.

---

## Build Pipeline

### 1. Author HTML
- Canvas: `html, body { width: 2400px; height: 1260px; overflow: hidden }`
- Load fonts via `<link>` (NOT `@import`) for predictable load in headless Chrome
- Fonts: `Space Grotesk`, `Inter`, `JetBrains Mono` (all from Google Fonts)
- Duplicate a reference HTML from `.stitch/designs/` — do NOT start from scratch

### 2. Render at 2× retina
```bash
# chrome-devtools MCP:
mcp__chrome-devtools__new_page   file:///path/to/cover.html
mcp__chrome-devtools__emulate    viewport=2400x1260x2
mcp__chrome-devtools__take_screenshot  filePath=/tmp/cover-2x.png
```
This produces a 4800×2520 PNG.

### 3. Lanczos downsample to final 2400×1260
```bash
magick /tmp/cover-2x.png -filter Lanczos -resize 2400x1260 \
  -sampling-factor 4:4:4 -strip -quality 95 \
  content/blog/<post-slug>/cover.png
```

### 4. Hugo build
```bash
bin/hugo-build
```
Hugo auto-derives:
- `cover_hu_*.jpg` 1200×630 (og:image)
- `cover_hu_*.webp` 640/960/1920 responsive srcset
- `cover_hu_*.jpg` 360×189 thumbnail (aspect-preserving, 2× retina for 180x display)

### 5. Frontmatter
```yaml
---
title: "Post Title That Maps to Hero Line 2"
metatags:
  image: cover.png
cover_image: "cover.png"
cover_image_alt: "Descriptive alt text matching the cover composition"
---
```

---

## Thumbnail Behavior

The blog list thumbnail is **aspect-preserving**, NOT center-cropped. The 2400×1260 source becomes `360×189` via Hugo's `.Resize "360x"` (2× retina source for a 180-wide CSS slot). CSS letterboxes the landscape thumbnail inside a 180×180 square with the obsidian background bleeding into the bars above/below.

**Why not center-crop?** The canonical 6-slot layout has the hero on the left and the gem visual on the right. A center crop would fragment both. The aspect-preserving approach shows the entire composition — the reader sees the same hero, gem, chips, and status that appears on the post page.

See `themes/beaver/layouts/partials/blog/img-cropped.html` and `.post-image` rules in `themes/beaver/assets/css/{homepage-layout,3114-layout}.css`.

---

## Per-Post Content Guide

When creating a new cover, answer these four questions before writing HTML:

1. **What's the post's CATEGORY?** (`ENGINEERING`, `TUTORIAL`, `CASE STUDY`, `OPINION`, `OPERATIONS`)
2. **What's the hero word?** Pick the single most iconic noun from the title. Put it on line 2 with the gradient.
3. **What 3 facts are NOT in the post title?** These become the stat chips. Each chip is `LABEL value` where:
   - Label is one word, all-caps, 0.14em tracking
   - Value is 1-3 words, mixed case, slightly larger
4. **What's the post's success signal?** This becomes the status indicator text (`DEPLOY SAFE`, `PRODUCTION READY`, `ZERO LOGOUTS`, `MIGRATION COMPLETE`).

### Worked examples

| Post | Category | Line 1 | Line 2 (gradient) | Line 3 | Chip 1 | Chip 2 | Chip 3 | Status |
|------|----------|--------|-------------------|--------|--------|--------|--------|--------|
| Active Job Continuations | Engineering | `Active Job` | `Continuations` | `Deploy-Safe` | CHECKPOINT · resume mid-job | KAMAL · SIGTERM-safe | RESTARTS · 0 lost jobs | Deploy Safe |
| `has_secure_password` + Argon2 | Engineering | `BCrypt to` | `Argon2` | `Zero Downtime` | ALGORITHM · memory-hard | ROLLOUT · hybrid verifier | USERS · 0 forced logouts | Production Ready |

---

## File Layout

```
.stitch/
├── design.md                           # this file (canonical spec)
├── designs/
│   ├── rails-8-1-active-job-continuations-cover.html
│   └── rails-argon2-has-secure-password-cover.html
```

```
content/blog/<post-slug>/
├── index.md              # frontmatter with metatags.image: cover.png
└── cover.png             # 2400×1260 PNG (Hugo derives all variants)
```

## Quick Checklist

- [ ] New cover HTML is a duplicate of an existing reference file (not written from scratch)
- [ ] All 6 slots filled: brand+category, year pill, 3-line hero, gem visual, 3 stat chips, status
- [ ] Pill carries YEAR not version
- [ ] Stat chips contain facts NOT in the post title
- [ ] `cover.png` exists in post bundle at 2400×1260
- [ ] `metatags.image: cover.png` in frontmatter
- [ ] `cover_image: cover.png` in frontmatter
- [ ] `cover_image_alt` describes the cover composition
- [ ] `bin/hugo-build` passes
- [ ] Blog index shows the full cover landscape (not a square crop)
