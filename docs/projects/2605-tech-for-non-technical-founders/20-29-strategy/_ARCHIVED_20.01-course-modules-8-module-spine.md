# Course Modules - Tech for Non-Technical Founders 2026

**Project**: 2605-tech-for-non-technical-founders
**Last updated**: 2026-05-12 (replaces previous `20.01-content-pillars.md`; pillars structure rejected by user, modules structure adopted)

This document defines the **8-module course architecture**. Each module has:

- **Input**: what the reader brings from the previous module
- **Output**: the deliverable they walk away with
- **Checkpoint**: how they know they can move on
- **Artifact**: the template/worksheet they fill in
- **Posts**: the individual chapters within the module

The course is a **journey, not a topic list.** A reader who completes the course holds a **Founder OS**: a stack of filled artifacts that document their validated problem, Product Brief, build decision, live MVP, oversight rhythm, contingency plan, and AI interrogation kit.

**Simplest-path doctrine** (memory ref: `feedback_kiss_simplest_solutions_only.md`): main path teaches the simplest method that already works for a solo non-tech founder. Structured frameworks (Foundation Sprint, JTBD Canvas, Shape Up, Continuous Discovery, Impact Mapping, User Story Mapping, Lean Inception, Empathy Mapping, Design Sprint) are demoted to optional "Advanced" sidebars at the bottom of Modules 1, 2, and 5.

---

## Module 0 - Where Are You?

- **Input**: An idea, an instinct, or an ongoing project that feels stuck.
- **Output**: A self-diagnosis: which module to start with.
- **Checkpoint**: You know your starting module and can name the next deliverable you'll produce.
- **Artifact**: Self-Assessment Worksheet (10 questions; outputs your entry module).
- **Posts**: `0.1 Course Map + Self-Assessment` (net-new).

### The 10 self-assessment questions + routing logic

