# Architecture Decision Record: The homepage sells one offer - an embedded team you do not manage

**ADR-0007**
**Date:** 2026-08-21
**Status:** Proposed — paused 2026-08-22, resume via `docs/projects/2608-niche-research/HANDOFF.md`

> **Two corrections landed after this ADR was drafted and change parts of it.**
> (1) JetThoughts can hire anyone and is not limited to the current bench, so any reasoning
> here that turns on "the bench already writes it" or "we cannot staff that" needs re-reading.
> (2) The ICP is a startup that cannot afford more than one or two developers and whose founder
> has little management skill — not the burned non-technical founder of ICP-E, which came from
> the killed rescue campaign. The copy below is still written for ICP-E in places and needs
> re-pointing. The Clutch quotes used in drafting are unverified pending a browser read.
**Supersedes:** the rescue-led homepage positioning shipped with the Vibe Code Rescue campaign
**Related:** vault `jt-business-os.md` (owns the offer decision), ADR-0006 (the `/next/` rail this copy will eventually ship through)

## Title

Replace the rescue-led homepage with a single offer - an embedded team of senior,
self-managed, full-stack developers - stated in stack-agnostic language, proven by
process transparency rather than adjectives.

## Context

### The homepage is selling a bet that was killed

The live hero reads *"Your dev shop stopped delivering. We rescue and stabilize."* Vibe
Code Rescue was killed as the thing JetThoughts sells on 2026-08-20 (vault
`jt-vibe-code-rescue.md`): a competitor runs the identical motion under the same name at a
third of the price, the market band is $500-5,000 against our $2,500-10,000, the free audit
wedge is no longer scarce, and the ICP's stack is not one this bench can staff. The
homepage has been advertising that bet ever since.

### Which offer replaces it, and why

Selection ran as a four-judge panel with mandatory dissent (forcing-function economics,
conversion history, channel realism, cold-eyes positioning) over the vault strategy notes
and this repo. It returned 3-1 for the embedded senior team.

The deciding evidence is conversion history: **placed senior people are the only thing
JetThoughts has ever sold.** Crosslake ($12k/mo, four years, still running) and
Framework.fm ($6.4k/mo) are both that motion. Every canon proof point - since 2008, ~95%
retention, five-year average client relationship, 8+ years average developer experience -
is evidence for exactly this claim and for no other candidate. Migration assurance scored
highest on forcing-function economics but sits at validation stage 1 of 5 with zero
customer contact, and its buyer (MSPs) does not arrive on this site.

Two corrections from Paul shaped the wording:

1. **No fractional-CTO, CTO or tech-lead title claims anywhere.** He has never been hired
   as a fractional CTO. At Crosslake he was the lead tech, a PM opened the engagement, and
   leadership was promoted from inside the team. Three current homepage FAQs, one use-case
   tile and one service card break this rule today.
2. **The differentiator is the team, not a lead.** Senior, self-managed, full-stack
   developers who drive the development while the client runs the rest of the business.

### Stack-agnostic positioning against Rails search equity

