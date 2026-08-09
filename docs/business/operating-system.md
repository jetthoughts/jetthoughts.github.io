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
**Kill-check**: the re-based C1 kill-criteria (register addendum 2026-08-08: "2 weeks of active outreach across live lanes yields 0 booked calls → pause, re-open A + C") has **not fired** - its clock starts at the first LinkedIn post or first send, and neither has happened. Don't read that as safe: it means we don't even have the data the criteria needs. See Issue 2.
**Where sessions went this week**: mostly 2605 (course wave completion, W1-W5) and 2510 (content re-plan), plus this session's 2607 sourcing-tool diagnosis. That allocation is why a distribution failure sat unflagged for 18 days - nobody was in the pipeline sheet.

---

## 2. Accountability chart

| Seat | Owner | Owns |
|---|---|---|
| **CEO / Sales / Trust layer** | Paul | Discovery calls, offer, pricing, founder relationship |
| **Delivery** | JT contractors + white-label partner | The rescue build (Rails), under JT brand. Both routes (CEO, 2026-08-09): three unallocated senior Rails contractors at zero bench cost, plus the partner for capacity |
| **Marketing / Content / Ops** | Claude Code (+ Paul review) | Content, SEO, landing, pipeline tracking, this OS |

## 3. OKR (Q3→Q4 2026) + kill-check

**Objective**: Land the first Vibe Code Rescue client and prove the machine.

| KR | Target | Status |
|---|---|---|
| KR1 - Offer + partner live | Priced, partner signed, landing CTA live | 🟢 partner ✓, priced ✓ ($2,500/$7,500/$10,000), booking link live ✓; full landing page still Blocked (card B1) |
| KR2 - Discovery calls booked | 8-12 by Nov 30 | 🔴 0. (Mid-Nov is an internal trend checkpoint, not a separate deadline - both KRs share one date now.) |
| KR3 - Audits delivered | 3-5 free Rescue Audits | 🔴 0 - blocked behind KR2 |
| KR4 - Rescue signed | 1 by Nov 30 | 🔴 0 - blocked behind KR3 |

**Kill-criteria (from the assumptions register, evaluated here weekly - this is the "runs automatically via OS-WEEKLY" promise, made real):** C1 test (re-based 2026-08-08) - 0 calls after 2 weeks of *active outreach across live lanes* (LinkedIn posts and/or verified sends) → pause, re-open A + C. Currently **untestable** - the clock hasn't started, see §1. A0 ICP test - if ≥half of early interest is technical or pre-launch founders, re-open the ICP vote. Not yet evaluable - zero interest of any kind so far.

## 4. Rocks (open only — realigned 2026-08-08 so the lanes SUM to KR2)

The arithmetic that forced the realignment: KR2 needs 8-12 calls; the cold lane at full success (10-15 verified rows, generous 20% reply-to-call) yields ~2-3. The cold lane cannot carry the KR alone — LinkedIn (now primary) plus inbound must carry the rest, with cold unblocked as the secondary and referral-asks as optional upside.

1. **Demand flowing from the live lanes** (re-weighted 2026-08-08 — Paul cannot enumerate 10 warm names, so the A0 C1 warm-primary premise is partially falsified; recorded as a dated addendum in the assumptions register):
   - **LinkedIn Stream 0 (PRIMARY)** - agent drafts, Paul posts, 3-4/wk total (20.09 §7). Cheapest unblock on the board: **Paul posts ICP post #1** (`linkedin-posts/icp-validation/POSTING-PACKET.md` - copy, paste, post). Reaches his network passively without naming anyone.
   - **Cold #29 (load-bearing again)** - BLOCKED-ON-TOOLING (`chrome-devtools` + egress to at least one of indiehackers.com / reddit.com). With warm gone this unblock is back on the critical path.
   - **Inbound (live floor)** - 6 funnel-linked founder-intent posts → `/services/vibe-code-rescue/` + the booking link; B1 landing is the capacity-blocked amplifier.
   - **Referral-ask (OPTIONAL side lane, not a gate)** - 2-3 past clients as referral sources via the kit templates, or T3 Gmail consent, or skip. Nothing waits on it.
2. **Landing page** (Aug) - card B1, blocked on nothing but capacity; booking link already live standalone.
3. **First send → first call** (Aug-Sep) - batch-1 from whichever lane opens first, then the daily reply-monitor.
4. **First audit → first signing** (Oct) - gated on Rock 3.

**Mid-point gate — Sep 30: ≥3 discovery calls booked, else pause and re-open A + C** (register wording). This is the falsifiable checkpoint between now and Nov 30; it exists so a re-plan can still happen while there is time to re-plan.

*Closed*: offer + partner locked (Jul 21). *Cut* (20.09, 2026-08-07): the paid-pilot rock - budget only matters once organic proves a reply signal, and the bet currently forbids a content sprint.

## 5. Issues (IDS - top 5, solve the highest-leverage one each week)

| # | Issue | Owner | Status |
|---|---|---|---|
| 1 | Sourcing BLOCKED-ON-TOOLING - #29's sweep can't open any thread to verify a timestamp | Infra/Paul | 🔴 Open since 2026-08-08 - see runbook §Card #29. **Load-bearing again** (2026-08-08): with the warm lane demoted, cold is the secondary demand lane and this unblock is back on the critical path |
| 2 | Kill-criteria untestable - zero posts posted, zero touches sent. Warm lane demoted 2026-08-08 (Paul can't enumerate 10 warm names - register addendum). **The cheapest unblock is now Paul posting LinkedIn ICP post #1** (packet ready: copy, paste, post); the re-based clock starts at first post or first send | Paul | 🔴 Open |
| 3 | Joy Adamson override - only survivor of batch-1, 5mo old, still publicly unanswered | Paul | 🟡 Open - **decide before first send** (she rides batch-1 or not at all) |
| 4 | Pricing vs. thesis tension - JT undercuts at $7,500 against $25-55K competitors one week after publishing "cheap developers are expensive," which argues against its own thesis to a twice-shy founder. Related: the category name "vibe code rescue" is now a competitor's page title, page 1 occupied - fight for it or differentiate? | Paul | 🟡 Open - **decide both before first send** (openers and the landing quote the offer) |
| 5 | vision-mission.md still stamped DRAFT, 18 days on, while other docs cite it as settled | Paul | 🟡 Open - 1-line decision: ship it or say what's wrong |
| 6 | G0 (partner lock) is marked Done on a CEO assertion, but its own definition-of-done is unmet - no paid trial rescue, no fallback partner named, and the cold-eyes handoff at runbook §G0 is still the empty placeholder. A2 pricing was confirmed off it anyway, which operating rule 1 forbids | Paul | 🟡 Open since 2026-08-09 - lower risk now that in-house is a second delivery route, but the gate is still open |

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
