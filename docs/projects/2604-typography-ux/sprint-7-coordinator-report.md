# Sprint #7 Coordinator Report - 2026-04-29

Two-issue cleanup sprint bundled into a single feature branch + single PR per the new "Feature-branch + ONE bundled PR per sprint" CLAUDE.md rule.

**Branch**: `sprint-7-cleanup`
**Scope**: docs-only (no template/CSS/HTML/layout changes)

---

## Issue 1: orphan `body { min-width: 992px !important }` audit

**Result**: NO-OP (already fixed by Sprint #5).

**Investigation**:
- `grep -rn "min-width: 992px !important"` across `themes/beaver/assets/css/` returns 1 file: `vendors/base-4.min.css`.
- Its single match is **inside `@media print { ... @page { size:a3 } .container,body{min-width:992px !important} ... }`** - correct print behavior, leave alone.
- `find ... -name "*.css" | xargs grep "body[^{]*\{[^}]*min-width:[^}]*992[^}]*important"` across the whole repo (excluding `_dest/`, `node_modules/`, `public/`): zero source files match outside `@media print`.
- Re-ran `bin/hugo-build` - the regenerated `_dest/public-dev/css/blog-list.*.css`, `blog-single.*.css`, `not_found.*.css` bundles still carry `body{min-width:992px !important}` ONLY inside `@media print` (correct).

**Why findings doc said multiple bundles**: the rule lived in ONE source file (`base-4.min.css`) and propagated into every per-page bundle through Hugo's CSS pipeline. Sprint #5's one-line fix to that source file (commit `6b08694ff`) removed it from all consuming bundles in a single shot. The "Sprint #5 fixed only base-4.min.css" framing in the parent prompt undersold the impact - that was the source of truth, and fixing it fixed every bundle.

**Action taken**: updated `findings-cross-page-consistency.md` Section 4 Issue #5 to mark RESOLVED with audit trail. No code changes needed. No test gates triggered (no source CSS modified).

---

## Issue 2: re-capture 4 broken/mislabeled competitor screenshots

**Method**: chrome-devtools MCP at 1440x900 desktop viewport.

**Files replaced** (all gitignored per `docs/screenshots/.gitignore` - on-disk replacements, not committed):

| Path | Source | Verified content |
|---|---|---|
| `docs/screenshots/competitors/thoughtbot/comp-tb-claude-skill.png` | https://thoughtbot.com/blog/reviewing-dependabot-prs-is-boring-let-claude-do-it-for-you | thoughtbot dark theme, "Reviewing Dependabot PRs..." H1, ALL-CAPS tags, Jose Blanco byline. 175KB (was 43KB broken). |
| `docs/screenshots/competitors/thoughtbot/comp-tb-js-everything.png` | https://thoughtbot.com/blog/retro-driven-development | thoughtbot dark theme, "Retro-driven development" H1, Rob Whittaker byline. 159KB (was 505KB exact-duplicate of comp-tb-js-composition.png). |
| `docs/screenshots/competitors/evil-martians/comp-em-oklch.png` | https://evilmartians.com/chronicles/oklch-in-css-why-quit-rgb-hsl | Evil Martians "OKLCH in CSS" + Hire Martians pill + 3D mascot graphic + Andrey Sitnik byline. 262KB (was 498KB JT-mislabeled). |
| `docs/screenshots/competitors/evil-martians/comp-em-favicon.png` | https://evilmartians.com/chronicles/flaky-tests-be-gone-long-lasting-relief-chronic-ci-retry-irritation | Evil Martians "Flaky tests, be gone" + TV mascot graphic. 683KB (was 498KB JT-mislabeled duplicate). |

**Md5 verification**: all 8 files in `docs/screenshots/competitors/` have unique md5 hashes (no remaining duplicates), no 43KB broken files.

**Action taken**: replaced 4 files on disk; updated `findings-competitor-benchmark.md` inventory table with new source URLs and Sprint #7 RE-CAPTURED status.

---

## Test gates

Per CLAUDE.md "Direct-to-master is only acceptable for ... docs under `docs/`" - this sprint is docs-only (markdown + gitignored PNGs). No CSS/HTML/template/layout changes touched. `bin/test`/`bin/dtest` not triggered (no behavior to verify). `bin/hugo-build` run once and passed (655 pages, 4.7s).

## Drift remaining

- 4 thoughtbot screenshots (`comp-tb-{duck-typer,js-activerecord,js-composition,props-template}.png`) and 1 Evil Martians (`comp-em-payment-form.png`) marked "likely real, not visually verified" still need a verification pass. Out of scope for Sprint #7 (parent's spec was the 4 broken/mislabeled files only). Defer to next session.
- The pre-existing `content/blog/*` and `90.11-voice-guide.md` modifications on master at session start were left untouched - they're someone else's WIP, outside Sprint #7 scope.
