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

Course skills (loaded automatically):
- `.skills/course-lesson-write/` — `/course-lesson-write` — draft 8-part micro-lesson
- `.skills/course-lesson-review-sam/` — `/course-lesson-review-sam` — Sam-perspective review
- `.skills/course-lesson-validate/` — `/course-lesson-validate` — mechanical pre-commit QA
- `.skills/course-svg-draft/` — `/course-svg-draft` — JT-brand hand-drawn SVG
- `.skills/course-skills-map.md` — full phase-by-phase skills map (7 phases, 30+ global skills)

Critical global skills for this course (Phase 1-2, invoke now):
- `course-designer` — learning objectives, Bloom's taxonomy, module-level outcomes
- `customer-research` — mine Reddit/G2 for Sam's pain language
- `customer-journey-map` — map Sam's emotional arc through all 5 modules
- `problem-statement` — sharpen course promise, Quickstart framing
- `copy-editing` — voice consistency across migrated v1 chapters
- `humanizer` + `slop-detector` — final AI-tell polish pass

Phase 3+ skills (SEO, landing page, distribution, growth): see `.skills/course-skills-map.md`.

Key commands:
- `bin/hugo-build`
- `bin/rake test:critical`

<!-- lean-ctx-compression -->
OUTPUT STYLE: concise-default
- Default: short replies (1-3 sentences or bullet list).
- Expand only when user requests details or task requires explanation.
- No preamble, no filler, no recaps unless asked.
- Code blocks: untouched (never compress code syntax).
- Each line: max 80 chars.
<!-- /lean-ctx-compression -->
