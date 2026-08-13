---
type: Reference
title: "Content Plan — Pipeline-First Revision (Aug 2026)"
description: Pipeline-first content plan (20.09, Aug 2026). Content is gated on 2607 outreach being unblocked; capacity is ~6 posts/month; durable news swaps in, event news goes to LinkedIn. Retains 20.08's GSC baseline analysis.
resource: docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md
tags: [content-strategy, seo, content-plan, blog]
generated:
  by: process:okf-migrate
  at: 2026-08-07T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-13T09:56:20Z
---

# Plan of record (2026-08-07)

`20.09-content-plan-revision-aug-2026.md` supersedes 20.08's allocation, cadence,
and click projection. 20.08's GSC analysis below is still correct.

**The governing rule now sits above the content plan.** 2607's rabbit-hole:
"Never ship a content sprint while the outreach is stalled." Outreach IS stalled
(`backlog.md:95` - all batch-1 messages HOLD, zero sendable rows), so P0 is
unblocking the pipeline, not writing.

**Four things 20.08 got wrong**, all verified 2026-08-07:
1. Real capacity is ~6 posts/month, not 2-3/week. June 2026 produced ZERO posts.
2. The 435-click snippet projection predates AI Overviews (~61% CTR loss on
   informational SERPs). Re-baseline before spending on it.
   **Falsified 2026-08-13** - the rewrites shipped (langgraph, crewai, autogen,
   `/services/`, homepage) and Google cut impressions instead of granting
   clicks: `rails-testing-best-practices` 9,997 -> 2,231 impressions (-78%) for
   +3 clicks; `langgraph-workflows` left the top 15 by impressions entirely;
   `falcon-web-server` -85% impressions. Do not run a second rewrite wave on
   this thesis.
3. Seven queued rows duplicate posts already on disk; F2 already shipped and
   created a 4-post Rails-8-authentication cluster.
4. The Rails-post-to-rescue-client funnel is imagined. Paul's 2026-08-07 exemption
   removed service links from technical posts, amputating the stated mechanism.

**Biggest single win, needs no new content**: `/services/vibe-code-rescue/` - the
conversion page for the company's only active bet - has ZERO inbound links from
608 blog posts. Six rescue-adjacent posts (fire-dev-shop-guide,
dev-shop-red-flags-checklist, hiring-dev-shop-questions, vibe-coding-crisis,
quality-tax, 47-startups) each link to it zero times.

**Status 2026-08-13**: linking is DONE - seven posts now point at
`/services/vibe-code-rescue/` (the six above plus
`migrate-lovable-replit-app-to-rails`), and the page is indexed (`PASS`,
crawled 2026-07-31). It did not move the needle: **3 impressions, 0 clicks**.
The linking posts have near-zero organic traffic themselves, so there is no
equity to pass. Internal linking was necessary and is not sufficient; the
constraint is that no rescue-intent page has search demand reaching it
(`dev shop` query cluster: 99 impressions, 0 clicks over 90 days).

# News policy: durable vs event (2026-08-07)

One test: **will someone search this in six months?**
- Durable (CVEs, releases, EOLs) -> blog, via SWAP against a queued row, never as
  an added slot. Throughput is the binding constraint.
- Event (incidents, drama, funding) -> LinkedIn only. Evidence: the PocketOS post
  scored 48/50, ran the full pipeline, earned 1 click in 3 months.

Version-current content incurs refresh debt - budget 1 refresh slot/month. Proof
it compounds: the Kamal 1/Traefik post is now factually wrong and still ranking.

# Overview

Supersedes the ICP-E-focused [20.07 plan](https://github.com/jetthoughts/jetthoughts.github.io/blob/emdash/seo/docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md).
Built from 3 months of GSC data (449 clicks, 478K impressions, 0.09% CTR).
Those impressions are `sc-domain:`-wide and heavily polluted - read
[analytics-access](/workflows/analytics-access.md) before deriving anything
from that CTR.

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
- **Phase 1 expanders (4 of 5 done)**: Falcon Production Tuning ✅, Solid
  Queue Advanced Patterns ✅, Rails 8 Authentication Generator ✅, Kamal 2
  Multi-Server ✅ (2026-08-07), Solid Cache Deep Dive ⛔ upgrade-in-place —
  extending the highest-click posts. All published posts passed blog pipeline
  validation (zero banned words, zero em dashes, Hugo build clean).
- **Bidirectional funnel**: every Rails post links to a founder post or
  service page; every founder post links to 2+ Rails posts.
  **Exemption (Paul, 2026-08-07)**: deep-technical developer-targeted posts
  drop the service link entirely - it lands on the wrong reader and costs
  credibility with engineers. They still cross-link sibling technical posts.
  Founder-stream posts keep the requirement in full.

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
