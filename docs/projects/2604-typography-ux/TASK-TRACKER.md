# Task Tracker — 2604 Typography & UX

**Last Updated**: 2026-07-21
**Status legend**: Planned | In progress | Done | Paused | Dropped

---

## Open Site-Level Typography/UX Backlog

| Priority | Task | Status | Notes |
|---|---|---|---|
| P2 | Site-level: investigate blog article column max-width (684px → wider?) | Planned | The 684px article column constraint on blog/course pages forces Mermaid LR diagrams ≥5 nodes to fail, SVG-with-prose-text to clip, 5-col tables to overflow on 390px mobile. Investigation: is the 684px max-width a deliberate readability choice (Bringhurst-style 45-75 char line length) or a vestigial theme value? Compare with thoughtbot, Stripe Press, Indie Hackers content widths. Decide: keep 684px (and design content within budget) OR widen to 720-800px (and adapt visual breaks to use more horizontal space). Surfaced 2026-05-20 during course-polish marathon — multiple visual breaks had to be reshaped/dropped because of width constraints. Per memory `feedback_684px_column_visual_constraints.md`. |
| P2 | Reader-mode screenshots as a post-QA / reader-UX tool | Planned | Capture Chrome reader-mode screenshots of our own rendered post/course pages. Reader mode strips chrome/nav and reflows to a clean typographic column - reading it that way surfaces reading-experience defects (line length, hierarchy, rhythm, orphaned headings, visual-break gaps) that the full-chrome page hides. Use as: (1) a reader-UX audit pass on published/draft posts, and (2) reference screenshots to improve post reader UX. Chrome DevTools MCP already available for screenshots - investigate whether reader mode is drivable headlessly or needs desktop Reader View. Surfaced 2026-07-21. |

---

## Closed (historical findings)

Project produced rich findings docs (cross-page consistency, mobile UX, competitor benchmark, sprint 3-6 reports) but no canonical tracker before now. See `findings-*.md` files in this directory for prior work.

---

## Related references

- `findings-cross-page-consistency.md` — cross-page typography audit
- `findings-mobile-ux.md` — mobile UX issues
- `findings-competitor-benchmark.md` — competitor comparison
- `findings-2026-04-30.md` — typography findings snapshot
- Memory: `feedback_684px_column_visual_constraints.md` — the constraint that surfaced this task
- Memory: `feedback_course_work_scope_discipline.md` — why this task stayed deferred during course work
