<!-- A4 print: 210x297mm, 20mm margins. Renders as pages in any markdown-to-PDF path. -->
<style>
@page { size: A4 portrait; margin: 20mm; }
@media print { .pagebreak { page-break-after: always; } body { font-size: 10.5pt; line-height: 1.45; } pre { font-size: 8.5pt; } }
</style>

# ADR-0009: Freeing founder hours — what the AI setup does, and what it must never do

- **Status:** Proposed — written to be attacked, not approved
- **Date:** 2026-08-29
- **Deciders:** Paul Keen (owner)
- **Relationship to ADR-0008:** does **not** supersede it. ADR-0008 is **held as a sandbox** at Paul's instruction (2026-08-29), unruled and not to be run. This ADR is a separate decision about the AI setup itself.

---

## Context

### The stage

**JetThoughts is in the planning stage, deliberately.** No plan is agreed and none has the owner's confidence; execution starts when he says it starts. Zero sends and zero conversations are the correct state for this stage, not a defect. Closed as `planning-stage-not-execution-failure` in `.ai/state/decision_log.json`.

### The business, measured

| | |
|---|---|
| Revenue | **$18,400/mo** — Crosslake $12,000 ($75/h, re-confirmed active by the founder 2026-08-09) + Framework.fm $6,400 ($40/h) |
| Profit | $5,440/mo — Crosslake $4,800 (40% margin), Framework.fm $640 (10%) |
| Annualised | **$220,800/yr revenue, $65,280/yr profit** |
| Capacity | **Access, not payroll.** Developers are available at **$0 until placed** — a third slot is open now — from the supplier network and freelancer database Paul can call. They are capacity, not employees or a bench he carries. |
| Operations | **Paul's alone, and not delegable.** The developers deliver; none of them runs the operation. |
| Headcount | One person. |

Source: `areas-northstar-business-reboot-goal.md`, `case-studies-crosslake-technology-case-study.md`, decision `jt-is-one-person`.

**Corrected twice on 2026-08-29, and the second correction is the one that matters.** A first draft read *"Dev 3 available, costs $0 until placed"*; I then struck it as superseded by `jt-is-one-person`. That was wrong. `jt-is-one-person` fixes the **employee count** — it exists because a partner-network form required ten employees — and says nothing about **access**. Both hold: JetThoughts has no payroll and no carried bench, *and* Paul can place a developer at zero standing cost. Access is an asset; payroll would be a liability.

**The constraint that follows is the load-bearing one for this ADR:** operational responsibility is Paul's alone and cannot be handed to the developers. They absorb *delivery* load; they cannot absorb *operations* load. So contractors are not an alternative lever on the hours this ADR is about — which removes the most obvious objection to it, and correspondingly raises the cost of being wrong about K1.

### The goal

**A new service idea**, developed from zero but with the firm's history and credibility as assets. Outstaffing is overcrowded, and prior strategy work ignored that. Longer horizon: $1M/yr.

**The $1M arithmetic, which existed in no document before this one** (gap G7): $220,800 → $1,000,000 is **4.53x**, or $83,333/mo. At Crosslake's economics ($12k/mo, 40% margin) that is ~7 Crosslake-sized accounts and ~$400k/yr profit. At Framework.fm's economics (10%) the same revenue yields ~$100k — so *which* accounts are added decides whether $1M is worth reaching.

### The evidence base

Six independent research lanes, 2026-08-29, each required to argue against its own conclusion. All in `~/Documents/pkm/.ai/evidence/`:

`2026-08-29-os-gap-audit.md` · `2026-08-29-vault-archaeology.md` · `2026-08-29-external-ai-operations-reference.md` · `2026-08-29-business-operating-process.md` · `2026-08-29-harness-encoding.md` · `2026-08-29-notebooklm-deep-research.md` · `2026-08-29-ai-executive-tool-landscape.md`

### What the evidence establishes

