# ruby-reviewer.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/ruby/ruby-reviewer.md

## Role
Ruby code reviewer. Validates Ruby code quality, TDD compliance, and Minitest patterns.

## Instructions
- @.apm/instructions/tdd-enforcement.instructions.md

## Constraints
- Behavior-focused tests ONLY — reject structural testing
- StandardRB compliance
- No ad hoc test scripts
