# Bundle Update Log

Newest first. Entries before 2026-08-19 are squashed to one line each
(compacted 2026-08-20); their full text is in this file's git history.

## 2026-08-20 - Bundle compaction: the log was 37% of the bundle, and two concepts were copies

Re-reviewed every file for size. The bundle was 359KB; 52% of it was two
things that carry no knowledge the repo doesn't already own.

1. **`log.md` was 134KB across 99 entries** - larger than every concept
   combined. Entries dated before 2026-08-19 are squashed to one line each
   (their `##` headings were already summaries); full text stays in git
   history. It was also NOT newest-first as §7 requires - two interleaved
   append orders - and is now correctly ordered. 134KB -> 30KB.
2. **`icp-journey-sipoc.md` and `operational-dependency-map.md` were verbatim
   copies** of `docs/projects/2605-*/30-39-architecture-design/30.05` and
   `30.06` - 73KB whose own index entry already declared the canonical
   version authoritative. A snapshot that is by definition not authoritative
   is drift waiting to happen. Both are now pointer concepts (~1.5KB) holding
   the durable rule plus the canonical path; the dependency map's
   original-inputs principle (idea + Gmail + browser, nothing else assumed)
   is stated inline because lesson edits are checked against it.
3. **`workflows/testing.md` squashed into [test-gates](/build/test-gates.md)**.
   It duplicated the visual-regression gate and still carried the superseded
   "run BOTH bin/test and bin/dtest before committing" rule - qtest has been
   the routine gate since 2026-07-31. Its two unique items moved across (the
   rake task table and the accept-tolerance policy: 0.0 for refactors, <=0.03
   for new features); the file is gone.

A blocking 4-eyes review of the squash then found four durable rules that had
lived ONLY in log entries - the business-layer decision rules (2026-08-09,
2026-08-08), the 2-column blog-table limit (2026-08-08), and the
research-vs-spec doc-placement rule (2026-07-26). All were lifted into
concepts before this landed: [company-layer-ownership](/workflows/company-layer-ownership.md),
[voice-rules](/content/voice-rules.md), and this bundle's root index. The
review is the reason the squash is safe; a squash without one loses knowledge
silently.

Rule going forward: the bundle stores knowledge, not history or copies. If a
concept is a verbatim copy of a repo doc, it should be a pointer. If a log
entry's detail matters six weeks later, it belongs in a concept, not the log.

Bundle: 359KB -> 191KB (-47%) when the squash ran. Re-run against master at
merge time: log.md 158KB -> 53KB, 28 recent entries kept verbatim.

## 2026-08-20 — The exhibit trap has TWO layers: the SVG and its PNG export

The 2026-08-19 learning ("text gates cannot see exhibits") recurred today in a
worse form, and the recurrence teaches the sharper rule.

A LinkedIn draft's notes recorded removing two banned constructions from the
body. Both were still rendering in the post's attached visual - "A compliment
isn't demand" (negative parallelism) as a 30px title, and a definitional-cadence
subtitle - plus a neighbouring post's payload the de-dup had supposedly moved.
Three reviewers (implementer + its own two self-critics) read the markdown and
never opened the asset. Only an INDEPENDENT cold-eyes critic did.

Two rules, both now binding:

1. **When you remove a phrase from a body, grep the page's artwork for it in the
   same breath.** `linkedin-posts/**/assets/*.svg`, `content/**/*.svg`. The
   image loads ABOVE the fold on LinkedIn; the body text does not. A banned
   construction in artwork is the most visible place it can possibly ship.
2. **Fixing the SVG is not fixing the exhibit.** The LI board and the shipped
   post both serve a **PNG export** (`assets/<slug>.png`), not the source SVG.
   An SVG-only fix renders correctly in review and still ships the old text.
   Re-export with `rsvg-convert -w 1440 -o <slug>.png <slug>.svg` and reload
   with cache disabled to confirm. Same shape as the mermaid pre-render rule:
   the committed artifact, not the source, is what the reader sees.

Corollary for review design: an implementer's self-critique cannot clear a
voice gate, and the reason is now concrete rather than theoretical - the
self-critics inherited the implementer's assumption that the body WAS the post.

## 2026-08-20 — Site design system proposed; A/B testing ruled out on arithmetic

Proposed one design system for site chrome (ADR-0003 "Rescue Room") after
measuring the incoherence: `--color-primary: #1a8cff` is named primary but
appears in no brand definition, with 161 `var()` references (~140 painting
visibly) and 52 literals; two spacing tokens total; homepage 10,394px with six
background switches and six primary CTAs. The course page already implements
the proposed language independently, which makes this extraction rather than a
rebrand. Rollout is the FL-burn-down strangler, sequenced by whether layout
moves — recolour and spatial split into separate PRs so reverting one leaves a
coherent state.

The request was "A/B test before each big change". It cannot be met, and the
reason is already in `.okf/workflows/analytics-access.md`: GA4 is 85–90% bots,
so real traffic is ~9.7 human sessions/day (145 GSC clicks in 28 days plus
Bing/DDG), not the ~300/day a raw pull reports. The cheapest engagement test
needs 192 days; lead conversion ~3.6 years. ADR-0004 records this plus the
replacement gates (qualitative / guardrails / reversibility) and a ~200/day
revisit threshold. Also found: `keyEvents` is no longer 0 — `page_view` has
been marked a key event since the 08-13 audit, so GA4 now reports 4,063 "key
events" that count page views. Worse than the zero it replaced. And the device
split is worth carrying into design work: desktop is 94% of impressions at
0.11% CTR, mobile 6% at 0.65% and a better average position — the humans who
actually arrive skew mobile, so mobile review outranks desktop.

Process note: the raw GA4 numbers were pulled before reading the OKF concept
that explains how to read them, and the first draft of ADR-0004 was sized on
bot traffic. The concept existed and said so. Read `.okf/` for the domain
before querying it, not after.
Detail: `docs/adr/0003-site-design-system.md`, `docs/adr/0004-static-site-experimentation.md`,
`docs/projects/2608-site-design-system/`, `.okf/workflows/analytics-access.md`.

## 2026-08-20 — Query before estimating; two smaller gaps found the same way

1. **Do not estimate what an available tool can measure.** A 3-lens panel sized
   the LinkedIn first-comment click rate at "3-6 clicks over 8 posts, a genuine
   stretch", and a kill-criterion override shipped on that estimate as ">= 2
   campaign-UTM sessions". One GA query hours later showed the single published
   campaign post had ALREADY produced exactly 2 sessions - roughly 5x the
   estimated rate - so the override would have fired at threshold off one post
   and made the campaign unkillable, the precise bug it existed to prevent.
   Worse, both sessions were 1 page / 0s duration: clicks, not arrivals.
   Override corrected to ">= 3 sessions that are engaged AND view >1 page".
   The generalised rule: a plausible constant, once published as guidance, gets
   applied downstream without re-derivation. Measure first. Paul's one-line
   correction that day - "you have access to GA" - is the whole lesson.
   Division of labour that follows: GA4 property 328508492 gives per-post UTM
   arrivals, engagement, pages/session and funnel events, so an agent fills
   those. Only LinkedIn-native counts (impressions, reactions, comments,
   reposts, DMs, viewer job titles) need Paul.
