# Architecture Decision Record: A single site design system ("Rescue Room")

**ADR-0003**
**Date:** 2026-08-20
**Status:** Proposed

## Title

Adopt one token-first design system for jetthoughts.com, rolled out by the
strangler pattern already used for the FL burn-down.

## Context

### The site has no site design system

`.stitch/design.md` is a rigorous, enforced design system — for **blog cover
images**. Obsidian dark, Space Grotesk, ruby→purple. The site chrome is light,
geometric and red. Cover art and site have never shared a language, and neither
governs the pages between them.

The result is roughly four visual languages stacked page by page. Measured
2026-08-20 against the live site and the CSS source:

| Finding | Value | Source |
|---|---|---|
| `var(--color-primary)` references | 161 | `grep -rn 'var(--color-primary' themes layouts` |
| — of which paint visibly | ~140 | 75 `color:`, 34 `background-color:`, 18 `border-color:`, 13 `background:` |
| `#1a8cff` literals | 52 | `grep -rni '1a8cff' themes layouts` |
| Homepage rendered height | 10,394px | Chrome, 1440×900 |
| Background switches on the homepage | 6 | rendered |
| Primary-styled CTAs on the homepage | 6 | rendered |
| Spacing tokens defined | 2 | `foundations/css-variables.css` |
| Screenshot baselines | 143 macOS / 135 Linux | `test/fixtures/screenshots/` |

`--color-primary: #1a8cff` is the root cause of the incoherence. It is *named*
primary but appears in no brand definition — `.stitch/design.md` names ruby
`#cc342d` and neon purple `#a855f7`, never blue. Its own definition comment
records that 279 literal occurrences existed before the token did; it was
codified to describe shipped rendering, not to express a design intent. It is
why the homepage carries blue divider bands, why blog tags are blue, and why
links are blue on a red-branded site.

Two spacing tokens (`--spacing-sm`, `--spacing-md`) means every section invented
its own padding, which is why the section rhythm reads as bolted-together
templates rather than one page.

### Why now

