# Course Chapter Writing Pipeline

Canonical pre-write + during-write guide for chapters in the **From Idea to First Paying Customer** course (`content/course/tech-for-non-technical-founders-2026/`, formerly "Tech for Non-Technical Founders 2026"). Built from 35+ documented regressions, 3-agent ICP audits, and the voice guide.

**Companion docs (do not duplicate):**
- `docs/projects/2605-tech-for-non-technical-founders/50-59-execution/mechanical-audit-checklist.md` — post-write audit with Cases 1-35
- `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` — JT voice rules + banned structural patterns
- `content/course/tech-for-non-technical-founders-2026/_index.md` — module index + landing page

---

## When to use this doc

Apply BEFORE writing any new chapter, BEFORE drafting structural revisions, and BEFORE merging anyone else's chapter edits into a course chapter. Skim section 1-3 every time; deep-read sections 4-12 on first chapter draft.

If you're doing a 1-sentence fix (typo, price update, link swap), this doc is overkill — apply the surgical-edit discipline from CLAUDE.md and ship.

---

## 1. The Course ICP — read FIRST every time

The course ICP is **"Sam"**, not the website ICP "Alex the burned founder". Confusing the two has cost multiple revision passes.

| Attribute | Sam (course ICP) | Alex (website ICP) |
|---|---|---|
| Stage | Idea-stage, no team yet | Post-team-fail, mid-rescue |
| Money | ~$20K personal savings | Has burned $50K-$500K with a shop |
| Time | Lunch breaks + nights/weekends, still has day job | Full-time on the company |
| Software experience | Has NEVER hired a developer, signed an SOW, shipped to production | Has hired, has shipped, has been burned |
| Tech vocab | Reads Stripe + finance docs fluently. Doesn't know what GitHub, AWS, Postgres are | Has been told 100 jargon words by 100 contractors |
| Goal | Get to first paying customer without burning the savings | Recover or rebuild what the team broke |

**Rule:** every chapter body is for Sam. Rescue/triage chapters (e.g. ownership audit, salvage-vs-rebuild) live in the course but must self-frame as "this also works as a Day-1 preventive" or "this is a side-path for active rescue" so Sam recognizes the chapter applies to him.

**The ICP-reader read-back gate (BLOCKING):** before handback, re-read the edited chapter top-to-bottom AS Sam. Confirm (1) every acronym/tool/term is glossed at FIRST mention, (2) orientation blocks don't front-load thresholds/metrics, (3) the opener doesn't lead with a scenario Sam can't picture himself in.

---

## 2. Pre-write mandatory reads

1. **`docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`** — voice, banned words, Cases 1-35 banned structural patterns
2. **`docs/projects/2605-tech-for-non-technical-founders/50-59-execution/mechanical-audit-checklist.md`** — Cases 1-35 + read-back items
3. **`content/course/tech-for-non-technical-founders-2026/_index.md`** — module index, where your chapter fits in the linear path
4. **The previous chapter (M.N-1) and next chapter (M.N+1)** — read their declared Input/Output so your chapter's handoff is clean
5. **`docs/projects/2605-tech-for-non-technical-founders/10-19-research/10.05-content-organization-patterns-2026.md`** Part 2 — cognitive load + F-pattern rules

---

## 3. Chapter structure — the required skeleton

Every chapter follows this skeleton. Sections marked **REQUIRED** are non-negotiable.

```
---
Frontmatter (REQUIRED)
---

> Module X · Step N of M · [course landing link]  (REQUIRED orientation callout)
>
> Input: [exact artifact from previous chapter]  (REQUIRED)
>
> Output: [exact artifact this chapter produces]  (REQUIRED)

[Opener: 1-2 paragraphs. Either (a) named-founder vignette, (b) stat-anchored hook,
 (c) definitional opener, (d) principle-statement, or (e) direct second-person.
 NEVER the same opener template as the chapter before AND after you (rotation gate).]

[Optional hero visual — Mermaid diagram or sketchy SVG. Hand-drawn aesthetic, NOT polished
 corporate infographic. Must be informational, not decorative.]

[Body sections — each ## H2 has one job. Each section starts with its main point in
 sentence 1, then evidence, then one actionable takeaway.]

## What to do tomorrow  (REQUIRED in every chapter — Sam's next concrete action)

[3-5 numbered actions Sam can take Monday morning. Each names: time budget, $ cost,
 the failure signal that means "stop and pivot."]

## Further reading  (OPTIONAL — for Sam who wants to go deeper)
```

