# Spine-2 Audit and Chapter Mapping
**Project**: 2605-tech-for-non-technical-founders
**Phase**: 2 — Restructure audit
**Date**: 2026-05-15
**Branch**: module-8-first-paying-customer
**Truth source**: `data/course_sequence.yaml` (34 entries, 9 modules numbered 0-9)
**Target spine**: 8 modules (0-7) approved by user 2026-05-15

---

## Task A — Chapter Mapping Table

All 34 entries from `data/course_sequence.yaml` classified against the approved 8-module spine.

| Slug | Old module | NEW module (or disposition) | Action | Reframing notes |
|---|---|---|---|---|
| `course-map-self-assessment-non-technical-founder-2026` | Module 0 | Module 0 | **REFRAME** | Routing logic must map to 8 modules (0-7) instead of the old 10-module tree; the 12-Q self-assessment needs re-numbered routing table. |
| `form-your-founding-hypothesis-90-minute-sprint` | Module 1.1 | Module 1 | **KEEP** | Fits as-is; one-sentence falsifiable hypothesis with price is the module output. |
| `smoke-test-landing-page-300-dollar-validation` | Module 2.1 | Module 2 | **REFRAME** | Add price hypothesis section: the smoke-test page must carry a Stripe price button, not just a waitlist. Gate changes from "300 visits" to "≥5% click-to-payment-intent." |
| `find-10-people-with-problem-outreach-2026` | Module 3.1 | Module 3 | **KEEP** | Outreach method fits Module 3 entry; no structural change needed. |
| `mom-test-ask-about-past-not-future` | Module 3.2 | Module 3 | **KEEP** | Core interview methodology; fits as-is. |
| `validated-problem-statement-decide-whats-next` | Module 3.3 | Module 3 | **FOLD** | Content overlaps heavily with `mom-test-ask-about-past-not-future`; merge the "decide what's next" decision logic as a closing section of the Mom Test chapter so Module 3 ends with a single decision gate. |
| `market-type-existing-resegmented-new` | Module 3.4 | Appendix / OPEN QUESTION | **DEMOTE** | Too academic for greenfield-newbie ICP; surfaces as open question D-1 below. |
| `one-page-product-brief-vibe-prd` | Module 4.1 | Module 4 | **KEEP** | Direct output of Module 4; no change needed. |
| `stop-specifying-features-start-outcomes` | Module 4.2 | Module 4 | **KEEP** | Prevents over-engineering before build; fits Module 4 as the "what you won't build" discipline. |
| `should-you-hire-2026-decision-tree` | Module 5 | Module 5 | **REFRAME** | Currently a parallel-branch decision; reframe as a ceiling-signal-triggered decision — self-serve is the DEFAULT path; hire only if solo vibe-coding can't cover the Product Brief scope. |
| `github-aws-db-ownership-checklist` | Module 6.1 | Module 5 | **REFRAME** | Ownership audit is a Day-1 prerequisite for BOTH build paths, not mid-build oversight; move under Module 5 as the mandatory pre-build checklist before the founder picks a tool or signs a contract. |
| `engineering-org-chart-non-technical-founder` | Module 6.2 | Module 7 ref sidebar | **DEMOTE** | Premature-management content; relevant after retention is measured. |
| `friday-demo-rule-founder-progress` | Module 6.3 | Module 7 ref appendix | **DEMOTE** | Oversight rhythm is post-ship management; demote to Module 7 "if retention is solid and you need to scale" reference. |
| `three-questions-turn-standup-into-proof` | Module 6.4 | Module 7 ref appendix | **DEMOTE** | Same as above — oversight management, post-retention context. |
| `weekly-dev-report-template-founders` | Module 6.5 | Module 7 ref appendix | **DEMOTE** | Same as above. |
| `asked-simple-admin-panel-built-spaceship` | Module 6.6 | CUT | **CUT** | Rescue framing; no greenfield-friendly rehoming possible. |
| `self-serve-mvp-stack-lovable-supabase-stripe-2026` | Module 6A.1 | Module 5 | **REFRAME** | Currently positioned as "one of two build paths"; reframe as the DEFAULT path for all Module 5 entrants. Hire path becomes a conditional branch, not a parallel co-equal path. |
| `vibe-coding-ceiling-signals` | Module 6A.2 | Module 5 | **REFRAME** | Remove rescue framing; reframe as proactive ceiling-signal monitoring the founder runs monthly — five signals to watch so they know when self-serve has outgrown its envelope before a crisis. |
| `who-where-hire-developer-2026-ai-augmented-offshore` | Module 6B.1 | Module 7 ref sidebar | **DEMOTE** | Hire-a-team detail; relevant only after retention is proven and founder decides to scale. |
| `fractional-cto-bridge-5-hours-week` | Module 6B.2 | Module 7 ref sidebar | **DEMOTE** | Same hire-track context. |
| `hiring-interview-catches-ai-theater` | Module 6B.3 | Module 7 ref sidebar | **DEMOTE** | Same. |
| `cheap-developers-expensive-without-cto-review` | Module 6B.4 | CUT | **CUT** | Rescue framing; no greenfield rehoming. |
| `reading-sow-clause-by-clause` | Module 6B.5 | Module 7 ref sidebar | **DEMOTE** | Hire-track SOW detail; post-retention context. |
| *(missing slug — yaml parse gap)* | Module 7.1 | Module 6 | **KEEP** | "First customer is not marketing" — fits Module 6 entry; channel-selection chapter is the new add that leads it. |
| `first-ten-customers-personal-network` | Module 7.2 | Module 6 | **KEEP** | Network-first outreach fits Module 6 as-is. |
| `paid-pilot-charge-before-ship` | Module 7.3 | Module 6 | **KEEP** | Core Module 6 mechanic; charge before ship is the gate. |
| `outbound-without-sales-team` | Module 7.4 | Module 6 | **KEEP** | Post-channel-selection outbound; fits after new "channel selection" chapter. |
| `customers-leaving-churn-triage-not-acquisition` | Module 7.5 | Module 7 | **KEEP** | Directly maps to Module 7 retention gate (measure churn, resolve top exit reason). |
| `pivot-or-persevere-decision-framework` | Module 7.6 | Module 7 | **KEEP** | Post-retention decision; fits Module 7 as the "what if ≥60% / ≥80% isn't hit?" escalation. |
| `salvage-vs-rebuild-software-project` | Module 8.1 | CUT | **CUT** | Rescue framing; no greenfield rehoming. |
| `switch-dev-shops-safely-transition-guide` | Module 8.2 | CUT | **CUT** | Rescue framing; no greenfield rehoming. |
| `agency-uses-ai-follow-up-questions` | Module 9.1 | Appendix | **DEMOTE** | AI-era hygiene; post-ship reference appendix. |
| `ai-token-bill-dev-shop-pass-through-cost` | Module 9.2 | Appendix | **DEMOTE** | Same. |
| `slopsquatting-ai-supply-chain-attack` | Module 9.3 | Appendix | **DEMOTE** | Same. |

