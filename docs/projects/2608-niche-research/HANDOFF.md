# Handoff — JT positioning, copy and niche research

**Snapshot taken:** 2026-08-22
**State:** paused deliberately. Research complete, copy drafted and voted, nothing shipped.
**Resume by reading:** this file, then vault `jt-business-os.md`, then `docs/adr/0007-homepage-main-offer-and-copy.md`.

Nothing on the live site was changed. Every site-content edit attempted during this work was
reverted; one abandoned attempt sits in `git stash@{0}` ("wip-homepage-offer") and is
superseded by ADR-0007.

---

## The one correction that invalidates prior work

**"We can hire anyone, we are not limited with current devs or techs."** (Paul, 2026-08-22)

All eight research lanes were briefed with the opposite and discarded candidates on staffing
grounds. Re-read those discards before acting on any lane's shortlist. Details and the
specific re-opens are in vault `jt-business-os.md` §"Constraint removed 2026-08-22".

The second correction, same day: **JetThoughts is a software development company — senior
developers who extend existing teams and help with delivery.** Germany is Paul's personal
situation, not JT's market. Compliance advisory is not a JT service line.

---

## Where everything lives

| Artifact | Location |
|---|---|
| Decisions, bet status, ICP, killed list | vault `jt-business-os.md` |
| PKM/research architecture, the three tiers, NotebookLM practice | vault `pkm.md` |
| Homepage offer, copy, panel vote, kill list, open questions | `docs/adr/0007-homepage-main-offer-and-copy.md` |
| How to find the right copy (repeatable process) | `docs/90-99-content-strategy/90.22-finding-the-right-copy.md` |
| 16 agencies' verbatim hero copy + extracted patterns | `docs/90-99-content-strategy/competitor-copy/` |
| Eight demand-research lanes | `docs/projects/2608-niche-research/*.md` |
| Cross-lane synthesis, contradictions, briefing doc | [NotebookLM notebook](https://notebooklm.google.com/notebook/2fc12fb9-855c-444b-9ded-afd658a25c24) |
| Full copy candidates and judge verdicts | `~/.claude/plans/homepage-copy/` (machine-local, not in git) |

---

## Tracked, to handle later

### 1. Verify the Clutch quotes — use claude-in-chrome
Four quotes used during drafting have no source in this repo, and one attributed to Mobile
Coach's CEO contradicts the testimonial already in `data/testimonials.yaml` ("JetThoughts'
work is flawless. They've never failed to deliver"). They came from a model-summarised web
fetch, not a verified read, and this repo purged fabricated testimonials on 2026-08-15.

**Method decided:** open clutch.co/profile/jetthoughts with claude-in-chrome and read the
review text directly. Confirm or discard each of: the Mobile Coach "more than a contractor"
quote, the inBeat Agency "agile project management" quote, "They genuinely understood our
challenges", and "We wouldn't be where we were". Also confirm the Willing to Refer sub-score
is still 5.0 before it is used as a heading.

**Blocks:** the proof block, the testimonials section, and any copy quoting a client.

### 2. Re-open the staffing-gated discards
See the correction above. Priority order: accessibility remediation (strongest forcing party,
and two lanes already disagree about it), then AI integration work, then Django/Laravel.

### 3. Find the new ICPs — the next research task
**Question:** which buyer segments have recently appeared or grown, are actively hiring
offshore or remote expertise, and would plausibly hire JetThoughts? Demand-side, with the
bench constraint removed. This supersedes the supply-limited framing of the August lanes.

Known starting points that survived: boutique consultancies that oversold their bench; the
tier below the AI deployment organisations (Ode, OpenAI Deployment Co, AWS's $1B forward-
deployed unit, which has publicly said it hires externally); PE operating partners; funded
product teams with a senior role open two or more quarters.

### 4. The claim leaks past the homepage
The fractional-CTO title survives in six use-case page frontmatter entries
(`menu_custom.title: Fractional CTO`), in `/use-cases/emergency-cto-leadership/` body copy,
and `/pages/friday-report/` is a whole live page built on the rejected weekly report.
`home.html` L200 also contradicts the claims canon ("most clients stay over 3 years" against
a five-year average). Fixing only the homepage leaves the site arguing with itself.

### 5. Answer the ADR's open questions
Roughly fifteen, listed in ADR-0007. The three that gate the most copy: is "you own the code
after every milestone" contractual; what does a client actually see day to day; and what are
the two-week trial's real terms (unpaid / refundable / no-minimum-term produce three
different sentences, and only one of them is a trial).

---

## What is settled and should not be re-litigated

- The offer: an embedded team of senior, self-managed, full-stack developers.
- Vibe Code Rescue is killed as the thing JT sells; `/vibe-code-rescue` survives as an SEO lander.
- Migration assurance sold to MSPs is killed — verification is bundled, never bought.
- Hacker News and Upwork are dead as bidding channels; both remain useful as demand intelligence.
- The hero is stack-free; the `<title>` keeps Rails for search.
- No fractional-CTO, CTO or tech-lead title claims anywhere.
- "Weekly reports in plain English" is untrue; the practice is async-first daily updates, and
  that is a working style, never a promised cadence.
- Publish the two Clutch criticisms alongside the praise — unanimous across three judges.

## Known unknowns worth carrying

The panel split 2-1 on the hero and the split is factual, not aesthetic: two judges chose
"Progress you can click" and both dissented against it because it implies a shipping artifact
nine reviews do not evidence. Answer open question 5 and the vote resolves itself.
