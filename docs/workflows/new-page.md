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
| Info card (pp-infobox) | `<div class="fl-module fl-module-pp-infobox jt-info-card <name>-card <name>-card-x">` + pp-infobox markup (copy one instance from `page/services.html`) | `components/info-card.css` |
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
bun run lint:css           # stylelint the hand-maintained layer
bin/qtest <name>          # fast scoped gate (build + screenshots + guards)
bin/rake test:critical    # before commit
bin/test && bin/dtest     # both platforms before the PR
```

FORCE_SCREENSHOT_UPDATE=true regenerates baselines (commit macos/ AND
linux/ together). A failing screenshot run overwrites baselines — restore
via `git checkout -- test/fixtures/screenshots` before rerunning.

## 8. Design pipeline — impeccable as the engine, everything else as extensions (proven on vibe-code-rescue, 2026-07-26)

For any conversion/marketing page, **impeccable owns the design lifecycle**; the repo toolchain plugs in around it. Run in this order:

### 8a. The impeccable spine

| Stage | Command | What it produces |
|---|---|---|
| Product truth (once per repo) | `/impeccable init` | `PRODUCT.md` — distilled from ICP 90.10 + offer docs, confirmed with Paul (users, success event, evidence policy). Never invent; every claim traces to canon. |
| Design authority (once, refresh on drift) | `/impeccable document` | `DESIGN.md` (frontmatter tokens are NORMATIVE) + `.impeccable/design.json` sidecar. Captures BOTH layers: JetVelocity brand world + legacy light chrome, with named rules (Ruby Ink, One-Gradient-Word, two-worlds). |
| Surface brief | `/impeccable shape <page>` | Persuade-mode brief; section order comes from the copy source doc, not invented. |
| Build | craft-floor loaded → write layout+CSS | The design detector hook auto-runs on every UI edit — treat it as the inner review loop (it drove 21→5 findings on the first page). |
| Iterate | `/impeccable live` (dev server) | In-browser element variants — the "canvas iteration" loop. |
| Consolidate | `/impeccable extract` | Promote tokens/components used **3+ times with same intent** into `foundations/css-variables.css` / `components/`. One page's patterns stay page-local — premature abstraction is worse than duplication. |
| Evaluate | `/impeccable critique` + `/impeccable audit` | Scored design review + a11y/perf/responsive checks before the PR. |

**Detector disposition protocol**: every hook finding gets classified, never ignored silently. (a) Real drift → fix BOTH sides: align the page AND document the deliberate addition in DESIGN.md (ramp steps, new colors) — the detector validates against DESIGN.md frontmatter, so documenting IS the fix. (b) Committed-world signature (gradient hero word, chip left-borders, grid-dot texture, Space Grotesk) → leave the code, state the pinning rule, get Paul's explicit confirmation before persisting a config ignore.

### 8b. Extensions around the spine

| Phase | Tool | Role |
|---|---|---|
| Scaffold | `hugo` skill + §1-7 above | fl-shell, bundle slice, purge prefix, qtest map, tests |
| Copy | source doc verbatim + `copywriting` | copy NEVER rewritten; copywriting only for CTA labels/meta |
| Implementation discipline | `ponytail` (auto-enforced globally) | reuse-first ladder, no new deps, minimal diff |
| Second opinion | `frontend-design` skill | anti-generic-UI pass when the design feels safe |
| Render verification | `chrome-devtools` MCP on `_dest/public-dev` (static server) | console zero-errors, network zero-404s, screenshots 1280×800 + 390×844, **drive interactive states** — open the mobile drawer, hover the CTA; closed-state screenshots miss real bugs (white-drawer incident) |
| Fast feedback loop | `bin/qtest <name>` after each change | Paul's preference: qtest for iteration speed; full `bin/test` + `bin/dtest` reserved for pre-PR |
| Perf | `agent-skills:webperf` / lighthouse | mobile CWV green (the ICP arrives on a phone) |
| Pre-PR review | `/ponytail-review` + `/code-review` | over-engineering delete-list + correctness on the diff |
| Ship | ONE PR, screenshots + 4-criteria scores in description | never direct-to-master for template/CSS |

Known trap: Stitch MCP `generate_screen_from_text` dies at the ~60s timeout — author HTML locally from `.stitch/design.md`, never generate screens via the MCP.

### Dark (JetVelocity brand-surface) page traps — learned on vibe-code-rescue, 2026-07-26

1. **White-wash override**: `legacy-theme-skin.css` paints `.fl-page-content` white AFTER your page slice — any section without its own background falls to white. Fix: `#fl-main-content.<your-page-class> { background: var(--color-obsidian) }` (id+class wins).
2. **Site chrome sits OUTSIDE your page div** — page-scoped custom props don't resolve on the header. Brand-surface tokens now live at `:root` (`foundations/css-variables.css`: `--color-obsidian*`, `--color-neon-purple`, `--color-on-dark`, `--color-label-dark`, `--color-ruby-hover`) — use those, never page-scoped vars, for `.top-panel` overrides.
3. **The `:not()`-chain anchor rule** (navigation.css, `#0066d6`) out-specifies normal page selectors — CTA/link recolors on dark pages need `!important` (repo precedent: navigation.css ruby buttons).
4. **The mobile drawer is a WHITE panel** (`.navigation.-open`): if you lighten `.top-panel a.link` for a dark header, restore `var(--color-dark)` inside the open drawer — and VERIFY by actually opening the menu at 390×844; closed-state screenshots can't see it.

- **Heroes**: cross-page intersection is 1 trivial rule - heroes are
  page-unique by design. Build yours under `.<name>-hero` with tokens;
  copy the closest existing hero as a starting point.
- **Stat/counter rows**: pages structure them differently (per-stat
  classes vs one shared class) - no forced component. Recipe: a col per
  stat, `jt-counter-number` on the number (JS hook), label below, all
  styled under your page prefix.

## Card class tiers

`jt-info-card <page>-card <instance>` - global 16-rule core (component)
-> page core (in pages/<name>.css) -> instance tweaks. Copy an instance
from page/services.html; the starter template shows the shape
(themes/beaver/layouts/page/starter-example.html.txt).
