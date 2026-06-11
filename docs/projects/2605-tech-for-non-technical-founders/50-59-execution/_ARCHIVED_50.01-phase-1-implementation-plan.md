# ⚠️ ARCHIVED — DO NOT EXECUTE

**Archived:** 2026-06-10
**Why:** This Phase 1 plan restructures a 9-module course to 6 modules at `content/blog/`. The course now lives at `content/course/tech-for-non-technical-founders-2026/` with a 5-module spine and is mid-migration to v2 micro-lessons (30.03 spec).
**Replaced by:** `TASK-TRACKER.md` "Course Migration Schedule" and the cold-agent route in `PROJECT-INDEX.md`. Tasks 1-23 in this plan would delete, rename, and restructure files using wrong paths — DO NOT execute.
**Historical reference only.** Read `30-39-architecture-design/30.03-course-format-requirements-for-creators.md` for the current lesson format spec.

---

# JT Course Spine Phase 1 Implementation Plan (ARCHIVED)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure the JT "Tech for Non-Technical Founders 2026" course from current 9-module / 34-chapter sprawl to a 6-module / ~24-chapter core spine that gets a newbie non-technical founder to first paying customer in 90 days.

**Architecture:** 6 sequential modules (Hypothesis → Test Demand → Validate Problem → Design from Evidence → Build It Yourself → First Paying Customer). Continuation chapters live as "Going further" callouts at end of Module 6, not as separate modules. Module 0 deleted entirely. AI-augmented method explicit per module.

**Tech Stack:** Hugo static site, Markdown content with YAML frontmatter, `data/course_sequence.yaml` as truth source for module/chapter sequence, Hugo `aliases:` frontmatter for 301 redirects.

**Spec:** `docs/projects/2605-tech-for-non-technical-founders/20-29-strategy/20.09-spine-3-rollout-design.md`

---

## File Structure

### Files deleted (chapter directories removed entirely)

- `content/blog/salvage-vs-rebuild-software-project/`
- `content/blog/switch-dev-shops-safely-transition-guide/`
- `content/blog/cheap-developers-expensive-without-cto-review/`
- `content/blog/asked-simple-admin-panel-built-spaceship/`
- `content/blog/market-type-existing-resegmented-new/`
- `content/blog/validated-problem-statement-decide-whats-next/` (after fold)
- `content/blog/course-map-self-assessment-non-technical-founder-2026/` (Module 0 deletion)
- 4 hire-track directories (after collapse): `who-where-hire-developer-2026-ai-augmented-offshore/`, `fractional-cto-bridge-5-hours-week/`, `hiring-interview-catches-ai-theater/`, `reading-sow-clause-by-clause/`

### Files created

- `content/blog/price-hypothesis-on-smoke-test-page/index.md` (NEW Module 2)
- `content/blog/ai-persona-pre-validation-mom-test-prep/index.md` (NEW Module 3)
- `content/blog/clickable-prototype-validation-2-hour-lovable/index.md` (NEW Module 3)
- `content/blog/channel-selection-before-outbound/index.md` (NEW Module 6)
- `content/blog/hire-track-supplementary-reference/index.md` (collapsed from 4 hire-track chapters)

### Files modified

- `data/course_sequence.yaml` (rebuild from new spine)
- `content/blog/tech-for-non-technical-founders-2026/index.md` (landing — full restructure)
- 7 chapter files (reframes): see Task 11-17
- 4 management chapter files (demoted with stripped course-nav): see Task 18
- 3 AI-era hygiene files (demoted with stripped course-nav): see Task 19
- 1 chapter (mom-test) absorbs folded content: see Task 5
- 1 chapter (find-10-people) gets recruitment-distinction note: see Task 13
- 1 chapter (outbound-without-sales-team) gets sales-distinction note: see Task 14

### Files NOT touched (KEEP as-is)

- `content/blog/form-your-founding-hypothesis-90-minute-sprint/index.md` (Module 1)
- `content/blog/one-page-product-brief-vibe-prd/index.md` (Module 4)
- `content/blog/stop-specifying-features-start-outcomes/index.md` (Module 4)
- `content/blog/github-aws-database-ownership-checklist/index.md` (Module 5 — Day-1 task)
- `content/blog/must-have-segment-pmf-test/index.md` (Module 6)
- `content/blog/first-ten-customers-personal-network/index.md` (Module 6)
- `content/blog/paid-pilot-charge-before-ship/index.md` (Module 6)
- `content/blog/customers-leaving-churn-triage-not-acquisition/index.md` (continuation)
- `content/blog/pivot-or-persevere-decision-framework/index.md` (continuation)
- `content/blog/five-tech-words-stop-nodding-at/index.md` (floating glossary)

---

## Verification gates (run after every task that modifies files)

```bash
bin/hugo-build          # Hugo builds without errors
grep -rn '—' content/blog/<changed-slug>/ # zero em-dashes (use - not —)
rg -l '/blog/<deleted-slug>/' content/    # zero broken inbound links
```

For voice-sensitive changes (reframes + new chapters), additional gate:
- Invoke `reflexion-reflect` skill on the changed chapter before commit
- Slop detector score must be ≤25/100 per CLAUDE.md voice rules
- Cross-post repetition scan per CLAUDE.md cluster rules

---

## Task 1: Cut 5 chapters with no rehoming

**Files:**
- Delete: `content/blog/salvage-vs-rebuild-software-project/`
- Delete: `content/blog/switch-dev-shops-safely-transition-guide/`
- Delete: `content/blog/cheap-developers-expensive-without-cto-review/`
- Delete: `content/blog/asked-simple-admin-panel-built-spaceship/`
- Delete: `content/blog/market-type-existing-resegmented-new/`

- [ ] **Step 1: List inbound links to be repaired** (run before delete to catch references)

```bash
for slug in salvage-vs-rebuild-software-project switch-dev-shops-safely-transition-guide cheap-developers-expensive-without-cto-review asked-simple-admin-panel-built-spaceship market-type-existing-resegmented-new; do
  echo "=== $slug ==="
  rg -l "/blog/$slug/" content/ data/ 2>/dev/null | grep -v "$slug/index.md"
done
```

Expected: Some references in chapter cross-links + landing module index. Capture this list — it determines what Task 2 fixes.

- [ ] **Step 2: Delete the 5 chapter directories**

```bash
rm -rf content/blog/salvage-vs-rebuild-software-project/
rm -rf content/blog/switch-dev-shops-safely-transition-guide/
rm -rf content/blog/cheap-developers-expensive-without-cto-review/
rm -rf content/blog/asked-simple-admin-panel-built-spaceship/
rm -rf content/blog/market-type-existing-resegmented-new/
```

- [ ] **Step 3: Verify Hugo build still passes**

```bash
bin/hugo-build
```

Expected: builds successfully (broken-link warnings acceptable here — Task 2 fixes them).

- [ ] **Step 4: Commit**

```bash
git add -A content/blog/
git commit -m "content(course): cut 5 chapters per Phase 1 spine (rescue + theoretical removed)"
```

---

## Task 2: Repair inbound links from cut chapters

