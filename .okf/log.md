# Bundle Update Log

Newest first. Entries before 2026-08-19 are squashed to one line each
(compacted 2026-08-20); their full text is in this file's git history.

**`okf_validate.py .okf --strict` EXITS 1 on this bundle. It has for some
time.** The command prints `✓ conformant (N warnings)` and that line is true -
conformance (§9) means no ERRORS - but `--strict` fails on any warning, so the
exit code is 1. Reading the friendly line and calling the gate green is the
easy mistake; it was made repeatedly on 2026-08-20/21 before review caught it.
**Check `$?`, not the checkmark.**

**No warning totals are recorded here, deliberately.** Every entry appended to
this file adds a §7 heading warning, so any number written down is wrong by the
next append - it was corrected twice on 2026-08-21 and went stale within one
commit each time.

Measure when you need it, via the SKILL so it resolves whatever validator is
canonical (`/okf:validate .okf --strict`), and count warning RECORDS:

```
<validator> .okf --strict | grep -c '! warn'          # total
<validator> .okf --strict | grep '! warn' | sed 's/.*: //' | sort | uniq -c | sort -rn
```

**Count `'! warn'`, not `'warn'`.** The summary line reads
`✓ conformant (N warning(s))` and matches the looser pattern, so `grep -c 'warn'`
returns one more than the real count - every total published on 2026-08-21 was
inflated by exactly one because of this.

**Derive the classes; do not assume them.** On the validator installed here the
bulk are §7 date headings from this file, with ~22 missing-recommended-field
and one tolerated out-of-bundle cross-link. Review reported a different
breakdown from another build (legacy `# Citations` warnings, no missing-field
ones) that could not be reproduced with either copy on this machine - so run the
classifier above rather than trusting any written composition, including this
sentence.

The date headings are a deliberate deviation. The spec's template is a bare
`## <YYYY-MM-DD>` with bullets beneath, which assumes one entry per day; this
bundle lands several thematic entries per day (12 on 2026-08-21), so bare
dates would produce a dozen identical headings. **Do not collapse them
casually** - the conformant shape is one dated heading per day with the themes
as sub-sections beneath it, which is a restructure of the whole file, not a
find-and-replace.

**This is a known-red gate, not accepted noise, and it is tracked** in
`docs/projects/2608-site-design-system/README.md` under Outstanding. Two jobs
make it green: restructure same-day entries under one heading, and add
`timestamp` to the 23 concepts missing it (anchored to each file's last commit
time, which is verifiable - never invented).

## 2026-08-21 - CSS ships both inline and as a linked file; text search cannot prove a selector applies

Recorded in [architecture/css-pipeline.md](architecture/css-pipeline.md). Eleven
findings across five codex review rounds on PR #537, every one verified against
the tree before acceptance. The count is the finding.

**The mechanism** (unchallenged across all three rounds):
`partials/assets/css-inline.html` emits `<style>`, production adding only
`| minify`; `partials/assets/css-processor.html` emits preload + stylesheet links
to `/css/<bundle>[.min].<hash>.css`, production adding `minify`,
`resources.PostProcess`, and `integrity` on both links (`fingerprint "sha256"`
runs in dev too). Homepage: 3 `<style>` of which 2 are pipeline bundles, 2
`link[rel=stylesheet]` of which one is a `<noscript>` swiper fallback.

**Three naive greps that lie**, each verified: grepping rendered `*.html` for a
class matches the `class="..."` attribute (`c-nav` is on the homepage with zero
matching CSS); grepping `_dest/*/css/*.css` alone misses everything inlined;
counting `rel="stylesheet"` with `rg` scores 3 where a parser says 2, because one
match is inside `<noscript>` and one is the preload polyfill's JavaScript.

**What I got wrong, and why it stopped mattering.** Four successive attempts at a
text-search check were each refuted by the next round: literal `String#scan`
(`'\.c-nav'` hunting a backslash), substring prefixes (`\.c-content-block`
scoring on `.c-content-block__text`), comments and URLs (`idangero` scoring 1
from `http://www.idangero.us/swiper/` in the shipped Swiper CSS), and finally the
one no regex fixes - a token in an unmatched contextual selector, an inactive
media/state rule, or an overridden declaration still counts, and a class added by
JavaScript is invisible to any static read.

So the concept no longer proposes a check. Text search can prove a string is
ABSENT from what a page loads, and that is the only question it settles.

Rounds four and five then rebuilt what replaced it. Routing everything to
`getComputedStyle` was imprecise, and so was the three-row table that followed:
reviews showed each row still overclaiming. The honest version is a five-rung
ladder where every rung states what it does NOT establish - text search proves
ABSENCE only (a hit can be a comment, a URL, or a longer selector prefix); a
CSSOM rule scan proves a rule shipped, not that it can apply inside an inactive
`@media`; `el.matches` proves the SELECTOR matches, not the rule; `getComputedStyle`
proves the value that won the cascade, not which selector produced it nor what is
visible under an overlay; only a pixel sample is a fact about the rendered page.
Every one of those limitations is demonstrated somewhere in this same concept.

The process lesson: the factual mechanism table survived all five rounds
untouched. Everything that failed was prescriptive - an instrument I invented, or
a promise about what an instrument establishes. Describing what the code does is
cheap to get right; telling a future reader what a measurement PROVES is where
the overclaiming lives, and it took five adversarial rounds to stop doing it.

## 2026-08-21 - test the instrument, not just the result

Recorded in [build/test-gates.md](build/test-gates.md), distinct from the NULL
CHANGE rule beside it: a null change does nothing and is at least silent about
it, while a wrong instrument RUNS, returns a plausible number, and gets believed.

The real instance: `okf_validate .okf --strict | grep -c 'warn'` also matches the
summary line `✓ conformant (89 warning(s))`, returning 90 - every warning total
published on 2026-08-21 was one high.

**The rule caught its own draft.** A second instance was nearly recorded:
`grep -rc 'c-button--primary' _dest/public-dev/css/*.css` returning 0, dismissed
as vacuous on the theory that bundles ship inline and never land under `css/`.
The positive control refuted it in one command - `blog-eyebrow`, a class known to
be adopted, returns 13 files through the identical glob. The instrument is valid
and its 0 was true (`c-button` sits in 2 source files that reach 0 bundles). The
accusation was as unevidenced as the measurement it accused.

