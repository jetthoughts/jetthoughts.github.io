# 2608 - Site design system (v2 clean-slate)

**Paused 2026-08-22, mid-flight. Start here.**

## Where the work stands in one paragraph

The legacy CSS was recovered from an obfuscated export and fights every change,
so v2 is being built clean on a noindexed `/next/` rail and cut over page by
page (ADR-0006). Three visual registers were built as full landing pages,
compared under controlled conditions, and voted on. Then the positioning
changed underneath them: the site now sells one offer and bans title claims, so
the pilots' copy has been rewritten but not yet applied. Nothing is blocked on
engineering - it is blocked on five decisions from Paul.

## Read in this order

| Doc | What it holds |
|---|---|
| `20-29-strategy/20.06-clean-slate-v2-plan.md` | **The plan of record + the COLD-SESSION STATE LEDGER.** Every row's status. Read the ledger first. |
| `20-29-strategy/20.09-repositioned-pilot-copy.md` | **The next task.** Repositioned copy, drafted and canon-verified, with a step-by-step apply checklist. |
| `20-29-strategy/20.08-register-demo-board.md` | The three pilots, the panel ballots, the recommendation, the decision protocol. |
| `10-19-research/10.01-design-register-research-2026-08-reference.md` | Why these three registers, the external research, the candidate table. |
| `../../adr/0006-clean-slate-dual-run.md` | The dual-run mechanism, supersession scope, flip checklist, sunset condition. |

## The five decisions waiting on Paul

1. **Pick the register** on the live pilots. Panel first choices: B 2 / C 1 / A 1;
   restricted to the two Claude Design artifact sets it is Editorial 4-1;
   recommendation is Editorial plus grafts (Precision's ledger table for data
   surfaces, Rescue Room's mobile rhythm patterns).
2. **Three claims**, all currently cut from the page: "the repo stays in your
   account", "starts in days", "no equity, no lock-in".
3. **Which page ships first** - homepage, or a standalone offer page. Under
   one-offer positioning these largely collapse into the same page.
4. **The legacy fractional-CTO sweep.** Those pages carry a claim now ruled
   inaccurate, today. `/services/fractional-cto/` has ranking history, so this
   needs a GSC check, not a deletion.
5. **Whether the ~2026-09-17 homepage measurement gate should fall**, given the
   homepage is being repositioned anyway.

## Live artifacts

Pilots (noindexed staging, on production once deployed):
`/next/pilots/{rescue-room,editorial,precision}/fractional-cto/` - renaming to
`/embedded-team/` when 20.09 is applied.

Claude Design projects (Paul's, external): `8eb98dd6-e460-469c-a43c-93fdc3f8592e`
holds the Editorial service page **and the homepage blueprint**;
`3dc819cf-084f-4dd6-b7aa-7275c2424e68` holds the Rescue Room service page.
The homepage blueprint has two open problems: its "Three ways in" section lists
three offers (one a banned title claim), and its audit exhibit is presented as
"from a real one, redacted" without a named source.

## Known red, do not re-record blindly

**RESOLVED 2026-08-22.** `linux/mobile/blog/index/_pagination` was a real
content difference (0.0425, max_delta 238), fixed by an `update-baselines`
dispatch **on master**, where the recorder and the tester see the same tree -
recording on a feature branch is what had produced a baseline the PR run never
matched. Verified green: CI screenshot run 32565008850, zero failing keys.

**The open one is different, and it is NOT architecture.** `bin/dtest` on a Mac
fails 8 `mobile/blog/special/codeblocks/*` screenshots at ~0.055-0.063. The
first three explanations offered for this were wrong, including "arm64 vs
amd64" - measured 2026-08-22, the test container is **x86_64** already
(`.dev/compose.yml` pins `platform: linux/amd64` on the `t` service, and that
does override `bin/dc`'s `DOCKER_DEFAULT_PLATFORM=linux/arm64/v8`).

What actually differs is the base OS:

| | local container | CI |
|---|---|---|
| arch | x86_64 | x86_64 |
| Chrome | 152.0.7977.54 (`.dev/cft-version`) | same pin, cached by its hash |
| `fonts.conf` + font packages | same | same |
| **base OS** | **Debian 13 trixie**, freetype 2.13.3 | **ubuntu-latest** |

Same architecture, same browser, same fonts by name - different distro, so
different freetype/harfbuzz builds. Dense monospace (syntax-highlighted code)
is where that shows first. The `linux/` baselines are a recording OF a
rendering stack; two stacks means they are only valid for one of them.

**The decision, then, is not arm-vs-amd. It is one rendering stack or two:**

1. **Run CI in this same container.** Local and CI become identical by
   construction, dtest becomes authoritative for visuals, and the "is this
   drift or a defect?" question disappears. CI is amd64 native, so the image
   runs without emulation; the cost is image build/pull per job, cacheable.
   **Measure that cost before committing** - it is the only real argument
   against.
2. **Accept the split**: CI owns pixel truth, dtest is a behavioural gate, and
   those 8 keys are screened as known-divergent. Free today, but an
   expected-red list is exactly what rotted into "everything is expected red"
   before #566.

Chasing parity by pinning font/library versions across two distros is a third
option and not a serious one - Debian and Ubuntu drift independently, forever.

Either way: never re-record `linux/` baselines from a Mac. The container is a
different stack from the recorder (`.okf/build/test-gates.md`).

Also worth cleaning up regardless: `bin/dc` exports
`DOCKER_DEFAULT_PLATFORM=linux/arm64/v8`, which the `t` service overrides but
the `hugo` dev service does not - and it is what made three separate arch
explanations look plausible today.

## What the sprint shipped (PRs #560-#578, 2026-08-21/22)

**The redesign**: three register pilots on the `/next/` rail (#561-#563) with a
cross-pilot specificity fix (#564), the demo board and panel vote (#565), and
the working papers (#567).

**The instrument, which turned out to need more work than the redesign**: the
visual gate was blind by 50x and green runs restored old baselines over fresh
captures (#560); 127 baselines re-recorded with every diff classified and the
tolerance shield deleted on a measurement (#566); the noise floor is per-page,
so the hand-pinned `0.03` tolerances are load-bearing rather than padding
(#570); fault-injecting 8 realistic defects caught only **3** (#572), which
un-blinded the link checker - 114,050 links checked against 15,642, finding
five real site defects including a self-canonical pointing at a 404 and a
promised download that never existed (#574) - and then closed the gaps to
**8 of 8** (#576); and `bin/dtest` was found to be comparing **nothing** from a
git worktree, with five-worktree parallelism added alongside the fix (#578).

The rule that came out of it, now blocking in `CLAUDE.md`: a new test is not
done until you have broken the code and watched it fail.
