# Incremental Refactoring Strategy for Coupled Layouts and CSS

**Status**: Proposed strategy
**Date**: 2026-04-09
**Scope**: `use-cases` layout review, reusable component extraction, visual-regression-safe migration

---

## Executive Summary

The safest long refactor for the current layout system is **markup-first, CSS-last**.

The `use-cases` page already shows the safest pattern available in this codebase:

- extract large inline sections into Hugo partials
- preserve the exact FL-Builder wrapper structure while extracting
- keep legacy classes and `fl-node-*` hooks in place
- validate every small step with visual regression testing

The dangerous pattern is the opposite:

- deduplicating numbered or page-scoped layout CSS too early
- moving shared rules into imports before semantic ownership is clear
- combining HTML extraction and CSS consolidation in the same step
- changing CSS bundle order during refactoring

This document recommends a staged path that delivers reusable components in small slices while keeping `bin/dtest` as the blocking validation gate.

---

## What Was Reviewed

### Layout files

- `themes/beaver/layouts/page/use-cases.html`
- `themes/beaver/layouts/partials/page/use-cases.html`
- `themes/beaver/layouts/partials/page/cta.html`
- `themes/beaver/layouts/partials/page/testimonials.html`
- `themes/beaver/layouts/partials/components/use-case-card.html`

### CSS and architecture references

- `themes/beaver/assets/css/fl-use-cases-layout.css`
- `docs/projects/2509-css-migration/css-loading-order-analysis.md`
- `docs/projects/2509-css-migration/css-preservation-analysis.md`
- `docs/component-extraction-architecture.md`

### Git history reviewed

- `863184421` — `refactor use cases html css js (#200)`
- `386e6ace7` — `Implement conservative CSS refactoring with dual-class BEM approach ... (#247)`
- `bf6fb5076` — `refact: cleanup duplications 6 (#258)`
- `8cf0ae09c` — `refactor(css): consolidate fl-use-cases-layout.css duplicates`

---

## Current State: Where the Coupling Lives

### 1. Markup coupling

The `use-cases` page is partly decomposed already.

### Already extracted

- `partial "page/use-cases.html"`
- `partial "technologies.html"`
- `partial "page/testimonials.html"`

### Still inline in `themes/beaver/layouts/page/use-cases.html`

- the CTA block that starts after the testimonials section
- surrounding FL-Builder row/column wrappers that still act as layout contracts

### Important implication

The page already has a proven seam for safe refactoring: **extract more inline HTML into partials without changing the output structure**.

That is a safer boundary than trying to normalize CSS selectors first.

---

### 2. CSS coupling

The `use-cases` page loads a layered CSS stack with page-specific and framework-specific dependencies.

### Current load order

From `themes/beaver/layouts/page/use-cases.html` and `docs/projects/2509-css-migration/css-loading-order-analysis.md`:

1. `css/critical/base.css`
2. `css/3021-layout.css`
3. `css/bf72bba397177a0376baed325bffdc75-layout-bundle.css`
4. `css/dynamic-icons.css`
5. `css/586.css`
6. `css/vendors/base-4.min.css`
7. `css/style.css`
8. `css/skin-65eda28877e04.css`
9. `css/technologies.css`
10. `css/footer.css`
11. `css/use-cases-dynamic.css`

### Why this is risky

- `3021-layout.css` contains page-layout-specific FL-Builder styles
- shared layout bundle rules participate in cascade and override chains
- `586.css` and Foundation/grid dependencies still support builder-era structure
- many selectors depend on existing `fl-row`, `fl-col`, `fl-module`, `fl-node-*`, and page-specific wrappers
- rule movement can break pages even when the final declarations look identical

### Refactoring consequence

If component extraction starts by moving CSS rules, the blast radius is large and hard to predict.

If extraction starts by moving markup into partials while preserving the existing selector contract, the blast radius stays small.

---

### 3. Selector contract risk

The current layout is not coupled only by class names. It is coupled by a broader contract:

- wrapper depth
- `fl-node-*` identities
- FL-Builder grid classes
- section nesting order
- CSS bundle order
- page-specific overrides layered on top of shared bundles

This means a refactor can break visuals even if:

- no text changes
- no styles are intentionally removed
- the same classes appear somewhere else in the DOM

For this project, **DOM shape is part of the styling contract**.

---

## What Previous Attempts Proved

### 1. Safe precedent: markup extraction

### Commit `863184421`

This is the strongest precedent for safe change.

It:

- reduced the size of `themes/beaver/layouts/page/use-cases.html`
- moved the main use-cases body into `themes/beaver/layouts/partials/page/use-cases.html`
- kept the FL-Builder wrapper structure around the extracted block

### Lesson

**Extracting HTML into a partial is safe when the rendered structure stays effectively identical.**

This should be the primary model for the next phase.

---

### 2. Safe precedent: additive dual-class migration

### Commit `386e6ace7`

This commit documents a conservative migration pattern:

- add semantic classes beside legacy classes
- keep backward compatibility during transition
- validate after micro-steps

### Lesson

**Additive migration is safer than replacement migration.**

For this codebase, new semantic classes should appear beside:

