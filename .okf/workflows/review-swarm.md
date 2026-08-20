---
type: Playbook
title: Two-critic review swarm
description: The proven module-review loop - a design critic (full render walk) plus a content-canon critic, followed by verified fixer waves.
tags: [swarm, review, process]
generated:
  by: process:okf-migrate
  at: 2026-07-24T00:00:00Z
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

# Multi-doc kit reviews (2026-07-24, 2607 outbound-kit audit)

When the review target is a SET of documents that share facts (pricing,
counts, claims, links), add two finder angles a per-doc review cannot cover:

- **Cross-doc drift finder** - pick each shared fact and trace it through
  every file. The A2 pricing was updated in all 5 sending docs but left
  stale in the 2 narrative docs (strategy, executive summary); every
  per-doc pass had "correct" input.
- **Link-routing check** - every link paired with a named person must
  resolve to that person's OWN post/profile. A quote captured from a
  COMMENT routes to the commenter, not the thread author (the Joy/Nico
  mis-route survived three docs).

# Reviewers die silently, and the brief size looks causal (2026-08-20)

In one 3-lane swarm, **six** review agents were dispatched and **four died
before reporting**, every one with "You've reached your Fable 5 limit". The
work agents were fine — they carried an explicit `model: opus` override; the
reviewers they spawned inherited the session default.

**The asymmetry is the danger, not the failures.** Work completes and reports
success; the thing that checks it quietly does not run. A lane can plausibly
report "done" having self-reviewed a 213-site codemod. Rules that follow:

* **A dead reviewer is not a passed review.** A lane whose gate agent dies
  reports *blocked-on-review*, never complete.
* **An idle reviewer is ambiguous** — "available" reads the same whether it
  finished, never started, or died. Ask for the verdict explicitly; never
  infer it from a status flag.
* **Pass `model: opus` explicitly on every spawned agent**, reviewers included.
* **The coordinator can close a leg itself** rather than stall the wave — but
  then it is reviewing work it also integrates, so say so and invite
  contradiction from any later reviewer.

**Brief size appears to be the mechanism, not luck.** The lane that dispatched
four reviewers observed that the three which died had long briefs and the one
that returned a full verdict had the tightest, most concrete one. A credit
limit is consumption-based, so a longer prompt burns the budget faster — which
makes the sprawling, thorough-looking brief the *less* likely one to produce a
review at all. Write reviewer briefs short and concrete: what to read, what
verdict format, and the two or three specific things to attack.

# Known failure modes

- Agents often go idle WITHOUT sending their report - nudge via SendMessage,
  and verify their work in the tree regardless. If SendMessage is
  unavailable, their final text is recoverable from
  `~/.claude/projects/<project>/<session>/subagents/agent-*.jsonl`.
- **Late finders carry real findings** - in the 2607 audit, 3 of 6 finders
  reported after the first synthesis was already delivered and contributed
  3 confirmed defects (stale pricing, board drift, a banned voice pattern
  in prospect-facing copy). Do not close the review until every finder has
  reported; treat an early synthesis as provisional.
- Session-limit failures kill whole waves; respawn after the reset rather
  than retrying immediately.
- Fixer geometry claims (SVG sizes, clipping fixed) must be re-verified by
  your own re-render - one wave shipped a wording truncation nobody saw.
- Parallel sessions contend on .git/index.lock - wait-loop before git ops.
