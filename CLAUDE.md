# Claude Code Configuration — JetThoughts Blog

**Type**: Hugo static site blog | **Build**: `bin/hugo-build` | **Test**: `bin/rake test` / `bin/rake test:critical`
**CSS**: PostCSS pipeline | **Content**: `content/blog/` (Markdown + Hugo frontmatter)

---

## 📌 Critical Files — READ BEFORE CHANGES

Always read these files before making changes. They define the project's architecture and constraints.

| File | When to Read |
|------|-------------|
| `@config/_default/hugo.toml` | ANY Hugo/site config change |
| `@themes/beaver/layouts/blog/list.html` | Blog index/listing changes |
| `@themes/beaver/layouts/partials/blog/img-cropped.html` | Blog thumbnail/cover image changes |
| `@themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` | SEO/og:image/meta tag changes |
| `@themes/beaver/layouts/partials/page/cover_image.html` | Blog post cover rendering |
| `@.stitch/design.md` | Cover image generation |
| `@docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` | ANY content, blog post, design, landing page, or marketing work |
| `@docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` | Writing ANY blog post or marketing copy — voice, tone, banned words, anti-AI structural patterns |
| `@docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` | Writing tech/Rails posts — thoughtbot content patterns, code example standards |
| `@docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md` | Writing the next blog post or planning content |
| `@docs/workflows/linkedin-post-pipeline.md` | Writing ANY LinkedIn post for Paul Keen / JT — voice rules, anti-AI patterns, AI score rubric, frontmatter |
| `@docs/workflows/linkedin-icp-validation-plan.md` | Writing LinkedIn posts under the ICP-E validation campaign |
| `@bin/hugo-build` | Build/deploy workflow |
| `@Rakefile` | Test workflow |
| `@test/test_helper.rb` | Writing new tests |
| `@docs/projects/2509-css-migration/2026-07-12-css-maintainability-redesign.md` | ANY CSS changes — the approved plan + evidence rule (compiled+gzip, never raw line counts) |
| `@docs/projects/2509-css-migration/css-bundle-ownership-map.md` | ANY CSS changes — which pages a CSS file affects + FL burn-down |

---

## 🔍 Research Protocol (MANDATORY)

**Session start**: Always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`.

Prefer **skills** over agents. Use agents only when the user or the selected workflow explicitly requires them.

Always use claude-context MCP search **before** making changes:

1. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"`
2. `Search the codebase at /Users/pftg/dev/jetthoughts.github.io/knowledge for: "[topic]"`
3. `Get library docs for "[framework]"`

