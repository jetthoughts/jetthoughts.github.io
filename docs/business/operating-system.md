# JetThoughts Operating System (lean)

**Scope**: the **company** operating system - how JetThoughts runs across every opportunity, not just the current one. **Company layer**: [`index.md`](index.md) (front door) · [`vision-mission.md`](vision-mission.md) (who we are, still DRAFT) · [`opportunity-portfolio.md`](opportunity-portfolio.md) (the bets).
**Purpose**: the smallest cadence that reliably ships the current objective - **1 Vibe Code Rescue client by Nov 30, 2026**.
**Owner**: Paul Keen | **Created**: 2026-07-21 | **Review**: weekly, in §1 below - no separate ritual
**State**: this file does NOT duplicate the runbook's fresh-session state. For "what do I do right now," open [`operation-runbook.md`](../projects/2607-vibe-code-rescue/operation-runbook.md) → START HERE. This file is the numbers layer over it.

---

## 1. This week

Source of truth: [`rescue-sprint/pipeline.md`](../projects/2607-vibe-code-rescue/rescue-sprint/pipeline.md) §Weekly tally. This table is that tally's numbers, not a second set - update the sheet first, this row second, same sitting.

| week of | touches sent | replies | calls booked | audits sold | rescues signed | posts shipped |
|---|---|---|---|---|---|---|
| 2026-08-08 | 0 | 0 | 0 (target 8-12 by Nov 30) | 0 (target 3-5) | 0 (target 1) | 2 (Aug, target ~6/mo) |

