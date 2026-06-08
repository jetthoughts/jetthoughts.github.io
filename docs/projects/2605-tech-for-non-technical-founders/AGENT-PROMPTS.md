# Agent Prompts — v2 Micro-Lesson Migration

**Cold start:** paste the prompt below into a session opener. **Returning agent:** skip to §2.

---

## Prompt

```
You are writing v2 micro-lessons for the 2605 course (Tech for Non-Technical Founders). The project is migrating 18 v1 long-form chapters (~2,000-4,500 words each) into 20-25 v2 micro-lessons (~400-600 words each) following the canonical 8-part template.

CONTEXT (5 minutes):
1. Read docs/projects/2605-tech-for-non-technical-founders/TASK-TRACKER.md — "Active Phase" + "Next sprint candidates." Pick ONE task.
2. Read docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.03-course-format-requirements-for-creators.md — §2 (the 8-part template) + Appendix A (the worked example). These are the canonical pattern.
3. Read the v1 chapter you're migrating under content/course/tech-for-non-technical-founders-2026/.

VOICE GATES:
- No em-dashes. Use - not —.
- No "Founders who", "Most founders", "## Why this matters", "ICP-E" banned phrases.
- No template labels in published content. "1. Hook (3 sentences):", "2. One-sentence outcome:", etc. are writer-only — never visible to readers.
- **ONE case study per lesson** (NOT two). Pick Tomas OR Mia by ICP-fit per 30.03 §2.7: B2B-heavy concept → Tomas; B2C-heavy concept → Mia; universal concept → pick the sharper "Sam can see himself in this" story. Do NOT alternate strictly. Case studies follow 4-beat narrative arc: input → challenge (with tension) → action (concrete) → result (observable). Not fact-list summaries.

WRITING ORDER (follow exactly):
a. Identify concept boundaries — split v1 chapter into 1-3 micro-lessons.
b. Write the success-check FIRST — what observable thing tells the learner they're done?
c. Draft Hook (1-3 sentences, pain + win) → Outcome (one observable sentence) → Concept block (≤300 words; if over, split into 2 lessons).
d. Draft Do-Now (3-7 imperative steps, success check on last step).
e. Draft Error Recovery (one most-common failure: If/Why/Fix pattern).
f. Draft Micro-Reflection (1-3 questions or a small save-to-file task).
g. Draft Bridge (name specific artifact the next lesson needs as input).
h. Add Visual if explanation >4-5 sentences — one concept per visual.
i. Add ONE case study (Tomas OR Mia, pick by ICP-fit per 30.03 §2.7) using the 4-beat arc, placed after the Done/Next/Blocked footer. NOT labelled with section numbers.

QUALITY GATES (all must pass before committing):
- [ ] Exactly one clearly stated outcome
- [ ] Observable success check on final Do-Now step
- [ ] Concept block ≤300 words (if over, split into 2 lessons)
- [ ] Total reading ≤10 minutes (~400-600 words)
- [ ] Implementation ≤15 minutes for a non-professional
- [ ] No content that doesn't directly support a concrete action
- [ ] 3-term cap on new jargon; each defined in one sentence
- [ ] 8-part template followed exactly (Hook → Outcome → Concept → [Visual] → Do-Now → Error → Reflection → Bridge)
- [ ] Zero template labels visible in published content
- [ ] Exactly ONE case study per lesson (Tomas OR Mia, pick by ICP-fit)
- [ ] Case study follows 4-beat narrative arc (not fact summary)
- [ ] bin/validate-course exits 0
- [ ] Em-dash sweep on touched files returns 0 hits
- [ ] Hugo build passes

COMMIT FORMAT:
content(course): v2 - [module/lesson] - [summary]

[one-line description of what shipped]
Validators: 7/7 pass. Em-dash sweep: zero.

DISCIPLINE:
- Atomic unit = 1 lesson. Write, validate, commit. THEN move to next.
- Never batch multiple lessons into one commit.
- Never mix v1 polish with v2 migration in the same commit.
- Never leave a Bridge pointing to a nonexistent lesson.
- After every module's last lesson, run a QA pass before starting next module.

AFTER EACH COMMIT: update TASK-TRACKER.md "What just shipped" with the commit hash. Before stopping: commit + push TASK-TRACKER so the next agent picks up cleanly.

STOP CONDITIONS (escalate to user):
- validate-course fails and the fix requires changing course_sequence.yaml structurally
- 30.03 spec says X but the chapter content forces Y
- You need a new visual style or theme change
- You disagree with the spec — escalate, do not override

START: report which task from TASK-TRACKER you picked, then begin the micro-loop.
```

---

## References

| File | What it's for |
|---|---|
| `30.03-course-format-requirements-for-creators.md` | Canonical spec — §2 = template, Appendix A = worked example |
| `TASK-TRACKER.md` | Ground truth — Active Phase, What just shipped, Next sprint candidates |
| `PROJECT-INDEX.md` | Navigation if lost — cold-agent route, file map |

*Built 2026-06-08. Radical simplification — one prompt, one workflow, no fluff.*
