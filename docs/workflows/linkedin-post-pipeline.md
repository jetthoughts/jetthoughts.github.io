# LinkedIn Post Pipeline — Paul Keen / JetThoughts

**Purpose:** Reference for writing LinkedIn posts under Paul Keen's account (https://www.linkedin.com/in/paul-keen/) — primarily for the ICP-E validation campaign and any other founder-facing content.

**Status:** Canonical voice reference for all `linkedin-posts/**/*.md` drafts.

**Last updated:** 2026-05-09

---

## Pre-writing reads (mandatory)

1. `docs/workflows/linkedin-icp-validation-plan.md` — campaign hypotheses, content pillars, weekly plan
2. `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` — ICP-E definition, pain language, control-loss patterns
3. `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` — voice formula, banned words, anti-AI structural patterns
4. **This file** — LinkedIn-specific rules that override or extend the blog voice guide

---

## Voice rules (LinkedIn-specific)

### Author identity

All LinkedIn posts are personal — authored by Paul Keen, posted from his profile. They are **never** corporate JetThoughts marketing.

| DO | DON'T |
|---|---|
| First-person ("I", "me", "my") | "We" / corporate plural |
| Personal anecdotes ("sat with a founder last week") | Case-study framing ("a client engagement we recently completed") |
| Opinions held with conviction | Hedged consultant phrasing |
| Concrete recent examples | Generalized industry observations |
| Authority via specific recent anecdote | Authority via credential stamp ("17 years", "500+ clients") |

### Conviction rule — no credential stamps, no slogans (BLOCKING)

State convictions directly. Don't frame how Paul came to hold them, and don't punctuate them with slogany sentence flips. Authority comes from the specificity of the anecdote that follows the conviction, not from a credential stamp on the conviction itself.

**Banned framings — reject on sight:**

| ❌ Framing | Why banned |
|---|---|
| "I learned this the hard way" | False humility, contradicts Paul's track record |
| "Took me years to figure out" | Same |
| "I've been saying this for 17 years" | Credential stamp - reads as sales positioning |
| "After 17 years of watching this..." | Same |
| "I've helped 500+ companies..." | Explicit numeric credential, very sales-y |
| "Tickets move. Product doesn't." | Slogany flip - too AI / too LinkedIn-coach |
| "X is a skill. Y isn't." | Same shape - tweetable flip |
| "Reading code is a skill. Asking for a URL isn't." | Same shape |

**Replacement approach:**

- Open with the conviction as a flat sentence, no framing, no flip. ("Jira is not progress.")
- The anecdote that follows (specific number, recent timeframe, named stakeholder type) does the authority work
- For naming the pattern, use observation rather than slogan: "This shows up in almost every team I look at where the founder isn't technical" (observation), not "Tickets move. Product doesn't." (slogan)
- Trust the reader to register authority without being told

### No marketing or sales CTAs (BLOCKING)

The validation plan offers artifact CTAs ("Comment DEMO and I'll send the script"). For Paul's account, these are **disabled** — they read as lead-gen even when the artifact is genuine.

| ❌ Banned closes | ✅ Replace with |
|---|---|
| "Comment DEMO and I'll send..." | An open question to readers about their experience |
| "DM me if you want to talk" | Opinion + invitation to share theirs |
| "Book a call at [link]" | (Never — no scheduling links in post body) |
| "Check out our [JT page]" | (Never — no JT mentions, no website links) |
| Lead-magnet teasers | Direct give-away — content stays in the post |

**Engagement loop replacement:** Open with anecdote → state conviction → give the tactical content → close with a peer question that invites founders to share their own experience. Founders who self-identify in the comments are still the ICP signal — earned through conversation, not gated by an artifact.

### Voice formula

JetThoughts blog voice: 70% Walling directness + 30% Fishkin vulnerability.
**Paul's LinkedIn voice tilts further:** ~85% Walling + 15% Fishkin. Strip most vulnerability framings — Paul is not the protagonist learning a lesson; he is the operator who has watched the lesson play out hundreds of times.

---

## Anti-AI patterns (zero tolerance)

These all come from the main voice guide but get violated most often in short LinkedIn copy:

| Pattern | Example (banned) | Fix |
|---|---|---|
| Rule-of-three negative parallelism | "Not a screenshot. Not a Loom. A URL where..." | "Screenshots and Looms don't count, since both can be staged." |
| Clean parallel sentence-stems | "I've stopped asking X. I've stopped asking Y." | "Two questions that buy you nothing: X and Y." |
| Signposting / fake-precision | "Three things usually come back:" | "When teams push back, I usually hear:" |
| Slogany meta-opener | "I keep relearning this." | (Delete or replace with concrete observation) |
| Triple rhetorical questions | "Why? How? What now?" | One real question, anchored to the reader's situation |
| Impersonal fragment stacking (3+) | "No tests. Open endpoints. Corrupted data." | Add a human subject or merge into one sentence |
| Tweetable negative-positive flip | "X isn't Y. X is Z." | Use sparingly — once per post max |
| Generic LinkedIn close | "Curious to hear your thoughts!" | Specific provocation tied to the post topic |
| Em dashes | `—` | `-` (always) |
| Fake authority count | "We've seen this 50 times" | Tenure ("17 years") or specific case ("last week") |

### The five sentence-level tests

Every line of every LinkedIn post must pass:

1. **Who test:** Does the sentence have a person doing something? Pure abstract statements need a human subject within 1-2 lines.
2. **Show test:** Replace adjectives with concrete scenarios. "The team was disorganized" → "The PR queue had 14 open PRs from 4 different developers, none reviewed."
3. **Practitioner test:** Replace generalized scenarios with specific recent incidents. "Founders often..." → "Sat with one last week..."
4. **Conviction test:** Does this sound like Paul stating a 17-year-held belief, or like a content-marketing draft hedging its way to engagement?
5. **No-pitch test:** If you remove the post body, does the close still feel like the start of a sales conversation? If yes, rewrite.

---

## Post shape: story, not advice (BLOCKING)

The single biggest tell that a post is sales/marketing is its **shape**, not its words. Marketing posts follow a predictable arc: hook → anecdote → generalization → solution → objection-handling → empowerment → CTA. That shape itself reads as marketing even when every individual word is fine.

Paul's posts must be **story-shaped**, not advice-shaped:

| ❌ Advice shape (marketing) | ✅ Story shape (conversation) |
|---|---|
| Open with a tagline ("Jira is not progress.") | Open with a specific recent encounter ("Founder showed me her sprint board last week.") |
| Generalize the pattern in the middle ("This shows up in almost every team I look at...") | Stay inside the encounter, let the reader generalize |
| Lift the tactical advice into a how-to section ("What works is asking for a URL...") | Embed the tactical move inside what the founder is going to do next ("She's going to try something this Friday: ...") |
| Add an objection-handling bullet list ("- We're refactoring → ...") | Skip the objection list. If the post must address objections, fold them into one sentence inside the story |
| Close with empowerment + question ("Any non-technical founder can do this. What's your story?") | Close with a single peer question ("Anyone else been in this version of it?") |

**The shape test:** Read the post in your head. If it could appear unchanged in a "5 ways to spot a stalled dev team" newsletter, the shape is wrong. Rewrite as a recounted encounter, not as advice with a story decorating it.

### Story-shape skeleton

```
Beat 1 (1-2 lines): Specific recent encounter - concrete detail (number, day, role)
Beat 2 (1-2 lines): The reveal moment in the encounter
Beat 3 (1-2 lines): One line of opinion as observation, not slogan
Beat 4 (1-2 lines): What the person in the story is going to do next
Close (1 line):     Peer question - "anyone else been in this version of it?"
```

Length target: **120-180 words**. Story shape needs less transition scaffolding than the marketing arc, so posts run shorter.

---

## ICP-validation context

The campaign tests 5 hypotheses (see validation plan). Not every post needs to test every hypothesis. Each draft's frontmatter should declare which:

| Hypothesis | What it tests | Signal |
|---|---|---|
| H1 | Control-before-rescue beats rescue-after-disaster | Founder comments on early-warning posts |
| H2 | Concrete scripts beat opinions | Saves and reposts on tactical posts |
| H3 | Founder pain language beats technical accuracy | Founder replies to pain-language posts |
| H4 | LinkedIn reveals new ICP sub-segments | Comments from COOs, operators, investors |
| H5 | ~~Artifact CTA beats calendar CTA~~ | **Not testable on Paul's account** — disabled per voice rules |

Without H5, the validation plan loses one mechanic. The trade-off was made consciously on 2026-05-09 in favor of authentic posting.

