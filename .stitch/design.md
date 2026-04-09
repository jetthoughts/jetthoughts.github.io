# JetVelocity Design System — Blog Cover Images

## Project Overview
- **Project**: JetThoughts Blog Covers
- **Stitch Project ID**: `3224353017067976684`
- **Platform**: Web, 2400×1260 (2x for Retina, OG standard is 1200×630)
- **Style**: Dark, technical, authoritative — "The Obsidian Engine"

## Creative North Star
**"The Obsidian Engine"** — High-end IDE/technical blueprint aesthetic. Authoritative, precise, sophisticated dark atmosphere. Intentional asymmetry: brand top-left, topic pill top-right, headline centered or left-aligned.

## Color Palette
| Token | Hex | Usage |
|-------|-----|-------|
| Background | `#0d1016` → `#141820` | Gradient base (145deg) |
| On Background | `#dfe2eb` | Body text (NEVER pure white #FFFFFF) |
| Primary (Ruby Red) | `#cc342d` | Badges, accents, CTAs |
| Primary Light | `#ffb4ab` | Pill text, highlights |
| Secondary (Neon Purple) | `#a855f7` | Gradient accents |
| Gradient | `#cc342d` → `#a855f7` | Accent text, rules (135deg) |
| Grid | `rgba(223,226,235,0.012)` | Barely-there 80px grid |

## Typography
- **Headlines**: Space Grotesk 800, `letter-spacing: -0.025em`
- **Brand/Labels**: Inter 600, ALL CAPS, `letter-spacing: 0.16em`
- **Pills**: Inter 600, `letter-spacing: 0.10em`
- **Subtitle**: Inter 500, `color: rgba(223,226,235,0.35)`

## Layout Rules (MANDATORY for ALL covers)

### 1. Thumbnail Crop Safety (CRITICAL)
The blog index uses a 180×180 center-crop from the 2400×1260 source:
- **Crop zone**: x=1110..1290, y=540..720 (180×180 from center)
- **Headline MUST fit entirely in crop zone**: Place headline at `top: 540px`, centered, max 2 lines at 80px font (176px tall = fits in 180px crop height)
- **Brand/pill MUST be outside crop zone**: `top < 540px` or `top > 720px`
- **Subtitle MUST be outside crop zone**: `top > 720px`

### 2. Asymmetric Layout
- Brand: top-left, `top: 100px, left: 160px`
- Topic pill: top-right, `top: 100px, right: 160px`
- Never center both brand and pill — creates template feel

### 3. Element Count (MAX 5)
1. Brand mark (small, top-left)
2. Topic pill (top-right)
3. Headline (centered, 2 lines max)
4. Thin rule (below headline, gradient)
5. Subtitle (below rule, only visible on full cover)

### 4. Visual Metaphor (Optional)
- If topic benefits from a visual (e.g., checkpoint nodes for "continuations"):
  - Position RIGHT side, `right: 160px, top: 400px`
  - Max 200×200px
  - Use brand colors only (red, purple, cyan)
  - Must be simple — 2-3 elements max

### 5. Grid & Texture
- Subtle 80px grid at 1.2% opacity
- Radial glows: Ruby red 10% (right), Purple 8% (left)
- Never use solid colors or heavy patterns

## Prompt Template for Stitch
```
A 1200×630 technical blog cover for 'JetThoughts' about [TOPIC].

**DESIGN SYSTEM (JetVelocity — Obsidian Engine):**
- Background: gradient #0d1016 → #141820 at 145deg, subtle 80px grid at 1.2%
- Headline font: Space Grotesk 800, white (#dfe2eb), letter-spacing -0.025em
- Accent: Ruby red (#cc342d) → Neon purple (#a855f7) gradient on key word
- Brand: top-left, small, uppercase
- Topic pill: top-right, Ruby red background, light text
- NEUTRAL: #dfe2eb for text (NEVER #FFFFFF)

**LAYOUT:**
- Headline: centered, 2 lines max, positioned at top center
- Thin gradient rule below headline
- Subtitle below rule: "[One-line description]"
- [Optional visual metaphor on right side]

**THUMBNAIL CROP SAFETY (CRITICAL):**
The 180×180 center-crop captures only the center 180×180px. Headline MUST be fully within this zone. Brand and pill MUST be outside this zone.

Mood: [3 descriptive words: minimalist, technical, premium].
```

## Cover Image Workflow

### Generating Covers
1. Run: `/stitch-design generate cover for [post title]`
2. Stitch generates in project `3224353017067976684` (JetThoughts Blog Covers)
3. Download HTML → screenshot at **2400×1260** (2x Retina) → save as `cover.png` in post bundle
4. Add `metatags.image: cover.png` + `cover_image: "cover.png"` + `cover_image_alt: "..."` to frontmatter
5. Run `bin/hugo-build` to verify og:image renders

### Frontmatter Convention
```yaml
---
title: "Post Title"
categories: ["Engineering"]
cover_image: cover.png
cover_image_alt: "Descriptive alt text"
metatags:
  image: cover.png
---
```

### File Structure
```
content/blog/post-slug/
├── index.md          # metatags.image: cover.png
└── cover.png         # 2400×1260 PNG source (Hugo converts to JPG q90)
```

### Image Resolution Standards
| Output | Size | Format |
|--------|------|--------|
| Source | 2400×1260 (2x) | PNG (lossless) |
| og:image | 1200×630 (1x) | JPG q90 (Hugo auto) |
| Thumbnail | 180×180 | JPG q90 (Hugo auto crop) |

### Quick Checklist
- [ ] `cover.png` exists in `content/blog/post-slug/` (2400×1260)
- [ ] `metatags.image: cover.png` in frontmatter
- [ ] `cover_image: cover.png` in frontmatter
- [ ] `cover_image_alt: "..."` in frontmatter
- [ ] Headline positioned within crop zone (y=540..720, x=1110..1290)
- [ ] Brand/pill outside crop zone
- [ ] `bin/hugo-build` passes
- [ ] og:image renders at 1200×630
- [ ] Blog index shows thumbnail (180×180) with full headline visible
