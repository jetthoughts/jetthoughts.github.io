# P7 Date-filtered active search sweep - method + prospect rows + VoC

> The sole P7 sourcing method. Output of backlog card #29's sourcing lane.
> Qualify per `t4-t5-grooming.md` **Vote 3 v2** (5 checks). Every why-ICP must be a verbatim quoted sentence + URL.
> **Created**: 2026-08-08 | **Role**: the load-bearing expansion mechanism for the ≤30-day lead window.

---

## 1. The rule this method exists to satisfy

Card #29 needs rows verified inside a ≤30-day window **on demand**. Two properties follow, and any tool lacking either is disqualified:

- **Active, not passive.** A monitor only knows what arrived after you switched it on, so it can never backfill a window. Search queries the index on demand and reaches backwards.
- **Ranked retrieval, not literal matching.** Founders do not type our phrasing verbatim. A substring matcher fed composed phrases (`vibe coded broke`) returns nothing; ranked retrieval still surfaces partial and reordered matches.

Recency must also be a first-class filter (`after:`), not an accident of setup time.

_(Learned the expensive way: a passive substring monitor ran here from 2026-07-25 to 2026-08-08 and matched 0 of the 25 posts we had already found by hand. Neither flaw was fixable by better keywords - the mismatch was structural. Do not re-introduce one.)_

---

## 2. Date arithmetic - regenerating the window

Google's `after:YYYY-MM-DD` is inclusive of the named date. Paul's rule is **leads = ≤30 days, no exceptions**.

```text
WINDOW_START = TODAY - 30 days
```

Compute it, never eyeball it:

```bash
date -u -d '30 days ago' +%Y-%m-%d      # GNU/Linux
date -u -v-30d +%Y-%m-%d                # macOS/BSD
```

Worked example for this run:

| Anchor | Value |
|---|---|
| TODAY | `2026-08-08` |
| WINDOW_START (-30d) | `2026-07-09` → operator `after:2026-07-09` |
| Tighter sweep (-14d) | `2026-07-25` → `after:2026-07-25` |
| Daily-watch sweep (-7d) | `2026-08-01` → `after:2026-08-01` |

Substitute `after:2026-07-09` wherever the bank below writes `after:{WINDOW_START}`.

---

## 3. Copy-paste query bank

**Keyword set** (v2, derived from phrase counts in our own captured corpus - `voice-of-customer.md` + `cold-prospect-list.md`, not invented):
`non-technical founder` · `vibe coded` · `lovable app` · `replit app` · `dev shop` · `bolt.new` · `cursor` · `base44`

Derivation - what each term is grounded in (counts re-verified 2026-08-08 across both corpus files):

| Keyword | Corpus evidence | Lane |
|---|---|---|
| `non-technical founder` | "non-technical" 20× - the ICP's literal self-identifier | all triggers |
| `vibe coded` | 2× in the past-tense personal form ("I vibe coded my app and..."); the bare gerund `vibe coding` is commoner at 10× but floods with commentary, not distress | Trigger 1 |
| `lovable app` | "lovable" 8× ("my Lovable app broke") | Trigger 1 |
| `replit app` | "replit" 16× | Trigger 1 |
| `cursor` | 5× | Trigger 1 |
| `dev shop` | **none - 0 occurrences of `dev shop`/`devshop`, 1 of `agency`** | Trigger 3 |
| `bolt.new`, `base44` | none - tool-name expansion by analogy with Lovable/Replit, not corpus-derived | Trigger 1 |

**Watch the bottom three rows.** `dev shop` carries the Trigger-3 ownership/hostage lane. §3.6 already documents why: open keyword search for Trigger 3 mostly returns competitor SEO articles, not real threads, so P7 has no reliable *discovery* lane for it and Trigger-3 coverage stays with P6. `dev shop` still runs in the §3.1/3.2/3.4 query banks below as a cheap opportunistic catch, but a zero result on it is **expected, not a fresh signal** - do not read a zero here as new evidence. What changed 2026-08-08 is the coverage argument: Trigger 3's only *other* channel was passive monitoring, and that's retired. So if P6 (competitor comments) also runs dry over consecutive sprints, escalate then - Trigger 3 needs a different venue or re-testing as a premise. `bolt.new`/`base44` are cheap tool-name guesses with no corpus backing; drop them after two **valid** sweeps (one that actually reached an openable venue, per §4) return nothing - a tooling-blocked run doesn't count toward that.

Run each as-is in a Google-operator-honouring search surface. Replace the date token first.

### 3.1 Reddit - highest founder density (excerpt queue + VoC only, never lead rows)

