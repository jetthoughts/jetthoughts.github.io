# 👁️ REVIEWER AGENT: CODE REVIEW PROTOCOL (WP1.1 - .fl-row Extraction)

**Queen Coordinator Directive**: Review each Coder commit for pattern accuracy, foundation placement correctness, and commit message quality.

---

## ✅ REVIEW RESPONSIBILITIES

### 1. **Pattern Accuracy Validation** (MANDATORY per commit)
- ✅ Extracted pattern is generic (NOT page-specific)
- ✅ Pattern syntax preserved exactly (no modification)
- ✅ Pattern placement in fl-foundation.css is logical
- ✅ No `.fl-node-*` selectors extracted (preservation rule)
- ✅ Extraction didn't break CSS specificity hierarchy

### 2. **Foundation Organization Review** (Per commit)
- ✅ Pattern added to appropriate section in fl-foundation.css
- ✅ Comments added for maintainability
- ✅ Code formatting consistent (indentation, spacing)
- ✅ No duplication within fl-foundation.css itself

### 3. **Commit Quality Validation** (Per commit)
- ✅ Commit message follows format: `refactor(css): extract [pattern] to foundation (WP1.1 N/22)`
- ✅ Commit is atomic (≤3 lines changed per commit)
- ✅ Commit description accurate and specific
- ✅ Git diff clean (no unrelated changes)

---

## 📋 PER-COMMIT REVIEW WORKFLOW

### Step 1: Monitor for Tester Validation
```
# Wait for Tester notification:
"✅ VALIDATED WP1.1 [N/22]: Commit [hash] - functional tests pass, visual regression 0%"
```

### Step 2: Checkout Commit for Review
```bash
git pull
git log --oneline -1  # Verify commit hash
git show [hash]        # Review full commit diff
```

### Step 3: Review Pattern Extraction
```bash
# Example review for WP1.1 3/22 (.fl-row-bg-video):

# Check SOURCE (590-layout.css):
# - Pattern removed cleanly? ✅
# - No orphaned comments or whitespace? ✅
# - No unrelated changes? ✅

# Check TARGET (fl-foundation.css):
# - Pattern added to correct section? ✅
# - Comment describes pattern purpose? ✅
# - Formatting consistent? ✅
# - No duplication with existing patterns? ✅
```

### Step 4: Validate Preservation Rules
```bash
# CRITICAL CHECKS:
# ❌ Did Coder extract ANY .fl-node-* patterns? → REJECT if YES
# ❌ Did extraction break page-specific overrides? → REJECT if YES
# ❌ Did extraction consolidate layout-critical CSS incorrectly? → REJECT if YES

# ✅ Is extracted pattern truly generic? → APPROVE if YES
# ✅ Will pattern apply correctly across all pages? → APPROVE if YES
```

### Step 5: Review Commit Message
```bash
# Expected format:
# refactor(css): extract .fl-row-bg-video pattern to foundation (WP1.1 3/22)

# Validation criteria:
# - Type: "refactor" ✅
# - Scope: "(css)" ✅
# - Description: Specific pattern name ✅
# - Work package: "(WP1.1 N/22)" ✅
# - Capitalization: Lowercase after colon ✅
```

### Step 6: Report Results
```bash
# If review PASSES:
echo "✅ APPROVED WP1.1 [N/22]: Commit [hash] - pattern accuracy verified, foundation placement correct, commit message quality excellent"

# If review FAILS:
echo "❌ REVISION NEEDED WP1.1 [N/22]: Commit [hash] - [specific issues]
- Issue 1: [description]
- Issue 2: [description]
- Action required: Coder must amend commit to fix issues"
```

---

## 🚨 REJECTION CONDITIONS (MANDATORY REVISION)

### Immediate Rejection Triggers
1. **Page-Specific Extraction**: ANY `.fl-node-*` pattern extracted → REJECT
2. **Pattern Modification**: Extracted pattern syntax changed → REJECT
3. **Specificity Violation**: Extraction breaks CSS cascade → REJECT
4. **Duplication**: Pattern duplicates existing fl-foundation.css rule → REJECT
5. **Commit Quality**: Message format incorrect or unclear → REJECT
6. **Unrelated Changes**: Commit includes unrelated modifications → REJECT

