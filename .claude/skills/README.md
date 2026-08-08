# Local Skill Profile for Codex

Skills live in-repo, portable across environments (no machine-specific paths):

- `.agents/skills/` — repo-wide SOP skills (async-first-communication, kanban-md, impeccable)
- `.skills/` — course-project skills (see `.skills/course-skills-map.md`)
- Global/plugin skills load via each tool's own roster — invoke by name, never by absolute path.

## Primary Workflows

### Maintain Hugo/Ruby/HTML/CSS/Markdown

`hugo` -> `minitest` -> `html-css-best-practices` -> `postcss-best-practices` -> `best-practices` -> `docs:update-docs`

### Audit and Improve Landing SEO

`seo-aeo-audit` -> `landing-page-optimization` -> `keyword-research` -> `pagespeed-insights`

### Research and Add Engagement Blog Posts

`content-trend-researcher` -> `social-media-trends-research` -> `keyword-research` -> `blog-post` -> `content-production` -> `geo-content-publisher`

## Selection Rule

Use only the minimal skill subset needed for the current task, preserving this order:
`research -> implementation -> validation -> docs/publish`.

Agents are thin wrappers; shared rules live in `docs/workflows/BASE_HANDBOOK.md`.
