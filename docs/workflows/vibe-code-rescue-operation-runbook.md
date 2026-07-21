# Vibe Code Rescue — Operation Runbook

**Owner**: Paul Keen (CEO) | **Created**: 2026-07-21 | **Goal**: 1 signed rescue client by Nov 30, 2026
**Parent strategy**: [`2026-autumn-client-acquisition-strategy.md`](2026-autumn-client-acquisition-strategy.md) · **OS**: [`operating-system.md`](operating-system.md)
**How to read this**: this file IS the shared state across separate sessions. A session reads
[`BASE_HANDBOOK.md`](BASE_HANDBOOK.md) + [`flow-router.md`](flow-router.md), opens this runbook, takes the next
`Ready` card, executes it, runs its cold-eyes gate, marks it `Done`, writes the handoff note (with the
critic's verdict pasted VERBATIM), and sets the next card `Ready`.

---

## ▶ START HERE (fresh session) — read this first, then act

**You can finish this operation in a new session with zero context loss. Do this:**

1. **Read order**: this START HERE block → the ACTIVE SPRINT state → the **Incremental agent backlog** table → the specific card/T-task you're taking. Optionally skim [`2026-autumn-client-acquisition-strategy.md`](2026-autumn-client-acquisition-strategy.md) (the why) and [`operating-system.md`](operating-system.md) (weekly cadence).
2. **Current state (2026-07-21)**: A0 (assumptions) ✓ · G0 (partner) ✓ · A2 offer draft ✓ · C0 kit draft ✓ · S0 spec ✓ · T1 taxonomy ✓ · T2 sourcing pipeline ✓. **Next Ready: T4, T5 (build the prospect list), T8 (discovery kit).**
3. **Take the next Ready task**, execute it end-to-end, run its LIGHT/HEAVY gate, paste the verdict, mark it Done, set the next Ready. **The agent does everything up to "hit send"** — sending + calls are Paul's (see Paul's desk).
4. **State lives in files, not memory.** Update this runbook (statuses + handoff notes) and the output file named on the task. That's what the next session reads.

**Artifact index — `docs/workflows/rescue-sprint/`:**
| File | What it is | Status |
|---|---|---|
| `assumptions-register.md` | A0 — ICP/trigger/channel/pre-validation brainstormed→voted→kill-criteria | ✓ done |
| `customer-profile-four-forces.md` | JTBD Customer Profile + Four Forces (push/pull/anxiety/habit) + find→channel→message map | ✓ done |
| `icp-trigger-taxonomy.md` | T1 — 8 ranked observable buying triggers + venue map (= the Push force) | ✓ done |
| `sourcing-pipeline.md` | T2 — per-trigger query recipes, lane split, verified venues, tool stack | ✓ done |
| `offer-one-pager.md` | A2 — the Vibe Code Rescue offer (free audit → fixed rescue) | draft; needs price confirm + booking link |
| `warm-intro-referral-kit.md` | C0 — target-list table + 3 outreach templates; **T3/T4/T5/T6 write rows here** | draft; list to be populated |
| `booking-page-spec.md` | S0 — Cal.com/NeetoCal setup (Paul, ~5 min) | spec ready |
| `outbound-openers.md` | T7 — per-target openers | not created yet |
| `discovery-kit.md` | T8 — call script + audit deliverable template | not created yet |
| `objection-followup-bank.md` | T9 — objections + follow-up sequence | not created yet |

---

## ▶ ACTIVE SPRINT — Rescue Demand Sprint (kicked off 2026-07-21) · HIGH PRIORITY

