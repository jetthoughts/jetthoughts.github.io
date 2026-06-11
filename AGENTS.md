# AGENTS.md — JetThoughts Blog

Canonical instructions live in `CLAUDE.md`. Read that first.
Session start: always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

**ICP (MANDATORY for content/design/marketing work):** Read `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` before writing blog posts, designing pages, planning content, or creating marketing materials. Target audience: non-technical founder burned by a devshop.

**Voice (MANDATORY when writing):** Read `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`.
- **Founder posts**: Rob Walling directness + Rand Fishkin vulnerability. Plain English, empathy, specific numbers.
- **Tech posts**: Thoughtbot style. Open with tension not features. Own opinions. Code as narrative evidence. Honest tradeoffs.
- Run the stream-specific self-test checklist before publishing.

**Finding posts to reference (MANDATORY when writing blog posts):** Use claude-context MCP search first: `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "topic keywords"`. For tag/slug lookups see `docs/blog-post-index.md`. Never guess slugs — verify with `ls content/blog/<slug>/index.md`.

Workflow references:
- `docs/workflows/css-consolidation.md`
- `docs/workflows/blog-pipeline.md`
- `docs/workflows/cover-images.md` (canonical spec in `.stitch/design.md`)
- `docs/workflows/commands.md`
- `docs/workflows/agents.md`

## Projects

Projects live in `docs/projects/<project-id>/`. Each project follows a standard
onboarding path:

**First visit — read in this order:**
1. `PROJECT-INDEX.md` — navigation hub, agent routes, integration rules
2. `GOAL-AT-A-GLANCE.md` — one-page exec summary, strategy, metrics
3. `.agent/prd/PRD.md` — formal spec (if PRD-driven project)
4. `.agent/tasks.json` — machine-readable task graph (if PRD-driven)
5. `TASK-TRACKER.md` — live task queue, migration schedule, active phase

**Project health:** `.agent/STATUS.md` — cross-project RAG dashboard.
Per-project PM health reports in `40-49-review/40.10-*.md`.

**Skills:** Project-specific skills in `.skills/`. Global skills loaded via
`skill` tool.

**Key commands:**
- `bin/hugo-build`
- `bin/rake test:critical`
- `bin/validate-course` (course projects only)

<!-- lean-ctx-compression -->
OUTPUT STYLE: concise-default
- Default: short replies (1-3 sentences or bullet list).
- Expand only when user requests details or task requires explanation.
- No preamble, no filler, no recaps unless asked.
- Code blocks: untouched (never compress code syntax).
- Each line: max 80 chars.
<!-- /lean-ctx-compression -->
