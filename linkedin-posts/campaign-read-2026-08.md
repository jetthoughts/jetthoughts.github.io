---
build:
  render: never
  list: never
---

# Campaign read - Aug 2026 LinkedIn window

**Date: 2026-08-20 | Status: AWAITING DATA**

The read template for the first LinkedIn window. Nothing here is filled in yet:
agents have no LinkedIn access, so the numbers come from Paul. Once
[`metrics-ledger.md`](metrics-ledger.md) has values, a cold session can execute
this document end to end without asking a question.

Same shape as the GA4 read in
`docs/projects/2605-tech-for-non-technical-founders/50-59-execution/50.02-aug14-metrics-read.md`:
data source, findings, decisions gated by the read.

---

## 1. What Paul must paste (his step - nobody else can do it)

For **each row** in [`metrics-ledger.md`](metrics-ledger.md), open the live post
on LinkedIn, click **"View analytics"** under it, and paste these six numbers:

| # | Number | Where it is |
|---|---|---|
| 1 | **impressions** | "View analytics" → top line |
| 2 | **reactions** | reaction count under the post |
| 3 | **comments** | comment count under the post |
| 4 | **reposts** | repost count under the post |
| 5 | **profile-view delta** | Profile → "Who viewed your profile" → 7-day count, minus the count before the post week |
| 6 | **icp_replies** | read every comment and DM on the post; count only the ones in ICP symptom-language (see §2) |

Also confirm, per row, whether the post actually **published** (the ledger has
rows for `scheduled` posts whose `posted` cell is still empty).

Paste them straight into the ledger table - one row per post, same column order.
Nothing else in this document needs Paul.

## 2. What counts as an `icp_replies`

A reply counts only if it uses the ICP's own symptom language. From
`docs/workflows/linkedin-icp-validation-plan.md` § "Validation Question":

> - "I can't tell if they're making progress."
> - "Jira says everything is in progress, but I can't click anything."
> - "The repo/cloud/accounts are under their name."
> - "I asked for something simple and got an overbuilt mess."
> - "The cheap developer was fine until the product needed senior judgment."

Likes, generic praise, and agency-owner comments are not `icp_replies`.

---

## 3. Decision rules, quoted verbatim

Neither lane plan uses the phrase "kill criteria". What each plan actually
carries is a **Decision rules** list under its weekly review. Those are the
criteria this read is evaluated against, quoted here in full so nobody
re-derives them from memory.

### Rescue lane (`icp-validation/`)

Source: `docs/workflows/linkedin-icp-validation-plan.md` § "Weekly Review" →
"Decision rules":

> - If one pillar produces 50%+ of qualified comments/DMs, move the next blog post toward that pillar.
> - If a post gets high likes but no founder comments, treat it as awareness, not ICP validation.
> - If technical people argue in comments but founders stay quiet, rewrite the hook in founder pain language.
> - If a CTA gets artifact requests, turn that artifact into a lead magnet.

Same file, § "Blog Plan Feedback Loop", the 2-week clause:

> After 2 weeks:
>
> | LinkedIn Winner | Blog Plan Action |
> |---|---|
> | Friday Demo Rule wins | Prioritize `friday-demo-rule-founder-progress` |
> | Access/ownership wins | Prioritize `github-aws-database-ownership-checklist` |
> | Artifact requests beat comments | Build the requested artifact before writing another post |
> | Neither pillar wins | Run the backlog hooks for one more week before changing ICP |
>
> If none win, the ICP may still be right but LinkedIn packaging is wrong. Test founder-specific distribution next: founder groups, investor/operator comments, and direct founder outreach using the same hooks.

### Course lane (`course-promo/`)

Source: `docs/workflows/linkedin-course-promo-plan.md` § "Measurement" →
"Weekly Friday review, same table as the ICP plan. Decision rules:":

> - If Tue give-aways beat Fri pointers on course clicks, the value-first framing is working - do not add harder CTAs.
> - If a module's week underperforms across all 5 slots, the module's pain framing is off for LinkedIn - rewrite next cycle's hooks from comment language, don't skip the module.
> - If reader-result posts appear, they outrank everything in the next week's plan.

---

## 4. Verdict

**BLANK - fill only after §1 numbers are in the ledger.**

The rule, from `metrics-ledger.md` § "Kill-criteria tie-in":

> Each lane's plan has a 2-week kill criterion. Evaluate it against the `icp_replies`
> column here, not impressions. Near-zero icp_replies across a lane's posts = the
> message/segment isn't landing (revisit before spending more reach).

So: evaluate **per lane**, on `icp_replies` only. Impressions and reactions are
context, never the verdict. A lane with high impressions and near-zero
`icp_replies` fails the read - that is awareness, not validation (the rescue
plan's second decision rule says exactly this).

| Lane | Posts read | Total icp_replies | Verdict | Basis |
|---|---|---|---|---|
| course | | | | |
| rescue | | | | |

**Sample-size caveat to write down with the verdict:** the window has 3 posts
total (1 posted, 2 scheduled), split across two lanes. A lane read on one or two
posts is directional, not conclusive - say so in the verdict rather than
declaring a lane dead.

---

## 5. What to reuse

Fill after §4. Answer three questions from the ledger, then feed the answers
into the next 2-3 drafts:

1. **Which opener archetype produced `icp_replies`?** (ledger `opener` column -
   idea-led / observation-led / question-led / stat-led / conflict-led)
2. **Which lane produced `icp_replies`?** (course vs rescue - this decides where
   the next drafts go)
3. **Which topic produced `icp_replies`?** (the post's `pillar` in frontmatter)

Write the winner into each row's "what to reuse" cell in the ledger, and retire
the shapes that only earned impressions.

| Question | Answer | Next 2-3 drafts |
|---|---|---|
| Winning opener archetype | | |
| Winning lane | | |
| Winning topic / pillar | | |

---

## 6. When this read is done

- Ledger rows filled, verdict written, "what to reuse" answered.
- Verdict copied into the weekly review surface (Fri) per
  `linkedin-posts/README.md` § "Analytics tracking".
- If a lane fails, the next action is the one its own decision rules name above -
  not an ad-hoc call.
