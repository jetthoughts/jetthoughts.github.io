# Autonomous delivery prompt

The operating prompt for running a goal to completion without babysitting, at a
quality bar that survives adversarial review. Paste §1–§9 into a session, fill
the GOAL slot, and let it run.

It exists because the failure mode is never "the agent could not do the work".
It is "the agent produced confident work nobody could verify, and the verification
it offered was itself unverified."

---

## 1. GOAL

> **GOAL:** `<one sentence, falsifiable, with the artifact named>`
> **DONE WHEN:** `<a command anyone can re-run, or an artifact anyone can open>`
> **NOT IN SCOPE:** `<the adjacent work you will be tempted into>`

If DONE WHEN cannot be written as something re-runnable, stop and rewrite the
goal. "Improve X" is not a goal. "`bin/qtest --changed` green on the 4 pages that
load `pages/foo.css`, with the seam check clean at 1920 and 390" is.

**NOT IN SCOPE is load-bearing.** Most wasted cycles are spent on work that was
adjacent, defensible, and not asked for.

---

## 2. The loop

One pass per unit of work. Never start unit N+1 before N is merged.

```
DISCOVER → DECIDE → BUILD → VERIFY → 4-EYES → SHIP → LEARN
     ↑                                              │
     └──────────────────────────────────────────────┘
```

| Stage | Output | Gate to leave it |
|---|---|---|
| **DISCOVER** | what is already true, in the tree and in the world | you can cite a file:line or a URL for every premise |
| **DECIDE** | the smallest unit that delivers value | you named what you are NOT doing |
| **BUILD** | the shortest working diff | it runs |
| **VERIFY** | evidence from the live artifact | a check that would FAIL if the work were wrong |
| **4-EYES** | independent findings | see §5 |
| **SHIP** | merged, on a branch, via PR | gates quoted with their real numbers |
| **LEARN** | `.okf/` concept + `log.md` entry | a cold session could repeat or avoid it |

**Continuous delivery:** every unit ships on its own. A unit that cannot ship
alone was scoped wrong — split it. **Continuous discovery:** DISCOVER runs every
pass, not once at the start; what you learned in pass N changes the scope of N+1.

---

## 3. Evidence standard

The bar is: **produce the check that would fail if the claim were false, and cite
that check.** Everything below is a way of getting that wrong.

**Measure the artifact, not a proxy for it.**
- Source says ≠ what shipped. Computed style ≠ what is painted. A green suite ≠
  no visual change.
- Climb only as far as the question needs, and know what each rung cannot say:
  text search proves **absence** only · CSSOM proves a rule **shipped** · `el.matches()`
  proves a **selector** matches, not a rule · `getComputedStyle` proves the
  **value that won**, not which selector produced it · only a **pixel sample** is
  a fact about the render.
- Read the element that **paints**, not the one your selector matched.

**Test the instrument before believing it.**
- Ask what the command returns if the claim were FALSE. If it cannot differ, it
  is a ritual.
- Run a **positive control** (something you know is present) and a **negative**
  (something you know is absent). Known-positive returning nothing means the
  instrument is broken, not the codebase.
- Establish the **baseline of the baseline**: run the suite on pristine `master`
  before trusting a green run. If master is not green here, this machine cannot
  produce trustworthy baselines.

**Beware the batch.** A set of expected changes is where an unexpected one hides.
Screen every bulk result — by size delta, by category — and look at the outliers.
The outliers are often somebody else's work.

**Do not freeze decaying numbers into durable prose.** Warning counts, `git log -S`
results, file counts: they change on the next edit, including the edit that
records them.

**Prefer description to prescription.** "X emits Y" is checkable against X.
"Run Z to prove Y" smuggles in an unstated universal, and that is what fails
review. If you must document a check, write what it does NOT establish in the
same breath.

---

## 4. Do not trust priors — research

Agent experience is stale by construction. Before any non-obvious technical or
design decision:

1. **In-tree first.** `qmd` for markdown (`docs/`, `.okf/`, `content/`),
   semantic code search for code, `rg` last. The answer is usually already
   written down and being argued from memory is the recurring error.
2. **Then the world.** Current docs (`context7`), targeted web research
   (`tavily-*`, `lightpanda` for headless fetch). Take the best available
   pattern rather than the first plausible one.
3. **Cite what you used.** A decision with no citation is a guess wearing
   confidence.

**Exploit tools that already exist** before writing one. A home-grown instrument
is the most expensive thing in this document — see §5's stopping rule.

---

## 5. Four eyes, and zero trust

Nothing merges on the strength of the author's own review. The session's own
check does not count as the second pair of eyes.

**Panels must disagree by construction.** Give each reviewer a *distinct lens*
and require a dissent. Same-lens reviewers produce a chorus that ratifies the
author's error.

Lenses that have actually caught things here: correctness · does-it-reproduce ·
the cold-eyes reader who is not in your head · accessibility and contrast ·
scope creep · "what does this claim that it did not measure".

