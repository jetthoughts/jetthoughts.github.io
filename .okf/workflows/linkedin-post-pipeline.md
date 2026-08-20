---
type: Playbook
title: LinkedIn Post Pipeline — Paul Keen / JetThoughts
description: Canonical voice reference and workflow for writing LinkedIn posts under Paul Keen's personal account, primarily for the ICP-E validation campaign.
resource: docs/workflows/linkedin-post-pipeline.md
tags: [content, linkedin, workflow, voice]
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
timestamp: 2026-08-20T00:00:00Z
---

# Overview

All LinkedIn posts (`linkedin-posts/**/*.md`) are personal, authored by
Paul Keen from his own profile — never corporate JetThoughts marketing.
First-person voice only ("I"/"me"/"my"), never "we"/corporate plural.

This file overrides the blog voice guide when the two conflict, for
LinkedIn drafts specifically.

# Mandatory pre-writing reads

1. `docs/workflows/linkedin-icp-validation-plan.md` — campaign
   hypotheses, content pillars, weekly plan.
2. [icp](/content-strategy/icp-primary-website-target.md) — ICP-E
   definition, pain language, control-loss patterns.
3. [voice-guide](/content-strategy/voice-guide.md) — voice formula,
   banned words, anti-AI structural patterns.
4. This file — LinkedIn-specific overrides.

# Blocking self-critique requirement

Every draft or revision of a LinkedIn post must invoke the
`reflexion-reflect` skill (Standard Path) BEFORE first handback. After
any user pushback on the same draft, escalate to `reflexion-critique`
(multi-judge debate). Solo iteration past first delivery has
repeatedly missed pattern-level tells (over-narration, cinematic
beat-marking, shape-coded copywriting).

# Local review board + composer scheduling (2026-08-17)

**Review = a link, not pasted text.** Run `bin/dev`, hand Paul
`http://localhost:1313/linkedin/` (board) or
`/linkedin/<lane>/<slug>/` (single post). Dev-only: the mount lives in
`config/development/hugo.toml` (`linkedin-posts/` → `content/linkedin`);
production builds never ship these pages.

**Board approvals (2026-08-17):** `bin/dev` auto-starts the `bin/li-review`
sidecar on **hugo port + 1000**; buttons target the sidecar of the server the
page came from, so parallel sessions each write to their own checkout.
Approve (key `a`, hidden once approved) writes `status: approved`; Postpone
(key `p`) writes `status: postponed` + `stage: backlog`; a backlogged post
offers only "To pre-verify" (requeue -> `status: draft` + `stage: next`) so
backlog items re-enter via review, never straight to approved. The board's
Backlog section is a catch-all - no status value can hide a post. Decisions land in
frontmatter (single status source) + `linkedin-posts/decisions.log`
(gitignored) - the agent tracks from there, no chat round-trip.

**Composer fill can be permission-blocked:** the harness classifier may deny
typing a post body into the composer, and LinkedIn's contenteditable exposes
no ref for form_input. Stage everything (draft, plan row, review link), leave
the composer open, hand Paul the body to paste. Do not chunk-retry the denied
type action.

**Driving the native composer (claude-in-chrome):**

- Focus the editor by clicking the *placeholder text* directly — a click
  in the empty area below it does not focus and typing is silently lost.
- Compose text = post **body + the frontmatter `cta` line** (the cta is
  not stored in the body).
- Image must be attached BEFORE scheduling; Paul attaches (file dialog
  is not automatable).
- Schedule dialog uses the account's local timezone (CEST for Paul);
  date via calendar click, time via the field's dropdown.
- The scheduled queue has **no direct URL**
  (`/my-items/scheduled-posts/` 404s) — reach it via composer → clock
  icon → "View all scheduled posts".
- After scheduling: flip the post's frontmatter (`status: scheduled`,
  `stage: now`, `scheduled_for`) and the `linkedin-posts/content-plan.md`
  table row in the same commit.

# Closing the loop on publish (2026-08-20)

`status: scheduled` is a promise, not a record — the scheduler fires with
no callback into the repo. The first metrics read found two of three
drafts still marked `scheduled` although both had published on time, and
no draft carried a `posted_url` at all.

On the day a post goes live: flip `status` → `posted`, add `posted_for`,
add **`posted_url`** (`/feed/update/urn:li:activity:<id>/`), and open its
`metrics-ledger.md` row with metric cells blank. Keep `scheduled_for` —
the gap to `posted_for` is the only record of slippage.

`posted_url` is load-bearing, not bookkeeping: the analytics page is the
same activity id under `/analytics/post-summary/`, and that id **cannot be
derived from the slug**. Without it, a later read means scrolling the
profile activity feed and matching post text by hand.

Two reading caveats found the same day: **`icp_profile_views` is not
readable** on this account (raw per-post viewer counts show, but the
titles behind them need Premium, which is lapsed) — record `n/a`, never
`0`. And the **rescue lane cannot satisfy the plan's arrival override** by
construction: it ships reply-CTA only with no link, so it emits no UTM and
generates no campaign session however well it performs. It is decidable on
`icp_replies` alone; its zero arrivals are not a signal.

# Citations

[1] `docs/workflows/linkedin-post-pipeline.md`
[2] `docs/workflows/linkedin-icp-validation-plan.md`