**Files (modified, exact set determined by Task 1 Step 1 output):**
- Likely: `content/blog/customers-leaving-churn-triage-not-acquisition/index.md`
- Likely: `content/blog/pivot-or-persevere-decision-framework/index.md`
- Likely: `content/blog/tech-for-non-technical-founders-2026/index.md` (landing — Module 8 reference will go in Task 21)

- [ ] **Step 1: For each file in Task 1 Step 1 output, replace broken link**

For links to `salvage-vs-rebuild-software-project`: replace with reference to "Salvage or Rebuild decision framework (continuation chapter)" or remove entirely if context allows.

For links to `switch-dev-shops`: same pattern — reference removed or rewritten.

For links to `market-type`: remove entirely (chapter was theoretical, no replacement).

Edit each file using the Edit tool with exact old/new strings. Show the change in commit message.

- [ ] **Step 2: Verify zero broken inbound links remain**

```bash
for slug in salvage-vs-rebuild-software-project switch-dev-shops-safely-transition-guide cheap-developers-expensive-without-cto-review asked-simple-admin-panel-built-spaceship market-type-existing-resegmented-new; do
  echo "=== $slug ==="
  rg -l "/blog/$slug/" content/ data/ 2>/dev/null | grep -v "$slug/index.md"
done
```

Expected: zero output for each.

- [ ] **Step 3: Commit**

```bash
git add content/blog/
git commit -m "content(course): repair inbound links to cut chapters"
```

---

## Task 3: Fix missing slug for "Your First Customer Is Not Marketing"

**Files:**
- Modify: `data/course_sequence.yaml`

- [ ] **Step 1: Locate the broken entry**

```bash
rg -n -B1 -A2 "Your First Customer" data/course_sequence.yaml
```

Expected: an entry missing the `slug:` line. Note line number.

- [ ] **Step 2: Add the missing slug field**

The slug should be `must-have-segment-pmf-test` (verified by `ls content/blog/must-have-segment-pmf-test/`).

Use Edit to add `    slug: must-have-segment-pmf-test` line in the correct position (between the `- ` start and the `title:` line).

- [ ] **Step 3: Verify YAML parses**

```bash
bin/hugo-build
```

Expected: no YAML parse errors.

- [ ] **Step 4: Commit**

```bash
git add data/course_sequence.yaml
git commit -m "data: fix missing slug for must-have-segment-pmf-test entry"
```

---

## Task 4: Apply 1 fold (validated-problem-statement → mom-test)

**Files:**
- Read: `content/blog/validated-problem-statement-decide-whats-next/index.md`
- Modify: `content/blog/mom-test-ask-about-past-not-future/index.md`
- Delete: `content/blog/validated-problem-statement-decide-whats-next/`

- [ ] **Step 1: Read the source chapter to identify the synthesis content to fold**

```bash
cat content/blog/validated-problem-statement-decide-whats-next/index.md
```

Identify the SYNTHESIS section (typically the "writing the validated problem statement" portion) — this is what gets folded into mom-test's closing.

- [ ] **Step 2: Append the synthesis section as the closing of mom-test chapter**

Open `content/blog/mom-test-ask-about-past-not-future/index.md`. Find the existing "## Further reading" or end-of-content marker. Insert a new H2 section BEFORE it: `## Synthesis: Write Down What You Heard, Decide What's Next` with the folded content from validated-problem-statement.

Add a one-line opening: "After your 10 interviews, you have 4 hours of notes. The synthesis below turns notes into the one-page validated problem statement that anchors Module 4."

- [ ] **Step 3: Repair inbound links to validated-problem-statement**

```bash
rg -l '/blog/validated-problem-statement-decide-whats-next/' content/ data/ 2>/dev/null
```

For each match, replace `/blog/validated-problem-statement-decide-whats-next/` with `/blog/mom-test-ask-about-past-not-future/#synthesis-write-down-what-you-heard-decide-whats-next` (Hugo auto-generates the anchor from the H2 text).

- [ ] **Step 4: Delete the source chapter directory**

```bash
rm -rf content/blog/validated-problem-statement-decide-whats-next/
```

- [ ] **Step 5: Verify**

```bash
bin/hugo-build
rg -l '/blog/validated-problem-statement-decide-whats-next/' content/ data/ 2>/dev/null
```

Expected: build passes, zero residual inbound links.

- [ ] **Step 6: Commit**

```bash
git add -A content/blog/
git commit -m "content(course): fold validated-problem-statement into mom-test as synthesis section"
```

---

## Task 5: Collapse 4 hire-track chapters into 1 reference page

**Files:**
- Create: `content/blog/hire-track-supplementary-reference/index.md`
- Read: 4 source chapters
- Delete: 4 source chapter directories after collapse

- [ ] **Step 1: Read all 4 source chapters**

```bash
for slug in who-where-hire-developer-2026-ai-augmented-offshore fractional-cto-bridge-5-hours-week hiring-interview-catches-ai-theater reading-sow-clause-by-clause; do
  echo "=== $slug ==="
  cat content/blog/$slug/index.md
  echo ""
done
```

Identify the strongest 1-2 sections per chapter. Discard preamble/repetitive context.

- [ ] **Step 2: Write the collapsed reference page**

Create `content/blog/hire-track-supplementary-reference/index.md` with frontmatter:

```yaml
---
title: "Hire Track Supplementary Reference"
description: "When you've reached the ceiling of self-serve and need to hire: where to find developers, the Fractional CTO bridge, interviews that catch AI theater, and how to read an SOW. Reference content - return when ready."
date: 2026-07-01
draft: false
author: "JetThoughts Team"
slug: hire-track-supplementary-reference
keywords:
  - hire developer non technical founder
  - fractional cto
  - hire dev shop sow
  - vet developer ai theater
tags:
  - founders
  - non-technical-founder
  - hire-track-reference
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Hire Track Supplementary Reference"
  og_description: "When you've reached the ceiling of self-serve and need to hire: where to find developers, the Fractional CTO bridge, interviews that catch AI theater, and how to read an SOW."
canonical_url: "https://jetthoughts.com/blog/hire-track-supplementary-reference/"
related_posts: false
---
```

Body structure (5 H2 sections):

```markdown
> **Reference content.** This page is supplementary - return when retention from Module 6 is solid AND you've hit the self-serve ceiling. Until then, [Module 5: Build It Yourself](/blog/self-serve-mvp-stack-lovable-supabase-stripe-2026/) is the path.

## When to hire (ceiling signals)

[Pull from `vibe-coding-ceiling-signals` and `should-you-hire` chapters - the 5 signals that mean self-serve has ended]

## Where to find developers in 2026

[Pull strongest 1-2 sections from `who-where-hire-developer-2026-ai-augmented-offshore` - the actual landscape: solo dev, team + manager, outstaff agency, MVP shop, fractional CTO]

## The Fractional CTO bridge

[Pull from `fractional-cto-bridge-5-hours-week` - the cheapest format if you're early; 5 hrs/week + price range + when it works]

## Interviews that catch AI theater

[Pull from `hiring-interview-catches-ai-theater` - the screening questions that distinguish AI-assisted competence from AI-substituted incompetence]

## Reading the SOW

[Pull from `reading-sow-clause-by-clause` - the 6 clauses to redline + the "delivered" definition redline that prevents the $78K staging-URL trap]
```

