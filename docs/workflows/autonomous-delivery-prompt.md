# Autonomous delivery prompt

**Onboard in 60 seconds** — the map, then read only what the task needs:

- **Loop** (§2): `DISCOVER → DECIDE → BUILD → VERIFY → SHIP → LEARN`, 4-eyes
  gating every stage. The unit is the PR; commits within it land one at a time,
  each independently reviewed; a sprint PR carries at most ~500 changed lines
  of CODE (§1a — docs/logs exempt).
- **Roles** (§5): Author writes, a different Verifier proves — author never
  produces evidence for its own claim. Internal sub-agents per stage;
  `/codex:review` once at the merge gate.
- **Principles**: evidence over confidence (§3 — produce the check that would
  fail if the claim were false), research before deciding (§4 — in-tree first,
  NotebookLM for deep research), async-first artifacts (§7), deliver the scope
  or say what you left (§8), learn every pass (§9).
- **Tools**: Appendix B is the current surface snapshot — do not re-discover.
  Appendix C maps each work domain to its references. Commands and repo gates:
  `CLAUDE.md` header + `docs/workflows/BASE_HANDBOOK.md`. Business/weekly loop
  lives in the vault (`jt-operations`), not here.

The operating prompt for running a goal to completion without babysitting, at a
quality bar that survives adversarial review. Paste §1–§9 into a session, fill
the GOAL slot, and let it run.

It exists because the failure mode is never "the agent could not do the work".
It is "the agent produced confident work nobody could verify, and the verification
it offered was itself unverified."

**What the whole document is for: agents collaborating to find the truth.** Not
to produce output faster, and not to produce more of it. A single agent cannot
find its own blind spot — it checks the thing it meant to build. Truth comes out
of the friction between agents with different jobs and different lenses, which is
why the rules below are mostly about keeping that friction real: separate the
author from the verifier, brief with evidence rather than conclusions, require a
dissent, and treat every finding as a claim that must itself survive.

Structure the collaboration well and the system converges on what is actually
there. Structure it badly — same lens, shared assumptions, author checking
author — and it converges just as confidently on whatever the first agent
believed.

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

### 1a. Intake — from a raw idea to a running unit

When Paul hands a feature or idea, this is the path in — orchestration never
starts before it:

1. **TRIAGE** (manager rule, `CLAUDE.md`): now / sequenced / backlog /
   groom-first. One-line verdict so Paul can override.
2. **SHAPE**: ambiguous or structural → grooming first (`structural-decisions`,
   brainstorming, persona panel). Concrete → straight to GOAL.
3. **GOAL**: write §1's three lines. No re-runnable DONE WHEN → no dispatch.
4. **ORCHESTRATE by size** — the contract holds at every scale:
   - *trivial edit*: inline; a verifier agent still reviews before commit.
   - *one unit*: author agent + distinct verifier (§5).
   - *a feature*: commits proceed one at a time on the sprint branch, each
     independently reviewed (§2); the sprint ships as **ONE PR capped at ~500
     changed lines of CODE** (Paul 2026-08-21 — docs, `.okf/` logs, and
     binaries/baselines do not count; docs-only work may batch bigger). A
     sprint whose code diff would exceed the cap splits into sequential PRs:
     merge N before opening N+1.
   - *swarm scale*: only on explicit request — `ruflo-swarm`, workers in
     worktrees (committing agents get isolation).
5. **The contract — non-negotiable regardless of orchestration shape**:
   feature branch + PR, never master, PR ≤ ~500 changed CODE lines
   (docs/logs exempt) · rebase when master moves, never merge it in (tag a
   backup ref first; `--autostash` when unstaged changes block it) ·
   author ≠ verifier at every stage (§5) ·
   gates matched to the diff type (§2 SHIP + `CLAUDE.md`) ·
   claims-canon + voice gates on anything customer-facing · OKF sync rides the
   same commit · async-first artifacts (§7) · escalate only the irreversible
   or a genuine scope change (§8).

