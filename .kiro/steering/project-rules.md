---
inclusion: always
---

# JetThoughts Site — Project Rules
#
# This is the SINGLE SOURCE for AI agent instructions across all tools.
# APM compiles this to each tool's expected path (CLAUDE.md, .github/
# copilot-instructions.md, etc.). Edit here, not in tool-specific files.
#
# CANONICAL SOURCE: THIS FILE. The existing CLAUDE.md is a Claude-specific
# superset; over time CLI tool instructions converge here. Voice, ICP, TDD,
# and CSS rules are split into separate instruction files for modularity.
#
# Full workflow docs: docs/workflows/
# Full content docs: docs/90-99-content-strategy/

## Stack
- **Site**: Hugo 0.147.9 Extended static site generator
- **Theme**: Custom "Beaver" theme (BEM + PostCSS)
- **Tests**: Ruby 3.4, Minitest, Capybara, Selenium WebDriver
- **CSS**: PostCSS pipeline (autoprefixer, cssnano, purgecss)
- **Package managers**: Bun (JS, NOT npm), Bundler (Ruby)
- **CI/CD**: GitHub Actions → GitHub Pages

## Build & Test Commands
- Build: `bin/hugo-build`
- Test (critical): `bin/rake test:critical`
- Test (visual/macOS): `bin/test`
- Test (visual/Linux Docker): `bin/dtest`
- Lint Ruby: `bundle exec standardrb --fix`

## Research Protocol (MANDATORY — before any change)
1. Search codebase with `claude-context` MCP FIRST
2. Verify exact filenames with `rg`/`ls` as fallback
3. Read `docs/workflows/BASE_HANDBOOK.md` at session start
4. Read `docs/workflows/flow-router.md` to route to correct workflow
5. For blog content: find existing posts via `docs/blog-post-index.md`
6. Never guess slugs — verify with `ls content/blog/<slug>/index.md`

## Non-Negotiables
- **Zero generic AI language** in content — all AI-sounding phrases rejected
- **Zero Hugo build breaks** — `bin/hugo-build` must pass for content changes
- **Zero unsupported claims** — all assertions must have citations
- **No ad hoc test scripts** — use `bin/rake test:critical` and `bin/test`
- **No Python for analysis** — prefer `rg`, `sed`, `awk`, shell tools
- **No duplicate throwaway files** — no `*_refactored.*`, `*_new.*`, `*_backup.*`
- **New docs only under `docs/workflows/`** — else edit existing files
- **Never commit coordinator/verification reports** — write to `/tmp/` instead

## Content Work (Blog Posts, LinkedIn, Pages)
- **BEFORE writing**: Read voice guide + ICP target (see instructions/voice-guide, instructions/icp-target)
- **Blog posts**: Follow `docs/workflows/blog-pipeline.md` end-to-end
- **LinkedIn**: Follow `docs/workflows/linkedin-post-pipeline.md`
- **Cover images**: Follow `docs/workflows/cover-images.md` + `.stitch/design.md`
- Run slop-detector + humanizer pass on all drafts
- Cold-eyes gate (9 checks) mandatory before publishing

## CSS / HTML Changes
- **BEM methodology** mandatory for all new CSS
- **FL-node extraction**: TDD cycle — RED → GREEN → REFACTOR → TEST
- **Visual regression tolerance**: 0.0 for refactors, ≤0.03 for new features
- **MANDATORY**: Run BOTH `bin/test` (macOS) AND `bin/dtest` (Linux Docker) before commit
- **Feature branches**: HTML/CSS/template changes → feature branch → one PR per sprint
- Zero tolerance: CSS class existence testing, framework selector usage in tests

## TDD & Testing
- **Cycle**: RED → GREEN → REFACTOR
- **Framework**: Minitest (test/system/, test/unit/)
- **Behavior-focused tests ONLY** — reject implementation/existence/config tests
- **Avoid fragile config assertions** — assert shape, not tunable values
- **Visual regression**: screenshot comparison, 0.0 tolerance for refactoring
- Run `bin/rake test:critical` after every micro-change (<10 lines)
- Chrome DevTools validation after HTML/CSS/JS changes: zero console errors, zero 404s

## Behavioral Constraints
- **User says "code is bad" or "over-engineered"**: HALT, 5-Why analysis, fix config, proceed
- **Reflection triggers**: zero-defect tracking, test masking detection
- **Four-eyes principle**: paired agents for all critical changes
- **Direct-to-master only for**: content-only blog edits, commit fixes, docs, CLAUDE.md policy updates

@see docs/workflows/ for full workflow documentation
@see docs/90-99-content-strategy/ for content strategy
