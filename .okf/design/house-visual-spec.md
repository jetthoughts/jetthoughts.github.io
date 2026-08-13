---
type: Design System
title: House in-post visual spec
description: Hand-drawn SVG house style - paper tones, 2-2.5px strokes, semantic colors (green = money only), labels inside shapes.
resource: .stitch/prompts/course-inpost-visual-prompt.md
tags: [svg, design, course]
generated:
  by: process:okf-migrate
  at: 2026-08-01T00:00:00Z
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

# Known ceiling: dense worksheets on phones (Wave M4 verdict, 2026-07-30)

Fill-in worksheet SVGs at 960px render ~7px text on a 390px phone - legal
but illegible. Investigated the portrait-variant route (`<picture>` media
query in render-image.html + a second portrait SVG per worksheet): the
template side is ~10 lines, but every dense worksheet would need a second
hand-drawn variant kept in sync by hand - a single-source violation with
real drift risk, plus double visual-regression gates for the theme change.
CLOSED as not worth it: the phone answer for fill-in worksheets is the
print-ready PDF (Wave M3 ships a download link on every printable page;
print is the native format for pen-and-paper artifacts). Revisit only if
pilot recordings show phone readers pinch-zooming worksheets instead of
downloading.

# v3 exhibit spec

Source of authority: ADR 30.09 (premium-editorial pilot). This section is
the executable spec its Phase-A A/B pilot demanded - an SVG author renders
from it without guessing px, ratios, or weights. It ADDS to (does not
replace) the hand-drawn grammar above: O1 keeps that style, disciplined to
the numbers here; O2 is the flat-vector challenger. Everything below is
style-agnostic unless a row splits O1/O2. Dashes stay "-" everywhere,
green stays money-only, labels stay inside shapes.

## The governing constant: the >=9px @390px legibility floor

The current SVGs render at a 960-1000 viewBox and their smallest text lands
at ~5.5-7px on a 390px phone (ADR "Measured state"). That is the defect v3
fixes. The fix is a formula, not a wish.

An SVG scales to its container width, so rendered text size is:

    rendered_px = font_viewBox * (W_render / W_viewBox)

Reference render width is **W_render = 390** (a phone's CSS viewport; the
real content column after page padding is ~358px, so 390 carries ~9%
built-in headroom). Require the SMALLEST rung (basis) to clear 9px:

    rendered_px(basis) >= 9
    => basis_viewBox >= 9 * W_viewBox / 390 = 0.02308 * W_viewBox
    => equivalently  W_viewBox <= basis_viewBox * 43.33

**Canonical exhibit viewBox width = 720.** At 720 the floor is
0.02308 * 720 = 16.62px, so the basis rung is set to **17px**, which renders
17 * 390/720 = **9.21px** at 390 - above floor by design. Only the basis rung
(the smallest) needs the check; every larger rung clears it automatically.

If an exhibit needs a wider viewBox W, scale ALL five rungs by W/720 so the
floor still holds; never place text smaller than `ceil(9 * W/390)` px.
Widening the viewBox to fit more nodes is the trap that caused the 5.5px
defect - prefer fewer nodes at W=720 over more nodes at W=960.

**O1 Caveat correction (calibration knob):** Caveat's x-height is ~15%
smaller than Space Grotesk at the same point size, so O1 multiplies the
required floor by 1.15 - O1 basis rung = ceil(1.15 * 17) = **20px** (renders
10.8px, perceived ~9.4px). This is a real font-metric compensation, not slack.

## 1. Grid / column system

| Property | Value (viewBox units at W=720) |
|---|---|
| Canonical viewBox width | 720 |
| Columns | 12 |
| Outer safe margin (no critical content past it) | 24 all sides |
| Gutter | 12 |
| Column width | (720 - 48 - 11*12)/12 = 45 |
| Vertical rhythm baseline | 8 |

Nodes and axes snap to column edges; multi-column nodes span whole columns
plus the gutters between them (2 cols = 45+12+45 = 102). Vertical positions
snap to the 8px baseline.

## 2. Spacing scale

8px-based rung set (matches JetVelocity's 8px rhythm; 4 and 12 are the only
half-steps, reserved for tight in-node text padding):

    4  -  8  -  12  -  16  -  24  -  32  -  48  -  64

- 4/8: in-node text padding, gap between a label and its icon.
- 12/16: node internal padding, gap between a bar and its value label.
- 24/32: gap between sibling nodes, chart plot inset.
- 48/64: gap between exhibit regions (title block -> body -> basis line).

Every gap in an exhibit is one of these eight values. No off-rung spacing.

## 3. Connector spec

| Property | O2 flat-vector | O1 hand-drawn-normalized |
|---|---|---|
| Line weight | 2px uniform | 2-2.5px hand stroke |
| Routing | orthogonal (right-angle) | organic curve |
| Corner radius on turns | 4px | n/a (curve) |
| Arrowhead | filled triangle, 9 long x 7 base, same fill as line | open hand-drawn caret, ~10px |
| Attach point | node edge midpoint | node edge, loose |
| Turn clearance | >=16px straight off a node before the first turn | ~16px |
| Connector label | in a paper-tone pill centered ON the line, never crossing it | same |

