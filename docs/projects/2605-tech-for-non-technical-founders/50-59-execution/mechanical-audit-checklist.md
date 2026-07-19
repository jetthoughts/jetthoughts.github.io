# Mechanical Audit Checklist

**Purpose**: every greppable + structural gate a 2605 course post must pass before being marked complete. A separate session running review can grep this file's commands instead of re-reading 10 memory files.

**Pairs with**: `docs/workflows/course-chapter-pipeline.md` — the PRE-write + DURING-write guide (structure, voice, ICP-Sam profile, cold-eyes panel). This file is the POST-write audit.

**Usage**: run the bash block at the top against the post file → manually verify the structural gates → manually verify the voice gates → if all pass, mark task complete.

---

## 🤖 Greppable mechanical gates (paste into terminal)

```bash
F=content/blog/<SLUG>/index.md

echo "=== EM-DASHES (must be 0) ==="
grep -c "—" "$F"

echo ""
echo "=== BANNED WORDS (must be empty) ==="
grep -niE "\b(leverage|unlock|harness|supercharge|robust|seamless|empower|streamline|delve|embark|revolutionize|paradigm|cutting-edge|world-class|game-changer|elevate)\b" "$F" || echo "✅ clean"

echo ""
echo "=== JT SERVICE CTAs (must be empty - Option C) ==="
grep -niE "Control Audit|JT runs|JetThoughts runs|book a call|schedule a consultation|book a (free )?(call|consultation)|get in touch|contact us" "$F" || echo "✅ no service CTAs"

echo ""
echo "=== AUTHORSHIP CREDIT FOOTER (must be 1) ==="
grep -c "Built by JetThoughts as part of the free" "$F"

echo ""
echo "=== TOP CALLOUT (must be 1) ==="
grep -c '^> \*\*Module' "$F"

echo ""
echo "=== CONTINUE THE COURSE NAV (must be 1) ==="
grep -c '^## Continue the course' "$F"

echo ""
echo "=== ← YOU ARE HERE MARKER (must be 1+) ==="
grep -c "← you are here" "$F"

echo ""
echo "=== REACT/NODE/JAVA AS LEAD STACK (must be empty in main path) ==="
grep -niE "\b(react\b|next\.js|node\.?js|express|nest\b|angular|vue\b|java\b|kotlin)\b" "$F" | grep -v "JavaScript\|over-engineered\|jetthoughts.com\|counter-example\|hallucinated\|never tried" || echo "✅ no leak"

echo ""
echo "=== EMOJI IN BODY (must be 0 in body; emoji in frontmatter OK) ==="
sed -n '/^---$/,/^---$/!p' "$F" | grep -c "[🎯🔥💡⚠️✅❌📊🚀🛡️📋🔍🧪]"

echo ""
echo "=== INFOGRAPHICS (≥3: SVG files + Mermaid blocks) ==="
echo "SVG files in post directory:"
ls content/blog/<SLUG>/*.svg 2>/dev/null | wc -l
echo "Mermaid blocks in post:"
grep -c '^```mermaid' "$F"

echo ""
echo "=== INTERNAL JT BLOG LINKS (must be 4+) ==="
grep -oE '/blog/[a-z0-9-]+/?' "$F" | grep -v 'tech-for-non-technical-founders-2026' | sort -u | wc -l

