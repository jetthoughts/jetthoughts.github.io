# GEMINI.md

Gemini CLI configuration for `jetthoughts.github.io`.

## Project Overview

- **Type**: Hugo static site blog (`jetthoughts.github.io`)
- **Build**: Hugo + Ruby/Rake tasks
- **Testing**: Minitest (`bin/rake test`, `bin/rake test:critical`)
- **CSS**: PostCSS pipeline
- **Content**: Markdown blog posts with Hugo frontmatter

## Gemini-Specific Notes

- **Image generation** requires `GEMINI_API_KEY` from [Google AI Studio](https://aistudio.google.com/app/apikey). The default OAuth endpoint (`cloudcode-pa.googleapis.com`) does NOT expose image generation models and will return 404 for `gemini-3.1-flash-image-preview` or any other image model. Export `GEMINI_API_KEY` to route requests to `generativelanguage.googleapis.com` where image models live.
- **Preferred image model**: `gemini-3.1-flash-image-preview` (Nano Banana 2, released 2026-02-26, 4K output).
- **Cover image generator script**: `bin/generate-cover-image <slug> "concept sentence"` wraps the gemini CLI image model with the jt_site design system baked into the prompt.
- **Stitch project**: `3224353017067976684` ("JetThoughts Blog Covers") is the canonical Stitch project for cover images — call `mcp__stitch__generate_screen_from_text` against it for designs that match already-shipped covers.

## Installed Skills (Global: `~/.gemini/skills/`)

### Blog Pipeline (Autonomous 11-Phase Workflow)
- `self-improving-agent` — Continuous learning & adaptation
- `blog-page-generator` — Automated blog page creation
- `content-strategy` — Strategic content planning
- `content-production` — End-to-end content creation
- `geo-content-publisher` — Automated publishing pipeline
- `workflow-execute` — Autonomous workflow runner
- `agentic-workflow-automation` — Multi-step task automation
- `blog-post` — Blog post generation
- `blog-writing-guide` — Blog writing process
- `ralph-loop` — Feedback-driven iterative development loop

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

### UX Research & Design (for cover image generation)
- `ux-researcher` — User research, persona identification, engagement pattern analysis
- `ux-principles` — UX heuristics, visual hierarchy, engagement psychology
- `frontend-design` — Production-grade design specs and visual language
- `web-design-guidelines` — Platform design and accessibility guidelines
- `web-design-reviewer` — Visual inspection and design review
- `stitch-design` — Stitch MCP wrapper for high-fidelity cover image generation

### CSS/HTML/PostCSS
- `best-practices` — Web quality audit
- `postcss-best-practices` — PostCSS configuration & patterns
- `html-css-best-practices` — HTML/CSS fundamentals

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
1. `hugo` → `html-css-best-practices` → `postcss-best-practices` → `best-practices`

### SEO Audit
1. `seo` → `seo-aeo-audit` → `landing-page-optimization` → `keyword-research` → `pagespeed-insights`

### Autonomous Blog Post Pipeline (11-Phase)
1. **Trend**: `social-media-trends-research` + `content-trend-researcher` + `keyword-research`
2. **Strategy**: `content-strategy` + `market-research-analysis`
3. **Research**: `competitor-intel` + `web-research-workflow` + `blog-writing-guide`
4. **Ideation**: `blog-post` + `copywriting-core` + `technical-writing`
5. **Draft**: `content-production` + `copy-editing`
5.5. **AI Check**: `slop-detector` scan → `humanizer` if flagged
5.7. **SEO + Editorial Re-Review**: `seo-aeo-audit` + `copy-editing` + `technical-writing` → `ralph-loop` iterates feedback until clean (mandatory BEFORE draft complete)
6. **SEO**: `seo` + `seo-aeo-audit` + `landing-page-optimization` + `pagespeed-insights`
7. **Hugo**: `hugo` + `blog-page-generator` + `obsidian-markdown`
7.5. **Cover Image** (mandatory AFTER Hugo build, BEFORE publish — three steps):
    a. `ux-researcher` + `ux-principles` — research which visual metaphor resonates with this audience for this topic
    b. `frontend-design` + `web-design-guidelines` — translate research into concrete design spec
    c. `stitch-design` MCP OR `bin/generate-cover-image` — generate 1200×630 `cover.jpg` as post page resource
8. **Publish**: `geo-content-publisher` + `workflow-execute`
9. **Improve**: `self-improving-agent`

## Autonomous Blog Pipeline Workflow

```
Phase 1: Trend Discovery          → ≥5 viable topics
Phase 2: Strategy                 → Topics with keyword + audience + shareability ≥7/10
Phase 3: Research                 → ≥8 sources, ≥1 expert quote
Phase 4: Ideation                 → 3-5 takeaways, compelling hook
Phase 5: Draft & Edit             → Zero AI phrases, paragraphs ≤3 sentences
Phase 5.5: AI Quality Check       → slop-detector passes, humanized if flagged
Phase 5.7: SEO + Editorial Re-Rev → ralph-loop handles feedback until clean (BEFORE draft complete)
Phase 6: SEO & Performance        → Flesch ≥60, metadata complete
Phase 7: Hugo Build               → bin/hugo-build passes
Phase 7.5: Cover Image Generation → UX research → Design → Stitch/gemini; og:image resolves to local cover.jpg (BEFORE publish)
Phase 8: Publish                  → Post live, social meta tags correct
Phase 9: Continuous Improve       → Lessons stored, configs updated
```

### Phase 5.7: SEO + Editorial Re-Review (Ralph Loop)

Mandatory before marking draft complete:

1. **SEO re-review** (`seo-aeo-audit` + `seo`) — catch missed keywords, metadata gaps, readability regressions from the Phase 5 drafting pass
2. **Editorial re-review** (`copy-editing` + `technical-writing`) — catch voice drift, unclear phrasing, unsupported claims, factual concerns, AI-tell phrases the slop-detector missed
3. **Ralph loop** — if either review returns feedback, feed the combined findings into the `ralph-loop` skill; ralph iteratively applies fixes and re-runs both reviews until both return clean
4. Draft is **only complete** when ralph loop exits with zero outstanding findings

### Phase 7.5: Cover Image Generation (UX Research → Design → Generation)

Mandatory after Hugo build, before publish. Three sub-steps (NOT a single tool call — a cover image is a UX artifact, not a decoration):

1. **UX Research** (`ux-researcher` + `ux-principles`):
   - Identify the specific reader for this post (within CTO/Engineering Manager audience)
   - Research which visual metaphors resonate for this topic in technical social feeds
   - Identify engagement patterns (dark IDE / editorial illustration / data viz / photography)
   - Check shipped covers to avoid visual repetition
   - Output: research brief at `blog/ux-research/covers/{slug}/brief`

2. **UX/UI Design** (`frontend-design` + `web-design-guidelines` + `web-design-reviewer`):
   - Translate research into concrete design spec: palette, composition pattern, hero element, tag pills, metric cards
   - Reference canonical design system at `docs/projects/2510-seo-content-strategy/20-29-strategy/20.06-blog-cover-image-design-system.md` for brand defaults
   - Reference existing Stitch project `3224353017067976684` for visual alignment with shipped covers
   - Output: concept sentence + full design spec at `blog/ux-design/covers/{slug}/spec`

3. **Generation**:
   - **Preferred**: `mcp__stitch__generate_screen_from_text` against project `3224353017067976684` with the design spec as the prompt. Download the generated HTML. Render at exact 1200×630 via `chrome-devtools` MCP (`new_page` → `resize_page` 1200×630 → wait for fonts → `take_screenshot` format=jpeg quality=90) directly into the post directory.
   - **Fallback**: `bin/generate-cover-image <slug> "concept"` wraps the gemini CLI image model. Requires `GEMINI_API_KEY` in the environment.
   - Save 1200×630 JPEG at `content/blog/<slug>/cover.jpg` as a page resource

**Verify**: Rebuild Hugo and confirm `og:image` resolves to the local processed WebP (e.g. `/blog/<slug>/cover_hu_<hash>.webp`), not `og-default.jpg`. If it still falls back, the page resource isn't resolving — check that the filename matches `cover_image`/`metatags.image` in frontmatter.

**Why three steps instead of one**: Prompt-first image generation consistently produces tech clichés (code editors, gears, lightbulbs). UX research grounds the visual metaphor in *this specific reader's* engagement patterns; UX/UI design translates that into a brand-aligned spec; generation is just execution. Skipping research-and-design means the generator defaults to whatever is in its training data, which rarely matches a specific audience.

## Behavioral Constraints

- **Zero generic AI language**: All AI-sounding phrases flagged and rejected
- **AI detection gate**: All content must pass slop-detector before Phase 5.7
- **Ralph loop exit clean**: Draft NOT complete until SEO + editorial re-reviews both return zero feedback
- **Cover image mandatory**: Phase 7.5 UX research + design + generation must complete before publish; `og:image` must NOT be the site-default fallback
- **Zero unsupported claims**: All assertions must have citations
- **Zero Hugo build breaks**: All content validated for Hugo compatibility
- **Zero readability compromise**: SEO never sacrifices human readability
- **Visual regression**: Zero tolerance — any visual change blocks publish
- **Testing**: Use `bin/rake test` or `bin/rake test:critical` — never create custom test scripts

## Key Commands

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build Hugo site |
| `bin/hugo-dev` | Start Hugo dev server on :1313 |
| `bin/rake test` | Run all tests |
| `bin/rake test:critical` | Run critical tests only |
| `bin/generate-cover-image <slug> "concept"` | Generate post cover via gemini CLI (requires `GEMINI_API_KEY`) |

## File Structure

| Path | Purpose |
|------|---------|
| `content/blog/` | Blog posts (Markdown + frontmatter) |
| `content/blog/<slug>/cover.jpg` | Per-post 1200×630 cover image (page resource) |
| `layouts/` | Hugo templates |
| `assets/css/` | CSS/PostCSS source |
| `static/` | Static assets |
| `.stitch/` | Stitch project scratch (DESIGN.md, designs/, metadata) — NOT committed |
| `docs/projects/2510-seo-content-strategy/20-29-strategy/20.06-blog-cover-image-design-system.md` | Canonical cover image design system |

## Execution Policy

- Prefer smallest skill set for end-to-end task completion
- Workflow: `research → design → implementation → validation → docs/publish`
- Multi-file changes: include `incremental-implementation`
- Autonomous pipeline: runs end-to-end with quality gates at each phase
- Cover image generation is a three-step sub-pipeline (research → design → generate), NOT a single tool call

## 🔍 Research Protocol (MANDATORY)

Always use semantic search **before** making changes. For gemini CLI, use `@` context injection or configured MCP servers:

**Step 1 — Search existing patterns** (codebase):
> Search `/Users/pftg/dev/jetthoughts.github.io` for: "[pattern]"

**Step 2 — Check knowledge standards**:
> Search `/Users/pftg/dev/jetthoughts.github.io/docs` for: "[topic]"

**Step 3 — Framework docs** (when needed):
> Retrieve library docs for "[framework]"

**Never** grep/find blindly for existing code patterns — use semantic search as the primary research tool.
