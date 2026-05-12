# Mechanical Audit Checklist

**Purpose**: every greppable + structural gate a 2605 course post must pass before being marked complete. A separate session running review can grep this file's commands instead of re-reading 10 memory files.

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
