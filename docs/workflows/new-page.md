# Adding a new page — the paved path

The checklist for building a new page that reuses the shared components and
stays consistent with the design system. Every trap listed here has bitten a
real sprint; do not skip steps.

## 1. Template

Create `themes/beaver/layouts/page/<name>.html`. Start from
`themes/beaver/layouts/page/clients.html` (the cleanest example) and keep the
structural shell:

```
{{ define "header" }}   <- CSS bundle slice (step 2)
{{ define "main" }}
  <div id="fl-main-content" class="fl-page-content" role="main">
    ... fl-row / fl-col-group / fl-col / fl-col-content nesting ...
```

The `fl-*` framework classes are load-bearing (layout grid from
`critical/fl-layout-grid.css`) — keep the nesting; name YOUR elements with a
page prefix (`<name>-hero`, `<name>-grid`, ...). Never introduce hash-like
class names.

## 2. CSS bundle slice

In the template's `header` block, compose the bundle. **Order is
load-bearing** — keep exactly this shape:

```
{{- $resources := slice
  (resources.Get "css/critical/base.css")            <- pure-@import prelude; MUST be first
  (resources.Get "css/components/<used>.css")        <- one line per component you use
  (resources.Get "css/pages/<name>.css")             <- your page CSS
  (resources.Get "css/dynamic-icons.css" | resources.ExecuteAsTemplate "css/dynamic586.css" .)
  (resources.Get "css/586.css")
  (resources.Get "css/vendors/base-4.min.css")
  (resources.Get "css/style.css")
  (resources.Get "css/legacy-theme-skin.css")
  (resources.Get "css/footer.css")
-}}
{{ partialCached "assets/css-processor.html" (dict "resources" $resources "bundleName" "<name>") "<name>" }}
```

TRAPS:
- `@import` only works in `critical/base.css` (the concat prelude). An
  `@import` in `pages/*.css` is silently skipped by postcss-import —
  components join as slice members, never imports.
- `bundleName` must be unique repo-wide (a collision silently races —
  the blog-list/taxonomy incident).

## 3. Reusable components (include partial + add CSS slice line)

| Component | Markup | CSS slice line |
|---|---|---|
| Testimonials section | `{{ partial "page/testimonials.html" . }}` | `components/testimonials.css` |
| CTA banner ("Let's get started now") | `{{ partial "page/cta.html" . }}` | `components/cta-banner.css` |
| Info card (pp-infobox) | `<div class="fl-module fl-module-pp-infobox jt-info-card <name>-card-x">` + pp-infobox markup (copy one instance from `page/services.html`) | `components/info-card.css` |
| Header CTA trio | (only if the page renders the bf72bba header variant) | `components/header-cta.css` |
| Technologies strip | `{{ partial "technologies.html" (dict "colorVariant" "dark") }}` | `technologies.css` |

Page-specific tweaks to a component (spacing, hover colors) go in
`pages/<name>.css` under YOUR page class — they win by concat position.
Never edit `components/*.css` for one page's needs.

## 4. Design tokens

Use the vars from `foundations/css-variables.css` (inlined site-wide):
`--color-ruby` (#cc342d) · `--color-primary` (#1a8cff) · `--color-dark`
(#121212) · `--color-muted` · `--font-system-ui` · `--radius-default` ·
`--spacing-sm/md`. Visual language: `.stitch/design.md` (JetVelocity).

## 5. PurgeCSS greedy prefix (DO NOT SKIP)

Add your page's class prefix to the `greedy` list in `postcss.config.js`
(next to `/^testimonials-/ ...`). Without it, any selector that pairs your
class with a runtime-injected class (swiper, PowerPack `pp-*`) gets purged
in production only — the visible-skip-link class of bug.

## 6. Tests + maps

- Add the page to `PAGE_TESTS` in `bin/qtest` (key = `pages/<name>.css`
  basename → test-name regex).
- Add desktop + mobile screenshot tests
  (`test/system/desktop_site_test.rb` / `mobile_site_test.rb`); anchor on
  visible text, then `assert_stable_screenshot "<name>"`.
- Add the bundle to `docs/projects/2509-css-migration/css-bundle-ownership-map.md`.

## 7. Verify

```
bin/qtest <name>          # fast scoped gate (build + screenshots + guards)
bin/rake test:critical    # before commit
bin/test && bin/dtest     # both platforms before the PR
```

FORCE_SCREENSHOT_UPDATE=true regenerates baselines (commit macos/ AND
linux/ together). A failing screenshot run overwrites baselines — restore
via `git checkout -- test/fixtures/screenshots` before rerunning.