Use the Write tool with the assembled content.

- [ ] **Step 3: Repair inbound links from the 4 cut chapters**

For each of the 4 hire-track slugs, find inbound links and redirect to the new collapsed page or to a specific anchor:

```bash
for slug in who-where-hire-developer-2026-ai-augmented-offshore fractional-cto-bridge-5-hours-week hiring-interview-catches-ai-theater reading-sow-clause-by-clause; do
  echo "=== $slug ==="
  rg -l "/blog/$slug/" content/ data/ 2>/dev/null | grep -v "$slug/index.md"
done
```

Update each match. Replace specific chapter links with `/blog/hire-track-supplementary-reference/` or anchored sections.

- [ ] **Step 4: Delete the 4 source chapter directories**

```bash
rm -rf content/blog/who-where-hire-developer-2026-ai-augmented-offshore/
rm -rf content/blog/fractional-cto-bridge-5-hours-week/
rm -rf content/blog/hiring-interview-catches-ai-theater/
rm -rf content/blog/reading-sow-clause-by-clause/
```

- [ ] **Step 5: Verify**

```bash
bin/hugo-build
for slug in who-where-hire-developer-2026-ai-augmented-offshore fractional-cto-bridge-5-hours-week hiring-interview-catches-ai-theater reading-sow-clause-by-clause; do
  rg -l "/blog/$slug/" content/ data/ 2>/dev/null | grep -v "$slug/index.md"
done
grep -c '—' content/blog/hire-track-supplementary-reference/index.md
```

Expected: build passes, zero broken links, zero em-dashes.

- [ ] **Step 6: Commit**

```bash
git add -A content/blog/
git commit -m "content(course): collapse 4 hire-track chapters into 1 supplementary reference page"
```

---

## Task 6: Demote 4 management chapters to standalone SEO pages

**Files (modify each):**
- `content/blog/engineering-org-chart-non-technical-founder/index.md`
- `content/blog/friday-demo-rule-founder-progress/index.md`
- `content/blog/three-questions-turn-standup-into-proof/index.md`
- `content/blog/weekly-dev-report-template-founders/index.md`

- [ ] **Step 1: For each of the 4 chapters, add a "supplementary" callout at the top**

Use Edit on each file. Insert the callout between the lead paragraph and the first H2:

```markdown
> **Supplementary content.** This chapter assumes you have a hired team. If you're still on the [self-serve path](/blog/self-serve-mvp-stack-lovable-supabase-stripe-2026/), bookmark this and return when you graduate to a hired team.
```

- [ ] **Step 2: Strip the course-nav table from each chapter's bottom**

Each chapter currently ends with a course-nav table (rendered by theme partial reading from YAML). To strip from these specific chapters: add `course_nav: false` to frontmatter (verify the theme partial respects this; if not, add the conditional).

If theme doesn't currently support `course_nav: false`, add a one-line conditional to `themes/beaver/layouts/partials/blog/course-prev-next.html`:

```html
{{ if not (default false .Page.Params.course_nav) }}{{/* skip if course_nav: false */}}{{ return }}{{ end }}
```

Wait — current default would be true. Reverse: `{{ if eq (default true .Page.Params.course_nav) false }}{{ return }}{{ end }}`. Verify by reading the partial first.

- [ ] **Step 3: Verify**

```bash
bin/hugo-build
# Visually verify: rendered page lacks course-nav table at bottom
curl -s http://localhost:1313/blog/engineering-org-chart-non-technical-founder/ | grep -c 'course-nav' || echo "course-nav stripped"
```

- [ ] **Step 4: Commit**

```bash
git add content/blog/ themes/beaver/layouts/partials/blog/course-prev-next.html
git commit -m "content(course): demote 4 management chapters to supplementary SEO pages"
```

---

## Task 7: Demote 3 AI-era hygiene chapters to standalone SEO pages

**Files (modify each):**
- `content/blog/agency-uses-ai-follow-up-questions/index.md`
- `content/blog/ai-token-bill-dev-shop-pass-through-cost/index.md`
- `content/blog/slopsquatting-ai-supply-chain-attack/index.md`

- [ ] **Step 1: Add "supplementary" callout to each (same pattern as Task 6)**

```markdown
> **Supplementary content.** This chapter is relevant after you've shipped (Module 5+) and your product touches AI in production. Bookmark and return when needed.
```

- [ ] **Step 2: Set `course_nav: false` in frontmatter of each (same pattern as Task 6)**

- [ ] **Step 3: Verify + Commit**

```bash
bin/hugo-build
git add content/blog/
git commit -m "content(course): demote 3 AI-era hygiene chapters to supplementary SEO pages"
```

---

## Task 8: Delete Module 0 with 301 redirect

**Files:**
- Delete: `content/blog/course-map-self-assessment-non-technical-founder-2026/`
- Modify: `content/blog/tech-for-non-technical-founders-2026/index.md` (frontmatter — add aliases)

- [ ] **Step 1: Add Hugo alias on landing page so old Module 0 URL redirects**

Edit landing page frontmatter. Add this field after `canonical_url:`:

```yaml
aliases:
  - /blog/course-map-self-assessment-non-technical-founder-2026/
```

Hugo's `aliases` field generates a `<meta http-equiv="refresh">` redirect on the landing page that catches the old URL.

- [ ] **Step 2: Repair inbound links from Module 0 page**

```bash
rg -l '/blog/course-map-self-assessment-non-technical-founder-2026/' content/ data/ themes/ 2>/dev/null | grep -v 'course-map-self-assessment-non-technical-founder-2026/index.md'
```

For each match, replace with `/blog/tech-for-non-technical-founders-2026/` or remove entirely if context allows.

- [ ] **Step 3: Distribute the 9 foundation concepts to chapter openings**

The 9 concepts (Hypothesis, Smoke test, Clickable prototype, Mom Test, Product Brief, Build path, Ownership, Oversight rhythm, Salvage vs rebuild) currently live in Module 0's "Course foundations" section.

For each concept, identify the chapter where it FIRST appears in the spine, and add the definition as a one-paragraph italic intro at the top of the chapter (after the top callout, before the first H2):

| Concept | Add to chapter |
|---|---|
| Hypothesis | `form-your-founding-hypothesis-90-minute-sprint` |
| Smoke test | `smoke-test-landing-page-300-dollar-validation` |
| Clickable prototype | `clickable-prototype-validation-2-hour-lovable` (NEW — built in Task 16) |
| Mom Test | `mom-test-ask-about-past-not-future` |
| Product Brief | `one-page-product-brief-vibe-prd` |
| Build path | `should-you-hire-2026-decision-tree` |
| Ownership | `github-aws-database-ownership-checklist` |
| Oversight rhythm | (skip — chapter demoted in Task 6; concept lives in glossary only) |
| Salvage vs rebuild | (skip — chapter cut in Task 1; concept lives in glossary only) |

For each chapter in the table, use Edit to insert the concept definition as italic intro paragraph. Pull exact wording from the existing Module 0 file before deleting it.

- [ ] **Step 4: Delete the Module 0 directory**

