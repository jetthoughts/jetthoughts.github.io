---
type: Ownership Contract
title: Company-layer ownership - vault vs repo vs claims canon
description: Which surface owns identity/positioning/bet status, which owns the weekly operating loop, and which owns company facts. Settled 2026-08-17 after the two banners disagreed.
tags: [ownership, business, vault, claims-canon]
generated:
  by: claude-opus/4.8
  at: 2026-08-17T00:00:00Z
---

Three surfaces, three jobs. Getting these confused is what produced the
2026-08-14 false-claims incident and the 2026-08-17 banner contradiction.

| Surface | Owns | Examples |
|---|---|---|
| **Vault** (`jt-business-os`, `jt-vibe-code-rescue` in `~/Documents/pkm`) | Identity, positioning, bets and bet **status** | "what we're doing and why" |
| **This repo** (`docs/business/operating-system.md`) | The **weekly operating loop** | goal, OKR (§3), rocks (§4), weekly numbers (§1) |
| **Claims canon** (`.okf/content/claims-canon.md`) | Company **facts** | founding date, tenure, ratings, retention |

The one-line test: **the vault decides what we're doing; the canon decides
what we're allowed to say; the repo runs the week.**

# Why the weekly loop is repo-owned (the narrow split)

The broad alternative - move OKR and rocks to the vault, leave only numbers
here - was rejected 2026-08-17. The 2607 runbook, backlog, pipeline ledger
and booking-page spec all bind to `operating-system.md` §1/§7. Splitting the
OKR from the numbers that measure it breaks those bindings and makes the
weekly loop read from two places.

# Facts are never vault-owned

This is the load-bearing carve-out. On 2026-08-17 the vault's own Positioning
line read *"shipping production software since 2011 - 4.8/5 from 32 clients"*
- two strings that `test/unit/marketing_copy_test.rb` bans verbatim (canon:
founded 2008-09-01, no review count, Clutch shows 9). The vault's stated flow
is "edit here, then reflect in the repo", which would have laundered both back
into published copy days after they were removed from 13 blog posts.

Never copy a company number out of a vault note into published copy. Corrected
in the vault the same day; the guard lives in the CLAUDE.md banner.

# Where the routers point

Aligned 2026-08-17: `AGENTS.md`, `docs/workflows/BASE_HANDBOOK.md`,
`docs/workflows/flow-router.md` (split into two routes), `CLAUDE.md`,
`docs/projects/2607-vibe-code-rescue/strategy.md`, and
`.agents/skills/async-first-communication/SKILL.md`. If a new doc tells an
agent where company work lives, it must match this table.

Still open: `jt-vibe-code-rescue.md` frontmatter says `state: postponed` while
its body and `docs/business/opportunity-portfolio.md` both say **Validating**.
Left for Paul - only he knows which is true.