| # | Question | Answer routes to |
|---|---|---|
| 1 | Have you talked to 10+ potential customers about the problem you want to solve? | No → Module 1. Yes → Q2. |
| 2 | Do you have a one-page written Product Brief (what you're building, for whom, why now)? | No → Module 2. Yes → Q3. |
| 3 | Have you decided whether to ship self-serve or hire a team? | No → Module 3. Yes → Q4. |
| 4 | Are you actively shipping software (you have a staging URL real users can click, OR a signed contract with a team)? | No → Module 4A (self-serve) or 4B (hire) based on Q3. Yes → Q5. |
| 5 | Do you own the GitHub org, AWS root account, domain registrar, and database under your company email? | No → Module 5 (start with 5.5 Ownership Audit). Yes → Q6. |
| 6 | Are you running a weekly oversight rhythm (Friday demo + standup with the 3 questions + plain-English weekly report)? | No → Module 5. Yes → Q7. |
| 7 | In the last 30 days, has your team had a milestone slip, a runaway invoice, or a quality issue you can't diagnose? | Yes → Module 6. No → Q8. |
| 8 | Does your product or team touch AI (Cursor, ChatGPT, vibe coding, AI agents, LLM calls in production)? | Yes → Module 7. No → Q9. |
| 9 | Do you understand the AI token costs your team is passing through to your invoice? | No → Module 7.2. Yes → Q10. |
| 10 | Have you ever asked your team to walk you through a real PR they reviewed last week? | No → Module 5.3. Yes → graduate; the curriculum is your reference library now. |

**Routing summary**: most readers route to Module 1, 2, 3, 4A, or 4B at Q1-Q4. Burned founders skip ahead to Q5-Q7 and land in Module 5 or 6. AI-exposed founders branch to Module 7 at Q8.

The artifact prints these 10 questions with checkboxes and a routing flowchart. Reader fills it in 5 minutes, writes their starting module at the top of a Notion doc, and works forward from there.

---

## Module 1 - Validate the Problem

*Idea → Validated Problem*

- **Input**: A hunch.
- **Output**: A one-page validated problem statement backed by 10+ real conversations.
- **Checkpoint**: 10 customer interviews complete · one-page problem statement signed by 2 peers/advisors.
- **Artifact**: Module 1 Toolkit (Outreach Sequence Template + Mom Test Interview Script + Validated Problem Statement Template).
- **Posts**:
  - `1.1 Find 10 People with the Problem in 2026` (net-new) - outreach: Reddit / LinkedIn / Discord mining + Clay or Apollo for list building + Lindy AI agent for sequence + paid panels (User Interviews, Respondent) as backup + smoke-test landing page on Carrd/Framer with £100-200 of paid traffic.
  - `1.2 The Mom Test - Ask About the Past, Not the Future` (net-new) - Rob Fitzpatrick's 5-question script; how to avoid leading questions; what emotional language to listen for.
  - `1.3 Write Down What You Heard, Decide What's Next` (net-new) - one-page validated problem statement template; the "3 pre-orders = green light" rule.
- **Advanced sidebar** (optional, for teams): Empathy Mapping (Dave Gray), JTBD Canvas 2 (Jim Kalbach, 2023), Customer Journey, Continuous Discovery (Teresa Torres) + Opportunity Solution Tree.

---

## Module 2 - Design the Solution

*Validated Problem → Product Brief*

- **Input**: Validated problem from Module 1.
- **Output**: A one-page Product Brief (Vibe PRD) describing what you're building, for whom, why now.
- **Checkpoint**: One-page Brief signed by 2 advisors/peers.
- **Artifact**: Vibe PRD Template (Product Brief).
- **Posts**:
  - `2.1 Five Tech Words to Stop Nodding At` (drafted) - vocabulary you need to read the answers you'll get back.
  - `2.2 The One-Page Product Brief (Vibe PRD)` (net-new) - the simplest format: who, what problem, what they currently do, what you'll build, what you won't build, how you'll know it worked.
  - `2.3 Stop Specifying Features. Start Specifying Outcomes.` (net-new) - one technique that prevents over-engineering. Teaches the job-story format inside as a tactic, not as a framework name. References post 5.6 "Simple Admin Panel → Spaceship" as the cautionary tale. Renamed 2026-05-12 to remove framework leak per `feedback_kiss_simplest_solutions_only.md`.
- **Advanced sidebar** (optional, for teams): Impact Mapping (Gojko Adzic), Foundation Sprint (Knapp/Zeratsky, *Click* April 2025), Design Sprint (Knapp 2016), Lean Inception (Paulo Caroli), User Story Mapping (Jeff Patton).

---

## Module 3 - Choose Your Build Path

*Product Brief → Build Decision*

- **Input**: Product Brief from Module 2.
- **Output**: A decision (self-serve OR hire) + a budget for the chosen path.
- **Checkpoint**: You've decided. Module 4A or Module 4B from here.
- **Artifact**: Build Path Decision Worksheet.
- **Posts**:
  - `3.1 Should You Hire? The 2026 Decision Tree` (net-new) - the Airbnb test (validate without code); Rob Walling's "shed not skyscraper" warning; when DIY is enough.
  - `3.2 The Fractional CTO Bridge - 5 Hours a Week Beats a Co-founder` (net-new) - the $0-equity alternative to a 50%-equity technical cofounder. **Positioned generically (any Fractional CTO), NOT as a JT offer.** Per pure-lead-magnet doctrine (`feedback_curriculum_is_pure_lead_magnet.md`).

---

## Module 4A - Ship Self-Serve *(branch)*

*Build Decision → Live MVP (self-serve)*

- **Input**: Product Brief + decision to ship self-serve.
- **Output**: Live MVP at a staging URL real users can click.
- **Checkpoint**: MVP live · first 5 users testing · 2026 stack working end-to-end.
- **Artifact**: Self-Serve Stack Walkthrough PDF.
- **Posts**:
  - `4A.1 The Self-Serve Stack: Lovable + Supabase + Stripe` (net-new) - what each tool does in plain English, how they connect, what a real founder shipped on this stack. Communities (Lovable Discord, Indie Hackers, No Code Founders) referenced inline.
  - `4A.2 Vibe Coding Done Right - The 5 Ceiling Signals` (net-new) - when AI builds hit the architectural ceiling. Trigger to route to Module 4B (hire to expand).

---

## Module 4B - Hire & Ship *(branch)*

*Build Decision → Live MVP (hired team)*

- **Input**: Product Brief + decision to hire OR Module 4A ceiling hit.
- **Output**: Live MVP shipped by a hired team + signed contract that protects you + code in YOUR GitHub org.
- **Checkpoint**: Contract signed · kickoff scheduled · GitHub org under your email.
- **Artifact**: Hiring Kit (Where-to-Hire Map + Hiring Interview Script + SOW Reading Guide).
- **Posts**:
  - `4B.1 Who You're Hiring in 2026 and Where to Find Them` (net-new) - the AI-Augmented Developer profile ($85-120K Junior with Senior productivity); onshore vs nearshore vs Tier-2 offshore ($15-70/hr Indian cities, LATAM nearshore, US onshore reality).
  - `4B.2 The Hiring Interview That Catches AI Theater` (net-new) - 7 questions extending the existing "We Use AI" lead magnet; how to verify the engineer can direct AI rather than type prompts.
  - `4B.3 When Cheap Developers Get Expensive` (wrap: 2510 NEW-L) - the student-developer 20-hour-week trap, the freelancer 5-project trap.
  - `4B.4 Reading the SOW Clause by Clause` (drafted) - 8 clauses agencies hope you skim.

---

## Module 5 - Manage Your Build

*Hired Team → Working Software*

- **Input**: A team in place + a signed SOW.
- **Output**: A weekly oversight rhythm running. By month 3 you can tell whether your team is shipping or stalling without reading code.
- **Checkpoint**: Friday demos running 4 weeks · ownership audit clean · weekly report arriving Mondays.
- **Artifacts**: Founder Oversight Toolkit (Friday Demo Template + Ownership Checklist + Weekly Report Template + Org Chart Audit Template).
- **Posts**:
  - `5.1 The Org Chart Your Dev Shop Won't Draw For You` (drafted) - 6 questions that surface who's actually on your project.
  - `5.2 The Friday Demo Rule` (wrap: 2510 NEW-J) - the 15-minute weekly ritual that catches fake progress.
  - `5.3 Three Questions That Turn Standup Into Proof` (drafted) - daily catch-fake-progress script.
  - `5.4 The Plain-English Weekly Dev Report` (wrap: 2510 NEW-A) - what a real weekly report looks like.
  - `5.5 Who Owns Your GitHub, AWS, and Database?` (wrap: 2510 NEW-K) - the 12-item ownership audit.
  - `5.6 You Asked for a Simple Admin Panel; You Got a Spaceship` (wrap: 2510 NEW-I) - Job Stories vs over-engineering; references back to post 2.3.
- **Verification-layer requirement** (added 2026-05-12 per Alex/ICP-E review): posts 5.2, 5.3, 5.4 must include a "what you cross-check the team's answer against" sidebar. Alex's old shop ran perfectly-formatted standups for 7 months while lying - format was real, content was theater. Posts must teach not just the question but the verification: `git log` for actual commits, AWS billing dashboard for real cost, staging URL clicks by the founder during the call. "Ask the question + verify the answer," not just "ask the question."
- **Advanced sidebar** (optional, for teams upgrading process): Shape Up (Basecamp - 6-week cycles + appetite + pitches), Continuous Discovery during build (Teresa Torres - weekly interviews continue), User Story Mapping for release planning (Jeff Patton).

---

## Module 6 - When Things Break

*Failed Build → Recovery Decision*

- **Input**: A failed Friday demo · a dropped milestone · a runaway invoice.
- **Output**: A documented decision (salvage / freeze / rebuild) + a 30/60/90 day plan.
- **Checkpoint**: Decision documented · recovery plan in flight · independent reviewer signed off.
- **Artifact**: Salvage vs Rebuild Decision Tree (already drafted).
- **Posts**:
  - `6.1 Salvage or Rebuild: A 6-Question Decision Tree` (wrap: 2510 NEW-M) - the 30-minute structured decision.
  - `6.2 How to Switch Dev Shops Without Losing the Codebase` (wrap: 2510 NEW-C) - the 30-day transition playbook + the "investor legend" trick.

---

## Module 7 - Manage AI-Era Risks

*Running Product → Interrogation System*

- **Input**: A product or team touching AI (most do in 2026).
- **Output**: A system for interrogating any AI claim, predicting AI costs, and catching supply-chain attacks.
- **Checkpoint**: You can interrogate any AI claim in 5 minutes · monthly AI cost predicted within ±20% · supply-chain defense agreed in contract.
- **Artifacts**: AI 5-Question Script (already drafted) + AI Cost Worksheet (net-new).
- **Posts**:
  - `7.1 "We Use AI" - Five Follow-Up Questions` (wrap: 2510 NEW-E) - vendor or hire interrogation in 30 minutes; dual-purpose with Module 4B.2.
  - `7.2 The AI Token Bill Your Agency Forgot to Mention` (wrap: 2510 NEW-D2) - predict and cap pass-through OpenAI/Anthropic charges.
  - `7.3 Slopsquatting: The Supply Chain Attack Vibe Coding Created` (wrap: 2510 #20) - 2025 attack vector; what your shop must do before merge.

---

## How modules connect (the journey map)

```
Module 0: Where Are You?
   │
   ▼
Module 1: Validate the Problem        ── advanced: Empathy / JTBD / Journey / Continuous Discovery
   │
   ▼
Module 2: Design the Solution          ── advanced: Impact Mapping / Foundation Sprint / Design Sprint / Lean Inception / User Story Mapping
   │
   ▼
Module 3: Choose Your Build Path
   │
   ┌─────────┴─────────┐
   ▼                   ▼
Module 4A:         Module 4B:
Ship Self-Serve    Hire & Ship
   │                   │
   │  (ceiling hit?    │
   │   route to 4B)    │
   │                   │
   └─────────┬─────────┘
             ▼
Module 5: Manage Your Build            ── advanced: Shape Up / Continuous Discovery / User Story Mapping
             │
             ▼
   (if everything is fine: skip to 7)
             │
             ▼
Module 6: When Things Break (triggered on signal, not always)
             │
             ▼
Module 7: Manage AI-Era Risks (everyone using AI in build)
```

---

## What this is NOT

- **Not** a "how to learn to code" course. The 100 School / Codecademy / Coding for Entrepreneurs angle is well served by others.
- **Not** a fundraising or operations course. YC Startup School and Sophia Matveeva own that.
- **Not** a "build with no-code only" course. Lovable's own community + WeAreNoCode own that.
- **Not** a cohort. No live sessions, no certificates, no graded assignments. Free, self-paced, readable on a phone at 9pm.

**Primary reader (course ICP):** a non-technical founder going from idea (or a half-built MVP) to first paying customer. They mostly have NOT hired a team yet - the course exists to get them to validated demand and a live MVP before they ever write that check. This is the course ICP and it is distinct from the website lead-generation ICP in `90.10-icp-primary-website-target.md` ("Alex, the Burned Non-Technical Founder"), which targets founders already in a rescue situation.

**Secondary readers (route, don't re-pitch):** founders who are about to hire, currently have a team, or have already been burned. They are routed at the entry point - the landing page "If Your Team Is Already Failing" fast path - to the management/rescue chapters (Modules 4-5 + continuation chapters). Course bodies address the primary idea-stage reader; burned-founder framing belongs on the landing-page fast path and inside the rescue chapters, NOT in the opening of validation chapters. (Per-chapter routing blocks were tried on Ch 1.1 and removed 2026-05-22 - they interrupted the primary reader and duplicated the landing-page router.) The course teaches the simplest path through the decision tree, with structured frameworks available as optional sophistication when team capacity allows.

---

## Pure-lead-magnet positioning (added 2026-05-12)

The course **does NOT sell JT services**. Memory ref: `feedback_curriculum_is_pure_lead_magnet.md`.

- **No service CTAs** anywhere in the 26 posts: no "book a Control Audit," no "schedule a consultation," no "we can help with this."
- **Authorship credit stays** at the footer of every post: "Built by JetThoughts as part of the free Tech for Non-Technical Founders 2026 curriculum."
- **Email-gated artifact downloads** are the lead-capture mechanism (standard lead-magnet mechanics).
- **Module 3.2 Fractional CTO** is generic, not a JT offer.
- **No "When you need a human" row** in the course-nav table - the nav stays pure module-progression.

## Viral-shareability requirements (added 2026-05-12)

Every post in the 26-post syllabus must include:

1. **Contrarian hook** in the opening 80 words ("Stop looking for a technical co-founder," not "How to find a CTO").
2. **One quote-tweetable insight** (single sentence, 140-280 chars, stands alone outside the post).
3. **A specific tactic** the reader can execute this week (not abstract principles).
4. **A free downloadable artifact** referenced inline.
5. **A shareable headline structure** (Stop X / N things you get wrong / How X lost $Y / The thing your dev shop won't show you).

Memory ref: `feedback_curriculum_viral_shareability.md`.

The course's success metric is **share velocity + email captures + page-1 SEO ranks**, not consultation bookings.
