---
type: Playbook
title: Self-iterating loops (ralph-loop) — what they are and are not for
description: A loop re-feeds one prompt until a completion promise is true; it can iterate but cannot re-scope, so it fits verifiable work with known-correct scope and fails on a mis-scoped plan item.
tags: [automation, loop, process, ralph]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-21T08:27:15Z
timestamp: 2026-08-21T08:27:15Z
---

# What it does

`/ralph-loop "<prompt>" --max-iterations N --completion-promise "<text>"` feeds
the SAME prompt back every time the session tries to stop. It ends on three
things only: the agent emitting the exact promise, the iteration cap, or the
human cancelling (`/cancel-ralph`).

**The agent cannot end it by concluding the work is blocked.** That conclusion
just produces another iteration of the same prompt.

# When it fits

Work whose completion is **mechanically checkable** and whose **scope is
known-correct**. The promise should be a command anyone can re-run, not a
judgement:

> "…`grep -rn 'var(--rr-' themes/beaver/assets/css/` returns nothing, the alias
> block is deleted, `bin/test` reported screenshots compared with zero failures,
> and the PR is merged"

That shape is what lets an agent refuse to emit a false promise: each clause is
falsifiable, so there is no room to rationalise.

# When it does not fit

**A plan item that might be mis-scoped.** A loop's only response to "this cannot
be done as specified" is to try again. It has no move for "the specification is
wrong".

Demonstrated on 2026-08-21 running Phase 1a.4
([site-redesign-rollout](/workflows/site-redesign-rollout.md)). Of four scope
items, one was as written; the other three were materially different work, and
two were gated by an unnamed design token. The loop could not re-scope, so it
kept iterating past the point where delivery was blocked - producing
investigation and documentation rather than the merge the prompt asked for. That
output was worth having, but it is not what "execute until merged" meant, and a
human reading only the prompt would have expected shipped CSS.

**Signal to cancel:** the agent has asked the same blocking question in three or
more consecutive iterations. It is not stuck on execution; it is waiting on a
decision the loop cannot supply.

# What worked inside the loop, and is worth keeping

The per-iteration cadence held up across nine merged PRs with no regression
shipped:

1. **WIP=1** - one PR open, merged before the next unit starts.
2. **`/codex:review` before every merge**, fixing what reproduces against the
   tree and saying so plainly when a finding does not reproduce.
3. **Revert rather than ship** when a change proves null or harmful. Five
   reverts on that phase, including a 41-rule sweep that measured as an AA
   regression and a tokenisation of dead code. A loop rewards visible progress,
   so this is the discipline it erodes first - see the NULL CHANGE rule in
   [test-gates](/build/test-gates.md).

# Content can run in a loop, but only with three exits (2026-08-22)

Content looks like it fails the "mechanically checkable" test above, because
"is this any good" is a judgement. It passes once the judgement is converted into
**gates that are allowed to fail the work** - a slop critic that did not write
the draft, a cold-eyes reviewer of a third agent type, every external claim
fetched rather than recalled. The promise is then about those gates, never about
quality. A promise containing "the post is good" is unfalsifiable, and an agent
under loop pressure will assert it.

**The specific way a content loop goes wrong: it manufactures a post.** The
revert-rather-than-ship erosion described above has an exact content analogue -
stopping feels like failing, so the loop writes something. A loop whose only
exits are SHIPPED and ITERATE will always ship. Give it three: **SHIPPED**,
**HOLD-with-evidence** (a terminal success), **BLOCKED on a named decision**.

Evidence this is real: on 2026-08-22 two `/blog-next` runs ended in HOLD, and
both were right - the groomed queue's lead row was an artifact (a 52x "finding"
that factorised to 1.4x clicks × 37.2x impressions), and its same-day replacement
failed dedup. A two-exit loop would have written both.

# Write the prompt with the traps in it

The loop re-reads the prompt every iteration, so it is the cheapest place to put
gate rules that would otherwise decay. The 1a.4 prompt carried "never cite
`bin/dtest` from this worktree - it is vacuous-green", "quote the
`[snap_diff] N verified` count" (2.0 summary format; the old wording was
`[snap_diff] N screenshots compared`), and "`--strict` EXITS 1 by design",
and none of those was violated across the whole run.

# The delivery contract that wraps this

The `jt-delivery:contract` skill (plugin `jt-delivery@jetthoughts`, per
ADR-0005) is the operating contract for running a goal unattended:
DISCOVER -> DECIDE -> BUILD -> VERIFY -> 4-EYES -> SHIP -> LEARN, WIP=1,
with the evidence ladder and the review-panel rules. The repo-specific
bindings (gate matrix, canon, reviewer routing, Appendices) live in
`docs/workflows/autonomous-delivery-prompt.md`.

It is the complement to this concept rather than a competitor. This file says
what a self-iterating LOOP can and cannot do; that file says what a delivery
PASS must contain. The loop rule that carries across: a loop can iterate but
cannot re-scope, so "the specification is wrong" has to end the run rather than
start another iteration.

Its own review found three P1s, one of which is the reason to trust it more
rather than less: the appendix hardcoded surface counts, and two were wrong,
violating the rule against decaying numbers written three sections above it.
Counts were replaced with the commands that produce them.
