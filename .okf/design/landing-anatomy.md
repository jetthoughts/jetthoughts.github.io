---
type: design-principle
title: Landing anatomy is settled; register is the variable
description: Service/sales pages share one landing skeleton; design comparisons vary only the visual register on top of it
tags: [design, landing-page, redesign, v2]
timestamp: 2026-08-21T00:00:00Z
---

# Landing anatomy is settled; register is the variable

A design **system** is not a page **design**. Applying good tokens to article
anatomy produced a page Paul read as "a blog, not a presentation" (PR-2,
2026-08-21). Sales pages are designed as landing pages; the reusable system is
extracted from shipped pages afterwards — never the reverse.

## The settled skeleton (three independent sources converged)

Problem-naming hero (+ dual CTA + de-risk line + stat strip) → month-one card →
decision table (vs the alternatives) → free-audit-first timeline → case cards →
named verified testimonial (dark band) → closing CTA. Convergence: Paul's
Claude Design artifact `3dc819cf`, the 20.05 spec, and the 2026 external sweep
(`docs/projects/2608-site-design-system/10-19-research/10.01-design-register-research-2026-08-reference.md`).

## Rules

- Pilots/comparisons vary the **register** (palette, type, surface language)
  on the shared skeleton — never anatomy and skin at once, or the comparison
  measures nothing.
- Proof sits near decision points, not in a basement section; CTAs repeat at
  multiple scroll points; forms ≤5 fields.
- Every number on the page passes [/content/claims-canon.md](/content/claims-canon.md)
  BEFORE styling work starts; tenure derives from `site.Params.foundingYear`.

# Citations

- Research + candidate shortlist: `docs/projects/2608-site-design-system/10-19-research/10.01-design-register-research-2026-08-reference.md`
- Plan of record: `docs/projects/2608-site-design-system/20-29-strategy/20.06-clean-slate-v2-plan.md` §Flow revision
