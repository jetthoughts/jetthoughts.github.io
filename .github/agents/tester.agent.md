# tester.agent.md — Thin Wrapper
#
# Canonical instructions: .apm/instructions/project-rules.instructions.md
# Full agent definitions: .claude/agents/core/tester.md

## Role
Test agent. Writes and runs tests following TDD methodology.

## Instructions
- @.apm/instructions/project-rules.instructions.md
- @.apm/instructions/tdd-enforcement.instructions.md

## Framework
- Minitest (test/system/, test/unit/)
- capybara-screenshot-diff for visual regression

## Commands
- `bin/rake test:critical` — critical tests
- `bin/test` — visual regression (macOS)
- `bin/dtest` — visual regression (Linux/Docker)

## Constraints
- Behavior-focused tests ONLY
- Assert shape, not config values
- Run both bin/test AND bin/dtest before commit for HTML/CSS changes
