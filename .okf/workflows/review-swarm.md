---
type: Playbook
title: Two-critic review swarm
description: The proven module-review loop - a design critic (full render walk) plus a content-canon critic, followed by verified fixer waves.
tags: [swarm, review, process]
generated:
  by: claude/opus-5
  at: 2026-08-21T05:15:00Z
verified:
  - { by: claude/opus-5, at: 2026-08-21T04:52:57Z }
  # The pair below is TWO real checks whose individual times are unrecoverable
  # (e046adc54: the originals were invented, offsets not uniform). They are
  # identical on purpose - do NOT dedup them. See log 2026-08-21.
  - { by: claude/opus-5, at: 2026-08-20T23:11:35Z }
  - { by: claude/opus-5, at: 2026-08-20T23:11:35Z }
timestamp: 2026-08-21T04:52:57Z
---

# The loop

**Scope: this loop is COURSE-oriented.** Step 2's content-canon critic diffs
against the course canon and the taste pass scores against
`.stitch/course-taste-design.md`. For SITE or BLOG surfaces take the
`/impeccable critique` step and the render gate from here, and skip the course-canon
and course-taste steps - running them off-surface produces findings from rules
that do not govern the page.

1. Build the site so critics inspect fresh output.
2. Spawn a DESIGN critic (renders every page via the
   [render-verification recipe](/workflows/render-verification.md), scores
   worst-first) and a CONTENT-CANON critic (diffs numbers against the
   [course canon](/content/course-canon.md), sweeps banned patterns, checks
   links) in parallel, in the background. **The DESIGN critic runs
   `/impeccable critique` against the surface's own design source** (table below) -
   a generic critic scores taste and keeps proposing recolours the anchor text
   already ruled out.
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

**Route design review through `/impeccable critique`** (Paul, 2026-08-21) - but
**name the design source for the surface first. There are four, and the
wrong one inverts the verdict.**

| Surface | Design source | Note |
|---|---|---|
| Blog cover images | `.stitch/design.md` | "The Obsidian Engine" - **DARK**, canvas 2400x1260 |
| Site chrome and pages | [site-palette](/design/site-palette.md) | **LIGHT by DEFAULT** (ADR-0003), ruby accent. Dark by design and NOT defects: blog cover art, ONE dark proof band per page, `/services/vibe-code-rescue/` |
| Course pages | `.stitch/course-taste-design.md` | taste-scoring anchor |
| In-post SVG / Mermaid / LinkedIn exhibits | [house-visual-spec](/design/house-visual-spec.md) | hand-drawn style, 2-2.5px strokes, semantic colour (green = money ONLY), labels INSIDE shapes; social assets also per `linkedin-posts/README.md` |

**Precedence when two rows match.** A visual inside a COURSE lesson hits both
the course row and the in-post row. Use **BOTH, course first**:
`.stitch/course-taste-design.md` declares itself the single source of truth for
course in-post visuals and carries course-specific rules the house spec lacks,
while the house spec carries the stroke, semantic-colour and label rules the
course file does not repeat. Taking only one silently drops half the governing
rules - which is why this lists SOURCES rather than picking one per file type.


# Routing text drops the qualifier that made the source correct

Adding ONE routing rule on 2026-08-21 took five review rounds, and every
finding had the same shape: a line summarising a source lost the condition
that made the source true.

| What the routing line said | What the source actually says |
|---|---|
| "site pages are LIGHT" | light by DEFAULT; three surfaces are dark by design |
| "detail in review-swarm" | that loop's canon and taste steps are COURSE-scoped |
| "there are three sources" | four - in-post SVG/Mermaid/social has its own |
| "route review through stitch" | stitch has no review verb; all three skills GENERATE |

Routing text is the most-read and least-reviewed prose in a repo, and the
compression that makes it readable is exactly what makes it wrong. Two habits
follow. **Carry the qualifier into the routing line** - "LIGHT by default,
three documented exceptions" is barely longer than "LIGHT" and is the
difference between a correct review and a recolour of a deliberate dark page.
And **check the destination is executable** before making a route mandatory:
a gate an agent cannot run gets improvised, which is worse than no gate
because it reports as done.

