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
- The course page already implements the proposed system independently — this is
  extraction, not a rebrand.

## Current state

| Phase | What | Gate | Status |
|---|---|---|---|
| 0 | Instrumentation + baseline tooling | events verified firing | **not started** |
| 1a | Style-only recolour | A + B + C | blocked on 0 |
| 1b | Spatial chrome | A (weighted) + B + C | blocked on 1a |
| 2 | Page bundles ×5 | A + B + C, GSC guardrail on 2.1 | blocked on 1b |
| 3 | Content: real numbers, sample report | A + cold-eyes review | parallel from 2 |

Gates per ADR-0004: **A** qualitative (Clarity recordings, screenshots, visual
suites), **B** guardrails with declared rollback thresholds, **C** reversibility.
**No phase is A/B tested** — at ~9–15 real human sessions/day the cheapest
viable test needs 155 days.

## Working notes

Coordinator/session reports do not belong in this directory — write them to
`/tmp`. Findings and audits that a cold session needs do.
