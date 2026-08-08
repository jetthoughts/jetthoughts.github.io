> ⚠️ **ARCHIVED 2026-08-08** — full task history through the 20.15 wave plan (W1-W5, all merged). The live queue is now the slim [`TASK-TRACKER.md`](TASK-TRACKER.md); this file is the reference for groomed scopes and closed-item history. Item locations preserved: item 13 @L295, item 14 @L819, item 16 @L476, item 18 @L693.

# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-07-30 EOD (NINE PRs merged in one day: #390 C1 completion mechanics · #392/#394 M1 SVGs · #395 M2 decision aids · #396 M3 PDFs · #398 G3 campaign briefs · #402 GA4 root-cause fix + copy-link button · #404 blog->course links · #406 M5 SVGs+checklists. Media waves M1-M5a/b COMPLETE, M4 closed-with-ceiling; growth waves G1-G3 shipped per 20.12 runbook. Decisions: Clarity waived (GA4-only), fully ungated / NO mail list, analytics consent granted by default, certificate rejected for stealth ICP. Earlier same day: strategy review vs Product Compass + Lenny corpus + 3-persona synthesis; DoD rules 6-7. Previous: media pilot shipped + repaired: 7 SVGs on 4 pages, 2 new template pages with covers, 40.20 gap audit. Media modernization backlog groomed below. Previous: PR #356 MERGED as ad1cb19c, deployed, production verified. It carried: Sprints A+B+C [GA4 funnel events + Clarity hook + pilot kit 40.18; walkthrough heroes/artifact trails + TL;DR accent + 21 cover badges; PDF pipeline + 5 printable worksheets], the 3-round PDF/SVG visual loop [43 SVGs + 61 pages exhaustively inspected, 13 SVGs repaired], the 8-dimension premium swarm review 40.19 [54/60 PREMIUM; all sub-premium findings fixed], and the reflection round [old-spine 6.x title ghosts, AI-block label leaks x4, org-chart mermaid -> decision table, Good/Bad callout accents + cascade bug].)

## Active Phase: full backlog execution — PILOT GATE REMOVED (Paul, 2026-07-31: "plan all pilot-gated backlog, no need to wait for pilot recruitment"). Pilot recruitment stays on Paul's desk (kit 40.18) but blocks nothing. Measurement: GA4 consent fix shipped in #402; Clarity CONFIGURED (project xum05dgnec, waiver superseded); analytics excluded from local/test builds via baseURL gate.

## Open queue (2026-07-31 - what a cold session picks up next, in order)