The control is therefore NOT "run it somewhere else" - re-running that grep
against a production tree proves nothing, since `css-inline.html` inlines the
bundle in every environment and only adds `minify` under `hugo.IsProduction`
(found by codex review of PR #536). The control is **a positive case through the
identical command**.

## 2026-08-21 - stop recording warning totals; they cannot stay true

A sync check found the header's stated total stale AGAIN - 87 written, 88
measured, one entry later. It had already been corrected twice today and went
stale within a commit each time.

The fix is not a third correction. **Any hardcoded count in an append-only file
is wrong by the next append**, and this file's dominant warning class is its own
headings - so writing the number down guarantees a false statement and invites
the next reader to trust it. Both the header here and the tracker in
`docs/projects/2608-site-design-system/README.md` now carry the measurement
COMMAND instead of a number.

What survives is the part that is actually stable: the composition. The large
majority are §7 date headings from this file, the rest are concepts missing a
recommended field, and **a warning that is neither is worth reading**. That is
the useful signal the totals were burying.

Historical log entries keep their measured numbers - the log records what was
true when written, and rewriting that would destroy the audit trail.

## 2026-08-21 - what a self-iterating loop can and cannot do

New concept [workflows/autonomous-loops.md](workflows/autonomous-loops.md),
written from running Phase 1a.4 under `/ralph-loop`.

**The structural limit:** a loop re-feeds one prompt until a completion promise
is true, and ends only on that promise, the iteration cap, or a human cancel.
**An agent concluding the work is blocked cannot end it** - that conclusion just
produces another iteration. So a loop fits work whose completion is mechanically
checkable AND whose scope is known-correct. It has no move for "the
specification is wrong".

1a.4 was the demonstration: one of four scope items was as written, two were
gated by an unnamed design token, and the loop kept iterating past the point
where delivery was blocked - producing investigation and documentation instead
of the merge the prompt asked for. Useful output, but not what "execute until
merged" meant. **Cancel signal recorded: the same blocking question asked in
three or more consecutive iterations.**

**What held up and is worth keeping:** WIP=1 with a codex review before every
merge, and reverting rather than shipping when a change proved null or harmful -
five reverts, including a 41-rule sweep that measured as an AA regression. A
loop rewards visible progress, so revert-discipline is the first thing it
erodes.

Also recorded: put gate traps IN the prompt. The 1a.4 prompt carried the
vacuous-green dtest warning, the compared-count rule and the `--strict` exit
code, and none was violated across the whole run - the loop re-reads the prompt
every iteration, which makes it the cheapest place for rules that otherwise
decay.

## 2026-08-21 - the NULL CHANGE, and empty results that are not absence

Two patterns recurred through Phase 1a.4 often enough to be rules, and neither
was in the bundle. Both now in
[build/test-gates.md](build/test-gates.md).

**The null change: a diff that passes every gate and alters nothing at
runtime.** Four instances in one phase - an eyebrow rule overridden by a
later-loading file, a screenshot assertion excluded from `CRITICAL_TESTS` so it
never ran, a tokenisation of code absent from the production tree, and a
DevTools recipe whose last statement discarded its own result. Every gate here
is built to catch a change doing the WRONG thing; none catches one doing
NOTHING, because nothing is indistinguishable from no-regression. The rule:
before counting a change done, NAME the observable it moves - a computed style,
a rendered pixel, a test that newly runs - and check that one thing.

**An empty query result is not evidence of absence.**
`querySelectorAll('path.fl-shape')` returned `[]` on /services/, which read as
"no shape layer here". Services uses `<rect>`; the homepage uses `<path>`. An
entire theory of an undetectable painter got built on one wrong query, and the
answer was in a rule already edited once. Suspect the query before concluding
the thing does not exist.

## 2026-08-21 - the unidentified /services/ painter, found

Closed the one technical unknown left from the footer work. The painter was
`rect.fl-shape` in the same `.fl-builder-bottom-edge-layer` pattern as the
homepage, filled by `.services-showcase ...` in `pages/services.css` - the exact
rule the broad sweep had converted and I then reverted as "internal".

Two causes, both now in
[architecture/css-pipeline.md](architecture/css-pipeline.md):

* **Homepage uses `<path>`, services uses `<rect>`.** My query was
  `path.fl-shape`, which returned `[]` on services - and an empty result reads
  as "no shape layer here" rather than "wrong primitive". That single wrong
  assumption sent the investigation sideways for a long stretch. Match on the
  CLASS or the layer, never the element name.
* `pointer-events: none`, again, so every hit-test skipped it.

**The technique worth keeping:** force `pointer-events: auto !important` on
`*, *::before, *::after`, then call `elementsFromPoint`. Click-through overlays
become ordinary stack entries. One call found what a geometric element scan, a
pseudo-element sweep and a stylesheet walk had all missed.

## 2026-08-21 - ruby fails AA on dark surfaces, and it gates two phases

Measured, not estimated: `--color-ruby` is **4.10:1 on #000 and 3.67:1 on
`--surface-ink`** - below AA for normal text both times. `--ruby-700` is worse
(2.75 / 2.46). Only `--color-ruby-hover` clears AA on both, and it is named for
a hover state.

Synced into [design/site-palette.md](design/site-palette.md) rather than left in
the project README, because the README is not on the path a session reads. The
concept now carries the table and a standing instruction: **until an on-dark
ruby is named, do not apply a ruby text token to any of the three deliberate
dark surfaces.**

Two phases are blocked by the same unnamed token, which nothing in the plan
connected:

* "ONE eyebrow style" cannot be one style - the canonical form was designed
  against LIGHT surfaces, and applying it site-wide drops two homepage eyebrows
  to 4.10:1. A full 41-rule sweep was written, measured and REVERTED for this.
* Migrating the dark bands to `--surface-ink` makes contrast WORSE, not better
  (`#14110f` is lighter than `#000`), so the footer work cannot ship first
  either.

Neither automated gate catches it: those homepage sections have no contrast
test, and the screenshot suite passes a colour change of this magnitude. The
only reason it surfaced is that the eyebrow sweep was contrast-measured before
being accepted.

## 2026-08-21 - the --rr-* aliases are gone; 1a.4's other half is blocked

**Done:** all 18 `--rr-*` consumer references migrated to canonical names and
the alias block deleted from `foundations/css-variables.css`. Zero visual delta
by construction - each alias was `--rr-X: var(--X)`, an exact 1:1 indirection -
and the suite agreed at 53 screenshots compared, no failures.
`design/site-palette.md` updated from "die next" to gone.

The method is the durable part: the precondition was re-grepped AT THE MOMENT
of deletion (18 -> 0), not read from a doc. A written inventory of those same
consumers had been wrong twice in one review, and `single-post.css` belongs to
the COURSE bundle as well as the blog, so deleting on the doc's word would have
broken both. **Verify a deletion precondition by running the check, never by
reading what the check returned last time.**

**Blocked, and re-scoped:** "footer onto surface-ink" is not a footer change.
Moving it leaves every adjacent dark surface at pure black - measured seams on
homepage and services. Migrating the shape-layer dividers closes those and OPENS
internal ones (`.home-proof` divider vs `.home-services` section). Dividers and
the dark sections they abut have to move together, across 7+ page bundles -
Phase 1b in size. All visual changes were reverted rather than shipping a seam.

Still unidentified: a painter on `/services/` that `elementFromPoint` and a
geometric scan of every element both miss, reporting white against a rendered
black pixel. See [architecture/css-pipeline.md](architecture/css-pipeline.md).

## 2026-08-21 - the footer moved and twelve invisible shape layers came with it

Phase 1a.4 step 1 was a 5-line footer change. It exposed a black band above the
footer that took an embarrassing number of wrong turns to find, and the lesson
is worth more than the fix.

* `architecture/css-pipeline.md` - extended the existing "computed style, not
  source, proves the paint" trap with the layer beyond it: **computed style is
  not enough either.** The band was an FL Builder SVG shape layer with
  `pointer-events: none`, so `document.elementFromPoint` - which is HIT-TESTING,
  not painting - skipped it and reported the white element underneath. It paints
  via SVG `fill`, so no `background-color` grep could see it. And its rule lives
  in `assets/css/PAGES/homepage.css`, a different file from
  `assets/css/homepage.css`, so one attempted fix edited the wrong file entirely.

  What answers "which rule paints this pixel": enumerate `document.styleSheets`
  and ask `el.matches(rule.selectorText)`. Cheaper fallback: sample the rendered
  pixel with `magick -format '%[pixel:p{x,y}]'`. Source grep proves what the CSS
  says, computed style proves what an element resolves to, only the pixel proves
  what the user sees.

Twelve shape-layer rules across nine page bundles were still `#000000`; all now
`var(--surface-ink)`. Recorded the grep that finds them for any future
dark-token move.

## 2026-08-21 - the strict gate has been RED and was being reported green

`okf_validate.py .okf --strict` **exits 1**, and has for some time. It prints
`✓ conformant (N warnings)` - true, since conformance (§9) means no ERRORS -
and that line was read as a pass repeatedly through 2026-08-20/21 without ever
checking `$?`. CLAUDE.md requires this gate before bundle commits, so it was
being reported green while failing. **Check the exit code, not the checkmark.**
Textbook evidence-over-assertion: the human-readable summary and the machine
signal disagreed, and the friendlier one won.

Measured, not estimated: 82 warnings, **57** §7 date headings and **23**
missing recommended fields. An earlier draft of this entry said "33 of ~80" -
itself an unmeasured number in a note whose whole purpose was separating known
noise from real signal.

Also recorded, because it is the opposite mistake: the one "broken cross-link"
warning points at a file that EXISTS
(`docs/projects/2605-.../course-landing-components-2026-08.md`); the validator
declines to resolve outside the bundle and tolerates it under §5.3. Acting on
that warning would have broken a working link. One warning class is real and
was ignored; another looks real and must be.

Header now carries the measured breakdown and the two jobs that make the gate
green (restructure same-day entries under one heading; add `timestamp` to the
23 concepts missing it, anchored to each file's last commit time). Tracked in
`docs/projects/2608-site-design-system/README.md` under Outstanding.

## 2026-08-21 - "tracked separately" was not true; now it is

The DESIGN.md banner written earlier today claimed the full regeneration "is
tracked separately". Nothing tracked it - the 2608 project had no outstanding
section at all, so the only record was a sentence inside the very file that
cannot be trusted.

Fixed by giving it a real home: an **Outstanding** section in
`docs/projects/2608-site-design-system/README.md` with the scope written out
(reconcile the two-layers section with ADR-0003, strip every `--color-primary`
reference including the primary-button spec, restate `.stitch/design.md` as
cover-scoped, and regenerate `.impeccable/design.json` if it encodes the same
palette - `/impeccable critique` now carries the design-review gate and would
score against stale values). Both `DESIGN.md` and
[site-palette](/design/site-palette.md) now point at it.

Worth keeping as a shape: **"tracked separately" is a claim like any other.**
It is the most natural thing to write when deferring work and the least likely
to be checked, because it sounds like process rather than fact. If nothing can
be named as the tracker, the work is not deferred - it is dropped.

## 2026-08-21 - design review is `/impeccable critique`, not stitch

Paul reversed his own instruction the same day: *"i was wrong, you should use
`/impeccable critique`."* Review had established the gap - all three stitch
skills GENERATE (`stitch-design` screens, `stitch-design-taste` a `DESIGN.md`,
`stitch-loop` iterations) and the MCP surface is create/edit/apply with no
critique verb - so routing review there returns a generated screen or an
improvisation. **Stitch stays for generation.**

Switched in `workflows/review-swarm.md`, `design/index.md`, and the two repo
docs on the mandatory path (`docs/workflows/flow-router.md`,
`docs/workflows/new-page.md`). The retraction is recorded at each site rather
than silently overwritten, so a reader who remembers the first instruction
learns why it changed.

**What survived the tool change, and was always the valuable part: the ANCHOR.**
Four design sources, and the wrong one inverts the verdict regardless of which
critic runs. The surface-to-source table, the course-visual precedence rule, and
the render/name-the-anchor/ask-for-a-delta contract are all tool-independent.
The tool was the least durable thing in the rule.

## 2026-08-21 - the routing rule exposed a contradicting design authority

Adding one routing line took five review rounds. The findings were worth more
than the rule.

* **Root `DESIGN.md` contradicts the resolved palette and would have been
  followed.** It frames dark JetVelocity as "normative for new brand/conversion
  surfaces", calls LIGHT chrome "legacy/incumbent", and specifies `#1a8cff`
  primary buttons - against ADR-0003 (light, 2026-08-20) and #518, which DELETED
  that token. An agent building a new conversion page would have gone dark with
  a `var()` that resolves to nothing. Superseded-in-part banner added there;
  full regeneration outstanding. `design/site-palette.md` now NAMES it as a
  known contradicting sibling - an authority that does not name what contradicts
  it leaves the reader to find the conflict by shipping the wrong thing.

* **`workflows/review-swarm.md` - routing text drops the qualifier that made the
  source correct.** Four for four this session: "pages are LIGHT" lost three
  deliberate dark surfaces; "see review-swarm" lost that the loop is
  COURSE-scoped; "three sources" lost the in-post/social fourth; "use stitch"
  lost that stitch has no review verb - all three skills GENERATE. Carry the
  qualifier into the routing line, and check the destination is EXECUTABLE
  before making a route mandatory: a gate an agent cannot run gets improvised,
  which is worse than no gate because it reports as done.

* Same section records the sibling trap: a rule in this bundle is not ON THE
  PATH. `AGENTS.md` routes sessions through `docs/workflows/flow-router.md`, so
  a concept nobody is routed to is read only by sessions already looking.

## 2026-08-21 - design review has a route: /stitch-design

* `workflows/review-swarm.md` + `design/index.md` + `workflows/index.md`, and
  the two REPO docs on the mandatory path (`docs/workflows/flow-router.md`,
  `docs/workflows/new-page.md`) - **design review routes through
  `/stitch-design`** (Paul, 2026-08-21). It reviews against the DESIGN
  SYSTEM rather than against taste, which is what a generic critic gives and why
  generic critics keep proposing recolours the anchor text already ruled out. It
  is also the consult for a critical call that is genuinely unclear - input
  before deciding, not instead of deciding; decide-don't-wait still holds.

  Recorded with two boundaries, because both are easy to get wrong: it
  COMPLEMENTS the rendered gates rather than replacing them (baselines check
  what shipped, stitch checks what was intended - a change can match its
  baseline exactly and still be wrong against the system), and its output is
  scoped like any critic's, a punch-list rather than a licence to redesign.

Review then found two things the first draft got wrong, both worth keeping:

* **It named no design SOURCE, and there are three.** `.stitch/design.md` is
  the DARK "Obsidian Engine" COVER system; site chrome is LIGHT
  ([site-palette](/design/site-palette.md), ADR-0003, confirmed by Paul
  2026-08-21); course pages use `.stitch/course-taste-design.md`. Loading the
  cover system to review a page yields exactly the recolour ADR-0003 rules out
  - the failure the route exists to prevent. A surface-to-source table now
  leads the rule.
* **The rule was in the bundle but not ON THE PATH.** `AGENTS.md` sends every
  session through `docs/workflows/flow-router.md`, which routed HTML/CSS to
  css-consolidation only; `new-page.md`'s Evaluate step named Impeccable
  alone; and this playbook's own step 2 still spawned a generic DESIGN critic.
  An agent following the canonical flow would never have seen it. Recording a
  rule in the bundle is not the same as putting it where a session that is not
  looking will hit it.

Deliberately NOT recorded: that a parallel PR currently owns the Linux baseline
re-record. The accepted-debt POLICY is already in `build/test-gates.md`; who
holds the work this hour is a state snapshot and would rot within days.
## 2026-08-21 - descriptions finished, R-queue restocked, and a GSC metric that lies

- **GSC page-level CTR is usually an artifact** - added to
  [analytics-access](/workflows/analytics-access.md). A page row and its query
  breakdown disagree by ~30x because GSC anonymizes low-volume queries:
  `rails-virtual-attributes` shows 7,902 impressions / 0.09% CTR at page level,
  but its named queries total 265 impressions at position 3.7-5.9 with 4.26% CTR
  on the head term. Rule: compare named-query total against page total before
  calling anything a CTR failure. The rule is ONE-WAY - `named ≪ page` means the
  page CTR is noise, but the converse is not licensed and no clean inverse case
  has been found in this data.
- **A pre-merge review falsified the "inverse case" this entry originally
  claimed** (PR #524). The Falcon post was written up as a real snippet failure
  at "804 named impressions / 5 clicks / 0.62%". Re-pulling: 804 came from a
  truncated `row_limit=20` call (real named total 920), and the 5 clicks / 0.62%
  were named-query totals quoted as page performance - the page takes 37 clicks
  at 1.03%. Named 920 vs page 3,590 = 26%, so it is the SAME artifact as
  rails-virtual-attributes. Two durable traps recorded in the concept: the row
  limit silently truncates the denominator, and `totals` sums only returned rows.
- **All site descriptions are now untruncated, and the earlier count was wrong.**
  36 written by hand. 19 of them were missed by every prior pass because their
  `...` sits inside single quotes (`description: 'foo...'`), which
  `/\.\.\.$/` never matches. Found only by grepping RENDERED meta tags, not
  source - the rule this repo already states for text ratchets. Verified 0
  remaining across `name="description"`, `og:description` and
  `twitter:description` site-wide.
- **The 2510 R-queue is empty and replaced by §13** of the content plan,
  restocked from live GSC. Headline: fix what already ranks before publishing
  more - named-query clicks across the property are in the low hundreds per
  quarter while pages sit unclicked at positions 3-8.

## 2026-08-21 - what three review rounds taught, lifted from the PR into concepts

#519 took three Codex rounds (8, 7, 9 findings). None cosmetic. The durable
part is not the individual fixes - those shipped with the PR - but why a
docs-only change needed three passes.

* `workflows/review-swarm.md` - **a correction is an edit, and it can break
  what the file already held.** Round three's findings were largely defects
  that rounds one and two INTRODUCED: adding "phase status comes from git" left
  a sentence four lines away still routing to the plan doc; adding a corrected
  click figure left the superseded one earlier in the same file. The correcting
  mindset asks "am I right here now" and does not look sideways. Re-read the
  whole file, not the paragraph. Plus: **sweep a corrected metric through the
  canonical summaries** (the README and the plan's own justification still
  carried the superseded figure, and those are read FIRST), and **budget more
  than one review round for docs** - prose has no compiler, so a reader
  checking claims against the tree is the only gate there is.

* `workflows/analytics-access.md` - **cut a measurement window on the DEPLOY,
  not the MERGE.** The first correction used #487/#494 merge timestamps as
  proof a Clarity window was contaminated. A merge is not a release: Pages
  publishes from a separate run that can lag, fail or be re-run. This cuts both
  ways - it can condemn a usable window as easily as bless a contaminated one.
  Read the deployment record; if you cannot, mark the window
  contaminated-pending-confirmation with the restore condition written down.

## 2026-08-21 - the Hugo trap behind the analytics finding, lifted from spec to bundle

The Codex round fixed the 2608 specs. One of its findings was a durable CODE
fact that was left sitting in a project doc where template work would never
find it.

* `architecture/hugo-site.md` - **a permalink rewrite does NOT change
  `.Section` or `.Kind`.** The taxonomy is declared `tag = "tags"` and only
  `[permalinks.term]` rewrites the URL, so a page served at
  `/blog/tags/rails/` still has `.Section == "tags"`. Every
  `eq .Section "blog"` condition therefore MISSES tag pages while reading as
  though it covers them - the URL says blog, the page object does not. A
  proposed analytics gate was written exactly this way.
* `architecture/blog-list-page.md` - the same drift in a second form. That
  concept already records the index and tag templates drifting apart in MARKUP
  and being unified by shared partials. Unifying markup did NOT unify
  PREDICATES: a `.Section` guard added anywhere still covers one and skips the
  other. Also noted the inline `!important` H1 styles still at `list.html:51,70`.
* `design/site-palette.md` - two fixes. `--color-primary` no longer "dies in
  1a.2"; it is GONE as of #518, and the seven surviving matches are comments
  recording what each rule replaced, which a careless grep reads as survival.
  And the `--rr-*` alias deprecation was missing entirely: it now names the
  three live consumers and the rule that matters - **verify by grep at deletion
  time, never against a written inventory.** That inventory was wrong twice in
  one review, and `single-post.css` is in the COURSE bundle, so an early
  deletion breaks blog and course together.

## 2026-08-21 - Codex review killed a claim I had already published

All eight findings verified against the tree; all eight valid. The one that
matters reached the bundle before review caught it.

**`workflows/analytics-access.md` corrected - the "Clarity disagrees with
itself" claim was a denominator mismatch.** The write-up said per-page numbers
contradict the aggregate "for an identical window and page-set" (~9% vs 25.56%,
"~3x"). They are NOT the same page-set: ~9% was session-weighted over the TOP
TEN pages, 25.56% covers EVERY `/blog/` page. The omitted long tail can account
for the whole gap. Nothing was demonstrated, and per-post analysis was never
ruled out - it needs the full page rows retrieved.

The violation is that the section states "state the denominator" as its rule,
and the mismatch was written INTO it. Recorded in the concept as a worked
near-miss rather than deleted, because the shape recurs: the API returns a
top-N subset by default and the aggregate on request, so comparing them is the
most available thing to do.

Other findings fixed in the 2608 specs (not bundle concepts): a `--rr-*` alias
inventory that omitted a live consumer and named a file with zero references -
deleting the aliases on it would have broken CTA/tag styling on blog AND course;
an analytics gate using `eq .Section "blog"` that cannot match tag pages
(`config/_default/hugo.toml:37-41` rewrites the term PERMALINK but the taxonomy
is `tag = "tags"`, so `.Section` is `tags`); inline `!important` H1 styles left
in `themes/beaver/layouts/list.html:51,70`; and advice to probe three
`!important`s for removal that fight legacy heading-margin rules, not the
retired anchor rule - `20.02:69-81` records that distinction and removing them
would restore a title-alignment regression.

Also recorded, not silently ignored: the macOS-only gate KNOWINGLY departs from
`CLAUDE.md:148`. The override is Paul's (CI unreliable, 2026-08-21) and its cost
- master's Linux job red until one batched dispatch - is now stated in the spec
rather than left for a reader to discover.

## 2026-08-21 - the deferred pass, and two of my own claims corrected

Ran the pass queued on #516 once that PR merged (it could not run earlier: the
session was checked out on #518, where this bundle state did not exist).

**Corrections to `workflows/site-redesign-rollout.md`, written four passes ago:**

* The engagement figure. The concept repeated the plan's "25.2% scroll / 26.3s
  vs a 32.9-40.3% site average". Measured: that is ONE 3-day Clarity window of
  five and the lowest, the windows swing 2.9x, and session-weighted across 743
  sessions the blog is at **44.31% / 34.97s** - at or above the average it was
  said to trail. It also straddles the 08-20 deploy; the clean pre-ship figure
  is 08-06->08-17, 451 sessions, 56.4% / 40.1s. Blog-first still holds, on a
  better fact: GSC puts the blog at 77% of the site's Google traffic.
* The course coupling. The concept repeated 20.01's "2.2 couples the course
  page". True of the FILE, false of the SELECTORS: `course/single.html:55` has
  no `.post-article` and all 15 styled rules are `.post-article`-prefixed.
  DECOUPLED - 2.3 need not follow 2.2. The genuinely shared file is
  `single-post.css`, which also drives `bin/generate-template-pdfs`.

Both were inherited from the plan doc without independent verification, which
is the same failure the new "check phase status against GIT, not the plan
table" rule now names: Phase 2.1 and 2.2 had ALREADY SHIPPED (#487, #494, both
2026-08-20) while the plan still listed them pending, and a status answer was
given from the table.

**Added:**

* `build/test-gates.md` - a `skip_area` mask blinds a gate STRUCTURALLY where
  tolerance blinds it statistically: all four blog-index screenshots mask
  `.post-feature`, which IS the feature slot, so the index content area has
  never been gated. Plus the local-gates-are-authority policy with its stated
  Linux debt, and "quote the compared COUNT, not just 0 failures".
* `workflows/analytics-access.md` - `/blog/` fires no `scroll_depth` at all
  (`page/analytics.html:72` gates on `.IsPage`), and the 3-day-window trap with
  the session-weighting and straddles-a-deploy rules.
* `workflows/review-swarm.md` - non-colliding agents can still collide with an
  unmerged branch, and never switch branches under a running agent.

## 2026-08-21 - new concept: the rollout SEQUENCE was undiscoverable

`design/site-palette.md` carried the palette decision, but nothing in the
bundle carried the ORDER it ships in. A session consuming `.okf/` after
Phase 1a.3 would reasonably do 1a.4 next - and that is the wrong order:
Paul re-sequenced 2026-08-20 to run the BLOG before the site-wide chrome.

New [workflows/site-redesign-rollout.md](workflows/site-redesign-rollout.md)
distils the three rules that decide sequence (order by whether LAYOUT MOVES
not by size; no A/B exists at this traffic so reversibility substitutes for
statistical confidence; blog first because that is where the humans are), the
cost blog-first accepts on purpose (token definitions move twice - duplicate
tokens mid-rollout are the plan working, not a mistake), and the gates that
block regardless (2.4's GSC keyword gate; 2.2 coupling the course page).

Live phase status deliberately NOT copied - it rots; the plan doc under
`resource:` owns it. Cross-linked from site-palette.

## 2026-08-21 - maintain pass 3: three rules the og:image PR taught, lifted

* `build/test-gates.md` - the `.gitignore` bullet now covers SUBdirectories
  of a tracked dot-dir (`.stitch/*.md` tracked, `.stitch/designs/` ignored),
  and records that `git add <path>` ERRORS on an ignored path while
  `git add -A` silently omits it. Staging by explicit path is the safer
  default whenever a commit's value depends on a specific file landing.
* `architecture/seo-meta-tags.md` - added the og-plate regeneration recipe
  and the md5 proving the SVG is the source of record, not an approximation.
* `index.md` - when two sessions verify one concept concurrently, a rebase
  conflict on `verified:` is resolved by keeping BOTH entries. Dropping one
  falsifies the provenance the field exists to carry.
## 2026-08-21 - Two gate lessons from merging six PRs: the stall masks, the local red lies

Both are sharpenings of rules the bundle already had, and both came from the
same PR (#511) during a queue-clearing pass.

**The checkout stall can hide a real failure behind it.** ci-gates already said
"re-run, don't raise the cap" and "if the job got past checkout it is a real
failure". Necessary, not sufficient. #511's `Unit Tests` read `fail 10m2s` - the
stall signature exactly - and the tempting call was "known flake, merge". The
fresh run got past checkout and failed again in **1m48s** on a genuine defect:
`PavedPathGuardTest` caught `friday-report.css` wired into `bin/qtest` but
missing from `css-bundle-ownership-map.md`, which is the other half of
new-page.md step 6. Same check, same PR, two unrelated causes. The rule added:
**a slow failure and a fast failure are different failures** - multi-minute with
no assertion output is infrastructure, fast with an assertion is the code, and
the first red's explanation must never carry over to the second.

**A local visual red cannot condemn a branch until master has been run the same
way.** `bin/qtest --changed` on #511 went red pointing at
`services/fractional-cto` - a page the PR never touched - and the available
story was that its `postcss.config.js` edit had shifted CSS site-wide. It had
not: the edit only ADDS purgecss safelist entries, and safelisting more can only
preserve more CSS, never remove any. The check that settled it was the same
system test on clean `origin/master` on this macOS host: **34 runs, 6 failures,
8 of 77 screenshots mismatched.** The suite is red on master here, so the local
leg was unusable for the question. CI's native-Linux Screenshot Tests passed
#511 in 16m15s; CI was right and local was noise. Also worth knowing: the run
rewrites two of those baselines mid-run and then fails its own dirty-check, so
`git checkout -- test/fixtures/screenshots/` never converges.

**Half-wired page bundles are a real recurring class.** The guard exists because
`docs/workflows/new-page.md` step 6 has two halves - `bin/qtest` PAGE_TESTS and
the ownership map - and #511 did one. Anyone adding `themes/beaver/assets/css/pages/*.css`
does both or the guard reds.

**Repo hygiene:** #505 landed two Phase-1a verification PNGs (392KB) at the repo
root. Every other screenshot in this repo lives under `docs/projects/<project>/`.
Removed in #514. Binary at the repo root is the kind of thing the next session
copies because it looks sanctioned.

## 2026-08-20 - maintain pass 2: a claim I wrote was wrong in three files

Review found "a fixed attribute sequence silently skipped 480 tag pages"
false - measured, 0 pages were missed entirely; what was dropped was the
content-first SECOND tag on those pages, losing one distinct image. The
wrong number had already propagated from the test comment into
`build/test-gates.md` and this log. All three corrected. Lesson lifted to
[workflows/review-swarm.md](workflows/review-swarm.md): brief critics to
return measurements, and scrutinise the prose describing a fix as hard as
the fix. Also dropped a `CGI.unescape` that was a no-op on every url in the
build and could only misfire (it decodes `+` as a space, a form rule that is
wrong for paths).

## 2026-08-20 - maintain pass: two concepts corrected against the code

* `architecture/seo-meta-tags.md` `resource:` and its citation pointed at
  `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` - a path that
  DOES NOT EXIST (that dir holds only schema partials). Repointed at the
  live root-level override `layouts/partials/seo/enhanced-meta-tags.html`.
  Also corrected `.Resize "1200x630 webp q85"` -> `jpg q90` (WebP unfurls
  blank on LinkedIn), and documented the site-default fallback + its test.
* `build/test-gates.md` gained the `--cleanDestinationDir` caveat lifted out
  of the entry below, per this bundle's own rule that log.md records what
  changed and concepts record what is true.
## 2026-08-20 - 553 pages previewed blank on social; the tests that should have caught it asserted the wrong thing

**The site-wide `og:image` fallback pointed at a file nobody ever uploaded.**
`layouts/partials/seo/enhanced-meta-tags.html:129` defaults to
`https://jetthoughts.com/assets/images/og-default.jpg`; `static/assets/`
did not exist. 553 pages - overwhelmingly blog posts without cover art -
rendered a social card that 404'd, so every LinkedIn and Slack share of them
previewed blank. Nothing on the site links an `og:image`, which is why it
survived: it is the one asset class no crawler, no link-checker, and no
reader ever exercises.

**Why the existing gate could not see it.**
`test/unit/meta_tags/meta_tags_test.rb:136-149` asserts the tag EXISTS and
that width/height are `1200`/`630`. Both passed throughout. That is an
existence-plus-config assertion of exactly the kind CLAUDE.md rejects: it
describes the markup, never the thing the markup points at. New
`test/unit/og_image_resolves_test.rb` sweeps RENDERED HTML for every
`og:image`/`twitter:image` and resolves each SAME-ORIGIN path against the
build. Same principle as the rendered-output rule for text ratchets.
Off-origin CDN URLs (`wsrv.nl?url=raw.githubusercontent.com/...`) are
deliberately not followed: `enhanced-meta-tags.html` only emits them inside
`{{- if $resource -}}`, so the build already guarantees the source resource
exists, and what is left is a publish-time network question.

**A rendered-output sweep can look thorough and check almost nothing.**
The first version matched `property="..." content="..."` as a FIXED
attribute sequence. Two facts collapsed that to a single URL checked out of
1297 tag matches: 682 of 683 distinct values are off-origin CDN URLs that
fell through the same-origin filter, and the two theme partials
(`themes/beaver/layouts/blog/list.html:23`,
`themes/beaver/layouts/partials/page/cover_image.html:3,:11`) write
`content=` BEFORE `property=`, dropping the content-first tag on 480 pages
(they still matched via their property-first tag - what was lost was one whole
distinct image, not the pages). The
test was `File.exist?` on one path wearing a 1757-file glob. It passed RED
and GREEN honestly, because the one path it checked was the defect under
repair - a reproduction test can be genuinely red for the right reason and
still cover nothing else. Match whole `<meta>` tags and extract `content`
separately; count the DISTINCT URLs a sweep actually resolves before
trusting its breadth.

**What this test structurally cannot catch.** If a page resource is
missing, Hugo does not emit a dangling `og:image` - the `{{ if . }}` /
`{{ with }}` guards drop the tag entirely, so the page silently ships with
NO social image. Deleting `content/blog/og-blog.jpg` (480 tag pages) proved
this: the sweep stayed green because the reference vanished rather than
broke. Dangling-reference and missing-tag are two different defects; this
gate covers only the first.

**The false GREEN worth remembering.** After writing the test I deleted the
JPG to confirm RED - and it stayed green through three attempts. First
diagnosis (warm tree, build skipped) was WRONG: `bin/build-if-stale` detects
deletions correctly. The tree rebuilt every time and still served the file,
because no local build path passes `--cleanDestinationDir`. Rule lifted to
[build/test-gates.md](build/test-gates.md) - it is not a log fact, it
governs every rendered-output test from here on.

**Fix:** a branded 1200x630 brand plate at `static/assets/images/og-default.jpg`
(JetVelocity obsidian/ruby per `.stitch/design.md`, canon figures only). It is
deliberately NOT the campaign pitch the first draft carried - a fallback
stands in under arbitrary technical posts, where "Your dev shop stopped
delivering" over a Puma-config article reads as an ad rather than an article.

**CI, adjacent:** clarified in `build/ci-gates.md` that `filter: blob:none`
must NOT be copied into the other five workflows. `_hugo.yml` is the only job
setting `fetch-depth: 0`, and the filter's entire win is skipping historical
blobs; the rest run at depth 1, where there is no history to skip and git
must still materialise every blob at HEAD. Their slow checkouts are the
625 MB of images in the tree, not a missing flag.

Touched: `build/ci-gates.md`.

## 2026-08-21 - The course's "good positions" were an artifact; GA4 UI setup closed out

**Course discovery diagnosed, and the inherited premise is retracted.** Two
reads (Aug-14, Aug-20) recorded "course 60+ URLs at good positions (5-13)",
which reads as a CTR problem. Live GSC says otherwise: GA4-style position is
averaged over impressions, so the best-looking course rows are the emptiest -
`form-your-founding-hypothesis` reports position 3.0 on ONE impression. Of the
six queries GSC will name across all course pages in 28 days (62 impressions),
57 come from `"stripe / collison" anti-reference` and
`dashboard.stripe.com/screenshare`; the four real queries total five
impressions at positions 42-97. The one course page with a real high-volume
target sits at position 26.6/32.6 over 90 days. Meanwhile the domain ranks fine
for Ruby/Rails/AI queries. **Topical authority, not CTR, not indexation** -
which is also why the falsified title/meta experiment could never have worked.
Retracted the stale clause in all three places carrying it. Full diagnosis:
2605 `50-59-execution/50.05-course-discovery-diagnosis-2026-08-21.md`.

The asymmetry worth acting on: AI Assistant delivered 34 sessions at 79%
engagement in the window against 2 from the LinkedIn course campaign, and the
course landing is the 15th most-landed page on the site without ranking for
anything. LLM retrieval matches on content, not on the domain authority the
course lacks.

**All four GA4-UI items done** (see [analytics-access](/workflows/analytics-access.md)):
`page_view` un-marked as a key event, two shared Explorations, a Reports
snapshot dashboard (the property had never had one), and a red bot-caveat
annotation. New traps recorded there: un-marking a key event is **not
retroactive**, annotation descriptions cap at 150 chars and truncate mid-word,
and the annotation date field fills its END slot when you type into it.

**Artifact-trail palette pass was 1 file, not 5.** The C2.2 follow-up assumed
green was landing on non-money cards across the five module trails. Rendering
all five side by side showed four already follow one learnable rule - exactly
one tinted card per trail, the module payoff, green when it is money and purple
when it is not. Only M2 broke it, tinting three of five. Green big-text on
BUILD/PASS was left alone: the spec's short line says "money only" but its own
table says "money/success outcomes", and it reads consistently in every trail.
*Render the set before believing a spec-vs-artifact complaint - the complaint
was half right and the fix was 1/5 the size.* Also renamed `.pay` -> `.done` in
the three purple trails, where the name was lying; hashes identical before and
after.

**Two "defects" that were not defects.** M2's duplicate `2.5` chips and M3's
3.1/3.1/3.2/3.2 look like copy-paste bugs and are correct: lesson 2.5 produces
both the BUILD verdict and the money answer, and module 3 has two lessons with
two artifacts each. Verified against each walkthrough's own lesson links before
"fixing" anything.


## 2026-08-20 - Three publishing gates, all learned from claims we shipped wrong

Added to [blog-pipeline](workflows/blog-pipeline.md), because all three are
gates rather than background:

1. **Technical claims must be executed, not read.** Every wrong technical
   claim shipped this day came from reading source and inferring behaviour.
   The Kamal 2 guide (#506) opened by asserting a stale `traefik:` key sits
   in `deploy.yml` doing nothing; `kamal config` answers
   `ERROR (Kamal::ConfigurationError): unknown key: traefik`. The bad
   inference came from `Validator::Configuration#allow_extensions? => true`,
   which governs YAML extension keys and not arbitrary config keys. Same
   post told readers to find a mistyped secret with `kamal config`, but
   `Configuration#to_h` emits no `env` and no `proxy`, so it exits 0
   unchanged - the gem's own stale `desc` string was inherited untested.
   A reviewer who ran the command falsified an opening thesis that
   source-reading passes had approved.

2. **Frontmatter is published copy.** #509 shipped live: the body was
   softened to "whether the model was being retired or quietly
   substituted" while `twitter_description` still asserted "a retired
   model took out five features at once". The softening reached the prose
   and not the metatags, so the page kept the claim the edit existed to
   remove. Diff meta against body before merge.

3. **Citation lists use `## Sources`.** 4 posts already used it; 16 had
   drifted across `## Further reading`, a bare `Further reading:`
   paragraph, and a bold `**Further reading:**` line (#510). The bold
   variant survived the first survey because the grep only matched the
   other two - a partial sweep reads as a finished one. Internal links
   belong in body prose or the theme's `Read next`, not in this list.

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


## 2026-08-20 - Site palette concept added; compaction verified non-lossy

Checked today's knowledge against the #504 bundle compaction (359KB -> 191KB)
before adding anything: the token layer, the img-cropped mobileWidth params,
the blog-list traps, record-baselines and the GA browser-channel distinction
all survived IN CONCEPTS rather than only in the log, which is the outcome the
compaction was aiming for.

One real gap remained, and it was in the section a cold session reads first
for visual questions: `design/` had NO site-palette concept. house-visual-spec
is in-post SVG artwork and cover-pipeline is covers, so "what palette does the
site use?" resolved to nothing there - the LIGHT decision lived only in
docs/adr/0003 and, since the previous pass, architecture/css-pipeline. Added
design/site-palette.md with the decision, the audience-shaped reasoning that
predicts future calls, the token table, and - importantly - the three surfaces
where dark stays deliberate, so a future session doesn't "fix" the blog covers
or the vibe-code-rescue campaign page into light.

## 2026-08-20 - CI checkout stalls: UPSTREAM (checkout#2441), mitigated with blob:none

Three CI failures in one session - Unit Tests at exactly 10m twice,
build_and_deploy/build at 15m1s - every one inside
`##[group]Fetching the repository` ending `The operation was canceled.` Each
plain re-run completed the same job in 2-3 minutes. ci-gates already documented
checkout being SLOW (7 min observed) and the timeouts raised to 15/25 because
of it; what it lacked is the distinction that matters operationally: this is a
HANG, not slowness. A cap cannot rescue a step that never progresses, so the
response is re-run-and-verify, and raising the timeout again would only make
each failure cost longer. Rule added with the log-check to confirm it before
re-running, so nobody re-runs a job that actually failed for real.

ROOT CAUSE FOUND (same day, on Paul's hunch that a checkout upgrade was at
fault - he was right that it was the action, wrong about it being our
version): actions/checkout#2441, open since 2026-05-19, silent stalls of
15-25 min on EU runners killed by timeout-minutes. Not our config, not
fixable by us. What IS ours is how much we ask for: a 1.70 GiB pack and a
625 MB content/ tree (1,576 images) downloaded by every job. _hugo.yml needs
fetch-depth: 0 for enableGitInfo, so it now also sets filter: blob:none -
measured 4.7 MB / 1.1s bare blobless vs 1.70 GiB, with
`git log -1 -- <post>/index.md` still returning the right date in 0.02s and
zero blobs fetched, so GitInfo is unaffected. Mitigation, not cure; the real
floor is 625 MB of images in git, which is a separate LFS/CDN decision.
## 2026-08-20 - #1a8cff IS the logo; a mark colour is not a UI accent

Lane A stopped mid-codemod rather than recolour brand assets, and the reason
it gave turned out to correct the ADR: after deleting --color-primary the only
#1a8cff left in built output was SVG assets, including the logo. Verified -
logo-dark.svg contains exactly one hex value, #1a8cff. So the token was
EXTRACTED FROM THE MARK, not invented, and ADR-0003's "appears in no brand
definition" was overstated (true of the documented design system, false of the
actual logo).

The decision survives with a sharper reason: a mark colour is not a UI accent.
The logo identifies, the accent directs. Promoting the mark's blue to
"primary" is exactly what produced blue bands, blue tags and blue links on a
ruby site. The three logo files stay blue and are OUT OF SCOPE for every
design-system phase - not deferred, out of scope; changing a mark is a brand
decision.

Two things worth carrying forward. **SVG assets cannot read CSS custom
properties**, so ~29 hardcoded icons are invisible to token work and a
site-wide recolour must sweep them separately or strand them on the old
palette - 20.02 measured CSS references and literals and never counted SVG
assets, a gap in the plan not in the execution. And the agent-design lesson:
the brief told Lane A to resolve consumers BY ROLE, and the role table had no
row for brand assets - so it halted and asked instead of inventing a row. A
role table is also a permission boundary; anything without a row is a question,
not a judgement call.

## 2026-08-20 - "Same class of fight" is not "same cause"; body links decided

Two corrections to my own Phase 1a plan, both found by the agent executing it
rather than by me writing it.

**The success signal was unfalsifiable in the dangerous direction.** 20.02 said
"delete all 55 !important workarounds" as the proof 1a.3 worked. 55 counted
every !important in four files; only ~19 are anchor-attributable. The rest are
@media print rules and legacy heading-margin fights, so chasing the number
would have deleted print styles to hit it. The trap is worth naming because it
will recur: blog-single.css's own comment says its fights are the "same class
of fight as the #0066d6 anchor rule - both die in Phase 1a". Same CLASS,
different CAUSE. A metric derived from a comment's phrasing rather than from
the cause it names is a metric that rewards damage.

**#0066d6 was an accessibility fix, not just a specificity monster.** It
replaced --color-primary in Sprint #2 because #1a8cff measured 3.37:1 and
failed AA. I had been describing it purely as a late-cascade monster, which
would have licensed replacing it with anything non-blue. Retiring it means
landing the replacement at AA or better.

**Body links decided: --ink-900 text, --color-ruby underline.** Not ruby text -
ruby is the action colour, and a body full of ruby links stops links being
distinguishable from buttons. WCAG 1.4.1 requires more than colour to mark a
link, so the underline carries the affordance and the text stays calm for
long-form reading. Recorded in design/site-palette.md with a do-not-simplify
note, since the obvious "tidy-up" is to make it a coloured link again.

Also verified by eye, which settled a sequencing question: with 1a.2 alone the
services page shows ruby icons beside blue card titles - visibly incoherent, so
1a.2 and 1a.3 ship as separate commits in ONE PR. And the blue logo against
ruby accents reads as intended: it identifies rather than competing.

## 2026-08-20 - The white-wash trap, and why four review agents died

Two durable findings from the 3-lane redesign swarm.

**Computed style, not source, proves the paint.** Two sections of the new
/friday-report/ page computed to background-color rgba(0,0,0,0) - the white
behind them was legacy-theme-skin.css's hardcoded .fl-page-content, which
ships after the page slice and wins on cascade order. Zero visual delta today
because both are #ffffff, which is exactly why it would have sat there
undetected; it detonates the moment a --surface token moves off white, leaving
a half-recoloured page caused by a file nobody touched. Recorded in
architecture/css-pipeline.md with the detection method and the id+class fix
from new-page.md. Same family as the uppercase #1A8CFF that survived a
case-sensitive sweep: verification resting on grep alone verifies the wrong
artifact.

**Review agents failed 4 of 6, and brief size looks causal.** Every failure was
a Fable credit limit; work agents survived because they carried an explicit
opus override while the reviewers they spawned inherited the default. The
asymmetry is the real hazard - work completes and reports success while its
gate quietly does not run. The lane that dispatched four of them noticed the
three that died had long briefs and the one that returned a verdict had the
tightest. A credit limit is consumption-based, so a longer prompt burns budget
faster, which makes the sprawling thorough-looking brief LESS likely to produce
a review. Rules recorded in workflows/review-swarm.md: dead reviewer is not a
passed review; idle is ambiguous so ask for the verdict; pass model opus
explicitly; a coordinator closing a leg itself must say so and invite
contradiction.

## 2026-08-20 - GA4 key-event toggles closed by another session; not retroactive

#508 un-marked `page_view` as a key event and #495 marked `contact_cta_click`,
closing the Phase 0.1 GA4 items I had been reporting as blocked on a browser
channel. Synced 2608's plan and README, which still described the polluted
state as current.

The caveat that survives the fix is the part worth carrying: **un-marking is
not retroactive.** The ~4,063 historical page-view "key events" stay in the
data, so any before/after read spanning 2026-08-13 to 08-20 compares a polluted
before against a clean after. Date-bound every keyEvents query, or read the
underlying event names rather than the aggregate. A fix that changes only
future collection is not a fix to the series you are about to analyse.

## 2026-08-20 - The stalled checkout is a hang, not a slow clone - make it fail fast

Asked to "optimize the slow checkout" on a 7-minute `Asset Pipeline` job. The
optimisation was the wrong frame, and the histogram said so before any code
changed: across 170 checkout steps in the last 40 `publish.yml` runs, **137
finished in 12-19s** and the bad tail piled up on **599s and 899s** - which
are exactly the 10- and 15-minute `timeout-minutes` values. A duration that
lands precisely on the cap did not run slowly; it never ran. Evidence: run
32407671265 logs `git fetch` at 19:15:42 and `The operation was canceled` at
19:30:41, with **zero output in between**.

That reframes every "make the clone smaller" lever as beside the point. In
particular the obvious one was already spent: **every job except
`_hugo.yml / build` was already at the default `--depth=1`**, and run
32414801788 hung 10 minutes on a shallow fetch. The one job that needs
`fetch-depth: 0` needs it for `enableGitInfo` -> `.Lastmod`, so it cannot go
shallow either. Nothing left to shrink.

The fix works with the grain of the tool instead of around it: `actions/checkout`
**already retries a failed fetch three times** (`src/git-command-manager.ts`
wraps `fetch` in `retryHelper`) - it just never fires, because a hang is not a
failure. So make the hang a failure. `http.lowSpeedLimit=1000` +
`http.lowSpeedTime=30` abort a transfer that stops moving, and checkout's own
retry recovers. No new action, no dependency, no per-step retry scaffolding.

Two mechanics that would have silently no-op'd this:

* It must be **`GIT_CONFIG_*` env, not `git config --global`.** Checkout logs
  "Temporarily overriding HOME=..." before it runs git, so a global config set
  by an earlier step never reaches it. The env form survives the HOME override.
* **Reusable workflows do not inherit the caller's env**, and neither do
  sibling workflow files. Six workflows check out; six copies of the block.

The habit worth keeping is the last step, not the first: a config you can only
*read back* is not a guard. Verified both directions against the real remote -
at an absurd 100 MB/s floor a healthy fetch aborts with `curl 28 Operation too
slow` (exit 128, an error `retryHelper` catches), and at the shipped 1 KB/s
floor a real fetch of master completes clean. Reading the value back would have
"passed" either way, including if the knob were inert.
