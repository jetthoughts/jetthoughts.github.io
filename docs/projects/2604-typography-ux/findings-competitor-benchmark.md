# Competitor Benchmark — 2026-04-30

Comparison of JetThoughts blog against thoughtbot and Evil Martians, post-Typography Sprint #2.

## 1. Verified screenshots inventory

`docs/screenshots/competitors/` — Sprint #7 (2026-04-29) re-captured the 4 broken/mislabeled files at 1440x900 desktop via chrome-devtools MCP and visually verified each against the source competitor blog:

| File | Status | Source URL (post-Sprint-#7) |
|---|---|---|
| `thoughtbot/comp-tb-rate-limits.png` | REAL thoughtbot | (pre-existing) |
| `thoughtbot/comp-tb-claude-skill.png` | RE-CAPTURED Sprint #7 | https://thoughtbot.com/blog/reviewing-dependabot-prs-is-boring-let-claude-do-it-for-you |
| `thoughtbot/comp-tb-js-everything.png` | RE-CAPTURED Sprint #7 | https://thoughtbot.com/blog/retro-driven-development |
| `thoughtbot/comp-tb-{duck-typer,js-activerecord,js-composition,props-template}.png` | likely real, not visually verified |
| `evil-martians/comp-em-llm-visible.png` | REAL Evil Martians | (pre-existing) |
| `evil-martians/comp-em-oklch.png` | RE-CAPTURED Sprint #7 | https://evilmartians.com/chronicles/oklch-in-css-why-quit-rgb-hsl |
| `evil-martians/comp-em-favicon.png` | RE-CAPTURED Sprint #7 | https://evilmartians.com/chronicles/flaky-tests-be-gone-long-lasting-relief-chronic-ci-retry-irritation |
| `evil-martians/comp-em-payment-form.png` | likely real, not verified |

All 8 files now have unique md5 hashes; the broken 43KB file is gone; no JT mislabeled files remain in the competitor folder.

## 2. Side-by-side dimension table

| Dimension | thoughtbot | Evil Martians | JetThoughts (post-sprint-#2) |
|---|---|---|---|
| Body font | system sans, ~17-18px | system sans, ~17-18px | system-ui, 20px desktop / 17 mobile |
| Body line-height | ~1.7 | ~1.6-1.7 | **1.75** (most generous of three) |
| Body color/bg | `#e8e6e3` on `#1a1a1a` (dark) | `#1a1a1a` on `#ffffff` | `#121212` on `#ffffff` |
| Content max-width | ~640-680px | ~700-740px | 688px (43rem) |
| H1 | ~44-48px, weight 700 | ~40-44px, weight 800-900 (display) | 48px desktop / 32px mobile |
| H2 | ~28-30px, weight 700 | ~28-32px, weight 800 | 29px desktop / 24px mobile |
| Blockquote | not in sample | italic + subtle bg, no border | **6px Ruby border + 5%-tint bg + 8px radius** |
| Code block | dark grey, syntax | dark theme, screenshot-style | Dracula, 24/28 padding, 10px radius |
| Inline code | colored highlight bg | mono with subtle bg | **`#1a1a2e` on `#f4f4f5` = 15.5:1 (best of three)** |
| Link | always-underlined orange (~`#f06d2a`) | orange/coral always-underlined | `#0066d6` underlined 70% opacity |
| CTA pattern | "Let's get started!" pill top-right + subscribe bottom | "Hire Martians" pill top-right + inline links | `.cta-link` Ruby button + header "Contact Us" pill |
| Byline | author-name link + date in orange under H1 | author photo cards + names + roles + date | "By JetThoughts Team - date - read-time" (text only, no link) |
| Tags | ALL-CAPS comma list under byline ("RAILS, WEB, DEV") | "Topics:" + pill badges in header | `#startup #hiring` hashtags at bottom |
| TOC | none on sample | sidebar on some posts | none |
| Author bio | bottom of post | top + bottom with photo cards | none |
| Brand color | dark + warm orange | coral header band + bold display | white + Ruby red `#cc342d` |
| Hero | small / type-led | large illustrated mascot | gradient with title overlay |

## 3. What thoughtbot does better

1. **Author byline as primary trust slot** — linked author name + date + tags right below H1. JT renders generic "By JetThoughts Team" with no link, no photo, no author page.
2. **Tags as editorial taxonomy** ("RAILS, WEB, DEVELOPMENT") read as section markers, not Twitter hashtags. JT's `#startup #hiring` triggers the exact dev-blog signal the founder ICP rejects.
3. **Dark-mode default + warm orange accent** does brand identity work before a word is read.

## 4. What Evil Martians does better

1. **Multi-author photo cards at the top** — names, photos, roles. Real humans, named accountability. JT has zero author photos anywhere.
2. **Illustrated mascot hero artwork** — uncopyable brand identity. JT's gradient covers are competent but generic.
3. **Mid-post pull quotes / callout boxes** break wall-of-text rhythm 2-4x per post. JT now has a strong blockquote treatment but uses it only once at the close.

## 5. What JetThoughts matches or beats

1. **Body line-height 1.75** — more generous than both competitors (~1.6-1.7). Reading rhythm is genuinely good.
2. **Inline code contrast 15.5:1** — beats both competitors' subtle-tint approach.
3. **Blockquote-as-callout** (post-Sprint-#2: 6px Ruby border + 5%-tint bg + 8px radius) — on par with EM, beats thoughtbot (no callout pattern in sample).

## 6. Top 5 borrowable patterns (impact / effort)

| # | Pattern | Source | Impact | Effort |
|---|---|---|---|---|
| 1 | Author byline upgrade (name + photo + role + date + read time + author-page link) | thoughtbot + EM | Highest — fixes #1 trust gap | M |
| 2 | Tags as editorial taxonomy (ALL-CAPS comma list or muted "Filed under" pills, drop `#`) | thoughtbot | High — removes dev-blog signal | S (~30 min) |
| 3 | Mid-post visual breaks: reuse existing `.cta-link` + blockquote 1-2× extra per post | EM | High — rescues 11-min readers | 0 dev, authoring-only |
| 4 | Custom illustrated hero per post or per category | EM | Medium — brand differentiation | L (illustration commitment) |
| 5 | Dark-mode toggle (CSS-vars on top of sprint #2, aligns with `.stitch/design.md`) | thoughtbot | Medium — premium signal + a11y | M |

## Method caveat

WebFetch returned plain markdown only; chrome-devtools could not navigate off `localhost:1313` during the audit (network restriction in agent context). Side-by-side dimensions sourced from verified-real PNGs (`comp-tb-rate-limits.png`, `comp-em-llm-visible.png`) plus prior `research-findings.md` notes. Re-capture competitor screenshots next session.
