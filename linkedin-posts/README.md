---
build:
  render: never
  list: never
---

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

## Active outreach + channels (Rock 1, reuse existing kits)

Posts are inbound/passive; **outreach is the faster Rock-1 signal** (direct replies in days, not weeks). Do NOT rebuild - wire the kits that already exist:

- **Course-lane outreach + 2nd channel:** `docs/projects/2605-.../50-59-execution/50.02-pilot-outreach-campaign-kit.md` - already has **Reddit (`r/startups`, `r/Entrepreneur`) + IndieHackers** value-first drafts with UTM'd course links. This IS probe #2 (the ICP-native channel).
- **Rescue-lane cold-DM:** `docs/projects/2607-vibe-code-rescue/rescue-sprint/` - `outbound-openers.md`, `cold-prospect-list.md`, `SEND-SHEET.md`.

**The rule (BLOCKING, same bar as posts): a reply, not a pitch.** Quote the prospect's specific post/comment in line 1, answer their actual question, and mention the free course only if it genuinely fits. No cold pitch, no slop, no "DM me". ~10 min/day.

**Channel discipline: exactly two ponds, then scale the winner.** LinkedIn (posts + outreach) is warm/set-up but skews employed; idea-stage non-technical founders skew Reddit/IndieHackers - so run **LinkedIn + one ICP-native channel (Reddit/IH) in parallel**, read the `metrics-ledger` + reply quality over ~2 weeks, then pour into whichever pond actually engages. Don't spray 4 channels thin.

## The two lanes

| Lane | Folder | Stage | ICP | Plan |
|---|---|---|---|---|
| **Course** (pre-validation) | `course-promo/` | idea-stage / about-to-build | validate demand *before* building | `docs/workflows/linkedin-course-promo-plan.md` |
| **Rescue** (control-loss) | `icp-validation/` | already building, can't verify | founder stuck with a dev shop | `docs/workflows/linkedin-icp-validation-plan.md` |

Both post from Paul's personal account. Assets (images) live in each lane's
`assets/` folder.

**Lanes are the TOPIC; the plan runs on PILLARS.** Adopted 2026-08-13: the feed is
planned as a **70% value / 20% personal / 10% promo** mix, not lane-rotation - so
it's worth following, not a promo machine. See
[`content-pillars.md`](content-pillars.md) for the strategy,
[`story-bank.md`](story-bank.md) for Paul's real cases + the interview backlog
(value posts run on real material, never invented), and [`trends.md`](trends.md)
for curation/reaction fuel. Most value posts carry NO course link - only the ~10%
promo slot does.

## Cadence (2026-08-13, Paul)

**2-3 posts per week, max** — the best-for-ICP volume (non-technical founders don't
want a daily firehose). Post at the ICP's peak read time: **Tue-Thu, US-morning
(9-11am ET = ~15:00-17:00 CEST)**. Schedule via LinkedIn's native scheduler. One
lane per post, alternating.

## Every post carries a visual (Paul: "missed images")

Each post gets one image in its lane's `assets/`. Frontmatter records the path
(`image: assets/<slug>.png`).

**Prefer a purpose-built exhibit over a reused course SVG** (Paul 2026-08-13:
reused exhibits carry "too much info" for the LinkedIn context). Build one
exhibit whose single message IS the post's thesis:

