# Autonomous delivery — repo binding

**The contract itself lives in the `jt-delivery` plugin** (per ADR-0005):
invoke the **`jt-delivery:contract`** skill for the full operating contract —
GOAL/intake (§1–1a), the DISCOVER→LEARN loop (§2), evidence standard (§3),
research order (§4), 4-eyes roles (§5), WIP=1 (§6), async-first (§7),
scope/stopping (§8), learn-every-pass (§9). Kickoff any idea with
**`/deliver <idea>`** (also from the plugin).

Not installed? `claude plugin marketplace add jetthoughts/claude-plugins` then
`claude plugin install jt-delivery@jetthoughts`. Source:
<https://github.com/jetthoughts/claude-plugins>.

**Precedence: THIS repo's instructions override the plugin on every conflict.**
This file carries the repo-specific bindings the generic contract defers to.

---

## Repo bindings — what this repo adds to the contract

### SHIP: the change-class gate matrix (contract §2's SHIP row resolves here)

| Change class | Gate |
|---|---|
| content only — markdown prose/frontmatter, no `themes/`, no `layouts/`, no CSS, no body HTML | `bin/hugo-build` + the rendered scroll gate. **Not** the visual suites. |
| anything touching `themes/`, `layouts/`, `*.css`, or body HTML/SVG | `bin/qtest --changed` before every commit; the full `bin/test` **and** `bin/dtest` pair once at PR prep |
| docs / instruction layer only | `bin/hugo-build`; internal review; the slow external reviewer does not gate the merge; app-build CI auto-skips (publish.yml paths-ignore) |

Check the **actual diff**, not your intent — the class is decided by what the
patch touches. If you cannot name your change class, you are not ready to SHIP.

PR mechanics, all in `CLAUDE.md` in full: branch + PR for everything including
docs · one sprint PR ≤ ~500 changed CODE lines (docs/logs exempt) · rebase
never merge, backup ref first, `--autostash` when unstaged changes block ·
`gh pr merge --auto` does NOT queue here · a PR touching visuals never opens
without the `dtest` leg.

### Contract additions (non-negotiable here, beyond the generic §1a list)

- **Claims-canon + voice gates** on anything customer-facing
  (`.okf/content/claims-canon.md`, voice-guide 90.11, blog-pipeline gates).
- **OKF sync rides the same commit** as the change it describes (CLAUDE.md
  §OKF — ENFORCED).
- **Ruflo memory is §4 step 0 and §9's second store**: `mcp__ruflo__memory_search`
  before non-obvious decisions, `mcp__ruflo__memory_store` for
  decisions/corrections (prefixes + CLI-keyword-only gotcha: `CLAUDE.md`
  §Memory).

### Reviewer routing (contract §5's cost tiers resolve here)

Internal sub-agents (distinct lens per call) for every per-stage review;
**`/codex:review` ONCE at the final verify before merge, for user-facing
changes only** — never in the inner loop. Docs/instruction-layer changes ship
on internal review + local gates; no CI fires on them (path filters — see the
gate table above) and none is waited for (Paul 2026-08-22).

### Where everything else is

- Tool surface (MCP servers, skills, agents, ruflo-first): **Appendix B**.
- Per-domain read-first/route-through map: **Appendix C**.
- The instantiated audit GOAL for instruction surfaces: **Appendix A**.
- Commands, gates, canon, memory rule: `CLAUDE.md` (always loaded).

---
## Appendix A — instantiated GOAL: review the skills, agents, and knowledge base

> **GOAL:** Produce a ranked, evidence-backed assessment of this installation's
> agent-facing surfaces, and fix what is measurably broken.
> **DONE WHEN:** every surface below has a verdict with a citation, every
> KEEP/FIX/DELETE call names the evidence, and each accepted FIX has shipped
> behind §5.
> **NOT IN SCOPE:** authoring new skills, or restructuring `docs/` wholesale.

