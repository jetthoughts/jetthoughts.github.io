---
type: Design System
title: Mermaid house theme and the Caveat webfont fix
description: Mermaid renders in Caveat handwritten cursive, loaded explicitly and awaited via document.fonts.ready; label metrics gotchas documented.
resource: themes/beaver/layouts/baseof.html
tags: [mermaid, fonts, design]
generated:
  by: claude/fable-5
  at: 2026-08-17T16:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-13T10:00:00Z
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

# Flake prevention, three layers (2026-08-17)

The `mermaid_post` screenshot flake family is closed from three sides:

1. **Page (root cause):** `document.fonts.ready` alone resolves when the
   fonts *requested so far* settle - the hidden `.mermaid` source may never
   request Caveat, so mermaid measured with the fallback and the late Caveat
   repaint shifted every glyph. `baseof.html` now `Promise.all`s explicit
   `document.fonts.load("20px Caveat")` (+ Patrick Hand) with `fonts.ready`
   before `mermaid.run()`.
2. **Test:** `blog_special_content_test.rb` waits for
   `div.mermaid[data-processed] svg` AND asserts
   `document.fonts.check("20px Caveat")` before capturing - the screenshot
   can only be taken in the same state the baseline was recorded in.
3. **Authoring-time pre-render (opt-in per page):** `bin/render-mermaid
   content/blog/<slug>` renders each fence to `mermaid-<hash8>.svg` in the
   page bundle via `bunx @mermaid-js/mermaid-cli` (theme config duplicated
   in the script - keep in sync with `baseof.html`; Caveat injected as a
   data-URI so mmdc MEASURES with the real font). The render hook embeds the
   SVG when present (`data-prerendered`), ships no mermaid.js for that page,
   and falls back to runtime mermaid otherwise. hash8 = md5 of the
   whitespace-trimmed fence body on BOTH sides. CI never runs the tool -
   SVGs are committed like any exhibit.

**Diagnosing a red `mermaid_post` check:** identical `difference_level`
across runs = stale baseline (a content/CSS change upstream), NOT flake -
download the CI run's `screenshots-report-full` artifact, eyeball the
heatmap, and commit the CI-rendered capture as the linux baseline. Never
re-record linux baselines from local emulated Docker.

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

# The unrendered-source flash (fixed 2026-08-13)

`<div class="mermaid">` renders its own SOURCE as article prose until
mermaid.js swaps in the SVG - and because `baseof.html` defers `mermaid.run()`
until `document.fonts.ready`, that window is as long as the Caveat load takes.
If the font never resolves, the wall of `flowchart TD ... classDef dead
fill:#fff5f5,...` never goes away.

Reported by the owner as "images have `&nbsp;` on it" - the `&nbsp;` we append
to labels is emitted by Hugo as `&amp;nbsp;`, so it sits in that raw text as a
literal entity. The entity itself is FINE once rendered: htmlLabels is on, so
mermaid decodes it to a trailing space. The bug was only ever the flash.

Fix is one rule in `themes/beaver/assets/css/single-post.css` - mermaid stamps
`data-processed` on each node it renders:

```css
.mermaid:not([data-processed]) { display: none; }
```

Trade-off accepted: if JS fails outright the diagram is absent rather than
showing its source. Absent beats a wall of code in the middle of a paragraph.
This was site-wide and pre-existing - it shipped with the first mermaid post in
May 2026 and went unreported for three months because it only bites on a slow
font load.

# Mobile legibility: width comes from COLUMNS, not label length

Mermaid wraps node labels at ~200px, so a long label never widens a diagram -
the number of PARALLEL COLUMNS does. Three sibling nodes feeding one gate
renders ~800px wide. Because the SVG scales to the content column, wide means
small: `renderedPx = minFontSize * (displayedWidth / viewBoxWidth)`. At a
390px viewport a 797px-wide diagram renders 8.88px text, under the 9px floor
`bin/check-svg-floor` enforces for course SVGs.

Measured 2026-08-13 while backfilling diagrams into the August blog cluster:

| Shape | viewBox | rendered @390px |
|---|---|---|
| 3 siblings -> 1 gate (fan-in) | 797px | 8.88px - FAILS |
| 2 columns (chain + branch) | 545px | 13.0px |
| single vertical column | 272px | 20px (unscaled) |

Fix by chaining vertically (`A --> B --> C`, or `~~~` for unconnected nodes),
not by shrinking labels. Note the trade: a pure single column renders at full
size on mobile but sits as a narrow ribbon in the 684px desktop content
column. Two columns is usually the balance point.

# Brand rule

Handwritten typography in diagrams is a non-negotiable brand identity -
the owner rejected a clean-sans mermaid theme on sight the same day he had
approved it in the abstract. Fix legibility structurally (compact SVG,
table) rather than by changing the font. See the
[house visual spec](/design/house-visual-spec.md).
