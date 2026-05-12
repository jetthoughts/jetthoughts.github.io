# Sprint Runbook - 2605 Course Execution

**Purpose**: Self-contained orchestrator runbook. A separate Claude Code session opens this file, picks the next task, copies the dispatch brief into an Agent call, runs the review checklist on return.

**Last Updated**: 2026-05-12 (Sprint 1 ready to dispatch)
**Owner**: any session with write access to `content/blog/` and the project tree

---

## 🚀 How to use this runbook

1. Read this file top to bottom on first session entry.
2. Read `../TASK-TRACKER.md` for current sprint scope.
3. Identify the next un-spawned task in the active sprint.
4. Copy the matching dispatch brief (Section "Sprint 1 task briefs" below) into a new Agent call. Use `subagent_type: general-purpose`.
5. When the agent returns, run the **Review checklist** (Section "Post-return review").
6. If review passes: mark task complete in TASK-TRACKER, queue next task.
7. If review fails: surface to user with specific issue list. Do not dispatch next task.

**WIP=1**: only one writer agent at a time per sprint. Sequential dispatches.

---

## 📜 Canonical writer brief template

Every writer agent in the 2605 curriculum receives a brief structured like this. Section S1.1 through S1.3 below fill in the task-specific placeholders.

```
You are drafting <<POST TITLE>> for JetThoughts curriculum project 2605: Tech for Non-Technical Founders 2026. Slug: <<SLUG>>. Module · Step: <<MODULE.STEP>>. Publish target: <<DATE>>.

This is a real blog post shipping to production at content/blog/<<SLUG>>/index.md, plus a companion artifact at docs/projects/2605-tech-for-non-technical-founders/50-59-execution/lead-magnets/<<ARTIFACT-FILENAME>>.md. Run the standard JT blog pipeline. Do not edit anything outside the blog post directory + the artifact file.

# CONTEXT - READ THESE FIRST (mandatory, in this order)

1. /Users/pftg/dev/jetthoughts.github.io/docs/workflows/blog-pipeline.md
2. /Users/pftg/dev/jetthoughts.github.io/docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md
3. /Users/pftg/dev/jetthoughts.github.io/docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md
4. /Users/pftg/dev/jetthoughts.github.io/docs/projects/2605-tech-for-non-technical-founders/GOAL-AT-A-GLANCE.md
5. /Users/pftg/dev/jetthoughts.github.io/docs/projects/2605-tech-for-non-technical-founders/PROJECT-INDEX.md (integration rules 1-10)
6. /Users/pftg/dev/jetthoughts.github.io/docs/projects/2605-tech-for-non-technical-founders/20-29-strategy/20.01-course-modules.md (your module's input/output/checkpoint)
7. /Users/pftg/dev/jetthoughts.github.io/docs/projects/2605-tech-for-non-technical-founders/20-29-strategy/20.07-content-plan-tnt-founders-2026.md (your post's row in the 26-post map)
8. /Users/pftg/dev/jetthoughts.github.io/docs/projects/2605-tech-for-non-technical-founders/50-59-execution/sprint-1/artifact-specs.md (your artifact spec)
9. <<TASK-SPECIFIC SISTER FILES>>

# DOCTRINE INHERITANCE (memory files; rules in scope)

Apply ALL of these:

- feedback_curriculum_is_pure_lead_magnet.md (zero JT service CTAs; authorship credit only)
- feedback_curriculum_viral_shareability.md (contrarian hook + tweetable insight + weekly tactic + artifact)
- feedback_kiss_simplest_solutions_only.md (simplest method on main path; frameworks only in Advanced sidebars)
- feedback_courses_are_journeys_not_topic_lists.md (input/output/checkpoint framing per post)
- feedback_curriculum_posts_as_course.md (top callout + 9-row course-nav table)
- feedback_no_length_caps.md (cut test per section; no word ceilings)
- feedback_engagement_first_for_icp.md (effective delivery > template compliance)
- feedback_infographics_required.md (≥3 handmade-style infographics per post)
- feedback_jt_tech_stack_preferences.md (Rails/Django/Laravel + full-stack; no React/Node/Java as lead stack)
- feedback_curriculum_sequence_self_serve_first.md (self-serve first → hire smart → manage well)

# DELIVERABLES

1. content/blog/<<SLUG>>/index.md
   - Frontmatter: title ≤45 chars, description 150-160 chars, date <<DATE>>, slug <<SLUG>>, 5 keywords, tags, cover_image: cover.png, metatags.
   - Top callout (after frontmatter): > **Module <<MODULE.STEP>> of <<MODULE-POSTS>>** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) free course.
     > Input: <<INPUT>>. Output: <<OUTPUT>>.
   - Hook (40-80 words, contrarian, distinct anecdote — check distinctness audit in 20.07 §"Distinctness audit").
   - Why this matters in 2026 (≤120 words).
   - Body sections per the post's row in 20.07.
   - One quote-tweetable insight (140-280 chars) — flag it in the report.
   - A specific tactic the reader executes this week.
   - Inline reference to the companion artifact.
   - Bottom: ## Continue the course with the 9-row module table (current module marked) + In Module X mini-list.
   - Further reading (5+ real external citations).
   - Authorship credit footer (NO JT service CTAs).

2. docs/projects/2605-tech-for-non-technical-founders/50-59-execution/lead-magnets/<<ARTIFACT-FILENAME>>.md
   - Per the artifact spec in artifact-specs.md.
   - Authorship credit footer.

3. ≥3 handmade-style infographics: at least 1 inline SVG + at least 1 Mermaid block. Save SVG files to content/blog/<<SLUG>>/*.svg. Inline Mermaid in markdown.

# REUSE EXISTING JT PATTERNS (mandatory)

Use lean-ctx MCP or rg to find similar JT posts. Read 3+ existing JT posts that match the topic. Match voice + structure.

# RULES (zero tolerance)

- Plain English; founder-to-founder voice.
- No em dashes (`-` only).
- No banned words (leverage, unlock, harness, supercharge, robust, seamless, empower, streamline, delve, embark, revolutionize).
- No rule of three, no signposting, no slogany closings, no shape tells.
- Zero JT service CTAs anywhere.
- Length is not a target — cut test per section.

# REPORT BACK

- File paths written (post + artifact + SVGs)
- Word counts (informational; not a gate)
- The quote-tweetable insight (one sentence, 140-280 chars)
- The specific weekly tactic the reader executes
- 4+ internal JT slugs linked (verified with ls)
- 5+ external citations
- Confirmation: zero JT service CTAs; authorship credit present
- Confirmation: course-frame top callout + 9-row nav table present
- Anonymized incident used (one sentence; confirm distinct from corpus per distinctness audit)
- 3 things flagged for human review
```

