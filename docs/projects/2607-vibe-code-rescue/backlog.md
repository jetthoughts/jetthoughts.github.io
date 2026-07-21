# 2607 Vibe Code Rescue — Atomic Backlog

**One file, one project. Each task = ≤1 session, self-contained, runnable by any agent with zero extra context.**
Read `rescue-sprint/t4-t5-grooming.md` (design + qualification rubric) once, then take the next `Ready` task.
Strategy/gates/Paul's desk live in [`operation-runbook.md`](operation-runbook.md); this file is the executable granularity.

**Rules**: (1) source tasks write to their OWN `rescue-sprint/prospects/<id>.md` — never edit a shared file, so they run in parallel with zero collision. (2) VoC quotes go in the same per-task file under a `## VoC` heading. (3) Qualification = grooming Vote 3 (non-tech founder, not a dev venting, not a supplier; app built by shop/AI-tool; live/answerable; ICP claim traces to a quoted sentence; ZERO supplier posts logged as leads). (4) Tools = `web_search` + `chrome-devtools` (`new_page`/`take_snapshot`/`close_page`) only; Reddit bodies unfetchable → excerpt capture. (5) Row schema: `handle/channel · source URL · trigger# · why-ICP (quoted) · verdict(ICP/semi-ICP) · best path`.

---

## Stage 1 — Source (all `Ready`, parallel-safe)

### P1 · IndieHackers comment-mine  → `prospects/p1-ih-comments.md`
- **do**: open each thread in chrome-devtools, `take_snapshot`, read ALL comments, log self-identifying ICP commenters + verbatim.
- **seeds**: `/post/looking-to-help-non-technical-founders-6e1d9b33ae` (68 comments — `dianewilliams75` "This is my current situation!"; `659ertramp` electrician; `J_Jie556517` professor) · `/post/im-non-technical-and-hit-the-month-3-wall-twice-here-s-the-system-i-built-that-fixed-it-no-github-required-f4a574c4cd` (mine commenters, OP is a vendor — skip OP).
- **done**: ≥6 commenter rows + VoC; no OP/vendor logged as a lead.

### P2 · IndieHackers founder posts  → `prospects/p2-ih-posts.md`
- **do**: `web_search` `site:indiehackers.com` + (non-technical / Lovable / Bolt / stuck / broke); open promising posts, capture OP handle + URL + pain sentence.
- **seeds**: `SpecBuildLab` (non-tech, Lovable, "bugs kept breaking… no visibility", cross-posted r/NoCode) · a non-tech iOS founder post (QueryStrategist).
- **done**: ≥6 founder-post rows + VoC.

### P3 · Hacker News threads  → `prospects/p3-hn.md`
- **do**: open each verified thread in chrome-devtools, capture founder/commenter pain (proof-of-pain + any founder handle).
- **seeds (verified IDs)**: `46713673` (stosssik, prototypes→production) · `47182659` (Lovable app exposed 18K users, 35 comments — `firefoxd` VoC) · `44739556` (vibe code is legacy code / Stripe-key stolen) · `44646151` (Replit wiped a codebase).
- **done**: ≥4 rows/threads + strong Anxiety/Push VoC.

### P4 · Reddit distress threads (excerpt-only)  → `prospects/p4-reddit.md`
- **do**: `web_search` `site:reddit.com` across r/replit, r/NoCode, r/Solopreneur, r/SaaS, r/startups, r/vibecoding; capture sub + OP handle + URL + quote from the excerpt (do NOT try to open thread bodies).
- **seeds**: r/replit `1hspre9` "Why is Replit so self-destructive" · r/startups `1lkp5p7` (non-tech founder, filter the agency-shill) — `Ajkrouse` "same boat… using Vibe Coding" · `jeancristof` (r/Solopreneur, 80/20 wall) · `Living-Pin5868` (r/replit — SUPPLIER, mine its commenters not the OP).
- **done**: ≥8 rows + VoC; supplier OPs excluded.

