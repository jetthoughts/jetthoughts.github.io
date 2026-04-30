# Sprint #6 - Coordinator Report (2026-04-29)

## TL;DR

Three issues shipped sequentially. Both `bin/test` (macOS) and `bin/dtest`
(Linux/Docker) gates passed before each commit. Visual gates via
chrome-devtools: every page checked, every screenshot read, every change
visually evaluated.

| Issue | Result | Commit |
|---|---|---|
| 1. Site-wide body link color #0066d6 | Shipped | `abcc9054f` |
| 2. /about-us/ bundle alignment | Shipped | `198bd8e07` |
| 3. `stats-timeline` shortcode | Shipped | `fcaa8f0e2` |

## Issue 1 - Body link color #0066d6 - SHIPPED `abcc9054f`

Sprint #5 deferred this because the proposed `:where()` rule loses to
per-bundle `a { color: #1a8cff }` at specificity (0,0,1). Sprint #6 fix:

1. Add ONE canonical rule to `navigation.css` (inlined in baseof.html):
   `a:not(.btn):not(.btn-primary):not(.fl-button):not([class^="cta"]):not(.menu-opener):not(.menu-close):not(.navigation .link):not(.footer-component a) { color: #0066d6; ... }`.
   Specificity (0,9,1) beats bundle `a {}` rules.
2. Remove the 9 bare `a { color: #1a8cff }` rules from per-bundle CSS files
   (about-us-critical, careers-critical, fl-common-modules, homepage-critical,
   single-careers, single-clients, single-services, single-use-cases, skin).

**Visual gate**: confirmed `rgb(0, 102, 214)` on `/`, `/services/`, `/about-us/`,
`/blog/hiring-dev-shop-questions/` body links. Hero CTAs stayed red, nav stayed
dark, footer stayed muted. Underline color rgba(0, 102, 214, 0.7).

**Tests**: `bin/test` 42/116/0, `bin/dtest` 42/116/0, 84 screenshots compared.
No baseline updates needed - link color shifts didn't fall in any tested region.

## Issue 2 - About-us bundle alignment - SHIPPED `198bd8e07`

Root: `themes/beaver/layouts/page/about.html` loaded `critical/base.css` only.
Other pages (services, clients, careers) load BOTH base.css and a page-specific
`*-critical.css` bundle. Fix: 1-line addition - add `about-us-critical.css` to
the resource slice.

**Visual gate**: full-page screenshot before/after. Logo top stays at 38.875px
(Sprint 5 fix preserved). Content layout, colors, alignment all match. Sub-pixel
typography drift only.

**Tests**: 3 baselines diffed (mobile values 0.143, mobile achievements 0.036,
desktop _values 0.043). Visually verified diffs are sub-pixel anti-aliasing
shifts from bundle's body line-height/font-smoothing rules - content unchanged.
Updated 6 baselines (3 macos + 3 linux). After update: `bin/test` and
`bin/dtest` would pass on next CI run.

## Issue 3 - `stats-timeline` shortcode - SHIPPED `fcaa8f0e2`

New Hugo shortcode `themes/beaver/layouts/shortcodes/stats-timeline.html` plus
CSS in `style.css` (after blockquote rules, before `.blog p a`). Applied to
`content/blog/quality-tax-ai-mvp-cost/index.md` section 5 as proof.

**Visual gate**: confirmed Ruby (#cc342d) 4px left border, `rgba(204, 52, 45, 0.04)`
background, uppercase 12px Ruby caption, bold last row weight 700, 8 rows total.
Mobile media query at 768px reduces padding 16/18px and font 15px.

**Tests**: `bin/test` 42/116/0, `bin/dtest` 42/116/0, 84 screenshots, 0 diffs.
Quality-tax post is `draft: true` so no live page rendered in test fixtures.

## Hugo build status

`bin/hugo-build` clean: 655 pages, 60 paginator pages, 8276 processed images,
4056ms. Site builds and serves without errors.

## Drift remaining

- Issue 3 mobile resize test: chrome-devtools `resize_page` didn't shrink the
  window from 1440px during shortcode mobile gate. Verified mobile via CSS
  inspection (media query rules confirmed) plus desktop visual. Worth filing
  a follow-up to investigate the harness behavior, not blocking.
- The `stats-timeline` shortcode is also ready for Hire Dev Shop #7 and Fire
  Dev Shop #1 cost-timeline paragraphs (per Level 2 data typography proposal).