echo ""
echo "=== EXTERNAL CITATIONS (must be 5+) ==="
grep -oE 'https?://[^ )]+' "$F" | grep -v 'jetthoughts.com\|/blog/' | sort -u | wc -l
```

**Expected outputs**:
- Em-dashes: 0
- Banned words: empty / "✅ clean"
- JT service CTAs: empty / "✅ no service CTAs"
- Authorship credit footer: 1
- Top callout: 1
- Continue the course nav: 1
- `← you are here` marker: 1 or more (one in module table + one in In Module X mini-list)
- React/Node/Java leak: empty / "✅ no leak"
- Emoji in body: 0
- SVG files: ≥2
- Mermaid blocks: ≥1
- Internal JT blog links: 4+
- External citations: 5+

Fail any one → surface to user. Do not mark complete.

---

## 👁️ Structural gates (manual read)

Verify each item by reading the draft. Note specific line numbers when an item fails.

- [ ] **Contrarian hook in opening 80 words.** Quote it back in your review notes. Test: would a Reddit r/startups reader paste this in a comment? If yes, pass.
- [ ] **One quote-tweetable insight (140-280 chars).** Single sentence. Stands alone outside the post. Quote it back; count chars.
- [ ] **Specific weekly tactic.** What does the reader DO this week as a result of reading? Not abstract advice. Quote the specific action sentence.
- [ ] **Course frame top callout** with: Module · Step · Input · Output. All 4 fields filled. Module/step matches `20.01-course-modules.md` placement.
- [ ] **Course-nav table at bottom**: 9 module rows (0-7 with 4A/4B as branch) + current module marked + `In Module X` mini-list with current post marked.
- [ ] **Anonymized incident** in the body. Check against the distinctness audit in `20.07-content-plan-tnt-founders-2026.md` § "Distinctness audit". Should be DISTINCT from $51K / $44K / $78K / $62K / $180K / $95K / $34K / $25K anchors already in the corpus.
- [ ] **At least 4 internal JT blog links** woven in prose (not just footer). Each verified to exist via `ls content/blog/<slug>/index.md`.
- [ ] **At least 5 external citations** with real URLs. No fabricated stats.
- [ ] **≥3 handmade-style infographics**: ≥1 inline SVG + ≥1 Mermaid block. Visually verify the SVG renders (open in browser) and the Mermaid is syntactically valid.
- [ ] **Companion artifact** shipped at `50-59-execution/lead-magnets/<filename>.md`. Follows the spec in `sprint-1/artifact-specs.md`.

---

## 🎙️ Voice gates (read the draft cold)

Read the post end-to-end before checking these. If you find yourself skimming, that's already a fail.

- [ ] No "rule of three" rhetorical patterns (3+ parallel clauses for emphasis)
- [ ] No signposting ("First... Second... Third...")
- [ ] No slogany flips ("X works. Y doesn't." / "It's not Y. It's Z.")
- [ ] No cinematic beat-marking ("Long pause." / "Five minutes in...")
- [ ] No noun stacking without human subject ("React + Rails, clean conventions, the demo sailed.")
- [ ] No "the..." paragraph-opener density > 20%
- [ ] Every sentence has a person doing something (no impersonal fragment stacking)
- [ ] Practitioner-voice anecdote (named industry + quarter + dollar + mechanic), not therapist-voice
- [ ] No essay arc (hook → pivot → thesis → evidence → caveat → close — typical AI shape)
- [ ] No pivot sentences ("That's the experience of..." / "Here's what's underneath..." / "The bigger problem is...")
- [ ] No apologetic caveats ("every project is different" / "it depends on the use case")
- [ ] No fluffy AI narration (dramatic present-tense "The alerts fire correctly. Then someone upgrades...")

---

## 📓 Learnings log + added gates (Module 1 polish, 2026-05-22)

These cases surfaced during the Module 1 (Hypothesis / Smoke-Test / Price) polish pass. Each is now a gate so the next chapters don't repeat it. **AUTO** = caught by `bin/validate-course` (hooked into `bin/hugo-build`). **Manual** = a read-back item below.

| # | Case we hit | Lesson | Enforced by |
|---|---|---|---|
| 1 | Chapter opened with rescue/trauma framing ("you already got burned... information asymmetry") | Course ICP is "Sam," the idea-stage pre-spend founder - NOT "Alex," the burned website lead-gen ICP. Rescue framing is off-ICP for course bodies. | Manual: read-back #3 |
| 2 | "Already burned?" routing block at chapter top interrupted the primary reader | Route burned founders at the LANDING page only; don't staple per-chapter routing blocks. Question inherited elements proactively. | Manual: read-back #5 |
| 3 | "ICP" used ~22x, never glossed for a newbie | Gloss every acronym/tool at FIRST mention (what it is, in plain words). | Manual: read-back #1 |
| 4 | "Most founders we joined in 2026..." (fabricated client-cohort year) | Don't stamp client cohorts with a year (untrue + redundant). | AUTO: `year-stamp-fabrication` |
| 5 | Hardcoded "Carrd or Framer" while the chapter offers more builders | Don't couple to a tool subset in forward refs or meta; name the category. | Manual: greppable tool-coupling |
| 6 | Rewrote the whole opener for a one-attribute ($300) fix; lost the page's value thesis | Surgical edits: change only the named attribute, never rebalance the page. | Manual: surgical-edit gate |
| 7 | Budget stance swung free-first → paid-first → balanced (4 round-trips) | Land the principle once at the documented middle; don't swing to the opposite extreme. Free and paid are EQUAL options, reader chooses (see GOAL delivery principle). | Manual: surgical-edit gate |
| 8 | Added an alias bridge during a "clean" rename | Zero tech debt: for a brand-new URL, remove old refs + update, add NO alias bridge. | Manual: surgical-edit gate |
| 9 | Stale link LABEL after slug rename (URL updated, text didn't) | After any rename, sweep display labels, not just URLs. | Manual: surgical-edit gate |
| 10 | Two stacked highlighted blockquote callouts (crowded) | Visual rhythm: the Module-nav banner is the one highlighted block; the opener is plain prose. No two adjacent same-form callouts. | Manual: read-back #4 |
| 11 | "≥300 paid visits or ≥30 organic" front-loaded into the orientation banner | Progressive disclosure: banners orient; push thresholds/metrics down to where the reader acts on them. | Manual: read-back #2 |
| 12 | Disclaimer present in only 2 of 18 chapters | Course-wide artifacts are all-or-none. | AUTO: `disclaimer-consistency` |
| 13 | Em-dashes across 9 chapters | Use "-" not "—" everywhere. | AUTO: `no-em-dash` |
| 14 | $62K / $38,400 dollar anchors too big for "Sam" | Keep a worst-case ceiling, but lead with a Sam-scale anchor ($500 + a few weekends) so the reader sees themselves. | Manual: read-back #6 |
| 15 | Signposting ("The pattern holds across...", "What the strong examples share") | Show the evidence; let the reader reach the conclusion. Banned signposting. | Manual: voice gates (above) |
| 16 | "Founders who..." generalized-actor refrain (7× in one chapter) | Caught by 4-persona cold-eyes panel (2026-05-23). Generalized "Founders who X..." opener as a refrain reads as one consultant voice running a template - not a practitioner. Cap usage at 2-3 instances per chapter; for the rest, rephrase as direct second-person ("Pivot before building and you learn in days...") or name a specific actor (Priya, Marcus). | Manual: read-back #7 (below) |
| 17 | Course-internal jargon (Magic Lens, Foundation Sprint, Mad Libs blanks, Customer lens) used without inline gloss | Cold readers landing mid-funnel from search/social don't know these terms. Either inline-gloss ("the four hypothesis lenses from Ch 1.1 - customer, problem, approach, money") or rephrase to not need the term ("your weakest hypothesis blank"). | Manual: read-back #1 (acronyms/terms glossed at FIRST mention) |
| 18 | First-timer tab-closer in tracking / setup sections (GA4 + Pixel + Clarity all stacked = brain shutdown) | When a section installs multiple tools, lead with the **minimum viable** one (Clarity = 4-min install, free forever, biggest signal-per-effort). Demote the others to "add these too if your channel needs it." A first-timer ships the test or doesn't; the kitchen-sink list is what makes them quit. | Manual: read-back #8 (below) |
| 19 | Per-channel cost spread without an escape hatch when the right channel is too expensive | A LinkedIn-best ICP staring at $1,800-$6,600 with $20K savings closes the tab. After any "the right channel depends on your ICP" table, add a "if the right channel is out of reach: [substitutes at ~10% of cost]" sidebar. The substitutes (organic outreach, Reddit B2B, cold email) give comparable signal at a fraction of the spend. | Manual: read-back #9 (below) |
| 20 | Recap sections multiplying (schedule table + "Three numbers to memorize" + "Your Monday morning") all doing the same job | The writer doesn't trust the lesson to land, so re-states it 3 ways. Pick one - the most action-oriented one. The reader gets the lesson once, in the format that drives them to act. | Manual: surgical-edit gate (already covered: no rebalancing for redundancy reasons) |
| 21 | Variant / Advanced sidebar content that duplicates a sibling chapter | If Ch X has a "Variant" that re-covers material the next chapter already teaches in depth, replace the variant with a 1-2 sentence link. Variants belong in a chapter when they're UNIQUE to it; when they duplicate, the link wins. | Manual: surgical-edit gate |
| 22 | Pad-then-discard listicle ("5 frames; pick 2") | Caught 2026-05-23 by Ch 1.3 cold-eyes panel. If the writer says "here are 5 X; pick the 2 best for you," just ship the 2. The other 3 add scroll-length, force the reader to discard, and signal "I padded this." Exception: when the 3 you'd discard are common-but-wrong choices the reader needs to NOT pick - then frame as a banned-vs-recommended split. | Manual: read-back #10 (below) |
| 23 | A/B test instructions that assume infrastructure first-timers don't have ("split traffic 50/50") | Sam-blocker on Ch 1.3 (Sunday-night close-the-tab moment). For a first-time founder on Carrd + a $300 ad budget: split-testing requires either two ad sets to two URLs or a tool they don't have (Google Optimize is dead). For the smoke-test stage, instruction should be "pick one variant and ship it" - A/B testing is a post-launch tool. Same logic applies anywhere the chapter asks the reader to do statistically-disciplined experimentation on volume that can't support it. | Manual: read-back #11 (below) |
| 24 | Multi-chapter forward-reference tease ("find out in Chapter 3.1") | Cold-eyes flagged: a chapter that twice points the reader at a *later* chapter for the real answer reads as "watching a movie that keeps saying 'find out in the sequel.'" Forward-references are fine for context ("when you reach the One-Page Brief in Module 3, you'll use this") but become a tease when the current chapter's promise depends on reading the later one. Either land the answer here, or rephrase as "a post-launch question, not a pre-build one" and stop pointing forward. | Manual: surgical-edit gate |
| 25 | "## Why this matters" preamble before the lesson | Caught 2026-05-23 by real-human-practitioner voice analysis (Fitzpatrick + McKenzie). Both refuse the preamble; the vignette opener carries the stakes implicitly. Explicit "why this matters" reads as throat-clearing - delete it and let the opener vignette + the first concrete step land the chapter's promise. | Manual: read-back #12 (below) |
| 26 | Written-artifact taught only by showing the GOOD version with `[brackets]` | Both Fitzpatrick and McKenzie teach by tearing apart the bad version first, then handing over the rewrite. When a chapter teaches a cold message / landing-page copy / interview script / founder-update email, lead with the typical wrong version, diagnose sentence-by-sentence what's wrong, then show the rewrite. The reader learns from the diagnosis, not from copying the answer. | Manual: read-back #13 (below) |
| 27 | "5 steps with sub-bullets" shape for chapters teaching judgment + craft | Procedural shape (Step 1 / Step 2 / Step 3) reads as textbook / AI. For chapters teaching craft (which question to ask, what to write, when to give up), reshape the sequence as 2-3 reader questions ("How do I X? What do I write? What if Y?"). Steps stay for genuinely sequential procedures (set up Stripe, configure DNS). | Manual: read-back #14 (below) |
| 28 | Paste-literal strings rendered as prose quotes ("Suggest 3 alternatives more focused on [vertical]") | Caught 2026-05-23 by user. Stripe / Anthropic / MDN convention: a string the reader pastes literally (AI prompt, CLI command, SMS template, search string, hypothesis sentence) goes in `backtick code spans`, not "prose double-quotes." Prose quotes are reserved for dialog or things a person said. Double-quoting a paste-literal string makes the reader unsure whether the quotes are part of what they type. | Manual: read-back #15 (below) |
| 29 | Prompt template with `[bracketed blanks]` and no upstream pointer to where the inputs come from | If the chapter hands the reader a fill-in-the-blank prompt, every blank must be sourced from somewhere the reader can point to: an earlier section in the same chapter, a named upstream chapter, or a one-line "how to find it in 5 minutes" inline. Caught 2026-05-23: the 2.2 AI ICP map prompt asked for 2 competitor URLs the course never produced - the reader hits the prompt and stalls. | Manual: read-back #16 (below) |
| 30 | Redundant "free" qualifier on tools the reader already knows are free (Reddit, Gmail, ChatGPT free tier) | Caught 2026-05-23 by user. "free Reddit account, free Gmail" reads as defensive over-explanation and recreates the parallel-block AI tell (free X / free Y / free Z). Strip the "free" qualifier when the tool is commonly known to have a free path (Reddit, Gmail, Twitter, Discord, etc.). Keep "free tier" or "free path" only when it differentiates the tool's tiers (Apollo's free tier, Streak's free tier - both have paid plans the reader does NOT need yet). | Manual: read-back #17 (below) |
| 31 | Answering a clarifying question by adding a defensive block that restates what's already covered | Caught 2026-05-23 by user immediately after Case 29 fix. When a reader asks "where does input X come from?" the right fix is to add ONLY the guidance for the input that's actually missing, placed where the reader will need it (immediately after the prompt block, not before). Wrong fix is a paragraph that restates "you already have A, B, C" + "for D, do this..." - that recreates the AI parallel-block tell and adds words the reader does not need. Surgical = answer only what's missing; place it at the point of need. | Manual: read-back #18 (below) |
| 32 | Slogany reveal-twist flip as opener or closer ("X hadn't been Y - Z had been", "It's not about X. It's about Y.", "X wasn't Y - it was Z") | Caught 2026-05-28 by user + 4-persona cold-eyes panel across M1-M3 (9 chapters, 25+ instances). The 2-sentence pivot from negation to assertion reads as a content-marketer punchline shape. Writer reaches for it because the shape feels structured; reader hears it as a slide-deck pull-quote. Fix: state the cause and effect in normal order ("the hypothesis was right; the questions were wrong" → "the hypothesis was probably right and the questions were probably broken; the real interviews confirmed both"). | Manual: read-back #19 (below) |
| 33 | Cost-stacked tri-list opener ("$X-$Y in incentives, N minutes of calendar, one of M slots") | Caught 2026-05-28 by user. 3 parallel cost/time/count items presented as if from a workshop slide. Reads as didactic, not practitioner. The information is usually useful but the slide-shape parallel structure carries the AI tell. Fix: embed the costs in prose, drop the symmetric serial-list shape, or reduce to the one or two costs that actually matter for the reader's decision. | Manual: read-back #20 (below) |
| 34 | Cute aphoristic flourish closer ("polite noise", "the kind smile that costs you a year", "the helpful answer is the trap", "Everything else is your mom being nice") | Caught 2026-05-28 by user. Invented metaphor used to package a teaching point at the end of a paragraph. Reads as marketing copy pull-quote, not practitioner observation. Fix: state the concrete mechanic instead ("polite noise" → "the interviewee says 'sure, I'd use it' to be kind, you hang up thinking you got a signal, and you got nothing usable"). | Manual: read-back #21 (below) |
| 35 | Anonymous-named-founder opener template repeated chapter-after-chapter ("Priya, a FinTech founder...", "Maya, a founder we worked with...", "An ed-tech founder we picked up...", "A consumer-app founder we spoke with...") | Caught 2026-05-28 by 4-persona panel across M1-M3. Module 2 had 4 consecutive chapters opening with the same template shape (named-or-anonymous founder → fabricated number stack → tidy failure → magic-number reframe). Cold-eyes reader: "by chapter 5 it reads as one consultant's case-study generator." Even when each individual vignette is well-written, the repeated shape across the module reads as AI-generated. Fix: vary opener shapes across consecutive chapters - rotate between vignette, direct-instruction, named-research-result, and reader-question openers. No 3+ chapters in a row may share the same opener shape. | Manual: read-back #22 (below) |
| 25-regression | Banned headings restored after they were removed in a prior pass | Caught 2026-05-28 - Case 25 ("## Why this matters in 2026") regressed in 3 of 9 chapters (CH 2.3, 3.1, 3.2). Banned patterns previously removed are at high risk during revision passes because the writer reaches for the same essay-frame habits. Fix: every revision pass must run `grep -rn "## Why this matters\|Founders who\|Most founders"` across edited chapters before handback. Treat banned-pattern regression as a BLOCKING failure, equivalent to introducing the pattern fresh. | AUTO candidate: extend `bin/validate-course` with `banned-headings` check |

### 👓 New read-back items from the 2026-05-23 cold-eyes panel

- [ ] 7. "Founders who..." / "the founder who..." opener used ≤2 times per chapter (count grep; any more, rephrase to second-person or name a specific actor).
- [ ] 8. Multi-tool setup sections lead with the **minimum viable** tool (free, fastest install, biggest signal); others demoted to "add if your channel needs it" sidebar.
- [ ] 9. Any per-channel cost/option table that prices a Sam-relevant option out of reach has an immediate escape-hatch sidebar with 2-3 cheaper substitutes.
- [ ] 10. No "5 options; pick 2" pad-then-discard listicles - if 3 of them get discarded, ship the 2 that work.
- [ ] 11. No A/B test instructions ("split traffic 50/50") at the smoke-test stage - smoke-test = pick one variant, ship it; A/B testing is a post-launch tool that requires infrastructure first-timers don't have.
- [ ] 12. No "## Why this matters" preamble before the lesson. The vignette opener carries the stakes. If the chapter doesn't open with a vignette, write one - don't explain why the chapter matters.
- [ ] 13. Every chapter that teaches a written artifact (cold message, landing-page copy, interview script, founder-update email) shows the BAD version first + sentence-by-sentence diagnosis + the rewrite. Not just the GOOD version with `[brackets]`.
- [ ] 14. Chapters teaching judgment + craft are organized as 2-3 reader questions ("How do I X? What do I write? What if Y?") rather than 5 procedural steps. Procedural steps remain for genuinely sequential procedures (set up Stripe, configure DNS).
- [ ] 15. Paste-literal strings (AI prompts, CLI commands, SMS templates, search strings, hypothesis sentences) are wrapped in `backtick code spans`, not "prose double-quotes." Dialog stays in double-quotes.
- [ ] 16. Every fill-in-the-blank prompt template the chapter hands the reader has each `[bracketed blank]` sourced from a named upstream section, a referenced chapter, or a one-line "how to find it in 5 minutes" inline. No orphan blanks.
- [ ] 17. No redundant "free" qualifier on commonly-known-free tools (Reddit, Gmail, Twitter, Discord, ChatGPT free tier). Keep "free tier" only when the tool has paid tiers the reader doesn't need yet (Apollo, Streak, etc.) and the differentiation matters.
- [ ] 18. When fixing a Case-29-style prompt-input gap, add ONLY the guidance for the missing input, placed at the point of need (immediately after the prompt block). Never add a "you already have X, Y, Z + for W do this" defensive block - that restates what's already covered AND recreates the parallel-block AI tell.

### 👓 New read-back items from the 2026-05-28 4-persona M1-M3 audit

- [ ] 19. No slogany reveal-twist flips ("X hadn't been Y - Z had been", "It's not about X. It's about Y.", "X wasn't Y - it was Z") in opener or closer position. State the cause and effect in normal order; let the reader supply the contrast.
- [ ] 20. No cost-stacked tri-list openers ("$X-$Y in A, N B, one of M C"). Embed the costs in prose, drop the symmetric serial-list shape, or reduce to the one or two costs that drive the reader's decision.
- [ ] 21. No cute aphoristic flourish closers ("polite noise", "the helpful answer is the trap", "Everything else is your mom being nice"). State the concrete mechanic instead.
- [ ] 22. Opener-shape rotation: no 3+ consecutive chapters in a module may open with the same template shape (anonymous-founder vignette, year-stamp cohort, named-research-result, etc.). Vary between vignette, direct-instruction, research-result, and reader-question openers.
- [ ] 23. Banned-pattern regression sweep: before handback, run `grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with"` across edited chapters; banned patterns previously removed are at high risk during any revision pass.