An orchestration that would break any contract line is scoped wrong — reshape
the work, never waive the line.

---

## 2. The loop

One pass per unit of work. **The unit is the PR**: within it, commits proceed one
at a time, each independently reviewed before it lands, and none is started while
the previous one is still unreviewed. Do not open a second PR until this one
merges.

Saying "never start N+1 before N MERGES" would deadlock any bundled sprint — the
appendix audits several surfaces in one PR, and no surface could ever merge on
its own. WIP=1 constrains what is IN FLIGHT, not how many commits a PR contains.

```
DISCOVER → DECIDE → BUILD → VERIFY → SHIP → LEARN
    │         │        │        │       │      │
    └─────────┴────────┴────────┴───────┴──────┘
         4-EYES gates EVERY stage, not just the last
```

**Review each stage before the next begins.** A wrong premise costs the whole
pass; a wrong diff costs an hour. Reviewing only before SHIP finds the cheap
defect and misses the expensive one — by then the wrong premise is load-bearing
under everything built on it.

| Stage | Output | Gate to leave it | Reviewed for |
|---|---|---|---|
| **DISCOVER** | what is already true, in the tree and in the world | a reviewer has READ each cited line and confirmed it says what the premise claims | *is the premise real, and is it current?* |
| **DECIDE** | the smallest unit that delivers value | you named what you are NOT doing | *is this the right unit, and is the scope honest?* |
| **BUILD** | the shortest working diff | it runs | *correctness, and what it touches that it should not* |
| **VERIFY** | evidence from the live artifact | a check that would FAIL if the work were wrong | *does the evidence support the claim — see §3* |
| **SHIP** | merged, on a branch, via PR | the gate matrix for THIS change class, quoted with real numbers — see below | *do the quoted gates say what you claim* |
| **LEARN** | a durable learning captured, or "none this pass" **naming what was checked and found derivable** | a cold session could repeat or avoid it | *is this derivable already, or genuinely new* |

The review weight scales with the stage's cost of being wrong, but none of them
is zero. A cheap stage gets a cheap check — one skeptical pass with a named
lens — not a skipped one, **and it leaves one line in the record**: lens,
strongest objection found, disposition. Without that line the pass is
undetectable afterwards, which makes it optional in practice.

**This matters most where it feels least necessary.** A skipped LEARN is visible
in a `log.md` diff; a skipped DISCOVER review leaves no trace at all — so the
stages whose omission is invisible are exactly the ones the document calls most
expensive to get wrong. Left unrecorded, the enforcement gradient runs backwards:
strongest detection over the cheapest failures.

### SHIP — the stage with no section, until now

Review found this was one table row governing the only irreversible stage. The
gates are **not** listed here, on purpose: they live in `CLAUDE.md` and they
change. What belongs here is *which class you are in*, because picking the wrong
class is the actual failure.

| Change class | Gate |
|---|---|
| content only — markdown prose/frontmatter, no `themes/`, no `layouts/`, no CSS, no body HTML | `bin/hugo-build` + the rendered scroll gate. **Not** the visual suites. |
| anything touching `themes/`, `layouts/`, `*.css`, or body HTML/SVG | `bin/qtest --changed` before every commit; the full `bin/test` **and** `bin/dtest` pair once at PR prep |
| docs / instruction layer only | `bin/hugo-build`; internal review; the slow external reviewer does not gate the merge |

Check the **actual diff**, not your intent — the class is decided by what the
patch touches.

PR mechanics that have bitten this repo, all in `CLAUDE.md` in full: branch and
PR for everything including docs · **rebase, never merge** when master moves,
after tagging a backup ref · `gh pr merge --auto` does **not** queue here, it
merges immediately · a PR touching visuals must not open without the `dtest` leg.

