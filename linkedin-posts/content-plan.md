---
build:
  render: never
  list: never
---

# LinkedIn content plan — rolling calendar

**Cadence:** 2-3 posts/week, Tue-Thu, US-morning (9-11am ET = ~15-17 CEST).

**Plan by PILLAR, not just lane** (adopted 2026-08-13, see `content-pillars.md`):
hold roughly **70% value / 20% personal / 10% promo** across each ~2-week window,
plus ~1 poll/week. Course/rescue are just the *topics*; the pillar is what the post
*gives*. Pull material from `story-bank.md` (real cases + interview backlog) and
`trends.md` (curation/reaction fuel).

**Pillars:** teach · opinion · story · build-in-public · curation/reaction (value)
· poll (engagement) · promo (the ask - course link in first comment, ~10% only).

**The 70% rule:** most value posts carry NO course link. Only the ~10% promo slot
links the course. Decoupling the give from the ask is what makes the ask land.

Status legend: `draft` · `revised` (idea-first, ready) · `approved` · `scheduled` · `posted`.

## Next actions (2026-08-14 handoff) - STOP BUILDING, START SENDING

All LI work landed on master (**PR #455 merged 2026-08-17**). 19 posts
drafted, illustrated (caricatures + exhibits), reordered. But the active bet (Vibe
Code Rescue) is **RED: zero outreach touches ever sent** - the bottleneck is
distribution, not demand, and 3+ weeks of finished content is *activity, not
validation*. **Do NOT make more posts until the first batch is live.** In priority:

1. **Schedule the ready LinkedIn run** - pre-verify founding-hypothesis (approved) →
   claude-code → vendors → vibe-coding, schedule >=24h out. Assistant drives the
   composer; Paul approves + attaches images. Starts UTM data.
2. **Start the direct rescue outreach** (the real bottleneck, stuck ~18 days) - send
   ~10 personalized touches from the 2607 kit (`outbound-openers.md` / SEND-SHEET).
   This is what books calls; it starts the kill-criteria clock.
3. **Resolve the 2 gating decisions** - pricing ($2.5-10K vs $25-50K) + category name
   (page-one occupied, competitor on the exact name). They frame every outreach message.
4. **Instrument** - log ICP replies in `metrics-ledger.md` / the 2607 pipeline sheet.

**Open items:** a real "I was wrong" story to replace the deleted BigBinary
(story-bank Q2); the caricature tool
now works (billing on; `GEMINI_API_KEY`/`GOOGLE_API_KEY` in `~/.claude/.env`,
untracked - Paul may rotate). Status snapshot: `docs/business/operating-system.md` §1
(RED) + the Aug-2026 investor update.

## Schedule (pillar-tagged)

Reordered 2026-08-14 (Paul): front-load pure-value/personal posts; space the course
links (~15%), the AI-tooling posts, and the repetitive clusters (progress-visibility:
jira/staging/trust-signals; interview: friends/mom-test/ten-interviews). The board
sorts by each post's `proposed_for`, so this table = the live board order.

| Date | Pillar | Post | Link? | Status |
|---|---|---|---|---|
| Aug 13 | story/opinion | `course-promo/week1-thu-validate-before-build` | course | **posted** |
| Aug 18 | opinion | `icp-validation/week1-mon-jira-not-progress` | none | **scheduled** ✓ |
| Aug 19 | teach | `course-promo/week1-tue-founding-hypothesis` | course *(promo)* | **scheduled** ✓ |
| Aug 25 | reaction | `personal/reaction-claude-code-trust` | none | drafted ✓ |
| Aug 27 | build-in-public | `personal/bip-vendors-still-burning-founders` | none | drafted ✓ |
| Sep 1 | reaction | `personal/reaction-vibe-coding-front-back` | none | drafted ✓ |
| Sep 3 | teach | `course-promo/week1-thu-price-before-product` | none | revised ✓ |
| Sep 8 | opinion | `icp-validation/week1-tue-staging-question` | blog | revised ✓ |
| Sep 10 | teach/opinion | `course-promo/week2-mon-friends-politely-lying` | none | revised ✓ |
| Sep 15 | poll | `course-promo/week1-wed-first-move-poll` | none | draft |
| Sep 17 | build-in-public | `personal/bip-build-your-own-tools-with-ai` | none | drafted ✓ |
| Sep 22 | teach | `course-promo/week2-tue-mom-test-past-questions` | none | revised ✓ |
| Sep 24 | story | `course-promo/backlog-40k-mvp-chasing-fixes` | course *(promo)* | draft |
| Sep 29 | poll | `icp-validation/week1-wed-trust-signals-poll` | none | revised ✓ |
| Oct 1 | teach | `course-promo/week2-fri-ten-interviews-recap` | none | revised ✓ |
| Oct 6 | opinion | `icp-validation/backlog-vibe-coding-disposable` | none | draft |
| Oct 8 | poll | `course-promo/week2-wed-interview-count-poll` | none | draft |
| Oct 13 | story/promo | `course-promo/week1-fri-why-i-wrote-it` | course *(promo)* | draft |
| Oct 15 | opinion | `personal/opinion-permission-to-fix` | none | drafted ✓ |

**Ratio:** across 18 posts, only **3 course links** (founding, 40k, why-i-wrote-it =
~15%) + 1 blog link; the rest is value/personal/poll. **Aug 25 → Sep 3 is four
straight no-link posts** - the run that makes the feed read as a person with takes.

**Still open:** a real "I was wrong about a founder/idea" story to replace the deleted
BigBinary draft (story-bank Q2). Slot it when Paul has a case.

## Per-post checklist

- [ ] Revised to idea-first, self-score ≤2/10 + shape-tell critic
- [ ] Visual exported to lane `assets/`
- [ ] `first_comment` staged (course lane: UTM'd course link)
- [ ] **Image attached in the composer BEFORE scheduling** (can't add to a live post)
- [ ] **Scheduled ≥24h ahead** for a Tue-Thu US-morning slot
- [ ] **Paul pre-verified** in the 24h window
- [ ] Published
- [ ] First comment posted right after publish (assistant, via claude-in-chrome)
- [ ] Metrics logged 48-72h later
