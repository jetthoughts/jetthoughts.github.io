# Sprint 1 Artifact Specs

**Purpose**: format + content gates for the 3 Sprint 1 artifacts. A writer agent producing these reads this file once and produces a consistent deliverable without re-deriving structure.

**Sister format reference**: every artifact mirrors the structure of the 5 shipped lead magnets in `../lead-magnets/`. Read at least `friday-demo-template.md` and `ownership-checklist.md` before drafting.

---

## Common structure (mandatory for all 3 artifacts)

Every artifact MD file follows this skeleton:

```markdown
# [Title - clear, concrete, action-oriented]

[One-line subhead in italic - explains what the founder does with it.]

[Optional 1-paragraph "Why this exists" - one anonymized incident showing the cost of NOT having this artifact. Distinct from the 5 sister-artifact anecdotes (62K MVP / 180K B2B / 95K marketplace / 34K AI agency / 78K SaaS milestone).]

## How to use this

[≤120 words. When to run it (Friday afternoon, alone, in 30 minutes). What to bring. What you should DO with what you produce.]

## The [thing] - copy and paste / fill in

[The actual template / script / checklist. Copy-pasteable Slack/email block when appropriate. Numbered or table format.]

## What good looks like vs what bad looks like

[2-3 bad/good pairs with named technical evidence. Show how a failing answer looks vs a passing answer.]

## What to do after

[3 bullets max. The actions the founder takes after filling in the artifact.]

---

Built by JetThoughts as part of the free Tech for Non-Technical Founders 2026 curriculum. See the full curriculum at [/blog/tech-for-non-technical-founders-2026/](/blog/tech-for-non-technical-founders-2026/).
```

**Mandatory rules (apply to all 3)**:
- Plain English, founder-to-founder voice.
- No em dashes (`-` only).
- No banned words (leverage, unlock, harness, supercharge, robust, seamless, empower, streamline, delve, embark, revolutionize).
- No emoji in body.
- ≥1 internal link to an existing JT blog post (verified with `ls content/blog/<slug>/index.md`).
- 1 link to the curriculum landing page at footer.
- 1 anonymized practitioner anecdote (distinct from the 5 lead-magnet anecdotes already in the corpus).
- Authorship credit footer as above.
- Length: not a target; the cut test per section determines what stays.

---

## Artifact 1 — Self-Assessment Worksheet *(Sprint 1.1, Module 0)*

**Path**: `docs/projects/2605-tech-for-non-technical-founders/50-59-execution/lead-magnets/self-assessment-worksheet.md`

**Purpose**: A 5-minute checkbox quiz that routes the reader to their starting module in the 8-module course. Reader prints it, fills it in alone, writes their starting module at the top of a Notion doc.

**Required content**:

1. **Title**: "Where Are You in the Founder Journey? The 10-Question Self-Assessment"
2. **Subhead**: "Five minutes alone with a checklist tells you which module to start with."
3. **Why this exists**: distinct anecdote — three founders who all said "help my team ship" but actually needed three different modules. (See `SPRINT-RUNBOOK.md` §S1.1 for the example phrasing.)
4. **How to use it**: 5 minutes, alone, before coffee. Bring a pen. Mark each question Y/N or with the multiple-choice answer. Write your routing result on top of a fresh Notion doc.
5. **The 10 questions (verbatim from `20.01-course-modules.md` §"The 10 self-assessment questions + routing logic")**:
   - Each question gets: checkbox · question text · routing line ("No → Module 1. Yes → Q2.")
   - Use a markdown table for the 10-question block.
6. **The routing summary**: 2-3 sentences summarizing which question types route where. Visual reference: a Mermaid flowchart in markdown showing the question paths feeding into Module 1/2/3/4A/4B/5/6/7.
7. **What good looks like vs what bad looks like**: 2 pairs.
   - Q1 good vs bad: "I talked to 10 people who all have this problem" vs "I asked 3 friends who said it sounds cool"
   - Q5 good vs bad: "I own the GitHub org under my email" vs "My contractor created the GitHub org under his Gmail"
8. **What to do after**: 3 bullets.
   - Write your starting module + the next deliverable you'll produce at the top of your Notion doc
   - Read that module's first post tonight
   - Re-take this quiz in 60 days to confirm you progressed

**Length expectation**: 800-1400 words is typical for this artifact type; the cut test rules.

---

## Artifact 2 — Outreach Sequence Template *(Sprint 1.2, Module 1.1)*

**Path**: `docs/projects/2605-tech-for-non-technical-founders/50-59-execution/lead-magnets/outreach-sequence-template.md`

**Purpose**: The 2026 stack for finding + booking 10 ICP interviewees in one morning. Reader downloads, copies the outreach sequence, runs it Monday morning, has 10 calls in their calendar by Friday.

**Required content**:

