---
type: Playbook
title: Render verification (visual scroll gate)
description: The working headless-Chrome capture, page-slicing, and SVG re-render recipes used to inspect every scroll view of a page.
tags: [verification, chrome, screenshots]
timestamp: 2026-07-13T00:00:00Z
---

Text validators cannot see rendered output - mermaid clipping, SVG text
crossing borders, stale cover badges, and wrong-direction "diagram above"
references are all invisible to grep. Canonical protocol:
`docs/workflows/visual-scroll-gate.md`.

# Render from _dest/public-dev, NEVER public/

[bin/hugo-build](/build/hugo-build.md) outputs to `_dest/public-dev/` with
RELATIVE asset URLs (covers and SVGs work over file://). The repo-root
`public/` directory is a stale artifact of raw `hugo` runs or the dev
server (localhost:1717 or canonified production URLs baked in) - reviewing
it produces false "missing image / missing cover / nav overlap" findings.
The 2026-07-13 review wave lost a whole finding class to this.

# Working capture recipe (macOS)

Chrome never exits on its own - background it and kill after a sleep:

```bash
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' \
  --headless --disable-gpu --user-data-dir=$(mktemp -d) \
  --hide-scrollbars --window-size=1280,20000 --virtual-time-budget=8000 \
  --screenshot=page.png "file:///path/to/public/.../index.html" & P=$!
sleep 14; kill $P
```

- 390-wide window for mobile first-fold; raw headless is NOT full mobile
  emulation.
- Slice for inspection: `magick page.png -trim +repage -crop 1280x2400 +repage p-%02d.png`
- Standalone SVGs: `rsvg-convert -w 1400 file.svg -o out.png` then inspect.
- Line-fraction crop estimates are unreliable (tables/code expand); iterate
  crops or measure with getBoundingClientRect.

# The gate

Walk EVERY slice at 1280x800 and 390x844 and actually look at each one
before handback. Score new visuals on: great look / functional / earns the
next scroll / helpful. Any NO on the last two = rollback or redesign.
Diagram checklist lives in the [house visual spec](/design/house-visual-spec.md)
and [mermaid theme](/design/mermaid-theme.md).
