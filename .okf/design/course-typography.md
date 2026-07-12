---
type: Design System
title: Course reading typography
description: Course pages read at 20px/1.65 body scale (blog keeps 22.4px); overrides must mirror the full single-post.css selector chain or they silently lose.
resource: themes/beaver/assets/css/style.css
tags: [css, typography, course]
timestamp: 2026-07-13T00:00:00Z
---

# The scale (course pages only)

| Element | Value |
|---|---|
| Body p / li | 20px / 1.65 |
| li margin | 12px |
| Blockquote/callout p | 19px / 1.6 |
| Worksheet card p, ws-checks li | 17px / 1.55 |
| ws-route p | 16.5px |

The blog keeps its thoughtbot-anchored 22.4px scale - the course override is
scoped with a `.section-course` prefix.

# The specificity trap

`single-post.css` sets body type via
`.blog article.single-content .fl-rich-text p` (specificity 0,3,2). Any
course override weaker than that silently loses - a plain
`.section-course .blog p` (0,2,1) does nothing. Mirror the FULL chain:
`.section-course .blog article.single-content .fl-rich-text p`.

Also: broad element rules (e.g. the 20px li rule) can invert component
hierarchies - the worksheet-card checklist items got bumped to 20px and had
to be re-pinned to 17px. After any type change, run both visual suites per
[test gates](/build/test-gates.md).
