> ⛔ **RETIRED 2026-08-08. Superseded by [`p7-search-sweep.md`](p7-search-sweep.md).**
> Two structural flaws, not fixable by better keywords: (1) F5Bot matches **literal substrings**, so composed phrases never fire - v1 matched 0 of our 25 hand-found posts; (2) it is **passive**, catching only mentions from setup-time forward, so it can never backfill the ≤30-day window card #29 needs on demand.
> Kept for the v2 keyword derivation (§Keywords v2), which the replacement doc reuses. Do not run the F5Bot setup steps below.

# P7 F5Bot setup + first pull - prospect rows + VoC
> Output of backlog task P7. Qualify per t4-t5-grooming.md Vote 3. Every why-ICP must be a verbatim quoted sentence.
> F5Bot account: logged in (Paul's credentials, NOT stored in any file).

## Setup status (HISTORICAL - state as of retirement, do not act on)

| Item | Status |
|------|--------|
| F5Bot login | Logged in |
| Keywords added | 5 of 6 (free plan limit = 5) |
| RSS/JSON feed | Not available on free plan - alerts sent via email instead |
| First feed pull | No results yet (keywords just added, F5Bot sends digests periodically) |

### Keywords configured (scoped to Reddit + Hacker News + Lobsters)
**v1 set — RETIRED 2026-07-25, zero mentions.** Root cause is mechanical, not bad luck: F5Bot matches literal substrings, and these were 3-5-word composed phrases (`vibe coded broke`, `Lovable app broken`, `Replit app broke`, `can't access my code`, `agency won't give code`) that never occur verbatim — they match 0 of the 25 posts we found by hand. Do not restore. (`dev shop ghosted` never fit the 5-keyword free cap.)

### Keywords v2 (the derivation `p7-search-sweep.md` reuses - do NOT configure these in F5Bot)

Derived from phrase counts in our OWN captured verbatim quotes (voice-of-customer.md + cold-prospect-list.md) — keywords founders literally type:

| # | Keyword | Evidence in corpus | Lane |
|---|---|---|---|
| 1 | `non-technical founder` | "non-technical" 20× — the ICP's literal self-identifier | all triggers |
| 2 | `vibe coded` | the past-tense personal form in distress posts ("I vibe coded my app and...") — bare `vibe coding` would flood/throttle | Trigger 1 |
| 3 | `lovable app` | "lovable" 8× ("my Lovable app broke") | Trigger 1 |
| 4 | `replit app` | "replit" 16× | Trigger 1 |
| 5 | `dev shop` | Trigger-3 hostage lane — grooming proved it unfindable via open search, so passive monitoring is its only coverage | Trigger 3 |

### Free plan limitation (HISTORICAL)
F5Bot's free tier: 5 keywords, email digest alerts only. RSS/JSON feed requires paid plan. This constraint is part of why the tool was retired; it no longer applies to anything.

## Rows
| handle/channel | source URL | trigger# | why-ICP (verbatim quote) | verdict |
|---|---|---|---|---|

*(None. F5Bot was retired before any digest produced a match. New rows go to `p7-search-sweep.md`.)*

## VoC (verbatim founder lines - force-tag Push/Pull/Anxiety/Habit + speaker tag + URL)
*(None - see above.)*
