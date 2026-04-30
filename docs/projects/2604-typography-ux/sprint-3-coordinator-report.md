# Sprint #3 Coordinator Report - Site-Wide Consistency Fixes

**Date**: 2026-04-29
**Branch**: master (pushed)
**Hugo build**: passing (655 pages, 2 aliases, 0 errors)

## Issues Shipped

| # | Issue | Commit | What Changed |
|---|---|---|---|
| 1 | `/about/` -> 404 stylesheet | `2dbf5f725` | Added `aliases: ["/about/"]` to `content/pages/about-us/index.md`. Legacy `/about/` URL now redirects to `/about-us/`, which loads the branded `about-us.css` bundle (not `not_found.css`). |
| 2 | `.btn.btn-primary` unstyled | `657350856` | Replaced legacy `.btn-primary { background: #1a8cff }` in `themes/beaver/assets/css/navigation.css` with brand styling (Ruby red `#cc342d`, 8px radius, weight 600, padding 14px/28px). `navigation.css` is inlined site-wide via `baseof.html`, so this propagates to header Contact Us, pagination, and all `.btn.btn-primary` instances on the site (including the inline blog post CTA). |
| 3 | `body { min-width: 992px !important }` | `6b08694ff` | Stripped the screen-media body min-width hack from `themes/beaver/assets/css/vendors/base-4.min.css`. The print-media equivalent inside `@media print` was preserved. Mobile blog/post/about pages no longer force horizontal scroll. |
| 4 | Body baseline cascade | `d4c7cb2d9` | Promoted `body { font-family: system-ui; font-size: 18px; font-weight: 400; line-height: 1.6 }` baseline to `navigation.css` (inlined site-wide). Updated 9 redundant body rules in `critical.css`, `skin-65eda28877e04.css`, `theme-main.css`, and 6 critical bundle CSS files to match the new baseline (was `roboto / weight 300 / lh 1.5`). All 5 page archetypes now resolve to `system-ui / 18px / 400 / 1.6`. |
| 5 | Author byline | `d7367e413` | Editorial styling: 12px / uppercase / weight 600 / 0.08em letter-spacing. Reads "BY JETTHOUGHTS TEAM - APRIL 27, 2026 - 11 MIN READ" - magazine masthead, not WordPress meta. Photo/profile-page work intentionally deferred until that content exists. |
| 6 | Tags as editorial taxonomy | `26f6db04c` | Replaced "#startup #hiring #dev-agency" hashtag rendering with "FILED UNDER: STARTUP, HIRING, DEV-AGENCY" editorial style. Top border + uppercase label + comma separators. Hover shifts to brand red. Updated `themes/beaver/layouts/single.html` template + added styles to `themes/beaver/assets/css/style.css`. |

All commits pushed to `master`.

## Deferred

None - all 6 issues shipped. Issue 5 was scoped down (light styling pass only - no author photos/profile pages) per spec.

## Unexpected findings & rollbacks

1. **`/about/` was never the real URL**. The findings doc claimed `/about/` ships `not_found.css`. It does, but only because `/about/` is a 404 (not a real page). The actual page is `/about-us/`, which already had its own `about-us.css` bundle. The fix made `/about/` redirect to `/about-us/` so any legacy links don't land on the 404 bundle. Same outcome, simpler change.
2. **`.btn-primary` source of truth wasn't `components/buttons.css`**. The spec said add the rule there, but the homepage CSS resource list does not import `critical.css` (only `critical/base.css`), so changes to `components/buttons.css` never reached the homepage bundle. The rule lived in `navigation.css` (inlined site-wide via `baseof.html`). Updated that file instead. Same intent, correct location. Reverted the misplaced edit before committing.
3. **`body { min-width: 992px !important }` was in a vendor file**. The hacked rule lived in `themes/beaver/assets/css/vendors/base-4.min.css` (a Bootstrap-derived bundle that someone edited). Removed only the screen-media occurrence; the print-media `@media print { body { min-width: 992px !important }}` inside the same file is Bootstrap default and was preserved.
4. **9 redundant body rules** instead of the 5 mentioned in the spec. Each `critical/*-critical.css` bundle contained its own body rule with weight 300 / line-height 1.5 / Roboto. All updated to the new baseline.
5. **Hugo dev server caching** required 3 server restarts during the sprint when `partialCached`-stored CSS partials wouldn't pick up source changes from livereload. `bin/hugo-build` worked correctly throughout. Production builds are unaffected.
6. **No rollbacks** - every fix passed visual gatekeeper on first review. Each commit was atomic and per-issue, allowing easy isolated revert if needed.

## Visual evidence

Screenshots saved under `docs/projects/2604-typography-ux/sprint3-screenshots/`:
- `01-about-before.png`, `01-about-after.png`
- `02-btn-primary-home-after.png`
- `03-blog-mobile-after.png`
- `04-body-aboutus-after.png`
- `05-byline-after.png`
- `06-tags-after.png`

## Next sprint candidates

- Promote sprint #2 link styling (`#0066d6` underlined) from `.blog p a` scope to site-wide (the rule from findings doc Section 4.1)
- Audit remaining `#1a8cff` occurrences (22-54 per bundle) and replace with `#0066d6` brand blue
- Hero CTA `.fl-button` reconciliation - homepage hero uses blue, while header/inline buttons now use red. Decide if the hero CTA should also turn red or stay blue as a visual "primary action" cue.
