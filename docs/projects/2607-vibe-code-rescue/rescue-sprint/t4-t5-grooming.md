> GROOMING — T4 (web cold) + T5 (Reddit/community cold). /brainstorming with voting, 3 sub-agents ideated (QueryStrategist, VoCWorkflow, ValidationDesigner). PENDING PAUL'S APPROVAL before any sourcing runs.

# T4/T5 Grooming — how a session builds the prospect list + harvests VoC

**Created**: 2026-07-22 | **Revised**: 2026-07-26 (Vote 3 → v2 rubric, card #28 — verified recency + routing + thread-health hard gates after batch-1 60% failure) | **Owner**: agent-built | **Feeds**: T6 dedupe → T7 openers → C0 send (Paul's desk P3)
**Inputs**: `sourcing-pipeline.md` (T2), `icp-trigger-taxonomy.md` (T1), `assumptions-register.md` (A0 D3), `voice-of-customer.md`, `customer-profile-four-forces.md`
**Method**: 3 background sub-agents ideated approaches; scored below; picks + carried evidence become the groomed cards.
**HARD-GATE**: this is the DESIGN. No actual sourcing (opening threads, writing rows) runs until Paul approves the design below.

---

## What the sub-agents produced

- **QueryStrategist** (discovery/query strategy) — full report + 3 live web_search probes.
- **VoCWorkflow** (throughput + VoC capture) — full report.
- **ValidationDesigner** (qualification rubric) — returned no report body; the qualification dimension is filled from QueryStrategist's acceptance criteria + VoCWorkflow's per-candidate loop + A0 D3 (5-question intake). Noted, not blocking.

---

## Vote 1 — Discovery strategy (how we FIND them)

Options (QueryStrategist): **A** site-scoped operator sweep · **B** first-person trigger-phrase sweep · **C** competitor-comment mining.

| Criterion (weight) | A. Site-scoped | B. First-person phrase | C. Competitor-comment |
|---|---|---|---|
| ICP-founders / unit effort (×3) | 5 | 3 | 3 |
| Precision — surfaces a real handle (×3) | 5 | 3 | 4 |
| Avoids SEO-article noise (×2) | 4 | 2 | 5 |
| Coverage across venues (×2) | 3 | 5 | 2 |
| **Weighted total** | **44** | **32** | **35** |

**Pick: A primary, C as the rescue-lane for Trigger 3 (ownership-hostage), B blended INTO A (add emotional first-person phrasing to a site-scoped query — never standalone).**

Forcing evidence (QueryStrategist live probes):
- **Proven failure**: a plain Trigger-3 keyword search (`developer won't give me code / agency owns my repo`) returned ~9/10 competitor rescue-shop SEO articles + zero founder threads. **The rescue shops own those keywords.** → Trigger 3 founders are found in the COMMENT layer of those very articles/subreddits, or via emotional phrasing SEO copy never uses ("he ghosted me", "I'm freaking out", "please help") — NOT open-web keyword search.
- Plain (non-`site:`) queries return articles, not founders — always weight `site:` operators.
- 4 real leads already surfaced (hand off to T6 to dedupe, do NOT re-find): **SpecBuildLab** (IndieHackers, non-tech Lovable, Trigger 1+7), a non-technical iOS founder (IndieHackers, latent Trigger 1), **jeancristof** (r/Solopreneur, 80/20 wall), **Living-Pin5868** (r/replit — a SUPPLIER post; mine its commenters, do not log the OP).
- New venues to add to the map: **r/replit, r/NoCode, r/Solopreneur, r/founder**.

## Vote 2 — Throughput / capture (how we RUN it)

Options (VoCWorkflow): **A** read-once extract-all per candidate · **B** two-phase shortlist-then-open · **C** excerpt-only harvest.

| Criterion (weight) | A. Read-once extract-all | B. Two-phase | C. Excerpt-only |
|---|---|---|---|
| Zero thread re-opens (×3) | 5 | 5 | 5 |
| Verbatim quotes possible (×3) | 5 | 5 | 1 |
| Fewest handoffs (×2) | 5 | 3 | 5 |
| Row/VoC can't drift (×2) | 5 | 3 | 2 |
| **Weighted total** | **50** | **42** | **32** |

**Pick: A (read-once, extract-all), fed by B's excerpt-triage front-end.** web_search excerpts build a cheap URL queue; one `chrome-devtools` open per queued URL produces validate + row + quotes in a single visit. Excerpt-only (C) rejected as capture (truncated/paraphrased violates the verbatim rule) — used ONLY to build the queue.

Core rule that kills rework: **open each thread exactly once; extract validation + row + quotes in that one visit.** Thread URL is the join key across rows / VoC / openers, so a row and its quotes physically can't drift.

## Vote 3 — Qualification rubric **v2** (revised 2026-07-26, card #28 — after batch-1 retro)

> **Why v2**: batch-1 Phase-1 pre-research (2026-07-26) found 3 of 5 P8-scored "ready" rows unsendable — Saul_E's post was from **2020** (6+ years), Afrikonnect's quote was a **~1-year-old comment on someone else's post** already pitched twice in-thread, and SANICE_AI's thread was **saturated by a competing "free" pitch**. v1's "When" check said "recent, not dead" but was eyeballed from `web_search` excerpts, never verified by reading the actual timestamp. Checks 3-5 below are now **HARD GATES enforced at capture/scoring time (P8)** — not deferred to send-time pre-research.

Per-candidate 5-check (one-word verdict `ICP` / `semi-ICP` / `drop`), applied in the single visit:
1. **Who** — OP is a **non-technical founder**, NOT a dev/team member venting about their own vibe-coding, NOT a supplier advertising rescue ("what I tell every founder…").
2. **What** — the app was built by a **shop / freelancer / AI tool** (Lovable/Bolt/Replit/Cursor), not hand-coded by the OP.
3. **When (VERIFIED)** — record the **actual post/comment timestamp read from the opened thread** — never inferred from a search excerpt. **Flat window, all venues: ≤30 days (Paul's rule, 2026-07-26: "for leads we need only actual — up to 1 month"). No venue exceptions.** Older = `drop` **as a lead**, logged with reason so it isn't re-found next pass — but see the lead-vs-voice split below: the thread is still harvested for VoC in the same visit.
4. **Where (routing)** — is the quote the target's **own post** or their **comment on someone else's thread**? Record `post` or `comment → route to commenter profile`. A comment-row's opener must address and route to the commenter (their profile/DM), never paste under the host's post. (Catches the Joy-Adamson-routing class of error at capture time, and the Afrikonnect mis-labeling — row 12 was logged as if Afrikonnect authored the post.)
5. **Thread health** — read ALL existing replies before logging: (a) **no competing rescue/audit-style pitch** already in-thread (any "free audit / free help / free build" offer, especially from spam-patterned accounts); (b) problem **not already solved/hired** in-thread; (c) **Paul hasn't already replied** anywhere in it. Saturated or solved = `drop` with reason.

Hard rules (from A0 D3 + QueryStrategist acceptance criteria + v2):
- ICP claim must trace to a **quoted sentence**, never inferred.
- **Zero supplier/agency posts logged as founder leads** — spot-check each handle.
- Trigger-3 rows come from **comment-mining**, not open-web keyword search (per the proven failure).
- `[VERBATIM-founder]` reserved for the non-technical founder who PAID someone; a dev venting = `[VERBATIM-dev/team]` (a different speaker T7 must not mirror as the founder).
- **NEW**: every row records `verified date` (the timestamp actually read) + `thread health` (`clean`, or the disqualifying note). **P8 MUST reject any row missing either field** — an excerpt-only candidate may enter the URL queue, but cannot enter the scored list until its one visit fills both.
- **NEW (quality over quota, Paul's directive 2026-07-26)**: do not pad toward a row-count target. 10-15 verified-fresh, unsaturated rows beat 25 rows carrying stale/saturated padding.

### Lead vs. voice — two harvests, one visit (Paul's policy, 2026-07-26)

| Harvest | Recency rule | Output |
|---|---|---|
| **Lead row** (`cold-prospect-list.md`) | **≤30 days, verified, all venues — no exceptions.** Leads expire; a reply to a stale thread reads as scraper spam. | Scored list → openers → send |
| **VoC quote** (`voice-of-customer.md`) | **NO age limit.** Any comment, message, or post is valid for learning the ICP's slang, phrasing, and emotional register — language doesn't expire. | Force buckets + phrase bank → opener/copy voice |

Operational rule: a thread `drop`ped for staleness or saturation is **not a wasted visit** — harvest its verbatim lines into VoC before closing it (same read-once economics as Vote 2). Example: Saul_E's 2020 "$55K to rebuild — money I don't have" thread is a dead lead but first-rate Push/Anxiety language. The recency gate filters WHO we contact, never WHAT we learn from.

---

## Lane split — T4 vs T5 (by fetchability)

| Task | Venues | Access | Method |
|---|---|---|---|
| **T4 — web cold (fetchable)** | **IndieHackers (run FIRST)**, Hacker News threads, X/Twitter first-person, competitor "free audit" comment threads (heydev/modall/attributex + the live competitor set) | `chrome-devtools` can open + read full post + comments | Read-once extract-all, site-scoped queries |
| **T5 — Reddit / community (mostly un-openable)** | r/replit, r/NoCode, r/Solopreneur, r/SaaS, r/startups, r/vibecoding, r/founder | Reddit thread **bodies not reliably fetchable**; web_search misses ~70% of Reddit | Excerpt capture (handle + URL + title from the excerpt). Un-blinding Reddit needs thread-open access; the keyword-feed route was tried and retired 2026-08-08 |

IndieHackers is the clear run-first venue: real posts + handles in the excerpt, fetch-free, low outreach hostility.

---

## Output schema — a SEPARATE cold-prospect table

VoCWorkflow flag (adopted): the warm `warm-intro-referral-kit.md` §1 table has **no thread-URL column** — public prospects need the URL join key. So public-thread rows land in a new `cold-prospect-list.md`, NOT shoehorned into the warm table.

Columns (v2, card #28): `handle/channel · source URL · **verified date** · **post|comment routing** · trigger # · why-ICP (quoted sentence) · verdict (ICP/semi-ICP) · **thread health** · best-contact path · status`.

VoC harvest lands in `voice-of-customer.md` (the four force sections) + the phrase bank, keyed by the same thread URL.

---

## Definition of DONE (both cards)

**Rows** (`cold-prospect-list.md`) — v2 targets (card #28):
- **10-15 verified-fresh public-prospect rows** (quality over the old ~30 quota), each with source URL + handle/channel + **verified date (≤ venue window)** + **post|comment routing** + one-line why-ICP (the Push signal, quoted) + verdict tag + **thread health = clean** + best-contact path.
- No two rows on the same thread. Warm rows stay in the warm kit; public rows here.
- Zero supplier/agency posts logged as founder leads.
- Zero rows missing `verified date` or `thread health` — those fields are the P8 admission gate.

**VoC** (`voice-of-customer.md`):
- ≥5 `[VERBATIM-founder]` lines each for **Push and Pull** (they generate demand — prioritized); ≥3 each for **Anxiety and Habit** (currently the thinnest — real switching-fear + "one more sprint"/sunk-cost lines).
- Every quote word-for-word, speaker-tagged, URL-attributed. Zero paraphrase in verbatim sections.
- Phrase bank ≥1 promotable mirror-phrase per force, built ONLY from `[VERBATIM-founder]` lines (closes the file's cold-eyes gap: today it's mostly `[VERBATIM-dev/team]` + one incident line).

**Handoff to T6/T7**: T7 assembles openers by picking Push words + Pull wedge + one Anxiety pre-empt from the force buckets — WITHOUT re-opening a single thread (force-tag is the interface).

---

## Politeness / anti-ban / data-hygiene (read-only public prospecting)

- Open public URLs, read, close. **No login, posting, DMs, votes, or auth-gated scraping.** Human-pace navigation.
- Batch of 8-10, `close_page` between each; don't hammer one domain. Reddit: prefer `old.reddit.com` public view; if a URL won't load without login, **DROP it** — never force.
- Store only already-public content: handle-as-shown + public URL + verbatim quote. No emails, no real names beyond a public handle, no deanonymizing. If content is later deleted, treat it as stale. Converting a handle to a contacted lead is Paul's manual step (P3).

---

## Tools (available only)

- `mcp__parallel__web_search` — `site:` operators + first-person phrasing → build the excerpt URL queue.
- `chrome-devtools` (`new_page` / `take_snapshot` / `close_page`) — open IH/HN/X/competitor threads, read full post + comments, validate+row+quotes in one visit.
- **Date-filtered active search** (`prospects/p7-search-sweep.md`) — `site:` + `after:{TODAY-30}` query bank across Reddit/IH/HN/X/Lobsters. Replaced the passive keyword feed retired 2026-08-08; do not re-introduce a passive or substring-matching monitor.
- **Not used**: `web_fetch` on Reddit (unreliable), Apollo/Hunter (paid, Paul's desk), Gmail (that's T3 warm lane, needs Paul's consent).

---

## Assumption trace (runbook rule 7)

These are refinements of the **already-registered** A0 find-channel premise (warm primary + cold-community secondary) and pre-validation D3 (5-question intake incl. repo-access gate) — NOT new premises, so no new A0 vote is required. The one sharpened learning to fold back into A0 on the first cohort: **open-web keyword search for the ownership-hostage trigger is dominated by competitor SEO** — a channel-cost fact, not a new bet.

---

## Cold-eyes (LIGHT, self-refute)

**Refute**: "Will a session running this produce 30 real ICP rows + verbatim founder quotes, not noise?"
- Discovery pick is backed by a PROVEN probe (site-scoped IH beats keyword search; Trigger-3 keyword search fails) — not a guess. PASS.
- **Objection that holds**: the ~30-row target leans on Reddit, which is the least-fetchable venue. Mitigation: IndieHackers (fetchable, run-first) + HN + X + competitor comments carry the fetchable load; Reddit contributes via excerpts, not as the primary — so **T4 (IndieHackers-first) is the load-bearing card; T5 is additive.**
- **Objection that holds**: cold thread-replies at volume risk looking like the six competitor rescue shops. Mitigation carried from T2: cap cold volume, lead with trust/ownership, prefer warm (T3) + Paul's relationship.

**Verdict**: PASS with two carried constraints (T4-IndieHackers-first is load-bearing, T5 additive; cap cold volume). Awaiting Paul's approval before execution.

---

## Cold-eyes v2 (LIGHT, self-refute — card #28, 2026-07-26)

**Refute**: "Will the v2 rubric actually prevent the batch-1 failure class, or is it more checklist theater?"
- Each new gate traces to a **named failure it would have caught**: check 3 (verified timestamp) catches Saul_E-2020 and Afrikonnect-1yr; check 4 (post|comment routing) catches the Afrikonnect mis-label and the Joy/Nico routing risk; check 5 (thread health) catches SANICE_AI's saturated thread. Not speculative — each is a regression test against a real miss. PASS.
- **Objection that holds**: the ≤30-day window will shrink IndieHackers yield hard — IH is lower-volume than Reddit, and most of the 25 v1 rows would fail it. Mitigation (already in card #29): re-audit keeps whatever survives verification, and channel expansion (the date-filtered sweep across Reddit/HN; X first-person) fills the gap. If the verified-fresh list lands at 8-10 rows, that is an acceptable **fallback floor**, not the target — quality-over-quota means don't pad past what's genuinely fresh, but T6/backlog's stated target stays 10-15+ rows and it makes the expansion lane genuinely load-bearing rather than optional. Since 2026-08-08 that lane is gated on thread-open tooling, not on a Paul action.
- **Objection that holds**: "read ALL replies" (check 5) on 60+ comment threads costs real time per candidate. Accepted: one thorough visit per candidate is still cheaper than a burned send or a spam-flag on Paul's account; the read-once extract-all pick (Vote 2) already assumed one full visit per thread.
- **Objection dismissed**: "the send-time Phase-1 pre-research already catches this, why duplicate?" — because batch-1 proved catching it at send-time wastes the whole downstream chain (openers written, scored, sheet built, Paul's approval loop entered for rows that were never viable). Catching at capture costs one timestamp read; catching at send costs a full cycle.

**Verdict: PASS.** Carried constraint for #29: reaching even 10-15 rows inside the window depends on an expansion lane beyond IndieHackers. That lane was a passive keyword monitor when this was written; it was retired 2026-08-08 and replaced by the date-filtered sweep (`prospects/p7-search-sweep.md`). The constraint stands — **it is now a tooling unblock (thread-open access), not a 2-minute ask on Paul's desk.**