If you cannot name your change class, you are not ready to SHIP.

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
- Establish the **baseline of the baseline**: run the suite at the branch's
  **merge base** (`git merge-base origin/master HEAD`) — not current `master`,
  which has moved and will smuggle unrelated upstream failures into your delta —
  then compare **failure sets**, not pass/fail. Rebase immediately before
  measuring, and run both sides in the same environment. Master red is normal —
  `/okf:validate .okf --strict` is known-red by design (invoke it through the
  skill or the full script path - there is no `okf_validate` on `PATH`), and this repo's macOS
  screenshot baselines can be red in a worktree before you touch anything. The
  signal is the *difference*: failures your branch adds, or base failures it
  silently fixes. Reject the instrument only when its controls fail or the
  environment differs, not merely because the base is not green.

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
   (`tavily-*`, `lightpanda` for headless fetch); substantial multi-source
   research goes through the NotebookLM MCP (Paul 2026-08-21). Take the best
   available pattern rather than the first plausible one.
3. **Cite what you used.** A decision with no citation is a guess wearing
   confidence.

**Exploit tools that already exist** before writing one. A home-grown instrument
is the most expensive thing in this document — see §5's stopping rule.

---

## 5. Four eyes, and zero trust

**Separation of duties is the rule, not a nicety: every change is WRITTEN by one
sub-agent and VERIFIED by a different one.** The author cannot be the verifier.
Not "the author double-checks", not "the author runs the tests" — a second agent
that did not write the change produces the evidence that it is correct.

The reason is not diligence, it is blindness. An author verifies the thing they
meant to build; only someone who did not build it checks the thing that is
actually there. Every serious defect in this repo's recent history got past an
author who had just re-read their own work.

Nothing merges on the strength of the author's own review. The session's own
check does not count as the second pair of eyes.

| Role | Does | Must not |
|---|---|---|
| **Author** | makes the change, states the claim | produce the evidence for its own claim |
| **Verifier** | independently re-derives the evidence | be briefed with the author's conclusions |

Give the verifier the GOAL, the artifact, **and the author's reasoning** — with
the instruction to attack the assumptions in it and to produce **one measurement
the author did not run**.

*This reverses an earlier rule that said to withhold the reasoning, and the
reviewer who overturned it proved the point by method: it read this document's
own argument, attacked it, and produced ten findings the blind version would have
forbidden it to look for.* Withholding the reasoning withholds the assumptions,
and the assumptions are the attack surface. The defects that actually get through
here are reasoning-shaped — stale premises, prescriptive claims, flattering
denominators — not arithmetic.

The original fear was real but misdiagnosed: a panel handed your **verdict**
returns it wearing independent confidence. That is verdict contamination, and it
is already handled by demanding measurements rather than verdicts. Exposing how
you reasoned is not the same as telling them what to conclude.

**Where the handoff lands, concretely.** The review happens *before the artifact
leaves the workshop* — before the human sees it, before it is committed. Not
before merge.

**These STACK, they do not replace each other:** internal review before every
commit, plus the external companion once more before merge. The pre-commit gate
is the one that catches a defect while it is still cheap; the pre-merge gate
catches what only the whole diff reveals. Neither is optional because the other
ran.

| You produced | Peer review happens | Only then |
|---|---|---|
| a **plan** | a second agent reviews the plan | → ask the user. They never see an unreviewed plan. |
| a **code change** | a second agent reviews the diff | → commit. Not "commit then review the PR". |
| a **finding** or claim | a second agent tries to reproduce it | → report it |
| a **measurement** | a second agent re-derives it independently | → quote it as evidence |
| a **doc / concept** | a cold-eyes agent reads it without your context | → ship it |

The test for whether you got this right: **at the moment the user reads
something, has someone other than the author already checked it?** If no, the
gate was in the wrong place.

### Which reviewer, and what it costs

Reviewing every stage is only affordable if you match the reviewer to the stage.
Using the slowest one everywhere is how four-eyes gets quietly abandoned.

