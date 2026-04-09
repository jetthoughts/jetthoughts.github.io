# AGENTS.md

Codex skill setup for `jetthoughts.github.io`.

## Skill Sources Reviewed

- Global skill library: `/Users/pftg/.agents/skills`
- Local project skills folder: `.claude/skills`

## Installed Skills Registry

All skills installed globally via `npx skills add`:

### Blog Pipeline (Autonomous 9-Phase Workflow)
- `self-improving-agent` (charon-fan/agent-playbook) — Continuous learning
- `blog-page-generator` (kostja94/marketing-skills) — Blog page creation
- `content-strategy` (guia-matthieu/clawfu-skills) — Content planning
- `content-production` (borghei/claude-skills) — End-to-end content creation
- `geo-content-publisher` (geoly-ai/geo-skills) — Publishing pipeline
- `workflow-execute` (catlog22/claude-code-workflow) — Workflow runner
- `agentic-workflow-automation` (samarv/shanon) — Multi-step automation
- `blog-post` (langchain-ai/deepagents) — Blog post generation
- `blog-writing-guide` (getsentry/skills) — Writing process

### Research & Trends
- `social-media-trends-research` (drshailesh88/integrated_content_os) — Social trends
- `content-trend-researcher` (alirezarezvani/claude-code-skill-factory) — Content trends
- `keyword-research` (kostja94/marketing-skills) — SEO keyword discovery
- `market-research-analysis` (manojbajaj95/claude-gtm-plugin) — Market context
- `competitor-intel` (ognjengt/founder-skills) — Competitive landscape
- `web-research-workflow` (yonatangross/orchestkit) — Structured research

### SEO & Performance
- `seo` (addyosmani/web-quality-skills) — SEO best practices
- `seo-aeo-audit` (warpdotdev/oz-skills) — SEO & AEO audits
- `landing-page-optimization` (manojbajaj95/claude-gtm-plugin) — Landing page conversion
- `web-performance-optimization` (sickn33/antigravity-awesome-skills) — Core Web Vitals
- `pagespeed-insights` (enderpuentes/ai-agent-skills) — Performance analysis

### CSS/HTML/PostCSS
- `best-practices` (addyosmani/web-quality-skills) — Web quality audit
- `postcss-best-practices` (mindrally/skills) — PostCSS patterns
- `html-css-best-practices` (hack23/homepage) — HTML/CSS fundamentals
- `web-design-guidelines` (ehmo/platform-design-skills) — Design & accessibility

### Markdown
- `obsidian-markdown` (kepano/obsidian-skills) — Creating/editing .md files
- `baoyu-markdown-to-html` (jimliu/baoyu-skills) — MD → HTML conversion

### Hugo
- `hugo` (jackspace/claudeskillz) — Hugo static site guidance

### Writing & Editing
- `technical-writing` (mindrally/skills) — Technical content clarity
- `copywriting-core` (manojbajaj95/claude-gtm-plugin) — Persuasive copy
- `copy-editing` (borghei/claude-skills) — Proofreading & polish

### AI Detection & Humanization
- `humanizer` (brandonwise/humanizer) — Humanizing AI-generated text
- `slop-detector` (athola/claude-night-market) — Detecting AI-generated content

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
1. `seo`
2. `seo-aeo-audit`
3. `landing-page-optimization`
4. `keyword-research`
5. `pagespeed-insights`

Routing notes:
- Technical SEO + structured data + AEO: `seo` + `seo-aeo-audit`.
- Conversion + hero/CTA quality: `landing-page-optimization`.
- Query intent alignment: `keyword-research`.
- Core Web Vitals impact: `pagespeed-insights`.

### 3) Research + add engagement-focused blog posts (Autonomous Pipeline)

Use these skills in order:
1. `social-media-trends-research` + `content-trend-researcher` — Discover trends
2. `keyword-research` + `market-research-analysis` — Validate demand
3. `competitor-intel` + `web-research-workflow` — Gather intelligence
4. `blog-post` + `copywriting-core` — Ideate & outline
5. `blog-writing-guide` + `content-production` — Draft content
5.5. `slop-detector` → scan for AI patterns → `humanizer` if flagged
6. `technical-writing` + `copy-editing` — Polish & edit
7. `seo` + `seo-aeo-audit` — Optimize for search
8. `hugo` + `obsidian-markdown` — Validate Hugo compatibility
9. `blog-page-generator` + `geo-content-publisher` — Publish
10. `self-improving-agent` — Store learnings

Routing notes:
- Discover demand first, then write.
- Publish only after keyword + editorial QA pass.
- Use `geo-content-publisher` for multi-channel distribution.
- Each phase has quality gates — fail stops pipeline.

### 4) CSS/HTML Quality & Accessibility

Use these skills in order:
1. `html-css-best-practices`
2. `postcss-best-practices`
3. `web-design-guidelines`
4. `web-performance-optimization`

Routing notes:
- ANY CSS changes → apply `html-css-best-practices` + `postcss-best-practices`
- ANY HTML changes → apply `html-css-best-practices` + `best-practices`
- Accessibility review → apply `web-design-guidelines`
- Performance audit → apply `web-performance-optimization` + `pagespeed-insights`

## Autonomous Blog Pipeline — 9-Phase Workflow

```
Phase 1: Trend Discovery → Phase 2: Strategy → Phase 3: Research
    → Phase 4: Ideation → Phase 5: Draft & Edit → Phase 6: SEO & Performance
    → Phase 7: Hugo Build → Phase 8: Publish → Phase 9: Continuous Improvement
```

### Phase Quality Gates
| Phase | Gate |
|-------|------|
| 1. Trend Discovery | ≥5 viable topic opportunities |
| 2. Strategy | Each topic: keyword + audience + shareability ≥7/10 |
| 3. Research | ≥8 credible sources, ≥1 expert quote |
| 4. Ideation | 3-5 takeaways, compelling hook defined |
| 5. Draft | Zero AI phrases, paragraphs ≤3 sentences |
| 5.5. AI Check | slop-detector passes, humanized if flagged |
| 6. SEO | Flesch Reading Ease ≥60, metadata complete |
| 7. Hugo Build | `bin/hugo-build` passes, all links resolve |
| 8. Publish | Post live, social meta tags rendering |
| 9. Improvement | Lessons stored, agent configs updated |

## Execution Policy

- Prefer the smallest skill set that completes the task end-to-end.
- Keep workflow sequence: `research -> implementation -> validation -> docs/publish`.
- For multi-file code changes, include `incremental-implementation`.
- For any docs affected by code/content updates, include `docs:update-docs`.
- Autonomous blog pipeline: runs end-to-end with quality gates at each phase.
- Zero tolerance: no generic AI language, no unsupported claims, no Hugo build breaks.

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
