---
type: Design System
title: Mermaid house theme and the Caveat webfont fix
description: Mermaid renders in Caveat handwritten cursive, loaded explicitly and awaited via document.fonts.ready; label metrics gotchas documented.
resource: themes/beaver/layouts/baseof.html
tags: [mermaid, fonts, design]
timestamp: 2026-07-13T00:00:00Z
---

# Root cause worth remembering

The Caveat webfont was historically NEVER loaded - mermaid fell back to the
platform's generic cursive (Apple Chancery on macOS) and measured labels
with different metrics than it rendered, causing a whole class of recurring
last-character clipping. The fix in `baseof.html`:

1. Google Fonts Caveat `<link>` (+ preconnects), gated on `features.mermaid`.
2. `startOnLoad: false` and `document.fonts.ready.then(() => mermaid.run())`.
3. Font stack `'Caveat', 'Patrick Hand', 'Comic Sans MS', cursive` - mirrors
   the in-post SVGs' fallback.

# Theming gotchas

- NEVER set font-size/padding on `.edgeLabel` via `themeCSS` - it applies
  AFTER measurement and reintroduces the measure/render mismatch.
- Labels ending in wide glyphs (%) clip; append `&nbsp;` inside the label or
  keep edge labels to 1-2 words.
- Bare diamond decision nodes are banned - use rects.
- Flowchart spacing: `nodeSpacing: 45, rankSpacing: 55, padding: 14`.
- Mermaid code fences render via
  `themes/beaver/layouts/_markup/render-codeblock-mermaid.html`, which sets
  `features.mermaid`.

# Brand rule

Handwritten typography in diagrams is a non-negotiable brand identity -
the owner rejected a clean-sans mermaid theme on sight the same day he had
approved it in the abstract. Fix legibility structurally (compact SVG,
table) rather than by changing the font. See the
[house visual spec](/design/house-visual-spec.md).
