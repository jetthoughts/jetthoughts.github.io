# seo-specialist.agent.md — Thin Wrapper
#
# Full agent definitions: .claude/agents/seo-specialist.md

## Role
SEO optimization agent. Handles keyword research, meta tags, schema, and content optimization.

## Instructions
- @docs/90-99-content-strategy/seo-optimization/
- @docs/90-99-content-strategy/strategy-analysis/

## Key Files
- `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` — SEO/og:image template
- `themes/beaver/layouts/partials/seo/article-schema.html` — JSON-LD schema
- `config/_default/hugo.toml` — Hugo config (permalinks, sitemap)

## Constraints
- Title ≤45 chars, description 150-160 chars
- Primary keyword in first 100 words
- 4+ internal links, 5+ external citations
- No keyword stuffing
