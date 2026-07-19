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

If this file conflicts with a generic writing, SEO, or humanizer skill, this file wins for LinkedIn drafts.

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

### First-draft warning: don't separate the beats into paragraphs

The skeleton names 5 beats. The first-draft trap is to render each beat as its own paragraph with no connector to the prior beat. That produces a list-of-points shape that reads as outline, not story — the post will fail the read-aloud fluency test even if every individual sentence is clean.

**Fix at the writing stage:** drop in connectors at the seams as you draft. "So we hopped on a quick call." "And the thing is..." "Anyway, we agreed she'd try..." Real spoken stories don't pause for breath at every clean beat. Two paragraphs of flowing prose almost always beat 5 paragraphs of separated beats.

**The Tuesday post lesson:** an initial 6-paragraph draft (one paragraph per beat, no connectors) was rewritten to 3 paragraphs by adding `so we hopped on a quick call`, `So we agreed she'd try a different one`, and `Beats three more sprints of...` — connectors that carry the listener forward. This is a writing-stage rule, not just an editing-stage fix.

### Hook archetype rotation (Beat 1)

Beat 1 ("specific recent encounter") most naturally produces a **dialogue-led** opener — "A founder pinged me last week..." Repeating this archetype across consecutive posts is itself an AI/LinkedIn tell, regardless of how spoken each individual post sounds. Three consecutive posts opening "A founder pinged me / Got a Slack from a founder / Talked to a founder" trains both readers and AI detectors to recognize the formula.

**Before drafting, scan the last 2-3 posts in `linkedin-posts/icp-validation/` for opener archetype.** Pick a different one:

| Archetype | Example opener |
|---|---|
| Dialogue-led | `A founder pinged me last week. She couldn't say what was off.` |
| Question-led | `For founders working with an external dev team: which signal do you actually rely on?` |
| Observation-led | `I keep noticing how different the answer is depending on who you ask.` |
| Stat-led | `12 closed tickets in a sprint can still mean zero product progress.` |
| Conflict-led | `Closing a ticket and shipping a feature aren't the same thing.` |
| History-led | `Three sprints ago, the same conversation: is it on track? yes.` |

**Format-specific defaults:** polls → question-led; checklists → conflict-led or stat-led; narrative posts → rotate among the others. Don't pick dialogue-led twice in a row.

See `~/.claude/projects/-Users-pftg-dev-jetthoughts-github-io/memory/feedback_hook_bank_diversity.md` for fuller rule and origin (flagged by user 2026-05-05).

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

## Editing methodology

Once a draft exists, three techniques produced the highest-quality posts in this campaign. Apply when an initial draft scores above the 2/10 AI-feel threshold.

### 1. Sentence-by-sentence pass (preferred granularity)

Walking each sentence one at a time — analyze, present 2-3 rewrite options, pick, apply, move on — catches problems batch rewrites miss. Monday's post went from 5.5/10 to 1/10 through this method after batch rewrites had stalled at 2-3/10.

For each sentence, audit:
- Does it have a human subject?
- Does it use a banned pattern (rule of three, parallel sentence-stem, slogany flip)?
- Does it carry concrete imagery or float in abstraction?
- Does it match the conversational register of the prior sentence?
- Is its rhythm distinct from the sentences immediately before and after?

Use this method when the AI score rubric returns >2/10 and the post still needs to drop.

### 2. Story-flow fluency test (read-aloud)

After individual sentences are clean, read the post aloud and ask: *does this sound like a person sharing a story, or a list of points?*

Symptoms of list-of-points shape:
- Each beat in its own paragraph with no connector to the prior beat
- Paragraph breaks fall at clean structural joints (setup / stakes / reveal / solution / outcome)
- No "so", "and", "anyway", "honestly" anywhere in the post
- Sentence lengths within a paragraph cluster around the same word count

Fix: collapse paragraphs by adding connectors at the seams. Spoken stories don't pause for breath at every clean beat. Tuesday's rewrite collapsed 6 paragraphs to 3 by adding "so we hopped on a quick call", "So we agreed she'd try a different one", and "Beats three more sprints of..." — connectors that carry the listener forward.

### 3. Multi-critic agent review (campaign drafts + first posts)

For high-stakes posts, spawn 3-4 critics in parallel with persona-specific briefings:

| Persona | Mandate |
|---|---|
| ICP target persona | Does the right reader recognize themselves and want to engage? |
| AI slop scanner | Any banned voice-guide patterns slip through? |
| Senior copy editor | Sentence-level craft, rhythm, fluency |
| Cold-eyes critic | First-impression reader with NO session context |

**Convergent flags rule:** when 2+ critics independently flag the same sentence, treat as high-confidence fix. Single-critic flags require judgment based on which lens dominates the post's purpose.

**Cold-eyes mandate:** the cold-eyes critic is briefed to read the post once, fast, with no context. They catch what session-anchored review can't — antecedent fuzziness, lecture-tone pivots, opener-pitch-bracing. Skipping this critic loses ~30% of the high-confidence flags.

See `~/.claude/projects/.../memory/feedback_multi_critic_convergence.md` for fuller methodology.

### 4. Frontmatter-to-body consistency check

Before marking `status: scheduled`, verify:

- [ ] `cta:` field text matches the actual closing line of the post body verbatim
- [ ] `icp_test:` describes what the post actually tests
- [ ] `notes:` reflect any voice trade-offs made during editing
- [ ] No em dashes (`—`) anywhere in the post body — `-` only

This caught a real bug in Monday's draft where the `cta:` field went out of sync with the actual close after a sentence-level rewrite.

---

## Workflow checklist

When asked to write a LinkedIn post for Paul:

- [ ] Read the 4 mandatory pre-writing files
- [ ] Identify which week/day in the validation plan
- [ ] Identify which hypothesis the post tests
- [ ] Scan last 2-3 posts for opener archetype; pick a different one
- [ ] Draft against the 5-beat skeleton
- [ ] Run the 5 sentence-level tests on each line
- [ ] Apply the AI score rubric — must be ≤ 2/10
- [ ] If score >2/10: run sentence-by-sentence pass (Editing methodology §1)
- [ ] Run story-flow fluency test (read aloud, listen for connectors at seams)
- [ ] If campaign post or first in sequence: spawn multi-critic review (Editing methodology §3)
- [ ] If the user flags the same draft as "AI", "sales-y", "fluffy", or "not human" a SECOND time, spawn multi-critic review (Editing methodology §3) BEFORE iterating again. Solo revision past the second user pushback consistently misses pattern-level tells (cinematic beat-marking, omniscient framing, copywriter shape) that single-pass review keeps missing — observed on the 2026-05-11 Monday Jira-not-progress post, which needed 5 solo passes after the AI rubric scored 0/10.
- [ ] Run frontmatter-to-body consistency check (Editing methodology §4)
- [ ] No marketing CTA, no JT mention, no website link
- [ ] No "learned the hard way" framing, no credential stamps
- [ ] Save under `linkedin-posts/icp-validation/<filename>.md` with frontmatter
- [ ] Update plan status if the post is the next in sequence
