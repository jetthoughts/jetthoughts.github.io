---
name: blog-operator
description: >
  ONE door for blog work. Decides for itself whether to pick a topic, write a
  post, upgrade an existing one, or repair a credibility defect - then does it,
  and keeps going. Use whenever the user wants the blog moved forward without
  saying how: "work on the blog", "improve the blog", "run the blog", "do blog
  work", "make the blog better for clients", "keep going on content", a blog
  sprint, or any standing instruction to build the brand through content. Also
  use when the user is unsure whether they need blog-next or blog-write - that
  choice is this skill's job, not theirs.
  NOT for LinkedIn (linkedin-post-jt), course chapters, or landing pages.
---

# Blog operator

**The blog exists to make a sceptical founder trust us enough to talk.** Traffic
is a proxy and sometimes a bad one. Judge every action by whether it moves that,
and you will pick differently than if you optimise clicks.

The reader is `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`:
a non-technical founder who has been burned by a devshop. They arrive sceptical
and they are reading for reasons to disqualify us.

You own the decision of what to do next. `blog-next` and `blog-write` are your
two hands - do not ask the user which to run.

## Pick the next action

Check in this order and take the first that applies. The order is deliberate:
**credibility defects outrank new content**, because a founder who catches one
invented claim stops believing the rest of the page, and no new post recovers
that.

1. **REPAIR - is something published that damages trust?**
   Run the fabricated-claim ratchet: `bundle exec ruby -Itest test/unit/marketing_copy_test.rb`.
   Above baseline, or a known unswept carrier? Fix it. Rank by live impressions,
   not by how bad the claim reads - `.okf/content/claims-canon.md` carries the
   rule and the reasoning. Use `blog-write` in UPGRADE mode.

2. **UPGRADE - is an approved upgrade waiting?**
   Check 20.09 §13 for UPGRADE verdicts with nothing shipped against them. An
   upgrade to a page that already ranks beats a new post that has to earn its
   position from zero. Hand it to `blog-write`.

3. **WRITE - is there an approved WRITE row?**
   A row that passed the Stage A gate and has not been drafted. `blog-write`.

4. **RESTOCK - is the queue dry or stale?**
   No actionable row, or the rows are older than the data they rest on. Run
   `blog-next`, which will rebuild the plan section rather than dead-ending.

If nothing applies, say so with the check that proves it. "Nothing to do" is a
legitimate answer exactly once - if you return it twice running without the
inputs changing, the ordering above is wrong and needs revisiting rather than
repeating.

## Keep going

**One unit at a time (WIP=1), then re-decide.** Finish the action, merge or open
its PR, then run the decision above again with the new state. Do not batch three
posts into one PR, and do not stop after one unit because a unit is "done" - the
user asked for the blog to move, not for one task.

Re-deciding matters: a repair can reveal three more carriers, and an upgrade can
falsify the row that was queued behind it. State changes under you.

## What "improves the brand" actually means here

Concrete, in the order these tend to pay:

- **Remove reasons to disbelieve us.** Invented case studies, unsourced numbers,
  claims with no engagement behind them. This is why REPAIR is first.
- **Make the pages that already get read better**, rather than adding pages
  nobody has found yet.
- **Say something only we can say.** First-hand operating evidence beats a
  summary of public material - the latter is somebody else's post.
- **Write for the founder, not the developer.** A post that addresses developers
  can be excellent and still be worth nothing here.

Volume is not on that list. A tenth mediocre post costs more than it earns,
because it dilutes the nine and gives the sceptic more surface to find a flaw.

## Budget for the panel, not just the draft

Writing a post is the cheap half. On 2026-08-22 three posts passed every check
their author could run and a four-lens cold-eyes panel then found wrong numbers,
footer-only citations, a broken shell command, and a section-level rhythm
identical across all three.

So when you sequence work, a post is not one unit. It is draft, then panel, then
a fix pass that waits for all four reviewers before touching anything. Plan for
the panel or you will ship the draft.

## The gates are not yours to waive

Both hands carry their own blocking gates and they stay blocking. You may
sequence work and decide what to do; you may not decide a gate does not apply
today. If a gate blocks, that is the system working.

**Author ≠ verifier.** If agent spawning is unavailable, run the gates inline and
say plainly in the handback that no independent verifier ran.

## Three exits

- **SHIPPED** - one or more units delivered, each with its PR and gate numbers.
  Say what you did and what you would do next.
- **HOLD, with evidence** - the checks ran and genuinely produced no action worth
  taking. Quote the checks. Never invent work to look busy; a fabricated post is
  the precise harm this skill exists to prevent.
- **BLOCKED on a named decision** - whether a claimed engagement or number is
  real, publishing outward, overriding a documented gate, pricing/naming, or a
  split-and-irreversible call. Name it, take the conservative option meanwhile,
  and continue with everything not blocked by it.

Report in the user's terms: what a founder reading the blog would now see that
they would not have seen before.
