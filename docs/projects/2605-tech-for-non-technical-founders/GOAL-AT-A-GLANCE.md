# Tech for Non-Technical Founders 2026 — Goal At-A-Glance

**ONE-PAGE EXECUTIVE SUMMARY** for agents and stakeholders.

**Project ID**: 2605-tech-for-non-technical-founders
**Created**: 2026-05-12
**Last restructured**: 2026-05-20 (Module 1+2 merged into single Hypothesis & Smoke-Test module; 6 modules → 5 modules; $0-budget reframe applied; YAML `goal` field added per chapter; Module → Chapter nomenclature unified)
**Status**: 🎉 Course shipped end-to-end (5 modules · 18 linear chapters + 1 glossary · 15 artifacts as of 2026-05-20). Live at `/blog/tech-for-non-technical-founders-2026/`.
**Owner**: JT content team
**Parent**: 2510-seo-content-strategy (extends, does not replace)

---

## 🎯 THE GOAL (30-second summary)

Publish a **free 5-module course that takes a non-technical founder from idea to first paying customer** in the most effective way for 2026 — and lets them run the whole thing on **$0 budget** if they want. The course is structured as **5 modules with input → output → checkpoint → artifact per module**. The reader compiles a personal "Founder OS" by working through the modules.

**Course promise**: From idea to first paying customer in the most effective way for 2026. You walk away with: validated hypothesis, live smoke-test landing page, signed validated problem statement, Product Brief, build decision, live MVP (self-serve or hired), **and one signed paid pilot**.

**Course philosophy**: Don't hire engineers if you don't have to. If you must hire, hire surgically. Don't ship more product before someone pays. The course teaches the SIMPLEST method that works for solo non-tech founders on **$0 budget by default**; paid tools (Lovable Pro, Apollo Pro, $300-500 ads) are optional accelerators, not gates. Structured frameworks (Foundation Sprint, JTBD Canvas, Shape Up, Impact Mapping) are demoted to optional "Advanced" sidebars.

**Positioning sentence**: A free competing curriculum to YC Startup School, Sophia Matveeva's Tech for Non-Technical Founders ($530/mo), Drew Falkman's Vibe Coding ($1,000), and the Kukoyi 2017 book — the only one that maps the full 5-module journey (form hypothesis + smoke-test → validate problem → write product brief → choose and run the build → close first paid pilot) without selling itself. Sequence matches Click's Foundation Sprint (lightweight Experiment before heavier Design Sprint prototype), Steve Blank Customer Development (Discovery before Validation), and the Mom Test (interviews-first for deep validation).

**JT positioning** (Option C: Pure Lead Magnet, no selling): the course does NOT pitch JT services. Zero "book a Control Audit" CTAs, zero "schedule a consultation," zero service offers. Authorship credit stays at the footer ("Built by JetThoughts as part of the free curriculum"). Lead capture works via email-gated artifact downloads only. See `feedback_curriculum_is_pure_lead_magnet.md`.

**Engineered for viral sharing**: every post needs a contrarian hook, a quote-tweetable insight (140-280 chars), a specific tactic the reader can use this week, and a free downloadable artifact. See `feedback_curriculum_viral_shareability.md`.

---

## 📊 KEY METRICS DASHBOARD

Success metric: **share velocity + email captures + page-1 SEO** — NOT consultation bookings (course is a pure lead magnet, no service CTAs).

| Metric | Baseline | 6-Month Target | Source of Truth |
|---|---|---|---|
| Course chapters published | 18 live | 18 live + Founder Control Dashboard | `data/course_sequence.yaml` |
| Course landing page | live | optimized for burned-founder fast path | hugo build |
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

**Total: 18 linear chapters + 1 glossary** ("Five Tech Words to Stop Nodding At").

**Going further (after Module 5 gate)**: continuation chapters for churn triage, pivot or persevere, hire-track supplementary reference, management chapters (Friday Demo Rule, Weekly Dev Report, etc.), and AI-era chapters (Agency AI Questions, Token Bill, Slopsquatting). These are NOT in the linear sequence.

