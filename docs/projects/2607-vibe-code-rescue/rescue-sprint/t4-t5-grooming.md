> GROOMING — T4 (web cold) + T5 (Reddit/community cold). /brainstorming with voting, 3 sub-agents ideated (QueryStrategist, VoCWorkflow, ValidationDesigner). PENDING PAUL'S APPROVAL before any sourcing runs.

# T4/T5 Grooming — how a session builds the prospect list + harvests VoC

**Created**: 2026-07-22 | **Owner**: agent-built | **Feeds**: T6 dedupe → T7 openers → C0 send (Paul's desk P3)
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
| **Weighted total** | **43** | **31** | **34** |

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
| **Weighted total** | **50** | **42** | **31** |

**Pick: A (read-once, extract-all), fed by B's excerpt-triage front-end.** web_search excerpts build a cheap URL queue; one `chrome-devtools` open per queued URL produces validate + row + quotes in a single visit. Excerpt-only (C) rejected as capture (truncated/paraphrased violates the verbatim rule) — used ONLY to build the queue.

Core rule that kills rework: **open each thread exactly once; extract validation + row + quotes in that one visit.** Thread URL is the join key across rows / VoC / openers, so a row and its quotes physically can't drift.

## Vote 3 — Qualification rubric (ValidationDesigner gap, filled)

Per-candidate 3-check (one-word verdict `ICP` / `semi-ICP` / `drop`), applied in the single visit:
1. **Who** — OP is a **non-technical founder**, NOT a dev/team member venting about their own vibe-coding, NOT a supplier advertising rescue ("what I tell every founder…").
2. **What** — the app was built by a **shop / freelancer / AI tool** (Lovable/Bolt/Replit/Cursor), not hand-coded by the OP.
3. **When** — it's **live / breaking / active-looking** and the thread is **answerable** (recent, not dead).

Hard rules (from A0 D3 + QueryStrategist acceptance criteria):
- ICP claim must trace to a **quoted sentence**, never inferred.
- **Zero supplier/agency posts logged as founder leads** — spot-check each handle.
- Trigger-3 rows come from **comment-mining**, not open-web keyword search (per the proven failure).
- `[VERBATIM-founder]` reserved for the non-technical founder who PAID someone; a dev venting = `[VERBATIM-dev/team]` (a different speaker T7 must not mirror as the founder).

---

## Lane split — T4 vs T5 (by fetchability)

| Task | Venues | Access | Method |
|---|---|---|---|
| **T4 — web cold (fetchable)** | **IndieHackers (run FIRST)**, Hacker News threads, X/Twitter first-person, competitor "free audit" comment threads (heydev/modall/attributex + the live competitor set) | `chrome-devtools` can open + read full post + comments | Read-once extract-all, site-scoped queries |
| **T5 — Reddit / community (mostly un-openable)** | r/replit, r/NoCode, r/Solopreneur, r/SaaS, r/startups, r/vibecoding, r/founder | Reddit thread **bodies not reliably fetchable**; web_search misses ~70% of Reddit | Excerpt capture (handle + URL + title from the excerpt); **F5Bot feed** (Paul's optional 2-min signup) to un-blind Reddit via JSON/RSS |

IndieHackers is the clear run-first venue: real posts + handles in the excerpt, fetch-free, low outreach hostility.

---

## Output schema — a SEPARATE cold-prospect table

VoCWorkflow flag (adopted): the warm `warm-intro-referral-kit.md` §1 table has **no thread-URL column** — public prospects need the URL join key. So public-thread rows land in a new `cold-prospect-list.md`, NOT shoehorned into the warm table.

Columns: `handle/channel · source URL · trigger # · why-ICP (quoted sentence) · verdict (ICP/semi-ICP) · best-contact path · status`.

VoC harvest lands in `voice-of-customer.md` (the four force sections) + the phrase bank, keyed by the same thread URL.

---

## Definition of DONE (both cards)

**Rows** (`cold-prospect-list.md`):
- ~30 public-prospect rows, each with source URL + handle/channel + one-line why-ICP (the Push signal, quoted) + verdict tag + best-contact path.
- No two rows on the same thread. Warm rows stay in the warm kit; public rows here.
- Zero supplier/agency posts logged as founder leads.

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
- **F5Bot** (free; Paul's optional 2-min signup) — Reddit + HN + Lobsters keyword feed via JSON/RSS an agent CAN read; bypasses the Reddit fetch block without scraping.
- **Not used**: `web_fetch` on Reddit (unreliable), Apollo/Hunter (paid, Paul's desk), Gmail (that's T3 warm lane, needs Paul's consent).

---

## Assumption trace (runbook rule 7)

These are refinements of the **already-registered** A0 find-channel premise (warm primary + cold-community secondary) and pre-validation D3 (5-question intake incl. repo-access gate) — NOT new premises, so no new A0 vote is required. The one sharpened learning to fold back into A0 on the first cohort: **open-web keyword search for the ownership-hostage trigger is dominated by competitor SEO** — a channel-cost fact, not a new bet.

---

## Cold-eyes (LIGHT, self-refute)

**Refute**: "Will a session running this produce 30 real ICP rows + verbatim founder quotes, not noise?"
- Discovery pick is backed by a PROVEN probe (site-scoped IH beats keyword search; Trigger-3 keyword search fails) — not a guess. PASS.
- **Objection that holds**: the ~30-row target leans on Reddit, which is the least-fetchable venue. Mitigation: IndieHackers (fetchable, run-first) + HN + X + competitor comments carry the fetchable load; Reddit contributes via excerpts + F5Bot, not as the primary. If F5Bot isn't set up, T5 yield drops — so **T4 (IndieHackers-first) is the load-bearing card; T5 is additive.**
- **Objection that holds**: cold thread-replies at volume risk looking like the six competitor rescue shops. Mitigation carried from T2: cap cold volume, lead with trust/ownership, prefer warm (T3) + Paul's relationship.

**Verdict**: PASS with two carried constraints (T4-IndieHackers-first is load-bearing, T5 additive; cap cold volume). Awaiting Paul's approval before execution.