---

## Frontmatter format

Every draft in `linkedin-posts/**/` uses this YAML header:

```yaml
---
week: 1
day: monday
author: paul-keen
voice: personal-first-person
pillar: progress-visibility
hypothesis: H1, H3
icp_test: <one-line description of what this post is testing>
cta: <description of the open-question close>
utm_campaign: icp_validation_<pillar>
utm_content: <slug-for-this-post>
status: draft | scheduled | posted
notes: |
  <free text - voice trade-offs, format choices, why patterns were broken>
---
```

---

## Save location

```
linkedin-posts/icp-validation/week{N}-{day}-{slug}.md
```

**Why outside `content/`:** The Hugo `content/social/linkedin/README.md` has frontmatter that renders as a published page. Drafts at repo root in `linkedin-posts/` stay out of the build, out of the public site, and out of search engine indexes.

**Why outside `docs/`:** Drafts are operational artifacts, not project documentation.

---

## AI score self-check

Before marking a draft as `status: scheduled`, score it 0-10 (0 = pure human, 10 = obviously AI). Target: **≤ 2/10**.

For each "high"-severity flag below, +2. For each "medium," +1.

| Flag | Severity |
|---|---|
| Rule-of-three negative parallelism | High |
| Clean parallel sentence-stems repeated 2+ times | High |
| Credential stamp ("17 years", "500+ companies", "I've shipped 100+ products") | High |
| Slogany sentence flip ("Tickets move. Product doesn't.", "X is a skill. Y isn't.") | High |
| "Learned the hard way" / "took me years" framing | High |
| Marketing-style CTA ("Comment X for Y") | High |
| Em dash anywhere in body | High |
| Signposting ("three things will...", "here's the thing") | Medium |
| Slogany meta-opener / aphoristic close | Medium |
| Tweetable negative-positive flip > 1 in post | Medium |
| 3+ consecutive impersonal fragments | Medium |
| "We've seen this 50 times" / fabricated count | Medium |

Score >2: rewrite the flagged lines and re-score.

---

## Worked example — bad → good

**Bad opener (5.5/10):**

> Jira is not progress. I keep relearning this.
>
> Sat with a founder last week. Her sprint board: 14 tickets closed.
> Standup looked great. She still couldn't click a single new thing
> on staging.
>
> I've stopped asking dev teams "is it on track?" - they'll say yes.
> I've stopped asking "when will it be ready?" - they'll say next week.
> Both are free promises.
>
> Not a screenshot. Not a Loom. A URL where I log in and use the
> feature myself.

Flags: slogany opener (M), parallel "I've stopped asking" (H), rule-of-three "Not X. Not Y. Z" (H).

**Good rewrite (2/10):**

> Jira is not progress.
>
> Sat with a founder last week. Her sprint board: 14 tickets closed.
> Standup looked great. She still couldn't click a single new thing
> on staging.
>
> This shows up in almost every team I look at where the founder
> isn't technical.
>
> Two questions that buy you nothing: "is it on track?" and "when
> will it be ready?" Both get rehearsed answers.
>
> What works is asking for a URL on staging every Friday - one you
> log in and use yourself. Screenshots and Looms don't count, since
> both can be staged.

Why it works:
- Conviction is stated flat ("Jira is not progress.") — no credential, no flip
- Authority comes from specific anecdote (14 tickets, last week, sprint board)
- Pattern is named with observation ("This shows up in almost every team I look at where the founder isn't technical"), not slogan
- Parallel structure compressed into one sentence ("Two questions that buy you nothing: X and Y")
- Rule-of-three replaced with cause-and-effect ("X and Y don't count, since [why]")

---

## Workflow checklist

When asked to write a LinkedIn post for Paul:

- [ ] Read the 4 mandatory pre-writing files
- [ ] Identify which week/day in the validation plan
- [ ] Identify which hypothesis the post tests
- [ ] Draft against the 5-beat skeleton
- [ ] Run the 5 sentence-level tests on each line
- [ ] Apply the AI score rubric — must be ≤ 2/10
- [ ] No marketing CTA, no JT mention, no website link
- [ ] No "learned the hard way" framing
- [ ] Save under `linkedin-posts/icp-validation/<filename>.md` with frontmatter
- [ ] Update plan status if the post is the next in sequence