**Sequence rationale** (decided 2026-05-20): Module 1 packages Hypothesis + Smoke-Test together because Click's Foundation Sprint produces both as one output ("a clear hypothesis you can validate" via lightweight experiment). The smoke-test landing page is a positioning artifact + price test (free on Neeto/Carrd), not a paid-ads demand gate. Deeper Customer Discovery (interviews) happens in Module 2 with the landing page as the conversation opener. Sequence matches Click → Steve Blank Customer Development → Mom Test. See `20-29-strategy/20.10-sequence-decision-validate-vs-smoke-test.md`.

---

## 💡 DELIVERY PRINCIPLES

- **$0-budget default, paid as optional accelerator.** Every paid solution has a free alternative leading the chapter. Burned founders should never feel they have to spend more before they've talked to anyone.
- **Simplest method on main path.** Foundation Sprint, JTBD Canvas, Shape Up, Continuous Discovery, Impact Mapping, Empathy Mapping, Design Sprint all relegated to optional "Advanced" sidebars.
- **Course is a journey, not a topic list.** Every module's chapters share input/output/checkpoint/artifact framing. The artifacts compile into the reader's Founder OS.
- **Engagement-first delivery.** No word-count caps; cut test per section determines what stays.
- **≥3 handmade-style infographics per post** (Excalidraw aesthetic, Mermaid + SVG mix).
- **Tech stack defaults to Rails / Django / Laravel + full-stack-developer-ships-end-to-end pattern** in examples. No React/Node/Java as the lead example stack.
- **Course frame in every post**: top callout (Module X · Step N of M) + bottom course-nav table.
- **Zero parallel slugs to 2510 plan.** Curriculum framing added via callout, not by creating duplicates.

---

## 🚀 EXECUTION STATUS

### ✅ Shipped (as of 2026-05-20)
- 18 linear chapters across 5 modules (see `data/course_sequence.yaml`)
- Course landing page at `/blog/tech-for-non-technical-founders-2026/`
- 14 spine-chapter covers (Stitch-generated, "Curriculum 2026" badge, 2400×1260)
- 15 artifacts / lead magnets (Vibe PRD Template, Friday Demo Template, Ownership Checklist, SOW Reading Guide, etc.)
- Theme partial `course-prev-next.html` auto-renders nav from YAML
- Course-chapter visibility filter excludes spine from `/blog/` index

### 🔲 Open work (see TASK-TRACKER.md)
- **P0**: Repair missing artifact link (`/blog/founding-hypothesis-worksheet/` 404 — actually no chapter currently links to it, low scope), remove unfulfilled download promises (already done)
- **P1**: Burned-founder fast path on landing page, Founder Control Dashboard artifact, inline-templates audit, AI critic blocks per module (5 blocks), build 4 source-of-truth validators (Kaizen Muda outcome)
- **P2**: "Done when / Next click / If blocked" endings on every chapter (18 chapters), tighten practical proof in weaker modules
- **P3**: Cover regen for ~30 companion posts, decision-doc cleanup

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
| ICP-E (burned founder) bouncing on validation curriculum when they need rescue | Per-chapter routing block on Ch 1.1 routes burned readers to Ch 4.2 (Ownership Audit) or Ch 4.1 (Should You Hire) before validation work. Pattern to roll out to other module-start chapters. |

---

## 🔗 NAVIGATION

- **Source of truth (chapter order + goals)**: `../../data/course_sequence.yaml`
- **Research**: `10-19-research/10.01-course-program-landscape.md` + `10.02-curriculum-sequence-synthesis.md` + `10.05-content-organization-patterns-2026.md`
- **Strategy**: `20-29-strategy/20.01-course-modules.md` + `20.02-positioning-vs-courses.md` + `20.07-content-plan-tnt-founders-2026.md` (historical, superseded by current YAML) + `20.10-sequence-decision-validate-vs-smoke-test.md`
- **Execution / lead magnets**: `50-59-execution/lead-magnets/`
- **Open work**: `TASK-TRACKER.md`
- **Master content plan (parent)**: `../2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md`
- **Voice**: `../../90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`
- **ICP**: `../../90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`