**Verdict: 🔴 red.** Not "zero calls" - **zero touches have ever been sent.** Batch-1 has been HOLD since 2026-07-26 (stale rows); the Sprint-3 re-source ran 2026-08-08 and is now BLOCKED-ON-TOOLING (`operation-runbook.md` §Card #29). 18 days since Sprint 3 kicked off (2026-07-26), the bottleneck hasn't moved past sourcing.
**Kill-check**: the C1 kill-criteria ("2 weeks of warm outreach yields 0 booked calls → pause, re-open A+C") has **not fired** - its precondition is 2 weeks of *actual* outreach, and none has gone out yet. Don't read that as safe: it means we don't even have the data the criteria needs. See Issue 2.
**Where sessions went this week**: mostly 2605 (course wave completion, W1-W5) and 2510 (content re-plan), plus this session's 2607 sourcing-tool diagnosis. That allocation is why a distribution failure sat unflagged for 18 days - nobody was in the pipeline sheet.

---

## 2. Accountability chart

| Seat | Owner | Owns |
|---|---|---|
| **CEO / Sales / Trust layer** | Paul | Discovery calls, offer, pricing, founder relationship |
| **Delivery** | White-label partner | The rescue build (Rails), under JT brand |
| **Marketing / Content / Ops** | Claude Code (+ Paul review) | Content, SEO, landing, pipeline tracking, this OS |

## 3. OKR (Q3→Q4 2026) + kill-check

**Objective**: Land the first Vibe Code Rescue client and prove the machine.

| KR | Target | Status |
|---|---|---|
| KR1 - Offer + partner live | Priced, partner signed, landing CTA live | 🟢 partner ✓, priced ✓ ($2,500/$7,500/$10,000), booking link live ✓; full landing page still Blocked (card B1) |
| KR2 - Discovery calls booked | 8-12 by Nov 30 | 🔴 0. (Mid-Nov is an internal trend checkpoint, not a separate deadline - both KRs share one date now.) |
| KR3 - Audits delivered | 3-5 free Rescue Audits | 🔴 0 - blocked behind KR2 |
| KR4 - Rescue signed | 1 by Nov 30 | 🔴 0 - blocked behind KR3 |

**Kill-criteria (from the assumptions register, evaluated here weekly - this is the "runs automatically via OS-WEEKLY" promise, made real):** C1 warm-channel test - 0 calls after 2 weeks of *actual sent* outreach → pause, re-open ICP/channel. Currently **untestable**, see §1. A0 ICP test - if ≥half of early interest is technical or pre-launch founders, re-open the ICP vote. Not yet evaluable - zero interest of any kind so far.

## 4. Rocks (open only)

1. **Unblock sourcing** (now) - card #29 needs `chrome-devtools` + egress to at least one of indiehackers.com / reddit.com. Nothing else on the board matters until this moves.
2. **Landing page** (Aug) - card B1, Blocked on nothing but capacity; booking link already live standalone.
3. **First send → first call** (Aug-Sep) - batch-1/2/3, gated entirely on Rock 1.
4. **First audit → first signing** (Oct) - not started, gated on Rock 3.

*Closed*: offer + partner locked (Jul 21). *Cut* (20.09, 2026-08-07): the paid-pilot rock - budget only matters once organic proves a reply signal, and the bet currently forbids a content sprint.

## 5. Issues (IDS - top 5, solve the highest-leverage one each week)

| # | Issue | Owner | Status |
|---|---|---|---|
| 1 | Sourcing BLOCKED-ON-TOOLING - #29's sweep can't open any thread to verify a timestamp | Infra/Paul | 🔴 Open since 2026-08-08 - see runbook §Card #29 |
| 2 | Kill-criteria untestable, not "not fired" - 18 days, zero touches sent, so the C1 test has never actually run | Claude/Paul | 🔴 Open - ratify: is this a distribution defect (re-run once unblocked) or does it call the bet itself into question? |
| 3 | Joy Adamson override - only survivor of batch-1, 5mo old, still publicly unanswered | Paul | 🟡 Open - 1-min decision, unresolved since ~2026-07-26 |
| 4 | Pricing vs. thesis tension - JT undercuts at $7,500 against $25-55K competitors one week after publishing "cheap developers are expensive," which argues against its own thesis to a twice-shy founder | Paul | 🟡 Open - content flagged it (20.09 §10), not a content fix |
| 5 | vision-mission.md still stamped DRAFT, 18 days on, while other docs cite it as settled | Paul | 🟡 Open - 1-line decision: ship it or say what's wrong |

*Resolved, moved to changelog*: white-label partner (Jul 21) · prospect list populated, P8 (Jul 22) · price band (Jul 22).

## 6. Tooling map

| Function | Tool |
|---|---|
| Site / blog | Hugo (`bin/hugo-build`), `content/blog/` |
| Content ops | `docs/workflows/blog-pipeline.md`, voice guide 90.11 |
| LinkedIn | `docs/workflows/linkedin-post-pipeline.md` + ICP validation plan |
| Discovery scheduling | NeetoCal |
| Pipeline tracking | [`rescue-sprint/pipeline.md`](../projects/2607-vibe-code-rescue/rescue-sprint/pipeline.md) - the only copy of these numbers |
| OKR/weekly-loop skills | `lark-okr`, `eos-lite` (`Skill(eos-lite) weekly`) |
| Step-by-step execution | [`operation-runbook.md`](../projects/2607-vibe-code-rescue/operation-runbook.md) - START HERE for any fresh session |
| Foundational premises | [`rescue-sprint/assumptions-register.md`](../projects/2607-vibe-code-rescue/rescue-sprint/assumptions-register.md) - kill-criteria live here |

## Changelog (resolved issues + closed rocks move here, newest first)

| Date | Change |
|---|---|
| 2026-08-08 | Rewrote this file: 110→~90 lines, bound §1 to `pipeline.md` instead of duplicating a second scorecard, fixed the KR2 Nov-15/Nov-30 date conflict, replaced the 3 stale "all-resolved" Issues with the real ones, cut the paid-pilot rock (superseded by 20.09), deleted the stale §0 snapshot in favor of linking the runbook. |
| 2026-07-22 | Prospect list populated (P8, 25 rows) · price band confirmed ($2,500/$7,500/$10,000) |
| 2026-07-21 | White-label partner locked · offer/kit/booking drafts done |