**Note on missing slug**: the yaml file has a parse gap at the Module 7.1 entry (title/mod keys present but slug key is absent). Verify raw file before Phase 3 begins.

---

## Task B — Briefs for the 4 New Chapters

### NEW: Price Your Hypothesis on the Smoke-Test Page
- **Slug proposal:** `price-hypothesis-smoke-test-stripe`
- **Module:** 2
- **Outcome:** Founder publishes a smoke-test landing page with a real Stripe price button (not a waitlist), collects click-to-payment-intent data, and has a go/iterate/kill threshold.
- **Signal/gate:** ≥5% of cold-traffic visitors click the Stripe payment-intent button within 72 hours of the page going live.
- **Required content:**
  - Why waitlists lie and a price button reveals real intent
  - How to pick a price point before you have a product (anchor to the closest existing alternative)
  - Step-by-step: Carrd/Framer page + Stripe payment link in under 2 hours
  - What to do when someone actually pays (refund script + follow-up call request)
  - Interpreting results: <1% = kill, 1-4% = iterate hypothesis, ≥5% = validated
  - Common error: price too high vs. copy unclear vs. audience wrong — how to tell which
- **AI-augmented method:** Use Claude / ChatGPT to generate 5 price-point framings from the one-sentence hypothesis, then A/B test top 2 as page variants.
- **Length:** 1,200-1,500 words
- **Templates/artifacts:** Smoke-Test Page Brief (copy template for headline, sub, CTA, price anchor, objection line) + Stripe Payment Link Setup Checklist

---

### NEW: AI Persona Pre-Validation
- **Slug proposal:** `ai-persona-pre-validation-before-mom-test`
- **Module:** 3
- **Outcome:** Founder runs a structured AI-persona session before booking real interviews, surfaces the 3 most likely objections, and enters Mom Test calls prepared to test - not discover - those objections.
- **Signal/gate:** Founder writes down 3 predicted objections before the first call; post-interviews they check which ones appeared verbatim.
- **Required content:**
  - Why interviewing AI before humans saves your first 3 interviews from fishing-expedition mistakes
  - The 5-prompt sequence: persona setup → job-to-be-done probe → objection surfacing → price sensitivity probe → status-quo defense
  - How to read AI output critically (AI agrees too easily; treat every "yes" as a hypothesis to stress-test)
  - Feeding AI insights back into your outreach copy and Mom Test script
  - What this does NOT replace: the 10 real human conversations are still mandatory
