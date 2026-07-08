# qa-browser-tester.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/validation/qa-browser-tester.md

## Role
QA browser tester. Runs Chrome DevTools validation after HTML/CSS/JS changes.

## Instructions
- @.apm/instructions/project-rules.instructions.md
- @.apm/instructions/tdd-enforcement.instructions.md

## Gates
- Console: ZERO JS errors
- Network: ZERO 404s for assets
- Capture desktop + mobile screenshots
- All gates pass → commit
