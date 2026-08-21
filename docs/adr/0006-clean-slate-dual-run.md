# Architecture Decision Record: Clean-slate v2, dual-run with a /next/ staging rail

**ADR-0006**
**Date:** 2026-08-21
**Status:** Accepted (approved by Paul in plan mode, 2026-08-21)
**Supersedes in part:** ADR-0003's *propagate-into-legacy* rollout mechanism,
for pages not yet shipped. ADR-0003's brand decisions remain in force on the
live site until the design competition names a winner.

## Title

Stop converting the legacy cascade page by page. Build v2 on a separate rail,
run both, and cut over one page at a time through a non-indexed `/next/` path.

## Context

ADR-0003 chose a strangler rollout: convert each page bundle in place, one PR
at a time, propagating the new tokens into the existing FL-derived cascade.
Five months of evidence say the two halves of that plan performed very
differently:

| Approach | Outcome |
|---|---|
| Born-clean page (blog rebuild, blog-single, course, vibe-code-rescue, friday-report) | shipped; 0–11 `fl-` lines; no reverts |
| Propagate into legacy (1a.4 footer, the 41-rule eyebrow sweep, #540's first attempt) | reverted, or created the seam it was removing |
| Buttons (780 call sites) and the 39 remaining blacks | never started |

The pattern is not about skill. A born-clean page owns its whole cascade, so a
change to it is local and its blast radius is one screenshot key. A
propagation change lands in a cascade recovered from an obfuscated FL-Builder
export, where `legacy-theme-skin.css` and a `:not()`-chain anchor rule outrank
whatever the page declares — so each fix needs a specificity workaround, and
the workaround is the next defect.

Paul's direction is that the site must read as a top-tier service with a
top-tier UI. The recovered cascade is not the foundation for that, and the
cost of making it one is now measurable in reverts.

## Decision

1. **Legacy is frozen.** `themes/beaver/layouts/**` and the existing bundles
   take defect fixes only. Two ADR-0003 work items are **dropped** as
   work-done-twice: the 780-site button unification and the 39 remaining
   hardcoded blacks. They will be resolved by pages moving to v2, not by
   editing the pages twice.
2. **v2 gets its own rail**, forked from the theme rather than grown out of
   it: `layouts/next/baseof.html` + `layouts/next/single.html` +
   `themes/beaver/assets/css/pages/next-pilot.css`. The rail keeps every
   FUNCTIONAL part of the theme baseof verbatim (SEO meta, the five schema
   partials, favicons, analytics — conversion events are attribute-driven, so
   the partial keeps them firing — service worker, skip link,
   `<main id="main-content">`) and reuses the chrome partials as they are. It
   drops the 7 hardcoded `fl-*` body classes, the `.fl-page` wrapper and the
   legacy slice members (`style.css`, `586.css`, `vendors/base-4.min.css`,
   `legacy-theme-skin.css`).
3. **`/next/` is staging on the production host**, not a separate deploy. It
   is `noindex` (frontmatter cascade → `enhanced-meta-tags.html`) and excluded
   from the sitemap (`private: true` → `layouts/sitemap.xml`). **No robots.txt
   disallow** — that would hide the `noindex` meta from the crawlers that need
   to read it. Staging is **sunset after two clean flips**.
4. **A staging stub owns only the URL.** Its `source_page` resolves the real
   page; the v2 layout renders from that single source so copy cannot drift
   between rails. The canonical points at the source page, emitted from the
   shared meta partial so exactly one canonical ships.
   **PR-1's pilot is a RAIL SMOKE PAGE, not a service-page mirror** — measured:
   47 of the real page's 536 words render, because service copy lives in
   frontmatter (`overview`, `faqs`) the smoke template does not read. Porting
   those frontmatter sections is PR-2's FIRST task, before any styling. Do not
   judge the design against the smoke page.
5. **Flipping a page keeps the permalink** so no redirects are needed, and the
   revert is a frontmatter change. But the flip is only safe ONCE the v2
   template renders everything the page's frontmatter carries (see 4) — setting
   `type: next` on the real page before that guts it to the smoke-page subset.
   The flip checklist: v2 template reads every frontmatter section the page
   uses → baselines for the page key → then `type: next`.
6. **Homepage carve-out.** A v2 homepage may be built at `/next/` at any time,
   but the PUBLIC flip honours the ≈2026-09-17 engagement-read gate from
   ADR-0004 — the homepage is the only surface with enough traffic for the
   read to mean anything, and flipping it early destroys the baseline.

## Consequences

**The rail is not zero-legacy — navigation.css leaks a body rule.** The v2
bundle reuses `navigation.css` and `footer.css` for chrome, and
`navigation.css:20` sets `body { font-family: system-ui; font-size: 18px;
line-height: 1.6; color: #121212 }` — so v2 pages inherit legacy body sizing
and a hardcoded colour literal unless the page bundle overrides them. Known,
accepted for PR-1; PR-2's design pass owns the override (measured: the pilot's
loose h1 leading is this rule).

### Positive

- Every v2 page is born clean; no page is edited twice.
- The rail is testable on the production host, on real devices, before any
  visitor-facing change.
- Rollback is a frontmatter revert rather than a CSS bisect.
- Closing a related false-green: root `layouts/` had no `bin/qtest` mapping at
  all, so a root-layouts-only diff exited 0 having tested nothing. The rail
  forced the terminal `^layouts/` → escalate-to-all case that fixes it.

### Negative / accepted risk

- **Two rails exist at once.** A chrome partial edited during the dual-run
  period must be checked on both. Mitigated by the freeze: legacy takes defect
  fixes only.
- **If the competition winner deviates from ruby/LIGHT**, this ADR supersedes
  ADR-0003's brand decisions too, and the already-shipped blog and course
  surfaces join a re-skin queue. Accepted cost, taken knowingly.
- **`/next/` is publicly reachable.** Anyone with the URL sees unfinished work.
  Accepted: `noindex` + sitemap exclusion is the right trade against the cost
  of a separate deploy target, and the pages carry no claims of their own.
- The rail duplicates ~70 lines of baseof. Deliberate: a shared baseof with
  conditionals is exactly the coupling this ADR exists to remove.

### Neutral

- No new dependency, no build-pipeline change. The v2 bundle goes through the
  same `assets/css-processor.html` as every other bundle.

## Alternatives considered

**Keep propagating (ADR-0003 as written).** Rejected on its own evidence:
three of three propagation attempts reverted, and the two largest items never
started.

**A second Hugo site / separate deploy target.** Cleanest isolation, but it
cannot be reviewed on the real host with the real chrome, and the flip becomes
a migration rather than two frontmatter lines.

**Redesign in place behind a feature flag.** Same cascade, same specificity
fights, plus a flag to maintain.

## References

- `docs/projects/2608-site-design-system/20-29-strategy/20.06-clean-slate-v2-plan.md` — the approved plan this ADR records
- ADR-0003 — the design system whose rollout mechanism this supersedes in part
- ADR-0004 — why the homepage flip waits on an engagement read
- `docs/workflows/new-page.md` §v2 rail — which fork a new page belongs on
- `docs/projects/2509-css-migration/css-bundle-ownership-map.md` — the `next-pilot` bundle row
