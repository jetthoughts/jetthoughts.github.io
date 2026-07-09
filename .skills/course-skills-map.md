# Course Skills Map — From Idea to Ideal Released Course

**Purpose:** Maps global Codebuff skills to the 7 phases of taking the Tech for Non-Technical Founders course from current state to the ideal released product that Sam loves and promotes.

**Global skills live at:** `~/.agents/skills/<skill-name>/`
**Local skills live at:** `.skills/<skill-name>/`

**Foundational docs (read first):**
- **PRD**: `.agent/prd/PRD.md` — formal product requirements, 5-module architecture, 15 canonical quality gates, migration phases
- **Tasks**: `.agent/tasks.json` — 34 trackable tasks (TASK-1 through TASK-34) for the v2 migration
- **Roadmap**: `docs/projects/2605-tech-for-non-technical-founders/20-29-strategy/20.11-course-migration-roadmap.md` — Now/Next/Later dependency-aware schedule
- **Task Tracker**: `docs/projects/2605-tech-for-non-technical-founders/TASK-TRACKER.md` — single source of truth for all post-ship improvements

**Current progress (2026-06-10):**
- ✅ Phase 1 (Pilot): Complete — 2 v2 micro-lessons shipped (1.2a, 1.2b)
- 🔲 Phase 0 (Mechanical quick wins): Deferred
- 🔲 Phase 2 (Module-by-module migration): Not started — M1-M5 pending
- 🔲 Phase 3 (Cross-cutting polish): Not started
- 🔲 5-Sam Validation Pilot: Planned — before Phase 2 fan-out

---

## Phase 1: Course Design & Architecture (NOW — migration prep)

**Status:** ✅ Pilot complete. Phase 2 pending 5-Sam validation gate.

| Skill | Why | When to use |
|---|---|---|
| **course-designer** (global) | Learning objectives, Bloom's taxonomy, assessment rubrics, syllabi | Designing module-level outcomes, ensuring lesson sequences build correctly, writing assessment gates |
| **customer-research** (global) | Validate what Sam actually needs, mine Reddit/G2/reviews for pain language | Before creating new lessons, when unsure if a topic belongs in the course |
| **customer-journey-map** (global) | Map Sam's emotional arc through all 5 modules, identify friction points | Auditing the full course flow, finding gaps in the trust curve (see 40.06) |
| **problem-statement** (global) | Frame "who is blocked, what they're trying to do, why it matters" | Sharpening the course promise, Quickstart page, module intros |
| **course-lesson-write** (local) | Draft 8-part micro-lessons from topic briefs. References PRD, tasks.json, 30.03 spec. | Every new Phase 2 lesson — core workflow. Maps to TASK-2 through TASK-26. |
| **course-lesson-review-sam** (local) | Sam-perspective review with 6 tests. References PRD, 30.03 spec, 40.11 simulation. | Before every lesson commit |
| **course-lesson-validate** (local) | Mechanical QA: build, validate, em-dash, word count, links, SVGs. References PRD, 30.03 §7. | Before every lesson commit |
| **course-svg-draft** (local) | JT-brand hand-drawn SVG illustrations. References PRD, pilot SVGs. | When a lesson needs a visual micro-aid |
| **task-breakdown** (global) | Break overwhelming tasks into manageable steps | Migrating modules one-by-one, planning the Phase 2 schedule |
| **product-marketing-context** (global) | Creates reusable context doc — course product, ICP (Sam), positioning — that every marketing skill references | BEFORE any copywriting, SEO, or landing page work. Foundational. Creates `.agents/product-marketing-context.md`. |
| **senior-pm** (global) | Portfolio mgmt, quantitative risk analysis, resource optimization, stakeholder alignment, executive reporting | Organizing project artifacts, auditing doc health, tracking milestones across phases. See 40.10 health report. |
| **prd-creator** (global) | Creates structured PRDs + generates implementation task lists in JSON | Already invoked — PRD at `.agent/prd/PRD.md`, tasks at `.agent/tasks.json`. Re-invoke if scope changes. |
| **roadmap-planning** (global) | Strategic roadmap, prioritization, epic definition, sequencing | Already invoked — roadmap at `20.11-course-migration-roadmap.md`. Re-invoke if schedule changes. |

