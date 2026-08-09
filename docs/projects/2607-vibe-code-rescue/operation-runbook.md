# Vibe Code Rescue — Operation Runbook

**Owner**: Paul Keen (CEO) | **Created**: 2026-07-21 | **Goal**: 1 signed rescue client by Nov 30, 2026
**Parent strategy**: [`strategy.md`](strategy.md) · **OS**: [`operating-system.md`](../../business/operating-system.md)
**How to read this**: this file IS the shared state across separate sessions. A session reads
[`BASE_HANDBOOK.md`](../../workflows/BASE_HANDBOOK.md) + [`flow-router.md`](../../workflows/flow-router.md), opens this runbook, takes the next
`Ready` card, executes it, runs its cold-eyes gate, marks it `Done`, writes the handoff note (with the
critic's verdict pasted VERBATIM), and sets the next card `Ready`.

---

## ▶ START HERE (fresh session) — read this first, then act

**You can finish this operation in a new session with zero context loss. Do this:**

1. **Read order**: [`executive-summary.md`](executive-summary.md) (the one-page bet, Shape Up format) → this START HERE block → the ACTIVE SPRINT state → the **Incremental agent backlog** table → the specific card/T-task you're taking. Optionally skim [`strategy.md`](strategy.md) (the why) and [`operating-system.md`](../../business/operating-system.md) (weekly cadence).
2. **Current state (2026-08-08, Sprint 3 BLOCKED-ON-TOOLING)**: P9/P10 done; batch-1 pre-research exposed a sourcing quality gap (retro below). **#28 is DONE** — the v2.1 qualification rubric (verified timestamps **≤30 days flat, all venues**, post|comment routing, thread-health scan, lead-vs-VoC split) is live in `rescue-sprint/t4-t5-grooming.md` Vote 3. **Policy split (Paul)**: leads must be ≤1 month verified; **VoC has NO age limit** — any comment/message/post teaches ICP slang, and stale-dropped threads still get VoC-harvested in the same visit. **Batch-1 is now 0-for-5** — the flat rule flipped SpecBuildLab (~9.5mo) and Joy (~5mo, Paul's one override candidate) too; #12 is blocked on #29's replacements. **Card registry: [`backlog.md`](backlog.md) §State + §Card #29 status** (the old local kanban board was never committed and no longer exists — do not look for it). **Next Ready: #29** (re-source v2 — re-audit all 25 v1 rows, dual-harvest leads+VoC, source fresh ≤30-day rows, expand channels if IH is thin). Then: openers-delta → #12 batch-1 send (Paul approves) → #20 daily reply-monitor. Booking link confirmed live. **Superseded 2026-08-08**: the passive keyword monitor that used to be #29's channel-expansion lane is retired, and the "~2 min keyword swap" is struck from Paul's desk — expansion now runs through `prospects/p7-search-sweep.md`. **#29 is BLOCKED-ON-TOOLING**, not on Paul: its sweep ran 2026-08-08 and returned zero rows because every thread-open hit `EGRESS_BLOCKED`. Agent-doable with zero Paul input once thread-open access is restored: #29 (re-source), #14 (landing page).

**⚠ Sourcing-quality retrospective (2026-07-26, short form)**: batch-1 pre-research found 3 of 5 openers unsendable (60% stale) because recency was eyeballed from excerpts, never verified in-thread. Fix = card #28's 5-check Vote 3 v2 rubric. **Treat all 25 rows in `cold-prospect-list.md` as unverified until #29 re-checks them.** Full retro (root cause, named misses, Paul's quality-over-quota directive): [`backlog.md`](backlog.md) §"Filed".
3. **Take the next Ready task**, execute it end-to-end, run its LIGHT/HEAVY gate, paste the verdict, mark it Done, set the next Ready. **The agent does everything up to "hit send"** — sending + calls are Paul's (see Paul's desk).
4. **State lives in files, not memory.** Update this runbook (statuses + handoff notes) and the output file named on the task. That's what the next session reads.

