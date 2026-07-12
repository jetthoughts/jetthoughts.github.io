# CSS Maintainability Redesign — approved spec (2026-07-12)

Supersedes Phase 3 (WP3.1–3.4) of the original migration plan. Approved by Paul on
2026-07-12 after per-section review (brainstorming session, sprint 7).

## Why the plan changed

The original goal — "eliminate 70-80% CSS duplication (27,094–31,536 lines)" — was
falsified twice. Phase 1 measurement (WP1.2/WP1.4) and the Phase 2 audits both showed
that in this pipeline PurgeCSS runs per bundle, so each page already ships only its own
subset; consolidating source files grows shipped bytes (measured: shared FL foundation
= +7.1–9.8 KB gzip first-visit per page). Line counts of source files predict nothing.

The real pain, named by Paul: **fear of cross-page breakage** — nobody can tell which
pages a CSS edit affects, and ~75K lines of generated FL-Builder export CSS
(`.fl-node-*` rules keyed to hash IDs) are effectively obfuscated and un-editable.

## Goal

Every style on the site is **hand-editable, understood, and single-source**.
FL-Builder export CSS is a legacy liability to retire page-by-page (strangler
pattern), not to optimize in place.

### Success criteria

1. **FL retirement burn-down**: live FL layout files 16 → 0 (17 at audit time;
   the e93d9b85 bundle was merged away in PR #363 — see
   `css-bundle-ownership-map.md` for the live list). Each rewritten page deletes
   its FL CSS file(s) and its template's `fl-node-*` markup in the same PR.
2. **No obfuscated artifacts** at end state: zero hash-named CSS files
   (`bf72bba…`, `e966db44…`, `fb2624…`), zero generated node-id rules.
3. **No duplication in the hand-maintained layer**: new CSS uses tokens from
   `foundations/css-variables.css` and shared components; the same rule appearing
   twice is a defect.
4. **Safe-edit guarantee**: for any CSS file, "which pages does this affect?" is
   answerable in under a minute (ownership map + per-file header), and the existing
   test suites (`bin/test` + `bin/dtest`) verify a change end-to-end.
5. **Evidence rule**: any size/perf claim is validated on compiled + gzip per-page
   payload, never raw source line counts.

### Non-goals

- Transfer-size optimization (proven net-negative territory here).
- Consolidating, renaming, or refurbishing FL files that are scheduled to die.
- PostCSS pipeline changes, except where a rewrite requires one.

## Phase 0 — safety scaffolding (one small sprint, before any rewrite)

Regression detection uses the EXISTING snapdiff infrastructure — `bin/test` (macOS)
and `bin/dtest` (Linux/Docker), built on capybara_screenshot_diff with
`FORCE_SCREENSHOT_UPDATE=true` for baseline regeneration and
`SCREENSHOT_STABILITY_TIME` for flaky pages. **No new custom baseline/compare
scripts.** Where the suites don't cover a surface, the fix is adding tests, not
tooling. Phase 0 closes the known coverage gaps:

1. **Special-content blog post coverage.** Blog posts exercise CSS surfaces no
   marketing page touches, and today only one post (red-flags…) is screenshot-tested.
   Inventory findings (2026-07-12): 3 posts use Mermaid diagrams
   (langchain-memory-systems…, rails-performance-at-scale…, hidden-cost-poor-
   development…), 139 posts have Chroma-highlighted code fences, 3 posts carry raw
   inline `style=` HTML, and the `youtube` shortcode is in use. Add desktop + mobile
   screenshot tests for one representative post per surface: a Mermaid post, a
   code-highlight-heavy post (Dracula wrapper must render), an inline-style post,
   and a youtube-embed post. The skipped `DiagramComponentTest`
   (test/system/components/diagram_component_test.rb) gets revived or replaced by
   the Mermaid-post test.
2. **Rewrite-target coverage check.** Before each page's rewrite sprint, confirm the
   suites screenshot that page (desktop + mobile); add the missing test first if not.
