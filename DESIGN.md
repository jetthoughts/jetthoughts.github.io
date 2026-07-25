---
name: JetThoughts — JetVelocity
description: Obsidian-dark technical blueprint brand language over a light legacy page chrome; Ruby red is the brand ink.
colors:
  obsidian-deep: "#0a0e14"
  obsidian-raise: "#10141a"
  obsidian-violet: "#1a0a2e"
  ruby: "#cc342d"
  ruby-light: "#ff8a7a"
  ruby-pale: "#ffb4ab"
  neon-purple: "#a855f7"
  cyan-info: "#7dd0fe"
  ruby-hover: "#e04a42"
  status-green: "#22c55e"
  on-surface-dark: "#dfe2eb"
  ink: "#121212"
  muted: "#969798"
  legacy-blue: "#1a8cff"
  paper: "#ffffff"
typography:
  display:
    fontFamily: "Space Grotesk, system-ui, sans-serif"
    fontSize: "clamp(1.9rem, 5.2vw, 3.1rem)"
    fontWeight: 800
    letterSpacing: "-0.03em"
  headline:
    fontFamily: "Space Grotesk, system-ui, sans-serif"
    fontSize: "clamp(1.4rem, 3.4vw, 1.9rem)"
    fontWeight: 700
    letterSpacing: "-0.02em"
  title:
    fontFamily: "Space Grotesk, system-ui, sans-serif"
    fontSize: "20px"
    fontWeight: 700
  stat:
    fontFamily: "Space Grotesk, system-ui, sans-serif"
    fontSize: "28px"
    fontWeight: 800
    letterSpacing: "-0.02em"
  quote:
    fontFamily: "Space Grotesk, system-ui, sans-serif"
    fontSize: "19px"
    fontWeight: 700
  lede:
    fontFamily: "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
    fontSize: "18px"
  label:
    fontFamily: "Inter, system-ui, sans-serif"
    fontSize: "13px"
    fontWeight: 600
    letterSpacing: "0.14em"
  caption:
    fontFamily: "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
    fontSize: "14px"
  mono:
    fontFamily: "ui-monospace, SFMono-Regular, Menlo, Consolas, monospace"
    fontSize: "13px"
    fontWeight: 600
    letterSpacing: "0.2em"
  body:
    fontFamily: "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
    fontSize: "16px"
    lineHeight: 1.5
rounded:
  default: "4px"
  pill: "999px"
spacing:
  sm: "0.75rem"
  md: "1rem"
components:
  button-primary:
    backgroundColor: "{colors.legacy-blue}"
    textColor: "{colors.paper}"
    rounded: "{rounded.default}"
    padding: "12px 24px"
  pill-ruby:
    backgroundColor: "{colors.ruby}"
    textColor: "{colors.ruby-pale}"
    rounded: "{rounded.pill}"
---

# Design System: JetThoughts — JetVelocity

## Overview

**Creative North Star: "The Obsidian Engine"**

A dark technical blueprint: authoritative, precise, sophisticated. The brand
surface is deep obsidian shading toward violet, lit by two inks — Ruby red
(the JetThoughts mark, `#cc342d`) and neon purple — with engineering texture:
grid-dot backdrops, stat chips, mono status indicators. It reads like the
instrument panel of a serious engineering shop, not a marketing gradient.

The repository carries **two coexisting layers**, both real:

1. **JetVelocity (brand world, normative for new brand/conversion surfaces)** —
   the obsidian-dark language above. Canonical spec: `.stitch/design.md`
   (born for blog covers; CLAUDE.md names it the site design system).
2. **Legacy page chrome (incumbent, light)** — white pages with `#121212` ink,
   BEM `c-*` components, `--color-primary` blue `#1a8cff` buttons, 4px radius,
   system-ui type. Being consolidated by the 2509 CSS migration; extend it for
   continuity pages, do not re-skin it ad hoc.

**Key Characteristics:**
- Obsidian dark + ruby/purple dual-ink accents (brand surfaces)
- Engineering texture: chips, pills, mono status dots, grid-dot backdrops
- Space Grotesk 800 display over quiet system-ui body
- Flat surfaces; depth via tone and glow, not shadow stacks
- Light legacy chrome persists on existing pages — two worlds, never mixed mid-page

## Colors

Dual-ink on obsidian for brand surfaces; ink-on-paper for legacy pages.

### Primary
- **Ruby** (`#cc342d`): the JetThoughts brand ink. Pill fills, gradient starts,
  chip left-borders, the gem motif. Defined in site CSS as `--color-ruby`.
- **Neon Purple** (`#a855f7`): the second ink — gradient end, radial glow,
  secondary chip accent. Always the partner, never the lead.

### Secondary
- **Ruby Light → Ruby Pale** (`#ff8a7a` → `#ffb4ab`): highlights and text on
  ruby fills.
- **Cyan Info** (`#7dd0fe`): tertiary chip accent and informational touches.

