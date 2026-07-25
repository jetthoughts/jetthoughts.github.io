# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Primary (confirmed 2026-07-26): **"Alex" — the burned non-technical founder** (ICP-E, canonical profile: `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`). Pre-seed to Series A, MVP built by a dev shop / freelancer / AI tool (Lovable, Bolt, Replit, Cursor), now breaking on real users or held hostage by the builder. Arrives skeptical and burned — every vendor promise pattern-matches to the shop that burned them. Decides alone under $50K.

Secondary audiences (surfaces pick explicitly, never blend): "Sam" — idea-stage non-technical first-timer (the course, `content/course/`); the blog's historical Rails-dev/CTO readership (technical posts).

## Product Purpose

jetthoughts.github.io is JetThoughts' marketing site, blog, and course home. Its #1 success event (confirmed 2026-07-26): **a booked free Rescue Context Call** — the NeetoCal booking for the 45-minute call + 48-hour AI-assisted audit that opens the rescue funnel (free audit → $2,500 triage → $7,500 rescue → $10,000 foundation reset). Business goal of record: 1 signed rescue engagement by Nov 30, 2026 (`docs/projects/2607-vibe-code-rescue/`).

## Positioning

**Ownership and trust, not "we fix code."** The wedge a competitor cannot truthfully copy: code and account ownership handed back at each milestone, and Paul (CEO) on every call as the founder's fractional CTO translating dev work into decisions. Six competitor rescue shops lead with "your vibe-coded app is breaking"; JetThoughts leads with "you will own and understand what you paid for." Salvage-vs-rebuild verdicts are honest even when rebuild is the harder sale.

## Operating Context

The visitor typically lands from a personal outreach reply, a Reddit/IndieHackers thread, or a warm referral — already mid-crisis, often on a phone, primed for distrust of agency marketing. The conversion surface is the NeetoCal booking page (live: `https://jetthoughts.neetocal.com/free-code-audit-find-out-whats-actually-broken-before-you-spend-another-dollar`) with a 5-question intake. Offer canon: `docs/projects/2607-vibe-code-rescue/rescue-sprint/offer-one-pager.md`. Audit process + data-handling contract: `rescue-sprint/discovery-kit.md`.

## Capabilities and Constraints

- Hugo static site; build `bin/hugo-build`; PostCSS pipeline; component reuse is mandatory (paved path: `docs/workflows/new-page.md`).
- Blocking gates for any HTML/CSS change: `bin/test` (macOS) AND `bin/dtest` (Linux) visual regression, Chrome-devtools console/network zero-error checks, visual scroll gate.
- Pricing canon (A2, confirmed 2026-07-22): free audit / $2,500 / $7,500 / $10,000 — no other offer numbers may appear.
- Voice: `90.11-voice-guide.md` — zero AI-pattern language; `-` not `—` in content; banned structural patterns list applies to all marketing copy.

## Brand Commitments

- **JetVelocity design system** (binding, canonical: `.stitch/design.md`): obsidian dark, Ruby red `#cc342d` as the brand accent ink, neon purple `#a855f7`. Ruby red is the accent, not decoration.
- Voice: plain-English practitioner, Rob Walling directness + Rand Fishkin vulnerability for founder-facing copy; no therapist voice, no slogans.
- Name/assets: JetThoughts, founded 2011 (tenure claim is "since 2011" — never "20 years").

## Evidence on Hand

Confirmed policy (2026-07-26): **sourced numbers only — nothing beyond these** on any marketing surface:
- 4.8/5 rating from 32 clients · 5-year average client relationships · 95% client retention · shipping Rails since 2011 · developers average 8+ years experience.
- **Real verbatim founder quotes** from `docs/projects/2607-vibe-code-rescue/rescue-sprint/voice-of-customer.md` are allowed, appropriately attributed/anonymized.
- **Absence that must not be fabricated** (repo-derived): no completed Vibe-Code-Rescue case study of our own exists yet — first engagement's case study is an Oct 2026 milestone. Surfaces must not imply one. Market examples (e.g. the $40K YC rescue) are third-party evidence and must be labeled as such.

## Product Principles

1. **Trust is the product; the rescue is the delivery.** Every surface earns belief from a visitor who has been burned — proof over promises, risk-reversal over pressure.
2. **The founder keeps something either way.** The free audit's write-up is theirs whether or not they hire us; surfaces make the no-strings shape of the offer unmistakable.
3. **Plain English or it doesn't ship.** If a burned non-technical founder can't parse a sentence, the sentence is wrong.
4. **Sourced claims only.** Any number, rating, or story on a surface traces to the Evidence list or a named third party — fabrication is a blocking failure.
5. **One next step.** The site funnels to one action: book the Rescue Context Call.

## Accessibility & Inclusion

Repo gates require zero console errors and mobile (390×844) verification on every page; audience skews non-technical, so reading level and jargon-glossing are treated as accessibility concerns, not style preferences.
