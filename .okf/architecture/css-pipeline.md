---
type: Service
title: CSS Build Pipeline (PostCSS + per-bundle PurgeCSS)
description: PostCSS pipeline that concatenates per-page CSS resource slices and purges unused rules per bundle before shipping.
resource: postcss.config.js
tags: [css, build, performance]
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