**Artifact index — `docs/projects/2607-vibe-code-rescue/rescue-sprint/`:**
| File | What it is | Status |
|---|---|---|
| `assumptions-register.md` | A0 — ICP/trigger/channel/pre-validation brainstormed→voted→kill-criteria | ✓ done |
| `customer-profile-four-forces.md` | JTBD Customer Profile + Four Forces (push/pull/anxiety/habit) + find→channel→message map | ✓ done |
| `icp-trigger-taxonomy.md` | T1 — 8 ranked observable buying triggers + venue map (= the Push force) | ✓ done |
| `sourcing-pipeline.md` | T2 — per-trigger query recipes, lane split, verified venues, tool stack | ✓ done |
| `../backlog.md` | **Atomic executable backlog P1-P9** — per-venue sourcing → merge → openers, seeded URLs | ✓ ready to run |
| `t4-t5-grooming.md` | T4/T5 groomed design (3-agent brainstorm + votes: discovery, throughput, qualification) | ✓ done |
| `voice-of-customer.md` | VoC swipe file keyed to Four Forces; stale-dropped leads still feed it (no age limit) | ✓ done — 27 quotes, all four forces PASS |
| `offer-one-pager.md` | A2 — the Vibe Code Rescue offer (free audit → fixed rescue) | ✓ done — priced $2,500/$7,500/$10,000, live booking link |
| `warm-intro-referral-kit.md` | C0 — referral-ask templates; **OPTIONAL side lane since 2026-08-08** (warm-primary premise falsified — register C1 addendum) | templates done; 2-3 past-client referral asks if Paul wants, or T3 Gmail consent, or skip — **nothing gates on this file** |
| `booking-page-spec.md` | S0 — NeetoCal setup spec (fulfilled; link live 2026-07-24) | ✓ done — historical record |
| `45-minute-session-playbook.md` | D1 — the call script Paul runs on a booked Rescue Context Call | done; awaiting Paul's read-through |
| `send-runner-prompt.md` / `reply-monitor-prompt.md` | #12 send runner (pre-research → Paul approves → send → log) / #20 daily reply monitor | ready; dormant until first sends |
| `outbound-openers.md` | T7 — per-target openers | done (P9 complete; 25 openers ready for Paul) |
| `discovery-kit.md` | T8 — call script + audit deliverable template | done (T8 complete) |
| `objection-followup-bank.md` | T9 — objections + follow-up sequence | done (T9 complete) |

---

## ▶ ACTIVE SPRINT — Sprint 3: Fresh-Leads Sprint (kicked off 2026-07-26) · HIGH PRIORITY

