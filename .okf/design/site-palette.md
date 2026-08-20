---
type: Design System
title: Site chrome palette (light, "Rescue Room")
description: The resolved site-wide palette - light default, ruby accent, purple secondary - and the three surfaces where dark is still deliberate.
resource: themes/beaver/assets/css/foundations/css-variables.css
tags: [design, palette, css, tokens, adr]
generated:
  by: claude/opus-5
  at: 2026-08-20T00:00:00Z
timestamp: 2026-08-21T01:20:00Z
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

# Body links: ink text, ruby underline

Decided 2026-08-20 (2608 Phase 1a.3). Body content links are `--ink-900` text
with a `--color-ruby` underline (~2px, ~3px offset); hover deepens the text to
`--ruby-700` and the underline to full ruby.

**Not ruby text.** Ruby is the *action* colour. A post body full of ruby links
stops links being distinguishable from buttons — the accent loses its meaning
when everything wears it.

**The underline is the affordance, not decoration.** WCAG 1.4.1 requires body
links to be distinguishable by more than colour, so the underline was always
carrying that load. Once it does so explicitly, the text colour is free to stay
calm, which is what long-form reading wants.

**Do not "simplify" this back to a coloured link.** The colour it replaced,
`#0066d6`, was itself an accessibility fix: it displaced `--color-primary`
`#1a8cff` in Sprint #2 because the brand blue measured **3.37:1** and failed
AA (`#0066d6` is 4.78:1). Phase 1a.3 retires that rule for its late-cascade
specificity, NOT for its colour choice — any replacement must land at AA or
better. `--ink-900` on white clears it comfortably.

# Where dark is still deliberate

Light is the default, not a monopoly. Three surfaces keep dark **by design** —
anything else going dark is a defect:

1. **Blog cover art** — obsidian, unchanged. It reads precisely *because* it is
   the only dark thing on the page.
2. **One dark band per page**, spent on the single strongest proof.
3. **`/services/vibe-code-rescue/`** — a dark *variant* of these same tokens and
   components as a campaign landing page, not a second design system.

# Deprecations in progress

`--color-primary` (`#1a8cff`) **is gone as of 2026-08-21** — deleted in Phase
1a.2 along with the late-cascade `#0066d6` anchor rule in 1a.3, both shipped
in PR #518. The only surviving matches in `themes/beaver/assets/css/` are
seven COMMENTS recording what each rule replaced (`/* was
var(--color-primary) */`); a grep that counts them reads as if the token
survived. Grep for `var(--color-primary` with the opening paren and read the
hits before concluding a token is still live.

## The `--rr-*` aliases die next, in 1a.4 — verify by grep, never by list

Phase 1a.1 promoted the Rescue Room tokens into
`foundations/css-variables.css:110-116` as `--rr-*` aliases marked
DELETE-in-1a.4. They are consumed in three files as of 2026-08-21:
`pages/blog-list.css`, `single-post.css`, and `pages/blog-single.css`.

**Do not delete the alias block against a written inventory.** A spec's list
of consumers was wrong twice in one review (2026-08-21): it omitted a live
line and named a file carrying zero references. `single-post.css` is the one
that makes this dangerous — its `--rr-*` declarations set CTA and tag colour
and background, and that file is a member of the COURSE bundle too, so
deleting the aliases early breaks styling on blog AND course. Re-run
`grep -rn 'var(--rr-' themes/beaver/assets/css/` at the moment of deletion and
believe the output, not the doc.

**It is the logo's colour, and that is the point, not a reason to keep it.**
`themes/beaver/assets/img/icons/logo-dark.svg` contains exactly one hex value:
`#1a8cff`. The token was extracted from the brand mark. **A mark colour is not
a UI accent** — the logo identifies, the accent directs — and promoting it to
"primary" is what put blue bands, blue tags and blue links on a ruby site.

**The three logo files stay blue and are OUT OF SCOPE for every design-system
phase** (not deferred — out of scope). A blue mark with a ruby UI accent is an
ordinary, coherent pattern; changing the mark is a brand decision.

**Trap: SVG assets cannot read CSS custom properties.** ~29 theme and submenu
icons under `themes/beaver/assets/img/icons/theme/` and
`content/services/*/submenu-*.svg` carry hardcoded fills, so they are invisible
to token work — deleting a token does not touch them, and a site-wide recolour
must sweep them separately or they are left stranded on the old palette. Until then several page files carry scoped `!important` workarounds
against that rule — **retiring all of them is the phase's success signal**: if
they cannot all go, the replacement link colours are wrong, not the
workarounds.

# Citations

[1] `docs/adr/0003-site-design-system.md` — the decision and its alternatives
[2] `docs/projects/2608-site-design-system/20-29-strategy/20.02-phase-1a-plan.md`
[3] `.stitch/design.md` — the cover-image system (separate surface, stays dark)
