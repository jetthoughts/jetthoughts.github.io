> DRAFT - cold-eyes fixes applied; ready for Paul to set up (~5 min)

# Booking-Page Spec - Free Rescue Context Call (Card S0)

**Owner**: Paul Keen | **Sprint**: Rescue Demand Sprint (2026-07-21) | **Card**: S0 (measurement prerequisite)
**Path**: lean - external Cal.com or NeetoCal booking page, no site change. ~5 minutes to set up in Paul's own account.
**Output**: one live booking URL that replaces every `[BOOKING_LINK]` placeholder across the offer one-pager and the warm-intro/referral kit. **Live URL**: https://jetthoughts.neetocal.com/free-code-audit-find-out-whats-actually-broken-before-you-spend-another-dollar

---

## Why an external booking link, not the contact form

The `operating-system.md` scorecard watches **discovery calls booked** as the leading KPI on the road to one signed rescue by Nov 30. The current contact form can't feed that number cleanly. Someone fills the form, Paul gets an email, then he replies, proposes times, and waits - and only some of those turn into a call on the calendar. He has to tally them by hand, and the count lags reality.

A Cal.com or NeetoCal link closes that gap. A founder clicks, picks a slot, and it lands on Paul's calendar as a booked call. Every booking is one auto-counted "discovery call booked" - the exact figure the weekly scorecard needs, with no manual counting. The tool also handles time zones, sends reminders, and holds a buffer, so Paul stops playing email tag and no-shows drop.

---

## Set-up spec

Paul builds this once in his Cal.com or NeetoCal account.

| Field | Value |
|---|---|
| **Event name** | Free Rescue Context Call (45 min) |
| **Duration** | 45 minutes |
| **Buffer** | 10 minutes after each call (notes/scheduling the async audit kickoff) |
| **Location** | Video call (Google Meet / Zoom - whichever Paul already uses) |
| **Availability** | Paul's real open blocks; cap at 2-3 slots/day so calls don't swamp delivery |

### Intake questions (ask all five)

1. **Company name + website** - so Paul walks in already oriented.
2. **What did you build it with?** Dev shop, freelancer, offshore team, or an AI tool (Lovable, Cursor, Bolt, Replit)? Name it. - flags the AI-built builds this offer is aimed at.
3. **What's breaking right now?** The symptom that made you book. - surfaces the pain and pre-qualifies the call.
4. **Funding stage** - bootstrapped, pre-seed, seed, or Series A? - confirms budget fit (ICP-E is pre-seed to Series A).
5. **Can you get access to the code, task board, and dev chats?** Do you have admin rights on GitHub/GitLab, Jira/Linear, and Slack/Teams, or does the dev shop still hold them? - the async audit needs read-only access to all three; this pre-qualifies the call AND surfaces the "hostage" pain (ICP pain #13).

### Confirmation message copy

> You're booked. Here's what happens: we spend 45 minutes understanding your situation and collecting read-only access to your code, task board, and dev chats. Then our team runs an intensive, AI-assisted audit offline and sends you a one-page, plain-English scorecard within 48 hours — what's solid, what's fragile, and whether to salvage or rebuild. If you can, bring read access to your repo (GitHub, GitLab, wherever the code lives). Nothing else to prep. See you soon.
>
> - Paul

---

## After the link is live

- ✅ Paste the real booking URL over every `[BOOKING_LINK]` slot in `warm-intro-referral-kit.md` (the forwardable blurb) and in the offer one-pager. Live URL: https://jetthoughts.neetocal.com/free-code-audit-find-out-whats-actually-broken-before-you-spend-another-dollar.
- Make the pipeline sheet the single source of truth, and link it from `operating-system.md` §7.
- Define the attribution rule: a call booked through this link counts as a discovery call; tag its source (warm intro, referral, or LinkedIn) so the scorecard shows which channel fed it.
