# Project 2509: CSS Migration — Safe Initiation Prompt

**Paste this entire prompt to an AI agent to start Project 2509 CSS Migration with maximum safety.**

---

You are leading Project 2509: CSS Migration for the JetThoughts Hugo site.
Your mission: eliminate 70-80% CSS duplication (27,094-31,536 lines) across 148 CSS
files (190,916 total lines) using the SAFEST possible approach. Zero visual regressions.
Zero tolerance for broken pages.

---

## PHASE 0: ORIENTATION (DO THIS FIRST — DO NOT SKIP)

### 0.1 Read the Master Index

```
Read: docs/projects/2509-css-migration/CSS-MASTER-PROJECT-INDEX.md
```

This is your single source of truth. It maps ALL 55 CSS-related documents across
the codebase: ADRs, analysis, architecture specs, task trackers, testing protocols,
workflows, and campaign summaries.

### 0.2 Read the Active Task Tracker

```
Read: docs/projects/2509-css-migration/TASK-TRACKER.md
```

You are starting at WP1.1 (CSS Variables Foundation). All 12 work packages are
NOT STARTED. Current phase: Phase 1 — Critical CSS Inline Consolidation.

### 0.3 Read the CSS Loading Order Analysis

```
Read: docs/projects/2509-css-migration/css-loading-order-analysis.md
```

The 5-layer cascade (Base → Layout → Component → Theme → Footer) is NON-NEGOTIABLE.
Any CSS extraction that changes load order = IMMEDIATE REJECTION.

### 0.4 Verify the Test Suite Works

```bash
bin/rake test:critical
```

Expected: 97 runs, 166 assertions, 0 failures. If any failures exist, DO NOT
proceed — fix the test suite first. This is your safety net.

### 0.5 Verify the Dev Server Works

```bash
bin/hugo-dev  # starts on localhost:1313
```

Navigate to localhost:1313 in Chrome. Confirm the homepage renders correctly.
This is your manual verification baseline.

---

## TEAM STRUCTURE: Multi-Agent XP With Safety Roles

You will spawn agents in this formation. NEVER proceed without all roles active.

### Safety Gate Agents (ALWAYS ACTIVE)

| Role | Agent | Authority |
|------|-------|-----------|
| **Screenshot Guardian** | code-reviewer-deepseek (in visual mode) | ABSOLUTE VETO on any visual regression >0% |
| **Test Watcher** | basher | Runs `bin/rake test:critical` after EVERY change |
| **Browser Verifier** | browser-use | Manual visual confirmation at key checkpoints |

### Implementation Agents (Spawned Per Work Package)

| Role | Agent | Responsibility |
|------|-------|---------------|
| **Code Implementer** | You (Buffy) | Makes the actual CSS changes |
| **Code Reviewer** | code-reviewer-deepseek | Reviews before every commit |
| **File Searcher** | code-searcher | Finds affected files before changes |
| **Impact Analyzer** | thinker-with-files-gemini | Thinks through cascade risks before changes |

---

## WORKFLOW: The 5-Step Safe Change Protocol

For EVERY single CSS change, follow this exact sequence. Never skip a step.

### Step 1: SCOPE — Identify exactly what's affected (30 seconds)

Before touching any CSS file, determine the blast radius:

```bash
# Which Hugo templates load this CSS file?
grep -r "YOUR_CSS_FILE" themes/beaver/layouts/

# Which pages will be visually affected?
# List them. ALL of them must be verified after the change.
```

Use the `code-searcher` agent to find all places the CSS selector appears.

**Gate**: You must be able to list exactly which pages are affected before
making any change. If you can't, STOP and investigate further.

### Step 2: BASELINE — Capture before state (1 minute)

```bash
# 1. Take a baseline screenshot of affected pages
bin/rake test:critical TESTOPTS="--name=/AFFECTED_PAGE/"

# 2. IF this is refactoring (moving CSS, not changing values):
#    Delete old baseline so a new one is captured
rm test/fixtures/screenshots/macos/desktop/PAGE_NAME.png
bin/rake test:critical TESTOPTS="--name=/AFFECTED_PAGE/"
```

**Gate**: Baseline screenshots must exist. If `bin/rake test:critical` doesn't
generate them, STOP and fix the test infrastructure.

### Step 3: CHANGE — Make ONE focused edit (2 minutes)

Rules for the change:
- **≤ 10 lines per change** (ideally ≤ 3)
- **One selector or one property group at a time**
- **Never mix refactoring with value changes in the same commit**
- **If extracting to a foundation file**: extract the ENTIRE rule set, not partial

