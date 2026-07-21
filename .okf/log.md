# Bundle Update Log

## 2026-07-21

* **New concept**: [ci-gates](/build/ci-gates.md) - what GitHub Actions enforces on a PR (build, unit, path-scoped broken-internal-link crawl via lychee in `link-check.yml`). Records that visual regression is intentionally NOT a CI gate: cross-OS pixel diffs (Alpine/musl baselines vs Ubuntu/glibc CI) diverge 3-28%, so `bin/test` + `bin/dtest` are the sole visual coverage (a CI screenshot job was built and removed in PR #386). Includes the libvips42-runtime gotcha for any future ruby-vips CI job.
* **Update**: [test-gates](/build/test-gates.md) - cross-linked to ci-gates; noted visual regression is a local-only gate.

## 2026-07-13
* **Update**: taste anchor established at `.stitch/course-taste-design.md` - Stitch-skill DESIGN.md encoding the course design language + anti-pattern bans; used as the scoring lens for taste-critic passes (see [review-swarm](/workflows/review-swarm.md)).
* **Update**: [render-verification](/workflows/render-verification.md) - render from `_dest/public-dev/` (relative URLs), never the stale repo-root `public/`; stale-tree reviews produce false missing-asset findings.
* **Initialization**: Created the bundle with build/, content/, design/, and workflows/ sections distilled from CLAUDE.md, docs/workflows/, .stitch/design.md, and the 2026-07 course review sprints.

## 2026-07-17 - M2 compression migration
Module 2 (last unmigrated module, 1,652-5,124 body words/lesson) compressed to
exemplar parity (1,265-2,038; migrated 1.4 exemplar = 1,258 on the same basis).
Depth moved to four new reference companions: mom-test-full,
persona-rehearsal-full, find-10-people-full (shared 2.3+2.4),
prototype-build-full. Operative rule learned: the 30.03 numeric bands are
unreachable when mandated keeps (full prompts, teaching tables, reuse bridges)
exceed the band - EXEMPLAR PARITY on an identical measurement basis is the
real gate, not the raw number. M3 (3.1/3.2 at ~2,900w) is the remaining
unmigrated pair.

## 2026-07-17 (later) - Full-course migration complete
M3 (3.1/3.2), M4 (all five), and M5 (5.1/5.2/5.6/5.7) migrated to v2
micro-lesson form in one 5-fixer wave; 11 new reference companions created
(every module now has its deep-dive set). Canon punch-list applied (Cursor
seat range, "Sixty percent" stat, PR #847 collision, fast/easy/free columns,
Chapter 0 -> Overview, faq 12-rules pointer). Cold-eyes M3+ reuse review
fixed 4 restart defects (5.3 warm-list seeding, SOW brief-as-scope, 5.1
persona reconciliation, PRD Section 2). No v1 long-form lessons remain.
Gotcha: claude-flow daemons recreate .git/index.lock continuously - commit
via retry loop (rm lock + immediate git add/commit, up to 10 attempts).
Voice wave (same day): 16-page opener-shape rotation shipped - max 4 pages
per shape, 4 composite-disclaimed vignettes kept, attribution phrases
("we picked up"/"we worked with") now zero course-wide. Teaching numbers
preserved as mechanism descriptions.

## 2026-07-18 - Added course architecture concepts
Added two course architecture concepts to `.okf/architecture/`:
[icp-journey-sipoc](/architecture/icp-journey-sipoc.md) — Mermaid flowchart
of Sam's full journey through all 25 lessons, gate thresholds, branch paths,
and artifact handoffs; and [operational-dependency-map](/architecture/operational-dependency-map.md)
— per-lesson operational prerequisites, template blank sources, wait times,
and Plan B recovery paths. Both distilled from
`docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/`.
Architecture index updated with the two new entries.

## 2026-07-19 (later) - Q3 content plan execution: Phase 1 expanders + snippet hygiene TL;DRs
* **Published**: 3 Phase 1 expander posts from the Q3 content plan:
  - [Falcon in Production: Benchmarks, Memory & Worker Count](/blog/falcon-web-server-production-tuning-benchmarks/) —
    worker sizing formulas, 24-hour memory curves, wrk2 benchmarks, GC tuning,
    rollback case study. 235 lines, 10/10 voice self-test.
  - [Solid Queue Advanced: Retries, Concurrency & Monitoring](/blog/solid-queue-advanced-patterns-retries-concurrency/) —
    exponential backoff, dead letter pattern, I/O profiling, dispatch config,
    queue depth alerts, preserve_finished_jobs gotcha + client story. 324 lines,
    10/10 voice self-test.
  - [Rails 8 Authentication Generator: Complete Guide](/blog/rails-8-authentication-generator-complete-guide/) —
    replaces Devise with built-in auth, sessions table, password reset,
    email verification, rate limiting, production hardening checklist,
    Devise migration case study. 347 lines, 10/10 voice self-test.
* **Cover images**: 3 new covers generated via established pipeline
  (duplicate Falcon HTML → Chrome headless 2× retina → Lanczos downsample):
  Falcon 595KB, Solid Queue 611KB, Rails Auth 600KB — all at 2400×1260.
  Covers live at `.stitch/designs/falcon-production-tuning-cover.html`,
  `.stitch/designs/solid-queue-advanced-cover.html`,
  `.stitch/designs/rails-8-authentication-cover.html`.
* **Snippet hygiene — TL;DR blocks**: TL;DR summary blocks with Quick
  start added to all 5 worst 0-CTR posts (langgraph-workflows, autogen-
  crewai-langgraph, crewai-multi-agent, langchain-memory, laravel-11-
  migration). Each includes 2-3 sentence summary + copy-paste-able quick
  start command sequence for better SERP snippet extraction.
* **Build infrastructure**: PostCSS installed (`npm install --save-dev
  postcss postcss-cli`). `bin/hugo-build` now passes clean (740 pages,
  exit code 0).
* **Bug fixes**: langgraph-workflows frontmatter `---` delimiter had
  concatenated to slug line during TL;DR insertion — split back to
  separate line. All 3 new posts + 3 covers verified in Hugo build.
* **Validation**: All 3 new posts passed blog pipeline validation
  (voice self-test 10/10, zero banned words, zero em dashes, zero
  generalized actors, zero mannerism nouns, zero definitional cadence).
  Solid Queue post received +1 internal link (Rails Auth) and client
  story (April 2026 preserve_finished_jobs disk incident).
* **Content plan** — [content-plan](/content-strategy/content-plan.md) and
  [blog-pipeline](/workflows/blog-pipeline.md) already synced.


* **New**: [content-plan](/content-strategy/content-plan.md) concept — the
  active Q3 2026 3-stream plan built from Apr–Jul GSC performance data (449
  clicks, 478K impressions, 0.09% CTR). Supersedes the ICP-E-focused 20.07
  plan. Rails technical 2/week, founder every other week, snippet hygiene
  sprint. Resource at
  `docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md`.
* **New**: [Falcon Production Tuning](/blog/falcon-web-server-production-tuning-benchmarks/)
  blog post — first Phase 1 expander from the new plan, extending the #1
  performing post (54 clicks, 0.89% CTR) with production worker sizing,
  24-hour memory curves, wrk2 benchmarking methodology, GC tuning, and
  a "when we rolled back to Puma" case study.
* **Update**: [blog-pipeline](/workflows/blog-pipeline.md) — content plan
  reference updated from 20.07 to 20.08; title constraint relaxed from ≤45
  to ≤60 chars (matches Google SERP display limit); added snippet-hygiene
  cross-link to the content-plan concept.
* **Update**: 5 worst 0-CTR blog posts had titles and meta descriptions
  rewritten per the snippet-hygiene sprint (langgraph-workflows, autogen-
  crewai-langgraph, crewai-multi-agent, langchain-memory, laravel-11-
  migration). Projected +435 clicks/3mo. Titles now all ≤60 chars.
* **Update**: [content-strategy index](/content-strategy/index.md) — added
  content-plan entry.

## 2026-07-18 - Merged blog/site bundle into course bundle
Folded a separately-produced Hugo blog/site OKF bundle into this one as two
new sibling sections: `architecture/` (hugo-site, css-pipeline, blog-list-page,
cover-image-pipeline, seo-meta-tags) and `content-strategy/`
(icp-primary-website-target, voice-guide). Added five site/content workflow
concepts to `workflows/` alongside the existing course pair: blog-pipeline,
linkedin-post-pipeline, css-maintainability-plan, visual-scroll-gate, testing.
Root index and workflows index updated with the new entries. No course-side
concepts changed; distilled from CLAUDE.md, bin/hugo-build, Rakefile,
config/_default/hugo.toml, theme layouts, and docs/workflows/ +
docs/90-99-content-strategy/.

## 2026-07-19
- bin/qtest added (scoped visual gate): PRECOMPILED_ASSETS + Minitest -n filter over an ownership-map-derived page set; ~25-60s per micro-commit vs >5 min full stack. Spec Phase C gate stack now items 4 (qtest per commit) + 5 (full suites per milestone/PR). test-gates.md updated.

## 2026-07-19 (2)
- Live incident: visible skip-link site-wide - CI PurgeCSS cold-start race (no hugo_stats.json on first pass). Fixed: safelist sr-only/skip-link (#377) + structural warm-up guard in bin/hugo-build and _hugo.yml (#378). Phase C completed and closed (PRs #371-#376).