---

## 📦 Sprint 1 task briefs (dispatch-ready)

### S1.1 - Module 0.1 Course Map + Self-Assessment

**Placeholder fills**:
- POST TITLE: "Where Are You in the Founder Journey? Take the 10-Question Self-Assessment"
- SLUG: `course-map-self-assessment-non-technical-founder-2026`
- MODULE.STEP: 0.1 (the only post in Module 0)
- MODULE-POSTS: 1
- DATE: 2026-07-01
- ARTIFACT-FILENAME: `self-assessment-worksheet`
- INPUT: An idea, an instinct, or an ongoing project that feels stuck
- OUTPUT: Self-diagnosis + your starting module
- TASK-SPECIFIC SISTER FILES:
  - Read `20.01-course-modules.md` §"The 10 self-assessment questions + routing logic" — the questions are already specified.
  - Read the 4 drafted posts to match course-frame style.

**Task-specific guidance**:
- The post EXPLAINS the 10 questions with one anonymized founder example per pillar (1-2 questions = early stage / 3-5 = mid build / 6-7 = managing team / 8-10 = AI-era risks).
- The artifact IS the 10 questions in checkbox form + the routing flowchart. Reader prints it, fills in 5 minutes, writes their starting module at top of a Notion doc.
- This is the COURSE ENTRY POINT. Hook must be strong enough to land readers from cold Reddit/Twitter traffic. Contrarian hook example: "Most non-technical founder courses ask you to commit to a 6-month program before they tell you what you'll learn. This 10-question quiz routes you to your starting module in 5 minutes, then disappears."
- Distinct anecdote (per distinctness audit): try something like "Three founders we picked up in Q1 2026 thought they needed the same thing - 'help my team ship.' All three actually needed different modules: one needed Module 5 (oversight rhythm), one needed Module 1 (her problem was unvalidated), one needed Module 6 (her team was lying to her face)."

