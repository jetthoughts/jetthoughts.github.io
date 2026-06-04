# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-06-04 (40.06 Sam journey report complete)
**Status legend**: Planned | Drafting | In review | Done | Paused | Dropped

---

## Current Active Scope

This tracker only covers post-course cleanup required before launch.

Current source of truth:

- Chapter order: `data/course_sequence.yaml`
- Project context and integration rules: `PROJECT-INDEX.md`
- ICP lens: `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`
- Voice lens: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`

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
| P2 | Add "Skip to the action" anchor links to longest chapters (40.05 Rec #1) | Planned | Add blockquote callout after Input/Output box in M1.1, M3.2, M4.3 with anchor links to key sections (template, sprint, PASS bar, AI block etc.). Serves crisis and skim-first founders. ~15 min per chapter. See 40.05 §Top 3 Recommendations #1. |
| P2 | Add burned-founder acknowledgment callouts in Module 2 (40.05 Rec #2) | Planned | Read M2.1 + M2.2, identify optimal insertion point, add empathetic blockquote modeled on M5.4's tone ("If you've been burned before..."). Module 2 scored weakest for burned founder (7/10). ~15 min per chapter. See 40.05 §Top 3 Recommendations #2. |
| P2 | Add TL;DR summaries to all chapters — phased rollout (40.05 Rec #3) | Planned | Add 2-3 line TL;DR after Input/Output callout: what you'll do, why it matters, deliverable, where it goes next. Phase 1: 5 chapters + browser-use verification. Phase 2: fan out remaining 13. ~5 min per chapter. See 40.05 §Top 3 Recommendations #3. |
| P2 | Add completion criteria to every chapter | Planned | Each chapter should end with "Done when / Next click / If blocked" so the founder knows when to move on. Template: `## Done when` + checklist + `## Next click` + conditional routing. 18 chapters. |
| P2 | Tighten practical proof in weaker modules | Planned | Early validation and market-type chapters need more concrete founder examples, exact time boxes, and decision thresholds. |
| P2 | Collapse outreach-sequence-template variant runs | Planned | 2026-05-23 audit found 3 variant groups rendered as 3 separate blockquote boxes each (LinkedIn DM openers ×3, cold-email subject lines ×3, possibly Day 1/3/7 email sequence ×3). Merge each group into ONE blockquote (use `>` blank-line separators) per the no-stacked-quotes rule. Lower priority because it's an artifact/template page, not a numbered linear chapter. |
| P2 | De-stack + rebalance "$0 path" callouts (outbound, self-serve-mvp) | Planned | 2026-05-23: two chapters still have a "$0 path / $0 outbound stack" blockquote callout immediately under the Module banner (top-stack). Bundle with the deferred Module 4/5 budget-rebalance pass - de-stack to plain prose AND rebalance the framing per `feedback_budget_stance_free_and_paid_equal` (free and paid as equal options, reader chooses; don't lead with "$0 first"). |
| Dropped | Add time-badge to each chapter header | Dropped (2026-06-02) | Each chapter needs a "**Time**: ~45 min" badge at the top so the reader can plan their session. 18 chapters. Dropped per user direction — time anchoring contradicts the ADR §1 policy of avoiding speculative effort estimates. |
| P1 | Build companion-post FAQ collection | New (ICP walkthrough 10.06) | Create a curated FAQ linking 8 companion posts as "read next" sidebars in relevant chapters. Currently only linked via course-frame nav. |
| P1 | Rescue-path routing audit | New (ICP walkthrough 10.06) | Audit all 5 module-start chapters for consistent burned-founder rescue-path routing. Chapter 1.1 had routing blocks added then removed; ensure uniform approach across spine. |
| P3 | Cover image regen audit for non-spine posts | Planned | 2026-05-20: 14 spine covers regenerated to clean "Curriculum 2026" badge. ~30 companion-post covers still have "Curriculum NN/30" stale counter. Regen via chrome-devtools at 2400×1260 if posts stay in active rotation. |
| ✅ Done | Update decision doc 20.10 with Click correction | Done | Decision block added at top of 20.10.md (2026-05-20) marking Recommendation section as superseded. TASK-TRACKER entry updated 2026-05-29. |
| ✅ Done 2026-06-04 | Add Sam customer journey report (40.06) with trust score methodology | Done | Single-ICP narrative spanning all 18 chapters + landing page. 3 entry-point doors. Per-chapter trust scores with emotional arc. Double-dip U-curve visualization. Appendix D: 19-row recalibrated trust score table with calibration constraints. Commit 63fb7d73. |

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