1. **Only two independently verified cases exist of AI agents producing money** — JPMorgan COiN (~$150M/yr, 360k lawyer-hours removed) and ambient clinical scribes (112% ROI, Stanford AI Index). Every other large figure found is vendor marketing by the tool seller. Both wins share one shape: **verified hours removed from a costly workflow, with hard output checks.** Not content production.
2. **The null results are stronger than the wins.** MIT NANDA: 95% of 300 enterprise GenAI pilots produced zero P&L impact. RAND: >80% project failure. METR: experienced developers **19% slower** with AI while believing they were faster.
3. **Founders close ~94% of contracts at this stage.** Cold outbound with no aged domain runs a 40–60% deliverability deficit; *"SDR-first at seed is the most common way $2–3M gets set on fire."*
4. **79% of multi-agent failures are specification and coordination**, not model capability (MAST, 1,600 annotated traces: 41.8% spec, 36.9% inter-agent, 21.3% verification).
5. **Same-model review is near-worthless.** Two heterogeneous reviewers overlapped on 6.6% of findings — 93.4% were caught by exactly one.
6. **Human-approval gates have no effectiveness evidence anywhere.** Every source gives a compliance rationale; none an outcome. Rubber-stamping is documented (Avianca's signer approved because the citations *looked* real).
7. **Only 3 of ~20 surveyed AI-executive systems run anything in the background.** The diagnostic that held every time: **look for the file that names a clock.** No clock file, no background.

<div class="pagebreak"></div>

## Decision

**The AI setup removes verified hours from delivery, research, planning, coordination and critique, so that the owner's hours land on the ~94% only he can do. It does not run growth, and it never acts outward.**

Five parts follow. Each is stated so it can be falsified.

### 1. The allocation

| The machine owns | The owner owns |
|---|---|
| Research, synthesis, and the evidence behind every claim | Sales conversations — the 94%, non-delegable |
| Sourcing, qualification, drafting | Price, terms, availability, appetite |
| Delivery scaffolding, SOW, runbooks, coordination | Any outward act: send, register, publish, spend |
| Critique — adversarial review of the machine's own output | The go/no-go: when planning ends and execution starts |
| Keeping state current in the same breath as the work | Which service idea is worth pursuing |

**The binding constraint this assumes:** founder hours. It is **untested** — founder-hours have never been measured here, and `bin/status-block` still prints *"Founder-hours: not measured, no data source."* That is the first thing this ADR obliges the setup to fix, and the honest place it could be wrong.

### 2. The encoding standard — five slots

A process stage is encoded only when all five are filled. **If Trigger is empty the stage runs zero times regardless of the other four** — the one-sentence explanation of *15 operating systems defined here, one run once*.

| Slot | Question | Carrier |
|---|---|---|
| **Carrier** | who executes it? | script · skill via explicit imperative · subagent spawned by the skill · human (surfaced, never encoded) |
| **Trigger** | what fires it without anyone remembering? | launchd/cron · git hook · Claude Code hook · an ambient mechanism naming a command |
| **State** | what does it read and write? | one JSON file or frontmatter field, dated, read by ≥1 script |
| **Enforcement** | what rejects a violation? | pre-commit block, PreToolUse exit 2, schema check. **An agent prompt does not count.** |
| **Proof** | how does a cold session know it ran? | a dated state transition it writes itself, plus an expiry branch that fires when it *didn't* |

Trigger reliability, measured here and externally: **launchd/cron** (the only thing that fires during silence) > **git hooks** (fire on Tolaria's auto-commit; the pre-commit schema gate has zero violations, the only rule class here with none) > **Claude Code hooks** > **AGENTS.md imperatives** (fire, but probabilistic) > **skill descriptions (4/10 — not a trigger).**

`bin/vault-health --alerts` gains a check: **an active Operation with no named trigger**, which converts the master failure from a retrospective finding into a per-commit alarm.

### 3. Read-mostly loops

**A clock may fire preparation and surfacing. It may never fire an act.** Since no outward act ships without explicit per-instance approval, a scheduled loop can only produce reading material — so headless runs carry no risk they did not already carry.

Two to three loops maximum. **Kill criterion, from the survey's graveyard:** any loop whose output goes unread two consecutive weeks, or whose upkeep exceeds 1 of the 15 daily minutes, is deleted. A chief-of-staff repo superseded in 4 months and rebuilt *smaller*, crewAI-examples archived, Clira stalled — all died of machinery exceeding attention.

### 4. The gate, designed against rubber-stamping

Because approval gates have no effectiveness evidence and rubber-stamping is the documented failure, the gate is designed for **legibility, not volume**:

- Every item reaches the owner as an **evidence pack** — proposed act, reasoning, sources, outcome preview — sized for a 10–30 second decision.
- **Escalation budget 10–15%.** Above it, the setup is misrouting, and that becomes the week's issue rather than more items to approve.
- **Author ≠ verifier, always**, and verifiers get **distinct lenses** — not N copies, which return correlated blind spots.
- The one mechanism with a demonstrated catch here is **opening the cited source**. On 2026-08-29 NotebookLM attached mismatched citations to two plausible numbers while asserting everything was grounded; reading the cited passages caught it. That is `exec-fact-verifier`'s job and it is now the setup's primary verification act.

### 5. The evidence ladder

Every claim carries a level. Orthogonal to the existing five-rung ladder, which grades the *cost of an answer*; this grades its *strength*.

| Level | Evidence |
|---|---|
| 0 | AI-generated idea or market report — a research lead only |
| 1 | Desk research, complaints, reviews, keyword trends |
| 2 | Several target users describe the same recent pain unprompted |
| 3 | Users share artifacts, data, access, or introduce the buyer |
| 4 | A defined pilot agreed, or time on the calendar |
| 5 | Deposit, pre-order, signed pilot, payment |
| 6 | Repeated use and retention after novelty |

**Nothing above Level 1 exists today for any new service idea.** Reaching Levels 3–5 precedes serious build.

<div class="pagebreak"></div>

### 6. Who — the seats, and the minimum panel

Seats are lenses, not people. **No two seats are held by the same agent on one decision**, and author never verifies.

| Seat | Agent | Owns | Fails when |
|---|---|---|---|
| Proposer | `exec-proposer` | one move, its evidence, its kill criterion | it argues for the move instead of stating it |
| Challenger | `exec-challenger` | the strongest attack on that move | it returns "looks good" |
| Fact-verifier | `exec-fact-verifier` | opening the primary source and reading it | it accepts a citation without opening it |
| Sourcer | `exec-sourcer` | verified rows, counted demand | it returns a directory instead of qualified rows |
| Teardown | `exec-teardown` | what comparables actually do, verbatim | it paraphrases |
| Customer | `exec-customer` | behavioural questions to real buyers | it asks about intent instead of what already happened |
| Allocation | `exec-ceo` | where the next 15 minutes and any money go | it returns a ranked list with no decision |

**Panel size scales to the cost of being wrong:** a queued draft needs proposer + challenger. Anything irreversible or paid needs all four core seats, with the challenger filled three times over on distinct lenses. A vote needs **≥3 voters with distinct source sets** — enforced by `bin/verify-sprint-round`, not by this paragraph.

### 7. How many — every number this process uses

Each carries its source and its strength. **Grounded** = an outside source says it. **Adopted** = chosen here, defensible but not inherited. Confusing the two is how ADR-0008 acquired an invented n>=3 provenance.

| Quantity | Value | Source | Strength |
|---|---|---|---|
| Lightning Demo companies | 5-7 | Design Sprint 2.0 | grounded |
| Voters per round | >=3, distinct sources | `op-cross-verified-decisions` r2 | adopted |
| Dots per voter | 3, max 2 on one item | Note-and-Vote | grounded |
| Solutions per winning mechanism | 2-3 | Opportunity Solution Tree | grounded |
| Experiments in flight | max 3, 2 weeks each | jt-sprint | adopted |
| Personalised messages per batch | <=30 | personalisation capacity ceiling | grounded |
| Reply-rate bands | <5% stop · 5-10% iterate one variable · >10% accelerate | JT's own course | grounded |
| Discovery conversations per iteration | 8-12, one segment at a time | validation literature | grounded |
| Continue threshold | >=5 of 10 describe the same *recent* pain unprompted | validation literature | grounded |
| Strong-relevance threshold | 3 people give an artifact, data, access, or a buyer intro | evidence ladder L3 | grounded |
| Qualified conversations/week | 2 | services-firm scorecard | grounded |
| Founder sales hours/week | 2-3 | no path to $1M is documented below this | grounded |
| Escalations reaching Paul | 10-15% of queued items | approval-fatigue research | grounded |
| Paul-minutes/day | 15, excluding sales calls | Paul | fixed |
| Scheduled loops | 2 now, 3 at execution | derived in §3 | adopted |
| Accounts needed for $1M | ~7 at Crosslake economics | arithmetic, §Context | derived |

**The one number that is not a target: qualified conversations currently reads 0**, by design in the planning stage.

### 8. The process, end to end

**Now — planning. Four steps, no others.**

1. **Generate** — four source lanes in parallel, distinct sources each: own book (20-30 past engagements, never read), posted demand, buyer behaviour, Lightning Demos. Biased away from anything needing an audience, because none exists.
2. **Score** — [[firm-fit-scorecard]]. Four vetoes fire independent of the total. A survivor must beat outstaffing on the three demand rows: access, avoided activities, path to first ten.
3. **Validate** — to evidence Level 3-5 before any build. Nothing above Level 1 exists today.
4. **Go/no-go** — Paul's alone.

**Later — execution. Seven stages**, each with an owner and a gate: Demand → Qualify → **Diagnose (Paul, non-delegable)** → Paid pilot (deposit before work) → Delivery (weekly written artifact) → Collect → Retain. Running these now is what produced outreach with no service behind it.

### 9. What must be settled for Claude Code to follow this

The harness contract. Every row is a filled slot; an empty Trigger means the stage runs zero times.

| What | Settled as | Enforced by |
|---|---|---|
| How a skill is reached | deterministic routing, not description-matching (measured 4/10) | `.claude/hooks/skill-activation.py` + `skill-rules.json`, UserPromptSubmit |
| Which loops run unattended | 2: every-commit, and Sunday 10:00 | git hook + launchd |
| What a clock may do | prepare and surface only — **never act outward** | no agent holds send/spend/account permission |
| The one number | `conversations:` in the weekly note | `bin/status-block`, `bin/eos-scorecard`, every commit |
| Vote validity | >=3 voters, distinct sources, dissent each, 3 dots max 2 | `bin/verify-sprint-round` — refuses to tally, prints nothing |
| Schema drift | rejected at the moment it is introduced | `bin/validate-frontmatter`, pre-commit |
| Overdue anything | spoken on every commit and every Sunday | `bin/vault-health --alerts` |
| Closed decisions | never re-opened without new contradicting evidence | `.ai/state/decision_log.json`, read third on every orientation |
| EOS cadence | 17 `ceos-*` skills, state at `.ai/eos/data/` | scorecard generated from the weekly note, one source |
| Agent-only vs Paul-facing | `.ai/` vs typed vault notes | the placement test in `AGENTS.md` |

**Still unfilled, and named rather than hidden:** `bin/vault-health` does not yet check for *an active Operation with no named trigger* — the check that would turn "15 systems defined, one run" into a per-commit alarm. And `founder_hours:` has no field and no reader, which is what K1 depends on.

## What this ADR deliberately does not decide

- **Which service to offer.** That is Paul's, informed by discovery the setup runs.
- **Whether the outstaffing motion is in or out of scope.** The harness is offer-agnostic on purpose.
- **When execution starts.** The go/no-go is Paul's alone.
- **ADR-0008's fate.** Held as a sandbox, unruled.

## Consequences

**Accepted:** the setup will feel slower than an autonomous one, because nothing outward moves without the owner. It buys back delivery, research and coordination hours instead — which is where the only two verified AI wins came from.

**Rejected, with reasons:** an advisory C-suite persona (8 roles for a one-person firm; the vault already closed `c-level-skills` and `founding-exec-team`); autonomous outbound (94% founder close rate; deliverability deficit); more skills (522 installed, firing measured at 4/10 — supply is not the constraint); a web-service harness (recorded decision: no agent infrastructure build until a client has paid).

## Kill criteria — each with a date and a reader

| # | Criterion | Checked |
|---|---|---|
| K1 | Founder-hours measured for 4 consecutive weeks show delivery/research/coordination was **not** the majority of non-sales time ⇒ the allocation principle is wrong and this ADR is withdrawn | 2026-09-26 |
| K2 | Any scheduled loop's output unread 2 consecutive weeks ⇒ that loop is deleted | every sitting |
| K3 | Escalations to Paul exceed 15% of queued items for 2 consecutive weeks ⇒ the gate is misrouting; fix routing, not the owner | every sitting |
| K4 | `conversations:` and `founder_hours:` still absent from the weekly note ⇒ the setup cannot see itself and is not operating | 2026-09-12 |
| K5 | Harness upkeep exceeds 1 of the 15 daily minutes ⇒ cut the harness, not the minutes | 2026-09-26 |

K1 is the load-bearing one: it can retire the whole ADR.

## Open questions, stated rather than hidden

1. **Founder hours are unmeasured.** The entire principle rests on an untested claim. K1 tests it.
2. **The lanes disagree on client concentration.** One reports ≥35% as failure likelihood (Baker benchmark); NotebookLM found **no grounded source** for a concentration collapse, and none for bench-as-failure. Unresolved; not picked.
3. **Method limit.** NotebookLM deep research ran **once** (the sales block, 70 sources) before Google quota blocked it; four blocks ran fast mode on ~10 sources each. A re-run could overturn the thin claims.
4. **EOS with agents as the leadership seats is untested.** Published EOS assumes a human leadership team; running L10 with agents in the seats is Paul's reframe and is an experiment, not a finding.

## What would make me withdraw this

If removing hours from delivery does not free founder hours — because the hours were never the constraint — then the principle is wrong and the answer is a different business shape, not a better harness. K1 is that test, and it is dated.
