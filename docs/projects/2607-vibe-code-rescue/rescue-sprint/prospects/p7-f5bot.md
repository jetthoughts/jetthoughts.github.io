> ⛔ **RETIRED 2026-08-08. Superseded by [`p7-search-sweep.md`](p7-search-sweep.md).**
> Two structural flaws, not fixable by better keywords: (1) F5Bot matches **literal substrings**, so composed phrases never fire - v1 matched 0 of our 25 hand-found posts; (2) it is **passive**, catching only mentions from setup-time forward, so it can never backfill the ≤30-day window card #29 needs on demand.
> Kept for the v2 keyword derivation (§Keywords v2), which the replacement doc reuses. Do not run the F5Bot setup steps below.

# P7 F5Bot setup + first pull - prospect rows + VoC
> Output of backlog task P7. Qualify per t4-t5-grooming.md Vote 3. Every why-ICP must be a verbatim quoted sentence.
> F5Bot account: logged in (Paul's credentials, NOT stored in any file).

## Setup status

| Item | Status |
|------|--------|
| F5Bot login | Logged in |
| Keywords added | 5 of 6 (free plan limit = 5) |
| RSS/JSON feed | Not available on free plan - alerts sent via email instead |
| First feed pull | No results yet (keywords just added, F5Bot sends digests periodically) |

### Keywords configured (scoped to Reddit + Hacker News + Lobsters)
**v1 set — RETIRED 2026-07-25, zero mentions.** Root cause is mechanical, not bad luck: F5Bot matches literal substrings, and these were 3-5-word composed phrases (`vibe coded broke`, `Lovable app broken`, `Replit app broke`, `can't access my code`, `agency won't give code`) that never occur verbatim — they match 0 of the 25 posts we found by hand. Do not restore. (`dev shop ghosted` never fit the 5-keyword free cap.)

### Keywords v2 (Paul: replace all five in F5Bot with these)

Derived from phrase counts in our OWN captured verbatim quotes (voice-of-customer.md + cold-prospect-list.md) — keywords founders literally type:

| # | Keyword | Evidence in corpus | Lane |
|---|---|---|---|
| 1 | `non-technical founder` | "non-technical" 20× — the ICP's literal self-identifier | all triggers |
| 2 | `vibe coded` | the past-tense personal form in distress posts ("I vibe coded my app and...") — bare `vibe coding` would flood/throttle | Trigger 1 |
| 3 | `lovable app` | "lovable" 8× ("my Lovable app broke") | Trigger 1 |
| 4 | `replit app` | "replit" 16× | Trigger 1 |
| 5 | `dev shop` | Trigger-3 hostage lane — grooming proved it unfindable via open search, so passive monitoring is its only coverage | Trigger 3 |

### Free plan limitation
F5Bot's free tier: 5 keywords, email digest alerts only. RSS/JSON feed requires paid plan. Paul will receive email alerts when matches appear on Reddit, HN, or Lobsters. The first digest should arrive within 24-48 hours of keyword setup.

### Next step when alerts arrive
When Paul receives the first F5Bot email digest:
1. Open the email and click through to each matching thread
2. Qualify per Vote 3 (non-technical founder, not dev venting, not supplier)
3. Log ICP matches to this file with verbatim quotes
4. Target ≥3 rows if any matched

## Rows
| handle/channel | source URL | trigger# | why-ICP (verbatim quote) | verdict |
|---|---|---|---|---|

*(No rows yet - awaiting first F5Bot digest. Keywords are live and monitoring.)*

## VoC (verbatim founder lines - force-tag Push/Pull/Anxiety/Habit + speaker tag + URL)
*(Awaiting first digest results.)*