3. **Page→bundle ownership map** — one doc in this folder listing all 19 bundles:
   owning template, feeding CSS files, URLs that load it, current gzip size, rewrite
   status (live-FL / rewritten / retired). Doubles as the burn-down chart. Each FL
   CSS file gets a one-line header comment pointing at the map.
4. **Orphan guard** — a check that lists CSS files under `themes/beaver/assets/css/`
   referenced by no template resource slice, so dead files can't accumulate again.

No legacy CSS edits in Phase 0.

## The per-page rewrite protocol (repeating unit; one page, one branch, one PR)

1. **Capture the before**: confirm the page has snapdiff coverage (add the test if
   missing — Phase 0 item 2), regenerate its baselines
   (`FORCE_SCREENSHOT_UPDATE=true`) on both suites; full-page screenshots at
   1280×800 and 390×844 as the design reference.
2. **Design pass**: start from `.stitch/design.md` (JetVelocity). Visual improvement
   is allowed and expected; write a short layout-intent note (what stays, what
   modernizes). Review includes a scored design-critic pass against external anchors,
   not just a defect checklist.
3. **Rewrite the template**: semantic HTML, no `fl-node-*` / `fl-row` / `fl-col`
   classes; class names carry meaning (`clients-hero`, `cta-banner`). Shared partials
   (header/nav/footer, technologies, testimonials) stay untouched until their own turn.
4. **Write the page CSS**: one file per page under `css/pages/`, built on
   `css-variables.css` tokens; no literal value where a token exists. Target hundreds
   of lines, not thousands. Swap the resource slice: FL files out, new file in.
5. **Delete in the same PR**: the page's FL layout CSS plus any satellite that loses
   its last importer. Orphan guard confirms.
6. **Verify**:
   - Both visual suites (`bin/test` macOS + `bin/dtest` Linux): this page's
     baselines change intentionally and are updated in the PR (both macos/ AND
     linux/) after Paul approves; every OTHER page and every special-content blog
     screenshot must be 0.0-diff — that is the no-cross-page-breakage guarantee.
   - Chrome DevTools: zero console errors, zero 404s; desktop + mobile screenshots
     attached to the PR for design approval.
7. **Rule of three**: extract a shared component to `css/components/` only when a
   2nd–3rd rewritten page needs a pattern an earlier one has; the extraction PR
   touches only rewritten pages and is verified the same way.

Rollback = revert one PR; the FL file returns.

## Rewrite order (easiest first, ascending FL size)

| # | Page (FL file) | FL lines |
|---|----------------|----------|
| 1 | Generic pages + course list (3059) | 924 |
| 2 | Contact-us (706) | 2,202 |
| 3 | Blog/client/career/course singles (3114) | 2,272 |
| 4 | Free-consultation + blog lists (homepage-layout + services-layout satellites) | ~4,356 |
| 5 | Career single (e966db44…) | 4,364 |
| 6 | About (701) | 4,462 |
| 7→ | Use-cases single (3027), careers (3086-layout2), clients landing (3082), services single (2949), use-cases landing (3021), clients single (fb2624…), services landing (737) — ascending | 5,056–6,523 |
| last | Homepage (590) | 12,437 |

The shared `bf72bba…` bundle (8 templates) and the `critical/` FL trio retire when
their last consumer is rewritten. Order flexes when Paul wants a page modernized
sooner; the protocol never changes.

## Bookkeeping

- Old Phase 3 (pattern consolidation + Hugo enhancements, 20–45 h) is **closed as
  superseded** — its premise died with the compiled+gzip evidence.
- TASK-TRACKER updates: GOAL OVERVIEW rewritten to this goal; stale CUMULATIVE
  METRICS replaced by the FL burn-down table (16 → 0); new phases = Phase 0
  (scaffolding) then rewrite sprints R1…Rn.
- Pace: one page per sprint, no fixed calendar. One branch + one bundled PR per
  sprint, per repo policy.