**Dispatch**: copy the canonical brief template above, fill placeholders, spawn `general-purpose` agent.

---

### S1.2 - Module 1.1 Find 10 People with the Problem

**Placeholder fills**:
- POST TITLE: "Find 10 People With the Problem in 2026 (Without Knowing Anyone)"
- SLUG: `find-10-people-with-problem-outreach-2026`
- MODULE.STEP: 1.1 (Step 1 of 3 in Module 1)
- MODULE-POSTS: 3
- DATE: 2026-07-08
- ARTIFACT-FILENAME: `outreach-sequence-template`
- INPUT: A validated problem you suspect is real (Module 0 routed you here)
- OUTPUT: 10 ICP interviewees booked for next week
- TASK-SPECIFIC SISTER FILES:
  - Read `friday-demo-template.md` and `ownership-checklist.md` for artifact format mirroring.

**Task-specific guidance**:
- The post teaches the 2026 outreach stack: Reddit/LinkedIn/Discord mining + Clay or Apollo for list building + Lindy AI agent for sequence + paid panels (User Interviews, Respondent) as backup.
- Specific tools to name: Clay (~$149/mo), Apollo ($49-$149/mo), Smartlead/Instantly (~$37-$94/mo), Lindy, User Interviews, Respondent.
- The smoke-test landing page as a parallel validation track: Carrd or Framer + £100-200 of paid Google/LinkedIn traffic.
- Contrarian hook example: "A YC manifesto says you can validate a startup without writing code. They left out the hard part: getting the first 10 strangers to talk to you. Here's the 2026 stack that books 10 ICP interviews in one morning."
- Distinct anecdote: a founder who tried "I posted in 3 subreddits and got 47 DMs in 24 hours" or "She paid $750 to User Interviews and had 10 calls in her calendar by Friday."

**Dispatch**: WAIT for S1.1 review pass. Then copy canonical brief template, fill placeholders, spawn.

---

### S1.3 - Module 1.2 The Mom Test

**Placeholder fills**:
- POST TITLE: "The Mom Test: Ask About the Past, Not the Future"
- SLUG: `mom-test-ask-about-past-not-future`
- MODULE.STEP: 1.2 (Step 2 of 3 in Module 1)
- MODULE-POSTS: 3
- DATE: 2026-07-15
- ARTIFACT-FILENAME: `mom-test-interview-script`
- INPUT: 10 interview slots booked (from Module 1.1)
- OUTPUT: 10 transcripts of honest past-behavior conversations
- TASK-SPECIFIC SISTER FILES:
  - Read `agency-ai-five-questions.md` for the "5 questions with Pass/Fail scoring" structural pattern — the Mom Test artifact follows similar.

**Task-specific guidance**:
- Teach Rob Fitzpatrick's "Mom Test" (book: *The Mom Test*, 2013) WITHOUT making the framework name the lead. Frame as "the technique that prevents your interviewees from being polite."
- 3 core principles: (1) talk about past behavior not hypothetical, (2) ask for specifics not generalities, (3) listen for emotional language (frustration, hack, workaround).
- Specific 5-question script: when's the last time X happened? what did you actually do? what did it cost you (time/money/sanity)? how big a deal is this on a scale of 1-10? what have you tried already?
- Contrarian hook example: "Most customer interviews are useless because they're polite. Your interviewees will tell you the idea is great. They will be lying. Here's the technique that gets them to say what they actually do."
- Distinct anecdote: a founder who asked "would you pay for this?" and got 8 enthusiastic yeses, then launched and 0 paid.

