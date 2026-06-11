# ICP-E (Alex) Course Walkthrough — Companion to ICP-Sam Walkthrough

**Created**: 2026-05-29
**Last updated**: 2026-05-29
**Project**: 2605-tech-for-non-technical-founders
**Method**: AI persona simulation — agent assigned the ICP-E profile (from `90.10-icp-primary-website-target.md`) walked the full 5-module course sequentially, recording assessments after each module.
**Evaluator**: ICP-E persona agent ("Alex")
**Companion to**: [`10.07-icp-sam-persona-course-walkthrough.md`](10.07-icp-sam-persona-course-walkthrough.md) — the parallel ICP-Sam (idea-stage non-technical first-timer) walk

> **Scope note**: This walkthrough evaluates the course through Alex's lens (the post-team-fail burned founder with a built product, dev shop relationship, and infrastructure to audit). The course was redesigned 2026-05-12 to be **Sam-first** (idea-stage non-technical first-timer); Alex is the secondary audience served by conditional side-paths. Read this file alongside the Sam walk — both are correct relative to their ICP; both miss the OTHER ICP's experience. The Sam walk surfaces 5 BLOCKING gaps Alex's perspective cannot see (because Alex already has the team / product / users Sam doesn't).

---

## 1. Persona: Alex

- 38, BBA/MBA, founder & CEO of a B2B SaaS at 8 employees
- $500K raised, 14 months of runway
- 6 months into a dev-shop engagement that delivered 4 weeks late with half the features
- Cannot read code, cannot evaluate the GitHub commit log, cannot tell if the agency is productive or stalling
- Tech literacy: can use Stripe, Notion, Google Sheets, and send a Loom — cannot read a PR, set up a DB, or deploy

**Key ICP-E traits active during evaluation**: distrust of technical authority, need for plain-English explanations, preference for concrete scripts over abstract frameworks, fear of being sold to, limited time for learning (fits between founder duties).

> **Note on chapter ordering**: This walkthrough presents chapters in the order Alex encountered them during the simulation (prioritizing the burned-founder experience). The actual shipped chapter sequence may differ. See `../20-29-strategy/20.01-course-modules.md` or `../../data/course_sequence.yaml` for canonical ordering.

---

## 2. Module-by-Module Walkthrough

### Module 1 — Hypothesis & Smoke Test (estimated 2 hr)

**Alex's experience:**

Alex opens Chapter 1.1 at 9 AM Monday. The three-sentence hypothesis template asks her to write *customer / business / solution* in plain English — no jargon, no features. She fills in:

> *Customer: A 12-person law-firm office manager on Friday afternoon trying to invoice 10 clients before QuickBooks logs her out.*
> *Business: B2B SaaS, self-serve, $29/month, annual billing.*
> *Solution: A one-click invoice export to Stripe that saves 90 minutes every Friday.*

She moves to Chapter 1.2. The smoke-test landing page builder walks her through a headline, a subheadline, a Stripe price button, and a 7-day wait. No code required — the tools named are Carrd + Stripe. She builds it in 90 minutes. Chapter 1.3 adds the price button: she sets it at $29/month and watches the email-capture rate.

**ICP verdict — Practicality**: ✓ High. The three-sentence structure removes the blank-page paralysis. Every tool is named with a free tier. The 7-day wait is concrete. Alex says: *"I can do this before lunch without asking anyone for help."*

**ICP verdict — Engagement**: ✓ High. The chapter opens with a real founder story (dev-shop disaster → landing page test), which mirrors Alex's own situation. The tone is direct — no buzzwords, no "harness the power." She feels spoken *to*, not lectured *at*.

**ICP verdict — Goal achievability**: ✓ Yes. After 2 hours she has a live landing page with a Stripe button and email capture. The output is real and investor-showable.

**Modernity / Validation**: ✓ The 2026-specific stack (Carrd + Stripe Checkout, not WordPress + PayPal) and the "write three sentences before building" pattern are modern. References to YC Startup School and the Mom Test ground it in validated methodology.

---

### Module 2 — Validate the Problem (estimated 3 hr)

**Alex's experience:**

