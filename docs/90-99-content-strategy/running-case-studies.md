# Running Case Studies — Course Thread

Two founders run through all 5 modules. Each chapter includes a "Case Study" callout showing how the chapter's technique applies to Tomas (B2B SaaS) and Mia (B2C marketplace). This creates simulated interactivity — the ICP reader watches a founder like them apply the technique and see the result.

**Format per chapter**: A `> **Case Study:**` blockquote at the end of the main body (before "Further reading"), showing the outcome for both founders. Keep each entry ≤4 sentences. Reference the concrete detail from the case profile below.

**Rule**: Case studies are sidebar callouts, NOT chapter openers. Never open a chapter with a case study — this triggers the voice-guide template-fatigue rule. The case study goes after the technique is taught, not before.

---

## Case 1: Tomas — B2B SaaS (Accounting/FinTech)

| Detail | Value |
|---|---|
| **Name** | Tomas |
| **Background** | Ex-accountant, 4 years at a mid-size firm. Left to start a company. Non-technical. |
| **Idea** | **ReconcileBot** — automated invoice reconciliation for mid-size accounting firms (50-200 employees). Auto-matches Stripe transactions against QuickBooks invoices, flags discrepancies in 90 seconds instead of 2 hours. |
| **Burn story** | Paid a dev shop $60K over 8 months for an MVP. Delivered a buggy dashboard with hardcoded data. GitHub org, AWS account, and domain were all under the agency's accounts. Tomas had no admin access. Fired them. |
| **Current state** | Has the idea validated through his network (ex-colleagues complain about this weekly), but zero evidence. $80K savings left. No team. No product. Distrustful of agencies. |
| **Personality** | Detail-oriented, skeptical, numbers-driven. Wants proof before spending. Reads contracts line by line. Would rather build it himself than trust another agency. |
| **ICP match** | Direct match for the course. Burned by a devshop, non-technical, has an idea, needs a linear route. |

## Case 2: Mia — B2C Marketplace (EdTech)

| Detail | Value |
|---|---|
| **Name** | Mia |
| **Background** | Former special-ed teacher, 8 years in public schools. Left to solve a problem she saw daily. Non-technical. |
| **Idea** | **TutorMatch** — marketplace connecting parents of kids with learning disabilities (dyslexia, ADHD, dyscalculia) to vetted specialized tutors. Search by specialty + location, parent reviews, booking/payment. |
| **Burn story** | Hired a freelance team on Upwork for $45K over 6 months. Built a half-finished WordPress site with a broken booking system. The team ghosted. Mia owns the domain and WordPress install, but the code is a mess. |
| **Current state** | Has a half-built site that doesn't work. Strong network of parent communities and teacher contacts. $45K savings left. No team. Cautious after being burned. |
| **Personality** | Community-driven, passionate, people-first. Tends to trust people too quickly — her burn came from hiring the cheapest Upwork team without checking references. Wants to help parents NOW, not build tech. |
| **ICP match** | Direct match. Burned by freelancers, non-technical, has a half-built product, needs validation + a path forward. |

---

## Full 5-Module Arc

### Module 1 — Hypothesis & Smoke Test

| Chapter | Tomas outcome | Mia outcome |
|---|---|---|
| **1.1** · Form Hypothesis | Founding Hypothesis: "Mid-size accounting firms (50-200 employees) waste 15+ hours/month reconciling Stripe against QuickBooks by hand. ReconcileBot auto-matches invoices in 90 seconds and flags the 5% that need a human." Scored 4/5 on customer, 4/5 on problem, 3/5 on approach, 3/5 on money. Weakest blank: money — doesn't know if they'll pay $200/mo or $2,000/mo. | Founding Hypothesis: "Parents of kids 8-14 with dyslexia/ADHD spend 20+ hours finding specialized tutors who understand their kid's condition. TutorMatch connects them to vetted specialists in 48 hours with parent reviews." Scored 5/5 on customer, 4/5 on problem, 3/5 on approach, 3/5 on money. Weakest blank: approach — doesn't know if parents prefer search-by-specialty or search-by-location. |
| **1.2a** · Build the Page | Builds a Carrd page with Mixo. Headline: "Reconcile Stripe & QuickBooks in 90 seconds." Hero visual: a 15-second Loom of him pretending to reconcile — manually clicking between two screens while shaking his head. Installs Clarity + LinkedIn pixel. | Builds a NeetoSite page. Headline: "Find a tutor who actually understands dyslexia — 48 hours." Hero visual: a screenshot of her old WordPress booking system with a red X over it. Installs Clarity + Meta pixel. |
| **1.2b** · Run It & Read Signal | Runs LinkedIn ads at $6 CPC. Spends $1,800 for 300 visits targeting "Controller" and "CFO" job titles at firms with 50-200 employees. Conversion rate: 8% (24 signups). Strong signal — moves to Module 2. | Runs Meta ads at $0.90 CPC. Spends $400 for 300 visits targeting "parent of school-age child" + "learning disability" interests. Conversion rate: 3.5% (11 signups). Lands in the "iterate the message" band. Rewrites her headline from "Find a tutor" to "Your kid's dyslexia tutor — 48 hours, parent-reviewed." Re-tests: 6.5%. Strong signal — moves to Module 2 with a tested headline. |
| **1.3** · Price Hypothesis | Adds a Stripe price button: "$200/mo — early access." 5% of visitors click the price button (15 of 300). Of those, 3 complete the $1 pre-sale. Weak price signal — the market won't pay $200/mo without seeing the product first. Notes this for Module 5 paid pilots. | Adds a Stripe price button: "$25/mo — early access." 6% of visitors click (18 of 300). Of those, 6 complete the $1 pre-sale. Stronger price signal than Tomas — parents are used to paying for tutoring. |

