---
type: Playbook
title: Visual Scroll Gate
description: Blocking pre-handback protocol requiring a full section-by-section visual walk of any new or edited content page at desktop and mobile viewports.
resource: docs/workflows/visual-scroll-gate.md
tags: [testing, visual-regression, chrome-devtools]
timestamp: 2026-08-28T14:34:59Z
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-28T14:34:59Z
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
- **Cold-eyes pass on a NEW component** (2026-08-13): a tweak to an
  existing pattern may be self-reviewed; a pattern that did not exist on
  the page before needs one independent critic on the render before
  handback. The implementer cannot see two failure modes in their own
  work - the wrong anchor ("better than the thing I just replaced" when
  that was also bad) and solving the symptom (a legibility complaint that
  was really a purpose problem, where a prettier wrong element still
  fails). Cheapest form: render 2-3 variants and let the owner pick from
  screenshots. Worked example: [course-landing entry fork](../design/course-landing-components.md).

# The longest-unbroken-run metric can't be moved by splitting a paragraph (2026-08-28)

The cognitive-load metric measures the longest run of PROSE between any two
of `h2 img pre table ul ol`. A one-line paragraph is still prose, so splitting
a paragraph ADDS a paragraph to the run - it never breaks it. A reviewer
predicted splitting out a bolded closing sentence would drop the run from
~23 to ~12 mobile lines, then measured: unchanged at 720px/23 lines mobile,
609px/16 lines desktop, now five paragraphs instead of four. The prediction
was withdrawn after the measurement, not before.

**Only a non-prose element (callout, list, heading) moves the number.** That
means the metric can push a writer toward adding furniture purely to satisfy
a gate - which is the failure, not the fix. On the page this was measured on,
the right call was to accept the unmoved number: the isolated bold line
demonstrably works as a visual landing point in the render, and a second
callout would have diluted the first. When a proxy metric and the render
disagree, look at the render and say which one you are trusting and why.

**Companion measurement that DOES discriminate: rendered bold ink**, computed
as summed client-rect area per bold element, not a count of `<strong>` tags.
A 77-character bold carried 9.5x the ink of a 7-character one at the same
weight and colour - the "Christmas tree" rule
([voice guide](/content-strategy/voice-guide.md) §2) biting in a form that
counting bolds cannot detect: one-bold-per-paragraph was satisfied while the
page's loudest mark was a hedge. Measure area, and check whether two bolds
can co-occur in one viewport - they competed at 720px apart on an 844px
viewport; at 3,026px apart they cannot.

# Citations

[1] `docs/workflows/visual-scroll-gate.md`
[2] `docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.05-content-organization-patterns-2026.md`
