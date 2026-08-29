# ADR-0008: The operating process for JetThoughts

- **Status:** Proposed
- **Date:** 2026-08-29
- **Deciders:** Paul Keen (owner). Drafted by agent, adversarially reviewed before acceptance.
- **Supersedes:** the undocumented "Orient → Count → Qualify → Draft → Gate → Record" loop asserted 2026-08-29 without derivation.

## Context

JetThoughts: one person, contractor delivery, $18,400/mo billings from 2 accounts, flat 4 years, **0 new-business conversations in 2026**. Goal: one paid income route by 2026-10-09; $1M longer horizon. Founder capacity for non-delivery work: ~15 min/day.

Two operating loops and a growth playbook were built on 2026-08-28/29 by assertion — copied shapes, no comparison of alternatives, no sources. The owner rejected this as *"finger in the sky, cargo cult"* and required an ADR with evidence. Three independent research lenses were run (files in `~/Documents/pkm/.jt-venture/evidence/2026-08-29-research-*.md`), each required to argue against its own conclusion.

## Decision

**Adopt no operating system, no strategy process, and no autonomous agent operations. Adopt one weekly list with a lead measure, a five-stage agent pipeline that ends at the owner, and a narrow position.**

**1. The operating layer — a weekly list, one lead measure.**
The scoreboard's first line is `new-business conversations this week: N / target M`. Steal 4DX's lead-vs-lag distinction and nothing else. Optionally a stripped 12 Week Year (~30 min/week) because a 6-week goal is half a cycle.

**2. The strategy layer — none until conversations exist.**
No SWOT, no market analysis pass, no strategy document while the conversation count is 0. The only instrument due is customer contact. Positioning is narrow-by-default and revised from conversations, not from analysis.

**3. The agent layer — SOURCE → QUALIFY → DRAFT → VERIFY → DECIDE+ACT.**
Agents may decide alone only on read-only or reversible work checkable against a written spec. Author and verifier are always different agents. Nothing outward-facing auto-sends. **Per-artifact explicit approval; the 48-hour silence-equals-yes timer is abolished** for anything leaving the vault. Queue capped at single-digit artifacts/day.

**4. The tool layer — ~$100-200/mo ceiling, and only when a stage is proven manually first.** Apollo.io Basic $59/mo and LinkedIn Sales Navigator ~$99/mo are the candidates. Clay ($185/mo) only if weekly enrichment waterfalls actually run. Skip 6sense, Demandbase, Common Room, UserGems as enterprise-only.

## Alternatives considered, and why rejected

| Alternative | Rejected because | Source |
| --- | --- | --- |
| **EOS / Traction** | Its own implementers: *"if you are a solopreneur… EOS is not right for you"*. Floor is a 3-7 person leadership team | res-operating-systems |
| **OKR** | Floor 10-15 people; *"first-time introductions are a disaster"*; Spotify dropped individual OKRs | same |
| **Scaling Up** | Daily huddle + monthly half-day exceeds the entire 15-min/day budget alone | same |
| **Hoshin Kanri** | lean.org: *"overburden, possibly overkill"* at 20 people; catchball requires layers that do not exist | same |
| **SWOT now** | Hill & Westbrook (Long Range Planning, 1997), 50 firms: 40+ unverified unprioritised factors, *"no-one subsequently used the outputs."* At 0 conversations every cell is self-assessment | res-strategy-processes |
| **A strategy document now** | Rumelt's kernel cannot start without facts — a diagnosis with none produces the goals-dressed-as-strategy he calls bad strategy. Martin: *"planning produces comfort, not strategy"*. Blank: *"there are no facts inside your building"* | same |
| **Blue Ocean as method** | Constructive claims are survivorship-biased (Rosenzweig). Porter retained only as a veto: do not enter as a commodity player | same |
| **Autonomous agent operations** | TheAgentCompany (CMU, NeurIPS 2025): best frontier agent completes **30.3%** of company tasks, admin/finance near 0%. Agent PRs: each reviewer comment *lowers* merge odds by 2.8% while raising human-PR odds — agents fail negotiation, and selling is negotiation | res-agent-operations |
| **The 48h silence-equals-yes gate** | No study validates timeout approval; every published gate guide specifies deny-on-silence. HBS 2024: +19pp deference to AI; expert radiologists 82% → 45.5% under wrong AI advice | same |
| **Scaling agent volume** | Bottleneck relocation is measured: Faros (10k devs) +98% PRs but +91% review time, +154% PR size, +9% bugs. A solo firm has one reviewer | same |
| **No system at all** (the honest default) | Retained in part — this ADR is closer to it than to any framework. Rejected only in that one lead measure is cheaper than the 4 years of flat lag it would have surfaced in week 1 | res-operating-systems |