| Reviewer | Use for | Cost |
|---|---|---|
| **Internal sub-agent** (`Agent` tool, distinct lens per call) | every per-stage review — plans, diffs before commit, findings, measurements, docs | fast; the default |
| **External companion** (`/codex:review`) | the final verify before merge, once — **for user-facing changes** | slow — do not put it in the inner loop |

**Select the reviewer by what the runtime actually has.** Some environments
expose neither a sub-agent tool nor `/codex:review`. The requirement is a second
pair of eyes, not a particular tool, so fall back in this order: another agent →
an external reviewer → **a peer session** (`ListAgents` / `SendMessage`) → the
human. If none is reachable, say so in the handback and mark the change
UNREVIEWED rather than describing it as verified. A review you could not run is
a disclosure, never a silent skip.

**Docs-only and instruction-layer changes do not wait on the slow reviewer**
(Paul, 2026-08-21). Ship on internal review plus CI, and apply the external
findings afterwards as a follow-up. Holding a green docs PR behind a ten-minute
reviewer buys nothing and teaches everyone that the gate is negotiable.

`/codex:review` earns its cost at the merge gate, where the whole diff exists and
being wrong is expensive. Spending it on a premise check or a two-line fix buys
little and trains everyone to skip the gate because "review is slow".

Rule of thumb: **internal agents all the way through, the external companion once
at the end.** If the external reviewer finds something the internal ones should
have caught, that is a signal about your per-stage lenses, not a reason to run
the slow reviewer more often.

**Panels must disagree by construction.** Give each reviewer a *distinct lens*.
Require each to name **the strongest finding against shipping, with the evidence
for it** — "no objection" is a permitted answer only when it names the check that
was run. A dissent requirement satisfied by a manufactured nitpick is worse than
none: it looks like friction and produces none. Same-lens reviewers produce a
chorus that ratifies the author's error.

Lenses that have actually caught things here: correctness · does-it-reproduce ·
the cold-eyes reader who is not in your head · accessibility and contrast ·
scope creep · "what does this claim that it did not measure".

**Brief reviewers with evidence and reasoning, never with a VERDICT.** The brief
is itself auditable — the reviewer prompt is logged, so quote it as evidence, and
it may contain no verdict-shaped sentence ("this is correct because…",
"confirm that…"). A rule only the author can check is not a rule.

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
- One **clean** round is the signal to stop. One round is not. *Clean* means **no
  confirmed blocking findings** - not "nobody objected". The dissent requirement
  above applies to judgement panels choosing between options; it does not oblige
  a verification round to manufacture an objection, and a round that ends with a
  reviewer naming its strongest objection and showing it does not block IS clean.
- **Round three on an instrument you invented means delete it**, not patch it.
  Each patch will be individually correct and expose the next hole.
- Same blocking question three passes running means you are waiting on a
  decision, not stuck on execution. See §8.

---

## 6. WIP = 1

One unit in flight. One PR open. Merge it, then start the next.

Parallelism is allowed in exactly three places:

1. **Independent reviewers judging one artifact** — run in parallel, each with a
   distinct lens and each required to make its strongest attempt at an
   objection. Independent agreement is a valid outcome; manufactured
   disagreement is not.
2. **The OKF maintainer**, which this repo requires to run *in parallel with* the
   work rather than after it, so the bundle update rides the same commit
   (`AGENTS.md` §OKF maintenance). It does not touch the work's files, so it
   does not collide.
3. **Explicitly-requested swarm workers** (§1a), each isolated in its own
   worktree — isolation is what removes the collision, so a swarm worker
   without a worktree is not allowed.

Otherwise: never run parallel agents over the same body of work — they collide,
and the collision is invisible until merge.

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
- Findings → the PR when one exists, with evidence. **Most stage reviews happen
  before any commit**, so their verdicts have no PR to land in: put those in the
  commit message of the change they gated, or the sprint working doc. A finding
  with nowhere to live fails this section's own cold-session bar.
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

Surfaces, and the command that enumerates each. **No counts are written here on
purpose** — §3 forbids freezing a decaying number into durable prose, and the
first draft of this appendix did it anyway, with two of the numbers wrong.

