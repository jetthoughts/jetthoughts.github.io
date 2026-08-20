# Cold Prospect List - Merged + Deduplicated

> ⚠ **RE-AUDIT COMPLETE (2026-08-20). 19 of 25 rows verified, ALL 19 DROPPED AS LEADS. The remaining 6 are Reddit rows nothing can date.** Not one row cleared the flat ≤30-day rule — the narrowest miss is 69 days, the widest 6.4 years. **This file contains zero send-ready rows and no path to one without new sourcing.** Do not draft or send from these tables.
>
> ⚠ **One row's "verbatim" quote was wrong and had reached the openers.** Row 4 was logged as *"a problem I couldn't fix"*; the founder wrote *"a problem I'm still paying for."* Corrected across all 6 files 2026-08-20 — see §Pass 3. Treat every un-re-read v1 quote as unconfirmed, not just every date.
>
> Verdicts in §Re-audit log below; method + run logs in `prospects/p7-search-sweep.md` §7 (open venues) and §8 (Reddit).
>
> ⚠ **Original warning (2026-07-26)** — batch-1 pre-research found 60% of its sample stale or saturated (recency was eyeballed from excerpts, never read in-thread). The re-audit above turned that 60% into 100% for the rows checked.
>
> P8 output. Merged from P1-P7 prospect files. Deduplicated by source URL (thread URL = join key). Scored by trigger strength. Rows from same thread with different handles are separate entries (different people, same venue).
>
> Sources: P1 IH comments (7), P2 IH posts (6), P3 HN (0), P4 Reddit (8), P5 X (1), P6 Competitor comments (3), P7 date-filtered sweep (0 - blocked on tooling). **Total: 25 rows. Zero dupes found.**
>
> Scoring: Trigger 1 (bugs/breaking) > Trigger 3 (ownership/hostage) > Trigger 7 (stuck/incomplete). Within each trigger, ICP > semi-ICP.
>
> **Best path note**: `outbound-openers.md` supersedes this column — P9 chose **public thread-reply** for IH/Reddit rows (a helpful reply on their own post beats a cold DM) and DM only for LinkedIn/X. Follow the opener's header, not this column.

## Trigger 1 - Bugs / Breaking (11 rows)

| # | handle/channel | source URL | why-ICP (verbatim quote) | verdict | best path |
|---|---|---|---|---|---|
| 1 | SpecBuildLab | https://www.indiehackers.com/post/what-i-learned-after-getting-stuck-building-my-first-no-code-app-in-lovable-ad0a54d71e | "Bugs kept breaking parts of the app, and I had no visibility into what was happening. I kept trying different prompts, hoping one would fix it." | ICP | IH DM |
| 2 | SANICE_AI | https://www.indiehackers.com/post/i-cant-write-a-single-line-of-code-i-built-a-multi-ai-research-platform-anyway-here-s-what-6-weeks-looked-like-e8f052d54c | "I'd describe what I wanted. Claude would write the code. I'd deploy it. It would break. I'd paste the error back. We'd fix it. Repeat 200 times a day." | ICP | IH DM |
| 3 | Joy Adamson | https://www.linkedin.com/posts/nico-casavecchia-2432b19b_i-vibe-coded-the-app-i-dreamed-about-for-activity-7424986945577013249-rizu | "I have built my dream app, and as soon as I got beta testers on it, it totally broke and lovable can't fix it... I am at the stage of moving away from Lovable and get to old good hand made code." | ICP | LinkedIn DM (quote is her COMMENT on Nico Casavecchia's post — DM via her profile, the URL is Nico's post) |
| 4 | r/startups OP (1sgsq6o) | https://www.reddit.com/r/startups/comments/1sgsq6o/vibe_coding_gave_me_a_product_it_also_gave_me_a/ | "Vibe coding gave me a product. It also gave me a problem I'm still paying for." | ICP | Reddit DM |
| 5 | r/replit OP (1pneqwa) | https://www.reddit.com/r/replit/comments/1pneqwa/replit_deleted_my_project_heres_what_i_learned/ | "Replit deleted my project. Not maliciously. Just... it happened." | ICP | Reddit DM |
| 6 | r/replit OP (1ucjd4y) | https://www.reddit.com/r/replit/comments/1ucjd4y/broken/ | "Now it's just reached a point where it's completely broken and it gets stuck in this loop of Found it, Let me fix this, that didn't work" | ICP | Reddit DM |
| 7 | eddwardpark | https://www.indiehackers.com/post/i-just-wanted-to-taste-ai-coding-tools-a-week-passed-76965a92c6 | "You fix one thing, Claude breaks two others. Then you fix those and something else shifts. After a while you're not building anymore - you're just chasing your own tail." | semi-ICP | IH DM |
| 8 | KaiaColban | https://www.indiehackers.com/post/learning/learning-to-code-from-scratch-with-ai-what-worked-what-didn-t-aOlE7Lfj63y2u3G5aqIT | "It was like asking for insulation for my house, and the AI gave me marshmallows. I didn't notice until I tried to hang drywall, and by then it was too late." | semi-ICP | IH DM |
| 9 | r/cursor OP (1q1v99l) | https://www.reddit.com/r/cursor/comments/1q1v99l/does_vibe_coding_hit_a_massive_wall_once_your/ | "I've built 3 versions using AI. The last one was so complicated that when I hired someone to fix the 'vibe' bugs, they told me it was easier to burn the whole thing down and start over." | ICP | Reddit DM |
| 10 | r/Solopreneur OP (1nhcc72) | https://www.reddit.com/r/Solopreneur/comments/1nhcc72/at_40_and_5_years_stuck_in_this_buildabandon/ | "I can build any web app quickly, but once it's done, I lose motivation... because I spent 3 months building and the product is a house of cards." | semi-ICP | Reddit DM |
| 11 | r/Solopreneur OP (1r9mxtm) | https://www.reddit.com/r/Solopreneur/comments/1r9mxtm/nontechnical_solo_founders_using_ai_to_build/ | "AI gets you 80% of an app fast, but the last 20%-infrastructure, security, scaling-is an abyss for non-technical founders." | semi-ICP | Reddit DM |

