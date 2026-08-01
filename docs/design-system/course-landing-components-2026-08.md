# Course-landing component library (extracted from the demo-1 ideal reference)

Extracted 2026-08-01 from the live DOM of Paul's ideal-reference demo
(shuffle 85cc6373…; durable capture rides the W1 branch as
`40.26-reference-demo1-full.jpeg`). Mid-page components only — nav/footer
excluded (site defaults stay). Every value below is TOKEN-MAPPED to
JetVelocity: demo red `#d94444` → ruby `#cc342d`; demo gray-900 → obsidian;
demo blue tints → ruby tint (`#cc342d` at 5-8% on white); `font-heading` →
Space Grotesk; `font-mono` → JetBrains Mono. Never ship the demo's raw hues.

Implementation home: `themes/beaver/assets/css/pages/course-list.css`
(landing-owned bundle) — components already partially exist from L4
(`.module-card`, `.mistake-list`, `.course-endcap`, `.course-hero-card`);
this doc is the canonical spec to converge them on.

## 1. Meta chip (hero + reusable)
`padding 4px 12px · bg gray-100 · text 12px/600 uppercase tracking-wide ·
radius 2px`. Row of 4 above the CTA pair. Quiet by design — the chips are
facts, not buttons.

## 2. Primary CTA (the only loud element)
`bg ruby · white · 500 weight · padding 16px 32px · radius 4px ·
box-shadow 0 4px 14px rgba(204,52,45,.39)`; hover: darker ruby,
`translateY(-2px)`, shadow `0 6px 20px rgba(204,52,45,.23)`. Secondary CTA:
white, 1px gray-200 border, same padding — never colored.

## 3. Hero H1 (two-line, gradient second line)
`Space Grotesk 700 · clamp ~48-72px · line-height 1.05 · tracking-tight`.
Line 2 as gradient text: `background-clip:text; color:transparent;
background-image: linear-gradient(90deg, ruby, purple #a855f7)` (demo used
gray→gray; ours is the JetVelocity ruby→purple — this is the SAFE variant of
the killed "two-tone H1": spans inside the rendered H1, frontmatter title
untouched... requires the hero to render title lines from template, so ship
only when list.html owns the line break; otherwise skip).