| Surface | Where | Enumerate with |
|---|---|---|
| Project agents | `.claude/agents/**` incl. `core/`, `ruby/`, `validation/` | `find .claude/agents -name '*.md'` |
| Project skills | **`.agents/skills/`** and **`.skills/`** | `ls .agents/skills .skills` |
| — pointer only | `.claude/skills/` holds a README naming the two real locations | `cat .claude/skills/README.md` |
| Global / plugin skills | **the running tool's own roster** — not a directory | list the roster of the runtime you are in; `~/.claude/skills/` is Claude Code's slice of it, not the whole |
| Global agents | the runtime's agent roster | same — enumerate per runtime |
| Project docs | `docs/` — Johnny-Decimal areas + `adr/`, `incidents/`, `projects/`, `design-system/` | `find docs -name '*.md'` — **recursive**; `ls docs` returns areas, not documents |
| Knowledge bundle - concepts | `.okf/` | `find .okf -name '*.md' -not -name 'index.md' -not -name 'log.md'` |
| Knowledge bundle - **reserved files** | `.okf/index.md`, section `index.md`s, `.okf/log.md` | `find .okf \( -name 'index.md' -o -name 'log.md' \)` - audit these SEPARATELY: the root index is the mandatory discovery entry point, so broken routing there is invisible to a concept-only sweep |

**Do not assume `.claude/skills/` is the skill surface.** It is a pointer. The
first draft audited it and would have skipped every real project skill — a
worked example of §3's "measure the artifact, not a proxy for it", found by
review rather than by the author.

Questions each surface must answer, with evidence:

