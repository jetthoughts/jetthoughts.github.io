---
type: Playbook
title: LinkedIn Post Pipeline — Paul Keen / JetThoughts
description: Canonical voice reference and workflow for writing LinkedIn posts under Paul Keen's personal account, primarily for the ICP-E validation campaign.
resource: docs/workflows/linkedin-post-pipeline.md
tags: [content, linkedin, workflow, voice]
generated:
  by: process:okf-migrate
  at: 2026-07-12T00:00:00Z
timestamp: 2026-08-17T13:20:00Z
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
sidecar (port 1315); each post page gets Approve/Reject buttons (keys
`a`/`r`) that rewrite the post's frontmatter `status:` and append to
`linkedin-posts/decisions.log`. Frontmatter stays the single status source -
the agent tracks decisions from there, no chat round-trip.

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

# Citations

[1] `docs/workflows/linkedin-post-pipeline.md`
[2] `docs/workflows/linkedin-icp-validation-plan.md`
