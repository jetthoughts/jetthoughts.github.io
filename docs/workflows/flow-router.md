# Flow Router (Auto-Discovery)

Read this at session start to route tasks to the right workflow without explicit user notice.

## Routing Rules
- **Outbound / sales / pipeline / prospect / discovery-call work (2607)** → vault `~/Documents/pkm/jt-vcr-runbook.md` **▶ START HERE** (moved 2026-08-20; bet PARKED until Sep 2026; campaign artifacts stay in `docs/projects/2607-vibe-code-rescue/`)
- **Weekly loop (goal, OKR, rocks, weekly numbers)** → vault `~/Documents/pkm/jt-operations.md` (moved 2026-08-20; vault = operations, repo = growth/marketing). Host-only — out of scope in container/CI sessions.
- **Identity, positioning, bet status** → the vault note `jt-business-os` (`~/Documents/pkm`) FIRST, then reflect into the `docs/business/` mirror
- LinkedIn post creation or edits, especially `linkedin-posts/**` → `@docs/workflows/linkedin-post-pipeline.md` (it routes to the active campaign plan — check the campaign's status banner; the ICP campaign is currently PAUSED)
- Content creation or edits → `@docs/workflows/blog-pipeline.md` (mandatory; its P0 gate can halt content entirely)
- Cover image work → `docs/workflows/cover-images.md` and `.stitch/design.md`
- Image/cover requests (even without content) → `@docs/workflows/cover-images.md` and `@.stitch/design.md`
- HTML/CSS changes → `@docs/workflows/css-consolidation.md`
- **Design review of a page or visual change → `/stitch-design`** (Paul,
  2026-08-21). Name the design source for the surface FIRST — loading the wrong
  one inverts the verdict:
  - Site chrome and pages → `.okf/design/site-palette.md`. **Light is the
    DEFAULT, not a monopoly.** Three surfaces are dark *by design* and must not
    be flagged for recolour: blog cover art, ONE dark proof band per page, and
    `/services/vibe-code-rescue/` (a dark variant of the same tokens, not a
    second system). Anything else going dark IS a defect.
  - Blog COVER images → `.stitch/design.md` (the dark "Obsidian Engine").
    Reviewing a *page* against this yields the recolour ADR-0003 rules out.
  - Course pages → `.stitch/course-taste-design.md`.
  - In-post SVG, Mermaid diagrams, LinkedIn exhibits →
    `.okf/design/house-visual-spec.md` (hand-drawn style, semantic colour —
    green = money ONLY, labels inside shapes); social assets also
    `linkedin-posts/README.md`.

  Stitch complements the rendered gates rather than replacing them: baselines
  check what SHIPPED, stitch checks what was INTENDED. Rule detail in
  `.okf/workflows/review-swarm.md` — note its surrounding loop (content-canon
  critic, taste pass) is COURSE-scoped; for site and blog surfaces take the
  stitch step and the render gate, not the course-canon steps.
- Ruby/Rails changes → `@docs/workflows/ruby.md`
- AI configuration, agents, skills → `@docs/workflows/ai-config.md`

Rule: Prefer skills for execution; use agents only when explicitly required by the user or by the selected workflow.
