# Cover Image Generation Skill
#
# Reusable skill for generating blog post cover images using the
# JetVelocity 6-slot design system.

## Overview
Generates 2400×1260 cover images for blog posts using a 6-slot HTML layout
rendered via chrome-devtools.

## Design System
- JetVelocity: obsidian dark, Ruby red (#cc342d), neon purple (#a855f7)
- Font: Inter (headlines), JetBrains Mono (code/metrics)
- 6-slot grid layout — canonical spec in .stitch/design.md

## Workflow
1. Read .stitch/design.md for the 6-slot layout specification
2. Duplicate an existing HTML from .stitch/designs/
3. Change ONLY: title, category, pill, 3 headline lines, 3 chip labels+values, status text
4. Render: chrome-devtools new_page → emulate viewport=2400x1260x2 → wait 2s → take_screenshot
5. Downsample: magick {screenshot} -filter Lanczos -resize 2400x1260 -sampling-factor 4:4:4 -strip -quality 95 content/blog/<slug>/cover.png
6. Set frontmatter: cover_image: cover.png, cover_image_alt: descriptive alt text

## Dependencies
### MCP
- chrome-devtools — rendering

### System
- ImageMagick (magick CLI) — downsampling

## Full Documentation
.stitch/design.md (canonical 6-slot spec)
docs/workflows/cover-images.md
