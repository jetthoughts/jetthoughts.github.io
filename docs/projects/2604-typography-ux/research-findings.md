# Typography & UX Research Findings

**Date**: 2026-04-26
**Method**: Visual comparison of JetThoughts vs thoughtbot + Evil Martians blog posts
**Screenshots**: `docs/screenshots/` (our-posts/, competitors/thoughtbot/, competitors/evil-martians/)

---

## Current State (JetThoughts)

| Property | Current Value | Source File |
|----------|-------------|-------------|
| Body font | `system-ui` stack (sans-serif) | `themes/beaver/assets/css/style.css` |
| Body font-size | 20px (17px mobile) | style.css |
| Body line-height | 32px (1.6 ratio) | style.css |
| Content max-width | 43rem (~688px) | single-post.css |
| H1 | 48px/60px, weight 700 | style.css |
| H2 | 29px/38px, weight 700, margin-top 48px | style.css |
| H3 | 22px/30px, weight 600, margin-top 36px | style.css |
| Paragraph margin-bottom | Browser default (~1em = 20px) | none set |
| Blockquote | 3px left border, #242424 | style.css |
| Table cells | 5px 10px padding, 16px font | style.css |
| Links | #1a8cff, no underline, underline on hover | style.css |
| Code blocks | 20px 24px padding, 8px radius | style.css |
| Author display | None - not rendered on page | single.html |
| Tags position | Below title, above content | single.html |

## Competitor Analysis

### Thoughtbot
- Dark background (charcoal), light text - premium feel
- Large confident serif title font
- Author name + date prominently displayed
- Body text generous line-height (~1.7-1.8)
- Always-visible link underlines
- Clean whitespace between paragraphs - "breathable" reading rhythm
- Inline code uses colored background highlight
- **Key insight**: "We care about every pixel" - design matches expertise claim

### Evil Martians
- Distinctive orange/coral brand header
- Very large bold display-weight headlines
- Multiple authors shown with photos
- Custom illustrations and graphics throughout
- Pull quotes and callout boxes break up long text
- Table of contents sidebar on longer posts
- Figures with captions
- **Key insight**: Magazine-quality layout - visual breaks prevent wall-of-text

## ICP Reader Feedback (Alex, non-technical founder)

> "The writing is doing 90% of the trust-building work. The design is doing maybe 10%. That gap is costing you conversions from founders who scan before they read."

Key quotes:
- "Thoughtbot looks like a company that sweats the details. JetThoughts' blog says 'we built this in a weekend and moved on.'"
- "JetThoughts has zero author presence. The author field isn't even rendered on the page."
- "Tags at the top of the post look like developer metadata. As a founder, I see hashtags and think 'this is a dev blog, not for me.'"
- "No table of contents on long posts. I want to jump to the section I care about."
- "The design doesn't match the writing quality."

## Proposed Changes (Priority Order)

### P1: CSS-only (no layout changes)

| Change | Current | Proposed | Impact |
|--------|---------|----------|--------|
| Paragraph line-height | 1.6 | 1.75 | Eliminates wall-of-text feeling |
| Paragraph margin-bottom | ~1em | 1.5em | Breathing room between paragraphs |
| H2 margin | 48px top, 16px bottom | 56px top, 20px bottom | Clearer section breaks |
| H3 margin | 36px top, 12px bottom | 44px top, 16px bottom | Better heading hierarchy |
| Link underline | hover only | always, text-underline-offset: 3px | Accessibility + scannability |
| Link underline color | n/a | rgba(26,140,255,0.4), full on hover | Subtle but visible |
| Blockquote border | 3px #242424 | 4px #cc342d (Ruby Red) | Brand identity on callouts |
| Blockquote text | same as body | italic, #4a4a4a | Visual differentiation |
| Table padding | 5px 10px | 10px 16px | Mobile usability |
| Table header | no background | #f8f8fa background, weight 600 | Clearer data hierarchy |
| Table margin | 22px | 32px | More breathing room |
| Code block padding | 20px 24px | 24px 28px | Comfortable reading |
| Code block radius | 8px | 10px | Softer, modern feel |
| Code block margin | 28px | 32px | Better separation |

### P2: Layout changes (template modifications)

| Change | Impact | Files |
|--------|--------|-------|
| Add author name + photo to posts | Trust signal - "real person, not content mill" | single.html, author partial |
| Move tags below content | Stop scaring founders with dev metadata | single.html |
| Add blockquote/callout styling for pull quotes | Visual breaks in long reads | style.css |

### P3: Feature additions (larger scope)

| Change | Impact | Complexity |
|--------|--------|-----------|
| Auto-generated table of contents for posts >1000 words | Navigation on long reads | Hugo partial + CSS |
| Author bio section at bottom of post | Team visibility, trust | Layout + data |
| Styled "Read next" section with thumbnails | Better cross-linking | Layout + CSS |

## References

- Thoughtbot blog: https://thoughtbot.com/blog
- Evil Martians chronicles: https://evilmartians.com/chronicles
- WCAG link contrast: https://www.w3.org/WAI/WCAG21/Understanding/non-text-contrast.html
