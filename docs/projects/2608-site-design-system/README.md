# 2608 — Site design system ("Rescue Room")

**Status:** Proposed — awaiting go/no-go on Phase 0
**Opened:** 2026-08-20
**Decisions:** [ADR-0003](../../adr/0003-site-design-system.md) (the system) ·
[ADR-0004](../../adr/0004-static-site-experimentation.md) (how it's validated)
**Plan:** [20.01 rollout plan](20-29-strategy/20.01-rollout-plan.md)
**Prototype:** Claude Design project *JetThoughts — Rescue Room* (14 previews:
foundations, components, and five page templates)

## Goal at a glance

Replace four stacked visual languages with one, so that every new page starts
from a system instead of a choice, and so the site reads to a non-technical
founder the way the course page already does.

**Done when:** all five page templates in the prototype ship the token set;
`--color-primary` is deleted; the homepage carries proof above the fold on
mobile; and a lead conversion event exists so the next change can be measured.

## The short version of why

- `--color-primary: #1a8cff` is named "primary" and appears in no brand
  definition. ~140 live paint sites, 52 literals. It is why the site has blue
  bands, blue tags and blue links on a red brand.
- Two spacing tokens exist, so every section invented its own padding.
- The homepage is 10,394px with six background switches and six primary CTAs.
- There **was** no conversion event on the site, and `page_view` had been
  marked a key event since 2026-08-13, so GA4 reported ~4,063 "key events" that
  counted page views. Phase 0.1 shipped the events (#489) and the GA4 toggles
  were closed 2026-08-20 (#495, #508). **Un-marking is not retroactive** — the
  polluted figures stay in history, so date-bound any `keyEvents` query.
- **Two pages already implement the system independently** — the course page and
  `/services/vibe-code-rescue/`. They agree on structure (proof in fold 1, one
  repeated CTA, artifacts not stock photos, ~4,300px, no blue) and disagree on
  one thing: light vs dark background. This is extraction, not a rebrand.
- **Palette resolved 2026-08-20: LIGHT** (Paul, on a lightning demo of the peer
  set — every services peer is light, and even Linear ships a light marketing
  site). Dark stays in three places: blog cover art, one dark proof band per
  page, and `/services/vibe-code-rescue/` as a dark-variant campaign page.
  Phase 1a is unblocked — see [20.02](20-29-strategy/20.02-phase-1a-plan.md).

## Current state

**Re-sequenced 2026-08-20 (Paul): BLOG FIRST** — confirm engagement on the
surface where the humans already land before touching chrome or money pages.
Tokens scope into the blog bundles first, promote site-wide later.

**Blog engagement baseline, corrected 2026-08-21** (Clarity, bot-filtered):
**56.4% avg scroll depth / 40.1s engagement over 451 sessions**, pre-ship
window 08-06 → 08-17. **Provisional**: the 08-18→20 window is excluded on MERGE
times, not a confirmed Pages deploy - if the deploy landed after 08-20 those 292
sessions come back. The **25.2% / 26.3s** figure previously quoted here was
ONE 3-day window of five, the lowest, and is BELIEVED to straddle the 08-20
ship (merge times only - deploy unconfirmed) - it is NOT
the baseline and does not support "visitors leave in the first quarter". Full
record: [40.01](40-49-measurement/40.01-blog-engagement-baseline.md).

The durable reason for blog-first is traffic share, not an engagement deficit:
the blog draws **105 GSC clicks / 28d - 77% of the site's entire Google
traffic**.

| Phase | What | Gate | Status |
|---|---|---|---|
| 0 (slim) | record-baselines wrapper, blog scroll/CTA events, coverage, baseline doc | events verified firing | **merged #489**; GA4 key-event toggles are agent-doable via the GA4 UI (see #495), not Paul's |
| 2.1 | `blog-list` restyle + tag pages | A + B + C | **merged #487** |
| 2.2 | posts: article-end CTA, ink tags | A + B + C | **merged #487/#489** |
| 2.2b | Whole-blog rebuild: post header, ink code, wide + responsive mobile covers | A + C | **merged #494** |
| — | Whole-blog measure (28d after rebuild deploys, [40.01](40-49-measurement/40.01-blog-engagement-baseline.md) protocol) | informational | after rebuild |
| **1a** | Site-wide recolour: token promotion, `--color-primary` deletion, retire the `#0066d6` rule (+55 `!important`s) | A + B + C | **ready** — [20.02](20-29-strategy/20.02-phase-1a-plan.md) |
| 1b | Spatial chrome (dead fold, nav 7→5, space scale) | A + B + C | after 1a |
| 2.4/2.5 | homepage, single-service | A + B + C, GSC gate on homepage | after the read |
| 3 | Content: real numbers, sample report | A + cold-eyes review | parallel |

Gates per ADR-0004: **A** qualitative (Clarity recordings, screenshots, visual
suites), **B** guardrails with declared rollback thresholds, **C** reversibility.
**No phase is A/B tested** — at ~9.7 real human sessions/day (measured, not
estimated) the cheapest viable test needs 192 days.

## Outstanding

**Regenerate root `DESIGN.md` against ADR-0003.** It still frames dark
JetVelocity as *"normative for new brand/conversion surfaces"*, calls LIGHT
page chrome *"legacy/incumbent"*, and specifies `#1a8cff` primary buttons —
a token **deleted in Phase 1a.2 (#518)**, so `var(--color-primary)` now
resolves to nothing and the declaration is dropped silently. An agent building
a new conversion page from it goes dark with a dead token.

A superseded-in-part banner was added at the top of that file on 2026-08-21
and `.okf/design/site-palette.md` names it as a known contradicting sibling,
so nobody following either authority is misled today. **The regeneration
itself is not done.** Scope when it runs: reconcile the two-layers section
with ADR-0003, strip every `--color-primary` reference including the
primary-button spec, and restate `.stitch/design.md`'s scope as cover images
rather than "the site design system". Also regenerate `.impeccable/design.json`
if it encodes the same palette, since `/impeccable critique` now carries the
design-review gate and would score against stale values.

**Make `okf_validate.py .okf --strict` exit 0.** It exits 1 today and has for
some time; the `✓ conformant` line refers to §9 (no ERRORS), while `--strict`
fails on any warning. CLAUDE.md requires this gate before bundle commits, so
it has been reported green while failing. Measured 2026-08-21: 82 warnings —
**57** §7 date headings, **23** missing recommended fields.

Two jobs: (1) restructure `log.md` so same-day themes sit as sub-sections
beneath ONE `## YYYY-MM-DD` heading — a whole-file restructure, not a
find-and-replace, and it conflicts with every parallel session appending to
that file, so do it when the repo is quiet; (2) add `timestamp` to the 23
concepts missing it, anchored to each file's last commit time
(`git log -1 --format=%cI -- <file>`), never invented.

## Working notes

Coordinator/session reports do not belong in this directory — write them to
`/tmp`. Findings and audits that a cold session needs do.
