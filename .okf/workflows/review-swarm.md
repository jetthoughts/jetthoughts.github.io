---
type: Playbook
title: Two-critic review swarm
description: The proven module-review loop - a design critic (full render walk) plus a content-canon critic, followed by verified fixer waves.
tags: [swarm, review, process]
timestamp: 2026-07-17T00:00:00Z
---

# The loop

1. Build the site so critics inspect fresh output.
2. Spawn a DESIGN critic (renders every page via the
   [render-verification recipe](/workflows/render-verification.md), scores
   worst-first) and a CONTENT-CANON critic (diffs numbers against the
   [course canon](/content/course-canon.md), sweeps banned patterns, checks
   links) in parallel, in the background.
3. Adjudicate reports; VERIFY every claim against the actual files/renders
   before acting - critics are sometimes wrong about line numbers or values.
4. Fix surgically (one attribute = one edit; never re-theme the page).
5. Add ratchet entries for fixed prose defects
   ([banned-strings ratchet](/content/banned-strings-ratchet.md)).
6. Gates per [test gates](/build/test-gates.md), commit to the sprint
   branch, one bundled PR per sprint.

# Taste pass (premium bar)

After defect review, run taste critics scoring 1-10 against
`.stitch/course-taste-design.md` - defect checklists miss "technically
fine but not premium" (monotone callout runs, brand living only in the
cover, wall-shaped diagrams). Adjudicate critic conflicts against the
anchor text, not majority vote: taste-e's red-metric ruling beat
taste-a's recolor suggestion because the anchor names Ruby as the brand
accent ink.

# Mechanical runbook

The full audit is codified as a command+pass-rule checklist that
less-powerful models can execute: `docs/workflows/course-audit-checklist.md`
(8 phases: length, structure, terminology, canon, reuse/seams, render gate,
judged checks with escalation rules, fix/report protocol). Hand agents that
file instead of re-deriving audit briefs per session.

# Known failure modes

- Agents often go idle WITHOUT sending their report - nudge via SendMessage,
  and verify their work in the tree regardless.
- Session-limit failures kill whole waves; respawn after the reset rather
  than retrying immediately.
- Fixer geometry claims (SVG sizes, clipping fixed) must be re-verified by
  your own re-render - one wave shipped a wording truncation nobody saw.
- Parallel sessions contend on .git/index.lock - wait-loop before git ops.
