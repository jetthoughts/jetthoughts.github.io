# Cross-Page Consistency — 2026-04-30 (post-Sprint-#2)

## TL;DR

Site ships **5 separate CSS bundles, one per page archetype, with no shared base** that pins typography, link color, or button shape. Marketing pages (homepage + services) run one cascade (Bootstrap-derived `#007bff` links, `var(--font-system-ui)` body, h1 weight 800). Blog index, blog post, about run a different cascade (`#1a8cff` links, `min-width: 992px !important`, h1 50/40px, no body font reset). Sprint #2 typography (`#0066d6` link, `.cta-link`, blockquote callout, list spacing) lives entirely inside `.blog`-scoped selectors in `style.css`, so it never propagates.

**About page is the worst case** — it ships `not_found.css` (the 404 bundle), so zero Ruby red, zero `.cta-link`, no brand font reset. Neon purple `#a855f7` appears in zero bundles. Site reads as 3 different sites stitched together: marketing, blog, leftover about.

## 1. Per-page hero observations

- **/** — H1 "Build faster. Scale smarter." renders 32px/700, but `critical.css` declares 70px/800 — a per-page rule overrides it down. Body inherits Bootstrap (`#212529`, `a #007bff`).
- **/services/** — Same body+a+h1 cascade as homepage (Bootstrap `#007bff`, weight 800). Visually similar to homepage, drifts from blog.
- **/blog/** — `body { min-width: 992px !important }` (forces horizontal scroll < 992px), h1 50/40px, link `var(--color-primary)`. 13 `.btn` rules, no `.cta-link`.
- **/blog/hiring-dev-shop-questions/** — Only page where Sprint #2 landed: 17px body, `system-ui`, `#0066d6` link with 2px underline. Body content typography is one step ahead of the rest of site.
- **/about/** — Loads `/css/not_found.6e81c42e...css` — the **404 bundle**. Zero `#cc342d`, zero `.cta-link`, no brand color anywhere.

## 2. Visual style audit

| Element | / | /services/ | /blog/ | /blog/post/ | /about/ |
|---|---|---|---|---|---|
| Body font-family | `var(--font-system-ui)` | `var(--font-system-ui)` | not set | not set (`.blog p` only) | not set |
| Body font-size | `1rem` (16px) | `1rem` (16px) | not set | `17px` via `.blog p` | not set |
| Body min-width | not set | not set | **`992px !important`** | **`992px !important`** | **`992px !important`** |
| H1 font-size | `32px` observed | Bootstrap | `50px / 40px` | `50px / 40px` then `.blog h1` 32px | `50px / 40px` |
| H1 font-weight | `800` declared, `500` cascade | `800` | unset | `700` | unset |
| Link color | `#007bff` | `#007bff` | `var(--color-primary)` | `#1a8cff`, then `.blog p a` `#0066d6` | `#1a8cff` |
| Link decoration | none | none | none | underline 2px (only `.blog p`) | none |
| `.btn-primary` styled? | **NO** | **NO** | **NO** | **NO** | **NO** |
| CTA live shape | `bg #1a8cff, radius 25px, pad 11/18, weight 700` | inherits | inherits | `bg #121212, radius 6px, weight 300` | inherits |
| `.cta-link` rules | 13 | 13 | 13 | 13 | **0** |
| `#cc342d` Ruby red | 3 | 3 | 3 | 3 | **0** |
| Old `#1a8cff` blue count | 54 | 48 | 26 | 22 | 23 |
| New `#0066d6` blue count | 2 | 2 | 2 | 2 | **0** |

## 3. Top 8 inconsistencies (visual impact)

1. **CTA button is two different buttons depending on page.** Homepage hero: `bg #1a8cff, radius 25px, weight 700`. Blog post inline: `bg #121212, radius 6px, weight 300`. `.btn-primary` is **unstyled in every bundle** — each page falls into a different generic `.btn` cascade.
2. **Link color drifts 5 ways**: `#007bff` / `var(--color-primary)` / `#0066d6` / `#1a8cff`. Founder clicking post → home sees the link blue change.
3. **Body typography only resets on 2 of 5 pages.** Homepage/services have `body { font-family, color }` rule; blog/post/about have no body rule.
4. **About ships the 404 stylesheet** (`/css/not_found.6e81c42e...css`). Zero brand presence by accident.
5. **`body { min-width: 992px !important }`** on blog/post/about. **Mobile reader scrolls horizontally**. Marketing pages don't have this rule, so blog feels "the broken one on phones."
6. **H1 size collapses 70px (critical) → 50px (blog) → 32px (post)** within one click. Hierarchy is invisible.
7. **`#1a8cff` is still the dominant blue.** Sprint #2 added 2 occurrences of `#0066d6` per bundle but left 22-54 of `#1a8cff` — including blog post `:hover` at `style.css:139` (Sprint #2 missed this).
8. **Neon purple `#a855f7` in brand spec, zero in CSS.** Either remove from spec or actually paint with it.

## 4. Top 5 design-system unifications to ship first

### 1. Promote the blog post link spec to site-wide
Add to `themes/beaver/assets/css/critical.css`:
```css
:where(a):not(.btn):not(.btn-primary):not([class^="cta"]) {
  color: #0066d6;
  text-decoration: underline;
  text-decoration-color: rgba(0, 102, 214, 0.7);
  text-decoration-thickness: 2px;
}
```
Drop the `.blog p a` override in `style.css`. One rule, five pages.

### 2. Define `.btn.btn-primary` once
In `themes/beaver/assets/css/components/buttons.css` (already imported by `critical.css:9`):
```css
.btn.btn-primary {
  background: #cc342d; color: #fff;
  padding: 14px 28px; border-radius: 8px;
  font-weight: 600; font-size: 18px;
  text-decoration: none; display: inline-block;
}
.btn.btn-primary:hover { background: #a8231e; }
```
Then alias `.cta-link` to it.

### 3. Move body baseline into `critical.css`
```css
body { font-family: var(--font-system-ui); font-size: 18px; line-height: 1.6; color: #121212; }
```
Delete the `body { ... }` blocks from `homepage.css`, `services.css`, `blog-list.css`, `blog-single.css`, `not_found.css` so they stop fighting.

### 4. Remove `body { min-width: 992px !important }`
From blog-list, blog-single, about bundles. Mobile-experience landmine. No reason a content page needs to force desktop width.

### 5. Stop shipping `not_found.css` to `/about/`
Either route `/about/` to the homepage bundle or give it a branded bundle. **Single biggest visual repair on the site.**

## 5. What's already consistent (preserve)

- **Footer** — identical 19 rules in every bundle. Strongest cross-page element.
- **Header** (`.top-panel`) — 77 occurrences across 4 bundles, structure consistent.
- **System-ui font stack** in every bundle; bug is body cascade not reaching every page, not the stack itself.
- **Sprint #2 work** (`.cta-link`, blockquote callout, list spacing, `#0066d6`) internally consistent within `.blog`. Worth promoting, not reverting.
- **Ruby red `#cc342d`** consistently dosed (3 occurrences) in 4 of 5 bundles. Gap is `/about/`.

## Cross-page friction check

A founder reads the post, clicks logo home, then hits Services:
1. **Post → Homepage**: body shrinks 17px → 16px; links shift `#0066d6` underlined → `#007bff` solid; H1 weight drops 700 → 500. CTA changes shape from `radius 6px/weight 300/dark bg` to `radius 25px/weight 700/blue bg`.
2. **Homepage → Services**: smallest jump. Same `var(--font-system-ui)` and `#007bff`.
3. **Services → About**: hardest. About loses Ruby red entirely, no `.cta-link`, links shift `#007bff` → `#1a8cff`, brand tokens vanish (404 stylesheet).

**Verdict**: doesn't feel like one site. Marketing pages + blog + leftover about, held together by header/footer.
