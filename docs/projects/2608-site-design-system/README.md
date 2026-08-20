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
- There is **no conversion event on the site**, and since 2026-08-13 `page_view`
  has been marked a key event — so GA4 now reports 4,063 "key events" that count
  page views. Nothing shipped today can be evaluated.
- **Two pages already implement the system independently** — the course page and
  `/services/vibe-code-rescue/`. They agree on structure (proof in fold 1, one
  repeated CTA, artifacts not stock photos, ~4,300px, no blue) and disagree on
  one thing: light vs dark background. This is extraction, not a rebrand.
- **Open decision, blocks Phase 1a only:** which palette. See open question 0 in
  the plan.

## Current state

**Re-sequenced 2026-08-20 (Paul): BLOG FIRST** — confirm engagement on the
surface where the humans already land before touching chrome or money pages.
Tokens scope into the blog bundles first, promote site-wide later. Blog
engagement baseline (Clarity, bot-filtered): **25.2% avg scroll depth / 26.3s
engagement** vs site avg 33–40% / 28–34s.

| Phase | What | Gate | Status |
|---|---|---|---|
| 0 (slim) | record-baselines wrapper, blog scroll/CTA events, coverage, baseline doc | events verified firing | **PR #489** (GA4 admin steps manual) |
| 2.1 | `blog-list` restyle + tag pages | A + B + C | **shipped 2026-08-20** (PR pending) |
| 2.2 | posts: article-end CTA, ink tags (measure/full-bleed/code-ink deferred to 1a) | A + B + C | **shipped 2026-08-20** (PR pending) |
| 2.2b | **Whole-blog rebuild** (post template: full-bleed cover, ink code blocks, meta-above-title; mobile covers on lists) | A + C | **in progress** (Paul 2026-08-20: no measure gates) |
| — | Whole-blog measure (28d after rebuild deploys, [40.01](40-49-measurement/40.01-blog-engagement-baseline.md) protocol) | informational | after rebuild |
| 1a/1b | Site-wide chrome (recolour, then spatial) | A + B + C | after the read |
| 2.4/2.5 | homepage, single-service | A + B + C, GSC gate on homepage | after the read |
| 3 | Content: real numbers, sample report | A + cold-eyes review | parallel |

Gates per ADR-0004: **A** qualitative (Clarity recordings, screenshots, visual
suites), **B** guardrails with declared rollback thresholds, **C** reversibility.
**No phase is A/B tested** — at ~9.7 real human sessions/day (measured, not
estimated) the cheapest viable test needs 192 days.

## Working notes

Coordinator/session reports do not belong in this directory — write them to
`/tmp`. Findings and audits that a cold session needs do.
