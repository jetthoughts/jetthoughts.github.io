# Bundle Update Log

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

## 2026-08-17 (bet status) - Vibe Code Rescue Parked, Nov 30 suspended

* **Parked until September 2026** (Paul). The vault frontmatter
  (`state: postponed`) was correct and every "Validating" claim was stale - the
  reverse of what the audit assumed. Fixed in the vault body,
  `opportunity-portfolio.md`, `AGENTS.md` (which was routing agents into the
  bet via "active bet ▶ START HERE") and `2607/strategy.md`.
* **No bet is in Validating, by design.** Do not promote a candidate to keep
  the slot warm.
* **Nov 30 target SUSPENDED, not rescheduled.** KR1 was green (offer, partner,
  pricing, booking link) while KR2-KR4 sat at zero and zero touches were ever
  sent across four unparked weeks - the deadline was never the binding
  constraint, execution was. A new date now would attach a schedule to unscoped
  work. Set the target at the September restart instead.
* **The Sep 30 mid-point gate is suspended and must be RE-SET, not dropped** -
  it would have fired "≥3 calls else re-open ICP + channel" against a bet that
  restarts *in* September, and it is what makes a re-plan falsifiable.
* ~9 remaining "Nov 30" strings in `docs/projects/2607-*` and `2510-*` are
  stale-by-decision; they get rewritten once, at restart, in one pass.

## 2026-08-17 (company-layer ownership settled) - vault vs repo vs canon

* **New concept**: `workflows/company-layer-ownership.md` - the three-surface
  split. Vault owns identity/positioning/bet status; the repo owns the weekly
  loop (`operating-system.md` incl. OKR §3 and rocks §4); `claims-canon.md`
  owns company facts.
* **Why narrow, not broad**: the 2607 runbook/backlog/pipeline/booking-page
  specs all bind to `operating-system.md` §1/§7 - moving the OKR to the vault
  would break those bindings.
* **The load-bearing carve-out**: the vault's Positioning line carried "since
  2011" and "4.8/5 from 32 clients", both BANNED in
  `test/unit/marketing_copy_test.rb`. Its "edit here, reflect in the repo"
  flow would have laundered them back days after they were removed from 13
  blog posts. Corrected in the vault; guard added to the CLAUDE.md banner.
* **Routers aligned**: AGENTS.md, BASE_HANDBOOK, flow-router (split in two),
  CLAUDE.md, 2607/strategy.md, async-first SKILL.
* **Skills policy (final state - an earlier attempt in this same branch was
  rolled back)**: we track ONLY skills we authored. 10 pipeline skills were
  briefly vendored into git to close a CI gap, then removed - of 13 tracked
  skills only `async-first-communication` had any JT content; the rest carried
  upstream versions. **Consequence a cold session must act on:** `slop-detector`,
  `humanizer` and `seo-aeo-audit` are BLOCKING gates in `blog-pipeline.md` and
  are per-machine prerequisites - install them in your own skill directory, they
  will NOT arrive with the repo, and CI cannot enforce them. Making a gate truly
  blocking means writing our own skill for it.

## 2026-08-17 (editorial sweep + claims ratchet) - PR #458 session wrap

* **Course-wide sweep** applied the PR-#457 rules everywhere: 22 objective
  lines + 13 TL;DRs cut (2 glossaries relocated first), 18 Progress tails
  trimmed, 7 "Supplementary content" notices -> plain "For later.".
* **Shell audit**: 16/18 reference pairs healthy; 2 flagged for owner
  decision (2.2 rehearsal prompts, 1.4 campaign build) - in PR #458 body.
* **New rule** in `content/voice-rules.md`: Further reading = 3-4 on-topic
  items max, inline-cited sources never repeat, own posts lead.
