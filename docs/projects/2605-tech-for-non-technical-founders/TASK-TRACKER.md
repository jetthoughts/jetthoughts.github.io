# Task Tracker - 2605 Tech for Non-Technical Founders

**Last Updated**: 2026-05-20 (triage from 3 review reports + Module->Chapter rename + Ch 1.1 enhancements)
**Status legend**: Planned | Drafting | In review | Done | Paused | Dropped

---

## Current Active Scope

This tracker only covers post-course cleanup required before launch.

Current source of truth:

- Chapter order: `data/course_sequence.yaml`
- Project context and integration rules: `PROJECT-INDEX.md`
- ICP lens: `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`
- Voice lens: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`

---

## ICP Practicality Improvement Backlog

Review lens: ICP-E, burned non-technical founder hiring or escaping a dev shop.

Current practicality score: 7.5/10.
Target: 8.5/10 before launch.

| Priority | Task | Status | Notes |
|---|---|---|---|
| P0 | Module 2 ↔ Module 3 sequence swap decision | **Decision needed** | ICP-E review argues smoke-test (spend $) before validation (talk) is backwards for burned founder. Counter: current order matches Rob Walling Stairstep (smoke-test first for conviction). Needs strategic call before implementation - cascade-destructive across YAML + 18 chapter cross-refs. |
| P0 | Fix course landing module map | Planned | `tech-for-non-technical-founders-2026` still says oversight = Module 8, salvage = Module 9, AI = Module 10. Current sequence is oversight = 6.2, salvage = 8, AI = 9. |
| P0 | Fix stale module/chapter numbering | Partial | 2026-05-20: global `Module N.X` → `Chapter N.X` rename across 28 .md + 2 SVGs + YAML. Still pending: standalone `Module 7/8/9/10` strings in landing/template tables. |
| P0 | Repair missing artifact link | Planned | `form-your-founding-hypothesis-90-minute-sprint` links to `/blog/founding-hypothesis-worksheet/`, which does not exist. Create page or redirect to an existing worksheet artifact. |
| P0 | Remove unfulfilled download/email promises | Planned | Template pages must be usable on-page or backed by a real file/form. `first-paying-customer-operating-kit` currently says "Send your email below; we ship the zip the same day." |
| P1 | Add "Burned founder fast path" to landing | Planned | Emergency route: Ownership audit -> Friday demo -> weekly report -> salvage/rebuild -> switch dev shops -> AI risk. Put before the full course table. (Per-chapter routing added to Ch 1.1 on 2026-05-20.) |
| P1 | Add Founder Control Dashboard artifact | Planned | One-page control system for access, demos, reports, SOW, budget, AI risk, and salvage score. Tie the strongest ICP-E chapters together. |
| P1 | Make every artifact copy-pasteable | Planned | Each template page needs on-page scripts/checklists, not only descriptions of future assets. Prioritize SOW, DPA, outreach, hiring interview, ownership, Friday demo. |
| P1 | Separate early-founder path from rescue path | Partial | Ch 1.1 now has top-of-page routing block ("Already burned?" / "Already hired?") on 2026-05-20. Roll same pattern out to other module-start chapters (2.1, 4.1, 5.1, 6.1). |
| P1 | Add AI critic/simulator blocks per module | Planned | Standardize where AI helps: critique artifact, simulate customer/vendor/advisor, find contradictions. State what AI cannot prove. One block per module = 6 blocks. |
| P1 | Roll manual-minimum sidebar to other tool-heavy chapters | Planned | Ch 3.2 got the "$0 manual version" sidebar on 2026-05-20 (the 8+ tool stack was a cognitive cliff). Audit Ch 6.3, 6.4, 6.5 for similar tool density and apply same sidebar pattern where appropriate. |
| P2 | Add completion criteria to every chapter | Planned | Each chapter should end with "Done when / Next click / If blocked" so the founder knows when to move on. Template: `## Done when` + checklist + `## Next click` + conditional routing. 18 chapters. |
| P2 | Tighten practical proof in weaker modules | Planned | Early validation and market-type chapters need more concrete founder examples, exact time boxes, and decision thresholds. |
| P3 | Cover image regen audit for non-spine posts | Planned | 2026-05-20: 14 spine covers regenerated to clean "Curriculum 2026" badge. ~30 companion-post covers still have "Curriculum NN/30" stale counter. Regen via chrome-devtools at 2400×1260 if posts stay in active rotation. |

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
| Ch 3.2 manual-minimum sidebar | $0 alternative to the $300-500/mo tool stack before the 5-step sequence |
| Verified: "We..." opener density already at 0% in Ch 3.2 + Ch 6.3 (Group B polish caught this) |

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