## Trigger 3 - Ownership / Hostage (3 rows)

| # | handle/channel | source URL | why-ICP (verbatim quote) | verdict | best path |
|---|---|---|---|---|---|
| 12 | Afrikonnect | https://www.indiehackers.com/post/looking-to-connect-with-non-technical-founders-f88cafc2c2 | "Am currently burned by devs who aren't professional and lacking how to build and execute." | ICP | IH DM |
| 13 | Saul_E | https://www.indiehackers.com/post/help-someone-quoted-me-55-000-to-rebuild-my-app-210b24265c | "Bootstrapped with a dev (co-founder, who has now dropped out)... Have conducted a new dev crew who've advised they rebuild it. Will take 1 individual... 55k (money i don't have)." | ICP | IH DM |
| 14 | r/nocode OP (1mx884d) | https://www.reddit.com/r/nocode/comments/1mx884d/why_is_a_vibe_coded_project_stuck_at_8090/ | "I spent $5k on a freelancer who used [AI Tool] to build it. It looks perfect but none of the actual API integrations work and they have ghosted me now that it's time to fix the database errors." | ICP | Reddit DM |

## Trigger 7 - Stuck / Incomplete (11 rows)

| # | handle/channel | source URL | why-ICP (verbatim quote) | verdict | best path |
|---|---|---|---|---|---|
| 15 | dianewilliams75 | https://www.indiehackers.com/post/looking-to-help-non-technical-founders-6e1d9b33ae | "This is my current situation!" | semi-ICP (quote is content-free — reacting to a help-offer thread; no evidence of a broken app; verify her actual situation before sending) | IH DM |
| 16 | 659ertramp | https://www.indiehackers.com/post/looking-to-help-non-technical-founders-6e1d9b33ae | "I'm a trades professional (electrician) working on a practical AI-driven tool for contractors... I'm at the point where I need the right technical direction to bring the MVP to life without wasting time or money." | semi-ICP (pre-build/direction-seeking — may have no code to audit; send last, verify code exists) | IH DM |
| 17 | J_Jie556517 | https://www.indiehackers.com/post/looking-to-help-non-technical-founders-6e1d9b33ae | "I'm a university professor with a field-tested methodology for intonation training looking for a technical partner." | semi-ICP (partner-seeking, likely pre-build — audit offer may not fit; send last, verify code exists) | IH DM |
| 18 | lucadeza | https://www.indiehackers.com/post/looking-to-help-non-technical-founders-6e1d9b33ae | "I am a former professional athlete building an AI Powered B2B SaaS platform but non technical (currently using an agency). ... I am looking for a technical co-founder so that we can start building in house." | ICP | IH DM |
| 19 | Abnrav | https://www.indiehackers.com/post/looking-to-connect-with-non-technical-founders-f88cafc2c2 | "I am a non-technical founder ... I had an app built ... my lack of knowledge and ingenuity have prevented it from catching on. ... At this point, funds have run dry and I have lost the limited support that I had. The app is in the App and Google Play stores but it is stagnant." | ICP | IH DM |
| 20 | Sam A | https://www.indiehackers.com/post/building-my-first-app-as-a-non-technical-founder-a309cb92c3 | "I'll also write a post about how I basically failed with another project where I got a freelance developer to build for me before truly validating the product / market." | ICP | IH DM |
| 21 | techPackets | https://www.indiehackers.com/post/i-am-frustrated-with-no-code-i-am-done-14a7ce60cb | "I hired a developer from freelancer and paid few hundred dollars to customise that according to my need. That also failed because even the freelancer struggled to understand the logic and then just vanished." | ICP | IH DM |
| 22 | r/nocode OP (1tdaqs9) | https://www.reddit.com/r/nocode/comments/1tdaqs9/what_happens_when_nontechnical_people_try_to/ | "Im a non technical founder, and im stuck with my app" | ICP | Reddit DM |
| 23 | r/nocode OP (1qo1nug) | https://www.reddit.com/r/nocode/comments/1qo1nug/i_thought_nocode_would_save_me_months_it_actually/ | "I thought no-code would save me months - it actually made me more stuck" | ICP | Reddit DM |
| 24 | r/startups OP (1thpn8u) | https://www.reddit.com/r/startups/comments/1thpn8u/vibe_coding_and_the_if_you_buildit_paradox/ | "Vibe coding creates the illusion of progress. You describe the app, the tool writes the code, but you have no idea what it actually did." | semi-ICP | Reddit DM |
| 25 | @markgadala | https://x.com/markgadala/status/1902738445920874553 | "I have 'vibe coded' full apps but I would never sell them without help from real coders. Vibe coding is best used in its current form to help bridge gaps." | semi-ICP | X DM |

