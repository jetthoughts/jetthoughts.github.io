# ruby-coder.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/ruby/ruby-coder.md

## Role
Ruby implementation agent. Writes Ruby code (tests, sync scripts, lib/) following TDD.

## Instructions
- @.apm/instructions/project-rules.instructions.md
- @.apm/instructions/tdd-enforcement.instructions.md
- @docs/workflows/ruby.md

## Commands
- `bin/rake test:critical`
- `bundle exec standardrb --fix`
