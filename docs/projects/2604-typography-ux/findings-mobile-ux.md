# Mobile UX Audit — 2026-04-30 (post-Sprint-#2)

## Method note

macOS Chrome viewport floor = 500px. Resize to 375 was requested; reported `vw=500`. Since the only mobile media query is `@media (max-width: 768px)`, computed values at 500px are identical to what an iPhone SE (375) and iPhone 13 Plus (414) will render. What could not be verified: how blockquote/code/CTA wrap when content drops from 464px (at 500w) to 343px (at 375w) — riskiest gap, called out below.

CSS source: `themes/beaver/assets/css/style.css` lines 23, 121, 270-298, 301-318, 427-436.

## 1. Computed styles at 768px-and-under breakpoint

| Element | Selector | font-size | line-height | margin | padding | rendered |
|---|---|---|---|---|---|---|
| H1 | `.blog h1.post-title` | 32px | 38px | 0 / 32 | 0 | 76px (2 lines) |
| H2 | `.blog h2:not(.post-title)` | 24px | 32px | 40 / 14 | 0 | 32-64px |
| H3 | `.blog h3:not(.post-title)` | 19px | 26px | 32 / 12 | 0 | 26px |
| Body p | `.blog p` | 17px | 29.75 (1.75) | 0 / 0 | 0 | 30/line |
| List item | `.blog li` | 17px | 29.75 | 0 / 12.75 | 0 | 30/line + 12.75 gap |
| Inline link | `.blog p a:not(.cta-link)` | 17px | 29.75 | — | — | underline 2px @ #0066d6 |
| **CTA button** | `.cta-link` | 17px | 23.8 | 8 / 0 | 16 / 24 | **56px tall, 100% wide** |
| Blockquote | `.blog blockquote` | 17px | 28.05 (1.65) | 48 / 48 | 24 / 28 | 358px tall (post #1 hook) |
| Blockquote p | `.blog blockquote p` | **20px** | 32 (1.6) | 22 / 0 | 0 | (no mobile override — bug) |
| `<pre>` | `.blog pre` | 17px | 28.05 | 32 / 32 | 24 / 28 | overflow-x: auto |
| `<pre><code>` | `.blog pre code` | 15.5px | 25.575 (1.65) | 0 | 0 | white-space: pre-wrap |

H1→H2 = 1.33×, H2→body = 1.41× (good). H3→body = 1.12× (tight).

## 2. Per-page observations

**Post #1 (hiring-dev-shop-questions)**: `.cta-link` lands at 56px × 100% — exceeds Apple HIG 44px by 12px, unmissable. Blockquote callout 358px tall with 5% red bg + 6px border + 24/28 padding. At 375w content area = 343 - 56 padding = 287px usable; the inner `<p>` is forced to 20/32 (heavier than body) and will break two-clause sentences to 4-5 lines. No page overflow.

**Post #2 (rails-event-structured-logging)**: 6 `<pre>` blocks. `overflow-x: auto` + `white-space: pre-wrap` correct, but syntax-highlight child `<span>`s measure 691-784px wide with right edge at 737-830px — that's **348px of horizontal scroll inside the block** at 500w (~470px at 375w). Page itself doesn't break, but user must two-finger swipe inside `<pre>`. 50 inline-code instances wrap on baseline (Sprint #2 fix landed).

**Post #3 (47-startups-failed)**: 11 citation links — credibility-critical. 3 of them render at <30px tap-target height (single-line links inside dense paragraphs). Inline link contrast + 2px underline solid. No tables (good). CTA renders correctly. No overflow.

**Post #4 (blog index)**: Thumbnails render at **80×42px** at 500w — postage-stamp size, 16% of viewport width. 60 cards = scroll-heavy. Card titles return 0×0 because the parent `.post` wrapper absorbs the click (tap area still passes). No overflow.

## 3. Top 8 mobile UX issues (ranked impact)

1. **Code block H-scroll on Rails post** — 348px of overflow inside `<pre>` at 500w (~470px at 375w). Behavior correct (scroll-within-block) but feel is poor.
2. **Blockquote inner `p` 20px ignores mobile breakpoint** — outer rule drops to 17/1.65 at 768px, inner `p` stays 20/1.6. Hook is 358px tall in 812-tall viewport (44%).
3. **Blog index thumbs 80×42** are too small for 500w viewport. ICP-E has no visual hook scrolling 60 cards.
4. **3 of 11 citation links < 30px tap height** on viral post. Passes WCAG AA (24×24), tight per Apple HIG (44×44).
5. **H3 hierarchy weak at 375w**: 19px vs body 17px = 2px + weight diff only.
6. **Blockquote padding 24/28 = 52px chrome** at 343px content = 291px usable. 12-word sentences break to 3 lines.
7. **H2 top margin 40px** feels disconnected from preceding paragraph at mobile scale. 32px would feel tighter to the section.
8. **Zero document-level horizontal scroll** confirmed on all 4 URLs (this is positive — bullet exists to rule it out).

## 4. Top 5 mobile-specific quick wins (~10 min of CSS, ~30 lines)

```css
/* 1. Blockquote inner-p mobile size + tighter padding (highest impact) */
@media (max-width: 768px) {
  .blog blockquote { padding: 20px 22px; margin: 36px 0; }
  .blog blockquote p { font-size: 18px; line-height: 1.55; }
}

/* 2. H3 distinct from body on mobile */
@media (max-width: 768px) {
  .blog h3:not(.post-title) { font-size: 21px; line-height: 28px; }
}

/* 3. Code block: smaller token + tighter padding */
@media (max-width: 768px) {
  .blog pre code { font-size: 14.5px; line-height: 1.6; }
  .blog pre { padding: 18px 20px; }
}

/* 4. H2 mobile margin: tighter top so it stays connected to its section */
@media (max-width: 768px) {
  .blog h2:not(.post-title) {
    margin-top: 32px !important;
    margin-bottom: 12px !important;
  }
}

/* 5. Blog index: full-width thumb under 480px */
@media (max-width: 480px) {
  .blog .post img, .blog .post-card img {
    width: 100%; height: auto; max-height: 180px; object-fit: cover;
  }
}
```

## 5. What works well on mobile (preserve)

- **CTA full-width**: 56px × 100%, padding 16/24, weight 600, bg `#cc342d` — biggest Sprint #2 win
- **Body 17/1.75** reads beautifully — generous breathing room
- **List item `margin-bottom: 0.75em`** groups bullets as a unit (was 42px gap pre-fix)
- **Inline link** `#0066d6` + 2px underline visible at scan distance
- **Blockquote callout** (5% red tint + 6px border + 8px right radius) reads as anchor
- **No page overflow** on any URL at 500w — `docW === viewport.w`
- **Code blocks contain their own scroll** — page layout never breaks
- **Mobile hierarchy 32 → 24 → 17** (1.33× then 1.41×) — balanced, fixed the pre-Sprint-#2 1.10× H1→H2 collapse

Screenshots: `/tmp/mobile-hiring-500.png`, `/tmp/mobile-rails-500.png`, `/tmp/mobile-47startups-500.png`, `/tmp/mobile-bloglist-500.png`, `/tmp/mobile-hiring-h2-scrolled.png`.