**Dispatch**: WAIT for S1.2 review pass. Then copy canonical brief, fill, spawn.

---

## 🔎 Post-return review checklist (run after every writer agent returns)

For each returned draft, verify the following in order. Fail any gate → surface to user. Pass all → mark task complete + queue next.

### Mechanical gates (greppable)

```bash
F=content/blog/<SLUG>/index.md
echo "em-dashes (must be 0):"
grep -c "—" "$F"
echo "banned words (must be empty):"
grep -niE "\b(leverage|unlock|harness|supercharge|robust|seamless|empower|streamline|delve|embark|revolutionize)\b" "$F"
echo "JT service CTAs (must be empty):"
grep -niE "Control Audit|JT runs|JetThoughts runs|book a call|schedule a consultation" "$F"
echo "React/Node/Java as lead stack (must be empty except in 'wrong example' context):"
grep -niE "\b(react\b|next\.js|node\.?js|java\b|kotlin)\b" "$F" | grep -v "JavaScript\|over-engineered\|jetthoughts.com\|counter-example"
echo "Top callout present:"
grep -c "^> \*\*Module" "$F"
echo "Continue the course nav present:"
grep -c "^## Continue the course" "$F"
echo "Authorship footer present:"
grep -c "Built by JetThoughts as part of the free" "$F"
```

Expected: 0 em-dashes, 0 banned, 0 CTAs, 1 callout, 1 nav, 1 footer.

### Structural gates (manual read)

- [ ] Contrarian hook in opening 80 words (quote it in your review notes)
- [ ] One quote-tweetable insight 140-280 chars (quote it)
- [ ] A specific tactic the reader executes this week (quote it)
- [ ] ≥3 infographics: ≥1 SVG file in post directory + ≥1 Mermaid block in markdown
- [ ] Course-frame top callout: Module/Step/Module-of-N/Input/Output all filled
- [ ] Course-nav table: 9 module rows + In Module X mini-list with current post marked
- [ ] Anonymized incident (distinct from corpus — check against distinctness audit in 20.07)
- [ ] 4+ internal JT blog links (verified via `ls content/blog/<slug>/index.md` for each)
- [ ] 5+ external citations (real URLs)
- [ ] Artifact file shipped at `50-59-execution/lead-magnets/<filename>.md`
- [ ] Artifact has authorship footer

### Voice gates (read the draft cold)

- [ ] No "rule of three" rhetorical patterns
- [ ] No signposting ("First… Second… Third…")
- [ ] No slogany flips ("X works. Y doesn't.")
- [ ] No cinematic beat-marking ("Long pause." "Five minutes in…")
- [ ] Every sentence has a person doing something (no impersonal fragment stacking)
- [ ] Practitioner-voice anecdote, not therapist-voice

If all gates pass → mark task complete + queue next sprint task.

---

## 📢 Per-chunk announce workflow (build-in-public)

Per the "small chunks + notice ICP in progress" directive (2026-05-12), every approved chunk publishes immediately and gets announced. The course is built in public — readers see momentum.

**When a chunk (post + artifact + cover image) passes all gates:**

1. **Hugo build** + commit to master → post goes live.
2. **Update the landing page** at `content/blog/tech-for-non-technical-founders-2026/index.md`:
   - Move the post's row from 🔲 → 🟢 in the modules table.
   - Update the "Status: X of 26 posts live" line.
   - Update the "What's live right now" section with the new post link.
   - Update the "What's coming next" section to reflect what's queued.
   - Bump the "Last updated" date at top and bottom.
3. **Post the announcement** per `distribution-prep.md` schedule:
   - Day 0: blog post + landing page update
   - Day 1: LinkedIn (Paul Keen voice, per `linkedin-post-pipeline.md`) + Twitter thread (JT brand + Paul Keen accounts)
   - Day 3: Reddit (r/startups + 1 niche sub) + Facebook (1-2 founder groups)
   - Day 7: Email newsletter feature
   - Day 14: Reddit 2nd wave if first wave landed
