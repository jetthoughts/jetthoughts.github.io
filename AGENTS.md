# AGENTS.md — JetThoughts Blog

Canonical instructions live in `CLAUDE.md`. Read that first.
Session start: always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

**Async-first communication (SOP for ALL agents):** written, discoverable artifacts are the default for every decision, finding, status change, and handoff — sync interaction is the exception and its outcome gets written back same-day. Full rules + canonical surfaces table: `.agents/skills/async-first-communication/SKILL.md`. A task is not done until its state is readable asynchronously. **Cold-start surface: `STATUS.md` at repo root** (goals + WIP + blockers, links only) — a session that changed what's in flight updates it in the same commit/PR, or the session is not done.

**Four eyes on every stage, author != verifier (SOP for ALL agents):** the point is agents collaborating to find the TRUTH — a single agent cannot find its own blind spot, because it checks the thing it MEANT to build. Every change is **written by one sub-agent and verified by a different one**; the author never produces the evidence for its own claim. The review lands before the artifact leaves the workshop: a plan is peer-reviewed BEFORE the user is asked, a diff BEFORE commit, a finding is reproduced before it is reported, a measurement re-derived before it is quoted. Brief reviewers with the goal and the artifact, never your conclusions; ask for measurements, not verdicts. Routing: internal sub-agents for every per-stage review, `/codex:review` ONCE at the final verify before merge for USER-FACING changes (it is slow — never in the inner loop); docs-only and instruction-layer changes ship on internal review + CI and apply its findings as a follow-up. No reviewer tooling in this runtime? Fall back agent → external → peer session → human, and mark the change UNREVIEWED if none is reachable. Full protocol: the `jt-delivery:contract` skill (plugin `jt-delivery@jetthoughts`); repo bindings: `docs/workflows/autonomous-delivery-prompt.md`.

**Session memory (ruflo-first, SOP for ALL agents):** search ruflo memory (`mcp__ruflo__memory_search`, MCP path) before non-obvious decisions; store decisions/corrections via `mcp__ruflo__memory_store` as they land. Details + prefix conventions: `CLAUDE.md` §Memory.

**OKF maintenance (ENFORCED, parallel by default):** durable learnings (canon numbers, root causes, workflow gotchas) go into `.okf/` — dispatch an okf-maintainer in parallel with the main work, not after it; the bundle update rides the same commit as the change. Weekly scheduled maintain pass back-fills misses. See CLAUDE.md OKF section for the full rule.

<skills>
- `.agents/skills/async-first-communication/SKILL.md` — async-first knowledge sharing SOP (default for ALL work)
- `.agents/skills/kanban-md/SKILL.md` — kanban-md CLI usage (note: no shared board currently exists; 2607's card registry is `docs/projects/2607-vibe-code-rescue/backlog.md` §State)
</skills>

**ICP (MANDATORY for content/design/marketing work):** Read `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` before writing blog posts, designing pages, planning content, or creating marketing materials. Target audience: non-technical founder burned by a devshop.

**Voice (MANDATORY when writing):** Read `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`.
- **Founder posts**: Rob Walling directness + Rand Fishkin vulnerability. Plain English, empathy, specific numbers.
- **Tech posts**: Thoughtbot style. Open with tension not features. Own opinions. Code as narrative evidence. Honest tradeoffs.
- Run the stream-specific self-test checklist before publishing.

**Finding posts to reference (MANDATORY when writing blog posts):** Use claude-context MCP search first: `Search the codebase at <repo root> for: "topic keywords"` (current checkout root via `git rev-parse --show-toplevel`; never a hardcoded machine path). For tag/slug lookups see `docs/blog-post-index.md`. Never guess slugs — verify with `ls content/blog/<slug>/index.md`.

Workflow references:
- `docs/workflows/css-consolidation.md`
- `docs/workflows/blog-pipeline.md`
- `docs/workflows/cover-images.md` (canonical spec in `.stitch/design.md`)
- `docs/workflows/agents.md`

## Business & operations (company layer)

**The vault (`~/Documents/pkm`) owns ALL operations** (Paul, 2026-08-20): identity, positioning, bet status (`jt-business-os`), the weekly loop / OKR / rocks (`jt-operations`), pipeline numbers (`jt-vcr-pipeline`), and the 2607 runbook + assumptions (`jt-vcr-runbook`, `jt-vcr-assumptions`). This repo is growth/marketing campaigns only; `docs/business/` and the 2607 operational files are pointer stubs. Company FACTS (founding date, tenure, ratings) stay canon in `.okf/content/claims-canon.md` regardless — never copy a company number from a vault note into published copy.
- **Right now no bet is Validating: 2607 Vibe Code Rescue is Parked until Sep 2026** (vault `jt-vibe-code-rescue`).
- The vault is host-only; in container/CI sessions treat operations as out of scope — the repo's campaign work is self-contained.

Any outbound/sales/pipeline task starts from that runbook, not from memory.

## Projects

Projects live in `docs/projects/<project-id>/`. Each project follows a standard
onboarding path:

**First visit — read in this order:**
1. `STATUS.md` (repo root) — cross-project view: what's in flight, goals, blockers
2. The project's `README.md` or `GOAL-AT-A-GLANCE.md` — one-page status / exec summary (2608's README is the template: status paragraph, read-order table, open decisions, known reds)
3. `TASK-TRACKER.md` or `backlog.md` — live task queue, active phase

(The former `.agent/STATUS.md` / `.agent/prd/PRD.md` / `.agent/tasks.json` stack never existed in this repo — removed 2026-08-22; root `STATUS.md` is the cross-project dashboard.)

**Skills:** Project-specific skills in `.skills/`. Global skills loaded via
`skill` tool.

**Key commands:**
- `bin/hugo-build`
- `bin/qtest --changed` (routine gate; `bin/rake test:critical` at milestones; `bin/test`+`bin/dtest` at PR prep only)
- `bin/validate-course` (course projects only)

<!-- lean-ctx-compression -->
OUTPUT STYLE: concise-default
- Default: short replies (1-3 sentences or bullet list).
- Expand only when user requests details or task requires explanation.
- No preamble, no filler, no recaps unless asked.
- Code blocks: untouched (never compress code syntax).
- Each line: max 80 chars.
<!-- /lean-ctx-compression -->

---

*(Removed 2026-08-08: 545 lines of vendored Memoria memory-tool documentation — the memory MCP server is not configured in this repo, so every `memory_*` tool those instructions mandated was unavailable. If Memoria is ever wired up via `.mcp.json`, restore its docs from git history or the Memoria distribution, not by hand.)*