## Summary

| Metric | Count |
|---|---|
| Total rows | 25 |
| ICP | 19 |
| semi-ICP | 6 |
| Trigger 1 (bugs/breaking) | 11 |
| Trigger 3 (ownership/hostage) | 3 |
| Trigger 7 (stuck/incomplete) | 11 |
| IndieHackers | 12 |
| Reddit | 9 |
| LinkedIn | 1 |
| X/Twitter | 1 |
| HN | 0 (dev-dominated, no founder voices) |
| P7 date-filtered sweep | 0 (method shipped 2026-08-08 blocked on tooling; re-run 2026-08-20 with tooling unblocked — 23 threads opened, still 0 qualified rows) |
| Re-audited and dropped as leads (2026-08-20) | 6 of 25 |

### LIGHT gate: "Would Paul recognize these as worth his time?"

**SUPERSEDED 2026-07-26** — the original PASS ("Yes, the 19 ICP rows...") was issued on rows later found 60% stale/saturated in batch-1 pre-research (Saul_E's post turned out to be from 2020; Afrikonnect's quote was a year-old comment on someone else's thread). The gate re-runs as part of #29's re-verification; the ICP-fit *reasoning* stands, the row-level freshness does not.

**Honest limitations:**
- Most rows are from IndieHackers and Reddit. HN and X/Twitter yielded thin results (dev-dominated, auditor-heavy).
- Reddit handles are partial (excerpt-only, some OPs unnamed). Improving Reddit coverage needs thread-open access, not another keyword feed.
- No warm intro paths yet - all are cold outreach via platform DMs.
- Semi-ICP rows (6) are founders who built with AI themselves, not paid a shop. They still need rescue but the trigger is different.

### Pending
- ~~P7 date-filtered sweep: add rows once the tooling unblock lands~~ — **tooling unblocked 2026-08-20**; IndieHackers, LinkedIn, X and HN all open from a host session and IH has a date-sorted search index (`prospects/p7-search-sweep.md` §7a). The sweep still returned **0 qualified rows** — the blocker is now the venue mix, not the tooling. Reddit remains closed.
- Deduplication key: source URL. No duplicates found across P1-P7.

---

## Re-audit log — card #29, 2026-08-20

Method: each thread opened once, `datePublished` read from the page (IH ships JSON-LD; LinkedIn renders public posts logged-out), all replies read for thread health. Vote 3 v2, flat ≤30-day lead window, `WINDOW_START = 2026-07-21`.

| # | handle | verified date (read in-thread) | age | post\|comment | thread health | verdict |
|---|---|---|---|---|---|---|
| 1 | SpecBuildLab | 2025-10-09 | 316 days | post | clean (3 comments, no competing pitch) | **DROP as lead** — stale |
| 2 | SANICE_AI | 2026-04-12 | 130 days | post | **saturated** — the spearprotocol.com "free… just clarity" pitch is in-thread as the retro described, and SANICE_AI now replies to nearly every commenter pitching his own free tool | **DROP as lead** — stale + saturated + OP now behaves as a supplier |
| 3 | Joy Adamson | ~2026-02-05/06 (comment, "6mo"; host post 2026-02-05) | ~196 days | **comment** on Nico Casavecchia's post | clean — her "how can I get help?" is still publicly unanswered | **DROP as lead** — stale. Paul's standing override candidate, but 6.5 months is far outside any window |
| 12 | Afrikonnect | comment "a year ago" (host post 2025-07-29) | ~1 year | **comment** on someone else's post | thread has other help-offers in the same spot | **DROP as lead** — stale + comment mis-routed in v1 (row was logged as if Afrikonnect authored the post) |
| 13 | Saul_E | 2020-05-26 | ~6 years 3 months | post | 87 comments, long dead | **DROP as lead** — stale by six years |
| 19 | Abnrav | comment "a year ago" (same host post as row 12) | ~1 year | **comment** on someone else's post | as above | **DROP as lead** — stale. Verified for free in row 12's visit |

**Confirmed**: all three failures the 2026-07-26 retro named were real, and reading the timestamp took one page load each. Nothing in this sample was a false alarm.

### Pass 2 — the 9 remaining openable rows (same day, 6 page loads)

| # | handle | verified date (read in-thread) | age | post\|comment | thread health | verdict |
|---|---|---|---|---|---|---|
| 7 | eddwardpark | 2026-06-12 | 69 days | post | clean | **DROP as lead** — stale. The narrowest miss on the whole list |
| 8 | KaiaColban | 2025-09-06 (`dateModified` 2026-02-26 is an edit, not the post date) | 348 days | post | clean | **DROP as lead** — stale |
| 15 | dianewilliams75 | comment "10 months ago" (host post 2025-10-28) | ~10 months | **comment** on someone else's post | **saturated** — 5 free-help / DM offers in-thread | **DROP as lead** — stale + saturated |
| 16 | 659ertramp | comment "9 months ago" | ~9 months | **comment** | as above | **DROP as lead** |
| 17 | J_Jie556517 | comment "7 months ago" | ~7 months | **comment** | as above | **DROP as lead** |
| 18 | lucadeza | comment "10 months ago" | ~10 months | **comment** | as above | **DROP as lead** |
| 20 | Sam A | 2020-03-16 | ~6 years 5 months | post | long dead | **DROP as lead** — stale by six years |
| 21 | techPackets | 2022-08-27 | ~4 years | post | long dead | **DROP as lead** — stale |
| 25 | @markgadala | 2025-03-20 (snowflake-derived from the status ID) | 518 days | post | n/a | **DROP as lead** — stale |

**Two things this pass settled.** The host thread behind rows 15-18 is itself a help-offer post carrying five competing free-help pitches, so all four rows were saturated as well as stale — check 5 would have caught them even if the dates had held. And `dateModified` is not a post date: row 8 shows a 2026-02-26 edit on a 2025-09-06 post, which is exactly the kind of number an excerpt-based pass mistakes for freshness.

**VoC**: all 5 threads harvested, **zero new `[VERBATIM-founder]` lines admitted.** Their good quotes were already captured in the original P8 pass, and the one fresh-looking candidate ("I found international devs who were so much cheaper") turned out to be a dev-sourcing vendor pitching his own agency — tagged `[vendor]`, not admitted.

**VoC**: every dropped thread was harvested before closing, per the lead-vs-voice split. Rows 1/2/12/13 quotes were already in `voice-of-customer.md`; no new lines came from the re-audit itself (the 6 new founder lines came from the fresh-sourcing pass — see `prospects/p7-search-sweep.md` §7).

### Pass 3 — the Reddit rows (2026-08-20, after Paul granted browser access)

Access decision: Paul said no API, use a browser. **Result: 4 of 10 verified, 6 still unverifiable — Reddit blocks automation at the network layer.** What worked and what did not is in `prospects/p7-search-sweep.md` §8; the short version is that Reddit's **per-thread `.rss` feed** is readable by plain `curl` and carries an exact `<published>` datetime, but it rate-limits hard, and the automation browser gets a "Prove your humanity" challenge that escalates to "You've been blocked by network security." Per the brief, no attempt was made to work around detection.

| # | handle | verified date (exact, from thread `.rss`) | age | verdict |
|---|---|---|---|---|
| 4 | r/startups OP (`/u/Mental_Push_6888`) | 2026-04-09 | 133 days | **DROP as lead** — stale |
| 9 | r/cursor OP (`/u/cdaviddav`) | 2026-01-02 | 230 days | **DROP as lead** — stale |
| 14 | r/nocode OP (`/u/anchit_rana`) | 2025-08-22 | 363 days | **DROP as lead** — stale |
| 22 | r/nocode OP (`/u/Alarmed_Movie9661`) | 2026-05-14 | 98 days | **DROP as lead** — stale. The freshest Reddit row on the list |
| 5, 6, 10, 11, 23, 24 | r/replit ×2, r/Solopreneur ×2, r/nocode, r/startups | — | — | **UNVERIFIABLE** — rate-limited on `.rss`, network-blocked in the browser |

**⚠ A misquote was found and corrected — this is the more serious finding.** Row 4's "verbatim" quote read *"It also gave me a problem I couldn't fix."* The founder's actual words are **"It also gave me a problem I'm still paying for."** The phrase "I couldn't fix" appears nowhere in the thread. It had propagated into five files including `outbound-openers.md`, so **the opener drafted for this person quoted words he never wrote** — the one defect class that survives a staleness check and lands in front of the prospect. Corrected in all six places 2026-08-20.

Rows 9 and 14's quotes are attributed to comments, and the `.rss` feed for those two returned the post without the comment tree, so they could be **neither confirmed nor refuted**. They are not accused of anything — but after row 4, no v1 Reddit quote should be treated as verbatim until it is re-read at source. Row 22's quote checked out and is in fact stronger than logged: the founder wrote "im stuck with my app **for 3 months now**."

**Even the freshest Reddit row is 98 days old.** These rows were sourced on 2026-07-22 from search excerpts, which means they were already between 1 and 11 months stale *on the day they were logged as "ICP, ready."*

### Final tally

| | Count | Rows |
|---|---|---|
| **Verified and dropped as leads** | **19** | 1, 2, 3, 4, 7, 8, 9, 12, 13, 14, 15-22, 25 |
| **Unverifiable — Reddit, blocked** | **6** | 5, 6, 10, 11, 23, 24 |
| **Send-ready** | **0** | — |

**The v1 list is closed.** Nineteen of 25 rows were verified and every one failed the ≤30-day rule — the narrowest miss is 69 days, the widest 6.4 years. The remaining 6 are Reddit rows that no available method can date: their `.rss` feeds rate-limit and the automation browser is network-blocked. Retire them rather than leaving them looking like a queue; a row that cannot be dated cannot become a lead.

**Verification is cheap; excerpts are not.** Nineteen rows cost roughly twenty page loads. The same rows were logged on 2026-07-22 as "ICP, ready" on eyeballed excerpt dates, then carried 25 openers, a scored sheet and Paul's approval loop before batch-1 pre-research caught the first three. The Reddit rows were already 1-11 months stale the day they were logged, and one of them carried a quote the founder never wrote.