## 4. Course-window card (hero artifact)
`radius 16px · 1px border gray-100 · shadow-2xl · bg obsidian · aspect 4/3`.
Chrome bar: `h 48px · border-b white/10 · 3 dots 12px` (red/amber/green at
80% — keep the mac colors, they read as "window" not "palette"). Body:
`padding 32px`, optional cover image under `obsidian/80 + backdrop-blur`
overlay; content: JetBrains-Mono ruby eyebrow (uppercase, tracked) →
2-line Space Grotesk ~36px white title → mono gray-300 meta line
("5 modules · 25 lessons"). NOTE: demo uses a VARIANT short title ("Idea to
First Paying Users") — ours repeats the H1 until Paul approves variant copy.

## 5. Red-X mistake item
`li flex gap-12px`; X = 20px stroke SVG in ruby, `margin-top 4px`; text
gray-700. (Our L4 numbered 01-05 cards are the richer alternative — keep
cards; this is the lighter fallback.)

## 6. Timeline rail + node
Wrapper `position:relative`; rail `absolute left-32px top/bottom-32px
width-1px bg gray-200` (desktop only). Node per card: `16px circle ·
bg white · border 4px obsidian · absolute left-0 top-32px
translateX(calc(-2rem - 1px))`.

## 7. Module card (the workhorse)
`bg white · radius 16px · border gray-200 · padding 32px · shadow-sm →
shadow-md on hover`. Internal order:
1. eyebrow `12px/700 uppercase tracking-widest gray-400` ("MODULE 1")
2. title `Space Grotesk 24px/600`
3. **Output panel**: `ruby-tint bg · 1px ruby-tint border · radius 8px ·
   padding 16px`; `<strong>Output:</strong>` lead + one sentence.
4. chapter rows: `flex` — mono numeral `gray-400 w-24px` + title with
   `underline decoration-gray-300 underline-offset-4`, hover ruby.
   (In our condensed layout these rows live inside `<details>`.)
5. **leave-with footer**: `border-t gray-100 · padding-top 20px`; green
   check SVG 16px + `<strong>You leave with:</strong>` sentence.

## 8. Collapsed module group ("Module 3-5")
Same card shell; eyebrow "MODULE 3-5", combined title, header row
`flex justify-between items-center` with a chevron affordance. Ours: the
card IS the `<summary>` of a native `<details>` (no JS).

## 9. NOT-cover section
`grid 12-col gap-64px`: heading column (~4col) + list column (~8col). Item:
`flex gap-12px`, 6px gray dot at text top, `<strong>` lead clause + one
plain sentence. Calm by design — no cards, no color.

## 10. Closing island (endcap)
`max-w 896px · bg obsidian · radius 24px · padding 40-64px · centered white`.
Ruby glow: `400px circle · bg ruby/20 · blur-3xl · top-right, half
off-card`. Content: Space Grotesk ~44px heading → gray-300 lede →
primary CTA → `margin-top 64px · border-t white/10 · padding-top 40px`
authorship line (`gray-400 small`, white link).

## Composition rules observed in the demo (why it feels calm)
- ONE loud element per viewport (the ruby CTA); everything else grayscale +
  obsidian islands.
- Section rhythm: `py ~96px`, alternating white / #FAFAFA / white / island.
- Dark appears exactly 3× (hero card, [optionally NOT-cover], closing
  island) — dark-as-island, never dark-as-theme.
- Type scale: 12 uppercase eyebrows → 24 card titles → 36-44 section H2s →
  48-72 hero. Nothing between.

---

## Reference 2 — shuffle b1a3fc85 (W1.6, captured 2026-08-01)

Second ideal reference from Paul (durable capture:
`40.28-reference-shuffle2-full.jpeg`). Same JetVelocity token-map rules as
above (never ship the raw hues). Mid-page components only. This reference is
FLATTER and LESS text-heavy than the current landing — its lesson lists are
shown inline, not behind expanders. It is the north star for W1.6's two named
fixes: kill the expander density and cut on-page text.

### R2.1 Numbered-mistake grid (3-col) — "Why this course exists"
`THE REALITY CHECK` eyebrow → H2 → one lede line → a 3×2 grid of cards. Each
card: ruby counter `01`-`05` (Space Grotesk 700) → **bold short title** →
2-line gray description. The 6th cell is the dark CTA ("Ready to stop
guessing? → Jump straight to syllabus"). **Convergence:** our `.mistake-list`
already renders this grid + dark 6th cell; W1.6 adds the bold-title lead-in
each card was missing (title = 2-4 word summary, description keeps its module
deep link). REPLACES the run-on single-sentence mistake bullets.

### R2.2 Flat module rows (no expander) — "The 5-Module Blueprint"
`THE ROADMAP` eyebrow → H2 → one lede line → one wide card PER module, all
equal, none grouped, none collapsed. Card structure: **head** (MODULE N
kicker + title on the left, `Deliverable: …` on the right) → hairline →
**body** two-column: left = `CHAPTERS` label + a flat numbered lesson list
(`1.1` mono + title link); right = a light `YOU LEAVE WITH` panel (✓ + one
sentence). **Convergence:** REPLACES our 5 `.module-card__details` expanders +
the `Modules 3-5` `.module-group` expander (6 expanders → 0). Cut off-landing:
per-lesson routers, optional-lesson skip-notes, template lists, per-module
"Start Module N" buttons (all reachable on the lesson pages + the kit). Kept
reachable: the numbered lesson links, the per-module "See it in action" Mia
walkthrough link (one compact line), the module deliverable + glossary.

### R2.3 Scope cards (2×2) — "What this course does NOT cover"
`SCOPE RULES` eyebrow → H2 → lede → a 2×2 grid, each cell a card with a bold
title + one-line "why it's out". Reference renders this dark; **we map it to
LIGHT bordered cards** — the max-3-dark-zones budget (hero card + mistake CTA
cell + endcap) is already spent, so a 4th dark band is out. **Convergence:**
REPLACES our 7-item `.not-cover-list` + the `.not-cover-details` expander (7th
expander → 0). Seven exclusions fold into 4 cards (hiring+managing merge;
SEO/content/paid merge) + one residual line for mobile/marketplace + legal, so
no fact is deleted — only relocated into fewer, denser components.