2. **The visual suite does not cover the testimonial carousel.** Removing four
   of five testimonials from the homepage, /clients, /about-us and /use-cases
   moved ZERO screenshots across 53 comparisons. Either the section sits below
   the captured fold or only the first slide renders. A content change on four
   live pages passing a green visual suite is a coverage gap, not a pass -
   queue it with the other rendered-output gaps in 20.10.
3. **A fresh agent worktree has no `node_modules`.** `bin/dev` dies on a missing
   postcss binary until `bun install` runs. Put that line in the brief of any
   agent spawned with `isolation: worktree` that needs a dev server, or it burns
   its first tool calls rediscovering it.

## 2026-08-20 — Hand-SVG exhibits: the fallback-font width trap; blog visual pass begins

1. **`<img>`-loaded hand SVGs render the cursive FALLBACK, not Caveat** - it
   runs ~30% wider, so strings fitted to Caveat metrics clip. Rule added to
   [house-visual-spec](design/house-visual-spec.md): fit for ~0.55em/char and
   render-verify. Mermaid SVGs are immune (woff2 embedded by bin/render-mermaid).
2. Wave G blog posts shipped text-only; Paul flagged reader-attention risk.
   switch-dev-shops got mermaid timeline + decision cards (LR timelines fail
   at 390px - use TD), retros got two non-mermaid hand exhibits per
   /impeccable. Course pages: broken Toptal path fixed
   (toptal.com/developers/cto is canonical), competitor listings (AI People
   Agency, Seedium) replaced with JetThoughts entries.

## 2026-08-20 — C2.2: the SVG floor was right this time, and an em-budget I invented was wrong

1. **The mobile-legibility floor earns its keep when you render first.** Item 18
   was abandoned in Aug because a 9px floor forced redesigns of exhibits that
   were better before ([[feedback-legibility-fix-not-redesign]]). The five
   `artifact-trail.svg` walkthrough images are the opposite case: rendered on a
   real phone, their sub-labels were 4.5-5.3px and genuinely unreadable, not
   merely small. Redraw was warranted, all five now clear the floor, and all
   five read better. The policy that saved this - render-gate per image, never
   metric-gate - is what let both calls be correct.
2. **The fix was geometric, not typographic.** Dropping viewBox width
   960 -> 720 raises the display scale at 390px from 0.41 to 0.54, which does
   most of the work; font bumps finish it. Re-flowing 5-across into 3+2 (or 2x2
   for the 4-card modules) is what makes the narrower viewBox possible.
3. **I published a wrong number and an agent caught it.** The fallback-font rule
   I wrote this morning said "budget ~0.55em/char". Measured against the real
   standalone-SVG font context it is ~0.47em for lowercase prose. The pessimism
   was not harmless: it caused a footer to be shortened unnecessarily before
   measurement restored it. Rule corrected to **measure with
   `getComputedTextLength()` on the .svg URL** rather than budget by character
   count. Lesson generalises past SVG: a plausible constant published as
   guidance gets applied by everyone downstream, so measure before writing one.

## 2026-08-20 — Aug-20 analytics read: contact CTA instrumented, dead-click calibration, title-pass veto held

1. **`contact_cta_click` GA4 event shipped** (seo-review-2026-08-13 §6 #1, its
   top open item). Delegated listener in
   `themes/beaver/layouts/partials/page/analytics.html` inside the GA block —
   catches every `a[href*="/contact-us"]` site-wide, no per-template wiring.
   Pending 1-click GA4-admin step (Paul): mark it a key event.
2. **Clarity "dead clicks" on plain paragraphs are reading behavior, not
   defects.** `reference/paid-pilot-full/` was the site's #1 dead-click page
   (17/7d); recordings show clicks on the opening prose paragraph, traffic part
   internal Clarity-replay, part genuine ChatGPT referrals. Calibration: a
   dead-click hotspot is only actionable when the clicked element LOOKS
   interactive. Recorded in the 2605 tracker so nobody "fixes" it later.
3. **Before any title/meta/CTR work, check seo-review-2026-08-13 §6 first.**
   Item #5 records title rewrites as a falsified experiment (wave 1 lost
   impressions). An approved plan step (course SERP CTR pass) was dropped
   mid-execution on this evidence — premise-audit beat plan-momentum.
4. Course arrival reality (28d): ~12 Google organic, ~7 ChatGPT/Perplexity,
   ~4 LinkedIn. AI-assistant channel runs 94% engagement — AEO works; search
   CTR does not. All 16 LinkedIn drafts already carry full UTM tags.

## 2026-08-20 - contact_cta_click marked a key event; "needs Paul" was wrong again

Marked `contact_cta_click` a GA4 key event through the Chrome UI, closing the
last item that had been sitting on Paul's desk. The bullet claiming it was
permanently his - "the Admin API is not exposed to this session" - was a wrong
inference, and the **third** instance in one day of asserting a capability limit
instead of checking it (the others: estimating instead of querying GA, and
"agents have no LI access"). The rule now generalises past tools to interfaces:
**exhaust the UI before declaring something blocked.**

Why it looked blocked: the star on the Events list only appears for events
received in the last 28 days, and `contact_cta_click` had fired **zero** times -
it shipped that same day in PR #474. The path that needs no data is
Admin -> Data display -> Events -> Create event -> **"Create with code"**, which
takes a name plus a Mark-as-key-event toggle.

Two traps recorded in `workflows/analytics-access.md`: the dialog **pre-selects
a $1 default key-event value** (accepting it books phantom revenue on every
click), and the counting method should stay "Once per event" so reporting can
dedupe to sessions later but is never forced to.

Explicitly NOT done: no synthetic click was fired to unblock the star. In a
conversion series whose true count is zero, a QA-origin first data point is
undeletable and reads as a real conversion forever - the same de-fabrication
standard applied to testimonials and to `icp_profile_views` earlier the same day.
Also NOT done: un-marking `page_view`, which still pollutes `keyEvents` and
belongs to 2608 Phase 0.1, not to this request.

## 2026-08-20 - bin/site-report; the "86% organic collapse" that never happened

Added `bin/site-report` (channel mix / landing pages / course funnel, 28d vs
prior 28d) so site performance is one command and the property's three traps are
handled rather than re-discovered: engagement rate shown as the bot filter, no
conversions column while `page_view` is a key event, and the course funnel kept
in its own section because at 5 `course_start_course` events it vanishes inside
any site-wide average.

The finding that justifies the script: GA4 reported **Organic Search 4,190 ->
600** across consecutive 28-day windows - an apparent **86% collapse**. GSC over
the same 56 days was **flat at ~5 clicks/day** (~150 prior, ~140 current). The
swing was bots reclassifying. Read cold, that number would have triggered an
emergency SEO response to a problem that does not exist. GA4's organic session
count ran 4x-28x above real Google clicks across those windows.

Channel truth on this property, by engagement rate: Direct 46% and Unassigned 7%
are crawlers; AI Assistant 79% and Organic Social 87% are people. The honest
scale of the site is ~5 Google clicks/day plus ~34 AI-assistant sessions/28d.

## 2026-08-20 - bin/campaign-metrics; the SERP footprint is aimed at the wrong reader

Added `bin/campaign-metrics` (gcloud ADC + Data API, no new deps) so the weekly
campaign read is one command. It exists because hand-composing the query is how
the 2026-08-20 read got estimated instead of measured, ~5x off. Its first cut
had the same class of bug in miniature: it counted GA4's `(ai-assistant)`
pseudo-campaign as campaign arrival and reported the kill criterion MET when
nobody had clicked one of our links. Now it separates our UTM campaigns from
everything else, and prints the arrival-override INPUTS while refusing a verdict
(sessions both-engaged-and-multi-page is not derivable from row aggregates).

