# Claude Code Configuration — JetThoughts Blog

**Type**: Hugo static site blog | **Build**: `bin/hugo-build` | **Test**: `bin/rake test` / `bin/rake test:critical`
**CSS**: PostCSS pipeline | **Content**: `content/blog/` (Markdown + Hugo frontmatter)

---

## 📌 Critical Files — READ BEFORE CHANGES

Always read these files before making changes. They define the project's architecture and constraints.

| File | When to Read |
|------|-------------|
| `@config/_default/hugo.toml` | ANY Hugo/site config change |
| `@themes/beaver/layouts/blog/list.html` | Blog index/listing changes |
| `@themes/beaver/layouts/partials/blog/img-cropped.html` | Blog thumbnail/cover image changes |
| `@themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` | SEO/og:image/meta tag changes |
| `@themes/beaver/layouts/partials/page/cover_image.html` | Blog post cover rendering |
| `@.stitch/design.md` | Cover image generation |
| `@bin/hugo-build` | Build/deploy workflow |
| `@Rakefile` | Test workflow |
| `@test/test_helper.rb` | Writing new tests |
| `@docs/projects/2509-css-migration/css-loading-order-analysis.md` | ANY CSS changes |

---

## 🔍 Research Protocol (MANDATORY)

Always use claude-context MCP search **before** making changes:

1. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"`
2. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io/knowledge for: "[topic]"`
3. `Get library docs for "[framework]"`

**Never** grep/find for code patterns — use claude-context MCP semantic search (100x faster).

## 🧪 TDD & Testing

Follow official methodology from `/knowledge/`:
- **TDD**: RED → GREEN → REFACTOR cycle. See `/knowledge/20.01-tdd-methodology-reference.md` and `/knowledge/20.11-tdd-agent-delegation-how-to.md`
- **Test Quality**: Behavior-focused ONLY. Reject implementation/existence/config tests. See `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md`
- **Framework**: Minitest (`test/system/`, `test/unit/`). NEVER create `*.sh` test scripts
- **Test Runner**: `bin/rake test:critical` after every micro-change (< 10 lines)

### Visual Regression (MANDATORY for CSS/HTML changes)
- **Tolerance**: 0.0 for refactoring (zero visual changes), ≤0.03 for new features only
- **Protocol**: Capture baseline screenshots BEFORE changes → compare AFTER → block commit on any difference > 0% during refactoring
- **Reference**: `docs/visual_testing_delegation_workflows.md`

### Chrome DevTools Validation (MANDATORY after HTML/CSS/JS changes)
1. Start Hugo dev server, open page in Chrome DevTools
2. Check Console — zero JS errors (ZERO tolerance)
3. Check Network tab — zero 404s for assets (ZERO tolerance)
4. Capture desktop + mobile screenshots, verify Core Web Vitals
5. All gates pass → commit. Any gate fails → investigate, fix, repeat

---

## 📁 CSS Consolidation Rules

**NEVER modify**: vendor files (`css/vendors/*.min.css`), dynamic templates (`css/dynamic-*.css`)
**Cascade order (preserve)**: Critical → Layout → Component → Theme → Footer
**Extraction strategy**: Extract whole rule sets (.fl-row, .fl-col patterns) to `fl-foundation.css`. Keep page-specific `.fl-node-{hash}` selectors in original files
**Test after each extraction**: `bin/rake test:critical`

Full analysis: `docs/projects/2509-css-migration/css-loading-order-analysis.md`

---

## 🤖 Autonomous Blog Pipeline

9-phase workflow coordinated by `blog-coordinator` agent:
1. **Trend Discovery** (`social-media-trends-research` + `keyword-research`) → ≥5 viable topics
2. **Strategy** (`content-strategy` + `content-calendar-planner`) → shareability ≥7/10
3. **Research** (`competitor-intel` + `web-research-workflow`) → ≥8 sources, ≥1 expert quote
4. **Ideation** (`blog-post` + `copywriting-core`) → 3-5 takeaways, compelling hook
5. **Draft & Edit** (`blog-writer` + `content-production` + `copy-editing`) → Zero AI phrases, paragraphs ≤3 sentences
6. **AI Quality Check** (`slop-detector` → `humanizer` if flagged) → must pass clean
7. **SEO & Performance** (`seo` + `seo-aeo-audit` + `pagespeed-insights`) → Flesch ≥60
8. **Hugo Build** (`hugo` + `obsidian-markdown`) → `bin/hugo-build` passes
9. **Continuous Improvement** (`self-improving-agent`) → lessons stored

### Cover Image Workflow
Source: PNG 2400×1260 (2x) → Hugo converts to JPG q90 for og:image (1200×630) + thumbnails (180×180)
Frontmatter: `metatags.image: cover.png` (primary) or `cover_image: "cover.png"`
Full spec: `.stitch/design.md` | Stitch project: `3224353017067976684`

---

## 🚨 Behavioral Constraints

- **Zero generic AI language**: All AI-sounding phrases flagged and rejected
- **Zero unsupported claims**: All assertions must have citations
- **Zero Hugo build breaks**: All content validated via `bin/hugo-build`
- **Zero custom test scripts**: Use `bin/rake test:critical` only
- **Zero tolerance for duplicates**: No `*_refactored.*`, `*_new.*`, `*_backup.*` files
- **Never create new .md docs**: Edit existing files only
- **Reflection triggers**: User reports "code is bad" / "over-engineered" → HALT, 5-Why analysis, fix config, THEN proceed

---

## 📋 Quick Reference

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build + validate site |
| `bin/rake test:critical` | Run critical tests |
| `Search the codebase at /knowledge/ for: "[topic]"` | Global standards |
| `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"` | Local patterns |

**Coverage**: Full codebase indexed (830+ files, 4,184+ semantic chunks)
**Design System**: JetVelocity — obsidian dark, Ruby red (#cc342d), neon purple (#a855f7). See `.stitch/design.md`
