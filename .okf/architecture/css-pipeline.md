---
type: Service
title: CSS Build Pipeline (PostCSS + per-bundle PurgeCSS)
description: PostCSS pipeline that concatenates per-page CSS resource slices and purges unused rules per bundle before shipping.
resource: postcss.config.js
tags: [css, build, performance]
timestamp: 2026-08-21T03:20:07Z
verified:
  - { by: claude/opus-5, at: 2026-08-21T01:43:19Z }
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
sources:
  - resource: "/workflows/css-maintainability-plan.md"
    title: "css-maintainability-plan"
---

# Overview

Each Hugo template loads exactly ONE fingerprinted CSS bundle, built by
concatenating that template's resource slice (a list of source CSS
files declared in a `*-css-resources.html` partial) and running it
through PostCSS. PurgeCSS runs **per bundle**, reading `hugo_stats.json`
(see [hugo-site](/architecture/hugo-site.md)) to strip unused
selectors, so each page ships only the subset of CSS it actually uses.

This per-bundle purge is the reason source-file line counts predict
nothing about shipped bytes: consolidating shared source files can
*grow* shipped bytes (measured: a shared FL foundation added +7.1–9.8 KB
gzip first-visit per page). Any size/perf claim must be validated on
**compiled + gzip per-page payload**, never raw source line counts —
see [css-maintainability-plan](/workflows/css-maintainability-plan.md).

# Token layer: `foundations/css-variables.css`

The one file every page can rely on. It loads **inline site-wide** via the
`navigation` bundle, so a token defined here resolves in all 19 bundles —
which is precisely why promoting a colour into it is the unlock for any
site-wide recolour, and why a page-scoped `:root` block reaches only that
page's bundles.

Since 2608 Phase 1a.1 (2026-08-20) it holds the **light Rescue Room palette**
(ADR-0003): `--ink-900/700/500/300`, `--line`, `--surface{,-raised,-sunken,-ink}`,
`--ruby-{700,100,050}`, alongside the pre-existing `--color-ruby` and the
`--color-obsidian*` dark family (one dark band per page; cover art; the
vibe-code-rescue campaign page).

**The zero-delta promotion pattern.** Moving tokens into this file is done in
its own commit, with the old names kept as aliases (`--rr-x: var(--x)`) and
identical values, so nothing renders differently and no baseline moves. That
turns the *next* commit — deleting a token and repointing its consumers — into
a value change rather than a rename, so its diff is about colour roles only.
Verified in 1a.1 by computed-value checks in the browser plus 53 screenshots
compared with zero churn.

**Deprecation in progress:** `--color-primary` (`#1a8cff`) is named "primary"
but appears in no brand definition; it and the late-cascade `#0066d6` anchor
rule are deleted in Phase 1a.2/1a.3. Until then, three page files carry scoped
`!important` workarounds against that rule — retiring all of them is the
phase's success signal.

# The white-wash trap: computed style, not source, proves the paint

Found 2026-08-20 while building `/friday-report/`. Two sections that *looked*
tokenised computed to `background-color: rgba(0,0,0,0)` — the white behind them
was `legacy-theme-skin.css`'s hardcoded `.fl-page-content`, which ships AFTER
the page slice and therefore wins on cascade order even where specificity ties.

**Why it is invisible and therefore dangerous:** both resolve to `#ffffff`
today, so there is zero visual delta and nothing to see in a screenshot diff.
The bomb goes off the moment a surface token moves off white — sections
genuinely painted by the legacy skin stay white while properly-tokenised
sections follow the token, producing a half-recoloured page caused by a file
nobody touched. ADR-0003 specifies three light surfaces, so this WILL be
exercised.

**Detection:** read *computed* `background-color`, not source. A source grep
proves what the CSS says; only computed style proves what the browser does.
Anything computing to `rgba(0,0,0,0)` where a `--surface*` token is expected is
a latent instance.

**Fix:** the `id+class` selector form prescribed in
`docs/workflows/new-page.md` for this exact trap. Do **not** reach for
`!important` — that adds to the pile Phase 1a is retiring.

Same family as the uppercase `#1A8CFF` that survived a case-sensitive sweep:
verification that rests on grep alone is verification of the wrong artifact.