```bash
rm -rf content/blog/course-map-self-assessment-non-technical-founder-2026/
```

- [ ] **Step 5: Verify redirect works**

```bash
bin/hugo-build
ls public/blog/course-map-self-assessment-non-technical-founder-2026/index.html
# Should exist (Hugo generates redirect HTML at the alias path)
grep 'http-equiv="refresh"' public/blog/course-map-self-assessment-non-technical-founder-2026/index.html
# Should match (redirect meta tag present)
```

- [ ] **Step 6: Commit**

```bash
git add -A content/blog/
git commit -m "content(course): delete Module 0 with 301 redirect; distribute foundations to chapters"
```

---

## Task 9: Reframe `should-you-hire-2026-decision-tree`

**Files:**
- Modify: `content/blog/should-you-hire-2026-decision-tree/index.md`

**Reframe target:** Change the framing from "two equal paths (self-serve vs hire)" to "self-serve is the default; hiring is a ceiling-signal trigger."

- [ ] **Step 1: Dispatch agent with reframe brief + voice gate**

Agent dispatch (general-purpose, sonnet):

```
Mission: Reframe content/blog/should-you-hire-2026-decision-tree/index.md from "two equal paths" framing to "self-serve is the default; hiring is a ceiling-signal trigger."

Specific changes:
1. Opening paragraph: change from "Your Brief plus your bank balance picks one of two doors" to "Self-serve with Lovable + Supabase + Stripe is the default for a non-technical founder in 2026. Hiring is what you do when you hit a specific ceiling signal — not the first decision after the Brief."
2. Decision tree section: keep the questions but reorder so self-serve is "yes path" and hire is "no path with these specific triggers"
3. Closing: end with "Default: self-serve. Continue to Module 5. The ceiling-signal chapter (vibe-coding-ceiling-signals) tells you when to revisit the hire decision."

CONSTRAINT: This is voice-sensitive content. Run reflexion-reflect skill before handback. Slop detector ≤25/100 per CLAUDE.md.

Don't commit. Hand back the diff for review.
```

- [ ] **Step 2: Review diff for voice quality + structural correctness**

Verify:
- Opening paragraph reframed
- Decision tree reordered (self-serve as default)
- Closing redirects to Module 5
- Zero em-dashes
- Voice rubric pass

- [ ] **Step 3: Commit**

```bash
git add content/blog/should-you-hire-2026-decision-tree/
git commit -m "content(course): reframe should-you-hire as ceiling-signal trigger, not parallel path"
```

---

## Task 10: Reframe `self-serve-mvp-stack-lovable-supabase-stripe-2026`

**Files:**
- Modify: `content/blog/self-serve-mvp-stack-lovable-supabase-stripe-2026/index.md`

**Reframe target:** Position as the DEFAULT path for Module 5; hire-track becomes optional sidebar reference.

**Required prose (per spec Critical Distinctions section):** Must include verbatim sentence: "You do NOT polish your Module 3 prototype into the MVP. The prototype was throwaway by design. The MVP is built fresh with production rigor."

- [ ] **Step 1: Dispatch agent with reframe brief**

```
Mission: Reframe content/blog/self-serve-mvp-stack-lovable-supabase-stripe-2026/index.md as the DEFAULT Module 5 path.

Specific changes:
1. Opening: lead with "If you completed Modules 1-4, your default Module 5 path is to build it yourself with Lovable + Supabase + Stripe. Hiring is a ceiling-signal trigger covered in the supplementary reference."
2. Add explicit M3-vs-M5 distinction section: "You do NOT polish your Module 3 prototype into the MVP. The prototype was throwaway by design. The MVP is built fresh with production rigor — real auth, real Stripe, real domain, real user data."
3. Add a "When this path ends" closing section linking to vibe-coding-ceiling-signals (proactive monitoring) and hire-track-supplementary-reference (when ceiling hits)

CONSTRAINT: Voice-sensitive. Run reflexion-reflect. Slop ≤25/100. Verify the verbatim quote in #2 is present.

Don't commit. Hand back diff.
```

- [ ] **Step 2: Verify required prose present**

```bash
grep "You do NOT polish your Module 3 prototype" content/blog/self-serve-mvp-stack-lovable-supabase-stripe-2026/index.md
```

Expected: match found.

- [ ] **Step 3: Commit**

```bash
git add content/blog/self-serve-mvp-stack-lovable-supabase-stripe-2026/
git commit -m "content(course): reframe self-serve-mvp-stack as default Module 5 path"
```

---

## Task 11: Reframe `vibe-coding-ceiling-signals`

**Files:**
- Modify: `content/blog/vibe-coding-ceiling-signals/index.md`

**Reframe target:** From "rescue diagnostic" to "proactive monthly monitoring habit starting at Week 2 of building."

- [ ] **Step 1: Dispatch agent with reframe brief**

```
Mission: Reframe content/blog/vibe-coding-ceiling-signals/index.md from rescue framing to proactive monitoring.

Specific changes:
1. Remove all language implying the build is already broken (e.g., "your codebase is in trouble", "diagnose what went wrong")
2. Reframe as a habit: "Starting at Week 2 of your build, run this 5-signal check monthly. Each signal that fires earlier saves weeks later."
3. Reorder signals so the EARLIEST ones (Week 2-detectable) come first
4. Add a closing section: "If 2+ signals fire in one check, the self-serve path is ending. See [hire track reference]."

CONSTRAINT: Voice-sensitive. Run reflexion-reflect. Slop ≤25/100. No rescue language ("broken", "trouble", "wrong" in present tense referring to the reader's build).

Don't commit. Hand back diff.
```

- [ ] **Step 2: Verify rescue language removed**

```bash
rg -i 'rescue|broken|already wrong|trouble' content/blog/vibe-coding-ceiling-signals/index.md
```

Expected: zero matches in body prose (frontmatter SEO terms can stay if needed).

- [ ] **Step 3: Commit**

```bash
git add content/blog/vibe-coding-ceiling-signals/
git commit -m "content(course): reframe vibe-coding-ceiling-signals as proactive monitoring"
```

---

## Task 12: Reframe `smoke-test-landing-page-300-dollar-validation`

**Files:**
- Modify: `content/blog/smoke-test-landing-page-300-dollar-validation/index.md`

**Reframe target:** Add Stripe price-button section (Gap 1 from research).

- [ ] **Step 1: Dispatch agent with reframe brief**

```
Mission: Add a "Price-button on the landing page" section to content/blog/smoke-test-landing-page-300-dollar-validation/index.md.

Specific changes:
1. After the existing "What goes on the landing page" section, add new H2: "## Add a real price button"
2. Section content: explain why a Stripe payment link (or "Reserve for $X" form) reveals payment intent in a way a waitlist does not. Cover: setting up a Stripe Payment Link in 5 minutes (no account integration needed), interpreting click vs payment vs form-fill rates, the ≥5% click-to-payment-intent threshold as a go/iterate/kill signal.
3. Cross-reference the new dedicated chapter: "For deep dive on price hypothesis, see [Price Hypothesis on the Smoke-Test Page] (will be /blog/price-hypothesis-on-smoke-test-page/)."

CONSTRAINT: Voice-sensitive. Run reflexion-reflect. Slop ≤25/100.

Don't commit. Hand back diff.
```

