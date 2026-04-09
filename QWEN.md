# QWEN.md

Qwen Code configuration for `jetthoughts.github.io`.

## Project Overview

- **Type**: Hugo static site blog (`jetthoughts.github.io`)
- **Build**: Hugo + Ruby/Rake tasks
- **Testing**: Minitest (`bin/rake test`, `bin/rake test:critical`)
- **CSS**: PostCSS pipeline
- **Content**: Markdown blog posts with Hugo frontmatter

## Installed Skills (Global: `~/.agents/skills/`)

### Blog Pipeline (Autonomous 9-Phase Workflow)
- `self-improving-agent` — Continuous learning & adaptation
- `blog-page-generator` — Automated blog page creation
- `content-strategy` — Strategic content planning
- `content-production` — End-to-end content creation
- `geo-content-publisher` — Automated publishing pipeline
- `workflow-execute` — Autonomous workflow runner
- `agentic-workflow-automation` — Multi-step task automation
- `blog-post` — Blog post generation
- `blog-writing-guide` — Blog writing process

### Research & Trends
- `social-media-trends-research` — Social media trend discovery
- `content-trend-researcher` — Content trend analysis
- `keyword-research` — SEO keyword discovery
- `market-research-analysis` — Market context & opportunity
- `competitor-intel` — Competitive landscape analysis
- `web-research-workflow` — Structured web research

### SEO & Performance
- `seo` — SEO best practices
- `seo-aeo-audit` — SEO & Answer Engine Optimization audits
- `landing-page-optimization` — Landing page conversion
- `web-performance-optimization` — Core Web Vitals optimization
- `pagespeed-insights` — PageSpeed Insights analysis

### CSS/HTML/PostCSS
- `best-practices` — Web quality audit
- `postcss-best-practices` — PostCSS configuration & patterns
- `html-css-best-practices` — HTML/CSS fundamentals
- `web-design-guidelines` — Design & accessibility guidelines

### Markdown
- `obsidian-markdown` — Creating/editing .md files
- `baoyu-markdown-to-html` — Markdown to HTML conversion

### Hugo
- `hugo` — Hugo static site generator guidance

### Writing & Editing
- `technical-writing` — Technical content clarity
- `copywriting-core` — Persuasive copywriting
- `copy-editing` — Proofreading & polish

### AI Detection & Humanization
- `humanizer` — Humanizing AI-generated text
- `slop-detector` — Detecting AI-generated content

## Skill Bundles by Task

### Hugo Site Maintenance
1. `hugo` → `minitest` → `html-css-best-practices` → `postcss-best-practices` → `best-practices`

### SEO Audit
1. `seo` → `seo-aeo-audit` → `landing-page-optimization` → `keyword-research` → `pagespeed-insights`

### Autonomous Blog Post Pipeline
1. **Trend**: `social-media-trends-research` + `content-trend-researcher` + `keyword-research`
2. **Strategy**: `content-strategy` + `market-research-analysis`
3. **Research**: `competitor-intel` + `web-research-workflow` + `blog-writing-guide`
4. **Ideation**: `blog-post` + `copywriting-core` + `technical-writing`
5. **Draft**: `content-production` + `copy-editing`
5.5. **AI Check**: `slop-detector` scan → `humanizer` if flagged
6. **SEO**: `seo` + `seo-aeo-audit` + `landing-page-optimization` + `pagespeed-insights`
7. **Hugo**: `hugo` + `blog-page-generator` + `obsidian-markdown`
8. **Publish**: `geo-content-publisher` + `workflow-execute`
9. **Improve**: `self-improving-agent`

### CSS/HTML Quality
1. `html-css-best-practices` → `postcss-best-practices` → `web-design-guidelines` → `web-performance-optimization`

## Autonomous Blog Pipeline Workflow

```
Phase 1: Trend Discovery    → ≥5 viable topics
Phase 2: Strategy           → Topics with keyword + audience + shareability ≥7/10
Phase 3: Research           → ≥8 sources, ≥1 expert quote
Phase 4: Ideation           → 3-5 takeaways, compelling hook
Phase 5: Draft & Edit       → Zero AI phrases, paragraphs ≤3 sentences
Phase 5.5: AI Quality Check → slop-detector passes, humanized if flagged
Phase 6: SEO & Performance  → Flesch ≥60, metadata complete
Phase 7: Hugo Build         → bin/hugo-build passes
Phase 8: Publish            → Post live, social meta tags correct
Phase 9: Continuous Improve → Lessons stored, configs updated
```

## Behavioral Constraints

- **Zero generic AI language**: All AI-sounding phrases flagged and rejected
- **Zero unsupported claims**: All assertions must have citations
- **Zero Hugo build breaks**: All content validated for Hugo compatibility
- **Zero readability compromise**: SEO never sacrifices human readability
- **Visual regression**: Zero tolerance — any visual change blocks publish
- **Testing**: Use `bin/rake test` or `bin/rake test:critical` — never create custom test scripts

## Key Commands

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build Hugo site |
| `bin/rake test` | Run all tests |
| `bin/rake test:critical` | Run critical tests only |

## File Structure

| Path | Purpose |
|------|---------|
| `content/blog/` | Blog posts (Markdown + frontmatter) |
| `layouts/` | Hugo templates |
| `assets/css/` | CSS/PostCSS source |
| `static/` | Static assets |
| `config.toml` | Hugo configuration |

## Execution Policy

- Prefer smallest skill set for end-to-end task completion
- Workflow: `research → implementation → validation → docs/publish`
- Multi-file changes: include `incremental-implementation`
- Docs affected: include `docs:update-docs`
- Autonomous pipeline: runs end-to-end with quality gates at each phase

## 🔍 Research Protocol (MANDATORY)

Always use claude-context MCP search **before** making changes:

**Step 1 — Search existing patterns:**
> Search the codebase at `/Users/pftg/dev/jetthoughts.github.io` for: "[pattern]"

**Step 2 — Check knowledge standards:**
> Search the codebase at `/Users/pftg/dev/jetthoughts.github.io/knowledge` for: "[topic]"

**Step 3 — Framework docs (when needed):**
> Get library docs for "[framework]"

**Never** grep/find/grep_search for existing code patterns — use claude-context MCP search as the primary research tool. It understands semantic relationships, is 100x faster, and returns relevant context chunks.

**Coverage**: Full codebase indexed (830+ files, 4,184+ semantic chunks)
