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
2. Export the visual to `assets/<slug>.png`. **Attach the image at compose time,
   BEFORE scheduling** - you cannot add an image to an already-published post
   (LinkedIn allows text edits only). Scheduling text-first to "add the image
   later" is how the 2026-08-13 post shipped imageless. (Until claude-in-chrome can
   drive the native upload dialog, Paul attaches the PNG in the composer.)
3. Stage the `first_comment` (course lane: UTM'd course link).
4. **Schedule at least 24 HOURS ahead** (Paul rule 2026-08-13) - never same-day or
   imminent. The 24h gap is Paul's **pre-verify window**: he reviews the queued post
   (text, image, shape) before it goes live and can tweak or pull it. Pick the next
   Tue-Thu US-morning slot that is ≥24h out.
5. **Paul pre-verifies** within the window. Only then does it publish.
6. **After it publishes, the assistant posts the `first_comment`** via claude-in-chrome
   (typing a comment needs no file dialog - this IS automatable). Course link lives
   here, not the body.
7. Reply to ICP comments within ~2h; route real conversations to DM.
8. Log analytics 48-72h later in the ledger.

### Link unfurl (why the course link shows no preview card)

- **Comment links never unfurl on LinkedIn** - only body links generate a preview
  card. A first-comment link is a bare clickable link by design (the cost of keeping
  the link out of the reach-throttled body).
- Separately, our `og:image` is currently **WebP**, which LinkedIn's crawler often
  won't render - so body links / Slack / Twitter shares may also show no image.
  **Fix pending:** change og:image output to jpg/png in
  `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` (or the root override).
  Tracked as an engineering task.

## Files

- `content-plan.md` — rolling 2-3/wk calendar, lane rotation, revision-wave queue.
- `reference-examples.md` — transcribed good posts to emulate (add more over time).
- `metrics-ledger.md` — per-post performance, the weekly review surface.
- `course-promo/` , `icp-validation/` — the two lanes, each with `README.md`, drafts, `assets/`.
