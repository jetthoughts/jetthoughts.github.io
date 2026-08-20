# Architecture

* [Hugo Site](hugo-site.md) - Hugo static site setup, theme, build/test commands
* [CSS Build Pipeline](css-pipeline.md) - PostCSS + per-bundle PurgeCSS, the site-wide token layer and its zero-delta promotion pattern, FL-Builder legacy CSS
* [Blog Index / Listing Page](blog-list-page.md) - index AND tag-page templates, the shared row/filter/CTA partials, blog-list CSS bundle, and the term-kind / date-fallback traps
* [Blog Cover Image Pipeline](cover-image-pipeline.md) - JetVelocity cover generation, og:image vs thumbnail rendering, and the responsive mobileWidth/mobileSizes params list covers need
* [Enhanced SEO Meta Tags](seo-meta-tags.md) - per-section title/description generation partial
* [ICP Journey SIPOC](icp-journey-sipoc.md) - pointer: Mermaid flowchart of Sam's full journey through every lesson, gate, branch, and artifact
* [Operational Dependency Map](operational-dependency-map.md) - pointer: per-lesson prerequisites, template blank sources, wait times, Plan B paths

## Pointer Concepts

These two concepts are pointers, not copies (the verbatim snapshots were deleted 2026-08-20 as ~73KB of duplication). Each states the durable rule and where to read the authoritative detail.

| Pointer | Canonical Source |
|---|---|
| `icp-journey-sipoc.md` | `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.05-icp-journey-sipoc.md` |
| `operational-dependency-map.md` | `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.06-operational-dependency-map.md` |
