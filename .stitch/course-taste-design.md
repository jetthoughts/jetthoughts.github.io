# Design System: From Idea to First Paying Customer (course pages)

Stitch-compatible DESIGN.md for the 2026 course. Single source of truth for
taste-scoring course pages and for generating Stitch concepts of in-post
visuals. Where this conflicts with generic design advice, THIS file wins -
the handwritten identity is owner-mandated brand (sans artwork was rejected
on sight 2026-07-12).

## 1. Visual Theme & Atmosphere

A founder's annotated field notebook: warm paper surfaces, hand-drawn
diagrams with confident 2-2.5px strokes, dark editorial covers that snap
against the cream page. Density "Daily App Balanced" (5) - every H2's worth
of prose earns one visual break. Variance "Offset Asymmetric" (5) - diagrams
are horizontal strips and card rows, never symmetric 3-up grids. Motion
"Static Restrained" (2) - the page holds still; the hand-drawn line carries
the energy.

## 2. Color Palette & Roles

- **Paper Cream** (#faf7f2) - default diagram card fill
- **Blush Paper** (#fff5f5) - red-tinted fill for action/anti-pattern cards
- **Mint Paper** (#f0f9f0) - green-tinted fill, money/success outcomes ONLY
- **Lilac Paper** (#fbe9ff) - purple-tinted fill for alternate paths
- **Ruby Ink** (#cc342d) - action, anti-pattern, "stop" accents; brand red
- **Forest Ink** (#2e7d32) - money and success outcomes ONLY, never decoration
- **Violet Ink** (#a855f7) - alternate path, optional branch
- **Amber Ink** (#d97706 on #fffbeb) - warnings and conditional states
- **Notebook Black** (#1a1a1a) - primary artwork text; never #000000
- **Pencil Gray** (#555/#666) - captions, subtitles, annotations

Covers only (JetVelocity): obsidian dark ground, Ruby red #cc342d, neon
purple #a855f7 - the dark cover is the one deliberate contrast slam per page.

## 3. Typography Rules

- **Artwork (SVG/mermaid):** `"Caveat", "Patrick Hand", "Comic Sans MS", cursive`
  - the full stack is MANDATORY (SVG-as-img cannot load webfonts; Comic Sans
  MS is the only handwritten face reliably installed - omitting it re-enters
  the platform font lottery).
- **Covers:** Space Grotesk 800 titles (-0.03em), Inter 600 chip labels
  (22px / 0.14em), Space Grotesk 700 chip values, JetBrains Mono status.
- **Body prose:** theme sans at 20px/1.65 (course scope), li margin 12px,
  callouts 19px/1.6.
- **Depicted UI/code inside artwork:** sans/mono is CORRECT when the artwork
  imitates a real screen, email, or terminal - the handwritten voice is for
  the diagram's own labels, headers, and annotations.
- **Dashes:** "-" everywhere, including inside artwork. "—" is banned.

## 4. Component Stylings

* **Diagram cards:** paper fill, 2-2.5px Notebook Black or semantic-ink
  border, 12-14px radius, label INSIDE the shape (Sweller split-attention).
* **Step strips:** numbered pill chips (Ruby fill, white numeral) + arrows,
  header + italic Pencil Gray subtitle - exemplar `invoice-loop.svg`.
* **Callouts:** red-left-border aside is the default; `bq-good` (green) /
  `bq-bad` (red) variants for good/bad exemplars; `bq-tldr` for TL;DR. Never
  two same-form callouts adjacent.
* **Tables:** decision aids and comparisons; 6+ visually identical rows need
  per-row differentiation (color-coded labels, icons, or grouped sub-tables).
* **Worksheet cards (`ws-*`):** cream card, checkbox squares, dashed verdict
  strip, green go-route / purple alt-route.

## 5. Layout Principles

- Diagrams are compact horizontal strips (~960x300-560); anything taller
  than 2x viewport reads as a wall and must become a strip or table.
- First fold (1280x800) always carries a visual hook - dark cover or
  handwritten strip. Pure-text heroes are a defect.
- One visual break per H2 run; 3+ H2s of plain prose is a rhythm defect.
- No overlap: labels never cross borders; artwork text never grazes edges
  (verify by render - Caveat metrics differ from sans).

## 6. Motion & Interaction

None inside the course pages. Mermaid renders after `document.fonts.ready`
(never remove - it kills the measure/render font mismatch class of bugs).

## 7. Anti-Patterns (Banned)

- Sans-serif diagram labels/headers (except depicted-UI mimicry, §3)
- Green used for anything but money/success; conditional states in green
- Bare diamond decision nodes; mermaid edge labels over 2 words
- Font stacks missing the Comic Sans MS fallback
- Em-dashes anywhere; year-stamped "LABEL // 2026" typography
- Fabricated metrics in artwork (numbers must come from the page's canon)
- Decorative visuals that add no information (delete instead)
- Corporate-slide look: symmetric 3-equal-card rows, glossy gradients,
  neon glows, stock photography, generic icon arrays
- "Scroll to explore" filler, emoji in artwork, pure #000000
- Repeating one callout form 3+ times in a row on a page
