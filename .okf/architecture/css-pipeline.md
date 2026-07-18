---
type: Service
title: CSS Build Pipeline (PostCSS + per-bundle PurgeCSS)
description: PostCSS pipeline that concatenates per-page CSS resource slices and purges unused rules per bundle before shipping.
resource: postcss.config.js
tags: [css, build, performance]
timestamp: 2026-07-12T00:00:00Z
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

# Citations

[1] `postcss.config.js`
[2] `docs/workflows/css-consolidation.md`
[3] [css-maintainability-plan](/workflows/css-maintainability-plan.md)
