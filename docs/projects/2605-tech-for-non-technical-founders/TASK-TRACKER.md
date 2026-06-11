# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-06-10 (Stale-doc cleanup: Phase 0 deferred, Phase 1 completion notes, 10.06 archived, path fixes)

## Active Phase: v2 Migration Pilot

**Current sprint focus:** validate the v2 micro-lesson format on Module 2 before fanning out to the rest. See "Course Migration Schedule" section below for the 4-phase rollout. Cold AI agents should read `30.03-course-format-requirements-for-creators.md` + `40.08-chapter-template-gap-report.md` + `40.09-mom-test-micro-lesson-qa-report.md` before touching any v2 lesson.

**What just shipped (2026-06-08):**
- ✅ Phase 1 pilot RESTRUCTURED into ONE Mixo-only golden-path lesson:
  - `smoke-test-build-page` — agnostic AI-builder workflow (Mixo as worked example, Manus AI and Durable named as equivalents, Carrd as manual-mode fallback): paste hypothesis → polish 4 copy blocks → swap hero → add disclaimer → publish → stranger test. Title and slug deliberately tool-agnostic so the lesson outlives any one tool.
  - `smoke-test-wire-tracking` — Clarity + ad-platform pixel + optional GA4, ~430 words (unchanged from earlier pilot)
- ✅ Deleted prior two-lesson split (`smoke-test-pick-builder-ship-page` + `smoke-test-ship-page`) - ICP review found audit framing + manual-path/AI-path conflation confused Sam; 6-element table positioned as audit gate but Mixo doesn't output labeled elements
- ✅ Both lessons pass: Hugo build, validate-course (7/7), em-dash sweep (zero), word count in 500-800 band
- ✅ Spec updates: 30.03 §2.7 mandates ONE case study per MODULE at module-end (slug `module-N-walkthrough-<founder>`); lesson bodies stay case-study-free; `See it in action` footer link added in SAME commit that publishes the walkthrough page (never before - placeholder URL reads as broken promise). AGENT-PROMPTS scaffolding file deleted - cold-agent workflow now lives inline in TASK-TRACKER + 30.03 + PROJECT-INDEX route.
- ✅ Plan B (split-by-path: separate AI lesson + manual lesson) parked in LOW-IMPACT-IDEAS-BANK with trigger condition (reader data showing ≥30% Carrd-fallback rate)
- ✅ Option C wired into landing: Quickstart + FAQ links in "Start here" callout, "What this course does NOT cover" section added with 7 explicit exclusions

**Phase 1 pilot findings (record for cold agents):**

| Observation | What it means for Phase 2 |
|---|---|
| Real time-per-lesson: ~25 min for the first draft + ~20 min for review/cuts ≈ 45 min/lesson | Phase 2 estimate of "~45-60 min per lesson" holds. Module 1 (3 remaining lessons × ~45 min) = ~2.5 hr realistic, not the original "~3-4 days." Earlier estimates were padded. |
| Two-case-studies-per-lesson pattern produced ~30% word-count drag on the 400-600 budget | Superseded 2026-06-08: case studies now live at module-end walkthrough page only (30.03 §2.7); lesson bodies are case-study-free. |
| Split-by-step pattern (audit lesson + ship lesson) confused Sam: audit framing assumed Mixo outputs labeled 6-element list, but Mixo outputs a complete page Sam can't easily map to the 6 elements | Workflow-shaped lessons (one Mixo session = one lesson) beat framework-shaped lessons (audit then ship). Match the cognitive split to the reader's actual session boundaries, not to teacher-imposed pedagogical phases. |
| Concept blocks naturally drift to ~310 words when GA4-style "industry standard" addendums creep in | Watch for "overkill but include for completeness" content. Cut or move to optional sidebar. The 300-word cap is enforced, not aspirational. |
| Template labels (1. Hook, 2. Outcome, etc.) NEVER leak into published content when the writer reads the lesson aloud at the end | Read-aloud check before commit is a cheap insurance. Adds <60s, prevents the worst kind of regression. |
| Step 2 of Do-Now in Lesson 1.2a originally combined all 6 elements into one ~95-word paragraph | Bullets beat paragraphs in Do-Now steps. Mobile scanability is the deciding factor. |
| ICP-fit case-study selection: Mia worked for 1.2a (B2C "use what you have" theme), Tomas worked for 1.2b (B2B "invisible builder blind spot" theme) | Strict alternation would have put Tomas in 1.2a where Mia's "scrappy founder uses real screenshot" lands harder. ICP-fit picking is the right rule. |

**Phase naming note:** This doc uses "Phase 0" for the remaining mechanical quick wins (outcome sentences, success checks, Stuck? boxes — see migration schedule below). The completed surgical improvements are called "Option C" (matching 30.03 §8.4-8.5). These are separate work streams.

**Next sprint candidates** (pick one):
1. **Phase 2 — Module 1 full migration** — migrate remaining M1 chapters (1.1, 1.2b, 1.3) using pilot template (~2-3 days)
2. **Wire micro-lessons into navigation** — add the 2 pilot lessons to course_sequence.yaml as draft entries for preview
3. **Phase 0 mechanical sweep** — deferred until pilot lessons complete (~2-3 hours).

