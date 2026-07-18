---
type: Decision
title: CSS Maintainability Redesign (approved 2026-07-12)
description: Approved plan superseding the original CSS-duplication-elimination goal; targets hand-editable, single-source CSS and FL-Builder retirement instead of raw line-count reduction.
resource: docs/projects/2509-css-migration/2026-07-12-css-maintainability-redesign.md
tags: [css, decision, migration]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

Approved by Paul on 2026-07-12, superseding Phase 3 (WP3.1–3.4) of the
original CSS migration plan. The original goal — "eliminate 70-80% CSS
duplication (27,094–31,536 lines)" — was falsified twice: because
PurgeCSS runs per bundle (see [css-pipeline](/architecture/css-pipeline.md)),
each page already ships only its own subset, and consolidating source
files can *grow* shipped bytes. Source line counts predict nothing
about shipped bytes.

# The real problem

Named by Paul: **fear of cross-page breakage** — nobody can tell which
pages a CSS edit affects, and ~75K lines of generated FL-Builder export
CSS (`.fl-node-*` selectors keyed to hash IDs) are effectively
obfuscated and un-editable.

# Goal & success criteria

Every style is hand-editable, understood, and single-source.

1. FL retirement burn-down: live FL layout files 16 → 0. Each rewritten
   page deletes its FL CSS file(s) and template's `fl-node-*` markup in
   the same PR.
2. Zero obfuscated artifacts at end state (no hash-named CSS files, no
   generated node-id rules).
3. No duplication in the hand-maintained layer — new CSS uses tokens
   from `foundations/css-variables.css` and shared components.
4. Safe-edit guarantee — "which pages does this affect?" answerable in
   under a minute via the ownership map
   (`docs/projects/2509-css-migration/css-bundle-ownership-map.md`);
   `bin/test` + `bin/dtest` verify changes end-to-end.
5. **Evidence rule**: any size/perf claim is validated on compiled +
   gzip per-page payload, never raw source line counts.

# Citations

[1] `docs/projects/2509-css-migration/2026-07-12-css-maintainability-redesign.md`
[2] `docs/projects/2509-css-migration/css-bundle-ownership-map.md`
