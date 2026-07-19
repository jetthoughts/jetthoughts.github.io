# Course Audit Runbook (mechanical checklist for any agent)

Purpose: let a less-powerful agent run the FULL course audit (structure, length,
terminology, canon, voice, reuse/seams, render) with minimal judgment. Every
check below is a command + a pass rule. Where judgment is unavoidable, the check
gives scoring anchors and an escalation rule instead of asking for taste.

Scope root: `content/course/tech-for-non-technical-founders-2026/` (call it `$C`).
Run everything FROM THE REPO ROOT. Background shells inherit cwd - launching
`bin/rake` from a subdirectory fails with a misleading exit 0 (2026-07 incident).

Binding sources (read before starting; do not audit from memory):
- Format spec: `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.03-course-format-requirements-for-creators.md`
- Canon: `.okf/content/course-canon.md` (numbers, cast, terminology, progressive-elaboration rule)
- Voice: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` + CLAUDE.md "Zero tolerance AI patterns" + "Slop detector" sections
- Render gate: `docs/workflows/visual-scroll-gate.md` (the FULL protocol; Phase 6 below is a pointer, not a replacement)
- Sequence/wiring: `data/course_sequence.yaml`

---

## Phase 0 - Setup

```sh
bin/hugo-build                     # must exit 0; 8 course validators run inside
ls $C                              # enumerate pages; classify each as:
                                   #   lesson (N.N in title), walkthrough,
                                   #   template/companion, reference/*-full, landing/faq/overview
```
Never review repo-root `public/` - built output is `_dest/public-dev/` only.

## Phase 1 - Length (mechanical)

Body word count, uniform basis (frontmatter + code fences stripped):

```sh
for f in $C/*/index.md $C/reference/*/index.md; do
  w=$(awk 'f&&!/^---$/{print} /^---$/{f++}' "$f" | sed '/^```/,/^```/d' | wc -w)
  echo "$w  $f"
done | sort -rn
```

Pass rules:
- Lessons: 900-1,500 on this basis = PASS ("exemplar parity" - the migrated
  1.4 exemplar measures ~1,258; the 30.03 raw bands of 400-600/600-900 are on a
  stricter prose-only basis and are NOT the gate). 1,500-2,100 = PASS only if
  the overage is mandated keeps (full prompts, teaching tables, reuse bridges) -
  name them. >2,100 = FAIL (unmigrated or bloated).
- reference/*-full pages: 1,100-2,900 = PASS. >2,900 = flag.
- Walkthroughs/landing: no band; flag only >2,500 as "long, not auto-defect".

## Phase 2 - Structure (mechanical greps, one per element)

For every LESSON (numbered N.N), each must be exactly 1 (0 = missing, 2+ = duplicated):

```sh
grep -c "After this lesson you will be able to" $f     # outcome line
grep -c "Success check" $f                              # labeled success check
grep -c "If this fails" $f                              # >=1 labeled failure block
grep -c "> \*\*Done:\*\*" $f                            # closure slots:
grep -c "> \*\*You have now:\*\*" $f
grep -c "> \*\*Next:\*\*" $f
grep -c "> \*\*If blocked:\*\*" $f
grep -c "Deeper reference" $f                           # footer pointer (lessons with a reference companion)
grep -c "Module [0-9] · Lesson" $f                      # orientation badge line
grep -c "\*\*Input:\*\*" $f ; grep -c "\*\*Output:\*\*" $f ; grep -c "\*\*Progress:\*\*" $f
grep -c "See it in action" $f                           # walkthrough link
grep -c "Built by \[JetThoughts\]" $f                   # JT footer
```

Visual count - exactly ONE per lesson body (references may hold more):

```sh
grep -c '!\[' $f                     # markdown images (SVG/PNG)
grep -c '```mermaid' $f              # mermaid blocks; images+mermaid total == 1
```

Optional lessons additionally need: `[OPTIONAL]` in the orientation badge + a
skip line. Check `data/course_sequence.yaml` for which are optional/branched,
and that each lesson's `Next:` matches the yaml order (branches included).

## Phase 3 - Terminology + banned strings (mechanical)

```sh
grep -rn "—" $C --include="*.md" --include="*.svg"           # em-dash: ZERO allowed; dashes are "-"
grep -rnE "\b(Chapter|Ch)\s+[0-9]+\.[0-9]+" $C               # ZERO; numbered units are "Lesson N.N"
grep -rn "this chapter\|next chapter\|the chapter" $C --include="*.md"
    # allowed ONLY for the non-numbered Going-Further long-form set; on numbered
    # lessons = violation ("this lesson")
grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with" $C
grep -rn "we picked up\|we worked with\|I rode shotgun\|I spoke with last" $C --include="*.md"
    # ZERO outside the 4 approved composite-disclaimed vignettes
grep -rn "Illustrative composite" $C --include="*.md"        # every retained vignette needs this line
```

Also run every signature in `data/course_banned_strings.yaml` (the build does
this, but run it explicitly when auditing uncommitted work).
SVGs are NOT scanned by the ratchet - grep them separately (first command above)
and rasterize in Phase 6.

## Phase 4 - Canon numbers (mechanical diff against the table)

Open `.okf/content/course-canon.md`. For each canonical number, grep the course
for the concept and compare EXACTLY. Current table (verify against canon file -
it is the source of truth, this list is a convenience snapshot):

| Concept | Canon | Watch for |
|---|---|---|
| Smoke-test cold visits | 300 | any other visit count |
| Conversion bands | <3 kill / 3-6 iterate / 6-10 promising / 10-20 strong / >20 suspicious | boundary drift |
| Interviews | 10 (30-name list feeding them) | "5 interviews" etc. |
| Sean Ellis | 40% = SURVEY very-disappointed share; thresholds >=10 directional / 20+ useful / 30+ sliceable | conflation with the 40% retention cut (churn page keeps them distinct) |
| Deposit | 10-30% of year-one ACV, $500 floor; customer-cancel = forfeit, founder-cancel = 100% refund | "refundable" applied to customer-cancel |
| Reply bands | 20-30% named-post / 1-5% generic (M2 research); 3-8% cold, <5% stop, 5-10% continue, >10% accelerate (5.7); 30+% warm (M5) | cross-assignment |
| Build/pivot/kill | 7+ / 4-6 / <4 | - |
| Tokens | $80-300 API on top of $20-40 Cursor seat; $500 undisciplined ceiling; $80-120 disciplined team total | Cursor $20-60 (wrong); note: app RUNTIME inference cost (4.5 Signal 1) is a different mechanism - do not "fix" it to seat numbers |
| Weekly-dev-report PRs | #843 admin-search (Priya), #851 rate-limiting (no reviewer, PTO); #847 reserved for refund-branch story | #847 used as generic example |
| Cast | Mia (walkthroughs), Marcos/Priya | "Marcus" misspelling |

Rule: a mismatch is a defect ONLY if it is the same concept. Same number for a
different mechanism (runtime inference vs dev seats) is NOT drift - record it as
"checked, distinct concept".

## Phase 5 - Reuse / seams (procedural)

1. Build the artifact ledger: read every lesson's `Output:` + `You have now:`
   lines in yaml order. The ledger is what the reader HOLDS after each lesson.
2. For every prompt/worksheet/tool step in later lessons: does it consume the
   ledger artifact BY NAME (link or canonical slot: `[customer]` `[problem]`
   `[approach]` `[competition]` `[differentiation]` `[hypothesis]`
   `[customer quote]` `[competitor URL]`)? A step that re-asks for something the
   ledger holds ("describe your product") = FAIL (owner rule: "expand previous
   results, never start over"). A renamed slot for an existing artifact = FAIL.
3. Inbound anchors: `grep -rn "/#" $C --include="*.md"` - for each `slug/#anchor`,
   verify the id exists in `_dest/public-dev/<slug>/index.html`.