### 🧑‍🔬 Cold-eyes panel agent mapping (BLOCKING - use specialized agents, not general-purpose)

When dispatching the 4-persona cold-eyes critic panel (per CLAUDE.md content cold-eyes review gate), the agents MUST be:

| Persona | Specialized agent | Why |
|---|---|---|
| AI-feel / shape-tell detector | `voltagent-biz:content-marketer` | Content strategy + native slop-pattern detection |
| Voice guide enforcer | `voltagent-biz:technical-writer` | Documentation voice/tone enforcement |
| ICP reader (Sam) | `voltagent-biz:ux-researcher` | Persona-based UX research; purpose-built for "does this work for this reader?" |
| Cold-eyes pedagogical fresh reader | `tutorial-engineer` | Pedagogical evaluation - "does this teach a fresh learner?" |

Defaulting to `general-purpose` for this panel is a process failure (caught 2026-05-23 on the Module 2 panel - the writer had memory `feedback_agent_selection_bias` and ignored it). The findings will still surface, but specialized agents bring their domain prompts, references, and quality bars without the dispatcher having to inline them.

### ✂️ Surgical-edit gate (when REVISING an existing chapter)

- [ ] Changed ONLY the sentences containing the attribute the user named; did not rewrite/rebalance the surrounding page.
- [ ] Named the page's thesis in one line first; confirmed it is unchanged after the edit.
- [ ] Grepped my own replacement text for the pattern I was removing (year-stamp, tool name, em-dash, alias, rescue framing) - did not re-introduce it.
- [ ] On a rename: removed old refs + updated display labels (not just URLs); added NO alias bridge for a brand-new URL.
- [ ] On a stance correction: landed at the documented middle, did not swing to the opposite extreme.

