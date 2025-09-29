# Refactoring Command: XP Swarm Micro-Refactor Flow

## Purpose
Automate safe, handbook-compliant refactoring with XP swarm, micro-refactoring, and shameless green. Ensures no tech debt, leftovers, or broken changes. Verifies with critical tests and requires agent review.

## Usage (zsh/bash)

```bash
# Run refactoring (replace <refactor-script> with your tool/script)
<refactor-script>
if [[ $? -ne 0 ]]; then
  echo "Refactoring failed. Aborting." >&2
  exit 1
fi

# Run critical tests
bin/rake tests:critical
if [[ $? -ne 0 ]]; then
  echo "Critical tests failed. Aborting." >&2
  exit 1
fi

# Trigger agent review (replace <review-command> with your review process)
<review-command>
if [[ $? -ne 0 ]]; then
  echo "Agent review failed. Aborting." >&2
  exit 1
fi

echo "Refactoring complete: No tech debt, no leftovers, all tests green, agent review passed."
```

## Handbook Compliance
- Micro-refactoring: ≤3 lines per step, run tests after each.
- Shameless green: Minimal code to pass tests, refactor immediately.
- XP Swarm: Involve whole team for review and knowledge sharing.
- Fail-fast: Abort on any error, no silent failures.
- No leftovers: Validate with tests and review, ensure clean state.

## Notes
- Replace <refactor-script> and <review-command> with your actual commands.
- Always run in a clean working directory.
- See handbook (docs/knowledge) for detailed process and standards.

