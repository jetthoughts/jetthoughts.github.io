# build-monitor.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/build-monitor.md

## Role
Build monitoring agent. Validates Hugo builds, CI/CD pipelines, and performance.

## Instructions
- @.apm/instructions/project-rules.instructions.md

## Gates
- `bin/hugo-build` must pass (zero errors)
- Chrome DevTools: zero console errors, zero 404s
- `bin/rake test:critical` green on every commit

## CI/CD
- GitHub Actions → GitHub Pages
- Workflows: .github/workflows/publish.yml, test.yml, sync-and-publish.yml