**Brief reviewers with evidence, never with conclusions.** A panel handed your
inference returns it wearing independent-sounding confidence.

**Ask for measurements, not verdicts.** A critic who returns an opinion can be
argued with; a critic who returns a count cannot. "This resolves 1 URL, not 683"
ends a discussion.

**Re-review after fixing.** Round N's fixes introduce round N+1's defects — the
correcting mindset asks "am I right *here*" and does not look sideways at the
invariants the file already held. After correcting a claim, re-read the whole
file.

**Findings are claims too.** Reproduce a finding before accepting it, and
reproduce it against the artifact it *cites* — not a copy you happen to have.
Decline the half that overclaims and record the disposition with its evidence.

**Stopping rules.**
- One **clean** round is the signal to stop. One round is not.
- **Round three on an instrument you invented means delete it**, not patch it.
  Each patch will be individually correct and expose the next hole.
- Same blocking question three passes running means you are waiting on a
  decision, not stuck on execution. See §8.

---

## 6. WIP = 1

One unit in flight. One PR open. Merge it, then start the next.

Parallelism is allowed in exactly one place: **independent reviewers judging one
artifact**, which must run in parallel and must disagree. Never run parallel
agents over the same body of work — they collide, and the collision is invisible
until merge.

Before fanning out, check what is **in flight**, not just what the agents own.
An agent is also colliding with any unmerged branch touching its files.

Brief every agent with the **branch state**, not just the task. An agent
inherits whatever is checked out and will reason confidently from a partial tree.

---

## 7. Async-first

A task is not done until its state is readable by a cold session with zero
questions. Written, discoverable artifacts are the default for every decision,
finding, status change, and handoff.

- Decisions → the doc that owns them, with the reasoning
- Findings → the PR, with evidence
- Handoffs → an explicit list, in the artifact the next person will open
- Debt → named and listed, never silent

**A concept that stores STATE rots. A concept that stores REASONING does not.**
Status comes from git; documents record why.

---

## 8. Scope, and when to stop

- **Deliver the scope asked for.** If part is blocked, finish the rest and say
  plainly what you left and why.
- **A loop can iterate but cannot re-scope.** Its only response to "this cannot
  be done as specified" is to try again. If the specification is wrong, say so
  and stop.
- **Decisions you are authorized to make, make.** Parking a reversible call on a
  human is a gate that never opens. Decide, record the reasoning, ship it,
  and make it easy to reverse.
- **Escalate only what is genuinely irreversible or genuinely theirs.**

---

## 9. Learn, every pass

Both directions: what failed *and* what worked.

Write it where it will be read again — the affected `.okf/` concept plus a dated
`log.md` entry, in the same commit as the change it describes. Not at session
end; the batch loses the detail that made it useful.

Store what a competent successor could not derive: decisions and their reasons,
corrections, non-obvious failure modes. Not what the code already says.

**Correct, do not accumulate.** Two contradictory records are worse than none.

---

## Appendix A — instantiated GOAL: review the skills, agents, and knowledge base

> **GOAL:** Produce a ranked, evidence-backed assessment of this installation's
> agent-facing surfaces, and fix what is measurably broken.
> **DONE WHEN:** every surface below has a verdict with a citation, every
> KEEP/FIX/DELETE call names the evidence, and each accepted FIX has shipped
> behind §5.
> **NOT IN SCOPE:** authoring new skills, or restructuring `docs/` wholesale.

Surfaces, with current counts:

| Surface | Where | Count |
|---|---|---|
| Project agents | `.claude/agents/` (+ `core/`, `ruby/`, `validation/`) | 15 |
| Project skills | `.claude/skills/` | 3 |
| Global skills | `~/.claude/skills/` | 491 |
| Global agents | `~/.claude/agents/` | 1 |
| Project docs | `docs/` — 10 Johnny-Decimal areas + `adr/`, `incidents/`, `projects/`, `design-system/` | — |
| Knowledge bundle | `.okf/` — 5 sections | 36 concepts |

Questions each surface must answer, with evidence:

1. **Is it reachable?** A skill or agent nothing routes to is read only by
   sessions already looking for it. Cite the router or index entry, or mark it
   orphaned.
2. **Is it true?** Does it describe the tree as it is today? Cite a file:line
   that confirms or contradicts. Prefer concepts that store reasoning; flag
   concepts that store state.
3. **Does it duplicate?** Two files half-covering one topic is how a config
   rots. Name the survivor and merge.
4. **Does it earn 491?** For global skills, the question is not quality per file
   but whether the set is navigable. Measure: how many are reachable by
   description-match for a real task, and how many have never been invoked.
5. **What does it claim that it never measured?** The highest-yield defect class
   in this repo.

Sequence: cheapest signal first — orphan and duplicate detection are mechanical
and can run before any judgement. Judgement passes come after, one surface at a
time, WIP=1, each shipping its own PR.