- [ ] **Step 2: Commit**

```bash
git add content/blog/smoke-test-landing-page-300-dollar-validation/
git commit -m "content(course): add price-button section to smoke-test chapter (Gap 1)"
```

---

## Task 13: Reframe `mom-test-ask-about-past-not-future`

**Files:**
- Modify: `content/blog/mom-test-ask-about-past-not-future/index.md` (already touched by Task 4 fold)

Note: this task COMPLETES the reframing started in Task 4. Task 4 added the synthesis section; this task ensures the chapter opening properly intros the AI persona pre-validation chapter.

- [ ] **Step 1: Add a forward reference to AI persona pre-validation**

Edit `content/blog/mom-test-ask-about-past-not-future/index.md`. After the lead paragraph, add: "Before you book real interviews, sharpen your question list with [AI personas](/blog/ai-persona-pre-validation-mom-test-prep/). Real interviews are irreplaceable for listening — but Claude personas catch weak questions before you waste a real interview slot."

- [ ] **Step 2: Commit**

```bash
git add content/blog/mom-test-ask-about-past-not-future/
git commit -m "content(course): add forward reference to AI persona pre-validation"
```

---

## Task 14: Reframe `find-10-people-with-problem-outreach-2026`

**Files:**
- Modify: `content/blog/find-10-people-with-problem-outreach-2026/index.md`

**Reframe target:** Make the recruitment-vs-sales distinction explicit (per spec Critical Distinctions section).

**Required prose:** "This is interview recruitment, not sales. You are asking for time and insight, not money."

- [ ] **Step 1: Dispatch agent with reframe brief**

```
Mission: Reframe content/blog/find-10-people-with-problem-outreach-2026/index.md to make the recruitment-vs-sales distinction explicit.

Specific changes:
1. Opening: insert verbatim "This is interview recruitment, not sales. You are asking for time and insight, not money. Different message template, different channels emphasized, different reciprocity. Do not use the Module 6 cold email script here — it will scare interview subjects who don't yet know you have a product."
2. Verify the existing channel coverage includes 2026 channels: Reddit DMs, Twitter/X DMs, LinkedIn, UserInterviews.com / Respondent.io paid panels ($25-$100 incentive), community Slack/Discord, personal network referrals, cold email to public lists. Add anything missing.
3. Add the volume target: "30-50 outreach to land 10 interviews. Reply rate ≥20%; show-rate ≥50% of replies."

CONSTRAINT: Voice-sensitive. Run reflexion-reflect. Slop ≤25/100. Verify required verbatim quote present.

Don't commit. Hand back diff.
```

- [ ] **Step 2: Verify required prose present**

```bash
grep "This is interview recruitment, not sales" content/blog/find-10-people-with-problem-outreach-2026/index.md
```

Expected: match found.

- [ ] **Step 3: Commit**

```bash
git add content/blog/find-10-people-with-problem-outreach-2026/
git commit -m "content(course): reframe find-10-people with recruitment-vs-sales distinction"
```

---

## Task 15: Reframe `outbound-without-sales-team`

**Files:**
- Modify: `content/blog/outbound-without-sales-team/index.md`

**Reframe target:** Make the sales-vs-recruitment distinction explicit.

**Required prose:** "This is sales outbound, not interview recruitment. You are asking for money, not time."

- [ ] **Step 1: Dispatch agent with reframe brief**

```
Mission: Reframe content/blog/outbound-without-sales-team/index.md to make the sales-vs-recruitment distinction explicit.

Specific changes:
1. Opening: insert verbatim "This is sales outbound, not interview recruitment. You are asking for money, not time. The 10 people you interviewed in Module 3 may or may not become customers — outreach to them goes through this chapter's sales sequence, not the Module 3 recruitment script."
2. Verify the existing volume target: "100-200 outreach to land 5-10 customers. Reply rate ≥5%; meeting-to-paid ≥20% of meetings."

CONSTRAINT: Voice-sensitive. Run reflexion-reflect. Slop ≤25/100. Verify required verbatim quote present.

Don't commit. Hand back diff.
```

- [ ] **Step 2: Verify + Commit**

```bash
grep "This is sales outbound, not interview recruitment" content/blog/outbound-without-sales-team/index.md
git add content/blog/outbound-without-sales-team/
git commit -m "content(course): reframe outbound chapter with sales-vs-recruitment distinction"
```

---

## Task 16: Write NEW chapter — Price Hypothesis on Smoke-Test Page

**Files:**
- Create: `content/blog/price-hypothesis-on-smoke-test-page/index.md`

**Brief (full version in 20.08 audit, summary here):**
- Module 2 chapter
- Outcome: founder publishes Carrd/Framer page with real Stripe price button
- Signal: ≥5% click-to-payment-intent
- Required artifacts: Smoke-Test Page Brief copy template + Stripe setup checklist

- [ ] **Step 1: Dispatch agent with full chapter brief**

```
Mission: Write content/blog/price-hypothesis-on-smoke-test-page/index.md as a Module 2 chapter teaching newbie non-technical founders to add a real price button to their smoke-test landing page.

Outcome: founder publishes a Carrd or Framer page with a Stripe Payment Link button live, and measures click-to-payment-intent vs form-fills as the demand signal.

Required structure:
- Frontmatter: title "2.2 · Price Your Hypothesis on the Smoke-Test Page", slug price-hypothesis-on-smoke-test-page, standard JT frontmatter
- Top callout: "Module 2 · Step 2 of 2 · Tech for Non-Technical Founders 2026"
- Lead paragraph: why a waitlist signup is a worse signal than a payment-intent click
- H2: Why price IS the hypothesis (not a launch tactic)
- H2: Setting up a Stripe Payment Link in 5 minutes (no account integration, no code)
- H2: What to measure: clicks vs form-fills vs actual payment-intent
- H2: The ≥5% threshold and what to do at each level (kill, iterate, advance)
- H2: Going further (when to revisit pricing post-launch)
- Required artifacts: Smoke-Test Page Brief copy template (inline checklist) + Stripe setup steps (numbered list)

CONSTRAINTS:
- Voice-sensitive content. Run reflexion-reflect before handback. Slop ≤25/100.
- Use - not — for all dashes.
- Newbie ICP: assume reader has not used Stripe before; explain "Payment Link" feature plainly.
- AI-augmented method: include a Claude prompt for generating the price-button copy variants.
- No rescue framing.
- 1500-2500 words (length is byproduct of effective delivery, not a target).

Don't commit. Hand back the file content for review.
```

- [ ] **Step 2: Review chapter for voice + structure**

Verify:
- All required H2 sections present
- Stripe Payment Link instructions are concrete (5-minute setup achievable)
- ≥5% threshold present and explained
- Voice rubric pass
- Zero em-dashes

- [ ] **Step 3: Generate cover image** (defer or use placeholder per existing pipeline)

Use existing `.stitch/design.md` cover-image pipeline. For Phase 1 launch, a placeholder cover is acceptable; cover regeneration can be a Phase 2 task.

- [ ] **Step 4: Commit**

