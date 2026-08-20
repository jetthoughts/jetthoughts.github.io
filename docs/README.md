# JT_Site Documentation Hub

## 🗂 Structure (Johnny Decimal — where a doc LIVES; routing rule in CLAUDE.md)

| Area | Contents |
|---|---|
| `10-19-core-development/` … `90-99-content-strategy/` | Engineering/tech reference by domain (testing in `20-29-testing-qa/`, PM in `60-69-project-management/`, content in `90-99-content-strategy/`) |
| `adr/` · `incidents/` · `design-system/` | Decisions · postmortems · design tokens |
| `business/` | Company OS, vision, opportunity portfolio — the company layer ([`business/index.md`](business/index.md)) |
| `projects/<YYMM-slug>/` | One folder per initiative (own JD sub-tree; superseded material under its `70-79-archives/`) |
| `workflows/` | ONLY cross-cutting pipeline how-tos (blog/linkedin pipelines, flow-router, BASE_HANDBOOK) — not a catch-all |

New docs go into the matching area with `NN.NN-name-{reference|tutorial|how-to}.md` naming — never loose at `docs/` root.

## 🎯 Authority

1. **`CLAUDE.md`** — the always-loaded policy file; its Critical Files table and behavioral constraints govern.
2. **`docs/`** — this tree: project reference, plans of record, and the business layer.
3. **`.okf/`** — the distilled operational-knowledge bundle (consume via the `/okf:okf` skill; `index.md` first).

*(Historical note, 2026-08-08: this file previously declared a `/knowledge/` "SUPREME AUTHORITY" inherited via symlink, plus cross-project references to `/projects/elital_*`. That symlink resolves only on Paul's host machine and the cross-project paths never existed in this repo — every rule that depended on them was unenforceable in container/CI sessions and has been removed. Host-only resources must never be load-bearing for repo policy.)*

## 🔍 Research Protocol

Markdown (docs/, content/, .okf/) → `qmd` first (collection `jt-site`); code (templates/CSS/Ruby) → claude-context MCP at the current repo root; exact filenames/slugs → `rg`/`ls`. Full protocol + examples: CLAUDE.md §Research Protocol.

## 📝 Before creating a new doc

1. Search first (qmd / Grep) — can an existing file take the change?
2. Pick the area by CLAUDE.md's routing rule; check the area's `README.md` for the next free `NN.NN` number.
3. Name it `NN.NN-descriptive-name-{reference|tutorial|how-to}.md` (Diátaxis type suffix).
4. Never create `*_new.*`, `*_refactored.*`, `*_v2.*`, `*_copy.*` variants.

## 🛠️ Tech stack (orientation)

Hugo static site (`bin/hugo-build`) · PostCSS pipeline · vanilla JS (minimal) · Ruby test infra (Minitest + Capybara + snap_diff screenshot comparison) · GitHub Actions CI.

## 🚀 Fresh-session entry points

- **Any task**: `docs/workflows/BASE_HANDBOOK.md` + `docs/workflows/flow-router.md`
- **Outbound/sales/pipeline**: vault `~/Documents/pkm/jt-vcr-runbook.md` ▶ START HERE (moved 2026-08-20; campaign artifacts stay in `docs/projects/2607-vibe-code-rescue/`)
- **Company numbers**: vault `~/Documents/pkm/jt-operations.md` §1 (host-only)
- **Content**: `docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md` (check its P0 gate first)

---

**Last Updated**: 2026-08-08 — phantom-authority layer removed; hub rewritten lean.
