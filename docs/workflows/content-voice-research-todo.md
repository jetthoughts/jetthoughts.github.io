# Content + SEO + Voice Roadmap

**Created:** 2026-05-08
**Sources:**
- GSC last-7-days report (2026-05-08): top 0-click commercial queries
- Last 20 published posts by frontmatter date
- Client research file `/Users/pftg/Downloads/Управление разработкой для нетехнических фаундеров (1).md`

## SEO Consolidation Roadmap

Sequenced by leverage × effort. Execute top-down; each block is one PR.

### Block 1 — In flight (PR #326)

- [x] Consolidate `/services/fractional-cto-services/` → `/services/fractional-cto/` (canonical) via Hugo alias. GSC `fractional cto services`: pos 75.5, 166 imp, 0 clicks (last 7 days). **Status:** PR #326 open, awaiting CI/merge.
- [ ] Anchor-text upgrade: change 2 weak `[fractional CTO](/services/fractional-cto/)` anchors to `[fractional CTO services](...)` in `5-warning-signs-your-startup-needs-technical-leadership/index.md` and `services/engineering-management-consulting/index.md`. 14 total inbound links; 12 already exact-match.
- [ ] Squash `/services/startup-cto-consulting/` → `/services/fractional-cto/` (same playbook). Overlap rationale: same buyer, fuzzy line, splits authority. Other CTO/leadership pages (`fractional-cto-cost`, `emergency-cto-leadership`, `engineering-management-consulting`) keep — distinct intent.

### Block 2 — Rails performance hub-and-spoke (next sprint)

GSC `ruby on rails performance`: 44 imp, 0 clicks. 10+ posts compete for the same query family.

- [ ] Pick canonical pillar: `ruby-on-rails-performance-optimization-patterns-2026` (newest, recent humanizer pass). Confirm before redirects.
- [ ] Redirect 4 generic Rails-perf posts to canonical:
  - `best-practices-for-optimizing-ruby-on-rails-performance`
  - `maximizing-efficiency-proven-strategies-for-ruby-on-rails-performance`
  - `unlocking-rails-performance-essential-strategies-for`
  - `rails-performance-optimization-15-proven-techniques.md` (also fix malformed single-file path → bundle)
- [ ] Keep narrower-intent posts (different long-tail queries):
  - `design-rails-json-api-with-performance-in-mind-cache` (API caching)
  - `hotwire-turbo-8-performance-patterns-real-time-rails` (Hotwire)
  - `rails-8-solid-cache-performance-redis-migration` (caching layer)
  - `improving-ruby-on-rails-test-suite-performance-...` (test perf)
  - `rails-performance-at-scale-10k-to-1m-users-roadmap` (scale-tier topic)

### Block 3 — Build missing service pages (separate content sprint)

- [ ] Create `/services/react-development/` service page. GSC `react development company`: 55 imp, 0 clicks. Currently no React service page exists; only roundup blog posts. This is a content-write task (≥1 day), not a redirect task. Follow service-page template from `fractional-cto/index.md` frontmatter shape.

### Block 4 — Hygiene & monitoring (recurring)

- [ ] Pre-existing visual regression on master: `DesktopSiteTest#test_blog_index`, `MobileSiteTest#test_blog_index`, `MobileSiteTest#test_blog_post` fail with `difference_level: 0.062389564043209875` (verified pre-existing during PR #326 work). Investigate or update baselines in a focused session.
- [ ] After PR #326 merges: monitor GSC `fractional cto services` query weekly for 4 weeks. Target: pos 75 → top 30 from authority consolidation. Top 10 needs content depth + backlinks (separate sprint).
- [x] ~~Verify suspect authority claims from deleted `fractional-cto-services` page~~ — user confirmed page was AI-imported; claims correctly excluded from canonical.

## Voice-Guide Violations To Fix

- [ ] Add citations for exact founder-facing numbers in `content/blog/infrastructure-spending-evaluation-founders/index.md` and `content/blog/hiring-developers-contractors-budget-guide-founders/index.md`; both contain price/budget claims with no external links.
- [ ] Rewrite `content/blog/remote-team-accountability-non-technical-founders/index.md` to remove repeated bold inline labels (`What It Is`, `Why It Works`, `Red Flag Detection`, `Success Metric`); convert the repeated grid into narrative sections and short checklists.
- [ ] Rewrite `content/blog/production-scaling-langchain-crewai-enterprise/index.md` to remove the repeated bold-label scaffolding and reduce unsupported authority claims around Klarna, AppFolio, and anonymized client results.
- [ ] Rewrite `content/blog/langgraph-workflows-state-machines-ai-agents/index.md` to remove banned phrases (`comprehensive guide`, `transform`) and reduce `workflow` repetition; keep the technical tutorial but cut the guide-style signposting.
- [ ] Replace `Conclusion`, `Final Thoughts`, `Next Steps`, and `Ready to...` sections in the May 8 batch with concrete decision endings that match the voice guide.
- [ ] Reduce mannerism-noun repetition in the technical posts (`workflow`, `pattern`, `framework`, `review`, `contract`, `cycle`, `discipline`) before promoting them in newsletters or social.

## Client Research Integration

- [ ] Treat the research as evidence for a secondary ICP: non-technical founder who has not fully fired the team yet but feels control slipping.
- [ ] Add "information asymmetry" and "loss of operational control" to the ICP pain model; the current ICP over-focuses on post-disaster rescue.
- [ ] Add a control-stage content lane: Job Stories instead of User Stories, weekly working demos, Shape Up appetites, GitHub/admin ownership, independent tech audit, salvage vs rebuild.
- [ ] Add LinkedIn/social experiments based on the research hooks: "Asked for X, got Y", "technical cofounder equity trap", and "who owns your startup code?"
- [ ] Convert the research's Russian/formal language into founder plain English before publication; do not copy the academic framing into blog posts.

## Content Plan Hygiene

- [ ] Reconcile the active content plan with the May 8 posts that shipped outside the schedule.
- [ ] Mark developer-heavy AI/Laravel/Django posts as technical authority content, not ICP-E lead-gen content, unless they are rewritten around founder risk.
- [ ] Keep future founder posts to one primary pain per article; avoid 5,000+ word mega-guides unless the search intent demands it.
