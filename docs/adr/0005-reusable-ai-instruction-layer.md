# Architecture Decision Record: Extracting the AI instruction layer for reuse

**ADR-0005**
**Date:** 2026-08-21
**Status:** Proposed

## Title

Package project-agnostic skills, agents, commands, and the delivery contract as
a versioned Claude Code plugin; each consuming repo keeps only a thin binding.

## Context

This repo has accumulated an AI instruction layer worth reusing in other
JetThoughts projects: the autonomous delivery contract
(`docs/workflows/autonomous-delivery-prompt.md` §1–§9), the `/deliver` kickoff
command, project skills (`.agents/skills/` — e.g. `async-first-communication`),
core agent definitions (`.claude/agents/core/`, `ruby/`, `validation/`), and
the OKF bundle convention.

Two facts constrain the design, both observed in this repo:

1. **Copy-paste drifts.** The 4-eyes rule was restated in `CLAUDE.md` and
   `AGENTS.md` and the two copies diverged within a day of each other
   (found 2026-08-21). Any extraction that duplicates prose re-creates this.
2. **Symlinks dangle.** `knowledge/` symlinks to a sibling repo and resolves
   only on the host machine — container/CI sessions see a broken path
   (`CLAUDE.md` warns against depending on it). Any extraction relying on
   local filesystem layout fails the weakest consumer.

Additionally, research (2026-08-21, cited in the delivery prompt work) shows
instruction files help only when minimal and precise; the extraction must not
grow each consumer's always-loaded context.

## Decision

**Package the generic layer as a Claude Code plugin in a dedicated marketplace
repo** (working name: `jetthoughts/claude-plugins`, plugin `jt-delivery`),
installed per machine/project with `claude plugin install jt-delivery@jetthoughts`
— the same mechanism already used for the ruflo plugin set, so the toolchain,
update path, and user habits exist.

What moves into the plugin (project-agnostic by construction):

| Piece | Plugin form |
|---|---|
| Delivery contract §1–§9 (loop, evidence, 4-eyes, WIP=1, async-first, scope, learn) | a skill (`jt-delivery:contract`) — loaded on demand, not always-on |
| `/deliver` kickoff | a command, parameterized by `$ARGUMENTS` |
| Core agent roster (`core-coder`, `core-reviewer`, `core-researcher`, `core-planner`, `core-tester`) | plugin agents |
| Cross-project skills (`async-first-communication`, review-panel patterns) | plugin skills |
| OKF authoring/validation | already external (`okf` plugin) — reference, don't absorb |

What stays in each consuming repo (project-specific by construction):

| Piece | Home |
|---|---|
| Tool-surface snapshot (Appendix B) and domain map (Appendix C) | repo's operating doc |
| Gates, commands, test matrix, canon numbers, voice rules | repo `CLAUDE.md` + `.okf/` |
| `AGENTS.md` | per-repo (the cross-tool standard expects repo-specific content) |
| The binding: which plugin version, and any overrides | repo `CLAUDE.md`, one short section |

**Precedence rule carried into every consumer:** repo instructions override
plugin instructions on conflict — the plugin is the default, never the
authority (mirrors the existing ruflo-first table's own escape hatch).

**Versioning:** semver git tags on the marketplace repo; consumers upgrade
deliberately (`claude plugin update`), never track a moving branch. A
`CHANGELOG.md` in the plugin is the migration surface.

## Alternatives considered

- **Symlink to a shared repo** — rejected: proven to dangle in containers
  (`knowledge/`, context fact 2).
- **Copy files into each repo** — rejected: proven to drift (context fact 1);
  N repos × M files with no update path.
- **Git submodule/subtree** — workable but rejected: update friction, detached
  heads, and no per-user scoping; plugins already solve distribution with
  less ceremony.
- **`ai-rulez` generation** (single source → generated CLAUDE.md/.cursor
  outputs) — deferred, not rejected: attractive for *rules* if we later target
  non-Claude tools seriously, but it adds a compile step and does not carry
  skills/agents/commands, which are the bulk of the layer.

## Consequences

- Extraction is a real migration for this repo: the delivery prompt splits
  into generic core (→ plugin) and Appendices A–C (stay). Until that
  migration, this repo's copy remains canonical.
- New projects onboard with: install plugin → write a ~30-line `CLAUDE.md`
  binding (commands, gates, canon pointers) → `/deliver` works day one.
- Plugin changes get their own review pipeline in the marketplace repo; a bad
  release affects every consumer, so the plugin repo inherits the 4-eyes
  contract it ships.
- Risk: divergence between this repo's evolving contract and the extracted
  plugin during the transition — mitigated by doing the split in one sprint
  and deleting the migrated prose here (consolidate-before-creating, zero
  duplicates).

## Verification

- DONE WHEN a second repo installs the plugin, runs `/deliver` on a toy idea,
  and the session follows §1a intake without reading this repo.
- The extraction PR here must show net deletion of migrated prose (no
  two-homes state survives the sprint).
