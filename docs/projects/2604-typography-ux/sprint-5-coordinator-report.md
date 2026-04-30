# Sprint #5 - Coordinator Report (2026-04-29)

## TL;DR

Two of three issues shipped sequentially with chrome-devtools visual gates and
`bin/rake test:critical` clean. Issue 2 (site-wide brand link color) deferred
after live audit revealed the proposed `:where()` rule has zero effective reach
- per-bundle `a { color: #1a8cff }` rules win on every selector except footer
links (which would not have benefited from the change anyway, dark background).

| Issue | Result | Commit |
|---|---|---|
| 1. /about-us/ logo misalignment | Shipped | `65ca72c82` |
| 2. Inline-link `#0066d6` site-wide | Deferred | - |
| 3. Service worker cache strategy | Shipped | `091352831` |

`bin/rake test:critical`: **42 runs / 116 assertions / 0 failures / 84
screenshots compared / 0 diffs** before and after each shipped change.

## Issue 1 - Logo alignment - SHIPPED 65ca72c82

**Root cause** (took ~10 evaluate_script calls to isolate): about-us bundle
loads `critical/base.css`, NOT `critical/about-us-critical.css` or
`vendors/base-4.min.css`, so it lacks the global `svg { vertical-align: middle }`
reset every other bundle has. The inline SVG logo inherited
`vertical-align: baseline`, leaving 7px of descender below it. The flex-centered
`.content` wrapper grew accordingly and pushed the SVG up 3.5px.

**Fix**: 11 lines in `themes/beaver/assets/css/navigation.css` (already inlined
site-wide). Force `display: block; width: 100%` on `.top-panel .logo svg, img`.
After: logo top = 38.875px on /about-us/ (was 35.375px) - identical to /clients/.

**Visual gate**: side-by-side screenshots, Y-coordinate match within 0.001px.

## Issue 2 - Site-wide brand link color - DEFERRED

**Why**: The brief's `:where(a):not(...)` rule was placed in navigation.css
(inlined first). Per-bundle stylesheets load AFTER and define `a { color: #1a8cff }`
at specificity (0,0,1) which beats `:where()` at (0,0,0). Live test on /, /services/,
/about-us/ confirmed body content links were unchanged - only footer links (no
`a` rule overriding) picked up the new color. That's the inverse of the goal.

The rule defeats itself: to actually promote site-wide brand color requires
removing the `a { color: #1a8cff }` rules from every bundle (5 files), which is
a Sprint #6+ refactor, not a P1 polish.

**Action**: rolled back the change before commit. No partial ship.

## Issue 3 - Service worker - SHIPPED 091352831

**Three combined fixes** (sw.js was 38 lines, all relevant):

1. baseof.html: skip `serviceWorker.register` on `localhost`/`127.*`/`0.0.0.0`,
   AND unregister any previously installed SW on those hosts. Cache-bust the
   registration URL with `?v={{ now.Unix }}`.
2. sw.js: bump `CACHE_NAME` to `jetthoughts-v2`, add `skipWaiting()` in install
   and `clients.claim()` + drop-old-caches in activate. Old caches purge on
   first activation.
3. sw.js: switch HTML navigation requests to network-first (cached page is the
   offline fallback). JS/CSS stay cache-first since they're hashed-immutable.

**Verification**: chrome-devtools on `localhost:1313/` showed `registrations: 0,
controller: null` after reload. Zero console errors. `curl /sw.js` returned the
new content. Build URL renders `?v=1777576445`.

## Hugo build status

`bin/rake test:critical` passed cleanly twice (one transient flake on first run
of issue 3, gone on retry - unrelated to SW changes). 84 screenshots compared
across desktop + mobile, zero diffs. Site builds and serves without errors.

## Drift remaining

- Inline link color drift (Issue 2) needs a Sprint #6 task: extract the
  `a { color: #1a8cff }` rule from each per-bundle CSS file and replace with
  one shared rule (probably in components.css after the bundle CSS loads, or
  via a `!important` brand override in navigation.css).
- About-us is still on `critical/base.css` instead of `critical/about-us-critical.css`
  (the about-us-critical file exists in repo but isn't loaded by `page/about.html`).
  The logo fix solves the user-flagged symptom; broader bundle alignment is
  Sprint #6 work.
