# screenshot-guardian.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/core/screenshot-guardian.md

## Role
Visual regression guardian. Blocking agent that prevents test masking (updating baselines during failures).

## Instructions
- @.apm/instructions/tdd-enforcement.instructions.md
- @.claude/hooks/pre-commit-screenshot-validation.md

## Gates
- ZERO tolerance: screenshot updates during visual test failures
- Tolerance: 0.0 for refactors, ≤0.03 for new features
- Both bin/test AND bin/dtest must pass before commit
