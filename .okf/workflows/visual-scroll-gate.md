---
type: Playbook
title: Visual Scroll Gate
description: Blocking pre-handback protocol requiring a full section-by-section visual walk of any new or edited content page at desktop and mobile viewports.
resource: docs/workflows/visual-scroll-gate.md
tags: [testing, visual-regression, chrome-devtools]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

Applies to any new/edited content page (course lesson, walkthrough,
companion/template page, blog post, landing page) and any change to a
visual asset (SVG, mermaid diagram, cover image). Must run BEFORE
declaring the page done, in the same session as the edit. Text
validators cannot see rendered output — this gate is the substitute for
human eyes.

On 2026-07-10 a single Module 3 pass caught: mermaid node text clipped
in every node, SVG text crossing an artwork's card border, a stale
"Curriculum 06/30" badge on a cover freshly wired as `og:image`, an
"above" image reference that actually rendered below, and a chapter
renumber leftover living inside SVG artwork (invisible to any
banned-string text ratchet).

# Protocol

1. `hugo server` + chrome-devtools MCP. Load the page at 1280×800.
2. Scroll section by section (every h2 anchor, every diagram/image/
   table/callout) and screenshot each view — actually look at each
   screenshot, "screenshot taken" is not the gate.
3. Repeat at 390×844 (minimum: numeric probes + screenshots of every
   diagram).
4. Run numeric probes: `bodyOverflowX`, mermaid SVG rendered heights,
   per-image `complete`/height.
5. Check console errors and network 404s. Dev-server-only artifacts are
   excusable if named explicitly; everything else blocks.

# Related content-quality gates

- **Cognitive load / F-pattern rules** for long-form posts (>800
  words): first-3-seconds visual hook, no 6+ identical bullets/table
  rows, decision-aid format (flowchart/table) for "if X then Y"
  sections, labels inside diagrams (not beside), one visual break per
  H2, no decorative visuals.
- **Visual verification gate** for any new media element: score
  against look/functional/scroll-earning/helpfulness; any NO/MIXED on
  the latter two = rollback or redesign before commit.

# Citations

[1] `docs/workflows/visual-scroll-gate.md`
[2] `docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.05-content-organization-patterns-2026.md`