The FL burn-down completed 2026-07-17 (16 → 0 generated layout files, PR #365).
Every style on the site is now hand-editable and single-source, and the
ownership map answers "which pages does this file affect?" in under a minute.
This work was not possible before that; it is cheap now.

### Two pages already solved this — and they disagree on one thing

The two newest pages on the site both arrived at the same system independently,
without being told to:

| | `/course/tech-for-non-technical-founders-2026/` | `/services/vibe-code-rescue/` |
|---|---|---|
| Page background | **light** (blush hero, white body) | **dark** (obsidian gradient) |
| Accent | ruby only | ruby **+ neon purple** gradient |
| Proof in fold 1 | chip row | chip row, canon figures |
| CTAs | one primary + one secondary | one action, repeated 3× |
| Imagery | dark artifact card | none — text and cards only |
| Page height | — | **4,347px** |
| `--color-primary` | not used | not used |

They agree on everything that matters structurally: proof in the first fold from
`claims-canon.md`, one repeated call to action rather than six competing ones,
artifacts or nothing instead of stock photography, a self-diagnosis section that
lets the reader place themselves ("Is this you?" / the module path), a page
around 4,300px, and no blue anywhere.

`pages/vibe-code-rescue.css` is 460 lines, fully token-driven
(`--color-obsidian`, `--color-on-dark`, `--color-ruby`, `--color-neon-purple`),
born semantic with no FL modules — the cleanest stylesheet in the repo. The
obsidian tokens in `foundations/css-variables.css` were extracted *from* it on
2026-07-26. It also carries an `!important` workaround at lines 58–71 to beat
"a late-cascade generic anchor color (#0066d6) that ships after page slices" —
independent evidence for the blue deletion below.

**So this ADR is not proposing a new language.** The system exists, is shipped
twice, and is already tokenised. What is missing is that the other seventeen
bundles never got it. That makes this **extraction and propagation**, not a
redesign — logo, ruby, display face and the cover system all unchanged.

### The one open decision: light or dark

The two reference pages differ on page background, and this ADR does **not**
settle it. Both readings are defensible:

- **Light** — the course page is written for the ICP most explicitly (a
  non-technical founder), and light chrome reads calmer and less "for
  developers" to an anxious buyer.
- **Dark** — `/services/vibe-code-rescue/` is the landing page for the live
  Validating bet, it is the strongest page on the site, and dark unifies site
  chrome with the blog cover system for the first time.

Everything else in this ADR is palette-independent: the scales, the section
rhythm, the proof placement, the CTA hierarchy and the blue deletion all hold
either way. **Paul decides the palette; the rest ships regardless.** The
prototype currently shows the light reading, and a dark variant is a token swap
against the same components, not a second design.

## Decision

Adopt one design system for site chrome, defined as tokens in
`foundations/css-variables.css` (already loaded inline site-wide via the
`navigation` bundle) and shared components in `components.css`.

1. **One accent.** Ruby `#cc342d` is the only accent. `--color-primary` is
   deleted. Neon purple is the **secondary** accent, used sparingly as a
   gradient partner to ruby and for small marks — the role it already plays on
   `/services/vibe-code-rescue/` and in the cover system. It is never a
   standalone brand colour.
2. **One neutral ramp, warm.** `ink-900/700/500/300` + `line`, replacing cool
   `#121212` / `#969798`.
3. **Three light surfaces plus one dark.** Sections alternate between two light
   surfaces; **exactly one dark band per page**, spent on the strongest proof.
4. **A real scale.** Six type steps with fluid clamps and a 68ch measure; a 4px
   space scale; two elevations; four radii.
5. **Artifacts, never stock photography.** The hero mockup and the
   service-page photograph of a stranger are replaced by the weekly report.
6. **Proof in fold one**, drawn from `.okf/content/claims-canon.md`.

### Rollout: strangler, sequenced by whether layout moves

Page bundles are converted one at a time, each in its own PR, exactly as the FL
files were retired.

Site-wide chrome is split in two, on the property that decides how a regression
is found and how it is undone:

- **Recolour** (tokens, blue deletion, footer surface, eyebrow, buttons) leaves
  every element in place. A regression here is a wrong colour, visible in a
  screenshot diff, and revertable on its own.
- **Spatial** (dead fold, nav 7→5, spacing scale) shifts every page vertically.
  A regression here is a layout fault, and it churns baselines wholesale.

This costs one extra baseline re-record versus batching them, and buys a
rollback point in between: reverting the spatial phase leaves the recolour
standing, which is a coherent state to sit in indefinitely. Since ADR-0004
establishes that no phase can be A/B tested at current traffic,
**reversibility is the substitute for statistical confidence** — which makes
the split worth its cost. The trade only works because the
`bin/record-baselines` wrapper is built first; without it, batching would win.

## Consequences

### Positive

- One answer to "what colour is this / how much space goes here", enforced by
  tokens rather than review.
- The blog cover system stops being the only coherent design artifact.
- Deleting `--color-primary` removes a token whose name actively misleads.
- Homepage drops from 10,394px to ~4,400px, with proof above the fold on mobile.

### Negative / accepted risk

- **278 baselines re-recorded twice** across the two chrome phases, on both
  platforms. This makes `bin/record-baselines` a hard prerequisite, not a
  nice-to-have.
- **The spatial phase has no partial rollback.** It lands or reverts whole;
  reverting leaves the recolour standing, which is a coherent state to sit in.
- **Deleting `--color-primary` is a 213-reference codemod.** `theme-main.css`
  already carries comments from a previous pass where consumers existed for an
  undefined token; the deletion must be measured on rendered output, not source.
- **Cutting homepage sections removes SEO surface.** The service tiles and
  framework grid carry keywords. See ADR-0004 and the plan's Gate 2.1 — GSC data
  is checked before anything is removed.

### Neutral

- Typeface unchanged. PostCSS pipeline unchanged. No transfer-size claims made
  (per the 2509 evidence rule, any size claim is compiled + gzip, never source
  line counts).

## Alternatives considered

**Extend the obsidian cover language site-wide.** Unifies site and covers, and
is highly differentiated against a field of white agency sites. Rejected: dark
chrome reads "built for developers", and the documented ICP is a non-technical
founder who has just been let down. The course page — the one page written
directly for that ICP — chose light.

**Foundations only, leave pages alone.** Cheaper and lower risk, but the tokens
would have no consumers, so nothing visibly improves and the system rots.

**Do nothing.** Defensible on cost. Rejected because every new page currently
starts by picking from four languages, so the incoherence compounds with each
page shipped.

## References

- `.stitch/design.md` — cover image system (unchanged by this ADR)
- `docs/projects/2509-css-migration/css-bundle-ownership-map.md` — bundle map
- `docs/projects/2509-css-migration/2026-07-12-css-maintainability-redesign.md`
- `.okf/content/claims-canon.md` — canonical figures used in proof rows
- `docs/projects/2608-site-design-system/` — the execution plan
- ADR-0004 — how changes are validated before and after they ship