### P5 · X/Twitter first-person  → `prospects/p5-x.md`
- **do**: `web_search` build-in-public distress (`"vibe coded" app broke can't fix founder`, `Replit app broke real users help`); capture handle + URL + quote.
- **done**: ≥4 rows + VoC (secondary venue; low yield expected).

### P6 · Competitor free-audit comment threads  → `prospects/p6-competitor-comments.md`
- **do**: open competitor rescue posts' comment sections; log founders who self-identify in comments (Trigger-3 lane — grooming's proven failure means these founders are in COMMENTS, not open search).
- **seeds**: heydev.us · modall.ca · attributex.ai · softdevdigital.com/blog/fix-vibe-coded-app · rockingtech.co.uk/products/platform-rescue · getautonoma.com/blog/vibe-coding-failures.
- **done**: ≥3 commenter rows + VoC; NO competitor/author logged.

### P7 · F5Bot setup + first pull  → `prospects/p7-f5bot.md`
- **do**: log into F5Bot (Paul's account — creds passed separately in-session, NEVER write them to any file), add keywords (`vibe coded broke`, `Lovable app broken`, `Replit app broke`, `can't access my code`, `agency won't give code`, `dev shop ghosted`) scoped to Reddit+HN+Lobsters; on next digest, read the JSON/RSS feed and log matching ICP posts.
- **done**: keywords live; first feed pulled; ≥3 rows if any matched. (If not yet set up, mark Blocked-on-Paul and skip — chain doesn't block.)

---

## Stage 2 — Consolidate

### P8 · Merge + dedupe + score  → `rescue-sprint/cold-prospect-list.md` + fold VoC into `rescue-sprint/voice-of-customer.md`
- **depends**: P1-P7 (any subset done; note which are pending).
- **do**: merge all `prospects/*.md` rows into one ranked list (warm-first if T3 ran), drop dupes (thread URL = key) + dead + supplier; score by trigger strength; target ~30 usable rows. Fold each file's `## VoC` lines into the four force sections + build the phrase bank (≥1 per force, `[VERBATIM-founder]` only).
- **done**: ~30 deduped rows; VoC ≥5 founder lines each for Push/Pull, ≥3 for Anxiety/Habit; phrase bank non-empty. LIGHT gate: "would Paul recognize these as worth his time?"

---

## Stage 3 — Convert

### P9 · Per-target openers  → `rescue-sprint/outbound-openers.md`
- **depends**: P8 + A2 (offer/price). **do**: one personalized opener per row (right template: referral / warm-intro / forwardable / thread-reply), mirror that row's VoC phrase, `[BOOKING_LINK]` placeholder. **done**: opener per row, ready for Paul to review+send (desk P3). LIGHT gate (HEAVY if any becomes a mass template).

---

## Parallel / already-tracked (see runbook for full cards)

| id | task | status |
|---|---|---|
| T3 | Gmail warm-source pass (Paul consent) → warm rows | Blocked-on-Paul (optional, non-blocking) |
| T8 | Discovery kit (call script + audit template) | ✓ Done (`rescue-sprint/discovery-kit.md`) |
| T9 | Objection + FAQ + follow-up bank → `rescue-sprint/objection-followup-bank.md` | **Ready** |

---

## State

> **Live status/flow is tracked in the kanban board** — `kanban-md list --compact --tag 2607` (board `jetthoughts.github.io`, tasks #1-#10). This file holds the task specs + verified seeds; the board holds status, claims, and dependencies (P8 gated on P1-P7, P9 on P8, P7 blocked on Paul). Copy-paste run prompts: `rescue-sprint/prospects/RUN.md`.

- **Ready now (parallel)**: P1 P2 P3 P4 P5 P6 (+ P7 if F5Bot set up).
- **Then**: P8 (merge) → P9 (openers).
- **Seeds** above were verified via `web_search` on 2026-07-22 — hand to the tasks, don't re-derive.
- Update this table's status + the task's `done` line when a task completes; write the output to its named file.
