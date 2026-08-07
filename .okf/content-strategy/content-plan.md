---
type: Reference
title: "Content Plan — Data-Driven Q3 2026"
description: Active 3-stream content plan based on GSC performance data (Apr–Jul 2026). Rails technical deep-dives (2/week), snippet hygiene rewrites, founder content (every other week). Supersedes 20.07.
resource: docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md
tags: [content-strategy, seo, content-plan, blog]
generated:
  by: process:okf-migrate
  at: 2026-08-07T00:00:00Z
---

# Overview

Supersedes the ICP-E-focused [20.07 plan](https://github.com/jetthoughts/jetthoughts.github.io/blob/emdash/seo/docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md).
Built from 3 months of GSC data (449 clicks, 478K impressions, 0.09% CTR).

**Core finding**: Every click-driving page is technical Rails/Ruby/CSS content.
Zero ICP-E founder posts rank in the top 50 pages by clicks. The old AI
framework content (langchain, crewai, autogen) gets 107K+ impressions with
near-zero CTR.

# Strategy

**Thesis**: Build search traffic through Rails technical authority, then convert
with internal links to founder-focused service pages.

Three streams:

| Stream | Frequency | Role |
|---|---|---|
| **Rails Technical** | 2/week (3 aspirational) | Search traffic + authority |
| **Snippet Hygiene** | 1-week sprint (done Jul 19) | Reclaim 107K wasted impressions |
| **Founder / ICP-E** | Every other week (6 total) | Lead gen + LinkedIn |

# Key deliverables

- **Snippet hygiene**: 5 worst 0-CTR pages had titles/metas rewritten
  (langgraph 44K impr, autogen-crewai 12.2K, crewai 11.7K, langchain-memory
  7.8K, laravel-11 19.2K). Projected +435 clicks/3mo.
- **Phase 1 expanders (3 of 5 done)**: Falcon Production Tuning ✅, Solid
  Queue Advanced Patterns ✅, Rails 8 Authentication Generator ✅, Solid
  Cache Deep Dive 🔲, Kamal 2 Multi-Server 🔲 — extending the highest-click
  posts. All 3 published posts passed blog pipeline validation (voice
  self-test 10/10, zero banned words, zero em dashes, Hugo build clean).
- **Bidirectional funnel**: every Rails post links to a founder post or
  service page; every founder post links to 2+ Rails posts.

# Snippet hygiene rewrites (applied 2026-07-19)

| Post | Old title | New title | TL;DR |
|---|---|---|---|
| langgraph-workflows | "Mastering LangGraph: Building Complex AI Agent Workflows…" | "LangGraph Tutorial: Build AI Agents with State Machines (Python)" | ✅ |
| autogen-crewai-langgraph | "LangGraph vs CrewAI vs AutoGen: Open Source Alternatives 2025" | "LangGraph vs CrewAI vs AutoGen: Which AI Agent Framework? (2026)" | ✅ |
| crewai-multi-agent | "CrewAI Hierarchical Agents: Manager-Worker Orchestration" | "CrewAI Hierarchical Agents: Manager-Worker Pattern" | ✅ |
| langchain-memory | "Building Stateful Conversational AI with LangChain Memory Systems" | "LangChain Memory: Conversation History with Python" | ✅ |
| laravel-11-migration | "Laravel 11 Migration Guide: Complete Production Deployment Strategies" | "Laravel 11 Upgrade Guide: Step-by-Step Migration" | ✅ |

# Phase 1 expanders — published (2026-07-19)

| # | Post | Slug | Status |
|---|---|---|---|
| E1 | Falcon in Production: Benchmarks, Memory & Worker Count | `falcon-web-server-production-tuning-benchmarks` | ✅ Published + cover |
| E2 | Solid Queue Advanced: Retries, Concurrency & Monitoring | `solid-queue-advanced-patterns-retries-concurrency` | ✅ Published + cover |
| E3 | Rails 8 Authentication Generator: Complete Guide | `rails-8-authentication-generator-complete-guide` | ✅ Published + cover |

# Build infrastructure (2026-07-19)

- PostCSS installed (`postcss` + `postcss-cli`) — `bin/hugo-build` now passes (740 pages)
- Cover image pipeline established: Chrome headless 2× retina → Lanczos downsample
- 3 cover images generated (Falcon 595KB, Solid Queue 611KB, Rails Auth 600KB)
- Frontmatter fix: langgraph slug concatenation bug resolved

# Immediate actions (from the plan)

1. Elital subdomain cleanup (53K junk upwork-login impressions)
2. Rewrite 5 worst 0-CTR titles/metas — **completed 2026-07-19**
3. Add TL;DR blocks to all 5 worst 0-CTR posts — **completed 2026-07-19**
4. Consolidate 4 cannibalized Rails performance posts into 1 canonical — **done (existing)**: Hugo aliases from `ruby-on-rails-performance-optimization-patterns-2026` cover all 5 old URLs. jtway.co redirects added for missing Medium migration entries.
5. Fix `/services/` page title (zero stack keywords, 202 impr, 0 clicks) — **done (existing)**: title already reads "Ruby on Rails & React Development Services | JetThoughts" with stack keywords and description including retention stat.

# Before writing a queued row: check it is not already covered (2026-08-07)

A row in the plan naming a NEW slug does not mean the topic is uncovered. Two
Q3 rows target keywords an existing post already ranks for, so writing them as
new posts would split the ranking - the exact Priority-3 cannibalization the
same plan warns about:

| Row | Existing post that owns it | Correct action |
|---|---|---|
| E3 `solid-cache-vs-redis-production-benchmarks` | `rails-8-solid-cache-performance-redis-migration` (908 lines) | Upgrade in place |
| F1 `propshaft-migration-complete-guide-rails-8` | `propshaft-vs-sprockets-rails-8-asset-pipeline-migration` (1,523 lines, pos 12.8 / 8,832 impr) | Upgrade in place |

Rule: before drafting any queued row, run `ls content/blog/ | grep -i <term>`
and read anything that matches. If a post already covers the keyword, upgrade
it and take the next row instead. Cheap check, expensive miss.

Also corrected: the plan's funnel section named `/services/startup-cto-consulting/`,
which does not exist. Real paths live in `content/services/` - `fractional-cto`,
`technical-leadership-consulting`, `app-web-development`. Verify before linking.

# Status (2026-08-07)

Published from this plan: E1 Falcon (Jul 22), E2 Solid Queue (Jul 24), F2 Rails 8
Auth Generator (Jul 29). E4 Kamal 2 multi-server published Aug 7 (PR #437) - taken ahead of
E3/F1 because all six existing Kamal posts are single-server and 2024-era, so it
splits no ranking.

# Technical posts need a source-verification pass, not just a voice pass (2026-08-07)

The E4 draft went through the standard 3-persona loop and still carried a
correctness bug that would have broken readers' deploys: it told them to run
migrations from a `pre-deploy` hook with bare `kamal app exec`. That resolves to
the `latest` tag, but Kamal only moves `latest` after every host boots - so the
hook runs the release being replaced. The fix is `--version "$KAMAL_VERSION"`.

The founder-persona critic cannot catch this class of defect, and the voice and
SEO critics do not read source. For any developer-targeted post, replace the
ICP-E founder persona with a practitioner critic that verifies every claim, flag,
default, and error string against a PINNED upstream commit and reports file:line.
On E4 that critic caught the migration bug, a self-contradiction about `--target`,
and a wrong `drain_timeout` default; the cold-eyes gate then caught a wrong claim
about Sidekiq-Cron's dedup behavior and a wrong date for kamal-proxy PR #124.
Five factual defects, none of which voice review would ever surface.

Cite technical claims as GitHub permalinks pinned to the released tag
(`/blob/v2.12.0/...#L161`), not bare `file:line` - line numbers rot.

# Citations

[1] `docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md`
[2] GSC data export: `jetthoughts.com-Performance-on-Search-2026-07-19/`