- `fl-*`
- `fl-node-*`
- page-specific wrapper classes

Legacy selectors should remain live until the semantic component is proven stable by repeated visual checks.

---

### 3. Unsafe precedent: early CSS deduplication

### Commit `8cf0ae09c`

This is the most important warning sign.

It consolidated duplicate CSS in `fl-use-cases-layout.css` by moving rules behind imports.

The broader migration documentation in `docs/projects/2509-css-migration/` repeatedly warns that this type of change can trigger large visual regressions because it changes:

- cascade order
- shared-vs-page ownership
- override timing
- dependency order between builder, shared, and page styles

### Lesson

**Reducing duplication is not the same as reducing risk.**

A smaller stylesheet can still be less stable.

---

## Refactoring Principles for This Codebase

### 1. Preserve structure before improving structure

Do not redesign wrappers, section hierarchy, or class contracts while extracting.

First goal:

- make structure reusable
- not prettier
- not more semantic
- not more consolidated

---

### 2. Move one kind of thing at a time

Each slice should do only one of these:

- extract markup
- parameterize a partial
- add semantic alias classes
- add dual-selector CSS
- remove obsolete selectors after repeated validation

Do **not** combine HTML extraction and selector cleanup in the same slice.

---

### 3. Keep legacy selectors alive until reuse is proven

When introducing a reusable component:

- keep all legacy classes on the markup
- add semantic classes beside them
- point new CSS at both selectors during the transition

Example pattern:

```css
.fl-node-7l8hya5ixfdo,
.c-cta {
  /* shared declarations */
}
```

Only remove the legacy selector after:

- the component is reused in more than one page
- `bin/dtest` stays clean across those pages
- no downstream override still depends on the old hook

---

### 4. Treat page layout CSS as a protected zone

Until component ownership is stable, these files should be treated as protected:

- `themes/beaver/assets/css/3021-layout.css`
- `themes/beaver/assets/css/fl-use-cases-layout.css`
- shared numbered layout bundles
- Foundation/grid dependencies

Protected means:

- no reorderings
- no import-based deduplication as an early step
- no rule moves unless the component contract already exists and is tested

---

### 5. Validate after every micro-step

Refactoring only stays safe if every step is reversible and visually checked.

The minimum validation gate for this work is:

1. make one small change
2. run `bin/dtest`
3. inspect any diff before continuing

If a shared partial changes, validation must include **all pages using that partial**, not only the page that motivated the refactor.

---

## Recommended Extraction Order

### Phase 1: Extract duplicate markup only

### First target: CTA block in `themes/beaver/layouts/page/use-cases.html`

Why this should be first:

- it is already duplicated conceptually by `themes/beaver/layouts/partials/page/cta.html`
- it is visually isolated
- it has a small surface area compared to tabs/cards
- it can be extracted without touching CSS

### Rule for this slice

The partial must render **the exact current HTML contract**:

- same wrapper structure
- same classes
- same `id`
- same `data-node`
- same text
- same link target

This is a pure ownership move, not a design move.

---

### Phase 2: Extract section shells, not card internals

After the CTA block is stable:

- extract the combined testimonials/CTA section shell if it proves reusable
- preserve FL row and column wrappers intact
- keep the internal testimonial partial contract unchanged

This creates a reusable section boundary without yet touching the most fragile nested card/tab markup.

---

### Phase 3: Stabilize partial contracts

Once the CTA and surrounding section are partialized:

- introduce parameters for text, links, modifiers, or wrapper options
- keep defaults equal to current output
- do not change CSS in the same slice

The goal here is to make reuse possible while still producing the same DOM.

---

### Phase 4: Add semantic component hooks

Only after the extracted partial is stable should semantic classes be added.

Example direction:

- `.c-cta`
- `.c-cta__title`
- `.c-cta__body`
- `.c-cta__action`

Critical rule:

- semantic classes are **additive only** at first
- existing `fl-*`, `fl-node-*`, and page-specific classes stay in place

---

### Phase 5: Introduce component CSS with dual selectors

At this stage:

- create or reuse component-level CSS
- duplicate declarations safely instead of moving them immediately
- use dual selectors during the migration period

This is the first moment where CSS extraction becomes reasonable, because the component has a stable markup owner.

---

### Phase 6: Consolidate legacy selectors only after repeated proof

Only after multiple successful visual passes should cleanup start:

- remove duplicate legacy declarations
- shrink page-specific CSS
- delete dead selectors

This should be the last phase, not the first phase.

---

## What Not to Refactor First

Do **not** start with any of the following:

### 1. `use-case-card` internals

There is already a `themes/beaver/layouts/partials/components/use-case-card.html`, but it should not be the first target.

Reason:

- the inner card/tab markup is more nested
- spacing and alignment are more sensitive
- selector specificity is likely more entangled there than in the CTA block

This component becomes a good target only after the outer section boundaries are stable.

---

### 2. CSS file deduplication

Do not begin by reducing lines in:

- `3021-layout.css`
- `fl-use-cases-layout.css`
- layout bundles with numbered or hashed names

Reason:

- it changes invisible dependencies first
- it increases debugging cost
- it often looks safe in diff form while altering cascade behavior

