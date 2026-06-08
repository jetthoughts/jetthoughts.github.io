# Project 2605 - Master Index

**Project**: Tech for Non-Technical Founders 2026
**Status**: 🟢 v1 (long-form) shipped + 🟡 v2 (micro-lesson) pilot in flight
**Last Updated**: 2026-06-08
**Parent**: `../2510-seo-content-strategy/`

This is the **single navigation hub** for the 2605 project. Read top-to-bottom on first visit.

---

## 🚀 IMMEDIATE ACTION - START HERE

**v1 (long-form) is shipped**: 5 modules, 18 chapters, live at `/course/tech-for-non-technical-founders-2026/`.
**Strategic pivot (2026-06-07)**: v2 (micro-learning format) is the next iteration based on `30.03-course-format-requirements-for-creators.md`. All 21 v1 chapters score 1.0-1.5/8 against the 8-part template (per 40.08 gap report). 7 v2 draft pages exist (Quickstart, FAQ, 5 micro-lessons) and the Mom Test 3-lesson sequence is QA-validated per 40.09.

**Currently in flight**: Phase 3 pilot — publish micro-lessons as canonical Module 2 path, measure completion rate, then migrate Modules 1/3/4/5.

Post-ship work is tracked in `TASK-TRACKER.md` (see "Course Migration Schedule" section for the 4-phase rollout). Review docs in `40-49-review/`.

### For a micro-lesson migration agent (Phase 1-2 of TASK-TRACKER "Course Migration Schedule")

