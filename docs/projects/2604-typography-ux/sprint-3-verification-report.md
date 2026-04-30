# Sprint #3 Verification Report - Site-Wide Consistency

**Date**: 2026-04-30
**Verifier**: Post-Sprint-#3 visual verifier (Opus 4.7)
**Scope**: Visual cohesion across 5 page archetypes x 2 viewports (10 screenshots)
**Hugo dev server**: http://localhost:1313/ (HTTP 200, all pages styled)

---

## 1. TL;DR Verdict

**YES** - the site reads as one cohesive site.

Every page now resolves to the same baseline (`system-ui / 18px / 400 / 1.6 / #121212`), the same `.btn.btn-primary` Ruby red treatment (`#cc342d / 8px radius / weight 600 / 14px-28px padding`), and the same footer. The /about-us/ page no longer ships the 404 stylesheet, mobile horizontal scroll is gone on blog/post/about, and the blog-post byline + tags now read as editorial typography. One visible drift remains: the homepage hero `.fl-button` "Talk to an Expert" still uses the legacy blue (`#1a8cff / radius 25px / weight 700`) - this is the Sprint #3 explicit deferral, not a regression.

---

## 2. Per-Page Cohesion Table

All measurements taken from live computed styles (not source CSS).

| Page | Body font / size / color | Inline link color | `.btn-primary` shape | Mobile h-overflow |
|------|--------------------------|-------------------|----------------------|--------------------|
| / (home) | system-ui / 18px / #121212 | -- (hero buttons only) | #cc342d / 8px / w600 | none (500w) |
| /services/ | system-ui / 18px / #121212 | (gray module link #969798, td:none) | #cc342d / 8px / w600 | none (500w) |
| /blog/ | system-ui / 18px / #121212 | (#121212 card title, td:none) | #cc342d / 8px / w600 | none (500w) |
| /blog/hiring-dev-shop-questions/ | system-ui / 18px / #121212 | **#0066d6 underlined 2px @70% opacity** | #cc342d / 8px / w600 | none (500w) |
| /about-us/ | system-ui / 18px / #121212 | (gray module link #969798, td:none) | #cc342d / 8px / w600 | none (500w) |

**H1 hierarchy** (no longer collapsing):
- /: 80px / 800
- /services/: 70px / 800
- /blog/: 48px / 700
- /blog/post/: 48px / 700 (32px on mobile)
- /about-us/: 70px / 800

**Footer**: identical on all 5 pages (`bg: #000, color: #fff`).

**Mobile note**: Chrome MCP environment has a hard floor of ~500px for `resize_page` (375px request snaps to 500w). All "mobile" measurements were taken at 500x812. The critical regression test (`body { min-width: 0 }` instead of `992px !important`) is still validated - 500 < 992, and on every page `body.minWidth = 0px` and `scrollWidth == innerWidth`. So the 992px hack is provably dead.

---

## 3. Visual Cohesion (Side-by-Side)

**Most cohesive trio**: /, /services/, /about-us/. All three share the same typographic baseline, the same red Contact Us in the header, the same dark footer, and the same "Just like you, we choose..." magenta-band module on /, /services/, /about-us/. /about-us/ is now indistinguishable from the marketing pages structurally.

