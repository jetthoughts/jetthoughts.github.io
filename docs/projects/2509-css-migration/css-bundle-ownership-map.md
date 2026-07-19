# CSS bundle ownership map + FL burn-down

Answers "which pages does this CSS file affect?" for every bundle and file.
Original sizes measured 2026-07-12, final sizes 2026-07-17, both from converged
production builds (`gzip -c | wc -c`). Update this map whenever a resource
slice changes (see `2026-07-12-css-maintainability-redesign.md`).

## External bundles (19)

Each page type loads ONE fingerprinted bundle, built by concatenating its
template's resource slice through PostCSS (per-bundle PurgeCSS — a page ships
only its own subset; see the evidence rule in the redesign spec).

Every bundle's page CSS now lives in a hand-maintained `css/pages/*.css` file;
zero FL-Builder export files remain in any slice.

| Bundle | Owning template | Page CSS file | gzip 07-12 → 07-17 | Status |
|---|---|---|---|---|
| homepage | `home.html` (partial `homepage-css-resources.html`) | pages/homepage.css | 29.6K → 26.6K | migrated (R9) |
| services | `page/services.html` | pages/services.css | 25.4K → 19.9K | migrated (R8c) |
| single-client | `clients/single.html` | pages/single-client.css | 25.4K → 16.6K | migrated (R3c) |
| use-cases | `page/use-cases.html` | pages/use-cases.css | 25.0K → 17.0K | migrated (R7) |
| single-service | `services/single.html` | pages/single-service.css | 23.8K → 19.1K | migrated (R8b) |
| clients | `page/clients.html` | pages/clients.css | 23.6K → 18.7K | migrated (R8a) |
| careers | `page/careers.html` (partial `careers-css-resources.html`) | pages/careers.css | 23.4K → 23.8K¹ | migrated (R6) |
| single-use-cases | `use-cases/single.html` | pages/single-use-cases.css | 23.3K → 18.8K | migrated (R7) |
| single-career | `careers/single.html` (partial `single-career-css-resources.html`) | pages/single-career.css | 22.0K → 18.8K | migrated (R3d) |
| free-consultation | `page/free-consultation.html` (partial `free-consultation-css-resources.html`) | pages/free-consultation.css | 20.2K → 16.2K | migrated (R4b) |
| about-us | `page/about.html` | pages/about-us.css | 19.4K → 15.0K | migrated (R5) |
| course-single | `course/single.html` | pages/blog-single.css (shared) | 19.3K → 12.9K | migrated (R3b) |
| blog-single | `single.html` | pages/blog-single.css | 19.3K → 12.9K | migrated (R3a) |
| blog-list | `blog/list.html` + `list.html` (shared partial `blog-list-css-resources.html`) | pages/blog-list.css | 19.1K → 15.0K | migrated (R4a) |
| contact-us | `page/contact-us.html` (partial `contact-us-css-resources.html`) | pages/contact-us.css | 18.9K → 17.4K | migrated (R2) |
| course-list | `layouts/course/list.html` (repo root, NOT in theme) | pages/course-list.css | 17.6K → 14.6K² | migrated (R1) |
| privacy-policy | `page/single.html` (generic pages) | pages/simple-page.css | 17.1K → 14.6K | migrated (R1) |
| not_found | `404.html` | — (404.css, dynamic-404-590.css) | 16.2K → 16.2K | no-FL |
| pagination | `list.html` (second bundle) | — (pagination.css only) | 0.2K → 0.2K | no-FL |

¹ careers was a byte-identical verbatim move (3086-layout2 had zero dead
nodes); the small growth vs 07-12 is upstream content drift (course v2 merge
enlarged shared members), not the migration.
² course-list also absorbed upstream growth; its migration delta at R1 time
was 17.6K → 14.2K.

Inline bundles (in `<head>` via `css-inline.html`, baseof.html): `navigation`
(css-variables + navigation.css, site-wide) and `components` (components.css,
site-wide). Not FL-affected.

Shared non-FL slice members loaded by most bundles: `critical/base.css` (pulls
the critical/fl-* trio), `dynamic-icons.css`, `586.css`, `vendors/base-4.min.css`,
`style.css`, `skin-65eda28877e04.css`, `footer.css`, plus per-page extras
(`technologies.css`, `single-post.css`, `use-cases-dynamic.css`, `homepage.css`,
`companies.css`, `careers.css`, `404.css`, `pagination.css`,
`component-bundle.css`, `theme-main.css`).

### Shared components (Phase C sprint C1, 2026-07-19)

Extracted from the byte-identical shared-partial copies the delta ports left
in sibling page files; wired as concat-slice members directly before each
consumer's `pages/*.css` entry (NOT `@import` — postcss-import silently skips
post-prelude imports; only `critical/base.css` is prelude):

