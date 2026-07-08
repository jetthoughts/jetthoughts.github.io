---
{}
---

# Cover Image Generation — Trigger Prompt
#
# Reusable prompt for generating blog post cover images via Stitch design system.
# Full spec: .stitch/design.md (canonical 6-slot layout)
# Full workflow: docs/workflows/cover-images.md

Generate a cover image for a blog post.

## Steps
1. Read .stitch/design.md for the 6-slot layout specification
2. Duplicate an existing HTML from .stitch/designs/ (e.g., rails-8-1-active-job-continuations-cover.html)
3. Change ONLY: title, category, pill, 3 headline lines, 3 chip labels+values, status text
4. Render: chrome-devtools new_page → emulate viewport=2400x1260x2 → wait 2s → take_screenshot
5. Downsample: magick {screenshot} -filter Lanczos -resize 2400x1260 -sampling-factor 4:4:4 -strip -quality 95 content/blog/<slug>/cover.png

## Design System
- JetVelocity: obsidian dark, Ruby red (#cc342d), neon purple (#a855f7)
- Font: Inter (headlines), JetBrains Mono (code/metrics)
- 6-slot grid layout — see .stitch/design.md for exact positioning