---
type: Reference
title: "Content Plan — Data-Driven Q3 2026"
description: Active 3-stream content plan based on GSC performance data (Apr–Jul 2026). Rails technical deep-dives (2/week), snippet hygiene rewrites, founder content (every other week). Supersedes 20.07.
resource: docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md
tags: [content-strategy, seo, content-plan, blog]
timestamp: 2026-07-19T18:00:00Z
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
4. Consolidate 4 cannibalized Rails performance posts into 1 canonical
5. Fix `/services/` page title (zero stack keywords, 202 impr, 0 clicks)

# Citations

[1] `docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md`
[2] GSC data export: `jetthoughts.com-Performance-on-Search-2026-07-19/`
