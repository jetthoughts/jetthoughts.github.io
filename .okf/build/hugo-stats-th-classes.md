---
type: Gotcha
title: Classes used only on <th> get purged from production CSS
description: Hugo 0.165 writeStats records no class attributes on <th>, so any selector whose class appears only on a th is stripped by PurgeCSS in production - and the visual gate cannot catch it because baseline and candidate are both built purged.
tags: [css, purgecss, hugo, false-green, layouts]
status: stable
generated: { by: claude/opus-5, at: 2026-08-21T18:12:00Z }
verified:
  - { by: claude/opus-5, at: 2026-08-21T18:12:00Z }
timestamp: 2026-08-21T18:12:00Z
---

# The trap

PurgeCSS keeps a selector only when the class appears in `hugo_stats.json`,
which Hugo writes from the rendered HTML. On Hugo 0.165 that file records the
`th` **tag** but not class attributes on `th` elements. A class used only on a
`<th>` is therefore invisible to PurgeCSS and its rule is deleted from the
production bundle.

Probe that established it (2026-08-21, `layouts/next/landing.html`):

| Class | Element it sits on | In hugo_stats.json |
|---|---|---|
| `rr-td-muted` | `<td>` | yes |
| `rr-table` | `<table>` | yes |
| `rr-btn-primary` | `<a>` | yes |
| `rr-th-ours` | `<th>` | **no** |
| `rr-th-theirs` | `<th>` | **no** |

Development builds hide it completely: `postcss.config.js` sets
`isDevelopment` from `HUGO_ENVIRONMENT === "development"` and skips PurgeCSS
entirely, so `bin/hugo-build` renders the styling correctly while production
ships it unstyled.

# Why no gate catches it

The visual regression suite compares a baseline against a candidate that were
**both** built the same way, so a rule that is purged in both is invisible to
it. `css_orphan_guard_test.rb` does not help either - it asks whether a FILE
is reachable from a template, never whether a SELECTOR survived the purge.
This class of defect reaches production green.

# What to do instead

Style the column by position, or move the class onto a child element:

```css
/* works: the selector matches on tag + position, no class lookup */
.rr-table thead th:nth-child(2) { color: var(--rr-ruby); }
```

```html
<!-- also works: the class rides a span, which writeStats does record -->
<th scope="col"><span class="rr-th-ours">Fractional CTO</span></th>
```

Verify on a PRODUCTION build, never a dev one: grep the fingerprinted bundle
under the production destination for the selector, and grep the rendered HTML
to confirm no orphan class attribute remains.

# The same class of defect elsewhere

Two more ways a /next/ rail change goes green while being wrong:

- **`page/site-scripts` in a landing baseof.** Its only payload is
  `navigation.js`, which unconditionally binds to `.js-mobile-menu-opener`
  from the site header partial. A layout that renders its own chrome and
  drops that partial throws `Cannot read properties of null` on every page
  load - and no test asserts a clean console, so nothing fails.
- **Computed `resources.Get` paths.** `css_orphan_guard_test.rb` scans for
  the literal `resources.Get "css/…"` string. A `printf`-built path silently
  removes the file from the guard's reachable set, so the guard keeps passing
  while no longer guarding anything. Keep one literal `resources.Get` per
  file, selected through a dict, when a template serves several skins.
