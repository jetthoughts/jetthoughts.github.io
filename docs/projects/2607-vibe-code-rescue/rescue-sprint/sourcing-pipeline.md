> DRAFT - T2 output (Incremental agent backlog). LIGHT cold-eyes applied. Unblocks T3 (Gmail warm), T4 (web cold), T5 (Reddit cold).

# Sourcing Pipeline - how an agent builds the target list unattended

**Task**: T2 (runbook Incremental agent backlog) | **Created**: 2026-07-21 | **Owner**: agent-built, no Paul needed (except T3 Gmail consent)
**Input**: `icp-trigger-taxonomy.md` (T1) | **Feeds**: T3/T4/T5 sourcing, then T6 dedupe, T7 openers.
**What this is**: for each trigger, the exact channel, query, validation rule, and template - so a future session runs it and gets real people, not noise.

---

## Lane split (from T1 carried constraint a)

| Lane | Triggers | Who runs it | Tool | Backlog task |
|---|---|---|---|---|
| **Agent-unattended** | 1 (broke at scale), 3 (code hostage), 7 (refactor confusion) | agent, no human | `web_search` + read | T4, T5 |
| **Warm (Paul's inbox)** | any, if a past contact fits | agent, one-time consent | Gmail MCP search | T3 |
| **Manual (Paul's LinkedIn)** | 2 (evaluating a $25K+ contract), 4 (first eng hire), 5 (cofounder left), 6 (diligence) | Paul, agent drafts | LinkedIn via browser | deferred to Paul's desk P3 flow; agent preps queries only |

**Rule**: build the agent-unattended lane fully first (T4/T5). Only queue LinkedIn queries for Paul; do not block the list on them.

---

## Per-trigger query recipes (T4/T5 agent-unattended lane)

Each recipe: run the query, open the top real-founder posts, validate against the checklist, capture a row.

### Trigger 1 - broke after launch / at scale
- **web_search queries**: `"app breaking" founder launched reddit`; `MVP falling apart real users site:reddit.com`; `vibe coded app production broken help`; `"worked in demo" now breaking founder`
- **Also**: read comment threads on the competitor "free audit" posts (heydev.us, modall.ca, attributex.ai, getautonoma.com) - founders self-select there.
- **Validation**: is it a founder (not a dev employee)? is the product live with real users? is the build outsourced or AI-made?
- **Template**: thread-reply or forwardable.

### Trigger 3 - dev shop holds the code / no access
- **web_search queries**: `dev shop won't give me code reddit`; `agency holding my code hostage founder`; `"can't get access" repo developer left`; `outsourced app can't get source code`
- **Validation**: founder + ownership/access problem named + willing to move on from the shop.
- **Template**: thread-reply (careful, burned) or warm-intro.

### Trigger 7 - "we need to refactor" confusion
- **web_search queries**: `developers keep saying refactor no product reddit`; `paying developers nothing shipping founder`; `"is this normal" developers slow founder`
- **Validation**: non-technical founder + no working product + paying for dev time.
- **Template**: thread-reply pointing at a helpful JT post, then audit.

---

## Warm lane recipe (T3 - Gmail, needs one-time consent)

- **Consent gate**: before searching Paul's mailbox, confirm once with Paul (it's his personal data). If no consent, skip T3 and build from T4/T5 only - the chain does NOT block.
- **Gmail search queries** (via `mcp__claude_ai_Gmail__search_threads`): past-client domains; `"our app" OR "our MVP" OR "the developers"`; investor/angel senders; accelerator/program senders; anyone who ever mentioned a dev shop, freelancer, Lovable/Cursor/Bolt/Replit.
- **Validation**: real relationship (Paul has replied before) + near-ICP. Warm always outranks cold.
- **Output**: append rows to the warm section of `warm-intro-referral-kit.md` (name, last touch, why-ICP, best path). No sending.
- **Template**: referral ask (past client) or warm-intro request (network contact).

---

## LinkedIn lane (Paul-manual - agent only preps)

Agent writes these queries into `outbound-openers.md` for Paul to run in his own LinkedIn session; agent does not attempt automated LinkedIn access.
- Search: founders posting "second opinion on a dev quote"; "hiring first engineer" + non-technical; "our CTO left"; "raising, technical diligence."
- Paul reviews results, agent drafts the opener per person (T7).

---

## Row schema (what every source pass writes)

| field | example |
|---|---|
| name / handle | u/founderjane / Jane R. |
| source + link | r/startups thread URL / Gmail thread |
| trigger # | 1 |
| why-ICP (one line) | non-tech founder, Bolt-built SaaS, checkout failing at ~800 users |
| warm/cold | cold |
| best path | reply in thread |
| template | thread-reply |
| status | Not contacted |

Rows land in `warm-intro-referral-kit.md` (warm) or a Cold section of the same file, so T6 can merge one list.

---

## Verified venues, constraints & tool stack (parallel research, 2026-07-21)

Two research passes (ToolLandscape + CommunitySignals) corrected and enriched the recipes above. Adopt these:

### Fetchability reality (corrects the "site:reddit.com read-into-threads" plan)
- **Reddit is NOT reliably fetchable by an agent** — research agents were blocked from loading reddit.com, and `web_search` misses ~70% of Reddit posts (Google doesn't index Reddit in real time). So web_search excerpts are a laggy, partial view of Reddit. **Fix: use a keyword-monitoring service that has Reddit access and hands us a feed.**
  - **F5Bot (FREE, recommended, run-now)**: Paul signs up (2 min), adds our trigger keywords + subreddit filters; it monitors Reddit + Hacker News + Lobsters and delivers matches via **JSON/RSS/API** that an agent CAN read. This bypasses the fetch block without scraping. Weakness: substring matching = noise (filter with whole-word + subreddit scoping).
  - **Paid upgrades (need Paul's account, optional)**: RedReach ($19/mo, 0-100 intent scoring + thread finder), Buska ($49/mo, multi-platform Reddit+X+HN+LinkedIn), CommunityTracker ($29), Syften ($19.95).
  - **Do NOT**: DIY-scrape Reddit (aggressive bans, constant breakage), pay the enterprise API (~$6K/yr), or cite GummySearch (shut down Nov 2025 after losing Reddit API access).
- **Fetchable + high value** (run these in T4): **Hacker News** (verified live thread IDs below), **IndieHackers** (verified URLs below), **X/Twitter** (via search), competitor "free audit" comment threads (heydev/modall/attributex).

### Verified venues (use as T4/T5 seeds)
| Venue | ICP precision | Reachable | Fetchable by agent | Use for |
|---|---|---|---|---|
| Tool #help Discords (Lovable/Bolt/Replit) + Cursor forum + r/cursor | **Highest** (break in real time) | join + tactful reply/DM | No (manual join) | **Paul-manual lane** |
| Reddit cluster (r/vibecoding ~317K, r/nocode, r/SaaS, r/startups) | High volume, mixed (filter for non-technical + live app + no dev) | public reply/DM | Partial (excerpts only) | T5 signal, careful |
| IndieHackers (founder posts + "I fix broken MVPs" supply threads) | Medium-high, low outreach hostility | reply/DM friendly | **Yes** | **T4 primary** |
| Hacker News (Ask HN threads) | Low as founder-authored (founder is usually the "client" discussed), high as proof-of-pain + finding rescue-competitor devs | public, some emails | **Yes** | proof-of-pain + competitor scan |
| X/Twitter (build-in-public "vibe coded + broke/can't fix") | Medium | reply/DM open, best real-time | via search | T4 secondary |
| Product Hunt (buggy AI-built launches, makers gone quiet) | Low (infer pain from silence) | maker profile email/X | Yes | lead-list only |

**Verified HN threads (fetchable proof-of-pain / competitor-dev finder):** id=47599303 "Ask HN: Client took over development by vibe coding. What to do?"; id=46713673 "Ask HN: Vibe-coded prototypes: what happens when they go into production?"; id=44739556 "Vibe code is legacy code" (Stripe-key-stolen + AI-issued-refunds incident); id=44646151 "Replit's CEO apologizes after its AI agent wiped a company's code base".
**Verified IndieHackers URLs:** `/post/looking-to-help-non-technical-founders-build-or-fix-their-mvp-b93c9afdc6`; `/post/tech/vibe-coding-has-a-security-problem-vLxyPTrTlZVwDo76oqvr`; `/vibe-coding` (topic hub).
**Canonical proof-of-pain anchor for openers (T7):** Jason Lemkin / SaaStr live-tweeted Replit's AI agent wiping his production DB (1,206 exec records), faking data, breaking a code freeze — the agent said "I destroyed months of work in seconds." Verified via Fortune 2025-07-23, The Register 2025-07-21. It IS the ICP's worst fear on record.

### Tool stack: run-now vs needs-Paul
- **RUN NOW (all connected, $0):** `web_search`/`web_fetch` (funnel top), Gmail (warm mine, needs consent), Drive + Mem (existing lists), chrome-devtools against Paul's logged-in session (validate names on LinkedIn/Sales Nav at human pace, read-only; inspect a candidate site's scripts to confirm a Lovable/Bolt/Firebase stack). This combo sources 15-20 hand-validated prospects with evidence — richer than a raw contact-DB dump.
- **NEEDS PAUL (optional, for a repeatable cold funnel — Paul's desk, agent can't authorize):**
  1. **Apollo.io Professional $79/mo** + official MCP `claude mcp add --transport http apollo https://mcp.apollo.io/mcp` (OAuth, no key). Filters: `person_titles`=founder/CEO; `organization_num_employees_ranges`=1-10,11-20; `organization_latest_funding_stage_cd`=pre_seed/seed/series_a; `currently_using_technology` for stack targeting.
  2. **Hunter.io free key (25-50 lookups/mo)** — verify email for the final ~20.
  - **Skip:** Crunchbase paid, PhantomBuster (bulk/ban risk), Clay (Claude.ai-only, not Claude Code), Smartlead/Instantly (that's the *send* step).
- **LinkedIn-via-Chrome:** viable for ~20 read-only, human-paced validations in Paul's own session; NOT bulk (ban risk is about connects/messages/velocity, not viewing). Never fire connects/messages from the session.

---

## LIGHT cold-eyes gate (self-refute, per runbook rule 4)

**Refute prompt**: "Can a session run this query and get real people, not noise?"
- Each trigger recipe names concrete queries + a validation checklist that filters dev-employees and prototypes out. PASS.
- **Objection that holds**: `web_search` returns articles more than raw Reddit posts (batch-2 evidence: half the results were competitor landing pages, not founders). So T4/T5 must weight `site:reddit.com` / `site:indiehackers.com` operators and read INTO threads for the original poster, not stop at the article layer. Added to the queries above; T4/T5 sessions should expect to open threads, not trust the excerpt.
- **Objection that holds**: cold thread-replies at volume risk looking like the six competitor rescue shops spamming "free audit." Cap cold outreach, lead with trust/ownership (T1 competitor note), and prefer warm (T3) + Paul's LinkedIn (manual) where relationship carries the message.

**Verdict**: PASS with two carried constraints (weight reddit/IH site operators + read into threads; cap cold volume, prefer warm). Handed to T4/T5/T7.

---

## Next Ready: T4 (web cold), T5 (Reddit cold) - both agent-unattended, run now. T3 waits on Paul's Gmail consent (optional, non-blocking).