1. **Author the SVG** at `assets/<slug>.svg`, house style
   (`.okf/design/house-visual-spec.md` → refactoring.fm section): clean white bg,
   **viewBox 720×480 (3:2)**, big Caveat labels with a soft same-colour glow
   (`feDropShadow`), saturated semantic colours (blue #2b7fff structure/arrows,
   red #e5484d anti-pattern, green #2e7d32 money/success only, amber #f59e0b,
   purple #a855f7), tinted pills, **no emoji**, one action title + one message +
   one basis line, min font 20px Caveat.
2. **Keep it to 2-3 nodes.** Vary the shape across sibling posts (contrast pair,
   fork, swap-table, flow) so the feed isn't all one diagram.
3. **Export:** `rsvg-convert -w 1080 assets/<slug>.svg -o assets/<slug>.png`.
4. **Render-verify EVERY exhibit** by viewing the PNG: the #1 defect is **text
   overflow clipping the viewBox edges** (long titles/rows). Fix by shortening
   text or dropping 1-2px, re-export, re-view. `xml:space="preserve"` keeps
   inter-`tspan` spaces from collapsing. Then run the 6-item clunkiness checklist
   (house-visual-spec) before it ships.

Keep the `.svg` source beside the `.png` so the exhibit is editable later.
Reusing a topic-perfect course exhibit is still fine when one exists.

> **Known tooling gap:** claude-in-chrome can schedule text but cannot drive
> LinkedIn's native file-upload dialog. Until solved, the image is attached
> manually by Paul (or dropped in a fresh composer). Track the fix in the backlog.

## Board approvals (`bin/li-review`)

Each post page on the dev board has decision buttons: **Approve** (key `a`,
shown only while the post is not yet approved - approval is the required
gate) and **Postpone** (key `p`, moves the post to the backlog: writes
`status: postponed` + `stage: backlog`). They hit a local sidecar that
`bin/dev` starts and stops automatically on **hugo port + 1000** (1313→2313,
1314→2314, ...), and the buttons target the sidecar of the server they were
loaded from - so parallel dev sessions on different ports each write to their
own checkout. A decision rewrites the post's frontmatter `status:` line
(single source of truth, no separate state file) and appends an audit line to
`linkedin-posts/decisions.log` (gitignored - local decision trail). The page
redirects back and shows the new status pill. Localhost-only, dev-only; the
agent reads decisions straight from frontmatter/log, no chat round-trip.

## Frontmatter schema v2

Lifecycle + pointers in frontmatter; **performance data lives in the ledger, not
the frontmatter** (single source, no double-authoring — see below).

```yaml
---
title: "<short descriptive name>"   # shown on the review-board card (not the slug)
lane: course | rescue
week: 1
day: thursday
author: paul-keen
pillar: <e.g. demand-before-build | progress-visibility>
hypothesis: <which validation hypothesis>
opener_archetype: idea-led | observation-led | question-led | stat-led | conflict-led
icp_test: <one line - what this post tests>
image: assets/<slug>.png            # REQUIRED - clean path to the visual (just the path)
first_comment: |                    # posted as the FIRST COMMENT after publish; NOT in the body
  <course lane: the comment incl. the UTM'd course link. rescue lane: usually empty.>
stage: now | next | future          # board column: now=on LinkedIn, next=awaiting pre-verify, future=backlog
status: draft | approved | scheduled | posted
proposed_for: "<date time CEST>"    # when it SHOULD be scheduled (next / approved)
scheduled_for: "<date time CEST>"   # when it's scheduled on LinkedIn
posted_for: "<date>"                # when it published
posted_url: "<https://www.linkedin.com/... live post URL, once published>"
notes: | <voice trade-offs, revision history>
---
```

**The body is ONLY the post text.** No trailing `**First comment:**` / `**Attachment:**`
authoring notes in the body — those belong in the `first_comment` and `image`
fields. The review board strips anything after a `---` separator from the copyable
body, but keep the source clean. `image` supersedes the older `visual` / `design_file`
fields (still read as fallbacks). `posted_url` is the canonical property for the
live LinkedIn post URL — the board links to it once set.

## Image type by pillar (what image for what post)

Grounded in the creators Paul rates: **Cutler/Rossi** lead with *diagrams and
editorial illustrations*; **Holub** often runs *text-only* and lets the take carry;
**Paolino** shows *real artifacts / screenshots*. Mapped to our pillars:

| Pillar | Image | Why |
|---|---|---|
| **Teach** (framework/tactic) | house-style refactoring.fm **exhibit** (SVG, see above) | the framework made visual (Cutler/Rossi register) |
| **Reaction / opinion / story** (personal) | a **New Yorker-style caricature** (editorial cartoon) | humour + humanity; a data-exhibit here reads as marketing |
| **Build-in-public** | a caricature, or a **real screenshot** of the artifact | show the thing (Paolino register) |
| **Poll** | the **poll itself** (no image) | the poll IS the visual; single images underperform text in 2026 |

One image, landscape ~3:2. Never a stock photo, never a logo-slathered card. Text-only
is always a valid choice for a blunt take (Holub) - a mediocre image hurts more than none.

## Generating caricatures (the Art tool)

Personal/opinion/story/build-in-public posts get a hand-drawn editorial cartoon via
the `Art` skill (Nano Banana Pro / Gemini 3 Pro image). Needs a **billing-enabled**
Google key in `~/.claude/.env` (`GOOGLE_API_KEY` + `GEMINI_API_KEY`) - the free tier
has a hard image quota of 0.

1. **Prompt** - one scene that IS the post's point, in this template:
   > Single-panel New Yorker-style editorial cartoon, hand-drawn black linework,
   > light cream background, minimal colour accent, **absolutely NO text / lettering /
   > captions**. Scene: [the gag that illustrates the post]. Gestural imperfect
   > linework, editorial sophistication, warm and human, gently satirical, not cutesy.
2. **Generate** (lands in `~/Downloads` first):
   ```
   bun ~/.claude/skills/Art/Tools/Generate.ts --workflow=Comics \
     --model nano-banana-pro --size 2K --aspect-ratio 3:2 \
     --prompt "..." --output "$HOME/Downloads/<slug>.jpg"
   ```
   (Model returns JPEG - fine for a cartoon on cream.)
3. **View + gate** - open the file and score the 4 new-media criteria (great look /
   functional at a glance / earns the scroll / helpful not decorative); re-roll if it
   misses. The model sometimes adds a clean sign word ("MANAGER", "ERROR") despite the
   no-text rule - keep only if it's correct and sharpens the gag, else re-roll.
4. **Wire in** - copy to `linkedin-posts/<lane>/assets/<slug>.jpg`, set
   `image: "assets/<slug>.jpg"`. A NEW lane needs a dev-only mount in
   `config/development/hugo.toml` (`linkedin-posts/<lane>/assets` ->
   `static/linkedin-assets/<lane>`). Verify it serves 200 on the board.

**Never commit the key** - it lives in `~/.claude/.env` (untracked, verified out of the repo).

## Poll posts (canonical structure)

Native LinkedIn polls follow ONE structure (reference: `first-move-poll`,
`interview-count-poll`). Frontmatter carries `design: poll` and `image: ""`
(polls show no image — the poll IS the visual). Body:

```
[framing para 1 — the idea-first claim, flat]

[framing para 2 — argue it plainly]

[framing para 3 — fold in the poll question + "Vote below" + a reply CTA]

[optional hashtags — rescue lane yes, course lane usually none]

---

**Poll options (LinkedIn native poll, run 1 week):**

1. Option one (≤30 chars)
2. Option two
3. Option three
4. Option four
```

Everything after the `---` (the options list) is a reference for the poll
widget — the board strips it from the copyable body, and the options are typed
into LinkedIn's poll UI, not the post text. Do NOT use `## Post body` /
`## Poll question` / `## Poll duration` / `## Hashtags` section headers (the old
format) — the framing prose carries the question, the header line carries the
duration.

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

## Review board (local preview) — ALWAYS give Paul the link

When asked to review/check LI posts, start the dev server and hand back the URL —
don't paste post text into chat:

```
bin/dev          # http://localhost:1313
```

- **Board (all posts by stage):** http://localhost:1313/linkedin/
- **Single post:** `http://localhost:1313/linkedin/<lane>/<slug>/`
  (e.g. `/linkedin/course-promo/week1-tue-founding-hypothesis/`)

Dev-only: `config/development/hugo.toml` mounts `linkedin-posts/` as `content/linkedin`;
production has no such mount, so these pages never ship.

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
- Separately, our `og:image` is **WebP**. **Telegram unfurls it fine** (confirmed by
  Paul 2026-08-13) - WebP-friendly crawlers are OK. **LinkedIn is the holdout**: its
  crawler won't render WebP, so a LinkedIn *body* link shows no preview card. The fix
  is LinkedIn-targeted: emit a jpg/png og:image in
  `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` (or the root override).
  Not a sitewide emergency (Telegram/most work); worth doing since LinkedIn is a key
  channel. Tracked as an engineering task.

## Files

- `content-pillars.md` — the feed strategy: 70-20-10 value/personal/promo pillars.
- `content-plan.md` — rolling 2-3/wk calendar, **pillar-tagged**, with the ratio check.
- `story-bank.md` — Paul's real cases + convictions + the **interview backlog** (fill gaps here, never invent).
- `trends.md` — monthly trend scan → curation/reaction post angles with JT's POV.
- `reference-examples.md` — transcribed good posts to emulate (add more over time).
- `metrics-ledger.md` — per-post performance, the weekly review surface.
- `course-promo/` , `icp-validation/` — the two lanes, each with `README.md`, drafts, `assets/`.

**Posts vs internal docs (board distinction):** a *post* is any `.md` with a
`status:` field; the board and prev/next nav filter on `status != nil`, so only
posts appear. These operational docs (this README, `content-plan.md`,
`metrics-ledger.md`, `reference-examples.md`, each lane `README.md`,
`POSTING-PACKET.md`) carry `build: {render: never, list: never}` in their
frontmatter so Hugo does not render them as pages at all. **Any new non-post `.md`
you drop in `linkedin-posts/` MUST get that frontmatter**, or it will render as an
orphan page under `/linkedin/`.