> Reddit is excerpt-only per the shared wrapper (`t4-t5-grooming.md` lane split), and a P7 lead row requires `verified date` read from the opened thread - so a Reddit candidate can never clear Vote 3 check 3 inside P7. Run these queries to feed the excerpt queue and VoC capture; Reddit leads are out of P7's scope.

```text
site:reddit.com "non-technical founder" ("broke" OR "broken" OR "stuck") after:{WINDOW_START}
site:reddit.com "vibe coded" ("can't fix" OR "no idea how to fix") after:{WINDOW_START}
site:reddit.com "lovable app" ("broke" OR "broken" OR "help") after:{WINDOW_START}
site:reddit.com "replit app" ("broke" OR "deleted" OR "help") after:{WINDOW_START}
site:reddit.com "dev shop" ("ghosted" OR "won't give" OR "still owns") after:{WINDOW_START}
site:reddit.com ("bolt.new" OR "base44") ("stuck" OR "broke" OR "not technical") after:{WINDOW_START}
```

Sub-scoped variants (narrower, cleaner - run when the broad sweep floods):

```text
site:reddit.com/r/replit "not technical" after:{WINDOW_START}
site:reddit.com/r/nocode "non-technical founder" after:{WINDOW_START}
site:reddit.com/r/vibecoding ("paid a developer" OR "hired someone") after:{WINDOW_START}
site:reddit.com/r/SaaS "vibe coded" ("broke" OR "rebuild") after:{WINDOW_START}
site:reddit.com/r/startups "non-technical founder" ("agency" OR "freelancer") after:{WINDOW_START}
site:reddit.com/r/Solopreneur ("lovable app" OR "replit app") after:{WINDOW_START}
site:reddit.com/r/founder "dev shop" after:{WINDOW_START}
```

### 3.2 IndieHackers - run-first venue per grooming (real handles, low outreach hostility)

```text
site:indiehackers.com "non-technical founder" ("stuck" OR "broke" OR "broken") after:{WINDOW_START}
site:indiehackers.com "vibe coded" ("can't fix" OR "falling apart") after:{WINDOW_START}
site:indiehackers.com ("lovable app" OR "replit app" OR "bolt.new") ("broke" OR "stuck") after:{WINDOW_START}
site:indiehackers.com "dev shop" ("ghosted" OR "owns my code" OR "won't hand over") after:{WINDOW_START}
site:indiehackers.com "cursor" "not a developer" after:{WINDOW_START}
```

### 3.3 Hacker News

```text
site:news.ycombinator.com "vibe coded" ("broke" OR "rewrite") after:{WINDOW_START}
site:news.ycombinator.com ("lovable app" OR "replit app" OR "base44") after:{WINDOW_START}
```

> HN caveat: P3 was retired at 0 rows (2026-07-22) - HN is dev-dominated and produced no founder voices. Run these for **VoC only**, not leads.

### 3.4 X / Twitter

```text
site:x.com "vibe coded" ("broke" OR "can't fix") after:{WINDOW_START}
site:x.com "non-technical founder" ("lovable" OR "replit" OR "bolt.new") after:{WINDOW_START}
site:x.com "dev shop" ghosted after:{WINDOW_START}
```

**X date shortcut**: a status URL's numeric ID encodes its timestamp, so you can verify a date without opening the page. Snowflake epoch is `1288834974657` ms:

```bash
id=2070153296862728515
date -u -d @$(( ((id >> 22) + 1288834974657) / 1000 )) +%Y-%m-%d   # -> 2026-06-25
```

This is the one venue where `verified date` can be derived deterministically. Everywhere else, open the thread.

### 3.5 Lobsters

```text
site:lobste.rs "vibe coded" after:{WINDOW_START}
```

Lowest-yield venue. Run last, or skip when time-boxed.

### 3.6 Trigger 3 (ownership/hostage) - no search lane

Grooming proved open keyword search for Trigger 3 returns ~9/10 competitor SEO articles, and no `site:` query reliably lands on competitor-article *comments* rather than an OP or an unrelated thread - logging an OP from such a query would violate Vote 3. This sweep therefore carries **no Trigger-3 lane**. Trigger-3 coverage stays with P6 (seeded competitor rescue-post comment sections, commenters only, never the OP).

---

## 4. Honest limitations

Read these before trusting a zero-result sweep.

