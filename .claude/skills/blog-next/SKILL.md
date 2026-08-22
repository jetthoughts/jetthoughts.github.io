---
name: blog-next
description: >
  Decide WHAT to write next and whether it is worth writing - by auditing the
  content plan against live search data, rebuilding the plan when it fails the
  audit, researching primary sources, and gating an outline. This is the
  find-the-topic half of the pipeline; it never writes a post. Use whenever the
  user asks what blog post to write next, for the next post, a new post, a batch
  of posts, or a blog sprint; when they point at the content-plan queue; when
  they ask to groom, restock, rebuild or sanity-check the content plan; and when
  they name a topic themselves, because the premise audit is what catches a
  decayed row or a dedup collision before anyone spends a draft.
  NOT for LinkedIn posts (use linkedin-post-jt), course chapters (see
  docs/projects/2605-tech-for-non-technical-founders/60-69-policies/),
  landing/services pages (page-cro, landing-page-optimization), or revising a
  draft that already exists - that is blog-post-coordinator's job.
---

# Blog: what to write, and whether to write it

Two halves, deliberately split. **You own "what and whether."** Drafting,
reviewing and shipping are the other half and belong to the agents below.

| Stage | Owner |
|---|---|
| A. Plan health + pick, or REBUILD the plan | **this skill** |
| B. Research | **this skill** |
| C. Outline + outline gate | **this skill** |
| Draft → 3 critics → cold-eyes → ship gates → commit | `blog-post-coordinator` |
| N-post sprint, cluster sweep, one PR, CI watch | `blog-batch-orchestrator` |

You produce one of three things, never a draft: a **topic row**, a **rebuilt
plan section**, or a **HOLD** saying the slot should not be spent.

**Read before starting; this skill does not copy them, so a correction lands
everywhere:**

- `docs/workflows/blog-pipeline.md` - canonical process. STEP 1-3 is Stages A-B.
- `.okf/workflows/analytics-access.md` - properties and every measurement trap.
  Stage A is unsafe without it.
- `docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md`
  - §13 is the live queue (§12 retired). §13a/§13d record the traps, including
  the ones that killed rows in this same file.

## Stage A - find candidates, then audit them

**Search demand cannot generate topics on this property; it can only veto them.**
Two audits in Aug 2026 falsified the queue's own lead item, and the reason was
structural: the blog earns ~0.69 named non-brand clicks/day and the ICP is
absent from the query data (`vibe*` ≈ 200 impressions / 0 clicks). A
search-driven queue here returns HOLD forever. So generate candidates from the
three sources below, then use search to kill the bad ones.

### A1 - generate candidates (do this FIRST, before touching GSC)

1. **Live trend research.** What is the audience arguing about right now? The
   HN Algolia API is free and needs no auth:
   ```
   curl -s "https://hn.algolia.com/api/v1/search?tags=story&numericFilters=created_at_i%3E<epoch>,points%3E200&hitsPerPage=50"
   ```
   (compute `<epoch>` separately - inlining `$(date ...)` in the URL mangles it).
   Then `?query=<title>` to recover each story's real URL and HN id for citation.
   **Look for a cluster, not a single story.** One hot post is noise; five
   front-page posts arguing the same thing in three weeks is a conversation the
   audience is already having, and a post that enters it has a reason to exist
   that search data can never supply.
2. **Paul's raw material**, when he supplies it - one sentence about something
   that happened is a topic ("the agents cancelled half their backlog"). Treat
   this as the highest-value source when present; he may not always have it.
3. **Our real work** - this repo and `~/dev/elital`. The 2026-08-20 batch's best
   material was a commit-documented outage. Sanitize: shapes and lessons yes;
   prompts, model IDs, proprietary numbers no.

A candidate is only worth writing when an external hook meets first-hand
evidence. A hot topic we have nothing to say about is somebody else's post.

### A2 - audit the candidates (search as veto, never as source)

1. **Pull live GSC/GA4** per `analytics-access.md`. Never query from memory of
   property IDs.
2. **Run every trap against your own numbers before quoting them** - the
   named-vs-page test (one-way: `named ≪ page` voids the page CTR; the converse
   licenses nothing), truncation, Trap C (page-level *position* is an artifact
   whenever the CTR is), Trap D (query-vs-query is the legitimate level;
   page-vs-page carries almost no signal).
3. **Are these impressions human?** Before treating volume as demand, look at the
   query strings. Combinatorial permutations of one stem, non-words, or 100+
   impressions at top-10 positions with a flat zero on clicks mean synthetic
   traffic, not demand you are failing to convert. `analytics-access.md` carries
   the tell and two worked examples.
4. **Name the post's job, then apply the matching floor.** A post is written to
   rank, or to be a credible asset for a reader who already arrived from LinkedIn
   or a conversation. These are judged differently and conflating them is how the
   queue filled with rows nobody should have written.
   - **Search-purposed:** convert to clicks/day against the blog's non-brand rate
     (§13c: 62 named non-brand clicks / 90 days ≈ 0.69/day). Compute the ceiling -
     best-case position at a defensible CTR, minus what the topic already earns,
     minus cannibalisation. **A search post whose ceiling cannot move the number
     is not a post.** Say so and stop.
   - **Arrival-purposed:** the search floor does not apply and quoting it is a
     category error. The test is whether the piece would survive a sceptical
     founder reading it after a LinkedIn click - does it say something true that
     the competition does not, backed by work we actually did. Most trend-driven
     candidates are this kind. Say which kind it is in the topic row, so nobody
     later kills a good asset with the wrong metric.
5. **Dedup** per `blog-pipeline.md` STEP 1/3b. A filename grep is not a coverage
   audit - regexes are order-dependent and miss real pages. Confirm each hit and
   check whether two of our pages already split the query.
