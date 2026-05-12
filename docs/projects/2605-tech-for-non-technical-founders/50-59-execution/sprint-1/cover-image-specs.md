# Sprint 1 Cover Image Specs

**Purpose**: define the Stitch HTML cover-image specs for the 3 Sprint 1 posts. Each post's cover.png renders from a 6-slot HTML template per `.stitch/design.md`. This file gives the writer / cover-image-generator agent the exact slot fills.

**Design system reference**: `.stitch/design.md` (JetVelocity — obsidian dark, Ruby red #cc342d, neon purple #a855f7).

**Workflow**: write the HTML at `.stitch/designs/<slug>-cover.html` → render via chrome-devtools (2400×1260 viewport) → downsample to `content/blog/<slug>/cover.png` via ImageMagick.

---

## Cover 1 — Module 0.1 Course Map + Self-Assessment

**Slug**: `course-map-self-assessment-non-technical-founder-2026`
**HTML path**: `.stitch/designs/course-map-self-assessment-cover.html`
**Final PNG**: `content/blog/course-map-self-assessment-non-technical-founder-2026/cover.png`

**Slot fills**:

| Slot | Content |
|---|---|
| Title (large, top-left) | Where Are You / In the Founder / Journey? |
| Subtitle | 10 questions · 5 minutes · routes you to your starting module |
| Category badge | Course Map · Free |
| Visual centerpiece | Stylized flowchart/decision-tree visual with 8 module boxes on right; Q1-Q10 cluster on left with arrows feeding into module boxes. Obsidian dark background. Ruby-red arrows on the YES paths, neon-purple on NO paths. |
| Chips (3 floating) | "8 modules" / "Free" / "5-minute self-assessment" |
| Status indicator | Course Entry Point |

**Voice**: course-onboarding, not aggressive. The cover signals "this is where you start," not "BUY THIS COURSE."

---

## Cover 2 — Module 1.1 Find 10 People With the Problem

**Slug**: `find-10-people-with-problem-outreach-2026`
**HTML path**: `.stitch/designs/find-10-people-outreach-cover.html`
**Final PNG**: `content/blog/find-10-people-with-problem-outreach-2026/cover.png`

**Slot fills**:

| Slot | Content |
|---|---|
| Title | Find 10 People / With the Problem / in 2026 |
| Subtitle | Reddit + Clay + Lindy + paid panels = 10 interviewees by Friday |
| Category badge | Module 1 · Validate |
| Visual centerpiece | A weekly calendar visual showing 5 days (Mon-Fri) with calendar slots filling in: Mon empty / Tue 2 slots / Wed 5 slots / Thu 8 slots / Fri 10 slots. Each slot a small avatar circle. Ruby-red highlights on the slots booked via paid panels; neon-purple on Reddit-sourced. |
| Chips | "Clay · $149/mo" / "Lindy AI agent" / "10 calls by Friday" |
| Status indicator | Sprint 1 / Module 1 |

**Voice**: practical-tactics. The cover signals "this teaches the actual booking sequence."

---

## Cover 3 — Module 1.2 The Mom Test

**Slug**: `mom-test-ask-about-past-not-future`
**HTML path**: `.stitch/designs/mom-test-cover.html`
**Final PNG**: `content/blog/mom-test-ask-about-past-not-future/cover.png`

**Slot fills**:

| Slot | Content |
|---|---|
| Title | The Mom Test: / Ask About the Past, / Not the Future |
| Subtitle | 5 questions that stop your interviewees from being polite |
| Category badge | Module 1 · Validate |
| Visual centerpiece | A speech-bubble visual: two side-by-side bubbles. Left bubble (ruby-red border, "BAD"): "Yeah, I'd totally pay for that!" Right bubble (forest-green border, "GOOD"): "Last Tuesday at 9pm I spent 40 minutes copying spreadsheets..." Arrow between them labeled "the Mom Test." |
| Chips | "5 questions" / "Past behavior > hypothetical" / "Score 1-10" |
| Status indicator | Sprint 1 / Module 1 |

**Voice**: contrarian-tactical. The cover signals "this prevents the lying-by-politeness trap."

---

## Generation order

After each Sprint 1 post is drafted + reviewed, the cover-image step runs as the LAST gate before publish:

1. Read this file for the slot fills.
2. Write the HTML at `.stitch/designs/<slug>-cover.html` using the existing `.stitch/designs/reading-sow-clause-by-clause-cover.html` as a structural template (it's the most recent shipped cover).
3. Render with chrome-devtools at 2400×1260 viewport.
4. Downsample via ImageMagick to standard cover dimensions.
5. Save to the post's bundle directory as `cover.png`.
6. Confirm frontmatter references match: `cover_image: cover.png` + `metatags.image: cover.png`.

If the cover-image-generator agent finds it cannot render (chrome-devtools unavailable, etc.), it surfaces to the user. The cover is NOT mandatory for first draft delivery — the agent can ship the markdown without the cover, and the cover renders in a separate downstream step.
