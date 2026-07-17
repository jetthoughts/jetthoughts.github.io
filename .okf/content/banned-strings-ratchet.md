---
type: Validator
title: Banned-strings ratchet
description: data/course_banned_strings.yaml pins every fixed prose defect so it cannot silently regress; entries can be scoped to a single page.
resource: data/course_banned_strings.yaml
tags: [validation, course, regression]
timestamp: 2026-07-13T00:00:00Z
---

When a review sprint fixes a prose defect (a wrong tool name, a banned
phrase, a stale threshold), the exact defective string is added to
`data/course_banned_strings.yaml`. [bin/hugo-build](/build/hugo-build.md)
fails if it reappears in any course chapter's SOURCE markdown body
(case-sensitive substring match against `index.md`).

# Rules

- Entries support per-page scoping via an optional `scope` regex matched
  against the bundle directory name (e.g. ban "Airtable" only on the
  operating-kit page). There is NO exemption mechanism - if a string must
  stay legal on some page, scope the entry AWAY from that page instead.
- The ratchet reads source markdown only - it is blind to text inside SVG
  artwork and mermaid labels. Artwork defects are caught by the
  [render-verification playbook](/workflows/render-verification.md) instead.
- After fixing any prose defect, grep your own replacement text for the
  exact pattern you just removed - re-introducing the defect being fixed is
  a blocking failure.
