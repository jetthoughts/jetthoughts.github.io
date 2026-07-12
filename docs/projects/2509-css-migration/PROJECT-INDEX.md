# CSS Migration Project 2509 - Master Index

**Last Updated**: 2026-07-12
**Project Status**: Phase 0 (safety scaffolding) of the maintainability plan
**Current Goal**: Every style hand-editable, understood, single-source — FL export CSS retired page-by-page (16 files → 0)

---

## 🚀 START HERE

1. **[2026-07-12-css-maintainability-redesign.md](2026-07-12-css-maintainability-redesign.md)** — PRIMARY AUTHORITY.
   The approved plan: goal, success criteria, Phase 0, the per-page rewrite
   protocol, rewrite order, and the evidence rule (validate on compiled+gzip
   per-page payload, never raw source line counts).
2. **[TASK-TRACKER.md](TASK-TRACKER.md)** — live status: Phase 0 items, FL
   burn-down, sprint update log (the full history of how the old plan was
   falsified lives here).
3. **[css-bundle-ownership-map.md](css-bundle-ownership-map.md)** — "which pages
   does this CSS file affect?": 19 bundles × owning template × FL files × gzip,
   plus the 16-file FL burn-down table. Update it whenever a resource slice changes.
4. **[css-loading-order-analysis.md](css-loading-order-analysis.md)** — how each
   template assembles its bundle and why load order matters. Read the supersede
   banner first: its FL-preservation rules predate the strangler plan.

## 🧭 The plan in one paragraph

The original Oct-2025 goal ("eliminate 70-80% CSS duplication, 27,094-31,536
lines" via shared-foundation extraction) was falsified on compiled+gzip
evidence: PurgeCSS runs per bundle, so every page already ships only its own
FL subset, and extraction grows shipped bytes. The replacement plan strangles
the generated FL-Builder CSS instead: Phase 0 adds missing snapdiff coverage
(special-content blog posts: Mermaid, code highlighting, inline styles,
youtube embeds) and an orphan-file guard; then one page per sprint gets a full
rewrite — semantic HTML + one small token-based file under `css/pages/` — with
its FL file deleted in the same PR, every other page proven 0.0-diff on both
suites (`bin/test` + `bin/dtest`), and design improvements per JetVelocity
(`.stitch/design.md`) approved via screenshots.

## 📂 Structure

```
2509-css-migration/
├── 2026-07-12-css-maintainability-redesign.md  # approved spec (authority)
├── TASK-TRACKER.md                             # live status + sprint log
├── css-bundle-ownership-map.md                 # bundle map + FL burn-down
├── css-loading-order-analysis.md               # load-order reference (banner'd)
├── PROJECT-INDEX.md                            # this file
└── 70-79-archives/
    ├── superseded-2026-07-12/                  # the falsified Oct-2025 plan (36 docs + README why)
    ├── 70.01…70.03, HISTORICAL-SPRINT-DATA.md  # earlier archives
    └── legacy-css-migration-data/              # 2025-09 raw metrics
```

## 🚨 Standing constraints

- Gates on every commit: `bin/test` (macOS) AND `bin/dtest` (Linux); baselines
  change only intentionally (`FORCE_SCREENSHOT_UPDATE=true`, both platforms in
  the same commit). No new custom baseline/compare scripts — missing coverage
  is fixed by adding tests.
- One feature branch + ONE bundled PR per sprint; rollback = revert one PR.
- Evidence rule: any size/perf claim is measured on compiled+gzip per-page
  payload. Known build noise: `sw.js?v=` cachebuster, taxonomy term-casing races.
- Production-only pipeline traps (dedup/purge) are documented in the update log
  and in `~/.claude` project memory — dev-server checks cannot catch them.
