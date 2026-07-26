---
type: Playbook
title: Outbound sprint machinery (2607 Vibe Code Rescue)
description: How the browser-agent outreach loop runs - pre-validated sends, daily reply monitoring, the pipeline ledger, board conventions, and the mail-routing gotchas.
tags: [outbound, sales, browser-agent, kanban, sourcing]
timestamp: 2026-07-26T00:00:00Z
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

# Sourcing quality gates (2026-07-26, learned from a 60% batch failure)

- **Verify timestamps at capture, not at send.** Batch-1 pre-research found
  3 of 5 P8-scored "ready" rows unsendable: a 6-year-old post, a 1-year-old
  comment mis-attributed as a post, and a thread already carrying a
  competing "free" pitch. Root cause: the rubric said "recent, not dead"
  but recency was eyeballed from search excerpts — nobody opened the thread
  and read the date. Catching it at send-time wastes the whole downstream
  chain (openers, scoring, sheet, approval loop).
- **Lead vs. voice — two harvests, one visit (Paul's policy):** lead rows
  need a **verified timestamp ≤30 days, all venues, no exceptions** (leads
  expire; replying to a stale thread reads as scraper spam). **VoC quotes
  have NO age limit** — any comment/message/post teaches the ICP's slang
  and emotional register. A thread dropped as a stale lead is still
  harvested into `voice-of-customer.md` before closing it.
- The v2 rubric (5 checks: who / what / when-verified / where-routing /
  thread-health) lives in `rescue-sprint/t4-t5-grooming.md` Vote 3;
  `verified date` + `thread health` are mandatory admission columns for
  the scored list. Quality over quota: 10-15 verified-fresh rows beat 25
  padded ones.

# Board conventions

- The kanban board (`kanban-md`, tag `2607`) is **local-only** - `kanban/`
  is gitignored. The committed status snapshot lives in the project
  `backlog.md`; keep both current.
- Every open card carries a `Requires:` line separating Paul-only inputs
  (logged-in browser, approvals, calls, warm-network picks) from
  agent-doable work, so agents never claim un-runnable cards.

# Discovery-call tooling (2026-07-25)

- Record + transcribe every call; Paul takes zero notes. Recommended:
  **Fathom free tier** — unlimited recording/transcripts, bot-free Mac
  desktop capture, MCP integration (agents pull transcripts directly).
  Since Apr 2026 Google Meet flags bot-join recorders (Fireflies/Otter)
  as security risks; a visible bot also reads as surveillance to a
  burned founder. Fallback: Gemini "Take notes for me" (needs Workspace
  Business Standard). Consent line lives in the playbook pre-call prep.
- Transcript feeds three artifacts: audit brief (card #24), VoC
  verbatim lines, objection-bank updates.
- **Optional pre-call fast-track** (discovery-kit): capped ~30-min
  preliminary repo pass when the founder grants access at booking —
  call opens with findings, not logistics. Never required (trust bar).

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
