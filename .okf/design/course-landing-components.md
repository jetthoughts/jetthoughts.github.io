---
type: Design System
title: Course-landing component rules
description: One loud element per viewport, max 3 dark zones, soft-card dialect - and the post-hero slot is for the argument, not a router menu.
resource: docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/course-landing-components-2026-08.md
tags: [css, design, course, landing]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-13T00:00:00Z
verified:
  - by: human:pftg
    at: 2026-08-13T00:00:00Z
---

# Composition rules

| Rule | Detail |
|---|---|
| One loud element per viewport | The ruby CTA. Everything else grayscale + obsidian islands. |
| Dark appears exactly 3x | Hero card, mistake-grid CTA cell, endcap. Dark-as-island, never dark-as-theme. |
| One dialect: soft card islands | `background:#f8f8fa` / `border:1px solid #e5e7eb` / `radius:12px` / `padding:20px 22px` - shared by `.mistake-list > li`, `.scope-card`, `.module-card`. |
| Links inside components | Body-text `#1f2937`, ruby on hover only (`item16 T6`). Rows of default-blue links read as a wall. |
| Type scale | 12 uppercase eyebrows -> 24 card titles -> 36-44 section H2s -> 48-72 hero. Nothing between. |

CSS lives in `themes/beaver/assets/css/pages/course-list.css` (landing-only
bundle). The `.course-landing .post-content` 3-track grid gives prose a 720px
measure and lets component grids span the full 1080px middle track.

# The post-hero slot is for the argument, not a router

Ruled 2026-08-13 after a 3-row "Where to start" router table (`.start-router`,
`<dl>`: *Ready to start* / *Prefer a map first* / *Already building*) shipped
there and was rejected on sight. A four-critic panel (ICP-reader, CRO,
visual-design, IA) plus a Codex refutation pass converged:

* **The hero owns the start CTA.** Restating `Start Lesson 1.1` ~250px below the
  hero button, *as one of three options*, converts an unconditional instruction
  into a conditional one. It demotes, it does not reinforce.
* **Labels that ask the reader to self-classify fail.** "Ready to start" - by
  what standard? The reader cannot answer before the page has earned anything.
* **Count the exits.** Three rows carried six links, offered *before* the "Why
  this course exists" argument. Hick's Law; the mistake grid got pushed a fold
  down on mobile.
* **Hairline rows + a fixed label column = spec-sheet semantics.** The only
  ruled table on a soft-card page reads as reference data, so it gets skipped.
* **Equal weight for a minority branch is the tell.** At 390px the
  already-building row rendered taller than the primary path.

The surviving shape is one asymmetric callout, `.start-note`: bold lead-in +
one link + a ruby left rule, ~79px desktop / 130px mobile, carrying only the
route the hero does *not* cover (already building or paying a shop -> the
Lesson 4.2 ownership audit). Wayfinding links (How This Course Works, FAQ)
moved to the module-map intro, where the reader is actually choosing a route.

**Generalization:** before adding a navigational component to a landing page,
count how many times each destination is already reachable. On this page only
2 of 6 router links were unique - the rest duplicated the hero, the
mistake-grid CTA, or a module card.

# Citations

* [Component library + the shuffle2 reference](../../docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/course-landing-components-2026-08.md)
* [Visual scroll gate](../workflows/visual-scroll-gate.md)
* [ICP profile](../content-strategy/icp-primary-website-target.md)