```bash
git add content/blog/price-hypothesis-on-smoke-test-page/
git commit -m "feat(course): NEW Module 2.2 chapter - price hypothesis on smoke-test page"
```

---

## Task 17: Write NEW chapter — AI Persona Pre-Validation (Mom Test Prep)

**Files:**
- Create: `content/blog/ai-persona-pre-validation-mom-test-prep/index.md`

**Brief:**
- Module 3 chapter
- Outcome: founder runs 5-prompt Claude session simulating ICP before booking real interviews
- Signal: top 3 objections identified BEFORE real interviews
- Positioning: AI-as-rehearsal (not replacement)
- Required artifacts: AI Prompt Pack + Objection Tracker template

- [ ] **Step 1: Dispatch agent with full chapter brief**

```
Mission: Write content/blog/ai-persona-pre-validation-mom-test-prep/index.md as a Module 3 chapter teaching newbie non-technical founders to use Claude personas to sharpen Mom Test interview questions BEFORE booking real interviews.

Outcome: founder has 3 sharpened interview questions per persona, with the top 3 objections to test (not discover) in the real Mom Test interviews.

POSITIONING (BLOCKING — must be explicit and threaded throughout):
- AI personas are REHEARSAL, not replacement
- Real interviews stay irreplaceable
- AI catches weak questions; real customers catch weak hypotheses

Required structure:
- Frontmatter: title "3.1 · AI Persona Pre-Validation - Sharpen the Mom Test Before You Book Real Interviews", slug ai-persona-pre-validation-mom-test-prep
- Top callout: "Module 3 · Step 1 of 4 · Tech for Non-Technical Founders 2026"
- Lead: the cost of a bad real interview ($25-$100 incentive + 40 min + 1 of 10 slots burned) vs the cost of a bad AI rehearsal (free, 5 minutes, no slot wasted)
- H2: Why this is rehearsal, not replacement (THE ANTI-AI-REPLACEMENT SECTION — Reddit anti-AI reflex pre-empt)
- H2: Build 3 ICP personas in Claude in 5 minutes
- H2: Run the rehearsal session (the 5-prompt sequence)
- H2: What to keep, what to throw out (interpreting AI persona signal)
- H2: Going further (using AI personas for hypothesis-revision, not just question-revision)
- Required artifacts: AI Prompt Pack (5 prompts inline) + Objection Tracker template

CONSTRAINTS:
- Voice-sensitive. Reflexion-reflect before handback. Slop ≤25/100.
- Newbie ICP. Assume Claude account but no advanced prompt experience.
- Explicit anti-AI-replacement framing (this is the Reddit downvote risk).
- Use - not —.
- 1500-2500 words.

Don't commit. Hand back content for review.
```

- [ ] **Step 2: Verify positioning is explicit + threaded**

```bash
rg -c 'rehearsal|not replacement|irreplaceable' content/blog/ai-persona-pre-validation-mom-test-prep/index.md
```

Expected: ≥4 matches (positioning threaded throughout, not buried in one paragraph).

- [ ] **Step 3: Commit**

```bash
git add content/blog/ai-persona-pre-validation-mom-test-prep/
git commit -m "feat(course): NEW Module 3.1 chapter - AI persona pre-validation (rehearsal not replacement)"
```

---

## Task 18: Write NEW chapter — Clickable Prototype Validation

**Files:**
- Create: `content/blog/clickable-prototype-validation-2-hour-lovable/index.md`

**Brief:**
- Module 3 chapter
- Outcome: founder builds 3-screen Lovable prototype, shows it to 5 of the 10 interviewees
- Signal: pass/fail per session — does user demonstrate the core flow without coaching?
- Required artifacts: Prototype Session Script + Lovable Prompt Template
- Required prose: "This prototype is throwaway. You will discard it after validation. Do not invest in production polish, real auth, or payment integration. The MVP in Module 5 is built differently."

- [ ] **Step 1: Dispatch agent with full chapter brief**

```
Mission: Write content/blog/clickable-prototype-validation-2-hour-lovable/index.md as a Module 3 chapter teaching newbie non-technical founders to build a 2-hour Lovable clickable prototype as the third validation pillar.

Outcome: founder has a 3-screen Lovable prototype shown to 5 of the 10 interview subjects with pass/fail observation logged.

REQUIRED PROSE (BLOCKING — must appear verbatim near the top): "This prototype is throwaway. You will discard it after validation. Do not invest in production polish, real auth, or payment integration. The MVP in Module 5 is built differently."

Required structure:
- Frontmatter: title "3.4 · Build a Clickable Prototype in an Afternoon", slug clickable-prototype-validation-2-hour-lovable
- Top callout: "Module 3 · Step 4 of 4"
- Lead: why a clickable prototype catches what landing pages and interviews miss (solution-shape signal)
- H2: This is throwaway (the verbatim required prose section)
- H2: Build 3 screens in 2 hours with Lovable (concrete walkthrough)
- H2: Run a silent-observation session with 5 interviewees
- H2: Pass/fail scoring (the gate signal)
- H2: What to do with results (revise hypothesis, advance to Module 4, or kill)

Required artifacts: Prototype Session Script (silent-observation facilitation) + Lovable Prompt Template (the prompt that gets you the 3 screens)

CONSTRAINTS:
- Voice-sensitive. Reflexion-reflect. Slop ≤25/100.
- Newbie ICP. Assume Lovable account; explain prompt-to-prototype flow plainly.
- The "throwaway" framing must be threaded, not just in one section.
- Use - not —.
- 1500-2500 words.

Don't commit. Hand back content.
```

- [ ] **Step 2: Verify required prose**

```bash
grep "This prototype is throwaway" content/blog/clickable-prototype-validation-2-hour-lovable/index.md
```

Expected: match.

- [ ] **Step 3: Commit**

```bash
git add content/blog/clickable-prototype-validation-2-hour-lovable/
git commit -m "feat(course): NEW Module 3.4 chapter - clickable prototype validation (throwaway by design)"
```

---

## Task 19: Write NEW chapter — Channel Selection Before Outbound

**Files:**
- Create: `content/blog/channel-selection-before-outbound/index.md`

**Brief:**
- Module 6 chapter
- Outcome: founder picks ONE channel from interview evidence before any outreach
- Signal: 4-week commitment to one channel (not channel-hopping)
- Required artifacts: Channel Selection Worksheet with interview-evidence scoring

- [ ] **Step 1: Dispatch agent with full chapter brief**

