# Commands & Hooks Consolidation

This file is the single overview of command families. Existing command files remain for compatibility.

## Command Families
- `analysis/` → performance and token usage checks
- `automation/` → session memory, auto-agent, smart spawn
- `github/` → repo/issue/PR workflows
- `hive-mind/` → multi-agent coordination
- `monitoring/` → agent metrics and status
- `optimization/` → topology and parallel execution
- `pair/` → pairing modes and session setup
- `sparc/` → SPARC roles and TDD guidance
- `swarm/` → swarm modes and coordination
- `training/` → model training utilities
- `verify/` → validation workflows
- `workflows/` → workflow create/export/execute

Rule: If a command file is updated, keep it thin and point here or to a dedicated workflow doc.
