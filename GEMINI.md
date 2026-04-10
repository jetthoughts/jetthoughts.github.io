# GEMINI.md — JetThoughts Blog

Canonical instructions live in `CLAUDE.md`. Read that first.
Session start: always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

**ICP (MANDATORY for content/design/marketing):** Read `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` before any content or design work. Target: non-technical founder burned by a devshop. Plain English, empathy first, specific data.

**Finding posts to reference:** Use claude-context MCP search: `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "topic"`. Tag/slug index: `docs/blog-post-index.md`. Verify slugs: `ls content/blog/<slug>/index.md`.

Workflow references:
- `docs/workflows/css-consolidation.md`
- `docs/workflows/blog-pipeline.md`
- `docs/workflows/cover-images.md` (canonical spec in `.stitch/design.md`)
- `docs/workflows/commands.md`
- `docs/workflows/agents.md`

Key commands:
- `bin/hugo-build`
- `bin/rake test:critical`
