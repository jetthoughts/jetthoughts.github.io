---
name: course-svg-draft
description: Draft a hand-drawn-style JT-brand SVG illustration for a course lesson. Use this skill whenever the user asks to create a course SVG, draw a diagram for a lesson, create an illustration, or mentions `/course-svg-draft`. Triggers on phrases like "create an SVG", "draw a diagram", "make an illustration for this lesson", "course SVG", "JT-brand illustration", or any request for a hand-drawn style diagram for the course.
---

# Course SVG Drafter

Draft a hand-drawn-style JT-brand SVG for a lesson. Mobile-readable at 375px, viewBox sized for 600px article column.

## Pre-loaded context

- **PRD**: `.agent/prd/PRD.md` — 5-module architecture, 15 quality gates. SVGs must serve the lesson's single concept per 30.03 §2.4 (dual coding + cognitive load).
- **30.03 §2.4**: `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.03-course-format-requirements-for-creators.md` §2.4 — visual discipline rules: 1 visual per lesson, no decorative graphics, mobile-legible at 375px.

### Canonical v2 SVG examples (study these first)
- `content/course/tech-for-non-technical-founders-2026/smoke-test-build-page/page-anatomy.svg` — the ONLY v2 pilot SVG. Block layout, label/desc pattern, hand-drawn rotation.
- `content/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/tracking-snippets.svg` — multi-column with arrows, event markers.

**DO NOT reference v1 lesson SVGs as style guides.** v1 SVGs (admin-panel-spaceship, shed-house-skyscraper, signals-scoreboard, etc.) were designed for long-form chapters and may have multi-concept infographics that violate the 1-visual-per-lesson rule. Use the pilot lesson SVGs as the canonical v2 pattern.

### JT brand palette
- **Ruby red** `#cc342d` — primary accent, borders, emphasis
- **Dark obsidian** `#1a1a1a` — text, headings
- **Pastel fills** — `#fff5f5` (warm pink), `#f0f9f0` (mint), `#e8f4f8` (sky), `#fffbe6` (warm yellow), `#fff8e0` (gold), `#fbe9ff` (lavender), `#f5e9ff` (purple tint)
- **Subtle gray** `#555` — secondary text, notes
- **White** `#fff` — CTA text on red

### Font stack
- **Headings/labels:** `"Caveat", "Patrick Hand", cursive` — font-size 22-30px, weight 700, color `#1a1a1a`
- **Body/descriptions:** `"Caveat", "Patrick Hand", cursive` — font-size 16-20px, color `#1a1a1a`
- **Notes/italic:** `"Caveat", "Patrick Hand", cursive` — font-size 14-17px, color `#555`, font-style italic
- **Mono/code:** `"JetBrains Mono", "Courier New", monospace` — only for code-like labels
- **CTA text on red:** font-family `"Caveat", "Patrick Hand", cursive`, color `#fff`, weight 700

### ViewBox and sizing
- **Default viewBox:** `0 0 600 400` (sized for 600px article column). Use wider if content needs it: `0 0 700 450` or `0 0 800 500`. Adjust height to content.
- **Font-size math for mobile:** at 375px viewport width, text must be ≥14px rendered. With viewBox width = 600, the ratio is 600/375 = 1.6x. Minimum viewBox font-sizes: 14×1.6 ≈ 22px for smallest text. Use: 20-22px for notes (14-15px rendered), 22-26px for labels (15-17px rendered), 26-30px for headings (17-19px rendered).
- **Target:** one concept per SVG. Never cram multiple concepts into one graphic.
- **Stroke width:** 2-2.5px for borders. 2px for arrow lines.

### Rotational "hand-drawn" effect
Apply subtle rotation to blocks (`transform="rotate(-0.3 X Y)"` or `rotate(0.2 X Y)`) to give a hand-drawn feel. Rotation should be subtle — between -0.5 and 0.5 degrees per block. Use slightly different rotation values on adjacent blocks.

### Existing SVG style references (pilot SVGs first — canonical v2 patterns)
Study these existing SVGs for style patterns:
- `content/course/tech-for-non-technical-founders-2026/smoke-test-build-page/page-anatomy.svg` — ✅ CANONICAL v2: block layout, label/desc pattern, hand-drawn rotation. Study this FIRST.
- `content/course/tech-for-non-technical-founders-2026/smoke-test-wire-tracking/tracking-snippets.svg` — ✅ CANONICAL v2: multi-column with arrows, event markers.
- Legacy reference (v1 — study for technique only, NOT as micro-lesson patterns):
  - `content/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/admin-panel-spaceship.svg` — comparison pair
  - `content/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/shed-house-skyscraper.svg` — progression diagram
  - `content/course/tech-for-non-technical-founders-2026/vibe-coding-ceiling-signals/signals-scoreboard.svg` — scoreboard/table

