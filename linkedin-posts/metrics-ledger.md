---
build:
  render: never
  list: never
---

# LinkedIn metrics ledger — source of truth for post performance

One row per **posted** post. Fill from LinkedIn analytics ~48-72h after posting,
then update at 7 days. This is the weekly review surface (Fri). Frontmatter carries
`status`/`posted_url` only; the numbers live here (no double-authoring).

**The signal that matters is `icp_replies`** — comments or DMs in ICP symptom
language, not impressions. Impressions are reach; icp_replies are validation.

`slug` is the draft's filename without `.md`, so every row resolves to
`linkedin-posts/<course-promo|icp-validation>/<slug>.md` and to the board page
`/linkedin/<lane-folder>/<slug>/`. Rows exist for `scheduled` posts too - a
scheduled post with an empty `posted` cell has not been confirmed live yet.

| posted | slug | lane | opener | impressions | reactions | comments | reposts | dms | icp_profile_views | icp_replies | reply_protocol_run | what to reuse |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 2026-08-13 | week1-thu-validate-before-build | course | idea-led | 307 | 0 | 1 | 0 | 0 | n/a (3 raw) | 0 | no | *(best reach of the three; its one comment is Paul's own first-comment link, which drew 69 impressions of its own)* |
| 2026-08-18 | week1-mon-jira-not-progress | rescue | observation-led | 192 | 1 | 0 | 0 | 0 | n/a (1 raw) | 0 | no | *(only post of the three to earn a reaction)* |
| 2026-08-19 | week1-tue-founding-hypothesis | course | framework-led | 181 | 0 | 0 | 0 | 0 | n/a (0 raw) | 0 | no | *(read at ~24h, earlier in its life than the other two)* |

### Read of 2026-08-20 (first filled rows)

All three rows were read from LinkedIn's own post-analytics pages
(`/analytics/post-summary/urn:li:activity:<id>/`), not estimated. Three things a
cold session should not have to rediscover:

- **Two rows were mis-stated as `scheduled` in frontmatter but were live.**
  `jira-not-progress` and `founding-hypothesis` both published on schedule; nobody
  flipped `status`. Conversely nothing was ever recorded that turned out not to
  have posted. Treat `status: scheduled` on a past-dated draft as unverified, not
  as evidence the post is missing - open the activity feed and check.
- **`posted_url` did not exist on any draft.** Without it there is no way back
  from a ledger row to the LinkedIn post, and the analytics URL needs an activity
  URN you cannot derive from the slug. It is now recorded on all three; add it at
  posting time, not at read time.
- **`icp_profile_views` is not readable on this account.** The post page reports a
  raw "profile viewers from this post" count (kept in parentheses above), but the
  titles behind it sit behind Premium, which is lapsed ("Reactivate Premium"). The
  column is `n/a` rather than `0` - absent data, not a zero result.

**What the numbers say: 0 replies, and reach is the prime suspect.** 680
impressions across three posts, 1 reaction, 0 genuine comments, 0 DMs, so **0
`icp_replies`**. The single comment on `validate-before-build` is Paul's own
first-comment link and fails the SELF clause.

The account-level read (LinkedIn `/dashboard/`, 2026-08-20) is the most
decision-relevant number here: **12,872 followers, 705 post impressions in 7
days.** Two posts in that window reached roughly 190 people each - about **1.5%
of the follower list**. Impressions are trending up (+18% w/w; daily cumulative
Aug 14->20: 83, 154, 205, 258, 402, 613, 705) but from a floor that low, "rising"
describes the slope, not the reach. Also on the dashboard: 303 profile viewers in
90 days (+9%), 333 search appearances Aug 11-17.

Read that against the kill criterion before concluding anything about the
message. Its INCONCLUSIVE branch exists for exactly this shape - *"the account
had no distribution, so the hypotheses were never tested."* A 1.5% follower-reach
rate means these posts have not yet been shown to enough of the right people for
silence to mean rejection. **Do not rewrite hooks on this evidence.** If the
pattern holds at 10 rows, the criterion routes to an ICP-native channel with the
hooks unchanged - and the distribution problem, not the copy, is what to work on
in the meantime.

`reply_protocol_run` is `no` on all three - there were no vague-but-promising
comments to clarify, so the protocol had nothing to act on. That is a real reading,
not a skipped step, but it does mean the 2-hour reply mechanism is still untested.

**The arrival override is also not met** (GA4 328508492, 2026-08-12..20, filtered
to `sessionCampaignName` containing `course_promo` / `icp_validation`). One
campaign appears at all: `course_promo_pre_validation`, **2 sessions, 1 engaged,
1.0 pages/session**, all landing on the `fake-stripe-pre-sale-pieter-levels`
lesson. The override needs >= 3 sessions that are *both* engaged *and* >1 page;
**0 sessions qualify** - the one engaged visitor read the landing lesson and went
no further. `course_promo_module1` (the `founding-hypothesis` first-comment link)
has produced **no** sessions in its first day.

**Structural finding: the rescue lane can never satisfy the arrival override.**
It ships reply-CTA only, with no link by design (`first_comment: "(rescue lane: no
link - reply-CTA only)"`), so it emits no UTM and cannot generate a campaign
session however well it performs. Since the criterion is evaluated *per lane*, the
rescue lane is decidable on `icp_replies` alone. Either accept that asymmetry
deliberately or give the lane a linkless-but-trackable arrival path; do not read
its zero arrivals as a signal.

**This does not trigger the kill criterion.** Three filled rows out of ten per
lane (course: 2, rescue: 1). Impressions are also far below the 3,000 threshold
that would let a KILL be attributed to the message rather than to reach.

Column notes (added 2026-08-20 - the plan named DMs and ICP-role profile views as
primary metrics but the ledger had nowhere to record either):

- **`dms`** - direct messages received about the post. The plan's strongest
  buying-intent signal; previously unrecordable.
- **`icp_profile_views`** - of the profile-view delta, how many carry a
  founder/co-founder/CEO-of-something-small title. Reach without a reply is still
  reach, and this ICP is structurally reluctant to comment in public.
- **`reply_protocol_run`** - yes/no: did Paul run the 2-hour clarifying reply on
  the vague-but-promising comments? A zero-reply window where this was never run
  measures reply latency, not the audience.

## How to read a post's analytics

1. Open the post → "View analytics" (or the impressions count under it).
2. Log impressions, reactions, comments, reposts, and profile-view delta.
3. **icp_replies:** read every comment and DM. A reply counts as ONE qualifying
   reply only if all three clauses hold (tightened 2026-08-20 - the old
   "uses ICP language" wording was not reproducible; two people counting the same
   six-comment thread could land anywhere from 0 to 5):
   - **SELF** - first person about their own build, current or roughly the last 12
     months ("I", "my app", "we paid"). A general statement about how founders or
     dev shops behave never counts, however well-phrased.
   - **ARTIFACT** - names one concrete thing: an account or access (repo, cloud,
     domain, database), a deliverable that does or does not exist (staging, demo,
     a clickable feature), a sum paid, a vendor gone quiet, a specific breakage.
     A feeling with no object ("I'm stuck") fails.
   - **NON-SUPPLIER** - check the headline first. Anyone selling dev services,
     freelancing, or running an agency is excluded even with perfect language;
     they are describing their clients, not themselves.

   One human counts at most once per post; comments and DMs pooled, tagged which.
   A near-miss (SELF but no ARTIFACT) is exactly what the 2-hour clarifying reply
   is for - ask "tickets moving, or can you click it on staging?" and count the
   ANSWER, not the original.
4. Weekly: which opener archetype / lane / topic produced icp_replies? Reuse the
   winners in the next 2-3 drafts; retire the shapes that only got impressions.

## Kill criterion

The criterion lives in
[`docs/workflows/linkedin-icp-validation-plan.md`](../docs/workflows/linkedin-icp-validation-plan.md)
§ "Kill criterion" - read it there, it is the single source.

Corrected 2026-08-20: this section previously claimed "each lane's plan has a
2-week kill criterion". Neither plan had one, and a 2-week window was never
buildable at 2-3 posts/week. The criterion is now counted in **posts, not
weeks**, and evaluated per lane at **10 filled rows** of this table.

The clause that matters most when you sit down to read this ledger: **a row
with empty metric cells does not count toward the ten.** Missing data means the
window has not run, never that it failed. Do not write a verdict off an empty
table.