**Option 2 — DeepWiki** (when claude-context doesn't have enough context or for repo-level questions):
- `ask_question` about `jetthoughts/jetthoughts.github.io` for AI-powered answers about the repo
- `read_wiki_structure` / `read_wiki_contents` for browsing repo documentation

**After:** use `rg`/`ls` for exact filenames, slugs, and fallback searches. For code/content patterns, use claude-context MCP semantic search first, then DeepWiki as fallback.

### Finding blog posts to reference (MANDATORY for content work)
When writing a blog post and looking for internal links, **always use claude-context first**:
```
Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "transparency weekly reports"
```
For exact slug/tag lookups, see the post index at `docs/blog-post-index.md` (584 posts, 135 tags, process posts table).
**Never guess slugs** — verify with `ls content/blog/<slug>/index.md` before linking.

## 🧪 TDD & Testing

Follow official methodology from `/knowledge/`:
- **TDD**: RED → GREEN → REFACTOR cycle. See `/knowledge/20.01-tdd-methodology-reference.md` and `/knowledge/20.11-tdd-agent-delegation-how-to.md`
- **Test Quality**: Behavior-focused ONLY. Reject implementation/existence/config tests. See `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md`
- **Avoid fragile config assertions**: Don't hardcode tunable values (`q=90`, `w=360`, exact file sizes, specific dimensions, CSS property values). Assert the *shape* (`q=\d+`, has `<picture>`, src contains `wsrv.nl`), not the configuration. If a test breaks when you change a quality/size knob unrelated to behavior, the test is testing config, not behavior — relax the assertion.
- **Framework**: Minitest (`test/system/`, `test/unit/`). NEVER create ad hoc `*.sh` test scripts
- **Test Runner**: `bin/rake test:critical` after every micro-change (< 10 lines)

### Visual Regression (MANDATORY for CSS/HTML changes)
- **Tolerance**: 0.0 for refactoring (zero visual changes), ≤0.03 for new features only
- **Protocol**: Capture baseline screenshots BEFORE changes → compare AFTER → block commit on any difference > 0% during refactoring
- **Reference**: `docs/visual_testing_delegation_workflows.md`

### Chrome DevTools Validation (MANDATORY after HTML/CSS/JS changes)
1. Start Hugo dev server, open page in Chrome DevTools
2. Check Console — zero JS errors (ZERO tolerance)
3. Check Network tab — zero 404s for assets (ZERO tolerance)
4. Capture desktop + mobile screenshots, verify Core Web Vitals
5. All gates pass → commit. Any gate fails → investigate, fix, repeat

---

## 📁 Workflow Pointers

- CSS consolidation rules: `docs/workflows/css-consolidation.md`
- Blog pipeline: `docs/workflows/blog-pipeline.md`
- LinkedIn pipeline: `docs/workflows/linkedin-post-pipeline.md` (Paul Keen voice rules, AI score rubric, save-location convention)
- LinkedIn campaign: `docs/workflows/linkedin-icp-validation-plan.md`
- Cover images: `docs/workflows/cover-images.md` (canonical spec remains `.stitch/design.md`)
- Visual scroll gate (rendered-output QA): `docs/workflows/visual-scroll-gate.md`
- **Content plan (active)**: `docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md`
- Commands & hooks overview: `docs/workflows/commands.md`
- Agent strategy: `docs/workflows/agents.md`

---

## 🚨 Behavioral Constraints

- **Zero generic AI language**: All AI-sounding phrases flagged and rejected
- **Zero unsupported claims**: All assertions must have citations
- **Zero Hugo build breaks**: All content validated via `bin/hugo-build`
- **Zero ad hoc test scripts**: Use repo-provided test commands: `bin/rake test:critical`, plus `bin/test` and `bin/dtest` for visual changes
- **No Python scripts for analysis**: Prefer `rg`, `sed`, `awk`, and shell tools
- **Zero tolerance for duplicates**: No `*_refactored.*`, `*_new.*`, `*_backup.*` files
- **New docs allowed only under** `docs/workflows/` (else edit existing files)
- **Reflection triggers**: User reports "code is bad" / "over-engineered" → HALT, 5-Why analysis, fix config, THEN proceed
- **Mandatory self-critique on voice-sensitive content (BLOCKING)**: For any draft or revision of LinkedIn posts, blog posts, or marketing copy, invoke `reflexion-reflect` (Standard Path) BEFORE first handback. After user pushback on the same draft, escalate to `reflexion-critique` (multi-judge debate) per the LinkedIn pipeline §3 / blog pipeline equivalent. Solo iteration past first delivery consistently misses pattern-level tells (over-narration, cinematic beat-marking, shape-coded copywriting) — observed on the 2026-05-11 Monday Jira-not-progress post (5 user corrections after the AI rubric scored 0/10).
- **Visual regression test gate (BLOCKING for HTML/CSS/template changes)**: After ANY edit to `themes/`, `layouts/`, `content/blog/*/index.md` body HTML, or `*.css`, run BOTH `bin/test` (macOS host) AND `bin/dtest` (Linux/Docker) BEFORE committing. They write to separate baseline dirs (`test/fixtures/screenshots/macos/` vs `linux/`) and CI runs Linux — skipping `bin/dtest` ships a green PR locally that breaks the build. The 35-failure incident on 2026-04-30 happened because Sprints #2/#3 shipped 15 commits without running it once — and the failing tests caught a real `.fl-button` regression Sprint #3 missed. Visual regression failures are NOT optional warnings; they are commit blockers. Either fix the regression OR confirm the change is intentional AND update baselines (both macos/ AND linux/) in the same commit. "I'll run tests after a few commits" is the path that lets unfixed bugs ship.
- **Feature-branch + ONE bundled PR per sprint (BLOCKING for HTML/CSS/template changes)**: Don't push HTML/CSS/template/layout changes directly to `master`. The pattern is: (1) `git checkout -b <sprint-name>`, (2) ship multiple related commits on the branch (one per fix is fine — easy to revert/cherry-pick), (3) run BOTH test gates green on each commit, (4) `git push -u origin <branch>`, (5) open ONE PR via `gh pr create` covering the full sprint with summary + per-commit description + visual evidence. **Bundle related work into one PR — don't split into many small PRs.** User flagged 2026-04-30: "let's have one big PR instead of small PR." A 5-commit sprint = 1 PR, not 5. Direct-to-master is only acceptable for content-only blog edits (markdown body without template changes), commit-message-only fixes, docs under `docs/`, and `CLAUDE.md` policy updates.
- **Never commit coordinator/agent report files**: User flagged 2026-04-30: "do not commit report files like docs/projects/2604-typography-ux/sprint-7-coordinator-report.md." Sprint coordinators and verification agents often write a `*-coordinator-report.md` or `*-verification-report.md` summarizing what they shipped. These are working notes, not project documentation — keep them OUT of the repo. Write to `/tmp/` instead, OR write to `docs/` but `git restore --staged <report>.md` before committing the rest of the work. The findings/audit reports under `docs/projects/2604-typography-ux/findings-*.md` ARE legitimate project artifacts (cross-page consistency audit, mobile UX audit, etc.) — those stay. Coordinator reports about WHICH commits ran on WHICH date are session-internal and should not pollute the repo.
- **Surgical edit discipline (BLOCKING for content edits)**: When the user flags ONE attribute (a price, a tool name, a year-stamp, a label, a callout), change ONLY the sentences containing that attribute. Do NOT rewrite, re-balance, or re-theme the surrounding page — name the page's thesis in one line first and confirm it is unchanged. If a fix seems to need touching >1 paragraph or the structure, STOP and ask before expanding scope. When correcting a stance the user called too far one way (e.g. "too free"), land at the documented middle — do NOT swing to the opposite extreme (the budget free→paid→balanced pendulum cost 4 round-trips on 2026-05-22). Before handback, grep your OWN replacement text for the exact pattern you just removed (year-stamp, banned word, hardcoded tool name, alias) — re-introducing the defect you are fixing is a blocking failure. On renames/cleanups default to LESS: remove old references and update them, never add alias/redirect bridges (zero tech debt); question inherited elements (routing blocks, disclaimers) proactively rather than preserving them until the user points. Scope critic/cold-eyes findings to a punch-list of surgical fixes, NOT license to rewrite the page.
- **ICP-reader read-back (BLOCKING for course/content edits)**: Before handback, re-read the edited chapter top-to-bottom AS the course ICP — "Sam," the idea-stage non-technical first-timer, NOT the website lead-gen ICP "Alex the burned founder" (rescue/trauma framing is off-ICP for course bodies). Confirm: (1) every acronym/tool/term is glossed at FIRST mention (what it is, in plain words); (2) progressive disclosure — orientation blocks orient, they do NOT front-load thresholds/metrics/mechanics (those belong where the reader acts on them); (3) value-first tone, not sales; (4) visual rhythm — no two adjacent same-form callouts. See memory `feedback_minimal_edit_scope_no_page_bombing` and `feedback_icp_reader_readback_progressive_disclosure`.
- **Write for Sam, not for Paul (BLOCKING for course content edits)**: When Paul corrects a phrase in fast operator-shorthand ("ICP", "apparatus", "resonate", "confirm demand"), DO NOT echo that wording into the lesson body. Translate to Sam-voice — plain English, observable behavior. Take initiative on wording — fix the underlying intent in Sam-voice, don't paste Paul-voice into the lesson. **When Paul flags the same line 2+ times across attempts, STOP iterating on phrasing — diagnose value-to-Sam.** Convergence check: "Could Sam read this and immediately tell a friend what's valuable to him?" If no, re-diagnose the value; do not re-phrase. The 1.2a Output line cost 6 iterations on 2026-06-11 because each pass optimized for surface (Paul's words / pattern consistency / simple phrasing / explicit grammar) instead of Sam-value. **Patterns that work for one lesson may not fit another** — 1.1 tests sentence resonance with target audience (fit); 1.2a tests page comprehension by any stranger (clarity); cloning 1.1's binary into 1.2a conflated two different test types. Drop the pattern when it doesn't fit. See `feedback_iterate_value_not_phrasing` memory + `feedback_write_for_sam_not_paul` if it exists.
- **"Pilot" in 2605 course work = INTERNAL editorial template review, NOT external customer recruitment**: In any 2605 session, "pilot lessons" / "5-Sam validation pilot" / "validate the template" defaults to Paul-as-reviewer of the v2 micro-lesson template (currently 1.2a + 1.2b). External recruitment / Clarity install / outreach scripts are deferred to post-course-completion (kit lives at `docs/projects/2605-tech-for-non-technical-founders/40-49-review/_DEFERRED_external-validation-pilot-kit.md`). Confirmation signals for INTERNAL: 30.03 spec exists, 40.11 Sam simulation already done, "review them", "approve", "fan out template". Confirmation signals for EXTERNAL (rare, post-launch only): "recruit", "real founders", "Clarity recordings", "promote", "sell the course". Cost a 372-line external-customer-research kit side-quest on 2026-06-11 when I anchored on TASK-TRACKER's literal "recruit 3-5 real founders" without questioning the implicit reviewer.

### ✍️ Blog Post Pipeline (MANDATORY)

When asked to write, draft, schedule, or publish a blog post, execute `docs/workflows/blog-pipeline.md` end-to-end as the canonical workflow. Do not stop after the draft step. If any step fails, fix and retry before moving to the next step.

For drafts (`draft: true`), still run the full pipeline so the post is publish-ready when someone flips it to `false`.

Repo voice guides and workflow docs override generic writing, SEO, or humanizer skill advice when they conflict.

**Pre-writing reads (MANDATORY):**
1. `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` — voice, banned words, anti-AI structural patterns
2. `docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` — thoughtbot patterns
3. `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` — ICP-E profile

**Zero tolerance AI patterns** — reject on sight:
- Rule of three, signposting, bold inline-header lists, negative parallelism
- Triple rhetorical questions, slogany closings, therapist voice, copula avoidance
- Impersonal fragment stacking ("No tests. Open endpoints. Corrupted data.")
- Noun stacking without human subject ("React + Rails, clean conventions, the demo sailed")
- Sustained staccato (3+ consecutive short fragments = fake burstiness)
- Command structure repetition (3+ paragraphs starting with imperatives)
- Telling instead of showing ("the error handling was bad" → describe the specific failure mechanic)
- Apologetic caveats ("every project is different", "it depends on the use case")
- Fluffy AI narration (dramatic present-tense "The alerts fire correctly. Then someone upgrades..." - use specific past-tense practitioner stories instead)
- Fake authority generalization ("We've seen this on every codebase" - use specific count: "The last three codebases we inherited...")
- Timeline fabrication ("last year" without checking if the technology existed then)
- Use `-` not `—` for all dashes in content
- **The "who" test:** every sentence needs a person doing something
- **The "show" test:** replace adjectives with concrete scenarios the reader can picture
- **The "practitioner" test:** replace generalized scenarios with specific incidents (name the client, version, timeline, exact failure)
- **The 90/10 rule:** ≥90% education, ≤10% promotion. Reader learns something useful even if they never contact us
- **Trade-offs:** always acknowledge what the proposed solution fails to do or what it costs
- See voice guide section "Banned structural patterns" for full list + fixes

**Cross-post repetition gates (BLOCKING for cluster posts):**
- Before finalizing any post in a topic cluster, run two scans:
  1. **Anecdote scan** — search the cluster for any specific story this draft uses (named client, dollar amount, technical mechanic, exact incident). If the same story already anchors a sibling post, pick a different one. Caught 2026-05-09: the URL-ID/BOLA story appeared in both `vibe-coding-crisis-ai-code-debt` opener AND `47-startups-failed-same-coding-mistake` body. Caught 2026-05-10: the $40K + React+Rails dollar-anchor was repeated across the same cluster.
  2. **Proof-signal scan** — verify the post's primary diagnostic signal (staging URL / test coverage / commit size / secrets storage / rollback drill / user-impact verification / contract clauses) isn't already the LEAD signal in another sibling. Distribute distinct signals across posts so each post owns one anchor. Caught 2026-05-10: scipab Path B initially used "staging URL" for the Situation question, exactly the LinkedIn Mon/Tue lead signal. Fixed to "Which users touched what shipped this week?" — user-impact verification, unused elsewhere in the cluster.
- See `~/.claude/projects/-Users-pftg-dev-jetthoughts-github-io/memory/feedback_cross_post_signal_repetition.md` for the signal portfolio map. See `feedback_hook_bank_diversity.md` for opening-shape rotation (separate concern).

**Slop detector + shape-tell critic both required:**
- Sentence-level slop ≤25/100 is necessary but not sufficient. User has flagged "still feels AI" three times in 2026-05-09 / 2026-05-10 / 2026-05-28 sessions when slop detector passed.
- After slop passes, spawn a shape-tell critic with this explicit pattern list: essay arc (hook → pivot → thesis → evidence → caveat → close), dual-source statistical opener, pivot sentences ("That's the experience of...", "Here's what's underneath...", "The bigger problem is..."), listicle scaffolding cloned 3+ times (Strong/Weak/Tips, 5-item lists repeated), "The..." paragraph-opener density >20%, slogany flips ("X works. Y doesn't.", "It looks Y. It isn't Z.", "The framework is a diagnostic, not a cure."), definitional cadence ("X is hypothesis-validation tooling."), "You're not throwing away X" reassurance tic.
- **2026-05-28 additions (caught by 4-persona M1-M3 audit):** slogany reveal-twist flip ("X hadn't been Y - Z had been", "It's not about X. It's about Y.", "X wasn't Y - it was Z"); cost-stacked tri-list opener ("$X-$Y in A, N B, one of M C" - reads as workshop slide); cute aphoristic flourish closer ("polite noise", "the kind smile that costs you a year", "the helpful answer is the trap", "Everything else is your mom being nice"); anonymous-named-founder opener template repeated 3+ chapters in a row (Module 2 had Priya/Maya/ed-tech-founder/consumer-app-founder back-to-back); cinematic time-cut narration ("Nine months later: a product, a $62K dev invoice, zero paying customers"); fabricated cohort stats with no source ("4 of 5 real interviewees", "3-5× the rate", "30-45% reply rates").
- **Opener-shape rotation gate (NEW):** when reviewing a multi-chapter sprint (3+ chapters in the same module), explicitly count the opener shape of each chapter. No 3+ consecutive chapters may share the same opener template (anonymous-founder vignette, year-stamp cohort, named-research-result, etc.). The 2026-05-28 Module 2 audit found 4 consecutive chapters opening with "A [adjective] founder we [verb]" - a regression nobody caught because single-chapter review can't see template repetition.
- **Banned-pattern regression sweep (NEW):** every revision pass must run `grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with"` across edited chapters before handback. Patterns previously removed regress under time pressure - the 2026-05-28 audit found Case 25 banned heading restored in 3 of 9 chapters.
- See `feedback_slop_detector_misses_shape_tells.md` and `feedback_voice_regression_m1_m3_2026_05_28.md` for the full pattern list. Run alongside the slop detector, not after.

**dev.to import ICP gate:**
- Posts synced from dev.to (`source: dev_to` in frontmatter) are auto-imported without an ICP filter. Before any dev.to-imported post is shipped or referenced, audit it against the JT ICP-E voice guide. If 80+/100 AI-feel or off-thesis (generic management/productivity content with no JT-rescue angle), either rewrite for the ICP or flip to `draft: true`. Caught 2026-05-10: scipab post (Dec 2024 dev.to import) was 92/100 AI-feel, orphan content. Rewrote as "SCIPAB for non-technical founders to interrogate their dev shop."

**Markdown code fence: use `html` not `erb`:**
- Hugo's Chroma syntax highlighter doesn't recognize `erb` as a lexer alias. Fences using ```erb render as plain `<pre><code>` without the Dracula wrapper — the theme's light foreground (`#f8f8f2`) on missing-background renders as invisible text. The `html` fence highlights HTML tags correctly while ERB `<%= %>` renders as plain text inside the dark block. 10 posts hit this bug before the 2026-05-10 fix; verified by HTML diff comparing the wrapper `<div class="highlight"><pre style="...">` (present for `html`/`ruby`) vs missing for `erb`.

**Visual verification gate (BLOCKING for any new media element):**
- After adding ANY new visual (Mermaid diagram, SVG infographic, image, table, chart, callout block, hero image), MUST verify via chrome-devtools MCP before declaring done. The "Screenshot taken" gate is necessary but not sufficient.
- Take screenshots at BOTH desktop (1280×800) and mobile (390×844) viewports. The first-fold experience is what determines whether the visual wins the 3-second hook.
- Score honestly from a user perspective against these 4 criteria — and write the scores in the commit message OR the user-facing report:
  1. **Is it a great look?** — visual harmony, font legibility, color contrast, alignment, fits the brand
  2. **Is it functional?** — info is readable without effort, doesn't require zooming, mobile renders, no overflow
  3. **Would it make a person want to read more?** — earns the next scroll OR pushes the reader away with visual fatigue
  4. **Is it helpful overall?** — orients vs overwhelms; teaches vs decorates; saves parse time vs costs it
- Any "NO" or "MIXED" on criteria 3 or 4 = ROLLBACK or REDESIGN before commit. Don't ship visuals that fail user-perspective scoring just because they're technically rendering.
- Verify the visual's POSITION on first-fold: at the typical laptop viewport (1280×800), does the new visual appear ABOVE the fold? If it doesn't, it cannot win the 3-second hook — relocate or accept it as a mid-page visual break (different acceptance criteria).
- For Mermaid diagrams specifically: measure rendered height. If > 2× viewport height, the diagram is too tall — reader perceives it as a wall, not a hook. Caught 2026-05-19: my Hero Roadmap rendered at 1551px on mobile (2× viewport) and the cursive font's dash-strikethrough effect on phase labels degraded legibility further.
- **Visual SCROLL gate (BLOCKING for any new/edited content page, not just new media)**: walk the FULL page section-by-section in chrome-devtools at 1280×800 AND 390×844, screenshot each scroll view, and actually inspect each screenshot before handback. Canonical protocol + per-view defect checklist + numeric probes: `docs/workflows/visual-scroll-gate.md`. Text validators cannot see rendered output — the 2026-07-10 Module 3 pass caught mermaid node clipping, SVG text crossing artwork borders, a stale cover badge on a freshly wired og:image, a wrong-direction "diagram above" reference, and a renumber leftover INSIDE an SVG, all invisible to the banned-string ratchet. One screenshot of the hero is NOT this gate.

**Cognitive load + F-pattern rules (mandatory for long-form posts > 800 words):**
- Research-grounded rules from `docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.05-content-organization-patterns-2026.md` Part 2 (Gloria Mark / Pew 2026 / NN/g F-pattern / Sweller CLT). Pew 2026: 71% of readers scroll past within 3 seconds without a visual hook; Gloria Mark 2026: per-screen attention = 43s.
- **First 3 seconds visual hook (hero rule):** every long-form post needs a visual within the first viewport - hero diagram, infographic, hero illustration, or a strong styled callout. Pure-text hero = guaranteed dropout for 71% of readers per Pew 2026. Decorative photography does NOT count.
- **Repetitive parallel sections must NOT be 6+ identical bullets or 6+ identical table rows.** Module indexes, template lists, mistake lists, decision lists — break into a card grid OR add per-item icons. Single-column tables with 6+ rows and identical-format bullet lists with 6+ items both trigger the F-pattern "give up + vertical scan only" failure mode (NN/g eye-tracking).
- **Decision-oriented sections use decision-aid format.** Anywhere the post asks "if X then Y" (rescue triage, decision trees, scoring tables, "should you...") render as flowchart/decision-table, not as a numbered list. Founder readers are in high cognitive load already; a flowchart cuts parse time vs. prose.
- **Labels INSIDE diagrams, not beside them** (Sweller's split-attention effect). A labeled flowchart works. A flowchart followed by a 200-word "what this shows" paragraph increases cognitive load. If the diagram needs a separate explanation paragraph, fix the diagram - integrate the labels.
- **No decorative visuals.** Stock photography of "happy founders at laptops," abstract gradients, generic icon arrays without informational content all violate the CLT integration rule. If removing the visual wouldn't lose information, the visual is decorative - delete it.
- **One visual break per H2.** Plain prose blocks ≥3 H2s in a row = density problem; readers drop off. Acceptable visual breaks: diagram, table, code block, pull-quote callout, icon row. Mermaid diagrams count; bold paragraph leaders do NOT.
- **Hand-drawn / Excalidraw-style sketches**: allowed when the sketch IS the diagram (informational); rejected when the sketch is decorative ornament beside a separate diagram. Per voice guide, prefer Mermaid + sketchy SVG over polished corporate infographics for the JT brand.

---

## 📋 Quick Reference

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build + validate site |
| `bin/rake test:critical` | Run critical tests |
| `Search the codebase at /knowledge/ for: "[topic]"` | Global standards |
| `Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "[pattern]"` | Local patterns |

**Coverage**: Full codebase indexed (830+ files, 4,184+ semantic chunks)
**Design System**: JetVelocity — obsidian dark, Ruby red (#cc342d), neon purple (#a855f7). See `.stitch/design.md`
**ICP**: Non-technical founder burned by a devshop. See `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`

## Tooling Preference
- Use `bun` for JS dependency installs and scripts; do not use `npm`.