6. **Reconcile with §13.** N1 is a downgraded hypothesis, not a win.
7. **P0 gate** (20.09 §1): if outreach is stalled, content halts. Read the plan's
   own log - Paul overrode it 2026-08-20, scoped to one post - and report the
   gate's state plus his last call rather than halting on the rule alone.

**Overriding the queue:** only on *falsifiable* grounds - a dedup collision, a
dead page, a premise the numbers contradict. Record the verdict and the number
that killed it. Ordering *preference* is Paul's: flag it, take his row.

### When the audit kills the row - rebuild, do not dead-end

If the row fails, or the queue is dry, or the survivors all fail the demand
floor, **the deliverable becomes a rebuilt plan section**, not a shrug. Write it
into 20.09 as a new dated subsection. Each candidate carries:

- the live figure it rests on, with its pull date, window and property
- which traps were run against it, and what they returned
- the demand ceiling in clicks/day and what it is being compared to
- the dedup result, naming any page that already owns the query
- a verdict: WRITE / UPGRADE / FLAG / DO-NOT-WRITE, with the reason

Record DO-NOT-WRITE rows too, with their numbers. A row nobody logged gets
re-proposed from intuition next quarter.

**When live data cannot settle it, name the cheap experiment** instead of
guessing - a date/device split, a look at the live SERP for what sits above us,
a title test with a measurable before/after. Fifteen minutes of checking beats
a spent content slot.

**Gate Stage A before quoting it.** Its output is nothing but measurements, and
CLAUDE.md requires a measurement verified before it is reported. Hand a
`core-reviewer` the raw pulls and the row you propose - goal and artifact, never
your conclusion - and ask it to re-derive. Both Aug 2026 runs had a material
error caught here and nowhere earlier.

Stage A output: a topic row (slug, angle, live figures, demand ceiling, dedup,
reviewer verdict), a rebuilt plan section, or a HOLD.

## Stage B - research primary sources

**Fetch sources; do not recall them.** Training memory is not a citation.

1. **Web search** per `blog-pipeline.md` STEP 3 - official docs, release notes,
   primary reports. This is Stage B's job; the coordinator starts at the writer
   and never re-runs research.
2. **NotebookLM** to interrogate a body of sources: `notebook_create` →
   `source_add` (`source_type: "url"`, `urls` takes a list) → `notebook_query`.
   To *find* sources: `research_start` → `research_status` →
   **`research_import`**; without the import nothing enters the notebook. Check
   `server_info` first - `stale` means ask the user to run `nlm login`;
   `unverified` means the check failed, not that credentials are bad.
3. Ask what a draft needs: what changed and when, the official position, where
   practitioners disagree, the strongest counter-argument. Not "summarize this."
4. **Mine our real code** (this repo, `~/dev/elital`) for first-hand material.
   Sanitize: shapes and lessons yes; prompts, model IDs, proprietary numbers no.
5. Verify every statistic against its source. Zero fabricated clients, stats,
   quotes or personas - `.okf/content/claims-canon.md` records "Sarah" as banned.
6. Internal links per `blog-pipeline.md` STEP 3b.

Stage B output: a sourced digest - every claim with its URL, links verified.

## Stage C - outline, then gate it

Write the outline: hook shape, H2 sequence, what the reader does differently
after each section, where internal links land, the CTA.

Apply `blog-pipeline.md`'s cut test here, where a cut costs a line instead of a
section. Pick a cadence anchor and hook shape from
`docs/workflows/blog-writer-reference-samples.md`, checked against recent
siblings so the post does not repeat an overused shape - that file and STEP 4b
own the current count.

**Gate it: author ≠ verifier.** A different agent type than whoever wrote the
outline - `core-reviewer`. Brief it with goal and artifact, never your
conclusions; ask for measurements. A panel handed your inference returns it
wearing independent confidence.

An outline that fails is rewritten before any prose exists.

## Hand off - and keep going

**Default is unattended.** A gated outline is not a place to stop and wait; hand
it straight on and let the gates decide. Paul asked for delivery without a human
in the loop (2026-08-22), and the stop list below is the whole of what he still
owns.

**One post** → `blog-post-coordinator` with the topic row, branch, dev-server
port, research digest, **the approved outline**, and `premise audited: yes`.

**Several posts** → `blog-batch-orchestrator` with N; it runs Stages A-C per row.

Session dev server, once, never 1313: `PORT=$((20000 + RANDOM % 20000)) bin/dev`.

Pass `model` explicitly on every spawn. Both agents declare `model: fable`; if a
fable spawn fails, fall back to `opus` and say you did.

Full unattended contract, including the completion promise and why it must be
about gates rather than quality: `docs/workflows/autonomous-delivery-prompt.md`
§"Running CONTENT unattended".

## Three exits, and only three

A run ends in exactly one of these. **Two exits are not enough** - a loop whose
only outcomes are "shipped" or "try again" will always ship something.

- **SHIPPED** - gates green, committed, PR open, verdicts quoted.
- **HOLD, with evidence** - a terminal success, not a failure. Every candidate
  failed its floor, or the queue is dry after rescopes. Record the numbers that
  killed each one so nobody re-proposes them from intuition next quarter. Never
  invent a topic to fill the slot; on 2026-08-22 two runs correctly ended here.
- **BLOCKED on a named decision** - one of the five below, named explicitly, with
  the conservative option already taken meanwhile where one exists.

**What genuinely needs Paul** (everything else: decide, record, continue):
whether a claimed client engagement or number is real · publishing outward ·
overriding a documented gate · pricing/naming/internal numbers · split and
irreversible calls. A figure you cannot source is not a decision for him - drop
the claim.
