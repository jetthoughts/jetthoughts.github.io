# Tech for Non-Technical Founders 2026 — Goal At-A-Glance

**ONE-PAGE EXECUTIVE SUMMARY** for agents and stakeholders.

**Project ID**: 2605-tech-for-non-technical-founders
**Created**: 2026-05-12
**Last restructured**: 2026-07-09 (post-#345: course merged + live, M1 fully v2 with lessons 1.1-1.5, M2 v2 migration started)
**Status**: 🟢 Course MERGED + LIVE (PR #345, 2026-07-09) · 🟢 M1 fully v2 + hardened (4 review rounds) · 🔄 M2 v2 migration in flight (branch `module-2-validate-the-problem`)
**Owner**: JT content team
**Parent**: 2510-seo-content-strategy (extends, does not replace)

---

## 🔀 STRATEGIC PIVOT (2026-06-07) — READ FIRST

**v1 status**: Long-form course shipped end-to-end (5 modules · 18 chapters · 15 artifacts · 22+ iterations of Sam-loop polish). Live and functional.

**The problem with v1**: 40.08 gap report scored all 21 chapters against the canonical 8-part micro-lesson template (30.03 spec). **0 of 21 chapters score above 2/8.** The format is wrong for Sam — long-form chapters (2,000-4,500 words each) violate the micro-learning research (Cathy Moore's Action Mapping, Carroll's Minimalist Instruction, Fogg's B=MAP, NN/g F-pattern). The 16 iterations of surgical polish caught real defects but cannot fix the structural format gap.

**v2 direction**: 20-25 micro-lessons (400-600 words each, 5-10 min read + 5-15 min do). Per-lesson 8-part template (Hook → Outcome → Concept → Visual → Do-Now → Error Recovery → Reflection → Bridge). Same 6 artifacts, same emotional arc — radical compression, not scope reduction. See `30-39-architecture-design/30.03-course-format-requirements-for-creators.md` for the canonical spec.

**Migration plan (see `TASK-TRACKER.md` "Course Migration Schedule")**:
- ✅ **Phase 0 / Option C** (shipped 2026-06-07): Quickstart + FAQ + "What not to learn" + 6 Sam recommendations from 40.07
- 🔄 **Phase 1** (iterating 2026-06-08+): 2 pilot lessons (1.2a, 1.2b) being iterated to ideal quality. Strategy: pilot-first, then scale. Phase 2 gated behind: (1) both pilots pass all 6 Sam-review tests, (2) 5-Sam real-founder validation confirms template, (3) 30.03 §7 QA passes, (4) iteration refinements documented.
- 🔄 **Phase 2** (in flight): module-by-module migration. M1 ✅ complete + merged + live (PR #345, lessons 1.1-1.5). M2 🔄 in flight on `module-2-validate-the-problem` (template alignment done; Mia walkthrough + review loop next). M3-M5 🔲.
- 🔲 **Phase 3** (cross-cutting polish, gated): bridges + reflection + visual discipline + viral loop

**What we stopped**: Iter 17+ surgical loop on v1 long-form chapters. Each Iter-N round was catching diminishing-return defects. The structural format gap is solved by migration, not by line edits.

**For cold AI agents picking up the work**: Start at PROJECT-INDEX.md → "For a micro-lesson migration agent" route. The 30.03 spec is the canonical authority on lesson structure. The 40.09 QA report shows the 8-part template applied correctly to the Mom Test 3-lesson sample.

---

## 🎯 THE GOAL (30-second summary)

Publish a **free 5-module course that takes a non-technical founder from idea to first paying customer** in the most effective way for 2026 — and lets them run the whole thing on **$0 budget** if they want. The course is structured as **5 modules with input → output → checkpoint → artifact per module**. The reader compiles a personal "Founder OS" by working through the modules.

**Course promise**: From idea to first paying customer in the most effective way for 2026. You walk away with: validated hypothesis, live smoke-test landing page, signed validated problem statement, Product Brief, build decision, live MVP (self-serve or hired), **and one signed paid pilot**.

**Course philosophy**: Don't hire engineers if you don't have to. If you must hire, hire surgically. Don't ship more product before someone pays. The course teaches the SIMPLEST method that works for solo non-tech founders and presents free and paid tool options as equal choices the reader picks based on situation (see Delivery Principles below). Tool spend is bounded and channel-dependent (the smoke-test ad budget, for example, ranges from $300-$600 on Meta to $1,800-$6,600 on LinkedIn for the same 300-visit floor) - not a single global anchor. Structured frameworks (Foundation Sprint, JTBD Canvas, Shape Up, Impact Mapping) are demoted to optional "Advanced" sidebars.

**Positioning sentence**: A free competing curriculum to YC Startup School (free), Sophia Matveeva's Tech for Non-Technical Founders ($2,500-$3,500 one-time, verified 2026-05-22), Drew Falkman's Vibe Coding (~$1,000 Maven cohort, price gated/unverified), and the Kukoyi 2017 book — the only one that maps the full 5-module journey (form hypothesis + smoke-test → validate problem → write product brief → choose and run the build → close first paid pilot) without selling itself. Sequence matches Click's Foundation Sprint (lightweight Experiment before heavier Design Sprint prototype), Steve Blank Customer Development (Discovery before Validation), and the Mom Test (interviews-first for deep validation).

**JT positioning** (Option C: Pure Lead Magnet, no selling): the course does NOT pitch JT services. Zero "book a Control Audit" CTAs, zero "schedule a consultation," zero service offers. Authorship credit stays at the footer ("Built by JetThoughts as part of the free curriculum"). Lead capture works via email-gated artifact downloads only. See `feedback_curriculum_is_pure_lead_magnet.md`.

**Engineered for viral sharing (v1 long-form posts):** every post needs a contrarian hook, a quote-tweetable insight (140-280 chars), a specific tactic the reader can use this week, and a free downloadable artifact. See `feedback_curriculum_viral_shareability.md`. **v2 micro-lessons** follow 30.03 §2 template (1 visual max, 400-600w bands).

---

## 📊 KEY METRICS DASHBOARD

Success metric: **share velocity + email captures + page-1 SEO** — NOT consultation bookings (course is a pure lead magnet, no service CTAs).

| Metric | Baseline | 6-Month Target | Source of Truth |
|---|---|---|---|
| Course chapters published | 18 v1 + 2 v2 pilot live | 20-25 v2 micro-lessons + companion pages | `data/course_sequence.yaml` |
| Course landing page | live | optimized for Sam-first fast path | hugo build |
| Page-1 rankings on course keywords | 0 | 8+ across founder-focused keywords | GSC |
| Email captures from artifact downloads | 0 | 500+ across 7 honest artifacts | site analytics |
| Reddit / Twitter / Facebook shares per post | 0 | ≥25 shares per post within 30 days of publish | manual + Buffer/social tracking |
| Course completion signal (readers who hit ≥3 modules) | 0 | measurable via path tracking | analytics |

**Quality gates (non-negotiable)**: every post passes the JT voice rules (90.11), the multi-persona review, the slop detector ≤25/100, the shape-tell critic, the cold-eyes final pass. Every post carries the course frame (module callout + bottom course-nav). Every post includes ≥3 handmade-style infographics. Zero word-count caps; cut test per section. Tech examples default to Rails/Django/Laravel + full-stack pattern. **Zero JT service CTAs.** **Every post has a contrarian hook + one quote-tweetable insight + a specific weekly tactic + a downloadable artifact.**

---

## 🛣️ THE 5 MODULES (current spine)

Each module has an **input** (what the reader brings from the previous module), an **output** (the deliverable they walk away with), a **checkpoint** (signal they can move on), and an **artifact** (template/worksheet they fill in). Source of truth: `data/course_sequence.yaml` with `goal:` field per chapter.

| # | Module | Output you walk away with | Chapters |
|---|---|---|---|
| 1 | **Hypothesis & Smoke Test** | One-sentence Founding Hypothesis + live landing page with Stripe price button. $0 path: Carrd/Neeto free + organic share. | 3 |
| 2 | **Validate the Problem** | 10 Mom Test interview transcripts + signed validated problem statement + 2-hour clickable prototype shown to 5 subjects. | 4 |
| 3 | **Product Brief** | One-page Vibe PRD ready to hand to Lovable or a hired junior. Outcome-shaped, not feature-shaped. | 2 |
| 4 | **Choose Your Build** | Build decision (self-serve or hire) + Day-1 ownership audit + live MVP at staging URL (Lovable + Supabase + Stripe under $50/mo). | 4 |
| 5 | **First Paying Customer** | First signed paid pilot ($500 Stripe deposit) + repeatable outbound machine. Free-tier tool stack. | 5 |

**Total: 1 overview (Chapter 0) + 18 v1 long-form chapters + 2 v2 pilot micro-lessons + 1 glossary** ("Five Tech Words to Stop Nodding At"). Start at [How This Course Works](/course/tech-for-non-technical-founders-2026/how-this-course-works/) for the full route at a glance: 5-module flow, AI tool stack, SIPOC system map, and module gates.

### 📦 Current Inventory (canonical count)

| Category | Count | Source of truth |
|---|---|---|
| Linear course chapters (v1) | 18 | `data/course_sequence.yaml` (excl. Ch 0 + glossary) |
| Chapter 0 (overview) | 1 | `content/course/.../how-this-course-works/` |
| Glossary | 1 | `content/course/.../five-tech-words-stop-nodding-at/` |
| v2 pilot micro-lessons live | 2 | `smoke-test-build-page/` + `smoke-test-wire-tracking/` |
| Companion/supplementary pages | ~30 | Not in linear sequence; linked from Module 5 gate |
| Content directory entries (total) | 56 | `ls content/course/tech-for-non-technical-founders-2026/` |
| Artifacts/templates | 15 | Vibe PRD, Friday Demo, Ownership Checklist, SOW Guide, etc. |
| SVG illustrations | ~15+ | Per-lesson visual micro-aids |
| Cover images (spine, "Curriculum 2026" badge) | 14 | 2400×1260 Stitch-generated |
| Cover images (companion, "Curriculum NN/30" stale) | ~30 | P3 regen tracked in TASK-TRACKER |
| Validation gates | 4 | `bin/validate-course` (chapter-number, title-yaml, internal-links, table-width). 3/4 pass. |
| Project docs (active) | 31 | `docs/projects/2605-tech-for-non-technical-founders/` (excl. 11 archived) |
| PM health report | 1 | `40-49-review/40.10-senior-pm-health-report-2026-06.md` |

**Going further (after Module 5 gate)**: continuation chapters for churn triage, pivot or persevere, hire-track supplementary reference, management chapters (Friday Demo Rule, Weekly Dev Report, etc.), and AI-era chapters (Agency AI Questions, Token Bill, Slopsquatting). These are NOT in the linear sequence.

**Sequence rationale** (decided 2026-05-20): Module 1 packages Hypothesis + Smoke-Test together because Click's Foundation Sprint produces both as one output ("a clear hypothesis you can validate" via lightweight experiment). The smoke-test landing page is a positioning artifact + price test (free on Neeto/Carrd), not a paid-ads demand gate. Deeper Customer Discovery (interviews) happens in Module 2 with the landing page as the conversation opener. Sequence matches Click → Steve Blank Customer Development → Mom Test. See `20-29-strategy/20.10-sequence-decision-validate-vs-smoke-test.md`.

---

## 💡 DELIVERY PRINCIPLES

- **Effectiveness first; free and paid presented as equal options.** For each step, show both a free path and a paid path and let the reader choose what fits their situation - never prioritize free over paid (cheap) or push paid over free (greedy). Most readers have some budget; the goal is the most effective route to the outcome, not the cheapest one. Don't over-weight the money dimension - it's one input the reader decides on, not the theme of the chapter.
- **Simplest method on main path.** Foundation Sprint, JTBD Canvas, Shape Up, Continuous Discovery, Impact Mapping, Empathy Mapping, Design Sprint all relegated to optional "Advanced" sidebars.
- **Course is a journey, not a topic list.** Every module's chapters share input/output/checkpoint/artifact framing. The artifacts compile into the reader's Founder OS.
- **Engagement-first delivery (v1 long-form).** No word-count caps; cut test per section determines what stays. **v2 micro-lessons** follow 30.03 §1.6 word count bands (400-600w standard, 500-900w tool).
- **≥3 handmade-style infographics per v1 post** (Excalidraw aesthetic, Mermaid + SVG mix). **v2 micro-lessons cap at 1 visual per lesson** (30.03 §2.4, cognitive load theory).
- **Tech stack defaults to Rails / Django / Laravel + full-stack-developer-ships-end-to-end pattern** in examples. No React/Node/Java as the lead example stack.
- **Course frame in every post**: top callout (Module X · Step N of M) + bottom course-nav table.
- **Zero parallel slugs to 2510 plan.** Curriculum framing added via callout, not by creating duplicates.

---

## 🚀 EXECUTION STATUS

### ✅ Shipped (as of 2026-05-20)
- 18 v1 long-form chapters across 5 modules (see `data/course_sequence.yaml`) + 2 v2 pilot micro-lessons (1.2a, 1.2b) + 14+ companion/supplementary pages + Quickstart + FAQ + 'What not to learn'
- Course landing page at `/course/tech-for-non-technical-founders-2026/`
- 14 spine-chapter covers (Stitch-generated, "Curriculum 2026" badge, 2400×1260)
- 15 artifacts / lead magnets (Vibe PRD Template, Friday Demo Template, Ownership Checklist, SOW Reading Guide, etc.)
- Theme partial `course-prev-next.html` auto-renders nav from YAML
- Course-chapter visibility filter excludes spine from `/blog/` index

### 🔲 Open work (see TASK-TRACKER.md)
- **P1**: Landing-page fast-path routing for founders further along, Founder Control Dashboard artifact, downloadable PDF templates, companion-post FAQ collection, rescue-path routing audit (Alex-targeted, not Sam-targeted)
- **P2**: Skip-to-action anchor links, Module 2 encouragement callouts (Sam-first, not burn-trauma), TL;DR summaries, completion criteria per chapter, tighten practical proof
- **P3**: Cover regen for ~30 companion posts, Wizard of Oz Concierge MVP, echo chamber warning (done in Ch 5.3), Loom outreach, Engineering as Marketing

### Phase pipeline
- LinkedIn promotion per post (Paul Keen voice) — ongoing
- Course completion path tracking — pending analytics setup
- Quarterly refresh sweep for AI-era posts — Q1 2027 first refresh

---

## ⚠️ TOP RISKS

| Risk | Mitigation |
|---|---|
| Re-introducing complexity via "improvements" | Memory feedback `feedback_kiss_simplest_solutions_only.md` lives in every agent brief; Advanced frameworks stay in sidebars |
| Spine drift after future restructures | P1: build 4 source-of-truth validators (chapter-number consistency, title-YAML byte match, internal-link existence, mobile-table width) per Kaizen Muda analysis |
| 2510 LinkedIn validation sprint already in flight - schedule conflicts | The wrap posts ship per 2510 calendar; the 2605 curriculum framing is added retroactively. Zero schedule conflicts. |
| AI-era posts (Going further) decay fast | Date-stamp every AI-era post + Q1 2027 refresh trigger |
| ICP-E (burned founder) bouncing on validation curriculum when they need rescue | Routed at the entry point: the landing page "Already started building?" fast path sends readers who are further along to Ownership Audit / Friday Demo / Weekly Report / Salvage-Rebuild before any validation work. Chapter bodies are written to the primary course ICP (Sam, first-timer, no burn history). **Alex (burned founder) is the website lead-gen ICP (90.10), NOT the course design target (Sam, per 40.06).** |

---

## 🔗 NAVIGATION

- **PM health report (canonical inventory + RAG dashboard)**: `40-49-review/40.10-senior-pm-health-report-2026-06.md`
- **Source of truth (chapter order + goals)**: `../../data/course_sequence.yaml`
- **Research**: `10-19-research/10.01-course-program-landscape.md` + `10.02-curriculum-sequence-synthesis.md` + `10.08-validation-tools-analysis-2026.md`
- **Reviews**: `40-49-review/40.03-sipoc-course-logic.md` (canonical SIPOC) + `40-49-review/40.04-execution-readiness-sweep-2026-06.md` + `40-49-review/40.05-multi-perspective-icp-review-2026-06.md` + `40-49-review/40.06-sam-customer-journey-report-2026-06.md` + `40-49-review/40.07-sam-experience-improvement-report-2026-06.md`
- **Course format spec (creators)**: `30-39-architecture-design/30.03-course-format-requirements-for-creators.md` — canonical micro-learning requirements, lesson template, gap analysis, migration guide
- **Strategy**: `20-29-strategy/20.01-course-modules.md` + `20.02-positioning-vs-courses.md` + `20.10-sequence-decision-validate-vs-smoke-test.md`
- **Open work**: `TASK-TRACKER.md` (single source of truth for all active tasks)
- **Low-impact ideas**: `LOW-IMPACT-IDEAS-BANK.md` (deferred, dropped, and P3 ideas)
- **External research**: `../../docs/_research/` (Russian-language market research)
- **Voice**: `../../90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`
- **ICP (course design target):** Sam (first-timer non-technical founder, no burn history, no PM background). Definitive doc: `40-49-review/40.06-sam-customer-journey-report-2026-06.md`.
- **ICP (website lead-gen):** Alex (burned founder). Defined in `../../90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`. NOT the course design target.

> **Note**: The parent content plan (`2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md`) is the site-level SEO calendar. The course shipped independently on its own timeline and does not depend on that plan. The archived `_ARCHIVED_20.07-content-plan-tnt-founders-2026.md` was a 26-post site-level content draft, not a course plan.
