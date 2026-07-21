# RUN — copy-paste prompts (one per backlog task)

Each prompt is self-contained. Paste ONE into a fresh session. Stage-1 tasks (P1-P7) are parallel-safe — run any/all at once. P8 needs P1-P7; P9 needs P8 + price. Repo: `/Users/pftg/tmp/jetthoughts.github.io`.

**Wrapper (all P-tasks share this spine):**
> Run task **{ID}** from `docs/projects/2607-vibe-code-rescue/backlog.md`. Read that task row + `rescue-sprint/t4-t5-grooming.md` Vote 3 (qualification) once, then do ONLY {ID}. Use its seeded URLs. Tools: `web_search` + `chrome-devtools` only (Reddit = excerpt-only, don't open thread bodies). Append rows + `## VoC` lines to `rescue-sprint/prospects/{FILE}`. Qualify hard: non-technical FOUNDER only — never a dev venting or a supplier advertising rescue; every why-ICP must be a verbatim quoted sentence + URL; log ZERO supplier/agency posts. Set {ID} status in `backlog.md` when done. Don't commit.

---

## Stage 1 — sourcing (parallel)

**P1** — Run task P1 (IndieHackers comment-mine) per the wrapper. Open the 2 seeded IH threads in chrome-devtools, read ALL comments, log self-identifying ICP commenters (skip the vendor OP). File: `prospects/p1-ih-comments.md`. Target ≥6 rows.

**P2** — Run task P2 (IndieHackers founder posts) per the wrapper. `site:indiehackers.com` + non-technical/Lovable/Bolt/stuck/broke; open promising posts, capture OP handle+URL+pain sentence. File: `prospects/p2-ih-posts.md`. Target ≥6 rows.

**P3** — Run task P3 (Hacker News) per the wrapper. Open the 4 seeded HN IDs in chrome-devtools, capture founder/commenter pain + proof-of-pain. File: `prospects/p3-hn.md`. Target ≥4 rows.

**P4** — Run task P4 (Reddit, excerpt-only) per the wrapper. `site:reddit.com` across r/replit, r/NoCode, r/Solopreneur, r/SaaS, r/startups, r/vibecoding; capture sub+handle+URL+quote from excerpts only. File: `prospects/p4-reddit.md`. Target ≥8 rows.

**P5** — Run task P5 (X/Twitter) per the wrapper. `web_search` build-in-public distress. File: `prospects/p5-x.md`. Target ≥4 rows.

**P6** — Run task P6 (competitor comment threads) per the wrapper. Open the seeded competitor rescue-post comment sections, log founders self-identifying in comments only. File: `prospects/p6-competitor-comments.md`. Target ≥3 rows.

**P7** — Run task P7 (F5Bot). Log into F5Bot with Paul's account (creds passed in-session — NEVER write them to any file), add the seeded keywords scoped to Reddit+HN+Lobsters, pull the first JSON/RSS feed, log ICP matches to `prospects/p7-f5bot.md`. If not set up yet, mark Blocked-on-Paul and stop.

## Stage 2 — merge

**P8** — Run task P8. Merge every `rescue-sprint/prospects/p*.md` into `rescue-sprint/cold-prospect-list.md`: dedupe by source URL, drop dead + supplier, score by trigger strength, ~30 rows (warm-first if T3 ran). Fold each file's `## VoC` into `rescue-sprint/voice-of-customer.md` four force sections + build the phrase bank (`[VERBATIM-founder]` only, ≥1/force). LIGHT gate: "would Paul recognize these as worth his time?" Update `backlog.md`. Don't commit.

## Stage 3 — convert

**P9** — Run task P9. One personalized opener per row in `cold-prospect-list.md` → `rescue-sprint/outbound-openers.md`: right template (referral/warm-intro/forwardable/thread-reply), mirror that row's VoC phrase, `[BOOKING_LINK]` placeholder. Needs A2 price. LIGHT gate. Update `backlog.md`. Don't commit.

**T9** — Run task T9. Build `rescue-sprint/objection-followup-bank.md`: likely burned-founder objections ("why not re-hire the shop", "is $25K real", "will you burn me too") + answers grounded in `discovery-kit.md` + `customer-profile-four-forces.md`, plus a 3-touch no-reply follow-up sequence. Use `-` not `—`, no banned AI patterns. LIGHT self-refute in-file. Don't commit.
