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
