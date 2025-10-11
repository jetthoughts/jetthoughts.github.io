# 🛡️ PRE-COMMIT SCREENSHOT VALIDATION GUARDRAILS

**Purpose**: ABSOLUTE blocking of screenshot baseline updates during visual test failures

**Authority**: BLOCKING - Prevents test masking violations

## Trigger Conditions

This validation ACTIVATES when:
- ANY commit contains `.png` file modifications in `test/fixtures/screenshots/`
- Context is IRRELEVANT (refactoring, features, bugs, ALL contexts)

## Blocking Protocol

### AUTOMATIC REJECTION when:
1. ✅ `git diff --cached` shows `.png` file changes
2. ✅ Visual tests are failing (ANY failure > 0%)
3. ✅ Commit message contains test masking language:
   - "baseline correction"
   - "fix test baseline"
   - "update screenshot"
   - "correct baseline"
   - "screenshot update"

### AUTOMATIC APPROVAL when:
1. ✅ ZERO `.png` file changes
2. ✅ Only CSS file modifications
3. ✅ Tests pass after CSS changes

## Enforcement Actions

**When screenshot updates detected during test failures**:
```
🛑 COMMIT BLOCKED - TEST MASKING DETECTED

Visual tests are failing. Screenshots CANNOT be updated.

Required Action: Fix CSS bugs causing visual regressions
- Desktop about_page/_values: 3.94% difference
- Desktop careers/_footer: 13.17% difference
- Mobile about_page/achievements: 4.21% difference
- Mobile about_page/values: 14.46% difference

Baseline updates are FORBIDDEN until CSS fixes achieve 0% difference.

This is a ZERO TOLERANCE policy. No exceptions.
```

## Memory Coordination

All blocking events stored in:
- `test_masking/prevention/{timestamp}`
- `screenshot_guardian/blocks/{timestamp}`

## Configuration Overrides

**NONE ALLOWED**. This guardrail CANNOT be bypassed or disabled.

Screenshot Guardian has ABSOLUTE authority during visual test failures.
