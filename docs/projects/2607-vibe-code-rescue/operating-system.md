# JetThoughts Operating System (lean)

**Purpose**: the smallest cadence that reliably ships the [Autumn strategy](strategy.md) - **1 Vibe Code Rescue client by Nov 30, 2026**.
**Owner**: Paul Keen | **Created**: 2026-07-21 | **Review**: weekly
**Model**: EOS-lite (accountability chart + quarterly OKR + weekly scorecard + rocks + issues), sized for a founder + white-label delivery + AI execution.

---

## 0. Current state & where to start (fresh session)

**As of 2026-07-21**: foundation is set. A0 assumptions register ✓, G0 white-label partner ✓ (locked per CEO), offer/kit/booking drafts ✓, T1 trigger taxonomy ✓, T2 sourcing pipeline ✓.
**Active sprint**: Rescue Demand Sprint — populate the prospect list (agent) so Paul can send + book calls.
**Next agent work**: `T4/T5` (build the list) → `T6` dedupe → `T7` openers; `T8` discovery kit in parallel.
**To execute**: open [`operation-runbook.md`](operation-runbook.md) → **▶ START HERE** block → take the next Ready task. That runbook is the shared state across sessions; this file is the weekly cadence over it.
**Paul's desk (human-only)**: booking page (~5 min), confirm price band (default: audit free, rescue from $25K), review + send the outreach, take the calls, close. Optional: Gmail consent (warm lane), Apollo $79/mo + Hunter key (paid cold funnel).

---

## 1. Accountability chart (who owns what)

| Seat | Owner | Owns |
|---|---|---|
| **CEO / Sales / Trust layer** | Paul | Discovery calls, offer, pricing, the founder relationship, fractional-CTO oversight |
| **Delivery** | White-label partner | The rescue build (Rails), under JT brand, to JT quality bar |
| **Marketing / Content / Ops engine** | Claude Code (+ Paul review) | Content, SEO, landing, lead magnets, LinkedIn drafts, pipeline tracking, this OS |

One person can hold several seats - but every seat has exactly one accountable owner.

## 2. Quarterly OKR (Q3->Q4 2026)

**Objective**: Land the first Vibe Code Rescue client and prove the machine.

| Key Result | Target | Status |
|---|---|---|
| KR1 - Offer + white-label partner live | Rescue Audit priced, partner signed, landing CTA live | 🟡 partner signed ✓; offer drafted (price confirm pending); landing deferred |
| KR2 - Discovery calls booked | 8-12 by Nov 15 | 🔲 |
| KR3 - Audits delivered | 3-5 paid Rescue Audits | 🔲 |
| KR4 - Rescue signed | **1 engagement by Nov 30** | 🔲 |

## 3. Rocks (90-day priorities = roadmap milestones)

1. **Offer + partner locked** (Aug) - the machine can't sell without these.
2. **Landing = booking machine** (Aug) - offer, proof, one CTA.
3. **Demand-gen live on all channels** (Aug->Sep) - LinkedIn 3-4/wk, rescue SEO cluster, paid pilot.
4. **First audit -> first signing** (Oct).

## 4. Weekly scorecard (leading metrics, review every week)

| Metric | Owner | Target/wk |
|---|---|---|
| LinkedIn posts published | Paul/Claude | 3-4 |
| LinkedIn qualified replies/DMs | Paul | >=3 |
| New email subs from magnets | Claude | trend up |
| Blog posts shipped (rescue/ICP-E) | Claude | 2-3 |
| **Discovery calls booked** | Paul | trend to 8-12 by mid-Nov |
| Rescue Audits sold | Paul | cumulative -> 3-5 |
| Rescues signed | Paul | -> 1 |

Green = hit target, Red = missed. Any red 2 weeks running becomes an Issue (section 6).

## 5. Meeting cadence

- **Weekly ops review (~30 min)**: scorecard (5 min) -> rock progress (5 min) -> pipeline
  walk (10 min) -> IDS the top issues (10 min). Update the scorecard + OKR statuses in this file.
- **Monthly strategy check (~45 min)**: is the wedge still right? adjust roadmap; refresh
  market scan if signals shift.
- **Per-deal**: discovery call -> audit -> proposal, tracked in the pipeline (section 7).

## 6. Issues list (IDS: Identify, Discuss, Solve)

Rolling list of the top blockers. Solve the highest-leverage one each week; don't let it grow.

| # | Issue | Owner | Status |
|---|---|---|---|
| 1 | White-label delivery partner (runbook G0) | Paul | ✅ Resolved 2026-07-21 (locked per CEO). Standing validation: confirm a paid trial rescue hits the quality bar + a fallback partner is named before the first real signing. |
| 2 | Prospect list not yet populated — Paul has nobody to send to until T4-T7 run | Claude | 🔲 Open — next agent work (runbook T4/T5) |
| 3 | Price band unconfirmed — offer ships on a default ("audit free, rescue from $25K") until Paul confirms | Paul | 🔲 Open (non-blocking; default in place) |

## 7. Pipeline (simple funnel, no CRM needed yet)

Track each lead as a row: **Source -> Discovery call -> Audit sold -> Proposal -> Signed**.
Stages: `Lead` -> `Call booked` -> `Audit sold` -> `Proposal out` -> `Won` / `Lost (reason)`.
Keep it in a single sheet (or a section here) until volume justifies a real CRM.
**Leads originate from** the populated target list in [`rescue-sprint/warm-intro-referral-kit.md`](rescue-sprint/warm-intro-referral-kit.md) (agent-built via runbook T4-T7); once Paul sends, each contacted row becomes a pipeline `Lead`.

## 8. Tooling map

| Function | Tool |
|---|---|
| Site / blog | Hugo (`bin/hugo-build`), content in `content/blog/` |
| Content ops | Blog pipeline (`docs/workflows/blog-pipeline.md`), voice guide 90.11 |
| LinkedIn | LinkedIn pipeline (`docs/workflows/linkedin-post-pipeline.md`) + ICP validation plan |
| Discovery scheduling | NeetoCal (per outreach template) |
| Pipeline tracking | Sheet / this doc section 7 until CRM is justified |
| OKR spine | `lark-okr` skill for structuring quarterly OKRs |
| Weekly OS loop | `eos-lite` skill (`Skill(eos-lite) weekly`) — runs scorecard/OKR/rocks/issues/pipeline over this doc |
| Step-by-step execution | [`operation-runbook.md`](operation-runbook.md) — ordered task cards + Incremental agent backlog; **▶ START HERE** for any fresh session |
| Foundational premises | [`rescue-sprint/assumptions-register.md`](rescue-sprint/assumptions-register.md) — ICP/trigger/channel/pre-validation, voted, with kill-criteria (runbook rule 7) |
| Sprint artifacts | `rescue-sprint/` — offer, warm-intro kit, booking spec, trigger taxonomy, sourcing pipeline (see runbook START HERE artifact index) |

## 9. Definition of "operating" (are we actually running the system?)

- Scorecard updated weekly, with real numbers.
- Every rock has a next action and an owner.
- The Issues list is short because we solve the top one each week.
- Discovery-calls-booked moves up week over week from Sept.
