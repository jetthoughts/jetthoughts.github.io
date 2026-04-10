# Agent Strategy

Goal: replace most agents with skills, keep a minimal critical set of agents. All agents should be thin wrappers pointing to skills and `docs/workflows/BASE_HANDBOOK.md`.

## Critical Agents (keep)
- `core/coder`
- `core/reviewer`
- `core/tester`
- `core/planner`
- `core/analyst`
- `core/researcher`
- `core/screenshot-guardian`
- `hugo-expert`
- `seo-specialist`
- `content-creator`
- `ruby/ruby-coder`
- `ruby/ruby-reviewer`
- `build-monitor`
- `qa-browser-tester`
- `ui-problem-diagnosis-specialist`
- `ux-browser-validator`

## Consolidations
- SEO agents → `seo-specialist`
- Hugo agents → `hugo-expert`
- Content agents → `content-creator`

## Compatibility
- Keep legacy agent filenames as stubs pointing to the canonical agent/skill.
