---
type: Design System
title: Site chrome palette (light, "Rescue Room")
description: The resolved site-wide palette - light default, ruby accent, purple secondary - and the three surfaces where dark is still deliberate.
resource: themes/beaver/assets/css/foundations/css-variables.css
tags: [design, palette, css, tokens, adr]
generated:
  by: claude/opus-5
  at: 2026-08-20T00:00:00Z
timestamp: 2026-08-20T00:00:00Z
---

# Resolved: LIGHT (ADR-0003, 2026-08-20)

Site chrome is light. Not a default anyone drifted into — decided on a
lightning demo of the peer set, and the reasoning is worth keeping because it
predicts future calls:

**The light/dark split is audience-shaped, not taste-shaped.** Dark marketing
belongs to products bought by *developers evaluating a tool*; light belongs to
services bought on *trust*. Every services peer reviewed ships light —
thoughtbot, Test Double (a Rails consultancy selling to technical buyers),
Basecamp (dark is a user preference, not the brand) — and the decisive signal
was **Linear**, the poster child for dark product aesthetics, shipping a
*light* marketing site. Light also holds a comprehension edge at **small font
sizes**, which is our case: our humans are on phones (28% of GSC clicks from
6% of impressions).

**Why the dark case lost, stated so it isn't re-litigated:**
`/services/vibe-code-rescue/` is the strongest page on the site and it is
obsidian — but its quality is **structural, not chromatic** (proof chips in
fold one, one repeated CTA, artifact cards instead of stock photography,
~4,300px). Every one of those is palette-independent and every one already
ships in the *light* blog.

# The palette

Defined in `foundations/css-variables.css`, which loads inline site-wide — see
[css-pipeline](/architecture/css-pipeline.md) for the token-layer mechanics and
the zero-delta promotion pattern.

| Role | Token | Value |
|---|---|---|
| Primary accent | `--color-ruby` | `#cc342d` (5.1:1 on white — AA both directions) |
| Accent pressed | `--ruby-700` | `#9e2620` |
| Accent tints | `--ruby-100` / `--ruby-050` | `#fbeae8` / `#fdf5f4` (hero blush) |
| Secondary accent | `--color-neon-purple` | `#a855f7` — gradient partner and small marks only, never a standalone brand colour or a section background |
| Ink ramp (warm) | `--ink-900/700/500/300` | `#14110f` / `#3d3733` / `#6b625c` / `#a49b94` |
| Hairlines | `--line` | `#e7e1d9` — the only border colour |
| Surfaces | `--surface{,-raised,-sunken}` | `#ffffff` / `#faf7f3` / `#f2ece4` |
| Dark surface | `--surface-ink`, `--color-obsidian*` | `#14110f`, JetVelocity obsidian family |

# Where dark is still deliberate

Light is the default, not a monopoly. Three surfaces keep dark **by design** —
anything else going dark is a defect:

1. **Blog cover art** — obsidian, unchanged. It reads precisely *because* it is
   the only dark thing on the page.
2. **One dark band per page**, spent on the single strongest proof.
3. **`/services/vibe-code-rescue/`** — a dark *variant* of these same tokens and
   components as a campaign landing page, not a second design system.

# Deprecations in progress

`--color-primary` (`#1a8cff`) is named "primary" and appears in no brand
definition; it and the late-cascade `#0066d6` anchor rule die in 2608 Phase
1a.2/1a.3. Until then several page files carry scoped `!important` workarounds
against that rule — **retiring all of them is the phase's success signal**: if
they cannot all go, the replacement link colours are wrong, not the
workarounds.

# Citations

[1] `docs/adr/0003-site-design-system.md` — the decision and its alternatives
[2] `docs/projects/2608-site-design-system/20-29-strategy/20.02-phase-1a-plan.md`
[3] `.stitch/design.md` — the cover-image system (separate surface, stays dark)
