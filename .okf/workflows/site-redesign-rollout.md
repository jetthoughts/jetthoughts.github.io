---
type: Decision
title: Rescue Room rollout sequence (2608)
description: Phases are ordered by whether LAYOUT MOVES, not by size; blog runs before site-wide chrome; no A/B is available at this traffic, so reversibility substitutes for statistical confidence.
resource: docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md
tags: [design, rollout, sequencing, decision, adr]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-21T00:30:00Z
timestamp: 2026-08-21T00:30:00Z
---

# Why this concept exists

The palette DECISION is in [site-palette](/design/site-palette.md). This is the
ORDER the decision ships in, which is a separate call and the one a session
gets wrong. Reading only the palette concept, the obvious next move after
Phase 1a.3 is 1a.4 - and that is the wrong order (see blog-first below).

Live phase status lives in the plan doc under `resource:`, not here; a state
snapshot in a concept rots within days. What is recorded here is the reasoning
that outlives any particular phase.

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
humans already are - the ~145 GSC clicks/28d land overwhelmingly on posts - and
the blog bundles do not touch the money pages. It also has the clearest
engagement problem to move: blog pages sit at **25.2% average scroll depth /
26.3s** against a site average of 32.9-40.3% / 28-34s (Clarity, bot-filtered,
2026-08-20 baseline).

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
- **2.2 couples the course page.** `blog-single` shares
  `pages/blog-single.css` with `course-single`; sequence 2.3 immediately after
  or screenshot both.

# Citations

[1] `docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md`
[2] `docs/projects/2608-site-design-system/20-29-strategy/20.02-phase-1a-plan.md`
[3] `docs/adr/0003-site-design-system.md`, `docs/adr/0004-static-site-experimentation.md`
[4] `docs/projects/2608-site-design-system/40-49-measurement/40.01-blog-engagement-baseline.md`