Related, same session: a rule recorded in this bundle is not ON THE PATH.
`AGENTS.md` routes every session through `docs/workflows/flow-router.md`; a
concept nobody is routed to is read only by sessions already looking for it.
`.stitch/design.md` is the COVER project, not the site. Point stitch at it
while reviewing a light page and it will judge light chrome against dark cover
tokens and recommend the recolour ADR-0003 explicitly rules out - the exact
failure this route exists to prevent.

With the right source loaded, stitch reviews against the DESIGN SYSTEM rather
than against taste - which is what a generic critic gives you, and why generic
critics keep suggesting recolours the anchor text already ruled out. It is also the consult for a CRITICAL call that is genuinely
unclear: get its input before deciding, not instead of deciding. The
decide-don't-wait rule still holds - stitch informs the call, it does not
own it, and it is never a reason to park a decision.

It complements rather than replaces the rendered gates. Baselines and the
scroll gate check what SHIPPED; stitch checks what was INTENDED. A change can
be pixel-identical to its baseline and still wrong against the system, and a
stitch-approved design can still ship broken - both passes are needed and
neither substitutes.

Scope its output like any critic's: a punch-list of surgical fixes, not a
licence to redesign a working page.

**Why impeccable and not stitch.** Paul first named `/stitch-design`
(2026-08-21) and retracted it the same day once review established the gap:
all three stitch skills GENERATE - `stitch-design` produces screens,
`stitch-design-taste` produces a `DESIGN.md`, `stitch-loop` iterates - and the
MCP surface is create/edit/apply with no critique verb. Routed there, a review
request gets improvised or, worse, returns a generated screen nobody asked
for. **Stitch stays for GENERATION; `/impeccable critique` carries review.**

The contract is the same whichever critic runs, and every step earns its place:

1. **Render first.** Capture the page at 1280x800 AND 390x844 via the
   [render-verification recipe](/workflows/render-verification.md). A critic
   reviews an image, not a URL.
2. **Name the anchor.** State which of the four sources governs this surface
   (table above) and paste its rules in. No critic knows which system applies;
   unanchored, it scores taste and proposes recolours the source already
   ruled out.
3. **Ask for a DELTA, not an opinion.** "List where this render departs from
   these rules, each with the rule it breaks." Ask for a redesign and you get
   a redesign; ask for departures and you get a punch-list.
4. **Verify each item against the rendered output** before acting - the same
   adjudication rule as any critic here.

If a step cannot be performed, report that the gate DID NOT RUN rather than
substituting a generic design opinion. That substitution is the failure this
route exists to prevent.

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
- **Non-colliding agents can still collide with an UNMERGED BRANCH**
  (2026-08-21). Fan-out safety is normally reasoned about between agents -
  give each its own file and they cannot fight. That is necessary and not
  sufficient. On 2026-08-21 three doc-writing agents were safe against each
  other AND against PR #518, but CSS agents would not have been: #518 was
  rewriting the very bundles a blog-rebuild lane would have edited, so every
  line they wrote would have been rebased over a 194-file recolour. Before
  fanning out, check what is IN FLIGHT, not just what the agents own.
- **Brief agents with the branch state, not just the task** (2026-08-21).
  Agents dispatched into a worktree inherit whatever is checked out. Two
  correctly reported that a concept "does not exist in this worktree" because
  it lived on an unmerged branch - right observation, and only harmless
  because they flagged it instead of inventing around it. Tell an agent which
  branch it is on and what is missing there, or it will reason confidently
  from a partial tree. Do NOT switch branches under a running agent: it
  silently changes the files it is mid-read of, and nothing errors.
- **Brief critics to return MEASUREMENTS, not verdicts** (2026-08-20). Two
  consecutive reviewers on one small test each found a claim that passed
  self-review twice, and in both cases the decisive artifact was a COUNT:
  "this sweep resolves 1 distinct url, not 683" killed a test that looked
  thorough, and "0 pages were missed entirely" killed the comment written
  to describe the fix. Ask for the number that would be different if the
  claim were false. A critic who returns an opinion can be argued with; a
  critic who returns a count cannot.
- **Claims ABOUT a fix need the same scrutiny as the fix** (2026-08-20). A
  corrected defect ships with prose describing it - a comment, a concept, a
  log entry - and that prose is written at the moment of least skepticism.
  Both overstatements this session were in comments, not code, and one had
  already propagated into two `.okf/` files before review caught it. Grep
  your own explanation for numbers you did not measure.
