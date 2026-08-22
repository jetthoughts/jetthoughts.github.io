---
type: Playbook
title: Ruflo runtime - self-heal, shared memory, and the learning loop
description: How ruflo (claude-flow) runs in this repo - bin/agent-bootstrap self-heals the gitignored scaffolding, worktrees symlink .swarm to the main checkout so memory is shared, and the okf memory namespace mirrors the OKF bundle one entry per concept.
tags: [ruflo, claude-flow, memory, hooks, learning]
generated:
  by: claude-fable/5
  at: 2026-08-22T00:00:00Z
timestamp: 2026-08-22T00:00:00Z
---

Ruflo = `@claude-flow/cli` (same codebase, two npm names). The repo commits NO
ruflo artifacts - `.claude/helpers/`, `.swarm/`, `.claude-flow/`, and
`claude-flow.config.json` are all gitignored scaffolding. That design created
two silent failure modes, both closed 2026-08-22 by a self-heal block in
`bin/agent-bootstrap` (the SessionStart hook):

1. **Dead hooks**: every `.claude/settings.json` hook calls
   `.claude/helpers/hook-handler.cjs` with `|| true`. In a fresh
   worktree/checkout the helper does not exist, so the whole learning pipeline
   no-ops silently (intelligence stats sat at zero for months). The bootstrap
   now runs `npx @claude-flow/cli@latest init upgrade` whenever the handler is
   missing - `init upgrade` regenerates helpers while preserving data and
   never touches tracked files.
2. **Doomed worktree memory**: `.swarm/` is cwd-relative, so a worktree
   session wrote to a private DB that died with the worktree. The bootstrap
   now symlinks a worktree's `.swarm` to the main checkout's (only when
   `.swarm` does not already exist), so every session - CLI and MCP tools -
   reads and writes the ONE shared store.

# The okf memory namespace mirrors this bundle

Backfilled 2026-08-22: namespace `okf` holds one entry per OKF concept — all
39 concepts across all six sections, plus two log-derived lessons and the
backfill marker. Key prefixes abbreviate the section: `okf-build-`,
`okf-content-`, `okf-wf-` (workflows), `okf-design-`, `okf-arch-`
(architecture), `okf-cs-` (content-strategy), `okf-log-`. Each entry is a
distilled fact plus a pointer to its `.okf/` file; semantic recall routes a
session to the right concept, the file stays canon. **Sync rule: a commit
that changes a concept's title/description also upserts its `okf-*` entry**
(`npx @claude-flow/cli@latest memory store -n okf -k <key> -v "<desc>
Details: <path>"`), or the namespace drifts from the bundle. The mirror lives
in the gitignored `.swarm/` store, so a fresh MACHINE (not worktree) starts
with an empty namespace — regenerate by re-running the backfill: one store
per concept from its frontmatter title/description, exactly as above.

# The learning loop, and where each piece lives

- `memory.db` - KV + vector store (memory_store/search; 384-dim ONNX
  embeddings). `agentdb-memory.db` - the learning store (reasoning_patterns,
  episodes, causal_edges, skills), fed by the in-session memory bridge.
- `memory distill run --db .swarm/agentdb-memory.db` mines agentdb entries
  into reasoning patterns (first run 2026-08-22: 660 patterns, 650 causal
  edges, 44 promoted). Plain `memory distill run` targets `memory.db`, which
  by design has no pattern tables - the skip message "agentdb schema not
  initialised" means you pointed it at the wrong DB, not that init is needed.
- 12 background workers exist (`hooks worker list`); the daemon runs them.
- **Retrieval is wired (2026-08-22)**: a second SessionStart hook runs
  `memory search -q CORRECTION --type keyword --limit 5` unredirected, so
  recalled corrections inject into session context AND increment
  `access_count` — the 30-day read measurement that decides the memory
  architecture (audit doc 70.12). Do not remove it before the measurement.
- **ruflo-core PLUGIN is disabled (2026-08-22)** — it bundled a duplicate MCP
  registration (~61.5k schema tokens/session); the project-level `ruflo`
  entry in `~/.claude.json` is the ONE registration (CLAUDE.md hardcodes its
  `mcp__ruflo__*` prefix). Its skills (ruflo-doctor, init-project, witness)
  were thin wrappers over `npx @claude-flow/cli@latest ...` — call the CLI
  directly (doctor / init upgrade / etc.). Other ruflo-* plugins stay enabled.
- **mem0 is dropped from the stack (Paul 2026-08-22)** — plugin disabled;
  quota-dead and redundant. Fallback chain is ruflo → memoria.

# CLI bugs observed 2026-08-22 (ruflo v3.38.16) - do not re-fight these

The bootstrap installs `@latest`, so no pin can hold - these are dated
observations, not version guarantees; re-measure before assuming one is fixed
or still present.

- `config init` generates a config the loader rejects ("reading 'map'"
  warning on every call). Run on defaults; delete any generated config.
- `memory export` fails ("Exported to undefined"); `memory_import_claude`
  finds 0 files even with `allProjects: true` (path-encoding). The auto-memory
  corpus is deliberately NOT mirrored into ruflo - `MEMORY.md` already loads
  every session.
- CLI `memory search --type semantic` returns empty in terminals (needs
  @ruvector/core); single-term `--type keyword` works; real semantic search is
  MCP-only. (Also in CLAUDE.md research protocol.)
- `CLAUDE_FLOW_DB_PATH` redirects store/list/search/retrieve but NOT
  backup/init (cwd-resolved) - superseded by the symlink for normal use.
