# _ARCHIVED_ — ICP-Sam Persona Course Walkthrough — Sam, the Idea-Stage First-Timer

> **ARCHIVED 2026-06-07.** This walkthrough is superseded by two newer, more comprehensive documents:
> - **40.06** (`docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.06-sam-customer-journey-report-2026-06.md`) — definitive Sam reference: per-chapter trust scores, emotional arcs, mobile analysis, artifact chains, 3 entry-point doors, overall journey score.
> - **40.07** (`docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.07-sam-experience-improvement-report-2026-06.md`) — canonical actionable recommendations: 6 Sam-first improvements logged in TASK-TRACKER for triage.
>
> The 8 recommendations from this walkthrough have been triaged:
> - 2 captured in 40.07 (landing fast path, stuck boxes)
> - 5 tabled as aspirational/structural (split M2.3, alt ch1.1 opener, jargon audit, idea discovery worksheet, Sam/Alex comparison)
> - 1 superseded by broader work (M2.2 repositioning discussion)
>
> **Kept for historical record only** — the illustrative Sam persona (BFA Industrial Design, $40K runway, dog-walking marketplace) was a useful exploration vector but is not canonical.

**Created**: 2026-05-29
**Last updated**: 2026-05-29
**Project**: 2605-tech-for-non-technical-founders
**Source definition**: `20.01-course-modules.md` § "Primary reader (course ICP)" and `CLAUDE.md` § "ICP-reader read-back" ("Sam, the idea-stage non-technical first-timer, NOT the website lead-gen ICP Alex the burned founder").
**Method**: AI persona simulation — agent assigned the course ICP profile walked the full 5-module course sequentially, recording assessments after each module.
**Evaluator**: ICP-Sam persona agent ("Sam")

> **Note on persona specificity**: Sam's age, background, product choice, and specific numbers (BFA Industrial Design, $40K runway, dog-walking marketplace) are **illustrative** — they embody the traits from the source definitions above. They are NOT canonical requirements for the ICP. Future agents should treat the traits (no technical trauma, low jargon tolerance, need progressive disclosure) as canonical, not the illustrative details.

---

## 1. Persona: Sam

- 33, BFA in Industrial Design, founder & sole employee of a pre-revenue B2B SaaS
- Self-funded from savings ($40K runway, 8 months left)
- Validated an idea through 3 hallway conversations with friends ("they all said they'd use it")
- Has NOT hired anyone. Has NOT been burned. Has NOT raised money.
- Tech literacy: can use Notion, Figma (basic), Gmail, Google Sheets — has never deployed anything, never touched a terminal, never heard of GitHub
- Emotional state: excited, anxious about the technical parts, afraid of wasting time/money, open to learning but easily overwhelmed by jargon

**Key ICP-Sam traits active during evaluation**: no prior technical trauma, low tolerance for unexplained jargon, need for progressive disclosure (orientation before mechanics), preference for value-first framing over sales/pitch, visual rhythm sensitivity (no two same-form callouts adjacent), aversion to "this will be hard" warnings that imply the reader isn't smart enough.

> **Note on chapter ordering**: This walkthrough presents chapters in the order Sam encountered them during the simulation (linear idea-stage sequence). The actual shipped chapter sequence may differ. See `../20-29-strategy/20.01-course-modules.md` or `../../data/course_sequence.yaml` for canonical ordering.

---

## 2. Module-by-Module Walkthrough

### Module 1 — Hypothesis & Smoke Test (estimated 2 hr)

**Sam's experience:**

Sam opens Chapter 1.1 at 10 PM Tuesday after putting the kids to bed. The three-sentence hypothesis template asks her to write *customer / business / solution* in plain English. She hesitates — she's been describing her idea as "an Airbnb for pet sitting" to friends. The template pushes her to be specific. She writes:

> *Customer: A 35-year-old dog owner in a city who travels for work 2x/month and doesn't trust boarding kennels.*
> *Business: B2C marketplace, 15% commission per booking, $0 upfront.*
> *Solution: A vetted pet-sitter network with live video check-ins, so they can travel without guilt.*

She moves to Chapter 1.2. The smoke-test landing page builder names Carrd + Stripe. Carrd is new to Sam — the chapter glosses it as "a one-page website builder, like a nicer Google Form that looks like a real product page." She builds the page in 90 minutes. The Stripe price button asks for $29/month — she pauses and re-reads Chapter 1.3's guidance on pricing: *"Price is a hypothesis too. The button tests whether strangers will click 'buy' — not whether they'll complete checkout."* She sets the price and launches.

**ICP verdict — Practicality**: ✓ High. Sam went from "I have an idea I told 3 friends about" to "I have a live landing page with a Stripe button" in one evening. The Carrd gloss is essential — without it she would have Googled "how to use Carrd" for 30 minutes and lost momentum.

**ICP verdict — Engagement**: ✓ High. The opening founder story (dev-shop disaster → landing page) is less resonant for Sam than it would be for Alex — she hasn't been burned by a dev shop. But the chapter structure (template → tools → deploy) is fast enough that she doesn't dwell on the mismatch. The "you don't need to code" framing is the real hook for Sam.

**ICP verdict — Goal achievability**: ✓ Yes. 2 hours, one landing page, live URL she can send to friends. The output is concrete and demystifying — Sam now knows what a "smoke test" actually looks like.

**Modernity / Validation**: ✓ The Carrd + Stripe stack is 2026-specific. The three-sentence hypothesis template is drawn from YC Startup School methodology. The 7-day wait is from validated lean startup practice.

**ICP-Sam-specific check — Jargon glossed at first mention**: ✓ "Carrd" gets a plain-English explanation. "Stripe" is explained as "a payment processor — the company that handles credit cards for most startups." "Smoke test" is defined inline.

**ICP-Sam-specific check — Progressive disclosure**: ✓ Chapter 1.1 orients (what is a hypothesis, why it matters) before mechanics (the three-sentence template). Chapter 1.2 orients (what is a smoke test, why run one) before build steps. No thresholds or metrics are front-loaded.

---

### Module 2 — Validate the Problem (estimated 3 hr)

**Sam's experience:**

Chapter 2.1 introduces the Mom Test. Sam has never interviewed a customer before — she only asked friends. The core rule (*ask about the past, not the future*) is new. She drafts 8 questions, most of which sound like "would you use..." and "do you think..." — hypotheticals.

Chapter 2.2 asks her to paste those questions into Claude with an ICP persona prompt. Sam has heard of "AI" but never used it as a rehearsal tool. The chapter glosses Claude as "a free AI assistant — think of it as a practice customer who answers honestly." She runs the prompt. Claude flags Q3 ("Would you pay $29/month?") as hypothetical. She rewrites: "How much do you currently spend on kennels or pet sitters per month?"

Chapter 2.3 is the outreach playbook — the longest chapter. Sam needs to find 10 people with the problem. The chapter walks her through Reddit, Discord, and G2 reviews. Sam has never used Reddit seriously before — the chapter includes a sidebar on Reddit etiquette ("read the sub for a week before posting, leave 3 real comments first"). She spends 2 hours reading r/dogs and r/petsitting threads. She finds 12 named people complaining about boarding costs, adds them to a spreadsheet.

Chapter 2.4 — the clickable prototype in Lovable. Sam builds a 3-screen clickable prototype in 2 hours. Lovable is glossed as "an AI app builder — you describe what you want in plain English and it generates the screens." She shows the prototype to 3 interview subjects. One says "I thought clicking the dog photo would show me sitter reviews." Sam catches a UX assumption she would have coded into the real product.

**ICP verdict — Practicality**: ✓ High. The AI rehearsal (Chapter 2.2) is the most practical tool for Sam — she has no interview experience and the practice run saves her first 3 real interviews. The outreach playbook is dense but methodical.