1. **Index lag.** Google may not index a post for hours to days. A genuinely fresh distress post can be invisible to `after:` on the day it matters most. A zero-result sweep means "not indexed yet or not there" - it never means "nothing happened."
2. **`after:` is unreliable per-site.** The operator filters on Google's *inferred* document date. Reddit and X pages are frequently re-crawled and re-dated, and IH listing pages carry no stable date, so `after:` silently drops valid results and admits stale ones. Treat it as a **noise reducer, never as the verification**. Vote 3 check 3 still requires a timestamp read from the opened thread.
3. **Reddit is excerpt-only** per existing policy (`t4-t5-grooming.md` lane split), and P7 does not open Reddit threads - which means Reddit candidates can never fill `verified date` + `thread health` inside P7 and are **excluded from P7 lead rows by rule** (see §3.1). Capture sub + handle + URL + the excerpt quote for the excerpt queue and VoC only.
4. **Search surfaces vary in operator support.** Some tools accept `site:`/`after:` as plain text and quietly ignore them, returning semantically similar SEO articles instead - see §6 for exactly this failure. Sanity-check every sweep: if results contain off-domain marketing pages, your operators are being dropped and the sweep is invalid.
5. **Competitor SEO dominates the rescue keywords.** Six rescue shops own this vocabulary. Any result that reads like an article rather than a person is noise by default.
6. **`site:` does not reach login-walled content.** Whatever needs auth stays invisible. That is a permanent coverage hole, not a tuning problem.

---

## 5. Cadence + dedupe

**Cadence: weekly, every Monday.** Rationale, not a round number:

