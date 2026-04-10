# Flow Router (Auto-Discovery)

Read this at session start to route tasks to the right workflow without explicit user notice.

## Routing Rules
- Content creation or edits → `@docs/workflows/blog-pipeline.md` (mandatory)
- Cover image work → `docs/workflows/cover-images.md` and `.stitch/design.md`
- Image/cover requests (even without content) → `@docs/workflows/cover-images.md` and `@.stitch/design.md`
- HTML/CSS changes → `@docs/workflows/css-consolidation.md`
- Ruby/Rails changes → `@docs/workflows/ruby.md`
- AI configuration, agents, skills → `@docs/workflows/ai-config.md`

Rule: Prefer skills for execution; use agents only when explicitly required.
