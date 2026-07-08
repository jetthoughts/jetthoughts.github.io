# Blog Post Pipeline Skill
#
# Reusable 9-phase autonomous content pipeline for Hugo-based blogs.
# This is a PRODUCER skill — published by jetthoughts/site for other repos.

## Overview
End-to-end pipeline from topic selection to published post with automated
quality gates, multi-critic review, and cover image generation.

## Phases
1. Pick topic from content plan
2. Read context (ICP, voice guide, brief)
3. Research (5+ authoritative sources)
4. Draft with voice enforcement + cadence quotas
5. Review loop (3 parallel critic agents: founder, SEO/slop, editor)
5c. Cold-eyes gate (9 explicit checks)
6. Cover image (6-slot HTML → chrome-devtools render → lanczos downsample)
7. Validate (Hugo build + Chrome DevTools)
8. Update content plan
9. Commit

## Dependencies
### MCP Servers
- claude-context — semantic codebase search for existing posts
- brave-search / searxng — web research
- chrome-devtools — cover image rendering, validation

### Other Skills
- content-voice-enforcement — voice guide compliance
- cover-image-generation — 6-slot layout rendering

### Agents
- content-creator — drafting
- seo-specialist — SEO compliance
- reviewer — quality gates

## Trigger
@.apm/prompts/blog-pipeline.prompt.md

## Full Documentation
docs/workflows/blog-pipeline.md