```
1. Read 30-39-architecture-design/30.03-course-format-requirements-for-creators.md — CANONICAL spec for the v2 format. The 8-part lesson template is non-negotiable.
2. Read 40-49-review/40.08-chapter-template-gap-report.md — every v1 chapter scored against the spec. Use as the "starting state" map.
3. Read 40-49-review/40.09-mom-test-micro-lesson-qa-report.md — QA pass on the 3 Mom Test sample lessons + paid-pilot lesson. These are the canonical examples of the v2 format done right.
4. Open the 7 v2 draft pages already in repo:
   - content/course/tech-for-non-technical-founders-2026/quickstart/
   - content/course/tech-for-non-technical-founders-2026/faq/
   - content/course/tech-for-non-technical-founders-2026/mom-test-lesson-1-5-questions/
   - content/course/tech-for-non-technical-founders-2026/mom-test-lesson-2-emotional-flags/
   - content/course/tech-for-non-technical-founders-2026/mom-test-lesson-3-run-score-interview/
   - content/course/tech-for-non-technical-founders-2026/paid-pilot-micro-lesson/
   - content/course/tech-for-non-technical-founders-2026/mom-test-5-questions-micro-lesson/
5. Read TASK-TRACKER.md "Course Migration Schedule" → pick the next phase (Phase 0 mechanical edits, Phase 1 pilot, or Phase 2 module-by-module).
6. After every micro-lesson rewrite: run bin/validate-course + verify mobile viewport at 375px + verify Hugo build passes.
7. Apply voice guide 90.11 (no em-dashes, no "Founders who"/"Most founders"/"## Why this matters" banned phrases).
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
| `40-49-review/40.09-mom-test-micro-lesson-qa-report.md` | **EXAMPLES** — QA pass on the 3 Mom Test micro-lessons + paid-pilot lesson. Reference these as the canonical implementation of the 8-part template. |
| `TASK-TRACKER.md` | Live queue of pending post-ship improvements (P1-P3) + Course Migration Schedule (Phase 0-3 rollout) |
| `40-49-review/40.01-m1-m3-audit-2026-05-28.md` | Banned-pattern regression findings — permanent gates now in CLAUDE.md + 90.11 voice guide |
| `40-49-review/40.03-sipoc-course-logic.md` | SIPOC course-logic validation — supplier-input-process-output-customer map, continuity validation, quality gates, 10/10 score |
| `40-49-review/40.04-execution-readiness-sweep-2026-06.md` | June 2026 retrospective — time/money sweep + 13 critic-flagged gap closures + 9 tool-input fixes across 18 chapters |
| `40-49-review/40.05-multi-perspective-icp-review-2026-06.md` | 4-lens ICP-aligned review (Burned/First-Time/Skim-First/Crisis) — 3 recommendations tracked in TASK-TRACKER |
| `40-49-review/40.06-sam-customer-journey-report-2026-06.md` | Single-ICP Sam narrative — 18-chapter emotional arc, trust scores, recalibrated scoring methodology |
| `40-49-review/40.07-sam-experience-improvement-report-2026-06.md` | Sam-first improvement recommendations (6 items, all marked Done in TASK-TRACKER 2026-06-07) |
| `30-39-architecture-design/30.02-adr-content-execution-readiness.md` | **CANONICAL** — content policy (no speculative time/money), binary anchor thresholds per chapter, Module 2 two-pass framing rationale, 4-persona critic gate, Tier 1/2/3 punch list shape |
| `10-19-research/10.06-icp-persona-course-walkthrough.md` | ICP-E simulation with per-module verdicts and gap recommendations |
| `10-19-research/_ARCHIVED_10.07-icp-sam-persona-course-walkthrough.md` | (ARCHIVED) — Superseded by 40.06 (Sam journey) + 40.07 (recommendations). |
| `50-59-execution/mechanical-audit-checklist.md` | Greppable + structural + voice gates every post must pass |
| `50-59-execution/distribution-prep.md` | Reddit/Twitter/Facebook/LinkedIn channels + share-copy templates + posting schedule |

### For a strategy / review agent

```
1. Read GOAL-AT-A-GLANCE.md.
2. Read 30-39-architecture-design/30.02-adr-content-execution-readiness.md — the canonical threshold-anchor table + content policy. ALL chapter edits must respect the anchors in section 2.
2a. Read 40-49-review/40.04-execution-readiness-sweep-2026-06.md — what landed in the June 2026 sweep and the open follow-ups.
2b. Read 40-49-review/40.01-m1-m3-audit-2026-05-28.md — understand what was caught and fixed.
3. Read 10-19-research/10.06-icp-persona-course-walkthrough.md — ICP-E gaps and recommendations.
4. Read 10-19-research/10.07-icp-sam-persona-course-walkthrough.md — ICP-Sam gaps and recommendations (idea-stage first-timer perspective).
5. Read TASK-TRACKER.md — verify P1 items reflect the audit + both ICP findings.
6. Read 40-49-review/40.03-sipoc-course-logic.md — understand module continuity and structural constraints before proposing sequence edits.
7. Read 20-29-strategy/20.02-positioning-vs-courses.md.
8. Cross-reference against ../2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md.
9. If retrospective is due: populate 40-49-review/40.02-post-ship-retrospective.md.
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
| `10-19-research/10.06-icp-persona-course-walkthrough.md` | ICP-E persona simulation — Alex (burned founder) walks the full 5-module course with per-module verdicts on practicality, engagement, achievability, and modernity |
| `10-19-research/10.07-icp-sam-persona-course-walkthrough.md` | ICP-Sam persona simulation — Sam (idea-stage first-timer) walks the full 5-module course with per-module verdicts, jargon-disclosure audit, and Sam-vs-Alex scoring comparison |
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
| `40-49-review/40.05-multi-perspective-icp-review-2026-06.md` | 4-lens ICP review (Burned/First-Time/Skim-First/Crisis) — 3 recommendations in TASK-TRACKER |
| `40-49-review/40.06-sam-customer-journey-report-2026-06.md` | Single-ICP Sam narrative — 18-chapter emotional arc, trust scores, recalibrated scoring |
| `40-49-review/_DEFERRED_40.02-post-ship-retrospective.md` | Post-ship retrospective — DEFERRED until 2+ weeks of live data |

### 🧭 Strategy (20-29)

| File | Purpose |
|---|---|
| `20-29-strategy/20.01-course-modules.md` | The 8 modules with input/output/checkpoint/artifact (REPLACES old pillars doc) |
| `20-29-strategy/20.02-positioning-vs-courses.md` | Why this beats YC Startup School, Sophia Matveeva, Drew Falkman, Kukoyi book |
| `20-29-strategy/20.10-sequence-decision-validate-vs-smoke-test.md` | Sequence debate; SIPOC confirms kept order |
| `20-29-strategy/_ARCHIVED_20.07-content-plan-tnt-founders-2026.md` | ~~The 26-post map, 11 artifacts...~~ **ARCHIVED** — shipped course uses 5-module spine. Historical reference only. |

### 🛠️ Execution (50-59)

