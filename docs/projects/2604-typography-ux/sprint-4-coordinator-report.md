# Sprint #4 Coordinator Report - FL-Builder CTA Reconciliation

**Date**: 2026-04-29
**Branch**: master (pushed)
**Hugo build**: passing (655 pages, 2 aliases, 0 errors)
**Scope**: Close the `.fl-button` gap flagged by the Sprint #3 verifier.

## What shipped

Sprint #3 unified `.btn.btn-primary` site-wide (header Contact Us, pagination, blog post inline CTA) but the FL-builder CTA selector tree was independent: `.fl-page a.fl-button` (specificity 0,2,1) lived in per-page bundles (`about-us.css`, `homepage.css`, `590-layout.css`) and painted homepage hero + about-us footer CTAs blue (`#1a8cff`) with 25px pill radius.

**Fix**: added a `.fl-button` brand block to `themes/beaver/assets/css/navigation.css` (already inlined site-wide) using `!important` to defeat the per-page bundle specificity:

```css
a.fl-button, a.fl-button:visited, .fl-button-wrap a {
  background-color: #cc342d !important;
  color: #fff !important;
  padding: 14px 28px !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  font-size: 18px !important;
  text-decoration: none !important;
  border: none !important;
  transition: background 0.15s ease;
}
a.fl-button:hover, .fl-button-wrap a:hover {
  background-color: #a8231e !important; color: #fff !important; text-decoration: none !important;
}
```

## Confirmed wins (live computed styles)

- **Homepage hero "Talk to an Expert"**: was `bg #1a8cff / radius 25px / weight 700`, now `bg #cc342d / radius 8px / weight 600 / padding 14/28`.
- **Homepage hero "Explore Use Cases"**: same transition.
- **Homepage hero card "Talk to an Expert" (was dark `#121212`)**: also pulled into Ruby red.
- **About-us footer "Contact Us"**: was `#1a8cff / 25px`, now `#cc342d / 8px`.
- All 6 `.fl-button` instances measured across `/` and `/about-us/` resolve to `rgb(204, 52, 45) / border-radius: 8px / font-weight: 600 / padding: 14px 28px`.

## Test baselines

`bin/test` failure count before this sprint: 35. After fix: 36 (one extra new diff before baselines were updated). 80 modified screenshots staged atomically with the CSS fix per the visual regression test gate rule (commit `1712b60d9`). Baselines now represent the post-Sprints-#2/#3/#4 visual state.

Hugo build: passing (655 pages, 0 errors).

## Remaining drift (out of scope)

- The decorative blue bar at the bottom of the About-us "Let's get started" panel is a separate `fl-row-bg` background element, not a CTA. Worth a future audit, but outside Sprint #4 scope.
- `#1a8cff` legacy blue still has 22-54 occurrences per CSS bundle (mostly inline link colors inside Beaver Builder modules). Sprint #2 brand-blue promotion (`#0066d6` site-wide for prose links) still pending - low impact since most non-blog pages have minimal body prose.
- Blog index card "tags-line" still renders hashtag-style on `/blog/`. Sprint #3 fix #6 only updated `single.html`.