### Module 2 — Validate the Problem

| Chapter | Tomas outcome | Mia outcome |
|---|---|---|
| **2.1** · Mom Test | Runs 10 interviews with accounting firm controllers he found on LinkedIn. Key answers: Q1 — "Last Monday I spent 2 hours exporting QuickBooks to CSV, then matching in Excel. I do it every week." Q2 — "My CFO bills $200/hr and spent 4 hours on it last week. That's $800." Q3 — "I tried Zapier but it breaks every time the invoice format changes." Q4 — "8 out of 10. Only hiring is higher on my plate." Scored 8/10 on 7 interviews. Validated. | Runs 10 interviews with parents from Facebook groups. Key answers: Q1 — "Last Tuesday I spent 3 hours Googling 'dyslexia math tutor near me,' called 4 numbers, 2 were disconnected, 1 had a 6-month waitlist." Q2 — "I missed a client deadline because I was on hold with a tutoring center. That cost me a $2,000 project." Q3 — "I joined 3 Facebook groups and posted 'does anyone know a tutor?' I got 12 replies, half were spam." Q4 — "9 out of 10. The only thing higher is my son's IEP meeting next month." Scored 9/10 on 8 interviews. Strongly validated. |
| **2.2** · AI Persona Prep | Runs his draft questions through a Claude persona — a skeptical accounting firm controller who has been pitched 3 "automation tools" this year and rejected all of them. The persona flags 2 leading questions. Sharpens them. | Runs her draft questions through a Claude persona — a parent of a 10-year-old with ADHD who has been burned by a tutoring app before. The persona flags 1 question that assumes the parent has time to search. Adds a question about "what happened the last time you tried to book a tutor during a workday?" |
| **2.3a** · Where to Look | AI ICP map identifies: r/Accounting (300K members), Controller-specific LinkedIn groups, AICPA conference attendees. Builds a 30-name list of controllers who posted about "manual reconciliation" or "month-end close pain" on LinkedIn in the last 90 days. | AI ICP map identifies: Facebook parent groups (ADHD Parent Support, Dyslexia Moms Unite), r/ParentingADHD, local school district special-ed coordinators. Builds a 30-name list of parents who posted about "can't find a tutor" or "tutoring waitlist" in the last 60 days. |
| **2.3b** · What to Say | Sends the 3-message sequence to 30 controllers on LinkedIn. Message 1 references their specific post about month-end close. Books 12 interviews from 30 reaches (40% — high because Tomas was an accountant and speaks the language). | Sends the 3-message sequence to 30 parents via Facebook DM. Message 1 references their specific post about tutoring frustration. Books 14 interviews from 30 reaches (47% — high because Mia was a teacher and parents trust her). |
| **2.4** · Clickable Prototype | Builds a 2-hour Lovable prototype: a simple dashboard showing a mock reconciliation — Stripe transactions on the left, QuickBooks invoices on the right, a "match" button in the middle. Shows it to 5 interviewees. 4 say "when can I use this?" 1 says "the match button is confusing — what happens when it's wrong?" | Builds a 2-hour Lovable prototype: a tutor search page with filters (specialty, location, availability) and mock tutor profiles with reviews. Shows it to 5 parents. 4 say "I'd use this tomorrow." 1 says "I need to see reviews before I book — can you add that?" |

### Module 3 — Design from Evidence

