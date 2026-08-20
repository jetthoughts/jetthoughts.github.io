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

## 3b. GA side - ALREADY FILLED (2026-08-20, no Paul input needed)

The arrival half of this read comes from GA4, not LinkedIn, so it is filled in.
Property `328508492`, 2026-08-01 → 08-19. Only one campaign post has published
(`week1-thu-validate-before-build`, 2026-08-13,
`utm_campaign=course_promo_pre_validation`).

| Measure | Value | Read |
|---|---:|---|
| Campaign-UTM sessions | **2** | Both landed on the linked page, `.../fake-stripe-pre-sale-pieter-levels/`, arriving with `trk=public_post_comment-text` - i.e. via the first-comment link exactly as designed. The mechanism works. |
| Engaged sessions | **1** of 2 | Engagement rate 0.50 |
| Pages per session | **1.0** | Nobody moved past the landing page into the course |
| Avg session duration | **0s** | Clicks, not reads |
| Other LinkedIn traffic | 5 sessions / 1 user, `linkedin.com` referral, no campaign UTM | Baseline profile/bio traffic - correctly excluded from the campaign count |

**What this says:** the click-through path is wired correctly and people do click
the first-comment link. What it has not yet produced is a single engaged read.
n=1 post, so this is a mechanism check, not a verdict on the message.

**Course funnel, same window** (was `start_course`=1 and glossary=0 at the Aug-14
read): `course_checkpoint_reveal` 4, `course_start_course` 3, `course_branch_click`
2, `course_glossary_click` 1. Marginal movement, still near-floor.

`contact_cta_click` does not appear yet - it shipped 2026-08-20, after this
window. First data expected in the next read.

---

## 4. Verdict

**BLANK for the LinkedIn half - fill only after §1 numbers are in the ledger.**

The rule now lives in
[`docs/workflows/linkedin-icp-validation-plan.md`](../docs/workflows/linkedin-icp-validation-plan.md)
§ "Kill criterion" (written 2026-08-20; before that date neither lane plan had
one, despite the ledger claiming both did). Evaluate **per lane at 10 filled
rows**, on `icp_replies`, never impressions - and remember that a row with empty
metric cells does not count toward the ten.

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