Surfaces, and the command that enumerates each. **No counts are written here on
purpose** — §3 forbids freezing a decaying number into durable prose, and the
first draft of this appendix did it anyway, with two of the numbers wrong.

| Surface | Where | Enumerate with |
|---|---|---|
| Project agents | `.claude/agents/**` incl. `core/`, `ruby/`, `validation/` | `find .claude/agents -name '*.md'` |
| Project skills | **`.agents/skills/`** and **`.skills/`** | `ls .agents/skills .skills` |
| — pointer only | `.claude/skills/` holds a README naming the two real locations | `cat .claude/skills/README.md` |
| Global / plugin skills | **the running tool's own roster** — not a directory | list the roster of the runtime you are in; `~/.claude/skills/` is Claude Code's slice of it, not the whole |
| Global agents | the runtime's agent roster | same — enumerate per runtime |
| Project docs | `docs/` — Johnny-Decimal areas + `adr/`, `incidents/`, `projects/`, `design-system/` | `find docs -name '*.md'` — **recursive**; `ls docs` returns areas, not documents |
| Knowledge bundle - concepts | `.okf/` | `find .okf -name '*.md' -not -name 'index.md' -not -name 'log.md'` |
| Knowledge bundle - **reserved files** | `.okf/index.md`, section `index.md`s, `.okf/log.md` | `find .okf \( -name 'index.md' -o -name 'log.md' \)` - audit these SEPARATELY: the root index is the mandatory discovery entry point, so broken routing there is invisible to a concept-only sweep |

**Do not assume `.claude/skills/` is the skill surface.** It is a pointer. The
first draft audited it and would have skipped every real project skill — a
worked example of §3's "measure the artifact, not a proxy for it", found by
review rather than by the author.

Questions each surface must answer, with evidence:

