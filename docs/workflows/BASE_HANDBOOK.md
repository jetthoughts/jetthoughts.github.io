# Base Handbook (Shared Rules)

Use this as the shared boilerplate for agents and skills. Keep agent/skill files thin and reference this.

## Non-Negotiables
- Zero generic AI language
- Zero unsupported claims (cite sources)
- Zero Hugo build breaks (`bin/hugo-build` required for content changes)
- No custom test scripts (use `bin/rake test:critical`)
- Avoid Python scripts for analysis; prefer `rg`, `sed`, `awk`, and shell tools
- No duplicate throwaway files (`*_refactored.*`, `*_new.*`, `*_backup.*`)
- New docs are allowed only under `docs/workflows/` (else edit existing files)
- If user says “code is bad” or “over-engineered”: HALT, perform 5-Why analysis, fix config, then proceed

## Research Protocol (Mandatory)
1. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"`
2. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io/knowledge for: "[topic]"`
3. `Get library docs for "[framework]"`

Never grep/find for code patterns; use claude-context MCP semantic search.

## Testing
- TDD: RED → GREEN → REFACTOR (see `/knowledge/20.01-*`, `/knowledge/20.11-*`)
- Test quality: behavior-focused only (see `/knowledge/25.04-*`)
- Minitest only; never `*.sh` test scripts
- Run `bin/rake test:critical` after every micro-change (<10 lines)

## Visual Validation (CSS/HTML/JS changes)
- Tolerance: 0.0 for refactors, ≤0.03 for new features
- Use Chrome DevTools to verify console/network are clean (zero errors, zero 404s)