## Consequences

- Most of the process built on 2026-08-28/29 is retired: the growth playbook's stage-gated instrument map survives only as a "when NOT to" reference; `eos-lite` is never adopted; the sprint/strategy machinery idles until conversations exist.
- **The 48h veto is abolished for outward-facing acts.** Every send needs an explicit yes. This slows things and is the point.
- Agents' honest job: make ~5 owner conversations a week better-prepared. Not 50 automated ones.
- The owner's reading hours become the declared pipeline ceiling. No amount of agent throughput raises it.


## Amendment 1 (2026-08-29) — the discovery engine, and where tools actually sit

Paul, on reading the ADR: *"I do not see any way how you would find the actual pain points, new opportunities, which will be used for generating the Hypothesis Summary which will be tested"* — and separately, that Apollo/Sales Navigator/Clay *"are for lead generation, after you generated idea, build Hypothesis and then run validation and try to find leads."*

Both correct, and the same defect: **the ADR specified guardrails and never specified the engine.** Measured: the words hypothesis, pain, discovery and learn appeared **zero times** in the original text. It said what not to run and who approves; it did not say how the business learns or generates a testable bet.

**The engine already exists in the vault and the ADR failed to reference it:** `_templates-sop-opportunity-validation-framework.md` — Foundation Sprint → ICE triage → SCIPAB → 10-Conversation Sprint → Minimum Viable Assets → HADI experiment → Go/No-Go. Nothing new is written here; two corrections are made to it.

### The loop, and where JT enters it

```
TALK → CODE → PATTERN → HYPOTHESIS SUMMARY → VALIDATE → LEAD-GEN → SELL
```

| Stage | What it produces | Rule |
| --- | --- | --- |
| **TALK** | verbatim conversation notes, Mom Test discipline: ask about behaviour that already happened, never future intent | Torres: *"at a minimum, weekly touchpoints"* — discovery is a habit, not a phase |
| **CODE** | each conversation coded into named pains, in the buyer's words | a paraphrase is not evidence; verbatim or it did not happen |
| **PATTERN** | a pain register with a count per pain | **n=1 is a candidate, n≥3 independent is a pattern.** The vault's own standing bar |
| **HYPOTHESIS SUMMARY** | one page per candidate offer, format below | no summary, no experiment |
| **VALIDATE** | the cheapest instrument that could falsify it | HADI, 14 days, per the SOP's Step 5 |
| **LEAD-GEN** | a list of named accounts for a *validated* offer | **this is where Apollo/Sales Navigator/Clay enter, and not before** |
| **SELL** | owner conversations | owner only, always |

**Correction 1 — JT enters at TALK, not at Foundation Sprint.** The SOP's Steps 0-2 (Foundation Sprint, ICE triage, SCIPAB) exist to choose *among* candidate opportunities. That is a problem you have when several validated candidates compete. At 0 conversations there is nothing to triage, and per the research (Blank: *"there are no facts inside your building"*; Rumelt: a diagnosis without facts produces bad strategy) those steps are premature. **Enter at Step 3, the 10-conversation sprint.** Steps 0-2 become due once two or more patterns compete.

**Correction 2 — tools are a LEAD-GEN stage cost, not a standing layer.** The original text listed Apollo ($59/mo), Sales Navigator (~$99/mo) and Clay ($185/mo) as "the tool layer" with no position in the sequence. They buy *reach to named accounts for a known offer*. Bought earlier they are a list for an unknown offer. **Nothing is subscribed until a Hypothesis Summary has passed VALIDATE.** Until then, lead sourcing is manual and free.

### The Hypothesis Summary — the artifact, its required fields