1. **Is it reachable?** Two discovery paths count, and conflating them
   manufactures false orphans:
   - **Roster/metadata match** — global and plugin skills are found by
     description against a real task, with no router entry anywhere. This is the
     normal path (`.claude/skills/README.md`: *"invoke by name, never by
     absolute path"*).
   - **Explicit routing** — an index or router entry.

   Do not assume project surfaces need routing: under some runtimes
   `.agents/skills/*/SKILL.md` is surfaced in the roster automatically, while
   `.skills/*` may not be. Check both locations against the ACTIVE runtime's
   roster before concluding either way - guessing here produces both false
   orphans and redundant routing.

   Mark orphaned only when **neither** applies. A DELETE call justified by a
   missing router entry alone is unsupported.
2. **Is it true?** Does it describe the tree as it is today? Cite a file:line
   that confirms or contradicts. Prefer concepts that store reasoning; flag
   concepts that store state.
3. **Does it duplicate?** Two files half-covering one topic is how a config
   rots. Name the survivor and merge.
4. **Does the SET earn its size?** For global skills, the question is not quality per file
   but whether the set is navigable. Measure: how many are reachable by
   description-match for a real task, and how many have never been invoked.
5. **What does it claim that it never measured?** The highest-yield defect class
   in this repo.

Sequence: cheapest signal first — orphan and duplicate detection are mechanical
and can run before any judgement. Judgement passes come after, one surface at a
time, WIP=1 — **one COMMIT per surface on the audit branch, one PR for the audit**.
Not one PR per surface: `CLAUDE.md` requires related work bundled into a single
PR (Paul, 2026-04-30: *"let's have one big PR instead of small PR"*), and eight
surfaces would otherwise become eight PRs.

---

## Appendix B — the tool surface, as of 2026-08-21

A **dated snapshot** so agents do not re-discover what is already known (Paul
2026-08-21: docs are explicit; do not spend cycles enumerating). Regenerate
each surface with the command in its header when a plugin changes; trust the
snapshot otherwise.

### MCP servers — regenerate: `claude mcp list`

Connected and load-bearing for this repo:

| Job | Server(s) |
|---|---|
| Markdown search (`docs/`, `.okf/`, `content/`) | `qmd` (collection `jt-site`) — FIRST for any doc/content lookup |
| Memory, swarm, hooks, loops | `ruflo` (plugin:ruflo-core; `.swarm/memory.db`) |
| Code search / symbols | `serena`, `tokensave`, `grepai`, `claude-context` |
| Library docs | `context7` |
| Visual checks, screenshots | `chrome-devtools` (headless) + plugin chrome-devtools |
| GitHub API | `github` (plugin) |
| Search Console / Analytics / Clarity | `gsc`, `google-analytics`, `clarity` |
| Web search / fetch | `parallel`, `brave-search`, `lightpanda` skill |
| Deep research, source-grounded Q&A | `notebooklm` / `notebooklm-mcp` (Google NotebookLM) — run substantial research through it, not ad hoc web calls |
| Design generation | `stitch` |
| Memory fallbacks | `memoria`, `mem0` (ruflo-first — see below) |
| Language server (Ruby) | `ruby-lsp` plugin + the `LSP` tool (diagnostics, go-to-def) |

Known state: `telegram` and `aci` fail to connect; `legalzoom` and `sentry`
need auth; interactively-authenticated (claude.ai) servers are absent in
headless/cron runs. A memoria cold-start "connection error" is a false alarm —
call the tool before believing it. Deferred tool schemas load via `ToolSearch`
— batch every tool you need into ONE comma-separated `select:` call.

### Skills — regenerate: read the roster in the session's system listing

The operational set for this repo (invoke via Skill tool; `/name` from the
user is an invocation request): `okf:okf` + `okf:validate` (bundle work),
`qmd:qmd`, `ponytail:ponytail` (held at ultra), `reflexion-reflect` /
`reflexion-critique` (voice-sensitive content, BLOCKING), `content-cold-eyes`,
`search-routing`, `code-review:code-review`, `commit-commands:*`, the
`superpowers:*` process family, and the ruflo set: `ruflo-swarm:swarm`,
`ruflo-loop-workers:ruflo-loop`/`cron-schedule`, `ruflo-autopilot:autopilot`,
`ruflo-security-audit:security-scan`, `ruflo-testgen:testgen`,
`ruflo-docs:doc-gen`, `ruflo-rag-memory:recall`. Repo pipelines (blog,
LinkedIn, new-page, cover-images) live in `docs/workflows/` and are executed
end-to-end like skills.

### Agents — regenerate: the Agent tool roster / `ListAgents`

The ones this repo actually routes to: `core-reviewer` / `core-coder` /
`core-researcher` / `core-planner` / `core-tester` (per-stage 4-eyes),
`hugo-expert`, `ruby-coder` + `ruby-reviewer`, `content-creator`,
`blog-batch-orchestrator` + `blog-post-coordinator`, `screenshot-guardian`,
`qa-browser-tester`, `ux-browser-validator`, `seo-specialist`,
`codex:codex-rescue` (external second opinion), `Explore` (read-only fan-out).
Project agent definitions: `.claude/agents/**` — audit per Appendix A.

**Routing through the roster is ENFORCED, not advisory (Paul 2026-08-21).**
If a listed skill or tool covers the task, invoke it — hand-rolling what a
skill already does is the same defect as writing a helper that exists two files
over. The order of preference:

1. **A matching skill** — invoke it before any response or action; its
   instructions replace your default approach. The roster proves presence,
   reading the skill proves fit — and **repo instructions win on conflict**
   (repo voice guides and workflow docs override generic writing/SEO/humanizer
   skill advice, per `CLAUDE.md`). Repo pipelines (blog, LinkedIn, OKF,
   new-page) are skills-by-another-name: execute them end-to-end.
2. **A matching MCP tool** — `qmd` for markdown search, semantic code search
   for code, `context7` for library docs, chrome-devtools for visual checks
   (§4's order). Load deferred schemas via `ToolSearch`, batched.
3. **Hand-rolled shell/code** — last, and only when neither exists.

Skipping a covering skill because "it's a simple task" is the named failure
mode: simple things become complex, and the skill carried the gate you just
bypassed.

**CI runs a different slice than your local gate — know which before quoting
"green".** The authority is `.github/workflows/`, not this sentence: as of
2026-08-21, `test.yml` runs `rake test:critical` on PRs and full `rake test` on
push, and `publish.yml` runs `rake test:unit` + `rake test:integration` on
master before deploying. CI is Linux — a macOS-green screenshot suite says
nothing about the Linux baselines CI compares against. Re-read the workflow
files before trusting this paragraph; they change more often than this doc.

**Ruflo-first (Paul 2026-08-21).** When a ruflo plugin covers the job — memory
store/search, swarm coordination, recurring loops/cron, autonomous completion,
security scanning, test-gap/TDD, doc generation — prefer its tools, skills, and
agents over the global/generic equivalent. The generic one is the fallback, not
the default. The full routing table lives in `~/.claude/CLAUDE.md` §Ruflo-first
(host-only — in container/CI sessions the category list above is the summary to
use); project instructions still override it.

---

## Appendix C — domain reference map

Per domain: read these first, route work through these. Explicit so onboarding
costs nothing (Paul 2026-08-21). All paths repo-relative; skills by roster name.

| Domain | Read first | Route through |
|---|---|---|
| **Coding** (templates, CSS, Ruby, config) | `CLAUDE.md` critical-files table; `docs/projects/2509-css-migration/` for CSS; `ponytail` held at ultra | `hugo-expert`, `ruby-coder` + `ruby-reviewer`, `core-coder`; gates per diff type |
| **Design / visual** | `.stitch/design.md`, `docs/design-system/`, `docs/workflows/visual-scroll-gate.md`, `.okf/design/` | `impeccable` skill, `stitch` MCP (generation only), `screenshot-guardian`, `qa-browser-tester`, chrome-devtools at 1280×800 + 390×844 |
| **Content / blog / LinkedIn** | voice guide `90.11`, ICP `90.10`, `docs/workflows/blog-pipeline.md` / `linkedin-post-pipeline.md`, `.okf/content/claims-canon.md` | `content-creator`, `content-cold-eyes`, `reflexion-reflect` (BLOCKING pre-handback), banned-strings ratchet |
| **Docs / knowledge** | new-doc location rules (`CLAUDE.md`), `.okf/index.md`, `writing-documentation-with-diataxis` | `okf:okf` (consume/produce/maintain), `okf:validate`, `ruflo-docs:doc-gen` |
| **Planning** | manager-triage rule (`CLAUDE.md`), active content plan `20.09`, §1a intake | `core-planner`, `plan-writing`, `task-breakdown`; plans peer-reviewed before Paul sees them (§5) |
| **Research** | §4 order: `qmd` in-tree → `context7` docs → NotebookLM MCP for deep multi-source → web (`parallel`/`tavily`) | `core-researcher`, `Explore` (read-only fan-out); cite everything |
| **Brainstorming / shaping** | `superpowers:brainstorming` (BEFORE creative work), `structural-decisions` | persona panels with distinct lenses + required dissent (§5) |
| **Testing / QA** | `CLAUDE.md` header Test line, `docs/20-29-testing-qa/` | `core-tester`, `ruflo-testgen:testgen`, `screenshot-guardian`; behavior-focused tests only |
| **SEO / analytics** | `docs/90-99-content-strategy/`, `bin/site-report`, `bin/campaign-metrics` | `seo-specialist`, `gsc` + `google-analytics` MCP; recompute averages, never quote them |
| **AI-instructions development** (skills, agents, CLAUDE.md, prompts, OKF) | this doc; `superpowers:writing-skills`; `.claude/agents/**` for agent shape; Appendix A for the audit method | `create-skill` / `create-agent` / `create-rule` skills, `claude-md-management:*`; instruction changes are code: branch + PR, 4-eyes, and a worked-example check (break the rule, watch the gate fail) before merge |