Chapter 2.1 introduces the Mom Test. Alex reads the core rule: *ask about the past, not the future.* She drafts 8 questions. Chapter 2.2 asks her to paste those questions into Claude with an ICP persona prompt. She runs the 5-prompt rehearsal sequence for 30 minutes. Claude flags her Q2 ("Would you use a tool like this?") as hypothetical → generates polite yes. She rewrites it: "Walk me through the last time you had to invoice clients on a Friday afternoon."

Chapter 2.3 is the outreach playbook — the longest chapter. Alex learns to find people on Reddit/Discord/G2 who are already complaining about the problem. The 6-a-day cold-message cadence is concrete. She spends 2 hours reading Reddit threads and builds a spreadsheet of 30 named people.

Chapter 2.4 wraps with the clickable prototype in Lovable. Alex builds a 3-screen clickable prototype in 2 hours. She shows it to 5 interview subjects. One says "I expected this button to go to a different screen." She catches a UX failure she would have shipped to production.

**ICP verdict — Practicality**: ✓ High-medium. The Mom Test rehearsal using Claude is the most practical 2026-specific innovation. Alex says: *"I would never have caught that 'would you use this' question on my own, and I would have wasted 8 interview slots on polite yeses."*

**ICP verdict — Engagement**: ✓ High. The chapter structure (interview → rehearse → find people → run prototype) mirrors a real validation sprint. Alex stays engaged because each chapter has a tangible deliverable that feeds the next.

**ICP verdict — Goal achievability**: ✓ Yes, conditionally. Alex can complete all 4 chapters in a week if she dedicates 45 min/day. The risk is the outreach chapter (2.3) — it's the longest and most labor-intensive, and she might stall there. The 6-a-day rule is the right countermeasure.

**Modernity / Validation**: ✓ The AI persona rehearsal (Claude/ChatGPT acting as the ICP) is not taught by any competing course. The Mom Test (Fitzpatrick) is the gold standard for customer discovery interviews. The Lovable prototype is 2026-native. The outreach playbook references Apollo, Clay, Gmail multi-send, NeetoCal — modern tooling.

---

### Module 3 — Product Brief (canonical landing page says 1 hr)

**Alex's experience:**

Chapter 3.1 introduces the Vibe PRD: a one-page outcome-shaped Product Brief. Alex fills in 6 sections: persona, problem, current behavior, solution (outcomes, not features), what we won't build, how we'll know it worked. She completes it in 60 minutes.

Chapter 3.2 is the critical framing shift: *stop specifying features, start specifying outcomes.* Alex reads the job-story format: "When [situation], I want to [motivation], so I can [expected outcome]." She rewrites her feature list ("invoices page with export button") as a job story ("When it's 4pm Friday and 10 clients haven't been invoiced yet, I want to get their invoices approved and sent in one pass, so I can leave at 5pm like I promised my family"). The outcome shift is real.

**ICP verdict — Practicality**: ✓ High. The Vibe PRD template is the killer artifact. Alex says: *"I have something I can hand to a developer and say 'build this,' and they won't come back with 12 clarifying questions."*

**ICP verdict — Engagement**: ✓ Medium-high. Chapter 3.2 is the most intellectually demanding chapter in the course. Alex has to unlearn the feature-specification habit. The job-story format is a new muscle. Engagement is high because the payoff is clear (fewer costly misunderstandings), but the learning curve is steeper than earlier modules.

**ICP verdict — Goal achievability**: ✓ Yes. A one-page PRD is achievable in a single focused session. The template reduces cognitive load.

**Modernity / Validation**: ✓ The Vibe PRD concept is from the 2026 vibe-coding ecosystem (Drew Falkman). Job Stories are from JTBD (Christensen, Kalbach), which are widely cited in product management. The "outcomes not features" principle aligns with YC's "talk to users, build what they need" ethos.

---

### Module 4 — Choose Your Build (estimated 3 hr)

**Alex's experience:**

Chapter 4.1 presents the build decision tree: self-serve or hire. The decision tree includes the Airbnb test, the "shed not skyscraper" warning (Rob Walling), and a budget-range tool comparison. The self-serve path uses Lovable + Supabase + Stripe (~$50/month total). The hire path uses the AI-Augmented Developer profile (~$85-120K annual).

Chapter 4.2 is the Ownership Audit checklist: who owns your GitHub org, AWS root account, domain registrar, and database? Alex runs the checklist and discovers her dev shop owns the GitHub org and AWS root. She requests transfer immediately.