**ICP verdict — Engagement**: ✓ Medium-high. Sam's primary engagement risk is the outreach chapter (2.3). She has never done sales-adjacent work. The chapter's "6 messages a day, 30 minutes a day" rule is a lifeline — it prevents paralysis. But the density (Reddit + Discord + G2 + LinkedIn + Apollo + NeetoCal + Gmail multi-send) risks overwhelm. Sam says: *"I had to re-read the outreach chapter twice. It's good but there's a lot of tools named."*

**ICP verdict — Goal achievability**: ✓ Yes, conditionally. Sam can complete the 4 chapters in a week if she paces herself. The risk is the outreach chapter's tool density — Sam might stall researching each tool instead of just picking one channel and executing. The "just Reddit is enough" callout helps but could be more prominent.

**Modernity / Validation**: ✓ AI persona rehearsal is a 2026-native innovation. The Mom Test (Fitzpatrick) is the validated interview methodology. The Lovable prototype chapter is modern. The outreach playbook references Apollo, Clay, Gmail multi-send, and NeetoCal.

**ICP-Sam-specific check — Jargon glossed at first mention**: ✓ "Mom Test" is explained (book by Rob Fitzpatrick, method for truthful customer interviews). "ICP" is glossed. "Apollo" is explained as "a sales database with a free tier — it finds people by job title and company size." "Gmail multi-send" is explained. "NeetoCal" is glossed as "a free booking calendar." All tools get an inline what-this-is sentence.

**ICP-Sam-specific check — Progressive disclosure**: Partially ✓. The outreach chapter orients (why find people, what channels exist) but the tool list in the "read where they're already complaining" section is dense. Sam has to absorb 6 channel types (Reddit, LinkedIn, Slack/Discord, G2, Twitter/X, personal network) and 3 tool names (Apollo, Clay, NeetoCal) in one section. Splitting this chapter into "find the people" and "book the calls" would improve progressive disclosure for Sam.

**ICP-Sam-specific check — No two adjacent same-form callouts**: ✓ The chapter alternates between tool tips, Reddit etiquette sidebars, and channel examples — no two adjacent same-format blocks.

---

### Module 3 — Product Brief (landing page declares 1 hr reading time; realistic 1-2 sessions execution)

**Sam's experience:**

Chapter 3.1 introduces the Vibe PRD. Sam has never written a product brief — she has a Notion doc with bullet points. The template asks for 6 sections: persona, problem, current behavior, solution (outcomes, not features), what we won't build, how we'll know it worked. She fills it in 60 minutes. The "what we won't build" section is hardest — she wants to build everything.

Chapter 3.2 introduces job stories: "When [situation], I want to [motivation], so I can [expected outcome]." Sam rewrites her feature list. One example: instead of "a booking calendar with availability slots," she writes: "When I'm going on a work trip next week, I want to find and book a sitter who's available those specific dates, so I don't spend Friday afternoon texting 5 friends asking who's free." The outcome shift clicks.

**ICP verdict — Practicality**: ✓ High. The Vibe PRD template is the key artifact. Sam now has a one-page document she can show anyone. The "what we won't build" section is especially valuable for her — it prevents scope creep before she starts.

**ICP verdict — Engagement**: ✓ High. Module 3 is the shortest module and the most intellectually satisfying. Sam says: *"The job-story format was a lightbulb moment. I had been describing my product as features, not situations. Now I understand why my friends said 'sounds cool' instead of signing up."*

**ICP verdict — Goal achievability**: ✓ Yes. One focused session. The template is short enough that Sam doesn't stall. The chapter is designed for completion in one sitting.

