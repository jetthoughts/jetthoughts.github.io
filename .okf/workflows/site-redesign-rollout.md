---
type: Decision
title: Rescue Room rollout sequence (2608)
description: Phases are ordered by whether LAYOUT MOVES, not by size; blog runs before site-wide chrome; no A/B is available at this traffic, so reversibility substitutes for statistical confidence.
resource: docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md
tags: [design, rollout, sequencing, decision, adr]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-20T22:30:00Z
timestamp: 2026-08-20T23:28:00Z
---

# Why this concept exists

# Check phase status against GIT, not the plan table

**The plan's Phase 2 table lists 2.1 and 2.2 as pending. Both shipped on
2026-08-20** - #487 (17:35, blog index/tags/posts restyle) and #494 (20:16,
whole-blog rebuild), confirmed with
`git merge-base --is-ancestor e1fa5409 origin/master`. A status answer given
from the plan on 2026-08-21 was wrong for exactly this reason.

A plan doc records what was DECIDED; only the tree records what SHIPPED. Before
reporting phase status or starting phase work, grep the artifact - the
markup, the selector, the commit - not the table row. Two independent agents
hit this within minutes of each other, which is how a stale row survives:
everyone reads the plan because it is the obvious place to look.

**Corollary - blog-first orders work NOT YET STARTED; it does not un-build
finished work.** When a later-sequenced phase is already built and edits the
same bundles an earlier-sequenced one rewrites, the built work lands first.
1a.2/1a.3 landed before the Phase 2 punch-lists on 2026-08-20 for this reason:
starting blog work on an unmerged 194-file recolour recreates precisely the
merge pain the 1a/1b split exists to avoid.

The palette DECISION is in [site-palette](/design/site-palette.md). This is the
ORDER the decision ships in, which is a separate call and the one a session
gets wrong. Reading only the palette concept, the obvious next move after
Phase 1a.3 is 1a.4 - and that is the wrong order (see blog-first below).

**Phase status comes from GIT, not from any document** - see the section below.
Neither this concept nor the plan doc is a status source: the plan records what
was DECIDED and went stale (it listed 2.1/2.2 pending after both shipped), and
a state snapshot in a concept rots within days. What is recorded here is the
reasoning that outlives any particular phase.

# Three rules that decide sequence

**1. Phases are ordered by whether LAYOUT MOVES, not by size.** A recolour
leaves every element in place: a fault is a wrong colour, caught in a
screenshot diff, revertable alone. A spatial change shifts every page
vertically: a fault is a layout break and baselines churn wholesale (143 macOS
+ 135 Linux). Hence Phase 1 splits - 1a recolours, 1b moves things - costing
one extra baseline re-record and buying a rollback point in between.

**2. No A/B test is available anywhere in this rollout** (ADR-0004). Real human
traffic is ~9.7 sessions/day; the cheapest viable engagement test needs 192
days to reach power, lead conversion ~3.6 years. GA4's ~300/day is 85-90% bots.
**Reversibility is the substitute for statistical confidence** - which is what
justifies the 1a/1b split paying an extra re-record for a rollback point. Gates
are A (qualitative), B (guardrails with declared rollback thresholds), C
(reversibility). Never attach a performance or conversion CLAIM to a phase
whose case is coherence.

**3. Blog before site-wide chrome** (Paul, 2026-08-20). That is where the
humans already are - the 105 GSC clicks/28d (measured 2026-08-21; the plan's
~145 was superseded) land overwhelmingly on posts - and
the blog bundles do not touch the money pages. It also has the clearest
engagement problem to move.

**CORRECTED 2026-08-21 - the engagement figure did not survive recomputation.**
The plan cites 25.2% scroll / 26.3s against a 32.9-40.3% site average. That is
ONE 3-day Clarity window of five, and the lowest; the windows swing 2.9x
(29.89 / 51.13 / 75.11 / 50.91 / 25.56%). Session-weighted over all 743
bot-filtered sessions the blog sits at **44.31% scroll / 34.97s** - at or above
the average it was said to trail. The low window also straddles the 08-20
deploy - PROVISIONALLY, on merge times only; no Pages deployment record has
been read - so the pre-ship baseline is provisionally 08-06 -> 08-17: 451
sessions,
**56.4% / 40.1s**.

Blog-first remains right, but on a different fact than the one written down:
GSC shows the blog at **105 clicks / 28d, 77% of the entire site's Google
traffic**. A 3-day window is not a baseline. Recompute a quoted metric over the
full period before building a strategy on it.

# The cost blog-first accepts, and why it is not a bug

Because the blog phases run first, new tokens are defined INSIDE the blog
bundles' own CSS (`pages/blog-list.css`, `pages/blog-single.css`) and promoted
to `foundations/css-variables.css` in Phase 1a later. **The token definitions
move twice.** A reviewer seeing duplicate token definitions mid-rollout is
looking at the plan working, not a mistake. It is slower overall, and it buys
learning whether the design engages anyone before the whole site commits to it.

# Gates that block regardless of sequence

- **2.4 (homepage) carries an extra, blocking GSC gate.** The cut removes the
  twelve service tiles and the framework logo grid; both carry keywords, and
  the site has just been through a GSC re-baseline and a fractional-CTO
  cluster cannibalisation. Pull GSC query/page data for `/` BEFORE removing any
  section and keep whatever earns impressions - collapsed below the FAQ, not
  deleted. A conversion gain paid for in rankings is a loss.
- **Per-phase measurement reads are RETIRED as gates** (Paul, 2026-08-20
  evening): "avoid measures, rebuild the whole blog, and we will use measure
  based on the whole blog." Nothing blog-scoped waits on a reading. The read
  still happens - once, over the whole rebuilt blog - and is informational.
- **2.2 does NOT couple the course page - the plan pointed at the wrong file**
  (measured 2026-08-21, correcting 20.01's "2.2 note"). The warning is true of
  the FILE and false of the SELECTORS. Both templates load
  `pages/blog-single.css`, but `course/single.html:55` renders
  `class="single-content"` with **no `.post-article`**, and all 15 styled rules
  in that file are `.post-article`-prefixed. Exactly two selectors reach
  course: `.single-post-row` and the `h1.post-title` rule. **2.3 need not
  follow 2.2.** The genuinely shared file is `single-post.css`, where
  `.blog .post-tags a` and the print block hiding `.post-cover-figure` DO reach
  course - and that file drives `bin/generate-template-pdfs`, so a change there
  moves PDFs too. Scope tripwire: `macos/{desktop,mobile}/course/chapter.png`
  must come out byte-identical.

# Citations

[1] `docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md`
[2] `docs/projects/2608-site-design-system/20-29-strategy/20.02-phase-1a-plan.md`
[3] `docs/adr/0003-site-design-system.md`, `docs/adr/0004-static-site-experimentation.md`
[4] `docs/projects/2608-site-design-system/40-49-measurement/40.01-blog-engagement-baseline.md`