### Frontmatter requirements

| Field | Required | Rule |
|---|---|---|
| `title` | yes | "**N.M** · [Chapter Name]" — chapter number in YAML matches landing-page module index |
| `description` | yes | 140-160 chars, mentions "Chapter N.M of this course" |
| `date` | yes | Real date, not future (Hugo hides future-dated content) |
| `draft` | yes | `false` for published; `true` for in-progress (still runs full pipeline) |
| `author` | yes | "JetThoughts Team" |
| `slug` | yes | URL-friendly, never change after publish |
| `cover_image` + `cover_image_alt` | yes | Cover image is source of truth for proof points (don't echo cover counts in body) |
| `metatags.og_title` + `og_description` | yes | Must match `title` / `description` thematically — drift breaks social cards |

---

## 4. Voice — DO and AVOID

### DO

- **Every sentence needs a human subject doing something.** "The migration broke" → "The contractor's migration broke at 3am because the staging DB had no foreign keys."
- **Use - not — for all dashes.** Em-dashes are a documented AI tell.
- **Show, don't tell.** Replace adjectives with concrete scenarios the reader can picture.
- **Practitioner-level specifics.** Named clients (anonymized OK), exact dollar amounts, exact timelines, exact failure mechanics.
- **Trade-off honesty.** Every chapter names what the proposed approach FAILS to do or costs.
- **90/10 rule.** ≥90% education, ≤10% promotion. Sam should learn something useful even if he never contacts JetThoughts.

### AVOID — zero tolerance (reject on sight)

| Pattern | Example | Fix |
|---|---|---|
| Rule of three | "It's faster, cheaper, and simpler." | Drop one or vary the structure |
| Triple rhetorical questions | "What if you could? What if it worked? What if it was free?" | Cut to one specific question |
| Slogany flips | "It looks free. It isn't." or "X works. Y doesn't." | Plain prose |
| Slogany reveal-twists | "The hypothesis hadn't been wrong - the questions had been." | Drop the twist, state the mechanic |
| Negative parallelism | "No tests. Open endpoints. Corrupted data." | One full sentence with a subject |
| Impersonal fragment stacking | "React + Rails, clean conventions, the demo sailed." | Add a human subject |
| Sustained staccato | 3+ consecutive short fragments | Vary sentence length |
| Command-structure repetition | 3+ paragraphs starting with imperatives ("You build... You add... You write...") | Collapse to one noun-phrase |
| Apologetic caveats | "every project is different", "it depends on the use case" | Cut entirely |
| Therapist voice | "It's okay to feel overwhelmed." | Cut entirely |
| Fluffy AI narration | "The alerts fire correctly. Then someone upgrades..." (dramatic present-tense) | Past tense, named incident |
| Fake authority generalization | "We've seen this on every codebase" | Specific count: "The last three codebases we inherited..." |
| Cinematic time-cuts | "Nine months later: a product, a $62K dev invoice, zero paying customers" | Drop the cut, state the outcome plainly |
| Cute aphoristic flourish | "polite noise", "the kind smile that costs you a year" | Cut entirely |
| Cost-stacked tri-list opener | "$25-$100 in incentives, 40 minutes of calendar, one of the 10 slots" | One sentence with one concrete cost |
| Fabricated cohort stats | "4 of 5 real interviewees", "30-45% reply rates" | Use real measured numbers OR drop the stat |
| Year-stamp fabrication | "Last year" without checking if the technology existed then | Verify timeline against real history |
| Banned heading "## Why this matters in 2026" / "## Why this matters more in 2026" | Case 25 | Use a heading that names the SPECIFIC content of the section |
| "Founders who..." / "Most founders..." | Case 16 — cap ≤2 per chapter | Reframe with named scenario or direct address |
| "A founder we worked with..." template opener | Case 17 — cap ≤1 chapter in 3 consecutive | Rotate opener shape across chapters |
| `## Why this matters` / `Founders who skip` / `Most founders` | Case 25 + 16 — grep regression sweep is BLOCKING before handback | See section 13 |

---

## 5. Practicality — the Monday-morning test

Every chapter must pass these 4 practicality gates:

1. **Time budget declared and honest.** "90-minute sprint" must actually take 90 minutes. "4-week ship plan" must be the build portion only; don't roll in validation weeks.
2. **$ budget declared.** Even $0 chapters must say "$0" explicitly. Sam needs to know whether to open his wallet.
3. **Concrete next action.** "Open X, do Y, by Friday." Not "consider", not "explore", not "think about."
4. **Failure mode named.** Tell Sam what FAILURE looks like: "if 0 of 35 click", "if 9 of 10 say yes politely", "if 2 test users stall on screen 1-2." Sam's intuition is unreliable at idea stage — the chapter must provide the diagnostic signal.

**Cumulative time anchor (BLOCKING for any chapter declaring time):** state where the chapter fits in the 8-12-week / 40-60-hour journey from idea to first paying customer. Don't let Sam infer "8 hours total" from the per-chapter callouts.

---

## 6. Pedagogy — progressive disclosure + scaffolding

1. **Orientation before body.** Input/Output/time/cost callout BEFORE any prose. Sam knows what he's getting into before he commits to reading.
2. **Progressive disclosure.** Concepts in the order Sam needs them. NEVER reference a tool, term, or framework before glossing it on first mention. "Pick Lovable Pro" only AFTER "Lovable is an AI app builder, free trial, paid plans from $20/mo."
3. **Scaffolding from previous chapter.** Accept the previous chapter's declared Output as your Input. Don't ask Sam to re-derive anything. If Chapter N.M produces "10 ICP interviewees booked", Chapter N.M+1 starts with "Given your 10 booked interviewees...", not "Now book 10 interviewees..."
4. **One walked-through example per chapter.** Frameworks + tables + bullets are necessary but NOT sufficient. Include ONE full example end-to-end (named persona, real numbers, named outcome). M1.1's Gmail 2003 example and M3.1's freelance-bookkeeper example are the gold standard.

### Inter-chapter handoff audit (BLOCKING for any structural change)

For each chapter you touch, verify:
- Does the previous chapter's Output match your declared Input verbatim?
- Does the next chapter's Input match your declared Output verbatim?
- Are there any "see Chapter X" deferrals that ask Sam to tab-switch for required content? Inline it instead.

---

## 7. Tool glossary policy (BLOCKING)

Every tool/acronym needs a one-line gloss at **first mention in each chapter** (not just first mention in the course). Sam may land on any chapter via Google search.

Gloss format: `[Tool name] (what it is + free/paid status + key constraint if any)`.

Examples:
- ✅ "Lovable (an AI app builder that generates a working web app from English prompts - free trial, paid plans from $20/month, no coding required)"
- ✅ "Supabase (a managed database + login service that stores users and data - free tier covers early-stage usage, paid plans from $25/month)"
- ✅ "MFA = Multi-Factor Authentication (the 6-digit code your phone shows when you log in - a second proof beyond your password)"
- ❌ "Lovable (see the gloss in Chapter 4.3)" — deferral fails the search-landing test
- ❌ "Use RLS to enforce isolation" — RLS unglossed
- ❌ "the webhook fires" — webhook unglossed for Sam

**Common terms requiring gloss on first mention in each chapter:**
Lovable · Supabase · Stripe (mostly assumed background, but webhook needs gloss) · Carrd · Notion · Loom · GA4 · Microsoft Clarity · ad-platform pixel · webhook · RLS · MFA · IAM · WHOIS · ICANN · ICP · CR · OAuth · SAML · SOC2 · HIPAA · PCI · ORM · JWT · BOLA · CSV

---

## 8. Visual + cognitive-load rules

Apply for any chapter > 800 words.

### Required
- **First-3-seconds visual hook** — every long-form chapter needs a visual within the first viewport. Hero diagram, infographic, or strong styled callout. Pure-text hero = 71% dropout per Pew 2026.
- **One visual break per H2.** Plain prose blocks across 3+ consecutive H2s = density problem.
- **Labels INSIDE diagrams**, not beside them. If a diagram needs a 200-word "what this shows" paragraph, fix the diagram.

### Forbidden
- Decorative photography ("happy founders at laptops")
- Generic abstract gradients
- Icon arrays without informational content
- Polished corporate infographics — JT brand uses hand-drawn / Excalidraw / sketchy-Mermaid aesthetic

### Mermaid + SVG width constraint
Article column is **684px max**. Pre-check width budget BEFORE designing:
- Mermaid LR with ≥5 nodes will fail
- SVG with prose-text rows will clip
- 5-column tables will overflow on mobile
Use TD orientation (top-down) for tall diagrams or compress nodes.

### Visual verification gate (BLOCKING for any new visual)
After adding any Mermaid/SVG/image/table/callout:
1. Take chrome-devtools screenshots at desktop (1280×800) AND mobile (390×844)
2. Score honestly against 4 criteria:
   - Is it a great look? (harmony, contrast, alignment)
   - Is it functional? (readable without zoom, mobile renders)
   - Would it make Sam want to read more?
   - Is it helpful overall? (teaches vs decorates)
3. Any NO on criteria 3 or 4 = ROLLBACK before commit

---

## 9. Cold-eyes review gate (BLOCKING before handback)

For any new chapter OR structural revision, dispatch 3-4 parallel critic agents BEFORE marking the work done.

Personas (specialized agents per `feedback_agent_selection_bias`):
1. **`voltagent-biz:ux-researcher`** — ICP-Sam reader-fit. Does Sam recognize himself? Is he at the right stage? Are tools glossed? Does he know what to do?
2. **`voltagent-biz:content-marketer`** — Monday-morning practicality. Time honest? $ named? Concrete action? Failure mode named?
3. **`tutorial-engineer`** — Pedagogical effectiveness. Orientation OK? Progressive disclosure? Scaffolds from previous? Worked example?
4. **AI-feel detector** (any critic with the voice-guide pattern list) — Cases 1-35 regression sweep.

**Process the panel in parallel** — single message, 3-4 Agent tool calls.

**Synthesize convergent vs divergent:** issues flagged by ≥2 agents are high-confidence fixes. Single-agent flags are judgment calls.

**Codex cross-check (per CLAUDE.md):** for structural changes touching ≥3 files, dispatch `codex:codex-rescue` as the 4th independent reviewer. Surface what Codex said BEFORE applying.

---

## 10. Post-write checklist

Run these in order. Any failure blocks handback.

### Mechanical (machine-checked)
- [ ] `bin/validate-course` — 7 validators pass (disclaimer-consistency, no-em-dash, year-stamp-fabrication, chapter-number-consistency, title-yaml-match, internal-link-existence, table-width)
- [ ] `bin/hugo-build` — no Hugo errors, page renders
- [ ] No em-dashes (`grep "—" content/course/...`)

### Banned-pattern regression sweep
- [ ] `grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with\|A founder we worked\|A founder we picked\|A founder we spoke" content/course/tech-for-non-technical-founders-2026/your-chapter-slug/`
- [ ] Any hit on `## Why this matters` (Case 25) = BLOCKING fix
- [ ] >2 "Founders who" / "Most founders" hits per chapter (Case 16) = BLOCKING fix
- [ ] Same opener template as ≥2 adjacent chapters (Case 17) = BLOCKING fix

### ICP read-back
- [ ] Read the chapter top-to-bottom AS Sam
- [ ] Every tool/acronym glossed at first mention in THIS chapter
- [ ] Orientation block doesn't front-load thresholds/metrics
- [ ] Opener doesn't lead with a scenario Sam can't picture himself in
- [ ] "What to do tomorrow" section has concrete actions with time + $ + failure signal

### Inter-chapter handoff
- [ ] Declared Input matches previous chapter's declared Output
- [ ] Declared Output matches next chapter's declared Input
- [ ] No "see Chapter X" deferrals for content Sam needs in-chapter

### Visual gate
- [ ] Hero visual within first viewport
- [ ] Chrome-devtools verified at desktop + mobile
- [ ] Scored 4 criteria honestly; no NO on items 3 or 4

### Cold-eyes panel
- [ ] 3-4 parallel critics dispatched
- [ ] Convergent issues surfaced to user
- [ ] Surgical fixes applied (NOT page-bombing rewrites)

---

## 11. Inter-chapter consistency

Course-level rules that span multiple chapters.

### Opener-shape rotation gate (BLOCKING)
No 3+ consecutive chapters in the same module may share the same opener shape. Templates to rotate:
- Named-founder vignette ("Maya, a founder we worked with...")
- Anonymous-founder vignette ("A founder we picked up...")
- Stat-anchored ("Eleven interviews, nine 'yes...'")
- Dollar-anchored ("Fourteen months of $23K monthly invoices...")
- Definitional ("**Vibe Coding** is shipping a real product with AI-generated code...")
- Principle-statement ("This is interview recruitment, not sales.")
- Direct second-person ("You have an idea, or a half-built MVP...")

### Cross-post signal portfolio
Each chapter owns ONE primary diagnostic signal — don't repeat the same lead signal across cluster chapters. M1.2 owns "smoke-test CR%". M2.3 owns "Mom Test scoring rubric". M3.1 owns "one-page brief sections". M4.3 owns "4-week ship plan demos". M4.4 owns "5 ceiling signals scoreboard."

### Anecdote scan
Before finalizing, grep cluster chapters for repeated named clients, dollar amounts, technical mechanics. The URL-ID/BOLA story repeated across cluster posts in May 2026 was caught by this scan.

---

## 12. Surgical edit discipline (BLOCKING for content edits)

When the user flags ONE attribute (a price, a tool name, a heading, a year-stamp):
- Change ONLY the sentences containing that attribute
- Do NOT rewrite, re-balance, or re-theme the surrounding chapter
- Name the chapter's thesis in one line first and confirm it's unchanged
- If a fix seems to need touching >1 paragraph or the structure, STOP and ask before expanding scope

When correcting a stance the user called too far one way: land at the documented middle. Do NOT swing to the opposite extreme. (The budget free→paid→balanced pendulum cost 4 round-trips on 2026-05-22.)

Before handback, grep your OWN replacement text for the exact pattern you just removed (year-stamp, banned word, hardcoded tool name) — re-introducing the defect you're fixing is a blocking failure.

---

## 13. Common regressions — the grep sweep

Run this before every handback. Any hit triggers a Tier-1 fix.

```bash
# Case 25 banned headings (zero tolerance)
grep -rn "## Why this matters" content/course/tech-for-non-technical-founders-2026/

# Case 16 generalized actor (cap ≤2 per chapter)
grep -rni "most founders\|founders who" content/course/tech-for-non-technical-founders-2026/your-chapter/

# Case 17 founder-vignette template (rotate across chapters)
grep -rn "A founder we worked\|A founder we picked\|A founder we spoke\|founder we sat with" content/course/tech-for-non-technical-founders-2026/

# Em-dashes (banned)
grep -rn "—" content/course/tech-for-non-technical-founders-2026/your-chapter/

# Apologetic caveats (banned)
grep -rni "every project is different\|depends on the use case\|your mileage may vary" content/course/tech-for-non-technical-founders-2026/your-chapter/

# Cumulative time-banner present on long-build chapters
grep -n "8-12 weeks\|40-60 hours" content/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/index.md
```

---

## 14. Banned patterns reference (Cases 1-35)

Full catalog in `docs/projects/2605-tech-for-non-technical-founders/50-59-execution/mechanical-audit-checklist.md`. Critical subset:

| Case | Pattern | Cap |
|---|---|---|
| 16 | "Founders who..." / "Most founders..." generalization | ≤2 per chapter |
| 17 | "A founder we worked with..." anonymous-vignette opener | ≤1 in any 3 consecutive chapters |
| 25 | "## Why this matters in 2026" / "## Why this matters more in 2026" heading | 0 (banned outright) |
| 32 | Command-structure repetition (3+ "You verb" sentences in a row) | 0 |
| 33 | Cinematic time-cut ("Nine months later:") | 0 |
| 34 | Cute aphoristic flourish ("polite noise") | 0 |
| 35 | Anonymous-named-founder opener template repeated 3+ consecutive | 0 |

---

## 15. What NOT to do (anti-patterns documented from incidents)

- **Don't page-bomb on a 1-attribute fix.** The user flagged "make this price clearer" once → I rewrote 3 paragraphs. Lost 2 hours. Cap edits to sentences containing the flagged attribute.
- **Don't trust the implementer subagent's self-review for voice quality.** They wrote the content; they can't cold-eyes review it. Always dispatch independent critics.
- **Don't skip the regression grep because "slop score is low."** Slop detector misses shape-tells. Voice regressed M1-M3 on 2026-05-28 despite slop score = 22/100 across all 9 chapters.
- **Don't add `## Why this matters` headings.** Removed 3 times across 9 chapters; regressed once. Use a heading that names the SPECIFIC content of the section ("Your real question: do you need to build at all", "Who this 5-signal check is for", etc.).
- **Don't change publish dates on a fix/republish pass.** Old date is part of the historical record.
- **Don't bundle tactical fixes with structural moves in one commit/edit batch.** Separate approval gates required.
- **Don't apply structural changes without explicit user approval.** Apply only after surfacing convergent findings + 1 recommendation.
- **Don't write Sam's chapter in Alex's voice.** Course ICP is Sam (idea-stage). Rescue framing is wrong-audience.

---

## 16. What TO do (validated patterns from successful chapters)

M1.1 (Form Your Founding Hypothesis) and M3.1 (One-Page Product Brief) are the gold-standard templates. Reference them when writing new chapters:

- M1.1: orienting callout → narrative hook → framework → 4 worked examples (Gmail 2003, chiropractic billing, allergy-parent, procurement matrix) → 4-lens scoring → trade-off acknowledgement → next-chapter handoff
- M3.1: orienting callout → audience table → 5 sections → freelance-bookkeeper carried through ALL 5 sections as one worked example → outcome-shaped feature spec

Use these as the structural template. Don't invent new structures for chapters that fit one of these two patterns.

---

## Quick reference

| Action | Command / file |
|---|---|
| Run mechanical validators | `eval "$(rbenv init -)" && bin/validate-course` |
| Build site | `bin/hugo-build` |
| Banned-pattern sweep | `grep -rn "## Why this matters\|Founders who\|Most founders\|A founder we" content/course/tech-for-non-technical-founders-2026/` |
| Cold-eyes panel | 3 parallel Agent calls — ux-researcher + content-marketer + tutorial-engineer |
| Voice guide | `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` |
| Banned patterns catalog | `docs/projects/2605-tech-for-non-technical-founders/50-59-execution/mechanical-audit-checklist.md` |
| Course ICP profile | This doc, section 1 |
| Project plan | `docs/projects/2605-tech-for-non-technical-founders/` |

---

## Change log

- **2026-05-29** — Initial version built from 3-agent M1-M4 audit, 35 mechanical audit cases, and 30+ documented memory feedback items.
