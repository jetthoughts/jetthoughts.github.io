---
type: Playbook
title: Outbound sprint machinery (2607 Vibe Code Rescue)
description: How the browser-agent outreach loop runs - pre-validated sends, daily reply monitoring, the pipeline ledger, board conventions, and the mail-routing gotchas.
tags: [outbound, sales, browser-agent, kanban]
timestamp: 2026-07-24T00:00:00Z
resource: docs/projects/2607-vibe-code-rescue/
---

# The loop

1. **Send** - a browser agent (Comet or Claude-in-Chrome, in Paul's
   logged-in session) runs `rescue-sprint/send-runner-prompt.md`:
   pre-research every prospect (post still live, author matches, quote
   unedited, situation unchanged, correct AI tool named), then a HARD STOP
   for Paul's per-message approval, then send, then log. Nothing sends on
   silence.
2. **Monitor** - each morning `rescue-sprint/reply-monitor-prompt.md`
   sweeps IH notifications, LinkedIn, Reddit, and Gmail (`neetocal`,
   `from:f5bot.com`), classifies replies, drafts responses from the
   objection bank (marked DRAFT - Paul sends), and updates the ledger.
3. **Measure** - `rescue-sprint/pipeline.md` is the single ledger (one row
   per touch + Friday tally). The A0 kill-criteria (~20 touches / ~10
   calls) are evaluated from it alone.

# Channel rules

- IndieHackers/Reddit: **public thread-reply on the prospect's own post**,
  not a DM - it reads as a helpful reply; cold DMs convert worse. LinkedIn/X
  get DMs. `outbound-openers.md` headers are authoritative over the
  prospect-list "best path" column.
- Every opener's link must route to the named prospect's own post/profile -
  a quote captured from a comment belongs to the commenter (see the
  link-routing check in [review-swarm](/workflows/review-swarm.md)).

# Board conventions

- The kanban board (`kanban-md`, tag `2607`) is **local-only** - `kanban/`
  is gitignored. The committed status snapshot lives in the project
  `backlog.md`; keep both current.
- Every open card carries a `Requires:` line separating Paul-only inputs
  (logged-in browser, approvals, calls, warm-network picks) from
  agent-doable work, so agents never claim un-runnable cards.

# Gotchas

- **F5Bot sends nothing until the account email is verified** - the verify
  email hid for 3 days (2026-07-21 to 07-24) because...
- ...mail to `pftg.sof@gmail.com` is auto-labeled + archived in that
  mailbox and auto-forwarded to Paul's main inbox. Monitor by search query
  (`from:f5bot.com`, `neetocal`), never by scanning that inbox.
- Statusline/parallel sessions contend on `.git/index.lock` - transient;
  re-check before force-removing.

# Citations

- Project docs: `docs/projects/2607-vibe-code-rescue/` (backlog, runbook,
  rescue-sprint kit).
- Review that hardened the kit: 2026-07-24 six-finder audit (see
  [review-swarm](/workflows/review-swarm.md) multi-doc section).