- **AI-augmented method:** Claude prompt sequence — system prompt sets persona as exact ICP description from the Product Brief; five structured interview turns; output is a list of predicted objections ranked by confidence.
- **Length:** 900-1,200 words
- **Templates/artifacts:** AI Pre-Validation Prompt Pack (5 copy-pasteable prompts + instructions for reading output) + Objection Tracker Worksheet

---

### NEW: Build a Clickable Prototype in an Afternoon
- **Slug proposal:** `clickable-prototype-lovable-afternoon-validation`
- **Module:** 3
- **Outcome:** Founder has a clickable prototype (not wireframes, not a deck) built in Lovable in under 4 hours and shows it to 5 of the 10 Mom Test interviewees to validate flow, not just problem.
- **Signal/gate:** ≥3 of 5 interview subjects can navigate the prototype's core flow without prompting AND articulate the problem the prototype solves unprompted.
- **Required content:**
  - The difference between a prototype and an MVP (prototype answers "can they use it?" not "does it work?")
  - What to build in Lovable in one afternoon: 3 screens maximum, the core user action only
  - How to run a prototype walkthrough (silent observation, note where they hesitate, ask "what did you expect?" not "was that clear?")
  - What a "pass" looks like vs. a "pivot the design" result
  - How prototype feedback shapes the Product Brief before Module 4
  - Common trap: over-building the prototype (perfectionism kills the learning signal)
- **AI-augmented method:** Paste the Product Brief into Lovable with the prompt "Build me a 3-screen prototype for [ICP] doing [job]"; use Lovable's AI to generate screens; founder navigates and edits, not codes.
- **Length:** 1,000-1,400 words
- **Templates/artifacts:** Prototype Session Script (observer checklist + 5 debrief questions + pass/fail scoring rubric) + Lovable Prompt Template

---

### NEW: Choose Your Channel Before You Send One Message
- **Slug proposal:** `channel-selection-first-paying-customer-2026`
- **Module:** 6
- **Outcome:** Founder picks ONE acquisition channel for the first paying customer based on where the 10 Mom Test interviewees already gather, commits to it for 4 weeks before evaluating a second.
- **Signal/gate:** Founder can name the channel, explain why (evidence from interviews), and has a 4-week outreach plan written down before sending any message.
- **Required content:**
  - Why channel-first prevents shotgun outreach and wasted time
  - The 5 greenfield-founder channels: personal network, niche communities (Reddit/Slack/Discord), cold email, content (post where ICP reads), paid (last resort)
  - How to read your interview notes for channel signal (where did they say they find tools? who do they trust for recommendations?)
  - The 4-week commitment rule: one channel, one message format, consistent daily action — no pivoting until week 4 data is in
  - How to define "working": a paying-customer conversion rate threshold per channel type
  - The channel-market fit trap: great product, wrong channel
- **AI-augmented method:** Feed the 10 interview transcripts to Claude with the prompt "Identify the 3 most common channels these people use to discover new tools. Quote the exact line from each transcript."
- **Length:** 1,000-1,300 words
- **Templates/artifacts:** Channel Selection Worksheet (5-channel scorecard with interview-evidence columns + 4-week outreach plan template)

---

## Task C — Reframing Notes for Chapters Needing Significant Editing

**`should-you-hire-2026-decision-tree`** — Currently frames self-serve and hire as two co-equal parallel paths the founder weighs from the start. Reframe as: self-serve (Lovable + Supabase + Stripe) is the DEFAULT; hire is a conditional branch triggered only when the ceiling-signal chapter (`vibe-coding-ceiling-signals`) produces a positive signal OR when the Product Brief scope is objectively beyond a solo AI-assisted build. The decision tree logic stays but the opening framing changes from "which path?" to "you're starting on the self-serve path — here's when to exit it."

**`self-serve-mvp-stack-lovable-supabase-stripe-2026`** — Currently positioned as one of two equal build paths ("6A" vs "6B"). Reframe as the default Module 5 chapter every reader enters first, regardless of their eventual build decision, because understanding the self-serve stack calibrates the hire-vs-build cost comparison. The "if you chose hire" fork becomes a sidebar at the end, not a co-equal opening.

**`vibe-coding-ceiling-signals`** — Currently framed with rescue language ("when your AI build breaks"). Remove rescue framing entirely; reframe as a monthly monitoring habit the founder runs starting at Week 2 of building, not a post-crisis diagnostic. The five signals become leading indicators to watch, not symptoms to recognize after the damage is done.

**`course-map-self-assessment-non-technical-founder-2026`** — Currently routes to the old 10-module structure (Modules 0-9 with 6A/6B branch). The routing table needs to be rebuilt for the 8-module spine (0-7) with the Module 5 self-serve/hire branch shown as a within-module decision, not a module split. The 12-Q self-assessment questions also need re-indexing to match the new module numbers.

