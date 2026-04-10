# AGENTS.md — JetThoughts Blog (Junie)

**Type**: Hugo static site | **Build**: `bin/hugo-build` | **Test**: `bin/rake test:critical`

## 📌 Critical Files — READ BEFORE CHANGES

| File | When to Read |
|------|-------------|
| `@config/_default/hugo.toml` | ANY Hugo config change |
| `@themes/beaver/layouts/partials/blog/img-cropped.html` | Blog cover/thumbnail changes |
| `@themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` | SEO/meta tag changes |
| `@.stitch/design.md` | Cover image generation |
| `@docs/projects/2509-css-migration/css-loading-order-analysis.md` | ANY CSS changes |
| `@bin/hugo-build` | Build/deploy workflow |

## 🔍 Research Protocol (MANDATORY)

1. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"`
2. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io/knowledge for: "[topic]"`
3. `Get library docs for "[framework]"`

**Never** grep/find for code — use claude-context MCP semantic search.

## 🧪 TDD & Testing

- **TDD**: RED → GREEN → REFACTOR. See `/knowledge/20.01-*`, `/knowledge/20.11-*`
- **Test Quality**: Behavior-focused only. Reject implementation/existence tests. See `/knowledge/25.04-*`
- **Framework**: Minitest only. NEVER `*.sh` test scripts
- **Test Runner**: `bin/rake test:critical` after every micro-change
- **Visual tolerance**: 0.0 for refactoring, ≤0.03 for new features

## 📁 CSS Rules

- **NEVER modify**: vendor files, dynamic templates
- **Test after each extraction**: `bin/rake test:critical`

## 🤖 Autonomous Blog Pipeline

9 phases: Trend → Strategy → Research → Ideation → Draft → AI Quality Check (slop-detector → humanizer) → SEO → Hugo Build → Improvement. Full spec in `CLAUDE.md`.

## 🖼️ Cover Images

**Full spec**: `.stitch/design.md` (canonical) | Stitch project: `3224353017067976684`

**6-slot layout (MANDATORY)**: brand+category (top-L) · year pill (top-R) · 3-line hero (white/**gradient**/white, mid-L) · ruby gem SVG (mid-R) · 3 stat chips (bot-L) · status indicator (bot-R)

**Anti-redundancy**: pill carries YEAR not version · stat chips carry facts NOT in the H1 · no footer meta

**Reference files**: `.stitch/designs/rails-8-1-active-job-continuations-cover.html` · `.stitch/designs/rails-argon2-has-secure-password-cover.html`. Always duplicate.

**Pipeline**: HTML → chrome-devtools 2× render → Lanczos downsample → `content/blog/<slug>/cover.png` → `bin/hugo-build`. Frontmatter: `metatags.image: cover.png`.

**Thumbnail**: aspect-preserving 360×189 · NEVER center-crop.

## 🚨 Behavioral Constraints

- Zero AI language, zero unsupported claims, zero build breaks
- Zero custom test scripts, zero duplicate files, zero new .md docs
- Reflection triggers: "code is bad" / "over-engineered" → HALT, analyze, fix

## 📋 Key Commands

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build site |
| `bin/rake test:critical` | Run tests |