**Most visually distinct**: /blog/post/. By design (it's a reading page) - narrow column, smaller H1 (48px instead of 70-80px), inline `#0066d6` underlined links in body copy. But the *brand* is consistent: same header CTA, same footer, same body baseline. It reads as the "blog section of the same site," not "a different site."

**Page that still drifts (one item)**: the homepage hero `.fl-button` ("Talk to an Expert", "Explore Use Cases") is still on the legacy `#1a8cff / radius 25px / weight 700` treatment. This is the only remaining visible cross-page button-shape inconsistency. Coordinator report flagged this as deferred to Sprint #4 ("Hero CTA reconciliation").

---

## 4. Sprint #3 Wins Confirmed (live measurements)

1. **Body baseline cascade reaches every page** (fix #4). Computed `body { font-family: system-ui, ...; font-size: 18px; font-weight: 400; line-height: 28.8px (1.6); color: rgb(18, 18, 18) }` is identical on /, /services/, /blog/, /blog/post/, /about-us/. Pre-fix, only / and /services/ had body resets and the others fell into Roboto/weight-300/lh-1.5.

2. **`.btn.btn-primary` is Ruby red site-wide** (fix #2). On all 5 pages: `bg: rgb(204, 52, 45) / border-radius: 8px / font-weight: 600 / padding: 14px 28px / font-size: 18px`. Pre-fix this was unstyled (`#1a8cff` Bootstrap blue or per-page drift).

3. **Mobile horizontal scroll is gone on blog/post/about** (fix #3). At 500w, every page reports `body.minWidth = 0px` and `scrollWidth == innerWidth`. Pre-fix, blog/post/about had `body { min-width: 992px !important }` forcing horizontal scroll under 992px.

4. **/about-us/ is fully branded** (fix #1). Live stylesheet list now contains an `about-us` bundle and zero `not_found` references. `has_about_bundle: true`, `has_404_bundle: false`. Ruby red Contact Us CTA renders. /about/ legacy URL serves a meta-refresh redirect to /about-us/ (HTTP 200, refresh content header confirmed).

5. **Blog post byline reads as editorial masthead** (fix #5). `.post-meta-byline` rendered as `font-size: 12px / font-weight: 600 / text-transform: uppercase / letter-spacing: 0.96px`. Visible text: "BY JETTHOUGHTS TEAM - APRIL 27, 2026 - 11 MIN READ".

6. **Blog post tags read as editorial taxonomy, not hashtags** (fix #6). `.post-tags` rendered as `font-size: 12px / text-transform: uppercase`, leading text "Filed under: startup, ...". No `#` prefix in copy.

---

## 5. Remaining Drift / Sprint #4 Candidates

1. **Homepage hero `.fl-button` still on legacy blue.** Live values: `bg: rgb(26, 140, 255) / border-radius: 25px / font-weight: 700 / padding: 12px 24px`. Two of these on the homepage hero ("Talk to an Expert", "Explore Use Cases"). They are visually the loudest CTAs above the fold and clash with the Ruby red `.btn-primary` Contact Us in the same header. Decide: are they primary CTAs (turn red) or are they brand-blue accent CTAs (keep blue, but reconcile shape - maybe `radius 8px / weight 600` to match `.btn-primary`)?

2. **Inline link color is not promoted site-wide** (Sprint #2 promotion still pending). On /blog/post/ inline content links are the spec-correct `#0066d6 / underline 2px / 70% opacity`. On /services/ and /about-us/, the only inline-link sample I caught was the gray `.fl-button-text` at `#969798` (a feature module). The spec rule from findings doc Section 4.1 (`:where(a):not(.btn):not(.btn-primary):not([class^="cta"])`) was not added to `critical.css` site-wide. Low impact for now (most pages don't have body-prose links), but would cement cross-page link consistency once we add prose to /about-us/.

3. **`#1a8cff` legacy blue still dominant in CSS bundles** (per coordinator report, 22-54 occurrences per bundle). Sprint #3 swapped the `.btn-primary` away from it but didn't audit and replace the rest. Most uses are inside `.fl-button` / Beaver Builder Bootstrap-derived modules, so they'd come along with item #1 if hero CTA gets reconciled.

4. **Blog index card "tags-line" still uses hashtag-style rendering.** This is on /blog/ (the index), not /blog/post/. Sprint #3 fix #6 only updated `single.html`. The card list in `list.html` still renders tags inline with `#` styling. Low priority - it's a card meta line, not the page's primary brand surface - but worth noting for completeness.

---

## 6. Screenshots Inventory

All 10 saved to `/Users/pftg/dev/jetthoughts.github.io/docs/projects/2604-typography-ux/sprint3-verification/`. All confirmed readable as PNG (visually evaluated by reading each file).

| File | Bytes | Visual notes |
|------|-------|--------------|
| `homepage-desktop.png` | 1.4 MB (full page) | Dark hero, Ruby red Contact Us nav, 80px H1, "Just like you" module, dark stats panel, Ruby red bottom CTA. Hero `.fl-button` blue (deferred). |
| `homepage-mobile.png` | 168 KB (viewport, 500w) | Hamburger nav, stacked hero card, big H1 below stats card. No h-scroll. |
| `services-desktop.png` | 741 KB (full page) | Same structure family as / - white hero with H1 70px, services grid, "Just like you" module, Ruby red CTA at bottom. |
| `services-mobile.png` | 69 KB (viewport, 500w) | Tagline "SERVICES" / H1 stack / paragraph / icon + "Fractional CTO" card / blue "Learn More" link. No h-scroll. |
| `blog-index-desktop.png` | 681 KB (full page) | "Blog" H1 48px, list of post cards with covers (red sparkle thumbnails), card meta lines, pagination "Next" button. |
| `blog-index-mobile.png` | 98 KB (viewport, 500w) | Stacked card layout, no h-scroll, hamburger nav. |
| `blog-post-desktop.png` | 2.1 MB (full page) | "5 Questions Before Hiring a Dev Shop" H1, BY JETTHOUGHTS TEAM uppercase byline, full editorial article with cover image, FILED UNDER tags. Reading column comfortable. |
| `blog-post-mobile.png` | 130 KB (viewport, 500w) | H1 stacks across 2 lines, byline visible, cover image at full mobile width, opening paragraphs, no h-scroll. |
| `about-desktop.png` | 614 KB (full page) | Dark hero "Learn more about our story...", Mission/Culture columns, "How we see the world" values grid, dark "Our successful outcome" stats panel, "5+ / 8+ / 4+" metrics, Ruby red CTA at bottom. |
| `about-mobile.png` | 252 KB (viewport, 500w) | Big stacked H1, hero photo, "Our Mission" bullet list, system-ui throughout. No h-scroll. |

---

## 7. Notes on Methodology / Limitations

- **Chrome MCP viewport floor**: resize_page below ~500w is silently clamped to 500w in this Chrome instance. The `emulate` tool with `viewport=375x812x2,mobile,touch` timed out and did not stick. All "mobile" measurements were therefore taken at 500w. This is wider than the spec's 375w target, but still well below the 992w threshold that was the actual breakpoint for the body min-width hack. So the critical sprint-#3 mobile regression test is still validly verified.
- **First page reload after fresh tab**: Hugo's main CSS bundle did not load on the initial selected page until a `reload(ignoreCache: true)` was issued. After that, every subsequent navigation rendered fully styled. This is a livereload caching quirk in the dev server, not a production issue (coordinator report mentioned dev-server CSS caching as a known sprint-#3 quirk).
- **Stylesheet count on /about-us/**: 8 stylesheets including the `about-us` bundle. `has_404_bundle: false` confirmed. Pre-fix the page would have shipped a single `not_found.6e81c42e...css` plus globals - the rebrand is real.
