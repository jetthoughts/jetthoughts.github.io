# Claude Code Configuration — JetThoughts Blog

**Coding posture**: activate `/ponytail:ponytail ultra` at session start and hold it — radical KISS/YAGNI, deletion over addition, shortest working diff. Applies to every code/config change.

> **Head lives in the vault** (`~/Documents/pkm`): [[jt-business-os]] / [[jt-vibe-code-rescue]]. **The vault owns OPERATIONS; this repo is growth/marketing campaigns only** (Paul 2026-08-20): identity, positioning, bet status, weekly loop, pipeline numbers live there; `docs/business/` holds pointer stubs. This repo keeps blog, SEO, LinkedIn drafts, landing pages, the course, outreach copy, and all tooling/tests. Do not create a parallel opportunity portfolio or scorecard here (flagged 2026-07-22); campaign working papers under `docs/projects/` stay put. Read the vault note before changing positioning or bet status.
>
> **Company FACTS are NOT vault-owned.** Every claim in `.okf/content/claims-canon.md` is canon HERE, enforced by `test/unit/marketing_copy_test.rb`. Never copy a company number out of a vault note into published copy (the vault itself carried two banned strings on 2026-08-17). The vault decides what we're doing; the canon decides what we're allowed to say.

**Type**: Hugo static site blog | **Build**: `bin/hugo-build`
**Test**: `bin/qtest --changed` (per change — tests the pages your diff touches) / `bin/test --smoke` (fixed 17-test core net, ~50s / ~30s CI) / `bin/rake test:critical` (milestones) / `bin/test` + `bin/dtest` (PR prep). qtest and smoke are complementary: qtest follows your diff, smoke is a constant basics check.
**CSS**: PostCSS pipeline | **Content**: `content/blog/` (Markdown + Hugo frontmatter)

---

## 📌 Critical Files — READ BEFORE CHANGES

| File | When to Read |
|------|-------------|
| `@config/_default/hugo.toml` | ANY Hugo/site config change |
| `@themes/beaver/layouts/blog/list.html` | Blog index/listing changes |
| `@themes/beaver/layouts/partials/blog/img-cropped.html` | Blog thumbnail/cover changes |
| `@layouts/partials/seo/enhanced-meta-tags.html` | SEO/og:image/meta changes (root-level override, not the theme copy) |
| `@themes/beaver/layouts/partials/page/cover_image.html` | Blog post cover rendering |
| `@.stitch/design.md` | Cover image generation |
| `@docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` | ANY content, design, landing page, or marketing work |
| `@docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` | Writing ANY blog post or marketing copy |
| `@docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md` | Writing tech/Rails posts |
| `@docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md` | Writing/planning the next blog post (20.07 superseded — kept for topic briefs only) |
| `@docs/workflows/linkedin-post-pipeline.md` | Writing ANY LinkedIn post |
| `@docs/workflows/linkedin-icp-validation-plan.md` | LinkedIn posts under the ICP-E campaign |
| `@bin/hugo-build` / `@Rakefile` / `@test/test_helper.rb` | Build workflow / test workflow / writing tests |
| `@docs/projects/2509-css-migration/2026-07-12-css-maintainability-redesign.md` | ANY CSS change — plan + evidence rule (compiled+gzip, never raw line counts) |
| `@docs/projects/2509-css-migration/css-bundle-ownership-map.md` | ANY CSS change — which pages a CSS file affects |

---

## 📚 OKF Knowledge Bundle (`.okf/`)

Operational knowledge lives in `.okf/` (`build/`, `content/`, `design/`, `workflows/` — one concept per file). Consume via progressive disclosure: `/okf:okf` (consume) at session start; never hand-read or hand-edit the bundle format — the skills carry the spec. Validate with `/okf:validate .okf --strict` before committing bundle changes.

**Maintain as you work (ENFORCED)**: a durable learning updates its concept + section index + a dated `.okf/log.md` entry, riding the SAME commit as the change — dispatch a background okf-maintainer in parallel, or inline for tiny fixes; a weekly maintain pass back-fills misses. A session that shipped durable knowledge without an OKF entry is not done.

---

## 🔍 Research Protocol

**Session start**: read `@docs/workflows/BASE_HANDBOOK.md` + `@docs/workflows/flow-router.md`, run `/okf:okf` consume. Prefer skills over agents unless the workflow requires them.

