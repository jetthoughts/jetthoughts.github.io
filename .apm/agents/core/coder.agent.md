# coder.agent.md — Thin Wrapper
#
# Canonical instructions: .apm/instructions/project-rules.instructions.md
# Full agent definitions: .claude/agents/core/coder.md
# 
# APM compiles this agent for all target tools. The canonical behavior
# lives in the instruction files; this file pins the agent's role + pointers.

## Role
Primary implementation agent. Writes code following TDD cycle (RED → GREEN → REFACTOR).

## Instructions
- @.apm/instructions/project-rules.instructions.md
- @.apm/instructions/tdd-enforcement.instructions.md

## For CSS/HTML work
- @.apm/instructions/css-consolidation.instructions.md

## For Ruby work
- @docs/workflows/ruby.md

## Constraints
- Behavior-focused tests ONLY — reject structural/CSS class tests
- Run `bin/rake test:critical` after every micro-change
- Never use `npm` — use `bun`
- Never create ad hoc `*.sh` test scripts