Chapters 4.3-4.4 walk through the self-serve stack with a staging URL build. Alex writes the appointment booking flow using AI coding tools.

**ICP verdict — Practicality**: ✓ High. The ownership audit (Chapter 4.2) is the most immediately useful chapter in the entire course for Alex. She was 6 months into a dev-shop relationship without knowing the root account was under their email. *"This chapter alone saved me from being held hostage when I eventually switch shops."*

**ICP verdict — Engagement**: ✓ High. The stakes are personal for Alex. The ownership audit is a gut-check moment. The self-serve walkthrough is motivating because she can see a path to shipping without the agency.

**ICP verdict — Goal achievability**: ✓ Yes. The decision tree is structured as 4 yes/no questions. The ownership audit is 12 line items. The self-serve walkthrough is a step-by-step build. Each chapter produces a concrete artifact.

**Modernity / Validation**: ✓ The Lovable + Supabase + Stripe stack is 2026-specific. The ownership audit pattern is drawn from real rescue cases. The AI-Augmented Developer profile ($85-120K) is from 2026 research. The Rob Walling "shed not skyscraper" warning anchors it in known startup thinking.

---

### Module 5 — First Paying Customer (canonical landing page says 1 hr; realistic 3-4 weeks elapsed)

> **Correction 2026-05-29**: the original draft of this section had the Module 5 chapter mapping wrong. Canonical mapping per `data/course_sequence.yaml`:
> - **Ch 5.1** — Your First Customer Is Not Marketing: The Sean Ellis 40% Test
> - **Ch 5.2** — Choose Your Channel Before You Send One Message
> - **Ch 5.3** — The First Ten From Your Network
> - **Ch 5.4** — Charge Before You Ship: The Paid Pilot Contract
> - **Ch 5.5** — Going Outbound Without a Sales Team
>
> The rewritten Alex walk below uses the correct chapter assignments.

**Alex's experience (corrected):**

Chapter 5.1 introduces the Sean Ellis 40% PMF test. Alex needs 10-30 users on the MVP to run the survey; she already has 47 paying customers from her dev-shop build, so she runs the survey immediately and finds 38% "very disappointed" — just under the 40% threshold.

Chapter 5.2 is channel selection — pick ONE channel and commit for 4 weeks. Alex's interview transcripts (from her own past research) suggest outbound to vertical CFO communities.

Chapter 5.3 is the first-ten-from-personal-network playbook — Alex builds a 50-name list in 4 buckets (champions, peers, advisors, weak ties) and sends 15 personalized DMs by Friday.

Chapter 5.4 is the paid pilot close: Alex sets a $500 pilot price, writes a Design Partner Agreement, and signs her first NEW paying customer (independent of her dev-shop legacy customers) via Stripe deposit.

Chapter 5.5 is the cold-outbound playbook for when the network is exhausted — Alex saves it for next month.

**ICP verdict — Practicality**: ✓ High. The paid pilot template (scope, price, duration, graduation terms) is the most valuable artifact in Module 5. Alex says: *"I now have a signed paid pilot — real money, not another 'we'll pay when you're done' commitment. This changes everything for investor conversations."*

**ICP verdict — Engagement**: ✓ High. The momentum from the staging URL build carries through. The milestone of a $500 Stripe deposit is the first real revenue — a concrete achievement after modules of research and planning.

**ICP verdict — Goal achievability**: ✓ Yes, with caveat. The initial paid pilot at $500 is achievable for most ICP-E founders with a validated product. The scaling path (Chapter 5.4 for B2B, Chapter 5.5 for customer acquisition) is optional.

**Modernity / Validation**: ✓ The channel selection framework is from Justin McGill / modern B2B go-to-market playbooks. The 3-message outbound sequence follows the cold-email conversion playbook (YC Startup School style). The paid pilot structure ($500 deposit, 6-week, go/no-go gate) is modeled on real best-practice agency pilot structures.

---

## 3. Overall Course Evaluation

