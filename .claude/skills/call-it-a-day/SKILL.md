---
name: call-it-a-day
description: >
  Graceful end-of-session close for this repo: every open thread shipped or
  parked with a resume recipe, state surfaces synced, memories stored,
  background processes stopped, and a day ledger handed back - so the next
  session (or any teammate) cold-starts with zero questions. Invoke when Paul
  says "call it a day", "wrap up", "закончили", "prepare to finish", or at any
  session end after real work. Complements the global session-wrap-up skill;
  this one binds to THIS repo's surfaces and gates.
---

# Call It a Day

A session is not finished when the work stops - it is finished when a cold
session can continue it without asking anyone anything. Work through the
checklist IN ORDER; each step is a gate, not a suggestion. Report honestly:
"parked with recipe" is a fine outcome, "silently unfinished" is the failure
this skill exists to prevent.

## 1. Settle every open thread

- `git status` in the worktree: clean, or every change committed/PR'd. Never
  leave uncommitted work in a worktree (worktrees die; only commits survive).
  A deliberate WIP goes on a pushed branch with a `WIP:` commit, named in the
  handback.
- Open PRs: merge them (docs/instruction-only → local gates, do NOT wait for
  CI; code diffs → `gh pr checks` green at the JOB level) or state who/what
  they wait on.
- Running subagents / peer collaborations: collect or explicitly release
  them (a silent agent's work is UNREVIEWED, say so). Reply to peer sessions
  whose requests you accepted.
- Stray stashes: `git stash list` - anything of yours gets applied+dropped
  or committed. Never leave tagged stashes overnight.

## 2. Sync the state surfaces (same-commit rule applies)

- **STATUS.md**: if anything started/finished/parked a workstream or hit a
  blocker today, update it - and verify each touched row against the
  ARTIFACT (ledger, frontmatter, file end), never a tracker line. New
  blocked-on-Paul items go in its table.
- **OKF (ENFORCED)**: every durable learning from today has a concept touch +
  dated `.okf/log.md` entry riding a commit that MERGED. If one is missing,
  this is the moment: dispatch `okf-maintainer` or do it inline, ship as a
  docs-only PR, merge on local gates. Concept title/description changed →
  upsert its `okf-*` ruflo mirror entry (namespace `okf`).
- Project trackers touched today: no stale line left that tomorrow's session
  would copy (stamp supersessions with dates, at the source).

## 3. Store the memories (ruflo-first, shared DB)

- One `episodic-YYYY-MM-DD-*` entry: topic, actions, outcomes, open items.
- A `retro-*` entry if the day taught something about HOW we work; every
  user correction already stored the moment it happened - verify, don't
  batch-backfill.
- Parked work gets a `plan-*` entry with a RESUME RECIPE: exact state, exact
  next commands, and the judgment criteria (see `plan-openviking-evaluation`
  for the shape).
- Auto-memory: new memory files listed in `MEMORY.md` (a file absent from
  the index is unreachable next session).

## 4. Stop what you started, keep what you didn't

- Kill YOUR background tasks: watches, timers, dev servers, monitors
  (`/tasks` view; TaskStop each). The session-random dev server dies with
  you; never kill servers you didn't start (ollama, openviking, daemons).
- Anything left running deliberately (e.g. an ingest queue draining
  overnight) is named in the handback with how to check it tomorrow.

## 5. The handback (day ledger)

End with one message containing:
1. **Shipped** - merged PRs with numbers and one-line whats.
2. **Parked** - each with WHERE its resume recipe lives (ruflo key, memory
   file, STATUS.md row).
3. **On Paul's desk** - the blocked-on-Paul items, each with its one-line ask.
4. **Left running** - deliberate survivors and their check command.
5. Local preview links for anything that renders (only if content changed).

## Self-check before sending the handback

Grep your own handback: every "will", "later", "next time" must map to a
written artifact (recipe, STATUS row, tracker line) - a promise that lives
only in the handback dies with the session.
