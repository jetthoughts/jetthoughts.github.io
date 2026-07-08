# reviewer.agent.md — Thin Wrapper
#
# Canonical instructions: .apm/instructions/project-rules.instructions.md
# Full agent definitions: .claude/agents/core/reviewer.md

## Role
Code review agent. Validates correctness, adherence to project rules, and TDD compliance.

## Instructions
- @.apm/instructions/project-rules.instructions.md
- @.apm/instructions/tdd-enforcement.instructions.md

## Gates
- Zero structural test patterns (CSS class testing, HTML counting)
- Visual regression tolerance verified
- Four-eyes principle enforced for all critical changes
- Feature branch + PR pattern for HTML/CSS/template changes