- **A correction is an edit, and it can break what the file already held**
  (2026-08-21). Three review rounds on one docs PR found real defects every
  time, and the third round's findings were largely defects the FIRST TWO
  ROUNDS' FIXES INTRODUCED. Adding "phase status comes from git" left an older
  sentence four lines away still saying status lives in the plan doc; adding a
  corrected click figure left the superseded one earlier in the same file. The
  correcting mindset is "am I now right here", which does not look sideways at
  the invariants the document already carried. After correcting a claim, re-read
  the WHOLE file, not the paragraph.

- **Sweep a corrected metric through the canonical summaries, not just its home**
  (2026-08-21). A figure was fixed in two specs and a measurement record while
  the project README and the plan's own justification still presented the
  superseded value as current - and those are what a cold session reads FIRST.
  A number lives in more places than the document that owns it. `grep -rn` the
  old value across docs and the bundle, and treat every surviving hit as stale
  unless it is explicitly framed as retracted history.

- **Docs review converges slowly - budget more than one round** (2026-08-21).
  Three rounds returned 8, 7 and 9 findings on a documentation-only PR, and
  none were cosmetic: a residual that would have reintroduced a known
  regression, an alias inventory that would have broken live CSS, an arithmetic
  error in a measurement plan, an overstated bot multiplier. Prose has no
  compiler and no test, so the ONLY gate is a reader who checks claims against
  the tree. One clean round is the signal to stop; one round is not.

- **Descriptive claims converge fast; PRESCRIPTIVE ones fail for rounds** (2026-08-21).
  Six codex rounds on one bundle-only PR (#537) returned 13 findings, 12
  accepted. The factual content - which partial emits what, what production
  adds - was corrected ONCE, in round one (a stylesheet-link count of three that
  a parser put at two; "production only adds `.min`" that also runs
  `resources.PostProcess` and adds `integrity`), and then stood unchallenged
  through rounds two to six, while the INVENTED INSTRUMENT in the same file was
  refuted five times running and finally deleted. Not every later finding was
  about measurement - round six caught a stale round count - but every finding
  that forced a rewrite rather than a word was.

  The planning shape: budget roughly one round for what the code does, and
  several for anything you claim a check PROVES. If you are on round three of
  patching an instrument you invented, delete it and route to a method that
  already exists. Four successive
  text-search checks were each refuted in turn: literal `String#scan`
  (`'\.c-nav'` hunting a backslash), substring prefixes (`\.c-content-block`
  scoring on `.c-content-block__text`), comments and URLs (`idangero` scoring 1
  from a Swiper URL), then semantics no regex fixes.

  "X emits Y" is checkable against X. "Run Z to prove Y" smuggles in an unstated
  universal - *no other path produces this result* - and that is the falsifiable
  part. So when writing durable guidance, prefer description; if a check must be
  documented, write what it does NOT establish in the same breath. Extends
  "docs review converges slowly" above by saying WHICH sentences will converge
  slowly.

- **Round three on a home-grown instrument means DELETE it, not patch it**
  (2026-08-21). Each of the four patches above was individually correct and each
  exposed the next hole; the honest version turned out to be much shorter than
  the one being defended, and routed to a method the same file already carried.
  A patch that fixes a real finding still reads as progress, which is what makes
  this hard to stop. If the tool is invented rather than the subject, the third
  round is the signal.

- **Verify a citation against the artifact it CITES, not a copy you happen to
  have** (2026-08-21). The same finding was declined twice on #537/#538 and was
  right both times. It asked to update `generated` for current content; I
  checked "canonical OKF §5.2", found "Relative links", and declined it as
  miscited. The reviewer was reading `~/.agents/skills/okf/reference/SPEC.md`,
  where §5.2 IS "Trust: `generated` and `verified`" and states plainly that
  `generated` records how the CURRENT content was produced and `generated.at`
  marks its last meaningful change. I was reading an older v0.1 copy in a plugin
  cache that never defines the fields at all.

  Two versions of a spec on one machine, and the section numbers do not agree.
  "Not reproducible as cited" is a claim about the reviewer that needs the same
  evidence as any other - resolve the path first. The correct semantics are now
  applied: `generated` = how the current content was produced, `verified` = who
  actually REVALIDATED it (an ordinary edit is not a verification).

  The general form still holds - a fair diagnosis can carry an overclaiming
  prescription, so check the halves separately - but this was not an instance of
  it. It was an instance of checking the wrong file twice and calling it
  evidence.