## Current Active Scope

This tracker is the **single source of truth** for all post-ship improvements. Recommendations from review files (40.04, 40.05, 40.06) and research (10.08) have been consolidated here.

Current source of truth:

- Chapter order: `data/course_sequence.yaml`
- Project context and integration rules: `PROJECT-INDEX.md`
- ICP lens: `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`
- Voice lens: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`
- Research: `10-19-research/10.08-validation-tools-analysis-2026.md`
- Course overview: Chapter 0 (`how-this-course-works`) + landing page (`_index.md`)
- Course format requirements: `30-39-architecture-design/30.03-course-format-requirements-for-creators.md` (canonical spec for course creators)
- Low-impact ideas: `LOW-IMPACT-IDEAS-BANK.md` (this directory)

---

## ICP Practicality Improvement Backlog

Review lens: the course ICP - a non-technical founder going from idea (or half-built MVP) to first paying customer, who mostly has NOT hired yet. Burned/already-hired founders are a secondary audience routed to the rescue chapters (4.1/4.2) and the landing "If Your Team Is Already Failing" fast path - do not write validation/build chapter bodies to the burned founder. (Distinct from the website lead-gen ICP in `90.10-icp-primary-website-target.md`.)

Current practicality score: 7.5/10.
Target: 8.5/10 before launch.

| Priority | Task | Status | Notes |
|---|---|---|---|
| ✅ Done 2026-05-20 | Fix course landing module map | Done | Landing page module list merged to 5 modules (commit 32e064dd). Stale "Proactive Ceiling Signals" title fixed. |
| ✅ Done 2026-05-20 | Fix stale module/chapter numbering in companion pages | Done | Global `Module N.X` → `Chapter N.X` rename across 28 .md + 2 SVGs + YAML; 6-module → 5-module spine renumber; 3 companion pages (operating-kit, pivot-or-persevere, churn-triage) Module 7 references resolved. GOAL-AT-A-GLANCE rewritten to 5-module spine. 20.07 content plan marked superseded. |
| ✅ Done 2026-05-20 | Repair missing artifact link | Done (no-op) | Audit confirmed `/blog/founding-hypothesis-worksheet/` is not linked from any chapter. The tracker entry was stale from a prior cleanup pass. |
| ✅ Done 2026-05-20 | Remove unfulfilled download/email promises | Done (already correct) | Audit confirmed `first-paying-customer-operating-kit` already says "There is no email signup; when a template is downloadable, the link appears inline below. We will not promise files we cannot ship today." Matches course philosophy. |
| ✅ Done 2026-05-20 | Build 4 source-of-truth validators (Kaizen Muda outcome) | Done | All 4 validators implemented as `bin/validate-course` + `lib/course_validators.rb` (with test/unit/course_validators_test.rb): (1) chapter-number-consistency, (2) title-yaml-match, (3) internal-link-existence, (4) table-width. Hooked into `bin/hugo-build` as pre-flight check. Globs updated to handle nested `content/course/<namespace>/<slug>/` structure. 3 of 4 pass after course-namespace migration; 1 (internal-link-existence) has 24 pre-existing broken-citation violations to non-existent research articles - separate follow-up. |
| P1 | Add "Burned founder fast path" to landing | Planned | Emergency route: Ownership audit -> Friday demo -> weekly report -> salvage/rebuild -> switch dev shops -> AI risk. Put before the full course table. (Per-chapter routing added to Ch 1.1 on 2026-05-20.) |
| P1 | Create downloadable PDF templates + restore "Free templates" section on landing | Planned | 2026-05-21: removed "Free downloadable templates" H2 + 14-row table from `_index.md` because the links pointed to in-browser chapter pages, not actual PDF downloads. The chapter pages still exist (Outreach Sequence Template, Mom Test Interview Script, Validated Problem Statement Template, Vibe PRD Template, Build Path Decision Worksheet, GitHub/AWS/DB Ownership Checklist, Self-Serve Stack Walkthrough, Where-to-Hire Map 2026, Hiring Interview Script, SOW Reading Guide, First-Paying-Customer Operating Kit, Friday Demo Template, Salvage vs Rebuild Decision Tree, "We Use AI" 5-Question Script). When the 14 PDFs are precreated, restore the landing section with the correct framing (PDF + browser-page link side by side). Cover image chip "TEMPLATES 14 free" stays unchanged - it remains accurate because the template chapter pages still exist as free in-browser resources. |
| P1 | Add Founder Control Dashboard artifact | Planned | One-page control system for access, demos, reports, SOW, budget, AI risk, and salvage score. Tie the strongest ICP-E chapters together. |
| P1 | Make every artifact copy-pasteable | Done | Each template page needs on-page scripts/checklists, not only descriptions of future assets. Prioritize SOW, DPA, outreach, hiring interview, ownership, Friday demo. All 6 done 2026-06-02: outreach quick-ref checklist, SOW agency email + pre-sign checklist, hiring interview pre-interview + polite-no emails, ownership audit spreadsheet + recovery email, Friday demo follow-up + skipped-twice message, DPA one-page template skeleton. |
| ✅ Done 2026-05-22 | Separate early-founder path from rescue path | Done | Decision reversed: chapter-level routing blocks removed, not rolled out. The Ch 1.1 "Already burned? / Already hired?" block was deleted 2026-05-22 - it interrupted the primary idea-stage ICP reader with two "leave this page" callouts before the hook, and duplicated the landing-page "If Your Team Is Already Failing" fast path (the real entry-point router for burned founders). Do NOT add per-chapter routing blocks to other module-start chapters; route burned founders at the landing page only. |
| ✅ Done 2026-06-02 | Add AI critic/simulator blocks per module | Done | Standardize where AI helps: critique artifact, simulate customer/vendor/advisor, find contradictions. State what AI cannot prove. One block per module = 5 blocks (new 5-module spine). M1.1: crystallized AI tools sidebar. M2.2: framed chapter as canonical AI simulator. M3.2: AI-as-peer callout standardized. M4.3: NEW build-review prompts (audit brief, check RLS, detect overengineering). M5.2: AI channel research framed as critic layer. Commit df9a537e.
| P1 | Roll manual-minimum sidebar to other tool-heavy chapters | Partial | 2026-05-20: 3 chapters got $0-budget callouts (Ch 1.2 smoke-test, Ch 4.3 self-serve-mvp-stack, Ch 5.5 outbound). Ch 2.2 already had manual-minimum sidebar. Audit remaining chapters (Ch 5.3, 5.4) for any unaddressed paid-tool friction. |
| SUPERSEDED | Add "Skip to the action" anchor links to longest chapters (40.05 Rec #1) | Superseded by 40.07 Rec #1 (2026-06-07) | Replaced by refined 40.07 version: targets M4.3a, M1.2a, M3.2 (narrowed from M1.1, M3.2, M4.3). See P2 item below for current. |
| DEFERRED | Add burned-founder acknowledgment callouts in Module 2 (40.05 Rec #2) | Deferred (2026-06-07) | **DEFERRED by user direction.** Burned-founder ICP improvements tabled as an idea. The course ICP is Sam (the idea-stage first-timer), NOT Alex (burned founder). See 40.07 for Sam-first alternative recommendations. |
| P2 | Add TL;DR summaries to all chapters — phased rollout (40.05 Rec #3) | Planned | Add 2-3 line TL;DR after Input/Output callout: what you'll do, why it matters, deliverable, where it goes next. Phase 1: 5 chapters + browser-use verification. Phase 2: fan out remaining 13. ~5 min per chapter. See 40.05 §Top 3 Recommendations #3. |
| P2 | Add completion criteria to every chapter | Planned | Each chapter should end with "Done when / Next click / If blocked" so the founder knows when to move on. Template: `## Done when` + checklist + `## Next click` + conditional routing. 18 chapters. |
| P2 | Tighten practical proof in weaker modules | Planned | Early validation and market-type chapters need more concrete founder examples, exact time boxes, and decision thresholds. |
| P2 | Collapse outreach-sequence-template variant runs | Planned | 2026-05-23 audit found 3 variant groups rendered as 3 separate blockquote boxes each (LinkedIn DM openers ×3, cold-email subject lines ×3, possibly Day 1/3/7 email sequence ×3). Merge each group into ONE blockquote (use `>` blank-line separators) per the no-stacked-quotes rule. Lower priority because it's an artifact/template page, not a numbered linear chapter. |
| P2 | De-stack + rebalance "$0 path" callouts (outbound, self-serve-mvp) | Planned | 2026-05-23: two chapters still have a "$0 path / $0 outbound stack" blockquote callout immediately under the Module banner (top-stack). Bundle with the deferred Module 4/5 budget-rebalance pass - de-stack to plain prose AND rebalance the framing per `feedback_budget_stance_free_and_paid_equal` (free and paid as equal options, reader chooses; don't lead with "$0 first"). |
| P3 | Add Wizard of Oz Concierge MVP path to Ch 4.3 (10.08 Gap #2) | Planned | Add Tally + Zapier + Airtable as $0 no-code backend alternative to Lovable build for founders who should validate deeper before coding. Documented in 10.08-validation-tools-analysis-2026.md §Gap 2. |
| P3 | Add echo chamber warning to Ch 5.3 and Ch 2.3 (10.08 Gap #3) | Planned | Warn that warm network is for SALES (valid) not VALIDATION (invalid echo chamber). Add cross-reference from Ch 2.3 warning against interviewing only other founders. Documented in 10.08 §Gap 3. |
| P3 | Add Loom video outreach tactic to Ch 5.2 or 5.5 (10.08 Gap #4) | Planned | 10-minute personalized B2B video audits with higher conversion than cold email. Low effort, high differentiation. Documented in 10.08 §Gap 4. |
| P3 | Add Engineering as Marketing to Ch 5.2 (10.08 Gap #5) | Planned | Free No-Code micro-tools (calculators/checklists) for $0 CAC organic SEO. Distinct from content marketing. Documented in 10.08 §Gap 5. |
| Dropped | Add time-badge to each chapter header | Dropped (2026-06-02) | Each chapter needs a "**Time**: ~45 min" badge at the top so the reader can plan their session. 18 chapters. Dropped per user direction — time anchoring contradicts the ADR §1 policy of avoiding speculative effort estimates. |
| P1 | Build companion-post FAQ collection | New (ICP walkthrough _ARCHIVED_10.06) | Create a curated FAQ linking 8 companion posts as "read next" sidebars in relevant chapters. Currently only linked via course-frame nav. |
| P1 | Rescue-path routing audit | New (ICP walkthrough _ARCHIVED_10.06) | Audit all 5 module-start chapters for consistent burned-founder rescue-path routing. Chapter 1.1 had routing blocks added then removed; ensure uniform approach across spine. |
| P3 | Cover image regen audit for non-spine posts | Planned | 2026-05-20: 14 spine covers regenerated to clean "Curriculum 2026" badge. ~30 companion-post covers still have "Curriculum NN/30" stale counter. Regen via chrome-devtools at 2400×1260 if posts stay in active rotation. |
| ✅ Done | Update decision doc 20.10 with Click correction | Done | Decision block added at top of 20.10.md (2026-05-20) marking Recommendation section as superseded. TASK-TRACKER entry updated 2026-05-29. |
| ✅ Done 2026-06-04 | Add Sam customer journey report (40.06) with trust score methodology | Done | Single-ICP narrative spanning all 18 chapters + landing page. 3 entry-point doors. Per-chapter trust scores with emotional arc. Double-dip U-curve visualization. Appendix D: 19-row recalibrated trust score table with calibration constraints. Commit 63fb7d73. |
| ✅ Done 2026-06-07 | Add Sam experience improvement report (40.07) | Done | 6 actionable Sam-first recommendations across 18 chapters. Burned-founder ICP framing removed per user direction. Recommendations logged here for triage. See `docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.07-sam-experience-improvement-report-2026-06.md`. |
| ✅ Done 2026-06-07 | Archived 10.07 Sam walkthrough | Done | Superseded by 40.06 (definitive Sam reference) and 40.07 (canonical recommendations). Renamed to `_ARCHIVED_10.07-icp-sam-persona-course-walkthrough.md` with cross-reference note to 40.06 + 40.07. |
| ✅ Done 2026-06-07 | Published 30.03 course format requirements for creators | Done | Consolidated micro-learning spec + gap analysis + migration guide. Canonical requirements for course format design. See `30-39-architecture-design/30.03-course-format-requirements-for-creators.md`. |
| ✅ Done 2026-06-10 | Applied 5 Sam-simulation surgical fixes to pilot lessons | Done | Added Mixo re-prompt hint (1.2a Step 2), Mixo head-tag path (1.2b), domain question (1.2a Step 5), non-Chrome incognito shortcuts (1.2a Step 5), preview-mode script-blocking note (1.2b Step 4). ~80 words total. Sam simulation report: 40.11. |
| 🔲 P1 | 5-Sam Validation Pilot — recruit 3-5 real founders, watch Clarity recordings | Planned (DEFERRED until course complete) | Pivoted 2026-06-11: "pilot" in 2605 work = INTERNAL editorial template review (Paul-as-reviewer), NOT external recruitment. External kit deferred to post-course-completion at `40-49-review/_DEFERRED_external-validation-pilot-kit.md`. Original research questions preserved there for revival. |
| 🔲 P1 | Course-wide voice cleanup sweep (post-pilot-lock) | Planned | After 1.2a + 1.2b pilot template is locked: apply the same voice rules across all other lessons (1.1, 1.2c, 1.3, M2-M5, walkthroughs, _index). Specifically: (a) strip scattered budget mentions per voice guide rule "Never mention price/budget except in direct comparison"; (b) consolidate 3+ interchangeable tool listings to one example per voice guide rule "Never list 3+ interchangeable tools when one is the obvious lead"; (c) rename 1.2b title "Wire Tracking Before You Spend a Dollar" → "Wire Tracking Before Traffic Starts" (touches 13+ files: lessons, _index, walkthrough, GOAL-AT-A-GLANCE, TASK-TRACKER, data/course_sequence.yaml); (d) migrate closure blocks to the 30.03 §2.9 4-slot pattern (`Done` / `You have now` / `Next` / `If blocked`); (e) rewrite Output/Outcome lines in Sam-voice (binary observable behavior, not Paul-business-speak). Gate: Phase 2 M1 migration starts AFTER this cleanup so the migrated lessons inherit the locked voice. |

**5-Sam Pilot steps:**

| Step | Action | Est. time |
|---|---|---|
| 0.1 | Recruit 3-5 idea-stage founders (indie-hackers, Reddit r/startups, personal network). Screening: no tech background, has an idea they haven't validated, reads on phone. | ~2 hours |
| 0.2 | Post pilot lesson URLs (1.2a + 1.2b). Install Clarity on these pages. Instruct Sam to read both lessons and follow the Do-Now steps. | ~30 min |
| 0.3 | Wait 3-5 days for Sams to complete. Watch Clarity session recordings + heatmaps. Record: completion rate, time-on-page, scroll depth, stall points, rage-clicks. | ~2 hours |
| 0.4 | Synthesize findings: compare simulation predictions vs real behavior. Update Phase 2 template with any blind spots found. | ~1 hour |
| 0.5 | Decision gate: if ≥3 Sams complete with no systemic stall point, fan out to Phase 2. If same stall point appears in ≥2 Sams, fix template first. | ~30 min |

**Gate:** All 5 research questions have answers from real data. Template updated with findings. Only then proceed to Phase 2 M1 migration. |

**Phase naming note:** This pilot uses "0.1-0.5" step numbering to distinguish it from the deferred Phase 0 mechanical quick wins.
| ✅ Done 2026-06-07 | Add "Skip to the action" anchor links to longest chapters (40.07 Rec #1) | Done | Anchor-link callout added to M4.3a (6 links), M1.2a (4 links), M3.2 (4 links). Serves skim-first Sam. |
| ✅ Done 2026-06-07 | Reduce builder comparison fatigue in M1.2a (40.07 Rec #2) | Done | Builder list restructured as decision tree: Mixo (start here) → Manus AI (fallback) → Durable/NeetoSite/Carrd (only if experienced). Eliminated the "Default vs Fallback" two-tier framing. |
| ✅ Done 2026-06-07 | Add "First-timer fast path" to landing page (40.07 Rec #3) | Done | Callout added after hero section on `_index.md`: "New founder, no team, no trauma? Skip the diagnostic. Start at Chapter 1.1." |
| ✅ Done 2026-06-07 | Reposition M2.2 (AI Persona) as optional (40.07 Rec #4) | Done | Implemented option 2: added "Skip this if you've interviewed before" callout to M2.2 + tagged [OPTIONAL] on landing page module index. M5.2 also tagged [OPTIONAL] per 40.06 trust scores. |
| ✅ Done 2026-06-07 | Add "Stuck? Try this" boxes per module for first-timers (40.07 Rec #5) | Done | Stuck boxes added to M1.2a (builder paralysis), M2.3a (too-few-names), M3.2 (feature-list creep), M4.3a (12-rules overwhelm), M5.4 (asking-for-money terror). Placed after existing "If blocked" sections. |
| ✅ Done 2026-06-07 | Move M4.3 AI critic block before the 12 rules (40.07 Rec #6) | Done | AI critic block (3 Claude prompts for build audit, RLS check, scope leak detection) moved before the 12 rules section. Sam hits the actionable prompts first; 12 rules are the reference checklist after. |
| ✅ Done 2026-06-07 | Create one-page Quickstart (30.03 Option C) | Done | New page: `/quickstart/` — problem statement, promise, minimal path (core lessons only per module), gate thresholds, Start-here button. |
| ✅ Done 2026-06-07 | Create FAQ page (30.03 Option C) | Done | New page: `/faq/` — 15 Q&A across all 5 modules + general questions. Typical blockers: Stripe verification, Mom Test scores <7, builder paralysis, 12-rules overwhelm, asking for money. |
| ✅ Done 2026-06-07 | Create "What not to learn" section (30.03 Option C) | Done | Added to `_index.md` after "This is not for you if" — 7 explicitly excluded topics (coding, hiring CTO, VC, team mgmt, marketplace/mobile/AI, legal, SEO/marketing at scale).

---

## Closed today (2026-05-20)

| Done | Notes |
|---|---|
| 3-cycle UI/UX polish across 18 spine chapters | 94 issues fixed across Groups A-F |
| SEO frontmatter trims | 7 chapters trimmed for title ≤60 / desc ≤170 |
| YAML title alignment | vibe-coding-ceiling-signals YAML matched file title |
| Cover image regen | 14 spine covers, "Curriculum 2026" badge, ai-persona slogany dropped |
| Module → Chapter nomenclature | Global sweep across content/blog + YAML + 2 SVGs (28 .md files) |
| Ch 1.1 shame recovery paragraphs | 3 paragraphs after intro callout addressing burned-founder shame |
| Ch 1.1 non-linear routing | Top-of-page block: "Already burned?" / "Already hired?" route to 5.2 / 5.1 |
| Ch 1.1 Magic Lenses Money skip guidance | Pre-revenue founders can leave Money lens blank until smoke test data lands |
| Ch 2.2 manual-minimum sidebar | $0 alternative to the $300-500/mo tool stack before the 5-step sequence (was Ch 3.2 pre-merge) |
| Verified: "We..." opener density already at 0% in Ch 2.2 + Ch 5.3 (Group B polish caught this) |
| **5-module spine merge** | Module 1 (1 chapter) + Module 2 (2 chapters) merged into 3-chapter Module 1 (Hypothesis & Smoke-Test). All downstream modules shifted down by 1. Slug-stable. |
| YAML `goal:` field | Added one-sentence outcome per chapter to `data/course_sequence.yaml` (18 entries) |
| $0-budget reframe | Top-of-chapter callouts in Ch 1.2 (smoke-test: Neeto/Carrd free + organic), Ch 4.3 (self-serve-mvp-stack: Lovable+Supabase+Stripe free tiers, under $50 to first customer), Ch 5.5 (outbound: Apollo free + Gmail mail-merge + Loom free + Calendly free) |
| Module 2↔3 sequence swap DECIDED | Kept current order. Re-read Click's "Experiment" chapter: it's the lightweight landing-page-class test, NOT the heavier Design Sprint prototype + 5-user test. Our spine matches Click: Foundation (1.x) → Validate deeper (2.x) → Build. The reviewer's swap argument was anchored on "$300-500 ad spend before talking to anyone" — fixed by the $0-budget reframe instead of restructure. Decision doc: 20.10-sequence-decision-validate-vs-smoke-test.md |

---

## Course Migration Schedule (8-Part Template Rollout)

**Reference docs:** 30.03 §8 (migration guide), 40.08 (gap report — all 21 chapters at 1.0-1.5/8), Appendix A micro-lesson example

### Scheduling Principles

Six principles drive this schedule. The wrong order wastes hours; the right order compounds learning.

1. **Mechanical before creative.** Edits that follow a formula (add one outcome sentence, convert a table to a numbered list) require zero design brain. Do them all first while the mental model of the template is fresh. Creative rewrites (splitting a 3,000-word chapter into 4 micro-lessons) need the template to be second nature.

2. **Complete one module end-to-end before fanning out.** The trap: add hooks to all 21 chapters, then outcomes to all 21, then concept blocks to all 21. You never see a single lesson fully working until the last pass. Instead: finish Module 1 (4 chapters → micro-lessons) completely. Ship it. Learn what broke. Apply those lessons to Module 2. Each module gets better.

   **Exception: Phase 0 mechanical edits.** Adding one-sentence outcomes, success checks, and Stuck? boxes is purely formulaic — pull a YAML field, add a table row, name a common stall point. No design brain required. Fanning these out to all 21 chapters in one pass is safe and efficient. The principle applies to Phase 2 creative rewrites, where the risk of inconsistent bridges and broken handoffs is real.

3. **Pilot before scale.** The first micro-lesson rewrite takes 3× longer than the fifth because you're discovering the real constraints — how 300 words actually feels, where Mermaid diagrams break on mobile, whether the bridge dependency actually holds. Do a 1-chapter pilot, measure the real time, recalibrate the estimates, then scale.

4. **Top-of-funnel first.** Module 1 is where students decide to stay or leave. Improvements here have the highest conversion leverage. It's also the simplest module (no Supabase, no Stripe webhooks, no cold outreach). Start here to build momentum.

5. **Dependency order within modules.** Never rewrite a chapter that depends on artifacts from a chapter you haven't rewritten yet. The bridge handoff (template §2.8) requires both lessons to be stable. Rewrite modules in linear order: 1 → 2 → 3 → 4 → 5.

6. **High-complexity last.** Module 4 (Supabase wiring, Stripe webhooks, RLS policies) and Module 5 (paid pilot negotiation, cold outbound sequences) are the hardest to compress into 300-word concept blocks. By the time you reach them, you've done 10+ micro-lessons in simpler modules. The template is muscle memory.

---

### Phase 0: Remaining Quick Wins (DEFERRED — postponed until pilot lessons complete)

> **Naming note:** This "Phase 0" is the mechanical quick-wins pass (outcome sentences, success checks, Stuck? boxes). It is separate from **Option C** (Quickstart, FAQ, "What not to learn," 6 Sam fixes) which is complete per 30.03 §8.4. See 30.03 §8.5 for the consolidated web delivery roadmap.

**Status:** Deferred. Postponed until pilot lessons complete per user direction (2026-06-10). These are mechanical edits that don't require rewriting chapters — do them in one focused session when ready.

| Step | Action | Chapters | Est. time |
|---|---|---|---|
| 0.1 | Add one-sentence outcomes | 21 | ~42 min |
| 0.2 | Add success checks to "What to do next" tables | 21 | ~42 min |
| 0.3 | Roll out Stuck? boxes to remaining chapters | 16 (5 already done) | ~80 min |

**How:** Pull the `goal` field from `data/course_sequence.yaml` for each chapter's YAML frontmatter. Format: "After this chapter you will be able to: [goal]." Place after the Input/Output callout. For success checks: add a final row to each "What to do next" table — "✅ Success check:" with a verifiable condition. For Stuck? boxes: name the most common first-timer stall point for that chapter, give a concrete fix, place after existing "If blocked."

**Gate:** Hugo build passes. No content rewrites — these are mechanical additions.

---

### Phase 1: Pilot Micro-Lesson Rewrite (✅ COMPLETE 2026-06-08, ~3 hours actual)

**Status:** ✅ DONE. Chapter 1.2a (Smoke Test Build) migrated to 2 micro-lessons. Real time-per-lesson ~45 min (first draft + review). Template refinements + pilot findings recorded in "What just shipped" block above. Phase 2 can now proceed using the validated pattern.

| Step | Action | Est. time |
|---|---|---|
| 1.1 | Select pilot chapter | 5 min |
| 1.2 | Split chapter into 2-3 micro-lessons (concept boundaries) | 30 min |
| 1.3 | Write all 8 parts for each micro-lesson | 2 hours |
| 1.4 | Build Hugo, fix lint issues, verify on mobile viewport | 30 min |
| 1.5 | Code review + final polish | 30 min |
| 1.6 | Write post-pilot notes: actual time-per-lesson, surprises, template refinements | 15 min |

**Recommended pilot:** Chapter 1.2a (Smoke Test Build). Reasons:
- Lowest word count (2,364) → easiest to split
- Already at 1.5/8 (Stuck? box + anchor links + visual)
- Simple domain (landing page, not database schemas)
- Top of Module 1 — the first module gets rewritten first anyway
- Natural split points: builder choice → page elements → tracking setup

**Alternative if 1.2a is too tool-dependent:** Chapter 2.1 (Mom Test, 2,931 words). The 5 micro-lesson exploration drafts (Mom Test 3-lesson sequence + paid-pilot + mom-test-5-questions) were removed 2026-06-08 to start the migration from a clean slate. The pilot would be a fresh rewrite using 30.03 Appendix A as the canonical pattern.

**Gate:** One chapter fully migrated. Real time-per-lesson measured. Template refinements documented. Only then proceed to Phase 2.

---

### Phase 2: Module-by-Module Full Migration (~2-4 weeks, raises median to 6.5+/8)

**Status:** Not started. Rewrite all remaining chapters module by module, completing each module fully before moving to the next.

#### Module 1 — Hypothesis & Smoke Test (~3-4 days)

4 chapters → ~5 micro-lessons. Simplest content, highest leverage.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 1.1 Founding Hypothesis | ~2 lessons | Mad Libs frame → 4-lens scoring |
| 1.2a Smoke Test Build | ~2 lessons | Builder choice + page elements → tracking setup |
| 1.2b Smoke Test Run | ~1 lesson | Ad setup + reading conversion rate + go/iterate/kill (can fit 300-word concept block) |
| 1.3 Price Hypothesis | ~1 lesson | Stripe Payment Link setup + price interpretation |

**Module 1 exit gate:** All 5 micro-lessons follow 8-part template. Hugo build ✓. Mobile viewport ✓. Bridge chain integrity verified (1.1 → 1.2a → 1.2b → 1.3 → M2 intro).

#### Module 2 — Validate the Problem (~4-5 days)

5 chapters → ~6 micro-lessons. Medium complexity — the content is interview scripts and outreach, not technical. But it's the longest module.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 2.1 Mom Test | ~2 lessons | 5-question script → scoring rubric + synthesis decision |
| 2.2 AI Personas [OPTIONAL] | ~1 lesson | One standalone optional lesson — skip-safe |
| 2.3a Find People | ~1 lesson | ICP sharpening + community discovery + search strings |
| 2.3b Outreach | ~1 lesson | Outreach templates + booking cadence |
| 2.4 Clickable Prototype | ~1 lesson | Lovable prototype build + 5-user test signals |

**Module 2 exit gate:** All 6 micro-lessons follow template. Core path (2.1 → 2.3a → 2.3b → 2.4) produces validated problem statement without 2.2. Bridge chain verified.

#### Module 3 — Design from Evidence (~2-3 days)

2 chapters → ~3 micro-lessons. Shortest module, fastest to rewrite.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 3.1 Product Brief | ~2 lessons | Problem statement → user + build + metric + no-go rows |
| 3.2 Outcomes Check | ~1 lesson | Feature audit → outcome mapping → decision |

**Module 3 exit gate:** All 3 micro-lessons follow template. The brief-to-outcomes handoff is tight — the bridge from 3.1 names exactly which rows 3.2 audits.

#### Module 4 — Build It Yourself (~4-5 days)

5 chapters → ~6 micro-lessons. **Highest technical complexity.** Supabase RLS, Stripe webhooks, SQL self-tests, 12 build rules. This is where the 300-word concept block constraint is hardest to satisfy.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 4.1 Hire Decision | ~1 lesson | Decision tree → path selection |
| 4.2 Ownership Audit | ~1 lesson | 12-item checklist → recovery email |
| 4.3a Stack Tools | ~2 lessons | What each tool does → pre-flight rules |
| 4.3b Build Phases | ~2 lessons | Phases 1-2 (UI + auth) → Phases 3-4 (Stripe + deploy) |
| 4.4 Ceiling Signals [OPTIONAL] | ~1 lesson | One standalone optional lesson |

**Module 4 exit gate:** All 6 micro-lessons follow template. Technical concept blocks pass the ≤300-word check. RLS + webhook concepts distilled to 3 sentences each. Bridge chain verified. Optional 4.4 skip-safe.

#### Module 5 — First Paying Customer (~4-5 days)

5 chapters → ~6 micro-lessons. Highest emotional stakes — asking for money, cold outreach, PMF testing. The paid pilot DPA template is the hardest single block to compress.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 5.1 PMF Test | ~1 lesson | Survey setup → 40% threshold interpretation |
| 5.2 Channel Selection [OPTIONAL] | ~1 lesson | One standalone optional lesson |
| 5.3 Personal Network | ~1 lesson | 8-name audit → outreach motion |
| 5.4 Paid Pilot | ~2 lessons | DPA template → Stripe deposit + kickoff cadence |
| 5.5 Cold Outbound [OPTIONAL] | ~1 lesson | Filter → personalize → Loom → Calendly pipeline |

**Module 5 exit gate:** All 6 micro-lessons follow template. DPA template split into concept block (<300 words) + do-this-now steps. Bridge chain verified. Win recap + share prompt on final lesson. Completion Toolkit bundle linked.

---

### Phase 3: Cross-Cutting Polish Pass (~2-3 days)

**Status:** Not started. After all 5 modules are rewritten, do a single pass across all lessons to ensure consistency.

| Step | Action | Est. time |
|---|---|---|
| 3.1 | Verify every bridge names a specific dependency (not just "Next: Ch X") | ~1 hour |
| 3.2 | Verify core path alone produces all 6 artifacts without touching optional lessons | ~30 min |
| 3.3 | Verify emotional arc (40.06 trust curve) is preserved across micro-lessons | ~1 hour |
| 3.4 | Verify all 6 artifacts are bundled in final Completion Toolkit reference | ~30 min |
| 3.5 | Mobile viewport test on all lessons (375px iPhone SE) | ~1 hour |
| 3.6 | Full Hugo build + validate-course + link checker | ~30 min |
| 3.7 | Update landing page module maps to reflect new lesson structure | ~30 min |
| 3.8 | Update Quickstart to reflect micro-lesson path | ~30 min |
| 3.9 | Final code review | ~30 min |

**Phase 3 exit gate:** All lessons pass template QA checklist (30.03 §7). Hugo build ✓. validate-course ✓. Mobile viewport ✓. Emotional arc preserved. Core path produces all artifacts.

---

### Total Estimated Effort

| Phase | Description | Est. time | Cumulative median score |
|---|---|---|---|
| Phase 0 | Quick wins (mechanical) | ~2 hours | 1.0 → ~2.5/8 |
| Phase 1 | Pilot micro-lesson rewrite | ~4 hours | Proof of concept |
| Phase 2 | Module-by-module full migration | ~2-4 weeks | 2.5 → ~6.5+/8 |
| Phase 3 | Cross-cutting polish pass | ~2-3 days | 6.5 → 7.0+/8 |
| **Total** | | **~3-5 weeks** | **1.0 → 7.0+/8** |

> **Day estimates in Phase 2 include:** writing + Hugo build verification + mobile viewport check + bridge chain verification per module. Not pure writing time — the overhead of splitting chapters, designing bridge dependencies, and compressing concept blocks is baked in.

> **Why the range:** Phase 2 is `2-4 weeks` based on pilot data from Phase 1 (~45 min per lesson real time). The 30.03 Appendix A example took ~30 min for one lesson; at 20-25 lessons, that's 15-19 hours of pure writing. But splitting chapters, designing bridges, compressing concept blocks, and fixing mobile issues adds overhead. The 2-week estimate assumes 4 lessons/day (sustainable pace after pilot); the 4-week estimate allows for Module 4's technical complexity and Module 5's emotional-stakes rewrites.

---

### Risk Mitigation

| Risk | Mitigation |
|---|---|
| Phase 2 stretches past 4 weeks | Ship module-by-module. Each module is independently shippable — Module 1 can go live while Module 2 is still being written. Never block the whole release on the last module. |
| Phase 0 work is deferred until after pilot lessons complete | Phase 0 costs ~2-3 hours. Deferred per user direction (2026-06-10) so pilot momentum is not interrupted. Execute when pilot lessons are stable and Phase 2 begins. |
| Technical chapters (4.3a, 4.3b) can't compress to 300 words | Allow 400-word concept blocks for technical chapters with hard constraints (RLS, webhooks). The template says ≤300; the spirit is "no bloat." A 400-word block that genuinely needs the space is better than a 300-word block that omits a critical concept. Flag these as exceptions in the rewrite notes. |
| Bridges break when upstream lesson changes | The Phase 3 bridge audit catches these. Do NOT try to get bridges right on first pass — expect them to need adjustment when the full chain is visible. |
| Phase 1 pilot diverges from 30.03 Appendix A worked example | 30.03 Appendix A is the canonical pattern. If Phase 1 discovers the pattern needs refinement, update 30.03 (with user approval) — do not let the pilot silently set a different precedent. |
| Mobile viewport issues discovered late | The Phase 3 viewport test is a safety net, not the primary check. Test each module's lessons on mobile as part of the module exit gate. Don't defer all mobile testing to the end. |

---

## Practicality Model Chapters

Preserve these as the standard for future edits:

- Ownership audit
- Friday demo
- Weekly report
- SOW review
- Salvage/rebuild
- Switch dev shops
- AI agency questions
- AI token bill
- Slopsquatting gate