## Phase 2: Content Creation & Voice (NOW — gated behind 5-Sam pilot)

| Skill | Why | When to use |
|---|---|---|
| **copy-editing** (global) | Edit, review, improve existing copy | Polishing existing v1 chapters during migration, refreshing lesson bodies |
| **copywriting** (global) | Write marketing copy for any page | Course landing page hero, module intros, CTA copy |
| **humanizer** (global) | Remove AI-generated writing signs from text | Final polish pass on every lesson before publish — catches AI tells the voice guide misses |
| **slop-detector** (global) | Detect and flag AI content markers | Auditing lessons for AI-pattern tells, verifying voice guide compliance at scale |
| **blog-post** (global) | Write long-form blog posts with SEO optimization | Companion blog posts that promote the course, deep-dive articles that drive traffic |
| **content-trend-researcher** (global) | Analyze trends across Google, Reddit, Substack, LinkedIn, YouTube for data-driven article outlines | Finding trending topics for companion blog posts that drive traffic to the course |
| **technical-writing** (global) | Create clear, in-depth developer tutorials | If any technical companion pages are needed (Supabase setup, Stripe webhook guide) |

## Phase 3: Marketing Infrastructure (NEXT — after content is 80% done)

| Skill | Why | When to use |
|---|---|---|
| **seo-audit** (global) | Audit technical SEO issues on course pages | Before launch — check meta tags, headings, crawlability, page speed |
| **ai-seo** (global) | Optimize for AI search engines, get cited by LLMs | After SEO audit — optimize for ChatGPT/Perplexity/Claude citations |
| **schema-markup** (global) | Add Course, FAQ, HowTo, Breadcrumb structured data | After content is stable — rich results for course pages in Google |
| **site-architecture** (global) | Plan page hierarchy, navigation, URL structure, internal linking | Designing the course navigation, ensuring proper breadcrumbs and link chains |
| **blog-page-generator** (global) | Create blog listing/index pages | Building a course blog hub page that indexes all companion posts |
| **programmatic-seo** (global) | SEO-driven pages at scale using templates | If building city/industry-specific course landing pages at scale |
| **analytics-tracking** (global) | Set up GA4, conversion tracking, event tracking | Track lesson completion, CTA clicks, email captures, share events |

**Gate to Phase 4:** All Phase 3 skills invoked. SEO audit clean. Schema markup deployed. Site architecture finalized. Analytics baseline captured.

---

## Phase 4: Landing Page & Conversion (NEXT)

| Skill | Why | When to use |
|---|---|---|
| **landing-page-optimization** (global) | Landing page creation, copywriting, design, conversion | Course landing page (`_index.md`) — hero section, CTAs, social proof, module map |
| **page-cro** (global) | Conversion rate optimization for any marketing page | Optimizing the landing page conversion rate, A/B testing CTAs |
| **copywriting** (global) | Hero copy, CTAs, value propositions | Writing the landing page copy in ICP-E voice |
| **marketing-psychology** (global) | Behavioral science, cognitive biases, persuasion | Framing the value proposition, designing trust triggers, pricing anchors |

## Phase 5: Distribution & Promotion (LATER)

| Skill | Why | When to use |
|---|---|---|
| **social-content** (global) | LinkedIn, Twitter, Instagram content creation and scheduling | Paul Keen LinkedIn posts promoting the course, founder Twitter threads |
| **email-sequence** (global) | Create nurture sequences, launch emails, lifecycle emails | Course launch email sequence, re-engagement for drop-offs, completion emails |
| **launch-strategy** (global) | Product launch planning, Product Hunt, beta launch | Planning the course launch — Product Hunt, Hacker News, Indie Hackers, Reddit |
| **cold-email** (global) | B2B cold outreach emails | If reaching out to newsletter curators, podcast hosts, or distribution partners |
| **content-strategy** (global) | Plan what content to create, topic clusters, editorial calendar | Planning the blog + social content calendar that funnels into the course |
| **solo-founder-gtm** (global) | Solo founder GTM motion, AI agent team for go-to-market | Designing the full marketing engine as a solo team with AI agents |
| **competitor-alternatives** (global) | Competitor comparison vs alternative pages | Building "vs YC Startup School" or "vs Lenny's Newsletter" comparison pages |
| **marketing-ideas** (global) | Brainstorm marketing tactics, growth ideas, promotion strategies | When stuck on promotion — "how else can I get this course in front of Sam?" |