Example of a SAFE change:
```css
/* WP1.1: Extract --font-system-ui variable */
/* BEFORE (in 590-layout.css): */
font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;

/* AFTER: */
font-family: var(--font-system-ui);
```

Example of a DANGEROUS change (DON'T DO THIS):
```css
/* BAD: changing value AND extracting at the same time */
/* This masks which action caused a regression */
padding-top: 100px;  /* → changed to 60px AND moved to foundation file */
```

### Step 4: VALIDATE — Three layers of verification (3 minutes)

**Layer 1: Automated tests (MANDATORY)**
```bash
bin/rake test:critical
```
- Spawn a `basher` agent to run this.
- If ANY test fails → IMMEDIATE ROLLBACK: `git checkout -- .`
- Check for new diff files:
  ```bash
  find test/fixtures/screenshots -name "*.diff.png" -mmin -3
  ```
  If any `.diff.png` or `.heatmap.diff.png` files exist, review them.

**Layer 2: Code review (MANDATORY before every commit)**
```
Spawn: code-reviewer-deepseek
Prompt: "Review this CSS change for cascade risks and FL-node preservation.
         The change affects [LIST OF PAGES].
         I changed [EXACT DESCRIPTION OF CHANGE].
         Full diff: [PASTE THE DIFF]"
```

**Layer 3: Manual browser verification (at key checkpoints)**

At these checkpoints, spawn the `browser-use` agent:

Checkpoints that REQUIRE manual browser verification:
1. After completing any work package
2. After extracting to a foundation file (load order risk)
3. After changing any `@media` query
4. After changing any `.fl-row`, `.fl-col`, or `.fl-module` rule
5. After completing WP1.1, WP2.1, WP2.2, WP2.4 (major gate)

Browser verification task:
```
Spawn: browser-use
Prompt: "Navigate to localhost:1313 and [LIST AFFECTED PAGES]. For each page:
         1. Check desktop viewport (1920x1080) — scroll full page, verify hero,
            services, clients, CTA, footer all render correctly.
         2. Check mobile viewport (375x812) — verify hamburger menu, sections
            stack correctly, no horizontal overflow.
         3. Check one intermediate breakpoint (860px) if the change was in a
            @media (max-width: 860px) block.
         4. Report any visual differences from expected behavior."
```

### Step 5: COMMIT or ROLLBACK (30 seconds)

**If ALL validations pass:**
```bash
git add -p  # Review each hunk
git commit -m "refactor(css): [WP tag] [exact description]"
# Example: "refactor(css): WP1.1 extract --font-system-ui from 590-layout.css"
```

**If ANY validation fails:**
```bash
git checkout -- .  # Full rollback
# OR
git checkout -- path/to/specific/file.css  # Selective rollback
```

Then investigate:
- Spawn `thinker-with-files-gemini` with the changed file and the diff file
- Ask: "Why did this CSS change cause a visual regression? Analyze the cascade."

---

## WORK PACKAGE EXECUTION ORDER

Execute in this exact order. Each WP is gated on the previous one.

### WP1.1: CSS Variables Foundation (4-6 hours)

**Files**: 12 inline critical CSS files
**Goal**: Create design tokens that all other WPs will use

Tasks (one commit per task):
1. Create `themes/beaver/assets/css/_css-variables.css`
2. Extract `--font-system-ui` variable (18 font-family declarations across 12 files)
3. Extract `--color-primary` (brand red #cc342d)
4. Extract `--color-text` (#121212), `--color-text-muted`
5. Extract `--border-radius-default`
6. Extract `--spacing-unit` (8px base)
7. Update each critical CSS file to reference variables (one file per commit)
8. Run full validation after each file

**Gate**: All 12 files use variables. `bin/rake test:critical` passes.
Browser verification confirms homepage, about, services, contact render correctly.

### WP1.2: Reset Utilities Extraction (6-8 hours)

**Files**: 12 inline critical CSS files
**Goal**: Replace 59 `padding: 0` + 70 `margin: 0` inline declarations with utilities

Tasks (one commit per utility class):
1. Create `themes/beaver/assets/css/_reset-utilities.css`
2. Create `.u-p-0`, `.u-pt-0`, `.u-pb-0`, etc.
3. Create `.u-m-0`, `.u-mt-0`, `.u-mb-0`, etc.
4. Replace declarations in critical files (one file per commit)
5. Browser verification at desktop + mobile after each batch

**Gate**: All padding/margin zeros use utility classes. Tests pass.

### WP1.3: PowerPack Infobox Pattern (4-6 hours)

**Files**: services.html (6 duplicate infobox patterns)
**Goal**: Extract shared infobox CSS (padding, border) into component utility

### WP1.4: Media Query Consolidation (6-8 hours)

**Files**: 12 inline critical CSS files (168 @media occurrences)
**Goal**: Group mobile rules into single @media block per file

### WP2.1-WP2.4, WP3.1-WP3.4

See `docs/projects/2509-css-migration/TASK-TRACKER.md` for full task breakdowns.

---

## CASCADE SAFETY RULES

These rules prevent the #1 cause of breakage: specificity inversion.

1. **Extract WHOLE rule sets, never partial properties.**
   If `.fl-row { display: flex; flex-wrap: wrap; }` is shared across files,
   extract ALL of it. Never extract just `display: flex` and leave `flex-wrap`.

2. **Foundation files load at the SAME cascade layer as the originals.**
   If extracting from a Layout-layer file, the foundation file MUST load in the
   Layout layer position. Never move CSS to a different cascade layer.

3. **Page-specific `.fl-node-{hash}` selectors NEVER leave their original file.**
   These are unique per page. Consolidating them breaks page-specific overrides.

4. **Foundation framework (`base-4.min.css`) is UNTOUCHABLE.**
   Never extract from or modify vendor CSS. Never change its load position.

5. **Template-generated CSS (`dynamic-*.css`) is UNTOUCHABLE.**
   These use `resources.ExecuteAsTemplate` and depend on Hugo page context.

6. **Value changes and extraction are SEPARATE commits.**
   If you want to change `padding-top: 100px` → `60px` AND extract it,
   do it in TWO commits: (1) extract, test, commit; (2) change value, test, commit.

---

## ROLLBACK PROTOCOL

At the FIRST sign of trouble, rollback immediately. Do not debug in place.

```bash
# Full rollback to last commit
git checkout HEAD -- .

# Or selective rollback
git checkout HEAD -- themes/beaver/assets/css/SUSPECT_FILE.css

# Verify rollback restored baseline
bin/rake test:critical TESTOPTS="--name=/AFFECTED_PAGE/"

# If still failing, go back further
git log --oneline -5  # Find last known-good commit
git checkout KNOWN_GOOD_COMMIT -- themes/beaver/assets/css/
```

---

## COMMUNICATION PROTOCOL

After EVERY commit, report:

```
✅ WP1.1 commit 3/18: Extracted --font-system-ui from about-us-critical.css
   Tests: 97/97 pass. Screenshots: 0 diff files.
   Pages verified: about-us (desktop + mobile via browser-use)
   Next: homepage-critical.css (same variable)
```

If you hit a problem, report BEFORE attempting a fix:

```
⚠️ WP1.1 commit 4/18 BLOCKED: homepage-critical.css extraction caused
   2.1% difference on desktop/homepage/_services heatmap.
   Diff file: test/fixtures/screenshots/macos/desktop/homepage/_services.heatmap.diff.png
   Rolling back to investigate.
```

---

## KEY REFERENCE FILES

| When you need to... | Read this |
|--------------------|-----------|
| Understand the big picture | `docs/projects/2509-css-migration/CSS-MASTER-PROJECT-INDEX.md` |
| Know what to do next | `docs/projects/2509-css-migration/TASK-TRACKER.md` |
| Understand CSS load order | `docs/projects/2509-css-migration/css-loading-order-analysis.md` |
| See the duplication patterns | `docs/projects/2509-css-migration/10-19-analysis/10.06-fl-builder-duplication-analysis.md` |
| Review testing protocol | `test/system/CSS_PROCESSING_TEST_PROTOCOL.md` |
| Understand cascade constraints | `docs/projects/2509-css-migration/REVISED-CONSOLIDATION-PROCESS.md` |
| Quick consolidation rules | `docs/workflows/css-consolidation.md` |
| Campaign history (what worked) | `docs/CSS_CONSOLIDATION_CAMPAIGN_SUMMARY.md` |
| Sprint backlog reference | `docs/CSS_CONSOLIDATION_QUICK_REFERENCE.md` |

---

## START COMMAND

When you are ready to begin, confirm by:

1. Reporting that you've read CSS-MASTER-PROJECT-INDEX.md
2. Reporting the current test suite state (`bin/rake test:critical` results)
3. Listing the pages that will be affected by WP1.1
4. Proposing the first commit (create `_css-variables.css` with `--font-system-ui`)

Then proceed with the 5-step safe change protocol for WP1.1, continuing
autonomously until the work package is complete or a blocker is found.

---

**Reminder**: Safety > Speed. Every visual regression caught before commit is a
win. Every rollback is a lesson. The 5-step protocol is not optional.
