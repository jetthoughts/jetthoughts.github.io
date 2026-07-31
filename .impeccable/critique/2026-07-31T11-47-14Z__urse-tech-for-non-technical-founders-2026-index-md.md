---
target: course landing page
total_score: 25
max_score: 36
na_heuristics: 9
p0_count: 0
p1_count: 3
timestamp: 2026-07-31T11-47-14Z
slug: urse-tech-for-non-technical-founders-2026-index-md
---
Method: dual-agent (A: critique-a-design · B: critique-b-detector)

# Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3 | No position/progress affordance on a 10.8k-px page; quiet visited-marks only |
| 2 | Match System / Real World | 3 | Glossing is superb; "rescue projects since 2005" speaks to the wrong ICP |
| 3 | User Control and Freedom | 3 | Good escape hatches; no back-to-top on the long scroll |
| 4 | Consistency and Standards | 3 | Module cards very consistent; brand vs legacy visual worlds coexist awkwardly |
| 5 | Error Prevention | 3 | "Start here if / Skip if" gates genuinely prevent wrong-lesson entry |
| 6 | Recognition Rather Than Recall | 2 | ~10-link same-blue runs per module footer force recall |
| 7 | Flexibility and Efficiency | 3 | Quickstart, optional flags, already-building side-path |
| 8 | Aesthetic and Minimalist Design | 2 | Weakest axis: one visual, then ~10k px of Roboto prose/links/tables |
| 9 | Error Recovery | n/a | Static page, no error states to recover from |
| 10 | Help and Documentation | 3 | FAQ + How-This-Works + Quickstart linked up top |
| **Total** | | **25/36 (69%)** | **Acceptable, just under Good** |

# Design Specificity Verdict

**LLM assessment (A)**: split personality. The copy is meticulously authored for this exact product and persona - real lesson titles, in-line jargon glosses, per-module "You leave with" artifacts, honesty sections nobody could transplant. The visual system is category-interchangeable: 100% Roboto, no display face, legacy-blue links, plain white cards; the lone JetVelocity cover image is the only branded pixel. Bespoke content wearing a template's clothes.

**Deterministic scan (B)**: 157 CLI findings, of which ~150 are token-mismatch advisories against the wrong token file (false positives). Signal: 3 overused-font/design-system-font warnings converging on the same monotony A found. Live computed-style scan: 8 findings - the real ones are **white-on-#1a8cff at 3.4:1 (WCAG AA fail, needs 4.5:1)**, single-font roboto at 100% of text, and one 4px-padded list item; 3 tight-leading hits were on style/script nodes (false positives). Zero console errors, zero 404s, clean metadata.

**Where they converge (high confidence)**: the single-font/no-display-type monotony is both A's #1 "looks generic" driver and B's top computed-style finding. The legacy-blue issue appears in both: A calls it off-brand, B proves it fails AA.

# Overall Impression

The page reads like it was written by someone who deeply knows Sam and looks like it was styled by nobody. Trust architecture in the copy is genuinely excellent - and then the global consulting footer spends that trust at the exact last impression. The single biggest opportunity: make the page LOOK as authored as it READS (brand display type + brand action color), and make the last screen keep the page's own promise.

# What's Working

1. **Jargon-glossing discipline** - Mom Test, Lovable, Supabase, MVP all defined in-line at first mention. ICP-perfect and rare.
2. **Trust architecture** - competitor pointer (YC Startup School), 7 honest exclusions, humble "Who built this", zero service asks in the body.
3. **Module card as a repeatable IA unit** - eyebrow → title → Output → gate → lessons → templates → "You leave with". Predictable and scannable.

# Priority Issues

1. **[P1] Peak-end sales footer.** The global service footer (Fractional CTO, Free Code Audit, Contact Us, "we're hiring") contradicts "free / no signup / no sales" at the final impression - the exact trust the body just earned. Fix: suppress the service footer on course pages OR add a course-owned end-cap (repeat "Start Lesson 1.1" + "send it to a founder friend") above it. Suggested: /impeccable polish (scoped to course list template).
2. **[P1] CTA contrast + off-brand action color.** White on legacy blue #1a8cff measures 3.4:1 - a real WCAG AA failure on the primary action - and the blue is not a JetVelocity ink. One fix solves both: course-surface CTAs move to brand ruby with an AA-verified pairing. Suggested: /impeccable colorize.
3. **[P1] No brand display type.** 100% Roboto; the hero H1 - the page's biggest brand moment - is default weight. Space Grotesk 800 on hero H1 + section H2s builds hierarchy and brand in one move (A's single biggest "generic" driver; B's detector agrees). Suggested: /impeccable typeset.
4. **[P2] Intro decision overload.** Hero fires 2 CTAs + 4 chips, then the intro paragraph adds ~5 rival links - about 7 competing next-actions before Module 1 (cognitive-load failures: 6 of 8 checklist items). Fix: keep the hero's 2 CTAs + one tertiary "see the full syllabus"; demote FAQ/how-it-works to a small secondary row. Suggested: /impeccable distill.
5. **[P2] Module-footer link runs.** "Templates: A·B·C · Optional reference: D·E · See it in action: F" renders ~10 undifferentiated same-blue links wrapping mid-phrase - a recognition failure on desktop and a one-thumb mis-tap trap on mobile (B: 4px-padded list item corroborates). Fix: labeled rows or chips, or a single "More resources" disclosure. Suggested: /impeccable layout.

# Persona Red Flags

- **Jordan (first-timer)**: hero answers "what do I click", then the intro paragraph re-opens the question with 5 rival links.
- **Casey (mobile, one thumb)**: hero is excellent full-width; module-footer link runs are the mis-tap trap; stat chips wrap 3+1.
- **Riley (stress tester)**: the "dev-audit overlay" that mutated the DOM mid-scroll was Assessment B's own injected detector overlay leaking across shared browser tabs - a critique-tooling artifact, NOT a product defect (production ships no such script; console is clean). 10.8k-px scroll with no back-to-top stands.
- **Sam (stealth idea-stage)**: "the evidence pack investors fund" injects fundraising anxiety pre-commit; footer's consulting links undercut the no-sales promise; "rescue since 2005" is the wrong ICP's story.

# Minor Observations

- "Free · 2026" badge hardcodes a year and will date.
- First ~3 screens: one cover image then pure prose before any module card (Pew 3-second-hook rule strains).
- 4 structurally identical trigger tables in "Going further" could merge into one categorized table.
- Every link is legacy blue; ruby/purple appear nowhere in the body.

# Questions to Consider

1. If the whole pitch is "free, no signup, no sales", why does every exit sell consulting? Which promise wins at the bottom of the page?
2. Is the visual plainness deliberate no-marketing-gloss trust-signaling, or unfinished brand - and would Sam trust the page MORE if it looked as authored as it reads?
3. Does the hero need 6 links, or is "Start Lesson 1.1" + "see the syllabus" the whole decision?
