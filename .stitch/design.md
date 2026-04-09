# JetVelocity Design System — Blog Cover Images

## Project Overview
- **Project**: JetThoughts Blog Covers
- **Stitch Project ID**: `3224353017067976684`
- **Platform**: Web, 1200×630 (Open Graph standard)
- **Style**: Dark, technical, authoritative — "The Obsidian Engine"

## Creative North Star
**"The Obsidian Engine"** — High-end IDE/technical blueprint aesthetic. Authoritative, precise, sophisticated dark atmosphere. Intentional asymmetry: heavy left-aligned typography, negative space right, punctuated by floating glassmorphic elements.

## Color Palette
| Token | Hex | Usage |
|-------|-----|-------|
| Background | `#10141a` | Primary canvas |
| Surface Low | `#181c22` | Content blocks |
| Surface Container | `#1c2026` | Cards, code blocks |
| Surface Container High | `#262a31` | Elevated elements |
| Surface Container Highest | `#31353c` | Overlays, tooltips |
| On Background | `#dfe2eb` | Body text (NEVER pure white #FFFFFF) |
| Primary (Ruby Red) | `#cc342d` | Ruby/brand accents, badges, CTAs |
| Primary Fixed Dim | `#ffb4ab` | Light ruby highlights |
| Secondary (Neon Purple) | `#a855f7` | Gradient accents, highlights |
| Secondary Container | `#6f00be` | Deep purple gradients |
| Secondary Fixed Dim | `#ddb7ff` | Light purple accents |
| Tertiary (Cyan) | `#7dd0fe` | Tech details, accent lines |
| Tertiary Container | `#0076a0` | Deep cyan backgrounds |
| Outline Variant | `#5a403d` | Ghost borders at 15% opacity |

## Typography
- **Headlines**: Space Grotesk — Bold (800), tight letter-spacing (-0.02em)
- **Body/Metadata**: Inter — Regular (400), line-height 1.6
- **Labels/Badges**: Inter — SemiBold (600), ALL CAPS, tracked out (+0.05em)

## Layout Pattern (1200×630 OG Standard)
1. **Background**: Dark gradient `#10141a` → `#1a0a2e` with subtle topic-specific patterns
2. **Top-left**: "JetThoughts" brand mark in `#dfe2eb`
3. **Top-right**: Topic pill badge in Ruby Red `#cc342d`
4. **Center-left**: Large bold headline (2-3 lines max, `#dfe2eb`, Space Grotesk)
5. **Bottom-left**: Stat/feature badges in a row (colored tags using brand colors)
6. **Right side**: Abstract visual element — glowing gem/crystal/icon/network in brand colors

## Rules
- **No-Line Rule**: No 1px solid borders for sectioning — use tonal shifts
- **Glass & Gradient**: CTA gradient from `#cc342d` to `#6f00be` at 135°
- **Intentional Asymmetry**: Heavy left-aligned typography, negative space right
- **Never use #FFFFFF** — always `#dfe2eb` for text
- **Thumbnail readable**: Text must be legible at 300×157px
- **Breathing Room**: Generous whitespace — high-end brands need space
- **Code Blocks**: Use `#0a0e14` background with 2px cyan `#7dd0fe` accent line on left

## Prompt Template for Stitch
```
A 1200×630 technical blog cover for 'JetThoughts' about [TOPIC].

**DESIGN SYSTEM (REQUIRED):**
- Platform: Web, 1200×630 Open Graph standard
- Palette: Obsidian background (#10141a), Ruby red (#cc342d), Neon purple (#a855f7), Cyan (#7dd0fe)
- Typography: Space Grotesk for headlines, Inter for body/labels
- Styles: Dark gradient (#10141a → #1a0a2e), glassmorphic elements, intentional asymmetry

**PAGE STRUCTURE:**
1. **Background:** Dark gradient with subtle [TOPIC-SPECIFIC] patterns
2. **Top-left:** "JetThoughts" brand mark
3. **Top-right:** "[TOPIC BADGE]" pill badge in Ruby red (#cc342d)
4. **Center-left:** Large bold headline "[HEADLINE]" in white (#dfe2eb), 2 lines
5. **Bottom-left:** Stat badges: "[Badge 1]" · "[Badge 2]" · "[Badge 3]" — colored tags
6. **Right side:** Abstract visual — [TOPIC-SPECIFIC] glowing element, in brand colors

Mood: [3 descriptive words].
```

---

## Cover Image Workflow

### Frontmatter Convention
Every blog post should use `cover_image` pointing to a file in the **same page bundle**:

```yaml
---
title: "Post Title"
description: "Post description"
date: 2026-04-09
cover_image: "cover.jpg"
cover_image_alt: "Descriptive alt text for the cover image"
---
```

### File Structure
```
content/blog/post-slug/
├── index.md          ← Frontmatter with cover_image field
├── cover.jpg         ← Cover image (1200×630px, JPEG/WebP)
└── other-assets/     ← Any additional images
```

### Template Priority
Templates check image fields in this order:
1. `cover_image` — **preferred**, looks in page bundle
2. `cover` — alias for `cover_image`
3. `featured_image` — legacy, also checks page bundle
4. `metatags.image` — fallback

### What Each Template Does
| Template | Uses cover_image for |
|----------|---------------------|
| `blog/img-cropped.html` | 180×180 thumbnail on blog index |
| `seo/enhanced-meta-tags.html` | og:image (1200×630) + twitter:image |
| `sitemap.xml` | Image sitemap entries |

### Generating Covers with Stitch
1. Run: `/stitch-design generate cover for [post title]`
2. Stitch generates in project `3224353017067976684` (JetThoughts Blog Covers)
3. Download HTML → screenshot at **2400×1260** (2x for Retina/Apple devices) → save as **`cover.png`** in post bundle (lossless source)
4. Hugo auto-converts to WebP/JPEG at build time — no manual conversion needed
5. Add `cover_image: "cover.png"` + `cover_image_alt: "..."` to frontmatter
6. Run `bin/hugo-build` to verify og:image renders

### Image Resolution Standards
- **Source**: **PNG at 2400×1260 (2x)** — lossless master, always keep this
- **Hugo converts to**: **JPG at q90** for all outputs (og:image, thumbnails)
- **OG Meta Tags**: Auto-resized to 1200×630 JPG (from 2x PNG source = crisp)
- **Blog Index Thumbnail**: Auto-resized to 180×180 JPG
- **Never use JPEG as source** — always PNG for quality retention

### Quick Checklist for New Posts
- [ ] `cover.png` exists in `content/blog/post-slug/` (2400×1260, 2x)
- [ ] `cover_image: "cover.png"` in frontmatter
- [ ] `cover_image_alt: "..."` in frontmatter
- [ ] `bin/hugo-build` passes
- [ ] Blog index shows thumbnail (180×180)
- [ ] og:image meta tag present (1200×630, crisp from 2x source)