## Phase 6: Growth & Conversion (LATER)

| Skill | Why | When to use |
|---|---|---|
| **lead-magnets** (global) | Plan email capture content, downloadable resources | Bundling the 6 Founder OS artifacts as a downloadable lead magnet |
| **referral-program** (global) | Referral program, affiliate, word-of-mouth strategy | Building the milestone referral program from 30.03 §6.4 |
| **ab-test-setup** (global) | Plan A/B tests, growth experiments | Testing landing page variants, email subject lines, CTA copy |
| **analytics-tracking** (global) | Optimize conversion tracking, event funnels | Refine lesson completion tracking, email capture funnels, share velocity metrics |

## Phase 7: Product Strategy & Pricing (IF MONETIZING)

| Skill | Why | When to use |
|---|---|---|
| **positioning-statement** (global) | Geoffrey Moore positioning — who, what, why different | Clarifying course positioning against YC, Lenny, Reforge, Maven |
| **product-strategy-session** (global) | End-to-end strategy: positioning, discovery, roadmap | If pivoting to a paid course or cohort-based version |
| **pricing-strategy** (global) | Pricing decisions, packaging, monetization strategy | If the course becomes a paid product (freemium → paid tiers) |
| **launch-strategy** (global) | Product launch planning | Launching a paid tier or premium companion offering |

---

## Immediate Next Actions (Phase 1 & 2)

These skills should be invoked NOW during the micro-lesson migration:

1. **course-lesson-write** — Draft M1 lessons per TASK-2 through TASK-5 (after 5-Sam pilot gate clears)
2. **5-Sam Validation Pilot** — Recruit 3-5 real founders, watch Clarity recordings, validate simulation predictions before Phase 2 fan-out
3. **customer-research** — mine Reddit/G2/forums for Sam's exact pain language to sharpen lesson hooks
4. **course-designer** — validate that the 5-module structure with 24-28 micro-lessons achieves the right learning objectives by Bloom's taxonomy

## Task-Awareness Quick Reference

| Task ID | Action | Skill to invoke |
|---|---|---|
| TASK-1 | Verify prerequisites (Hugo, validators, spec access) | (manual) |
| TASK-2 | M1.1 Founding Hypothesis → 2 micro-lessons | course-lesson-write → course-lesson-review-sam → course-lesson-validate |
| TASK-3 | M1.2b Smoke Test Run → 1 micro-lesson | course-lesson-write → course-lesson-review-sam → course-lesson-validate |
| TASK-4 | M1.3 Price Hypothesis → 1 micro-lesson | course-lesson-write → course-lesson-review-sam → course-lesson-validate |
| TASK-5 | M1 bridge chain + exit gate | (manual verification) |
| TASK-6..26 | M2-M5 migration (21 tasks) | course-lesson-write → course-lesson-review-sam → course-lesson-validate |
| TASK-27..34 | Phase 3 polish (8 tasks) | (cross-cutting audits) |

See `.agent/tasks.json` for full task index with spec file paths.

## Skill Import Status

| Skill | Location | Status |
|---|---|---|
| course-lesson-write | `.skills/` (local) | Created ✓ |
| course-lesson-review-sam | `.skills/` (local) | Created ✓ |
| course-lesson-validate | `.skills/` (local) | Created ✓ |
| course-svg-draft | `.skills/` (local) | Created ✓ |
| All others | `~/.agents/skills/` (global) | Already installed ✓ |