Line color = ink (#121212 O2 / #1a1a1a O1) for neutral flow; ruby only when
the connector itself is the anti-pattern / action edge; purple for the
alternate path (carried from the hand-drawn semantics above).

## 4. Data-viz rules

- **Chart-vs-diagram trigger:** message is a quantity / comparison / trend
  -> chart. Message is a flow / relationship / sequence -> diagram. One
  message per exhibit decides which.
- **Fill vs stroke (hard rule):** DATA marks are FILLED, no stroke (bars,
  dots, bands, meter fill). STRUCTURE is STROKED, no fill (axes, gridlines,
  connectors, node outlines). Never both on one mark.
- **Bars:** filled semantic color; inter-bar gap = 0.5x bar width; category
  label below (label rung), value label above (annotation rung).
- **Dots/scatter:** 6px-radius filled dots, no stroke.
- **Gauge / meter / signal read:** horizontal track, bands filled by
  semantic tone, 2px pointer tick, threshold marked with a labeled tick
  (this is the `smoke-test-signal.svg` archetype).
- **Ruby-for-signal convention:** ruby marks the ONE actionable reading -
  the threshold to act on, the kill zone, the number the exhibit exists to
  show. Everything else stays ink or gray. If two things are ruby, the
  exhibit has two messages - split it.
- **Threshold vs band:** a threshold is a 2px dashed ink line perpendicular
  to the axis with a labeled tick. A band is a filled semantic-tone rect
  BEHIND the data, its label inside at the label rung.
- **Axis:** single baseline axis 2px ink; no gridlines unless precise values
  are read (then 1px #e5e5e5); no 3D, no chart junk. Plain-language chart
  title sits in the action-title slot (see grammar).

## 5. Aspect-ratio guidance

| Exhibit type | Ratio | viewBox at W=720 |
|---|---|---|
| Signal meter / single-axis chart | 12:5 | 720 x 300 |
| Flow / process diagram | 16:9 | 720 x 405 |
| Comparison (bars) | 3:2 | 720 x 480 |
| Relationship / node map | 3:2 | 720 x 480 |
| Program map / synthesis | up to 4:5 portrait | 720 x 900 max |

**Mobile-safe default = 3:2 (720 x 480)** - fills the phone column at ~1.3x
viewport height. Never exceed 4:5 portrait on a phone, and never breach the
hand-drawn spec's "taller than 2x viewport = wall, not hook" ceiling above.

## 6. Five-rung type scale

Sizes in viewBox units at the canonical W=720. Rendered column = value *
390/720 = value * 0.5417 (the >=9px floor check).

| Rung | Role in exhibit | O2 size / font | O1 size / font | Rendered @390 (O2) |
|---|---|---|---|---|
| 1 Title | action title (the takeaway sentence) | 34 / Space Grotesk 700 | 34 / Caveat 700 | 18.4px |
| 2 Message | the one point proved (subtitle) | 24 / Space Grotesk 600 | 24 / Caveat 700 | 13.0px |
| 3 Label | in-node / axis labels | 20 / Space Grotesk 600 | 22 / Caveat 700 | 10.8px |
| 4 Annotation | callouts, value labels | 18 / system-ui 400 | 22 / Caveat 700 | 9.75px |
| 5 Basis | source/scope line | 17 / system-ui 400 | 20 / Caveat 700 | 9.21px |

O2 uses Space Grotesk for title/message/label only; annotation and basis
(running text) stay system-ui per ADR ("Space Grotesk labels only, body
stays system-ui"). O1 keeps the full Caveat/Patrick Hand/Comic Sans stack at
the x-height-corrected sizes (rungs 3-5 bumped to satisfy the O1 floor).

## Exhibit grammar (every exhibit, both styles)

Zelazny doctrine, from ADR driver D2. Non-negotiable in either style:

1. **One action title** - a sentence stating the takeaway, not a label.
   "Under 3% conversion means kill the idea", never "Conversion signal".
2. **One message** - the single point the exhibit proves. If you need two,
   make two exhibits.
3. **One basis line** - the data's source and scope, bottom of the exhibit.
   "Basis: 7-day cold-traffic test, one channel."

## O1 vs O2 scoring rubric (for the T2 A/B pair)

Both variants MUST pass the grammar checklist and the measured >=9px @390px
floor - those are pass/fail gates, not scored preferences. The rows below
are where the two styles legitimately diverge, so T2 (and Paul's eye-test)
can score them on the same axes at equal zoom.

| Axis | O1 hand-drawn-normalized | O2 premium-editorial flat-vector |
|---|---|---|
| Heading/label font | Caveat / Patrick Hand / Comic Sans stack | Space Grotesk 600-700 |
| Running-text font | same cursive stack | system-ui |
| Stroke | 2-2.5px hand feel | 1.5-2px uniform |
| Corner radius | organic / none | 4px |
| Texture filter | rough filter allowed | none (clean) |
| Background | paper tones (#fff5f5 / #faf7f2 / #f0f9f0 / #fbe9ff) | paper white #ffffff on #faf7f2 page |
| Ink color | #1a1a1a | #121212 |
| Accents | ruby=action/anti-pattern, purple=alt, green=money, amber=warn | same semantics |
| Basis-rung floor | 20px (Caveat x-height corrected) | 17px |
| Brand-identity fit | preserves the "handwritten = non-negotiable" mermaid brand rule | deliberately re-tests it (ADR: weak prior) |
| Sam-trust read (ADR) | risked reading "amateur / unfinished" | risked reading "generic startup" if overdone |
| When it wins | authenticity/warmth valued over polish; cheapest (no restyle) | craft/consistency read as premium; consulting-grade synthesis |

## Verification against ADR 30.09

All six demanded components are present: (1) grid, (2) spacing scale,
(3) connector spec, (4) data-viz rules, (5) aspect-ratio, (6) 5-rung type
scale with the measured >=9px @390px floor formula - plus the exhibit
grammar and the O1/O2 rubric. Nothing in the ADR's Phase-A spec requirement
was left aspirational; the floor is a formula (basis 17px @ W=720 -> 9.21px)
and every dimension is a number an SVG author can render from.

## Refactoring.fm illustration style (2026-08-13, Paul - the new exhibit bar)

Paul's north star for course exhibits: the refactoring.fm (Luca Rossi) illustration
look (reference set: `docs/projects/2605-.../10-19-research/images/`). Redraw
exhibits to THIS, not the muted #faf7f2 O2 cards:
- **Clean white bg**, generous whitespace, minimal text, BIG labels.
- **Big bold hand-drawn Caveat labels** with a **soft colored drop-shadow glow**
  (SVG feDropShadow, the label's own colour, opacity ~0.5) so they pop.
- **Saturated semantic per-element colours** (NOT muted): blue #2b7fff structure,
  red #f2635a/#e5484d, green, amber, purple - each category its own colour.
- **Soft tinted rounded pills** behind labels (very light tint of the label colour,
  rx ~18) with a subtle grey drop-shadow for depth + a slight wobble rotation
  (~0.4-0.6deg) for the hand-drawn feel.
- **Bold blue connector arrows** (stroke ~3.5, blue arrowhead marker); purple
  dashed arrows for callout annotations.
- **NO emoji** (Paul 2026-08-13: "emojis look not so good, avoid them").
- **Wobble is layout-dependent (2026-08-13 correction):** the ~0.4-0.6deg wobble
  reads "hand-drawn/playful" in a **flow or vertical stack** - but in a **grid of
  aligned cards it reads as MISALIGNMENT, not craft.** Drop the wobble in grids;
  keep clean edges. (This exact rule caused the friday-demo-timeline clunkiness -
  see the render-gate checklist below.)
- Legibility unchanged: min font >=20px Caveat, W=720, ZERO overflow (render-check
  every one at 390 + desktop).
Template exhibit: `five-tech-words-stop-nodding-at/jargon-translator.svg`.

### Render-gate clunkiness checklist (2026-08-13 - itemize, don't vibe-check)

**Why this exists (decision record):** friday-demo-timeline was render-verified at
390, judged "legible + no overflow + on-style" -> stamped PASS -> handed back. Paul
then caught 3 clunky defects that were all VISIBLE in that same screenshot: grid
wobble reading as misalignment, a crowded odd-one-out STOP card, and hollow
badge-to-label gaps. **Root cause: a legibility/overflow gate is structurally BLIND
to composition.** Binary defect gates are necessary but NOT sufficient.

**The rule:** after the binary gate (legible / no overflow / on-style) passes, run
these 6 as an EXPLICIT ticked checklist - stance = "assume clunky, find 3 things to
fix" (assuming PASS is why the 3 were missed). A render is not PASS until all 6 are
ticked, not glanced:

1. **Alignment** - repeated elements on a clean grid, or does wobble/offset read jagged?
2. **Odd-one-out balance** - does the different cell (STOP, total row, hero) match its
   siblings' internal rhythm, or crowd/diverge?
3. **Whitespace / hollowness** - dead gaps inside boxes? content floating with no anchor?
4. **Sibling consistency** - do all repeated cards share ONE internal layout (badge, label pos)?
5. **Edge breathing room** - any text CROWDING the container edge (not overflow, just tight)?
6. **Weight / emphasis** - is the one thing that should dominate actually dominant?

**Backstop for batches:** a self-checklist still relies on the author's eye, which
rationalizes its own choices as intentional. Before a PR merge, run one INDEPENDENT
critic pass on the renders (impeccable `critique` or a fresh reviewer that didn't
draw them) - the only reliable catch for author-blind clunkiness (matches the
CLAUDE.md content cold-eyes gate). Per-exhibit: the 6-item checklist. Per-batch: the
critic pass.
