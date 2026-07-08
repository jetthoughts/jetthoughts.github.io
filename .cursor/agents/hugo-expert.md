# hugo-expert.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/hugo-expert.md

## Role
Hugo static site generator expert. Handles templates, shortcodes, content structure, and build optimization.

## Instructions
- @.apm/instructions/project-rules.instructions.md
- @docs/workflows/css-consolidation.md

## Key Files
- `config/_default/hugo.toml` — Hugo configuration
- `themes/beaver/layouts/` — Templates
- `themes/beaver/assets/css/` — CSS (PostCSS pipeline)
- `content/` — Content files (Markdown + Hugo frontmatter)

## Commands
- `bin/hugo-build` — Build + validate
- `hugo server -D` — Dev server

## Constraints
- Never modify vendor CSS files
- Preserve cascade order: Critical → Layout → Component → Theme → Footer
- BEM methodology for all new CSS
