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

## Register-pilot mechanics (learned building pilots A and B)

**A pilot stub is a COPY of the previous pilot's, not a rewrite.** Pilot B's
stub was produced with `cp` and then three edits (title, description,
`register`/`font`); `diff` between the two stubs shows six lines and nothing
else. If the copy drifts, the demo compares two skins AND two texts and
measures neither. Give the pilots the same screenshot assertions for the same
reason - a copy edit that reaches only one pilot then fails a test.

**The accent that passes on paper can fail catastrophically when the band
inverts.** The dark testimonial/closing band is part of the settled anatomy, so
every register meets it, and a register whose own artifact has no dark band has
to invent one. Measured for the Artifact Editorial palette:

| pair | ratio | verdict |
|---|---|---|
| accent `#a91918` on paper `#fbf9f8` | 7.05:1 | AA |
| accent `#a91918` on ink `#1b1c1c` | **2.31:1** | FAIL - and this is what pilot A shipped |
| light label `#c9c2ba` on ink | 9.69:1 | AA |
| lightened accent `#e07a6e` on ink | 5.84:1 | clears 3:1 for the graphic rule |

So on an ink band: text takes a light neutral, the accent survives only as a
LIGHTENED cut on non-text rules, and a filled accent button becomes an inverted
paper one - an accent fill against a `#232424` card sits at ~2.2:1, a button
with no visible edge (WCAG 1.4.11). **Measure in the browser, not in the head**:
walking every text node's computed colour against its resolved background
checked 117 elements per viewport and is the only evidence that "every pair
passes" is a fact rather than an intention.

**A gate pinned to one pilot's path stops guarding the moment pilot N+1
lands.** `next_rail_test.rb` had the testimonial-verbatim and tenure-derived
gates pinned to the pilot-A path, so pilot B could have smoothed the Wozniak
quote undetected. Both now iterate the same `next/pilots/**/index.html` glob,
with the "found nothing" assertion inside the shared helper so no caller can
iterate zero pages and report green. Widen these when adding a pilot, and prove
it by breaking the new pilot's copy and watching the failure name that file.

**A class the shared template hands you can be silently outranked by your own
tag-scoped default.** `landing.html` marks the comparison's "theirs" column
`.rr-td-muted` (0,1,0), but a register that sets `.rr-table tbody td` (0,1,2)
for its body colour beats it, and the column renders in full ink - the
comparison stops comparing while the CSS still READS correct. Found in pilot C
by walking computed colours (`oursColor !== theirsColor` per row); the same
shape is live in `next-editorial.css`, so pilot B's muted column is its body
tone. Scope the override past the default (`.rr-table tbody .rr-td-muted`).
Applies to every class the template supplies: assert the computed value, never
the declaration.

**The accent does not always die on the inverted band - measure YOUR cut.**
Pilot B's deep red is 2.31:1 on ink and had to invert to paper. The standard
ruby `#cc342d` is 3.46:1 on `#18181b`: still under the 4.5:1 text floor, but
over the 3:1 a filled button's edge needs, with white on ruby at 5.13:1
inside it - so pilot C's closing CTA stays ruby. The rule is "no accent TEXT
on ink", not "no accent on ink". A register drawn in hairlines must also step
its structural rules up when the ground inverts (`#71717a`, 3.67:1) or the
geometry that IS the design dissolves.

**Self-hosted faces: one file per REGISTER when a register needs several.**
The stub's `font:` key carries one stylesheet and one preload, so a three-family
register ships `static/css/fonts-<register>.css` rather than three
`fonts-<family>.css` files and an edited shared template. Variable families
serve every declared weight from ONE latin binary, which is why two
`@font-face` rules can point at the same URL. A register-keyed stylesheet may
also point at a binary ANOTHER register already shipped - pilot C declares its
own JetBrains Mono face against pilot B's `/fonts/jetbrains-mono-latin.woff2`
rather than committing a second copy of the same bytes.

Ship only the weights the artifact actually uses - then **walk computed
`font-weight` in the rendered page**, because a declaration grep cannot see
inherited weights and a face asked for a weight it does not ship gets
FAKE-BOLDED by the browser. Missed exactly that way on 2026-08-21: JetBrains
Mono shipped 400 only, but the brand mark inherited 700 from `.rr-brand` and
the nav button inherited 600 from `:where(.rr-nav-links a)`, so the same mono
label rendered heavier in the nav than in the hero. The walk that catches it
resolves `fontFamily` per node and histograms `fontWeight`: every mono node
must read 400. Pin `font-weight` on any component that sets `font-family` to a
single-weight face.

# Citations

- Research + candidate shortlist: `docs/projects/2608-site-design-system/10-19-research/10.01-design-register-research-2026-08-reference.md`
- Plan of record: `docs/projects/2608-site-design-system/20-29-strategy/20.06-clean-slate-v2-plan.md` §Flow revision
