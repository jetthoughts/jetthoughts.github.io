# Master prompt — in-post course visuals (inline SVG + mermaid)

Reusable AI-design prompt for redesigning the diagrams that live INSIDE course
pages (not covers). Written 2026-07-12 after a design-critic triage of all ~70
in-post visuals. Covers get `.stitch/prompts/course-landing-hero-prompt.md`;
this file governs everything rendered in the reading column.

---

Redesign an informational diagram that sits inline in a long-form lesson for a
non-technical first-time founder ("Sam"). The diagram interrupts reading, so it
must pay for the interruption: a reader who looks ONLY at the diagram should
learn the section's core decision or structure in under 5 seconds.

CONTEXT CONSTRAINTS:
- Renders in a ~688px-wide reading column on WHITE page background (mobile:
  ~360px, may scroll horizontally inside its own container but must stay
  legible without zooming).
- It is content, not decoration: labels INSIDE shapes (Sweller split-attention
  rule); if a separate paragraph is needed to explain it, the diagram failed.
- One diagram = one idea. If it needs two ideas, make two diagrams or a table.

HOUSE FAMILY - "informational sketch, drawn by a confident hand":
- Paper-tone fills: #fff5f5 (warm) / #faf7f2 (cream) / #f0f9f0 (success tint)
  / #fbe9ff (purple tint) on white; NEVER dark backgrounds inline.
- Stroke grammar: uniform 2-2.5px strokes, rounded corners (rx 10-16), slight
  per-card rotation (max ±1.5°) allowed for the sketch feel - but ALL shapes in
  one diagram share the same stroke weight and corner language.
- Color = meaning, never mood: red #cc342d for the action/anti-pattern side,
  purple #a855f7 for the alternate branch, green #2e7d32 ONLY for
  pass/money/success, amber #b8860b sparingly for warnings, gray #666 for
  neutral structure. Two accent colors max per diagram plus green if there is
  a success state.
- Typography: Caveat / Patrick Hand for labels (>=15px effective at column
  width), plain sans-serif is acceptable for dense table-like cells; NEVER
  mix a third family; NEVER let a font fallback to system defaults (embed or
  restrict text to the declared stack + sans-serif tail).
- Hierarchy: exactly one visual entry point (title or biggest shape); reading
  order left-to-right or top-to-bottom, marked with arrows that touch the
  shapes they connect; annotations in gray italic BELOW or BESIDE, never
  across artwork.

MERMAID-SPECIFIC (when the diagram stays a mermaid block):
- Always include the house init: theme base, fontFamily 'Caveat, Patrick Hand,
  cursive', fontSize >=20px, primaryColor #fff5f5, primaryBorderColor #cc342d,
  lineColor #333, primaryTextColor #1a1a1a - PLUS 'padding': 12 so cursive
  glyphs never touch node borders.
- Rect nodes with the question/threshold INSIDE; never bare diamonds (they
  crush cursive text).
- Max ~6 nodes per direction; a sequential checklist of gates is NOT a
  flowchart - render it as a decision TABLE instead (proven pattern:
  engineering-org-chart, pivot-or-persevere).
- LR for <=6 short-label nodes in a row; TD for branching; never a staircase
  (LR+TD mixed) - it scales the whole render down to micro-text.

QUALITY GATES (reject if any fails):
- Screenshot at 688px column width: every label legible without zoom.
- No text within 12px of any border it doesn't belong to; nothing crosses
  another element's text.
- Squint test: the diagram's ONE idea survives blurring (hierarchy holds).
- Family test: put it beside network-buckets.svg and page-anatomy.svg - it
  must look drawn by the same hand.
- Information test: delete the diagram - if the section loses nothing, the
  diagram should not exist (fix by adding the missing info, not ornament).
