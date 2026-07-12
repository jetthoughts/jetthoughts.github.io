# Visual Scroll Gate (BLOCKING before handback)

**When**: any new or edited content page (course lesson, walkthrough, companion/template page, blog post, landing page) and ANY change to a visual asset (SVG, mermaid, cover, image) - run BEFORE declaring the page done, in the same session as the edit.

**Why this exists**: text validators cannot see rendered output. On 2026-07-10 this gate caught, in one Module 3 pass: mermaid node text clipped in every node (cursive theme font overflows mermaid's measured boxes), SVG text lines crossing the artwork's card border (user-visible defect), a stale "Curriculum 06/30" badge on a cover that had just been wired as og:image, a "the spaceship above" reference rendering BELOW the image, and a "Chapter 2.1" renumber leftover living INSIDE SVG artwork where the banned-string ratchet never looks.

## Protocol

1. `hugo server` + chrome-devtools MCP. Load the page at **1280×800**.
2. **Scroll section by section** (jump anchor-to-anchor via the h2 list, plus every diagram/image/table/callout) and screenshot each view. Actually look at each screenshot - the gate is your eyes, not the tool call. "Screenshot taken" is not the gate.
3. Repeat the walk at **390×844** (or at minimum: numeric probes + screenshots of every diagram).
4. Run the numeric probes on each page:

```js
() => ({
  bodyOverflowX: document.documentElement.scrollWidth > document.documentElement.clientWidth,
  mermaidHeights: [...document.querySelectorAll('svg[id^="mermaid"]')].map(m => Math.round(m.getBoundingClientRect().height)),
  images: [...document.querySelectorAll('article img')].map(i => ({src: i.src.split('/').pop(), complete: i.complete, h: Math.round(i.getBoundingClientRect().height)}))
})
```

5. Check the console (errors) and network (404s). Dev-server-only artifacts (e.g. webmanifest CORS when browsing via 127.0.0.1 against a localhost baseURL) are excusable - name them explicitly in the report; everything else is a blocker.

### Asset-level SVG pass (MANDATORY - the in-page walk misses these)

Sampling pages does NOT clear the SVGs: on 2026-07-11 a full asset sweep of all 43 course SVGs found 13 with internal defects (labels under cards, bars drawn over their own captions, right-edge clipping, stale chapter numbers) that months of page-level reviews had sailed past because each review sampled different pages. Rasterize EVERY SVG in scope and look at each one:

```sh
find content/course/<section> -name "*.svg" | while read f; do
  rsvg-convert -w 1400 "$f" -o "/tmp/svgsweep/$(echo "$f" | awk -F/ '{print $(NF-1)"__"$NF}').png"
done
# then Read every PNG - the defect classes: text crossing its container,
# elements drawn over other elements' text, edge clipping, arrows through
# labels, stale facts baked into the art.
```

### No-MCP fallback (headless Chrome)

When the chrome-devtools MCP is unavailable, the walk still happens - full-height capture + slicing replaces live scrolling:

```sh
CHROME='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
"$CHROME" --headless --disable-gpu --user-data-dir=$(mktemp -d) --hide-scrollbars \
  --window-size=1280,16000 --virtual-time-budget=8000 \
  --screenshot=page.png "file://$PWD/_dest/public-dev/<path>/index.html" & P=$!; sleep 16; kill $P
magick page.png -trim +repage -crop 1280x2400 +repage slices/page--%02d.png
# Read every slice. Chrome does not exit on its own (site JS keeps timers
# alive) - the kill-after-sleep watchdog is required.
```

Caveat: raw headless `--window-size=390,...` does NOT emulate a mobile
device (no viewport-meta scaling) - body text clips at the right edge on
EVERY page, which reads as fake overflow. Mobile checks need the
chrome-devtools MCP resize (or DevTools device emulation); use raw
headless only for desktop-width captures.

## Per-view checklist

| Class | What to look for | Caught before |
|---|---|---|
| Diagram text fit | Mermaid/SVG node text clipped, truncated mid-word, or crossing box borders (cursive theme fonts overflow mermaid's measurement) | 3.1 forks mermaid, 2026-07-10 |
| Artwork border overflow | SVG text lines extending past the card/page shape inside the artwork | vibe-prd-template-visual.svg |
| Facts inside artwork | Chapter numbers, counts, prices, time-boxes INSIDE SVGs/covers - the ratchet does not scan SVGs | "Chapter 2.1" in 2 SVGs |
| Cover staleness | Badge style, counters ("NN/30"), chip facts vs current canon - especially if the cover is og:image | vibe-prd-template cover |
| Positional prose | "the diagram above/below" pointing the wrong way after content moved | 3.2 spaceship hook |
| Diagram height | Rendered height > ~2× viewport (1600px desktop) = wall, compress | 2.1 interview-flow (M2 sprint) |
| Callout rhythm | 3+ same-form blockquotes stacked back to back | 3.2 opener + action section |
| Mobile overflow | bodyOverflowX true, tables without scroll containers, images past 100% | - |
| First-fold hook | An informational visual inside the first viewport at 1280×800 (hero rule) | - |
| Image wiring | cover_image present in frontmatter when cover.png exists; images actually load (complete=true after scroll) | vibe-prd-template |

## Reporting

State the result as evidence, not assurance: "scroll gate run on N pages × 2 viewports; found X (list), fixed; remaining console errors are dev-only (named)". Never "looks fine".

Any fix that changes prose gets its ratchet signature (`data/course_banned_strings.yaml`) in the same commit, per `docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.13-retrospective-review-churn-2026-07-10.md`. Fixes INSIDE SVGs cannot be ratcheted - re-run this gate after any SVG edit instead.
