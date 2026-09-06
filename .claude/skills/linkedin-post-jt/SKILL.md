---
name: linkedin-post-jt
description: Use when writing or revising a LinkedIn post for Paul Keen / JetThoughts (https://www.linkedin.com/in/paul-keen/), or any LinkedIn content under the ICP validation or course-promo campaigns. Triggers on phrases like "LinkedIn post", "next LI post", "post for LinkedIn", "linkedin draft", or any reference to docs/workflows/linkedin-icp-validation-plan.md. Loads Paul's personal voice rules (no credential stamps, no marketing CTAs, no slogany flips) and the campaign's hypothesis-tracking conventions.
---

# LinkedIn Post Skill — Paul Keen / JetThoughts

## Mandatory pre-writing reads

Before drafting any LinkedIn post, read these four files in order:

1. `docs/workflows/linkedin-post-pipeline.md` — voice rules, anti-AI patterns, AI scoring rubric, frontmatter format (THE primary reference; defer to it when this summary disagrees)
2. `docs/workflows/linkedin-icp-validation-plan.md` — campaign plan, hypotheses being tested
3. `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` — ICP-E pain language
4. `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` — base voice formula and banned word list

## Voice rules at a glance

**Author identity:** All posts authored by Paul Keen (founder), posted from his personal account. Never corporate. Never disclose AI authorship.

**Register B — Fried-style committed hammering (Paul 2026-08):** deliver the idea
with conviction, idea-first. No staged parables, no beat-marking ("Then it hit
me"), no rubric-beige neutrality. Deliver the point, not the setup.

**State convictions flat — no credential stamps:**
- ❌ "I learned this the hard way"
- ❌ "I've been saying this for 17 years"
- ✅ "Jira is not progress." (just state it)

**No slogany sentence flips:**
- ❌ "Tickets move. Product doesn't."
- ✅ "This shows up in almost every team I look at where the founder isn't technical."

**No marketing/sales CTAs in the body:**
- ❌ "Comment DEMO and I'll send..." / "DM me if..."
- ❌ Any body link to JT website, scheduling tool, or lead magnet
- ✅ Real peer question that invites founders to share their own experience
- **No course link anywhere, including the first comment (stopped 2026-09-06).** The course goes in a DM or after a call. Rescue lane ships no link (reply-CTA only).

**Shape that the feed routes (decision of record 2026-09-06, `linkedin-posts/content-plan.md`):**
- First line: flat contrarian conviction on a live professional topic.
- **One concrete failure mechanism in plain words** - the sentence a reader can quote and argue with ("the AI doesn't edit your code, it writes new code, so the bug comes back from the copies").
- ~130 words, **text only - no designed exhibit** (every imaged post stayed under 350 impressions, both text-only posts cleared 9,000), no hashtags, one real question to close.
- LinkedIn's job is referrals and credibility with CTOs, heads of engineering and agencies who see broken founder apps. Founder discovery happens in comments on founders' posts, in calls and in DMs, not in Paul's broadcast.

**Anti-AI structural rules (zero tolerance):**
- No rule-of-three negative parallelism ("Not X. Not Y. Z.")
- No clean parallel sentence-stems repeated 2+ times
- No signposting ("Three things will happen:", "Here's the thing:")
- No em dashes — use `-` always
- No fabricated counts ("we've seen this 50 times")

## Post structure (5-beat skeleton)

```
Beat 1 (1 line):    Conviction statement, flat - no credential
Beat 2 (2-3 lines): Specific recent anecdote with a number
Beat 3 (1 line):    Name the pattern via observation, not slogan
Beat 4 (4-8 lines): Tactical content - give it away in full, no gating
Beat 5 (1-2 lines): Why this matters for the reader
Close (1 line):     Real question to readers
```

Length target: 150-200 words.

## Save location (three lanes)

```
linkedin-posts/course-promo/week{N}-{day}-{slug}.md    # course-topic value posts, NO link (link lane stopped 2026-09-06)
linkedin-posts/icp-validation/week{N}-{day}-{slug}.md  # rescue lane, no links, 1/week in the viral shape
linkedin-posts/personal/{slug}.md                      # brand/opinion/engineering posts - the main lane now
```

Outside `content/` (Hugo renders drafts only via the dev-only board mount).

## Frontmatter

Follow `linkedin-post-pipeline.md` for the full schema. Non-obvious required
fields: `status` (draft/scheduled/posted — the board's source of truth),
`posted_url` (record at posting time; analytics URLs need the activity URN),
`first_comment` (staged verbatim; verify it actually ships — one sat unposted
for 17 days), `utm_campaign`/`utm_content`.

## Gates before handback

1. Self-score against the pipeline's AI rubric (target ≤ 2/10); rewrite flagged lines first
2. `reflexion-reflect` BEFORE first handback (BLOCKING); `reflexion-critique` after any pushback on the same draft
3. Handback ends with the board preview link: `http://localhost:<session port>/linkedin/<lane>/<slug>/` — always the link, never the post body pasted instead

## Posting mechanics

Posting is Paul-gated. Composer typing is blocked for automation — stage
everything; Paul pastes. First comments CAN be posted via BrowserOS neo after
the post is live. Metrics land in `linkedin-posts/metrics-ledger.md` (one row
per posted post; kill criterion evaluated per lane at 10 filled rows).
