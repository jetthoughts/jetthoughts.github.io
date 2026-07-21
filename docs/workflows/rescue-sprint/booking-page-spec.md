> DRAFT - cold-eyes fixes applied; ready for Paul to set up (~5 min)

# Booking-Page Spec - Free Code Audit (Card S0)

**Owner**: Paul Keen | **Sprint**: Rescue Demand Sprint (2026-07-21) | **Card**: S0 (measurement prerequisite)
**Path**: lean - external Cal.com or NeetoCal booking page, no site change. ~5 minutes to set up in Paul's own account.
**Output**: one live booking URL that replaces every `[BOOKING_LINK]` placeholder across the offer one-pager and the warm-intro/referral kit.

---

## Why an external booking link, not the contact form

The `operating-system.md` scorecard watches **discovery calls booked** as the leading KPI on the road to one signed rescue by Nov 30. The current contact form can't feed that number cleanly. Someone fills the form, Paul gets an email, then he replies, proposes times, and waits - and only some of those turn into a call on the calendar. He has to tally them by hand, and the count lags reality.

A Cal.com or NeetoCal link closes that gap. A founder clicks, picks a slot, and it lands on Paul's calendar as a booked call. Every booking is one auto-counted "discovery call booked" - the exact figure the weekly scorecard needs, with no manual counting. The tool also handles time zones, sends reminders, and holds a buffer, so Paul stops playing email tag and no-shows drop.

---

## Set-up spec

Paul builds this once in his Cal.com or NeetoCal account.

| Field | Value |
|---|---|
| **Event name** | Free Code Audit (45 min) |
| **Duration** | 45 minutes |
| **Buffer** | 10 minutes after each call (write-up time for the one-page assessment) |
| **Location** | Video call (Google Meet / Zoom - whichever Paul already uses) |
| **Availability** | Paul's real open blocks; cap at 2-3 slots/day so audits don't swamp delivery |

### Intake questions (ask all five)

1. **Company name + website** - so Paul walks in already oriented.
2. **What did you build it with?** Dev shop, freelancer, offshore team, or an AI tool (Lovable, Cursor, Bolt, Replit)? Name it. - flags the AI-built builds this offer is aimed at.
3. **What's breaking right now?** The symptom that made you book. - surfaces the pain and pre-qualifies the call.
4. **Funding stage** - bootstrapped, pre-seed, seed, or Series A? - confirms budget fit (ICP-E is pre-seed to Series A).
5. **Can you get access to the code?** Do you have it on GitHub/GitLab, or does the dev shop still hold it? - the audit needs read access to run; this pre-qualifies the call AND surfaces the "hostage" pain (ICP pain #13) before Paul spends 45 minutes on a call he can't deliver.

### Confirmation message copy

> You're booked. Here's what happens: one of our senior engineers spends 45 minutes with you and your codebase, then sends you a one-page, plain-English assessment - what's solid and what to fix first. If you can, bring read access to your repo (GitHub, GitLab, wherever the code lives). Nothing else to prep. See you soon.
>
> - Paul

---

## After the link is live

- Paste the real booking URL over every `[BOOKING_LINK]` slot in `warm-intro-referral-kit.md` (the forwardable blurb) and in the offer one-pager.
- Make the pipeline sheet the single source of truth, and link it from `operating-system.md` §7.
- Define the attribution rule: a call booked through this link counts as a discovery call; tag its source (warm intro, referral, or LinkedIn) so the scorecard shows which channel fed it.