### Neutral
- **Obsidian Deep / Raise / Violet** (`#0a0e14` / `#10141a` / `#1a0a2e`):
  brand-surface backgrounds, typically a 135° gradient deep→violet.
- **On-Surface Dark** (`#dfe2eb`): body text on obsidian.
- **Ink** (`#121212`): body text and dark fills on light pages (`--color-dark`).
- **Muted** (`#969798`): secondary text on light pages (`--color-muted`).
- **Legacy Blue** (`#1a8cff`): incumbent `--color-primary`; existing button/link
  color on light pages. Not a JetVelocity ink — do not carry it onto obsidian
  surfaces.

### Named Rules
**The Ruby Ink Rule.** Ruby `#cc342d` is the brand accent ink, used sparingly
and structurally (pills, gradient starts, borders) — its rarity is its
authority. It is never a background wash.

**The Never-Pure-White Rule.** On obsidian surfaces body text is
`#dfe2eb`, never `#ffffff` — pure white is reserved for display headlines.

## Typography

**Display Font:** Space Grotesk (system-ui fallback)
**Body Font:** system-ui stack (`--font-system-ui`)
**Label Font:** Inter, uppercase, wide tracking
**Mono Font:** JetBrains Mono (status/technical accents)

**Character:** engineered contrast — a heavy, tight-tracked grotesk display
voice over a deliberately plain, fast system body. Labels whisper in wide
uppercase; mono appears only where the content is machine-flavored.

### Hierarchy
- **Display** (800, tight `-0.03em`, large/clamped): hero headlines on brand
  surfaces; the hero word may take the ruby→purple gradient.
- **Body** (400, 16px, 1.5): all running text; system-ui on both worlds.
- **Label** (600, uppercase, `0.14em`–`0.22em` tracking): category slugs, chip
  labels, eyebrow lines.
- **Mono status** (600, uppercase, `0.2em`): `● STATUS` indicators only.

### Named Rules
**The One-Gradient-Word Rule.** The ruby→purple gradient belongs to at most
one emphasized display phrase per surface; everything else stays solid.

## Layout

Light pages: contained content column, BEM `c-*` sections, `--spacing-sm`
(0.75rem) / `--spacing-md` (1rem) rhythm. Brand surfaces: generous negative
space over the obsidian field, engineering-slot composition (brand/category
top-left, status bottom-right), 48px grid-dot texture at ~5% ruby opacity.
Mobile-first: every surface must hold at 390×844; gates verify 1280×800 and
390×844.

## Elevation & Depth

Flat by default on both worlds. On obsidian, depth comes from tonal layering
(deep → raise) and ambient radial glows (ruby at 10–14% opacity, purple at
8–12%) — not box-shadows. Chips sit on semi-transparent raised surface
(`rgba(28,32,38,0.75)`) with colored left borders instead of shadows.

## Shapes

Quiet geometry: 4px default radius (`--radius-default`) on buttons, cards,
inputs; full pills (999px) for year/category pills and status chips; sharp
edges on the obsidian field itself. Chip identity comes from a 3px colored
left border, not from shape.

## Components

### Buttons (light pages, incumbent)
- **Shape:** gently rounded (4px)
- **Primary:** legacy blue fill (`#1a8cff`), white text, 12px 24px padding
- **Hover:** 0.2s ease-in-out transition; **Active:** nudges down 1px
- **Secondary/Tertiary:** same base, color-only variants (BEM `c-button--*`)

### Ruby Pill (brand surfaces)
- Filled ruby (`#cc342d`), ruby-pale text, full-radius; Space Grotesk 700.
  Used for the year/ecosystem pill and as the CTA shape on obsidian.

### Stat Chips (brand surfaces)
- Semi-transparent raised background, 3px colored left border (ruby, purple,
  or cyan), Inter uppercase label + Space Grotesk value. Three per surface,
  each carrying a fact not already in the headline.

### Status Indicator (brand surfaces)
- `● STATUS TEXT` in JetBrains Mono uppercase with a colored dot
  (green `#22c55e` for OK); bottom-right anchor; texture, not navigation.

### Cards / Containers (light pages)
- 4px radius, white background, `--spacing-md` internal padding, flat.

## Do's and Don'ts

### Do:
- **Do** use ruby (`#cc342d`) as the structural accent — pills, borders,
  gradient starts — on both worlds.
- **Do** keep body text `#dfe2eb` on obsidian and `#121212` on paper.
- **Do** reuse the BEM `c-*` components on light pages and the chip/pill/status
  vocabulary on brand surfaces before inventing new patterns.
- **Do** hold the two-ink limit: ruby leads, purple partners, cyan only as a
  tertiary informational accent.

### Don't:
- **Don't** mix the worlds mid-page — a surface is either obsidian-brand or
  light-chrome.
- **Don't** carry legacy blue (`#1a8cff`) onto obsidian surfaces.
- **Don't** stack box-shadows for depth; use tone and glow.
- **Don't** use pure white body text on dark, or gradient more than one
  display phrase per surface.
- **Don't** invent a third accent hue; the palette is closed.
