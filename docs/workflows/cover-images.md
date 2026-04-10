# Cover Images Workflow

Canonical spec: `.stitch/design.md` (read before any cover work)

## Required Layout
- Brand + category (top-left)
- Year pill (top-right, YEAR not version)
- 3-line hero (white / gradient / white, mid-left)
- Ruby gem SVG (mid-right)
- Three stat chips (bottom-left, facts not in title)
- Status indicator (bottom-right)

## Anti-Redundancy
- Pill carries YEAR, not version
- Stat chips must add facts not already in H1
- No footer meta chip
- No subtitle unless it adds new benefit

## Reference Files (duplicate, never author from scratch)
- `.stitch/designs/rails-8-1-active-job-continuations-cover.html`
- `.stitch/designs/rails-argon2-has-secure-password-cover.html`

## Pipeline
HTML → chrome-devtools 2× retina → Lanczos downsample → `content/blog/<slug>/cover.png` → `bin/hugo-build`

Frontmatter:
- `metatags.image: cover.png`
- `cover_image: "cover.png"`
- `cover_image_alt: "..."`

Thumbnail:
- Aspect-preserving 360×189 (2× retina for 180×95)
- Letterbox inside 180×180 container; never center-crop