One page, in `.ai/evidence/` while forming, refactored into the note that owns the offer once it survives.

| Field | Content |
| --- | --- |
| **Pain** | the pain in buyers' verbatim words, with **n** and the sources |
| **Who** | the segment that has it, specifically enough to build a list from |
| **Chequebook** | who holds the budget, and evidence the pain lands on *them* |
| **Forcing party + date** | who compels the spend and when. **No forcing party → no experiment**, whatever the score |
| **The bet** | "If we offer [X] to [segment], [metric] moves by [amount]" |
| **What we would sell** | unit, price, scope boundary |
| **Why us, not the incumbent** | the structural reason they cannot copy it |
| **Falsifier** | the single observation that would prove this wrong |
| **Cheapest test** | the instrument, its cost in money and founder-minutes, its dates |
| **Kill** | the number and the date that retires it |

A Hypothesis Summary missing **Forcing party**, **Falsifier** or **Kill** is rejected at the challenger gate, same as any other recommendation.

### Applied to JT today

The five discovery messages are the TALK stage — pain research, not selling. They also carry the wedge's kill test. **JT currently has n=13 pain evidence for one adjacent buyer (Toptal's end clients) and n=0 for its actual buyer, the agency.** That is why no Hypothesis Summary exists yet and why buying a lead-gen tool now would be premature by two full stages.


## Amendment 2 (2026-08-29) — Amendment 1 had the loop backwards

Paul: *"'ask about behaviour that already happened' — with whom? about what? you need hypothesis first."* And: *"have you checked `~/dev/jetthoughts.github.io/content/course/`?"*

Both land. **Amendment 1 started the loop at TALK. That is impossible**: a Mom Test interview needs a subject — whom to interview and which problem to ask about — and only a hypothesis supplies it. Talking without one produces unfocused anecdotes, which is the "polite nods" failure the discipline exists to prevent.

**And the canonical process was already published by JetThoughts itself.** `content/course/tech-for-non-technical-founders-2026` is a five-module course whose entire subject is zero to first paying customer. Neither ADR-0008 nor Amendment 1 referenced it. External frameworks were researched while our own published method sat unread — the same defect as Amendment 1's failure to reference the vault SOP, one level up.

### The corrected loop

```
FOUNDING HYPOTHESIS → SMOKE TEST → 10 MOM TEST INTERVIEWS → CODE → REVISE OR KILL → (repeat)
                                                                    ↓ survives
                                                        OFFER → LEAD-GEN → SELL
```

**It starts with a hypothesis written from what you already know** — 90 minutes, not research. Course Lesson 1.1, using the Founding Hypothesis frame from Knapp and Zeratsky's *Click* (2025):

> *"If we help **[CUSTOMER]** solve **[PROBLEM]** with **[APPROACH]**, they'll choose it over **[COMPETITION]** because **[DIFFERENTIATION]**."*

Five blanks, one sentence, and **each blank is an assumption with a designated test:**

| Blank | Where it gets tested |
| --- | --- |
| `[CUSTOMER]` + `[PROBLEM]` | strangers recognise themselves in the headline; then ten Mom Test interviews confirm the pain |
| `[APPROACH]` | a clickable prototype in front of 5 interviewees |
| `[COMPETITION]` + `[DIFFERENTIATION]` | ~300 cold strangers convert on the page, or do not |
| the whole bet: will they pay | the Stripe price test |

**Specificity is the whole discipline.** *"We help small businesses save time with automation"* cannot be argued with and cannot be validated. *"Solo chiropractors, insurance-claim resubmission, one-click resubmit, versus billing services that take 14 days and charge 8%"* gets either *"I dealt with this last Tuesday"* or *"not my problem."* Both are useful.

**The hypothesis is kept private during interviews.** Pitching it contaminates the answers. This retroactively confirms the standing instruction that the five discovery messages must not mention the entry wedge.

### What this corrects in Amendment 1