**Goal**: a **verified-fresh** prospect list (every row: timestamp read **≤30 days flat, all venues**, routing recorded, thread-health clean) and batch-1 actually sent. Quality over quota — 10-15 real rows beat 25 padded ones.
**Policy split (Paul, 2026-07-26)**: the 30-day rule gates **leads only**. **VoC harvest has no age limit** — any comment/message/post teaches the ICP's slang; every visited thread (including stale drops) feeds `voice-of-customer.md` in the same visit.
**Sequence (WIP=1)**: #29 re-source v2 (re-audit 25 v1 rows + source fresh, dual-harvest leads+VoC; IH-first, P7 date-filtered sweep + X expansion if thin) → openers-delta for new rows → #12 batch-1 send (Paul approves; batch-1 currently 0-for-5 — blocked on #29's rows, with Joy Adamson as Paul's one explicit-override candidate) → #20 daily reply-monitor. Batch-2/3 (#19/#25) gated on #29.
**Paul's desk is clear of #29** (2026-08-08): the old "swap the monitor keywords" 2-minute ask died with the monitor - do not re-surface it. **#29 is now BLOCKED-ON-TOOLING instead**: the replacement sweep (`prospects/p7-search-sweep.md`) ran and returned zero qualified rows because every venue thread-open attempt hit `EGRESS_BLOCKED` and Reddit rejected the tool's user agent. Unblock = `chrome-devtools` + egress to **at least one** of `indiehackers.com` or `reddit.com` (per `p7-search-sweep.md`'s own unblock note - one openable venue is sufficient, not both). See `backlog.md` §Card #29 status.

---

### Previous — Rescue Demand Sprint (2026-07-21 → 2026-07-26, closed)

**Goal**: get Paul sending trusted intros with a *populated, evidenced* prospect list. G0 partner = Done. Scope = lean minimum. **Outcome**: P1-P10 shipped (25 rows, 25 openers, discovery kit, objection bank, booking link, pipeline sheet) — but batch-1 pre-research exposed the 60% staleness gap (see retrospective in START HERE), triggering the Sprint-3 quality re-source.
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
| P1 | Create the booking page in his own Cal.com/NeetoCal account (~5 min; spec in `booking-page-spec.md`) | Needs his calendar + login | S0 gate; live URL: https://jetthoughts.neetocal.com/free-code-audit-find-out-whats-actually-broken-before-you-spend-another-dollar |
| P2 | Confirm the price band (audit free; tiered rescue pricing) | Depends on partner margin only he knows | ✅ Done 2026-07-22 — A2 confirmed at $2,500 / $7,500 / $10,000 |
| P3 | **Post LinkedIn ICP post #1** (`linkedin-posts/icp-validation/POSTING-PACKET.md` — copy, paste, post; ~2 min), then keep the 3-4/wk cadence from agent drafts. Later: review + send any verified openers from #29. Optional: 2-3 past-client referral asks from the kit | Posts and sends go out under his name/relationship | C1 activation; C0 send |
| P4 | Take the discovery calls; run audits → proposals → close | The whole point; the human trust layer | D3 signing |

If a card handoff says "waiting on Paul" for anything NOT in this table, that's a mis-scope — the agent should have done it.

---

## Incremental agent backlog (T-tasks — one per session, no human needed)

> **Atomic execution list → [`backlog.md`](backlog.md).** T4/T5 below are decomposed there into parallel-safe atomic tasks P1-P9 (per-venue sourcing → merge → openers), each seeded with verified URLs/handles. Agents run from `backlog.md`; this table stays as the strategic view.

A future session takes the next `Ready` task, does it end-to-end (research/draft/source/prep),
runs its LIGHT cold-eyes gate, writes the output to the named file, marks it `Done`, sets the next `Ready`.
These feed the C0/D1 cards without touching Paul's desk. Each is scoped to ≤1 session.

| T | Task | Output file | Status | Depends | Gate |
|---|---|---|---|---|---|
| T1 | **Trigger taxonomy** — run the trigger research first-hand (`web_search` on ICP rescue-pain signals; don't wait on any prior ghost agent report — if none is on disk, generate it), then synthesize a ranked list of *detectable* ICP buying triggers (e.g. "posted about a dev shop ghosting them", "asking r/startups if their MVP is salvageable", "hiring a first eng after an agency build") with the observable signal + where it shows up | `rescue-sprint/icp-trigger-taxonomy.md` | **Done** (2026-07-21 — 8 ranked triggers + venue map + competitor note; PASS w/ 2 carried constraints) | — (self-contained) | LIGHT — refute "is each trigger actually observable by us, or a guess?" |
| T2 | **Sourcing pipeline spec** — for each trigger: channel → exact search query/operator → validation rule → which template applies. Carries T1's 2 constraints (lane-split + trust/ownership differentiation) | `rescue-sprint/sourcing-pipeline.md` | **Done** (2026-07-21 — per-trigger query recipes + lane split + row schema; PASS w/ 2 carried constraints: weight reddit/IH site operators + read into threads; cap cold volume prefer warm) | T1 ✓ | LIGHT — refute "can a session run this query and get real people, not noise?" |
| T3 | **Warm-source pass (Gmail)** — with Paul's one-time consent, mine his mailbox for past clients / founders / investor-adjacent contacts near the ICP; output candidate warm rows (name, last touch, why-ICP, best path). No sending. | append to `rescue-sprint/warm-intro-referral-kit.md` target list | Blocked (optional — needs Paul Gmail consent; chain does NOT block on it) | T2 ✓ + P-consent | LIGHT — refute "is each row genuinely warm + near-ICP?" |
| T4 | **Cold-source pass A (web, fetchable)** — GROOMED in `t4-t5-grooming.md`. **IndieHackers-first** (fetch-free, run FIRST), then HN threads, X first-person, competitor-comment threads. Site-scoped queries → excerpt queue → `chrome-devtools` read-once-extract-all (validate+row+quotes in one visit). Rows → `cold-prospect-list.md`; verbatim founder quotes → `voice-of-customer.md` | `rescue-sprint/cold-prospect-list.md` + `voice-of-customer.md` | **Done** (P1-P3 + P6 complete) | T2 ✓ + grooming approval | LIGHT — refute "real ICP founder in a buying moment, traceable to a quoted sentence?" |
| T5 | **Cold-source pass B (Reddit/community)** — GROOMED in `t4-t5-grooming.md`. r/replit, r/NoCode, r/Solopreneur, r/SaaS, r/startups, r/vibecoding. Reddit bodies not fetchable → **excerpt capture** (handle+URL+title), feeding the excerpt queue + VoC only. Additive to T4, not load-bearing. Same output files | `rescue-sprint/cold-prospect-list.md` + `voice-of-customer.md` | **Done** (P4/P5/P6 rows landed; P7's method shipped but its 2026-08-08 sweep produced zero rows, BLOCKED-ON-TOOLING — see card #29 status, not a T5 defect) | T2 ✓ + grooming approval | LIGHT — refute ICP fit + thread live/answerable; no supplier posts logged as leads |
| T6 | **Validate + score + dedupe** — merge sources into one ranked list (warm-first), drop dupes/dead, score by trigger strength; target ~30 usable rows | finalized target list | **Done** (P8 merge; 25 deduped rows) | T4 + T5 complete; T3 folded in **if** Paul gave Gmail consent (chain does NOT hard-block on consent) | LIGHT — refute "would Paul recognize these as worth his time?" |
| T7 | **Per-target openers** — draft a personalized opener per row (right template: referral / warm-intro / forwardable / thread-reply), `[BOOKING_LINK]` placeholder, ready for Paul to review-and-send | `rescue-sprint/outbound-openers.md` | **Done** (P9 complete; 25 openers ready) | T6, A2 | LIGHT (bulk/near-public → HEAVY if any becomes a mass template) |
| T8 | **Discovery kit** — call script + audit deliverable one-page template + 45-min agenda (Card D1 content), so Paul walks into calls with a script | `rescue-sprint/discovery-kit.md` | **Done** (2026-07-22 — 45-min agenda + SPIN/Four-Forces script + 1-page RAG scorecard/verdict template; devil's-advocate self-refute PASS, order-dependency noted) | A2 draft | HEAVY — devil's-advocate self-refute (verdict in-file §Cold-eyes) |
| T9 | **Objection + FAQ + follow-up bank** — likely founder objections ("why not just re-hire the shop", "is $7,500 real"), answers, and a 3-touch no-reply follow-up sequence | `rescue-sprint/objection-followup-bank.md` | **Done** (T9 complete) | T8 ✓ | LIGHT — refute "does each answer hold up to a skeptical burned founder?" |

**All T-tasks T1-T9 are Done except T3** (2026-08-08). T3 (warm-source pass) stays open but **OPTIONAL** — the warm-primary premise was partially falsified 2026-08-08 (Paul cannot enumerate warm ICP names; register C1 addendum). The primary lane is now **LinkedIn** (posting packet ready — Paul copies, pastes, posts); cold #29 is the load-bearing secondary (gated on the tooling unblock). No grooming gate holds anything — sourcing ran and completed 2026-07-22; the Vote 3 v2 rubric governs *re-verification* (#29), not permission to run.

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
- **status**: Done (2026-07-24 — booking link live and confirmed by Paul; `rescue-sprint/pipeline.md` is the ledger, bound from `operating-system.md` §1)
- **depends-on**: —
- **record**: full event spec (intake questions, confirmation copy, reminders) lives in [`booking-page-spec.md`](rescue-sprint/booking-page-spec.md) — the single copy; do not restate it here. Live URL: see Paul's desk P1.
- **definition-of-done**: a live booking link that makes "discovery calls booked" auto-countable; pipeline sheet exists and is linked from the OS. ✓
- **cold-eyes gate**: LIGHT — refute "can we actually measure calls-booked end-to-end with this?"
- **handoff note**: _(verbatim verdict)_

## CARD A2 — Define the Vibe Code Rescue offer  *(price gated on G0)*
- **role**: Sales/Comms
- **status**: Done (2026-07-22 — A2 confirmed: 3-tier pricing at $2,500 / $7,500 / $10,000)
- **depends-on**: G0 (for pricing only)
- **skills**: `copywriting`, `reflexion-critique`
- **inputs**: strategy doc; market pricing ($25-50K / 4-8wk / keep 30-50%); ICP `90.10`
- **steps**: write the one-page offer — Rescue Audit (fixed fee, plain-English scorecard + salvage-vs-rebuild verdict) → fixed-price rescue; finalize price only after G0 margin is known.
- **definition-of-done**: one-page offer + price band approved by Paul.
- **cold-eyes gate**: HEAVY — `reflexion-critique` + devil's-advocate on price/positioning; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C0 — Paul's outbound target list  *(demand engine · human-path · counts)*
- **role**: Sales/Comms (Paul-led; agent drafts list + messages)
- **status**: In progress (re-weighted 2026-08-08 — the warm-primary premise is partially falsified: Paul cannot enumerate warm ICP names [register C1 addendum]. The COLD lane is built but 100% unverified + blocked-on-tooling (#29, now the load-bearing sourcing path). The **WARM sub-lane is demoted to an OPTIONAL referral-ask**: 2-3 past clients via the kit templates, or T3 Gmail consent, or skip — nothing gates on it. The fastest path to a live touch is now C1: Paul posting LinkedIn #1 from the ready packet.)
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

## CARD C1 — LinkedIn ICP validation sprint  *(fast pipeline · drafts-only lane)*
- **role**: Lead-gen (agent drafts; **Paul posts** — nothing publishes without him)
- **status**: Ready (drafts-only, per revised Rock 1: LinkedIn is one of the three demand lanes because the cold lane alone cannot reach KR2. Campaign state: 3 of 10 posts drafted, zero posted, zero data — see `linkedin-icp-validation-plan.md` status banner. Cadence when live: within 20.09 §7's 3-4/wk total.)
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
- **status**: Archived (not critical path for Nov 30; 20.09 additionally found page 1 for the category term fully occupied — re-open only after the category-name decision on Paul's desk)
- **depends-on**: A2
- **skills**: `blog`, `social-media-trends-research`
- **definition-of-done**: cluster planned + published over time; own the "vibe code rescue" keyword.
- **cold-eyes gate**: HEAVY — full blog-pipeline; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD C4 — Paid pilot on rescue keywords  *(Paul-gated budget)*
- **role**: Marketing/Paid
- **status**: Archived (rock cut 2026-08-07 per 20.09 — paid waits on an organic reply signal that does not yet exist)
- **depends-on**: B1, A2
- **steps**: small LinkedIn/Google pilot on rescue intent → B1; measure cost-per-call.
- **definition-of-done**: pilot live; CPA measured in pipeline.
- **cold-eyes gate**: HEAVY (expensive) — devil's-advocate on spend/targeting; Paul approves budget; verbatim verdict.
- **handoff note**: _(verbatim verdict)_

## CARD D1 — Discovery script + follow-up + audit deliverable template
- **role**: Sales/Comms
- **status**: ✅ Done via T8/T9 (2026-07-22) — call script + one-page audit template live in `rescue-sprint/discovery-kit.md`, follow-up sequence in `rescue-sprint/objection-followup-bank.md`. Do not rebuild.
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

## Sprint map (rocks → cards, aligned with `operating-system.md` §4, 2026-08-08)

- **Rock 1 (now) — demand flowing from the live lanes, summing to KR2's 8-12 calls** (re-weighted 2026-08-08): **C1 LinkedIn** (PRIMARY — packet ready, Paul copies/pastes/posts) · **#29 cold** (load-bearing secondary; blocked-on-tooling) · **inbound floor** (6 funnel-linked posts + booking link, live) · **C0 referral-ask** (optional, 2-3 past clients, nothing gates on it). The cold lane alone maxes at ~2-3 calls — it cannot carry the KR.
- **Rock 2 (Aug) landing**: B1 (after A2/S0 — both Done, so B1 is capacity-blocked only).
- **Rock 3 (Aug→Sep) first send → first call**: #12 batch-1 (any lane that opens), then #20 reply-monitor; C2 stays support-only.
- **Rock 4 (Oct) convert**: D3 with D1's kit, then B2 from the first real engagement.
- **Mid-point gate (Sep 30)**: ≥3 discovery calls booked, else pause and re-open A + C (register wording).
- **Ongoing**: OS-WEEKLY. Closed/archived: G0, A0, S0, A2, D1 (done) · C3, C4 (archived).

## Cold-eyes on this runbook (2026-07-21)

A devil's-advocate critic reviewed the orchestration design and rated it over-engineered for a
1-client goal. The CEO reviewed the critique and chose the full apparatus. The critic's non-negotiable
correctness fixes were adopted here: G0 as a blocking gate, pricing gated on partner, S0 booking link as
an early prerequisite, human-path cards flagged as the ones that count, content demoted to support,
4-eyes calibrated by reversibility, and verbatim critic verdicts required in handoffs.