1. **Title**: "Find 10 People With the Problem — The 2026 Outreach Sequence Template"
2. **Subhead**: "Reddit + LinkedIn + Clay + Lindy + paid panels = 10 interviewees by Friday."
3. **Why this exists**: distinct anecdote — a founder who tried "I'll just ask my LinkedIn network" (got 3 polite no's), pivoted to the 2026 stack, booked 12 calls in 4 days.
4. **How to use it**: Run this Monday morning. Budget: 4 hours + $200-$500 in tools/panels. Outcome: 10 booked calls by Friday.
5. **The sequence (5 steps; the artifact's main body)**:
   - **Step 1 — Mine where they're already complaining** (Reddit subreddits + LinkedIn searches + Discord servers; concrete subreddit names per ICP type)
   - **Step 2 — Build the ICP list** (Clay $149/mo or Apollo $49-$149/mo; 50-100 contacts; criteria checklist)
   - **Step 3 — Run the sequence** (Smartlead or Instantly $37-$94/mo + Lindy AI agent for sequence + calendar booking; sample 3-email sequence with subject lines)
   - **Step 4 — Backup via paid panels** (User Interviews $50-$150/interviewee; Respondent for B2B; when to use)
   - **Step 5 — The parallel smoke-test landing page** (Carrd/Framer + £100-200 paid traffic; conversion-rate signal)
6. **Copy-pasteable templates inline**:
   - 3 sample LinkedIn DM openers
   - 3 sample cold email subject lines
   - 1 sample Reddit "I'm researching X" comment
   - 1 sample Calendly booking page copy
7. **What good looks like vs what bad looks like**: 2 pairs.
   - Good DM: specific, references their public post, asks for 20 min on a specific problem
   - Bad DM: generic "love to pick your brain about your industry"
8. **What to do after**:
   - Score the responses: aim 30%+ accept rate by Wednesday
   - If <10% accept: rewrite the opener with sharper specificity
   - Move to the Mom Test artifact for the actual interview script

**Internal links**: at least one to an existing JT post on B2B outreach or founder communication.

**Length expectation**: 1200-1800 words is typical.

---

## Artifact 3 — Mom Test Interview Script *(Sprint 1.3, Module 1.2)*

**Path**: `docs/projects/2605-tech-for-non-technical-founders/50-59-execution/lead-magnets/mom-test-interview-script.md`

**Purpose**: The 5-question script that prevents polite-yes answers. Reader keeps it open on a second screen during interview, asks exactly these questions, gets honest past-behavior data instead of hypothetical agreement.

**Required content**:

1. **Title**: "The Mom Test Interview Script — Ask About the Past, Not the Future"
2. **Subhead**: "Five questions that get the interviewee to tell you what they actually did, not what sounds polite."
3. **Why this exists**: distinct anecdote — a founder who got 8 enthusiastic "yes I'd pay for that" responses, launched, and 0 people actually paid. Rob Fitzpatrick's framework (book: *The Mom Test*, 2013) referenced as the technique, but NOT named in the headline.
4. **How to use it**: Open the script on a second screen during the call. Read questions as written. Listen for emotional language (frustration, hack, workaround). Take notes by hand. Score 1-10 at the end.
5. **The 5 questions (the artifact's main body)**:
   - **Q1: "Tell me about the last time [problem context happened]. Walk me through what you did."** — anchors in past behavior, not hypothetical.
   - **Q2: "What did that cost you — in time, money, or sanity?"** — quantifies the pain.
   - **Q3: "What have you tried already to fix this?"** — surfaces existing workarounds and what didn't work.
   - **Q4: "On a scale of 1-10, how big a problem is this for you compared to everything else on your plate?"** — calibrates urgency.
   - **Q5: "Who else on your team feels this? How do they handle it?"** — surfaces the buying committee + alternative solutions.
   For each question: copy-pasteable phrasing + 1 follow-up + Pass / Fail signals + what good vs bad answer looks like.
6. **The 3 emotional-language flags** to listen for (frustration / workaround language / urgency expressions).
7. **What good looks like vs what bad looks like**: 2-3 pairs.
   - Good Q1 answer: "Last Tuesday at 9pm I spent 40 minutes copying numbers from 3 spreadsheets into a deck for the board. I called my CFO and she did it for me."
   - Bad Q1 answer: "Yeah, I usually struggle with reporting."
8. **What to do after**:
   - Score each interview 1-10 on the pain intensity (Q4 + emotional language flags)
   - If 7+ scores in 10 interviews, the problem is validated. Move to the Validated Problem Statement (Module 1.3).
   - If <5 scores in 10 interviews, the problem isn't strong enough. Re-evaluate; consider pivoting.

**Internal links**: at least one to a JT post on customer research / founder discovery, plus one to the upcoming Module 1.3 post (forward link).

**Length expectation**: 1200-1800 words.

---

## Distinct anecdote anchors (avoid duplicating)

Already used in the corpus:
- $62K MVP / Stripe behind feature flag (Friday demo template)
- $180K B2B fintech / GitHub org locked (ownership checklist)
- $95K marketplace / 38K LOC Rails (salvage decision tree)
- $34K AI agency / secrets in database.yml (AI 5-questions)
- $78K SaaS / 4-of-5 milestones on broken staging (SOW reading guide)
- $51K refactoring / 14 months nodding (Five Tech Words post)
- $44K/month team-of-4 (Org Chart post)
- $25K/month, 47 standups (Three Questions post)

Sprint 1 artifacts must introduce 3 NEW anecdotes. Avoid the dollar anchors above. Avoid the technical mechanisms above (no more "GitHub org locked," no more "database.yml secrets," no more "feature flag broken").

Suggested fresh anchor angles (pick any, vary):
- A founder who paid $1,500 for a Survey Monkey "validation" that taught her nothing
- A solo founder who DM'd 47 Twitter strangers and got 12 honest no's
- An ex-PM who spent 6 weeks on Reddit r/SaaS reading posts before writing one comment
- A founder who used UserInterviews + paid $1,200 for 8 interviews + closed her first 3 customers from the interview pool
