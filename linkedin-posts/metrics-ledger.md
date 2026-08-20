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
| 2026-08-13 | week1-thu-validate-before-build | course | idea-led | | | | | | | | | *(first idea-first post; log after 48-72h)* |
| | week1-mon-jira-not-progress | rescue | observation-led | | | | | | | | | *(scheduled 2026-08-18 15:30 CEST; fill `posted` when it goes live)* |
| | week1-tue-founding-hypothesis | course | | | | | | | | | | *(scheduled 2026-08-19 15:30 CEST; no `opener_archetype` in frontmatter)* |

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
