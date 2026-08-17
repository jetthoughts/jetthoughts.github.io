# Claude Code Configuration — JetThoughts Blog

**Coding posture**: activate `/ponytail:ponytail ultra` at session start and hold it — radical KISS/YAGNI, deletion over addition, shortest working diff, naive over clever. Applies to every code/config change in this repo.

> **Head lives in the vault:** [[jt-business-os]] / [[jt-vibe-code-rescue]] — `~/Documents/pkm`
>
> **Identity, positioning, and bet status** are owned in the vault — **not** in `docs/business/`.
> The **weekly loop stays in this repo**: `docs/business/operating-system.md` (goal, OKR §3, rocks §4, weekly numbers §1) is edited here, beside the pipeline tooling that feeds it (narrow split, settled 2026-08-17).
> Do not create a parallel opportunity portfolio here. Working papers under `docs/projects/` stay put.
>
> Read the vault note before changing positioning or bet status. Verified by `bin/check-repo-links` in the vault.
>
> **Company FACTS are NOT vault-owned.** Founding date, tenure, ratings, review counts, retention — every claim in `@.okf/content/claims-canon.md` — stay canon in THIS repo, enforced by `test/unit/marketing_copy_test.rb`. Never copy a company number out of a vault note into published copy. On 2026-08-17 `jt-business-os.md` was found carrying "since 2011" and "4.8/5 from 32 clients" - both BANNED strings here (canon: founded 2008-09-01, no review count) - and was corrected the same day. Re-check the vault whenever you quote a company number from it. The vault decides what we're doing; the canon decides what we're allowed to say.


**Type**: Hugo static site blog | **Build**: `bin/hugo-build`
**Test**: `bin/qtest --changed` (per change — tests the pages your diff touches) / `bin/test --smoke` (fixed 17-test core net, ~50s / ~30s CI) / `bin/rake test:critical` (milestones) / `bin/test` + `bin/dtest` (PR prep). qtest and smoke are complementary, not redundant: qtest follows your diff, smoke is a constant basics check.
**CSS**: PostCSS pipeline | **Content**: `content/blog/` (Markdown + Hugo frontmatter)

---

## 📌 Critical Files — READ BEFORE CHANGES

Always read these files before making changes. They define the project's architecture and constraints.

| File | When to Read |
|------|-------------|
| `@config/_default/hugo.toml` | ANY Hugo/site config change |
| `@themes/beaver/layouts/blog/list.html` | Blog index/listing changes |
| `@themes/beaver/layouts/partials/blog/img-cropped.html` | Blog thumbnail/cover image changes |
| `@layouts/partials/seo/enhanced-meta-tags.html` | SEO/og:image/meta tag changes (root-level override, not the theme copy) |
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

## 📚 OKF Knowledge Bundle (`.okf/`)

Distilled operational knowledge lives in the OKF v0.1 bundle at `.okf/` (markdown + YAML frontmatter, one concept per file). **Consume it via progressive disclosure**: read `.okf/index.md` first, then follow links into only the concepts relevant to the task.

**Use the OKF skills, don't hand-roll the format**: run the `/okf:okf` skill for all bundle work — `consume` to pull context, `produce` to add concepts, `maintain` to sync the bundle after a change — and `/okf:validate .okf --strict` to check conformance. The skills carry the canonical spec (one concept per file, required `type` frontmatter, reserved `index.md`/`log.md`, dated log entries); follow them rather than editing by hand.

- `.okf/build/` — build pipeline, blocking test gates, template-PDF regeneration
- `.okf/content/` — course structure, canonical numbers, voice rules, banned-strings ratchet
- `.okf/design/` — mermaid/Caveat theme, house visual spec, cover pipeline, course typography
- `.okf/workflows/` — render-verification recipes, review-swarm pattern

