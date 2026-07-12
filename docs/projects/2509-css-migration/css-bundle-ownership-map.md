# CSS bundle ownership map + FL burn-down

Answers "which pages does this CSS file affect?" for every bundle and file.
Sizes measured 2026-07-12 from a converged production build (`gzip -c | wc -c`).
Update this map whenever a resource slice changes; flip statuses as rewrite
sprints land (see `2026-07-12-css-maintainability-redesign.md`).

## External bundles (19)

Each page type loads ONE fingerprinted bundle, built by concatenating its
template's resource slice through PostCSS (per-bundle PurgeCSS — a page ships
only its own subset; see the evidence rule in the redesign spec).

| Bundle | Owning template | FL layout files in slice | gzip | Status |
|---|---|---|---|---|
| homepage | `home.html` (partial `homepage-css-resources.html`) | 590-layout | 29.6K | live-FL |
| services | `page/services.html` | 737-layout, bf72bba… | 25.4K | live-FL |
| single-client | `clients/single.html` | 3114-layout, fb2624… | 25.4K | live-FL |
| use-cases | `page/use-cases.html` | 3021-layout, bf72bba… | 25.0K | live-FL |
| single-service | `services/single.html` | 2949-layout, bf72bba… | 23.8K | live-FL |
| clients | `page/clients.html` | 3082-layout, bf72bba… | 23.6K | live-FL |
| careers | `page/careers.html` (partial `careers-css-resources.html`) | 3086-layout2 | 23.4K | live-FL |
| single-use-cases | `use-cases/single.html` | 3027-layout, bf72bba… | 23.3K | live-FL |
| single-career | `careers/single.html` (partial `single-career-css-resources.html`) | 3114-layout, e966db44… | 22.0K | live-FL |
| free-consultation | `page/free-consultation.html` (partial `free-consultation-css-resources.html`) | homepage-layout, services-layout | 20.2K | live-FL |
| about-us | `page/about.html` | 701-layout, bf72bba… | 19.4K | live-FL |
| course-single | `course/single.html` | 3114-layout, bf72bba… | 19.3K | live-FL |
| blog-single | `single.html` | 3114-layout, bf72bba… | 19.3K | live-FL |
| blog-list | `blog/list.html` + `list.html` (shared partial `blog-list-css-resources.html`) | homepage-layout, services-layout | 19.1K | live-FL |
| contact-us | `page/contact-us.html` (partial `contact-us-css-resources.html`) | 706-layout | 18.9K | live-FL |
| course-list | `layouts/course/list.html` (repo root, NOT in theme) | 3059-layout, bf72bba… | 17.6K | live-FL |
| privacy-policy | `page/single.html` (generic pages) | 3059-layout, bf72bba… | 17.1K | live-FL |
| not_found | `404.html` | — (404.css, dynamic-404-590.css) | 16.2K | no-FL |
| pagination | `list.html` (second bundle) | — (pagination.css only) | 0.2K | no-FL |

Inline bundles (in `<head>` via `css-inline.html`, baseof.html): `navigation`
(css-variables + navigation.css, site-wide) and `components` (components.css,
site-wide). Not FL-affected.

Shared non-FL slice members loaded by most bundles: `critical/base.css` (pulls
the critical/fl-* trio), `dynamic-icons.css`, `586.css`, `vendors/base-4.min.css`,
`style.css`, `skin-65eda28877e04.css`, `footer.css`, plus per-page extras
(`technologies.css`, `single-post.css`, `use-cases-dynamic.css`, `homepage.css`,
`companies.css`, `careers.css`, `404.css`, `pagination.css`,
`component-bundle.css`, `theme-main.css`).

## FL layout file burn-down: 16 → 0

Generated FL-Builder export CSS under `themes/beaver/assets/css/`. A file is
RETIRED when its last consuming bundle's page is rewritten (semantic HTML +
`css/pages/*.css`) and the file is deleted.

| FL file | Lines | Consumed by bundles | Status |
|---|---|---|---|
| 590-layout.css | 12,437 | homepage | live |
| 737-layout.css | 6,489 | services | live |
| fb2624e43f3c4277448abe268cde571e-layout-bundle.css | 6,523 | single-client | live |
| 3021-layout.css | 6,409 | use-cases | live |
| 2949-layout.css | 5,407 | single-service | live |
| 3082-layout.css | 5,399 | clients | live |
| 3086-layout2.css | 5,157 | careers | live |
| 3027-layout.css | 5,056 | single-use-cases | live |
| 701-layout.css | 4,462 | about-us | live |
| e966db44b09892b8d7d492247c67e86c-layout-bundle.css | 4,364 | single-career | live |
| homepage-layout.css | 2,678 | blog-list, free-consultation | live |
| 3114-layout.css | 2,272 | blog-single, course-single, single-career, single-client | live |
| 706-layout.css | 2,202 | contact-us | live |
| bf72bba397177a0376baed325bffdc75-layout-bundle.css | 1,969 | 9 bundles: about-us, blog-single, clients, course-list, course-single, privacy-policy, services, single-service, single-use-cases, use-cases | live |
| services-layout.css | 1,678 | blog-list, free-consultation | live |
| 3059-layout.css | 924 | course-list, privacy-policy | live |

Satellites that retire with their last importer: `foundations/fl-builder-common-base.css`
(imported only by 3021-layout.css), `utilities/fl-builder-grid.css` (imported only
by homepage-layout.css), and the `critical/` FL trio (`fl-layout-grid.css`,
`fl-shape-dividers.css`, `fl-common-modules.css` via `critical/base.css`).

**Retired so far**: e93d9b85…-layout-bundle.css (merged into superset bf72bba…,
PR #363, 2026-07-12); 6 never-loaded orphans deleted same PR.