```
Mission: Write content/blog/channel-selection-before-outbound/index.md as a Module 6 chapter teaching newbie non-technical founders to pick ONE acquisition channel before sending the first outbound message.

Outcome: founder has a written channel decision (one channel for first 4 weeks of outbound) backed by interview evidence (which channel did the 10 Module 3 subjects say they'd discover this product through?).

Required structure:
- Frontmatter: title "6.1 · Choose Your Channel Before You Send One Message", slug channel-selection-before-outbound
- Top callout: "Module 6 · Step 1 of 5"
- Lead: why channel-hopping in week 2 is the most common newbie mistake
- H2: The 4-week commitment rule (why one channel for 4 weeks beats 4 channels for 1 week each)
- H2: How to pick from interview evidence (Module 3 interviewees told you which channel — listen)
- H2: Channel-fit scoring (price point + buyer type + founder time budget = channel)
- H2: The 4 channels for newbie B2B and B2C (with criteria for each)
- H2: AI-augmented channel research (Claude prompt to map ICP segment to channel fit)

Required artifact: Channel Selection Worksheet with interview-evidence scoring rubric (inline)

CONSTRAINTS:
- Voice-sensitive. Reflexion-reflect. Slop ≤25/100.
- Newbie ICP. Plain language for "channel" (sales channel = how customers find you).
- Cross-reference outbound chapter (this is the decision; outbound is the tactic).
- Use - not —.
- 1500-2500 words.

Don't commit. Hand back content.
```

- [ ] **Step 2: Commit**

```bash
git add content/blog/channel-selection-before-outbound/
git commit -m "feat(course): NEW Module 6.1 chapter - channel selection before outbound"
```

---

## Task 20: Rebuild `data/course_sequence.yaml` from new spine

**Files:**
- Modify: `data/course_sequence.yaml`

- [ ] **Step 1: Write the new YAML**

Replace the entire `data/course_sequence.yaml` content with the new 6-module sequence (no Module 0; new chapters in their slots; cuts removed; fold removed; demoted hire-track collapsed to one entry; demoted management + AI-era removed from sequence).

The new sequence (verbatim slugs from the spec):

```yaml
# Tech for Non-Technical Founders 2026 - chapter sequence (Phase 1 spine)
# Each entry: slug, title (short for nav), module label
# Order = reading sequence on the landing page (Module 1 -> end of Module 6).
# Used by the prev/next partial on chapter pages.
#
# Note: floating glossary - "Five Tech Words to Stop Nodding At" (slug five-tech-words-stop-nodding-at)
# is reference content, accessible from every chapter, not in the linear reading order.
#
# Continuation chapters (customers-leaving-churn-triage-not-acquisition,
# pivot-or-persevere-decision-framework) and supplementary references
# (hire-track-supplementary-reference, demoted management chapters,
# demoted AI-era chapters) are linked from Module 6 "Going further" callout
# but NOT in the linear sequence.

sequence:
  - slug: form-your-founding-hypothesis-90-minute-sprint
    title: "1.1 · Form Your Founding Hypothesis"
    module: "Module 1.1"

  - slug: smoke-test-landing-page-300-dollar-validation
    title: "2.1 · Smoke-Test the Hypothesis"
    module: "Module 2.1"

  - slug: price-hypothesis-on-smoke-test-page
    title: "2.2 · Price Your Hypothesis on the Smoke-Test Page"
    module: "Module 2.2"

  - slug: ai-persona-pre-validation-mom-test-prep
    title: "3.1 · AI Persona Pre-Validation"
    module: "Module 3.1"

  - slug: find-10-people-with-problem-outreach-2026
    title: "3.2 · Find 10 People With the Problem"
    module: "Module 3.2"

  - slug: mom-test-ask-about-past-not-future
    title: "3.3 · The Mom Test (with Synthesis)"
    module: "Module 3.3"

  - slug: clickable-prototype-validation-2-hour-lovable
    title: "3.4 · Build a Clickable Prototype in an Afternoon"
    module: "Module 3.4"

  - slug: one-page-product-brief-vibe-prd
    title: "4.1 · The One-Page Product Brief"
    module: "Module 4.1"

  - slug: stop-specifying-features-start-outcomes
    title: "4.2 · Stop Specifying Features, Start Outcomes"
    module: "Module 4.2"

  - slug: should-you-hire-2026-decision-tree
    title: "5.1 · Build It Yourself or Hire (the Default)"
    module: "Module 5.1"

  - slug: github-aws-database-ownership-checklist
    title: "5.2 · Day-1 Ownership Audit"
    module: "Module 5.2"

  - slug: self-serve-mvp-stack-lovable-supabase-stripe-2026
    title: "5.3 · Build It Yourself: Lovable + Supabase + Stripe"
    module: "Module 5.3"

  - slug: vibe-coding-ceiling-signals
    title: "5.4 · Proactive Ceiling Signals (Monthly Check)"
    module: "Module 5.4"

  - slug: must-have-segment-pmf-test
    title: "6.0 · The Must-Have Segment Test"
    module: "Module 6.0"

  - slug: channel-selection-before-outbound
    title: "6.1 · Choose Your Channel Before You Send One Message"
    module: "Module 6.1"

  - slug: first-ten-customers-personal-network
    title: "6.2 · The First Ten From Your Network"
    module: "Module 6.2"

  - slug: paid-pilot-charge-before-ship
    title: "6.3 · Charge Before You Ship"
    module: "Module 6.3"

  - slug: outbound-without-sales-team
    title: "6.4 · Going Outbound Without a Sales Team"
    module: "Module 6.4"
```

Use Write tool with this exact content.

- [ ] **Step 2: Verify Hugo build passes**

```bash
bin/hugo-build
```

Expected: build passes, no orphan slugs, no missing entries.

- [ ] **Step 3: Verify chapter prev/next nav works**

```bash
curl -s http://localhost:1313/blog/form-your-founding-hypothesis-90-minute-sprint/ | grep -A2 'course-prev-next'
```

Expected: prev = none (Module 1.1), next = smoke-test-landing-page.

- [ ] **Step 4: Commit**

```bash
git add data/course_sequence.yaml
git commit -m "data(course): rebuild course_sequence.yaml from new 6-module Phase 1 spine"
```

---

## Task 21: Rebuild landing page Module index from new spine

**Files:**
- Modify: `content/blog/tech-for-non-technical-founders-2026/index.md`

- [ ] **Step 1: Replace the entire Module index section**

Find the existing `## Module index` section and replace with the 6-module structure pulled from the new YAML. Each module entry has:
- H3 with `Module N - <name>`
- *Output: ...* italic line
- *Start here if...* italic line
- Chapter links

Use the spec (20.09 file, "Architecture: 6-module core spine" section) as source of truth for outcomes + start-here-if conditions per module.

After Module 6, add the "Going further" callout:

```markdown
## Going further (after first paying customer)

These continuation chapters apply once you've passed the Module 6 gate (one paying customer):

- **If your customers are leaving:** [Churn Triage Before Acquisition](/blog/customers-leaving-churn-triage-not-acquisition/)
- **If a key metric has stalled for 2+ months:** [Pivot or Persevere](/blog/pivot-or-persevere-decision-framework/)
- **If you've hit the self-serve ceiling and need to hire:** [Hire Track Supplementary Reference](/blog/hire-track-supplementary-reference/)
- **If your product touches AI in production:** [AI Token Bill](/blog/ai-token-bill-dev-shop-pass-through-cost/) | [Agency AI Questions](/blog/agency-uses-ai-follow-up-questions/) | [Slopsquatting](/blog/slopsquatting-ai-supply-chain-attack/)
```

- [ ] **Step 2: Update other landing page sections that reference old structure**

- "Take this course if" — verify still accurate
- "What you walk away with" — already updated to single Founder OS list; reorder items 1-10 to match new module sequence
- Templates table — remove rows for cut chapters (validated-problem-statement-template, etc.); keep rows for chapters still in scope