**Modernity / Validation**: ✓ Vibe PRD (Drew Falkman's 2026 format). Job Stories (JTBD canon from Christensen/Kalbach). The "outcomes not features" principle is validated by YC and product management best practice.

**ICP-Sam-specific check — Jargon glossed at first mention**: ✓ "Vibe PRD" is explained as "a one-page product brief — think of it as the simplest possible blueprint for what you're building." "Job story" is explained with the format and an example. "Outcome" vs "feature" is demonstrated with before/after examples.

**ICP-Sam-specific check — Progressive disclosure**: ✓ Module 3 follows a natural progression: template → fill → reframe. No mechanics are front-loaded. Sam learns the job story format by writing one, not by reading a definition.

---

### Module 4 — Choose Your Build (landing page declares 2 hr reading time; realistic 4-6 weeks execution including the 4-week ship plan + Week-5 Module 5 onramp)

**Sam's experience:**

Chapter 4.1 presents the build decision tree. Sam has never considered "should I build this myself or hire someone" as a structured decision. The tree asks 4 yes/no questions. For Sam (pre-revenue, solo, not technical), the answer is clearly self-serve.

Chapter 4.2 is the Ownership Audit. Sam doesn't have a GitHub org or an AWS account — she's never deployed anything. The audit checklist includes a prelude: *"If you haven't started building yet: create these accounts today under your personal email. One hour now saves you a migration nightmare later."* She creates GitHub, AWS, and Stripe accounts under her company email.

Chapters 4.3-4.4 walk through the self-serve stack build. Sam builds the pet-sitter matching flow using Lovable + Supabase + Stripe. Supabase is glossed as "a database that lives in the cloud — think of it as Google Sheets for your app's data." Stripe is re-glossed for the integration step. She reaches a staging URL by the end of Chapter 4.4.

**ICP verdict — Practicality**: ✓ High. The ownership audit prelude (new section written for the idea-stage founder) is essential for Sam — without it, she would start building under a personal email and face the migration problem 6 months later. The self-serve build chapters give her a real staging URL.

**ICP verdict — Engagement**: ✓ High. The staging URL milestone is the most motivating moment in the course for Sam. She has a real, clickable app — not a mockup, not a landing page, an app with a database. She texts a screenshot to her co-founder friend.

**ICP verdict — Goal achievability**: ✓ Yes, with caveat. The self-serve stack walkthrough is the most technically demanding section of the course. Sam can follow the steps if she goes slowly and uses the tool-specific glossaries. The risk is that a single failed step (e.g., Stripe webhook misconfiguration) could stall her for a day. The chapter's "stuck? paste the error into Claude and ask 'what do I do next?'" callout is a practical workaround.

**Modernity / Validation**: ✓ The Lovable + Supabase + Stripe stack is 2026-specific and widely discussed in founder communities. The ownership audit pattern is derived from real rescue cases. The "create accounts now" prelude is a forward-looking fix for a common post-hoc pain point.

**ICP-Sam-specific check — Jargon glossed at first mention**: ✓ "Supabase" is glossed. "AWS" is explained as "Amazon Web Services — the cloud provider where most startups host their app." "Staging URL" is glossed as "a private web address where your app lives during development — not yet public, but clickable." "Webhook" is glossed as "a way for one service to notify another when something happens — like Stripe telling your app 'the customer paid'."

**ICP-Sam-specific check — Progressive disclosure**: ✓ Chapter 4.1 orients (build decision framework) before mechanics (tool-specific steps). The ownership audit audits before the build — natural sequence for a first-timer. The self-serve build chapters start with "what you'll build by the end" before the step-by-step.

**ICP-Sam-specific check — Value-first, not sales**: ✓ No "hire JetThoughts" framing. The ownership audit is positioned as founder empowerment, not as a service upsell. The self-serve stack is presented as a real alternative to hiring.

---

### Module 5 — First Paying Customer (landing page declares 1 hr reading time; realistic 3-4 weeks execution)

> **Correction 2026-05-29**: an earlier draft of this section had the Module 5 chapter mapping wrong. Canonical mapping per `data/course_sequence.yaml`:
> - **Ch 5.1** — Your First Customer Is Not Marketing: The Sean Ellis 40% Test
> - **Ch 5.2** — Choose Your Channel Before You Send One Message
> - **Ch 5.3** — The First Ten From Your Network
> - **Ch 5.4** — Charge Before You Ship: The Paid Pilot Contract
> - **Ch 5.5** — Going Outbound Without a Sales Team
>
> The rewritten Sam walk below uses the correct chapter assignments.

**Sam's experience (corrected):**

Chapter 5.1 introduces the Sean Ellis 40% PMF test. Sam needs 10-30 users on the MVP to run the survey — she has the 10 Module 2 interviewees she just invited via the new M4.3 Week-5 onramp section. She sends the 5-question Typeform; 4 of 10 respond, 2 say "very disappointed" without her product = 50% must-have rate. Sean Ellis's framework treats anything ≥40% as PMF signal. Sam has a green light at 10 users.

Chapter 5.2 is channel selection — pick ONE channel and commit for 4 weeks. Sam's interview transcripts named Reddit (r/dogs, r/petsitting) as the channel her ICP actually uses. She picks personal network first (Module 5.3), Reddit second.

Chapter 5.3 is the first-ten-from-personal-network playbook — Sam builds a 50-name list in 4 buckets (champions, peers, advisors, weak ties) and sends 15 personalized Looms by Friday. 4 reply, 2 book intro calls.

Chapter 5.4 is the paid-pilot close: Sam sets a $250 pilot price (lower than the course default of $500 — the chapter's "B2C pricing range $99-$499 / month" sidebar guides her). She writes a 4-week scope with weekly checkpoints and a go/no-go decision gate. Her first pilot customer (a friend-of-a-friend from the interview pool) pays via Stripe deposit. Sam now has her first revenue.

Chapter 5.5 is the cold-outbound playbook for when personal network is exhausted — Sam saves it for week 4-6 of Module 5 to find pilot #2.

**ICP verdict — Practicality**: ✓ High. The paid pilot template (scope, price, checkpoints, graduation terms) is the most valuable artifact for Sam. A B2C pricing sidebar (recommended — see Gaps table) would be a necessary addition to prevent Sam from following the $500 default and scaring off early users.

**ICP verdict — Engagement**: ✓ Very high. The $250 Stripe deposit notification is Sam's first revenue ever. She says: *"I cried. Someone paid me for something I built. This is real now."* The emotional milestone is the most powerful engagement driver in the entire course.

**ICP verdict — Goal achievability**: ✓ Yes. The 4-week paid pilot at $250 is achievable for Sam with a validated product and 10 interview subjects. The scaling chapters (5.4, 5.5) are optional.

**Modernity / Validation**: ✓ Channel selection framework (Justin McGill / modern B2B). Cold-email conversion playbook (YC Startup School). Paid pilot structure is modeled on real best practices.

**ICP-Sam-specific check — Jargon glossed at first mention**: ✓ "Cold email" is explained as "an email to someone who doesn't know you — short, specific, not spam." "Paid pilot" is glossed as "a short-term paid engagement — like a trial but with real money, so both sides take it seriously." "Go/no-go gate" is explained as "a pre-agreed checkpoint where you decide whether to continue or stop."

**ICP-Sam-specific check — Progressive disclosure**: ✓ Module 5 follows a natural escalation: choose channel → write script → close pilot → scale. The high-ticket B2B chapter is clearly flagged as skippable for B2C founders — no pressure to read it.

---

## 3. Overall Course Evaluation (Sam's Perspective)

| Dimension | Score (1-10) | Notes |
|-----------|-------------|-------|
| **Practicality** | 10 | Every chapter produces a concrete deliverable. Sam built a landing page, prototype, PRD, staging URL, and signed pilot — none of which she had before. |
| **Engagement** | 9 | The staging URL milestone (Module 4) and the first Stripe deposit (Module 5) are emotional peaks that sustain momentum through the slower chapters. |
| **Goal achievability** | 9 | The linear path is clearly mapped. Realistic timeline is **12-22 weeks elapsed (40-60 focused hours)** at 2-4 hours/week — the "4 weeks" figure in earlier drafts was the BUILD portion of M4.3 only, not the full idea-to-paying-customer journey. The main risk is Module 2's outreach chapter density. |
| **Modernity / Validation** | 9 | Stack is 2026-native. Methodology is grounded. AI-persona rehearsal is genuine innovation. |
| **Progressive Disclosure** | 8 | Most chapters orient before mechanizing. Module 2 outreach chapter is the weak point — tool density risks overwhelm for a first-timer. |
| **Jargon Handling** | 9 | All major tools/terms glossed at first mention. A few omissions: "database migration" (Module 4.2) is used without definition. |

**Overall: 9.0/10**

### What the course does exceptionally well for Sam

1. **Every chapter has a concrete output** — Sam goes from "I have an idea" to "I have revenue" with no chapter that ends in reflection-only.
2. **Tools are named with plain-English glosses** — Carrd, Claude, Lovable, Supabase, Stripe all get real explanations, not just links.
3. **The self-serve build path is complete and achievable** — Sam builds a real app, not a mockup.
4. **The paid pilot is the right first-revenue milestone** — $250 is low enough to close, high enough to count. The B2C pricing sidebar prevents the $500 default from being a blocker.
5. **The ownership audit prelude (create accounts now) prevents a future crisis** — Sam would have started building under a personal email without this chapter.

### Gaps and suggestions (Sam-specific)

| Gap | Severity | Suggestion |
|-----|----------|------------|
| Module 2 outreach chapter is tool-dense | **High** | Split into 2 chapters: "Find 10 People" (channels + reading + list building) and "Book the Calls" (message templates + calendar + follow-ups). The current density is the highest dropout risk for the idea-stage ICP. |
| "Database migration" in Module 4.2 is not glossed | Medium | Add a one-sentence gloss: "moving your data from one database to another — imagine moving all your files from one Google Drive account to another, but more technical." |
| The opening founder story in Module 1 is dev-shop focused | Medium | Add an alternative opening for the idea-stage reader: a founder who validated with 3 friends, built a smoke test, and discovered the friends were just being nice. The current opener (dev-shop disaster) is off-persona for Sam. |
| No "what to do when you're stuck" per-module for first-timers | Medium | Add a "Stuck? Try this" box per module with the most common first-timer stall point. Module 2: "Your list has 3 names, not 10. Go back to Step 2 and search for a related keyword — 'boarding costs' instead of 'pet sitter.'" |
| Module 1 assumes the reader has a clear hypothesis | Low | Add a one-page "Idea Discovery Worksheet" for readers who have a vague feeling ("I want to build something for dog owners") but not a specific hypothesis. |

### What Sam (ICP) would say after completing

> *"I started with an idea I told three friends and a Notion doc. Roughly four months later — about 50 hours of evenings and weekends — I have a live app, a paying customer, and a process I can repeat. The course didn't assume I knew anything about tech — it explained every tool the first time it appeared and never made me feel dumb for not knowing. The hardest part was finding interview subjects, but the '6 messages a day' rule made it manageable. I'm going to run the whole thing again for my second product."*

---

## 4. Verification Against Course ICP Requirements

Per `20.01-course-modules.md` § "Primary reader (course ICP)":

> A non-technical founder going from idea (or a half-built MVP) to first paying customer. They mostly have NOT hired a team yet.

### Does the course serve the idea-stage first-timer? ✓

Every module produces a concrete output that builds on the previous one. The self-serve build path is complete and accessible. The ownership audit includes a "start here" prelude for founders who haven't built yet. The paid pilot chapter includes a B2C pricing sidebar. Sam completed the course with: hypothesis → landing page → interview transcripts → prototype → PRD → staging URL → paid pilot.

### Does the course gloss every term at first mention? Mostly ✓

All major tools and frameworks (Carrd, Stripe, Claude, Mom Test, ICP, Apollo, Lovable, Supabase, AWS, Vibe PRD, job story, cold email, paid pilot, go/no-go gate, staging URL, webhook) receive plain-English explanations at first mention. One missed term: "database migration" (Module 4.2) is used without definition.

### Does the course use progressive disclosure? Mostly ✓

Modules 1, 3, 4, and 5 orient the reader before introducing mechanics. Module 2 (outreach chapter) is the weakest — it presents 6 channel types and 3 tool names in a single dense section. The "just Reddit is enough" callout helps but should be more prominent.

### Does the course maintain a value-first (not sales) tone? ✓

No service CTAs. No pitch framing. The ownership audit is positioned as founder empowerment. The self-serve build path is a genuine alternative to hiring, not a lead-in to a "when you need professionals" upsell. The "Built by JetThoughts" footer is the only brand presence, and it's unobtrusive.

### Does the course maintain visual rhythm? ✓

No two adjacent same-form callouts across the 18 chapters. Callout types alternate between tool tips, Reddit etiquette asides, pricing guidance sidebars, and blocking notes.

### Does the course avoid rescue/trauma framing in idea-stage chapters? ✓

Per CLAUDE.md: "rescue/trauma framing is off-ICP for course bodies." Module 1.1 uses a dev-shop disaster opener — this is the one deviation flagged as off-persona for Sam. Modules 2-5 use neutral framing (opportunity, not rescue). The ownership audit (Module 4.2) is framed as future-proofing, not trauma recovery, which is correct for Sam.

### Does the course avoid per-chapter routing blocks? ✓

Per CLAUDE.md: "per-chapter routing blocks were tried on Ch 1.1 and removed 2026-05-22 — they interrupted the primary reader." The shipped course has no routing blocks ("If you're here because your dev shop is failing, skip to Chapter 4.2") in any chapter. All routing is handled by the landing page assessment worksheet, which is appropriate for both Alex and Sam.

---

## 5. Module Scoring Matrix (Sam vs Alex)

| # | Module | Sam Practicality | Sam Engagement | Sam Achievability | Sam Score | Alex Score | Delta |
|---|--------|-----------------|----------------|-------------------|-----------|------------|-------|
| 1 | Hypothesis & Smoke Test | 10 | 8 | 10 | 9.3 | 9.5 | -0.2 (dev-shop opener less resonant) |
| 2 | Validate the Problem | 9 | 8 | 8 | 8.3 | 9.0 | -0.7 (outreach tool density overwhelms first-timer) |
| 3 | Product Brief | 10 | 9 | 10 | 9.7 | 9.25 | +0.45 (job stories click harder for idea-stage) |
| 4 | Choose Your Build | 10 | 10 | 9 | 9.7 | 9.5 | +0.2 (staging URL is more emotional for first build) |
| 5 | First Paying Customer | 10 | 10 | 9 | 9.7 | 8.5 | +1.2 (first revenue is more powerful for pre-revenue founder) |

**Sam's overall: 9.0/10**

**Key deltas from Alex (10.06):** Sam scores Module 5 higher (first revenue is a more emotional milestone for a pre-revenue founder than for a burned founder who has already raised). Sam scores Module 2 lower (outreach tool density and first-time interview anxiety are bigger barriers than for Alex, who has probably had sales conversations before). Sam scores Module 1 engagement lower (the dev-shop opener is off-persona).

---

## 6. Key Findings (Sam-Specific)

1. **Strongest chapters**: Charge Before You Ship / paid pilot close (5.4 — originally mis-attributed as 5.3 in the first draft of this walk), Self-Serve Stack Walkthrough (4.3-4.4), Vibe PRD (3.1). These produce tangible, emotional milestones for a first-timer: revenue, a live URL, and a one-page blueprint.

2. **Weakest chapter**: Find 10 People (2.3). The tool density (Reddit + Discord + G2 + Twitter/X + LinkedIn + personal network + Apollo + Clay + NeetoCal + Gmail multi-send) is the highest overwhelm risk in the course for an idea-stage first-timer. The "just Reddit is enough" callout needs to be more prominent — ideally the first sentence of the section.

3. **Most underutilized asset**: The glossary chapter. Sam would use it heavily, but it's a separate reference page, not inline guidance. Adding inline glosses (already done for most terms) is the right approach, but the one missed term ("database migration") confirms the system needs a gloss audit.

4. **Risk of reader dropout**: Highest risk point is Module 2 → Module 3 transition. Sam finishes outreach (dense, labor-intensive) and faces the prototype chapter (another build task). Adding a "halfway checkpoint" between Module 2 and 3 would reduce dropout — something like: "You've found 10 people. You've run 5 interviews. Take a breath. You now know more about your customer than 90% of founders at your stage."

5. **The ownership audit prelude is essential for Sam**: Without the "if you haven't started building yet, create these accounts now" section, Sam would start under a personal email and face the migration problem later. This section should be preserved and highlighted in any future revision.

6. **Sam would benefit from a "first-timer fast path" on the landing page**: Unlike Alex (who needs the burned-founder route), Sam enters without trauma. A landing page option that reads "New to this? Start here →" and routes to Module 1.1 directly would save her from the decision-paralysis of the self-assessment worksheet.

---

## 7. Comparison: Sam vs Alex — When the Course Works for Whom

| Dimension | Sam (idea-stage) | Alex (burned founder) |
|-----------|-----------------|----------------------|
| Entry point | Module 1.1 (linear start) | Module 4.2 (ownership audit first) or Module 5 (oversight chapters) |
| Emotional peak | First Stripe deposit (Module 5.3) | Ownership audit discovery (Module 4.2) |
| Biggest risk | Outreach tool density overwhelm | Trust: "is this course selling me something?" |
| Most valuable chapter | Paid Pilot Close (5.3) | Ownership Audit (4.2) |
| Least valuable chapter | Build Decision Tree (4.1) — obvious for pre-revenue | Hypothesis chapter (1.1) — already has product |
| Best course promise | "From Idea to First Paying Customer" (the course title) | "Rescue your project without becoming technical" |
| Needs from landing page | "New? Start here" button + idea-stage testimonials | "Your team is failing?" fast path + rescue case studies |
| Dropout risk zone | Module 2.3 outreach density | Module 3.2 (outcomes framing) — impatient to build |
| Preferred module order | 1 → 2 → 3 → 4 → 5 | 4.2 → 5 oversight → 6 (if applicable) → backfill |

---

## 8. Recommendations for Sam-First Improvements

| Priority | Recommendation | Rationale |
|----------|---------------|-----------|
| **P1** | Split Module 2 outreach into 2 chapters: "Find 10 People" (channels + reading) and "Book the Calls" (templates + calendar) | Single highest dropout risk for Sam. Current density is ~45 min read + ~2 hr execution in one sitting. |
| **P1** | Add a "New to this? Start here →" routing option on the landing page | Sam currently sees the same landing page as Alex. First-timers need a clear "you're in the right place" signal. |
| **P2** | Write an alternative opener for Module 1 Chapter 1.1: idea-stage founder + 3 friends who said "sounds great" → smoke test → friends were just being nice | Current dev-shop opener is off-persona. The first 80 words of the first chapter set the tone for the entire course. |
| **P2** | Audit all 18 chapters for unexplained terms: add gloss to any term that appears without definition | "Database migration" missed in Module 4.2. A systematic grep for un-glossed technical terms would catch others. |
| **P3** | Add "Stuck? Try this" box per module (first-timer version) | Sam needs different unblocking advice than Alex. E.g., Module 2: "List has 3 names? Search a related keyword." Not "License Apollo Pro." |
| **P3** | Create an "Idea Discovery Worksheet" as a pre-Module-1 artifact | Some idea-stage founders have a vague hunch, not a testable hypothesis. A 10-minute worksheet bridges that gap. |