0. ✅ **Wave 0 SHIPPED** (PR #407, merged + deployed 2026-07-31): Clarity
   xum05dgnec live, analytics excluded from local/test builds (baseURL gate),
   both mobile homepage baselines re-recorded per #405's note, qtest-first
   test policy codified (CLAUDE.md/AGENTS.md/OKF).
1. ✅ **Wave A DONE** (2026-07-31, production via Chrome devtools): all
   events 204 with consent granted (gcs=G101) - page_view, scroll,
   course_pdf_download (beacon, survives PDF navigation),
   course_copy_share_link (beacon, labeled); Clarity recording live.
   Results table in runbook 20.12. Known nit: pdf event's course_label empty
   (link_url carries the file).
2. ✅ **Wave B SHIPPED** (PR #408, 2026-07-31): 5 informational SVGs for the
   zero-visual reference chapters; scroll gate both viewports; one review
   fix (Prompt 5 text-margin budget); bonus: stray </content> corruption
   removed from find-10-people-full.
3. ✅ **Wave C SHIPPED** (PR #409, 2026-07-31): 20 covers (18 reference +
   faq + quickstart) via the cover pipeline. Sprint B #7 stale-badge audit:
   premise INVALID - all 61 existing covers audited, no "NN/30" badge exists;
   item CLOSED with nothing to regenerate.
4. ✅ **Wave D DONE** (2026-07-31): SERP table filled in runbook 20.12.
   Target phrases not in top 10 (course too new, no backlinks - Wave G is
   the lever); one genuine gap fixed: /course/ section had NO _index.md so
   its snippet was site boilerplate - created with course-specific
   description. Runbook 20.12 is now fully complete.
5. ✅ **Wave E SHIPPED** (PR #410, 2026-07-31): echo-chamber callouts in
   2.3/5.3 + Concierge MVP path in 4.3 (fixes the glossary's dangling 4.3
   pointer). 4 items closed done-as-stale with evidence: Loom already
   canonical in 5.4/5.5; EaM deliberately reference-tier per 40.19;
   manual-minimum paths already stated everywhere. **Operating Kit "5
   remaining templates" CLOSED as invalid** (coordinator call, 2026-07-31,
   per Paul's decide-don't-wait rule): no authoritative list exists in any
   doc, and the kit page's reviewed framing says all 6 components are live
   at their source lessons. Reopen ONLY if GA4 course_pdf_download data
   shows demand for a specific missing template.
6. ✅ **Wave F SHIPPED** (PR #411, merged + production-verified 2026-07-31 -
   course_checkpoint_reveal fires live with q1-q6 labels): ALL THREE BUILT - (a) Module-2 checkpoint "Pressure-test
   your read" in 2.5 per spec 30.08 (6 details-reveals, per-question GA4
   labels, zero theme changes, validity-gated); (b) Founder OS pack page +
   printable PDF (founder-os-pack, wired from 5.7 + landing, no cert/share
   language; follow-up: needs a cover.png); (c) quiet localStorage visited
   checkmarks (course-visited.html partial, all 2-1-vote trust mitigations
   honored, verified in-browser: 1 visited lesson = exactly 1 quiet ✓, empty
   storage = byte-identical page). Full pair was 34/34 green on both platforms.
7. **Wave G - campaign execution** (NEARLY CLOSED 2026-07-31): brief audit
   found only 8 of 15 need posts (7 absorbed into course; 2 weak-fit
   deferred on GA4 demand) - all 15 stamps flipped with categories.
   ✅ Batch 1 LIVE (PR #419): contract-ownership, switch-dev-shops, retros -
   dual adversarial critics, 2 accuracy fixes (one also corrected the LIVE
   fire-dev-shop-guide Deloitte overstatement), covers incl. a chip that
   repeated the fixed legal absolute (re-rendered).
   ⏳ Batch 2 (sla-checklist, cheap-developers, admin-panel-spaceship):
   written + critic-fixed on `blog-waveg-batch2`; covers agent in flight;
   then publish gate -> draft:false -> ONE PR closes the wave.
   LinkedIn brief: DRAFTS ONLY for Paul (untouched).
8. ✅ **Wave H DECIDED + SHIPPING** (3-voter panel, 20.13): Option 3
   (off-course bridge) rides the Wave G posts now live; Option 2 locked
   behind all red-lines; no-backport rule standing.
9. **NEXT UP - Sprint V remainder + X/Y** (plan file + this board):
   (a) pilot-prep assets from kit 40.18 - Paul-voice outreach drafts +
   channel shortlist + Clarity review runbook (agent-doable; Paul only
   sends); (b) L3 landing restructure per the 40.21 punch-list (SHIP BEFORE
   2026-08-14 so its effect window aligns with the first metrics read - see
   50.01 week-0 baseline); (c) media normalization sprint (classify-first
   audit of off-spec SVG fonts, mobile text-size floor, founder-os-pack
   cover). Pilot recruitment (PAUL): 3-5 real Sams per 40.18.

10. **[W2] ✅ DONE 2026-08-01, merged as PR #431 (squash 82deeec7).**
    Groomed re-audit → T1-T5 scaffold fixes (parallel worktrees) → T6
    cross-file sweeps → T7 audit (9 fixes incl. the kit DPA-refund-half seam
    defect + canon deposit-row sync) → T8 4-persona cold-eyes panel + 25-item
    fix round + voice re-check. Panel: assessment spine / split routing / path
    integrity all PASS, zero pages more-AI-after. Scroll gate: desktop clean
    (25 pages); SVG "failures" proven non-defects (HTTP 200, lazy-load probe
    artifact). Known issue → W4 (item 13): 390px mobile table overflow on 2
    dense reference pages (fcto 4-col table; operating-kit pre-existing since
    W1) - fix is course-single responsive-table CSS, campaign-frozen. hire-track
    split shipped: new fractional-cto-sow-reference page. Two "20 years" →
    since-2011. 20%-slot for this boundary: O5(a) OS-scoped restore-on-green
    (shipped 9d45c8d1). GROOMED SCOPE (historical, executed):

    **[W2] Course v2-format consistency fix + deep audit — GROOMED
    2026-08-01 (re-audited against tree @3d732e23; research:
    `40-49-review/40.22-v2-format-structural-audit-2026-08-01.md`; wave plan:
    `20-29-strategy/20.15-course-improvement-wave-plan-2026-08.md`; runbook:
    `docs/workflows/course-audit-checklist.md`).**

    **Re-audit verdict (audit-premise rule, retro action item 2):** the 40.22
    lists are STILL ACCURATE and the tree grew two new findings.
    - Missing outcome line (6, unchanged): 2.5 mom-test-synthesis · 5.3
      network-list · 5.6 paid-pilot · 4.4 build-phases · 4.3 lovable-stack ·
      4.1 should-you-hire. **All six are TL;DR-block lessons** — the TL;DR
      migration dropped the line; that confirms miss-not-exception and makes
      C3 the fix vehicle.
    - Missing "Success check" (5, unchanged): 2.6 clickable-prototype · 2.3
      where-to-look · 2.4 what-to-say · 2.5 mom-test-synthesis · 1.3
      wire-tracking.
    - Double visual (2, unchanged): 5.2 channel-selection · 2.4 what-to-say.
    - **NEW:** 2.3 and 2.4 have ZERO "If this fails" blocks (scaffold needs
      >=1); 40.22 did not run that grep.
    - **NEW (C3 scope grows):** 16 lessons carry a TL;DR; the 10 that have
      the outcome line have it BELOW the TL;DR (1.3-position pattern). C3 =
      6 adds + 10 repositions, all 16 TL;DR lessons.
    - Closure slots, Input/Output/Progress, badges: 25/25 PASS — no scope.
    - Length flags re-verified byte-identical: hire-track 5,558w /
      stack-walkthrough 4,508w (flag-only, no cap).
    - **Struck as stale:** landing C1 hero line (shipped in W1 PR #428).
      NOTHING else from 40.23 shipped — verified in-tree: kit:168 "20 years"
      still present (l3-reviewer queued it, never landed) AND a second real
      instance at hire-track:194 ("20 years of rescue calls"); the Cagan "20
      years" in reference/hire-decision-full:69 is a distinct concept — do
      NOT "fix" it. 1.4 $0-path exists but trails the paid math (reposition
      only); C2 roster, 1.1 stranger read-aloud, fake-stripe "same 100
      visitors" (line 39) all still open. Phase-4 candidate for the sweep:
      5.6 TL;DR says "refundable Stripe deposit" unqualified — canon splits
      customer-cancel forfeit vs founder-cancel refund.

    **Decomposed tasks (one owner, one file-set, AC, gate = hugo-build +
    scroll gate on edited pages; content-only, no visual suite):**
    - **W2-T1 (M1+M2, 8 files):** 1.1 Success check → stranger read-aloud;
      1.3 add Success check; 1.4 $0-path co-equal at top of budget section;
      2.3 add Success check + >=1 "If this fails" + outcome above TL;DR
      reposition; 2.4 same + keep-or-merge call on funnel+mermaid double
      visual (document the call); 2.5 add outcome above TL;DR + Success
      check (build/pivot/kill 7+/4-6/<4 is the observable check) — Dana
      pressure-test block is NO-TOUCH, edits land outside it; 2.6 add
      Success check + reposition. AC: Phase-2 greps all pass on the 8 files;
      no other lines changed.
    - **W2-T2 (M4, 5 files):** 4.1/4.3/4.4 add outcome above TL;DR;
      4.2/4.5 reposition outcome above TL;DR. AC: Phase-2 greps pass.
    - **W2-T3 (M5, 7 files):** 5.3/5.6 add outcome above TL;DR;
      5.1/5.4/5.5/5.7 reposition; 5.2 reposition + keep-or-merge call on
      channel-decision + channel-fit-canvas double visual. AC: Phase-2
      greps pass. (5.1/5.6 opener shape-tells belong to T6, not here.)
    - **W2-T4 (2 files):** how-this-course-works C2 tool-roster trim +
      AI-callout demotion; fake-stripe "100 visitors" → 300-visit canon
      label. AC: canon table Phase-4 grep clean on both files.
    - **W2-T5 (2 files + split):** hire-track split/demote (5,558w →
      reference band or demote to non-reference) incl. its line-194 "20
      years" → since-2011 canon; kit:168 same fix. AC: word-count command
      shows every resulting page in band; `rg "20 years"` in course returns
      ONLY the Cagan line; sequence yaml + inbound links updated if split.
    - **W2-T6 (cross-file sweeps, ONE owner, runs AFTER T1-T5 merge):** C5
      adjacent-callout sweep; shape-tell opener/closer sweep (5.1 opener,
      5.6 time-cut, 5 Going-Further vignettes, 3 cloned template closers —
      opener/closer sentences ONLY); glosses for queues/SOC 2/GA4 at first
      mention. AC: one defect = one edit; banned-strings ratchet entries
      added for prose fixes.
    - **W2-T7 (audit, AFTER T6):** runbook Phases 3-6 full sweep on the
      CURRENT tree (incl. the 5.6 "refundable" canon candidate); Phase-8
      report format; surgical fixes only, escalate structure.
    - **W2-T8 (AFTER T7):** cold-eyes persona pass on EDITED chapters only —
      ICP-Sam, voice, slop, course-experience-reviewer (mandatory per
      runbook). Convergent (>=2 critics) = fix; divergent = judgment note.

    **Sequencing:** T1-T5 parallel (disjoint file sets, worktree isolation
    per `feedback-workflow-writers-need-worktrees`); T6 serializes after
    their merge (it crosses their files); T7 after T6 (audits of pages a
    fixer then rewrites certify nothing — W1 retro); T8 last.
    **BINDING no-touch list (C6, re-verified present):** Mia M1 walkthrough,
    2.5 Dana pressure-test ("Pressure-test your read", line ~110), the three
    decision forks, 1.4 exemplar structure, canon numbers, JT footer
    discipline.
    **20% capacity slot (this boundary):** devx O5(a) scoped restore-on-green
    — 3 one-line edits, spec ready in
    `docs/20-29-testing-qa/screenshot-testing/20.10-visual-suite-speed-research-reference.md`;
    cheapest fully-specced item and it de-risks every future visual-suite
    run (O6 ports is convenience; reader-mode is open-ended research).

11. **[W1 — ✅ DONE 2026-08-01, merged as PR #428 (squash f5455dec)] Landing
    L2 → L3 → L4 → L5.** L1 = PR #416; L2 3-critic panel → contract 40.24;
    L3 restructure executed + 4-eyes approved (kit card-grid rode along per
    C4); L4 visual overlay from Paul's shuffle demos (brief 40.25), cold
    re-critique **29/36 vs 25/36 baseline - beaten**; L5 density condense to
    demo 1 (spec + side-by-side verdicts in `40-49-review/40.26-*`,
    component spec `docs/design-system/course-landing-components-2026-08.md`;
    default-visible words -40%, page 10k→6.9k px). Honest dtest from main
    checkout: red ONLY on the expected set. Merge-gate panel: **3/3 SHIP,
    zero blockers** (verdict + evidence on PR #428). R3 pre-merge Clarity
    snapshot recorded on the PR: landing 45.08% avg scroll depth / 11.27s
    active / 13 sessions (2026-07-19→08-01) - the BEFORE number; GA4 leg
    documented-not-reached. Post-merge CI `update-baselines` dispatched for
    the linux landing pair (run 30703840581).
    **W1 carry-over nits (non-blocking, fold into W3/W4 visual waves):**
    (a) inline ruby link density mid-page - demote some to gray/hover-ruby;
    (b) ruby uppercase eyebrows on every section - candidate: gray, ruby
    reserved for hero+CTAs; (c) hero fold visual weight vs demo poster hero
    (deferred with section-band rhythm + 6.9k→5.1k height gap); (d) watch
    GA4: hero Quickstart button siphoning primary Start clicks → demote to
    text link; (e) printable-pack link in module-map intro = mid-funnel
    exit candidate; (f) `.course-hero-note` (9 lines) landed in style.css
    alongside the sanctioned `.kit-grid` - same risk profile, logged against
    the same l3-reviewer exception; (g) 40.26 review JPEGs ~1.1MB - pruning
    candidate.

12. **[W3] ✅ DONE 2026-08-01, merged PR #433 (squash 8a5f5643).** Module-1
    visual pilot shipped: T1 wrote the v3 exhibit spec (grid/scale/measured
    ≥9px floor formula/O1-O2 rubric); A/B exemplar → **Paul chose O2 flat-
    vector** (recorded ADR 30.09); T5 redrew all 5 M1 SVGs to O2 - one
    consistent template, fixing the 4-of-5 mobile-floor failures (signal SVG
    5.7px→9.21px); T3 shipped program-map v1 (replaced the old 5.5px-phone
    landscape diagram + removed the orphan); Sprint-Y audit (40.31). Honest
    dtest clean (SVGs img-masked → no course baseline moved, no CI record).
    20%-slot deferred to the W4 boundary (O8 worktree node_modules, the
    friction that hit every W3 worker, is the frontrunner). **Deferred per
    ADR:** M2-M5 ~76 SVGs roll to O2 in a later wave after this M1 pilot.
    _Groomed scope (historical, executed):_ Visual V3-A (wave plan 20.15; ADR 30.09). GROOMED 2026-08-01,
    re-audited @cdcccd51. Content-scoped (SVGs + one .okf spec doc) =
    campaign-safe, NO shared CSS. Agents on Opus/Sonnet (Fable quota out,
    W1.6 retro).
    **M1 visual inventory (verified — all 5 still OLD hand-drawn grammar,
    none redesigned; W1/W2/W1.6 touched only landing + prose/tables, not
    these; W2's 2.4 mermaid is Module 2, out of scope):** 1.1
    `form-your-founding-hypothesis-90-minute-sprint/hypothesis-mad-libs.svg`,
    1.2 `smoke-test-build-page/page-anatomy.svg`, 1.3
    `smoke-test-wire-tracking/tracking-snippets.svg`, 1.4
    `smoke-test-landing-page-7-day-demand-test/smoke-test-signal.svg`, 1.5
    `price-hypothesis-on-smoke-test-page/stripe-payment-link.svg`. The
    board's "4" = the 4 that go straight to the chosen style; a 5th is the
    A/B exemplar rendered BOTH ways. All 5 land in the end.
    **EXHIBIT SPEC VERDICT: must be WRITTEN, not assumed done.**
    `.okf/design/house-visual-spec.md` (48 lines) is still the OLD hand-drawn
    spec (Caveat/Comic-Sans, paper tones, 2-2.5px) — it has NONE of the 6
    ADR-demanded v3 components (grid/column, spacing scale, connector spec,
    data-viz rules, aspect-ratio, 5-rung type scale + ≥9px@390px floor).
    Writing it is T1 and blocks the exemplar + redesigns.

    **Decomposed, style-call-gated (owner / files / AC / gate):**
    - **T1 Write v3 exhibit spec** (agent: content/design; files: append v3
      section to `.okf/design/house-visual-spec.md` — do NOT delete the
      hand-drawn spec, O1 still needs it). AC: all 6 components + 5-rung type
      scale + measured ≥9px@390px floor + grammar (action title / one
      message / basis line), covering BOTH O1-normalized and O2-flat so the
      A/B has a rubric. Gate: `/okf:validate .okf --strict` + hugo-build.
      **Blocks T2, T5.** Parallelizable-after: none (root).
    - **T2 A/B exemplar pair** (agent: SVG; pick ONE M1 exhibit — recommend
      1.4 `smoke-test-signal.svg`, a data-signal read that best exercises the
      O2 data-viz rules where flat-vector most diverges from hand-drawn).
      Render it BOTH ways (O1 hand-drawn-normalized + O2 flat-vector), both
      carrying the new grammar+floor, into a comparison doc under
      `40-49-review/` — NOT committed into the lesson. Gate: both variants
      pass grammar checklist + measured floor; reference side-by-side at
      equal zoom (W1 retro BLOCKING gate). Gated on T1.
    - **T3 Program map v1** (Phase C, agent: SVG; new file into
      `how-this-course-works/`, versioned "v1.0 — July 2026"). Judged
      INDEPENDENTLY of the style call — does not gate and is not gated by it;
      iterate regardless of O1/O2 outcome. Gate: hugo-build + scroll gate +
      4-criteria new-media score. Parallel to T2 once T1 exists.
    - **T4 Eye-test doc + hand to Paul** (agent: coordinator): assemble the
      A/B pair (T2) + 3 before/after screenshot pairs → doc for Paul; record
      the ask in the ADR. Gated on T2.
    - **Sprint-Y classify-first audit** (agent: SVG/audit): identify any
      intentional-mono / hand-drawn-on-purpose M1 elements BEFORE conversion.
      Outcome-independent (runs in EITHER O1/O2 result) → **can run pre-call**
      as prep, parallel to T2/T3. Output: a keep-as-is list feeding T5.

    ⛔ **BLOCKING GATE — PAUL'S STYLE CALL** (O2 rollout / O1 normalization /
    mix), recorded in ADR 30.09 within 3 days of the eye-test doc. Nothing
    below starts until it lands.

    - **T5 Redesign the remaining M1 SVGs in the CHOSEN style** (agent: SVG;
      the 4 non-exemplar lessons + finalize the exemplar lesson's committed
      SVG so all 5 carry the winning style). Same filenames, in-place,
      **alt text rewritten to the new exhibit's message = body edit = FULL
      visual gate, no content-only skip.** Honor the Sprint-Y keep-as-is
      list. Gate PER FILE: `bin/qtest --changed` + scroll gate
      (evidence-per-claim: HTTP status for asset checks, named element +
      control measurement for overflow — W2 retro) + 4-criteria new-media
      score written into the commit; `bin/test`+`bin/dtest` pair at PR prep.

    **Autonomous-before-Paul (start now, WIP-respecting):** T1 → then T2 ‖ T3
    ‖ Sprint-Y audit → T4 → HOLD. **Waits for the call:** T5 only.
    **Parallelizable:** T2, T3, Sprint-Y audit (disjoint files, worktree
    isolation per `feedback-workflow-writers-need-worktrees`). **Sequential:**
    T1 before all; T4 after T2; T5 after the call.
    **One PR for the wave** (spec + exemplar doc + program map + T5 redesigns
    + ADR verdict ride the same branch). Skills: `/impeccable` +
    stitch-design taste + ux-principles (stitch-loop only for variant
    exploration); `/okf:okf maintain` every commit; `/ponytail:ponytail
    ultra` posture. Verification checklist = ADR 30.09 "Verification".
    **20% capacity slot (this boundary): devx O5(b) worktree-compose
    isolation** — W3 runs the most parallel-worktree agents of any wave (T1
    spec, T2 exemplar, T3 map, Sprint-Y audit concurrently) and W2's retro
    already flagged worktree merge races (.okf/log.md union); per-worktree
    compose isolation removes that class of race for this wave's own
    execution. (Confirm O5(b) is specced enough at dispatch; if not, fall
    back to O7 validator-net gap, which also bites hardest on a visual wave.)

13. **[W4, post-Aug-14] V3-B wiring + media P1** (wave plan 20.15): new
    course-single.css + single.html; walkthrough visual hooks, 1.2/1.3/1.5
    mid-body visuals, 5.7 mermaid horizontal, TL;DR accent. Full visual pair
    at PR prep. **W2 INPUT (2026-08-01): responsive-table treatment** - add
    `overflow-x:auto` scroll containers to course tables in course-single
    CSS. W2 scroll gate found 390px mobile overflow on dense reference pages
    (fractional-cto-sow-reference's 4-col Week/ships/ships/why-parallel table
    25px; first-paying-customer-operating-kit 51px, pre-existing since W1
    #428). Desktop clean; fix is shared CSS = frozen until this wave. The
    course-wide fix here clears both + any sibling reference tables at once. THEN **[W5] completion mechanics + content strategy** (wave
    plan 20.15): path-finder audit vs course_sequence.yaml, strengthen forks
    2.5/4.1/5.6, compress the over-length Going Further set, verify Success
    checks are observable-behavior measurable. Progress tracker stays GATED
    on Paul's 30-min Clarity check. **40.23 centerpiece (Paul APPROVED 2026-08-01):** long-wait bridges at the 3 calendar-forced pauses
    (M2 interview booking 2-4wks, 1.4 seven-day run, Stripe verification) -
    one parallel micro-action + explicit "come back when X" re-entry trigger
    each; pedagogy persona named this the single highest-leverage completion
    change. Investor-framing DECIDED (Paul 2026-08-01): the Founder OS pack
    KEEPS its investor-showable framing; scattered lesson-body "if you ever
    raise" asides may be softened during W2/W5 passes only where they read
    off-ICP, under surgical-edit rules.

---

### W5 ✅ DONE 2026-08-02, merged PR #435 (squash a35d6632)
T1 long-wait bridges (3-persona cold-eyes caught a Stripe-trigger correctness
bug + 2 banned patterns + a path-honesty gap, all fixed) · T2 path-finder fix
(2.1→2.3 core route) + `bin/check-course-paths` gate (O7c) · T3 fork routing
(4.1/5.6 diagnose→route, fork bodies untouched) · T4 Going Further compression
(2 hard-over pages under band, reviewer SHIP, cuts removed 3 voice tells).
Progress-completion tracker stays Clarity-gated (parked, Paul's desk).
Content-only, honest dtest 34/34. **This closes wave plan 20.15's final
planned wave.**

### W5 GROOMED SCOPE (historical, executed; re-audited 2026-08-02 @ current tree)

**Gate class: CONTENT-ONLY** (markdown prose/frontmatter, no `themes/`/`layouts/`/`*.css`/body-HTML). Per CLAUDE.md content-only rule: gate = `bin/hugo-build` (validators + banned-string ratchet) + rendered **scroll gate** on edited pages + **cold-eyes personas** (3-4) for voice-sensitive prose. NO `bin/qtest`/`bin/test`/`bin/dtest`. All editors bound by 40.23 **C6 no-touch list**: Mia M1 walkthrough, 2.5 Dana transcript, the 3 decision-fork *bodies* incl. 4.1 mermaid, 1.4 as v2 exemplar, canon numbers, 90/10 footer.

**RUNNABLE-NOW vs PAUL-GATED split:** items 1-4 below are content-safe and run now. Item 6 (visible progress tracker) stays **PAUL-GATED** on the 30-min Clarity check — do NOT build. Note: a passive `course-visited.html` localStorage layer already exists (records visited paths); the gated piece is the *visible completion UI* only. Confirmed parked.

**Current-state numbers (audit-premise re-run, not memory):**

- **Item 1 — Path-finder audit: 24/25 in-body `Next:` match yaml. ONE live drift.** `2.1 mom-test-ask-about-past` in-body `> **Next:**` funnels solely to `2.2` (the AI-persona rehearsal), but its own `course_sequence.yaml` branch marks **2.3 as "Core path →"** and 2.2 as "Optional rehearsal → (skip if…)". Same funnel-through-optional anti-pattern the 40.17 P1 fix cleared for 5.1/2.4 — 2.1 got the yaml branch but its prose Next was never updated. All other 24 Next pointers + the 4 branched forks (2.1/2.4/2.5/5.1) render correctly. The auto prev/next strip is yaml-derived (matches by construction); only the editorial in-body Next drifted.
- **Item 2 — 3 decision forks: 2.5 is a full fork; 4.1 and 5.6 are NOT.** `2.5 build/pivot/kill` has explicit yaml branches + in-body routing (strong — and C6-protected). `4.1 should-you-hire` and `5.6 paid-pilot` have **no branch entries in yaml** and linear in-body Next → the "hire/self-serve" and "persevere/pivot" decisions live in body prose but never route the reader. Strengthen = add the **diagnose→route layer** (yaml branch + branch-aware in-body Next), NOT touch the protected fork bodies (4.1 mermaid is C6 no-touch). Scope the fork work to the routing/Next: layer only.
- **Item 3 — Long-wait bridges (CENTERPIECE, Paul APPROVED): all 3 pauses real, NONE has the full pattern.** `1.5 Stripe verification` has the closest — a "start verification tonight, 1-3 business days" nudge + an "If this fails >3 days" block, but no parallel micro-action + "come back when verified" re-entry. `1.4 seven-day ad run` (5-7 days to 300 visits) has NO bridge. `M2 interview booking` (2.4 → 2.5, "takes days not one sitting") has NO parallel-action + re-entry. Confirms the centerpiece is unbuilt & highest-value. Design **one** bridge pattern (parallel micro-action + "come back when X" trigger), apply at 3 points.
- **Item 4 — Over-length Going Further set (re-measured, Phase-1 basis):** `pivot-or-persevere` **3,206w**, `validation-tools-field-guide` **3,150w**, `customers-leaving-churn-triage` **2,870w**, `five-tech-words` (glossary) **2,733w**, `how-this-course-works` **2,751w** (GREW +93 vs the 2,658 on the board). Only the first two exceed even the generous 2,900 reference ceiling; the other three are soft-over per 30.03. Also surfaced but out-of-named-scope: `self-serve-stack-walkthrough` 4,508w (a walkthrough — no band, "long not auto-defect"), `hire-track-supplementary-reference` 2,921w, `fractional-cto-sow-reference` 2,875w. Compress the named 5; treat the 3 extras as a flag, not this wave's job.
- **Item 5 — Success checks: 25/25 lessons measurable. Essentially DONE (W2 did it).** 24 carry a labeled "Success check" with observable thresholds (counts/scores/written artifacts); `self-serve-mvp-stack-build-phases` uses "5 green lights" + a `> **Done:**` closure (Stripe live-mode, domain wired, 1 user tested, zero console errors, demo exists) — measurable, just a different label. Only residual = a naming-normalization judgment call touching an exemplar; **low value, recommend note-only, do not touch.**

**Decomposed tasks (agent-sized, sequenced; WIP=1 per continuous-execution mandate):**

| # | Task | Files | Voice-sensitive? | AC |
|---|---|---|---|---|
| **W5-T1** | **Long-wait bridges (centerpiece).** Design ONE reusable bridge block (parallel micro-action + explicit "come back when X" re-entry), apply at 3 pauses. Write for Sam (plain, observable), not Paul-shorthand. | `smoke-test-landing-page-7-day-demand-test` (1.4), `price-hypothesis-on-smoke-test-page` (1.5), `find-10-people-with-problem-outreach-2026` (2.4, M2 booking) | **YES** — 3-4 persona cold-eyes + slop≤25 + shape-tell + ICP-reader readback | one bridge at each pause; re-entry trigger names a concrete resume condition; 1.5's existing nudge folded in, not duplicated; hugo-build + scroll gate green |
| **W5-T2** | **Path-finder fix.** Rewrite 2.1 in-body `> **Next:**` to lead with the yaml core path (2.3) and mark 2.2 skippable, mirroring 2.4/5.1's branch-aware Next. | `mom-test-ask-about-past-not-future` (2.1) | Low (routing prose) | in-body Next matches yaml branch (2.3 core, 2.2 optional-skip); hugo-build green |
| **W5-T3** | **Strengthen forks 4.1 + 5.6 as diagnose→route.** Add yaml `branches:` for 4.1 (self-serve→4.3 / fractional→hire-track ref / hired→4.2) and 5.6 (converts→5.7/going-further / stalls→pivot-or-persevere), and branch-aware in-body Next. Do NOT edit the fork bodies (4.1 mermaid C6-protected). | `data/course_sequence.yaml`, `should-you-hire-2026-decision-tree` (4.1), `paid-pilot-charge-before-ship` (5.6) | Low-med (routing only) | both forks route by outcome in yaml + in-body; fork bodies untouched; hugo-build green |
| **W5-T4** | **Compress the 5 over-length Going Further pages** toward 30.03 bands (hard targets: pivot-or-persevere 3,206→≤2,600, validation-tools 3,150→≤2,600; soft: churn 2,870, glossary 2,733, how-this-works 2,751 → trim to ≤2,400). Condense, don't re-theme; surgical. | `pivot-or-persevere-decision-framework`, `validation-tools-field-guide`, `customers-leaving-churn-triage-not-acquisition`, `five-tech-words-stop-nodding-at`, `how-this-course-works` | **YES** — cold-eyes + shape-tell + ICP readback per page | each page under target on Phase-1 recount; no dropped canon numbers; hugo-build + scroll gate green |

**Sequencing (recommend, run FIRST → last):** **W5-T1 (bridges) FIRST** — confirmed, not revised: it is the Paul-approved centerpiece, design-once-apply-thrice, and the highest-leverage completion change per the pedagogy lens; proving the bridge pattern on 3 pages before the bulk work de-risks it. Then **W5-T2** (cheap mechanical drift fix) → **W5-T3** (fork routing) → **W5-T4** (compression — largest, most voice-sensitive, run last; pages are non-overlapping so it *could* fan out, but WIP=1 sequential per the mandate + workflow-writers-need-worktrees if parallelized). Item 5 = note-only. Item 6 = parked.

**20%-slot pick — path-integrity validator (O7c), NOT O5(b)/literal-O7.** Justification: (a) **literal O7 is already closed** — its build-time SVG-floor check shipped as `bin/check-svg-floor` (O7b), so "O7 validator-net gap" as written is stale (audit-premise). (b) **O5(b) worktree-compose is unspecced** (only a research reference in 20.10) and W5 is content-only WIP=1 — shared-checkout race payoff is low this wave; per the board's own fallback rule, fall back. (c) **item-18 (46 SVGs under-floor, confirmed)** is real and campaign-safe but it's a *visual* wave needing the full suite — folding it into content-only W5 mixes two gate regimes; better run as its own interleaved wave. So the leverage pick is a NEW validator in the O7 family: a build-time check that every lesson's in-body `> **Next:**` link resolves AND branched lessons name their yaml core branch — turning W5-T2's one-time audit into a permanent gate. This is the same "fix the gate, not the instance" win the M2-M5 retro celebrated with check-svg-floor, and it directly prevents the 2.1-style drift this audit just found from recurring. Small: one grep-based validator added to the `bin/hugo-build` validator set. Runs alongside W5-T2.

---

**W1.5 ✅ DONE 2026-08-01, merged as PR #429 (squash c9da2ea9):** landing
layout converged on demo 1 - full-bleed tinted hero band + two-col grid +
obsidian course-window card (chrome dots, "Idea to First Paying Customer"),
1080px centered container aligning all sections with the hero, section-band
rhythm (#FAFAFA module-map band, endcap island), gray eyebrow economy.
Honest dtest: expected-set-only reds (first attempt OOM-killed exit 137,
discarded; full re-run clean). CI update-baselines dispatched (run
30709991666). **Paul's post-ship verdict (2026-08-01): layout + section
background colors GOOD; flagged "maybe too many expand-to-read-more
components" - expander-density reduction (e.g. Module 1 lessons open by
default, drop the NOT-cover "why" expander) is a TOP candidate for the next
grooming pass.**

**CAPACITY RULE (Paul 2026-08-01, standing): 80% feature delivery / 20%
self-improvement + tech-debt.** The 20% slot is drawn at wave boundaries
(retro → grooming picks ONE debt/improvement item per boundary: devx O5/O6,
reader-mode item 14, skill/process tuning); debt work never preempts a wave
in flight.

**DESIGN-CALL METHOD (Paul 2026-08-01, standing):** (1) **Modern is the
standing style preference** - flat-vector / clean-infographic / premium-
editorial over hand-drawn/old-time (confirmed by the W3 O2 pick). (2)
**Future style/taste calls: run a VOTING PANEL and DECIDE autonomously** -
the autonomy grant now extends to taste/design, don't reflex-hold for Paul
(W3 held because it was the first; next time panel → call, record it, Paul
overrides if he disagrees). (3) **Ground design calls in evidence:** the
competitor set Paul curated - `10-19-research/10.04-competitor-courses-2026-
forum-validated.md` (+ `10.05-content-organization-patterns-2026.md`,
`10.06-media-design-recommendations.md`) - AND fresh online research of how
top modern courses/blogs (Product Compass, Lenny's, Reforge, Stripe/Linear-
class sites) actually do it. A design panel brief cites the competitor doc +
one online scan before scoring.

**QUEUE-AND-SEQUENCE (Paul 2026-08-01, standing):** Paul's incoming requests
are QUEUE INPUTS, not run-now orders - the manager decides sequencing AND
timing against critical level + the active plan (triage verdict recorded per
request). Paul steers by adding to the queue and by the taste gate at PR;
he does not micromanage when each runs.

**CONTINUOUS-EXECUTION MANDATE (Paul 2026-08-01, standing):** after W1.5
(landing demo-1 layout fix - now DONE, see above), the
manager runs ALL remaining waves end-to-end autonomously - W2 → W3 → W4 → W5
per items 10-13 - without waiting for per-wave go-aheads. Between waves:
run `/sprint-retrospective` (fallback: inline XP retro - what worked / what
failed / what changes) and REVISE the next wave's scope from what the retro
surfaces before dispatching it. Big/critical calls inside waves follow the
CLAUDE.md voting-panel protocol; Paul's explicit words always override.
Inter-wave sequence is fixed (XP practice, Paul 2026-08-01): retro FIRST,
then a GROOMING pass on the next wave BEFORE dispatch - re-read the wave's
board item + its source research, apply the retro's lessons, decompose into
concrete agent-sized tasks with acceptance criteria, drop/resize anything
the previous wave made stale or already covered, and update the board item
with the groomed scope (audit-premise rule: groomed items decay - verify
the artifact, not the memory of it). Dispatch only from the groomed scope.
**Skill enforcement (Paul 2026-08-01):** at every phase boundary, check the
loaded skills list (global + project) and route through the matching skill
instead of default behavior; agent prompts NAME the skills they must invoke.
The whole wave cycle runs under `/xp-practices` as the umbrella discipline -
small releases (one PR per wave), tests green before merge, sustainable
pace (WIP=1 waves), 4-eyes on every change, retro-driven adaptation.
Flow map (extend when new skills land): retro → `/sprint-retrospective`
(xp-practices family); wave planning → `/agile-sprint-planning` or
`/agile-product-owner`; grooming/breakdown → `/user-story-splitting` or
`/epic-breakdown-advisor` (+ `/user-story-mapping` when the wave touches a
user journey, e.g. W5 path-finding) + `superpowers:brainstorming` when scope
is open-ended; multi-agent wave coordination → `/agile-coordinator`; visual/UI work (W1.5,
W3, W4) → `/impeccable` + stitch-design taste (+ stitch-loop only for
variant exploration) + ux-principles; content audit/fixes (W2, W5) → the
course-audit-checklist runbook + content cold-eyes personas +
course-experience-reviewer agent + learn-with-coursera lens (W5 pathfinding
especially); board updates → kanban-markdown conventions; md search → qmd
first; every commit → `/okf:okf maintain`; coding posture everywhere →
`/ponytail:ponytail ultra`. A wave dispatched without its flow's skills
named in the agent brief is a process defect - catch it at grooming.
Standing gates unchanged: W4 stays post-Aug-14 (campaign window), W3 contains
PAUL'S STYLE CALL as a blocking decision point inside the wave, progress
tracker stays gated on the Clarity check. Goal = wave plan 20.15 executed
in full; the mandate ends when W5 closes or Paul redirects. Cold-session
rule: any fresh session picks up at the first non-DONE wave with this
mandate in force.

15. **[✅ DONE 2026-08-01, merged PR #432 (squash 2fd99e16), Paul "ship it"]
    Landing W1.6:** converged on the new shuffle reference - expanders 7→0
    (the named complaint, resolved), on-page text 1642→1302w (-21%), module
    map flattened to scannable rows, NOT-cover → 2x2 scope cards, mistakes
    grid bold titles; hero/section-rhythm kept from W1.5. New reference +
    result committed (40.28 / 40.29). Honest dtest clean (7 known emulation
    diffs only). CI baseline record dispatched (run 30716133805). **Accepted
    tradeoff (Paul shipped over the flag): all 25 chapters visible inline
    keeps the page ~2x the reference height; module-map compaction to
    summaries+counts is a documented available lever if "too long" recurs -
    NOT a defect, a taste option.**
    _Original scope (executed):_ closer to the new shuffle reference + less
    text / better components
    (Paul 2026-08-01). New target reference (supersedes demo 1 as the layout
    north star for this pass): `https://shuffle.dev/preview/b1a3fc8570aef0386cda8dbad53f3abc297a3d96?page=index.html&screen=top&iframe=1`
    (capture the full inner page - strip `&iframe=1` from the URL - and
    commit it as `40-49-review/40.28-reference-shuffle2-full.jpeg` first).
    Goal: push the live landing MUCH closer to that reference AND cut on-page
    text / reorganize into better components (this SUPERSEDES and completes
    the W1.5 carry-over "too many expand-to-read-more" nit + the design
    voter's link-density/eyebrow-economy nits). Approach: extract the new
    reference's components (impeccable, live-DOM, into the design-system doc),
    diff against our current landing, then a layout+content-density pass -
    landing-owned files ONLY (layouts/course/list.html + course-list.css +
    _index.md), no shared CSS/JS (campaign window). BLOCKING gate from the
    W1 retro: full-page reference side-by-side at equal zoom before ship +
    Paul's eyeball at PR (taste gate). Skills: /impeccable + stitch-design +
    ux-principles; stitch-loop only if a structural variant is needed.
    Runs as its own PR after W2 merges (WIP=1). NOTE: reducing text may mean
    MOVING content off the landing (to lessons/kit/FAQ) not deleting it -
    the landing attracts + drives the Start-Lesson click; depth lives one
    click away.
    **TRIAGE (Paul 2026-08-01): W1.6 runs NEXT, ahead of W3** - Paul scheduled
    it "after W2", it's the live-campaign (Aug 1-14) acquisition surface, and
    it answers direct customer-facing feedback; that outranks W3's campaign-
    safe course-exhibit work by critical level. W3/W4/W5 shift one slot back.

16. **[UNFROZEN 2026-08-02 by Paul - RUNS NEXT WAVE, no Aug-14 wait] Landing
    full-migration to the shuffle2 reference** (Paul 2026-08-01, triaged
    backlog by impact/effort). W1.6 (PR #432) closed the expander/text
    complaint but the result (40.29) is still ~2x the reference (40.28)
    height. Full match is a bigger restructure that needs campaign-frozen
    changes, so it waits for the post-Aug-14 window (with W4). WHY not now:
    (a) section restructure + a template edit (gradient H1) are frozen in
    the Aug 1-14 campaign window; (b) the landing is already goal-serving
    for the campaign - full pixel-match is polish, and the Aug-14 metrics
    read tells us whether landing changes move conversion before investing.
    **Gap punch-list (40.28 ref vs 40.29 result):** (1) omit/RELOCATE "Take
    this course if" + "Who built this" off the landing (to how-this-course-
    works / FAQ) - the single biggest height cut; (2) module map → compact
    module summaries + chapter counts (chapters via lesson links), not all
    25 inline (the lever from item 15); (3) gradient second-line H1 word -
    needs layouts/course/list.html to own the title line-break (TEMPLATE,
    post-Aug-14 safe); (4) mistakes grid 2-col → 3-col (needs the container/
    reading-measure widened); (5) hero card labeled stat cells vs our meta
    line; (6) NOT-cover dark band (requires a dark-zone-budget rebalance).
    Skills: /impeccable + stitch-design + ux-principles; reference side-by-
    side + Paul taste gate (W1 retro rule). Landing-owned files + (post-
    Aug-14) the title-render template only.

    _Groomed scope — GROOMED 2026-08-02, re-audited @662744c3 against live
    `_index.md` + `list.html` + `course-list.css` (NOT the 40.29 JPEG alone).
    Paul's design-call method governs (modern/flat-vector; panel-decide;
    Paul taste gate at the PR render)._

    **All 6 punch-list gaps STAND (verified in source):**
    1. RELOCATE — `_index.md:46-62` still carries `## Take this course if`
       (5 bullets) + `## Who built this` (2 paras); reference (40.28) has
       neither. **Also off-reference:** `## Going further` (`:249`) +
       `## Already started building?` (`:253`). Biggest height cut. Targets
       exist: `how-this-course-works/index.md`, `faq/index.md`. Anchor care:
       `#already-started-building` is cross-linked from `:56`; `#module-map`
       from `:44`/`:74` — relocation MUST fix these + any inbound links.
    2. MODULE COMPACTION — live renders all 5 modules × 25 chapters as flat
       wide cards (W1.6 R2.2, already inline — chapters are NOT the bloat).
       Reference is denser per-card: trim the `module-card__mia` "See it in
       action" line + long deliverable glossaries, tighten padding. Overlaps
       item-15 lever. CSS + light `_index.md` trim.
    3. GRADIENT H1 — `list.html:34` renders `<h1>{{ .Title }}</h1>` plain.
       The ONE template edit (unblocked). Split title so line 2 "Paying
       Customer" gets a ruby→purple gradient span (spec §3 token-map);
       frontmatter title untouched, one semantic `<h1>`.
    4. MISTAKES 3-COL — `course-list.css:79` = `repeat(2,...)`. 6 `<li>`
       (5 + dark CTA) → clean 3×2. Grid already spans the 1080px middle
       track, so width fits. CHEAP CSS.
    5. HERO STAT CELLS — `list.html:76-81` card body = eyebrow+title+meta
       line+leave. Reference card has labeled stat cells (Methodology /
       No-Code MVP · Validation Pace / 2-3 Weeks). Template markup + CSS.
       **Copy needs Paul's taste gate** (spec §4: variant card copy is
       Paul-approval-gated).
    6. NOT-COVER DARK — `course-list.css:299-302` is deliberately LIGHT with
       a documented 3-dark-zone budget (hero card + mistake CTA + endcap).
       Reference is DARK **and has NO dark endcap island** (ends NOT-cover →
       footer). True swap = trade the dark endcap for a dark NOT-cover, so
       the calm 3-zone budget holds. DESIGN DECISION for the panel.
    + SECTION REORDER: reference = Hero → mistakes → modules → NOT-cover;
      current = Hero → mistakes → NOT-cover → modules (module-map + NOT-cover
      are swapped). Panel call; moves an HTML block if adopted.

    **Decomposed tasks (ONE sprint branch → ONE PR, per feature-branch rule):**
    - **T1 · Content relocation** (Track A, content-care). Files: `_index.md`
      (cut Take-if/Who-built + Going-further/Already-building), `how-this-
      course-works/index.md` &/or `faq/index.md` (absorb), fix anchors. AC:
      landing section set matches reference; no orphan anchors; no fact lost.
      Gate: content-only → `bin/hugo-build` + scroll gate (per content-only
      exemption) — pure prose cut, no HTML touched.
    - **T2 · Gradient H1** (the ONE template edit). `list.html` + `course-
      list.css`. Gate: qtest (hero-fold test) + side-by-side + Paul taste.
    - **T3 · Mistakes 3-col.** `course-list.css` only. Gate: qtest + side-by-side.
    - **T4 · Hero stat cells.** `list.html` + `course-list.css`; Paul copy
      approval. Gate: qtest + side-by-side + Paul taste/copy.
    - **T5 · NOT-cover dark + dark-zone rebalance.** `course-list.css` only;
      executes the panel's budget ruling. Gate: qtest + side-by-side + Paul taste.
    - **T6 · Module compaction.** `course-list.css` + light `_index.md` trim.
      Gate: qtest + side-by-side.
    - (Section reorder, if panel adopts, rides T1's branch as a follow-commit
      with the FULL visual gate — it moves the module-map HTML block.)

    **Sequencing:** PANEL first (pre-execution) → **T1 FIRST** (biggest cut,
    cheapest gate, settles the section set the restyle targets) → restyle
    bundle T2·T3·T4·T5·T6 on the same branch, qtest per commit, FULL
    `bin/test`+`bin/dtest` at PR prep (both macos/ + linux/ baselines) →
    ONE PR with reference side-by-side @ equal zoom → Paul taste gate.

    **Panel = YES, run it BEFORE execution** (this is Paul's acquisition
    surface + two real design forks: the dark-zone rebalance #6 and the
    compaction depth #2 / whether to also cut Going-further+Already-building).
    2-4 lenses scoring the proposed restructure vs 40.28 + competitors
    (10.04/10.05): conversion/acquisition · visual-taste (/impeccable) ·
    UX/cognitive-load · reference-fidelity. Decide autonomously (Paul
    autonomy grant); Paul's taste gate at the PR render is final.

    **20%-slot:** `bin/check-landing-parity` (report-only) — assert the
    rendered landing's H2/section count ≤ a reference budget so the 2×-height
    drift this item fixes can't silently regress. Matches the proven "fix the
    gate, not the instance" pattern (check-svg-floor O7b / check-course-paths
    O7c); flip to blocking once green. (Defer to O6 if that's the committed slot.)

    **Campaign-safety:** Paul UNFROZE 2026-08-02, so the `list.html` template
    edit (gradient H1, stat cells) is now in scope. ALL CSS stays in the
    landing-owned `course-list.css` (loaded only via `list.html`, already
    `.course-landing`-scoped) — NO shared blog CSS, NO `style.css`, NO shared
    partials. Content stays in `_index.md` + the two relocation targets.

17. **[✅ DONE 2026-08-02, merged PR #434 (squash 133f8f4d)] M2-M5 SVG→O2
    rollout.** All 17 M2-M5 numbered-lesson SVGs → O2 flat-vector (3 sub-waves
    M2 / M3+M4 / M5); every one now clears the ≥9px@390 mobile floor (was
    4.5-8px). Bonus: redraws removed 2 fabricated-cohort stats (5.3, 5.6).
    20%-slot shipped: `bin/check-svg-floor` (O7b) build-time legibility gate
    (report-only; confirms the 17+6 pass, enumerates 46 deferred). Honest
    dtest 34/34 green. **→ item 18: deferred 46-SVG follow-on wave.**
    _Groomed scope (historical, executed):_ M2-M5 SVG→O2 rollout — GROOMED
    2026-08-01, re-audited @45ecea48 (Paul's design-call method:
    modern/flat-vector; ADR 30.09 gate "follow the M1 pilot" SATISFIED by W3
    #433). Extend the O2 flat-vector system (spec
    `.okf/design/house-visual-spec.md` v3 section; template = the 5 shipped M1
    lesson SVGs, all FLAT/PASS) to the M2-M5 numbered lessons.

    **Re-audit findings (floor = min font-size ≥ 9·viewBoxW/390, i.e. ≥9px@390):**
    - Course carries **80 SVGs total.** Grammar split: **7 FLAT** (O2), **73
      HAND-drawn** (Caveat/Patrick-Hand cursive). Floor: **6 PASS, 74 FAIL.**
      The 6 PASS are all FLAT (5 M1 lessons + `how-this-course-works/program-map`).
      **Every hand-drawn SVG fails the floor** (min font 10-18 vs required 21-24
      on their 900-1000 viewBoxes). One FLAT-but-FAIL outlier: an email mock in
      `reference/ownership-full/bad-vs-good-email.svg`.
    - **Hypothesis CONFIRMED and broader than stated:** the defect is not "M2-M5"
      — it is the *entire* hand-drawn corpus. 74/80 fail. But the "~76" figure in
      the old scope conflated the whole-course backlog with the M2-M5 lesson spine.

    **Right-sizing — "~76" REFUTED. True M2-M5 numbered-lesson scope = 17 SVGs**
    (all HAND, all FAIL). The other ~57 are reference/continuation/global pages,
    a separate wave — do NOT smuggle them in:
    - **Tier A · M2-M5 lessons (THE WAVE) = 17 SVGs, 17/17 fail:**
      - M2 (5): `mom-test-ask-about-past-not-future/mom-test-script`,
        `ai-persona-pre-validation-mom-test-prep/rehearsal-loop`,
        `find-10-people-where-to-look/find10-journey`,
        `find-10-people-with-problem-outreach-2026/outreach-funnel-strip`,
        `clickable-prototype-validation-2-hour-lovable/prototype-build-strip`.
        (2.5 `mom-test-synthesis-build-pivot-kill` = mermaid, no SVG.)
      - M3 (2): `one-page-product-brief-vibe-prd/vibe-prd-template-visual`,
        `stop-specifying-features-start-outcomes/admin-panel-spaceship`.
      - M4 (3): `github-aws-database-ownership-checklist/ownership-audit-flow`,
        `self-serve-mvp-stack-lovable-supabase-stripe-2026/stack-boundaries`,
        `self-serve-mvp-stack-build-phases/build-phases-strip`.
        (4.1 `should-you-hire` + 4.5 `vibe-coding-ceiling-signals` = mermaid, no SVG.)
      - M5 (7): `must-have-segment-pmf-test/sean-ellis-gauge`,
        `channel-selection-before-outbound/channel-fit-canvas`,
        `first-ten-customers-network-list/network-buckets`,
        `first-ten-customers-outreach-message/network-audit-grid`,
        `first-ten-customers-send-track/send-day-rhythm-card`,
        `paid-pilot-charge-before-ship/free-vs-paid-pilot`,
        `outbound-without-sales-team/ph-vs-ih`.
      - W2-touched confirmed current: 2.4 now carries `outreach-funnel-strip.svg`
        (hand/fail); 5.2 now carries `channel-fit-canvas.svg` (hand/fail). Both
        still need conversion.
    - **Mermaid in M2-M5 lessons (3, OUT of O2-SVG scope):** 2.5, 4.1, 4.5.
      Theme-rendered (Caveat theme), font is render-CSS not authored-in-fence, so
      the SVG floor check does not apply. Keep-as-is; flag only if render review
      trips.
    - **Tier B · M2-M5 walkthroughs (4, optional add-on):**
      `module-{2,3,4,5}-walkthrough-mia/artifact-trail.svg` — all HAND/FAIL. Ride
      the wave only if capacity allows; `module-1-walkthrough-mia/artifact-trail`
      is the same defect (W3 converted M1 *lessons* only, not the M1 walkthrough)
      — note as a straggler, fold into whichever sub-wave touches walkthroughs.
    - **Tier C/D · reference + continuation/global (~55, DEFER to a follow-on
      wave):** 19 `reference/*-full/` SVGs + ~36 continuation/supplementary/global
      (friday-demo, weekly-report, pivot, hiring, sow, slopsquatting, faq,
      quickstart, five-tech-words, etc.). Same grammar/defect, but not the numbered
      spine — own wave, own PR.

    **Decomposition — 3 sequential sub-waves, one branch, ONE bundled PR**
    (bundled-PR rule; WIP=1 + one-owner-per-module for grammar consistency; files
    are disjoint so parallel is *safe* but sequential keeps the 4-eyes gate clean):
    - **SW-1 = M2 (5 SVGs)** — RUN FIRST.
    - **SW-2 = M3+M4 (5 SVGs)** — merged; both are the "build" modules, 2+3 too
      small to split.
    - **SW-3 = M5 (7 SVGs)** — largest, the first-customer payoff tail.
    - Each sub-wave, per SVG: (1) redraw to the O2 template (system-ui type, 5-rung
      scale, grid W=720, connectors/data-viz per v3 spec), (2) clear the ≥9px@390
      floor (min font ≥17 on a 720 viewBox), (3) rewrite the markdown `![alt]` AND
      the SVG `<title>`/`<desc>`, (4) per-module Sprint-Y keep-as-is pass (preserve
      mono tokens, ruby/green/amber semantics, intentional elements — classify
      before redrawing).
    - **Acceptance per SVG:** O2 template match + floor PASS + alt rewritten +
      4-criteria rendered score (great look / readable-without-zoom / earns the
      scroll / helpful-not-decorative).

    **Gate (state it so no baseline churn panic):** `bin/hugo-build` +
    `bin/qtest --changed` on edited lessons + rendered review at 1280×800 and
    390×844. SVGs embed as `![alt](x.svg)` → `<img>`, and the pixel suite masks
    img (`skip_area: %w[picture img]`, W3 lesson) → **NO baseline re-record
    expected.** Content-scoped, NO shared CSS, campaign-safe. Full `bin/test` +
    `bin/dtest` only at PR-prep.

    **RUN M2 FIRST:** it is adjacent to the already-converted M1 — a reader
    walking M1(O2)→M2(hand-drawn) hits the visible grammar seam immediately;
    converting M2 restores an unbroken O2 run from the course entrance. Then
    M3+M4, then M5.

    **20%-slot pick = O7 validator-net gap (build-time SVG floor check).**
    Justification: this 74-SVG defect shipped *because the only visual gate masks
    img* — the pixel suite is structurally blind to it, and nothing else checks
    font legibility. A ~15-line check (parse viewBox W + min font-size, assert
    ≥9·W/390) wired into the hugo-build validator net turns "we eyeball the floor"
    into an automated gate, catches every future under-floor SVG, and pays off
    across the deferred Tier C/D backlog too — the root-cause, fix-it-once move.
    (O5(b) worktree-compose isolation is NOT the 20%-slot but IS the standing
    execution mechanic: the 3 committing sub-wave agents run in worktrees to avoid
    racing the shared branch — per the workflow-writers-need-worktrees rule.
    O8 already DONE.)

    Triaged ahead of W5 (higher momentum/lower risk; W5 is Clarity-gated) and
    ahead of frozen W4.

18. **[GROOMED 2026-08-02, READY TO RUN - deferred SVG wave, campaign-safe,
    after W5 or interleaved] Remaining 46 under-floor SVGs → O2 flat-vector.**
    Extends the DECIDED O2 system (ADR 30.09 accepted 2026-07-31; W3 #433
    satisfied the "follow M1 pilot" gate; #434 rolled M2-M5) to the rest of
    the 80-SVG corpus — NO new Paul style call needed. Template = the 22
    already-converted FLAT/PASS SVGs (5 M1 lessons + program-map + 17 M2-M5).
    Spec: `.okf/design/house-visual-spec.md` "v3 exhibit spec" (W=720 grid,
    5-rung scale, basis rung ≥17px so smallest text renders ≥9.21px@390).
    Method: per-SVG Sprint-Y classify pass (40.31) — CONVERT generic styling,
    KEEP-AS-IS meaning-bearing elements cited to a spec rule.

    **Live list (re-run `ruby bin/check-svg-floor` before dispatch): 46 SVGs,
    all under the 9px@390 floor (3.71-7.80px today).** Grouped by page-type,
    counts sum to 46:

    - **Group A · Mia walkthroughs (5)** — `module-{1,2,3,4,5}-walkthrough-mia/
      artifact-trail.svg` (incl. the M1 straggler W3 left; W3 converted M1
      *lessons* only). All HAND/FAIL (4.47-5.28px, vb 960). Files DIFFER
      (module-specific content) but share ONE template/grammar → fastest batch,
      one redraw pattern ×5. **Highest-linked pages** (walkthroughs are the
      most-linked per earlier research) → RUN FIRST.
    - **Group B · reference/*-full + smoke-test-channel-guide (11)** —
      sprint-timeline, mom-test good-vs-bad-answers, must-have segment-isolation,
      outbound stage-cadence, outcomes feature-vs-outcome, ownership bad-vs-good-
      email + ownership-zones, product-brief good-vs-bad-prd, prototype-build
      wireframe-strip, smoke-test channel-icp-matrix, stripe-price-test
      price-test-flow. (The other ~8 reference/*-full SVGs already PASS — Wave B
      shipped them FLAT.)
    - **Group C1 · sales/outreach + friday-demo + first-customer + process
      templates (15)** — outreach-sequence-template ×3 (bump-decision,
      message-channels, outreach-cadence), friday-demo-template timeline,
      friday-demo-rule ×3 (catching-the-lie, demo-rule, friday-loop),
      first-paying-customer-operating-kit ×2 (kit-components, kit-sample-row),
      fake-stripe dollar-presale-flow, three-questions daily-weekly-cadence,
      self-serve-stack walkthrough-milestones, pre-launch-checklist
      pre-launch-gates, vibe-prd-template vibe-prd-skeleton, validation-tools
      tools-in-sequence.
    - **Group C2 · hiring + scorecards + jargon + org/maps + global glue (15)**
      — agency-ai-five-questions scorecard-at-a-glance, hiring-interview-script
      scorecard-at-a-glance (DIFFERS from agency's — no convert-once shortcut),
      interview-scorecard scorecard-5-questions, hire-track-map,
      where-to-hire hiring-region-map, engineering-org-chart reviewer-attention,
      five-tech-words ×3 (architecture-comparison, jargon-translator,
      refactor-check), ai-token-bill invoice-loop, sow eight-clause-risk-map,
      pivot ×2 (pivot-ledger, pivot-wheel), faq module-strip, quickstart
      minimal-path. (No glossary SVG exists — confirmed.)

    **Hard vs straightforward split (~18 hard / ~28 straightforward):**
    - **HARD — wide viewBox 980-1000 needing node-reduction to W=720, or dense
      tables/maps/matrices (redraw, not rescale):** the maps (hire-track-map,
      hiring-region-map, sow eight-clause-risk-map), org chart (reviewer-
      attention), matrix (channel-icp-matrix), and the two-column COMPARE
      exhibits (good-vs-bad-answers, good-vs-bad-prd, feature-vs-outcome,
      bad-vs-good-email, ownership-zones, architecture-comparison, kit-sample-row
      [worst: 4.68px], kit-components, dollar-presale-flow, catching-the-lie,
      demo-rule [worst overall: 3.71px], friday-demo-timeline, vibe-prd-skeleton).
      Apply v3's "prefer fewer nodes at W=720 over more nodes at W=960" rule —
      compare tables likely stack or shed nodes to hold the floor.
    - **STRAIGHTFORWARD — single strip/timeline/cadence/loop/scorecard at vb
      900-960, linear re-layout:** the 5 artifact-trails, both scorecards +
      scorecard-5-questions, sprint-timeline, stage-cadence, wireframe-strip,
      price-test-flow, module-strip, minimal-path, outreach ×3, friday-loop,
      walkthrough-milestones, daily-weekly-cadence, pre-launch-gates,
      tools-in-sequence, jargon-translator, refactor-check, pivot-ledger,
      pivot-wheel, invoice-loop, segment-isolation.

    **Do-NOT-convert / keep-as-is flags (per Sprint-Y 40.31 — NO wholesale
    skips; element-level preserves apply course-wide):** mono tokens/event-names
    stay mono; ruby=action/CTA, green=money/success, amber=warning semantics
    survive the redraw; labels-INSIDE-shapes (Sweller) preserved. **Special:
    `reference/ownership-full/bad-vs-good-email.svg` is already FLAT** (system
    font, not cursive) but under-floor — it's a deliberate email-client mock.
    Classify REVIEW→FLOOR-FIX (bump type / reduce nodes to 720, KEEP the inbox-
    mock framing), NOT a full O2 redraw. (The 3 M2-M5-lesson mermaids 2.5/4.1/4.5
    are theme-rendered, not in this 46 — no action.)

    **Decomposition — 4 page-cohesive sub-waves, one branch, ONE bundled PR**
    (WIP=1 + one-owner-per-group for grammar consistency; files disjoint so
    parallel is *safe* but sequential keeps the 4-eyes gate clean; committing
    agents run in **worktrees** per the workflow-writers-need-worktrees rule):
    - **SW-1 = Group A walkthroughs (5)** — RUN FIRST (traffic + easiest).
    - **SW-2 = Group B reference/*-full (11)**.
    - **SW-3 = Group C1 templates (15)**.
    - **SW-4 = Group C2 hiring/global (15)**.
    - C1/C2 at 15 are the heaviest; an executing agent may split each into two
      passes (multi-SVG pages — outreach ×3, friday-demo ×3, five-tech-words ×3,
      kit ×2, pivot ×2 — are natural seams) if 15 in one sitting is too much.
    - Per SVG: (1) redraw to O2 template (system-ui type, 5-rung scale, W=720
      grid, connectors/data-viz per v3), (2) clear ≥9px@390 (min font ≥17 on a
      720 viewBox; scale all rungs by W/720 if wider), (3) rewrite markdown
      `![alt]` AND the SVG `<title>`/`<desc>`, (4) Sprint-Y keep-as-is pass.
    - **Acceptance per SVG:** O2 template match + floor PASS + alt rewritten +
      4-criteria rendered score (great look / readable-without-zoom / earns the
      scroll / helpful-not-decorative).
    - **Bundled-PR note:** default ONE PR for the 46-SVG wave (bundled-PR rule).
      If the single review gets too large, the natural split is after SW-2
      (walkthroughs+reference = 16 SVGs / PR-A; templates+hiring = 30 / PR-B) —
      but hold to one PR unless Paul says otherwise.

    **Gate (no baseline-churn panic):** `bin/hugo-build` + `bin/qtest --changed`
    on edited lessons + rendered review at 1280×800 and 390×844. SVGs embed as
    `![alt](x.svg)` → `<img>`; the pixel suite masks img (`skip_area:
    %w[picture img]`, W3 lesson) → **NO baseline re-record expected.** Content-
    scoped, NO shared CSS, campaign-safe. Full `bin/test` + `bin/dtest` only at
    PR-prep.

    **20%-slot pick = flip `bin/check-svg-floor` to a BLOCKING gate**
    (`SVG_FLOOR_BLOCK=1` wired into `bin/hugo-build`), sequenced as the FINAL
    sub-wave's payload AFTER all 46 convert and the check reports zero.
    Justification: this is the capstone that gives the whole two-wave effort
    (17 + 46 = the full hand-drawn corpus) its permanent teeth — the exact
    "fix the gate, not the instance" root-cause move the M2-M5 retro celebrated
    when it shipped the report-only check (O7b). ~2-line change (env default +
    hugo-build wiring); permanently blocks any future under-floor SVG across all
    80. Picked OVER O5(b) worktree-compose (that's a standing *execution
    mechanic*, already in use here for the committing agents, not a deliverable —
    and it's unspecced) and over literal-O7 (already closed by O7b). The
    blocking-flip is what makes all this durable.

    **Campaign-safety CONFIRMED:** every SVG is content-scoped (lives in one
    lesson's `index.md` folder, self-contained inline styles), NO shared CSS, NO
    template/layout changes → zero shared-surface risk to any live campaign.

    Triaged after W5 or interleaved (W5 is Clarity-gated; this is content-only,
    lower-risk, higher-momentum). Own wave, own branch, own PR.

14. **[POSTPONED 2026-08-02 by Paul - revisit later, not blocking] Reader-mode
    readability research** (Paul 2026-08-01): browsers' reader modes
    (Chrome DevTools can toggle Reader Mode; Firefox/Safari have their own)
    encode battle-tested readability defaults - measure line length,
    font-size/line-height ratios, paragraph spacing, link treatment, content
    width. Research pass: render 2-3 course lessons + 2-3 blog posts in
    reader mode, screenshot-compare against our normal styles side by side,
    extract the deltas that would improve reading XP (candidates: measure,
    contrast, vertical rhythm, de-chrome), and propose which to adopt in
    course-single/blog CSS. Deliverable: short findings doc with the
    screenshot pairs + an adopt/skip table; NOT a restyle - feeds W4 (V3-B
    course-single wiring) and any future blog typography pass. Cold-session
    executable; no gate dependencies.

## Browser-session track (claude-in-chrome, added 2026-07-31)

Paul's logged-in Chrome is now a proven agent surface (LinkedIn reads
worked 2026-07-31; it is also the ONLY agent path to the login-walled GA4
property UI and Clarity dashboard). Operating model (Paul 2026-07-31):
AUTOMATED PIPELINE, HUMAN SEND - agents source, filter, personalize, and
pre-fill each message in the open composer; Paul's only action is per-message
review + the Send click. Agents never click Send. Local cards (gitignored
.devtool board) mirrored here:

- **B1 - pilot lead sourcing** (TODO, due Aug 4, card
  `browser-lead-sourcing-2026-07-31`): scout the 8 hunting grounds with the
  40.18 screener translated to observable post signals (filters + hard
  disqualifiers in 50.02); output 50.03 shortlist of 15-25 candidates with
  evidence, DM-template mapping, and a separate Alex/rescue-leads section;
  then queue the sends - open each qualified candidate's DM thread and
  pre-fill the personalized message for Paul's review-and-click.
- **B2 - campaign monitoring** (BACKLOG, Aug 1-14, card
  `browser-campaign-monitoring-2026-08`): daily comment/thread reads with
  replies pre-filled in-thread for Paul's review-and-click, ledger numbers,
  flagging Sam-pattern commenters into
  50.03; Aug 14 GA4 + Clarity dashboard pull into 50.04 first-metrics-read
  with removal-candidate verdicts; monthly register-B voice recalibration
  against real human posts.

## Visual system v3 track (ADR 30.09, accepted 2026-07-31)

Three-reviewer panel (design / Sam-ICP / feasibility) accepted with changes,
all incorporated. Full spec: 30-39-architecture-design/30.09-adr-*.md.
- **V3-A (start now, content-scoped):** v3 exhibit spec -> A/B exemplar
  (hand-drawn-normalized vs flat-vector, both new-grammar) -> 4 M1 in-place
  redesigns + rewritten alts -> eye-test doc -> PAUL'S STYLE CALL in the
  ADR. Program map v1 drafted alongside, judged independently.
- **V3-B (post-Aug-14):** new course-single.css + single.html wiring
  (shared template - never mid-campaign; never touch shared blog CSS).
- **Sprint Y normalization = the O1 fallback path**; its classify-first
  audit runs in either outcome.

## Landing-page improvement track (scheduled 2026-07-31)

Kanban cards live on the LOCAL board `.devtool/features/` (gitignored - VS
Code kanban-markdown extension); this section is the committed mirror so a
cold session sees the work.

- **L1 - styling batch** (IN FLIGHT, branch `course-landing-critique-fixes`):
  all 8 UI/UX critique findings - course-owned end-cap above the sales
  footer, ruby AA CTAs (legacy blue failed at 3.4:1), Space Grotesk display,
  BOTH "since 2005" tenure-canon violations -> 2011, intro decision-diet,
  module link-run restructure, disclosure softening, year-chip/chip-wrap.
- **L2 - content-architecture pre-review** (TODO, card
  `landing-content-layout-critique-prereview-2026-07-31`): 3-4 independent
  critics on section order; produces the punch-list; NO edits. Blocked by L1
  (owns `_index.md`).
- **L3 - content/layout restructure** (BACKLOG, card
  `landing-content-layout-improvement-2026-07-31`): executes L2's punch-list.
  Expected moves: relocate "Going further" (post-graduation content, 4
  identical trigger tables) off the acquisition page; promote the
  already-building route out of 89% scroll depth into the hero area; expand
  the 32-word authorship footnote; break the 646-word prose tail. Blocked by
  L2.
- Baseline to beat: UI/UX critique scored 25/36 (69%) on 2026-07-31; snapshot
  at `.impeccable/critique/2026-07-31T11-47-14Z__*.md`. Re-run after L3.
- **Spun out of L1 (NOT course work)**: the detector's 3.4:1 white-on-#1a8cff
  finding is the GLOBAL FOOTER "we're hiring" badge (`b.special`, 13.33px
  bold), not the course CTAs - those compute ruby at 5.12:1 and pass. Real
  sitewide WCAG AA failure; card
  `footer-hiring-badge-contrast-a11y-2026-07-31`. Deliberately not bundled:
  it churns ~50 baselines on both platforms and would collide with the
  in-flight visual-CI work (#412/#413).
- **Also spun out**: the "Free · 2026" chip is baked into `cover.png`
  artwork, not markup - dating it out needs a cover-pipeline regeneration
  pass, not a template edit.

## Groomed backlog (2026-07-11 grooming session)

Course is content-complete on the v2 template, journey-audited (40.17), and review-clean. Grooming closed 7 stale items (marked in the table below) and organized the rest into 4 sprints:

**Sprint A - P0, start now: pilot + measurement**
1. Funnel instrumentation: Clarity/GA4 events for landing → 1.1 → 1.4 gate → M2 booking → 5.6 DPA (the course must practice its own Ch 1.3 discipline before we drive traffic)
2. Revive the external validation pilot (kit: `40-49-review/40.18-external-validation-pilot-kit.md`) - recruit 3-5 real idea-stage founders, watch recordings
3. Rider: fix the site-wide "© 2024" footer to a dynamic year (trust nit flagged by every Sam walk)

**Sprint B - P1: media + template polish** (parallel with pilot recruitment lag)
1. Visual hooks for the 5 Mia walkthroughs (most-linked pages; currently pure text walls - hero + per-lesson artifact motif)
2. One mid-body informational visual each for 1.2 / 1.3 / 1.5 (1.4 already has its decision table)
3. 5.7 stages mermaid: vertical ~1,200px wall → horizontal layout
4. Typography: distinct accent for the TL;DR card so the lesson-head stack reads ranked (one CSS variant + template class)
5. outreach-sequence-template: collapse 3× stacked variant blockquotes (existing P2)
6. De-stack + rebalance "$0 path" callouts in outbound + self-serve-mvp per `feedback_budget_stance_free_and_paid_equal` (existing P2)
7. Companion-cover regen audit: ~30 covers with stale "Curriculum NN/30" badge incl. glossary "08/30" (existing P3; covers pipeline is proven, cheap now)

**Sprint C - P1: PDF thin slice** (regroomed from the 14-PDF item)
1. Print stylesheet + `bin/generate-template-pdfs` (headless-Chrome print-to-PDF over rendered pages - single source, zero drift)
2. Ship PDFs + "Download PDF" links for the 5 physically-used templates: Build Path Worksheet, Mom Test Interview Script, Ownership Checklist, Validated Problem Statement, DPA one-pager
3. Landing "Free templates" section stays down until the full set exists (per the 2026-05-21 deal); extend to the other 9 if pilot recordings show download demand

**Sprint D - P2, demand-driven (after first pilot data):**
1. Operating Kit: ship the 5 remaining templates as pilot readers approach M5
2. 10.08 content gaps batch: echo-chamber warning 2.3/5.3 (cheapest, do first), Wizard-of-Oz path 4.3, Loom outreach 5.2/5.5, Engineering-as-Marketing 5.2
3. Manual-minimum audit for 5.3/5.4 paid-tool friction (existing partial)
4. Whatever the pilot recordings surface (this replaces the vague "tighten practical proof" item)

Then: distribution prep (blog funnel per 20.07 + LinkedIn campaign), gated on Sprint A instrumentation being live.

---

## Media modernization backlog (groomed 2026-07-26)

**Goal:** every lesson earns its scroll - first-fold visual hook, decision-aid
formats where the reader decides, one visual break per H2, printable artifacts
where the reader acts on paper. Grounded in `40-49-review/40.20-media-gap-audit-report.md`
(the inventory), `10-19-research/10.06-media-design-recommendations.md` (what
formats apply - NO slides/video per 30.03), and `10-19-research/10.05-content-organization-patterns-2026.md`
Part 2 (the cognitive-load rules the visuals must serve).

**What already shipped (2026-07-26 pilot, commits 2e153bd6 + e112a3f1):** all
three P0 assets - interview-scorecard page (+SVG +cover), pre-launch-checklist
page (+SVG +cover), channel-fit canvas, 3 outreach-sequence SVGs; both new
pages wired into `_index.md` + companion lessons 2.1/4.4.

**Definition of done for EVERY item below (no exceptions):**
1. House visual spec (`.okf/design/house-visual-spec.md`): paper tones, semantic
   colors (red=action/anti-pattern, purple=alternate, green=money/success),
   Caveat stack, labels INSIDE shapes.
2. **Text budgets sized for Comic Sans MS**, not Caveat - SVGs render via `<img>`
   where webfonts never load (~6.2px/char at 13px, ~8px/char at 16px bold; every
   line ends >=10px before any rect edge/badge/divider). See memory
   `project-svg-text-budget-comic-sans-fallback` - the pilot's first cut shipped
   5 of 6 SVGs with overflow because budgets assumed Caveat.
3. Visual scroll gate (docs/workflows/visual-scroll-gate.md) at 1280x800 AND
   390x844 BEFORE commit - raw SVG URL + in-page. The banned-string ratchet does
   NOT scan SVG internals; the gate is the only check that sees them.
4. Informational only - if removing the visual loses nothing, don't ship it
   (no decorative art, 10.05 CLT rule). Mermaid height <= ~1600px rendered.
5. `bin/hugo-build` + `bin/rake test:critical` green; ONE PR per wave.
6. **Words-per-visual <= ~600 on core lessons** (2026-07-30 delta audit: binary
   has-SVG checks let 5,400-word single-SVG walls pass; density is the real gate).
7. **Templates ship scaffolded, never blank** (worked-example fading: link the
   FILLED Mia version first -> partial -> blank; 57-source research corpus:
   blank forms stall novice founders who can't self-diagnose).

**Sequencing: WIP=1, one wave at a time, each wave independently shippable.
Order (2026-07-30): M1 -> C1 -> M2 -> M3 -> M4; M5 + Phase 2 gated on pilot
data. None of it blocks or delays the P0 pilot (Paul's desk).**

### Wave M1 - P1 core-lesson visuals (~1 day) - START HERE

The 4 core lessons with a cover but ZERO inline visual (40.20 §2, P1 rows).
One informational SVG each, placed at the section where the reader decides/acts:

| # | Lesson | Visual to create |
|---|---|---|
| 1 | `find-10-people-with-problem-outreach-2026` (2.4) | Outreach funnel strip: 30 names -> sent -> replied -> booked, with honest drop-rates - reuses the tracker-row motif from outreach-cadence.svg |
| 2 | `first-ten-customers-outreach-message` (5.3) | 8-name network audit grid (who/last-contact/warm-intro-path) as fill-in worksheet |
| 3 | `first-ten-customers-send-track` (5.4) | Send-day rhythm card: daily handful cadence + stop-at-10-booked gate |
| 4 | `vibe-prd-template` (M3 companion) | One-page brief skeleton: 5 sections as labeled card stack, outcome-shaped vs feature-shaped cues |

Skip (already adequate per 40.20): `mom-test-synthesis-build-pivot-kill` and
`should-you-hire-2026-decision-tree` both carry Mermaid decision flowcharts.

### Wave C1 - completion mechanics (~1 day) - NEW 2026-07-30

**State (2026-07-30, post-merge):** items 1/2/3/5 SHIPPED - PR #390 MERGED
to master (squash d3e8595d; independent reviewer APPROVE on all 5 checks).
**Item 4 (progress tracker) DEFERRED to Sprint D by 2-1 team vote**
(operator + Sam-ICP voters: per-browser marks vanishing on a second device
erodes trust even with quiet-checkmark mitigations, and the pilot will
observe real reader behavior directly; pedagogy voter dissented - engagement
lift is real but recoverable post-pilot). Do not build before pilot data.
**Clarity: WAIVED by Paul (2026-07-30) - GA4 is the measurement stack for
now.** (Background: the analytics partial ships the Clarity snippet but
`microsoftClarity` is unset, so no session recordings exist. Paul decided
GA4 funnel events are enough for the current stage.) Consequence for the
pilot: no session recordings - stall diagnosis comes from GA4 funnel
drop-offs + direct pilot-founder debriefs instead of watching replays. If
recordings become wanted later: create the project at clarity.microsoft.com
and set `microsoftClarity = "<project-id>"` under [params] in
config/_default/hugo.toml (one line - partial already handles the rest).
**Wave M1 SHIPPED** - PR #394 merged (squash d029db90): 4 hand-drawn SVGs
(2.4 outreach-funnel-strip, 5.4 network-audit-grid, 5.5 send-day-rhythm-card,
M3 vibe-prd-skeleton), designer agent in worktree + team-lead visual walk of
all 4 pages at 1280x800. Two backlog spec-wording errors corrected against
page content (5.5 gate = "10+ replies, 3-5 demos booked", not
"stop-at-10-booked"; grid rows are illustrative sizing). NEXT WAVE: M2
(decision-aid retrofits incl. the promoted salvage-vs-rebuild +
where-to-hire pages and the 4 word-walls). Known ceiling for Wave M4:
network-audit-grid at 390px renders small - the worksheet mobile-legibility
investigation owns it.

Grounded in the 2026-07-30 strategy review (Product Compass benchmark + Sam
persona walk + pedagogy persona + 57-source NotebookLM corpus; plan file
`iridescent-tinkering-parrot`). Core finding: the completion gap is progress
MECHANICS, not media. All zero-ops (static/client-side only).

1. **20-min first-win path**: overview + Lesson 1.1 open with a 15-20-min
   happy path (fill the hypothesis sentence + find one matching Reddit
   complaint); move the >=14/20 scoring rubric + "if this fails" branches
   behind a `<details>` toggle. (Sam persona: "90-minute sprint" gets
   deferred; rubric flips quick-win into assignment.)
2. **Defer the overview tool-stack tables**: replace the ~15-tool wall on
   how-this-course-works with "notebook + a landing-page builder; each tool
   appears in the lesson that uses it". (Sam: "the scariest thing on the map".)
3. **Implementation-intention line** at each module end: "When this week will
   you do the worksheet? [day/time]" (Gollwitzer d~.65 on follow-through).
4. **Progress tracker (GATED)**: first run the 30-min Clarity check - % of
   returning readers on the same device. Cross-device dominant -> SKIP
   (an empty tracker on device #2 demotivates). Same-device dominant ->
   localStorage checkboxes on the module map + per-lesson "mark complete"
   (goal-gradient). Pull Wave M5's module-end checklists INTO this item.
5. **Living-document trust line**: visible "Updated <month year>" + 3-line
   changelog on the overview (Product Compass pattern; zero recurring cost).

REJECTED after persona review (do not relitigate without pilot data):
public completion CERTIFICATE / LinkedIn badge - idea-stage Sams are stealthy
("posting 'I'm validating an idea' invites questions I can't answer, tips off
copycats"). The completion artifact is the private **Founder OS pack** (the 6
artifacts bundled, investor-showable) - Phase 2, gated on pilot demand.

### Wave M2 - decision-aid + F-pattern retrofits (~1 day)

**State (2026-07-30): SHIPPED** - branch course-wave-m2-decision-aids.
Delivered: salvage-vs-rebuild mermaid decision tree (title finally kept its
promise); where-to-hire 4-region hand-drawn map SVG; hire-track
trap-vs-redline milestone table; self-serve-stack mistakes bullets ->
grouped Ownership/Scope/Truth table. 4-eyes critic: 4/4 PASS (fact
fidelity, AI-feel, voice, nothing-lost).
**Stale items closed without work** (already fixed by earlier sprints):
item 4's outreach-sequence blockquote collapse (done in the PR #351
rewrite) and the "$0 path" callout de-stack (budget-stance fix already
landed). **Audit-metric lesson**: the words-per-visual count can't see
blockquote scripts/Bad-Good pairs as breaks - 3 of the 4 flagged
"word walls" (churn, outbound-full, most of self-serve + hire-track
sections) were already healthy at section level. Assess per-H2 before
building; only 2 real gaps existed and both are now filled.

Apply the 10.05 Part 2 rules to existing prose in the highest-traffic lessons:
1. Sweep all core lessons for if-X-then-Y prose sections -> compact decision
   table or labeled flowchart (pattern: M3's I4 "2 forks" retrofit).
2. Sweep for 6+ identical-format bullets / 6+ single-format table rows ->
   card grid or per-item icons (F-pattern give-up rule).
3. "One visual break per H2" audit on the 10 longest lessons; fill gaps with
   informational visuals only (a table or styled callout counts; bold leaders don't).
4. Quick wins carried from the ICP backlog (still open): collapse
   outreach-sequence-template 3x stacked variant blockquotes into single
   blockquotes; de-stack + rebalance "$0 path" callouts in outbound +
   self-serve-mvp per `feedback_budget_stance_free_and_paid_equal`.
5. **Delta-audit reprioritizations (2026-07-30, promote to P1)**: (a)
   `salvage-vs-rebuild-decision-tree` - a literal 6-question decision TREE
   rendered as prose + tables, mermaid=0 (title promises a visual the page
   lacks = trust cost); (b) `where-to-hire-developer-2026-map` - titled a MAP,
   is 4-region/6-platform tables, zero visual. (c) Break the 4 worst
   words-per-visual walls: hire-track-supplementary-reference (5,483w/1 SVG),
   self-serve-stack-walkthrough (5,248w/1), customers-leaving-churn
   (2,997w/1 mermaid), reference/outbound-full (2,851w/1).

### Wave M3 - printable artifacts thin slice (~0.5 day)

**State (2026-07-30): SHIPPED** - PR #396 merged. interview-scorecard +
pre-launch-checklist added to the PDF pipeline with on-page download links
(scorecard links Mia's M2 walkthrough as the filled example);
channel-fit-canvas.pdf via new CANVASES landscape-wrapper loop (portrait
clipped the 960px canvas - caught in PDF review, MediaBox now 792x612).
8/8 PDFs green. Remaining ~9 template PDFs stay demand-gated per Sprint C #3.

Extend the proven `bin/generate-template-pdfs` pipeline to the 3 new pilot
assets: interview-scorecard, pre-launch-checklist, channel-fit canvas one-pager.
These are the pages readers physically fill in - print is the native format.
The remaining ~9 template PDFs stay gated on pilot download demand (standing
Sprint C #3 rule - do not relitigate).

### Wave M4 - worksheet mobile legibility (investigation, ~0.5 day)

**State (2026-07-30): INVESTIGATED + CLOSED (ceiling documented).** SVGs
render as plain `<img>` in render-image.html; the portrait-variant pattern
is ~10 template lines BUT needs a second hand-drawn variant per worksheet
kept in sync by hand (single-source violation, drift risk) + double
visual-regression gates for the theme change. Verdict: not worth it - the
phone answer for fill-in worksheets is the Wave M3 print-ready PDF link.
Ceiling documented in `.okf/design/house-visual-spec.md`. Revisit only if
pilot recordings show phone readers pinch-zooming instead of downloading.

Dense 960-wide worksheet SVGs (channel-fit canvas, scorecard) render at ~7px
text on a 390px phone - legal but illegible; Sam reads on phone (pilot
screening criterion). Investigate ONE pattern on ONE worksheet: portrait-
orientation variant (e.g. 700x900 viewBox) selected via `<picture>`/media
query in the render hook, or taller stacked layout. Ship only if the pattern
is cheap and reusable; otherwise document the ceiling in
`.okf/design/house-visual-spec.md` and close.

### Wave M5 - P2/P3 SVGs + module-end checklists (M5a+M5b SHIPPED; M5c + covers remain)

**Gate change (Paul, 2026-07-30): all M-wave items lost their pilot gate.
Sprint D content-gap batch and Phase 2 mechanics keep their gates.**

**State (2026-07-30 EOD): M5a + M5b SHIPPED in PR #406.**
- M5a: 3 SVGs (fake-stripe $1-presale flow - agent corrected the backlog's
  wrong "fake-door" framing against page reality; friday-demo 8-node
  timeline; sow-reading-guide 8-clause risk map). SKIPPED with reason:
  agency-uses-ai-follow-up-questions + customers-leaving-churn (both already
  carry adequate decision visuals - backlog rows now moot).
- M5b: module-end checklists added/reformed for M1/M2/M3/M5 on M4's model
  form; Do-This-Now template-link audit = 0 violations (a prior wave closed
  it); reflection-line audit = 0 exact duplicates (4-lesson "read X aloud"
  soft pattern noted, acceptable).
- REMAINING: M5c reference-tier visuals + the ~19-cover batch (see Open
  queue at top).

- 40.20 P2 list (fake-stripe case study, friday-demo, sow-reading-guide,
  vibe-coding-ceiling-signals; salvage-vs-rebuild PROMOTED to Wave M2 P1
  2026-07-30) and P3 list (3 Going Further pages) - only for pages Clarity
  shows real traffic on.
- 40.20 §5 interaction gaps: module-end checklists for M1/M2/M3/M5 folded
  into Wave C1 #4 (progress tracker); Do-This-Now-references-template-by-name
  audit, micro-reflection wording sample audit remain here.
- **Reference-tier gap (2026-07-30 delta audit - invisible to 40.20's
  cover-based scan)**: 5 reference/*-full chapters at 1,800-2,500 words with
  ZERO in-body visuals (mvp-build-phases-full, stack-tools-full,
  find-10-people-full, persona-rehearsal-full, channel-selection-full);
  19 of 80 pages missing covers (18 reference + faq + quickstart). True
  zero-body-visual count course-wide = 17 pages, not 40.20's "1".
  Demand-driven: only if Clarity shows reference traffic.
- **Phase 2 (Paul-approval gate + pilot signal)**: Module-2 applied
  checkpoint experiment ("score this practice interview" with instant
  feedback - NOT a recall quiz; assessment-validity-checker skill reviews
  questions before ship); private Founder OS pack completion artifact
  (HTML->PNG/PDF via cover pipeline).

## Growth waves G1-G3 (runbook: 20-29-strategy/20.12-course-growth-agent-runbook.md)

**All three waves SHIPPED 2026-07-30** (agent specs + standing decisions live
in the runbook - fully ungated, NO mail list, no selling, stealth ICP,
campaigns pilot-gated):
- **G1** (direct to master): docs-truth sweep removed every email-gated /
  email-capture KPI claim; production GA4 verification found the muted-
  analytics root cause (consent denied-by-default with no banner + missing
  beacon transport).
- **G2** (PRs #402 + #404): consent default -> granted for analytics_storage
  (ads stay denied), beacon transport, copy-link referral button on 5
  module-end lessons; 10 evergreen blog posts now deep-link 8 course lessons
  (was 0 of ~580). G2.2 SERP spot-check still OPEN (see Open queue).
- **G3** (PR #398): 16 pilot-gated campaign briefs (15 blog-funnel + 1
  LinkedIn), incl. the finding that 7 topics in 2510's 20.07 plan were
  already live as course chapters (statuses corrected in 20.07).

### Effectiveness measurement (rides every wave, not a wave itself)

Sprint A instrumentation (GA4 + Clarity, shipped in #356) is live. For each
page that gets a visual: note baseline scroll-depth/time-on-page the week
before, re-check 2 weeks after. A visual that doesn't move scroll-through or
reduce Clarity stall points on its section is a candidate for removal, not
iteration (10.05: visuals that decorate cost parse time). Record per-wave
before/after in this tracker when closing the wave.

**🚀 What shipped 2026-07-09..10: Module 2 v2 complete (PR #351, 20 commits)**
- ✅ All chapters on the M1 v2 template; numbering FLATTENED to 2.1-2.6 (letters retired; Synthesis is Lesson 2.5, in yaml prev/next). Chapter count derives 25 via course-stat.
- ✅ Module 2 Mia walkthrough (incl. Lesson 2.5 section) wired into all lessons + landing.
- ✅ Decision gate canonical everywhere: BUILD 7+ / PIVOT 4-6 / KILL <4, with score≥7 ≡ real-past-spend equivalence stated on 2.5.
- ✅ outreach-sequence-template rewritten as the true 2.4 companion (Gmail + NeetoCal, honest bump variants).
- ✅ Four gatekeeper reports + re-verification + final cold-eyes + 65-finding fan-out (40.12/40.14) - ALL findings fixed or skipped-with-reason. M1↔M2 boundary breaks fixed (no pitch-the-hypothesis instruction; 1.4→1.5→2.1 spine; ICP derives from the [customer] blank).
- ✅ Covers: stale landing-copy covers on 2.3/2.5 replaced with purpose-made lesson covers; clipped Q5 SVG + 1881px interview-flow mermaid fixed (now 971px).
- ✅ **Regression ratchet** (40.13): validator 8 `banned-string-ratchet` + data/course_banned_strings.yaml (25 signatures). Every review fix adds its signature in the same commit. Caught 6 live instances outside review scope across 3 runs.
- ✅ Six external reader reviews triaged: 8 improvements adopted (2.1 awkward-first-calls + no-story interviewee; 2.2 GIGO routing + objection emotional-prep; 2.3 perfectionism time-box; 2.4 flattery reframe), rest confirmed content.
- 🔲 Carry-forwards: "Artifact #N of 6" labels in 3.1/4.3b/5.4 renumber in their sprints; M3-M5 in-lesson case studies removed in their sprints; word-count-band spec gap needs split-or-waiver decision; 2.5 "why now" timing factor = backlog idea.

## Previous phase (merged): course shipped via PR #345

**🚀 What shipped 2026-07-07..09: full course merged + Module 1 hardened (PR #345, squash 90216d2f, deployed)**
- ✅ Landing page redesigned: hero lede + chips + CTA buttons above the fold, module cards, mistake list; Founder OS artifact grid merged into the module-map intro (dedup). Old 12,000px bullet-list layout gone.
- ✅ Module 1 lesson numbering is now **1.1-1.5** (was 1.1/1.2a/1.2b/1.2c/1.3 in older tracker entries below - historical sections keep the old labels).
- ✅ 1.1 reframed as strategy-as-hypothesis (Click / lean-inception rationale): advantage + assumptions exposed as blanks, blank→experiment map table, why-one-sentence.
- ✅ Four independent review rounds all resolved: 2 cold-eyes subagent reviews, CodeRabbit triage, 5-lens fan-out (66 raw → 60 verified findings) + reviewer re-verification. Gate table bands contiguous (Under 3 / 3-6 / 6-10 / 10-20 / Over 20, proceed = ≥6%); FAQ/quickstart/HTCW aligned to it.
- ✅ Single-source stats: `course-stat` shortcode derives chapters/modules/artifacts from `data/course_sequence.yaml` (24 chapters currently render). Covers use near numbers ("20+ chapters"). Never hardcode counts in prose.
- ✅ Covers added for 1.2 + 1.3; landing + HTCW covers regenerated ("5 modules · 20+ chapters", TEMPLATES chip now "All free" - the old "14 free" note below is obsolete).
- ✅ De-hardcoded volatile third-party claims (tool prices/limits → capability language + check-pricing-page note). Removed fabricated "Hacker News $475/mo" ad product. CPC table arithmetically consistent (Meta plan band $250-$700).
- ✅ Site-wide fix: render-link.html trailing-newline chomp (stray space before punctuation after every markdown link).
- ✅ Legacy deleted: drafted pre-split 5.3 chapter (first-ten-customers-personal-network) + 17 links retargeted to 5.3a/b/c.

**🔄 In flight (this branch): M2 v2 migration**
- ✅ 2026-07-09: all 5 M2 chapters aligned to the M1 v2 lesson template (Lesson 2.x · [CORE/OPTIONAL] headers, Progress chain M2 · n of 5, "After this lesson" lines, Done/You-have-now/Next/If-blocked footers). Commit 48552e7b.
- 🔲 Module 2 Mia walkthrough (`module-2-walkthrough-mia`) + See-it-in-action lines in the 5 lessons (same-commit rule per 30.03 §2.7).
- 🔲 Cross-page consistency pass + sweeps + cold-eyes review loop → ONE PR for the sprint.

**Current sprint focus:** migrate Module 2 (Validate the Problem) to v2 micro-lesson format — 5 v1 chapters → ~6 micro-lessons following the 30.03 8-part template. M1 v2 is complete and serves as the canonical pattern. Cold AI agents should read `30.03-course-format-requirements-for-creators.md` + the M1 v2 lessons (1.1, 1.2a, 1.2b, 1.2c, 1.3) + the Mia walkthrough as the implementation reference before touching any M2 lesson.

**🚀 What shipped 2026-06-22: Module 1 release (Option C reframe)**
- ✅ Landing `_index.md` opener reframed: "Module 1 - Validate Demand - is released today. Modules 2-5 roll out through 2026." Drops the "live MVP, signed paid pilot" promise from the opener (those are M4/M5 outputs, not released yet).
- ✅ Module map status badges added: M1 = `✅ Released today · v2 micro-lessons`; M2-M5 = `🗓️ Rolling out 2026 · v1 long-form chapters readable now`.
- ✅ Founder OS section footnote: "Today: Module 1 produces artifacts 1 and 2. Artifacts 3 through 6 unlock as Modules 2-5 release through 2026."
- ✅ `og_description` updated to be M1-honest (no fundraising/MVP promise).
- ✅ Quickstart reframed: "What's released, what's coming" replaces the old "Promise" section; M1 chapter list fixed to current 5-lesson v2 structure (1.1, 1.2a, 1.2b, 1.2c, 1.3); status badges on M2-M5 sections.
- ✅ FAQ: added 4 new release-status Q&As under "General"; existing "How long" Q split into M1-specific + full-course-when-released.
- ✅ Stale slug `smoke-test-build-landing-page` → `smoke-test-build-page` corrected in Quickstart + FAQ (3 occurrences).
- ✅ Build clean: 0 em-dashes across all 3 pages; all 7 course validators pass.

**Deferred to follow-up sweeps (NOT in this release):**
- ✅ OBSOLETE (2026-07-09): the "M2-M5 v1/v2 status callout" idea was dropped - the released-vs-rolling-out status lines were removed from the landing during the #345 redesign; the course presents as one coherent product.
- ✅ Done differently (2026-07-08): covers regenerated with "5 modules · 20+ chapters" and "All free" chips; no roadmap badges.

**What shipped earlier (2026-06-16): M1 v2 conversion COMPLETE**

**What just shipped (2026-06-16): M1 v2 conversion COMPLETE**
- ✅ All 5 Module 1 lessons converted to v2 micro-lesson format with full 8-part template:
  - `form-your-founding-hypothesis-90-minute-sprint` (1.1) — Mad Libs frame → 4-lens scoring
  - `smoke-test-build-page` (1.2a) — agnostic AI-builder workflow, Mixo as worked example
  - `smoke-test-wire-tracking` (1.2b) — Clarity + GA4 (channel-independent), pixel deferred to 1.2c
  - `smoke-test-landing-page-7-day-demand-test` (1.2c) — channel selection + pixel install + go/iterate/kill
  - `price-hypothesis-on-smoke-test-page` (1.3) — Stripe Payment Link + price signal interpretation
- ✅ Mia walkthrough page (`module-1-walkthrough-mia`) published with full narrative arc across all 5 lessons
- ✅ Voice cleanup sweep applied to all M1 lessons + walkthrough (Hook ≤3 sentences, em-dash → hyphen, error blocks normalized, 4-slot closure pattern)
- ✅ 1.2b title renamed: "Wire Tracking Before You Spend a Dollar" → "Wire Tracking Before Traffic Starts" across 7 files
- ✅ Frontmatter title prefix consistency: all M1 lessons use `1.2X · ` prefix
- ✅ Pixel install sequencing fixed: channel-independent tracking (Clarity + GA4) in 1.2b, channel-specific pixel in 1.2c
- ✅ 1.3 Mixo redirect wording aligned: "GA4 counts the revisit"
- ✅ Bridge chain verified: 1.1 → 1.2a → 1.2b → 1.2c → 1.3 → M2 intro intact

**What shipped earlier (2026-06-08): Phase 1 pilot COMPLETE**
- ✅ Phase 1 pilot RESTRUCTURED into ONE Mixo-only golden-path lesson:
  - `smoke-test-build-page` — agnostic AI-builder workflow (Mixo as worked example, Manus AI and Durable named as equivalents, Carrd as manual-mode fallback): paste hypothesis → polish 4 copy blocks → swap hero → add disclaimer → publish → stranger test. Title and slug deliberately tool-agnostic so the lesson outlives any one tool.
  - `smoke-test-wire-tracking` — Clarity + ad-platform pixel + optional GA4, ~430 words (unchanged from earlier pilot)
- ✅ Deleted prior two-lesson split (`smoke-test-pick-builder-ship-page` + `smoke-test-ship-page`) - ICP review found audit framing + manual-path/AI-path conflation confused Sam; 6-element table positioned as audit gate but Mixo doesn't output labeled elements
- ✅ Both lessons pass: Hugo build, validate-course (7/7), em-dash sweep (zero), word count in 500-800 band
- ✅ Spec updates: 30.03 §2.7 mandates ONE case study per MODULE at module-end (slug `module-N-walkthrough-<founder>`); lesson bodies stay case-study-free; `See it in action` footer link added in SAME commit that publishes the walkthrough page (never before - placeholder URL reads as broken promise). AGENT-PROMPTS scaffolding file deleted - cold-agent workflow now lives inline in TASK-TRACKER + 30.03 + PROJECT-INDEX route.
- ✅ Plan B (split-by-path: separate AI lesson + manual lesson) parked in LOW-IMPACT-IDEAS-BANK with trigger condition (reader data showing ≥30% Carrd-fallback rate)
- ✅ Option C wired into landing: Quickstart + FAQ links in "Start here" callout, "What this course does NOT cover" section added with 7 explicit exclusions

**Phase 1 pilot findings (record for cold agents):**

| Observation | What it means for Phase 2 |
|---|---|
| Real time-per-lesson: ~25 min for the first draft + ~20 min for review/cuts ≈ 45 min/lesson | Phase 2 estimate of "~45-60 min per lesson" holds. M1 v2 conversion (5 lessons) took ~4 hours actual including walkthrough + voice sweep — validates the ~45 min/lesson estimate. M2 (5 chapters → ~6 micro-lessons) ≈ 4.5 hours realistic. Earlier estimates were padded. |
| Two-case-studies-per-lesson pattern produced ~30% word-count drag on the 400-600 budget | Superseded 2026-06-08: case studies now live at module-end walkthrough page only (30.03 §2.7); lesson bodies are case-study-free. |
| Split-by-step pattern (audit lesson + ship lesson) confused Sam: audit framing assumed Mixo outputs labeled 6-element list, but Mixo outputs a complete page Sam can't easily map to the 6 elements | Workflow-shaped lessons (one Mixo session = one lesson) beat framework-shaped lessons (audit then ship). Match the cognitive split to the reader's actual session boundaries, not to teacher-imposed pedagogical phases. |
| Concept blocks naturally drift to ~310 words when GA4-style "industry standard" addendums creep in | Watch for "overkill but include for completeness" content. Cut or move to optional sidebar. The 300-word cap is enforced, not aspirational. |
| Template labels (1. Hook, 2. Outcome, etc.) NEVER leak into published content when the writer reads the lesson aloud at the end | Read-aloud check before commit is a cheap insurance. Adds <60s, prevents the worst kind of regression. |
| Step 2 of Do-Now in Lesson 1.2a originally combined all 6 elements into one ~95-word paragraph | Bullets beat paragraphs in Do-Now steps. Mobile scanability is the deciding factor. |
| ICP-fit case-study selection: Mia worked for 1.2a (B2C "use what you have" theme), Tomas worked for 1.2b (B2B "invisible builder blind spot" theme) | Strict alternation would have put Tomas in 1.2a where Mia's "scrappy founder uses real screenshot" lands harder. ICP-fit picking is the right rule. |

**Phase naming note:** This doc uses "Phase 0" for the remaining mechanical quick wins (outcome sentences, success checks, Stuck? boxes — see migration schedule below). The completed surgical improvements are called "Option C" (matching 30.03 §8.4-8.5). These are separate work streams. M1 v2 is complete; Phase 2 Module 2 migration is the active work stream.

**Active sprint: M2 migration** (other candidates listed for visibility):
1. **Phase 2 — Module 2 full migration** — apply v2 template to M2 (5 chapters → ~6 micro-lessons), start at 2.1 Mom Test (~4-5 days)
2. **Landing page review against 30.03 + research** — audit `_index.md` against canonical spec + Sam journey reports (~2-3 hours, scope below)
3. **Phase 0 mechanical sweep** — deferred until pilot lessons complete (~2-3 hours).

## Current Active Scope

This tracker is the **single source of truth** for all post-ship improvements. Recommendations from review files (40.04, 40.05, 40.06) and research (10.08) have been consolidated here.

Current source of truth:

- Chapter order: `data/course_sequence.yaml`
- Project context and integration rules: `PROJECT-INDEX.md`
- ICP lens: `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`
- Voice lens: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`
- Research: `10-19-research/10.08-validation-tools-analysis-2026.md`
- Course overview: Chapter 0 (`how-this-course-works`) + landing page (`_index.md`)
- Course format requirements: `30-39-architecture-design/30.03-course-format-requirements-for-creators.md` (canonical spec for course creators)
- Low-impact ideas: `LOW-IMPACT-IDEAS-BANK.md` (this directory)

---

## ICP Practicality Improvement Backlog

Review lens: the course ICP - a non-technical founder going from idea (or half-built MVP) to first paying customer, who mostly has NOT hired yet. Burned/already-hired founders are a secondary audience routed to the rescue chapters (4.1/4.2) and the landing "If Your Team Is Already Failing" fast path - do not write validation/build chapter bodies to the burned founder. (Distinct from the website lead-gen ICP in `90.10-icp-primary-website-target.md`.)

Current practicality score: 7.5/10.
Target: 8.5/10 before launch.

| Priority | Task | Status | Notes |
|---|---|---|---|
| ✅ Done 2026-05-20 | Fix course landing module map | Done | Landing page module list merged to 5 modules (commit 32e064dd). Stale "Proactive Ceiling Signals" title fixed. |
| ✅ Done 2026-05-20 | Fix stale module/chapter numbering in companion pages | Done | Global `Module N.X` → `Chapter N.X` rename across 28 .md + 2 SVGs + YAML; 6-module → 5-module spine renumber; 3 companion pages (operating-kit, pivot-or-persevere, churn-triage) Module 7 references resolved. GOAL-AT-A-GLANCE rewritten to 5-module spine. 20.07 content plan marked superseded. |
| ✅ Done 2026-05-20 | Repair missing artifact link | Done (no-op) | Audit confirmed `/blog/founding-hypothesis-worksheet/` is not linked from any chapter. The tracker entry was stale from a prior cleanup pass. |
| ✅ Done 2026-05-20 | Remove unfulfilled download/email promises | Done (already correct) | Audit confirmed `first-paying-customer-operating-kit` already says "There is no email signup; when a template is downloadable, the link appears inline below. We will not promise files we cannot ship today." Matches course philosophy. |
| ✅ Done 2026-05-20 | Build 4 source-of-truth validators (Kaizen Muda outcome) | Done | All 4 validators implemented as `bin/validate-course` + `lib/course_validators.rb` (with test/unit/course_validators_test.rb): (1) chapter-number-consistency, (2) title-yaml-match, (3) internal-link-existence, (4) table-width. Hooked into `bin/hugo-build` as pre-flight check. Globs updated to handle nested `content/course/<namespace>/<slug>/` structure. 3 of 4 pass after course-namespace migration; 1 (internal-link-existence) has 24 pre-existing broken-citation violations to non-existent research articles - separate follow-up. |
| SUPERSEDED 2026-07-11 | Add "Burned founder fast path" to landing | Closed (grooming) | Superseded by the 2026-06-16 landing rework: "Already started building?" side-path + "Going further" 3 use-case clusters ARE the burned-founder routing, and per-chapter rescue blocks are explicitly banned (see 2026-05-22 reversal row). Course ICP is Sam; no further rescue framing on the course surface. |
| P1 | Create downloadable PDF templates + restore "Free templates" section on landing | Regroomed 2026-07-11 → Sprint C (thin slice: print-CSS pipeline + 5 printable worksheets first; landing restore when full set exists; other 9 gated on pilot download demand) | 2026-05-21: removed "Free downloadable templates" H2 + 14-row table from `_index.md` because the links pointed to in-browser chapter pages, not actual PDF downloads. The chapter pages still exist (Outreach Sequence Template, Mom Test Interview Script, Validated Problem Statement Template, Vibe PRD Template, Build Path Decision Worksheet, GitHub/AWS/DB Ownership Checklist, Self-Serve Stack Walkthrough, Where-to-Hire Map 2026, Hiring Interview Script, SOW Reading Guide, First-Paying-Customer Operating Kit, Friday Demo Template, Salvage vs Rebuild Decision Tree, "We Use AI" 5-Question Script). When the 14 PDFs are precreated, restore the landing section with the correct framing (PDF + browser-page link side by side). Cover image chip "TEMPLATES 14 free" stays unchanged - it remains accurate because the template chapter pages still exist as free in-browser resources. |
| SUPERSEDED 2026-07-11 | Add Founder Control Dashboard artifact | Closed (grooming) | Superseded by `first-paying-customer-operating-kit` - the 6-component control hub covers access/demos/reports/SOW/budget; its 5 remaining templates ship demand-driven (Sprint D #1). A second dashboard artifact would duplicate it. |
| P1 | Make every artifact copy-pasteable | Done | Each template page needs on-page scripts/checklists, not only descriptions of future assets. Prioritize SOW, DPA, outreach, hiring interview, ownership, Friday demo. All 6 done 2026-06-02: outreach quick-ref checklist, SOW agency email + pre-sign checklist, hiring interview pre-interview + polite-no emails, ownership audit spreadsheet + recovery email, Friday demo follow-up + skipped-twice message, DPA one-page template skeleton. |
| ✅ Done 2026-05-22 | Separate early-founder path from rescue path | Done | Decision reversed: chapter-level routing blocks removed, not rolled out. The Ch 1.1 "Already burned? / Already hired?" block was deleted 2026-05-22 - it interrupted the primary idea-stage ICP reader with two "leave this page" callouts before the hook, and duplicated the landing-page "If Your Team Is Already Failing" fast path (the real entry-point router for burned founders). Do NOT add per-chapter routing blocks to other module-start chapters; route burned founders at the landing page only. |
| ✅ Done 2026-06-02 | Add AI critic/simulator blocks per module | Done | Standardize where AI helps: critique artifact, simulate customer/vendor/advisor, find contradictions. State what AI cannot prove. One block per module = 5 blocks (new 5-module spine). M1.1: crystallized AI tools sidebar. M2.2: framed chapter as canonical AI simulator. M3.2: AI-as-peer callout standardized. M4.3: NEW build-review prompts (audit brief, check RLS, detect overengineering). M5.2: AI channel research framed as critic layer. Commit df9a537e.
| P1 | Roll manual-minimum sidebar to other tool-heavy chapters | Partial | 2026-05-20: 3 chapters got $0-budget callouts (Ch 1.2 smoke-test, Ch 4.3 self-serve-mvp-stack, Ch 5.5 outbound). Ch 2.2 already had manual-minimum sidebar. Audit remaining chapters (Ch 5.3, 5.4) for any unaddressed paid-tool friction. |
| SUPERSEDED | Add "Skip to the action" anchor links to longest chapters (40.05 Rec #1) | Superseded by 40.07 Rec #1 (2026-06-07) | Replaced by refined 40.07 version: targets M4.3a, M1.2a, M3.2 (narrowed from M1.1, M3.2, M4.3). See P2 item below for current. |
| DEFERRED | Add burned-founder acknowledgment callouts in Module 2 (40.05 Rec #2) | Deferred (2026-06-07) | **DEFERRED by user direction.** Burned-founder ICP improvements tabled as an idea. The course ICP is Sam (the idea-stage first-timer), NOT Alex (burned founder). See 40.07 for Sam-first alternative recommendations. |
| ✅ Done (v2 migration) | Add TL;DR summaries to all chapters — phased rollout (40.05 Rec #3) | Closed 2026-07-11 (grooming) | Every spine lesson carries the TL;DR slot via the v2 template (M1-M5 migrations, PRs #351-353). Remaining refinement is visual only: distinct TL;DR accent (Sprint B #4). |
| ✅ Done (v2 migration) | Add completion criteria to every chapter | Closed 2026-07-11 (grooming) | The v2 4-slot footer (Done / You have now / Next / If blocked) shipped on every spine lesson via PRs #351-353; conditional routing now also strip-level (branch-aware nav, PR #354). |
| CONVERTED 2026-07-11 | Tighten practical proof in weaker modules | Closed (grooming) | Too vague to act on after 3 review rounds found no concrete instance. Converted to Sprint D #4: fix what real pilot recordings show readers stalling on, not what internal review guesses. |
| P2 | Collapse outreach-sequence-template variant runs | Planned | 2026-05-23 audit found 3 variant groups rendered as 3 separate blockquote boxes each (LinkedIn DM openers ×3, cold-email subject lines ×3, possibly Day 1/3/7 email sequence ×3). Merge each group into ONE blockquote (use `>` blank-line separators) per the no-stacked-quotes rule. Lower priority because it's an artifact/template page, not a numbered linear chapter. |
| P2 | De-stack + rebalance "$0 path" callouts (outbound, self-serve-mvp) | Planned | 2026-05-23: two chapters still have a "$0 path / $0 outbound stack" blockquote callout immediately under the Module banner (top-stack). Bundle with the deferred Module 4/5 budget-rebalance pass - de-stack to plain prose AND rebalance the framing per `feedback_budget_stance_free_and_paid_equal` (free and paid as equal options, reader chooses; don't lead with "$0 first"). |
| P3 | Add Wizard of Oz Concierge MVP path to Ch 4.3 (10.08 Gap #2) | Planned | Add Tally + Zapier + Airtable as $0 no-code backend alternative to Lovable build for founders who should validate deeper before coding. Documented in 10.08-validation-tools-analysis-2026.md §Gap 2. |
| P3 | Add echo chamber warning to Ch 5.3 and Ch 2.3 (10.08 Gap #3) | Planned | Warn that warm network is for SALES (valid) not VALIDATION (invalid echo chamber). Add cross-reference from Ch 2.3 warning against interviewing only other founders. Documented in 10.08 §Gap 3. |
| P3 | Add Loom video outreach tactic to Ch 5.2 or 5.5 (10.08 Gap #4) | Planned | 10-minute personalized B2B video audits with higher conversion than cold email. Low effort, high differentiation. Documented in 10.08 §Gap 4. |
| P3 | Add Engineering as Marketing to Ch 5.2 (10.08 Gap #5) | Planned | Free No-Code micro-tools (calculators/checklists) for $0 CAC organic SEO. Distinct from content marketing. Documented in 10.08 §Gap 5. |
| Dropped | Add time-badge to each chapter header | Dropped (2026-06-02) | Each chapter needs a "**Time**: ~45 min" badge at the top so the reader can plan their session. 18 chapters. Dropped per user direction — time anchoring contradicts the ADR §1 policy of avoiding speculative effort estimates. |
| P3 (downgraded 2026-07-11) | Build companion-post FAQ collection | Backlog | Downgraded in grooming: the FAQ page + landing "Going further" clusters + the 40.17 nav work cover most of the moment-of-need linking. Revisit only if pilot readers ask questions the FAQ misses. |
| SUPERSEDED 2026-07-11 | Rescue-path routing audit | Closed (grooming) | Superseded by the 40.17 journey audit (44-page walk verified all module-boundary routing) + the standing 2026-05-22 decision that burned-founder routing lives at the landing page only. |
| ✅ Done 2026-06-16 | Course landing page (`_index.md`) review + fixes against 30.03 + 40.06/40.07 | Done (commit 770dab88) | Comprehensive audit + restructure shipped from 3-critic cold-eyes review (ICP Sam + voice-guide enforcer + 30.03 spec auditor). **Tactical fixes:** deleted duplicate "What this course does NOT cover" section, renamed Module index → Module map (anchor #module-map), tagged M4.4 OPTIONAL (matches M2.2/M5.2 pattern), collapsed module map template sub-bullets to inline parentheticals. **Structural fixes:** trimmed YC/Lenny/Reforge competitor block, reframed payoff section as Founder OS bundle, reorganized "Going further" into 3 use-case clusters (diagnose / agency / manage team), consolidated 5 conflicting start-here buttons into 4 conditional routes, added "6-10 weeks at evenings-and-weekends pace" time commitment (Sam BLOCKER: page never named a duration). **Voice cleanup:** killed slogany flips ("Investors fund evidence, not ideas" used twice, "NOT for you if", "If X / If not X" pairing, "Walk into the meeting before the first slide" cinematic), killed staccato ("Free. No sign-up. Start tonight."), removed "skip the diagnostic / no trauma" callout (in-joke for burned founders, not Sam), rewrote aphoristic + cinematic openers, added human subject to "Rails-first dev shop" bio. Word count 2,551 → 2,179 (-15% after Stickiness pass added 5 win-recap callouts). All 7 course validators pass. **Note on 40.07 Rec #3 (line 131 below):** the "no trauma" callout previously shipped under that recommendation was reworded; the underlying intent (clean first-timer routing) is preserved in the new 4-route start-here block. **Stickiness pass (2026-06-16 follow-up):** §6.2 progress narrative + §6.3 per-module win recap shipped as one `**Walk away with:** [artifact]. [progress reinforcement].` blockquote per module (5 total, after each module's chapter list). §6.6 downloadable Founder OS toolkit dropped from queue per user direction — in-page Founder OS framing carries the bundle promise without PDF infra. |
| P3 | Cover image regen audit for non-spine posts | Planned | 2026-05-20: 14 spine covers regenerated to clean "Curriculum 2026" badge. ~30 companion-post covers still have "Curriculum NN/30" stale counter. Regen via chrome-devtools at 2400×1260 if posts stay in active rotation. |
| ✅ Done | Update decision doc 20.10 with Click correction | Done | Decision block added at top of 20.10.md (2026-05-20) marking Recommendation section as superseded. TASK-TRACKER entry updated 2026-05-29. |
| ✅ Done 2026-06-04 | Add Sam customer journey report (40.06) with trust score methodology | Done | Single-ICP narrative spanning all 18 chapters + landing page. 3 entry-point doors. Per-chapter trust scores with emotional arc. Double-dip U-curve visualization. Appendix D: 19-row recalibrated trust score table with calibration constraints. Commit 63fb7d73. |
| ✅ Done 2026-06-07 | Add Sam experience improvement report (40.07) | Done | 6 actionable Sam-first recommendations across 18 chapters. Burned-founder ICP framing removed per user direction. Recommendations logged here for triage. See `docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.07-sam-experience-improvement-report-2026-06.md`. |
| ✅ Done 2026-06-07 | Archived 10.07 Sam walkthrough | Done | Superseded by 40.06 (definitive Sam reference) and 40.07 (canonical recommendations). Renamed to `_ARCHIVED_10.07-icp-sam-persona-course-walkthrough.md` with cross-reference note to 40.06 + 40.07. |
| ✅ Done 2026-06-07 | Published 30.03 course format requirements for creators | Done | Consolidated micro-learning spec + gap analysis + migration guide. Canonical requirements for course format design. See `30-39-architecture-design/30.03-course-format-requirements-for-creators.md`. |
| ✅ Done 2026-06-10 | Applied 5 Sam-simulation surgical fixes to pilot lessons | Done | Added Mixo re-prompt hint (1.2a Step 2), Mixo head-tag path (1.2b), domain question (1.2a Step 5), non-Chrome incognito shortcuts (1.2a Step 5), preview-mode script-blocking note (1.2b Step 4). ~80 words total. Sam simulation report: 40.11. |
| 🔲 P0 (UNBLOCKED 2026-07-11) | 5-Sam Validation Pilot — recruit 3-5 real founders, watch Clarity recordings | Sprint A #2 - course is complete, deferral condition met | Pivoted 2026-06-11: "pilot" in 2605 work = INTERNAL editorial template review (Paul-as-reviewer), NOT external recruitment. External kit deferred to post-course-completion at `40-49-review/40.18-external-validation-pilot-kit.md`. Original research questions preserved there for revival. |
| 🔄 P1 | Course-wide voice cleanup sweep | M1 fully done 2026-06-14 (all 5 lessons + Mia walkthrough + 1.2b title rename + frontmatter prefix consistency); M2 active — apply sweep to M2 chapters BEFORE v2 conversion (so v2 lessons inherit clean voice from the start); M3-M5 queued | M1 sweep applied uniformly: Hook ≤3 sentences, em-dash → hyphen, error blocks normalized to `If this fails: / Why: / Fix:` triple, closure migrated to 4-slot pattern (`Done` / `You have now` / `Next` / `If blocked`), Outputs/Outcomes re-cast to Sam-voice result-state, budget/tool callouts comparison-context-only. 1.2b title renamed from "Wire Tracking Before You Spend a Dollar" → "Wire Tracking Before Traffic Starts" across 7 files (1.2b frontmatter, 1.2a Bridge, _index.md, data/course_sequence.yaml, 30.03 spec example, this entry; 1.2b SLUG kept stable for URL/SEO stability). 1.2a + 1.2b frontmatter titles gained `1.2X · ` prefix for consistency with 1.1/1.2c/1.3. Mia walkthrough em-dash sweep + vocab sync with locked 1.2b ("GA4 snippet" not "Measurement ID") + 1.3 ("waitlist" not "free waitlist"). **M2 active:** apply same sweep to all 5 M2 v1 chapters BEFORE converting to v2 (so v2 lessons inherit clean voice from the start). Tomas walkthrough drafted after M2 lessons stabilize. M3-M5 queued for later phases. |

**5-Sam Pilot steps:**

| Step | Action | Est. time |
|---|---|---|
| 0.1 | Recruit 3-5 idea-stage founders (indie-hackers, Reddit r/startups, personal network). Screening: no tech background, has an idea they haven't validated, reads on phone. | ~2 hours |
| 0.2 | Post pilot lesson URLs (1.2a + 1.2b). Install Clarity on these pages. Instruct Sam to read both lessons and follow the Do-Now steps. | ~30 min |
| 0.3 | Wait 3-5 days for Sams to complete. Watch Clarity session recordings + heatmaps. Record: completion rate, time-on-page, scroll depth, stall points, rage-clicks. | ~2 hours |
| 0.4 | Synthesize findings: compare simulation predictions vs real behavior. Update Phase 2 template with any blind spots found. | ~1 hour |
| 0.5 | Decision gate: if ≥3 Sams complete with no systemic stall point, fan out to Phase 2. If same stall point appears in ≥2 Sams, fix template first. | ~30 min |

**Gate:** All 5 research questions have answers from real data. Template updated with findings.

**Phase naming note:** This pilot uses "0.1-0.5" step numbering to distinguish it from the deferred Phase 0 mechanical quick wins. M1 v2 is now complete — the pilot validated the format; M2 is the first full-scale module migration.
| ✅ Done 2026-06-07 | Add "Skip to the action" anchor links to longest chapters (40.07 Rec #1) | Done | Anchor-link callout added to M4.3a (6 links), M1.2a (4 links), M3.2 (4 links). Serves skim-first Sam. |
| ✅ Done 2026-06-07 | Reduce builder comparison fatigue in M1.2a (40.07 Rec #2) | Done | Builder list restructured as decision tree: Mixo (start here) → Manus AI (fallback) → Durable/NeetoSite/Carrd (only if experienced). Eliminated the "Default vs Fallback" two-tier framing. |
| ✅ Done 2026-06-07 | Add "First-timer fast path" to landing page (40.07 Rec #3) | Done | Callout added after hero section on `_index.md`: "New founder, no team, no trauma? Skip the diagnostic. Start at Chapter 1.1." |
| ✅ Done 2026-06-07 | Reposition M2.2 (AI Persona) as optional (40.07 Rec #4) | Done | Implemented option 2: added "Skip this if you've interviewed before" callout to M2.2 + tagged [OPTIONAL] on landing page module index. M5.2 also tagged [OPTIONAL] per 40.06 trust scores. |
| ✅ Done 2026-06-07 | Add "Stuck? Try this" boxes per module for first-timers (40.07 Rec #5) | Done | Stuck boxes added to M1.2a (builder paralysis), M2.3a (too-few-names), M3.2 (feature-list creep), M4.3a (12-rules overwhelm), M5.4 (asking-for-money terror). Placed after existing "If blocked" sections. |
| ✅ Done 2026-06-07 | Move M4.3 AI critic block before the 12 rules (40.07 Rec #6) | Done | AI critic block (3 Claude prompts for build audit, RLS check, scope leak detection) moved before the 12 rules section. Sam hits the actionable prompts first; 12 rules are the reference checklist after. |
| ✅ Done 2026-06-07 | Create one-page Quickstart (30.03 Option C) | Done | New page: `/quickstart/` — problem statement, promise, minimal path (core lessons only per module), gate thresholds, Start-here button. |
| ✅ Done 2026-06-07 | Create FAQ page (30.03 Option C) | Done | New page: `/faq/` — 15 Q&A across all 5 modules + general questions. Typical blockers: Stripe verification, Mom Test scores <7, builder paralysis, 12-rules overwhelm, asking for money. |
| ✅ Done 2026-06-07 | Create "What not to learn" section (30.03 Option C) | Done | Added to `_index.md` after "This is not for you if" — 7 explicitly excluded topics (coding, hiring CTO, VC, team mgmt, marketplace/mobile/AI, legal, SEO/marketing at scale).

---

## Closed today (2026-05-20)

| Done | Notes |
|---|---|
| 3-cycle UI/UX polish across 18 spine chapters | 94 issues fixed across Groups A-F |
| SEO frontmatter trims | 7 chapters trimmed for title ≤60 / desc ≤170 |
| YAML title alignment | vibe-coding-ceiling-signals YAML matched file title |
| Cover image regen | 14 spine covers, "Curriculum 2026" badge, ai-persona slogany dropped |
| Module → Chapter nomenclature | Global sweep across content/blog + YAML + 2 SVGs (28 .md files) |
| Ch 1.1 shame recovery paragraphs | 3 paragraphs after intro callout addressing burned-founder shame |
| Ch 1.1 non-linear routing | Top-of-page block: "Already burned?" / "Already hired?" route to 5.2 / 5.1 |
| Ch 1.1 Magic Lenses Money skip guidance | Pre-revenue founders can leave Money lens blank until smoke test data lands |
| Ch 2.2 manual-minimum sidebar | $0 alternative to the $300-500/mo tool stack before the 5-step sequence (was Ch 3.2 pre-merge) |
| Verified: "We..." opener density already at 0% in Ch 2.2 + Ch 5.3 (Group B polish caught this) |
| **5-module spine merge** | Module 1 (1 chapter) + Module 2 (2 chapters) merged into 3-chapter Module 1 (Hypothesis & Smoke-Test). All downstream modules shifted down by 1. Slug-stable. |
| YAML `goal:` field | Added one-sentence outcome per chapter to `data/course_sequence.yaml` (18 entries) |
| $0-budget reframe | Top-of-chapter callouts in Ch 1.2 (smoke-test: Neeto/Carrd free + organic), Ch 4.3 (self-serve-mvp-stack: Lovable+Supabase+Stripe free tiers, under $50 to first customer), Ch 5.5 (outbound: Apollo free + Gmail mail-merge + Loom free + Calendly free) |
| Module 2↔3 sequence swap DECIDED | Kept current order. Re-read Click's "Experiment" chapter: it's the lightweight landing-page-class test, NOT the heavier Design Sprint prototype + 5-user test. Our spine matches Click: Foundation (1.x) → Validate deeper (2.x) → Build. The reviewer's swap argument was anchored on "$300-500 ad spend before talking to anyone" — fixed by the $0-budget reframe instead of restructure. Decision doc: 20.10-sequence-decision-validate-vs-smoke-test.md |

---

## Course Migration Schedule (8-Part Template Rollout)

**Reference docs:** 30.03 §8 (migration guide), 40.08 (gap report — all 21 chapters at 1.0-1.5/8), Appendix A micro-lesson example

### Scheduling Principles

Six principles drive this schedule. The wrong order wastes hours; the right order compounds learning.

1. **Mechanical before creative.** Edits that follow a formula (add one outcome sentence, convert a table to a numbered list) require zero design brain. Do them all first while the mental model of the template is fresh. Creative rewrites (splitting a 3,000-word chapter into 4 micro-lessons) need the template to be second nature.

2. **Complete one module end-to-end before fanning out.** The trap: add hooks to all 21 chapters, then outcomes to all 21, then concept blocks to all 21. You never see a single lesson fully working until the last pass. Instead: finish Module 1 (4 chapters → micro-lessons) completely. Ship it. Learn what broke. Apply those lessons to Module 2. Each module gets better.

   **Exception: Phase 0 mechanical edits.** Adding one-sentence outcomes, success checks, and Stuck? boxes is purely formulaic — pull a YAML field, add a table row, name a common stall point. No design brain required. Fanning these out to all 21 chapters in one pass is safe and efficient. The principle applies to Phase 2 creative rewrites, where the risk of inconsistent bridges and broken handoffs is real.

3. **Pilot before scale.** The first micro-lesson rewrite takes 3× longer than the fifth because you're discovering the real constraints — how 300 words actually feels, where Mermaid diagrams break on mobile, whether the bridge dependency actually holds. Do a 1-chapter pilot, measure the real time, recalibrate the estimates, then scale.

4. **Top-of-funnel first.** Module 1 is where students decide to stay or leave. Improvements here have the highest conversion leverage. It's also the simplest module (no Supabase, no Stripe webhooks, no cold outreach). Start here to build momentum.

5. **Dependency order within modules.** Never rewrite a chapter that depends on artifacts from a chapter you haven't rewritten yet. The bridge handoff (template §2.8) requires both lessons to be stable. Rewrite modules in linear order: 1 → 2 → 3 → 4 → 5.

6. **High-complexity last.** Module 4 (Supabase wiring, Stripe webhooks, RLS policies) and Module 5 (paid pilot negotiation, cold outbound sequences) are the hardest to compress into 300-word concept blocks. By the time you reach them, you've done 10+ micro-lessons in simpler modules. The template is muscle memory.

---

### Phase 0: Remaining Quick Wins (DEFERRED — postponed until pilot lessons complete)

> **Naming note:** This "Phase 0" is the mechanical quick-wins pass (outcome sentences, success checks, Stuck? boxes). It is separate from **Option C** (Quickstart, FAQ, "What not to learn," 6 Sam fixes) which is complete per 30.03 §8.4. See 30.03 §8.5 for the consolidated web delivery roadmap.

**Status:** Deferred per user direction (2026-06-10). These are mechanical edits that don't require rewriting chapters — execute in one focused session when M2 migration momentum allows (~2-3 hours).

| Step | Action | Chapters | Est. time |
|---|---|---|---|
| 0.1 | Add one-sentence outcomes | 21 | ~42 min |
| 0.2 | Add success checks to "What to do next" tables | 21 | ~42 min |
| 0.3 | Roll out Stuck? boxes to remaining chapters | 16 (5 already done) | ~80 min |

**How:** Pull the `goal` field from `data/course_sequence.yaml` for each chapter's YAML frontmatter. Format: "After this chapter you will be able to: [goal]." Place after the Input/Output callout. For success checks: add a final row to each "What to do next" table — "✅ Success check:" with a verifiable condition. For Stuck? boxes: name the most common first-timer stall point for that chapter, give a concrete fix, place after existing "If blocked."

**Gate:** Hugo build passes. No content rewrites — these are mechanical additions.

---

### Phase 1: Pilot Micro-Lesson Rewrite (✅ COMPLETE 2026-06-08, ~3 hours actual)

**Status:** ✅ DONE. Chapter 1.2a (Smoke Test Build) migrated to 2 micro-lessons. Real time-per-lesson ~45 min (first draft + review). Template refinements + pilot findings recorded in "What just shipped" block above. Phase 2 can now proceed using the validated pattern.

| Step | Action | Est. time |
|---|---|---|
| 1.1 | Select pilot chapter | 5 min |
| 1.2 | Split chapter into 2-3 micro-lessons (concept boundaries) | 30 min |
| 1.3 | Write all 8 parts for each micro-lesson | 2 hours |
| 1.4 | Build Hugo, fix lint issues, verify on mobile viewport | 30 min |
| 1.5 | Code review + final polish | 30 min |
| 1.6 | Write post-pilot notes: actual time-per-lesson, surprises, template refinements | 15 min |

**Recommended pilot:** Chapter 1.2a (Smoke Test Build). Reasons:
- Lowest word count (2,364) → easiest to split
- Already at 1.5/8 (Stuck? box + anchor links + visual)
- Simple domain (landing page, not database schemas)
- Top of Module 1 — the first module gets rewritten first anyway
- Natural split points: builder choice → page elements → tracking setup

**Alternative if 1.2a is too tool-dependent:** Chapter 2.1 (Mom Test, 2,931 words). The 5 micro-lesson exploration drafts (Mom Test 3-lesson sequence + paid-pilot + mom-test-5-questions) were removed 2026-06-08 to start the migration from a clean slate. The pilot would be a fresh rewrite using 30.03 Appendix A as the canonical pattern.

**Gate:** One chapter fully migrated. Real time-per-lesson measured. Template refinements documented. Only then proceed to Phase 2.

---

### Phase 2: Module-by-Module Full Migration (~2-4 weeks, raises median to 6.5+/8)

**Status:** In progress. M1 complete (2026-06-16). M2 is the active sprint.

#### Module 1 — Hypothesis & Smoke Test (✅ COMPLETE 2026-06-16, ~4 hours actual)

5 chapters → 5 micro-lessons + 1 walkthrough. Simplest content, highest leverage. **SHIPPED.**

| Chapter | → Micro-lessons | Status |
|---|---|---|
| 1.1 Founding Hypothesis | 1 lesson | ✅ v2 live |
| 1.2a Smoke Test Build | 1 lesson | ✅ v2 live (pilot) |
| 1.2b Wire Tracking | 1 lesson | ✅ v2 live (pilot) |
| 1.2c Smoke Test Run | 1 lesson | ✅ v2 live |
| 1.3 Price Hypothesis | 1 lesson | ✅ v2 live |
| Walkthrough | Mia builds TutorMatch | ✅ published |

**Module 1 exit gate:** ✅ PASSED. All 5 micro-lessons follow 8-part template. Hugo build ✓. Mobile viewport ✓. Bridge chain verified (1.1 → 1.2a → 1.2b → 1.2c → 1.3 → M2 intro). Voice cleanup sweep ✓. Walkthrough published ✓.

#### Module 2 — Validate the Problem (~4-5 days)

5 chapters → ~6 micro-lessons. Medium complexity — the content is interview scripts and outreach, not technical. But it's the longest module.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 2.1 Mom Test | ~2 lessons | 5-question script → scoring rubric + synthesis decision |
| 2.2 AI Personas [OPTIONAL] | ~1 lesson | One standalone optional lesson — skip-safe |
| 2.3a Find People | ~1 lesson | ICP sharpening + community discovery + search strings |
| 2.3b Outreach | ~1 lesson | Outreach templates + booking cadence |
| 2.4 Clickable Prototype | ~1 lesson | Lovable prototype build + 5-user test signals |

**Module 2 exit gate:** All 6 micro-lessons follow template. Core path (2.1 → 2.3a → 2.3b → 2.4) produces validated problem statement without 2.2. Bridge chain verified.

#### Module 3 — Design from Evidence (~1-2 days) — IN PROGRESS on branch `module-3-design-from-evidence` (2026-07-09)

**Progress 2026-07-10:** whole-course 4-lens validity review run mid-sprint at user request - verdict VALID, 13 finding-classes fixed in 46b3f0a4 (M5 numbering collision on Going Further pages, 3 Sam persona leaks, volatile price hardcodes across 7 M4/M5 files, OpenHunts primary-source repoint, 35→30 canon, 32 ratchet sigs). Full report + carry-forwards: `40-49-review/40.15-whole-course-review-2026-07-10.md`. M4/M5 sprint scopes now pre-seeded by 40.15 §Deferred.

**Progress 2026-07-09:** steps 1-6 done - 3.1 v2 (ea8943ec, incl. course-wide 2.1→2.5 mislabel + Maven price sweep across 5.1/4.1/4.3a/worksheet/companion, 6 ratchet sigs), 3.2 v2 with I1-I3 (4a2ff457), Mia walkthrough + See-it-in-action + case-block removal (453fc5be), companion aligned + cover wired + 90-min contradiction fixed (95a5c23e), SVG-internal renumber leftovers fixed - visual QA caught 'Chapter 2.1' inside vibe-prd-template-visual.svg and pivot-ledger.svg, note the ratchet does NOT scan SVGs (3220e2f2, 498974ca). I4 verified already-compliant (2-forks section already sits below the template as a labeled flowchart). Covers verified current (no regen needed). Mobile: no overflow, mermaids compact. Orientation pages already correct for M3. 2026-07-10 finalization: 4-lens M3 fan-out (ICP/quality/voice/boundary) - all findings fixed in e854b3d9 (walkthrough coherence, rubric contradiction, callout stacks, glosses, Sarah-anecdote single-sourcing, Most-first-timers dodge in 4 Stuck boxes); visual scroll gate run on all 4 pages x 2 viewports (mermaid clipping + SVG border overflow + stale companion cover fixed, cover regenerated); scroll gate codified as blocking check in docs/workflows/visual-scroll-gate.md + CLAUDE.md + 30.03 §7 + 40.13 (a05424f5). PR #352 carries the full sprint.

> The original "2 chapters → ~3 micro-lessons" plan predates the M2 sprint and is superseded by this section. Revision grounded in: M2 shipped shape (PR #351), 40.13 process rules, 30.03 §2.7, and a fresh re-read of both M3 chapters on 2026-07-09.

**Prerequisite:** merge PR #351 first. Then branch `module-3-design-from-evidence` off fresh master. Cold agents read 30.03 + the M1/M2 v2 lessons + both Mia walkthroughs before touching M3.

**Shape decision (revised): 1 chapter = 1 lesson, NO splits.** M2 retired letter-splits and shipped 1:1; splitting 3.1 would mint a new slug, cover, and redirect churn for no reader gain. Numbering stays 3.1 / 3.2 (already flat, already on landing/quickstart/yaml - no renumber needed, which removes M2's biggest defect source). Word-count band: both chapters sit at ~2.8-3.0k words vs the 30.03 400-900 band - proceed under the same waiver-by-precedent as M2 (spec split-or-waiver decision remains an open carry-forward, not a blocker).

| Page | Slug (stable) | Work |
|---|---|---|
| 3.1 The One-Page Product Brief | `one-page-product-brief-vibe-prd` | v2 8-part template (Module 3 · Lesson 3.1 · CORE, Progress M3 · 1 of 2); remove in-lesson "Case Study: Tomas & Mia" block; fix defects 1-3 below; improvements I4-I5 |
| 3.2 Quality-check Your Brief | `stop-specifying-features-start-outcomes` | v2 template (Lesson 3.2 · CORE, Progress M3 · 2 of 2); remove case block; align "Artifacts you carry out of Module 3" with Founder OS framing; fix defect 4; improvements I1-I3 |
| Walkthrough (NEW) | `module-3-walkthrough-mia` | Mia drafts + quality-checks the TutorMatch brief. Seed content already exists in the two case blocks being removed (core 3 jobs, no-go list, job-story rewrites). M2 walkthrough's closing promise binds it: "Every feature on that page will trace back to a line a parent actually said." See-it-in-action lines land in the SAME commit (30.03 §2.7) |
| Companion | `vibe-prd-template` | Align with 3.1 v2 the way `outreach-sequence-template` was aligned with 2.4 last sprint: fix defect 5 below, adopt the M2-companion header format (Input/Output callout), verify cover exists |

**Known defects to fix regardless (found in the 2026-07-09 plan re-review):**
1. 3.1 body says "Chapter 2.1 synthesis" twice (Section 1 heading + "What comes next") - M2 renumber leftover; synthesis is now Ch 2.5. The Input callout was fixed in the M2 fan-out, the body was not. Add `Chapter 2.1 synthesis` to the ratchet in the same commit.
2. 3.1 "Founder OS · Artifact #4 of 6" hardcoded index - reconcile with the landing "You leave with" lines and the v2 footer style (name the artifact, drop the fragile index). 4.3b/5.4 keep theirs until their sprints.
3. 3.1 hardcodes the "$1,000 Maven cohort" price 3× plus a "4.8/5 reviews" score (section heading, intro, Further reading) - volatile third-party facts; convert to capability language + check-the-pricing-page note per the de-hardcoding policy.
4. Verify 3.2's `admin-panel-spaceship.svg` desc/alt text ("47 buttons") doesn't collide with the `47-button admin panel` ratchet signature; the illustration itself stays (informational, not decorative).
5. `vibe-prd-template` companion: header says "synthesis from **Chapter 2.1**" while linking the 2.5 synthesis page (same renumber-leftover class); "one-page one-page brief" doubled-word typo; "$1,000" Maven price echoed twice more.

**Content improvements IN scope (numbered; I1-I3 grounded in 40.06 trust-score friction, both chapters 7/10; I4-I5 grounded in documented CLAUDE.md content-organization rules):**
- **I1 - 3.2 hook reframe.** 40.06 records Sam's resistance verbatim: "I already wrote Section 3 in Chapter 3.1 - why do I need to rewrite it?" The v2 Hook (≤3 sentences) must earn the rewrite up front - the 20-minute rewrite is insurance against the $15K admin-panel spaceship - and the objection gets answered before the first exercise, not assumed away. *Lands in: 3.2 Hook + the sentence right after Input/Output.*
- **I2 - AI critic manual fallback.** 40.06 flags that 3.2's quality-check prompt requires a Claude account. Add the manual path (read each Section 3 sentence and ask: "is this a thing the user does, or a thing the software has?") per the manual-minimum policy. *Lands in: 3.2, directly under the existing AI quality-check prompt block.*
- **I3 - Explicit module gate in the Done footer.** M1 ends on go/iterate/kill, M2 on build/pivot/kill; M3's implicit pass ("4 of 5 sections outcome-shaped", currently buried in the case blocks being deleted) becomes the stated Done criterion. *Lands in: 3.2 Done footer ("Done when 4 of 5 brief sections read as outcomes; brief saved to Founder OS").*
- **I4 - "The 2 forks: Vibe PRD vs traditional PRD" → decision table.** The section is if-X-then-Y prose; the decision-aid rule (10.05 Part 2 / CLAUDE.md F-pattern rules) says render it as a compact decision table, and it currently sits BEFORE the 5-section walkthrough - demote it below the template so action comes first. *Lands in: 3.1.*
- **I5 - First-fold visual hook check.** Verify both lessons put an informational visual inside the first viewport at 1280×800 (hero rule, Pew 2026); `vibe-prd-template-visual.svg` / `feature-vs-outcome.svg` are the natural candidates if repositioning is needed. *Lands in: 3.1 + 3.2, verified in the visual-QA step.*

**Backlog rows this sprint closes for M3** (mark them in the ICP backlog table when done): P2 "TL;DR summaries" and P2 "completion criteria" for 3.1/3.2 - both are delivered inherently by the v2 template ("After this lesson you will be able to" + Done/Next/If-blocked footers).

**Content improvements OUT of scope (decided, don't relitigate):** no new lessons, no splits, no synthesis-style addition. M3's two-step arc (draft → quality-check) is sound, trust scores are healthy, and the module is deliberately the short breather between M2 interviews and the M4 build. OpinionX stack-ranking stays the optional callout it already is.

**Ordered steps (each gate before the next):**
1. Voice sweep on both v1 chapters BEFORE template conversion (em-dash, banned patterns, full ratchet run) - so v2 inherits clean voice.
2. Convert 3.1 (with I4), then 3.2 (with I1-I3) - dependency order; the 3.1→3.2 bridge names exactly which brief sections 3.2 audits.
3. Walkthrough + See-it-in-action lines + case-block removal in one commit.
4. Cross-page pass: landing/quickstart/FAQ/HTCW M3 rows; M2→M3 inbound promises honored (2.5 problem statement → Section 1 verbatim; 2.6 "describe in one sentence" vocabulary → Section 3; prototype code discarded, fresh M4 build); M3→M4 outbound intact (4.1 reads the brief for the build-path decision, 4.3 prompts Lovable from it).
5. Semantic-leftover pass (40.13): grep order-encoding prose ("next chapter", "proceed to", "after step") in every touched file.
6. Chrome-devtools visual QA at 1280×800 + 390×844: all 4 SVGs, both mermaid diagrams (height ≤ ~1600px), both covers (verify content is current - 2.3/2.5 covers turned out to be stale copies last sprint; regen from the family template if facts are wrong), first-fold visual hook per I5.
7. ONE fan-out review (find → dedup → adversarial verify) AFTER migration is complete; fixes reviewed as scoped diffs, never whole-world re-samples; every fix adds its ratchet signature in the same commit.
8. Mechanized gates: `bin/hugo-build` (8 validators) + `bin/rake test:critical`; `bin/dtest` too if any template/CSS file is touched; production link sweep.
9. ONE PR for the sprint.

**Module 3 exit gate:** both lessons on the 8-part template; walkthrough live and linked; boundary promises verified in both directions; all mechanized gates pass. Report format per 40.13: "all N mechanized gates pass; review round K found X" - never "everything is fine".

#### Module 4 — Build It Yourself (~4-5 days)

5 chapters → ~6 micro-lessons. **Highest technical complexity.** Supabase RLS, Stripe webhooks, SQL self-tests, 12 build rules. This is where the 300-word concept block constraint is hardest to satisfy.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 4.1 Hire Decision | ~1 lesson | Decision tree → path selection |
| 4.2 Ownership Audit | ~1 lesson | 12-item checklist → recovery email |
| 4.3a Stack Tools | ~2 lessons | What each tool does → pre-flight rules |
| 4.3b Build Phases | ~2 lessons | Phases 1-2 (UI + auth) → Phases 3-4 (Stripe + deploy) |
| 4.4 Ceiling Signals [OPTIONAL] | ~1 lesson | One standalone optional lesson |

**Module 4 exit gate:** All 6 micro-lessons follow template. Technical concept blocks pass the ≤300-word check. RLS + webhook concepts distilled to 3 sentences each. Bridge chain verified. Optional 4.4 skip-safe.

#### Module 5 — First Paying Customer (~4-5 days)

5 chapters → ~6 micro-lessons. Highest emotional stakes — asking for money, cold outreach, PMF testing. The paid pilot DPA template is the hardest single block to compress.

| Chapter | → Micro-lessons | Key split |
|---|---|---|
| 5.1 PMF Test | ~1 lesson | Survey setup → 40% threshold interpretation |
| 5.2 Channel Selection [OPTIONAL] | ~1 lesson | One standalone optional lesson |
| 5.3 Personal Network | ~1 lesson | 8-name audit → outreach motion |
| 5.4 Paid Pilot | ~2 lessons | DPA template → Stripe deposit + kickoff cadence |
| 5.5 Cold Outbound [OPTIONAL] | ~1 lesson | Filter → personalize → Loom → Calendly pipeline |

**Module 5 exit gate:** All 6 micro-lessons follow template. DPA template split into concept block (<300 words) + do-this-now steps. Bridge chain verified. Win recap + share prompt on final lesson. Completion Toolkit bundle linked.

---

### Phase 3: Cross-Cutting Polish Pass (~2-3 days)

**Status:** Not started. After all 5 modules are rewritten, do a single pass across all lessons to ensure consistency.

| Step | Action | Est. time |
|---|---|---|
| 3.1 | Verify every bridge names a specific dependency (not just "Next: Ch X") | ~1 hour |
| 3.2 | Verify core path alone produces all 6 artifacts without touching optional lessons | ~30 min |
| 3.3 | Verify emotional arc (40.06 trust curve) is preserved across micro-lessons | ~1 hour |
| 3.4 | Verify all 6 artifacts are bundled in final Completion Toolkit reference | ~30 min |
| 3.5 | Mobile viewport test on all lessons (375px iPhone SE) | ~1 hour |
| 3.6 | Full Hugo build + validate-course + link checker | ~30 min |
| 3.7 | Update landing page module maps to reflect new lesson structure | ~30 min |
| 3.8 | Update Quickstart to reflect micro-lesson path | ~30 min |
| 3.9 | Final code review | ~30 min |

**Phase 3 exit gate:** All lessons pass template QA checklist (30.03 §7). Hugo build ✓. validate-course ✓. Mobile viewport ✓. Emotional arc preserved. Core path produces all artifacts.

---

### Total Estimated Effort

| Phase | Description | Est. time | Cumulative median score |
|---|---|---|---|
| Phase 0 | Quick wins (mechanical) | ~2 hours | 1.0 → ~2.5/8 |
| Phase 1 | Pilot micro-lesson rewrite | ~~~4 hours~~ ✅ COMPLETE 2026-06-08 | Proof of concept |
| Phase 2 | Module-by-module full migration | 🔄 In progress (M1 done, M2 active) | M1: 6.5+/8; M2-M5: pending |
| Phase 3 | Cross-cutting polish pass | ~2-3 days | 6.5 → 7.0+/8 |
| **Total** | | **~2-4 weeks remaining (M2-M5 + polish)** | **1.0 → 7.0+/8** |

> **Day estimates in Phase 2 include:** writing + Hugo build verification + mobile viewport check + bridge chain verification per module. Not pure writing time — the overhead of splitting chapters, designing bridge dependencies, and compressing concept blocks is baked in.

> **Why the range:** Phase 2 is `2-4 weeks` based on pilot data from Phase 1 (~45 min per lesson real time). The 30.03 Appendix A example took ~30 min for one lesson; at 20-25 lessons, that's 15-19 hours of pure writing. But splitting chapters, designing bridges, compressing concept blocks, and fixing mobile issues adds overhead. The 2-week estimate assumes 4 lessons/day (sustainable pace after pilot); the 4-week estimate allows for Module 4's technical complexity and Module 5's emotional-stakes rewrites.

---

### Risk Mitigation

| Risk | Mitigation |
|---|---|
| Phase 2 stretches past 4 weeks | Ship module-by-module. Each module is independently shippable — Module 1 can go live while Module 2 is still being written. Never block the whole release on the last module. |
| Phase 0 work is deferred until after pilot lessons complete | Phase 0 costs ~2-3 hours. Deferred per user direction (2026-06-10) so pilot momentum is not interrupted. Execute when pilot lessons are stable and Phase 2 begins. |
| Technical chapters (4.3a, 4.3b) can't compress to 300 words | Allow 400-word concept blocks for technical chapters with hard constraints (RLS, webhooks). The template says ≤300; the spirit is "no bloat." A 400-word block that genuinely needs the space is better than a 300-word block that omits a critical concept. Flag these as exceptions in the rewrite notes. |
| Bridges break when upstream lesson changes | The Phase 3 bridge audit catches these. Do NOT try to get bridges right on first pass — expect them to need adjustment when the full chain is visible. |
| Phase 1 pilot diverges from 30.03 Appendix A worked example | 30.03 Appendix A is the canonical pattern. If Phase 1 discovers the pattern needs refinement, update 30.03 (with user approval) — do not let the pilot silently set a different precedent. |
| Mobile viewport issues discovered late | The Phase 3 viewport test is a safety net, not the primary check. Test each module's lessons on mobile as part of the module exit gate. Don't defer all mobile testing to the end. |

---

## Practicality Model Chapters

Preserve these as the standard for future edits:

- Ownership audit
- Friday demo
- Weekly report
- SOW review
- Salvage/rebuild
- Switch dev shops
- AI agency questions
- AI token bill
- Slopsquatting gate
