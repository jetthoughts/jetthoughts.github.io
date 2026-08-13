# LinkedIn Operating System — Paul Keen / JetThoughts

How we run Paul's LinkedIn: two lanes, a slow cadence, one voice doctrine, and
per-post analytics tracking. Nothing publishes without Paul.

## Voice + shape (the engine)

**Canonical:** `docs/workflows/linkedin-post-pipeline.md` → "Post shape: idea-first,
deliver the point (BLOCKING)". Corrected 2026-08-13 away from the old "story, not
advice" parable doctrine that produced AI slop. In one line: **open with the idea
flat, argue it plainly, deliver the tactic in full, plain short sentences, close
with a real peer question.** Study the writers Paul rates: John Cutler
(`johnpcutler`), Luca Rossi (`lucaronin`/refactoring.fm). Good examples transcribed
in [`reference-examples.md`](reference-examples.md).

## The two lanes

| Lane | Folder | Stage | ICP | Plan |
|---|---|---|---|---|
| **Course** (pre-validation) | `course-promo/` | idea-stage / about-to-build | validate demand *before* building | `docs/workflows/linkedin-course-promo-plan.md` |
| **Rescue** (control-loss) | `icp-validation/` | already building, can't verify | founder stuck with a dev shop | `docs/workflows/linkedin-icp-validation-plan.md` |

Both post from Paul's personal account. **Rotate between lanes** so the feed isn't
all one stage. Assets (images) live in each lane's `assets/` folder.

## Cadence (2026-08-13, Paul)

**2-3 posts per week, max** — the best-for-ICP volume (non-technical founders don't
want a daily firehose). Post at the ICP's peak read time: **Tue-Thu, US-morning
(9-11am ET = ~15:00-17:00 CEST)**. Schedule via LinkedIn's native scheduler. One
lane per post, alternating.

## Every post carries a visual (Paul: "missed images")

Each post gets one image in its lane's `assets/`. Reuse course exhibits (the
refactoring.fm-style SVGs) exported to PNG via `rsvg-convert -w 1080 <svg> -o <png>`
— they're on-brand and seed the course bridge without a link. Frontmatter records
the path.

> **Known tooling gap:** claude-in-chrome can schedule text but cannot drive
> LinkedIn's native file-upload dialog. Until solved, the image is attached
> manually by Paul (or dropped in a fresh composer). Track the fix in the backlog.

## Frontmatter schema v2

Lifecycle + pointers in frontmatter; **performance data lives in the ledger, not
the frontmatter** (single source, no double-authoring — see below).

```yaml
---
lane: course | rescue
week: 1
day: thursday
author: paul-keen
pillar: <e.g. demand-before-build | progress-visibility>
hypothesis: <which validation hypothesis>
opener_archetype: idea-led | observation-led | question-led | stat-led | conflict-led
icp_test: <one line - what this post tests>
visual: assets/<slug>.png        # required - the image that ships with the post
status: draft | scheduled | posted
scheduled_for: <ISO date, if scheduled>
posted_url: <LinkedIn URL, once posted>
first_comment: |            # posted as the FIRST COMMENT right after publish (not the body)
  <course lane: the ready comment incl. the UTM'd course link. rescue lane: usually empty.>
notes: | <voice trade-offs, revision history>
---
```

## Link policy per lane (BLOCKING)

- **Never a link in the post body** - LinkedIn throttles reach on external links, and JT voice bans in-body CTAs.
- **Course lane** → one UTM'd course link in the **first comment** (`first_comment` in frontmatter). Link the specific lesson that delivers on the post's promise. This is the arrival signal the metrics-ledger tracks.
- **Rescue lane** → no link. Reply-CTA only (test ICP presence via replies, not clicks).
- Hashtags: 2-3 max, relevant, at the end of the body. 0 is acceptable and on-trend. Never a wall of tags.

**Posting the first comment:** claude-in-chrome CAN do this (typing a comment needs no file dialog) - after the post publishes, add the `first_comment` text via the assistant. Only the image attach is a manual gap.

## Analytics tracking — the ledger (proposed "better way")

Instead of scattering metrics across 20 frontmatter blocks, **one reviewable table**:
[`metrics-ledger.md`](metrics-ledger.md). One row per posted post, filled from
LinkedIn analytics. This is the weekly review surface (same pattern as the outreach
`pipeline.md`). Frontmatter only carries `posted_url` + `status`; the ledger owns
the numbers.

**Review workflow (per post):**
1. **~48-72h after posting**, open the post's LinkedIn analytics ("View analytics").
2. Log the row: impressions, reactions, comments, reposts, profile views, and the
   real signal — **ICP replies** (comments/DMs in ICP symptom-language).
3. **Weekly (Fri):** scan the ledger. Which opener archetype / lane / topic pulled
   ICP replies? Reuse the winners; retire the flat ones. Note it in the ledger's
   "what to reuse" column.
4. The `icp_replies` count, not impressions, decides whether the campaign is
   validating (per each lane's plan kill-criteria).

## Posting workflow

1. Draft against the idea-first skeleton; self-score ≤2/10 (pipeline rubric) + the
   shape-tell critic.
2. Export the visual to `assets/<slug>.png`.
3. Paul (or claude-in-chrome for text) schedules for the next Tue-Thu US-morning slot.
4. Attach the image (manual until the upload gap is solved).
5. Reply to ICP comments within ~2h; route real conversations to DM.
6. Log analytics 48-72h later in the ledger.

## Files

- `content-plan.md` — rolling 2-3/wk calendar, lane rotation, revision-wave queue.
- `reference-examples.md` — transcribed good posts to emulate (add more over time).
- `metrics-ledger.md` — per-post performance, the weekly review surface.
- `course-promo/` , `icp-validation/` — the two lanes, each with `README.md`, drafts, `assets/`.