### 👓 ICP-reader read-back gate (read the edited chapter AS "Sam", before handback)

- [ ] 1. Every acronym/tool/term glossed at FIRST mention, in plain words.
- [ ] 2. Orientation blocks (Module banner, summaries) ORIENT only - no thresholds/metrics/mechanics front-loaded.
- [ ] 3. Tone is value-first, not sales/rescue/trauma. Reader is pre-spend Sam, not burned Alex.
- [ ] 4. Visual rhythm: no two adjacent same-form callouts (e.g. two stacked blockquotes).
- [ ] 5. No inherited element (routing block, disclaimer, callout) preserved unquestioned.
- [ ] 6. Dollar/scale anchors relatable to Sam (lead with $500-scale; a big worst-case is fine as a ceiling, not the lead).

> Mirror of the agent-side memory `feedback_minimal_edit_scope_no_page_bombing` and `feedback_icp_reader_readback_progressive_disclosure`, and the BLOCKING rules in project `CLAUDE.md`. Keep all three in sync if any changes.

---

## 🚦 Three outcomes

After running all gates:

1. **All gates pass** → mark task complete in TASK-TRACKER → run cover-image generation (per `sprint-1/cover-image-specs.md`) → commit → queue next sprint task.

2. **1-2 gates fail (easy fixes)** → surface specific failures to user with the exact line numbers + suggested fixes. Don't auto-fix; let user decide. Do not mark complete.

3. **3+ gates fail OR a "zero tolerance" gate fails (JT CTA / em-dash / banned word / React/Node/Java leak)** → surface to user with full failure list. Recommend re-spawning the writer with a stricter brief. Do not mark complete. Halt sprint.

---

## 🔁 If review fails twice on the same draft

Halt the sprint. Surface to user with:
- The failure pattern (which gates the agent keeps missing)
- The agent's report-back text
- A diagnosis: is the brief unclear, the agent confused, or the doctrine impossible to apply?

The WIP=1 sequential rule means a stuck task blocks the rest of the sprint. Better to escalate than to keep re-spawning the same agent against the same brief.
