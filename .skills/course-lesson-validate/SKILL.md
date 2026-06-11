---
name: course-lesson-validate
description: Run pre-commit mechanical QA on a course lesson. Use this skill whenever the user asks to validate a lesson, check a lesson before commit, run course validation, or mentions `/course-lesson-validate`. Triggers on phrases like "validate the lesson", "run the checks", "pre-commit check", "QA the lesson", "check for errors before I commit", or any request to mechanically verify course lesson quality.
---

# Course Lesson Validator

Pre-commit mechanical QA. Fast, scriptable, deterministic. Run this before every lesson commit.

## Pre-loaded context

- **PRD**: `.agent/prd/PRD.md` — 5-module architecture, 15 quality gates, artifact chain. Validator enforces the mechanical gates; the PRD defines what we're building.
- **30.03 §7 QA Checklist**: `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.03-course-format-requirements-for-creators.md` §7 — the canonical QA spec this validator is derived from.
- **Tasks**: `.agent/tasks.json` — 34 trackable tasks. Validator is the mechanical gate for every TASK-2 through TASK-26.

## Checks (run all 7)

Each check produces a PASS/FAIL verdict + an actionable fix for failures.

### Check 1: Hugo build clean

Run `bin/hugo-build`. Must exit 0 with no error output.

```
Command: bin/hugo-build
FAIL if: non-zero exit code OR error lines in output
Fix: read the error output, fix the Hugo syntax issue, re-run
```

### Check 2: validate-course 7/7 pass

Run `bin/validate-course`. All 7 checks must pass.

```
Command: bin/validate-course
FAIL if: any of the 7 checks fail
Fix: read the failure output, fix the specified issue, re-run
```

Note: These 7 scripted checks cover mechanical gates (chapter-number, title-yaml, internal-links, table-width, etc.). The full 30.03 §7 QA checklist (21 items across Per Lesson, Per Module, Per Course) is for human QA review — see `30.03-course-format-requirements-for-creators.md` §7.

### Check 3: Em-dash grep

Zero em dashes (`—`) in the lesson body.

```
Command: grep -n '—' content/course/tech-for-non-technical-founders-2026/<slug>/index.md
FAIL if: any lines returned (unless inside frontmatter YAML or code blocks)
Fix: replace each em dash with a regular dash (-)
```

### Check 4: Word count band

Count words in the lesson body (everything from the first `>` callout after frontmatter to the `*Built by*` footer, excluding code blocks and blockquotes).

```
Command: count body words
Bands:
- Agnostic-tool lessons (tool featured as worked example): 500-900 words
- Pure-concept lessons (no specific tool featured, no action section): 400-600 words
FAIL if: outside the applicable band
Fix: if under — expand the concept block or error anticipation; if over — tighten prose, move tangents to further reading
```

To count words, extract the body text between the frontmatter closing `---` and the `*Built by*` line, strip Markdown syntax, and count.

### Check 5: Template-label H2 grep

Forbid template-label H2s. These specific H2 strings must NOT appear:

```
## Why this matters
## Do this now
## If this fails
## What to do tomorrow
## What you'll get
## The problem
## The solution
## How it works
## Step by step
```

```
Command: grep -n '^## \(Why this matters\|Do this now\|If this fails\|What to do tomorrow\|What you.ll get\|The problem\|The solution\|How it works\|Step by step\)' content/course/tech-for-non-technical-founders-2026/<slug>/index.md
FAIL if: any matches
Fix: replace with a descriptive, content-specific H2
```

### Check 6: Internal link existence

Every internal link in the lesson must point to a file that exists.

```
Command: extract all /course/tech-for-non-technical-founders-2026/*/ links
For each link: check that content/course/tech-for-non-technical-founders-2026/<slug>/index.md exists
FAIL if: any link target doesn't exist
Fix: correct the slug to match an existing lesson
```

Internal link pattern: `](/course/tech-for-non-technical-founders-2026/<slug>/)`

### Check 7: SVG file presence

Every SVG referenced in the lesson must exist.

```
Command: extract all .svg references from image tags and markdown images
For each reference: check that the SVG file exists in the lesson's directory
FAIL if: any referenced SVG doesn't exist
Fix: create the SVG or remove the reference
```

SVG reference patterns:
- `![alt text](filename.svg)`
- `<img src="filename.svg"`

Only check SVGs inside the lesson's own directory (not external URLs).

## Output format

```
## Validation Report — [lesson slug]

| # | Check | Verdict | Detail |
|---|---|---|---|
| 1 | Hugo build | PASS/FAIL | [error message or "clean"] |
| 2 | validate-course | PASS/FAIL | [N/7 passed or "7/7"] |
| 3 | Em-dash grep | PASS/FAIL | [N occurrences or "zero"] |
| 4 | Word count | PASS/FAIL | [N words, band: X-Y] |
| 5 | Template H2s | PASS/FAIL | [matches or "none found"] |
| 6 | Internal links | PASS/FAIL | [broken slugs or "all exist"] |
| 7 | SVG files | PASS/FAIL | [missing files or "all present"] |

### Overall: [PASS / FAIL] ([N]/7 checks passed)

### Fix list (if any failures)

1. [specific fix instruction for Check X]
2. ...
```

## Quick reference commands

```bash
SLUG="<slug>"
LESSON_DIR="content/course/tech-for-non-technical-founders-2026/$SLUG"

# Check 1: Hugo build
bin/hugo-build

# Check 2: Course validation
bin/validate-course

# Check 3: Em-dash grep (should return nothing)
grep -n '—' "$LESSON_DIR/index.md" || echo "PASS: zero em dashes"

# Check 4: Word count (body text between frontmatter and *Built by*)
sed -n '/^---$/,/^---$/!p' "$LESSON_DIR/index.md" | tail -n +2 | \
  sed -n '1,/*Built by/p' | head -n -1 | \
  sed 's/[#>*`\[\]()!]//g' | wc -w | xargs echo "Word count:"

# Check 5: Template-label H2s (should return nothing)
grep -n '^## \(Why this matters\|Do this now\|If this fails\|What to do tomorrow\|What you.ll get\|The problem\|The solution\|How it works\|Step by step\)' "$LESSON_DIR/index.md" || echo "PASS: no template H2s"

# Check 6: Internal link existence
grep -oP '/course/tech-for-non-technical-founders-2026/\K[^/) ]+' "$LESSON_DIR/index.md" | sort -u | while read target; do
  if [ ! -f "content/course/tech-for-non-technical-founders-2026/$target/index.md" ]; then
    echo "FAIL: linked slug not found: $target"
  fi
done

# Check 7: SVG file presence
grep -oP '[a-zA-Z0-9_-]+\.svg' "$LESSON_DIR/index.md" | sort -u | while read svg; do
  if [ ! -f "$LESSON_DIR/$svg" ]; then
    echo "FAIL: referenced SVG not found: $svg"
  fi
done
```

## What NOT to do

- Do NOT modify the lesson content — only report failures
- Do NOT skip checks because "the file looks clean"
- Do NOT interpret partial passes — each check is binary PASS/FAIL
