# GEMINI.md — JetThoughts Blog

**Type**: Hugo static site | **Build**: `bin/hugo-build` | **Test**: `bin/rake test:critical`

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
- **Cascade order**: Critical → Layout → Component → Theme → Footer

## 🤖 Autonomous Blog Pipeline

9 phases: Trend → Strategy → Research → Ideation → Draft → AI Quality Check (slop-detector → humanizer) → SEO → Hugo Build → Improvement. Full spec in `CLAUDE.md`.

## 🖼️ Cover Images

Source: PNG 2400×1260 (2x) → Hugo converts to JPG q90. Frontmatter: `metatags.image: cover.png`
Full spec: `.stitch/design.md` | Stitch project: `3224353017067976684`

## 🚨 Behavioral Constraints

- Zero AI language, zero unsupported claims, zero build breaks
- Zero custom test scripts, zero duplicate files, zero new .md docs
- Reflection triggers: "code is bad" / "over-engineered" → HALT, analyze, fix

## 📋 Key Commands

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build site |
| `bin/rake test:critical` | Run tests |