4. **Notify-list email** (once email-capture is wired up): send a one-paragraph email to the subscribed list — "[Post title] just shipped. Read it here. Download artifact here. Next post: [topic] coming [date]."
5. **Update TASK-TRACKER** with the published SHA + status.

The build-in-public mechanic: each chunk feels like an event, not a deliverable. ICP sees the course growing in real time. Share velocity compounds because each launch has its own social moment.

**Frequency target**: 1-2 chunks per week. Sprint 1 = 3 chunks over 3 weeks. After Sprint 1, cadence can go to 2/week.

## 🎭 Hook-bank diversity rule (added 2026-07-15 after S1.3 cold-eyes review)

The "A founder we picked up..." anecdote pattern now anchors 8+ posts. Cold-eyes verifier on S1.3 flagged the JT-signature tell is wearing. For all Sprint 2+ writer briefs, the writer must NOT lead the hook with "A founder we picked up in QX 20XX..." pattern.

Rotate hook archetypes across posts:
- Interview transcript snippet ("'I'd absolutely pay for that.' She said it on Tuesday. She didn't pay.")
- Raw stat ("Founders who validate with 10+ past-behavior interviews ship 4x faster than founders who validate with hypotheticals.")
- Direct address ("You are about to send 60 polite LinkedIn DMs. You will book 3 calls. Two will ghost.")
- Reddit poster ("A founder posted in r/startups last week: 'I've been on the phone with 11 prospects and none of them said no.' She had asked them all the wrong question.")
- Twitter/X founder ("Lenny Rachitsky tweeted last month: '47% of customer interviews are worthless because the founder asks about the future.'")
- News-pegged opener ("YC's W26 batch shipped 3 startups with zero customer interviews. Two failed by demo day.")
- The product-tour reveal ("Open Calendly. Six calls booked. Read the names. Three are your old colleagues. Two are friends-of-friends. One is your mother. Validation is not happening.")

Apply at minimum 2 different archetypes across the next 5 posts.

## 🔁 After Sprint 1 closes

When all 3 Sprint 1 tasks complete + reviewed:

1. Update `TASK-TRACKER.md` → mark Sprint 1 complete; promote Sprint 2 to current.
2. Sprint 2 tasks (queue):
   - S2.1: Module 1.3 (Validated Problem Statement post + template) - closes Module 1
   - S2.2: Module 2.2 (One-Page Product Brief post + Vibe PRD template)
   - S2.3: Module 2.3 (Stop Specifying Features post; teaches job-story TACTIC without naming framework)
3. Run the same dispatch pattern (canonical brief template + task-specific placeholders).
4. Surface to user after Sprint 2 closes for any direction adjustments before Sprint 3.

---

## 📊 Distribution-readiness check

Before publishing any Sprint 1 post, verify the distribution prep:
- Read `distribution-prep.md` for the target subreddits, Twitter accounts, Facebook groups, and LinkedIn hashtag library for the post's pillar/module.
- Confirm the post's quote-tweetable insight is ≤280 chars (counts in distribution-prep's tweet template).
- Confirm the artifact is email-gated (or queued to be) before public sharing.

The post going viral without the artifact gate live is wasted distribution.

---

## 🛑 Stop conditions (surface to user immediately)

Halt and ping the user if:
- A writer agent returns with JT service CTAs present (zero tolerance, Option C is non-negotiable)
- A writer agent introduces React / Node / Java as the lead example stack
- A writer agent reuses an anonymized anecdote already in the corpus (distinctness rule)
- A writer agent's draft contains em dashes or banned words
- A mechanical gate fails twice on the same draft (agent isn't applying the brief)
- The artifact is missing or doesn't follow the spec in `artifact-specs.md`
- Hugo build fails on the new post

Do NOT auto-spawn the next task if review fails. WIP=1 sequential discipline must hold.