**`tech-for-non-technical-founders-2026`** (landing page) — Full restructure required from the new 8-module spine; flag for a separate task. The current landing likely lists the old module order, the old chapter count, and possibly the old positioning sentence. Do not touch in Phase 3 until all chapter rewrites are staged.

---

## Task D — Open Questions for the User

**D-1. Does `market-type-existing-resegmented-new` survive?**
This chapter (Module 3.4 in old structure) teaches existing / re-segmented / new-market framing from Steve Blank. It is theoretical and has no artifact. For a greenfield-newbie ICP it is likely too academic and may increase drop-off between the Mom Test and the Product Brief.
*Recommendation: cut or demote to a reference appendix. Flag it as "advanced reading for founders who want to understand why their competitive positioning feels off."*

**D-2. Should `validated-problem-statement-decide-whats-next` fold into `mom-test-ask-about-past-not-future`?**
Both live in Module 3. The "decide what's next" chapter is essentially the debriefing and synthesis step after the Mom Test. Keeping them separate adds a chapter click with little standalone value; folding creates a cleaner Module 3 that has: (1) find 10 people, (2) run the interviews + synthesize the decision.
*Recommendation: fold — merge the synthesis and go/iterate/kill decision logic as a 400-word closing section of the Mom Test chapter.*

**D-3. Where does `five-tech-words-stop-nodding-at` live in the new 8-module structure?**
The yaml marks it as out-of-linear-reading-order (course glossary). The approved spine has no explicit glossary slot. It could sit as a floating reference page linked from the course nav, or it could anchor Module 4 (Product Brief) as "vocabulary you need before you write the brief."
*Recommendation: keep it as a standalone reference linked from the course-nav table in every post. No module assignment. Accessible from anywhere but not in the linear path.*

**D-4. Are the Module 7 ref sidebar chapters (hire track) usable as standalone blog posts or only as reference?**
`who-where-hire-developer-2026-ai-augmented-offshore`, `fractional-cto-bridge-5-hours-week`, `hiring-interview-catches-ai-theater`, `reading-sow-clause-by-clause` are demoted to a Module 7 reference sidebar per the approved cuts. The question is whether they remain fully-written chapter pages (with course nav) or are collapsed into a single "If You're Scaling: Hire Track" reference page.
*Recommendation: keep as individual pages (they have SEO value and may rank for hire-related queries); strip the course-nav table and replace with a single "This is supplementary material — return to Module 7 when you're ready to scale" callout.*

**D-5. Does `pivot-or-persevere-decision-framework` belong in Module 7 or should it anchor a Module 8?**
The approved spine ends at Module 7 (Retain Before You Scale). The pivot-or-persevere framework is currently Module 7.6 but logically it triggers when retention targets are NOT met — making it a post-Module-7 decision. If the course is meant to end at Module 7, it fits as the Module 7 closing chapter. If the user wants a Module 8 for "what if nothing works," this is its anchor.
*Recommendation: keep in Module 7 as the closing chapter — "if you hit ≥60%/≥80% retention, you graduate; if not, here's the pivot-or-persevere gate." No Module 8 needed; keeps the spine clean at 8 modules.*

---

## Surprises / Anomalies Found

**Slug gap in yaml**: The yaml entry at Module 7.1 position is missing its `slug:` key entirely (title and mod are present). The chapter "Your First Customer Is Not Marketing" exists as a chapter in the strategy docs but cannot be served by Hugo without a slug. Requires a fix before Phase 3 build.

**`github-aws-db-ownership-checklist` is misclassified**: In the old structure it was Module 6.1 (mid-build oversight). The approved cuts demote `engineering-org-chart`, `friday-demo-rule`, `three-questions`, and `weekly-dev-report` to appendix — but ownership is fundamentally different (it's a Day-1 setup task, not management). This chapter should NOT be demoted to the same appendix as the management posts; it belongs in Module 5 as a mandatory pre-build gate. If it lands in the management appendix by accident, greenfield founders will never read it.

**Module 6A/6B split creates navigation confusion**: The old YAML has `6A.1`, `6A.2`, `6B.1`…`6B.5` as sibling entries in a flat list. In the new 8-module spine, these become either Module 5 chapters or Module 7 sidebar entries. The YAML will need renumbering (Phase 3 task) — but note that the branching logic currently visible to the reader in the course-nav table will disappear, which may disorient readers who arrived from Google on a 6A or 6B URL. Redirects needed.

**`customers-leaving-churn-triage-not-acquisition`** is currently Module 7.5 (old), which was the "First Paying Customer" module. In the new spine it maps cleanly to Module 7 (Retain Before You Scale) — but its title still implies the founder already has customers leaving, which presupposes a flow problem that new Module 7 readers haven't yet experienced. The title may need softening for greenfield ICP before it goes live.