**Memory — search before deciding, store as you learn (ruflo-first, Paul 2026-08-21)**: at session start and before any non-obvious decision, `mcp__ruflo__memory_search` with a semantic query from the task's actual words — a past 🔧 CORRECTION outranks fresh reasoning. Store cross-session decisions/corrections/state the moment they land via `mcp__ruflo__memory_store` (one fact per entry; 🎯 GOAL / 📋 PLAN / 🔄 RETRO / 💡 LESSON / 🔧 CORRECTION / ⚠️ ANTIPATTERN prefixes; corrections upsert the existing key — never a second copy). This is IN ADDITION to the ENFORCED OKF rule above — `.okf/` owns repo-canonical knowledge, ruflo memory owns what a future session must recall before deciding. Terminal gotcha: CLI `memory search --type semantic` returns empty (needs @ruvector/core) and hybrid degrades to its keyword leg — use `--type keyword` in terminals; real semantic search works only via the MCP tools. Fallback when ruflo is down: memoria / mem0.

**Markdown search (docs/, content/, .okf/) — `qmd` FIRST** (Paul 2026-08-01; collection `jt-site`; `qmd embed` after big doc batches): known terms → `qmd search "..." -c jt-site -n 5`; conceptual → `qmd query` with lex/vec/hyde fields; then `qmd get`/`multi-get` — never answer from snippets. **Code** (templates/CSS/Ruby): claude-context MCP (`Search the codebase at <repo root> for: "[pattern]"`, root via `git rev-parse --show-toplevel`) or grepai/tokensave; DeepWiki `ask_question` on `jetthoughts/jetthoughts.github.io` for repo-level questions; `rg`/`ls` after, for exact names. `knowledge/` is a host-only symlink — never depend on it in container/CI sessions.

**Blog internal links**: qmd first; slug/tag lookups in `docs/blog-post-index.md` (regenerate: `bin/generate-blog-index`; never trust its count if the date stamp is old). Never guess slugs — verify `ls content/blog/<slug>/index.md`.

---

## 🧪 TDD & Testing

- **TDD**: RED → GREEN → REFACTOR. Doctrine: `docs/20-29-testing-qa/` + `docs/incidents/25.0x`.
- **Behavior-focused tests ONLY** — reject implementation/existence/config tests. Don't hardcode tunables (`q=90`, exact sizes); assert the shape (`q=\d+`, has `<picture>`). A test that breaks on a knob change is testing config — relax it.
- **Framework**: Minitest (`test/system/`, `test/unit/`). Test runner matrix: the header **Test** line — don't restate it.
- **Visual regression + gates**: full matrix, tolerances, baseline procedure → `.okf/build/test-gates.md` (canonical). Tolerance 0.0 for refactoring, ≤0.03 for new features.
- **After HTML/CSS/JS changes**: chrome-devtools pass — zero console errors, zero asset 404s, desktop + mobile screenshots, verify Core Web Vitals. All gates pass → commit; any fail → fix first.

---

## 📁 Workflow Pointers

- **New page (paved path)**: `docs/workflows/new-page.md`
- CSS consolidation: `docs/workflows/css-consolidation.md`
- Blog pipeline: `docs/workflows/blog-pipeline.md`
- LinkedIn pipeline: `docs/workflows/linkedin-post-pipeline.md`. **Every LI post you create or update ends its handback with the preview link** `http://localhost:<session port>/linkedin/<lane>/<slug>/` (dev-only mount; board at `/linkedin/`) — a one-line edit ships with the link too, never the post body instead (details: `linkedin-posts/README.md` §Review board).
- Cover images: `docs/workflows/cover-images.md` (spec: `.stitch/design.md`)
- Visual scroll gate: `docs/workflows/visual-scroll-gate.md`
- Agent strategy: `docs/workflows/agents.md`

---

## 🚨 Behavioral Constraints

