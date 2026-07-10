# Project 2605 - Master Index

**Project**: Tech for Non-Technical Founders 2026
**Status**: 🟢 Course LIVE (PR #345) · 🟢 M2 v2 COMPLETE on PR #351 (awaiting merge) · 🔲 M3 next
**Last Updated**: 2026-07-10 (M2 done: flattened 2.1-2.6 with Synthesis as 2.5, walkthrough, all review rounds closed, regression ratchet validator live - see 40.12/40.13/40.14)
**Parent**: `../2510-seo-content-strategy/`

This is the **single navigation hub** for the 2605 project. Read top-to-bottom on first visit.

---

## 🚀 IMMEDIATE ACTION - START HERE

**The course is merged and live** (PR #345, squash 90216d2f): 5 modules, 24 spine chapters (count derives from `data/course_sequence.yaml` via the `course-stat` shortcode - never hardcode it), live at `/course/tech-for-non-technical-founders-2026/`. Module 1 is fully v2 (lessons **1.1-1.5**) with redesigned landing, covers, and four review rounds resolved.
**Strategic pivot (2026-06-07)**: v2 (micro-learning format) is the next iteration based on `30.03-course-format-requirements-for-creators.md`. All 21 v1 chapters score 1.0-1.5/8 against the 8-part template (per 40.08 gap report). The 5 micro-lesson exploration drafts (Mom Test 3-lesson sequence + paid-pilot + mom-test-5-questions) were removed 2026-06-08 to start the migration from a clean slate; the **Quickstart and FAQ pages remain in `content/course/...`** as the v2 entry points already wired into the landing.

**Currently in flight**: nothing - PR #351 (Module 2 complete) awaits merge. Next work stream: M3 migration, using M1+M2 lessons as the pattern and the ratchet discipline from 40.13 (every review fix adds its signature to data/course_banned_strings.yaml in the same commit).

Post-ship work is tracked in `TASK-TRACKER.md` (see "Course Migration Schedule" section for the 4-phase rollout). Review docs in `40-49-review/`.

### For a micro-lesson migration agent (Phase 1-2 of TASK-TRACKER "Course Migration Schedule")

```
1. Read TASK-TRACKER.md — "Active Phase" + "Next sprint candidates". Pick ONE task.
2. Read 30-39-architecture-design/30.03-course-format-requirements-for-creators.md — CANONICAL spec for the v2 format. §2 = 8-part template (non-negotiable). §2.7 = case-study-at-module-end rule. Appendix A = worked example.
3. Read 40-49-review/40.08-chapter-template-gap-report.md — every v1 chapter scored against the spec. Use as the "starting state" map.
4. Reference 40-49-review/_ARCHIVED_40.09-mom-test-micro-lesson-qa-report.md ONLY for the QA methodology pattern (criterion-by-criterion binary scoring).
5. Read the pilot lessons as the canonical implementation pattern:
   - all five Module 1 lessons (now numbered 1.1-1.5): form-your-founding-hypothesis-90-minute-sprint (1.1), smoke-test-build-page (1.2), smoke-test-wire-tracking (1.3), smoke-test-landing-page-7-day-demand-test (1.4), price-hypothesis-on-smoke-test-page (1.5) - plus module-1-walkthrough-mia
6. Open the v2 production pages already wired into the landing: content/course/tech-for-non-technical-founders-2026/quickstart/ + .../faq/
7. Voice gates: no em-dashes (use `-` not `—`); no "Founders who"/"Most founders"/"## Why this matters"/"ICP-E"; no template labels visible in published content; ZERO case studies inside lesson body (they live at module-end walkthrough page). The `See it in action` footer link is added in the SAME commit that publishes the module's walkthrough page - never before; otherwise the lesson promises a page that does not exist.
8. After every micro-lesson rewrite: run bin/validate-course + em-dash sweep + Hugo build + mobile viewport check at 375px.
9. Atomic unit = 1 lesson. Write, validate, commit. THEN move to next. Never batch.
10. After each commit: update TASK-TRACKER.md "What just shipped." Before stopping: commit + push TASK-TRACKER.
```

### For an executing writer / task agent (single-session shortcut on v1 long-form)

```
1. Read TASK-TRACKER.md — identify the highest-priority un-spawned task (P1 items first).
2. If task references a new chapter or revision: open the target file at content/course/...
3. Run the gates in 50-59-execution/mechanical-audit-checklist.md after writing/editing.
4. Pass → mark task complete in TASK-TRACKER.md.
5. Fail → surface specific failures to user. Stop.
6. Before shipping any revision, run voice-regression sweep: grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with" across edited files.
```

### Files a fresh session reads for post-ship tasks

| File | Purpose |
|---|---|
| `30-39-architecture-design/30.03-course-format-requirements-for-creators.md` | **CANONICAL v2 spec** — micro-learning course format requirements, 8-part lesson template, core/optional tagging, gap analysis, migration guide. The authoritative answer to "how should I structure this lesson?" |
| `40-49-review/40.08-chapter-template-gap-report.md` | **DIAGNOSTIC** — every v1 chapter scored 1.0-1.5/8 against the 30.03 template. The "starting state" map for migration. |
| `40-49-review/_ARCHIVED_40.09-mom-test-micro-lesson-qa-report.md` | **QA METHODOLOGY PATTERN** — the audited lessons were removed 2026-06-08 (start v2 from clean slate). The criterion-by-criterion binary scoring structure is preserved as the canonical QA template for any new phase. |
| `TASK-TRACKER.md` | Live queue of pending post-ship improvements (P1-P3) + Course Migration Schedule (Phase 0-3 rollout) |
| `40-49-review/40.01-m1-m3-audit-2026-05-28.md` | Banned-pattern regression findings — permanent gates now in CLAUDE.md + 90.11 voice guide |
| `40-49-review/40.03-sipoc-course-logic.md` | SIPOC course-logic validation — supplier-input-process-output-customer map, continuity validation, quality gates, 10/10 score |
| `40-49-review/40.04-execution-readiness-sweep-2026-06.md` | June 2026 retrospective — time/money sweep + 13 critic-flagged gap closures + 9 tool-input fixes across 18 chapters |
| `40-49-review/40.05-multi-perspective-icp-review-2026-06.md` | 4-lens ICP-aligned review (Burned/First-Time/Skim-First/Crisis) — 3 recommendations tracked in TASK-TRACKER |
| `40-49-review/40.06-sam-customer-journey-report-2026-06.md` | Single-ICP Sam narrative — 18-chapter emotional arc, trust scores, recalibrated scoring methodology |
| `40-49-review/40.07-sam-experience-improvement-report-2026-06.md` | Sam-first improvement recommendations (6 items, all marked Done in TASK-TRACKER 2026-06-07) |
| `30-39-architecture-design/30.02-adr-content-execution-readiness.md` | **CANONICAL** — content policy (no speculative time/money), binary anchor thresholds per chapter, Module 2 two-pass framing rationale, 4-persona critic gate, Tier 1/2/3 punch list shape |
| `10-19-research/_ARCHIVED_10.06-icp-persona-course-walkthrough.md` | (ARCHIVED 2026-06-10) Alex (burned founder) walkthrough — website ICP, not course ICP. Historical reference — use 40.06 for Sam (course ICP), 90.10 for Alex (website ICP). |
| `10-19-research/_ARCHIVED_10.07-icp-sam-persona-course-walkthrough.md` | (ARCHIVED) — Superseded by 40.06 (Sam journey) + 40.07 (recommendations). |
| `50-59-execution/mechanical-audit-checklist.md` | Greppable + structural + voice gates every post must pass |
| `50-59-execution/distribution-prep.md` | Reddit/Twitter/Facebook/LinkedIn channels + share-copy templates + posting schedule |

### For a strategy / review agent

```
1. Read GOAL-AT-A-GLANCE.md.
2. Read 30-39-architecture-design/30.02-adr-content-execution-readiness.md — the canonical threshold-anchor table + content policy. ALL chapter edits must respect the anchors in section 2.
2a. Read 40-49-review/40.04-execution-readiness-sweep-2026-06.md — what landed in the June 2026 sweep and the open follow-ups.
2b. Read 40-49-review/40.01-m1-m3-audit-2026-05-28.md — understand what was caught and fixed.
3. Read 40-49-review/40.06-sam-customer-journey-report-2026-06.md — definitive Sam ICP document.
4. Read TASK-TRACKER.md — verify P1 items reflect the audit + ICP findings.
5. Read 40-49-review/40.03-sipoc-course-logic.md — understand module continuity and structural constraints before proposing sequence edits.
6. Read 20-29-strategy/20.02-positioning-vs-courses.md.
7. Cross-reference against ../2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md.
8. If retrospective is due: populate 40-49-review/40.02-post-ship-retrospective.md.
```

---

## 📋 CORE DOCUMENTS

### 🎯 Goals & Planning

| File | Purpose |
|---|---|
| `GOAL-AT-A-GLANCE.md` | One-page summary, metrics, three-phase plan, delivery principles |
| `TASK-TRACKER.md` | Live status of every course post + artifact |
| `PROJECT-INDEX.md` | This file |

### 🔎 Research (10-19)

| File | Purpose |
|---|---|
| `10-19-research/10.01-course-program-landscape.md` | 19-program inventory, coverage matrix, gap analysis, voice intelligence |
| `10-19-research/10.02-curriculum-sequence-synthesis.md` | Synthesis of 3 research inputs; why module structure beats pillar structure |
| `10-19-research/10.03-2026-ecosystem-research-ru-source.md` | Russian-language source research on 2026 ecosystem (Sophia Matveeva, Drew Falkman, FI Vibecode, AI-Augmented Developer profile). English wrapper header explains contents. Originally at `docs/Курс для нетехнических основателей 2026.md`, moved 2026-05-12. |
| `10-19-research/10.04-competitor-courses-2026-forum-validated.md` | Competitor course reviews from founder forums (Indie Hackers, Reddit, Hacker News) |
| `10-19-research/10.05-content-organization-patterns-2026.md` | Gloria Mark / Pew 2026 / NN/g attention-span research; cognitive-load patterns for content structure |
| `10-19-research/_ARCHIVED_10.06-icp-persona-course-walkthrough.md` | (ARCHIVED) Alex (burned founder) walkthrough. Use 40.06 for Sam. |
| `10-19-research/_ARCHIVED_10.07-icp-sam-persona-course-walkthrough.md` | (ARCHIVED) — Superseded by 40.06 (Sam journey) + 40.07 (recommendations). |
| `10-19-research/10.08-validation-tools-analysis-2026.md` | AI validation tools gap analysis & recommendations (June 2026). Sources: Russian-language market research (`docs/_research/`) + web research. Maps 6 gaps to course modules, ranks by ROI. |

### 💡 Ideas Bank

| File | Purpose |
|---|---|
| `LOW-IMPACT-IDEAS-BANK.md` | Aggregated dropped, deferred, and P3 ideas from all reviews and research. Scan when starting a new work cycle. |

### 🔍 Reviews (40-49)

| File | Purpose |
|---|---|
| `40-49-review/40.01-m1-m3-audit-2026-05-28.md` | Banned-pattern regression findings — permanent gates now in CLAUDE.md + 90.11 voice guide |
| `40-49-review/40.03-sipoc-course-logic.md` | SIPOC course-logic validation — 10/10 score, mermaid diagrams, artifact chain, quality gates |
| `40-49-review/40.04-execution-readiness-sweep-2026-06.md` | Sweep retrospective — 13 gap closures + 9 tool-input fixes + open follow-ups |
| `40-49-review/40.05-multi-perspective-icp-review-2026-06.md` | 4-lens review (⚠️ done against Alex/website ICP, not Sam/course ICP — read corrigendum header first). Structural analysis and skim-first/first-timer lenses partially applicable to Sam. |
| `40-49-review/40.06-sam-customer-journey-report-2026-06.md` | Single-ICP Sam narrative — 18-chapter emotional arc, trust scores, recalibrated scoring |
| `40-49-review/40.11-sam-simulation-pilot-lessons-2026-06.md` | Sam simulation report — Iter 19 pilot lessons. Beat-by-beat reader simulation, 5 themes, 5 surgical fixes applied. Strong recommendation: 5-Sam validation pilot before Phase 2. |
| `40-49-review/_DEFERRED_40.02-post-ship-retrospective.md` | Post-ship retrospective — DEFERRED until 2+ weeks of live data |

### 🧭 Strategy (20-29)

| File | Purpose |
|---|---|
| `20-29-strategy/20.01-course-modules.md` | The 5 modules with input/output/checkpoint/artifact (REPLACES old pillars doc) |
| `20-29-strategy/20.02-positioning-vs-courses.md` | Why this beats YC Startup School, Sophia Matveeva, Drew Falkman, Kukoyi book |
| `20-29-strategy/20.11-course-migration-roadmap.md` | **CANONICAL** — dependency-aware Now/Next/Later roadmap for v2 micro-lesson migration. Task-level dependency graph, parallelization map, risks. Generated from `.agent/tasks.json`. |
| `20-29-strategy/_ARCHIVED_20.07-content-plan-tnt-founders-2026.md` | ~~The 26-post map, 11 artifacts...~~ **ARCHIVED** — shipped course uses 5-module spine. Historical reference only. |

### 🛠️ Execution (50-59)

| Sub-dir | Purpose | Status |
|---|---|---|
| `50-59-execution/mechanical-audit-checklist.md` | Greppable + structural + voice gates every post must pass | Active |
| `50-59-execution/distribution-prep.md` | Reddit/Twitter/Facebook/LinkedIn channels + share-copy templates | Active |
| `50-59-execution/_ARCHIVED_SPRINT-RUNBOOK.md` | (ARCHIVED 2026-06-10) Sprint 1 runbook — DO NOT EXECUTE | Superseded by TASK-TRACKER migration schedule |
| `50-59-execution/_ARCHIVED_50.01-phase-1-implementation-plan.md` | (ARCHIVED 2026-06-10) Phase 1 plan — DO NOT EXECUTE | Superseded by TASK-TRACKER migration schedule |
| `50-59-execution/landing-page/` | Curriculum index page draft | Not yet authored; ships after Module 5 |

### Blog post drafts (in main repo — companion pages, not course spine)

| Slug | Module | Status |
|---|---|---|
| `content/blog/five-tech-words-stop-nodding-at/` | 2.1 | ✅ drafted |
| `content/blog/engineering-org-chart-non-technical-founder/` | 5.1 | ✅ drafted |
| `content/blog/reading-sow-clause-by-clause/` | 4B.4 | ✅ drafted + cover image |
| `content/blog/three-questions-turn-standup-into-proof/` | 5.3 | ✅ drafted |

---

## 🔗 EXTERNAL DEPENDENCIES (read these too)

| File | Why |
|---|---|
| `../../90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` | ICP-E definition, pains, white-space features |
| `../../90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` | Voice rules, banned words, anti-AI patterns |
| `../../90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` | Tech post structural standards |
| `../../workflows/blog-pipeline.md` | The 7-step blog writing workflow |
| `../../workflows/proof-signal-portfolio.md` | Distinct proof signals per post (avoid repetition) |
| `../../workflows/linkedin-post-pipeline.md` | Promo channel for each course post |
| `../2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md` | Parent content plan; 10 wrap slugs integrate here |

---

## 🚨 INTEGRATION RULES (zero tolerance)

### v2 micro-lesson conventions (authoritative — see 30.03)

**For all v2 micro-lessons, 30.03 is the canonical authority.** These rules distill the key points:

A. **8-part template mandatory.** Every lesson follows §2.1-2.8: Hook → Outcome → Concept → Visual → Do-Now → Error → Reflection → Bridge. Visual is optional; all other parts required.

B. **Word count bands.** Standard lessons: 400-600 words. Tool-as-worked-example lessons: 500-900 words. Per 30.03 §1.6.

C. **One visual per lesson.** Maximum 1 informational SVG/Mermaid per micro-lesson. Per 30.03 §2.4 (cognitive load theory).

D. **No case studies inside lesson bodies.** Case studies live at module-end walkthrough pages only. Per 30.03 §2.7.

E. **Zero template-label H2s.** Never use "## Do this now" / "## If this fails" / "## Why this matters" as H2s.

F. **Every term glossed at first mention.** Sam knows nothing. Define MVP, PMF, ICP, CTA, DPA, ARR, MRR, etc. inline.

### v1 long-form conventions (for companion/reference pages)

**These rules apply to v1 long-form companion pages and blog posts, NOT to v2 micro-lessons:**

1. **No parallel slugs.** 10 of 26 course posts wrap existing 2510 slugs. The 2605 project DOES NOT create new slugs for these.

2. **No duplicate artifacts.** Lead magnets are the SAME artifacts the 2510 plan references. One canonical version, multiple link entry points.

3. **Every course post carries the course frame.** Top callout + bottom course-nav table.

4. **Simplest method on main path.** Advanced frameworks (Foundation Sprint, JTBD Canvas, Shape Up, etc.) relegated to optional "Advanced" sidebars.

5. **No length caps for v1 long-form.** Word counts are not targets, ceilings, or floors. Length is byproduct of effective delivery. Cut test per section. **Note: v2 micro-lessons DO have word count bands (see 30.03 §1.6).**

6. **≥3 handmade-style infographics per v1 post** (Mermaid + sketchy SVG mix, Excalidraw aesthetic, JT brand colors). **Note: v2 micro-lessons cap at 1 visual per lesson (30.03 §2.4).**

7. **Tech-stack defaults**: Rails / Django / Laravel + full-stack-developer-ships-end-to-end.

8. **All voice rules from `90.11` apply.** No special exemptions.

9. **ZERO JT service CTAs anywhere in the course** (Option C: Pure Lead Magnet).

10. **Every v1 post engineered for viral sharing.** Contrarian hook in opening 80 words, quote-tweetable insight (140-280 chars), specific weekly tactic, downloadable artifact. Shareable headline structure. **Note: v2 micro-lessons follow the 8-part template, not these viral-sharing rules.**