| Component | Rules | Consumers |
|---|---|---|
| `components/testimonials.css` | 133 | about-us, clients, services, homepage, single-use-cases, single-service, use-cases |
| `components/cta-banner.css` | 10 | about-us, homepage, services, single-service, single-use-cases, use-cases |
| `components/header-cta.css` | 3 | use-cases, clients, services |

Page-specific overrides (spacing variants, homepage swiper sizing, the
rujwd9mzxche pair) stay in the page files — variance log in TASK-TRACKER §C1.

## FL layout file burn-down: 16 → 0 ✅ COMPLETE (2026-07-17)

All 16 generated FL-Builder export files under `themes/beaver/assets/css/`
are retired. Migration technique per file (all at pixel parity — zero
snapdiff baseline changes across the whole run):

| FL file | Lines | Retired by | Technique |
|---|---|---|---|
| 3059-layout.css | 924 | R1 | semantic rewrite (privacy-policy + course-list) |
| 706-layout.css | 2,202 | R2 | semantic rewrite (contact-us) |
| 3114-layout.css | 2,272 | R3a-d | semantic rewrite (blog/course single) + node aliases |
| fb2624e43f3c4277448abe268cde571e-layout-bundle.css | 6,523 | R3c | semantic node aliases (single-client) |
| e966db44b09892b8d7d492247c67e86c-layout-bundle.css | 4,364 | R3d | delta port (single-career) |
| homepage-layout.css | 2,678 | R4a+R4b | semantic rewrite (blog-list) + clone (free-consultation) |
| services-layout.css | 1,678 | R4a+R4b | (same two consumers) |
| 701-layout.css | 4,462 | R5 | delta port, dead-node prune (about-us) |
| 3086-layout2.css | 5,157 | R6 | verbatim move, byte-identical bundle (careers) |
| 3021-layout.css | 6,409 | R7 | delta port, 58 dead nodes pruned (use-cases) |
| 3027-layout.css | 5,056 | R7 | delta port, 14 dead nodes pruned (single-use-cases) |
| 3082-layout.css | 5,399 | R8a | delta port, 35 dead nodes pruned (clients) |
| 2949-layout.css | 5,407 | R8b | delta port, 26 dead nodes pruned (single-service) |
| 737-layout.css | 6,489 | R8c | delta port, 41 dead nodes pruned (services) |
| bf72bba397177a0376baed325bffdc75-layout-bundle.css | 1,969 | R5–R8c | dropped per consumer slice; deleted at R8c (last consumer: services). Its only live contribution (header CTA button, 3 rules) ported into use-cases/clients/services page files; about/single-service criticals carried byte-identical copies |
| 590-layout.css | 12,437 | R9 | delta port, 47 dead nodes pruned (homepage) |

Satellites: `utilities/fl-builder-grid.css` deleted with homepage-layout.css
(R4b). `foundations/fl-builder-common-base.css` KEPT — now imported by
pages/use-cases.css; its content is NOT byte-redundant in the compiled bundle
(deletion attempt changed the fingerprint, reverted). The `critical/` FL trio
(`fl-layout-grid.css`, `fl-shape-dividers.css`, `fl-common-modules.css` via
`critical/base.css`) remains as shared framework for the kept fl-node markup.

**Previously retired**: e93d9b85…-layout-bundle.css (merged into superset
bf72bba…, PR #363, 2026-07-12); 6 never-loaded orphans deleted same PR.

## Follow-ups (not blocking)

**2026-07-18: absorbed into Phase C** (spec revision + TASK-TRACKER PHASE C
section): testimonials/cta/header-cta extraction = sprint C1; fl-node
re-keying = sprints C2/C3 + C4 backlog; the 586.css:823 hardening below =
task C2.5.

- Shared `css/testimonials.css`: the testimonials-partial node rules are now
  carried (identically) inside several pages/*.css files; extracting them once
  is a source-hygiene pass — gate on byte-identical compiled bundles.
- Markup still carries `fl-node-*` classes on pages migrated via delta port
  (Option A). Semantic re-keying per page remains available as separate,
  independently-gated cleanup sprints (the R3c alias technique).
- Code-block fallback background is cascade-order-dependent: for bare/unknown
  fences (no Chroma inline styles) the dark `#282a36` background wins only
  because `style.css .blog pre` sorts after `586.css .single-content pre`
  (equal 0-1-1 specificity) in the blog-single bundle. Hardening = delete the
  losing `background-color:#F5F6F8` from `.single-content pre` (586.css:823)
  — deferred because 586.css is shared by most bundles (fingerprint churn).
  The regression is now screenshot-locked by `test_codeblock_language_styles`
  (fixture post `codeblock-styles-fixture`, bare + indented shots would flip
  to light-bg/invisible-text on a cascade flip).
