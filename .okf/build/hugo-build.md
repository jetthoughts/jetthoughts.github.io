---
type: Build Pipeline
title: Hugo build (bin/hugo-build)
description: Canonical build + validation entry point; runs Hugo plus the course validators including the banned-strings ratchet.
resource: bin/hugo-build
tags: [build, hugo, validation]
timestamp: 2026-07-19T12:00:00Z
---

`bin/hugo-build` builds the site into `_dest/public-dev/` (repo-root
`public/` is a stale artifact - never review it) and runs the validation
suite. Zero build breaks is a hard rule - all content changes must pass it
before commit.

# Key facts

- Course pages get extra validators, including the banned-strings ratchet
  driven by [data/course_banned_strings.yaml](/content/banned-strings-ratchet.md).
- The ratchet scans course chapter SOURCE markdown (`index.md` bodies,
  case-sensitive substring match) - not rendered HTML, and never SVG artwork
  or mermaid diagram labels. Defects inside artwork need the
  [visual scroll gate](/workflows/render-verification.md).
- Build twice as a control before blaming an edit for output flicker:
  Hugo stats/PurgeCSS interactions can produce nondeterministic diffs
  (term-casing races, header partialCached race).

# Examples

```bash
bin/hugo-build            # build + validate
```

# PurgeCSS cold-start race (fixed 2026-07-19)

hugo_stats.json only exists AFTER a build; a cold runner's first
production pass purges against absent stats and can drop live classes
(shipped a visible skip-link site-wide; earlier forced the fl-button
safelist entries). Guards: bin/hugo-build runs a warm-up pass when
production + stats missing; the deploy workflow has an explicit warm-up
step. sr-only/skip-link also safelisted as defense-in-depth. Never
trust a first cold production build's CSS.
