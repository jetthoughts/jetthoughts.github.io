---
type: Design System
title: House in-post visual spec
description: Hand-drawn SVG house style - paper tones, 2-2.5px strokes, semantic colors (green = money only), labels inside shapes.
resource: .stitch/prompts/course-inpost-visual-prompt.md
tags: [svg, design, course]
timestamp: 2026-07-13T00:00:00Z
---

# The spec in one table

| Element | Rule |
|---|---|
| Backgrounds | Paper tones: #fff5f5 (red-tint), #faf7f2 (cream), #f0f9f0 (green), #fbe9ff (purple) |
| Strokes | 2-2.5px, hand-drawn feel |
| Red | Action / anti-pattern |
| Purple | Alternate path |
| Green | ONLY money/success outcomes |
| Amber | Warnings |
| Typography | Caveat / Patrick Hand / Comic Sans MS cursive stack |
| Labels | INSIDE shapes (Sweller split-attention rule); never bare diamonds |
| Dashes | "-" only, including inside artwork |

# Exemplars

`invoice-loop.svg` (ai-token-bill) and `network-buckets.svg` are the
canonical compact hand-drawn exemplars - numbered step cards, outcome cards,
dashed loop, header + italic subtitle, ~960x470.

Diagrams taller than 2x viewport read as a wall, not a hook - replace with a
compact SVG or table. Verify every new visual with the
[render-verification playbook](/workflows/render-verification.md).