- **Feature/idea intake**: `/deliver <idea>` (or §1a of `docs/workflows/autonomous-delivery-prompt.md`) — triage → GOAL → author≠verifier orchestration under the contract.
- **Manager triage (Paul 2026-08-01)**: Paul adds requests mid-flight; triage each against the active plan — now / sequenced / backlog / groom-first — and report the verdict in one line so he can override. Deferring is a decision; interrupting a gated pipeline for a non-critical request is the failure. **Autonomy grant**: handle sprints end-to-end; for big/critical calls run a 2-4 agent voting panel and make the call (split + irreversible → hold for Paul). Record every autonomous call with its evidence. Paul's explicit words override any panel.
- **Agent 4-eyes on EVERY stage, author ≠ verifier (Paul 2026-08-20, widened 2026-08-21)**: every change is written by one agent and verified by a different one; review lands BEFORE the artifact leaves the workshop (plan before Paul sees it, diff before commit, finding before reported, measurement before quoted). Brief reviewers with goal + artifact, never conclusions; ask for measurements, not verdicts. Internal sub-agents per stage; `/codex:review` once at the merge gate for user-facing changes. Full protocol: `docs/workflows/autonomous-delivery-prompt.md` §5. (Evidence: 2026-08-20/21 — reviewers caught a CSS-breaking defect, a fabricated quote, and 11 findings on the delivery prompt itself, all after author self-review.)
- **Async-first (MANDATORY)**: written, discoverable artifacts for every decision, finding, and handoff; sync is the exception, written back same-day. A task is not done until a cold session can read its state with zero questions. Canonical surfaces: `.agents/skills/async-first-communication/SKILL.md`; same SOP in `AGENTS.md`.
- **Company facts have a canon**: check `.okf/content/claims-canon.md` before publishing any number (founding 2008-09-01; tenure from `site.Params.foundingYear`; "4.8/5 on Clutch" linked, NO review count; founder 22+ vs company 18+). A number with no in-repo source is a defect. Correcting one means sweeping the instruction layer too — `PRODUCT.md`, `docs/business/`, outreach kits have re-introduced bad canon before (4 of 8 published figures were wrong on 2026-08-14).
- **Text ratchets read RENDERED output, not source**: `marketing_copy_test` globs source and missed three rendered-only defects on 2026-08-14 (unglobbed partial, line-wrapped banned phrase, composed nested `<main>`). Queued: `docs/20-29-testing-qa/20.10` §3b P0-4.
- **Zero**: generic AI language · unsupported claims · Hugo build breaks (`bin/hugo-build` validates) · ad hoc test scripts (header Test line commands only) · Python for analysis (use `rg`/`sed`/`awk`) · duplicate files (`*_new.*`, `*_backup.*`).
- **Never leave the shell in a subdirectory (2026-08-19)**: Bash cwd persists between calls; a bare `cd` breaks every later repo-relative path and reads as "file missing". Use absolute paths, `cd <root> && cmd`, or `git -C`. If a known file reports missing, run `pwd` before believing it.
- **New-doc locations — `docs/workflows/` is NOT a catch-all** (Paul 2026-08-01). Order: (1) engineering reference → its Johnny Decimal area (`docs/10-19-…` through `90-99-…`, naming `NN.NN-name-{reference|tutorial|how-to}.md`; check the area's README/existing numbers first); (2) company/OS → vault-owned, `docs/business/` stubs only; (3) opportunity validation → `docs/projects/<YYMM-slug>/`; (4) ADRs → `docs/adr/`, incidents → `docs/incidents/`, design system → `docs/design-system/`; (5) `docs/workflows/` ONLY for cross-cutting pipeline how-tos. Everything else edits an existing file.
- **Stale-view check (2026-08-17)**: feedback quotes page text → grep current source FIRST; absent means stale tab/server — reply "already fixed, hard-refresh" with the link. Never fix a defect that no longer exists.
- **Handbacks end with local review links (Paul 2026-08-17/19)**: any change to something that renders locally ends with its `http://localhost:<port>/<path>/` link(s) — "renders locally" is the test (includes `linkedin-posts/` drafts), not "lives in content/".
- **Session-random dev-server port (Paul 2026-08-17)**: `PORT=$((20000 + RANDOM % 20000)) bin/dev`, once per session; never assume 1313; never kill a server you didn't start.
- **Reflection trigger**: Paul reports "code is bad" / "over-engineered" → HALT, 5-Why, fix config, then proceed.
- **Self-critique on voice-sensitive content (BLOCKING)**: any LinkedIn/blog/marketing draft runs `reflexion-reflect` BEFORE first handback; after pushback on the same draft, escalate to `reflexion-critique`. Solo iteration misses pattern-level tells (5 corrections on a 0/10-scored post, 2026-05-11).
- **Content-only changes SKIP the visual suites (Paul 2026-07-31)**: markdown prose/frontmatter only (no themes/layouts/CSS/body HTML) → `bin/hugo-build` + rendered scroll gate; NOT qtest/test/dtest. The moment the diff touches a template/stylesheet/body HTML, the visual gate applies in full — check the actual diff, not the intent. Docs/instruction-only PRs also skip the app-build CI (publish.yml paths-ignore, 2026-08-21).
- **Visual regression gate (BLOCKING for HTML/CSS/template changes)**: `bin/qtest --changed` before EVERY commit; the full `bin/test` + `bin/dtest` pair ONCE at PR prep — a PR must never open without the dtest leg (CI is Linux). Failures are commit blockers: fix, or confirm intentional AND update both `macos/` + `linux/` baselines in the same commit. Baselines compare against git HEAD, not the working tree — identical difference_level across runs means a stale committed baseline (`md5 -q` the file to confirm), not flaky rendering. Full procedure incl. Linux re-record: `.okf/build/test-gates.md`. (Evidence: the 2026-04-30 35-failure incident — 15 commits with no visual gate; the suite caught a real `.fl-button` regression.)
- **Feature-branch + PR for ALL changes (BLOCKING — Paul 2026-08-17)**: never push to master, any change type. Branch → related commits → gates green → `gh pr create` (body: summary + per-commit description + visual evidence). **One sprint = ONE PR** (Paul 2026-04-30), **capped at ~500 changed lines of CODE** (Paul 2026-08-21; docs, `.okf/` logs, binaries/baselines don't count — docs-only may batch bigger); an oversized code sprint splits into sequential PRs, merge N before opening N+1. `gh pr merge --auto` does NOT queue here — it merges immediately; poll `gh pr checks` and merge without it.
  **Master moved → REBASE, never merge it in** (Paul 2026-08-20): tag a backup ref, `git rebase origin/master` (`--autostash` if unstaged changes block; never a bare `git stash`), `git push --force-with-lease`. Branch cut from a since-squash-merged branch replays its own merged commits — don't fight it: `git reset --hard origin/master` + cherry-pick your commits; always cut from `origin/master`. `.okf/log.md` conflicts on essentially every parallel PR — resolution is near-always keep-both.
- **Never commit coordinator/agent report files** (Paul 2026-04-30): `*-coordinator-report.md` / `*-verification-report.md` are session notes — `/tmp/` or unstage before commit. Genuine audit findings under a project's `findings-*.md` stay.
- **Surgical edit discipline (BLOCKING for content edits)**: Paul flags ONE attribute → change only the sentences containing it; name the page's thesis first and confirm it unchanged; >1 paragraph or structure → STOP and ask. Correcting "too far one way" lands at the documented middle, not the opposite extreme (the pendulum cost 4 round-trips, 2026-05-22). Before handback, grep your OWN replacement for the exact pattern you removed. Renames/cleanups default to LESS: no alias/redirect bridges. Critic findings are a surgical punch-list, not license to rewrite.
- **2605 course edits (BLOCKING)**: ICP-reader read-back as "Sam", Write-for-Sam-not-Paul, "Pilot" = internal review. Full rules: `docs/projects/2605-tech-for-non-technical-founders/60-69-policies/60.01-course-editing-policies.md` — read before touching course content.

### ✍️ Blog Post Pipeline (MANDATORY)

Any request to write/draft/schedule/publish a post executes `docs/workflows/blog-pipeline.md` end-to-end — do not stop after the draft step; a failing step is fixed and retried before the next (drafts too — publish-ready when flipped). Repo voice guides and workflow docs override generic writing/SEO/humanizer skill advice. Pre-writing reads: voice-guide 90.11, thoughtbot analysis, ICP 90.10.

**BLOCKING gates** — enforced by blog-pipeline.md; named here so none is skipped, detail in the canonical home:
- **Voice / zero-tolerance AI patterns** — banned structural patterns + fixes: voice-guide; use `-` not `—`.
- **Slop ≤25 + shape-tell critic** — slop score is necessary, NOT sufficient; run the shape-tell critic after it passes; every revision runs the regression sweep before handback: `grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with"` across edited chapters + opener-shape count (no 3+ consecutive chapters share a template). Details: voice-guide + memories.
- **Cross-post repetition** (cluster posts) — anecdote + proof-signal scan: blog-pipeline.md.
- **New-media visual gate** — chrome-devtools at 1280×800 AND 390×844, score 4 criteria (look / readable / earns scroll / helpful) and write the scores in the commit/report; NO on 3 or 4 = rollback. Then the full-page scroll gate (`visual-scroll-gate.md`).
- **Cognitive load / F-pattern** (posts >800w) — hero visual first fold, labels INSIDE diagrams, one visual break per H2, no 6+ identical bullets/rows, no text bricks (>~5 rendered lines; full rule `.okf/content/voice-rules.md`), decision-aids as tables. Source: `docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.05-content-organization-patterns-2026.md`.
- **dev.to import ICP gate** — audit `source: dev_to` posts vs the voice guide before referencing.
- **Code fences: `html` not `erb`** — Chroma has no erb lexer; erb blocks render invisible.

---

## 📋 Quick Reference

**Design System**: JetVelocity — obsidian dark, Ruby red (#cc342d), neon purple (#a855f7). See `.stitch/design.md`
**ICP**: Non-technical founder burned by a devshop. See `90.10-icp-primary-website-target.md`
**Tooling**: `bun` for JS installs/scripts — never `npm`.
