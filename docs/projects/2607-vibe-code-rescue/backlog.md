# 2607 Vibe Code Rescue — Atomic Backlog

**One file, one project. Each task = ≤1 session, self-contained, runnable by any agent with zero extra context.**
Read `rescue-sprint/t4-t5-grooming.md` (design + qualification rubric) once, then take the next `Ready` task.
Strategy/gates/Paul's desk live in [`operation-runbook.md`](operation-runbook.md); this file is the executable granularity.

**Rules**: (1) source tasks write to their OWN `rescue-sprint/prospects/<id>.md` — never edit a shared file, so they run in parallel with zero collision. (2) VoC quotes go in the same per-task file under a `## VoC` heading. (3) Qualification = grooming Vote 3 (non-tech founder, not a dev venting, not a supplier; app built by shop/AI-tool; live/answerable; ICP claim traces to a quoted sentence; ZERO supplier posts logged as leads). (4) Tools = `web_search` + `chrome-devtools` (`new_page`/`take_snapshot`/`close_page`) only; Reddit bodies unfetchable → excerpt capture. (5) Row schema: `handle/channel · source URL · trigger# · why-ICP (quoted) · verdict(ICP/semi-ICP) · best path`.

---

## Stage 1 — Source

**P1-P6 are COMPLETE (2026-07-22) — specs removed; each `prospects/p*.md` file carries its own provenance.** Results: P1 8 rows · P2 7 · P3 **0 (HN retired — dev-dominated, do NOT re-run)** · P4 9 (excerpt-only, VoC-grade not lead-grade) · P5 2 (**low-yield, don't re-run without a new seed**) · P6 4. All rows merged by P8 and now **unverified pending #29** (see §Card #29 status).

### P7 · Date-filtered search sweep  → `prospects/p7-search-sweep.md`  *(the LIVE sourcing method — tooling unblocked 2026-08-20; still 0 rows, now a venue problem)*
- **supersedes** the retired passive keyword monitor (see §Card #29 status for why it was structurally unfixable). Its doc is deleted; the keyword derivation it carried now lives in `prospects/p7-search-sweep.md` §3.
- **do**: run the query bank in `prospects/p7-search-sweep.md` §3 — `site:` operators across reddit/IH/HN/x/lobste.rs crossed with the corpus-derived v2 keywords and `after:{TODAY-30}` (compute the date per §2, never eyeball). Open each non-Reddit candidate ONCE, read the real timestamp + all replies, fill `verified date` + `thread health`. **Reddit is excerpt-only (wrapper rule) and P7 lead rows require an opened-thread timestamp, so Reddit hits feed the excerpt queue + VoC only - never P7 lead rows (sweep doc §3.1).** Normalize URLs, then dedupe against `cold-prospect-list.md` by normalized thread URL (§5).
- **needs**: a thread-opening tool + a date-aware search surface. **Solved 2026-08-20** — from a host session IH post pages open with plain `curl` and carry JSON-LD `datePublished` plus every comment, and IH's `discussions_createdTimestamp_desc` Algolia index supplies the recency lane that `after:` never could. Recipe in `prospects/p7-search-sweep.md` §7a; `chrome-devtools` is not required. Reddit is still un-openable.
- **done**: rows all carrying `verified date` ≤30 days + `thread health`; stale/saturated threads harvested for VoC before closing. Quality over quota — log what defensibly qualifies, pad nothing.

---

## Stage 2 — Consolidate  *(first run done 2026-07-22; spec kept — RE-RUNS for every #29 delta)*

### P8 · Merge + dedupe + score  → `rescue-sprint/cold-prospect-list.md` + fold VoC into `rescue-sprint/voice-of-customer.md`
- **depends**: new verified rows from #29 (first run consumed P1-P7).
- **do**: merge all `prospects/*.md` rows into one ranked list (warm-first if T3 ran), drop dupes (thread URL = key) + dead + supplier; score by trigger strength; target ~30 usable rows. Fold each file's `## VoC` lines into the four force sections + build the phrase bank (≥1 per force, `[VERBATIM-founder]` only).
- **done**: ~30 deduped rows; VoC ≥5 founder lines each for Push/Pull, ≥3 for Anxiety/Habit; phrase bank non-empty. LIGHT gate: "would Paul recognize these as worth his time?"

---

## Stage 3 — Convert  *(first run done 2026-07-22; P9 spec kept — RE-RUNS as the openers-delta after #29)*

### P9 · Per-target openers  → `rescue-sprint/outbound-openers.md`
- **depends**: P8 re-run + A2 (offer/price — confirmed). **do**: one personalized opener per row (right template: referral / warm-intro / forwardable / thread-reply), mirror that row's VoC phrase, live booking link. **done**: opener per row, ready for Paul to review+send (desk P3); **every opener's link resolves to the named prospect's OWN post/profile** — if the quote is a comment on someone else's thread, the opener must say so and route to the commenter (this check would have caught the Joy Adamson/Nico mis-route). LIGHT gate (HEAVY if any becomes a mass template).

### P10 · Pipeline tracking sheet — ✓ DONE (2026-07-24): `rescue-sprint/pipeline.md` exists, bound from `operating-system.md` §1; weekly tally filling started 2026-08-08. A0 kill-criteria evaluable from the sheet alone.

---

## Parallel / already-tracked (see runbook for full cards)

| id | task | status |
|---|---|---|
| T3 | Gmail warm-source pass (Paul consent) → warm rows | Blocked-on-Paul (optional, non-blocking) |
| T8 | Discovery kit (call script + audit template) | ✓ Done (`rescue-sprint/discovery-kit.md`) |
| T9 | Objection + FAQ + follow-up bank → `rescue-sprint/objection-followup-bank.md` | **Ready** |
| T10 | Split business/strategy docs out of the public repo - [#449](https://github.com/jetthoughts/jetthoughts.github.io/issues/449). Touches this project's `20-29-strategy/` files, so 2607 tracks it. | Blocked-on-Paul (org decision, not a refactor) |

---

## State — THE card registry (2026-08-08)

> **This section is the single committed source for card status.** (A local kanban board once tracked cards #1-#29 but was never committed and no longer exists — every reference to it is dead; do not look for it.) Card meanings that still matter: **#12** batch-1 send · **#19/#25** batches 2-3 · **#20** daily reply-monitor · **#28** sourcing-quality rubric fix (Done) · **#29** re-source v2 (the gate everything cold waits on — status below). Copy-paste run prompt for the live sourcing method: `rescue-sprint/prospects/RUN.md` (P7).

### ⚠ Sourcing-quality retrospective (2026-07-26)

Batch-1 Phase-1 pre-research (send-runner-prompt.md, run against card #12's 5 openers) found **3 of 5 rows unsendable — a 60% failure rate** on a list P8 had already scored "ICP, ready":
- **Afrikonnect** (row 12): quote is a comment **~1 year old**, on someone else's post — not Afrikonnect's own post. Thread already has 2 people publicly offering to help in that exact spot.
- **Saul_E** (row 13): post is dated **2020-05-26 — over 6 years old**.
- **SANICE_AI** (row 2): recent and correctly matched, but the 61-comment thread already contains a near-identical competing "free" pitch (a spam-patterned account that pivoted from a paid contest to "spearprotocol.com — free... just clarity" after being declined) — sending our audit offer into that thread reads as a third scraper.

**Root cause**: `t4-t5-grooming.md` Vote-3 rubric already names a "When" check ("recent, not dead") — it was never enforced with a verified timestamp read; P1-P9 (2026-07-22) eyeballed recency from `web_search` excerpts instead of opening the thread and reading the actual date. There is also no rubric check at all for thread saturation (competing pitches already present).

**This means the other 20 rows in `cold-prospect-list.md` (built the same day, same method) carry the same unverified risk** and should not be treated as send-ready until re-checked.

**Filed**: #28 ✓ **DONE 2026-07-26** — v2 rubric live in `rescue-sprint/t4-t5-grooming.md` Vote 3 (5 checks; verified-timestamp ≤30-day window with venue caps, post|comment routing field, thread-health scan; `verified date` + `thread health` are now P8 admission-gate columns; cold-eyes v2 PASS, verdict in-file) → #29 (re-source v2 against the fixed rubric). Directive from Paul (2026-07-26): prioritize finding **actual users with a real, current problem** over hitting a row-count quota; a shorter list of genuinely fresh, unsaturated rows beats a padded one.

### Card #29 status — **BLOCKED-ON-TOOLING (2026-08-08). Method delivered, zero rows.** *(SUPERSEDED — see the 2026-08-20 handoff below; the tooling block is gone and the remaining blocker is the venue mix.)*

- **Passive keyword monitor (F5Bot) RETIRED 2026-08-08** (Paul called it dead; its doc was deleted 2026-08-08 — this line is the record). Two structural flaws, not keyword tuning: it matched **literal substrings** (v1 matched 0 of our 25 hand-found posts), and it was **passive** — catching only mentions from setup-time forward, so it could never backfill the ≤30-day window on demand. The keyword swap is no longer a Paul unblock; it is struck from Sprint 3 and from 20.09's P0 list. Its v2 keyword derivation now lives in `prospects/p7-search-sweep.md` §3. **Do not re-introduce a passive or substring-matching monitor** — both flaws are structural, not tunable.
- **Replacement method shipped**: `rescue-sprint/prospects/p7-search-sweep.md` — date-filtered active search (`site:` + `after:{TODAY-30}`), with a copy-paste query bank across Reddit/IH/HN/X/Lobsters using the corpus-derived v2 keywords, the window date arithmetic, an X-snowflake date-derivation shortcut, honest limitations, a weekly cadence, and a URL-keyed dedupe + `Seen-and-skipped` protocol.
- **Sweep executed 2026-08-08 → ZERO qualified rows, ZERO VoC founder lines.** Cause is tooling, not the market - and it is venue-specific, two distinct failure classes: (1) **search-surface limits** - bare `site:reddit.com` queries had the operator dropped (off-domain Substack/Goodreads results), while the tool's native domain filter DID return `indiehackers.com` and `x.com` URLs; `after:` filtering was ineffective everywhere it was tried (IH results dated 2025-07 and 2026-03 came back). (2) **venue access** - `reddit.com` rejected the tool's user agent outright (hard 400), and every thread-open attempt (`indiehackers.com`, `news.ycombinator.com`, `old.reddit.com`, `lobste.rs`) returned `EGRESS_BLOCKED`. So IH was searchable but not openable; Reddit was neither. Vote 3 check 3 requires a timestamp **read from the opened thread**, so with no venue openable every candidate fails by construction. IH search returned only threads already in `cold-prospect-list.md` plus suppliers; X's freshest result was 40 days old and off-ICP. Nothing was padded or inferred. Full attempt-by-attempt log in `p7-search-sweep.md` §6.
- **Unblock needed**: `chrome-devtools` (the tool grooming Vote 2 actually names) plus egress to `indiehackers.com` and `reddit.com`. Until one venue is openable, #29 cannot produce verified-fresh rows by **any** method.
- **#12 remains blocked** — still zero sendable rows, unchanged since 2026-07-26.

### Card #29 handoff — **Re-audit COMPLETE: 19 of 25 verified, all 19 dropped, 6 Reddit rows unverifiable. 0 fresh verified rows. Reddit tried via browser (Paul, 2026-08-20) and is network-blocked. One misquote found and corrected across 6 files.**

Run artifacts: `rescue-sprint/prospects/p7-search-sweep.md` §7 (method + full log + Seen-and-skipped), `rescue-sprint/cold-prospect-list.md` §Re-audit log, `rescue-sprint/voice-of-customer.md` (+6 `[VERBATIM-founder]`, +2 `[vendor]`).

**1. The tooling block is gone — and it was environmental, not a venue policy.** From a host session IndieHackers, LinkedIn public posts, X status pages and the HN Algolia API all open. IH post pages are server-rendered and carry JSON-LD `datePublished` plus every comment and its age, so Vote 3 check 3 and check 5 are both satisfiable in one page load. **Reddit is still closed** (`/new.json` 403; the HTML listing returns an ~8KB interstitial), so §3.1's Reddit-is-excerpt-only rule stands unchanged and its ten rows here stay unverifiable.

**2. The missing recency lane exists.** IH listing pages are client-rendered so there is no browsable "newest" feed, but IH's own search runs on Algolia and one index is `discussions_createdTimestamp_desc`. Query it for discovery, then open each hit to verify. Exact call in `p7-search-sweep.md` §7a. Pair it with domain-filtered `WebSearch` for precision — relevance-ranked search is stale-biased (10 candidates returned 1 inside the window), the Algolia index is fresh but loose.

**3. Re-audit COMPLETE — 15 of 15 openable rows dropped, no false alarms, and the v1 list is now closed.**
- *Pass 1 (batch-1's five, plus one free)*: SpecBuildLab 2025-10-09 (316d) · SANICE_AI 2026-04-12 (130d, and the competing free pitch is genuinely in-thread) · Joy Adamson ~2026-02-05 comment (~196d, still publicly unanswered) · Afrikonnect ~1yr comment on someone else's post · Saul_E 2020-05-26 (~6.2yr) · Abnrav ~1yr comment, verified free in Afrikonnect's visit.
- *Pass 2 (the 9 remaining openable rows, 6 page loads)*: eddwardpark 2026-06-12 (69d — the narrowest miss on the list) · KaiaColban 2025-09-06 (348d) · dianewilliams75 / 659ertramp / J_Jie556517 / lucadeza, all 7-10 month comments on one host thread that also carries **5 competing free-help pitches**, so they were saturated as well as stale · Sam A 2020-03-16 (~6.4yr) · techPackets 2022-08-27 (~4yr) · @markgadala 2025-03-20 (518d, snowflake-derived).
- **Tally: 15 verified and dropped · 10 Reddit rows unverifiable · 0 send-ready.** Every failure the 2026-07-26 retro named was real, and none of the 15 was a false alarm.
- **Two things worth carrying forward.** `dateModified` is not a post date — row 8 shows a 2026-02-26 edit on a 2025-09-06 post, exactly the number an excerpt pass mistakes for freshness. And verification is cheap: 15 rows cost ~15 page loads, against a list that was logged as "ICP, ready" on eyeballed excerpts and then carried openers, a scored sheet and Paul's approval loop before anyone noticed.
- **Pass 2 added no VoC.** All 5 threads were harvested; their good lines were already in the file, and the one fresh-looking candidate was a dev-sourcing vendor pitching his own agency (`[vendor]`, not admitted).
- **Pass 3 (2026-08-20, Reddit, after Paul granted browser access): 4 more verified, 6 permanently unverifiable.** `/u/Alarmed_Movie9661` 2026-05-14 (98d — the freshest Reddit row) · `/u/Mental_Push_6888` 2026-04-09 (133d) · `/u/cdaviddav` 2026-01-02 (230d) · `/u/anchit_rana` 2025-08-22 (363d). Rows 5, 6, 10, 11, 23, 24 could not be dated by any route — retire them; a row that cannot be dated cannot become a lead.
- **Running tally: 19 of 25 verified, all 19 dropped · 6 unverifiable · 0 send-ready.** The v1 list is closed.

**3b. The most serious finding of the whole card is not a stale date — it is a quote we got wrong.** Row 4 was logged as *"Vibe coding gave me a product. It also gave me a problem I couldn't fix."* The founder actually wrote *"…a problem I'm still paying for."* The phrase "I couldn't fix" appears nowhere in his thread. It had propagated into **five files including `outbound-openers.md`**, so the opener drafted for him quoted words he never wrote — a defect that passes every staleness check and surfaces in front of the prospect. Corrected in all 6 places 2026-08-20. A second re-read quote was truncated in a way that dropped the buying moment ("stuck with my app" → the source says "stuck with my app **for 3 months now**").

**Two of the four re-read quotes needed fixing.** The `[VERBATIM-founder]` tag has been recording *intent*, not verification. Treat every un-re-read v1 quote as unconfirmed and re-read at source before it is mirrored into any opener. Rows 9 and 14's quotes come from comments the `.rss` feed did not return — neither confirmed nor refuted, so not accused, just unverified. Noted in `voice-of-customer.md` under PUSH.

**4. Zero fresh rows, and this time it is a venue finding, not a tooling one.** 21 keyword queries, 5 domain-filtered searches, 4 HN date-filtered queries, 10 date-probes, **23 threads opened in full**. IndieHackers' ≤30-day stream is a launch/promo board: everything in-window is a launch announcement, a success retrospective, a supplier pitch, or a co-founder-wanted ad. Where distress language does appear fresh, a competitor rescue shop is speaking it as content marketing (forgex.systems ×2, StackRadar, QAura, FixBrokenApp, TatePrograms) and the comment sections are other vendors. HN re-confirmed P3's retirement — every in-window hit was a developer discussing AI code quality.

**5. Closest miss, recorded so it is not re-adjudicated.** Fallet Sébastien / JourX (`indiehackers.com/post/1vb5UrAjNLmhuZK2gsXG`, verified 2026-07-22, own post, thread clean) **clears all five Vote-3 checks** — non-technical, paid a dev team that walked out mid-project, 29 days old. He fails the buying-moment test: he already rebuilt it himself in Flutter and the post is a celebration. **Paul's call** if the "solo non-technical founder now maintaining a live money app alone" reading makes him a control-before-disaster prospect rather than a rescue.

**LIGHT cold-eyes gate — refute verdict, verbatim:**

> **Refute: "is this a real ICP founder in a buying moment, traceable to a quoted sentence?"**
> Applied to the **18 fresh candidate threads** (the 5 batch-1 re-audits are adjudicated separately by the flat ≤30-day rule and all failed it). **0 pass; 0 rows logged.** Where the 18 failed: **6** are suppliers or competitors, not founders — forgex.systems twice, StackRadar, Zarek, ChromolyDB, QAura (fails "real ICP founder"). **8** are real founders with no live problem — launch announcements, success retrospectives, content promo, one hobby app going fine (fails "buying moment"). **1** is pre-build and partner-seeking, nothing built and nothing broken (fails "buying moment"). **1** is a technically capable builder self-diagnosing his own bugs and writing his own regression tests (fails "ICP" — the ICP cannot evaluate code quality; he demonstrably can). **1** is advisor commentary *about* non-technical founders rather than by one (fails "traceable to a quoted sentence" — the pain is in the third person). **1** (JourX) is a real ICP founder whose ICP claim IS traceable to a quoted sentence, failing only the buying-moment clause because the pain resolved before the post was written.
> **The gate rejected nothing I wanted to keep.** No row was dropped on a technicality and none was borderline enough to argue for. I did not pad, and I did not log JourX as a row to avoid reporting a zero — he is recorded as a drop with the reasoning visible so Paul can overrule me in one read.
> **What the gate cannot tell me**: whether 0 rows means the market is quiet or the venue is wrong. Two consecutive sweeps at 0 from the open venues, against a closed Reddit, points hard at the venue.

**5b. The fresh Reddit sweep could not run at all.** Discovery needs subreddit listings; the listing `.rss` 429s on the first request and the browser is network-blocked, so there was no lane to sweep. **Zero fresh rows, so the LIGHT cold-eyes gate had nothing to refute** — recorded as "not run, no candidates" rather than a pass, because a gate that never saw a row cannot vouch for one.

**6. Next — the venue premise is now settled, and the answer is that cold public sourcing has no venue.** Two sweeps have now returned 0 from the open venues. The grooming cold-eyes already warned IH is low-volume and that the expansion lane is load-bearing; that lane is now proven open and still empty. Before a third identical sweep, one of these:
- ~~**(a) Get Reddit openable**~~ — **TRIED 2026-08-20 (Paul: no API, use a browser). It does not open.** Automation Chrome gets `Prove your humanity`, then `You've been blocked by network security`. Stopped there per the no-workaround rule. The one route that does work is the **per-thread `.rss` feed via plain `curl`** (exact `<published>` datetime, no browser) — but it rate-limits after ~4 requests and the **listing** feed 429s immediately, so it dates a known URL and gives no discovery lane. Full route-by-route table: `prospects/p7-search-sweep.md` §8. **A browser was not the missing piece; an account or the official API is, and that carries terms worth a deliberate decision rather than a tooling tweak.**
- ~~**(b) Close out the v1 list cheaply**~~ — **DONE 2026-08-20**, 6 page loads, all 9 dropped. The v1 list no longer carries any unverified row worth checking.
- **(c) Accept that the cold-public-sourcing premise has been tested and failed — this is now the recommendation, not the fallback.** Three sweeps, four venues, zero verified-fresh rows. IndieHackers is open, verifiable and empty of fresh distress; HN was retired for being dev-dominated and re-confirmed; X is supplier-dominated; Reddit is where the ICP actually talks and is closed to us. The ≤30-day cold lane is not under-tooled, it is **structurally out of supply at the venues we can read**. That makes LinkedIn (already the primary per the 2026-08-08 re-weight) and T3's warm pass the real lanes, and it means Rock 1's arithmetic should stop counting on cold for its ~2-3 calls. Worth a Paul decision at the September restart: **retire the cold-community lane, or buy Reddit API access and re-test it once with a real budget for the terms.**

**#12 stays blocked** — still zero sendable rows.

**Batch-1 status (updated 2026-07-26, flat lead-recency rule)**: **ALL 5 messages HOLD — zero sendable rows.** Paul's rule "leads = up to 1 month, no exceptions" flipped the two survivors too: SpecBuildLab and Joy Adamson (the latter flagged as Paul's one override candidate — still publicly unanswered). **Ages verified in-thread 2026-08-20**, replacing the 2026-07-26 estimates: SpecBuildLab **2025-10-09 (316 days)**, Joy Adamson **~2026-02-05 (~196 days)** — both older than the estimates suggested. `SEND-SHEET.md` carries per-message ⛔HOLD banners so no runner can send anything. Card #12 is **blocked on #29's replacement rows** (or Paul's explicit Joy override).

**Policy split (Paul, 2026-07-26) — recency gates leads, not voice**:
- **Leads** (`cold-prospect-list.md`): verified **≤30 days, all venues, no exceptions**. Leads expire.
- **VoC** (`voice-of-customer.md`): **no age limit** — any comment/message/post teaches the ICP's slang and emotional register. Stale-dropped lead threads are still harvested for VoC in the same visit (codified in `rescue-sprint/t4-t5-grooming.md` §Lead vs. voice).

### ▶ Sprint 3 — Fresh-Leads Sprint (planned 2026-07-26)

Sequence (WIP=1): **#29** re-source v2 (re-audit all 25 v1 rows with verified timestamps; drop stale/saturated **as leads** while harvesting their VoC; source new ≤30-day rows; IH-first, expand via the date-filtered search sweep + X if thin — the expansion lane is `prospects/p7-search-sweep.md`) → **P9-delta** openers for the new rows only (reuse `outbound-openers.md` templates) → **#12** batch-1 send (first ≤30-day verified rows, Paul approves) → **#20** daily reply-monitor. Batch-2/3 cards (#19, #25) depend on #29 — no more sends from the unverified v1 list.

- **Done**: P1 ✓, P2 ✓, P3 retired (0 rows — HN is dev-dominated, no founder voices; venue invalid for this ICP, do NOT re-run), P4 ✓, P5 ✓ (1 row — low-yield as predicted; don't re-run without a new seed), P6 ✓, P7 = `rescue-sprint/prospects/p7-search-sweep.md` (the passive monitor it replaced was retired 2026-08-08; the sweep shipped its method but produced 0 rows on 2026-08-08, blocked on tooling), P8 ✓ (25 deduped rows), P9 ✓ (25 openers), T9 ✓ (objection bank), P10 ✓ (pipeline sheet scaffolded)
- **A2 confirmed**: 3-tier pricing ($2,500 triage / $7,500 rescue / $10K foundation reset)
- **Next**: browser-agent send run, gated on Paul's approval. The runner prompt is `rescue-sprint/send-runner-prompt.md` (pre-research every prospect → GO/HOLD table → Paul approves → send → log to `rescue-sprint/pipeline.md`). Booking link confirmed live by Paul 2026-07-24. After first sends, run `rescue-sprint/reply-monitor-prompt.md` each morning (classify replies, draft responses from the objection bank, update pipeline — never auto-reply).
- **Mail routing (2026-07-24)**: `pftg.sof@gmail.com` auto-forwards everything to Paul's main inbox (and archives locally under its label) — NeetoCal booking notifications arrive via the forward. The reply-monitor prompt additionally searches this account by query (`neetocal`) as a backup.
- **Seeds** above were verified via `web_search` on 2026-07-22 — hand to the tasks, don't re-derive.
- Update this table's status + the task's `done` line when a task completes; write the output to its named file.