## And computed style is not enough either: `elementFromPoint` cannot see overlays

Extended 2026-08-21 (Phase 1a.4). Moving the footer to `--surface-ink`
exposed a black band above it. Every DOM probe said the region was WHITE while
the screenshot said BLACK - and the screenshot was right.

It was an **FL Builder SVG shape layer**:
`.fl-builder-bottom-edge-layer .fl-shape-content .fl-shape`, a `path` filled
`#000000`. Three properties made it invisible to the obvious instruments:

| Instrument | Why it missed |
|---|---|
| `document.elementFromPoint` | the layer is `pointer-events: none`; that API is HIT-TESTING, not painting, and skips it |
| `grep background-color` | the paint is `fill`, an SVG property - no background involved |
| editing `assets/css/homepage.css` | the rule lives in `assets/css/PAGES/homepage.css` - two different files, one obvious name |

**What actually answers "which rule paints this pixel":** enumerate
`document.styleSheets`, filter rules by the property, and ask the browser
`el.matches(rule.selectorText)`. **That narrows the field; it does not name the
winner.** `matches()` only proves a selector APPLIES - it resolves neither
cascade order nor specificity, and a pseudo-element selector (`::before`) can
never match an Element at all, so pseudo-painted surfaces need
`getComputedStyle(el, '::before')` separately. Use it to collect CANDIDATE
rules, then decide between them by comparing against the element's computed
value.

The check that is actually decisive: screenshot the region and sample the pixel
(`magick img -format '%[pixel:p{x,y}]' info:`). A pixel value is a fact; a rule
list is a hypothesis. On 2026-08-21 the candidate-rule method found the homepage
painter and then FAILED on the equivalent /services/ surface. **Resolved
2026-08-21, and the cause generalises twice over.**

The services painter was `rect.fl-shape` inside the same
`.fl-builder-bottom-edge-layer`, filled by
`.services-showcase .fl-builder-bottom-edge-layer .fl-shape-content .fl-shape`
(`pages/services.css`). Two things hid it:

* **The homepage shape is a `<path>`; the services shape is a `<rect>`.** A
  query scoped to `path.fl-shape` returns `[]` on services, which reads as
  "no shape layer here" rather than "wrong primitive". Match on the CLASS
  (`.fl-shape`) or the layer, never on the element name.
* `pointer-events: none` again, so every hit-test skipped it.

**The one-line technique that works, and should be reached for first:**

```js
const s = document.createElement('style');
s.textContent = '*, *::before, *::after { pointer-events: auto !important; }';
document.head.appendChild(s);
const stack = document.elementsFromPoint(x, y);  // overlays now appear
s.remove();
stack;   // <- must be last: otherwise the completion value is s.remove()'s undefined
```

Forcing hit-testability turns a click-through overlay into an ordinary stack
entry. It found in one call what a geometric element scan, a pseudo-element
sweep and a stylesheet walk had all missed.


**The layered lesson:** source grep proves what the CSS says; computed style
proves what an ELEMENT resolves to; only the rendered pixel proves what the
user sees. Each layer catches what the one before it cannot, and a
`pointer-events: none` overlay defeats the middle one silently.

Sweep result: 12 shape-layer rules across 9 page bundles were still `#000000`
and are now `var(--surface-ink)`. Any future dark-surface token move must
include them - `grep -rn 'fill: *#000' themes/beaver/assets/css/pages/`.

# Legacy liability: FL-Builder export CSS

A large portion of shipped CSS (~75K lines at audit time) is
FL-Builder page-builder export CSS: `.fl-node-{hash}` selectors keyed
to opaque generated IDs, effectively obfuscated and un-editable by
hand. These files are being retired page-by-page (strangler pattern),
not optimized in place. The live burn-down list and per-bundle
ownership is tracked in
`docs/projects/2509-css-migration/css-bundle-ownership-map.md`.

# Consolidation rules

- Never modify vendor files (`css/vendors/*.min.css`) or dynamic
  templates (`css/dynamic-*.css`).
- Preserve cascade order: Critical → Layout → Component → Theme →
  Footer.
- Extract whole rule sets; keep page-specific `.fl-node-{hash}`
  selectors in their original files.
- Run `bin/rake test:critical` after each extraction.