1. **Is it reachable?** Two discovery paths count, and conflating them
   manufactures false orphans:
   - **Roster/metadata match** — global and plugin skills are found by
     description against a real task, with no router entry anywhere. This is the
     normal path (`.claude/skills/README.md`: *"invoke by name, never by
     absolute path"*).
   - **Explicit routing** — an index or router entry.

   Do not assume project surfaces need routing: under some runtimes
   `.agents/skills/*/SKILL.md` is surfaced in the roster automatically, while
   `.skills/*` may not be. Check both locations against the ACTIVE runtime's
   roster before concluding either way - guessing here produces both false
   orphans and redundant routing.

   Mark orphaned only when **neither** applies. A DELETE call justified by a
   missing router entry alone is unsupported.
2. **Is it true?** Does it describe the tree as it is today? Cite a file:line
   that confirms or contradicts. Prefer concepts that store reasoning; flag
   concepts that store state.
3. **Does it duplicate?** Two files half-covering one topic is how a config
   rots. Name the survivor and merge.
4. **Does the SET earn its size?** For global skills, the question is not quality per file
   but whether the set is navigable. Measure: how many are reachable by
   description-match for a real task, and how many have never been invoked.
5. **What does it claim that it never measured?** The highest-yield defect class
   in this repo.

Sequence: cheapest signal first — orphan and duplicate detection are mechanical
and can run before any judgement. Judgement passes come after, one surface at a
time, WIP=1 — **one COMMIT per surface on the audit branch, one PR for the audit**.
Not one PR per surface: `CLAUDE.md` requires related work bundled into a single
PR (Paul, 2026-04-30: *"let's have one big PR instead of small PR"*), and eight
surfaces would otherwise become eight PRs.

---

## Appendix B — the tool surface, as of 2026-08-21

A **dated snapshot** so agents do not re-discover what is already known (Paul
2026-08-21: docs are explicit; do not spend cycles enumerating). Regenerate
each surface with the command in its header when a plugin changes; trust the
snapshot otherwise.

### MCP servers — regenerate: `claude mcp list`

Connected and load-bearing for this repo:

| Job | Server(s) |
|---|---|
| Markdown search (`docs/`, `.okf/`, `content/`) | `qmd` (collection `jt-site`) — FIRST for any doc/content lookup |
| Memory, swarm, hooks, loops | `ruflo` (plugin:ruflo-core; `.swarm/memory.db`) |
| Code search / symbols | `serena`, `tokensave`, `grepai`, `claude-context` |
| Library docs | `context7` |
| Visual checks, screenshots | `chrome-devtools` (headless) + plugin chrome-devtools |
| GitHub API | `github` (plugin) |
| Search Console / Analytics / Clarity | `gsc`, `google-analytics`, `clarity` |
| Web search / fetch | `parallel`, `brave-search`, `lightpanda` skill |
| Deep research, source-grounded Q&A | `notebooklm` / `notebooklm-mcp` (Google NotebookLM) — run substantial research through it, not ad hoc web calls |
| Design generation | `stitch` |
| Memory fallbacks | `memoria`, `mem0` (ruflo-first — see below) |
| Language server (Ruby) | `ruby-lsp` plugin + the `LSP` tool (diagnostics, go-to-def) |

Known state: `telegram` and `aci` fail to connect; `legalzoom` and `sentry`
need auth; interactively-authenticated (claude.ai) servers are absent in
headless/cron runs. A memoria cold-start "connection error" is a false alarm —
call the tool before believing it. Deferred tool schemas load via `ToolSearch`
— batch every tool you need into ONE comma-separated `select:` call.

### Skills — regenerate: read the roster in the session's system listing

The operational set for this repo (invoke via Skill tool; `/name` from the
user is an invocation request): `okf:okf` + `okf:validate` (bundle work),
`qmd:qmd`, `ponytail:ponytail` (held at ultra), `reflexion-reflect` /
`reflexion-critique` (voice-sensitive content, BLOCKING), `content-cold-eyes`,
`search-routing`, `code-review:code-review`, `commit-commands:*`, the
`superpowers:*` process family, and the ruflo set: `ruflo-swarm:swarm`,
`ruflo-loop-workers:ruflo-loop`/`cron-schedule`, `ruflo-autopilot:autopilot`,
`ruflo-security-audit:security-scan`, `ruflo-testgen:testgen`,
`ruflo-docs:doc-gen`, `ruflo-rag-memory:recall`. Repo pipelines (blog,
LinkedIn, new-page, cover-images) live in `docs/workflows/` and are executed
end-to-end like skills.

### Agents — regenerate: the Agent tool roster / `ListAgents`

The ones this repo actually routes to: `core-reviewer` / `core-coder` /
`core-researcher` / `core-planner` / `core-tester` (per-stage 4-eyes),
`hugo-expert`, `ruby-coder` + `ruby-reviewer`, `content-creator`,
`blog-batch-orchestrator` + `blog-post-coordinator`, `screenshot-guardian`,
`qa-browser-tester`, `ux-browser-validator`, `seo-specialist`,
`codex:codex-rescue` (external second opinion), `Explore` (read-only fan-out).
Project agent definitions: `.claude/agents/**` — audit per Appendix A.

**Routing through the roster is ENFORCED, not advisory (Paul 2026-08-21).**
If a listed skill or tool covers the task, invoke it — hand-rolling what a
skill already does is the same defect as writing a helper that exists two files
over. The order of preference:

1. **A matching skill** — invoke it before any response or action; its
   instructions replace your default approach. The roster proves presence,
   reading the skill proves fit — and **repo instructions win on conflict**
   (repo voice guides and workflow docs override generic writing/SEO/humanizer
   skill advice, per `CLAUDE.md`). Repo pipelines (blog, LinkedIn, OKF,
   new-page) are skills-by-another-name: execute them end-to-end.
2. **A matching MCP tool** — `qmd` for markdown search, semantic code search
   for code, `context7` for library docs, chrome-devtools for visual checks
   (§4's order). Load deferred schemas via `ToolSearch`, batched.
3. **Hand-rolled shell/code** — last, and only when neither exists.

Skipping a covering skill because "it's a simple task" is the named failure
mode: simple things become complex, and the skill carried the gate you just
bypassed.

**CI runs a different slice than your local gate — know which before quoting
"green".** The authority is `.github/workflows/`, not this sentence: as of
2026-08-21, `test.yml` runs `rake test:critical` on PRs and full `rake test` on
push, and `publish.yml` runs `rake test:unit` + `rake test:integration` on
master before deploying. CI is Linux — a macOS-green screenshot suite says
nothing about the Linux baselines CI compares against. Re-read the workflow
files before trusting this paragraph; they change more often than this doc.

**Ruflo-first (Paul 2026-08-21).** When a ruflo plugin covers the job — memory
store/search, swarm coordination, recurring loops/cron, autonomous completion,
security scanning, test-gap/TDD, doc generation — prefer its tools, skills, and
agents over the global/generic equivalent. The generic one is the fallback, not
the default. The full routing table lives in `~/.claude/CLAUDE.md` §Ruflo-first
(host-only — in container/CI sessions the category list above is the summary to
use); project instructions still override it.

---

## Appendix C — domain reference map

Per domain: read these first, route work through these. Explicit so onboarding
costs nothing (Paul 2026-08-21). All paths repo-relative; skills by roster name.

| Domain | Read first | Route through |
|---|---|---|
| **Coding** (templates, CSS, Ruby, config) | `CLAUDE.md` critical-files table; `docs/projects/2509-css-migration/` for CSS; `ponytail` held at ultra | `hugo-expert`, `ruby-coder` + `ruby-reviewer`, `core-coder`; gates per diff type |
| **Design / visual** | `.stitch/design.md`, `docs/design-system/`, `docs/workflows/visual-scroll-gate.md`, `.okf/design/` | `impeccable` skill, `stitch` MCP (generation only), `screenshot-guardian`, `qa-browser-tester`, chrome-devtools at 1280×800 + 390×844 |
| **Content / blog / LinkedIn** | voice guide `90.11`, ICP `90.10`, `docs/workflows/blog-pipeline.md` / `linkedin-post-pipeline.md`, `.okf/content/claims-canon.md` | `content-creator`, `content-cold-eyes`, `reflexion-reflect` (BLOCKING pre-handback), banned-strings ratchet |
| **Docs / knowledge** | new-doc location rules (`CLAUDE.md`), `.okf/index.md`, `writing-documentation-with-diataxis` | `okf:okf` (consume/produce/maintain), `okf:validate`, `ruflo-docs:doc-gen` |
| **Planning** | manager-triage rule (`CLAUDE.md`), active content plan `20.09`, §1a intake | `core-planner`, `plan-writing`, `task-breakdown`; plans peer-reviewed before Paul sees them (§5) |
| **Research** | §4 order: `qmd` in-tree → `context7` docs → NotebookLM MCP for deep multi-source → web (`parallel`/`tavily`) | `core-researcher`, `Explore` (read-only fan-out); cite everything |
| **Brainstorming / shaping** | `superpowers:brainstorming` (BEFORE creative work), `structural-decisions` | persona panels with distinct lenses + required dissent (§5) |
| **Testing / QA** | `CLAUDE.md` header Test line, `docs/20-29-testing-qa/` | `core-tester`, `ruflo-testgen:testgen`, `screenshot-guardian`; behavior-focused tests only |
| **SEO / analytics** | `docs/90-99-content-strategy/`, `bin/site-report`, `bin/campaign-metrics` | `seo-specialist`, `gsc` + `google-analytics` MCP; recompute averages, never quote them |
| **AI-instructions development** (skills, agents, CLAUDE.md, prompts, OKF) | this doc; `superpowers:writing-skills`; `.claude/agents/**` for agent shape; Appendix A for the audit method | `create-skill` / `create-agent` / `create-rule` skills, `claude-md-management:*`; instruction changes are code: branch + PR, 4-eyes, and a worked-example check (break the rule, watch the gate fail) before merge |