---

### 3. CSS bundle reordering

Do not reorder the `page/use-cases.html` CSS slice during this refactor.

That includes:

- swapping bundle positions
- moving page CSS later or earlier
- folding shared imports into another file

Bundle order is part of the page’s visual contract.

---

## Micro-Refactoring Workflow

Each refactoring slice should follow this exact loop.

### 1. Choose one thin slice

Examples:

- replace one inline HTML block with a partial
- add one semantic class to one component
- add one dual-selector rule group

### 2. Preserve the existing contract

Before calling the slice done, verify:

- HTML structure is equivalent
- legacy classes remain
- IDs and `data-node` hooks remain
- text and links remain

### 3. Validate immediately

Run:

```bash
bin/dtest
```

If the change affects shared partials, validate all impacted pages before moving on.

### 4. Stop on the first unexplained diff

Do not stack more refactors on top of a visual diff.

Either:

- fix the diff immediately
- revert the slice
- narrow the slice further

### 5. Only then take the next slice

The project is safer when progress is slower but deterministic.

---

## Recommended Initial Slices

### Slice 1: Inline CTA -> partial extraction

### Files

- `themes/beaver/layouts/page/use-cases.html`
- `themes/beaver/layouts/partials/page/cta.html` or a new partial with identical output

### Allowed changes

- replace inline CTA markup with a partial call
- move HTML only

### Forbidden changes

- CSS edits
- class cleanup
- text edits
- wrapper simplification

### Validation

- run `bin/dtest`
- compare screenshots for `use-cases`

---

### Slice 2: CTA partial parameterization

### Goal

Make the CTA partial reusable without changing current output.

### Allowed changes

- add optional parameters with defaults matching current values
- keep wrapper markup and classes unchanged

### Validation

- run `bin/dtest`

---

### Slice 3: Add semantic CTA classes

### Goal

Introduce semantic hooks while preserving all legacy hooks.

### Allowed changes

- add classes like `.c-cta` beside existing classes

### Forbidden changes

- removing `fl-*`
- removing `fl-node-*`
- moving existing CSS

### Validation

- run `bin/dtest`

---

### Slice 4: Introduce dual-selector CTA CSS

### Goal

Begin component ownership in CSS without removing legacy ownership.

### Allowed changes

- add a component stylesheet or component section
- target both legacy selectors and semantic selectors

### Validation

- run `bin/dtest`
- inspect all pages that reuse the CTA

---

### Slice 5: Reuse CTA partial on another page

### Goal

Prove the component contract outside the original page.

### Allowed changes

- swap another matching inline CTA to the same partial
- preserve page-specific wrappers if necessary

### Validation

- run `bin/dtest`
- inspect both pages

---

### Slice 6: Prune legacy CTA selectors

### Preconditions

- repeated successful visual passes
- at least two real uses of the extracted component
- no page-specific override still depending on removed selectors

Only after those conditions are true should cleanup begin.

---

## Decision Matrix

| Change type | Risk | Do now? | Notes |
| --- | --- | --- | --- |
| Inline HTML -> partial with identical output | Low | Yes | Best first step |
| Partial parameterization with current defaults | Low | Yes | Safe after extraction |
| Add semantic classes beside legacy classes | Low | Yes | Additive only |
| Add dual-selector component CSS | Medium | Yes, later | Only after markup stabilizes |
| Remove legacy selectors | Medium/High | Later | Requires repeated proof |
| Deduplicate page layout CSS by import | High | No | Too risky early |
| Reorder CSS bundles | High | No | Breaks cascade contract |
| Simplify FL-Builder wrappers immediately | High | No | DOM shape is part of styling contract |

---

## Validation Checklist

Use this checklist before closing any slice.

### Pre-change

- identify the exact HTML block or selector being touched
- confirm the slice does only one kind of change
- confirm no CSS order changes are included

### Post-change

- rendered DOM contract still matches intent
- legacy selectors still exist where needed
- no unrelated cleanup slipped into the patch
- `bin/dtest` completed
- any visual diff is explained and accepted before proceeding

### Before cleanup/removal work

- component is already reused
- semantic hooks exist
- dual-selector period has been stable
- downstream pages are validated

---

## Recommended First Move

If the goal is to start delivering this refactor safely, the best first slice is:

> Replace the inline CTA block in `themes/beaver/layouts/page/use-cases.html` with a partial that preserves the exact current DOM, then validate with `bin/dtest`.

Why this is the right first move:

- it follows the successful precedent from commit `863184421`
- it avoids early CSS risk
- it creates immediate structure reuse
- it sets up later semantic/component work without destabilizing layout CSS

---

## Final Recommendation

For this codebase, reusable components should be extracted in the following order:

1. **HTML ownership**
2. **partial contract stability**
3. **semantic alias classes**
4. **dual-selector CSS ownership**
5. **legacy selector cleanup**
6. **page-layout CSS consolidation last**

This keeps refactoring incremental, reversible, and compatible with screenshot-based validation.

The core rule is simple:

> **Do not start by making the CSS cleaner. Start by making the markup reusable without changing how the page works.**
