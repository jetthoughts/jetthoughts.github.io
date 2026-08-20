---
type: Ownership Contract
title: Company-layer ownership - vault vs repo vs claims canon
description: The vault owns ALL operations (identity, bets, weekly loop, pipeline, runbook, assumptions); the repo owns growth/marketing campaigns; the claims canon owns company facts. Re-settled 2026-08-20, superseding the 2026-08-17 narrow split.
tags: [ownership, business, vault, claims-canon]
generated:
  by: claude-fable/5
  at: 2026-08-20T00:00:00Z
---

Three surfaces, three jobs. Getting these confused is what produced the
2026-08-14 false-claims incident and the 2026-08-17 banner contradiction.

| Surface | Owns | Examples |
|---|---|---|
| **Vault** (`~/Documents/pkm`: `jt-business-os`, `jt-operations`, `jt-vibe-code-rescue`, `jt-vcr-pipeline`, `jt-vcr-runbook`, `jt-vcr-assumptions`) | Identity, positioning, bets and bet **status**, AND the **entire operating loop** — goal, OKR, rocks, issues, weekly numbers, runbook, kill-criteria | "what we're doing, why, and this week's numbers" |
| **This repo** | **Growth/marketing campaigns** | blog, SEO, LinkedIn drafts, landing pages, course, outreach copy/kits, all tooling/tests |
| **Claims canon** (`.okf/content/claims-canon.md`) | Company **facts** | founding date, tenure, ratings, retention |

The one-line test: **the vault decides what we're doing and runs the week;
the canon decides what we're allowed to say; the repo ships the campaigns.**

# History: the narrow split (2026-08-17 → 2026-08-20)

On 2026-08-17 the weekly loop was deliberately kept repo-owned because the
2607 runbook, backlog, pipeline ledger and booking-page spec all bound to
`operating-system.md` §1/§7. On 2026-08-20 Paul inverted this: the vault owns
operations wholesale, and the bindings moved WITH the loop — pipeline, runbook
and assumptions register migrated to the vault in the same pass, so the weekly
loop still reads from one place (the vault). The repo files are pointer stubs;
full pre-move content is in git history. The vault is host-only: container/CI
sessions treat operations as out of scope.

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

**Resolved 2026-08-17**: the frontmatter was right. Vibe Code Rescue is
**Parked, postponed until September 2026** - the body and the repo portfolio
were the stale side, and both now say Parked. This is the worked example of the
ownership rule: the vault held the truth about bet status, and the repo was the
mirror that had drifted. When the two disagree, the vault wins for status.

Consequence, recorded in vault `jt-operations`: **no bet is in
Validating** (intended - do not promote a candidate to fill the slot), and the
**Nov 30 target is suspended, not rescheduled**. The evidence for suspending
rather than moving it: KR1 was green while KR2-KR4 sat at zero and no outreach
was ever sent, so the deadline was never the binding constraint. The new target
is set at the September restart, together with a re-set of the Sep 30 mid-point
gate (which must be re-set, not dropped - it is what makes a re-plan
falsifiable).

# Skills: we track only our own

Policy, 2026-08-17: `.agents/skills/` is a local workspace. **Only skills we
authored get committed** - a skill qualifies if it carries JetThoughts-specific
content (our voice guide, our pipelines, our paths). Vendored/marketplace
skills carry an upstream version and no JT content; they are installed
per-machine and never committed, because we will not maintain third-party code
we did not write and cannot patch upstream.

Ours today: `async-first-communication`. Pre-existing vendored exceptions
tracked before this policy: `impeccable`, `kanban-md` - decide whether to
untrack them (`impeccable` has inbound references from four 2605 docs).

The consequence to keep honest: `blog-pipeline.md` names `slop-detector`,
`humanizer` and `seo-aeo-audit` as BLOCKING gates, and all three are vendored.
They therefore cannot run in a container/CI session, and the pipeline doc now
says so out loud. Making a gate genuinely blocking means writing our own skill
for it - not vendoring someone else's.
