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
| `@docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` | ANY content, blog post, design, landing page, or marketing work |
| `@docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` | Writing ANY blog post or marketing copy — voice, tone, banned words, anti-AI structural patterns |
| `@docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` | Writing tech/Rails posts — thoughtbot content patterns, code example standards |
| `@docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md` | Writing the next blog post or planning content |
| `@bin/hugo-build` | Build/deploy workflow |
| `@Rakefile` | Test workflow |
| `@test/test_helper.rb` | Writing new tests |
| `@docs/projects/2509-css-migration/css-loading-order-analysis.md` | ANY CSS changes |

---

## 🔍 Research Protocol (MANDATORY)

**Session start**: Always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

Prefer **skills** over agents. Use agents only when a task explicitly requires them.

Always use claude-context MCP search **before** making changes:

1. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"`
2. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io/knowledge for: "[topic]"`
3. `Get library docs for "[framework]"`

**Option 2 — DeepWiki** (when claude-context doesn't have enough context or for repo-level questions):
- `ask_question` about `jetthoughts/jetthoughts.github.io` for AI-powered answers about the repo
- `read_wiki_structure` / `read_wiki_contents` for browsing repo documentation

**After:** grep/find and other tools for search code patterns — use claude-context MCP semantic search first (100x faster), then deepwiki as fallback.

### Finding blog posts to reference (MANDATORY for content work)
When writing a blog post and looking for internal links, **always use claude-context first**:
```
Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "transparency weekly reports"
```
For exact slug/tag lookups, see the post index at `docs/blog-post-index.md` (584 posts, 135 tags, process posts table).
**Never guess slugs** — verify with `ls content/blog/<slug>/index.md` before linking.

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

## 📁 Workflow Pointers

- CSS consolidation rules: `docs/workflows/css-consolidation.md`
- Blog pipeline: `docs/workflows/blog-pipeline.md`
- Cover images: `docs/workflows/cover-images.md` (canonical spec remains `.stitch/design.md`)
- **Content plan (active)**: `docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md`
- Commands & hooks overview: `docs/workflows/commands.md`
- Agent strategy: `docs/workflows/agents.md`

---

## 🚨 Behavioral Constraints

- **Zero generic AI language**: All AI-sounding phrases flagged and rejected
- **Zero unsupported claims**: All assertions must have citations
- **Zero Hugo build breaks**: All content validated via `bin/hugo-build`
- **Zero custom test scripts**: Use `bin/rake test:critical` only
- **No Python scripts for analysis**: Prefer `rg`, `sed`, `awk`, and shell tools
- **Zero tolerance for duplicates**: No `*_refactored.*`, `*_new.*`, `*_backup.*` files
- **New docs allowed only under** `docs/workflows/` (else edit existing files)
- **Reflection triggers**: User reports "code is bad" / "over-engineered" → HALT, 5-Why analysis, fix config, THEN proceed

### ✍️ Anti-AI Writing Enforcement (MANDATORY for all content)

**Before writing ANY blog post or marketing content**, read these 3 files:
1. `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` — voice, banned words, structural patterns
2. `docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` — thoughtbot patterns to follow
3. The humanizer skill patterns (Wikipedia AI writing signs) — run `/humanizer` after every draft

**Zero tolerance AI patterns** — reject on sight:
- Rule of three: "X, Y, and Z" parallel triads (break the pattern: combine two, vary the third)
- Signposting: "This post is about...", "Here's what you need to know", "Let's explore..."
- Bold inline-header lists: "**Speed:** fast. **Quality:** good." → write prose instead
- Negative parallelism: "It's not X — it's Y" and "Not just... but also..."
- Triple rhetorical questions in a row
- Slogany parallel closings: "X is A. Y is B."
- Therapist voice: "That's the hardest part", "The next step is smaller than you think"
- Copula avoidance: "serves as", "stands as", "marks a" → use "is"

**Write like a human** — every sentence must pass the "would a tired founder actually talk like this?" test:
- Vary sentence length unpredictably (not short-short-long, short-short-long)
- Use "I" and "we" with specific, concrete memories
- Interrupt yourself with asides, parentheticals, half-thoughts
- Admit uncertainty: "I genuinely don't know" beats "the implications remain unclear"
- Kill your ideas publicly: "We tried X. It didn't work. So we stopped."
- Reference voice: Rob Walling (directness) + Rand Fishkin (vulnerability) for founder posts; thoughtbot blog for tech posts

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
**ICP**: Non-technical founder burned by a devshop. See `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`

## Tooling Preference
- Use `bun` for JS dependency installs and scripts; do not use `npm`.