* **Claims-canon recurrence caught live**: "seventeen years" in the
  red-flags blog post AND "17 years" hardcoded in blog/list.html (the
  ratchet's SURFACES excluded blog chrome). Fixed: template now derives
  tenure from foundingYear; `test/unit/marketing_copy_test.rb` gains the
  two stale-tenure spellings AND the blog-chrome glob - the same
  three-spellings lesson as reviewCount-32 (2026-08-14).

## 2026-08-17 (no-text-bricks rule) - break walls by content type

* **Trigger**: Paul flagged 5.1's 9-line "The 40% test, in one paragraph"
  section as a "big brick"; the friday-demo page had three more plus the
  template-contents description repeated 3x.
* **Rule** (`content/voice-rules.md`): no paragraph over ~5 rendered lines.
  Quotable artifact → blockquote; enumeration-in-prose → list; if-X-then-Y
  → table; what the adjacent exhibit shows gets one prose sentence. A
  heading apologizing for the wall ("...in one paragraph") marks the brick.
* Also mirrored in CLAUDE.md's cognitive-load gate line.

## 2026-08-17 (LI review board preview + composer scheduling recipe)

* **Trigger**: Paul asked for a standing rule — reviewing LI posts should hand
  him a dev-server link, not pasted text. Same session scheduled the Aug-19
  founding-hypothesis post via the native composer and hit the operational
  gotchas worth keeping.
* **Change**: `workflows/linkedin-post-pipeline.md` gained a "Local review
  board + composer scheduling" section: `bin/dev` → `/linkedin/` board URLs
  (dev-only mount in `config/development/hugo.toml`), composer focus/cta/image
  gotchas, no-direct-URL scheduled queue, and the post-scheduling frontmatter
  flip. Mirrors: `CLAUDE.md` pointer + `linkedin-posts/README.md` §Review board
  (commit 5665c2d26). Also: PR #455 confirmed merged; stale "not merged" note
  in `linkedin-posts/content-plan.md` corrected.

## 2026-08-17 (Lesson 4.4 promo-shell fix) - the micro/reference altitude rule

* **Trigger**: Paul flagged 4.4 (self-serve-mvp-stack-build-phases) as "one big
  promo before the movie" - 4x links to the same reference, promise restated 6x,
  green lights enumerated 3x, Phases 2-4 untaught in place. 4-critic panel
  confirmed (~70% shell); root cause: the micro/reference split was made by
  content VOLUME, not learner ACTION, so the mechanics moved out while the
  lesson kept its full ambition.
* **Fix**: full symmetric do → demo → if-fails blocks for all 4 phases (at
  altitude - SQL/prompts/test-cards stay reference-only), promise stack → 1,
  green lights listed once (4.4 owns them), reference links 4→3, Module 5
  handoff deduplicated (4.4 canonical, reference points back), failure-shape
  triage MOVED from reference into 4.4 (decision aid = micro modality).
* **Concept**: `content/course-structure.md` gains "Micro-lesson vs reference:
  the altitude rule" - split by learner action; each fact one home; circular
  deferrals are defects.

## 2026-08-14 (LinkedIn caricatures) - image type by pillar; the Art-tool cartoon pipeline

* **Update**: `linkedin-posts/README.md` gains "Image type by pillar" + "Generating
  caricatures (the Art tool)".
* **The split**: not every LinkedIn post wants a house-style *exhibit*. Teach posts
  (frameworks) do - Cutler/Rossi register. But **personal / opinion / story /
  reaction** posts want a **New Yorker-style caricature** (editorial cartoon): a
  data-diagram on a personal take reads as marketing, the opposite of the goal. Polls
  show the poll (no image). Text-only stays valid for a blunt Holub take.
* **The tool**: the `Art` skill (`~/.claude/skills/Art`, Nano Banana Pro / Gemini 3
  Pro image) generates the cartoons - `--workflow=Comics`, single-panel New Yorker
  style, **no lettering**, output to `~/Downloads` first, view-and-gate, then wire in.
  Needs a **billing-enabled** Google key in `~/.claude/.env` (free tier image quota =
  0); the key is untracked, never in the repo. New lanes need a dev-only assets mount
  in `config/development/hugo.toml`.
* **Recurring model quirk**: it sometimes adds a clean sign word ("MANAGER", "ERROR")
  despite the no-text prompt - keep only if correct and it sharpens the gag.

## 2026-08-14 (gates) - every late defect was invisible to source-level matching

* **Update**: findings backlogged in `docs/20-29-testing-qa/20.10` §3b (P0-4,
  P0-5, P0-6 + a ranked open list); claims-audit and rendered-output rows added
  to `seo-review-2026-08-13.md` §6 as actions #10-#11.
* **The finding**: a Lighthouse/snapshot sweep of the live site found three
  defects the marketing ratchet had reported clean on - a false review count in
  an unglobbed partial, "Take You to the Next Level" in the careers `<h1>`
  (wrapped across two template lines), and a nested `<main>` that only exists
  after `baseof` + page compose. Source-level gates could not see any of them.
* **The compounding bug**: the ratchet's `scrub` helper stripped tokens
  containing a slash, and `Level?</span` contains one, so it deleted the word
  along with the tag. Strip template expressions and HTML tags BEFORE path
  tokens.
* **The contradiction**: `testimonial_shortcode_test` asserted the literal
  careers `<h1>` copy that `marketing_copy_test` bans. Two gates cannot
  disagree about the same string - the ratchet lost silently. Assert shape, not
  marketing copy.
* **The rule**: point text ratchets at RENDERED output, not source. Rendering
  flattens wraps, resolves partials, and covers pages nobody remembered to
  glob. One change closes the whole class.
* **The base rate worth remembering**: 4 of 8 published figures checked this
  cycle were wrong. Treat an unsourced number as a defect until verified.

## 2026-08-14 (canon) - the founding year was wrong, and so was the instruction layer

* **Update**: new concept [company claims canon](/content/claims-canon.md);
  `content/index.md` refreshed; `build/hugo-build.md` migrated off the legacy
  `timestamp` field to `generated`.
* **The finding**: JetThoughts was founded **2008-09-01**, not 2011. The site
  had carried 2011 for years, which also made every derived tenure claim three
  short (a hardcoded "13+ years" in service schema matched *neither* year).
  Two defects, not one: the canonical `foundingYear` param was wrong AND most
  claims bypassed it with their own hardcoded copy, so fixing the param alone
  would have left "since 2011" in eight places.
* **The bigger finding**: the wrong year and the false "32 clients" review count
  were baked into the **instruction layer** - `PRODUCT.md` canon,
  `docs/business/vision-mission.md`, four 2607 rescue-sprint docs, and the 2605
  outreach claims whitelist. One literally read *'Tenure claim is "since 2011"
  (from `foundingYear = 2011` - verifiable)'*. It was neither. Anyone following
  those docs would have re-introduced both.
* **The rule**: when correcting a published fact, sweep the instruction layer,
  not just the output layer. And derive - never hardcode - anything with a
  canonical param behind it.
* **Tooling note**: serena's `search_for_pattern` regex found seven files that
  targeted greps missed. qmd was the wrong instrument for an exact-literal hunt
  (semantic/BM25 over markdown returns topically-related docs, not literal
  matches) - use qmd for "what do we say about X", serena for "find every
  occurrence of this string". Recorded in [test gates](/build/test-gates.md)'s
  sibling lesson about mechanical ratchets beating manual review.

## 2026-08-14 (claims) - the number nobody had a source for was wrong

* **Update**: `.okf/build/test-gates.md` gains the 2% tolerance false-green and
  the `FORCE_SCREENSHOT_UPDATE` re-record trap;
  `docs/projects/2510-seo-content-strategy/seo-review-2026-08-13.md` §8 actions
  7-9 closed.
* **The finding**: the site published "4.8/5 by 32 clients" and
  `reviewCount: 32` in schema on ~1,147 URLs. `reviewCount` had **no source
  anywhere in the repo** - `data/company.yaml:11` cites a Clutch rating with no
  count. The live Clutch profile shows **4.8 from 9 reviews**. The rating was
  right; the count was overstated ~3.5x. `data/course_banned_strings.yaml:65`
  had already banned "4.8/5" in course content as a "volatile third-party
  review score" - the course side learned this and the marketing side did not.
* **The rule**: a number with no in-repo provenance is a defect, not a detail.
  When a claims audit says "verify X", verify it before deciding what to do
  with it - the earlier call to keep 32 was made assuming it was sourced.
  Prefer a **linked** rating over a bigger unlinked one; the link is the proof.
* **Also closed**: fabricated `Review` objects ("Technology Executive",
  "Startup Founder") deleted from `comprehensive-service-schema.html`, and
  `keepQuotes = true` added (verified in a production build; homepage
  124,256 -> 125,988 bytes, +1.4%).

## 2026-08-13 (LinkedIn exhibits) - purpose-built post images consume the house spec

* **Update**: `linkedin-posts/README.md` §"Every post carries a visual" rewritten
  from "reuse a course SVG" to a purpose-built exhibit pipeline; cross-ref added
  in `.okf/design/house-visual-spec.md`.
* **The finding**: reusing a topic-adjacent course exhibit on a LinkedIn post
  reads as "too much info" (Paul) - a course exhibit is built for a lesson's
  density, not a scroll-stopping social card. The fix is one purpose-built
  exhibit whose single message IS the post's thesis, authored to the
  refactoring.fm house spec at **viewBox 720×480**, exported
  `rsvg-convert -w 1080`, and **render-verified by viewing the PNG**.
* **The recurring defect**: every hand-authored exhibit this session clipped its
  title or a long row at the viewBox edge on first render (Caveat runs wider than
  estimated, esp. bold). Cannot be caught without viewing the export - shorten
  text or drop 1-2px, re-export, re-view. `xml:space="preserve"` stops
  inter-`tspan` spaces collapsing.
* **The rule**: vary exhibit SHAPE across sibling posts (contrast / fork /
  swap-table / flow) so the feed isn't one repeated diagram - the same
  cross-post-repetition discipline as anecdotes/openers.
* **Board (dev-only) evolved**: `layouts/linkedin/single.html` → 2-col
  image|body with the Details panel full-width at the bottom (frees width at
  MBP-14), image column 460px, image is a click-to-open-new-tab link
  (drag-to-attach preserved); prev/next nav now traverses in board order
  (chronological by effective date), not Hugo section order.
## 2026-08-13 (build) - a failing audit tool is not a failing site

* **Update**: `.okf/build/hugo-build.md` gains "Minified output has unquoted
  attributes"; full write-up in
  `docs/projects/2510-seo-content-strategy/seo-review-2026-08-13.md` §8.
* **The finding**: a third-party AI-SEO tool scored the site 60/100 "Multiple
  Organ Failure" and reported no canonical tags, no structured data, and
  placeholder meta descriptions. **All false.** `minifyOutput = true` drops
  quotes on space-free attribute values (`rel=canonical`,
  `type=application/ld+json`), and the tool's regex parser requires quotes.
  GSC confirms Google parses all of it correctly.
* **The tell**: checks reading ATTRIBUTE VALUES failed; checks reading ELEMENT
  CONTENT (title, H1) passed. Read the failure *shape* before the failure
  *text* - that split is a parser artifact every time.
* **The rule**: before acting on any external audit, run GSC
  `inspect_url_enhanced`. It returns `user_canonical` plus the rich-results
  verdict - Google reporting what it actually parsed - and settles it in one
  call. Also note `config/test/hugo.toml` sets `minifyOutput = false`, so the
  test suite is blind to minification regressions by construction.
* **What was real**: the same audit's copy criticism. And what it missed
  entirely - the site publishes fabricated review schema (invented "Technology
  Executive" reviews + two contradictory ratings). Asking "is schema missing?"
  never asks "is the schema honest?".

## 2026-08-13 (visual gate) - a new component needs cold eyes, not the implementer's

* **Update**: `docs/workflows/visual-scroll-gate.md` §Design-quality pass gains
  item 7; `.okf/workflows/visual-scroll-gate.md` mirrors it.
* **The finding**: the UI-gatekeeper rule was followed to the letter - screenshot
  taken, read, judged "much better than before" - and the component was still
  rejected on sight, later scoring 3/10 from a design critic. Two blind spots the
  implementer cannot self-detect: the **wrong anchor** (better than the thing you
  just replaced, when that was also bad) and **solving the symptom** (a
  link-density complaint that was really "this element does not belong in this
  slot" - a prettier wrong element still fails).
* **The rule**: tweak to an existing pattern = self-review OK; a pattern NEW to
  the page = one cold-eyes critic on the render before handback. Cheapest form:
  render 2-3 variants, screenshot at 1280x800 + 390x844, let the owner pick from
  images rather than prose - that took ~6 minutes and ended the debate.

## 2026-08-13 (course landing) - the post-hero slot is not a router

* **New concept**: `.okf/design/course-landing-components.md` - the landing's
  composition rules (one loud element, 3 dark zones, soft-card dialect) plus a
  ruling on the entry block.
* **The finding**: a 3-row "Where to start" router table (`.start-router` `<dl>`)
  shipped under the hero and was rejected on sight. Four independent critics
  (ICP-reader, CRO, visual-design, IA) all recommended deleting it; a Codex
  refutation pass then caught that "delete to prose" would ignore the stated
  intent (a visual component) AND silently drop the page's only links to How
  This Course Works and the FAQ. Only 2 of 6 router links were unique.
* **The fix**: `.start-note` - one asymmetric callout carrying only the
  already-building -> Lesson 4.2 fork (~79px desktop / 130px mobile, down from
  ~200px). Wayfinding moved to the module-map intro. The first mistake card now
  lands at y~643 instead of ~760 on desktop.
* **Reusable rule**: before adding a navigational component to a landing page,
  count how many times each destination is already reachable elsewhere on it.

## 2026-08-13 (first full SEO review) - the GA4 traffic number was never real

* **Update**: `.okf/workflows/analytics-access.md` gains a "Reading the numbers"
  section. The servers went live yesterday; the first real review found both of
  them return correct-but-misleading data unless corrected.
* **The finding**: GA4 `328508492` reported **1,628 `google / organic` sessions**
  for 2026-07-14..08-10; GSC reported **~130 clicks** for the same window. A 12x
  gap is not lag - **~85-90% of GA4 traffic is bots**. The tell is engagement,
  not volume: google/organic 11.8% @34s and direct 31% @21s, against
  duckduckgo 68.8% @370s and bing 66.7% @425s. Corroborating: 94% of sessions
  are `first_visit`, and there are 170 `scroll` events per 6,392 `page_view`s.
  **Never quote a GA4 organic figure without diffing it against GSC clicks.**
  Real search traffic is ~255 sessions/28d, not the ~5k GA4 implies - the
  "~5k baseline" in `GOAL-AT-A-GLANCE.md` was corrected in the same commit.
* **Second correction**: `sc-domain:` impressions are polluted. One page on a
  different site under the same domain property (`elital.jetthoughts.com`'s
  "upwork login" post) is **14,438 impressions / 2 clicks** = 14% of domain
  impressions against 1.4% of clicks. Site-wide CTR from `sc-domain:` is not a
  usable metric. Use the property for coverage questions; use the
  `https://jetthoughts.com/` prefix property (or a `notContains elital` filter)
  for performance ones. The yesterday-recorded "1,445 sessions / 7 days" and
  "0.14% CTR" baselines are re-annotated in place rather than deleted.
* **Update**: `.okf/content-strategy/content-plan.md` - two 20.08/20.09 claims
  resolved against live data. (1) The **title-rewrite thesis is falsified**: the
  rewrites shipped and Google cut impressions instead of granting clicks
  (`rails-testing-best-practices` -78% impressions for +3 clicks;
  `langgraph-workflows` left the top 15). Do not run wave 2. (2) The
  "`/services/vibe-code-rescue/` has ZERO inbound links" item is **done** -
  seven posts now link it and the page is indexed - and it changed nothing
  (3 impressions, 0 clicks), because the linking posts have no traffic to pass.
* **Live signal to track**: average position decayed 14.7 (Feb) -> 13.0 (Apr) ->
  18.5 (Aug), monotonic across top pages. Track that, not CTR.
* **Also true**: GA4 `keyEvents` = 0. Four `click` events in 28 days. No form
  submit, no booking. "Did traffic convert" is unanswerable today.
* Full analysis: `docs/projects/2510-seo-content-strategy/seo-review-2026-08-13.md`.

## 2026-08-13 (analytics goes live) - GA4 + GSC queryable from an agent session

* **New**: `.okf/workflows/analytics-access.md` - the two local MCP servers
  (`google-analytics` via ADC, `gsc` via its own Desktop OAuth client),
  registered at Claude Code user scope so they load in every worktree.
  Replaces hand-downloaded GSC CSV exports as the way to pull performance data.
* **Property IDs pinned**, because both accounts carry overlapping properties
  that return real-looking but wrong numbers: GA4 is **`328508492`** (not the
  two blog properties), GSC is **`sc-domain:jetthoughts.com`** (not the
  URL-prefix variants, which each cover only part of the traffic).
* **Learning worth keeping**: the two servers CANNOT share one credential.
  Google classes `webmasters*` as a sensitive scope and blocks gcloud's shared
  built-in OAuth client from brokering it, so `gcloud auth
  application-default login --scopes=...webmasters...` dies with "This app is
  blocked" no matter how the project is configured. GA rides plain ADC;
  GSC needs a self-owned Desktop client with the account as a Testing-mode
  test user. Chasing this via ADC is a dead end - don't retry it.
* **GSC data lags ~2-3 days** - query windows ending today read as zero-traffic
  tails. Baseline recorded for future diffs: 142 clicks / 104,754 impressions /
  0.14% CTR / position 18.1 over 2026-07-14..08-10, consistent with the 0.09%
  CTR that `content-strategy/content-plan.md` was built from.
* **Not in the repo**: all credential files live under `~/.config/` and
  `~/Library/Application Support/`. Nothing was committed but the bundle.
## 2026-08-13 (exhibit clunkiness) - render-gate needs a composition pass

* **Update**: `.okf/design/house-visual-spec.md` gains a **render-gate
  clunkiness checklist** (6 items: alignment, odd-one-out balance, whitespace/
  hollowness, sibling consistency, edge breathing room, weight/emphasis) plus a
  per-batch independent-critic backstop.
* **Wobble rule corrected**: the ~0.4-0.6deg hand-drawn wobble reads as craft
  in a flow/stack but as MISALIGNMENT in a grid of aligned cards - drop it in
  grids. This exact spec rule caused the friday-demo-timeline clunkiness.
* **Root cause recorded**: a legibility/overflow gate is structurally BLIND to
  composition. friday-demo-timeline passed the binary gate (legible/no-overflow/
  on-style) with 3 clunky defects visible in the same screenshot; Paul caught
  them. Binary gates necessary, not sufficient - stance "assume clunky, find 3"
  is the lever. Redraw shipped on `course-svg-per-image-fixes` (7e87b1a7 draw,
  c0df99a1 de-clunk).

## 2026-08-12 (item16 landing migration) - below-fold coverage gap confirmed

* **Update**: `.okf/build/test-gates.md` documents the REPORT-ONLY build-gate
  pair (`bin/check-svg-floor`, `bin/check-course-paths`) - standalone, each
  with a `--self-test`, flipping to blocking via an env flag once its backlog
  is zero.
* **Coverage-gap confirmed from both sides**: item16's below-fold changes
  (dark NOT-cover band, merged endcap, compacted module cards) produced
  ZERO Linux dtest reds - only the hero-fold desktop/course/landing baseline
  shifted (T2/T4). Below-fold visual work is gated by rendered chrome-devtools
  review at 1280+390, never by the pixel suite.
* **Dropped**: a `bin/check-landing-parity` report-only gate was tried as the
  wave's 20%-slot and removed as redundant (Paul, YAGNI) - a report-only
  gate nobody wires into hugo-build/CI doesn't earn its keep unless it guards
  an active backlog the way svg-floor/course-paths do.

## 2026-08-09 (CEO decisions) - delivery goes dual-route, client picture corrected

* **Update**: no concept file changed - this is a business-layer decision, and the
  bundle has no business section. Recording the durable rules here; the decisions
  themselves live in `docs/business/` and `docs/projects/2607-vibe-code-rescue/`.
* **Decision 1** - delivery runs through **both** JT's own senior Rails engineers
  and the white-label partner (was: partner only). Accountability chart, E3, the
  strategy risk section, and the exec-summary rabbit hole all updated.
* **Decision 2** - the exec summary's "needs to restart client acquisition" opener
  did not match the firm's actual position and is now "needs new clients." The
  commercial detail behind that correction is deliberately not recorded here - this
  repo is public; it lives in the private vault.

**Durable rules:**
1. **A single-threaded dependency the docs themselves flag as "the single point of
   failure" is a design choice, not a fact - re-open it.** E3 picked white-label over
   in-house in the register's *lighter-vote* tier: no options table, no scores, no
   rationale, and a kill-criteria that could only route partner -> fallback partner,
   never back in-house. The devil's-advocate pass reviewed A-D and never touched it.
   The weakest-argued assumption was carrying the biggest named risk.
2. **When the sales copy and the org chart disagree, one of them is lying to a
   customer.** `offer-one-pager.md` grounded the $7,500 price in *JT's own*
   AI-assisted development and promised "one senior engineer," while the chart
   assigned the whole delivery seat to an unnamed third party. Reconcile these at
   the point the price is set, not after a founder asks who is writing the code.
3. **A gate marked Done on an assertion is an open gate.** G0's definition-of-done
   (paid trial + fallback named + cold-eyes verdict pasted) was unmet, its handoff
   note still the empty placeholder - yet A2 pricing was confirmed off it, which
   operating rule 1 forbids. Logged as OS Issue 6 rather than silently re-scoped.
4. **Stale facts propagate into strategy.** Several notes and the bet's own pitch
   asserted a commercial position that was months out of date. Re-confirm the money
   facts before a plan is built on top of them.
5. **This repo is public - commercial figures belong in the private vault.** Revenue,
   profit, rates, headcount, bench cost, and client-book size do not go in
   `docs/`, `.okf/`, commit messages, or PR descriptions here. State the decision
   and its reasoning; keep the numbers behind it private.

## 2026-08-01 (W2 T7 escalation) - canon deposit row carries the cancel split

* **Update**: [content/course-canon.md](content/course-canon.md) - deposit row
  "$500+ refundable" was missing the customer-cancel-forfeit / founder-cancel-
  100%-refund split that 5.6's DPA clause 3 and the audit-runbook table already
  carry; the bare "refundable" phrasing caused 3 in-course drift instances
  fixed in W2-T7 (e4850eaf). Row synced; floor and mechanism unchanged.

## 2026-08-01 (O5a) - restore-on-green now OS-scoped

* **Update**: [build/test-gates.md](build/test-gates.md) - green runs restore
  only the OS dir they wrote (macos/ vs linux/), unblocking parallel
  test+dtest in one checkout (devx backlog O5(a); O5(b) worktree-compose
  isolation still open).

## 2026-08-01 (W1 landing merge) - vacuous worktree-dtest caveat

* **Update**: [build/test-gates.md](build/test-gates.md) - new caveat: `bin/dtest`
  run from a git worktree passes vacuously (worktree `.git` pointer file is
  outside the container mount → no baselines → everything records as "new");
  the two tells and the detached-HEAD recipe for an honest Linux leg recorded.
  Learned closing W1 (PR #428 merge gate).

## 2026-08-01 (v0.2 migrate) - bundle-wide v0.1 -> v0.2 field migration

* **Update**: ran the validator `--migrate` across `.okf/` (the skill-sanctioned
  path for a whole v0.1 bundle - do not hand-edit). Mechanically converted every
  legacy `timestamp` to `generated: { by: process:okf-migrate, at: <original> }`
  (29 files) - an honest `process:` actor, NOT `human:`, so no fabricated review
  tier; original dates preserved. Also folded the parseable `# Citations` link in
  `architecture/css-pipeline.md` into `sources`. No external URLs dropped
  (verified); the two dropped plain-text citations were `postcss.config.js`
  (already the `resource`) and a repo doc path.
* **Note**: 12 `# Citations` body lists remain (soft warnings) - their conversion
  to `sources` is semantic, done migrate-as-touched. 31 log date-heading warnings
  are the deliberate house-style suffixes on this append-only history.

## 2026-08-01 (v0.2) - bundle adopts OKF v0.2 provenance/trust/lifecycle

* **Update**: [root index](/index.md) - `okf_version` bumped 0.1 -> 0.2; added a
  conventions note for the new optional frontmatter families (`generated`,
  `verified`, `status`, `stale_after`) and the actor convention
  (`<producer>/<version>` / `human:<id>` / `process:<id>`).
* **Update**: [test-gates](/build/test-gates.md) - migrated to v0.2 trust fields:
  `status: stable`, `generated`/`verified` by `claude/fable-5` (the caveats were
  empirically verified this session - dtest x3 byte-identical, bin/test x2 green).
  Replaces the bare `timestamp`.
* **Note**: the other 34 concepts keep v0.1-style frontmatter (still conformant
  under v0.2); they migrate honestly as maintainers touch them. No back-stamping
  of provenance nobody performed.

## 2026-08-01 (later) - dtest drift verified, CI back to critical, PR #425 review

* **Update**: [test-gates](/build/test-gates.md) - ran `bin/dtest` x3 to hunt
  flakiness. All 3 runs BYTE-IDENTICAL: only 7 mobile-codeblock screenshots red,
  same diff_levels every run = deterministic amd64-emulation antialiasing, NOT
  flaky. mermaid is now GREEN (self-hosted fonts + fonts.ready + CI re-record
  fixed the drift) - the earlier "10 stale linux baselines" narrows to 7, all
  green on CI-native. Trust CI; do NOT re-record locally.
* **Update**: CI reverted PR runs to `test:critical` (was briefly `test:smoke`) -
  the skip_area fix already makes critical ~46s on CI, so full 34-test coverage
  costs little; smoke stays the local/dispatch fast tier. `.github/workflows/test.yml`.
* **Fix**: `bin/test --smoke <file>` now rejects trailing file args (exit 2,
  fail-fast before build) instead of silently ignoring `--smoke` (CodeRabbit
  PR #425). Rakefile `SMOKE_TESTS` unanchored `test_course_landing` kept
  intentional (matches both mobile + desktop course-landing renders).
* **Creation**: [snap-diff-upstream-issues](/docs/20-29-testing-qa/screenshot-testing/20.11-snap-diff-upstream-issues-reference.md)
  - two paste-ready gem bug reports: `Reporters::Default#generate` TypeError when
  `failed_by` is the `"missing_image"` String; skip_area zero-match 5s wait.
* **Update**: [test-speed-research-todo](/docs/20-29-testing-qa/screenshot-testing/20.10-visual-suite-speed-research-reference.md) -
  added the drift-overview procedure for removing a skip_area/tolerance mask
  (read `snap_diff_report.html` heatmap, one mask at a time, which masks to KEEP).
* **Update**: CLAUDE.md - onboard via `/okf:okf`, run `/okf:okf maintain` before
  every commit, default coding posture `/ponytail:ponytail ultra`.

## 2026-08-01 - smoke test tier + test-speed profiling

Profiled the visual suites (`TESTOPTS=--verbose bin/test`). Finding: ONE test,
`test_codeblock_language_styles` (desktop+mobile), is 98.8s+97.2s = ~196s = 44%
of the full 67-test / ~450s run - it loops 8 code-fence sections each doing a
multi-capture `assert_stable_screenshot`. It also errors in the snap_diff Default
reporter (`reporters/default.rb:25`, Symbol into Integer via String#[]) whenever
a delayed codeblock diff needs formatting - external-gem bug, not monkeypatched.

Shipped a smoke tier: `test:smoke` rake task + `bin/test --smoke` flag (reuses
the build + restore-on-green wrapper; `bin/dtest --smoke` passes through to the
container). 17 curated basics+bummers, excludes the `_sections` sweeps and the
codeblock elephant. Measured: host 50.5s green (17/17), Docker 41.6s (Docker
~18% faster, confirming the "Docker is faster" report) with 1 known-stale
failure (linux mermaid baseline diff_level 0.0693, byte-identical across runs -
see project-stale-linux-baselines-pending, NOT a smoke defect). vs bin/test
critical ~300s -> smoke is ~6x faster. Smoke is NOT a milestone/PR gate;
test:critical + bin/dtest at PR prep stay the bar.

Parallel-test execution (host process-sharding + Docker) deferred as a written
spike: docs/docs/20-29-testing-qa/screenshot-testing/20.10-visual-suite-speed-research-reference.md (O1 kill the codeblock
elephant, O2 process sharding, O3 Docker-vs-host, O4 direct-visit). Thread
parallelism is out - Capybara.threadsafe=false + shared current_driver global.
Code: Rakefile (SMOKE_TESTS + test:smoke), bin/test (--smoke flag).

## 2026-08-01 - real elephant found (skip_area waits) + self-hosted fonts/mermaid

The 196s codeblock elephant was NOT stability retries and NOT font swaps -
instrumented probe showed the stable loop exits in 2x0.6s attempts; the ~10s
per screenshot was the gem resolving skip_area CSS selectors via
`all(selector, visible: true)`, where Capybara waits default_max_wait_time
(5s) for EVERY selector with zero visible matches (`%w[picture img]` on the
image-less codeblock fixture = 10.05s x 13 screenshots). Fix at the
assert_screenshot choke point: pin `final_options[:wait] ||=
Capybara.default_max_wait_time`, wrap assert_matches_screenshot in
`Capybara.using_wait_time(0)`; plus a document.fonts.ready wait before
capture (font-swap flakiness), and the 8 stability_time_limit:1 overrides in
blog_special removed. Measured: blog_special 247s->34.9s, bin/test critical
301s->81s (green x2, zero drift), bin/dtest critical ~6-7min->46s.
Lesson: the "stability retries" theory survived two sessions and was wrong -
one attempt-level probe killed it in minutes. Profile before believing.

Same day: self-hosted Caveat + Space Grotesk + mermaid.min.js (was Google
Fonts css2 + jsdelivr). Same woff2 binaries + unicode-ranges, sha384 of
vendored mermaid IDENTICAL to the old SRI pin. Prod loses 2 preconnects +
css2 + font + CDN js round trips on mermaid pages; visual tests are now
hermetic (zero third-party network). Gate: 2 macOS mermaid baselines updated
intentionally (font deterministically ready at mermaid.run() -> SVG measures
~8% more compact; evaluated side by side, quality equivalent). Linux mermaid
baselines need a CI workflow_dispatch update-baselines run after merge -
never re-record locally (emulation drift).

Hugo build (research, no changes): 11.4s memory-render; top template costs
are _partials/img/generic.html (16.5s cumulative, 104 calls),
clients/single (1.56s avg), img/hero-big + img/hero (~14s combined);
css-inline is 100% cached. Follow-up lever if build speed matters:
partialCached on stable img partials.

## 2026-07-31 (R3-2 CI correctness + cost)

* **Update**: [ci-gates](/build/ci-gates.md) - DevX R3-2: hugo_stats.json
  moved to its own EXACT-key-only cache (restore-keys could restore stale
  stats and re-open the PurgeCSS purge-live-classes incident class via
  cache); `_dest` dropped from cache paths (~1-2 GB/job, evicted everything
  else); sync fan-out gated (workflow_run jobs skip when the sync pushed
  nothing - was ~84 no-op deploy+test cascades/day); link-check builds once
  (composite `build: 'false'` - the double build blew its 10-min timeout on
  cold caches, seen live on PR #422); test.yml checks out the PR merge
  commit (head_ref tested the tip unmerged + broke fork PRs) and records
  via `rake test:system` with an always()-gated porcelain-guarded commit
  step (a red unit test used to discard 15+ min of recorded baselines).
  Also: baseline re-record landed (2edb94d9) on the pinned stack - third
  attempt, after #417 (drafts/fail_if_new) and #418 (push race + swallowed
  retry failure).

## 2026-07-31 (R3-1 harness truth)

* **Update**: [test-gates](/build/test-gates.md) - all four test runners now
  build through the shared `bin/build-if-stale` helper (routes via
  bin/hugo-build's PurgeCSS warm-up guard, skips on warm trees); qtest shares
  bin/test's `_dest/public-test` so micro-commit gates stop paying a ~26s
  rebuild each run; `qtest --changed` now counts untracked files (was false
  green exit 0 on a brand-new CSS file); bin/test honors preset
  HUGO_DEFAULT_PATH + PRECOMPILED_ASSETS (was silently breaking bin/dtest by
  pointing the container at the wrong tree). Removed the stale "CI does NOT
  run screenshot diffs" claim (superseded by #413/#417). New gotcha recorded:
  the `.gitignore` `.*` rule kept `.githooks/pre-push` out of the repo
  entirely - the R2 pre-push guard existed only on one machine until the
  `!.githooks` negation landed; check `git check-ignore -v` for any new root
  dot-path. Guard tests added: bare `hugo --environment production` outside
  hugo-build/build-if-stale, multi-file `ruby a_test.rb b_test.rb` (only the
  first file executes), bin/test HUGO_DEFAULT_PATH contract.

## 2026-07-31 (visual gate truth fix)

* **Update**: [ci-gates](/build/ci-gates.md) - first CI baseline-record run
  ([run 30629929407](https://github.com/jetthoughts/jetthoughts.github.io/actions/runs/30629929407))
  failed with 2 root causes, both now fixed: (1) CI test builds lacked `--buildDrafts`, so the draft
  codeblock-styles fixture 404'd and the codeblock tests failed on EVERY visual run (incl. the
  new PR gate - noisy-by-construction); test.yml now sets `BUILD_DRAFTS: '1'` on its setup-hugo
  step. (2) snap_diff `fail_if_new` hard-errors on missing baselines under ENV["CI"], so record
  mode could never create a FIRST baseline for pages added since the last recording
  (vibe_code_rescue); record mode now disables fail_if_new too. Re-record dispatch after merge
  closes the pending linux/ re-baseline.

## 2026-07-31 (R2 Phase C)

* **Update**: [test-gates](/build/test-gates.md) + [ci-gates](/build/ci-gates.md) - DevX R2
  Phase C (inner loop): `bin/test` now builds ONCE via bin/hugo-build (PurgeCSS warm-up guard
  included - hugo_helpers' bare `hugo` call could purge live classes on cold caches) to stable
  `_dest/public-test`, exports PRECOMPILED_ASSETS, and mtime-skips the build when warm -
  measured cold 2m19s -> warm 0.6s for single-file runs (previously EVERY single-file run paid
  a full rebuild into one of 5 random dirs; rand(5) fan-out retired). CI: `hugo_stats.json` now
  in the setup-hugo cache (was gitignored + uncached = ~52s warm-up double-build every run);
  `_hugo.yml` warm-up exits early on cached stats; cache key fixed to hash `config/**` (old key
  hashed nonexistent root hugo.toml, so config-only changes reused stale resources/_gen).
  `test:critical` glob now recursive, matching test:system.

## 2026-07-31 (R2 Phase B2)

* **Update**: [ci-gates](/build/ci-gates.md) scope - DevX R2 Phase B2: agent containers now
  self-bootstrap - checked-in `.claude/settings.json` SessionStart hook runs
  `bin/agent-bootstrap` (bundle+bun install, libvips, pinned CfT stack via setup-test-env,
  doctor; every step warns-and-continues on blocked network; log at /tmp/agent-bootstrap.log).
  Sync code made Ruby>=3.3-compatible (three `it` block-params replaced with named params +
  a missing `require "time"`) - `rake test:unit` now 275/275 green on the container's 3.3.6
  (was 71 errors; agent sessions can finally run the unit gate). NEW pre-push guard
  (`.githooks/pre-push`, installed by bin/setup via core.hooksPath): lint-css ratchet +
  course validators + toolchain-pin/bin-script guard tests in ~5s; bypass SKIP_CHECKS=1.
  Gotcha: `.claude/**/*.json` is gitignored - settings.json needed a `!` negation.

## 2026-07-31 (course waves + GA4 batching)

* **Update**: 2605 course project shipped Waves 0/A-H in one day (PRs #407
  Clarity + local-analytics exclusion, #408 five reference SVGs, #409 twenty
  covers, #410 Sprint D gaps, #411 Phase 2 mechanics). Durable operational
  learning worth keeping: **GA4 batches multiple events into one POST whose
  QUERY STRING carries no `en=` param - the event names live in the REQUEST
  BODY.** Verifying an event by reading the network list alone produces a
  false "did not fire" (hit on the 2.5 checkpoint verification). Read the
  request body. Recorded in runbook 20.12's verified-events table.
* **Learning (process)**: audit a backlog item's premise before dispatching
  work - 4 items this day were invalid or already-resolved (stale cover
  badge, Operating Kit templates, 7 of 15 campaign briefs absorbed, the
  "bistable render" that was a stale committed baseline).

## 2026-07-31 (R2 Phase B)

* **Update**: [ci-gates](/build/ci-gates.md) - the CI visual gate is BACK (report-only soak):
  `test.yml` now provisions the pinned rendering stack via `bin/setup-test-env` (CfT from
  `.dev/cft-version`, cached; fonts + fonts.conf) and exports CHROME_BIN/CHROMEDRIVER_PATH, so
  runner pixels match `linux/` baselines. New `pull_request` trigger (paths-filtered to visual
  surfaces) runs `test:critical` with `continue-on-error: true` - failures comment the snap_diff
  report on the PR without blocking; flip that flag off after the soak week. Record mode is
  workflow_dispatch-only, sets ALLOW_DIRTY_SCREENSHOTS=1 explicitly, and now records on the
  pinned stack (previously it would have silently overwritten canonical baselines with
  unpinned-runner-Chrome renders). Floating snap-diff composite refs pinned to the
  Gemfile.lock SHA. Re-record baselines via workflow_dispatch update-baselines=true - this
  also closes Round 1's pending linux/ re-baseline without a Docker-capable machine.

## 2026-07-31 (R2 Phase A)

* **Update**: [ci-gates](/build/ci-gates.md) + [test-gates](/build/test-gates.md) - DevX R2
  Phase A: bin/test, bin/dev, bin/build, bin/hive shebangs fixed sh→bash (dash exits 2 on
  `set -o pipefail` before line one - the Phase 1 sweep caught only 2 of 6 scripts); NEW guard
  `test/unit/bin_scripts_test.rb` fails CI on any sh-shebang script using pipefail/-E, and it
  caught bin/hive on its first run. `bin/dtest` arg bug fixed (`t "$@"` replaced the container
  command with a bare .rb path; now `t bin/test "$@"`, mirroring dtest-all). `bin/hugo-dev`
  retired - it never exported HUGO_ENVIRONMENT so `rake dev` paid the full production
  PurgeCSS+cssnano chain per rebuild; `rake dev` now runs `bin/dev`. qtest: `privacy-policy`
  critical-CSS key added (was a hard abort), dead pages/careers test branch removed, dirty
  guard now honors ALLOW_DIRTY_SCREENSHOTS and points at the reset task. ci-gates concept
  updated: the Alpine/musl premise for excluding visual CI is obsolete (pinned glibc stack);
  R2 Phase B plans the re-introduction. README/SETUP truth pass #2 (broken doc links,
  fictional coverage section, dead SELENIUM_BROWSER env, setup-test-env now documented).

## 2026-07-31

* **Update**: [test-gates](/build/test-gates.md) - new leading caveat: snap_diff
  baselines are **git HEAD, not the working tree**, so un-committed "accepted"
  baselines change nothing and an identical difference_level across runs means
  a stale committed baseline (not a flaky render). Case study: #405's 28px
  mobile hero gap merged with a "re-record on next run" note instead of updated
  baselines; every later local run failed at 0.2747 until re-record+commit.

## 2026-07-30 (Phase 4)

* **Update**: [test-gates](/build/test-gates.md) scope - DevX Phase 4: canonical visual rendering stack defined - `.dev/Dockerfile` moved ruby:3.4-alpine → ruby:4.0-slim (glibc; Alpine/musl was why linux baselines diverged 3-28% from every real Linux) with pinned Chrome for Testing + chromedriver (`.dev/cft-version` = 141.0.7390.37), deterministic fontconfig (`.dev/fonts.conf`: hintslight, grayscale AA, no embedded bitmaps), fonts-noto-core/freefont/dejavu. `bin/setup-test-env` installs the identical stack bare-metal (CfT cached under ~/.cache/jt-cft/<v>; `eval "$(bin/setup-test-env --print-env)"` exports CHROME_BIN/CHROMEDRIVER_PATH). Bare-metal verified green in an agent container. PENDING on a Docker-capable machine: build image, `FORCE_SCREENSHOT_UPDATE=true bin/dtest` once, commit re-recorded linux/ baselines in the same PR - until then linux/ baselines are still Alpine-rendered.

## 2026-07-30 (Phase 5)

* **Hygiene**: DevX Phase 5 - 9 orphaned agent-era markdown files (~108 KB, closed reference island, all frozen 2026-07-18) moved to `docs/projects/2509-css-migration/70-79-archives/agent-era/`: 3 from repo root (AGENT_COORDINATION_FAILURE_ANALYSIS, coordination, memory-bank) + 6 ALL-CAPS protocol docs from `test/system/`. Executable bits cleared on the two mode-0755 markdown files. Stale `/Users/pftg/...` absolute paths fixed in GEMINI.md/QWEN.md (live pointer files - they stay at root by CLI-tool convention, as do DESIGN.md/PRODUCT.md/AGENTS.md which are resolved at root by the impeccable skill's context.mjs). Rule of thumb: grep for inbound references before moving root docs - the load-bearing set is invisible to grep (tool conventions), so check `.agents/skills/impeccable/scripts/context.mjs` name lists too.

## 2026-07-30 (Phase 3)

* **Update**: [test-gates](/build/test-gates.md) scope - DevX Phase 3: the qtest-only dirty-baseline guard now runs at system-test load (`test/application_system_test_case.rb`) for ALL runners (bin/test, bin/dtest, rake) - refuses to start on dirty `test/fixtures/screenshots`, companion `bin/rake test:screenshots:reset`, bypass `ALLOW_DIRTY_SCREENSHOTS=1`. Browser overrides `CHROME_BIN` + `CHROMEDRIVER_PATH` in `setup_capybara.rb` make the suite runnable in agent containers (proven: color_system test green against Playwright Chromium 141 + matching chromedriver). All 11 `File.read` sites in `lib/` now force `encoding: "bom|utf-8"` - validators no longer crash under non-UTF-8 locales (`LANG=C bin/validate-course` green).

## 2026-07-30 (Phase 2)

* **Update**: [ci-gates](/build/ci-gates.md) - DevX Phase 2: `.mise.toml` is now the toolchain single source of truth (hugo 0.164.0 / bun 1.3.13 / node 22 / ruby 4.0.6), enforced by `test/unit/toolchain_pins_test.rb` drift gate in CI. `_hugo.yml` de-duplicated onto the setup-hugo composite (new `build` input). `bin/setup` rewritten: mise install + brew/apt system libs + bun install + `bundle install` (previously missing!) + doctor with per-item fixes. Brewfile now system-libs-only (mise/vips/lychee). README/CONTRIBUTING corrected (Hugo badge was 17 minor versions stale, 3 fictional test commands, `hugo server -D` → `bin/dev`); `docs/SETUP.md` created (4 links already pointed at it). Gotchas: `.ruby-version` must be an exact patch (rbenv never matches fuzzy "4.0"); repo `.gitignore` ignores all dotfiles - `.mise.toml`/`.ruby-version` needed `!` negations.

## 2026-07-30

* **Update**: [test-gates](/build/test-gates.md) - DevX Phase 1: `bin/docked`/`bin/dc` shebangs fixed to bash (`set -o pipefail` is a bashism; dash rejected it, breaking `bin/dtest` on Linux hosts); new `bin/lint-css` stylelint ratchet (cap 377, wired into CI unit_tests job); dead `SCREENSHOT_DRIVER` env removed from test.yml (driver hardcoded `:vips` in setup_snap_diff.rb). Last 2 `site.Data` call sites migrated to `hugo.Data` (deprecation gone from build output); stale `package-lock.json` deleted (bun.lockb is the only lockfile). Agent-container caveat: Docker Hub blob CDN is 403 through the agent proxy, so dtest is unavailable there - use full-build HTML diff for template-neutrality proof.

## 2026-07-26

* **Milestone**: Vibe Code Rescue landing page built at `/services/vibe-code-rescue/` (branch `landing-vibe-code-rescue`, card #14) via the impeccable pipeline (init → document → build): PRODUCT.md + DESIGN.md + sidecar now exist at repo root as design authority. JetVelocity brand tokens extracted to `foundations/css-variables.css` `:root`.
* **Gotchas** (recorded in `docs/workflows/new-page.md` §Dark-page traps): legacy-theme-skin whitewashes `.fl-page-content` after page slices; site chrome sits outside the page div so page-scoped vars don't reach the header; the `:not()`-chain anchor rule needs `!important` to beat; the mobile drawer is a white panel — drive the menu-open state at 390×844, closed-state screenshots can't see it.

## 2026-07-25

* **Policy**: async-first communication is now repo SOP for all agents — skill at `.agents/skills/async-first-communication/SKILL.md`, exposed via AGENTS.md `<skills>` block + CLAUDE.md Behavioral Constraints + operating-system.md §5. OKF maintenance is now ENFORCED parallel-by-default (dispatch okf-maintainer alongside main work; weekly scheduled back-fill as safety net).
* **Update**: [outbound-sprint](/workflows/outbound-sprint.md) - discovery-call tooling: Fathom free (bot-free capture + MCP; Google Meet flags bot-join recorders since Apr 2026), Gemini-notes fallback, consent line, transcript→3-artifacts pipeline, optional capped pre-call repo pass.
* **Gotcha**: repo `.gitignore` line 28 ignores ALL dotfiles (`.*`) — any new dot-directory artifact (like `.agents/`) needs an explicit `!` negation or it silently never gets committed while docs point at it.
* **Update**: `docs/workflows/new-page.md` §8 — design toolchain for conversion/marketing pages: impeccable (init→document→shape, Persuade mode) as the design engine + hugo/copywriting + frontend-design + impeccable live iteration + ponytail discipline + devtools/webperf gates + critique/audit pre-PR. Ponytail plugin installed and enforced globally (~/.claude/CLAUDE.md); impeccable skill installed. Board card #14 carries the same stack.

## 2026-07-24

* **New concept**: [outbound-sprint](/workflows/outbound-sprint.md) - the 2607 rescue outbound machinery: browser-agent send runner (pre-research -> approval gate -> send -> log), daily reply monitor, pipeline.md ledger, local-only kanban convention, F5Bot/Gmail-forward routing gotchas.
* **Update**: [review-swarm](/workflows/review-swarm.md) - multi-doc kit reviews need a cross-doc drift finder + link-routing check (Joy/Nico mis-route, stale pricing in narrative docs); late finders carry real findings (3 of 6 reported after first synthesis with 3 confirmed defects); idle agents' reports recoverable from subagent transcript jsonl.

## 2026-07-21

* **New concept**: [ci-gates](/build/ci-gates.md) - what GitHub Actions enforces on a PR (build, unit, path-scoped broken-internal-link crawl via lychee in `link-check.yml`). Records that visual regression is intentionally NOT a CI gate: cross-OS pixel diffs (Alpine/musl baselines vs Ubuntu/glibc CI) diverge 3-28%, so `bin/test` + `bin/dtest` are the sole visual coverage (a CI screenshot job was built and removed in PR #386). Includes the libvips42-runtime gotcha for any future ruby-vips CI job.
* **Update**: [test-gates](/build/test-gates.md) - cross-linked to ci-gates; noted visual regression is a local-only gate.

## 2026-07-13
* **Update**: taste anchor established at `.stitch/course-taste-design.md` - Stitch-skill DESIGN.md encoding the course design language + anti-pattern bans; used as the scoring lens for taste-critic passes (see [review-swarm](/workflows/review-swarm.md)).
* **Update**: [render-verification](/workflows/render-verification.md) - render from `_dest/public-dev/` (relative URLs), never the stale repo-root `public/`; stale-tree reviews produce false missing-asset findings.
* **Initialization**: Created the bundle with build/, content/, design/, and workflows/ sections distilled from CLAUDE.md, docs/workflows/, .stitch/design.md, and the 2026-07 course review sprints.

## 2026-07-17 - M2 compression migration
Module 2 (last unmigrated module, 1,652-5,124 body words/lesson) compressed to
exemplar parity (1,265-2,038; migrated 1.4 exemplar = 1,258 on the same basis).
Depth moved to four new reference companions: mom-test-full,
persona-rehearsal-full, find-10-people-full (shared 2.3+2.4),
prototype-build-full. Operative rule learned: the 30.03 numeric bands are
unreachable when mandated keeps (full prompts, teaching tables, reuse bridges)
exceed the band - EXEMPLAR PARITY on an identical measurement basis is the
real gate, not the raw number. M3 (3.1/3.2 at ~2,900w) is the remaining
unmigrated pair.

## 2026-07-17 (later) - Full-course migration complete
M3 (3.1/3.2), M4 (all five), and M5 (5.1/5.2/5.6/5.7) migrated to v2
micro-lesson form in one 5-fixer wave; 11 new reference companions created
(every module now has its deep-dive set). Canon punch-list applied (Cursor
seat range, "Sixty percent" stat, PR #847 collision, fast/easy/free columns,
Chapter 0 -> Overview, faq 12-rules pointer). Cold-eyes M3+ reuse review
fixed 4 restart defects (5.3 warm-list seeding, SOW brief-as-scope, 5.1
persona reconciliation, PRD Section 2). No v1 long-form lessons remain.
Gotcha: claude-flow daemons recreate .git/index.lock continuously - commit
via retry loop (rm lock + immediate git add/commit, up to 10 attempts).
Voice wave (same day): 16-page opener-shape rotation shipped - max 4 pages
per shape, 4 composite-disclaimed vignettes kept, attribution phrases
("we picked up"/"we worked with") now zero course-wide. Teaching numbers
preserved as mechanism descriptions.

## 2026-07-18 - Added course architecture concepts
Added two course architecture concepts to `.okf/architecture/`:
[icp-journey-sipoc](/architecture/icp-journey-sipoc.md) — Mermaid flowchart
of Sam's full journey through all 25 lessons, gate thresholds, branch paths,
and artifact handoffs; and [operational-dependency-map](/architecture/operational-dependency-map.md)
— per-lesson operational prerequisites, template blank sources, wait times,
and Plan B recovery paths. Both distilled from
`docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/`.
Architecture index updated with the two new entries.

## 2026-07-19 (later) - Q3 content plan execution: Phase 1 expanders + snippet hygiene TL;DRs
* **Published**: 3 Phase 1 expander posts from the Q3 content plan:
  - [Falcon in Production: Benchmarks, Memory & Worker Count](/blog/falcon-web-server-production-tuning-benchmarks/) —
    worker sizing formulas, 24-hour memory curves, wrk2 benchmarks, GC tuning,
    rollback case study. 235 lines, 10/10 voice self-test.
  - [Solid Queue Advanced: Retries, Concurrency & Monitoring](/blog/solid-queue-advanced-patterns-retries-concurrency/) —
    exponential backoff, dead letter pattern, I/O profiling, dispatch config,
    queue depth alerts, preserve_finished_jobs gotcha + client story. 324 lines,
    10/10 voice self-test.
  - [Rails 8 Authentication Generator: Complete Guide](/blog/rails-8-authentication-generator-complete-guide/) —
    replaces Devise with built-in auth, sessions table, password reset,
    email verification, rate limiting, production hardening checklist,
    Devise migration case study. 347 lines, 10/10 voice self-test.
* **Cover images**: 3 new covers generated via established pipeline
  (duplicate Falcon HTML → Chrome headless 2× retina → Lanczos downsample):
  Falcon 595KB, Solid Queue 611KB, Rails Auth 600KB — all at 2400×1260.
  Covers live at `.stitch/designs/falcon-production-tuning-cover.html`,
  `.stitch/designs/solid-queue-advanced-cover.html`,
  `.stitch/designs/rails-8-authentication-cover.html`.
* **Snippet hygiene — TL;DR blocks**: TL;DR summary blocks with Quick
  start added to all 5 worst 0-CTR posts (langgraph-workflows, autogen-
  crewai-langgraph, crewai-multi-agent, langchain-memory, laravel-11-
  migration). Each includes 2-3 sentence summary + copy-paste-able quick
  start command sequence for better SERP snippet extraction.
* **Build infrastructure**: PostCSS installed (`npm install --save-dev
  postcss postcss-cli`). `bin/hugo-build` now passes clean (740 pages,
  exit code 0).
* **Bug fixes**: langgraph-workflows frontmatter `---` delimiter had
  concatenated to slug line during TL;DR insertion — split back to
  separate line. All 3 new posts + 3 covers verified in Hugo build.
* **Validation**: All 3 new posts passed blog pipeline validation
  (voice self-test 10/10, zero banned words, zero em dashes, zero
  generalized actors, zero mannerism nouns, zero definitional cadence).
  Solid Queue post received +1 internal link (Rails Auth) and client
  story (April 2026 preserve_finished_jobs disk incident).
* **Content plan** — [content-plan](/content-strategy/content-plan.md) and
  [blog-pipeline](/workflows/blog-pipeline.md) already synced.


* **New**: [content-plan](/content-strategy/content-plan.md) concept — the
  active Q3 2026 3-stream plan built from Apr–Jul GSC performance data (449
  clicks, 478K impressions, 0.09% CTR). Supersedes the ICP-E-focused 20.07
  plan. Rails technical 2/week, founder every other week, snippet hygiene
  sprint. Resource at
  `docs/projects/2510-seo-content-strategy/20-29-strategy/20.08-content-plan-data-driven-q3-2026.md`.
* **New**: [Falcon Production Tuning](/blog/falcon-web-server-production-tuning-benchmarks/)
  blog post — first Phase 1 expander from the new plan, extending the #1
  performing post (54 clicks, 0.89% CTR) with production worker sizing,
  24-hour memory curves, wrk2 benchmarking methodology, GC tuning, and
  a "when we rolled back to Puma" case study.
* **Update**: [blog-pipeline](/workflows/blog-pipeline.md) — content plan
  reference updated from 20.07 to 20.08; title constraint relaxed from ≤45
  to ≤60 chars (matches Google SERP display limit); added snippet-hygiene
  cross-link to the content-plan concept.
* **Update**: 5 worst 0-CTR blog posts had titles and meta descriptions
  rewritten per the snippet-hygiene sprint (langgraph-workflows, autogen-
  crewai-langgraph, crewai-multi-agent, langchain-memory, laravel-11-
  migration). Projected +435 clicks/3mo. Titles now all ≤60 chars.
* **Update**: [content-strategy index](/content-strategy/index.md) — added
  content-plan entry.

## 2026-07-18 - Merged blog/site bundle into course bundle
Folded a separately-produced Hugo blog/site OKF bundle into this one as two
new sibling sections: `architecture/` (hugo-site, css-pipeline, blog-list-page,
cover-image-pipeline, seo-meta-tags) and `content-strategy/`
(icp-primary-website-target, voice-guide). Added five site/content workflow
concepts to `workflows/` alongside the existing course pair: blog-pipeline,
linkedin-post-pipeline, css-maintainability-plan, visual-scroll-gate, testing.
Root index and workflows index updated with the new entries. No course-side
concepts changed; distilled from CLAUDE.md, bin/hugo-build, Rakefile,
config/_default/hugo.toml, theme layouts, and docs/workflows/ +
docs/90-99-content-strategy/.

## 2026-07-19
- bin/qtest added (scoped visual gate): PRECOMPILED_ASSETS + Minitest -n filter over an ownership-map-derived page set; ~25-60s per micro-commit vs >5 min full stack. Spec Phase C gate stack now items 4 (qtest per commit) + 5 (full suites per milestone/PR). test-gates.md updated.

## 2026-07-19 (2)
- Live incident: visible skip-link site-wide - CI PurgeCSS cold-start race (no hugo_stats.json on first pass). Fixed: safelist sr-only/skip-link (#377) + structural warm-up guard in bin/hugo-build and _hugo.yml (#378). Phase C completed and closed (PRs #371-#376).

## 2026-07-26
- Media pilot shipped: 7 hand-drawn SVGs across 4 course pages (outreach-sequence-template x3, interview-scorecard, pre-launch-checklist, channel-selection channel-fit canvas) + 2 new template pages with JetVelocity covers, wired into _index.md template lists and companion lessons 2.1/4.4. New concept: design/media-design-guidelines.md (external baseline; slides/video sections marked not-applicable - course is text-only per 30.03). Gap audit: 40.20 in project 2605; P0 rows marked shipped. Lesson re-learned: run the visual scroll gate BEFORE committing SVGs - the first cut of all 6 SVGs shipped with text-overflow/misalignment defects that one Chrome pass caught.

## 2026-07-26 (2)
- Correction: the media-design-guidelines concept added earlier today was misplaced in .okf/design/ (a rendering-spec section) and duplicated raw external research that docs/projects/2605-.../10.06-media-design-recommendations.md already distills/adopts. Removed from OKF entirely and relocated as docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.09-media-design-guidelines-external-baseline.md (source material, not an operational concept). Rule: raw external research belongs in docs/projects/<project>/10-19-research/, not .okf/ - OKF concepts are for durable operational knowledge distilled FROM research, not the research itself.

## 2026-07-26 (3)
- Correction to the correction: the doc is enforced guidelines/results, not research - moved again to docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.07-media-design-guidelines.md (the project's specs/requirements section, alongside 30.03-course-format-requirements-for-creators.md) rather than 10-19-research/. Rule refined: 10-19-research/ is for investigation/analysis docs; 30-39-architecture-design/ is for adopted, enforced specs - a doc that prescribes what creators must do belongs in the latter even if its origin was external research.

## 2026-07-26 (4) - Sourcing quality gates + lead/VoC recency split
Batch-1 send-run pre-research (send-runner-prompt Phase 1, via Claude-in-Chrome)
found 3 of 5 curated openers unsendable (6-year-old post; 1-year-old comment
mis-routed as a post; thread saturated by a competing "free" pitch). Root cause:
recency was eyeballed from search excerpts, never verified by reading the thread
timestamp. Fixes shipped: v2 qualification rubric (5 checks, hard capture-time
gates) in rescue-sprint/t4-t5-grooming.md; Paul's policy split codified — leads
must be verified ≤30 days (all venues, no exceptions), VoC quotes have no age
limit and are harvested even from dropped-stale threads. SEND-SHEET now carries
per-message GO/HOLD banners (batch-1 currently 0-for-5; Joy Adamson is the one
Paul-override candidate). Board: #28 done, #29 (re-source v2) is the critical
path. Updated: [outbound-sprint](/workflows/outbound-sprint.md).

## 2026-07-30 - Course strategy review: completion mechanics beat more media
Benchmarked the course against 4 Product Compass course pages (browser walk),
the two Lenny-podcast skill repos, and a 57-source NotebookLM learning-research
corpus, then ran a 3-persona synthesis (pedagogy / Sam-ICP / media-delta audit).
Convergent finding: the completion gap is progress MECHANICS, not media - Wave
C1 added to the TASK-TRACKER (20-min first-win path, tool-stack tables deferred
to JIT, implementation-intention lines, Clarity-gated localStorage progress
tracker, living-document trust line). Public completion certificate REJECTED:
idea-stage Sams are stealthy and won't share "I'm validating an idea"; the
Phase-2 completion artifact is the private Founder OS pack. Delta audit found
40.20's cover-based scan blind to the reference tier (5 chapters 1.8-2.5k words,
zero visuals; 19 pages coverless; true zero-body-visual count 17 not 1) and to
density (5.4k-word single-SVG walls pass) - DoD now carries words-per-visual
<=600 + worked-example fading (templates never ship blank). Updated:
[course-structure](/content/course-structure.md), TASK-TRACKER waves, GOAL-AT-A-GLANCE.

## 2026-07-30 (2) - Waves C1 + M1 shipped; Clarity config gap; sprint retro
PR #390 (1.1 two-sitting split + overview first-win path, 4-eyes reviewed) and
PR #394 (4 hand-drawn SVGs for the visual-less core lessons, designer agent in
worktree + team-lead browser walk) both merged. C1 progress tracker DEFERRED by
2-1 team vote (Sam-ICP + operator over pedagogy) - pilot data decides. P0 gap
found: `microsoftClarity` was never set in config, so the shipped Clarity
snippet collects nothing - blocks pilot recordings; one-line fix documented in
TASK-TRACKER. Retro learnings: (1) subagent SendMessage-to-main is unreliable -
synchronous spawns or nudge-pings needed, budget ~2x expected wall time;
(2) worktree isolation saved the shared checkout when the designer cd'd wrong;
(3) groomed-backlog wording can drift from page reality - agents must verify
spec numbers against page content (two catches this sprint); (4) 4-eyes critic
rounds caught 5 real voice defects my own pass missed - keep as blocking gate.
Updated: TASK-TRACKER wave states, [course-structure](/content/course-structure.md).

## 2026-07-30 (3) - Waves M2 + M3 shipped, M4 closed; media modernization COMPLETE to pilot gate
PR #395 (M2: salvage-vs-rebuild mermaid tree, where-to-hire region map SVG,
hire-track trap-vs-redline table, self-serve mistakes grouped table; 4-eyes
4/4 PASS) and PR #396 (M3: interview-scorecard + pre-launch-checklist PDFs +
channel-fit-canvas landscape one-pager; portrait clip caught in review) both
merged. M4 investigated + closed: portrait worksheet variants = single-source
violation; phone answer is the M3 PDF link; ceiling in
[house-visual-spec](/design/house-visual-spec.md). Board lesson: the
words-per-visual audit metric can't see blockquote scripts/Bad-Good pairs -
3 of 4 flagged word-walls were already healthy; assess per-H2 before
building. All agent-doable media waves (M1-M4) are now DONE; M5 + Phase 2 +
Sprint D are pilot-gated. The wave order M1->C1->M2->M3->M4 completed in one
day (5 PRs: #390/#392/#394/#395/#396).

## 2026-07-30 (4) - Growth waves G1-G3 + M5 shipped; GA4 root cause fixed
Growth runbook 20.12 created (agent-executable marketing plan; standing
decisions: fully ungated, NO mail list, no selling, stealth ICP). Shipped:
G1 docs-truth sweep + production GA4 verification which found the ROOT CAUSE
of muted analytics - privacyCompliant=true defaulted consent to denied with
no banner to ever grant it, AND click events lacked beacon transport. Fixed
in PR #402 (consent granted for analytics_storage, ads stay denied, beacon
added, plus the stealth-compatible copy-link button on 5 module-end
lessons - both visual suites green after rebuilding the stale Docker test
image from #391's gem bumps). PR #404: 10 evergreen blog posts now deep-link
8 course lessons (was 0 of ~580). PR #398: 16 pilot-gated campaign briefs.
PR #406: Wave M5 un-gated by Paul - 3 P2 SVGs (2 pages skipped as already
covered) + module-end checklists M1/M2/M3/M5 + clean interaction audits.
All wave branches cleaned. REMAINING: M5c reference-tier visuals + ~19
covers, G2.2 SERP spot-check, post-deploy GA4 re-verification.

## 2026-07-31 - bin/test port bug root-caused; restore-on-green baselines (PR #424)

Host bin/test failed 49/49 screenshots while bin/dtest stayed green. Root
cause: the R2 fast path built with baseURL=http://localhost:1314 while
Capybara boots Puma on a random port (TEST_SERVER_PORT only set in
Docker) - every stylesheet and clicked link hit a dead port. Fixed to
baseURL "/" (matching CI/qtest/Hugo#precompile). Second fix: green runs
of bin/test/bin/dtest/bin/qtest now auto-restore
test/fixtures/screenshots (red runs keep candidates; re-records exempt
via FORCE_SCREENSHOT_UPDATE), ending the dirty-fixture-guard deadlock
after every passing dtest. Also: dtest reuses warm builds. Re-recorded
12 genuinely-changed macos baselines (record mode had briefly saved
Chrome ERR_CONNECTION_REFUSED pages as baselines - caught by brightness
audit before commit). test-gates.md updated with both caveats.
Evidence: PR #424 (fix + verification transcript: host bin/test 34 runs
0 failures in 5:01 vs 29F+2E in ~11min before; bin/dtest 34 runs 0
failures; forced-red run preserved candidates). Code: bin/build-if-stale
(BASE_URL default), bin/test / bin/dtest / bin/qtest (restore-on-green).

## 2026-07-31 - warm-tree staleness trap + OS-scoped dirty guard

bin/test was red and bin/dtest refused to start. Root cause was NOT a
regression in either script: `_dest/public-test` had been built at 20:17
with the pre-#424 absolute `localhost:1314` baseURL, and #424 landed at
20:45 - but `bin/build-if-stale`'s `stale()` compares only content/theme
SOURCE mtimes against `$DEST/index.html`, so the poisoned tree was judged
warm forever. Every asset 404'd on Capybara's random Puma port; the 21:48
run rewrote 49 macos baselines with black/unstyled renders (404.png = black
canvas + inline-critical nav only; homepage/_footer.png = raw unstyled
HTML). Those 49 dirty files then tripped the dirty-fixture guard, which
globbed the WHOLE screenshots tree - and since the test container has git
(`safe.directory /app`), macOS dirt aborted the Linux leg too.

Fixes (2 one-liners + 1): `bin/build-if-stale` counts `bin/build-if-stale`
and `bin/hugo-build` as sources; the guard in
`test/application_system_test_case.rb` scopes to
`test/fixtures/screenshots/#{Capybara::Screenshot::Os.name}`;
`test/support/setup_snap_diff.rb` deletes a stale snap_diff_report.html at
load (the reporter only writes on failures, so a green run otherwise leaves
the previous red run's report describing diffs that no longer exist - it
bit on the very first green run here).

Verified: rebuilt tree emits root-relative `/css/...` with zero
localhost:1314; warm rerun still short-circuits; `bin/test` 34 runs 0
failures, 53 screenshots compared, tree auto-restored clean; with a
deliberately dirtied macos baseline `bin/test` aborts while `bin/dtest`
runs. Skipped as YAGNI: a `$BASE_URL` stamp file - no caller passes a
different base URL to the same dest (test/qtest -> public-test at "/",
dtest -> public-dtest at "/", dtest-all -> public-dtest-all absolute).

Non-issue confirmed, not changed: this Mac is in Dark Mode and headless
Chrome 151 reports `prefers-color-scheme: dark`, but the only dark-mode CSS
is `themes/beaver/layouts/shortcodes/testimonial.html` and that shortcode
has ZERO usages - the black canvas was purely missing CSS. If baselines
ever come back black on a light-mode-recorded tree, the pin is
`"blink-settings" => "preferredColorScheme=1"` in CHROME_ARGS (verified on
Chrome 151 --headless=new; `--force-prefers-color-scheme=light` is not a
real switch).


## 2026-08-01 - W2-T5: hire-track reference split + since-2011 canon

hire-track-supplementary-reference (5,558w, 2x the 2,900 reference cap)
split at the contract seam: FCTO bridge + Reading the SOW moved whole to
new companion `fractional-cto-sow-reference` (2,893w); find-developers,
stack conversation, interview screen stay (2,890w). All anchored inbound
links re-pointed (13 course pages + 2 blog posts), zero aliases. The only
whole-section 2-page partition that fits the band - FCTO (2,132w) cannot
share a page with the stack section. Two "20 years" tenure claims fixed
to since-2011 canon (kit Built-by, hire-track stack intro); ratchet
signatures added; Cagan "20 years" in hire-decision-full is distinct,
untouched.

## 2026-08-01 - Removed toolchain drift-gate unit tests (config-mirror anti-pattern)
* **Remove**: `test/unit/toolchain_pins_test.rb` deleted in full. It was a config-mirror "drift gate" asserting `.mise.toml` version pins equal the literal pins in the setup-hugo action, `_hugo.yml`, `.dev/compose.yml`, and `.ruby-version`. `test_setup_hugo_action_matches_mise` red-built on a FALSE invariant: `.mise.toml` `node = "latest"` (devs want latest) vs CI `node-version: '22'` (pinned on purpose in #393) - a correct divergence, not drift. Tests config agreement, not behavior; violates FIRST + the CLAUDE.md "no fragile config assertions" rule. Comparing CI-vs-local node explicitly was considered and rejected as overkill (Paul). Refs cleaned: Rakefile `:guards` list, `.mise.toml` / setup-hugo `action.yml` header comments, README, `docs/SETUP.md`, this bundle's [ci-gates](/build/ci-gates.md). Pins still need manual sync when bumping - now by convention, not a gate.

## 2026-08-01 - W3-T1: v3 exhibit spec appended to house-visual-spec

Added a `# v3 exhibit spec` section to `.okf/design/house-visual-spec.md`
(hand-drawn spec untouched, O1 still needs it) covering the six components
ADR 30.09 Phase A demanded: 12-col grid at a canonical 720 viewBox, 8px
spacing scale, connector spec (2px orthogonal + 4px radius O2 / hand-curve
O1), data-viz rules (fill=data / stroke=structure, ruby-for-signal,
threshold-vs-band), aspect-ratio table (mobile-safe default 3:2), and the
5-rung type scale. The >=9px @390px floor is a formula, not prose:
`rendered = font_viewBox * 390/W_viewBox`; basis rung 17px @ W=720 renders
9.21px. O1 bumps the floor x1.15 (basis 20px) for Caveat's small x-height.
Includes the action-title/one-message/basis-line grammar and an O1-vs-O2
scoring rubric so the T2 A/B pair scores both on the same axes.

## 2026-08-07 — content plan of record corrected to 20.08; cannibalization guard added

`docs/workflows/blog-pipeline.md` STEP 1 and `GOAL-AT-A-GLANCE.md` both still
named 20.07 as the plan of record, four months after 20.08 superseded it.
Following either literally picks from the wrong calendar. Both repointed at
20.08; 20.07 is now described as the home of the founder-stream topic briefs
only.

Added the check that would have caught the real trap: a queued row naming a NEW
slug is not proof the topic is uncovered. E3 (Solid Cache vs Redis) and F1
(Propshaft migration) both target keywords an existing long post already ranks
for - F1's target IS the page holding 8,832 impressions at position 12.8.
Writing them as new posts splits the ranking. Both are upgrade-in-place; the
rule now lives in `.okf/content-strategy/content-plan.md` and in STEP 1.

Also corrected `/services/startup-cto-consulting/` (named in 20.08's funnel
section, does not exist) to the paths that do exist under `content/services/`.

E4 Kamal 2 multi-server taken as the next post instead - the six existing Kamal
posts are all single-server and 2024-era, so it splits no ranking.

## 2026-08-07 — E4 Kamal 2 multi-server published; technical posts need a source-verification critic

Published `kamal-2-multi-server-deployment-complete-guide` (Q3 plan E4, PR #437).
Taken ahead of the earlier-queued E3 and F1, both of which target keywords an
existing long post already ranks for and are upgrade-in-place jobs instead.

The durable lesson is about the review loop, not the topic. The standard
3-persona loop (founder / SEO-slop / copy editor) passed a draft that still told
readers to run migrations with bare `kamal app exec` from a `pre-deploy` hook.
That resolves to the `latest` tag, and Kamal only moves `latest` after every host
boots, so the hook would have run the release being replaced. Silent no-op
migrations on every deploy.

For developer-targeted posts, swap the ICP-E founder persona for a practitioner
critic that verifies every claim against a PINNED upstream commit and reports
file:line. That critic caught the migration bug plus a `--target`
self-contradiction and a wrong `drain_timeout` default. The cold-eyes gate then
caught a wrong claim about Sidekiq-Cron's dedup and a wrong date for kamal-proxy
PR #124. Five factual defects total; voice review surfaces none of them.

Two mechanical notes: cite as GitHub permalinks pinned to the released tag, since
bare file:line rots. And per-diagram mermaid `%%init%%` headers copied from older
posts OVERRIDE the house theme in `baseof.html` and silently shrink label text
below the 20px house size - drop the override and fix legibility structurally,
per the standing brand rule.

## 2026-08-07 — service links dropped from deep-technical posts

Paul's call on PR #437: developer-targeted technical posts no longer carry a
service-page link. 20.08's bidirectional-funnel rule required one on every Rails
post, but a fractional-CTO link at the end of a post about container ids and boot
denominators reaches the wrong reader and costs more credibility with engineers
than it returns. Those posts still cross-link sibling technical posts, which is
what actually keeps readers on the site. Founder-stream posts keep the funnel
requirement unchanged. Exemption recorded in 20.08 and applied to
`kamal-2-multi-server-deployment-complete-guide`.
## 2026-08-07 - Test coverage gap analysis; two false-green mechanisms found

Full audit written to
`docs/20-29-testing-qa/20.10-test-coverage-gap-analysis-reference.md`.

* **`lib/` is healthy**: 91.6% line coverage (716/782 relevant lines),
  measured with SimpleCov over `test/unit/sync/**` +
  `course_validators_test.rb` (103 runs, 207 assertions). Worst files are
  network-error branches in `dev_to_article_fetcher` (67.9%) and
  `sources/base` (75.0%). SimpleCov is in the Gemfile but `require`d
  nowhere, so no coverage is collected in any run today - the measurement
  needs a `RUBYOPT=-r<cov.rb>` shim.
* **False green #1**: `test/integration/hugo_pipeline_test.rb:48-51` `skip`s
  the whole asset-pipeline suite when the Hugo build fails - the exact
  failure it guards. Should `flunk` with the build stderr.
* **False green #2**: 42 conditional assertion guards across the unit tests
  (`if robots_meta ... assert ... end`, e.g. `baseof_template_test.rb:153`,
  `404_template_test.rb:186`). They pass when the element is absent, while
  reading as "present and well-formed".
* **`rake test:html_proofer` is invoked nowhere** (no workflow, hook, or
  script); `rake test:integration` never gates a PR. Recorded in
  [ci-gates](/build/ci-gates.md).
* **ci-gates.md was stale**: it claimed a toolchain drift test "fails the
  build when any copy diverges". That test was deleted 2026-08-01 (see
  entry above) - pins are now synced by convention with zero enforcement.
  Corrected. Same stale phrase removed from the Rakefile `:guards` comment.
* **Validator scope boundary is measurable**: `CourseValidators` filters on
  `course_chapter == true`, so 82 of 727 content pages are gated. Em-dash
  files by scope: course 0/82, marketing 1/37, blog 208/607. The CLAUDE.md
  `-` not `—` rule holds exactly where a validator enforces it. Blog needs
  ratchet semantics (no NEW violations), not a hard fail on 208 legacy
  dev.to imports.
* **Untested money paths**: the contact/free-consultation form renders every
  field `name` from `.Site.Params.forms.contact.*`; Hugo renders a missing
  param as `""` with no error, the page stays pixel-identical, and leads
  submit blank. `seo/faq-schema.html` ships on 10 service pages with zero
  tests while article/breadcrumb/organization/service schemas each have one.
* **`lib/sync/sources/sanity.rb`** (129 lines) is referenced by nothing
  outside itself and loaded by no test - 0% covered, and it holds the
  `sanity-ruby` gem dependency in place. Delete-or-test decision.

## 2026-08-07 - Closed the two false-green mechanisms; wired the two dead CI gates

Follow-through on the gap analysis logged above. `rake test:unit` 272 -> 285
runs, 5723 -> 5935 assertions, still 0 failures.

* **Integration suite fails loudly now**: `hugo_pipeline_test.rb` replaced its
  two `*_ready?` predicates with `build_failure`, which returns nil or a
  diagnostic and is `flunk`ed in `setup`. It distinguishes "hugo not on PATH"
  from a real build error and prints the last 30 lines of build output.
  Verified by shimming `hugo` to `/bin/false` - the suite fails instead of
  skipping 11 tests into a green report.
* **`rake test:integration` now gates PRs** as an `Asset Pipeline` job in
  publish.yml, separate from `unit_tests` (it drives two Hugo builds of its
  own, ~50s locally) with `setup-hugo build: 'false'`.
* **`rake test:html_proofer` is finally invoked**: link-check.yml runs
  `rake test:links test:html_proofer` as ONE rake invocation. `build_for_linkcheck`
  is memoized per process so the pair shares a single production build - two
  separate steps would each trigger their own build, which is exactly what blew
  that job's timeout before (the reason the workflow passes `build: 'false'`).
  Timeout 10 -> 15 min.
* **Two schema test files were dead code**: `breadcrumb_schema_test.rb` and
  `service_schema_test.rb` were commented out in full behind stale
  "restore when <X> schema implemented in reverted HTML" TODOs. The build emits
  both `BreadcrumbList` and `Service` today. Uncommented, 3 tests each, green.
  Lesson: a test file existing is not coverage - grep for `def test_`, not for
  the filename.
* **New `test/unit/lead_forms_test.rb`**: the funnel forms' field `name`s come
  from `[params.forms.*]`, and Hugo renders a missing param as `""` without
  failing the build. RED-verified by renaming `first_name` in hugo.toml and
  rebuilding - the test names the broken field id and the config key.
* **New `test/unit/meta_tags/faq_schema_test.rb`** (6 tests) including a sweep
  over every service page declaring `faqs` in frontmatter, so a template guard
  that stops matching turns red instead of silently dropping rich results.
* **Guard sweep, `baseof` + `404`**: presence assertions where the element
  exists; dead branches deleted where it does not (`.logo-image-main` no longer
  exists anywhere; no `meta[name=referrer]`; no search form). The mermaid SRI
  test asserted the retired jsdelivr+SRI implementation while running against
  index.html, which never loads mermaid - retargeted to a diagram page and
  rewritten to assert same-origin, matching the self-hosting change.
* **Test-env gotcha**: `parse_html_file` uses bare `File.read`, so on a
  container with no `LANG` (`Encoding.default_external` = US-ASCII) Nokogiri
  aborts with "FATAL: Invalid bytes in character encoding", every selector
  returns empty, and 73 template tests fail for a non-template reason. Run the
  suite under `LANG=C.UTF-8`.

## 2026-08-07 - Guard sweep found a live bug the false-green was hiding

Continued the conditional-assertion sweep into `list_template_test.rb` and
`home_template_test.rb`. `rake test:unit` now 276 runs / 5967 assertions /
0 failures (from 272 / 5723): the suite got SMALLER and checks MORE.

* **Live bug, hidden for as long as the test existed**:
  `test_list_page_date_information` selected post items with
  `"article, .post, .post-item, .entry"`. The blog index renders `.blog-post`
  and nothing else from that list, so the selector matched ZERO items on every
  run - and `if items.any?` turned that into a pass. Both list tests now share
  one `ITEM_SELECTOR` constant so the two cannot drift apart again. This is the
  concrete argument for the sweep: a guard does not just fail to catch future
  regressions, it hides present ones.
* **`setup` skips are the same defect one level up**: `list_template_test`
  skipped all 13 tests when no list page was found. The blog index vanishing IS
  the regression. Now `refute_empty`.
* **Classification rule that made the sweep tractable**: check the built page
  first, then decide. Element present -> replace the guard with a presence
  assertion. Element absent -> the branch is dead; delete it and record in
  place what to assert if the feature ships. Deleted this round: filtering/
  sorting, RSS head link, search, `.breadcrumb`/`.author`/`.category` elements,
  homepage breadcrumbs, CSP meta, analytics (environment-gated out of the test
  build).
* **Discarded-value lines are a sibling smell**: `external_scripts.length +
  external_stylesheets.length` and `large_images.any? { ... }` computed a value
  and dropped it. Where an invariant was behind them it is now asserted - the
  404 page, blog index, and homepage each load zero third-party scripts and
  stylesheets, which is also why the site needs no dns-prefetch.
* **Scan over-reports**: `.each` over a literal array, or over a collection the
  test already asserted non-empty, always runs. 61 raw hits, 32 addressed;
  the rest live in template_cleanup_validation (9), hugo_partials (8),
  single_template (5), seo_schema (3) + singletons. Scan script is in
  `docs/20-29-testing-qa/20.10-test-coverage-gap-analysis-reference.md` §5.

## 2026-08-07 - Guard sweep complete: 61 candidates triaged, four live bugs found

Finished the conditional-assertion sweep (single_template, hugo_partials,
template_cleanup_validation, seo_schema, asset_url_validation,
hugo_asset_validation, testimonial_shortcode). `rake test:unit` 275 runs /
6086 assertions / 0 failures, from 272 / 5723 - assertions +363 while the
test count went DOWN by 13. That ratio is the whole point of the exercise.

**Four live bugs the guards were hiding** (a guard does not just miss future
regressions, it hides present ones):

1. **`single_template_test.rb` never tested a single page.** `@test_pages` led
   with `"blog/index.html"` and `.first` picked it, so 376 lines nominally
   covering `single.html` ran against the LIST page. Pinned to a real post via
   `SINGLE_PAGE`. Retargeting immediately exposed bug 4.
2. **Two item selectors omitted `.blog-post`** - the only class the blog index
   renders. `test_list_page_date_information` and `test_blog_post_partials`
   matched zero items on every run.
3. **`css_urls.any? do |url| assert ... end`** in asset_url_validation:
   `any?` short-circuits on the first truthy block result and `assert` returns
   true, so only the FIRST stylesheet was ever checked.
4. **Over-strict a11y rule**: image-only links were flagged as having no
   accessible name. A link wrapping an image takes its name from the image
   `alt` (WCAG 2.1 SC 1.1.1). Blog posts wrap YouTube thumbnails this way.

**Skip-style guards are the same defect one level up** and are all gone:
list_template skipped 13 tests with no list page; 404_template skipped 12 with
no 404.html; template_cleanup_validation had 9 `next unless test_page_exists?`
+ 3 `return unless` (now one `assert_empty missing` in setup, helper deleted);
seo_schema called `skip "Schema N is empty - might indicate template issue"` -
an empty JSON-LD block IS that template issue.

**Reusable rule for this class of work**: check the BUILT page first, then
decide. Element present -> presence assertion. Element absent -> the branch is
dead; delete it and record in place what to assert if the feature ships. Never
promote a guard to an assertion without confirming the element exists, and
never delete without confirming it does not.

## 2026-08-07 - CI timeouts sized from measured cold-cache runs, not averages

Three runs of the new gates produced hard numbers worth keeping:

* `Broken Internal Links`: **3.5 min warm, 10.7 min cold** (right after master
  moved and invalidated `resources/_gen`). At its original 10-minute timeout
  the cold run would have gone red for nothing but cache state. Now 15.
* `Asset Pipeline`: **~10 min** for the suite itself - two full Hugo builds,
  and the dev-environment build cannot reuse the production-keyed resource
  cache, so it reprocesses images. Plus `actions/checkout` measured at **7 min**
  on one slow runner: 17 min of wall clock against a 15-minute cap. Now 25.

**Rule**: size a CI timeout from the worst observed run plus headroom, never
from the average. A gate that flakes on timeout is worse than no gate - it
trains reviewers to ignore red, and the runner minutes it "saves" are trivial
next to that. Diagnosis tell for this class: read the per-STEP timings in
`list_workflow_jobs`, not just the job duration - the 7-minute checkout was
invisible at job level and would have been misread as a slow test.


## 2026-08-07 — content plan re-review: pipeline-first revision (20.09)

Four-agent re-review (market, SEO, competitor, goal-alignment) against the 2607
bet. 20.09 supersedes 20.08's allocation, cadence, and click projection; 20.08's
GSC analysis stands.

The finding that reorders everything: 2607's own rabbit-hole says "never ship a
content sprint while the outreach is stalled," and outreach IS stalled - all
batch-1 messages HOLD, zero sendable rows, card #12 blocked on #29. Four Rails
deep-dives shipped Jul 22 - Aug 7 anyway. Content is not the binding constraint;
prospect sourcing is.

Cheapest high-value fix, no new content: the rescue offer page has zero inbound
links from 608 blog posts. Six pre-qualified rescue posts link to it zero times.

Also corrected: real capacity is ~6 posts/month (June 2026 = zero posts), not the
2-3/week the plan assumed; seven queued rows duplicate existing posts and F2
already shipped into a 4-post auth cluster; the 435-click snippet projection
predates AI Overviews.

Market shifts: CVE-2026-66066 (Active Storage RCE, CVSS 9.5, Jul 29) is the rare
durable+urgent+in-authority item - and patching Rails alone is NOT sufficient,
libvips must go to >=8.13 and secrets must be rotated. "Vibe code rescue" is no
longer an uncontested category: justinmckelvey.com (cited in our own strategy as
proof the model works) now sells it at $25K-$50K under the same name.

## 2026-08-08 — 20.09 execution: funnel links, auth consolidation, CVE post; sourcing blocked

Executed the 20.09 priority stack. Three of four landed.

P1: /services/vibe-code-rescue/ now has inbound links from the six rescue-intent
posts. It previously had zero from 608 posts.

P2: the 4-post Rails-8-auth cluster consolidated to one canonical with three
aliases. Merging also fixed a real bug the canonical carried - its password-reset
action branched on "Email not found", leaking account existence.

P3: first durable-news post shipped (CVE-2026-66066). The review loop caught four
blockers; the load-bearing one inverted the post's thesis. The draft said the
patched gem's guard silently no-ops on libvips < 8.13. The advisory says the
opposite verbatim: "Active Storage will raise an exception during boot in such an
unsecurable environment." It fails CLOSED. As drafted, the runbook (bump gem,
deploy, fix libvips later) would crash a reader's app at boot on Ubuntu 22.04,
which ships libvips 8.12.1. Runbook now lands libvips >= 8.13 first.

Two review lessons worth keeping:
1. The fact-check critic marked a date VERIFIED that does not exist in its cited
   source (Rails 7.1 EOL "2025-10-01"; the announcement gives no date and is
   itself published 2025-10-29). The cold-eyes gate caught it structurally - an
   announcement cannot announce a date 28 days before its own publication - and
   correctly routed it back instead of editing fact territory. Verifiers can
   over-trust secondary sources; a structural reader catches the smell.
2. Second consecutive technical post where voice-tuned review passed something
   that would break a reader's production. The source-verifying practitioner
   critic is now load-bearing, not optional, for developer-targeted posts.

P0 sourcing: BLOCKED, and the diagnosis moved. F5Bot is retired - it matches
literal substrings and is passive, so it can never backfill the <=30-day window
card #29 needs. Its replacement (p7-search-sweep.md, ~30 site:+after: queries)
produced zero rows for venue-specific reasons, in two distinct classes.
Search-surface limits: bare site:reddit.com queries had the operator dropped
(returned Substack and Goodreads), while the tool's native domain filter did
return indiehackers.com and x.com URLs; after: filtering was ineffective
everywhere tried (IH results dated 2025-07 came back). Venue access: reddit
rejected the agent user agent outright (hard 400), and thread opens on IH, HN,
old.reddit, and lobste.rs all returned EGRESS_BLOCKED - so IH was searchable but
not openable, reddit neither. Card #12's blocker is no longer a 2-minute keyword
swap; it is venue reachability (thread opening above all), and the query bank
needs a human browser.

## 2026-08-08 — 3-column markdown tables overflow at 390px; two posts shipped

Published `rails-7-eol-unpatched-security-exposure` and
`migrate-lovable-replit-app-to-rails`.

**Durable layout finding.** A 3-column markdown table breaks the mobile scroll
gate in this theme. Measured at 390px: the article container is 354px wide and
tables render `table-layout: auto` with no `overflow-x` wrapper, so minimum
content width wins. The migration post's 3 columns computed to 116+132+129 =
377px and pushed documentSscrollWidth to 396. Trimming cell prose did NOT fix it
- min-width is set by the longest unbreakable token per column, not by sentence
length, and a first trim actually made it 1px worse. Collapsing to 2 columns
fixed it: the sibling EOL post's 2-column table lands at exactly 354px.

Rule: **2 columns maximum in blog tables**, or fold the extra column's value into
the last cell in bold. Code blocks are unaffected - they already carry
`overflow-x: auto` and stay inside the container. The systemic fix (wrapping
tables in a scroll container in the theme) is a CSS change and would trigger the
full visual regression pair, so it stays a content rule until someone takes that
on deliberately.

**Also swept**: `<!-- Reference cadence: <author> -->` was shipping in published
HTML on five posts, three of them already live (kamal-2-multi-server,
ai-code-ownership-accountability, claude-code-xp-team-workflow). It is internal
review metadata from the writer brief. Removed sitewide; writers should report
cadence in the handback, never in the file.

## 2026-08-08 — Passive keyword monitor purged from the sourcing machinery

**Decision (Paul)**: remove F5Bot outright — "it's not working as you wanted."
The tool was already marked retired on 2026-08-08, but the retirement was
half-done: its doc survived as a "kept for the keyword derivation" stub, and two
separate boards still carried *"paste the v2 keywords into F5Bot"* as a
load-bearing 2-minute ask on Paul's desk (`operation-runbook.md` Sprint-3 header
and `20.09` §P0). A dead blocker parked on the CEO's desk is worse than no
blocker: it reads as the cheapest available unblock, so it displaces the real
one.

**Durable rule — two structural tests any sourcing tool must pass.** Neither is
fixable by better keywords, and both killed this one:

1. **Active, not passive.** A monitor only knows what arrived after it was
   switched on, so it can never backfill a window. Card #29 needs rows verified
   inside ≤30 days *on demand*; a passive feed cannot satisfy that by
   construction.
2. **Ranked retrieval, not literal substring matching.** Founders don't type our
   phrasing. The v1 composed phrases (`vibe coded broke`) matched **0 of the 25
   posts we had already found by hand**.

Do not re-propose the class. Judge paid alternatives (RedReach, Buska, Syften,
CommunityTracker) against those two tests *before* spending.

**Keyword derivation preserved and re-verified**, moved into
`prospects/p7-search-sweep.md` §3 with counts re-run across
`voice-of-customer.md` + `cold-prospect-list.md`: `non-technical` 20×,
`replit` 16×, `lovable` 8×, `cursor` 5×, `vibe coded` 2× (vs the gerund
`vibe coding` 10×, rejected — it floods with commentary, not distress).

**Finding surfaced by the move**: `dev shop` has **zero** corpus occurrences
(`dev shop`/`devshop` 0, `agency` 1). It carries the Trigger-3
ownership/hostage lane, and its only prior coverage argument *was* passive
monitoring. So our second-strongest trigger now rides an unevidenced query term
in a lane grooming already proved unfindable through open search. A zero return
on it is a **lane gap to escalate**, not a quiet zero. `bolt.new`/`base44` are
likewise unevidenced tool-name guesses — drop after two empty sweeps.

**Correction to the board while here**: `#29` was described as agent-runnable.
It is not — the replacement sweep ran on 2026-08-08 and returned zero rows
because every thread-open hit `EGRESS_BLOCKED` and Reddit rejected the tool's
user agent. Qualification requires a timestamp read from the *opened* thread, so
**no sourcing method can produce a lead until thread-open access is restored**
(`chrome-devtools` + egress to indiehackers.com / reddit.com). That is now the
real P0 in both boards, in place of the keyword ask.

## 2026-08-08 — Business/ops/sales/marketing doc-estate consolidation

**Scope**: two exhaustive audits (2607: 31 files/3,053 lines; company layer +
2510 + workflows + OKF) followed by a single cleanup pass. The estate measured
~40% live / ~60% stale-or-duplicated 18 days after creation.

**Durable lessons** (each caused a real defect this sweep fixed):

1. **A state doc that references an uncommitted artifact is a time bomb.** The
   runbook's entry point told every fresh session to read a kanban board that
   was gitignored, never committed, and whose binary isn't installed - cards
   #12-#29 were cited ~40 times across 6 files with no surviving definition.
   Rule: state lives in COMMITTED files only; `backlog.md` §State is now the
   sole card registry.
2. **Phantom human gates outlive their approval.** Two files still said "no
   sourcing until Paul approves" 18 days after sourcing ran - exactly the
   mis-scope the runbook's own Paul's-desk rule forbids. Rule: when a gate is
   satisfied, edit the gate line itself, not just the status table 80 lines
   below it.
3. **N agreeing copies don't prevent 2 disagreeing ones.** Pricing existed in
   12 correct locations AND 2 stale $25-50K locations (assumptions-register E1,
   trigger-taxonomy competitor note) - both feeding sales collateral. Rule: on
   any canon change, grep for the OLD value, not just update the new one.
4. **Roadmaps must sum.** KR2 needs 8-12 calls; the only lane being worked
   maxes at ~2-3. Rocks now carry the arithmetic (three lanes: warm PRIMARY /
   LinkedIn drafts / cold top-up) + a falsifiable Sep-30 midpoint gate.
5. **Supersession must be stamped ON the superseded file.** 20.08 carried a
   banner (the model); 20.07/20.04/20.05 didn't and 20.05 held three
   contradictory states across three files. All banners added; 2510's three
   2025 fossils (_ARCHIVED_ prefix) archived; GOAL-AT-A-GLANCE's dated status
   block (which instructed work 20.09 prohibits) replaced with pointers.
6. **Routers must route to the entry point the OS names.** No router sent
   sessions to the runbook START HERE; flow-router/BASE_HANDBOOK/AGENTS.md now
   carry business + outbound routes, and the dead /Users/pftg machine path is
   gone.

**Cadence canon**: LinkedIn Stream 0 total is 3-4 posts/week SHARED across
campaigns (20.09 §7). Both campaign plans (icp-validation PAUSED 3/10 drafted;
course-promo 9/~25 drafted) now say so - previously they claimed 5/wk each.

## 2026-08-08 — Repo-wide simplification: config surface + docs estate (tranches 1-5)

Follow-on from the business/ops consolidation, per Paul's "what else needs
simplifying." Two audits, five tranches, all on PR #441's branch.

**Removed with zero capability loss (~120 KB):** 132 byte-identical stub
slash-commands (one md5 across all of .claude/commands/ — each was a roster
entry every session paid for); .claude/agents/templates/ + content/ (claude-flow
boilerplate whose hooks call an uninstalled binary); .claude/rules/ (575 lines
of vendored Memoria docs mandating memory_* tools from an MCP configured
nowhere); AGENTS.md lines 77-621 (the same rules concatenated verbatim).

**Durable rules this sweep produced:**

1. **Config documents only installed tools.** Three independent systems
   (claude-flow, Memoria, kanban-md board) left instruction surface behind
   after the tool itself was gone or never wired. Instructions for absent
   tools are worse than none — they mandate impossible actions.
2. **Supreme-authority claims must resolve.** docs/README.md declared a
   /knowledge/ "SUPREME AUTHORITY" that is a symlink to Paul's Mac — dangling
   in every container/CI session — plus three /projects/elital_* repos that
   never existed here. Host-only resources must never be load-bearing policy.
3. **A "latent" registration bug can hide in plain sight**: six agents listed
   as Critical (keep) had no YAML frontmatter and never registered. A doc's
   keep-list is not evidence the thing it keeps exists.
4. **Indexes must be generated, not asserted.** blog-post-index claimed 584
   posts against 607 actual; now `bin/generate-blog-index` regenerates it
   (gotcha: File.read needs explicit UTF-8 in the container locale).
5. **Trackers are queues, not journals.** 2605's tracker hit 1,628 lines,
   ~72% closed history, items physically out of order — the archive-prefix
   convention the project already had was the fix (slim tracker + _ARCHIVED_
   history file).
6. **Date-cohort archiving must check inbound links per-file**: the Oct-2025
   sweep nearly archived a Russian-language research doc that 2605 cites as a
   live June-2026 source.

**Deferred (documented, not done):** the six duplicate 60.xx JD numbers in
60-69-project-management + moving its four testing docs to 20-29 (M effort,
inbound-link risk); .junie/ + GEMINI.md/QWEN.md mirrors (other tools' files).

## 2026-08-08 — Warm lane demoted: C1 premise partially falsified, lanes re-weighted

Paul: "I would not be able to provide 10 warm names." The A0 C1 pick (warm =
primary channel) leaned on an enumeration he can't produce - exactly the risk
the register's devil's-advocate pre-registered ("C1 assumes Paul's network
actually contains ICP-adjacent founders"). Handled per runbook rule 7: a dated
ADDENDUM in the register's §C, not a silent rewrite.

**New lane order** (mirrored in OS Rock 1, runbook C0/C1/sprint map, strategy,
executive summary): LinkedIn PRIMARY (agent drafts, Paul posts 3-4/wk; posting
packet ready - his total effort is copy/paste/post) → cold #29 load-bearing
secondary (tooling unblock back on the critical path) → inbound floor LIVE
(verified: all 6 founder-intent posts link to /services/vibe-code-rescue/,
shipped in yesterday's 20.09 execution) → referral-ask OPTIONAL side lane
(2-3 past clients; a referral source need not be the ICP; nothing gates on it).

**Kill-criteria re-based** everywhere it appears (register, OS §1/§3,
portfolio, executive summary): "2 weeks of warm outreach" → "2 weeks of active
outreach across live lanes (LinkedIn posts and/or verified sends), 0 booked
calls → pause, re-open A + C." Clock starts at first post or first send.

**Durable rules:**
1. **When a human says they can't do the ask, the ask is dead - re-plan the
   lane, don't shrink the ask.** The F5Bot lesson generalized: a dead ask
   parked on the CEO's desk displaces the real unblock.
2. **A pre-registered risk firing is the register working.** The
   devil's-advocate note made this a 30-minute re-weight instead of a crisis -
   record premise changes as dated addenda so the vote history stays honest.
3. **Distinguish the ask from its cheapest satisfiable form**: "10 warm ICP
   names" was unsatisfiable; "2-3 past-client referral asks" survives because
   a referral source need not be the ICP. Demote, don't delete, when a weaker
   form retains value.

## 2026-08-13 - Blog in-body visuals: a gate nothing enforced

Audited the four posts published 2026-08-07/08 (Kamal multi-server, Lovable->Rails
migration, Rails 7 EOL, CVE-2026-66066). The prose gates had all held: zero em
dashes, zero bold inline-header lists, 2-8% paragraph cap breaks against the
39-58% of the failed TDD/XP cluster, varied opener shapes, and every mechanical
pre-publish check green.

The gap was visuals. Three of four had none, and the archive said why: only 2
posts in all of 2026 carried an in-body visual, while 25 of the 31 long posts
published since 2026-04 carried none. CLAUDE.md's cognitive-load gate requires a
hero visual over 800 words; nothing checked it, because
`test/unit/diagram_rendering_test.rb` proves diagrams RENDER, not that posts HAVE
them.

**Durable rules:**
1. **Text gates automate, visual gates rot.** Banned words and frontmatter shape
   are greppable so they survive time pressure; "does this need a diagram" is
   judgment and silently drops. Any gate stated only in prose will decay - give
   it a ratchet script or expect it unenforced.
2. **Ratchet over backfill.** 81 legacy posts are over the line and nobody is
   backfilling them. `bin/check-post-visuals` fails only when the count RISES,
   so new work is blocked while the backlog burns down at its own pace - same
   shape as `bin/check-svg-floor`.
3. **Read the OKF bundle before authoring diagrams, not after.** Skipping the
   session-start consume meant shipping five diagrams with diamond decision
   nodes, which `design/mermaid-theme.md` bans outright. Caught only on the
   pre-commit maintain pass.
4. **A cover chip is a claim with an expiry.** The Rails 7 EOL cover read "7.2
   SUPPORT ENDS August 9, 2026" and the post was written in future tense; both
   went stale four days after publishing. Date-bearing covers and prose need a
   recheck whenever the date passes.
5. **The gem never varies.** `.stitch/design.md` slot 4 is explicit - the
   low-poly ruby is the brand throughline across ALL Ruby/Rails posts.
   "Cover sameness" is the design working, not a defect.

## 2026-08-13 - Mermaid rendered its own source as prose until fonts loaded

Owner reported "images have &nbsp; on it" on the Rails 7 EOL post. Reproduced by
stalling `document.fonts.ready`: `<div class="mermaid">` displays its raw source
as article text - `flowchart TD R70["Rails 7.0 - ...&nbsp;"] ... classDef dead
fill:#fff5f5,...` - because `baseof.html` defers `mermaid.run()` until fonts
resolve and no CSS hid the div in the meantime. Fixed with one rule:
`.mermaid:not([data-processed]) { display: none; }`.

**Durable rules:**
1. **The reported symptom is rarely the bug.** "`&nbsp;` in the image" was not an
   entity-escaping bug - the entity decodes correctly once htmlLabels render it.
   It was a flash-of-unrendered-source bug that happened to expose the entity.
   Chasing the escaping would have produced a fix that changed nothing.
2. **Deferring render needs a matching hide.** Any "wait for X, then swap the
   DOM" pattern leaves the pre-swap content visible for the length of X. The
   font-gated `mermaid.run()` was added to fix label CLIPPING and silently
   created a worse visual defect on the slow path.
3. **Site-wide and three months old.** It shipped with the first mermaid post in
   May 2026 and nobody saw it, because it only bites on a slow font load - the
   visual suite renders after fonts settle, so screenshots were always green.
   A suite that waits for the happy path cannot see the unhappy one.

## 2026-08-17 - Board approvals: one-click decisions land in frontmatter

Paul asked for approvals from the LinkedIn review board with locally tracked
decisions. Shipped: Approve/Reject buttons (keys `a`/`r`) on each
`/linkedin/<lane>/<slug>/` page, backed by `bin/li-review` - a stdlib-Ruby
sidecar that `bin/dev` starts/stops automatically (port 1315). A decision
rewrites the post's frontmatter `status:` (kept as the single status source;
no parallel state file) and appends an audit line to
`linkedin-posts/decisions.log`, then 303s back to the page.

1. **Constraint from Paul: nothing to run besides `bin/dev`.** First cut was a
   separately-started sidecar; folded into `bin/dev` (dropped its `exec` so an
   EXIT trap can reap the child). Hugo alone cannot accept writes - a sidecar
   is the minimum honest write path for a static dev server.
2. **Same session: the harness classifier can DENY typing a post body into the
   LinkedIn composer** (and the contenteditable has no a11y ref for form_input).
   Recipe updated: stage everything, Paul pastes; never chunk-retry a denied
   type action.

## 2026-08-17 - GA property ID made unmissable; LinkedIn attribution trap

Paul asked for the GA property to be recorded so sessions stop re-searching
the account tree - the fact was already in `workflows/analytics-access.md`
(`328508492`), but the session enumerated properties anyway. Fixes:

1. **TL;DR line added at the top of "Which property to query"**: query
   `328508492` directly, never enumerate first. Re-confirmed 2026-08-17:
   LinkedIn/course sessions exist only there; `315618854` returns zero.
2. **New trap**: LinkedIn clicks arrive as `linkedin.com / (referral)` with an
   empty campaign even though staged first-comment links carry UTM. Query by
   `sessionSource CONTAINS linkedin`, not campaign name, and audit the live
   comment's link for lost UTM.
3. First LI-post evidence (Aug 13 validate-before-build): ~4 clicks on post
   day, including a 26-min read of the linked lesson and a 35-min homepage
   session - low volume, high depth.

## 2026-08-17 - mermaid_post: three-layer flake prevention + the stale-baseline tell

The recurring `mermaid_post` screenshot failures resolved into TWO distinct
causes this session, each with its own fix (details in
[mermaid-theme](design/mermaid-theme.md) §Flake prevention):

1. **The race (real flake):** fonts.ready does not force-request Caveat;
   mermaid could measure with the fallback. Fixed in baseof
   (explicit `fonts.load` before `mermaid.run`) + the test now asserts
   `fonts.check("20px Caveat")` and `[data-processed]` before capture.
2. **The stale baseline (not flake):** PR #457's heading-anchor CSS +
   an upstream de-fabrication edit ("200+ projects" dropped from the post
   opener) shifted text; linux baselines were left for CI on purpose.
   Tell: byte-identical difference_level across runs. Fix: accept the CI
   run's own captures (`screenshots-report-full` artifact) as baselines
   after eyeballing the heatmap; macos legs re-recorded locally.
3. **Pre-render option:** `bin/render-mermaid` renders fences to committed
   SVGs at authoring time (Caveat data-URI injected so mmdc measures
   correctly); render hook embeds them and skips mermaid.js. Opt-in per
   page, zero CI footprint.

## 2026-08-17 - Content rewrite pipeline: hub posts, scannability pendulum, humanizer merge

Three durable learnings from the vendor-post rewrite + lovable-guide session:

1. **Hub-post pattern**: when a listicle rots (fabricated stats, wrong
   persona), the rewrite target is the CLUSTER HUB - own the taxonomy and
   the lifecycle map, link each phase to the specialist post/lesson that
   owns the checklist depth. Run the claims audit + cluster/signal map
   agents BEFORE writing; the do-not-reuse list prevents double-anchoring
   sibling stats (Deloitte/Qodo/LitsLink were already triple-anchored).
2. **The scannability pendulum**: "too many lists" -> all-prose overshoots.
   The stable middle: bold lead-in taxonomy paragraphs + varied-phrase H3
   anchors + ONE hero exhibit in the first fold + one closing action list.
   Slop-critic fixes (de-quarteting bold labels) must be re-checked against
   the F-pattern gate on the RENDERED page - the two gates pull opposite
   directions and both are blocking.
3. **Voice guide §3 now carries the humanizer cross-check additions**
   (2026-08-17 subsection): ~18 extra AI-vocabulary words, false ranges,
   -ing tails, synonym cycling, vague authority, generic positive
   conclusions, chatbot artifacts, straight-quotes rule. Sweep rewrites
   against the MERGED list, not just the original §3.
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
   165 / 0; course 60+ URLs ~800 / 2 - all at good positions (5-13). Answers
   20.09 §8's October re-check early: zero.
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

## 2026-08-20 - Same-day-cluster voice tells (4-post AI+Rails batch)

Shipping four posts in one day exposed a review gap: per-post critics pass a
post while the BATCH carries fingerprints - a shared intensifier ("genuinely"
in all four), a shared metaphor family ("X earns Y" 5x), verbatim phrase reuse
between siblings, meta-narration templates, and cloned CTA tails. Added the
cross-batch sweep to `content/voice-rules.md`. Also: critic-tech caught that
ruby_llm 1.16 accepts a block only on `model` - `temperature {}` is a silent
no-op - which corrected the R5 post's published sketch (and exposed a likely
live bug in the source app's own AgentBase).

## 2026-08-20 - First LinkedIn metrics read: reach without replies

Filled the first three `metrics-ledger.md` rows from LinkedIn's own
post-analytics pages: 680 impressions, 1 reaction, 0 genuine comments,
**0 `icp_replies`** (the one comment is Paul's own first-comment link).
Account reach is climbing (+18% w/w), so reach is the less likely cause of
the silence. Not a kill signal - 3 of the required 10 rows per lane, and
impressions are an order of magnitude below the 3,000 attribution floor.

Three durable findings, recorded in `workflows/linkedin-post-pipeline.md`:
(1) `status: scheduled` never gets flipped on publish and no draft carried
a `posted_url` - the activity id can't be derived from a slug, so a missing
one costs a manual feed scroll later; (2) `icp_profile_views` is unreadable
on a lapsed-Premium account, so it records `n/a`, not `0`; (3) the rescue
lane can't satisfy the arrival override at all - reply-CTA only, no link,
no UTM, no session. Also fixed `layouts/linkedin/list.html`, where three
sequential `with` blocks made the LEAST advanced date win, labelling posted
cards "scheduled".
