# AGENTS.md

Codex skill setup for `jetthoughts.github.io`.

## Skill Sources Reviewed

- Global skill library: `/Users/pftg/.agents/skills`
- Local project skills folder: `.claude/skills` (was missing; now created with a local profile)

## Default Skill Bundles

### 1) Hugo + Ruby + HTML/CSS/Markdown maintenance

Use these skills in order:
1. `hugo`
2. `minitest`
3. `html-css-best-practices`
4. `postcss-best-practices`
5. `best-practices`
6. `docs:update-docs`

Routing notes:
- Template/content/layout changes: start with `hugo`.
- Ruby/test work: add `minitest`.
- CSS pipeline/refactor: add `postcss-best-practices`.
- Cross-cutting quality/security pass: `best-practices`.

### 2) Landing page SEO audit and improvement

Use these skills in order:
1. `seo-aeo-audit`
2. `landing-page-optimization`
3. `keyword-research`
4. `pagespeed-insights`

Routing notes:
- Technical SEO + structured data + AEO: `seo-aeo-audit`.
- Conversion + hero/CTA quality: `landing-page-optimization`.
- Query intent alignment: `keyword-research`.
- Core Web Vitals impact: `pagespeed-insights`.

### 3) Research + add engagement-focused blog posts

Use these skills in order:
1. `content-trend-researcher`
2. `social-media-trends-research`
3. `keyword-research`
4. `blog-post`
5. `content-production`
6. `geo-content-publisher`

Routing notes:
- Discover demand first, then write.
- Publish only after keyword + editorial QA pass.
- Use `geo-content-publisher` for multi-channel distribution.

## Execution Policy for Codex

- Prefer the smallest skill set that completes the task end-to-end.
- Keep workflow sequence: `research -> implementation -> validation -> docs/publish`.
- For multi-file code changes, include `incremental-implementation`.
- For any docs affected by code/content updates, include `docs:update-docs`.