| Dimension | Score (1-10) | Notes |
|-----------|-------------|-------|
| **Practicality** | 10 | Every chapter produces a concrete deliverable. No theory without output. Tools are named with free tiers. |
| **Engagement** | 9 | Founder stories mirror the ICP's reality. Tone is direct without being cold. Momentum builds across modules. |
| **Goal achievability** | 9 | Linear path from idea to paying customer is clearly mapped. Realistic timeline is **12-22 weeks elapsed (40-60 focused hours)**; the often-misquoted "4 weeks" is the BUILD portion of M4.3 only. |
| **Modernity / Validation** | 9 | Stack is 2026-native. Methodology is grounded in proven frameworks (Mom Test, JTBD, YC). AI-persona rehearsal is a genuine innovation. |

**Overall: 9.25/10**

### What the course does exceptionally well

1. **Every chapter has a concrete output** — landing page, interview transcript, prototype, PRD, staging URL, paid pilot. No chapter ends with "reflect on what you learned."
2. **Tools are named with free tiers and 2026 relevance** — Carrd, Stripe, Lovable, Supabase, Apollo, NeetoCal, Claude. No imagined tools, no affiliate-driven picks.
3. **The AI-persona rehearsal (Module 2) is a genuine innovation** — no competing course teaches founders to validate their question script against an AI persona before running real interviews.
4. **The ownership audit (Module 4) is the most immediately useful chapter for the burned-founder ICP** — it surfaces a hostage situation the founder didn't know existed.
5. **The linear sequence is forced-choice and opinionated** — no "pick your own adventure" confusion. The reader knows exactly what to do next.

### Gaps and suggestions

| Gap | Severity | Suggestion |
|-----|----------|------------|
| Module 2 (outreach) is disproportionately long | Medium | Split into 2 chapters: "Find 10 People" and "Book the Calls." The current single-chapter density risks reader dropout. |
| Module 5 (first paying customer) is lighter than earlier modules | Medium | Add a "Preparing for the Pilot Kickoff" chapter: how to set expectations, define success criteria, and run the first 2 weeks. |
| No "what if I get stuck" per-module section | Medium | Add a "Blocked?" sidebar per module with the most common reason readers stall and the unblocking action. |
| Glossary chapter references technical terms not all chapters define inline | Low | Add inline definitions for the 3-4 most technical terms per chapter rather than relying on the glossary. |
| No completion estimate per chapter | Low | Add "Time: ~45 min" badge at the top of each chapter so the reader can plan their session. |

### What Alex (ICP) would say after completing

> *"I went in thinking I needed to learn to code or hire someone who can. I came out with a paying customer and a checklist I can re-run for the next product. The course didn't try to make me technical — it gave me a system for being a non-technical founder effectively."*

---

## 4. Verification Against Project Requirements

### Does the course teach practical, implementable skills? ✓

Every chapter names specific tools (Carrd, Stripe, Claude, Lovable, Supabase, NeetoCal, Apollo, Gmail multi-send) with free tiers or low entry costs. Every chapter has a concrete output the reader produces. The course passes the "could a reader complete this in a single focused session?" test.

### Does the course engage the ICP? ✓

The opening-founders-vignette pattern (used in modules 1-3) mirrors Alex's own experience of being burned by a dev shop. The direct, plain-English tone avoids both cheerleading and lecturing. The "skip if you're too busy" callout on longer chapters respects the reader's time.

### Can the reader reach the stated goal by following instructions? ✓

The linear module structure forces the reader through hypothesis → validation → brief → build → pilot. Each module's output is the next module's input. A reader who completes all 18 chapters in sequence will have: a validated hypothesis, a live smoke-test landing page, 10+ interview transcripts, a clickable prototype shown to 5 subjects, a one-page outcome-shaped PRD, a build decision, a live staging URL, and one signed paid pilot. This matches the course promise: "From idea to first paying customer."

### Are the instructions modern and validated by market professionals? ✓

The course references or builds on:

| Source | What it validates |
|--------|------------------|
| Y Combinator Startup School methodology | Hypothesis validation, talk-to-users ethos |
| Rob Fitzpatrick, *The Mom Test* | Customer interview technique (ask about past, not future) |
| Rob Walling (Drip, TinySeed, MicroConf) | "Shed not skyscraper" build philosophy |
| Jim Kalbach / JTBD canon | Job Stories for outcome specification |
| Drew Falkman, Vibe PRD | One-page product brief for AI-era building |
| Justin McGill / B2B outbound playbooks | Channel selection and cold-outreach sequences |
| Sean Ellis PMF test | Must-have / nice-to-have survey methodology |
| Sophia Matveeva, *Tech for Non-Technical Founders* | Validation-first curriculum design |
| Christensen / JTBD (Jobs to Be Done) | Outcome specification over feature specification |
| Click (Knapp/Zeratsky), Foundation Sprint | Lightweight experiment before heavy design sprint |

