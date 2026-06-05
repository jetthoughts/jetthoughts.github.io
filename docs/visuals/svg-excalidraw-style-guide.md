# Excalidraw-Style SVG Guide — Course Visuals

Canonical spec for all inline SVGs in the JetThoughts course. Follow these conventions when creating new SVGs. Existing SVGs that don't match should be migrated over time (see Migration Guide below).

## Creative North Star

Hand-drawn whiteboard diagrams that a founder would sketch on a napkin. Imperfect, casual, warm. The roughness signals "this was made by a person, not a design tool." Never polished, never perfect — SVG filters simulate pen-on-paper jitter.

---

## Starter Template

Copy this into a new `.svg` file and replace the placeholder content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 960 520" role="img" aria-labelledby="diagram-title">
  <title id="diagram-title">Replace with descriptive title</title>
  <desc>Optional: what the reader sees and what to compare.</desc>
  <defs>
    <style>
      .title   { font-family: "Caveat", "Patrick Hand", cursive; font-size: 28px; fill: #1a1a1a; font-weight: 700; }
      .heading { font-family: "Caveat", "Patrick Hand", cursive; font-size: 22px; fill: #1a1a1a; font-weight: 700; }
      .body    { font-family: "Caveat", "Patrick Hand", cursive; font-size: 16px; fill: #1a1a1a; }
      .note    { font-family: "Caveat", "Patrick Hand", cursive; font-size: 14px; fill: #555; font-style: italic; }
      .badge   { font-family: "Caveat", "Patrick Hand", cursive; font-size: 13px; fill: #fff; font-weight: 700; }
      .muted   { font-family: "Caveat", "Patrick Hand", cursive; font-size: 14px; fill: #666; font-style: italic; }

      /* Card classes — fill from the core palette below */
      .card-indigo  { fill: #eef2ff; stroke: #4f46e5; stroke-width: 2.5; stroke-linejoin: round; }
      .card-cyan    { fill: #ecfeff; stroke: #0891b2; stroke-width: 2.5; stroke-linejoin: round; }
      .card-amber   { fill: #fffbeb; stroke: #d97706; stroke-width: 2.5; stroke-linejoin: round; }
      .card-ruby    { fill: #fff5f5; stroke: #cc342d; stroke-width: 2.5; stroke-linejoin: round; }
      .card-green   { fill: #f0fdf4; stroke: #16a34a; stroke-width: 2.5; stroke-linejoin: round; }

      /* Pills */
      .pill-indigo  { fill: #4f46e5; }
      .pill-cyan    { fill: #0891b2; }
      .pill-amber   { fill: #d97706; }
      .pill-ruby    { fill: #cc342d; }
      .pill-green   { fill: #16a34a; }
    </style>

    <filter id="rough" x="-3%" y="-3%" width="106%" height="106%">
      <feTurbulence type="fractalNoise" baseFrequency="0.04" numOctaves="3" seed="7"/>
      <feDisplacementMap in="SourceGraphic" scale="2.5"/>
    </filter>

    <filter id="rough-arrow" x="-3%" y="-3%" width="106%" height="106%">
      <feTurbulence type="fractalNoise" baseFrequency="0.06" numOctaves="2" seed="12"/>
      <feDisplacementMap in="SourceGraphic" scale="1.8"/>
    </filter>
  </defs>

  <!-- Background -->
  <rect width="960" height="520" fill="#fafaf7"/>

  <!-- Title -->
  <text x="480" y="38" class="title" text-anchor="middle">Your Diagram Title</text>
  <text x="480" y="62" class="muted" text-anchor="middle">Subtitle or one-line explanation</text>

  <!-- Example card (copy and reposition) -->
  <rect x="60" y="100" width="400" height="200" rx="10" class="card-indigo" filter="url(#rough)"/>
  <text x="260" y="135" class="heading" text-anchor="middle">Card Title</text>
  <text x="260" y="165" class="body" text-anchor="middle">First line of body text</text>
  <text x="260" y="187" class="body" text-anchor="middle">Second line of body text</text>
  <line x1="80" y1="210" x2="440" y2="210" stroke="#4f46e5" stroke-width="1" stroke-dasharray="4 3" opacity="0.4"/>
  <text x="260" y="238" class="note" text-anchor="middle">Artifact or note</text>

  <!-- Example arrow -->
  <g filter="url(#rough-arrow)">
    <line x1="470" y1="200" x2="530" y2="200" stroke="#777" stroke-width="2.5"/>
    <polygon points="528,192 542,200 528,208" fill="#777"/>
  </g>

</svg>
```

**For system-font SVGs** (decision matrices, dense comparison tables), swap the CSS font stack to:

```css
.font-title   { font-family: "Segoe UI", system-ui, -apple-system, sans-serif; font-size: 30px; fill: #1a1a1a; font-weight: 700; }
.font-heading { font-family: "Segoe UI", system-ui, -apple-system, sans-serif; font-size: 24px; fill: #1a1a1a; font-weight: 700; }
.font-body    { font-family: "Segoe UI", system-ui, -apple-system, sans-serif; font-size: 17px; fill: #1a1a1a; }
.font-note    { font-family: "Segoe UI", system-ui, -apple-system, sans-serif; font-size: 15px; fill: #555; font-style: italic; }
```

---

## The Rough Filter (MANDATORY)

Every SVG MUST include these filters in `<defs>`. Copy them verbatim from the starter template.

**Primary filter** — for cards, rects, polygons:

```xml
<filter id="rough" x="-3%" y="-3%" width="106%" height="106%">
  <feTurbulence type="fractalNoise" baseFrequency="0.04" numOctaves="3" seed="7"/>
  <feDisplacementMap in="SourceGraphic" scale="2.5"/>
</filter>
```

**Arrow filter** — less jitter so arrowheads stay recognizable:

```xml
<filter id="rough-arrow" x="-3%" y="-3%" width="106%" height="106%">
  <feTurbulence type="fractalNoise" baseFrequency="0.06" numOctaves="2" seed="12"/>
  <feDisplacementMap in="SourceGraphic" scale="1.8"/>
</filter>
```

**Apply to**: All rectangles, polygons, lines, and arrows. Do NOT apply to text elements.

**Varying parameters**:
- `seed`: 2-15. Change only if two overlapping shapes produce identical jitter (rare).
- `scale`: 2.5 default. Drop to 1.8 for arrows/lines. Bump to 3 for large background rects.

---

## Color Palette

### Core Palette (use these first)

| Token | Fill | Stroke | Usage |
|-------|------|--------|-------|
| Indigo | `#eef2ff` | `#4f46e5` · 2.5px | Hypothesis / strategy |
| Cyan | `#ecfeff` | `#0891b2` · 2.5px | Validation / interviews |
| Amber | `#fffbeb` | `#d97706` · 2.5px | Design / planning |
| Ruby red | `#fff5f5` | `#cc342d` · 2.5px | Build / warnings / bad |
| Green | `#f0fdf4` | `#16a34a` · 2.5px | First customer / good / done |

### Extended Palette (use when core 5 aren't enough)

| Token | Fill | Stroke | When to use |
|-------|------|--------|-------------|
| Green (dark) | `#f0f9f0` | `#2e7d32` · 2.5px | Ownership chapters, "correct" answers |
| Purple | `#fbe9ff` | `#a855f7` · 2.5px | Champions, high-priority tier |
| Blue | `#e8f4f8` | `#0277bd` · 2.5px | Cloud, infrastructure |
| Yellow | `#fffbe6` | `#bf8a00` · 2.5px | Validate-without-code quadrant |
| Gold | `#fff8e0` | `#b8860b` · 2.5px | Warm tier, secrets zone |
| Purple-light | `#f5e9ff` | `#7c3aed` · 2.5px | Fractional CTO |
| Gray | `#f0f0f0` | `#666` · 2px, dashed | Cold/dormant tier |

### Background

| Token | Hex | Usage |
|-------|-----|-------|
| Paper | `#fafaf7` | Default. Warm off-white. Never sterile `#ffffff`. |
| Near-white | `#fafafa` | Alternative when `#fafaf7` clashes. |

### Text Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Body | `#1a1a1a` | Titles, headings, labels |
| Secondary | `#444` | Sub-labels, artifact names |
| Muted | `#555` | Notes, captions |
| Subtle | `#666` | Italic footnotes |
| Arrow | `#777` | Arrow labels and shafts |

### Semantic Accents

| Meaning | Color |
|---------|-------|
| Bad / wrong / warning | `#cc342d` (ruby red) |
| Good / correct / done | `#2e7d32` or `#16a34a` (green) |
| Callout / emphasis | `#a3621e` (brown-gold italic) |

---

## Typography

### Primary: Handwritten (PREFERRED)

Use for conceptual diagrams, bucket frameworks, narrative visuals, and pipeline flows.

```css
font-family: "Caveat", "Patrick Hand", cursive;
```

**Size scale** (Caveat runs smaller than system fonts — size up):

| Element | Size | Weight | Color | Line spacing |
|---------|------|--------|-------|-------------|
| Page title | 28px | 700 | `#1a1a1a` | — |
| Subtitle | 16px | 400 italic | `#666` | 24px after title |
| Card title | 22px | 700 | `#1a1a1a` | — |
| Section label | 18px | 700 | `#1a1a1a` | 26px after card title |
| Body / rule text | 16px | 400 | `#1a1a1a` | 22px between lines |
| Sub-label | 15px | 400 | `#555` | 20px between lines |
| Artifact / note | 14px | 400 italic | `#444` | 20px between lines |
| Badge text | 13px | 700 | `#fff` | — |
| Large number | 38px | 700 | `#cc342d` | — |

### Fallback: System Font

Use only for decision matrices, dense comparison tables, and text-heavy cognitive diagrams where Caveat becomes illegible at small sizes:

```css
font-family: "Segoe UI", system-ui, -apple-system, sans-serif;
```

| Element | Size | Weight | Line spacing |
|---------|------|--------|-------------|
| Title | 30-34px | 700 | — |
| Heading | 24-26px | 700 | 32px after title |
| Body | 17-20px | 400 | 24px between lines |
| Caption | 16px | 400 italic | 22px between lines |
| Note | 14-15px | 400 | 20px between lines |

**Decision rule**: If the SVG has more than 15 text elements or text below 14px, use system font. If it's a conceptual diagram, use handwritten. Never mix font families within one SVG.

**`text-anchor` convention**: Page titles and card titles use `text-anchor="middle"` (centered on the card/viewport midpoint). Body text within cards uses `text-anchor="middle"` when cards are narrow (≤200px wide) or left-aligned at `x="card-x + 20"` for wider cards.

---

## Card Conventions

### Shape

```xml
<rect x="..." y="..." width="..." height="..." rx="10" class="card-indigo" filter="url(#rough)"/>
```

- `rx="10"` for standard cards, `rx="12-14"` for larger containers
- Always include `stroke-linejoin: round` in the CSS class — softens stroke corners to match pen-on-paper feel
- Always apply `filter="url(#rough)"`

### Casual Rotation

Cards should look placed by hand, not machine-aligned:

```xml
transform="rotate(-0.3 265 203)"
```

- **Values**: `-0.4` to `+0.4` degrees. Alternate sign between adjacent cards.
- **Exception**: Skip rotation for linear pipelines (horizontal card sequences) and comparison matrices where perfect alignment aids readability.
- The `(cx cy)` is the card center — calculate as `(x + width/2)` and `(y + height/2)`.

### Internal Structure

Every card follows this pattern from top to bottom. Vertical spacing between elements: 22-26px.

1. **Pill badge** (optional) — `rx="6"`, white text on filled background, 13px Caveat 700
2. **Card title** — 22px Caveat 700, `text-anchor="middle"`, centered on card
3. **Section label** — 16-18px bold
4. **Body lines** — 14-16px, 2-4 lines max per card, 22px between lines
5. **Dashed separator** — `stroke-dasharray="4 3"`, opacity 0.4, match the card stroke color
6. **Artifact / note** — 14px italic, 20px below separator

### VS Divider Pattern

For side-by-side comparison SVGs (like `good-vs-bad-answers.svg`), use a vertical dashed line with a circle "vs" marker:

```xml
<line x1="500" y1="100" x2="500" y2="600" stroke="#888" stroke-width="2" stroke-dasharray="6 4"/>
<circle cx="500" cy="335" r="22" fill="#fff" stroke="#888" stroke-width="2"/>
<text x="500" y="342" text-anchor="middle" font-family="..." font-size="18" fill="#888">vs</text>
```

---

## Arrows & Connectors

### Hand-drawn arrows

```xml
<g filter="url(#rough-arrow)">
  <line x1="210" y1="200" x2="260" y2="200" stroke="#777" stroke-width="2.5"/>
  <polygon points="258,192 272,200 258,208" fill="#777"/>
</g>
```

- Arrow color: `#777` (muted, never `#000`)
- Arrow label: 18px Caveat 700, `#777`, placed above the arrow shaft
- For vertical arrows, adjust polygon points

### Dashed connectors

```xml
<line x1="..." y1="..." x2="..." y2="..." stroke="#888" stroke-width="2" stroke-dasharray="5 4"/>
```

Use for:
- Ground lines (e.g., "the ground" in shed-house-skyscraper)
- VS dividers in comparison diagrams
- Zone/quadrant boundaries

---

## SVG Viewport

### Standard sizes

| Type | Width | Height |
|------|-------|--------|
| Pipeline / flowchart (horizontal) | 1100 | 340 |
| 4-quadrant matrix | 920 | 620 |
| 4-zone diagram | 1000 | 620 |
| Comparison (side-by-side) | 1000 | 640 |
| Conceptual (single concept) | 960 | 520 |
| Scoreboard / checklist | 900 | 500 |

### Accessibility

Every SVG MUST have:

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 960 520" role="img" aria-labelledby="diagram-title">
  <title id="diagram-title">Descriptive title of what this diagram shows</title>
  ...
</svg>
```

For comparison or data-heavy SVGs, add a `<desc>` for screen readers:

```xml
<desc>Left side shows a polite hypothetical answer (marked Bad in red). Right side shows a specific past-behavior answer (marked Good in green). Same interviewee, same problem, opposite signal — the question wording decides which answer you get.</desc>
```

---

## Anti-patterns (DO NOT)

| Don't | Why | Do instead |
|-------|-----|------------|
| `#ffffff` background | Sterile, looks like a screenshot | `#fafaf7` (warm paper) |
| No rough filter | Looks machine-generated | Always apply `filter="url(#rough)"` |
| Mixing Caveat + Segoe UI in one SVG | Jarring inconsistency | Pick one font family per SVG |
| Pure black text (`#000`) | Too harsh on warm paper | `#1a1a1a` (off-black) |
| Perfectly aligned cards in conceptual diagrams | Looks like a spreadsheet | Rotate ±0.3° (except pipelines/matrices) |
| More than 6 cards/sections | Overwhelms the reader | Split into two SVGs |
| More than 4 lines of text per card | Walls of text kill scannability | Move detail to the chapter body |
| SVG without `<title>` | Inaccessible | Always include `role="img"` and `aria-labelledby` |
| `text-anchor="start"` without left-padding | Text touches card edge | Center (`middle`) or pad with `x="card-x + 20"` |

---

## Migration Guide (existing SVGs)

### Priority 1 — font mismatch

These SVGs use Segoe UI but the conceptual content calls for Caveat:

| SVG | Current | Fix |
|-----|---------|-----|
| `ownership-zones.svg` | Segoe UI | Swap to Caveat/Patrick Hand |
| `shed-house-skyscraper.svg` | Segoe UI | Swap to Caveat/Patrick Hand |
| `decision-matrix.svg` | Segoe UI | **Keep as-is.** Dense matrix with 20+ text elements — system font is correct. |
| `good-vs-bad-answers.svg` | Patrick Hand | ✅ Already correct |
| `module-pipeline.svg` | Caveat | ✅ Already correct |
| `network-buckets.svg` | Caveat | ✅ Already correct |

### Priority 2 — missing rough filter

| SVG | Status |
|-----|--------|
| `ownership-zones.svg` | No rough filter — add one |
| `network-buckets.svg` | No rough filter — add one |
| `good-vs-bad-answers.svg` | No rough filter — add one |
| All others | Have rough filter ✅ |

### Priority 3 — missing accessibility

Most course SVGs lack `role="img"`, `aria-labelledby`, and `<title>`. Add during next edit pass. Priority SVGs: `module-pipeline.svg`, `decision-matrix.svg`, `good-vs-bad-answers.svg` (these appear in the most-trafficked chapters).

### Priority 4 — background inconsistency

`good-vs-bad-answers.svg` uses `#fafafa` instead of `#fafaf7`. Swap to match the rest.

---

## Quick Checklist (before shipping an SVG)

- [ ] `#fafaf7` background (never `#ffffff`)
- [ ] `<filter id="rough">` + `<filter id="rough-arrow">` in `<defs>`
- [ ] Rough filter applied to all shapes (not text)
- [ ] `stroke-linejoin: round` on all card stroke classes
- [ ] Font stack matches content type (handwritten for concepts, system for dense matrices)
- [ ] Cards rotated ±0.2° to 0.4° (alternating) — **unless** it's a pipeline or matrix
- [ ] Card fills from the core palette first, extended palette only when needed
- [ ] Text uses `#1a1a1a` (never `#000`, never `#ffffff` for body)
- [ ] Arrows use `#777` with `filter="url(#rough-arrow)"` and poly arrowheads
- [ ] Dashed separators use `stroke-dasharray="4 3"` at opacity 0.4
- [ ] Text spacing: 22px between body lines, 26px heading→body, 20px separator→note
- [ ] No more than 6 cards/rects, no more than 4 lines per card
- [ ] `<title>` with descriptive text + `role="img" aria-labelledby`
- [ ] Viewport matches one of the standard sizes
- [ ] One font family per SVG — never mix Caveat and Segoe UI