| Chapter | Tomas outcome | Mia outcome |
|---|---|---|
| **3.1** · Product Brief | Drafts a 1-page brief. Section 1 (Problem): 8 of 10 controllers spend 2+ hours/week on manual reconciliation. Section 2 (Core 3 Jobs): (1) auto-match Stripe to QuickBooks, (2) flag the 5% exceptions that need a human, (3) generate a before/after reconciliation report for month-end close. Section 3 (Outcomes): reduces reconciliation from 2 hours to 90 seconds. Section 4 (Out of Scope): no ERP integrations yet, no multi-currency, no invoice generation — just matching. | Drafts a 1-page brief. Section 1 (Problem): 9 of 10 parents can't find a vetted dyslexia/ADHD tutor in under a week. Section 2 (Core 3 Jobs): (1) search tutors by specialty + location, (2) read parent reviews before booking, (3) book + pay in one flow. Section 3 (Outcomes): reduces time-to-tutor from 20+ hours to 48 hours. Section 4 (Out of Scope): no in-person tutoring coordination, no school district partnerships yet, no tutor training materials. |
| **3.2** · Quality-check | Rewrites 3 feature-nouns as job stories: "When a Stripe transaction has no matching QuickBooks invoice, I want to see the top 3 candidate matches so I can confirm the right one in one click — not scan 200 line items." Passes the outcome filter: 4 of 5 sections are outcomes, not features. | Rewrites 3 feature-nouns as job stories: "When I search for a math tutor for my 10-year-old with dyslexia, I want to filter by 'dyslexia-trained' and see reviews from other parents of dyslexic kids — not scroll through 50 generic math tutors." Passes the outcome filter: 5 of 5 sections are outcomes. |

### Module 4 — Build It Yourself

| Chapter | Tomas outcome | Mia outcome |
|---|---|---|
| **4.1** · Should You Hire? | Runs the decision tree. Validated hypothesis? Yes. Mid-complexity? Yes — needs Stripe API + QuickBooks API + matching logic. Has $200K+ for a team? No — $80K savings. Result: **Fractional CTO bridge** (box 3). Hires a fractional CTO at 5 hrs/week for architecture review, then builds the core himself in Lovable. | Runs the decision tree. Validated hypothesis? Yes. Simple MVP? Yes — search + profiles + booking. 4-8 weeks free? Yes. Result: **Self-serve build** (box 2). Builds the whole thing herself in Lovable + Supabase + Stripe. |
| **4.2** · Ownership Checklist | Before starting the build, audits all 12 items. Finds: GitHub org is under his personal email (good), but he has no AWS account at all (bad — needs to create one), and his domain is auto-renewing on the registrar he forgot the password to. Spends a Friday fixing all three. Now owns everything. | Before starting the build, audits all 12 items. Finds: owns the domain (good), has a personal GitHub but no org (fixes — creates one), Supabase account under her email (good). Has no secrets manager (creates a 1Password vault). Spends a Friday afternoon. Now owns everything. |
| **4.3a** · Self-Serve Stack: Tools | Since Tomas chose Fractional CTO bridge, his CTO reviews the self-serve stack and greenlights: Lovable (UI), Supabase (auth + DB), Stripe (payments), n8n (QuickBooks API connector). The CTO writes the RLS policies and the API integration patterns. Tomas builds the UI. | Picks the full self-serve stack: Lovable (UI), Supabase (auth + DB), Stripe (booking payments). Reads the 12 rules checklist. Passes all 12. Starts building. |
| **4.3b** · Self-Serve Stack: Build | Phase 1 (Lovable UI): builds the reconciliation dashboard in 2 weeks. Phase 2 (Supabase auth): fractional CTO sets up RLS policies — each firm sees only their own data. Phase 3 (Stripe): CTO integrates Stripe subscriptions + QuickBooks API via n8n. Phase 4 (deploy): ships to a custom domain. 6 weeks total. 5 green lights passed. | Phase 1 (Lovable UI): builds the tutor search + profile pages in 1 week. Phase 2 (Supabase auth): sets up parent login + tutor login. Phase 3 (Stripe): integrates booking payments. Phase 4 (deploy): ships to a custom domain. 4 weeks total. 5 green lights passed. |
| **4.4** · Ceiling Signals | At ~50 firms (paying customers), 2 ceiling signals fire: (1) the reconciliation matching logic has race conditions — a Stripe webhook fires while the QuickBooks sync is running, producing duplicate matches. (2) n8n API connector breaks every time QuickBooks changes their API response format. Graduates from self-serve to fractional CTO → hired team. The fractional CTO was already in place, so the transition is smooth. | At ~200 parents (registered users), 2 ceiling signals fire: (1) search performance degrades — the Supabase query that filters tutors by specialty + location takes 4 seconds at 200 tutors. (2) the booking flow doesn't handle timezone edge cases — a parent in California books a tutor in New York and the confirmation email shows the wrong time. Graduates from self-serve to fractional CTO. Hires one at 5 hrs/week to fix the search query and timezone logic. |