---

## 5. Module Scoring Matrix

| # | Module | Practicality | Engagement | Achievability | Modernity | Overall |
|---|--------|-------------|-----------|---------------|----------|---------|
| 1 | Hypothesis & Smoke Test | 10 | 9 | 10 | 9 | 9.5 |
| 2 | Validate the Problem | 9 | 9 | 8 | 10 | 9.0 |
| 3 | Product Brief | 10 | 8 | 10 | 9 | 9.25 |
| 4 | Choose Your Build | 10 | 9 | 9 | 10 | 9.5 |
| 5 | First Paying Customer | 9 | 9 | 8 | 8 | 8.5 |

---

## 6. Key Findings

1. **Strongest chapters**: Ownership Audit (4.2), Mom Test Rehearsal with AI (2.2), Smoke Test Landing Page (1.2). These produce immediate, high-value outputs that teach the reader something they didn't know they were missing.

2. **Weakest chapter**: Charge Before You Ship (5.4 — the paid pilot close chapter, originally mis-attributed as 5.3 in the first draft of this walk). The $500 pilot price point is validated but the chapter could be more specific about the kickoff conversation script, the go/no-go decision criteria, and handling objections.

3. **Most underutilized asset**: The AI-persona rehearsal in Module 2. This is a genuine 2026 innovation no competitor teaches. It deserves a standalone section in the course landing page to attract the mom-test-curious audience.

4. **Risk of reader dropout**: The sequence from Module 2.3 (outreach) to Module 2.4 (prototype) has the highest dropout risk because it requires the most active work (building the list, running interviews, building the prototype) without an intermediate checkpoint. Consider adding a "halfway checkpoint" after Module 2.2.

5. **Burned-founder fast path works**: Alex would route through the fast path (Module 4.2 Ownership Audit first, then Module 5 oversight chapters, then backfill Modules 1-3 only if rebuilding from scratch). The landing-page router correctly handles this case, but the per-chapter routing blocks were correctly removed to avoid distracting the primary reader.

---

## 7. What Alex's perspective misses — read the Sam walk

The 9.25/10 verdict above is Alex-specific. The course's primary ICP is Sam (idea-stage), and the Sam walk (see [`10.07-icp-sam-persona-course-walkthrough.md`](10.07-icp-sam-persona-course-walkthrough.md)) surfaced 5 BLOCKING gaps that Alex's perspective could not see:

| Gap (visible to Sam, invisible to Alex) | Why Alex can't see it | Status after 2026-05-29 fix sprint |
|-----------------------------------------|-----------------------|--------|
| **M4.3 → M5.1 invisible bridge** — no instructions for getting first 10-30 users onto MVP | Alex already has 47 paying customers from her dev-shop build | FIXED — Week-5 Module 5 onramp section added to M4.3 |
| **M4.2 Ownership Audit reads as wrong-stage** for self-serve Sam | Alex (post-team-hire) finds it the most valuable chapter | FIXED — top-of-chapter skip-out for Path 2 self-serve readers |
| **M4.4 Ceiling Signals has no Monday action** for pre-launch Sam | Alex already has a live product to monitor | FIXED — reframed as monthly-review reference with "set calendar block today" as the one concrete action |
| **M4.1 Q1 pre-order requirement** routes Sam back to Path 1 unnecessarily | Alex has paying customers and skips Q1 entirely | FIXED — sub-callout: "Already completed Modules 1-3? Answer Yes" |
| **Stripe lead-time** buried at L77 of M1.3 gotcha list | Alex already has Stripe set up from her dev-shop build | FIXED — top-of-chapter warning surfaces 1-3 day verification time |

The Alex walk's 9.25/10 was correct **for Alex**; the Sam walk's "GOAL REACHABLE WITH GAPS" was correct **for Sam**. The 2026-05-29 fix sprint closed Sam's gaps, raising the Sam-walk verdict to "MOSTLY REACHABLE." This file (Alex's walk) is preserved as the secondary-ICP record; the Sam walk is the primary-ICP record per the 2026-05-12 course redesign.