## SVG template

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 400" role="img" aria-labelledby="svg-title">
  <title id="svg-title">Alt text describing the content of the diagram</title>
  <defs>
    <style>
      .heading   { font-family: "Caveat", "Patrick Hand", cursive; font-size: 26px; fill: #1a1a1a; font-weight: 700; }
      .label     { font-family: "Caveat", "Patrick Hand", cursive; font-size: 22px; fill: #cc342d; font-weight: 700; }
      .desc      { font-family: "Caveat", "Patrick Hand", cursive; font-size: 18px; fill: #1a1a1a; }
      .note      { font-family: "Caveat", "Patrick Hand", cursive; font-size: 16px; fill: #555; font-style: italic; }
      .cta-text  { font-family: "Caveat", "Patrick Hand", cursive; font-size: 18px; fill: #fff; font-weight: 700; }
      .block     { fill: #fff5f5; stroke: #cc342d; stroke-width: 2.5; }
      .block-cta { fill: #cc342d; stroke: none; }
      .arrow     { stroke: #1a1a1a; stroke-width: 2; fill: none; stroke-dasharray: 6 4; }
      /* Add more block styles as needed with different pastel fills */
    </style>
    <marker id="arrowhead" viewBox="0 0 12 12" refX="10" refY="6" markerWidth="9" markerHeight="9" orient="auto">
      <path d="M0,0 L12,6 L0,12 z" fill="#1a1a1a"/>
    </marker>
  </defs>

  <!-- Title -->
  <text x="300" y="32" class="heading" text-anchor="middle">Diagram title</text>

  <!-- Content here... -->

</svg>
```

## Design rules

### Content rules
1. **One concept per SVG** — if the diagram has two separate ideas, it's two SVGs
2. **Title at top** — centered heading, y=32, font-size 28px
3. **3-7 blocks max** — more than 7 blocks overwhelms the visual channel per cognitive load theory
4. **No decorative elements** — every shape carries information. No stock icons, no abstract backgrounds

### Layout rules
1. **Left-to-right flow** for comparisons: bad on left (red/pink border), good on right (green/mint border)
2. **Top-to-bottom flow** for sequences: steps flowing downward
3. **Center layout** for single concepts
4. **Arrows between connected elements** — dashed lines with arrowheads, stroke-dasharray 6 4

### Color coding
| Element | Fill | Border |
|---|---|---|
| Default block | `#fff5f5` | `#cc342d` |
| Good/success | `#f0f9f0` | `#2e7d32` |
| Bad/failure | `#fff5f5` | `#cc342d` |
| Neutral/info | `#e8f4f8` | `#0277bd` |
| Warning | `#fffbe6` | `#bf8a00` |
| CTA button | `#cc342d` | none |
| Purple accent | `#f5e9ff` | `#7c3aed` |
| Lavender accent | `#fbe9ff` | `#a855f7` |

### Accessibility
1. **role="img"** on the SVG element
2. **aria-labelledby** pointing to the title element
3. **Title text** that describes the diagram content, not just "diagram" or "illustration"
4. **Alt text** — always provide alt text that describes the CONTENT of the SVG. Never write "decorative graphic" or "illustration." Bad alt: "A diagram showing the process." Good alt: "A hand-drawn comparison showing the simple three-button admin panel requested on the left and the 47-button spaceship control deck that was built on the right, connected by a red arrow labeled '10-week build, $15K'"

## Workflow

1. Understand the concept the SVG needs to communicate (from the lesson topic)
2. Read 2-3 existing SVGs from the course for style reference
3. Sketch the layout: blocks, arrows, labels
4. Write the SVG following the template above
5. Self-check:
   - [ ] ViewBox reasonable (600-900 wide, height proportional)
   - [ ] Font sizes ≥20px for smallest text
   - [ ] Colors match JT palette
   - [ ] One concept only
   - [ ] Title describes the content
   - [ ] Alt text describes the content (not "decorative graphic")
   - [ ] Subtle rotation on blocks for hand-drawn feel
   - [ ] No em dashes in text
6. Output the complete SVG file and save to `content/course/tech-for-non-technical-founders-2026/<slug>/<filename>.svg`
7. Provide the alt text separately for the lesson's markdown image reference