**Maintain it as you work (ENFORCED, parallel by default)**: when you learn something durable (a new canon number, a root-cause fix, a workflow gotcha), update the affected concept file and its `timestamp`, refresh the section `index.md`, and append a dated entry to `.okf/log.md`. **Do NOT defer this to session end**: dispatch a background okf-maintainer agent (`/okf:okf maintain` scope) IN PARALLEL with the main work as soon as a durable learning lands, so bundle sync rides the same commit as the change it describes. Sessions that can't parallelize (tiny fixes) run maintain inline before the final commit. Fallback safety net: a scheduled weekly maintain pass (cron/`/loop`) that diffs recent commits against `.okf/log.md` and back-fills anything missed. Validate with `/okf:validate .okf --strict` before committing bundle changes. A session that shipped durable knowledge without an OKF entry is NOT done — same rule as async-first communication.

---

## 🔍 Research Protocol (MANDATORY)

**Session start (onboarding)**: Always read `@docs/workflows/BASE_HANDBOOK.md` and `@docs/workflows/flow-router.md`, and run **`/okf:okf`** (consume scope) to onboard from the `.okf/` bundle — it loads `index.md` and follows links into only the concepts the task needs. Don't hand-read the bundle when the skill does it correctly.

**Before every commit**: run **`/okf:okf maintain`** to sync the bundle with what the commit changed (concept file + its `timestamp`, section `index.md`, dated `.okf/log.md` entry) so bundle sync rides the same commit. A commit that shipped durable knowledge without an OKF update is NOT done.

Prefer **skills** over agents. Use agents only when the user or the selected workflow explicitly requires them.