**Goal**: get Paul sending trusted intros with a *populated, evidenced* prospect list. G0 partner = Done. Scope = lean minimum.
**Primary bet**: warm intros + past-client referrals + agent-sourced cold-community rows + a wired booking link.
**Done + gated (2026-07-21)**: A0 assumptions register (brainstorm→vote→kill-criteria, devil's-advocate PASS) · A2/C0/S0 drafts (cold-eyes fixes applied) · T1 trigger taxonomy · T2 sourcing pipeline (2 teammate research reports folded in: Reddit-not-fetchable correction, verified HN/IndieHackers seeds, Lemkin proof-of-pain anchor, run-now-vs-needs-Paul tool stack).
**Next agent work (autonomous)**: T4 + T5 build the prospect list from fetchable venues (IndieHackers/HN/X/competitor threads; Reddit via excerpts only) → T6 dedupe/score → T7 openers. T8 discovery kit in parallel.
**Explicitly deferred this sprint**: B1 landing page, C1 LinkedIn, C3 SEO, C4 paid (per CEO "lean minimum only").
**Human-only steps left for Paul**: see **Paul's desk** below. Everything else is agent-doable and queued in the **Incremental agent backlog**.

---

## Paul's desk (HUMAN-ONLY — nothing else waits on Paul)

These are the only items that need Paul. Everything else an agent session does autonomously.

| # | Item | Why only Paul | Blocks |
|---|---|---|---|
| P1 | Create the booking page in his own Cal.com/NeetoCal account (~5 min; spec in `booking-page-spec.md`) | Needs his calendar + login | S0 gate; every `[BOOKING_LINK]` |
| P2 | Confirm the price band (default set: audit free, rescue from $25K) | Depends on partner margin only he knows | A2 final approval |
| P3 | Review the agent-built target list + openers, then **hit send** from his own inbox/LinkedIn | The intros go out under his name/relationship | C0 send |
| P4 | Take the discovery calls; run audits → proposals → close | The whole point; the human trust layer | D3 signing |

If a card handoff says "waiting on Paul" for anything NOT in this table, that's a mis-scope — the agent should have done it.

---

## Incremental agent backlog (T-tasks — one per session, no human needed)

A future session takes the next `Ready` T-task, does it end-to-end (research/draft/source/prep),
runs its LIGHT cold-eyes gate, writes the output to the named file, marks it `Done`, sets the next `Ready`.
These feed the C0/D1 cards without touching Paul's desk. Each is scoped to ≤1 session.

| T | Task | Output file | Status | Depends | Gate |
|---|---|---|---|---|---|
| T1 | **Trigger taxonomy** — run the trigger research first-hand (`web_search` on ICP rescue-pain signals; don't wait on any prior ghost agent report — if none is on disk, generate it), then synthesize a ranked list of *detectable* ICP buying triggers (e.g. "posted about a dev shop ghosting them", "asking r/startups if their MVP is salvageable", "hiring a first eng after an agency build") with the observable signal + where it shows up | `rescue-sprint/icp-trigger-taxonomy.md` | **Done** (2026-07-21 — 8 ranked triggers + venue map + competitor note; PASS w/ 2 carried constraints) | — (self-contained) | LIGHT — refute "is each trigger actually observable by us, or a guess?" |
| T2 | **Sourcing pipeline spec** — for each trigger: channel → exact search query/operator → validation rule → which template applies. Carries T1's 2 constraints (lane-split + trust/ownership differentiation) | `rescue-sprint/sourcing-pipeline.md` | **Done** (2026-07-21 — per-trigger query recipes + lane split + row schema; PASS w/ 2 carried constraints: weight reddit/IH site operators + read into threads; cap cold volume prefer warm) | T1 ✓ | LIGHT — refute "can a session run this query and get real people, not noise?" |
| T3 | **Warm-source pass (Gmail)** — with Paul's one-time consent, mine his mailbox for past clients / founders / investor-adjacent contacts near the ICP; output candidate warm rows (name, last touch, why-ICP, best path). No sending. | append to `rescue-sprint/warm-intro-referral-kit.md` target list | Blocked (optional — needs Paul Gmail consent; chain does NOT block on it) | T2 ✓ + P-consent | LIGHT — refute "is each row genuinely warm + near-ICP?" |
| T4 | **Cold-source pass A (web)** — run T2's `web_search` queries (weight `site:reddit.com`/`site:indiehackers.com`, read INTO threads for the original poster); collect founders publicly showing rescue pain; validate each against ICP; output candidate cold rows with the source link | same target list (Cold section) | **Ready** | T2 ✓ | LIGHT — refute "is this a real ICP founder in a buying moment, or off-target?" |
| T5 | **Cold-source pass B (Reddit/community)** — mine r/startups, r/SaaS, IndieHackers, no-code/vibe-coding communities for active salvage-pain threads; output rows + the exact thread to reply in | same target list (Cold section) | **Ready** | T2 ✓ | LIGHT — refute the ICP fit + that the thread is live/answerable |
| T6 | **Validate + score + dedupe** — merge sources into one ranked list (warm-first), drop dupes/dead, score by trigger strength; target ~30 usable rows | finalized target list | Blocked | T4 + T5 required; T3 folded in **if** Paul gave Gmail consent (chain does NOT hard-block on consent) | LIGHT — refute "would Paul recognize these as worth his time?" |
| T7 | **Per-target openers** — draft a personalized opener per row (right template: referral / warm-intro / forwardable / thread-reply), `[BOOKING_LINK]` placeholder, ready for Paul to review-and-send | `rescue-sprint/outbound-openers.md` | Blocked | T6, A2 | LIGHT (bulk/near-public → HEAVY if any becomes a mass template) |
| T8 | **Discovery kit** — call script + audit deliverable one-page template + 45-min agenda (Card D1 content), so Paul walks into calls with a script | `rescue-sprint/discovery-kit.md` | Ready | A2 draft | HEAVY — `reflexion-critique` + devil's-advocate; verbatim verdict |
| T9 | **Objection + FAQ + follow-up bank** — likely founder objections ("why not just re-hire the shop", "is $25K real"), answers, and a 3-touch no-reply follow-up sequence | `rescue-sprint/objection-followup-bank.md` | Blocked | T8 | LIGHT — refute "does each answer hold up to a skeptical burned founder?" |

**Next Ready T-tasks: T4, T5, T8** (independent — a session can take any). T1+T2 Done (2026-07-21). T4/T5 are the actual cold-sourcing runs → feed T6 dedupe → T7 openers. T3 (Gmail warm) is optional and waits only on Paul's consent. T8 (discovery kit) is parallel off A2.

---

## Operating rules (read before touching a card)

1. **Partner-lock (G0) is a BLOCKING GATE.** No public-selling or pricing card (A2 price, B*, C4, D*)
   may reach `Done` until G0 is `Done`. If the white-label partner is not real (signed + trial-delivered +
   named fallback), there is no offer and the operation is on hold.
2. **Human-path cards are the ones that count toward the goal.** G0, C0 (outbound), D3 (close) are
   Paul-led and sign the client. Content cards (C2/C3) are SUPPORT, never a substitute for pipeline.
   Do not ship a content sprint while a human-path card is stalled.
3. **Demand pulls assets.** Build the lead-magnet plumbing / SEO cluster only after a channel shows
   reply interest. Cheap reuse (offer page off `free-consultation`) is fine early; net-new plumbing is not.
4. **4-eyes, calibrated by reversibility** (every card has a gate; weight differs):
   - HEAVY (public / irreversible / expensive: published copy, landing, pricing, paid spend) →
     `reflexion-reflect` → blog-pipeline cold-eyes Agent-4 (or `.okf/workflows/review-swarm.md` for rendered),
     escalate `reflexion-critique` on pushback; plus `bin/test` + `bin/dtest` for template/CSS.
   - LIGHT (internal / reversible: ops docs, scorecard, pipeline, partner-list drafts, logistics) →
     one devil's-advocate critic Agent prompted to REFUTE.
   - A card is NOT `Done` until its gate returns PASS AND the verdict is pasted verbatim in the handoff.
5. **Status lifecycle**: `Blocked` → `Ready` → `In progress` → `Cold-eyes` → `Done`. A card is `Ready`
   only when its `depends-on` are all `Done`.
6. **One bundled PR per sprint** for any `themes/`/`layouts/`/`content` template change (per CLAUDE.md).
7. **Every card traces to a validated assumption (A0).** The foundational premises — WHO the ICP is, WHICH trigger leads, HOW we find them, HOW we pre-validate before a call — are brainstormed → voted → given a pre-validation test + kill-criteria in `rescue-sprint/assumptions-register.md`. Do not build a card on an un-registered assumption; if a card needs a new premise, add it to A0 (brainstorm + vote + kill-criteria) FIRST. The kill-criteria run automatically on the first cohort of calls/touches via OS-WEEKLY.

## Role-agents (persona a session adopts + skills it invokes)

| Role | Adopts / spawns | Skills / workflows |
|---|---|---|
| Partner-sourcing | Paul-led; agent drafts | criteria + vetting scorecard, trial-brief |
| Sales/Comms | session persona (Paul closes) | `copywriting`, `reflexion-critique`, linkedin-post-pipeline |
| Lead-gen | session persona | `linkedin-post-pipeline` + `linkedin-icp-validation-plan`, `agentic-humanizer` |
| Marketing/Content/SEO | `content-marketer` / `content-creator` agent | `blog`, `copywriting`, `writing-guidelines`, `social-media-trends-research`, `hugo` |
| Offer/Landing | `hugo-expert` persona | `docs/workflows/new-page.md`, `design-md`, `stitch-loop`, `cover-images`, `review-swarm` |
| Ops/Scorecard | session persona | `eos-lite` skill, `lark-okr` |
| Cold-eyes critic | `general-purpose` Agent | `reflexion-critique`, `review-swarm`, adversarial-refute prompt |

---

## GATE A0 — Foundational assumptions register  *(BLOCKING premise-gate · Paul reviews picks)*
- **role**: Ops/Strategy (agent-built; Paul reviews)
- **status**: Done (2026-07-21 — `rescue-sprint/assumptions-register.md`: ICP, lead trigger, find-channel, pre-validation each brainstormed → scored/voted → pick + pre-validation test + kill-criteria; devil's-advocate PASS as falsifiable bets)
- **depends-on**: —
- **definition-of-done**: every foundational premise a card leans on is registered with options, a vote, and a kill-criteria.
- **cold-eyes gate**: LIGHT — devil's-advocate refute "where is this still gut, not evidence?" (done inline; verdict in the file).
- **handoff note**: picks — ICP=non-technical burned founder (A1); lead trigger=ownership-hostage wedge + broke-at-scale volume (B2/B1); channel=warm primary + cold-community secondary, paid later (C1/C2); pre-validation=5-question intake checklist incl. repo-access gate (D3). Kill-criteria tied to first ~10 calls / ~20 touches, tracked by OS-WEEKLY.

## GATE G0 — Lock the white-label delivery partner  *(BLOCKING · human-path · counts)*
- **role**: Partner-sourcing (Paul-led; a session drafts artifacts only)
- **status**: Done (2026-07-21 — partner locked per CEO)
- **depends-on**: —
- **skills**: criteria doc + vetting scorecard drafting; devil's-advocate critic
- **inputs**: strategy doc "Biggest risk"; `operating-system.md` Issue #1
- **steps**: (1) draft partner criteria (Rails 8 rescue capability, 4-8wk turnaround, security bar, margin split, NDA/white-label terms); (2) Paul sources a shortlist; (3) vetting scorecard per candidate; (4) **run a PAID TRIAL rescue** on a low-stakes scope; (5) sign primary partner + **name a fallback partner**.
- **definition-of-done**: primary partner signed AND trial delivered to quality bar AND fallback named.
- **cold-eyes gate**: LIGHT+ — devil's-advocate prompted to refute "can this partner actually deliver a rescue in 4-8 weeks to our bar, and what happens the week they can't?" Majority-refute → do not open selling cards.
- **handoff note**: _(paste critic verdict verbatim on completion)_

## CARD S0 — Wire the booking link + pipeline source of truth  *(measurement prerequisite)*
- **role**: Ops + Offer/Landing
- **status**: In progress (2026-07-21 — Rescue Demand Sprint; lean path = external Cal.com/NeetoCal link, NO site change)
- **depends-on**: —
- **skills**: `hugo`, `new-page.md`
- **inputs**: `content/pages/free-consultation/index.md`, `themes/beaver/layouts/page/free-consultation.html`, `operating-system.md` §7
- **steps**: embed a real booking widget (NeetoCal/Cal.com) on the consultation/landing page (today NeetoCal is copy-only); make the pipeline sheet the single source; define LinkedIn-reply → call attribution.
- **definition-of-done**: a live booking link that makes "discovery calls booked" auto-countable; pipeline sheet exists and is linked from `operating-system.md` §7.
- **cold-eyes gate**: LIGHT — refute "can we actually measure calls-booked end-to-end with this?"
- **handoff note**: _(verbatim verdict)_

## CARD A2 — Define the Vibe Code Rescue offer  *(price gated on G0)*
- **role**: Sales/Comms
- **status**: In progress (2026-07-21 — G0 Done, pricing unblocked; Rescue Demand Sprint)
- **depends-on**: G0 (for pricing only)
- **skills**: `copywriting`, `reflexion-critique`
- **inputs**: strategy doc; market pricing ($25-50K / 4-8wk / keep 30-50%); ICP `90.10`
- **steps**: write the one-page offer — Rescue Audit (fixed fee, plain-English scorecard + salvage-vs-rebuild verdict) → fixed-price rescue; finalize price only after G0 margin is known.
- **definition-of-done**: one-page offer + price band approved by Paul.
- **cold-eyes gate**: HEAVY — `reflexion-critique` + devil's-advocate on price/positioning; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C0 — Paul's warm-intro + outbound target list  *(PRIMARY demand engine · human-path · counts)*
- **role**: Sales/Comms (Paul-led; agent drafts list + messages)
- **status**: In progress (2026-07-21 — Rescue Demand Sprint; PRIMARY bet)
- **depends-on**: — (messages that quote price/offer wait on A2)
- **skills**: `copywriting`, `linkedin-icp-validation-plan`
- **inputs**: ICP `90.10`; existing network; control-loss pain phrases
- **steps**: AGENT builds the list + openers via the **Incremental agent backlog** (T1→T2→T3-T5 source→T6 dedupe/score→T7 openers). PAUL then reviews and sends (desk item P3). The agent does everything up to "hit send."
- **definition-of-done**: ~30 named targets (T6) + per-target openers (T7) ready in `rescue-sprint/`; Paul has sent + cadence started → tracked in pipeline.
- **cold-eyes gate**: LIGHT — refute the targeting + opener; HEAVY only for any published/mass copy.
- **handoff note**: _(verbatim verdict)_

## CARD B1 — Rescue Audit offer/landing page  *(public · demand-supported)*
- **role**: Offer/Landing (hugo-expert)
- **status**: Blocked
- **depends-on**: A2, S0
- **skills**: `new-page.md`, `design-md`, `cover-images`, `review-swarm`
- **inputs**: `content/_index.md` (rescue frontmatter, PR #385), `page/free-consultation.html`, `use-cases/salvage-existing-project/`
- **steps**: reuse the `free-consultation` funnel + `_index` rescue frontmatter; add offer, proof, one "Book a Rescue Audit" CTA → S0 booking link; surface salvage-existing-project.
- **definition-of-done**: page live, CTA wired to booking, mobile+desktop clean.
- **cold-eyes gate**: HEAVY — `review-swarm` + `visual-scroll-gate` + `bin/test` AND `bin/dtest`; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C1 — LinkedIn ICP validation sprint  *(fast pipeline)*
- **role**: Lead-gen
- **status**: Ready
- **depends-on**: — (S0 booking link strengthens CTA)
- **skills**: `linkedin-post-pipeline` + `linkedin-icp-validation-plan`, `reflexion-reflect`
- **inputs**: `linkedin-icp-validation-plan.md` (reply-keyword CTAs DEMO/ACCESS/REPORT/REPO/TRANSFER), voice guide `90.11`
- **steps**: run the 5 control-loss hooks; route qualified replies → discovery call (S0 link).
- **definition-of-done**: 5 posts live; qualified replies logged to pipeline.
- **cold-eyes gate**: HEAVY (voice) — `reflexion-reflect` → blog/linkedin cold-eyes; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C2 — Control posts as call-support collateral  *(SUPPORT · demoted)*
- **role**: Marketing/Content/SEO
- **status**: Blocked (ship at most 1-2 now; rest deferred until a call needs them)
- **depends-on**: C1 signal
- **skills**: `blog` (full blog-pipeline)
- **inputs**: 20.07 plan — the 5 Planned Control posts (`friday-demo-rule-founder-progress`, `github-aws-database-ownership-checklist`, `asked-simple-admin-panel-built-spaceship`, `cheap-developers-expensive-without-cto-review`, `salvage-vs-rebuild-software-project`)
- **steps**: write the 1-2 posts that best support live conversations; one card/session each.
- **definition-of-done**: post shipped via full blog-pipeline (cover, build, visual gate).
- **cold-eyes gate**: HEAVY — full blog-pipeline stack (slop ≤25, shape-tell, cold-eyes Agent-4); verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C3 — "Vibe Code Rescue" SEO cluster  *(Q1 2027 pipeline · NOT critical path for Nov 30)*
- **role**: Marketing/Content/SEO
- **status**: Blocked (low priority; compounding, won't rank by Nov 30)
- **depends-on**: A2
- **skills**: `blog`, `social-media-trends-research`
- **definition-of-done**: cluster planned + published over time; own the "vibe code rescue" keyword.
- **cold-eyes gate**: HEAVY — full blog-pipeline; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C4 — Paid pilot on rescue keywords  *(Paul-gated budget)*
- **role**: Marketing/Paid
- **status**: Blocked
- **depends-on**: B1, A2
- **steps**: small LinkedIn/Google pilot on rescue intent → B1; measure cost-per-call.
- **definition-of-done**: pilot live; CPA measured in pipeline.
- **cold-eyes gate**: HEAVY (expensive) — devil's-advocate on spend/targeting; Paul approves budget; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD D1 — Discovery script + follow-up + audit deliverable template
- **role**: Sales/Comms
- **status**: Blocked
- **depends-on**: A2
- **skills**: `copywriting`, `reflexion-critique`
- **definition-of-done**: call script, follow-up sequence, one-page audit deliverable template ready.
- **cold-eyes gate**: HEAVY — `reflexion-critique` + devil's-advocate; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD B2 — Our own rescue case study  *(real proof)*
- **role**: Marketing/Content
- **status**: Blocked
- **depends-on**: first delivered audit/rescue (Rock 4)
- **definition-of-done**: case study published from a real engagement.
- **cold-eyes gate**: HEAVY — full blog-pipeline; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD D3 — Deliver audits → proposals → close  *(human-path · counts · signs the client)*
- **role**: Sales/Comms (Paul-led; white-label delivers)
- **status**: Blocked
- **depends-on**: G0, A2, S0, C0/C1 (pipeline)
- **definition-of-done**: **1 rescue engagement signed.**
- **cold-eyes gate**: LIGHT — refute the proposal/close logic per deal.
- **handoff note**: _(verbatim verdict)_

## CARD OS-WEEKLY — Run the operating-system loop  *(ongoing)*
- **role**: Ops/Scorecard
- **status**: Ready (weekly)
- **skills**: `eos-lite` skill, `lark-okr`
- **steps**: `Skill(eos-lite) weekly` — update scorecard, check OKR/KRs, advance rocks, IDS issues, walk pipeline.
- **definition-of-done**: `operating-system.md` scorecard + statuses current for the week.
- **cold-eyes gate**: LIGHT — refute "does the scorecard reflect reality or wishful numbers?"
- **handoff note**: _(verbatim verdict)_

---

## Sprint map (rocks → cards)

- **Rock 1 (Aug) offer+partner**: **G0** (gate), **S0**, **A2**, **C0** — the human critical path. Start here.
- **Rock 2 (Aug) landing**: B1 (after A2/S0).
- **Rock 3 (Aug→Sep) demand-gen**: C1 (now), C0 (now), C2 (1-2 support), C3 (deferred), C4 (paid, gated).
- **Rock 4 (Oct) convert**: D1, D3, then B2 from the first real engagement.
- **Ongoing**: OS-WEEKLY.

## Cold-eyes on this runbook (2026-07-21)

A devil's-advocate critic reviewed the orchestration design and rated it over-engineered for a
1-client goal. The CEO reviewed the critique and chose the full apparatus. The critic's non-negotiable
correctness fixes were adopted here: G0 as a blocking gate, pricing gated on partner, S0 booking link as
an early prerequisite, human-path cards flagged as the ones that count, content demoted to support,
4-eyes calibrated by reversibility, and verbatim critic verdicts required in handoffs.
