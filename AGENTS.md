# AGENTS.md — JetThoughts Blog

Canonical instructions live in `CLAUDE.md`. Read that first.
Session start: always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

**ICP (MANDATORY for content/design/marketing work):** Read `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` before writing blog posts, designing pages, planning content, or creating marketing materials. Target audience: non-technical founder burned by a devshop. Tone: plain English, empathy first, specific data over vague claims.

**Finding posts to reference (MANDATORY when writing blog posts):** Use claude-context MCP search first: `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "topic keywords"`. For tag/slug lookups see `docs/blog-post-index.md`. Never guess slugs — verify with `ls content/blog/<slug>/index.md`.

Workflow references:
- `docs/workflows/css-consolidation.md`
- `docs/workflows/blog-pipeline.md`
- `docs/workflows/cover-images.md` (canonical spec in `.stitch/design.md`)
- `docs/workflows/commands.md`
- `docs/workflows/agents.md`

Key commands:
- `bin/hugo-build`
- `bin/rake test:critical`