JetThoughts is stack-agnostic in principle (vault: "any stack, with the firm signing for
the outcome") while every piece of the site's organic footprint is Rails. The competitor
survey resolves this: **the senior consultancies are all stack-free in the hero** -
thoughtbot is as Rails-famous as any firm alive and its homepage never names a stack, and
the same holds for Test Double, 8th Light, Bitovi and Evil Martians. Stack-bound heroes
belong to smaller shops competing on specialisation (Visuality, Arkency, WideFix, Tighten).

Planet Argon solves the tension in one line: *"Often Ruby on Rails. Almost never a
rewrite."* Stack as tendency, not fence.

In this theme the H1 comes from the `headline` param while `<title>` is built separately,
so the two can differ by design - stack-free H1, Rails-rich title tag, no search equity
lost.

### What the research says about the copy itself

**Competitor survey** (16 agencies captured verbatim in
`docs/90-99-content-strategy/competitor-copy/`): headlines run 3-8 words, median 6; the
headline states a belief or capability while the mechanism goes in the subhead; subheads
carry who-it-is-for plus one number; boutiques win on voice where big shops go generic;
and nobody sells their communication model in the hero, which leaves it open as proof.

**Buyer research (2026):** process transparency is now a primary buying criterion. Buyers
want "visibility into the people, processes and evidence behind the promise", and 87% say
they are more likely to buy from a transparent vendor than a cheaper black-box competitor.
Seniority claims are undifferentiated across the whole field - every competitor says
"senior", "elite" or "world-class" - so only a number or a named mechanism makes one real.
47% of senior B2B buyers now begin vendor research with an AI assistant, which raises the
value of FAQ answers that stand alone when quoted.

**Conversion research (2026):** CTAs must promise a specific next step rather than general
contact; first-person benefit-led CTA copy outperforms generic by roughly 90%; a bare
"Contact Us" now reads as a high-pressure trap. The governing rule is to match the CTA to
visitor intent stage - direct call for high intent, low-commitment value exchange for
awareness traffic. Optimal B2B form length is 3-5 fields; past seven, average abandonment
is 67.8%.

**Customer language** (ICP research, previously unused in copy): founders say "progress",
"working product", "click through it", "know what's happening", "runway", "control". Their
words: *"They say it's refactoring, Docker, architecture - I don't know if that means
progress or excuses."* · *"Jira says everything is in progress, but I still can't click
through a working product."* · *"I own the company, but they control the repo, cloud,
timeline, and technical truth."* · *"If I ask basic questions, they'll know I don't
understand the tech."*

### Claims discipline

Two claims in current copy were found to be untrue or unverified and are removed:

- **"Weekly reports in plain English" and the Friday report section** - rejected by Paul as
  "not true and not relevant". The real practice is async-first communication, meaning
  updates every day.
- **"48-hour start" and "you own the code after every milestone"** - present in live copy,
  absent from `.okf/content/claims-canon.md`. Treated as unverified pending confirmation.
  Paul's note, 2026-08-21: the team embeds and works in the client's own environment, so
  the code is never hidden from them. That answers the substance of the ownership question
  and should be written into the claims canon in a form the copy can then use.

### What nine Clutch reviews actually say

The review corpus was the last source consulted and turned out to be the strongest. It is
public, dated, uneditable, and it is the only place a claim about JetThoughts has already
been made by someone who paid for the work.

Profile: **4.8/5 from 9 verified reviews. Quality 4.9 · Schedule 4.9 · Cost 4.7 · Willing
to Refer 5.0.**

The decisive line, from an advertising-company client:

> "They are incredibly reliable, **managing development and QAing themselves** to produce
> high-quality, bug-free results."

A client described the self-managed-team positioning before we wrote it. Two further
reviews corroborate the visibility half from opposite ends of the technical spectrum - a
Director of Engineering at PubNative ("we knew exactly what was happening and where we were
going the whole time") and a non-technical CEO at OrchestrateCS ("straightforward and
understandable the whole way through"). A technical and a non-technical buyer independently
reporting the same experience is stronger evidence than either quote alone.

**What the reviews do not support, and therefore what the copy must not claim:**

| Not supported | Consequence |
|---|---|
| Any reporting artifact - no reviewer mentions a report, document, dashboard or cadence | Independent corroboration for killing the Friday report |
| The stack as a reason to hire us - not one reviewer praises Rails or any framework | Independent support for the stack-free hero |
| Rescue work - the corpus is steady delivery on ongoing products, not burning codebases | Rescue framing would be sourced from our sales deck, not from clients |
| Speed or start time - one "moved quickly", schedule sub-score 4.9 | Supports "we hit dates", not "we are fast". No start-time claim exists at all |
| Cost or value for money - 4.7, our weakest sub-score | Do not raise price on the page |
| "Bug-free" as our own claim | Safe only inside quotation marks, as that client's experience |

Two criticisms sit on the same public profile: an EVP at Corsis wrote that Paul "has very
strong opinions and could benefit from a bit more diplomacy", and PubNative wanted more
data engineers and DevOps people than the bench held. Surfacing them alongside the praise
is recommended - a page of unbroken praise reads as curated, and publishing the diplomacy
complaint costs nothing while buying credibility for everything around it.

### How this copy was produced

The repeatable process is written up as `90.22-finding-the-right-copy.md`: settle the offer
first, assemble four sources (claims canon, Clutch reviews, ICP research, competitor swipe
file), generate independently from three lenses rather than polishing one draft, score
against a rubric with required dissent, run the mechanical gates, and record what is still
unknown instead of guessing it. That document also lists the failure modes this rewrite hit
- inherited claims, the newest input welded into every variant, a working style promoted to
a promise, mechanism in the headline, and a claim fixed on one page while it lives on five
others.

## Decision

**1. The homepage sells one offer:** an embedded team of senior, self-managed, full-stack
developers who drive the development while the client runs the rest of the business.

**2. The hero is stack-free** (option B of five drafted against competitor structures):

> **We are the dev team you don't manage.**
>
> Senior full-stack engineers who plan their own work and tell you what changed as it
> happens, so you always know what shipped without reading code. 8+ years each, since 2008.

The `<title>` tag keeps "Senior Ruby on Rails & React Development Team | JetThoughts", and
a stack line lower on the page states Rails as the home stack rather than the boundary.

**3. Title claims are removed sitewide on the homepage.** No fractional CTO, no CTO, no
tech lead, no "Emergency CTO Leadership". Affected: two service cards, one use-case tile,
three FAQs.

**4. The Friday report section becomes an async-first section.** The show-don't-tell
sample-artifact format is kept because it is the most concrete proof on the page and
process transparency is a primary buying criterion; the weekly ritual it depicts is
replaced by how the team actually works.

**5. The primary CTA changes** from "Get a Free Code Audit" to a specific,
duration-and-outcome-bearing invitation to talk to a senior developer. The free code audit
survives as the secondary, intent-matched CTA for awareness traffic arriving from the blog
and the `/vibe-code-rescue` lander.

**6. `/vibe-code-rescue` stays live as an SEO lander.** Only the homepage stops leading
with rescue. Project rescue remains a legitimate secondary path in the services and
use-case copy.

**7. Migration assurance stays off the site** until its r/msp test converts. The standing
no-go against a site overhaul while a bet is unvalidated applies to it, not to this change:
this change removes a *killed* bet's copy rather than promoting an unvalidated one.

## Section copy

Drafted section by section against the constraints above by four independent passes. Full
ready-to-paste copy lives in `~/.claude/plans/homepage-copy/` (`services.md`,
`working-model.md`, `usecases-faq.md`, `conversion.md`). Decisions below.

### Services

Section H2 becomes "Ways to work with us" - the current one ("Ruby on Rails and React, done
by specialists") fences the offer to two technologies three lines above the section that
proves we are not fenced. The intro opens on the buyer's problem rather than our catalogue,
per the page-flow research.

Six cards, every URL unchanged so no search history is lost:

| Position | Title | Replaces |
|---|---|---|
| 1 | Embedded Dev Team | Outsourced Developer Staffing |
| 2 | App and Web Development | unchanged |
| 3 | Technical Second Opinion | Fractional CTO |
| 4 | Testing and QA | Software QA & CAT (garbled name) |
| 5 | Project Rescue | Emergency CTO Leadership |
| 6 | Hiring and Training Developers | Talent Recruiting and Training |

**"Fractional Product Management" is cut from the homepage.** It contradicts the hero: the
flagship card says engineers plan their own work, while that card says your developers need
a product lead to write specs so they stop guessing. Both cannot be true on one screen, and
that contradiction is exactly what a burned founder is scanning for. The page stays for
search; the card goes.

**Descriptive card names beat productized ones here.** reinteractive (CodeCare, OpsCare) and
8th Light (Production Autonomy) productize successfully because their buyer is technical
enough to decode a brand name. Ours is the founder who says *"they say it's refactoring,
Docker, architecture - I don't know if that means progress or excuses."* A card called
"CodeCare" asks that reader to decode one more thing.

The word "senior" appears on exactly one card, where the person is the product and a price
makes it real. Every other card names a mechanism instead, because the survey found all 16
competitors claiming seniority.

### Working model

The Friday-report section becomes **"How we work / We write it down as it happens"**, and
the sample artifact changes from a weekly email to **a day of channel messages** with times
and names. Shipped, blocked and next survive as three real messages rather than three
labelled rows, so the section shows the working model without promising a cadence. A note
under the card makes the absence of a schedule explicit: *"That is the shape, not a form we
fill in on a schedule. Some days there are five messages, some days one."*

"Why us" drops from four blocks to four rewritten ones, headed **"Who you are actually
hiring"** and introduced by the sentence that carries the whole offer: **"You own the
business decisions. We own the technical ones."** Cut: "We Are Reliable" and "We Simplify
Costs" (both label virtues the async section now demonstrates) and "We Prioritize You"
(unsourced). Added: a block stating the decision boundary, and a Planet-Argon-style stack
block ("Often Ruby on Rails").

Stats band becomes **8+ years per developer · 5+ years the average client stays · 95% of
clients stay**. Retention and tenure are the only numbers that argue a team can run itself.
"4+ Years is Our Average Developer Turnover" is dropped: not in the canon, and "turnover" is
a rate, so "4+ years of turnover" is wrong even when the underlying tenure is right.

### Use cases and FAQs

Tiles move to buyer-situation language ("When your lead developer leaves") under the heading
**"When founders call us"**. Two current tiles are merged - "Support an Existing Engineering
Team" and "Accelerate Development & Maximize Capacity" are the same offer written twice and
close on nearly the same sentence. A new tile, *"When you are the one running the
developers"*, becomes the default open tab, displacing salvage - which currently puts rescue
framing in front of every visitor on page load.

FAQ set keeps eight questions and every phrasing that carries search value. Two are
replaced because they cannot be answered without a banned title claim or an unsourced
price: the fractional-CTO cost comparison becomes **"Who manages the developers if I am not
technical?"**, and the CTO-consulting question becomes **"How do I know what my developers
are actually working on?"**. The emergency-CTO question keeps its phrasing (it matches how
people search that moment) and refuses the title in its first sentence: *"We do not take the
CTO title."*

Answers are written to stand alone when quoted out of context, because 47% of senior B2B
buyers now start vendor research with an AI assistant.

**A ninth question is drafted but deliberately blank: "What happens if it does not work
out?"** It is the objection every burned founder holds and no competitor answers, and it
cannot be written without the real notice period and what happens to repo access, cloud
accounts and the code on the way out.

### Conversion path

**One ask, three placements.** The homepage currently makes three different asks with three
destinations and three mental models of what happens next: a code audit (hero), a strategy
session with "an expert" (mid-page), and generic contact (final). All three become **"Talk
to a senior developer"** pointing at `/free-consultation/`. `/contact-us/` is dropped as the
final CTA destination - the same intent split across two URLs splits the conversion data and
hands the visitor a decision they should not have to make. It stays reachable from nav and
footer.

**"One of our experts" does not survive.** A senior developer is a job; an expert is a
compliment we paid ourselves, and the competitor survey found seniority adjectives
undifferentiated across the entire field.

**The free code audit is kept, demoted, and removed from the homepage entirely.** It is a
good offer aimed at the wrong moment: it asks for a repository, which sorts for "has broken
code", while the homepage buyer is sorted into "wants a team" and often has nothing built.
It survives on the two surfaces that already carry qualified broken-code traffic - the blog
CTA band (whose heading already asks "Reading this because something is going wrong?") and
`/services/vibe-code-rescue/`. Both point at the same `/free-consultation/` page, which
leads with the call and names the audit as the alternative on the way in. No second page, no
second form, no new URL: the audit becomes a choice inside the front door rather than a
competing front door.

**Hero microcopy carries the offer's real friction remover:** *"Thirty minutes with one of
the developers who would be on your project. You do not need a codebase or a written spec to
book it."* The second sentence exists because the ICP's stated fear is *"If I ask basic
questions, they'll know I don't understand the tech"* - the ask has to say out loud that
arriving unprepared is allowed. It also removes the audit's disqualifier, which is precisely
why the audit could never be the hero ask.

**Proof framing is corrected to what the canon supports.** The testimonials heading loses
"Most clients stay over 3 years. Some stayed beyond 6." (neither number is in the canon) for
the five-year average, and states the proof inventory honestly: one named client note plus a
public 4.8/5 from nine verified reviews. The clients section drops "CASE STUDIES" from its
eyebrow, because the canon records that there is no publishable completed case study and
that synthetic proof was purged - the three items rendering there are client blurbs, and
calling them what they are costs nothing and cannot be wrong.

### The two-week trial (added 2026-08-21)

JetThoughts offers a **two-week no-obligation trial**. This appears nowhere in the repo, the
vault, or the claims canon - it surfaced in conversation - so it must enter the canon before
any surface states it.

**Why it matters more than any other line on the page.** Conversion research is blunt about
this: the primary barrier is fear of regret rather than price, and risk perception scales
with ticket size. A burned founder's whole objection is "what if this is the second disaster",
and a trial answers it structurally rather than rhetorically. It also fills the FAQ this ADR
deliberately left blank - *"What happens if it does not work out?"* - which was flagged as
the objection every burned founder holds and no competitor on our list answers.

**How Toptal sells it** (the model Paul named, captured verbatim 2026-08-21):

> "No-Risk Trial, Pay Only If Satisfied"
>
> "If you're completely satisfied with the results, we'll bill you for the time and continue
> the engagement for as long as you'd like. If you're not completely satisfied, you won't be
> billed."
>
> "Work with your new team member on a trial basis (pay only if satisfied), ensuring you hire
> the right people for the job."
>
> "Our highly selective process leads to a 98% trial-to-hire success rate."

Three things they do that we should copy:

1. **The offer name states the terms.** "No-Risk Trial, Pay Only If Satisfied" is the name
   and the contract in six words. No adjectives.
2. **The mechanic is a two-branch conditional with no weasel words.** Satisfied, we bill;
   not satisfied, you are not billed. Any hedging in that sentence destroys the whole device.
3. **It is paired with a success statistic, which reframes the trial as evidence of vetting
   rather than desperation.** Toptal uses a 98% trial-to-hire rate; JetThoughts has the
   canon equivalents - ~95% retention and a five-year average relationship. The research is
   explicit that a success metric ("97% of customers stay") persuades harder than the
   guarantee alone, because it signals that most people succeed rather than that we expect
   to fail.

**Placement.** Recommended: a dedicated risk-reversal block immediately before the final
CTA, plus the FAQ answer, plus one clause on the flagship service card. Not the hero. The
hero's job is the positioning claim, and the competitor survey found that premium
consultancies never put an offer or terms in the hero - only the marketplaces do, and Toptal
is a marketplace competing on volume.

**The honest counter-argument, for Paul to settle:** if the primary barrier really is fear of
regret, then leading with the trial could out-convert leading with positioning, and the
biggest player in this exact category does surface it prominently. The case against is that
de-risking up front can read as an admission - a firm that has to guarantee its way in
invites the question of why. This is worth an A/B test rather than an argument, once the
page ships.

**Copy is blocked on the actual terms**, which nobody has written down. The wording differs
completely depending on which of these is true, and guessing would repeat the exact failure
mode this ADR was written to stop:

| If the terms are | The line is |
|---|---|
| Unpaid - JT works two weeks and bills nothing unless the client continues | "Two weeks, unpaid. If you do not want to carry on, you owe us nothing." Strongest form, matches Toptal |
| Paid but refundable | "Two weeks. If it is not working, we refund it." Second strongest, and safe to say |
| Paid, no refund, but no commitment to continue | "Two weeks, then you decide whether to carry on. No notice period, no minimum term." This is a cancellation policy, not a trial - and calling it a trial would be the overclaim |

Until Paul confirms which, no surface states it.

## The copy panel: nine candidates, three judges, a split vote

Three lenses each drafted a full candidate set (`candidates-clutch.md`,
`candidates-structure.md`, `candidates-buyerfear.md`), then three judges scored all nine
heroes with a required dissent (`vote-truth.md`, `vote-buyer.md`, `vote-diff.md`). All six
files are in `~/.claude/plans/homepage-copy/`.

**The vote split 2-1, and the split is the finding.**

| Judge | Winning hero | Its own dissent |
|---|---|---|
| Buyer (cold read) | "Progress you can click" + trial subhead | It is a cadence promise wearing a metaphor |
| Craft (differentiation) | Same | Most ownable line in the set, least evidenced; also names no category |
| Truth (defensibility) | "When nobody manages developers, seniority does." | Wins on sourcing, loses on readability |

The two judges who picked the same headline **both argued against it for the same reason** -
it implies a shipping artifact exists at all times, which nine Clutch reviews do not
evidence, and which is structurally the same defect as the Friday report. The truth judge
scored it 2/5 for exactly that. Meanwhile the buyer judge scored the truth judge's winner
2/5: *"I read it twice and I still had to work out what the verb was doing."*

**So the panel is not split on taste. It is blocked on two facts.** Answer open question 5
(what artifact does a client actually see day to day) and question 14 (the trial's real
terms), and the ranking resolves itself:

- If a client reliably has something openable within two weeks, "Progress you can click"
  becomes defensible and wins on all three lenses.
- If not, the honest hero is the truth judge's, and clicking moves to the FAQ where it can
  be explained rather than promised.

### Provenance failure, and the rule it confirms

The truth judge traced every quote and found **four with no source in the repository**,
including one attributed to the CEO of Mobile Coach whose actual recorded testimonial reads
completely differently ("JetThoughts' work is flawless. They've never failed to deliver").

Those four quotes entered this process through a web fetch of the Clutch profile summarised
by a model, not through a verified read. They may well be real and sitting on the live
profile. But this repo purged four fabricated testimonials six days ago, and the rule that
came out of that incident is unambiguous: *if you cannot point at the review, it does not
ship.* None of the four is used in any recommended block below. **Anything quoted from
Clutch must be confirmed by a human opening the profile.**

Traceable and therefore usable: both Bruno Wozniak / PubNative quotes
(`data/testimonials.yaml`, Clutch-verified 2019-11-26), "managing development and QAing
themselves", "straightforward and understandable the whole way through" (OrchestrateCS),
"moved quickly", the Corsis and PubNative criticisms, and the four sub-scores.

### The blocks all three judges agree on

**Proof block - publish the criticisms.** Unanimous, and the craft judge calls it the only
uncopyable move available: no agency in the sixteen-firm corpus prints a complaint about
itself, and a competitor cannot fake one. Heading: **"Nine reviews, including the
complaints."** Cut the unverified quotes; keep the two sourced criticisms and the two
sourced PubNative quotes. Also cut *"The lowest score we carry is cost, at 4.7, and we are
fine with that one"* - likeable, but it raises price on a page that should not, and invites
the one comparison JetThoughts loses.

**Flagship service card:**

> **An embedded team that drives**
>
> Senior full-stack developers who work inside your product and set their own order of work,
> so development moves while you run the rest of the business. Ruby on Rails is where we are
> most at home, not where we stop.

"Work inside your product" is Paul's own statement, and it is the honest replacement for the
unverified "you own the code after every milestone" - it answers the same fear with a fact
rather than a contract clause nobody has located. The stack line is Planet Argon's device
done safely: a tendency that promises nothing, where the rejected variant ("whatever else
your product already runs on") converted the same idea into a commitment the bench cannot
staff.

**Risk-reversal block - the `[TERMS]` slot.** The only treatment of the trial that is
shippable the hour Paul answers and unshippable until he does:

> Start with two weeks of real work on your actual codebase, not a sample project.
>
> If the team is working, you keep them and the engagement continues from where the work
> stands. If the team is not working, you stop at the end of the two weeks, `[TERMS]`.
>
> About 95% of our clients stay, and the average relationship runs five years.

| If the trial is | Fill `[TERMS]` with |
|---|---|
| Unpaid | "and you owe nothing for the two weeks" |
| Refundable | "and we refund the two weeks in full" |
| No minimum term | "and there is no notice period and nothing further to pay" |

Two candidate blocks asserted "no obligation" outright, which is the strongest of the three
readings; one claimed to be terms-agnostic and then asserted no-minimum-term in its own
body. Neither ships.

**FAQ - "Who manages the developers if I am not technical?"** Concede the objection before
answering it, then answer with two clients rather than an argument:

> They do. That is the part worth being careful about, because a team that manages itself
> with nothing coming back to you is exactly the arrangement that failed you last time.
>
> One client described what that looks like in practice on Clutch: we handle "development
> and QAing" ourselves, which means code review, testing and the call about what to build
> next week all happen inside the team. Your job is to say what the business needs and to
> push back when the answer looks wrong.
>
> You will still know where things stand. A Director of Engineering at PubNative, who could
> have checked our work himself, wrote that "we knew exactly what was happening and where we
> were going the whole time." A CEO at OrchestrateCS described the same experience as
> "straightforward and understandable the whole way through."

A technical and a non-technical reader independently reporting the same visibility is
evidence of a property of the team rather than of one good quarter.

### Kill list

Never ship as written: "no obligation" anywhere · "You are not signing up for anything past
those two weeks" · the four unverified Clutch quotes · "join your standups" (contradicts the
async-first practice and answers a blocked question) · "whatever else your product already
runs on" (unbounded stack promise) · "About 95% of them stay" where "them" grammatically
means the nine reviewers · "Hire-and-forget is how the last team spent four months building
the wrong thing" (fabricated fact about a specific reader's history).

## The claim leaks past the homepage

Three of the four drafting passes independently found the killed and unverified claims
living outside the page this ADR covers. Fixing the homepage alone would leave the site
arguing with itself:

1. **The fractional-CTO title claim is repeated six times in site navigation.** All six
   use-case pages carry `menu_custom.title: Fractional CTO` with the description "Get
   on-demand access to a CTO to help guide your technical vision". This is independent of
   anything on the homepage.
2. **`/pages/friday-report/` is a whole live page** built on the rejected weekly report
   ("The Friday report you get every week"), and the services intro sells "weekly reports in
   plain English" as a service attribute at `home.html` L325-327.
3. **`/use-cases/emergency-cto-leadership/` body text ends** "With access to a fractional
   CTO, you can maintain best practices ... at a fraction of the cost of a full-time CTO."
   Renaming the tile without fixing the page moves the claim one click away rather than
   removing it.
4. **The homepage contradicts the claims canon above the fold**: `home.html` L200 says "most
   clients stay over 3 years" while the canon and the stats band say five. One of the two
   numbers is wrong.
5. **Unverified claims currently shipping**: "48-hour start" and "you own the code after
   every milestone" (hero `description` and `excerpt`), "8-12 weeks" MVP timeline (two
   FAQs plus an invented week-by-week phase plan), "$5K-15K/month", "4+ years average
   developer turnover".

## Open questions blocking implementation

| # | Question | Blocks |
|---|---|---|
| 1 | Is "you own the code after every milestone" backed by a contract clause? | The strongest available answer to the "they control the repo" fear. If real, it belongs in the claims canon |
| 2 | What is the real time from signature to a developer in the repo? | Replaces "48-hour start" |
| 3 | Is "$5K-$15K/month" still right for a review service priced without the CTO framing? | Card 3 |
| 4 | Has JT shipped in Django, Laravel, Next.js, Vue and Node, or is it Rails plus two? | The stack-agnostic claim's honesty |
| 5 | What is the actual artifact a client sees day to day - Slack thread, PR list, demo link? | The flagship card names an outcome without its mechanism |
| 6 | Is "there is no standing call" true across all engagements? | The async section's lede |
| 7 | Notice period and exit handover terms | The ninth FAQ |
| 8 | Does JT sell QA standalone to non-clients, or only attached to a dev engagement? | Whether card 4 exists at all |
| 9 | How long is the call, really? "Thirty minutes" appears nowhere in the repo - the 45 minutes on the current page belongs to the audit, and moving that number across would be a quiet transfer of a claim | Hero microcopy, the lede, the list panel |
| 10 | Does the call actually go to a developer who would be on the project? | The line is load-bearing in three places and worth saying only if true |
| 11 | Will JT take idea-stage calls with no codebase? | "You do not need a codebase or a written spec to book it" |
| 12 | Is the Clutch "Willing to Refer" sub-score still 5.0 on the live profile? | Using it as the mid-page heading |
| 13 | Does `/free-consultation/` earn impressions on audit keywords? Pull GSC before dropping "code audit" from its title | The destination page's title |
| 14 | **What exactly are the two-week trial's terms - unpaid, refundable, or simply no minimum term?** The three cases produce three different sentences and only one of them is a trial | The risk-reversal block, the ninth FAQ, the flagship card, and possibly the hero |
| 15 | Has anyone ever taken the trial, and did they continue? A trial-to-hire figure would pair with it the way Toptal's 98% does | Whether the block leads with a statistic or with the terms alone |

## Implementation notes

- The stats band **hardcodes `+` after every value** (`home.html` L253), so 95% cannot
  render. Add a `suffix` field to the `overview` entries in `content/_index.md` and read it
  in the template - a two-line change. Without it, the honest fallback is to ship two stats
  and drop retention rather than print "95+%".
- Four "Why us" icons need remapping: `homepage_reliable` and `homepage_simplify_costs` no
  longer describe their blocks.
- Every service card and use-case tile keeps its existing URL, so the rename is a copy diff
  with no redirects and no lost search history.
- Tile 1 ("When you are the one running the developers") has no destination page yet. Its
  CTA has nowhere honest to point until one exists.

## Consequences

**Wanted.** The page stops advertising a killed bet. Every claim traces to the claims canon
or to a verified statement from Paul. The promise stops depending on Paul's own hours,
which is what capped the rescue product at roughly four clients. Stack-free positioning
matches where the firm is going without surrendering Rails search equity.

**Costs and risks.**

- **The claim is now broader than the bench.** Stack-agnostic copy is honest about intent,
  but every case study is Rails and the vault records all five contractors as senior Rails
  with no JavaScript specialists. A prospect asking about a Django app routes to the
  supplier group, not to JT's own people.
- **Two system tests assert the homepage headline verbatim** (`desktop_site_test.rb:17`,
  `mobile_site_test.rb:14`) and three screenshot baselines will need re-approval.
- **Naming the bench is still unmet.** 2026 buyer research says technical buyers trust
  named practitioners over brand content, and the vault flags the roster's "Dev 3 / Dev 4 /
  Dev 5" placeholders as a prerequisite for selling anything. This ADR does not fix it.
- **The site has never originated a deal.** Its measured job is passing the diligence check
  for warm and referral leads. This change should be judged on whether it stops repelling
  them, not on inbound volume.

## Alternatives considered

| Alternative | Why not |
|---|---|
| Migration assurance as the homepage offer | Highest forcing-function score, but validation stage 1 of 5, zero customers, and its buyer is found in r/msp peer threads rather than on this site |
| Keep rescue, soften to "we place seniors who fix broken Rails" | Keeps the site in a market that is crowded, priced below us, and named identically by a competitor |
| Outcome umbrella ("European software delivery, any stack") | Reads as generic agency positioning; converts nobody cold and states no differentiator |
| Fractional CTO + team | The panel's original 3-1 winner, rejected by Paul on the facts: he has never been hired as a fractional CTO |
| Retire `/vibe-code-rescue` and redirect | Throws away working organic traffic on the site's #4 page |
