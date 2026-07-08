---
{}
---

# Research Protocol — Trigger Prompt
#
# Reusable prompt for research-first development.
# MANDATORY sequence before any implementation.

Research this topic before implementing: {TOPIC}

## Research Sequence
1. **Handbook search**: Search claude-context for existing patterns in /knowledge/ and docs/
2. **Codebase search**: Search claude-context for similar implementations in this repo
3. **Framework docs**: context7 for official documentation (Hugo, PostCSS, Ruby, etc.)
4. **Package analysis**: package-search for dependency research (if using new packages)
5. **Web search**: brave-search / searxng for current best practices (2025-2026)

## Output Requirements
- 5+ authoritative sources
- Existing patterns found (or confirmation of none)
- Framework documentation citations
- Dependency evaluation (if applicable)
- Recommendation with trade-offs

## Anti-Patterns (BLOCKED)
- Implementation before research
- Single-source decisions
- Dependencies installed without package-search verification
- Slugs guessed without ls content/blog/ verification