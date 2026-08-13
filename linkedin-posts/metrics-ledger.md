# LinkedIn metrics ledger — source of truth for post performance

One row per **posted** post. Fill from LinkedIn analytics ~48-72h after posting,
then update at 7 days. This is the weekly review surface (Fri). Frontmatter carries
`status`/`posted_url` only; the numbers live here (no double-authoring).

**The signal that matters is `icp_replies`** — comments or DMs in ICP symptom
language, not impressions. Impressions are reach; icp_replies are validation.

| posted | slug | lane | opener | impressions | reactions | comments | reposts | profile views | icp_replies | what to reuse |
|---|---|---|---|---|---|---|---|---|---|---|
| 2026-08-13 | validate-before-build | course | idea-led | | | | | | | *(first idea-first post; log after 48-72h)* |

## How to read a post's analytics

1. Open the post → "View analytics" (or the impressions count under it).
2. Log impressions, reactions, comments, reposts, and profile-view delta.
3. **icp_replies:** read every comment/DM. Count the ones using ICP language
   (e.g. "I can't tell if they're making progress", "the repo is under their name",
   "I built the wrong thing first"). Those are the qualified signal.
4. Weekly: which opener archetype / lane / topic produced icp_replies? Reuse the
   winners in the next 2-3 drafts; retire the shapes that only got impressions.

## Kill-criteria tie-in

Each lane's plan has a 2-week kill criterion. Evaluate it against the `icp_replies`
column here, not impressions. Near-zero icp_replies across a lane's posts = the
message/segment isn't landing (revisit before spending more reach).