### Module 5 — First Paying Customer

| Chapter | Tomas outcome | Mia outcome |
|---|---|---|
| **5.1** · Must-Have Segment | Runs the Sean Ellis survey on his 24 smoke-test signups. Segments by firm size: firms with 50-150 employees score 45% "very disappointed" without it. Firms with 150-200 score 28% — they have in-house tools. Narrows to firms with 50-150 employees. | Runs the Sean Ellis survey on her 21 smoke-test signups. Segments by child age: parents of kids 8-14 with dyslexia score 52% "very disappointed." Parents of kids 14+ score 31% — they've already found workarounds. Narrows to parents of kids 8-14 with dyslexia/ADHD. |
| **5.2** · Channel Selection | Channel scoring: LinkedIn (9/10 — controllers are there), cold email (8/10 — accounting firms list emails publicly), Reddit (5/10 — r/Accounting is active but noisy). Commits to LinkedIn + cold email. Scoring: 8.0/10. | Channel scoring: Facebook groups (9/10 — parents are there daily), school district referrals (7/10 — slow but high-trust), Instagram (5/10 — visual but hard to target). Commits to Facebook groups + school referrals. Scoring: 8.0/10. |
| **5.3** · First Ten Customers | 50-name network list: 5 champions (ex-colleagues who complained about reconciliation for years), 10 hot (controllers he met at AICPA conferences), 15 warm (LinkedIn connections in accounting), 20 cold (strangers on r/Accounting). Sends Monday. Gets 8 pilot conversations from 50 messages. 5 say yes. | 50-name network list: 5 champions (teacher friends who have dyslexic kids), 10 hot (parents from her Facebook groups who posted about tutoring), 15 warm (former students' parents), 20 cold (parents who liked her Facebook page). Sends Monday. Gets 12 pilot conversations from 50 messages. 7 say yes. |
| **5.4** · Paid Pilot | Signs a Design Partner Agreement with 3 accounting firms. Deposit math: B2B financial software → $2,500 deposit (refundable if product doesn't ship within 90 days). Writes the DPA with the deposit clause. 2 of 3 sign and pay within 48 hours. Revenue: $5,000 in committed deposits. | Signs a Design Partner Agreement with 4 parents. Deposit math: B2C parent marketplace → $50 deposit (refundable). Writes a simplified DPA. 4 of 4 sign and pay. Revenue: $200 in committed deposits. Lower deposit, higher volume — consumer math. |
| **5.5** · Outbound | Runs LinkedIn cold outreach to 30 controllers at firms NOT in his network. Uses the 3-message cold email variant. 12% reply rate (4 replies). Books 2 pilot conversations. 1 signs a paid pilot at $2,500. Paid pilot count: 3 total (2 from network, 1 from cold outreach). Annualized: $30,000 in committed pilot revenue. Goes to investor meetings with evidence. | Runs Facebook group cold outreach to 30 parents NOT in her network. 28% reply rate (8 replies — parents are responsive in community groups). Books 5 pilot conversations. 2 sign at $50. Paid pilot count: 6 total (4 from network, 2 from cold outreach). Monthly recurring: $300 from paid pilots. Goes to pitch a seed round with 6 paying customers. |

---

## Implementation Pattern

In each chapter, add this callout after the main body (before "Further reading"):

```markdown
> **Case Study: Tomas & Mia**
>
> **Tomas** (ReconcileBot, B2B SaaS): [1-2 sentences showing this chapter's technique applied to Tomas, with a concrete outcome.]
>
> **Mia** (TutorMatch, B2C marketplace): [1-2 sentences showing this chapter's technique applied to Mia, with a concrete outcome.]
```

**Rules:**
- Keep each founder entry to 1-2 sentences. The full arc lives in this reference document; the callout is the scene, not the whole movie.
- **Exception**: The first-chapter callout (Ch 1.1) can run 3-4 sentences per founder — it introduces them for the first time. All subsequent chapters use the 1-2 sentence rule.
- Reference concrete numbers when available (prices, percentages, counts).
- Show the outcome, not just the action. "Got 8% conversion" not "ran the test."
- Place AFTER the "Done when / Next click / If blocked" footer, BEFORE "Further reading."
- Do NOT put case studies in the chapter opener or TL;DR — those are reserved for the technique, not the example.