| Sub-dir | Purpose | Status |
|---|---|---|
| (moved 2026-07-15 to public Hugo URLs) | All 8 artifacts now live at `content/blog/<slug>/` as standalone template pages: `/blog/self-assessment-worksheet/`, `/blog/outreach-sequence-template/`, `/blog/mom-test-interview-script/`, `/blog/friday-demo-template/`, `/blog/ownership-checklist/`, `/blog/salvage-vs-rebuild-decision-tree/`, `/blog/agency-ai-five-questions/`, `/blog/sow-reading-guide/`. The `50-59-execution/lead-magnets/` directory is now empty; artifact-link infrastructure debt resolved 2026-07-15. | 8 of 11 shipped; 3 net-new pending (Vibe PRD, Self-Serve Stack PDF, AI Cost Worksheet) |
| `50-59-execution/landing-page/` | Curriculum index page draft for `/blog/tech-for-non-technical-founders-2026/` | Not yet authored; ships after Module 5 |

### Blog post drafts (in main repo)

| Slug | Module | Status |
|---|---|---|
| `content/blog/five-tech-words-stop-nodding-at/` | 2.1 | ✅ drafted (nav swap pending this pass) |
| `content/blog/engineering-org-chart-non-technical-founder/` | 5.1 | ✅ drafted (nav swap pending this pass) |
| `content/blog/reading-sow-clause-by-clause/` | 4B.4 | ✅ drafted + cover image (nav swap pending this pass) |
| `content/blog/three-questions-turn-standup-into-proof/` | 5.3 | ✅ drafted (nav swap pending this pass) |

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

1. **No parallel slugs.** 10 of 26 course posts wrap existing 2510 slugs (NEW-J, NEW-K, NEW-A, NEW-L, NEW-I, NEW-M, NEW-C, NEW-E, NEW-D2, #20). The 2605 project DOES NOT create new slugs for these. Curriculum frame is added via callout to the existing/in-flight 2510 post when it ships.

2. **No duplicate artifacts.** The lead magnets shipped under 2605 (Friday Demo Template, Ownership Checklist, Salvage Decision Tree, AI 5-Question Script, SOW Reading Guide) are the SAME artifacts the 2510 plan references. One canonical version, multiple link entry points.

3. **Every course post carries the course frame.**
   - Top callout: `> **Module X · Step N of M** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free course. Input: [what reader brings]. Output: [deliverable].`
   - Bottom section: `## Continue the course` with the module nav table + an `In Module X:` mini-list showing current-module posts with `← you are here` marker.
   - Canonical wording examples in existing chapter callouts (e.g., Ch 1.1, 5.3). Memory: `feedback_curriculum_posts_as_course.md`.

4. **Simplest method on main path.** Foundation Sprint, JTBD Canvas 2, Shape Up, Continuous Discovery, Impact Mapping, User Story Mapping, Lean Inception, Empathy Mapping, Design Sprint - all relegated to optional "Advanced" sidebars at the bottom of Modules 1, 2, and 5. They never appear on the main reading path. Memory: `feedback_kiss_simplest_solutions_only.md`.

5. **No length caps.** Word counts are not targets, ceilings, or floors. Length is byproduct of effective delivery. Cut test per section. Memory: `feedback_no_length_caps.md`.

6. **≥3 handmade-style infographics per post** (Mermaid + sketchy SVG mix, Excalidraw aesthetic, JT brand colors, handwriting fonts). Memory: `feedback_infographics_required.md`.

7. **Tech-stack defaults**: Rails / Django / Laravel + full-stack-developer-ships-end-to-end. AI tooling (Cursor, Claude Code) and infra (AWS, GitHub, Stripe, Heroku, Kamal) stay framework-agnostic. Memory: `feedback_jt_tech_stack_preferences.md`.

8. **All voice rules from `90.11` apply.** No special exemptions for course framing. Founder voice, plain English, no shape tells, no slogan closings, no em dashes, no banned words.

9. **ZERO JT service CTAs anywhere in the course** (Option C: Pure Lead Magnet, adopted 2026-05-12). No "book a Control Audit," no "schedule a consultation," no "JT runs a 45-minute..." Authorship credit at the footer is OK ("Built by JetThoughts as part of the free curriculum"). Email-gated artifact downloads are the lead-capture mechanism. Module 3.2 Fractional CTO is positioned generically, not as a JT offer. Memory: `feedback_curriculum_is_pure_lead_magnet.md`.

10. **Every post engineered for viral sharing.** Mandatory: (a) contrarian hook in opening 80 words, (b) one quote-tweetable insight 140-280 chars, (c) a specific tactic the reader can execute this week, (d) a free downloadable artifact, (e) a shareable headline structure (Stop X / N things you get wrong / How X lost $Y / The thing your dev shop won't show you). Success metric: share velocity on Reddit r/startups + Twitter founder threads + Facebook founder groups + email captures + page-1 SEO. Memory: `feedback_curriculum_viral_shareability.md`.
