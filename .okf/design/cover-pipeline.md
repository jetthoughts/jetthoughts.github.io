---
type: Playbook
title: Course cover rebuild pipeline
description: Covers are rebuilt as full HTML per .stitch/design.md rendered headless at 2400x1260; chip-composite for single-fact edits.
resource: .stitch/design.md
tags: [covers, design, stitch]
timestamp: 2026-07-13T00:00:00Z
---

Original covers were Stitch-made and their downloads are auth-gated, so the
working rebuild path is: author a full HTML page implementing the spec and
screenshot it headless at 2400x1260.

# Spec essentials (.stitch/design.md)

- Titles: Space Grotesk 800, letter-spacing -0.03em
- Chip labels: Inter 600, 22px, letter-spacing 0.14em
- Chip values: Space Grotesk 700
- Status line: JetBrains Mono
- Palette: JetVelocity - obsidian dark, Ruby red #cc342d, neon purple #a855f7

# Techniques

- Full rebuild: HTML file in scratchpad → headless Chrome screenshot →
  `cover.png` (update the `cover_image_alt` frontmatter to match).
- Single-fact edit (one chip's wording): chip-composite - render just the
  corrected chip and composite it over the existing PNG with magick.
- Watch sub-glyph grazes on chips ("%", trailing "E"); fix with explicit
  `<br/>` splits and `&nbsp;` slack, verify with zoomed re-renders.