4. Lesson-vs-reference duplication: for each `reference/*-full`, spot-diff its
   tables/prompts/scripts against its lesson - moved content must live in ONE
   place (byte-excerpt + pointer is allowed; the 5.6 DPA block is canonical in
   the LESSON, the kit excerpts it).
5. Positional prose: `grep -rn "above\|below" $f` on any page whose content
   moved - verify each still points the right way in the BUILT page.
6. Walkthroughs (`module-N-walkthrough-mia`): each per-lesson beat must not
   contradict the compressed lesson.
7. One-canonical-home registry: SOW table = sow-reading-guide; agency rubric =
   agency-ai-five-questions; DPA = 5.6 `#dpa-template`; outreach sequence =
   outreach-sequence-template. Siblings point, never duplicate.

## Phase 6 - Render gate (pointer - run the real one)

Run `docs/workflows/visual-scroll-gate.md` IN FULL on every page you touched or
audited as changed: headless walk at 1280 wide reading EVERY slice, numeric
probes, rasterize EVERY SVG in scope and read each PNG (moved SVGs especially -
their internal text may reference their OLD host page). Mobile needs
chrome-devtools MCP; raw headless 390px is fake overflow - never report it.
Report as evidence ("N pages x M slices, found X, fixed Y"), never "looks fine".

## Phase 7 - Judged checks (anchored, escalate when unsure)

- Opener-shape taxonomy: mechanism-first / artifact-first / direct-address /
  question / composite vignette (disclaimed). Count shapes across the audited
  set: no shape on more than 4 pages in a sibling set; no 3 consecutive pages
  (in reading order) sharing one; linked pairs must differ.
- Shape-tells (flag, quote the sentence, propose a one-edit fix): reveal-twist
  flips ("It's not X. It's Y."), cost-stacked tri-list openers, aphoristic
  closers, cinematic present-tense scene-setting, sustained staccato (3+
  fragments), "The..." paragraph-opener density >20%, unsourced cohort stats.
- Sam glossing: list every acronym/tool on the page; each must be glossed at
  FIRST mention in plain words. (Audience: idea-stage non-technical first-timer;
  NOT the website rescue ICP - rescue/trauma framing in course bodies = flag.)
- Callout rhythm: 3+ same-form blockquotes adjacent = flag.
- ESCALATE to a stronger model / the owner instead of guessing: taste scores,
  rewriting more than 2 sentences, canon conflicts between two sources, any fix
  that would touch structure or >1 paragraph (surgical-edit discipline).

## Phase 8 - Fix + report protocol

- One defect = one edit. Never re-theme a page. Preserve reuse bridges byte-exact.
- Prose-defect fixes add a `data/course_banned_strings.yaml` signature in the
  same change set (SVG fixes cannot be ratcheted - re-run Phase 6 instead).
- Gates before any commit, FROM REPO ROOT, reading the output file:
  `bin/hugo-build` AND `bin/rake test:critical` AND (if `lib/` or validators
  changed) `bundle exec rake test:unit` - CI runs the unit suite; test:critical
  does not include it (2026-07-17 incident).
- Template pages in `bin/generate-template-pdfs` need PDF regen when their body
  changes; restore untouched PDFs (regen churns bytes).
- Report format: counts per phase, then severity-ranked defects, each with
  file:line + verbatim offending text + the fix applied (or "report-only" +
  why). State what you did NOT check.

## Known process failure modes (from retrospectives)

- Audits must run on the CURRENT tree - an audit of pages that a fixer then
  rewrites certifies nothing; re-audit after any rewrite wave.
- Fixer self-reports are claims: verify counts/greps/renders yourself.
- Parallel fixers own files; NOBODY owns seams unless a seam pass is scheduled.
- Agents go idle without reporting - inspect their work in the tree.
- `.git/index.lock` contention from daemons - retry loop around git ops.