**Markdown search (docs/, content/, .okf/) — use `qmd` FIRST** (Paul 2026-08-01; `knowledge/` dropped from the target list 2026-08-08 — it's a host-only symlink that dangles in container sessions). The repo is indexed as qmd collection `jt-site` (run `qmd embed` after big doc batches to refresh vectors):

1. Known words/titles/slugs → BM25: `qmd search "skip_area selector wait" -c jt-site -n 5`
2. Conceptual/indirect recall → structured query (write the fields yourself): `qmd query $'intent: ...\nlex: exact anchor words\nvec: paraphrase concepts\nhyde: a plausible answer paragraph' -c jt-site`
3. Then fetch full sources with `qmd get <path>` / `qmd multi-get "#id1,#id2"` — never answer from snippets alone.

**For CODE (templates/CSS/Ruby)**: claude-context MCP (`Search the codebase at <repo root> for: "[pattern]"` — repo root via `git rev-parse --show-toplevel`, never a hardcoded machine path) or grepai/tokensave per the global search-tool table; DeepWiki (`ask_question` on `jetthoughts/jetthoughts.github.io`) for repo-level questions. **After:** `rg`/`ls` for exact filenames and fallbacks.

### Finding blog posts to reference (MANDATORY for content work)
When writing a blog post and looking for internal links, search with **qmd first**:
```
qmd search "transparency weekly reports" -c jt-site -n 5
```
For exact slug/tag lookups, see the post index at `docs/blog-post-index.md` (regenerate with `bin/generate-blog-index` after adding/removing posts — never trust its count if the date stamp is old).
**Never guess slugs** — verify with `ls content/blog/<slug>/index.md` before linking.

## 🧪 TDD & Testing

- **TDD**: RED → GREEN → REFACTOR cycle. In-repo doctrine: `docs/20-29-testing-qa/` (anti-masking + false-green references) and `docs/incidents/25.0x` postmortems. (*Host-only*: the `/knowledge/` methodology bundle is a symlink that resolves only on Paul's machine — never depend on it in a container/CI session.)
- **Test Quality**: Behavior-focused ONLY. Reject implementation/existence/config tests.
- **Avoid fragile config assertions**: Don't hardcode tunable values (`q=90`, `w=360`, exact file sizes, specific dimensions, CSS property values). Assert the *shape* (`q=\d+`, has `<picture>`, src contains `wsrv.nl`), not the configuration. If a test breaks when you change a quality/size knob unrelated to behavior, the test is testing config, not behavior — relax the assertion.
- **Framework**: Minitest (`test/system/`, `test/unit/`). NEVER create ad hoc `*.sh` test scripts
- **Test Runner**: see the header **Test** line — that is the single statement of the qtest/smoke/critical/full-pair matrix; don't restate it.

### Visual Regression (MANDATORY for CSS/HTML changes)
- **Tolerance**: 0.0 for refactoring (zero visual changes), ≤0.03 for new features only
- **Protocol**: Capture baseline screenshots BEFORE changes → compare AFTER → block commit on any difference > 0% during refactoring
- **Reference**: `docs/20-29-testing-qa/screenshot-testing/20.02-screenshot-testing-workflow-tutorial.md`

### Chrome DevTools Validation (MANDATORY after HTML/CSS/JS changes)
1. Start Hugo dev server, open page in Chrome DevTools
2. Check Console — zero JS errors (ZERO tolerance)
3. Check Network tab — zero 404s for assets (ZERO tolerance)
4. Capture desktop + mobile screenshots, verify Core Web Vitals
5. All gates pass → commit. Any gate fails → investigate, fix, repeat

---

## 📁 Workflow Pointers

- **New page (paved path)**: `docs/workflows/new-page.md` - starter template, component reuse, slice recipe, traps
- CSS consolidation rules: `docs/workflows/css-consolidation.md`
- Blog pipeline: `docs/workflows/blog-pipeline.md`
- LinkedIn pipeline: `docs/workflows/linkedin-post-pipeline.md` (Paul Keen voice rules, AI score rubric, save-location convention). **Reviewing LI posts: run `bin/dev` and give Paul the board link http://localhost:1313/linkedin/ (dev-only mount)** — per-post: `/linkedin/<lane>/<slug>/`; details in `linkedin-posts/README.md` §Review board
- LinkedIn campaign: `docs/workflows/linkedin-icp-validation-plan.md`
- Cover images: `docs/workflows/cover-images.md` (canonical spec remains `.stitch/design.md`)
- Visual scroll gate (rendered-output QA): `docs/workflows/visual-scroll-gate.md`
- **Content plan (active)**: `docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md` (20.07 is superseded — kept for its topic briefs only)
- Agent strategy: `docs/workflows/agents.md`

---

## 🚨 Behavioral Constraints

- **Async-first communication (MANDATORY, all agents)**: written, discoverable artifacts are the default for every decision, finding, status change, and handoff — see `.agents/skills/async-first-communication/SKILL.md` for the canonical-surfaces table (docs/projects, runbook handoff notes, backlog State snapshot, pipeline ledgers, `.okf/` + log, PR disposition comments). Sync (calls, live approvals — Paul's desk) is the exception; its outcome is written back same-day. A task is not done until its state is readable by a cold session with zero questions. `AGENTS.md` carries the same SOP for non-Claude agents.
- **Zero generic AI language**: All AI-sounding phrases flagged and rejected
- **Zero unsupported claims**: All assertions must have citations
- **Company facts have a canon — check it before publishing a number**: `.okf/content/claims-canon.md` (founding **2008-09-01**, derive tenure from `site.Params.foundingYear`, "4.8/5 on Clutch" with the profile linked and **no** review count, founder experience 22+ vs company 18+). On 2026-08-14, **4 of 8 published figures were wrong** — `reviewCount 32` (real: 9), `foundingYear 2011` (real: 2008), a hardcoded `13+`, a `15+`. A number with no in-repo source is a defect, not a detail. Correcting one means sweeping the **instruction layer** too (`PRODUCT.md`, `docs/business/`, the 2607/2605 outreach kits all carried the wrong canon and would have re-introduced it).
- **Text ratchets must read RENDERED output, not source**: `marketing_copy_test` globs `themes/`+`content/` and missed all three late defects of 2026-08-14 — a false figure in an unglobbed partial, a banned phrase wrapped across two template lines, and a nested `<main>` that only exists after compose. Queued as `docs/20-29-testing-qa/20.10` §3b P0-4. Same principle CLAUDE.md already states for visuals: text validators can't see rendered output.
- **Zero Hugo build breaks**: All content validated via `bin/hugo-build`
- **Zero ad hoc test scripts**: Use repo-provided test commands: `bin/qtest --changed` (routine), `bin/rake test:critical` (milestones), `bin/test`/`bin/dtest` (PR prep only)
- **No Python scripts for analysis**: Prefer `rg`, `sed`, `awk`, and shell tools
- **Zero tolerance for duplicates**: No `*_refactored.*`, `*_new.*`, `*_backup.*` files
- **New-doc locations — pick the RIGHT home, `docs/workflows/` is NOT a catch-all** (Paul 2026-08-01: dev/tech docs kept getting dumped in workflows/). Decide in this order:
  1. **Engineering / tech reference** (test strategy, architecture, security, deployment, CI, APIs, AI-intelligence) → the **Johnny Decimal** area, one per domain: `docs/10-19-core-development/`, `docs/20-29-testing-qa/` (with `performance-testing/`, `screenshot-testing/` subdirs), `docs/30-39-architecture-design/`, `docs/40-49-security-compliance/`, `docs/50-59-deployment-operations/`, `docs/60-69-project-management/`, `docs/70-79-ai-intelligence/` & `70-79-templates-boilerplates/`, `docs/80-89-integration-apis/`, `docs/90-99-content-strategy/`. File naming: `NN.NN-descriptive-name-{reference|tutorial|how-to}.md`; check the area's `README.md`/existing numbers before picking one.
  2. **Company / OS** → the weekly loop (operating system: goal, OKR, rocks, numbers) is edited in `docs/business/operating-system.md`; vision/positioning and the opportunity portfolio are **vault-owned** (`jt-business-os`) and only mirrored into `docs/business/` - see the banner at the top of this file.
  3. **A project** validating one opportunity → its own `docs/projects/<YYMM-slug>/` (dated-slug: 2509/2510/2604/2605/2607).
  4. **ADRs** → `docs/adr/`; **incidents/postmortems** → `docs/incidents/`; **design tokens/system** → `docs/design-system/`.
  5. **`docs/workflows/`** is ONLY for **cross-cutting pipeline/process how-tos** that span domains (blog-pipeline, linkedin-pipeline, flow-router, commands, BASE_HANDBOOK) — NOT engineering reference, NOT research notes. If a doc belongs to one JD domain, it goes in that domain, not here.
  Everything else edits an existing file. Do NOT put the business/OS under `docs/workflows/` or collapse the company layer into a single project — the company OS runs ALL projects, one bet is "Validating" at a time (flagged 2026-07-22: the Vibe Code Rescue OS first landed in workflows/, then wrongly nested the whole business inside project 2607; the company layer now lives in `docs/business/` with 2607 as portfolio bet #1).
- **Manager triage of incoming requests (Paul 2026-08-01)**: Paul adds requests mid-flight at any time; the assistant is the MANAGER and must triage each against the active plan by critical level — not execute everything immediately in arrival order. Triage outcomes: (1) **now** — only if it's critical to the active gate or cheaper to fold into in-flight work than to defer (e.g. a directive changing an executing agent's target); (2) **this sprint, sequenced** — slot it at the right point in the current wave and say where; (3) **backlog** — write it to the owning board/backlog doc with enough diagnosis that a cold session can execute, and say when it's likely to run; (4) **groom first** — if big or ambiguous, run grooming/decomposition (persona panel or plan pass) before committing scope. ALWAYS report the triage verdict in one line ("doing now because X" / "queued to W4 because Y") so Paul can override. Deferring is a decision, not a failure; interrupting a gated pipeline for a non-critical request is the failure. **Autonomy grant (Paul 2026-08-01)**: the manager handles sprints end-to-end autonomously — for big/critical calls (merges of customer-facing redesigns, structural changes, scope pivots) run a small VOTING PANEL (2-4 distinct-lens agents) and MAKE THE CALL: unanimous → execute; split → execute the majority ONLY if reversible, else hold for Paul with the split documented. Every autonomous call is recorded (board/40.xx/PR) with its evidence so Paul can audit and reverse. Managing-up style: evidence and decisions, not questions; Paul's explicit words always override a panel.
- **Stale-view check before acting on page feedback (2026-08-17 retro)**: when feedback quotes text from a rendered page, FIRST grep the current source for the quoted text. If it's absent, the reviewer is on a stale tab or stale server - reply "already fixed, hard-refresh" with the link instead of re-editing; if the dev server is stale, restart it. Never fix a defect that no longer exists.
- **Always end page-change handbacks with local review links (Paul 2026-08-17)**: after ANY change to a rendered page (content, template, CSS), the handback message ends with the direct `http://localhost:<port>/<path>/` link(s) to every edited page (note hard-refresh if the page was open). Paul re-reviews in one click - never make him reconstruct the URL.
- **AI sessions use a session-random dev-server port (Paul 2026-08-17)**: never assume 1313 - that's the human default. Start your own server once per session with `PORT=$((20000 + RANDOM % 20000)) bin/dev`, remember the port, and use it in every review link. Never kill a server you didn't start (another session or Paul may own it); if your chosen port is taken, pick another.
- **Reflection triggers**: User reports "code is bad" / "over-engineered" → HALT, 5-Why analysis, fix config, THEN proceed
- **Mandatory self-critique on voice-sensitive content (BLOCKING)**: For any draft or revision of LinkedIn posts, blog posts, or marketing copy, invoke `reflexion-reflect` (Standard Path) BEFORE first handback. After user pushback on the same draft, escalate to `reflexion-critique` (multi-judge debate) per the LinkedIn pipeline §3 / blog pipeline equivalent. Solo iteration past first delivery consistently misses pattern-level tells (over-narration, cinematic beat-marking, shape-coded copywriting) — observed on the 2026-05-11 Monday Jira-not-progress post (5 user corrections after the AI rubric scored 0/10).
- **Content-only changes SKIP the visual suites (Paul 2026-07-31: "we can flex tests if we change only content and no html/css changes")**: a change that touches ONLY markdown prose/frontmatter — no `themes/`, no `layouts/`, no `*.css`, no inline HTML/SVG in the body — needs `bin/hugo-build` (validators + banned-string ratchet) and the rendered scroll gate on the edited pages. It does NOT need `bin/qtest`, `bin/test`, or `bin/dtest`; qtest correctly reports "no visual-affecting changes" for these. The moment a diff touches a template, a stylesheet, or body HTML/SVG, the gate below applies in full — check the actual diff, not the intent.
- **Visual regression test gate (BLOCKING for HTML/CSS/template changes)**: After ANY edit to `themes/`, `layouts/`, `content/blog/*/index.md` body HTML, or `*.css`, run `bin/qtest --changed` BEFORE committing (Paul 2026-07-31: qtest is the routine gate for simplicity). The FULL pair — `bin/test` (macOS host) AND `bin/dtest` (Linux/Docker) — runs ONCE at PR-preparation time (branch head, before `gh pr create`) or when Paul explicitly confirms; they write to separate baseline dirs (`test/fixtures/screenshots/macos/` vs `linux/`) and CI runs Linux, so a PR must never open without the dtest leg. The 35-failure incident on 2026-04-30 happened because Sprints #2/#3 shipped 15 commits without a visual gate at all — and the failing tests caught a real `.fl-button` regression Sprint #3 missed. Visual regression failures are NOT optional warnings; they are commit blockers. Either fix the regression OR confirm the change is intentional AND update baselines (both macos/ AND linux/) in the same commit. Baselines compare against **git HEAD, not the working tree** — an un-committed "accepted" PNG changes nothing, and an identical difference_level across runs means a stale committed baseline, not a flaky render. Confirm it in one command before theorising about flaky rendering: `md5 -q <baseline.png>` before and after a failing run — unchanged hash means you are looking at the HEAD-comparison behaviour, so **commit** the accepted baselines and re-run. Re-recording the Linux leg is fiddly by hand (`FORCE_SCREENSHOT_UPDATE=1 bin/dtest` rewrites ALL 45 baselines, so you must copy out only the ones your change moved, `git checkout -- test/fixtures/screenshots/linux`, then restore them) — done 3× manually on 2026-08-14; a `bin/record-baselines <path>...` wrapper is a live automation candidate.
- **Feature-branch + PR for ALL changes (BLOCKING - Paul 2026-08-17: "use PR for our changes, do not commit to master")**: Don't push directly to `master` - any change type, content-only edits and docs included. The pattern is: (1) `git checkout -b <sprint-name>`, (2) ship multiple related commits on the branch (one per fix is fine — easy to revert/cherry-pick), (3) run BOTH test gates green on each commit, (4) `git push -u origin <branch>`, (5) open ONE PR via `gh pr create` covering the full sprint with summary + per-commit description + visual evidence. **Bundle related work into one PR — don't split into many small PRs.** User flagged 2026-04-30: "let's have one big PR instead of small PR." A 5-commit sprint = 1 PR, not 5. **Sprint/wave work ALWAYS rides its sprint's PR (Paul 2026-08-01: "use PR for our current sprints")** — including the sprint's docs, board updates, and review artifacts, which ride the same branch as the code they describe. Direct-to-master is DISABLED even for non-sprint changes (content-only edits, standalone docs, `CLAUDE.md` policy updates): branch + PR, always. Content-only PRs still run only the content gates (hugo-build + rendered scroll gate), per the content-only rule above. **`gh pr merge --auto` does NOT queue on this repo** — auto-merge is disabled, so it merges IMMEDIATELY (bit us 2026-08-14: used expecting it to hold for green, merged with a check still pending). To wait for green, poll `gh pr checks <n>` and merge without `--auto`.
- **Never commit coordinator/agent report files**: User flagged 2026-04-30: "do not commit report files like docs/projects/2604-typography-ux/sprint-7-coordinator-report.md." Sprint coordinators and verification agents often write a `*-coordinator-report.md` or `*-verification-report.md` summarizing what they shipped. These are working notes, not project documentation — keep them OUT of the repo. Write to `/tmp/` instead, OR write to `docs/` but `git restore --staged <report>.md` before committing the rest of the work. The findings/audit reports under `docs/projects/2604-typography-ux/findings-*.md` ARE legitimate project artifacts (cross-page consistency audit, mobile UX audit, etc.) — those stay. Coordinator reports about WHICH commits ran on WHICH date are session-internal and should not pollute the repo.
- **Surgical edit discipline (BLOCKING for content edits)**: When the user flags ONE attribute (a price, a tool name, a year-stamp, a label, a callout), change ONLY the sentences containing that attribute. Do NOT rewrite, re-balance, or re-theme the surrounding page — name the page's thesis in one line first and confirm it is unchanged. If a fix seems to need touching >1 paragraph or the structure, STOP and ask before expanding scope. When correcting a stance the user called too far one way (e.g. "too free"), land at the documented middle — do NOT swing to the opposite extreme (the budget free→paid→balanced pendulum cost 4 round-trips on 2026-05-22). Before handback, grep your OWN replacement text for the exact pattern you just removed (year-stamp, banned word, hardcoded tool name, alias) — re-introducing the defect you are fixing is a blocking failure. On renames/cleanups default to LESS: remove old references and update them, never add alias/redirect bridges (zero tech debt); question inherited elements (routing blocks, disclaimers) proactively rather than preserving them until the user points. Scope critic/cold-eyes findings to a punch-list of surgical fixes, NOT license to rewrite the page.
- **2605 course-editing policies (BLOCKING for any 2605 course/content edit)**: ICP-reader read-back (edit as "Sam", not "Alex"), Write-for-Sam-not-Paul (translate operator-shorthand; 2+ flags on one line → diagnose value, stop re-phrasing), and "Pilot" = INTERNAL template review (external kit is `40-49-review/40.18-external-validation-pilot-kit.md`, deferred post-launch). Full verbatim rules: `docs/projects/2605-tech-for-non-technical-founders/60-69-policies/60.01-course-editing-policies.md` — read it before touching course content.

### ✍️ Blog Post Pipeline (MANDATORY)

When asked to write, draft, schedule, or publish a blog post, execute `docs/workflows/blog-pipeline.md` end-to-end as the canonical workflow. Do not stop after the draft step. If any step fails, fix and retry before moving to the next step.

For drafts (`draft: true`), still run the full pipeline so the post is publish-ready when someone flips it to `false`.

Repo voice guides and workflow docs override generic writing, SEO, or humanizer skill advice when they conflict.

**Pre-writing reads (MANDATORY):**
1. `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` — voice, banned words, anti-AI structural patterns
2. `docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` — thoughtbot patterns
3. `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` — ICP-E profile

**BLOCKING gates** — `blog-pipeline.md` enforces each; named here so none is skipped, detail lives in its canonical home (dedup, not duplicate):
- **Voice / zero-tolerance AI patterns** — reject rule-of-three, signposting, negative parallelism, sustained staccato, telling-not-showing, apologetic caveats, fake-authority generalization, timeline fabrication; use `-` not `—`. The who/show/practitioner tests + the 90/10 rule + always-name-trade-offs. Full list + fixes: voice-guide "Banned structural patterns".
- **Slop ≤25 + shape-tell critic** — slop score is necessary, NOT sufficient (user flagged "still feels AI" 3× when slop passed). After slop passes, run the shape-tell critic (essay-arc, pivot sentences, slogany flips, definitional cadence, 2026-05-28 reveal-twist / cost-stacked opener / cinematic time-cut / fabricated-cohort-stats tells). Full pattern lists: voice-guide + memories `feedback_slop_detector_misses_shape_tells.md`, `feedback_voice_regression_m1_m3_2026_05_28.md`. **Every revision runs the regression sweep before handback** (banned patterns regress under time pressure): `grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with"` across edited chapters, and count opener shapes — no 3+ consecutive chapters share an opener template.
- **Cross-post repetition** (cluster posts) — anecdote scan + proof-signal scan so no story or diagnostic signal double-anchors sibling posts. Detail + the signal-portfolio map: blog-pipeline.md, memories `feedback_cross_post_signal_repetition.md` / `feedback_hook_bank_diversity.md`.
- **New-media visual gate** — after ANY new visual, verify via chrome-devtools at 1280×800 AND 390×844 (not just "screenshot taken") and score 4 criteria: (1) great look, (2) functional/readable without zoom, (3) earns the next scroll, (4) helpful not decorative. Any NO on 3 or 4 = ROLLBACK/redesign; write the scores in the commit/report. Mermaid >2× viewport height = wall, not hook. Then the full page **scroll gate** (`docs/workflows/visual-scroll-gate.md`) — text validators can't see rendered output.
- **Cognitive load / F-pattern** (posts >800w) — hero visual in the first fold (71% drop without one), decision-aid format for if-X-then-Y, labels INSIDE diagrams, one visual break per H2, no decorative visuals, no 6+ identical bullets/rows, no text bricks (Paul 2026-08-17: no paragraph >~5 rendered lines — quotable artifact → blockquote, enumeration-in-prose → list, if-X-then-Y → table; full rule in `.okf/content/voice-rules.md`). Source: `docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.05-content-organization-patterns-2026.md`.
- **dev.to import ICP gate** — `source: dev_to` posts are auto-imported unfiltered; audit vs the ICP voice guide before shipping/referencing, `draft: true` if 80+/100 AI-feel. (blog-pipeline.md)
- **Code fences: `html` not `erb`** — Hugo's Chroma has no `erb` lexer → the block renders as invisible light-on-missing-background text. (blog-pipeline.md)

---

## 📋 Quick Reference

| Command | Purpose |
|---------|---------|
| `bin/hugo-build` | Build + validate site |
| Test commands | See the header **Test** line (single source for qtest/smoke/critical/full-pair) |
| `Search the codebase at <repo root> for: "[pattern]"` | Local patterns (claude-context MCP; repo root via `git rev-parse --show-toplevel`) |

**Coverage**: Full codebase indexed (830+ files, 4,184+ semantic chunks)
**Design System**: JetVelocity — obsidian dark, Ruby red (#cc342d), neon purple (#a855f7). See `.stitch/design.md`
**ICP**: Non-technical founder burned by a devshop. See `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`

## Tooling Preference
- Use `bun` for JS dependency installs and scripts; do not use `npm`.
