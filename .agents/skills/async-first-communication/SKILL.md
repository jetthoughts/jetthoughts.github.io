---
name: async-first-communication
description: >
  Async-first knowledge sharing is the default operating procedure for all
  agents and humans in this repo. Use for ANY task that produces decisions,
  findings, status changes, or handoffs — write them where the next reader
  (human or agent, possibly in another session/timezone) can find them
  without asking anyone. Live/sync interaction is the exception and its
  outcome must be written back.
---

# Async-First Communication

Every session ends. Every teammate — human or agent — may pick up the work
cold, in another session, on another machine. Knowledge that lives only in a
conversation, a call, or an agent's context window is lost knowledge.

## The default

**Write it where the next reader will look, at the moment you learn it.**
Do not defer documentation to "after the work" — the write-back IS part of
the work. A task is not done until its state is readable asynchronously.

## Where things go (this repo's canonical surfaces)

| What | Where |
|---|---|
| Decision / groomed design / vote | the project's docs (`docs/projects/<id>/`), with rationale |
| Task status + claims + handoffs | kanban board (`kanban-md`, local) AND the committed snapshot (project `backlog.md` State section) |
| Operational state across sessions | the project runbook (statuses + handoff notes pasted VERBATIM) |
| Outreach / funnel events | the project ledger (e.g. `rescue-sprint/pipeline.md`) — one row per event |
| Durable how-to / gotcha / root cause | `.okf/` concept file + dated `log.md` entry; reusable process → `docs/workflows/` |
| Review findings + dispositions | PR comments (one summary disposition comment; resolve threads with reasons) |
| Company-level policy / cadence | `docs/business/` |
| Session-internal scratch | `/tmp/` — never committed |

## Practices

- **Prefer shared artifacts over direct messages.** Answer a question by
  updating the doc that should have answered it, then link the doc.
- **Every handoff is written.** An agent finishing a task updates the card
  (done-criteria met? blockers? verbatim critic verdict) so the next agent
  starts cold with zero questions.
- **TL;DR on top.** Long updates lead with the outcome in 1-2 sentences;
  detail follows for readers who want it.
- **Assume no reply is coming.** Structure every request so the recipient
  can act on it whenever they read it: full context, explicit ask, default
  action if no answer by a stated date.
- **Sync is for judgment, not transfer.** Calls/live sessions are reserved
  for decisions only a human can make (Paul's desk: approvals, sales calls,
  pricing). Within one working session, live back-and-forth with the user is
  normal — this skill governs knowledge that must OUTLIVE the session.
  Every sync interaction ends with a written artifact: notes, decision
  record, or updated card — same day.
- **State lives in files, not memory.** If a fact matters beyond the current
  session and exists only in context, write it before ending the turn.

## Agent behavior

- When asked to "tell/explain/align the team", draft the async artifact
  (doc section, PR comment, card update) — do not assume a meeting.
- When planning, include the write-back steps (changelog, decision record,
  status update) as explicit tasks, not afterthoughts.
- When you find documentation missing or stale while working, fix it or
  flag it in the artifact you touch — don't route around it silently.
- When work is blocked on a human, write the blocker where they will see it
  (card `Requires:` line, runbook Paul's-desk table) with everything they
  need to unblock in one sitting.

## Escalation (when async is not enough)

Escalate to sync only when: a decision is blocking AND ambiguous AND owned
by a human; or an incident is time-critical. Even then: state the question
async first with your recommended default, and record the sync outcome in
writing the same day.