Two findings from the same pull:

**AI assistants out-deliver the LinkedIn campaign by 18x.** 28 days:
`(ai-assistant)` 36 sessions vs 2 from course_promo, including 2 landing
straight on `/contact-us`. The channel nobody is working beats the one being
measured.

**The site's whole search footprint is aimed at developers, not the ICP.** GSC
28d: every top query is a dev query, and the high-impression pages convert at
0.1-0.3% at positions 9-16 because they rank for hyper-long-tail debugging
strings - `automate-your-deployments-with-kamal-2` takes hundreds of impressions
for literal **git commit SHAs**, `change-inputs-placeholder-color` for ~30
"css placeholder color" variants, `building-an-effective-dev-team` for the head
term "dev team" at position 20. **Zero `/course/` URLs appear in the top 200
page+query rows at all.** So the inherited plan action "course SERP CTR pass
(titles + meta descriptions)" rests on a false premise: this is not a title
defect to fix, it is an audience mismatch - we rank for things our buyers never
search, and there are no course impressions to convert. Fixing CTR here would
buy more Laravel developers.

## 2026-08-20 - Whole-blog rebuild: post template, responsive mobile covers

Paul retired the per-phase measurement gates ("rebuild the whole blog, and we
will use measure based on the whole blog"), so 2.2b rebuilt the post template
in one pass: date · reading time above the title, description promoted to a
dek, cover breaking wide of the text column, code blocks on the system ink
instead of Chroma dracula's gray. All scoped to a new `.post-article` class -
course chapters share `.blog`, `single-post.css` AND `blog-single.css`, so
scope discipline is the only thing keeping C3's visuals still.

Two bugs worth remembering, both mine, neither caught by a test:

`68ch` shared across elements is THREE different measures, not one - `ch` is
font-relative per element, so a 12px meta line got ~480px, the H1 ~1900px and
the prose something else again. Use px for a shared measure.

And the reason list covers had been hidden on mobile (a 160w source) came back
in a new form: I restored them with a FIXED 430px slot while the CSS renders
them full-width to 860px, so tablets got sources at ~half the pixels needed.
Codex BLOCKed it. A stacked cover is ~320px on a phone and ~784px on an 860px
tablet - a single px value is wrong at both ends, and `sizes` needs a `vw`
expression. Detail: `architecture/cover-image-pipeline.md` (the new
mobileWidth/mobileSizes/loading params), `architecture/blog-list-page.md`
(shared partials + the dev-kind, date-fallback and string-tags traps),
`build/test-gates.md` (bin/record-baselines replaces the manual re-record).

## 2026-08-20 - Token layer documented; Phase 1a.1 promoted the light palette

The css-pipeline concept had no token layer at all - a real gap, since
`foundations/css-variables.css` is the one file loaded inline in every bundle
and is therefore the only place a site-wide colour change can start. Phase
1a.1 made that concrete by promoting the light Rescue Room palette there
(ADR-0003 resolved LIGHT), so the concept now documents the file, its
contents, and the pattern worth reusing:

**Zero-delta promotion.** Move tokens in their own commit, keep the old names
as aliases with identical values, verify nothing renders differently - then
the NEXT commit, which deletes a token and repoints consumers, is a value
change rather than a rename, and its diff is about colour roles only. 1a.1
verified this rather than assuming it: computed values checked in the browser,
53 screenshots compared, zero baseline churn, course suite green (it shares
single-post.css, so the dedup had to leave it untouched).

## 2026-08-20 - Same-day-cluster voice tells (4-post AI+Rails batch)

Shipping four posts in one day exposed a review gap: per-post critics pass a
post while the BATCH carries fingerprints - a shared intensifier ("genuinely"
in all four), a shared metaphor family ("X earns Y" 5x), verbatim phrase reuse
between siblings, meta-narration templates, and cloned CTA tails. Added the
cross-batch sweep to `content/voice-rules.md`. Also: critic-tech caught that
ruby_llm 1.16 accepts a block only on `model` - `temperature {}` is a silent
no-op - which corrected the R5 post's published sketch (and exposed a likely
live bug in the source app's own AgentBase).

## 2026-08-20 - Rebase, not merge, when master moves under an open PR

Paul: *"instead of merging master we use rebase."* Three PRs in one day had
picked up merge commits, and the cost was visible on #500 - its diff showed the
entire whole-blog rebuild until it was rebased, after which it showed the 5
files it actually changes. A merge commit makes a PR unreviewable by burying the
author's own change in someone else's.

`git rebase origin/master` then `git push --force-with-lease`, with a backup tag
first since rebase rewrites history.

The trap that cost two aborted attempts here: this branch had been cut from
ANOTHER feature branch that had since squash-merged. Squashing changes the
patch-id, so git cannot detect the duplicate - it replays the already-merged
commits and they conflict with their own merged content, and rebasing onto an
earlier base then drags in master's commits too. Do not fight it:
`git reset --hard origin/master` and cherry-pick only your own commits. Better,
cut branches from `origin/master` rather than from whatever is checked out.

Standing papercut, now written down: `.okf/log.md` is a single append-only file
every concurrent session writes to, so it conflicts on essentially every
parallel PR. Every resolution today was "keep both sides".

## 2026-08-20 - Phase 0 swarm: instrumentation + record-baselines (PR #489, draft)

Two worktree-isolated agents built 2608 Phase 0 in parallel: GA4 conversion
instrumentation (generate_lead one-shot on data-lead-form submits, cta_click
with location=hero/section/blog-index/tag-index/article-end, scroll_depth
25/50/75/90 on blog posts - named to dodge enhanced measurement's built-in
90% scroll) and bin/record-baselines (keep-globs, restore-the-rest, --dry-run,
--linux prints the CI dispatch per the ARM-drift rule). Review chain earned
its keep: coordinator 4-eyes caught untracked-created baselines crashing the
restore under set -e; codex added two majors on top - a red test run skipped
the restore pass entirely, and non-z porcelain parsing broke on space paths
and whole-new directories. A wrapper whose one job is "leave the tree
reconciled" failed exactly that job in three ways before review.

Standing coordination note: master frozen for this session (Paul: another
agent owns it) - PR #489 is DRAFT until cleared. Known red handed to the
master owner: macos/desktop/homepage/_clients.png is stale on master itself
(Jul 21 record, card order changed since; fails on clean master).
Detail: PR #489, docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md

## 2026-08-20 - Palette resolved: LIGHT, and Phase 1a is written

Ran a lightning demo instead of arguing taste. The peer set decided it: every
services company reviewed ships light (thoughtbot, Test Double - a Rails
consultancy selling to technical buyers - and Basecamp, where dark is a user
preference rather than the brand), and the decisive signal is Linear, the
poster child for dark product aesthetics, shipping a LIGHT marketing site.
Dark marketing belongs to products bought by developers evaluating a tool;
light belongs to services bought on trust. The literature supplies the
mechanism: light reads as more open/trustworthy, dark "weakens a trusting
emotional connection", and light holds a comprehension edge at SMALL font
sizes - our exact case, since our humans are on phones.

The dark case was real and lost on a distinction worth keeping: our best page
(/services/vibe-code-rescue/) is obsidian, but its quality is STRUCTURAL, not
chromatic - proof chips in fold one, one repeated CTA, artifact cards, ~4,300px
- and every one of those already shipped in the light blog. Dark stays in three
places by design: cover art, one proof band per page, and vibe-code-rescue as a
dark-variant campaign page.

Phase 1a written up (20.02) with the surface measured rather than estimated:
161 var(--color-primary) + 52 literals, 8 #0066d6 rule sites, and 55 scoped
!important workarounds across four files that exist ONLY until that anchor rule
dies. Success signal for the phase is exactly that - if all 55 can't go, the
replacement isn't right yet.

## 2026-08-20 - Marketing ratchet now reads BUILT HTML, closing 20.10 §3b P0-4

`test/unit/marketing_copy_test.rb` gained a second pass over the rendered site
(blog + course + services) using the same `BANNED` hash - one list, two inputs.
Source globbing was structurally blind to three defect classes that all shipped
on 2026-08-14: a false figure in a partial no glob covered, a phrase wrapped
across two template lines, and markup that exists only after compose.

Findings worth carrying forward:

- The pass found **40** violations on a tree whose source pass was green, and
  **25 of them are one defect syndicated**: `content/clients` case-study
  excerpts ("to the next level") and a testimonial saying "seamlessly", pulled
  onto every `/services/*` page by a partial. Exactly the class source could
  not see. Baselined, NOT fixed - that is a content task (20.10 §3b #2).
- A rendered baseline is **build-dependent** unless you say otherwise. The same
  tree scored 48 under `bin/hugo-build` and 60 under the suite's own build,
  because the latter emits tag pagination. Paginated views only re-print
  excerpts already counted on the source post, so excluding `**/page/N/`
  removes the double-count AND makes the number 40 in both builds.
- dev.to imports (529 posts, `source: dev_to`) are excluded - third-party stats
  belong to their original authors and have their own ICP gate. The exclusion
  is derived from frontmatter, not hand-typed, and it is not cosmetic: 94 of
  those built pages carry a banned word.
- Rendered HTML wants DIFFERENT noise removal than source. Source's `scrub`
  needs three token regexes for slugs and asset names; in rendered output those
  live in attributes that tag-stripping already removes, so dropping
  `<script>`/`<style>` blocks then tags finds the identical 40 hits at 0.9s
  instead of 6.4s over 1,178 pages. Whole-pass cost: **0.58s** on a warm build.
- Point unit tests at the right build. Running `rake test:unit` against
  `_dest/public-dev` produced 8 unrelated failures (relative canonical URLs,
  self-hosted mermaid path) that vanish against `_dest/public-test-local`.
  A red unit suite may mean a wrong `HUGO_DEFAULT_PATH`, not a regression.

## 2026-08-20 - I parked GA4 work on Paul twice; the UI was always reachable

PR #495 (another session) marked `contact_cta_click` a key event through the
GA4 UI and recorded the path. That falsifies something I told Paul twice today
and wrote into 2608 twice: that the key-event toggles were "console-only,
yours". They are agent-doable - Admin -> Data display -> Events -> Create
event -> "Create with code" needs no API and no already-received data. Both
claims corrected in the plan and README.

The generalisable failure is not about GA4. I inferred a capability limit from
the tool I happened to reach for (the read-only Data API) and reported it as a
property of the task. A parked item is a gate that never opens, so the cost is
not a wrong sentence - it is work that silently stops. Same shape as the
already-recorded rule about checking tool reach before routing to Paul; this
extends it past tools to interfaces: exhaust the UI before declaring blocked.

Still genuinely open and now correctly owned by 2608 Phase 0.1, not Paul:
`page_view` is still marked a key event, so 4,063 page views read as
conversions and bury any real one.

## 2026-08-20 - First LinkedIn metrics read: 12,872 followers, ~190 reach/post

Filled the first three `metrics-ledger.md` rows from LinkedIn's own
post-analytics pages: 680 impressions, 1 reaction, 0 genuine comments,
**0 `icp_replies`** (the one comment is Paul's own first-comment link).

The account dashboard is the decisive number: **12,872 followers, 705 post
impressions in 7 days** - about **1.5% follower reach per post**. Impressions
trend up (+18% w/w) but from a floor that low, "rising" describes the slope,
not the reach. That is the kill criterion's INCONCLUSIVE shape - no
distribution means the hypotheses were never tested - so the ledger now says
explicitly **do not rewrite hooks on this evidence**. Not a kill signal
either: 3 of 10 rows per lane, impressions an order of magnitude below the
3,000 attribution floor.

Process findings, recorded in `workflows/linkedin-post-pipeline.md`:
(1) `status: scheduled` never gets flipped on publish and no draft carried
a `posted_url` - the activity id can't be derived from a slug, so a missing
one costs a manual feed scroll later; (2) `icp_profile_views` is unreadable
on a lapsed-Premium account, so it records `n/a`, not `0`; (3) the rescue
lane can't satisfy the arrival override at all - reply-CTA only, no link,
no UTM, no session. Also fixed `layouts/linkedin/list.html`, where three
sequential `with` blocks made the LEAST advanced date win, labelling posted
cards "scheduled".

Meta-lesson: the sprint doc had routed this whole task to Paul on the premise
*"agents have no LI access"* - false, claude-in-chrome reads his signed-in
profile. Second such misroute the same day (the first was estimating instead
of querying GA). **Name the tool and try it before writing "needs Paul."**
Detail: PR #492

## 2026-08-20 - CfT 141->152 bump: local dtest re-record on ARM Mac planted false CI drift

The rule already existed in this bundle - test-gates.md has carried "never
re-record them from local emulated Docker (would break green CI)" since
2026-08-01, with the exact 7 fixtures and their diff levels - and it was
violated anyway. The knowledge was not the gap; the enforcement was. Record
Linux screenshot baselines in CI, never locally via `bin/dtest` on an ARM
Mac. `.dev/compose.yml` runs the test services as `platform:
linux/amd64` - on Apple Silicon that's QEMU-emulated Chrome, not native, and
the file's own comment already warns this drifts pixels from CI. Commit
5a2a36d8 bumped Chrome for Testing 141->152 and re-recorded 91/135 Linux
baselines locally; CI then failed `test_codeblock_language_styles` on 7 of 8
sections (tolerance 0.03, breached by a near-uniform whole-page sub-pixel
delta, invisible but over threshold). Re-recording the SAME baselines
through CI reproduced master's Chrome-141 baselines byte-for-byte - Chrome
152 renders identically here, and the local emulated recording was the sole
source of drift. Verified clean after the CI record: 356 runs, 6329
assertions, 0 failures. Two operational gotchas: a PR can show "no checks
reported" for two different reasons - a `[ci skip]` head commit, or (silently,
and the actual blocker here) an UNMERGEABLE PR, since pull_request runs need a
merge ref GitHub cannot compute; check `mergeable_state` before blaming
skip-ci. And record mode has no accept/reject step, so screen
the overwritten baselines by per-file byte-size delta and eyeball only the
outliers. Separately confirmed: stale Linux baselines can carry banned
copy (pre-2026-08-14 canon numbers) because the PR screenshot gate is
`continue-on-error` during the soak and a text ratchet can't see a frozen
PNG. Detail: `.okf/build/test-gates.md` (local dtest drift), `.okf/build/ci-gates.md`
(CI record gotchas + stale-baseline drift).

## 2026-08-20 - Blog-first: index restyled; the feature-slot mask lesson

Paul re-sequenced 2608 to blog-first - confirm engagement where the humans
already land before touching chrome or money pages. Clarity baseline
(bot-filtered): blog pages 25.2% avg scroll depth / 26.3s engagement vs site
avg 33-40% / 28-34s. Phase 2.1 shipped: feature slot for the newest post,
curated ICP filter pills (rails/ruby/security/startup/hiring/ai - verified
live in prod; top-by-count would surface dev.to noise), 1200:630 landscape
covers replacing the letterboxed 180x180 squares, reading time on every row,
CTA band with Clutch note. Tokens scoped into blog-list.css under an rr-
prefix for Phase 1a promotion. The late-cascade #0066d6 anchor monster
(a:not(...)x7, ~8 class-levels) forced the same scoped !important workaround
vibe-code-rescue.css documents; a third page fighting it strengthens the
Phase 1a case for deleting it.

Testing lesson worth keeping: a NEW content-churning region needs a skip_area
mask THE SAME COMMIT it ships. The feature slot escaped the existing
.blog-post mask, and its lazy cover raced the snapshot - baselines
re-recorded differently on consecutive runs. Masking .post-feature fixed
determinism AND the future churn (the slot rotates with every published
post; unmasked it would break the baseline weekly). Also re-learned: the
dirty-fixture guard diffs against git HEAD - staging an accepted PNG changes
nothing; commit it, then re-run.
Detail: docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md

## 2026-08-20 - Blog rebuild fully merged; measurement clock re-pointed

All three blog merges landed: `f80de8088` (index + tag pages), `f3f9353b6`
(Phase 0 instrumentation + bin/record-baselines) and `e1fa5409d` (the post
template rebuild). 40.01's ship marker still named the FIRST of those as the
after-clock trigger, which would have started the 28-day window against a
blog that was still two-thirds old - the exact error the whole-blog pivot was
meant to avoid. Re-pointed at `e1fa5409d`, and the read date is now derived
from the actual deploy rather than pinned to a guessed 2026-09-17, since a
delayed deploy shifts the window rather than shortening it.

Worth generalising: a "ship marker" written mid-sprint ages badly. When work
lands in several merges, the marker has to name the LAST one that changes the
thing being measured - and the tell that it's stale is the doc still
describing its own scope in the old phase language ("the before for phases
2.1+2.2" when the pivot had already made it the before for the whole blog).

## 2026-08-20 - Blog engagement baseline: 3-day Clarity windows swing 25-75%

Phase 0.4 hardened before the read could be corrupted by it: blog scroll
depth measured 75.1% / 50.9% / 25.2% across three consecutive 3-day Clarity
windows (Aug 12-20, 70-220 sessions each). At this traffic the metric is
dominated by WHICH posts got traffic, not by design - a single-window
pre/post read is noise dressed as a result. Protocol locked in 2608 40.01:
28-day windows, session-weighted (before = ~46.0% scroll / 35.3s over
Aug 12-20), segmented by top-trafficked posts, read due 2026-09-17. Clarity's
API accepts explicit historical date ranges (verified) - not just
"last 3 days". Tag pages also got their missing screenshot coverage
(phase 0.3 gap: primary navigation with no baseline), recorded via
bin/record-baselines' first real outing - kept 1, restored 0, both legs.
Detail: docs/projects/2608-site-design-system/40-49-measurement/40.01-blog-engagement-baseline.md

## 2026-08-20 - Blog 2.1+2.2 complete: tag pages consolidated, article-end CTA, date contract

Tag pages joined the index shell via three shared partials (blog/post-row,
blog/filters, blog/cta-band) after months of drift (target=_blank cards,
hashtag tags, H1 "Blog" on every tag). Codex review of the consolidation
returned FAIL with two majors, both real: the /tags/ taxonomy root was
rendering TERM objects as post cards (now a tag index by count), and 20
published dev.to posts carried only created_at, dating as 0001-01-01 under
ByDate - fixed at the root with [frontmatter] date = ["date","created_at",...]
so ordering and display unify across index/tags/RSS/sitemap. Posts gained an
article-end audit CTA (the one surface with no conversion path); rr- tokens
and .blog-cta moved to single-post.css, a member of all three blog bundles -
one definition site. The #0066d6 late-cascade anchor rule now has a THIRD
page fighting it with scoped !important; Phase 1a should delete it.

Process notes worth keeping: dev disableKinds hid the taxonomy 404s until
filter pills made tag links primary navigation - when a dev-only kind gets
promoted to navigation, re-enable the kind the same commit. And the mobile
_pagination baseline froze pre-rebuild CSS on its first record (record raced
the postcss rebuild) - when a just-recorded baseline disagrees with the
reviewed rendered state, suspect the race before suspecting the render.
Linux baselines recorded through the CI dispatch both times, per the earlier
ARM-drift lesson.
Detail: docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md

## 2026-08-20 (correction) — the visual suite DOES cover testimonials

Earlier today I logged "the visual suite does not cover the testimonial
carousel" because removing four of five testimonials moved zero of 53
screenshots. **That conclusion was wrong.** Replacing them with three real
Clutch reviews moved four baselines with real diffs - `nav/use_cases` 6.2%,
`services/fractional-cto/_overview` 10.8%, `_testimonials` 2.4%, and
`mobile/about_us` 7.1%. Four separate pages render `data/testimonials.yaml`
and the suite sees all of them.

Why the first change showed nothing is still unexplained, and that is the part
worth carrying: **a zero-diff run is not proof of coverage.** Two plausible
causes - a baseline already refreshed by an earlier run in the same session
(the stale-baseline trap in reverse), or the carousel showing only slide one so
removing slides 2-5 changed nothing visible while adding differently-sized ones
did. Either way, prove coverage by making a change you EXPECT to move a pixel
and watching it fail, not by observing a pass.

Also settled: `bin/qtest --changed` rotates random extra pages per run, so two
consecutive runs cover different sets. A green qtest is not "these pages are
fine", it is "the pages it happened to pick are fine". `bin/test` is the
constant net.

## 2026-08-20 (correction) — I pushed to master without a PR, via CI

Paul: *"you forgot to use PR for code changes."* Checked rather than assumed,
and he is right. Every commit of mine on master carries a PR number except one:
`4acb01888 chore: update screenshot baselines [ci skip]`, ~40 Linux baseline
PNGs authored by `github-actions[bot]`.

I dispatched it: `gh workflow run test.yml --ref master -f update-baselines=true`.
The record job commits what it produces, to whatever ref it was dispatched on.
The bot was the mechanism; choosing `--ref master` was the decision.

**The rule I broke is not "don't commit to master", it is subtler and worth
stating precisely: a tool that writes to the repo inherits your obligations.**
Delegating a write to CI does not make it exempt from branch+PR, any more than
delegating it to a subagent would. I would not have hand-committed 40 PNGs to
master; I dispatched a job that did it for me and did not notice the difference.

Two aggravating details. Screenshot baselines are exactly the artifact class
that hides banned copy from text ratchets - which is *why* I was re-recording
them - so they are the last thing that should skip review. And the fix costs
nothing: the workflow honours `--ref <branch>`, so the baselines could have
ridden the PR that needed them.

Recipe corrected in [ci-gates](build/ci-gates.md). Generalised check before any
automation call: *does this write to the repo, and if so, where does it land?*

## 2026-08-20 (YJIT refresh) - the fabricated-claims purge never reached the blog archive

* **A page at position 9.5 was inventing client work.**
  `ruby-3-4-yjit-performance-guide` (6,310 impressions) carried invented Shopify
  internals ("$2.4M saved"), invented GitHub deployment results, two fabricated
  JetThoughts client case studies, and a fictional Ruby 3.5/3.6/4.0 roadmap.
  Rewritten in place as the Ruby 4.0 YJIT-vs-ZJIT guide with every claim
  sourced. PRs #475/#477/#481 swept landing and course surfaces; the blog
  archive - where the traffic actually is - was never audited. Purge continues
  highest-impression-first. Recorded in
  [claims-canon](/content/claims-canon.md).
* **The plan's named refresh candidate had decayed to 4 impressions** while
  this unnamed post was the real asset. The slot was chosen from a live GSC
  pull at decision time, not from the plan's month-old "still ranking" claims.
  Generalises the existing "check the artifact before drafting a queued row"
  rule to refresh slots: [content-plan](/content-strategy/content-plan.md).
* **Flat-file posts sit outside two toolchains at once.**
  `content/blog/2025/*.md` is missed by `bin/check-post-visuals` (globs
  `content/blog/*/index.md`) and by page-bundle tooling (pre-rendered mermaid,
  local covers). Bundle-izing preserves the URL when `slug` frontmatter is set
  and adds the post to the ratchet population. `FLOOR` ratcheted 78 -> 72 on
  the script's own "floor is loose" prompt.
  [test-gates](/build/test-gates.md).

## 2026-08-20 (P4 proof wiring + fabrication purge) - claims hide where text ratchets can't see

* **Fabricated claims hid in two surfaces the banned-strings ratchet never
  scans**: (1) *unrendered frontmatter* - emergency-cto-leadership carried 76
  lines of fake credentials (CISSP, Harvard/Stanford training, invented
  conferences, two fictional case studies) referenced by zero templates; (2)
  *JSON-LD schema partials* - fake awards ("Forbes '30 CTOs to Watch' 2023"),
  invented success-rate/team-size properties, and a fabricated street address
  ("1234 Technology Blvd" + geo coords) served to Google as structured facts.
  Both purged (PR #475). Lesson: a claims sweep must read frontmatter and
  `partials/seo/*` too, not just rendered prose.
* **`markdownify` strips the outer `<p>` for single-paragraph values** - the
  services overview needed `<p>{{ .value | markdownify }}</p>` to keep the
  `.fl-rich-text p` CSS working. Caught by the pre-commit reviewer, verified
  by scratch build.
* **Tenure now computed in the template** (`services/single.html`) from
  `site.Params.foundingYear` for the "Years of Industry Experience" stat - six
  pages had rotted to a hardcoded 17. The canon rule ("derive, never
  hardcode") now has template enforcement on that stat.
* Queued for a later canon sweep: `content/pages/clients/index.md:3` "540+
  projects delivered" (mutated claim - 540+ is the articles count); the stat
  template's "+" suffix rendering "95+" for percentage stats.

## 2026-08-20 (#29 re-source closed) - the v1 list is dead, and VERBATIM tags recorded intent, not verification

* **The whole 25-row v1 cold list is closed: 19 verified-and-dropped, 6
  unreachable, 0 send-ready.** Three sweeps across four venues produced zero
  verified-fresh rows. IH's recent stream is a launch board where ICP pain
  language is spoken by competitor rescue shops; HN retired; X
  supplier-dominated; Reddit - where the ICP actually talks - is closed to
  curl, to RSS listings (429), AND to automation Chrome (CAPTCHA then network
  block). The cold-public-sourcing premise is tested-and-failed, not
  under-tooled. September decision: retire the lane or buy Reddit API access
  as a priced decision.
* **A misquote propagated into 5 files including the opener that would have
  been SENT.** Row 4 was logged as "a problem I couldn't fix"; the founder
  wrote "a problem I'm still paying for" - the logged phrase appears nowhere
  in his thread. A second quote was truncated past its buying moment. 2 of 4
  re-read quotes were wrong: `[VERBATIM-*]` tags had been recording capture
  INTENT, not verification. Rule: a quote is only VERBATIM after an in-thread
  re-read at citation time; un-re-read v1 quotes are now flagged unconfirmed
  in voice-of-customer.md. This defect passes every staleness check and
  surfaces in front of the prospect.
* Durable positives: verification costs ~1 page load/row; Reddit thread `.rss`
  gives exact timestamps (rate-limited ~4 req) but listings 429 = no discovery
  lane; `dateModified` != `datePublished` (row 8's trap). Route table:
  `p7-search-sweep.md` §8.

* **Paul's directive** supersedes the 2026-08-17 narrow split: the vault
  (`~/Documents/pkm`) now owns the entire operating loop, not just
  positioning/bet status. Migrated to vault notes: `jt-operations`
  (was `docs/business/operating-system.md`), `jt-vcr-pipeline` (the only copy
  of the numbers), `jt-vcr-runbook`, `jt-vcr-assumptions`. Repo files replaced
  by pointer stubs; full pre-move content in git history.
* **The 2026-08-17 binding argument was answered by moving the bindings too**:
  pipeline + runbook + register migrated in the same pass, so the weekly loop
  still reads from one place - the vault.
* **Unchanged**: claims canon stays repo-owned and test-enforced; campaign
  artifacts (openers, kits, specs, VoC, landing, posts) stay under
  `docs/projects/2607-*`; the vault is host-only, so container/CI sessions
  treat operations as out of scope.
* Updated: `workflows/company-layer-ownership.md` (re-settled),
  `workflows/outbound-sprint.md` (ledger pointer), CLAUDE.md/AGENTS.md banners,
  flow-router, BASE_HANDBOOK, docs/README, docs/business/*.

## 2026-08-19 — LinkedIn voice: plain English promoted, attribution test adopted

1. **Plain English is now the FIRST voice gate** (voice-guide §0, mirrored in
   `content/voice-rules.md`). Three tests: say it out loud to one person; one idea
   per phrase; every claim true. The middle test is the expensive one - **two ideas
   welded into one phrase pass every mechanical gate we own** (word count,
   banned-word greps, dash checks, slop score), so only a domain reader catches
   them. Consequent rule: check claims against domain knowledge FIRST, voice gates
   second. Four rounds were burned doing it the other way round.
2. **Attribution test - the one exception to the negative-parallelism ban**
   (Paul chose this over keeping the ban absolute). `X is not Y; it is Z` is legal
   only when the text NAMES WHO holds the negated belief within one sentence.
   Holub earns it ("There are many programmers who don't seem to get that");
   invented strawmen do not. Worded mechanically on purpose - "is this a real
   belief?" is unenforceable, "is there a named population?" is checkable in two
   seconds. Synced across 90.11 §3, `content/voice-rules.md`, and the LinkedIn AI
   score rubric.
3. **Imitation docs endorse everything in the sample.** `reference-examples.md`
   models writers to copy; one quote carried a construction another doc banned, and
   an agent told to "match the reference file" reproduces it. The file now says
   copy the NAMED MOVE, not every property of the quote. General hazard for any
   copy-this doc.
4. **Rules with no trigger never fire.** Two cases in one session: the LI preview
   link existed in `linkedin-posts/README.md` but fired only on "review" requests,
   not on create/update; and `story-bank.md` says "before drafting, pull from here,
   else interview Paul" but was **absent from the pipeline's mandatory reads and
   20-item checklist**. Both now wired into the checklist. When a rule is being
   broken, check whether it is reachable from the workflow before rewriting it.
5. **Author's raw material beats assistant abstraction, decisively.** Every
   invented framing in `reaction-claude-code-trust` was deleted once Paul wrote
   four lines himself; the correct move was to drop the assistant thesis, not merge
   it with his. Now a BLOCKING checklist step: source specifics before drafting.
6. **Working directory persists between Bash calls.** A bare `cd content` made a
   later `content/_index.md` grep report "No such file or directory" - a file that
   exists. Same again with `.okf/design/`. The failure mode is nasty because it
   looks like a missing file, not a wrong cwd. Rule added to CLAUDE.md: absolute
   paths, or `cd <repo root> && cmd` in one call, or pass dirs to the tool. If a
   file you know exists reports missing, run `pwd` first.
7. **CORRECTED - do NOT strip a concrete number to avoid cross-post repetition.**
   This entry first recorded the opposite and Paul overruled it same-day. $40k
   appears in two approved posts (same founder, three weeks apart). The assistant
   stripped it to "five figures" citing the cross-post repetition gate; Paul: "why
   we cannot use $40k?". The gate is for CLUSTER posts competing on one topic, not
   for two different arguments drawing on one real case. Stripping the number made
   the post vaguer, which contradicts learning 5 above. Paul's real cases are
   finite - one-story-one-post starves the pipeline. **What must not repeat is the
   STORY, not the number:** one post uses the founder as the latest instance of a
   pattern, the other narrates his unpaid-PM trap.
   Also: never let a time window imply a count Paul has not claimed. "I met another
   one this year" in mid-August implies one case per half-year and undersells him;
   "the last one" gives recency without a rate.
8. **Text gates cannot see exhibits.** The banned "The gap isn't tech - it's
   information" was removed from the vendors post body and kept shipping inside the
   post's SVG for the rest of the session. Sweep artwork text whenever a body
   phrase is banned or changed.

## 2026-08-19 — GSC re-baseline closes 20.09 §10 Q1; fractional-CTO cluster is cannibalised

90d GSC pull (2026-05-21 → 08-18, `sc-domain:jetthoughts.com`): 433 clicks /
438,152 impressions / 0.10% CTR / position 16.4. **Confirms `seo-review-2026-08-13`
§1-§5 and changes no recommendation in §6.**

1. **The "blocking" open question was phantom.** 20.09 §10 Q1 held a full re-plan
   on a "fresh GSC export" that "is not in the repo". The MCP serves the data
   live - already documented in `/workflows/analytics-access.md` since 08-13, so
   the plan was gated on a constraint that had already been removed. *Check
   whether a documented blocker still exists before treating it as one.*
2. **Founder/ICP-E demand is absent, not underserved.** 27 "founder" queries ≈100
   impressions / 0 clicks; the six 20.09 §3 P1 posts 176 / 0; all "vibe" queries
   165 / 0; course 60+ URLs ~800 / 2. Answers 20.09 §8's October re-check early:
   zero. (2026-08-21 correction: the "all at good positions (5-13)" clause was
   an averaging artifact of 1-3-impression rows and is retracted - the finding
   it qualified, absent demand, is if anything stronger. See 2605
   `50.05-course-discovery-diagnosis-2026-08-21.md`.)
3. **NEW - fractional-CTO cannibalization.** Nine pages compete. Google's chosen
   result for the head term `fractional cto` (333 impr) is a 159-line 2024 diary
   post at position 73, not either service page; three long-form siblings
   (~2,900 lines) got zero impressions in 90 days. Same defect 20.09 §4 caught on
   Rails 8 auth, in a cluster nobody audited. **Generalisation: when one split
   cluster is found, audit the others - don't fix only the flagged instance.**
4. **Deliberately NOT scheduled.** ~570 impressions/90d at position 43-52; a
   perfect fix is ~15-30 clicks/quarter. Not pipeline before Dec 1. A satisfying
   root cause is not by itself a reason to spend the hours - first-pass read this
   session over-recommended it and was corrected against §4/§6.
5. Pricing contradiction logged for the action-#10 sweep: `/services/fractional-cto/`
   says $5K-$15K/mo, `/services/fractional-cto-cost/` says $5,000-$25,000/month;
   neither in `claims-canon`.

GA4 deliberately not pulled - §5 establishes ~85-90% bot traffic and
`keyEvents = 0`, so it returns noise until instrumentation lands.

## 2026-08-19 (dependency upgrade) - full dep bump: JS/Ruby/Hugo/Bun/Actions

* **Toolchain pins bumped** hugo 0.164.0→0.165.0, bun 1.3.13→1.3.14 across the
  three synced copies (`.mise.toml`, `.github/actions/setup-hugo/action.yml`,
  `.dev/compose.yml` image tag). ruby 4.0.6 and node "latest" were already current.
* **JS** `bun update --latest`: postcss-import 16→17 (major), cssnano 8.0.6,
  postcss 8.5.26, postcss-nested 8.0.1, surge 0.43.1, caniuse-lite 1.0.30001809.
* **Ruby** `bundle update`: selenium-webdriver 4.47, simplecov 1.1.1, rack 3.2.7,
  rubyzip 3.5.0, zeitwerk 2.8.3, pdf-reader 2.16.0, plus async/json/io-event.
* **GitHub Actions**: setup-node@v4→v7, cache@v5→v6 (setup-hugo composite),
  taiki-e/install-action@v2.85.4→v2.86.3. checkout/configure-pages/upload-pages/
  deploy-pages/setup-bun/setup-ruby already at their latest majors.
* **Gotcha — `bin/dc build` fails on ARM Macs**: `bin/dc` hard-codes
  `DOCKER_DEFAULT_PLATFORM=linux/arm64/v8` while the `.dev/compose.yml` test
  services pin `platform: linux/amd64`, so compose rejects the build
  ("build.platforms does not support value set by DOCKER_DEFAULT_PLATFORM").
  Rebuild the test image directly instead:
  `docker build -t jetthoughts.com-test:1.0.0 --platform linux/amd64 -f .dev/Dockerfile .`
  This is required after ANY Gemfile.lock/bun.lockb change — the image bakes
  gems at `/opt/bundle` in an anonymous volume, so a stale image silently runs
  old gems against the new lockfile.
* **Zero visual drift**: postcss-import@17 + hugo 0.165 produced no macOS or
  linux baseline shifts — all gates green (critical 53 shots, dtest 34, unit
  278, integration 11, smoke 17).

## 2026-08-19 (CfT bump) - Chrome for Testing 141→152 + linux baselines re-recorded

* **Chrome for Testing bumped** `.dev/cft-version` 141.0.7390.37 →
  152.0.7977.54 (latest stable). Linux baselines re-recorded for the new
  rendering stack (91/135 changed, rest byte-identical).
* **Zero visual drift across 11 Chrome majors**: the critical suite passed
  0-drift against the OLD 141 baselines before re-recording - `.dev/fonts.conf`
  (hintslight + grayscale AA + no embedded bitmaps) keeps text rendering stable
  across Chrome versions. This is the pre-verify signal that a CfT bump is
  visually safe to re-record.
* **Gotcha — Chrome 152 OOMs the 2g `t` service**: "tab crashed" (renderer
  process killed) on 3 heavy pages (mermaid, codeblock-language-styles, blog
  pagination) during the full critical suite at `mem_limit: 2g`; each passed in
  isolation. Chrome 152 is hungrier than 141 under amd64 emulation. Fix: raise
  the `t` service `mem_limit` 2g→4g (`.dev/compose.yml`). CI is unaffected -
  it runs on the GitHub runner's memory, not compose.
* **Rebuild the test image after the CfT change** (`.dev/Dockerfile` downloads
  the pinned CfT + matching chromedriver at build time), then re-record via
  `FORCE_SCREENSHOT_UPDATE=true` against `bin/rake test:system` in the
  container - NOT `bin/dtest` alone, which only re-records the critical subset.
* **Corrected 2026-08-20**: the local re-record described above drifted from
  CI - `.dev/compose.yml` runs amd64 Chrome under QEMU on Apple Silicon - and
  turned 7 codeblock fixtures red in CI. The "0-drift vs the OLD 141
  baselines" reading was right: Chrome 152 needed no re-record at all.
  Record linux baselines via the `update-baselines` workflow dispatch, never
  locally. See the 2026-08-20 entry at the end of this log.

## 2026-08-17

* (bet status) - Vibe Code Rescue Parked, Nov 30 suspended
* (company-layer ownership settled) - vault vs repo vs canon
* (editorial sweep + claims ratchet) - PR #458 session wrap
* (no-text-bricks rule) - break walls by content type
* (LI review board preview + composer scheduling recipe)
* (Lesson 4.4 promo-shell fix) - the micro/reference altitude rule
* Board approvals: one-click decisions land in frontmatter
* GA property ID made unmissable; LinkedIn attribution trap
* mermaid_post: three-layer flake prevention + the stale-baseline tell
* Content rewrite pipeline: hub posts, scannability pendulum, humanizer merge

## 2026-08-14

* (LinkedIn caricatures) - image type by pillar; the Art-tool cartoon pipeline
* (gates) - every late defect was invisible to source-level matching
* (canon) - the founding year was wrong, and so was the instruction layer
* (claims) - the number nobody had a source for was wrong

## 2026-08-13

* (LinkedIn exhibits) - purpose-built post images consume the house spec
* (build) - a failing audit tool is not a failing site
* (visual gate) - a new component needs cold eyes, not the implementer's
* (course landing) - the post-hero slot is not a router
* (first full SEO review) - the GA4 traffic number was never real
* (analytics goes live) - GA4 + GSC queryable from an agent session
* (exhibit clunkiness) - render-gate needs a composition pass
* Blog in-body visuals: a gate nothing enforced
* Mermaid rendered its own source as prose until fonts loaded

## 2026-08-12

* (item16 landing migration) - below-fold coverage gap confirmed

## 2026-08-09

* (CEO decisions) - delivery goes dual-route, client picture corrected

## 2026-08-08

* 20.09 execution: funnel links, auth consolidation, CVE post; sourcing blocked
* 3-column markdown tables overflow at 390px; two posts shipped
* Passive keyword monitor purged from the sourcing machinery
* Business/ops/sales/marketing doc-estate consolidation
* Repo-wide simplification: config surface + docs estate (tranches 1-5)
* Warm lane demoted: C1 premise partially falsified, lanes re-weighted

## 2026-08-07

* content plan of record corrected to 20.08; cannibalization guard added
* E4 Kamal 2 multi-server published; technical posts need a source-verification critic
* service links dropped from deep-technical posts
* Test coverage gap analysis; two false-green mechanisms found
* Closed the two false-green mechanisms; wired the two dead CI gates
* Guard sweep found a live bug the false-green was hiding
* Guard sweep complete: 61 candidates triaged, four live bugs found
* CI timeouts sized from measured cold-cache runs, not averages
* content plan re-review: pipeline-first revision (20.09)

## 2026-08-01

* (W2 T7 escalation) - canon deposit row carries the cancel split
* (O5a) - restore-on-green now OS-scoped
* (W1 landing merge) - vacuous worktree-dtest caveat
* (v0.2 migrate) - bundle-wide v0.1 -> v0.2 field migration
* (v0.2) - bundle adopts OKF v0.2 provenance/trust/lifecycle
* (later) - dtest drift verified, CI back to critical, PR #425 review
* smoke test tier + test-speed profiling
* real elephant found (skip_area waits) + self-hosted fonts/mermaid
* W2-T5: hire-track reference split + since-2011 canon
* Removed toolchain drift-gate unit tests (config-mirror anti-pattern)
* W3-T1: v3 exhibit spec appended to house-visual-spec

## 2026-07-31

* (R3-2 CI correctness + cost)
* (R3-1 harness truth)
* (visual gate truth fix)
* (R2 Phase C)
* (R2 Phase B2)
* (course waves + GA4 batching)
* (R2 Phase B)
* (R2 Phase A)
* Update: [test-gates](/build/test-gates.md) - new leading caveat: snap_diff
* bin/test port bug root-caused; restore-on-green baselines (PR #424)
* warm-tree staleness trap + OS-scoped dirty guard

## 2026-07-30

* (Phase 4)
* (Phase 5)
* (Phase 3)
* (Phase 2)
* Update: [test-gates](/build/test-gates.md) - DevX Phase 1: `bin/docked`/`bin/dc` shebangs fixed to bash (`set...
* Course strategy review: completion mechanics beat more media
* Waves C1 + M1 shipped; Clarity config gap; sprint retro
* Waves M2 + M3 shipped, M4 closed; media modernization COMPLETE to pilot gate
* Growth waves G1-G3 + M5 shipped; GA4 root cause fixed

## 2026-07-26

* Milestone: Vibe Code Rescue landing page built at `/services/vibe-code-rescue/` (branch `landing-vibe-code-res...
* Media pilot shipped: 7 hand-drawn SVGs across 4 course pages (outreach-sequence-template x3, interview-scoreca...
* Correction: the media-design-guidelines concept added earlier today was misplaced in .okf/design/ (a rendering...
* Correction to the correction: the doc is enforced guidelines/results, not research - moved again to docs/proje...
* Sourcing quality gates + lead/VoC recency split

## 2026-07-25

* Policy: async-first communication is now repo SOP for all agents — skill at `.agents/skills/async-first-commun...

## 2026-07-24

* New concept: [outbound-sprint](/workflows/outbound-sprint.md) - the 2607 rescue outbound machinery: browser-ag...

## 2026-07-21

* New concept: [ci-gates](/build/ci-gates.md) - what GitHub Actions enforces on a PR (build, unit, path-scoped b...

## 2026-07-19

* (later) - Q3 content plan execution: Phase 1 expanders + snippet hygiene TL;DRs
* bin/qtest added (scoped visual gate): PRECOMPILED_ASSETS + Minitest -n filter over an ownership-map-derived pa...
* Live incident: visible skip-link site-wide - CI PurgeCSS cold-start race (no hugo_stats.json on first pass).

## 2026-07-18

* Added course architecture concepts
* Merged blog/site bundle into course bundle

## 2026-07-17

* M2 compression migration
* (later) - Full-course migration complete

## 2026-07-13

* Update: taste anchor established at `.stitch/course-taste-design.md` - Stitch-skill DESIGN.md encoding the cou...