- The lead window is 30 days. A weekly run means any given post is caught with ~23 days of usable life left - enough for opener drafting, Paul's approval, and the send.
- Weekly also absorbs limitation #1: a post missed for index lag on run *N* is caught on run *N+1*, still well inside the window.
- Use `after:{TODAY-7}` for the Monday sweep once the pipeline is steady-state. Use the full `after:{TODAY-30}` only on a cold start or after a skipped week.
- Do not run daily. Index lag means daily runs mostly re-return the same rows, and the venue-politeness cap from grooming (batch of 8-10, don't hammer one domain) still applies.

**Dedupe - the normalized thread URL is the join key** (same rule as P8):

1. Normalize the candidate URL FIRST - strip `?utm_*` params and trailing slashes, and rewrite `old.reddit.com` to `www.reddit.com`. The normalized form is what you grep for and what you log.
2. Then grep the merged list and every sibling file for it:
   ```bash
   cd docs/projects/2607-vibe-code-rescue/rescue-sprint
   rg -F "<normalized-url>" cold-prospect-list.md prospects/
   ```
3. A hit anywhere = skip the row. Do not re-log under a different handle.
4. Keep a `### Seen-and-skipped` list in this file with the reason (`already row 14` / `stale, VoC only` / `supplier`) so the next sweep does not re-adjudicate the same URL from scratch.
5. Same thread, genuinely different commenter = a separate row, per P8's existing rule. Same person twice = one row.

---

## 6. Run log - 2026-08-08 (first execution)

**Result: ZERO qualified lead rows. The sweep could not be executed as designed in this environment.**

This is a tooling failure, not a finding about the market. Recorded in full so the next session does not repeat it.

### What was tried

| # | Attempt | Outcome |
|---|---|---|
| 1 | `site:reddit.com "non-technical founder" app broke after:2026-07-09` | Operators **ignored**. Returned Substack essays, a university events page, Goodreads. Zero reddit.com results. |
| 2 | `site:indiehackers.com "non-technical founder" stuck app after:2026-07-09` | Partial - IH URLs returned, but `after:` had no effect; results included posts dated 2025-07 and 2026-03. |
| 3 | Search restricted to `reddit.com` via the tool's native domain filter | **Hard 400**: "The following domains are not accessible to our user agent: ['reddit.com']". Reddit is unreachable by search here, not merely excerpt-limited. |
| 4 | Search restricted to `indiehackers.com` (3 query variants, founder-voice phrasing) | Returned only threads **already in `cold-prospect-list.md`** (`looking-to-help-non-technical-founders-6e1d9b33ae` = rows 15-18; `i-am-frustrated-with-no-code-i-am-done-14a7ce60cb` = row 21) plus supplier/agency posts and generic advice articles. Zero new founder threads. |
| 5 | Search restricted to `x.com` | Returned 9 results. Dates derived via the §3.4 snowflake method: newest was **2026-06-29 (40 days old)**; the rest ranged 2025-03 to 2026-06. **Every result was a supplier, agency, or commentator**, not an ICP founder. Zero rows. |
| 6 | `WebFetch` on `indiehackers.com`, `news.ycombinator.com`, `old.reddit.com`, `lobste.rs`, and one unrelated marketing domain | **All `EGRESS_BLOCKED`** by the network proxy. |
| 7 | `curl "$HTTPS_PROXY/__agentproxy/status"` | Proxy healthy, `recentRelayFailures: []`. The blocks are a deliberate egress allowlist, not a transient fault. |

### Why zero rows is the only defensible output

Vote 3 check 3 requires the **actual post timestamp read from the opened thread, never inferred from a search excerpt** - that check exists specifically because batch-1's 60% failure came from eyeballing recency off excerpts. In this environment **no thread of any venue can be opened** (attempt 6). Every candidate therefore fails check 3 by construction.

Even setting that aside, the sweep surfaced no new ICP candidates: attempt 4 returned only known threads and suppliers, and attempt 5's freshest item was 40 days old and off-ICP. Logging anything here would mean either (a) inventing a date, or (b) re-logging a row already in the merged list. Both are the exact defects card #28 was filed to stop.

### What the next session needs

The method in §1-5 is sound and unchanged - it needs a runner with the tools grooming already specifies:

- **`chrome-devtools`** (`new_page` / `take_snapshot` / `close_page`) - the tool Vote 2 and the grooming tool list actually name. It is what makes check 3 and check 5 possible. It was not available here.
- **A search surface that honours `site:` and `after:`** - verify with the §4 sanity check before trusting any sweep.
- Egress access to `indiehackers.com` and `reddit.com` at minimum.

Until at least one venue is openable, card #29 cannot produce verified-fresh rows by any method - this is a **blocked-on-tooling** state, not a "search harder" state. Note this does NOT reopen the retired passive monitor: it was never going to deliver on-demand backfill either, so the block is not an argument for going back.

---

## Rows

| handle/channel | source URL | verified date | post\|comment | trigger# | why-ICP (verbatim quote) | verdict | thread health | best path |
|---|---|---|---|---|---|---|---|---|

*(No rows. Zero candidates cleared Vote 3 - see §6. Nothing was padded, inferred, or carried over from the v1 list.)*

### Seen-and-skipped (do not re-adjudicate)

| URL | Reason |
|---|---|
| indiehackers.com/post/looking-to-help-non-technical-founders-6e1d9b33ae | Already rows 15-18 in `cold-prospect-list.md` |
| indiehackers.com/post/i-am-frustrated-with-no-code-i-am-done-14a7ce60cb | Already row 21 |
| indiehackers.com/post/agency-offering-backend-full-stack-dev-for-non-technical-founders-... | **Supplier** - agency advertising. Never log. |
| indiehackers.com/post/i-review-ai-built-codebases-for-a-living-heres-what-s-actually-inside-them-... | **Supplier** - competitor rescue offer. Mine commenters only (P6 lane). |
| indiehackers.com/post/from-prototype-to-production-how-replit-lovable-bolt-and-v0-power-your-mvp-... | **Supplier** - Vibeship vendor post. |
| x.com/PrajwalTomar_/status/2070153296862728515 | Supplier (agency, "60+ apps at the agency"). Derived date 2026-06-25 - outside window anyway. |
| x.com/leojr94_/status/1970481417009443229 | Supplier/acquirer ("we are taking over"). Derived date 2025-09-23. |
| x.com/GergelyOrosz/status/1946783581570736362 | Commentator, not founder. Derived date 2025-07-20. |

## VoC (verbatim founder lines - force-tag Push/Pull/Anxiety/Habit + speaker tag + URL)

**Zero `[VERBATIM-founder]` lines captured this run.** VoC has no age limit, so a stale thread would still have been harvested - but no thread could be opened, and the verbatim rule ("word-for-word, zero paraphrase") cannot be met from a search-result summary.

The following surfaced as quoted strings in search-result titles. They are **not admitted to `voice-of-customer.md`** - all are non-founder speakers, and none is confirmed word-for-word against the source page. Listed only so the next session does not re-derive them:

- `[UNVERIFIED - VERBATIM-dev/team]` "Most people are not Vibe Coding. They are panic prompting. They open Cursor, paste a vague idea, accept every diff, break the app, prompt harder, create a worse bug, then blame the model." - Ziwen (commentator), https://x.com/ziwenxu_/status/2057165083180929140 (derived date 2026-05-20)
- `[UNVERIFIED - VERBATIM-dev/team]` "Shipping the first working version as if it is production-ready is." - Louis-Francois Bouchard (commentator), https://x.com/Whats_AI/status/2071579616943239251 (derived date 2026-06-29)

Neither is promotable to the phrase bank - the bank is built **only** from `[VERBATIM-founder]` lines.