- [ ] **Step 3: Verify zero broken links**

```bash
grep -oE '/blog/[a-z0-9-]+/' content/blog/tech-for-non-technical-founders-2026/index.md | sort -u | while read url; do
  slug=$(echo "$url" | sed 's|/blog/||;s|/||')
  test -d "content/blog/$slug" || echo "BROKEN: $url"
done
```

Expected: zero BROKEN output.

- [ ] **Step 4: Commit**

```bash
git add content/blog/tech-for-non-technical-founders-2026/
git commit -m "content(landing): rebuild Module index from Phase 1 spine + Going further callout"
```

---

## Task 22: Add "Going further" callout to end of Module 6 last chapter

**Files:**
- Modify: `content/blog/outbound-without-sales-team/index.md` (last chapter in Module 6 sequence)

- [ ] **Step 1: Append the callout after the existing closing**

Insert before the Further Reading section (or append at end if no Further Reading):

```markdown
## Going further (after your first paying customer)

You've completed the core 6-module course. Continuation chapters apply once you've signed your first paid pilot:

- **Customers leaving in week 2-4?** → [Churn Triage Before Acquisition](/blog/customers-leaving-churn-triage-not-acquisition/) before you spend on more outbound
- **Key metric flat for 2+ months?** → [Pivot or Persevere](/blog/pivot-or-persevere-decision-framework/) decision framework
- **Hit the self-serve ceiling?** → [Hire Track Supplementary Reference](/blog/hire-track-supplementary-reference/) for when to hire and what to look for
- **Product touches AI?** → [AI Token Bill](/blog/ai-token-bill-dev-shop-pass-through-cost/), [Agency AI Questions](/blog/agency-uses-ai-follow-up-questions/), [Slopsquatting](/blog/slopsquatting-ai-supply-chain-attack/) — supplementary references for AI-era hygiene

The course graduates here. Return to the [course landing page](/blog/tech-for-non-technical-founders-2026/) when you're ready to retake it for a new project.
```

- [ ] **Step 2: Commit**

```bash
git add content/blog/outbound-without-sales-team/
git commit -m "content(course): add Going further callout at end of Module 6"
```

---

## Task 23: Final verification gates

- [ ] **Step 1: Hugo build passes**

```bash
bin/hugo-build
```

Expected: clean build, no warnings.

- [ ] **Step 2: Zero em-dashes in all changed files**

```bash
git diff --name-only HEAD~22 HEAD | grep '\.md$' | xargs grep -l '—' 2>/dev/null
```

Expected: zero output.

- [ ] **Step 3: Zero broken inbound links across course content**

```bash
# Build set of all course slugs from new YAML
slugs=$(grep -E '^\s+slug: ' data/course_sequence.yaml | sed 's/.*slug: //')
# Plus floating + supplementary slugs
extra="five-tech-words-stop-nodding-at hire-track-supplementary-reference customers-leaving-churn-triage-not-acquisition pivot-or-persevere-decision-framework agency-uses-ai-follow-up-questions ai-token-bill-dev-shop-pass-through-cost slopsquatting-ai-supply-chain-attack engineering-org-chart-non-technical-founder friday-demo-rule-founder-progress three-questions-turn-standup-into-proof weekly-dev-report-template-founders"

# Find every /blog/X/ link and verify X exists
grep -rohE '/blog/[a-z0-9-]+/' content/blog/ | sort -u | while read url; do
  slug=$(echo "$url" | sed 's|/blog/||;s|/||')
  test -d "content/blog/$slug" || echo "BROKEN: $url"
done
```

Expected: zero BROKEN output.

- [ ] **Step 4: Visual regression**

```bash
bin/test
bin/dtest  # Linux/Docker test (per CLAUDE.md mandatory gate)
```

Expected: visual regression passes for landing + 4 new chapters + 7 reframed chapters. Update baselines if changes are intentional.

- [ ] **Step 5: Voice rubric spot-check on 3 random changed chapters**

```bash
# Pick 3 changed chapters at random
git diff --name-only HEAD~22 HEAD | grep 'content/blog/.*index.md' | shuf -n 3
```

For each, run reflexion-reflect manually or via skill. Spot-check slop score ≤25/100.

- [ ] **Step 6: Final commit (if anything was caught + fixed in steps 1-5)**

```bash
git add -A
git commit -m "content(course): final verification fixes for Phase 1 spine launch"
```

---

## Definition of done (Phase 1 complete)

- ☐ All 23 tasks marked complete with checkbox
- ☐ 6-module spine live on landing page
- ☐ 4 new chapters published (price, AI-persona, prototype, channel)
- ☐ 7 reframed chapters republished with required prose statements verified
- ☐ 5 cuts removed; 1 fold merged; 10 demotions applied
- ☐ Module 0 deleted with working redirect (verified via Hugo `aliases:`)
- ☐ data/course_sequence.yaml reflects new 6-module spine
- ☐ All chapter pages pass `bin/hugo-build` and `bin/test`/`bin/dtest`
- ☐ Voice rubric pass on all new + reframed content
- ☐ Zero broken inbound links across course content
- ☐ "Going further" callout at end of Module 6 + on landing page

---

## Out of scope for Phase 1 (deferred)

Per spec section "Out of scope for Phase 1":
- Formal continuation modules 7-8
- Advanced modules 9-10 for repeatable GTM
- 6A/6B slug renumbering (defer)
- Topic ID convention overhaul beyond core 6 modules
- Course completion analytics infrastructure (manual feedback survey only for v1)
- Email gate / signup flow

---

## Open items (none blocking — proceed once plan approved)

- Cover image generation for 4 new chapters (use Stitch pipeline post-launch if needed)
- Final naming for the 4 new chapters' titles (slugs locked; titles refinable during chapter write)
- Lead-magnet artifacts referenced in chapters (Smoke-Test Page Brief, AI Prompt Pack, Prototype Session Script, Channel Selection Worksheet) — drafts can ship inline as markdown checklists; downloadable versions are Phase 2

---

## Execution dependency graph

```
Task 1 (cuts) ──┐
                ├──► Task 2 (link repair) ──► Task 3 (slug fix) ──► Task 4 (fold)
Task 5 (collapse hire-track) ──► Task 6 (demote mgmt) ──► Task 7 (demote AI-era) ──► Task 8 (Module 0 delete)
                                                                                          │
                                              Tasks 9-15 (7 reframes, parallel-safe) ◄────┤
                                              Tasks 16-19 (4 new chapters, parallel-safe) ◄┤
                                                                                          │
                                              Task 20 (YAML rebuild) ◄────────────────────┘
                                              Task 21 (landing rebuild)
                                              Task 22 (Going further callout)
                                              Task 23 (verification gates)
```

Tasks 9-15 can run in parallel as separate agent dispatches (each is a single-chapter reframe).
Tasks 16-19 can run in parallel as separate agent dispatches (each is a single new-chapter write).
Tasks 20-22 must run sequentially (YAML → landing → callout) and AFTER 9-19 complete.
Task 23 is the final gate.

Estimated total dispatches: ~15-20 (some can be batched).