- **"Enter at TALK, not Foundation Sprint" was wrong** and is withdrawn. Something hypothesis-shaped must exist first. The Foundation Sprint objection was that it is a *strategy* instrument requiring facts JT lacks; the 90-minute Founding Hypothesis is not that — it is an explicit bet written from existing knowledge precisely so it can be proven wrong cheaply.
- **The Hypothesis Summary's ten fields are demoted to a later artifact.** They describe a hypothesis that has already survived interviews and is heading for an offer. The *entry* artifact is one sentence with five blanks. Requiring ten fields before the first conversation is the overhead failure this ADR was written to avoid.
- **What Amendment 1 got right and stands:** lead-gen tools are a stage cost, not a layer; nothing is subscribed until a hypothesis has survived; n>=3 independent instances make a pattern.

### The canonical sequence, and where JT actually is

The course is the process of record for zero-to-first-customer. Read it before designing anything new.

**JT has never written a Founding Hypothesis.** Two years of positioning notes, an offer, a rate card and five drafted messages exist — and not one sentence naming customer, problem, approach, competition and differentiation in testable form. **That, not more research, is the missing first artifact**, and it costs 90 minutes.


## Amendment 3 (2026-08-29) — the loop had no way to find a NEW opportunity

Adversarial review of Amendment 1 (`.ai/evidence/2026-08-29-adr0008-amendment-challenge.md`), by an agent that did not write it. **PARTLY REFUTED**, with one objection that answers the half of Paul's question the earlier amendments quoted and dodged.

**The proof, and it is clean:** the `n=13` pain evidence the amendment itself cites came from **review mining** — a desk stage with zero conversations that appears nowhere in TALK → CODE → PATTERN. **The loop cannot reproduce its own cited evidence.** It only refines the bet already chosen, and the segment it talks to was chosen by the `days-open` screen that was later proven inverted. Circular.

### Fix: PATTERN has two inputs, not one

```
TALK (conversations, strong)  ──┐
                                ├──→ PATTERN → HYPOTHESIS revision
DESK (review mining, forum      ──┘
      and complaint scraping,
      competitor teardowns,
      demand counts — weaker)
```

**Desk discovery is a legitimate first-class input, flagged weaker.** It cannot establish willingness to pay and never promotes a hypothesis on its own, but it is how a *rival* pain — one nobody is currently asking about — enters the system at all. It costs agent-minutes, not founder-minutes, which is why it can run continuously while founder attention stays on conversations.

**Re-trigger condition corrected.** Steps 0-2 of the SOP (choose what to validate) fire on **"TALK returns empty OR a rival pain appears from any source"**, not on the earlier "two or more patterns compete" — which was circular, since only TALK could fire it and TALK only reached the already-chosen segment.

### Two further corrections from the same review

**`n>=3` was invented provenance.** Amendment 1 called it *"the vault's own standing bar"*. Grepped: no such written rule exists in the decision log, AGENTS.md, jt-business-os or the opportunity-testing note. Practice echoes it (review mining flagged a 3-complaint convergence; scouts triangulate in threes) but the bar is **adopted here, not inherited**. Number kept, attribution corrected — a false citation is precisely the cargo cult this ADR exists to stop.

**Correction 1's rationale mischaracterised the SOP.** Step 0's own header reads *"choose what to validate. Skip this and you validate whatever idea you happened to have first."* It is not an arbiter among already-validated candidates, as Amendment 1 claimed. Amendment 2 already withdrew "enter at TALK" on separate grounds; this records that the stated reason was also wrong. What survives is narrower: **for the current wedge only**, the five drafted messages are near-free re-qualification and go first.

**Hypothesis Summary compresses from ten fields to seven** — Falsifier, Kill and Cheapest-test are three names for one thing; Bet and What-we-sell duplicate.

### What survived the attack

**The lead-gen tool timing holds, and is possibly still too generous.** TALK needs no subscription — contacts are public and sourcing costs agent-minutes. Apollo and Sales Navigator exist to enable cold volume, which house rule 6 forbids at any stage. Paul's original correction stands unweakened.

## Kill criteria

- **2026-10-09:** if conversations remain 0, the constraint was never process — it is the owner's willingness or ability to hold sales conversations, and that is the only thing worth working on.
- **This ADR is falsified by:** an RCT showing net positive throughput from autonomous outbound at small scale, or a buyer-side study showing AI-led B2B consulting deals closing at human rates. Neither existed as of 2026-08.
- **Review:** 2026-09-25 alongside the existing kill date.