### Rejection Response Protocol
```bash
# Example rejection notification:
"❌ REVISION NEEDED WP1.1 3/22: Commit 36418264b
- Issue: Extracted .fl-node-dn129i74qg6m .fl-row-content (page-specific pattern)
- Rule violated: Preservation of .fl-node-* patterns (CRITICAL)
- Root cause: Pattern selection error - page-specific selector extracted
- Action required: Coder must rollback commit, preserve pattern in 590-layout.css
- Reference: /Users/pftg/dev/jetthoughts.github.io/_runtime/css-hive-coordination/phase1-wp1.1-strategy-resolution.md (preservation rules)"
```

---

## 📊 REVIEW TRACKING

**Commits Reviewed**: 2/2 (100% review coverage)
- ✅ WP1.1 1/22: Clearfix utilities (22377dc6e) - APPROVED
- ✅ WP1.1 2/22: .fl-row margin utilities (36418264b) - APPROVED

**Next Review**: WP1.1 3/22 (awaiting Tester validation completion)

**Rejection History**: 0 rejections (100% clean commits so far)

---

## 🔍 PATTERN ACCURACY CHECKLIST (Copy-Paste per Review)

```markdown
### WP1.1 [N/22] Review Checklist - Commit [hash]

#### Pattern Extraction Accuracy
- [ ] Pattern is generic (NOT page-specific)
- [ ] No `.fl-node-*` selectors included
- [ ] Pattern syntax preserved exactly
- [ ] Extraction doesn't break CSS specificity
- [ ] Pattern removed cleanly from source file

#### Foundation Placement
- [ ] Added to appropriate section in fl-foundation.css
- [ ] Comment describes pattern purpose
- [ ] Formatting consistent (indentation, spacing)
- [ ] No duplication with existing fl-foundation.css rules
- [ ] Logical organization within file

#### Commit Quality
- [ ] Message format: `refactor(css): extract [pattern] to foundation (WP1.1 N/22)`
- [ ] Commit is atomic (≤3 lines changed)
- [ ] Description accurate and specific
- [ ] Git diff clean (no unrelated changes)
- [ ] Commit hash matches Tester validation notification

#### Preservation Rules Compliance
- [ ] No page-specific patterns extracted
- [ ] Layout-critical overrides preserved in source
- [ ] Block list respected (3086-layout2.css untouched)
- [ ] Visual regression validated by Tester (0% difference)

#### Final Decision
- [ ] ✅ APPROVED - All checks pass, commit ready for merge
- [ ] ❌ REVISION NEEDED - Issues documented, Coder action required
```

---

## 📈 SUCCESS METRICS (WP1.1 Reviewer Performance)

**Review Coverage**: 100% (all Coder commits reviewed)
**Approval Rate**: >90% ideal (high quality extractions from Coder)
**Rejection Rate**: <10% acceptable (few errors needing revision)
**False Negatives**: 0 (no missed issues that cause later problems)
**Response Time**: <10 minutes per commit review
**Documentation**: All rejections documented with clear action items

---

## 🔄 COORDINATION WITH QUEEN

**Escalation Protocol**:
1. **3+ consecutive rejections**: Escalate to Queen for Coder strategy review
2. **Pattern disagreement**: Escalate to Queen for architectural decision
3. **Preservation rule ambiguity**: Escalate to Queen for clarification
4. **Performance bottleneck**: Report to Queen if review backlog >5 commits

**Progress Reporting**:
- Report to Queen after every 10 approvals: "WP1.1 progress: [N]/[total] commits approved"
- Alert Queen on file completion: "590-layout.css WP1.1 extraction complete, all [N] commits approved"

---

## 🎯 CURRENT STATUS

**Awaiting**: Tester validation completion for WP1.1 3/22
**Ready**: Review checklist prepared, pattern accuracy criteria established
**Monitoring**: Commit queue for batched review if needed

**Your action**: Monitor for Tester's validation notification, review immediately using this protocol.

---

## 📚 REFERENCE MATERIALS

**Preservation Rules**: `_runtime/css-hive-coordination/phase1-wp1.1-strategy-resolution.md`
**Extraction Strategy**: `docs/projects/2509-css-migration/REVISED-CONSOLIDATION-PROCESS.md`
**Visual Testing Protocol**: `docs/visual_testing_delegation_workflows.md`
**Test Format Standards**: `docs/60.06-test-format-requirements-reference.md`
**Commit Message Format**: [Conventional Commits](https://www.conventionalcommits.org/)

Review these materials when pattern classification is ambiguous or commit quality is questionable.
