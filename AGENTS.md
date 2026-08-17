# AGENTS.md — JetThoughts Blog

Canonical instructions live in `CLAUDE.md`. Read that first.
Session start: always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

**Async-first communication (SOP for ALL agents):** written, discoverable artifacts are the default for every decision, finding, status change, and handoff — sync interaction is the exception and its outcome gets written back same-day. Full rules + canonical surfaces table: `.agents/skills/async-first-communication/SKILL.md`. A task is not done until its state is readable asynchronously.

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

The company's weekly loop — goal, OKR, rocks, weekly numbers — lives in `docs/business/operating-system.md` and is edited here. **Identity, positioning, and bet status are owned in the vault** (`jt-business-os`, `~/Documents/pkm`); `docs/business/vision-mission.md` and `opportunity-portfolio.md` mirror it, so read the vault note before changing either. Company FACTS (founding date, tenure, ratings) stay canon in `.okf/content/claims-canon.md` regardless.
- `operating-system.md` — the weekly loop; §1 carries this week's real numbers (bound to the 2607 pipeline ledger)
- `opportunity-portfolio.md` — the bets; one is Validating at a time. **Right now none is: 2607 Vibe Code Rescue is Parked until Sep 2026.** Canonical status lives in the vault note `jt-vibe-code-rescue`.
- Execution entry point for 2607 (parked until Sep 2026, resume here): `docs/projects/2607-vibe-code-rescue/operation-runbook.md`

Any outbound/sales/pipeline task starts from that runbook, not from memory.

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
